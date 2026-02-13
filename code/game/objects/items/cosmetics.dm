/obj/item/facepaint
	gender = PLURAL
	name = "facepaint"
	desc = "涂脸用的颜料。需要时可以用纸擦掉。这个是深森林绿色。"
	icon = 'icons/obj/items/paint.dmi'
	icon_state = "camo"
	var/paint_type = "green"
	w_class = SIZE_TINY
	var/uses = 10
	/// for lipstick
	var/open = TRUE
	/// Last world.time someone attempted to apply the makeup, for anti-spam.
	var/last_apply_time
	/// How long the anti-spam cooldown on applying the makeup is.
	var/apply_delay_length = 5 SECONDS
	/// the cooldown for applying makeup.
	COOLDOWN_DECLARE(apply_delay)

//FACEPAINT
/obj/item/facepaint/green
	name = "绿色油彩"
	desc = "涂脸用的颜料。这款绿色油彩非常适合在脸上画出威慑性的条纹。需要时可以用纸擦掉。"
	paint_type = "green_camo"
	icon_state = "green_camo"

/obj/item/facepaint/brown
	name = "棕色油彩"
	desc = "涂脸用的颜料。这款棕色油彩非常适合在脸上画出威慑性的条纹。需要时可以用纸擦掉。"
	paint_type = "brown_camo"
	icon_state = "brown_camo"

/obj/item/facepaint/black
	name = "黑色面部油彩"
	desc = "用于面部的油彩。这款黑色面部油彩非常适合用作你自己的眼部涂黑。如果需要，可以用纸擦掉。"
	paint_type = "black_camo"
	icon_state = "black_camo"

/obj/item/facepaint/sniper
	name = "全身伪装油彩"
	desc = "用于面部的油彩。这种油彩旨在帮助你融入植被环境，但相关研究充其量尚无定论。如果需要，可以用纸擦掉。"
	paint_type = "full_camo"
	icon_state = "full_camo"

/obj/item/facepaint/sniper/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	if(flags_atom & MAP_COLOR_INDEX)
		return
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			paint_type = "full_camo_jungle"
			icon_state = "full_camo_jungle"
		if("classic")
			paint_type = "full_camo"
			icon_state = "full_camo"
		if("desert")
			paint_type = "full_camo_desert"
			icon_state = "full_camo_desert"
		if("snow")
			paint_type = "full_camo_snow"
			icon_state = "full_camo_snow"
		if("urban")
			paint_type = "full_camo_urban"
			icon_state = "full_camo_urban"

/obj/item/facepaint/sniper/Initialize()
	. = ..()
	select_gamemode_skin(type)

/obj/item/facepaint/sniper/snow
	name = "雪地全身伪装油彩"
	paint_type = "full_camo_snow"
	icon_state = "full_camo_snow"

/obj/item/facepaint/sniper/desert
	name = "沙漠全身伪装油彩"
	paint_type = "full_camo_desert"
	icon_state = "full_camo_desert"

/obj/item/facepaint/sniper/jungle
	name = "丛林全身伪装油彩"
	paint_type = "full_camo_jungle"
	icon_state = "full_camo_jungle"

/obj/item/facepaint/sniper/urban
	name = "城市全身伪装油彩"
	paint_type = "full_camo_urban"
	icon_state = "full_camo_urban"

/obj/item/facepaint/skull
	name = "骷髅面部油彩"
	desc = "用于面部的油彩。让你脸上的骷髅图案给敌人带来纯粹的恐惧，让他们需要换条裤子。警告：与胡须搭配效果不佳。"
	paint_type = "skull_camo"
	icon_state = "skull_camo"

/obj/item/facepaint/clown
	name = "小丑彩妆油彩"
	desc = "用于面部的油彩。供演艺人员等使用，或者也许你只是有这种感觉。"
	paint_type = "clown_camo"
	icon_state = "clown_camo"

/obj/item/facepaint/clown/alt

	paint_type = "clown_camo_alt"
	icon_state = "clown_camo_alt"

/obj/item/facepaint/sunscreen_stick
	name= "\improper USCM issue sunscreen"
	desc = "一支SPF 50防晒霜，由陆战队的好长官配发给你。之前配发的防晒霜在摄入时有毒，而这一批有所改进，仅含有过量的镉。"
	paint_type = "sunscreen_stick"
	icon_state = "sunscreen_stick"

