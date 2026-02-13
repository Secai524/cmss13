//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/obj/item/device/mmi
	name = "人机接口"
	desc = "战士公司平淡的缩写‘MMI’，掩盖了这怪物的真正恐怖。"
	icon = 'icons/obj/items/assemblies.dmi'
	icon_state = "mmi_empty"
	w_class = SIZE_MEDIUM


	//these vars are so the mecha fabricator doesn't shit itself anymore. --NEO

	req_access = list(ACCESS_MARINE_RESEARCH)

	//Revised. Brainmob is now contained directly within object of transfer. MMI in this case.

	var/locked = 0
	var/mob/living/brain/brainmob = null//The current occupant.
	var/obj/mecha = null//This does not appear to be used outside of reference in mecha.dm.

/obj/item/device/mmi/attackby(obj/item/O, mob/user)
	if(istype(O,/obj/item/organ/brain) && !brainmob) //Time to stick a brain in it --NEO

		var/obj/item/organ/brain/B = O
		if(B.health <= 0)
			to_chat(user, SPAN_DANGER("那个大脑已经彻底死亡了。"))
			return
		else if(!B.brainmob)
			to_chat(user, SPAN_DANGER("你不确定这个大脑从何而来，但你很确定它是个无用的大脑。"))
			return

		for(var/mob/V in viewers(src, null))
			V.show_message(text(SPAN_NOTICE("[user] sticks \a [O] into \the [src].")), SHOW_MESSAGE_VISIBLE)

		brainmob = O:brainmob
		O:brainmob = null
		brainmob.forceMove(src)
		brainmob.container = src
		brainmob.set_stat(CONSCIOUS)
		GLOB.dead_mob_list -= brainmob//Update dem lists
		GLOB.alive_mob_list += brainmob

		user.drop_held_item()
		qdel(O)

		name = "人机接口：[brainmob.real_name]"
		icon_state = "mmi_full"

		locked = 1

		return

	if((istype(O,/obj/item/card/id)) && brainmob)
		if(allowed(user))
			locked = !locked
			to_chat(user, SPAN_NOTICE("你[locked ? "lock" : "unlock"] the brain holder."))
		else
			to_chat(user, SPAN_DANGER("权限被拒绝。"))
		return
	if(brainmob)
		O.attack(brainmob, user)//Oh noooeeeee
		return
	..()

/obj/item/device/mmi/attack_self(mob/user)
	..()

	if(!brainmob)
		to_chat(user, SPAN_DANGER("你倒空了人机接口，但里面空无一物。"))
	else if(locked)
		to_chat(user, SPAN_DANGER("你试图倒空人机接口，但大脑被牢牢固定住了。"))
	else
		to_chat(user, SPAN_NOTICE("你倒空了人机接口，将大脑倾倒在地板上。"))
		var/obj/item/organ/brain/brain = new(user.loc)
		brainmob.container = null//Reset brainmob mmi var.
		brainmob.forceMove(brain)//Throw mob into brain.
		GLOB.alive_mob_list -= brainmob//Get outta here
		brain.brainmob = brainmob//Set the brain to use the brainmob
		brainmob = null//Set mmi brainmob var to null

		icon_state = "mmi_empty"
		name = "人机接口"

/obj/item/device/mmi/proc/transfer_identity(mob/living/carbon/human/H)//Same deal as the regular brain proc. Used for human-->robot people.
	brainmob = new(src)
	brainmob.name = H.real_name
	brainmob.real_name = H.real_name
	brainmob.blood_type = H.blood_type
	brainmob.container = src

	name = "人机接口：[brainmob.real_name]"
	icon_state = "mmi_full"
	locked = 1
	return

/obj/item/device/mmi/radio_enabled
	name = "无线电人机接口"
	desc = "战士公司平淡的缩写‘MMI’，掩盖了这怪物的真正恐怖。这个型号内置了无线电。"


	var/obj/item/device/radio/radio = null//Let's give it a radio.

/obj/item/device/mmi/radio_enabled/New()
	..()
	radio = new(src)//Spawns a radio inside the MMI.
	radio.broadcasting = 1//So it's broadcasting from the start.

/// Allows the brain to toggle the radio functions.
/obj/item/device/mmi/radio_enabled/verb/Toggle_Broadcasting()
	set name = "Toggle Broadcasting"
	set desc = "Toggle broadcasting channel on or off."
	set category = "MMI"
	set src = usr.loc//In user location, or in MMI in this case.
	set popup_menu = 0//Will not appear when right clicking.

	if(brainmob.stat)//Only the brainmob will trigger these so no further check is necessary.
		to_chat(brainmob, "在丧失行动能力或死亡时无法执行此操作。")

	radio.broadcasting = radio.broadcasting==1 ? 0 : 1
	to_chat(brainmob, SPAN_NOTICE("无线电[radio.broadcasting==1 ? "now" : "no longer"] broadcasting."))

/obj/item/device/mmi/radio_enabled/verb/Toggle_Listening()
	set name = "Toggle Listening"
	set desc = "Toggle listening channel on or off."
	set category = "MMI"
	set src = usr.loc
	set popup_menu = 0

	if(brainmob.stat)
		to_chat(brainmob, "在丧失行动能力或死亡时无法执行此操作。")

	radio.listening = radio.listening==1 ? 0 : 1
	to_chat(brainmob, SPAN_NOTICE("Radio is [radio.listening==1 ? "now" : "no longer"] receiving broadcast."))

/obj/item/device/mmi/emp_act(severity)
	. = ..()
	if(!brainmob)
		return
	else
		switch(severity)
			if(1)
				brainmob.emp_damage += rand(20,30)
			if(2)
				brainmob.emp_damage += rand(10,20)
			if(3)
				brainmob.emp_damage += rand(0,10)
