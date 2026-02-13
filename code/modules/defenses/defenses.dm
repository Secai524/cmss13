/obj/structure/machinery/defenses
	name = "不要看到这个"
	desc = "呼叫支援。"
	icon = 'icons/obj/structures/machinery/defenses/sentry.dmi'
	icon_state = "defense_base_off"
	anchored = TRUE
	unacidable = TRUE
	density = TRUE
	layer = ABOVE_MOB_LAYER //So you can't hide it under corpses
	use_power = USE_POWER_NONE
	stat = DEFENSE_FUNCTIONAL
	health = 200
	var/list/faction_group
	var/health_max = 200
	var/turned_on = FALSE
	var/mob/owner_mob = null
	var/defense_icon = "uac_sentry"
	var/handheld_type = /obj/item/defenses/handheld
	var/disassemble_time = 20
	var/defense_type = "Normal"
	var/static = FALSE
	var/locked = FALSE
	var/composite_icon = TRUE
	var/display_additional_stats = FALSE

	var/defense_check_range = 2
	var/can_be_near_defense = FALSE

	var/shots = 0
	var/kills = 0

	var/hack_time = 150
	var/placed = 0
	var/obj/item/defenses/handheld/HD

	/// Defence Laptop
	var/nickname = ""
	var/encryptable = TRUE
	/// laptop which is currently linked to the sentry
	var/obj/item/device/sentry_computer/linked_laptop = null
	var/has_camera = FALSE
	var/list/choice_categories = list()

	var/list/selected_categories = list()


/obj/structure/machinery/defenses/Initialize()
	. = ..()
	update_icon()
	connect()

/obj/structure/machinery/defenses/Destroy()
	owner_mob = null
	HD = null // FIXME: Might also need to delete. Unsure.
	if(linked_laptop)
		linked_laptop.unpair_sentry(src)
		linked_laptop = null
	if(!QDELETED(HD))
		QDEL_NULL(HD)
	return ..()

/obj/structure/machinery/defenses/proc/connect()
	if(static)
		return FALSE
	if(placed && !HD)
		HD = new handheld_type
		if(!HD.TR)
			HD.TR = src
			return TRUE
		return TRUE
	return FALSE

/obj/structure/machinery/defenses/update_icon()
	if(!composite_icon)
		icon_state = null
	else if(turned_on)
		icon_state = "defense_base"
	else
		icon_state = "defense_base_off"


/obj/structure/machinery/defenses/get_examine_text(mob/user)
	. = ..()

	var/message = ""
	if(ishuman(user))
		message += SPAN_INFO("A multitool can be used to disassemble it.")
		message += "\n"
		message += SPAN_INFO("It is currently [locked? "locked" : "unlocked"] to non-engineers.")
		message += "\n"
		message += SPAN_INFO("It has [SPAN_HELPFUL("[health]/[health_max]")] health.")
	message += "\n"
	if(display_additional_stats)
		message += SPAN_INFO("Its display reads - Kills: [kills] | Shots: [shots].")
	if(length(nickname) > 0)
		message += SPAN_INFO("\nIt has been assigned the name: [nickname]")
	. += message

/obj/structure/machinery/defenses/proc/power_on()
	if(stat == DEFENSE_DAMAGED)
		return FALSE
	if(!(placed||static))
		return FALSE

	msg_admin_niche("[key_name(usr)] turned on [src] at [get_location_in_text(src)] [ADMIN_JMP(loc)]")
	turned_on = TRUE
	power_on_action()
	update_icon()

/obj/structure/machinery/defenses/proc/power_off()
	msg_admin_niche("[key_name(usr)] turned off [src] at [get_location_in_text(src)] [ADMIN_JMP(loc)]")
	turned_on = FALSE
	power_off_action()
	update_icon()

/**
 * Update state category for this structure.
 * @param user: user who has initiated this change.
 * @param category: category of change.
 * @param selection: configuration value for category.
 */
/obj/structure/machinery/defenses/proc/update_choice(mob/user, category, selection)
	msg_admin_niche("[key_name(user)] changed the [category] of [src] at [get_location_in_text(src)] to [selection] [ADMIN_JMP(loc)]")
	if(category in selected_categories)
		selected_categories[category] = selection
		switch(category)
			if(SENTRY_CATEGORY_IFF)
				handle_iff(selection)
				return TRUE
		return FALSE

	switch(category)
		if("nickname")
			nickname = selection
			return TRUE
	return FALSE

/**
 * Update the IFF status of this structure.
 * @param selection: faction selection string.
 */
