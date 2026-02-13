/*
 * Morgue
 */
/obj/structure/morgue
	name = "morgue"
	desc = "用于存放尸体，直到有人来取走。"
	icon = 'icons/obj/structures/morgue.dmi'
	icon_state = "morgue1"
	dir = EAST
	density = TRUE
	var/obj/structure/morgue_tray/connected = null
	var/morgue_type = "morgue"
	var/tray_path = /obj/structure/morgue_tray
	var/morgue_open = 0
	var/exit_stun = 2
	var/update_name = TRUE
	anchored = TRUE
	throwpass = 1

/obj/structure/morgue/Initialize()
	. = ..()
	connected = new tray_path(src)

/obj/structure/morgue/Destroy()
	for(var/atom/movable/object in contents)
		object.forceMove(loc)
	. = ..()
	QDEL_NULL(connected)

/obj/structure/morgue/update_icon()
	if(morgue_open)
		icon_state = "[morgue_type]0"
	else
		if(length(contents) > 1) //not counting the morgue tray
			icon_state = "[morgue_type]2"
		else
			icon_state = "[morgue_type]1"

/obj/structure/morgue/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				return
		if(0 to EXPLOSION_THRESHOLD_LOW)
			if(prob(95))
				return
	contents_explosion(severity)
	deconstruct(FALSE)

/obj/structure/morgue/attack_hand(mob/user)
	toggle_morgue(user)

/obj/structure/morgue/proc/toggle_morgue(mob/user)
	add_fingerprint(user)
	if(!connected)
		return
	if(morgue_open)
		for(var/atom/movable/A in connected.loc)
			if(!A.anchored)
				A.forceMove(src)
		connected.forceMove(src)
		if(update_name)
			name = initial(name)
			var/mob/living/L = locate(/mob/living) in contents
			if(L)
				name = "[name] ([L])"
			else
				var/obj/structure/closet/bodybag/B = locate(/obj/structure/closet/bodybag) in contents
				if(B)
					L = locate(/mob/living) in B.contents
					if(L)
						name = "[name] ([L])"

	else
		name = initial(name)
		connected.forceMove(loc)
		if(step(connected, dir))
			connected.setDir(dir)
			for(var/atom/movable/A in src)
				A.forceMove(connected.loc)
		else
			connected.forceMove(src)
			return
	morgue_open = !morgue_open
	playsound(loc, 'sound/items/Deconstruct.ogg', 25, 1)
	update_icon()


/obj/structure/morgue/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/weapon/zombie_claws))
		attack_hand()
		return
	else if(HAS_TRAIT(W, TRAIT_TOOL_PEN))
		var/prior_label_text
		var/datum/component/label/labelcomponent = GetComponent(/datum/component/label)
		if(labelcomponent && labelcomponent.has_label())
			prior_label_text = labelcomponent.label_name
		var/tmp_label = tgui_input_text(user, "为[src]输入标签（或留空以移除）", "Label", prior_label_text, MAX_NAME_LEN, ui_state=GLOB.not_incapacitated_state)
		if(isnull(tmp_label))
			return // Canceled
		if(!tmp_label)
			if(prior_label_text)
				log_admin("[key_name(usr)] has removed label from [src].")
				user.visible_message(SPAN_NOTICE("[user]移除了[src]上的标签。"),
									SPAN_NOTICE("You remove the label from [src]."))
				labelcomponent.clear_label()
			return
		if(length(tmp_label) > MAX_NAME_LEN)
			to_chat(user, SPAN_WARNING("标签长度最多为[MAX_NAME_LEN]个字符。"))
			return
		if(prior_label_text == tmp_label)
			to_chat(user, SPAN_WARNING("标签上已经写着\"[tmp_label]\"."))
			return
		user.visible_message(SPAN_NOTICE("[user]将[src]标记为\"[tmp_label]\"."),
		SPAN_NOTICE("You label [src] as \"[tmp_label]\"."))
		AddComponent(/datum/component/label, tmp_label)
		playsound(src, "paper_writing", 15, TRUE)
		return

	return ..()

/obj/structure/morgue/relaymove(mob/living/user)
	if(user.is_mob_incapacitated())
		return
	if(exit_stun)
		user.apply_effect(exit_stun, STUN)
		if(user.mobility_flags & MOBILITY_MOVE)
			user.visible_message(SPAN_WARNING("[user]突然从[src]里出来了！"),
			SPAN_WARNING("You get out of [src] and get your bearings!"))
		toggle_morgue(user)


/*
 * Morgue tray
 */

/obj/structure/morgue_tray
	name = "停尸盘"
	desc = "放入尸体后再关闭。"
	icon = 'icons/obj/structures/morgue.dmi'
	icon_state = "morguet"
	var/icon_tray = ""
	density = TRUE
	layer = OBJ_LAYER
	var/obj/structure/morgue/linked_morgue = null
	anchored = TRUE
	throwpass = 1
	var/bloody = FALSE

