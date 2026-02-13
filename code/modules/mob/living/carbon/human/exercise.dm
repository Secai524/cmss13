/*
Verbs related to getting fucking jacked, bro
*/

/mob/living/carbon/human/verb/pushup()
	set name = "Do Pushup"
	set desc = "Makes you do a pushup."
	set category = "IC"

	do_pushups()

/mob/living/carbon/human/proc/do_pushups()
	if(!can_do_pushup())
		return

	set_face_dir(WEST)
	visible_message(SPAN_NOTICE("[src]俯身准备做几个俯卧撑。"), SPAN_NOTICE("You get down for some pushups."), SPAN_NOTICE("You hear rustling."))

	var/choice = tgui_alert(src, "标准俯卧撑还是跪姿俯卧撑？", "What kinda pushups, mate.", list("Proper ones", "On my knees"), 60 SECONDS)
	if(choice == "Proper ones")
		visible_message(SPAN_NOTICE("[src] shifts \his weight onto \his hands and feet."), SPAN_NOTICE("You move your weight onto your hands and feet."), SPAN_NOTICE("You hear rustling."))
		execute_pushups(on_knees = FALSE)
	if(choice == "On my knees")
		visible_message(SPAN_NOTICE("[src] shifts \his weight onto \his knees. What a wimp."), SPAN_NOTICE("You move your weight onto your knees. WEAK!"), SPAN_NOTICE("You hear rustling."))
		execute_pushups(on_knees = TRUE)
	else
		return


/mob/living/carbon/human/proc/execute_pushups(on_knees = FALSE)
	if(!can_do_pushup())
		return
	var/target_y = -5
	var/pushups_in_a_row
	var/staminaloss
	var/matrix/matrix = matrix() //all this to make their face actually face the floor... sigh... I hate resting code
	apply_transform(matrix)
	if(dir == WEST)
		matrix.Turn(270)
	else if(dir == EAST)
		matrix.Turn(90)
	else
		if(prob(50))
			dir = EAST
			matrix.Turn(90)
		else
			dir = WEST
			matrix.Turn(270)
	apply_transform(matrix)

	while(stamina.current_stamina > 10)
		if(!can_do_pushup())
			return
		staminaloss = calculate_stamina_loss_per_pushup(on_knees)
		animate(src, pixel_y = target_y, time = 0.8 SECONDS, easing = QUAD_EASING) //down to the floor
		if(!do_after(src, 0.6 SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC))
			visible_message(SPAN_NOTICE("[src]停止了俯卧撑。"), SPAN_NOTICE("You stop doing pushups."), SPAN_NOTICE("You hear movements."))
			animate(src, pixel_y = 0, time = 0.2 SECONDS, easing = QUAD_EASING)
			return
		animate(src, pixel_y = 0, time = 0.8 SECONDS, easing = QUAD_EASING) //back up
		if(!do_after(src, 0.6 SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC))
			visible_message(SPAN_NOTICE("[src]停止了俯卧撑。"), SPAN_NOTICE("You stop doing pushups."), SPAN_NOTICE("You hear movements."))
			animate(src, pixel_y = 0, time = 0.2 SECONDS, easing = QUAD_EASING)
			return
		pushups_in_a_row++
		visible_message(SPAN_BOLDNOTICE("[src]做了一个俯卧撑 - 目前已完成[pushups_in_a_row]个！"), SPAN_BOLDNOTICE("You do a pushup - [pushups_in_a_row] done so far!"), SPAN_NOTICE("You hear rustling."))
		stamina.apply_damage(staminaloss)
		if(stamina.current_stamina < 10)
			to_chat(src, SPAN_WARNING("你瘫倒在地板上，累得无法继续。"))
			return

/mob/living/carbon/human/proc/can_do_pushup()
	if(is_mob_incapacitated())
		return FALSE

	if(!resting || buckled)
		to_chat(src, SPAN_WARNING("你以为站着能做俯卧撑吗？趴到地上去！"))
		return FALSE

	var/list/extremities = list("l_hand", "r_hand", "l_foot", "r_foot", "l_arm", "r_arm", "l_leg", "r_leg")

	for(var/zone in extremities)
		if(!get_limb(zone))
			extremities.Remove(zone)

	if(length(extremities) < 8)
		to_chat(src, SPAN_WARNING("你以为没有双手双脚支撑能做俯卧撑吗？去看医生！"))
		return FALSE

	if(stamina.current_stamina < (stamina.max_stamina / 10))
		to_chat(src, SPAN_WARNING("你感觉太虚弱了，做不了俯卧撑！"))
		return FALSE

	if(!isturf(loc))
		to_chat(src, SPAN_WARNING("你不能在这里这么做！"))
		return FALSE

	return TRUE


/mob/living/carbon/human/proc/calculate_stamina_loss_per_pushup(on_knees = FALSE)
	//humans have 100 stamina
	//default loss per pushup = 5 stamina
	var/stamina_loss = 5
	if(!skills || issynth(src))
		return 0
	switch(skills.get_skill_level(SKILL_ENDURANCE))
		if(SKILL_ENDURANCE_NONE)
			stamina_loss += 5
		if(SKILL_ENDURANCE_TRAINED)
			stamina_loss -= 1
		if(SKILL_ENDURANCE_MASTER)
			stamina_loss -= 2
		if(SKILL_ENDURANCE_EXPERT)
			stamina_loss -= 3
	if(wear_suit)
		stamina_loss += 0.5
	if(back)
		stamina_loss += 0.5
	if(pain.get_pain_percentage() >= 20)
		stamina_loss += 3
	if(nutrition <= NUTRITION_LOW)
		stamina_loss += 2
	if(on_knees)
		stamina_loss -= 2
	if(health <= ((maxHealth / 10) * 9))
		stamina_loss += 2
	if(stamina_loss <= 0)
		stamina_loss = 1
	if(isyautja(src))
		stamina_loss = stamina_loss/2
	return stamina_loss