/obj/structure/machinery/defenses/proc/handle_iff(selection)
	switch(selection)
		if(FACTION_MARINE)
			faction_group = FACTION_LIST_MARINE
		if(SENTRY_FACTION_HUMAN)
			faction_group = FACTION_LIST_HUMANOID
		if(SENTRY_FACTION_COLONY)
			faction_group = list(FACTION_MARINE, FACTION_COLONIST)
		if(SENTRY_FACTION_WEYLAND)
			faction_group = FACTION_LIST_MARINE_WY
		if(FACTION_WY)
			faction_group = FACTION_LIST_WY
		if(FACTION_UPP)
			faction_group = FACTION_LIST_UPP


/obj/structure/machinery/defenses/start_processing()
	if(!machine_processing)
		machine_processing = TRUE
	START_PROCESSING(SSdefprocess, src)

/obj/structure/machinery/defenses/stop_processing()
	if(machine_processing)
		machine_processing = FALSE
	STOP_PROCESSING(SSdefprocess, src)

/obj/structure/machinery/defenses/proc/earn_kill()
	kills++

/obj/structure/machinery/defenses/proc/track_shot()
	shots++
	if(owner_mob && owner_mob != src)
		owner_mob.track_shot(initial(name))

/obj/structure/machinery/defenses/proc/friendly_faction(factions)
	if(factions in faction_group)
		return TRUE
	return FALSE