/obj/structure/morgue_tray/New(loc, obj/structure/morgue/morgue_source)
	icon_tray = initial(icon_state)
	if(morgue_source)
		linked_morgue = morgue_source
	..()

/obj/structure/morgue_tray/Destroy()
	. = ..()
	linked_morgue = null

/obj/structure/morgue_tray/MouseDrop_T(atom/movable/O, mob/user)
	if(!istype(O) || O.anchored || !isturf(O.loc))
		return
	if(!ismob(O) && !istype(O, /obj/structure/closet/bodybag))
		return
	if(!istype(user) || user.is_mob_incapacitated() || !isturf(user.loc))
		return
	O.forceMove(loc)
	if(user != O)
		for(var/mob/B in viewers(user, 3))
			B.show_message(SPAN_DANGER("[user]把[O]塞进了[src]！"), SHOW_MESSAGE_VISIBLE)
			if(B.stat==DEAD)
				bloody = TRUE
				update_icon()

/obj/structure/morgue_tray/update_icon()
	if(bloody)
		icon_state = icon_tray + "_b"
	else
		icon_state = icon_tray

/obj/structure/morgue_tray/clean_blood()
	bloody = FALSE
	update_icon()
	. = ..()


/*
 * Crematorium
 */

/obj/structure/morgue/crematorium
	name = "crematorium"
	desc = "一台人体焚烧炉。在烧烤之夜特别好用。"
	icon_state = "crema1"
	dir = SOUTH
	tray_path = /obj/structure/morgue_tray/crematorium
	morgue_type = "crema"
	var/cremating = 0
	var/id = 1


/obj/structure/morgue/crematorium/toggle_morgue(mob/user)
	if(cremating)
		to_chat(user, SPAN_WARNING("它锁上了。"))
		return
	..()


/obj/structure/morgue/crematorium/relaymove(mob/user)
	if(cremating)
		return
	..()


/obj/structure/morgue/crematorium/update_icon()
	if(cremating)
		icon_state = "[morgue_type]_active"
	else
		..()


/obj/structure/morgue/crematorium/proc/cremate(mob/user)
	set waitfor = 0
	if(cremating)
		return

	if(length(contents) <= 1) //1 because the tray is inside.
		visible_message(SPAN_DANGER("你听到一阵空洞的噼啪声。"))
	else
		visible_message(SPAN_DANGER("你听到焚化炉启动时发出的轰鸣声。"))

		cremating = 1

		update_icon()

		for(var/mob/living/M in contents)
			if(M.stat!=DEAD)
				if(!ishuman(M))
					M.emote("scream")
				else
					var/mob/living/carbon/human/H = M
					if(H.pain.feels_pain)
						H.emote("scream")

			user.attack_log +="\[[time_stamp()]\] Cremated <b>[key_name(M)]</b>"
			msg_admin_attack("\[[time_stamp()]\] <b>[key_name(user)]</b> cremated <b>[key_name(M)]</b> in [get_area(src)] ([src.loc.x],[src.loc.y],[src.loc.z]).", src.loc.x, src.loc.y, src.loc.z)
			M.death(create_cause_data("cremation", user), TRUE)
			M.ghostize()
			qdel(M)

		for(var/obj/O in contents)
			if(istype(O, /obj/structure/morgue_tray))
				continue
			qdel(O)

		new /obj/effect/decal/cleanable/ash(src)
		sleep(30)
		cremating = 0
		update_icon()
		playsound(src.loc, 'sound/machines/ding.ogg', 25, 1)


/*
 * Crematorium tray
 */

/obj/structure/morgue_tray/crematorium
	name = "焚化炉托盘"
	desc = "焚烧前请放置尸体。"
	icon_state = "cremat"


/*
 * Crematorium switch
 */

/obj/structure/machinery/crema_switch/attack_hand(mob/user)
	if(allowed(user))
		for(var/obj/structure/morgue/crematorium/C in range(7,src))
			if(C.id == id)
				if(!C.cremating)
					C.cremate(user)
	else
		to_chat(user, SPAN_DANGER("权限被拒绝。"))



/*
 * Sarcophagus
 */

/obj/structure/morgue/sarcophagus
	name = "sarcophagus"
	desc = "用于存放阵亡战士。"
	icon_state = "sarcophagus1"
	morgue_type = "sarcophagus"
	tray_path = /obj/structure/morgue_tray/sarcophagus
	update_name = FALSE


/*
 * Sarcophagus tray
 */

/obj/structure/morgue_tray/sarcophagus
	name = "石棺托盘"
	desc = "放入尸体后再关闭。"
	icon_state = "sarcomat"