/obj/item/facepaint/attack(mob/target, mob/user)
	if(user.a_intent == INTENT_HARM)
		return ..()

	if(!ismob(target))
		return FALSE

	if(!COOLDOWN_FINISHED(src, apply_delay)) // Stops players from spamming each other with popups.
		to_chat(user, SPAN_WARNING("你刚刚试图化妆，慢一点！"))
		return FALSE

	COOLDOWN_START(src, apply_delay, apply_delay_length)

	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/mob/living/carbon/human/human_user = user
		human_user.animation_attack_on(human_target)
		if(!open)
			to_chat(user, SPAN_WARNING("盖子盖上了！"))
			return FALSE

		if(human_target.lip_style) //if they already have lipstick on
			to_chat(user, SPAN_WARNING("你需要先用纸把旧的化妆品擦掉！"))
			return

		if(human_target == user)
			paint_face(human_target, user)
			return TRUE

		else
			to_chat(user, SPAN_NOTICE("你试图将[src]涂在[human_target]脸上..."))
			to_chat(human_target, SPAN_NOTICE("[user]正试图将[src]涂在你脸上..."))
			if(alert(human_target,"你是否允许[user]给你化妆？",,"Sure","No") == "Sure")
				if( user && loc == user && (user in range(1,human_target)) ) //Have to be close and hold the thing.
					paint_face(human_target, user)
					return TRUE

	to_chat(user, SPAN_WARNING("被阻止了！"))


/obj/item/facepaint/proc/paint_face(mob/living/carbon/human/H, mob/user)
	if(!H || !user)
		return //In case they're passed as null.
	user.visible_message(SPAN_NOTICE("[user]小心翼翼地将[src]涂在[H]脸上。"),
						SPAN_NOTICE("You apply [src]."))
	H.lip_style = paint_type
	H.update_body()
	uses--
	if(!uses)
		user.temp_drop_inv_item(src)
		user.update_inv_l_hand(0)
		user.update_inv_r_hand()
		qdel(src)

//you can wipe off lipstick with paper! see code/modules/paperwork/paper.dm, paper/attack()

//LIPSTICK
/obj/item/facepaint/lipstick
	name = "红色唇膏"
	desc = "唇膏。一支用于嘴唇的棒状物。"
	paint_type = "red_lipstick"
	icon_state = "lipstick"
	item_state = "lipstick"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/paint_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/paint_righthand.dmi'
	)
	var/icon_state_open = "lipstick_red"
	var/icon_state_closed = "lipstick"
	open = FALSE

/obj/item/facepaint/lipstick/attack_self(mob/user)
	. = ..()
	if(open)
		open = FALSE
		to_chat(user, SPAN_NOTICE("你把唇膏的盖子盖了回去。"))
		icon_state = icon_state_closed
	else
		open = TRUE
		to_chat(user, SPAN_NOTICE("你把盖子取了下来。"))
		icon_state = icon_state_open
		playsound(src, "pillbottle", 25, TRUE)

/obj/item/facepaint/lipstick/purple
	name = "紫色唇膏"
	paint_type = "purp_lipstick"
	icon_state_open = "lipstick_purple"

/obj/item/facepaint/lipstick/maroon
	name = "褐红色唇膏"
	paint_type = "marn_lipstick"
	icon_state_open = "lipstick_maroon"

/obj/item/facepaint/lipstick/jade
	name = "翡翠色唇膏"
	desc = "唇膏。一根涂在你嘴唇上的棒子。这支不知为何看起来很锋利。为什么涂在嘴上的东西会是锋利的？？"
	paint_type = "jade_lipstick"
	icon_state_open = "lipstick_jade"

/obj/item/facepaint/lipstick/jade/attack_self(mob/user) //this is a reference :)
	. = ..()
	if(open)
		sharp = IS_SHARP_ITEM_ACCURATE
		edge = TRUE
		force = MELEE_FORCE_NORMAL
	else
		sharp = FALSE
		edge = FALSE
		force = 0

/obj/item/k9_name_changer
	name = "K9命名植入器"
	desc = "将植入的维兰德-汤谷序列芯片同步到该单位的首选名称。"
	icon = 'icons/obj/items/economy.dmi'
	icon_state = "efundcard"
	w_class = SIZE_TINY

/obj/item/k9_name_changer/attack_self(mob/user)
	. = ..()
	var/newname = capitalize(tgui_input_text(user, "你希望被命名为什么", "名称：", encode = FALSE))
	if(!newname)
		return

	var/verify = tgui_input_list(user, "你确定希望被命名为：[newname]吗？", "确认", list("Yes", "No"))
	if(verify != "Yes")
		return

	user.change_real_name(user, newname)
	if(istype(user, /mob/living/carbon/human))
		var/mob/living/carbon/human/altered_human = user
		var/obj/item/card/id/ID = altered_human.get_idcard()
		if(ID)
			ID.name = "[altered_human.real_name]'s [ID.id_type]"
			ID.registered_name = "[altered_human.real_name]"
			if(ID.assignment)
				ID.name += " ([ID.assignment])"

	var/genderswap = tgui_input_list(user, "选择性别？", "Gender", list("Male", "Female"))
	if(!genderswap)
		return
	user.gender = lowertext(genderswap)
	qdel(src)