/obj/structure/machinery/defenses/attackby(obj/item/O as obj, mob/user as mob)
	if(QDELETED(O))
		return

	if(HAS_TRAIT(O, TRAIT_TOOL_MULTITOOL))
		if(!friendly_faction(user.faction))
			to_chat(user, SPAN_WARNING("这看起来不太安全..."))
			var/additional_shock = 1
			if(!do_after(user, hack_time * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, src))
				additional_shock++
			if(prob(50))
				var/mob/living/carbon/human/H = user
				if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_NOVICE))
					if(turned_on)
						additional_shock++
					H.electrocute_act(40, src, additional_shock)//god damn Hans...
					setDir(get_dir(src, H))//Make sure he died
					power_off()
					power_on()
					return
				else
					H.electrocute_act(20, src)//god bless him for stupid move
					return
			if(additional_shock >= 2)
				return
			LAZYCLEARLIST(faction_group)
			for(var/i in user.faction_group)
				LAZYADD(faction_group, i)
			to_chat(user, SPAN_WARNING("你已经黑入了\the [src]，现在它是我们的了！"))
			return

		if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_NOVICE))
			to_chat(user, SPAN_WARNING("你没有接受过相关训练。"))
			return
		// if the sentry can have key interacted with
		// and if the multitool is able to do it
		// we need to ask what to do
		var/list/multitool_actions = list()
		var/obj/item/device/multitool/tool = O
		if(encryptable && !linked_laptop && length(tool.encryption_keys) > 0)
			multitool_actions += "encrypt"
		if(encryptable && linked_laptop)
			multitool_actions += "decrypt"
		if(encryptable && !linked_laptop)
			multitool_actions += "disassemble"

		var/result = null
		if(length(multitool_actions) > 1)
			result = tgui_input_list(user, "你想用万用工具做什么", "Multitool interaction", multitool_actions)
		else if (length(multitool_actions) == 1)
			result = multitool_actions[1]

		if(!result)
			return
		switch(result)
			if("encrypt")
				var/key_found = FALSE
				for(var/i in tool.encryption_keys)
					var/datum/weakref/ref = tool.encryption_keys[i]
					var/obj/item = ref.resolve()
					if(istype(item, /obj/item/device/sentry_computer))
						var/obj/item/device/sentry_computer/computer = item
						to_chat(usr, SPAN_NOTICE("正在尝试连接到[item] [computer.serial_number]。"))
						playsound(src, 'sound/machines/scanning.ogg', 25, FALSE)
						computer.register(tool, user, src)
						key_found = TRUE
						break
				if(!key_found)
					to_chat(user, SPAN_WARNING("未找到有效加密密钥。请将\the [tool]与哨戒炮计算机连接。"))
				return
			if("decrypt")
				// unregister
				var/loaded_key = linked_laptop.serial_number
				if(length(tool.encryption_keys) == 0)
					to_chat(user, SPAN_NOTICE("\The [src] is encrypted. To use \the [tool] it must be paired with the laptop [linked_laptop.serial_number]."))
				if(tool.encryption_keys[loaded_key])
					to_chat(user, SPAN_NOTICE("正在尝试对[src]进行解密。"))
					linked_laptop.unregister(tool, user, src)
				else
					to_chat(user, SPAN_WARNING("\The [src] is already encrypted by laptop [linked_laptop.serial_number]. You must load its encryption key to decrypt."))
				return
		if(health < health_max * 0.25)
			to_chat(user, SPAN_WARNING("\The [src] is too damaged to pick up!"))
			return

		if(static)
			to_chat(user, SPAN_WARNING("\The [src] is bolted to the ground!"))
			return

		if(linked_laptop)
			to_chat(user, SPAN_WARNING("\The [src] is currently encrypted by [linked_laptop]. To deconstruct \the [src] it must first be unlinked."))
			return

		user.visible_message(SPAN_NOTICE("[user]开始拆卸\the [src]。"), SPAN_NOTICE("You begin disassembling \the [src]."))

		if(!do_after(user, disassemble_time * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, src))
			return

		if(health < health_max * 0.25) //repeat check
			to_chat(user, SPAN_WARNING("\The [src] is too damaged to pick up!"))
			return

		user.visible_message(SPAN_NOTICE("[user]拆解了[src]。"), SPAN_NOTICE("You disassemble [src]."))

		playsound(loc, 'sound/mecha/mechmove04.ogg', 30, 1)
		var/turf/T = get_turf(src)
		if(!faction_group) //Littly trolling for stealing marines turrets, bad boys!
			for(var/i in user.faction_group)
				LAZYADD(faction_group, i)
		power_off()
		HD.forceMove(T)
		transfer_label_component(HD)
		HD.dropped = 1
		HD.update_icon()
		placed = 0
		forceMove(HD)

		return

	if(HAS_TRAIT(O, TRAIT_TOOL_WRENCH))
		if(anchored)
			if(turned_on)
				to_chat(user, SPAN_WARNING("[src]目前处于激活状态。电机会阻止你安全地解除其固定。"))
				return

			user.visible_message(SPAN_NOTICE("[user]开始将[src]从地面解除固定。"),
			SPAN_NOTICE("You begin unanchoring [src] from the ground."))

			if(!do_after(user, 20 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, src))
				return
			user.visible_message(SPAN_NOTICE("[user]将[src]从地面解除固定。"),
			SPAN_NOTICE("You unanchor [src] from the ground."))
			anchored = FALSE
			playsound(src.loc, 'sound/items/Ratchet.ogg', 25, 1)
			return
		else
			var/area/area = get_area(src)
			if(!area.allow_construction)
				to_chat(user, SPAN_WARNING("你无法在此处固定\the [src]，找个更稳固的表面！"))
				return
			var/turf/open/floor = get_turf(src)
			if(!floor.allow_construction)
				to_chat(user, SPAN_WARNING("你无法在此处固定\the [src]，找个更稳固的表面！"))
				return FALSE
			user.visible_message(SPAN_NOTICE("[user]开始将[src]固定在地面上。"),
			SPAN_NOTICE("You begin securing [src] to the ground."))

			if(!do_after(user, 20 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, src))
				return
			user.visible_message(SPAN_NOTICE("[user]将[src]固定在地面上。"),
			SPAN_NOTICE("You secure [src] to the ground."))
			anchored = TRUE
			playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
			return

	if(iswelder(O))
		if(!HAS_TRAIT(O, TRAIT_TOOL_BLOWTORCH))
			to_chat(user, SPAN_WARNING("你需要一把更强的喷枪！"))
			return
		var/obj/item/tool/weldingtool/WT = O
		if(health < 0)
			to_chat(user, SPAN_WARNING("[src]的内部电路已损坏，你无法在行进中修复它。"))
			return

		if(health >= health_max)
			to_chat(user, SPAN_WARNING("[src]不需要修理。"))
			return

		if(WT.remove_fuel(0, user))
			user.visible_message(SPAN_NOTICE("[user]开始修理[src]。"),
			SPAN_NOTICE("You begin repairing [src]."))
			if(do_after(user, 40 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_FRIENDLY, src))
				user.visible_message(SPAN_NOTICE("[user]修理了[src]。"),
				SPAN_NOTICE("You repair [src]."))
				if(stat == DEFENSE_DAMAGED)
					stat &= ~DEFENSE_DAMAGED
				update_health(-50)
				playsound(src.loc, 'sound/items/Welder2.ogg', 25, 1)
		return

	return TRUE

/obj/structure/machinery/defenses/attack_hand(mob/user)
	if(!attack_hand_checks(user))
		return

	if(isyautja(user))
		to_chat(user, SPAN_WARNING("你击打了[src]，但无事发生。"))
		return

	add_fingerprint(user)

	if(!friendly_faction(user.faction))
		return

	if(!anchored)
		to_chat(user, SPAN_WARNING("你必须先将其固定在地面上才能激活。"))
		return

	if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
		if(locked)
			to_chat(user, SPAN_WARNING("[src]的控制面板对非工程师锁定。"))
			return
		user.visible_message(SPAN_NOTICE("[user] begins switching [src] [turned_on? "off" : "on"]."), SPAN_NOTICE("You begin switching [src] [turned_on? "off" : "on"]."))
		if(!(do_after(user, 20, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_FRIENDLY, src)))
			return

	if(!turned_on)
		if(!can_be_near_defense)
			for(var/obj/structure/machinery/defenses/def in long_range(defense_check_range, loc))
				if(def != src && def.turned_on && !def.can_be_near_defense)
					to_chat(user, SPAN_WARNING("这离\a [def]太近了！"))
					return

		power_on()
	else
		power_off()


/obj/structure/machinery/defenses/proc/attack_hand_checks(mob/user)
	return TRUE

/obj/structure/machinery/defenses/proc/power_on_action(mob/user)
	return

/obj/structure/machinery/defenses/proc/power_off_action(mob/user)
	return

// DAMAGE HANDLING
/obj/structure/machinery/defenses/update_health(damage = 0) //Negative damage restores health.
	health -= damage

	if(health > health_max)
		health = health_max

	if(health <= 0 && stat != DEFENSE_DESTROYED)
		stat |= DEFENSE_DESTROYED
		SEND_SIGNAL(src, COMSIG_SENTRY_DESTROYED_ALERT)
		destroyed_action()
		return

	if(stat == DEFENSE_FUNCTIONAL && damage > 0)
		damaged_action(damage)

	if(stat == DEFENSE_DAMAGED)
		set_density(FALSE)
	else
		set_density(initial(density))

	update_icon()

/obj/structure/machinery/defenses/proc/destroyed_action()
	visible_message("[icon2html(src, viewers(src))] [SPAN_WARNING("The [name] starts to blink rapidly!")]")
	playsound(loc, 'sound/mecha/critdestrsyndi.ogg', 25, 1)

	sleep(5)

	cell_explosion(loc, 10, 10, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, create_cause_data("defense explosion"))
	if(!QDELETED(src))
		qdel(src)

/obj/structure/machinery/defenses/proc/damaged_action(damage)
	if(health < health_max * 0.15)
		visible_message(SPAN_DANGER("[icon2html(src, viewers(src))] [name]破裂并粉碎了！"))
		stat |= DEFENSE_DAMAGED
		turned_on = FALSE

/obj/structure/machinery/defenses/emp_act(severity)
	. = ..()
	if(turned_on)
		if(prob(50))
			visible_message("[icon2html(src, viewers(src))] <span class='danger'>[src]疯狂地发出哔哔声和嗡嗡声，屏幕上闪过奇怪的符号，随后关机！</span>")
			playsound(loc, 'sound/mecha/critdestrsyndi.ogg', 25, 1)
			for(var/i = 1 to 6)
				setDir(pick(1, 2, 3, 4))
				sleep(2)
			turned_on = FALSE
	if(health > 0)
		update_health(25)
	return

/obj/structure/machinery/defenses/ex_act(severity)
	if(health <= 0)
		return
	update_health(severity)

/obj/structure/machinery/defenses/bullet_act(obj/projectile/P)
	bullet_ping(P)
	visible_message(SPAN_WARNING("[src]被[P]击中了！"))
	var/ammo_flags = P.ammo.flags_ammo_behavior | P.projectile_override_flags
	if(ammo_flags & AMMO_ACIDIC) //Fix for xenomorph spit doing baby damage.
		update_health(floor(P.damage/3))
	else
		update_health(floor(P.damage/10))
	return TRUE
// DAMAGE HANDLING OVER

//Fixes a bug with power changes in the area.
/obj/structure/machinery/defenses/power_change()
	return

/obj/structure/machinery/defenses/verb/toggle_turret_locks_verb()
	set name = "Toggle Turret Lock"
	set desc = "Toggles allowing non-engineers to turn turrets on and off"
	set category = "Object"
	set src in view(1)
	if(static)
		return
	if(!ishuman(usr))
		return
	if(!friendly_faction(usr.faction))
		return
	if(!skillcheck(usr, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
		to_chat(usr, SPAN_WARNING("你没有接受过相关训练。"))
		return

	locked = !locked
	to_chat(usr, SPAN_NOTICE("You [locked? "lock" : "unlock"] [src] to non-engineers."))
	update_icon()
