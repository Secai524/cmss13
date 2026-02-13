/obj/structure/machinery/computer/shuttle/dropship/flight
	name = "运输机导航计算机"
	desc = "一种可用于自动驾驶或长途飞行的飞行计算机。"
	icon = 'icons/obj/structures/machinery/shuttle-parts.dmi'
	icon_state = "console"
	req_one_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_DROPSHIP)
	unacidable = TRUE
	explo_proof = TRUE
	needs_power = FALSE
	var/override_being_removed = FALSE

	// Admin disabled
	var/disabled = FALSE

	// Is door control locked -- hijack
	var/dropship_control_lost = FALSE
	var/door_control_cooldown

	// Allows admins to var edit the time lock away.
	var/skip_time_lock = FALSE

	// Landing zones which can be used
	var/compatible_landing_zones = list()

	// If the computer is on the dropship or remotely accessing it
	var/is_remote = FALSE

	// linked lz id (lz1, lz2 or null)
	var/linked_lz

	var/can_change_shuttle = FALSE
	var/faction = FACTION_MARINE

	/// If this computer should respect the faction variable of destination LZ
	var/use_factions = TRUE

/obj/structure/machinery/computer/shuttle/dropship/flight/upp
	icon_state = "console_upp"
	req_one_access = list(ACCESS_UPP_FLIGHT)
	faction = FACTION_UPP

/obj/structure/machinery/computer/shuttle/dropship/flight/Initialize(mapload, ...)
	. = ..()
	compatible_landing_zones = get_landing_zones()

/obj/structure/machinery/computer/shuttle/dropship/flight/Destroy()
	. = ..()
	compatible_landing_zones = null

/obj/structure/machinery/computer/shuttle/dropship/flight/proc/get_landing_zones()
	. = list()
	for(var/obj/docking_port/stationary/marine_dropship/dock in SSshuttle.stationary)
		if(use_factions && dock.faction != faction)
			continue
		if(istype(dock, /obj/docking_port/stationary/marine_dropship/crash_site))
			continue
		. += list(dock)

/obj/structure/machinery/computer/shuttle/dropship/flight/is_disabled()
	return disabled

/obj/structure/machinery/computer/shuttle/dropship/flight/disable()
	disabled = TRUE

/obj/structure/machinery/computer/shuttle/dropship/flight/enable()
	disabled = FALSE

/obj/structure/machinery/computer/shuttle/dropship/flight/proc/update_equipment(optimised=FALSE, is_flyby=FALSE)
	var/obj/docking_port/mobile/marine_dropship/dropship = SSshuttle.getShuttle(shuttleId)
	if(!dropship)
		return

	// initial flight time
	var/flight_duration =  is_flyby ? DROPSHIP_TRANSIT_DURATION : DROPSHIP_TRANSIT_DURATION * GLOB.ship_alt
	if(optimised)
		if(is_flyby)
			flight_duration = DROPSHIP_TRANSIT_DURATION * 1.5
		else
			flight_duration = DROPSHIP_TRANSIT_DURATION * SHUTTLE_OPTIMIZE_FACTOR_TRAVEL

	// recharge time before dropship can take off
	var/recharge_duration = SHUTTLE_RECHARGE

	if(optimised)
		recharge_duration = SHUTTLE_RECHARGE * SHUTTLE_OPTIMIZE_FACTOR_RECHARGE

	for(var/obj/structure/dropship_equipment/equipment as anything in dropship.equipments)
		// fuel enhancer
		if(istype(equipment, /obj/structure/dropship_equipment/fuel/fuel_enhancer))
			if(is_flyby)
				flight_duration = flight_duration / SHUTTLE_FUEL_ENHANCE_FACTOR_TRAVEL
			else
				flight_duration = flight_duration * SHUTTLE_FUEL_ENHANCE_FACTOR_TRAVEL

		// cooling system
		if(istype(equipment, /obj/structure/dropship_equipment/fuel/cooling_system))
			recharge_duration = recharge_duration * SHUTTLE_COOLING_FACTOR_RECHARGE


	dropship.callTime = floor(flight_duration)
	dropship.rechargeTime = floor(recharge_duration)

/obj/structure/machinery/computer/shuttle/dropship/flight/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		var/obj/docking_port/mobile/shuttle = SSshuttle.getShuttle(shuttleId)
		var/name = capitalize(shuttle?.name)
		if(can_change_shuttle)
			name = "遥控器"
		ui = new(user, src, "DropshipFlightControl", "[name] Flight Computer")
		ui.open()

/obj/structure/machinery/computer/shuttle/dropship/flight/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	if(inoperable())
		return UI_CLOSE
	if(disabled)
		return UI_UPDATE
	if(!skip_time_lock && world.time < SSticker.mode.round_time_lobby + SHUTTLE_TIME_LOCK)
		to_chat(user, SPAN_WARNING("运输机仍在进行起飞前燃料加注，尚不能出发。请再等待[floor((SSticker.mode.round_time_lobby + SHUTTLE_TIME_LOCK-world.time)/600)]分钟再试。"))
		return UI_CLOSE
	if(dropship_control_lost)
		var/remaining_time = timeleft(door_control_cooldown) / 10
		var/units = "seconds"
		if(remaining_time > 60)
			remaining_time = remaining_time / 60
			units = "minutes"
		to_chat(user, SPAN_WARNING("运输机没有响应，请在[remaining_time] [units]后重试。"))
		return UI_CLOSE

/obj/structure/machinery/computer/shuttle/dropship/flight/ui_state(mob/user)
	var/obj/docking_port/mobile/marine_dropship/shuttle = SSshuttle.getShuttle(shuttleId)
	if(shuttle?.is_hijacked)
		return GLOB.never_state
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/computer/shuttle/dropship/flight/ui_static_data(mob/user)
	. = ..(user)
	compatible_landing_zones = get_landing_zones()
	var/obj/docking_port/mobile/shuttle = SSshuttle.getShuttle(shuttleId)
	// we convert the time to seconds for rendering to ui
	if(shuttle)
		.["max_flight_duration"] = shuttle.callTime / 10
		.["max_pre_arrival_duration"] = shuttle.prearrivalTime / 10
		.["max_refuel_duration"] = shuttle.rechargeTime / 10
		.["max_engine_start_duration"] = shuttle.ignitionTime / 10
		.["door_data"] = list("port", "starboard", "aft")
	.["alternative_shuttles"] = list()
	if(can_change_shuttle)
		.["alternative_shuttles"] = alternative_shuttles()

/obj/structure/machinery/computer/shuttle/dropship/flight/proc/alternative_shuttles()
	. = list()
	for(var/obj/docking_port/mobile/marine_dropship/shuttle in SSshuttle.mobile)
		if(use_factions && shuttle.faction != faction)
			continue
		. += list(
			list(
				"id" = shuttle.id, "name" = shuttle)
		)


/obj/structure/machinery/computer/shuttle/dropship/flight/attack_hand(mob/user)
	. = ..(user)
	if(.)
		return TRUE

	if(!allowed(user))
		to_chat(user, SPAN_WARNING("权限被拒绝。"))
		return TRUE

	// if the dropship has crashed don't allow more interactions
	var/obj/docking_port/mobile/marine_dropship/shuttle = SSshuttle.getShuttle(shuttleId)
	if(!shuttle)
		tgui_interact(user)
		return

	if(shuttle.mode == SHUTTLE_CRASHED)
		to_chat(user, SPAN_NOTICE("[src]无响应。"))
		return

	if(dropship_control_lost)
		if(shuttle.is_hijacked)
			to_chat(user, SPAN_WARNING("由于未经授权的访问尝试，运输机没有响应。"))
			return
		var/remaining_time = timeleft(door_control_cooldown) / 10
		to_chat(user, SPAN_WARNING("由于未经授权的访问尝试，运输机没有响应。大号文字显示锁定将在[remaining_time]秒后自动解除。"))
		if(!skillcheck(user, SKILL_PILOT, SKILL_PILOT_EXPERT))
			return
		if(user.action_busy || override_being_removed)
			return
		to_chat(user, SPAN_NOTICE("你开始解除锁定。"))
		override_being_removed = TRUE
		while(remaining_time > 20)
			if(!do_after(user, 20 SECONDS, INTERRUPT_ALL|INTERRUPT_CHANGED_LYING, BUSY_ICON_HOSTILE, numticks = 20))
				to_chat(user, SPAN_WARNING("解除锁定失败！"))
				override_being_removed = FALSE
				return
			if(!dropship_control_lost)
				to_chat(user, SPAN_NOTICE("锁定已解除。"))
				break
			remaining_time = timeleft(door_control_cooldown) / 10 - 20
			if(remaining_time > 0)
				to_chat(user, SPAN_NOTICE("你部分绕过了锁定，仅剩[remaining_time]秒。"))
				door_control_cooldown = addtimer(CALLBACK(src, PROC_REF(remove_door_lock)), remaining_time SECONDS, TIMER_STOPPABLE|TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_NO_HASH_WAIT)
	override_being_removed = FALSE
	if(dropship_control_lost)
		remove_door_lock()
		to_chat(user, SPAN_NOTICE("你成功解除了锁定！"))
		playsound(loc, 'sound/machines/terminal_success.ogg', KEYBOARD_SOUND_VOLUME, 1)

	if(!shuttle.is_hijacked)
		tgui_interact(user)

/obj/structure/machinery/computer/shuttle/dropship/flight/proc/groundside_alien_action(mob/living/carbon/xenomorph/xeno)
	if(SSticker.mode.active_lz != src)
		to_chat(xeno, SPAN_NOTICE("此终端未激活。"))
		return

	if(!SSobjectives.first_drop_complete)
		to_chat(xeno, SPAN_NOTICE("此终端未激活。"))
		return

	var/obj/docking_port/mobile/shuttle = SSshuttle.getShuttle(shuttleId)
	if(linked_lz)
		var/obj/docking_port/stationary/landing_zone = SSshuttle.getDock(linked_lz)
		var/obj/docking_port/mobile/maybe_dropship = landing_zone.get_docked()

		if(maybe_dropship)
			to_chat(xeno, SPAN_NOTICE("一只金属鸟已经在此。"))
			return

		var/conflicting_transit = FALSE
		for(var/obj/docking_port/mobile/other_shuttle in SSshuttle.mobile)
			if(landing_zone == other_shuttle.destination)
				conflicting_transit = TRUE
				break

		if(conflicting_transit)
			to_chat(xeno, SPAN_NOTICE("一只金属鸟已在途中。"))
			return

		playsound(loc, 'sound/machines/terminal_success.ogg', KEYBOARD_SOUND_VOLUME, 1)
		if(shuttle.mode == SHUTTLE_IDLE && !is_ground_level(shuttle.z))
			var/result = SSshuttle.moveShuttle(shuttleId, linked_lz, TRUE)
			if(result != DOCKING_SUCCESS)
				to_chat(xeno, SPAN_WARNING("金属鸟无法在此降落。该区域可能已被占用！"))
				return
			to_chat(xeno, SPAN_NOTICE("你命令金属鸟降落。聪明的家伙。"))
			xeno_announcement(SPAN_XENOANNOUNCE("Our Queen has commanded the metal bird to the hive at [linked_lz]."), xeno.hivenumber, XENO_GENERAL_ANNOUNCE)
			log_ares_flight("未知", "Remote launch signal for [shuttle.name] received. Authentication garbled.")
			log_ares_security("Security Alert", "Remote launch signal for [shuttle.name] received. Authentication garbled.")
			return
		if(shuttle.destination && shuttle.destination.id != linked_lz)
			to_chat(xeno, "运输机尚未就绪。屏幕显示 T-[shuttle.timeLeft(10)]。请耐心等待。")
			return
		if(shuttle.mode == SHUTTLE_CALL)
			to_chat(xeno, "运输机正在飞行中。屏幕显示 T-[shuttle.timeLeft(10)]。请耐心等待。")
			return
		if(shuttle.mode == SHUTTLE_PREARRIVAL)
			to_chat(xeno, "运输机正在降落。做好准备。")
			return
		if(shuttle.mode == SHUTTLE_IGNITING)
			to_chat(xeno, "运输机正在起飞。")
			return


/obj/structure/machinery/computer/shuttle/dropship/flight/attack_alien(mob/living/carbon/xenomorph/xeno)
	// if the shuttleid is null or the shuttleid references a shuttle that has been removed from play, pick one
	if(!shuttleId || !SSshuttle.getShuttle(shuttleId, FALSE))
		var/list/alternatives = alternative_shuttles()
		shuttleId = pick(alternatives)["id"]

	var/obj/docking_port/mobile/marine_dropship/dropship = SSshuttle.getShuttle(shuttleId)

	// If the attacking xeno isn't the queen.
	if(xeno.hive_pos != XENO_QUEEN)
		// If the 'about to launch' alarm is playing, a xeno can whack the computer to stop it.
		if(dropship.playing_launch_announcement_alarm)
			stop_playing_launch_announcement_alarm()
			xeno.animation_attack_on(src)
			to_chat(xeno, SPAN_XENONOTICE("我们劈砍[src]，让它闭嘴！"))
			playsound(loc, 'sound/machines/terminal_shutdown.ogg', 20)
		else
			to_chat(xeno, SPAN_NOTICE("终端灯光闪烁，但我们无法理解其含义。"))
			playsound(loc, 'sound/machines/terminal_error.ogg', KEYBOARD_SOUND_VOLUME, TRUE)
		return XENO_NONCOMBAT_ACTION

	if(!is_ground_level(z))
		// "you" rather than "we" for this one since non-queen castes will have returned above.
		to_chat(xeno, SPAN_NOTICE("终端灯光闪烁，但你无法理解其含义。"))
		playsound(loc, 'sound/machines/terminal_error.ogg', KEYBOARD_SOUND_VOLUME, TRUE)
		return XENO_NONCOMBAT_ACTION

	if(is_remote)
		groundside_alien_action(xeno)
		return

	if(dropship.is_hijacked)
		return

	// door controls being overridden
	if(!dropship_control_lost && do_after(xeno, 3 SECONDS, INTERRUPT_ALL, BUSY_ICON_HOSTILE))
		dropship.control_doors("unlock", "all", TRUE)
		dropship_control_lost = TRUE
		update_icon()
		door_control_cooldown = addtimer(CALLBACK(src, PROC_REF(remove_door_lock)), SHUTTLE_LOCK_COOLDOWN, TIMER_STOPPABLE|TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_NO_HASH_WAIT)
		if(GLOB.almayer_orbital_cannon)
			GLOB.almayer_orbital_cannon.is_disabled = TRUE
			addtimer(CALLBACK(GLOB.almayer_orbital_cannon, TYPE_PROC_REF(/obj/structure/orbital_cannon, enable)), 10 MINUTES, TIMER_UNIQUE)
		if(!MODE_HAS_MODIFIER(/datum/gamemode_modifier/lz_weeding))
			MODE_SET_MODIFIER(/datum/gamemode_modifier/lz_weeding, TRUE)
		stop_playing_launch_announcement_alarm()

		to_chat(xeno, SPAN_XENONOTICE("你强行打开了舱门。"))
		xeno_message(SPAN_XENOANNOUNCE("The doors of the metal bird have been overridden! Rejoice!"), 3, xeno.hivenumber)
		message_admins("[key_name(xeno)] has locked the dropship '[dropship]'", xeno.x, xeno.y, xeno.z)
		notify_ghosts(header = "Dropship Locked", message = "[xeno] has locked [dropship]!", source = xeno, action = NOTIFY_ORBIT)
		SScmtv.spectate_event("Dropship Locked", src)
		return

	if(dropship_control_lost)
		//keyboard
		for(var/i = 0; i < 5; i++)
			if(usr.action_busy)
				return
			playsound(loc, get_sfx("keyboard"), KEYBOARD_SOUND_VOLUME, 1)
			if(!do_after(usr, 1 SECONDS, INTERRUPT_ALL, BUSY_ICON_HOSTILE))
				return
			if(i < 4)
				playsound(loc, 'sound/machines/terminal_error.ogg', KEYBOARD_SOUND_VOLUME, 1)
		playsound(loc, 'sound/machines/terminal_success.ogg', KEYBOARD_SOUND_VOLUME, 1)
		if(world.time < SHUTTLE_LOCK_TIME_LOCK)
			to_chat(xeno, SPAN_XENODANGER("你还无法集中力量劫持运输机。请再等待[time_left_until(SHUTTLE_LOCK_TIME_LOCK, world.time, 1 MINUTES)]分钟后再试。"))
			return
		hijack(xeno)
		return

/obj/structure/machinery/computer/shuttle/dropship/flight/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	return TAILSTAB_COOLDOWN_NONE

/obj/structure/machinery/computer/shuttle/dropship/flight/update_icon()
	. = ..()
	if(icon_state == "console") // someday, replace this with a better check
		if(dropship_control_lost)
			icon_state = "[initial(icon_state)]-locked"
		else
			icon_state = initial(icon_state)

/obj/structure/machinery/computer/shuttle/dropship/flight/proc/hijack(mob/user, force = FALSE)
	// select crash location
	var/turf/source_turf = get_turf(src)
	var/obj/docking_port/mobile/marine_dropship/dropship = SSshuttle.getShuttle(shuttleId)
	var/result = tgui_input_list(user, "‘降落’地点？", "Dropship Hijack", GLOB.almayer_ship_sections , timeout = 10 SECONDS)
	if(!result)
		return
	if(!user.Adjacent(source_turf) && !force)
		return
	if(dropship.is_hijacked)
		return

	var/datum/dropship_hijack/almayer/hijack = new()
	SShijack.call_shuttle()
	dropship.hijack = hijack
	hijack.shuttle = dropship
	hijack.target_crash_site(result)

	dropship.crashing = TRUE
	dropship.is_hijacked = TRUE

	hijack.fire()
	GLOB.alt_ctrl_disabled = TRUE

	marine_announcement("侦测到作战区域发生非预定运输机离港。可能遭劫持。正在关闭自动驾驶。", "Dropship Alert", 'sound/AI/hijack.ogg', logging = ARES_LOG_SECURITY)
	log_ares_flight("未知", "侦测到作战区域发生非预定运输机离港。可能遭劫持。正在关闭自动驾驶。")
	addtimer(CALLBACK(src, PROC_REF(hijack_general_quarters)), 10 SECONDS)
	var/mob/living/carbon/xenomorph/xeno = user
	var/hivenumber = XENO_HIVE_NORMAL
	if(istype(xeno))
		hivenumber = xeno.hivenumber
	xeno_message(SPAN_XENOANNOUNCE("The Queen has commanded the metal bird to depart for the metal hive in the sky! Rejoice!"), 3, hivenumber)
	xeno_message(SPAN_XENOANNOUNCE("The hive swells with power! You will now steadily gain pooled larva over time."), 2, hivenumber)
	var/datum/hive_status/hive = GLOB.hive_datum[hivenumber]
	addtimer(CALLBACK(hive, TYPE_PROC_REF(/datum/hive_status, abandon_on_hijack)), DROPSHIP_WARMUP_TIME, TIMER_UNIQUE)
	var/original_evilution = hive.evolution_bonus
	hive.override_evilution(XENO_HIJACK_EVILUTION_BUFF, TRUE)
	if(hive.living_xeno_queen)
		var/datum/action/xeno_action/onclick/grow_ovipositor/ovi_ability = get_action(hive.living_xeno_queen, /datum/action/xeno_action/onclick/grow_ovipositor)
		ovi_ability.reduce_cooldown(ovi_ability.xeno_cooldown)
		if(!hive.living_xeno_queen.queen_aged)
			hive.living_xeno_queen.make_combat_effective()
	addtimer(CALLBACK(hive, TYPE_PROC_REF(/datum/hive_status, override_evilution), original_evilution, FALSE), XENO_HIJACK_EVILUTION_TIME)

	// Notify the yautja too so they stop the hunt
	message_all_yautja("The serpent Queen has commanded the landing shuttle to depart.")
	playsound(src, 'sound/misc/queen_alarm.ogg')

	if(istype(SSticker.mode, /datum/game_mode/colonialmarines))
		var/datum/game_mode/colonialmarines/colonial_marines = SSticker.mode
		colonial_marines.add_current_round_status_to_end_results("劫持")

/obj/structure/machinery/computer/shuttle/dropship/flight/proc/hijack_general_quarters()
	var/datum/ares_datacore/datacore = GLOB.ares_datacore
	if(GLOB.security_level < SEC_LEVEL_RED)
		set_security_level(SEC_LEVEL_RED, no_sound = TRUE, announce = FALSE)
	if(!COOLDOWN_FINISHED(datacore, ares_quarters_cooldown))
		return FALSE
	COOLDOWN_START(datacore, ares_quarters_cooldown, 10 MINUTES)
	shipwide_ai_announcement("注意！全员战斗警报。所有人员，进入战斗岗位。", MAIN_AI_SYSTEM, 'sound/effects/GQfullcall.ogg')
	return TRUE

/obj/structure/machinery/computer/shuttle/dropship/flight/proc/remove_door_lock()
	if(door_control_cooldown)
		deltimer(door_control_cooldown)
		door_control_cooldown = null
	var/obj/docking_port/mobile/marine_dropship/shuttle = SSshuttle.getShuttle(shuttleId)
	if(shuttle.is_hijacked)
		return
	playsound(loc, 'sound/machines/terminal_success.ogg', KEYBOARD_SOUND_VOLUME, 1)
	dropship_control_lost = FALSE
	update_icon()

/obj/structure/machinery/computer/shuttle/dropship/flight/ui_data(mob/user)
	var/obj/docking_port/mobile/marine_dropship/shuttle = SSshuttle.getShuttle(shuttleId)
	. = list()
	.["shuttle_id"] = shuttle?.id
	.["shuttle_mode"] = shuttle?.mode
	.["flight_time"] = shuttle?.timeLeft(0)
	.["is_disabled"] = disabled
	if(shuttle?.is_hijacked)
		.["is_disabled"] = TRUE
	.["locked_down"] = FALSE
	.["can_fly_by"] = !is_remote
	.["can_set_automated"] = is_remote
	.["automated_control"] = list(
		"is_automated" = shuttle?.automated_hangar_id != null || shuttle?.automated_lz_id != null,
		"hangar_lz" = shuttle?.automated_hangar_id,
		"ground_lz" = shuttle?.automated_lz_id
	)
	.["primary_lz"] = SSticker.mode.active_lz?.linked_lz
	if(shuttle?.destination)
		.["target_destination"] = shuttle?.in_flyby? "Flyby" : shuttle?.destination.name

	.["door_status"] = is_remote ? list() : shuttle?.get_door_data()
	.["has_flyby_skill"] = skillcheck(user, SKILL_PILOT, SKILL_PILOT_EXPERT)

	// Launch Alarm Variables
	.["playing_launch_announcement_alarm"] = shuttle?.playing_launch_announcement_alarm

	.["destinations"] = list()
	// add flight
	if(!is_remote)
		.["destinations"] += list(
			list(
				"id" = DROPSHIP_FLYBY_ID,
				"name" = "Flyby",
				"available" = TRUE,
				"error" = FALSE
			)
		)

	for(var/obj/docking_port/stationary/dock in compatible_landing_zones)
		var/dock_reserved = FALSE
		for(var/obj/docking_port/mobile/other_shuttle in SSshuttle.mobile)
			if(dock == other_shuttle.destination)
				dock_reserved = TRUE
				break
		var/can_dock = shuttle?.canDock(dock)
		var/list/dockinfo = list(
			"id" = dock.id,
			"name" = dock.name,
			"available" = can_dock == SHUTTLE_CAN_DOCK && !dock_reserved,
			"error" = can_dock,
		)
		.["destinations"] += list(dockinfo)

/obj/structure/machinery/computer/shuttle/dropship/flight/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	var/obj/docking_port/mobile/marine_dropship/shuttle = SSshuttle.getShuttle(shuttleId)
	if(disabled || (shuttle && shuttle.is_hijacked))
		switch(action)
			if ("change_shuttle")
				var/new_shuttle = params["new_shuttle"]
				return set_shuttle(new_shuttle)
		return
	var/mob/user = usr
	if (shuttle)
		var/obj/structure/machinery/computer/shuttle/dropship/flight/comp = shuttle.getControlConsole()
		if(comp.dropship_control_lost)
			to_chat(user, SPAN_WARNING("运输机没有响应控制指令。"))
			return

	if(use_factions && shuttle && shuttle.faction != faction) //someone trying href
		return FALSE

	switch(action)
		if("move")
			if(!shuttle)
				return FALSE
			if(shuttle.mode != SHUTTLE_IDLE && (shuttle.mode != SHUTTLE_CALL && !shuttle.destination))
				to_chat(usr, SPAN_WARNING("你现在无法前往新目的地。"))
				return TRUE

			var/is_optimised = FALSE
			// automatically apply optimisation if user is a pilot
			if(skillcheck(user, SKILL_PILOT, SKILL_PILOT_EXPERT))
				is_optimised = TRUE

			var/dock_id = params["target"]
			if(dock_id == DROPSHIP_FLYBY_ID)
				if(!skillcheck(user, SKILL_PILOT, SKILL_PILOT_EXPERT))
					to_chat(user, SPAN_WARNING("你没有执行飞掠的技能。"))
					return FALSE
				update_equipment(is_optimised, TRUE)
				to_chat(user, SPAN_NOTICE("你开始启动飞掠程序。"))
				if(shuttle.faction == FACTION_MARINE)
					log_ares_flight(user.name, "Launched Dropship [shuttle.name] on a flyby.")
				var/log = "[key_name(user)] launched the dropship [src.shuttleId] on flyby."
				msg_admin_niche(log)
				log_interact(user, msg = "[log]")
				shuttle.send_for_flyby()
				stop_playing_launch_announcement_alarm()
				return TRUE

			update_equipment(is_optimised, FALSE)
			var/list/local_data = ui_data(user)
			var/found = FALSE
			playsound(loc, get_sfx("terminal_button"), 5, 1)
			for(var/destination in local_data["destinations"])
				if(destination["id"] == dock_id)
					found = TRUE
					break
			if(!found)
				log_admin("[key_name(user)] may be attempting a href dock exploit on [src] with target location \"[dock_id]\"")
				to_chat(user, SPAN_WARNING("[dock_id]泊位目前不可用。"))
				return
			var/obj/docking_port/stationary/dock = SSshuttle.getDock(dock_id)
			var/dock_reserved = FALSE
			for(var/obj/docking_port/mobile/other_shuttle in SSshuttle.mobile)
				if(dock == other_shuttle.destination)
					dock_reserved = TRUE
					break
			if(dock_reserved)
				to_chat(user, SPAN_WARNING("\The [dock] is currently in use."))
				return TRUE
			SSshuttle.moveShuttle(shuttle.id, dock.id, TRUE)
			to_chat(user, SPAN_NOTICE("你启动了前往[dock]的发射程序。"))
			if(shuttle.faction == FACTION_MARINE)
				log_ares_flight(user.name, "Launched Dropship [shuttle.name] on a flight to [dock].")
			var/log = "[key_name(user)] launched the dropship [src.shuttleId] on transport."
			msg_admin_niche(log)
			log_interact(user, msg = "[log]")
			stop_playing_launch_announcement_alarm()
			return TRUE
		if("button-push")
			playsound(loc, get_sfx("terminal_button"), KEYBOARD_SOUND_VOLUME, 1)
			return FALSE
		if("door-control")
			if(!shuttle)
				return FALSE
			if(shuttle.mode == SHUTTLE_CALL || shuttle.mode == SHUTTLE_RECALL)
				return TRUE
			var/interaction = params["interaction"]
			var/location = params["location"]
			if(!dropship_control_lost)
				shuttle.control_doors(interaction, location)
			else
				playsound(loc, 'sound/machines/terminal_error.ogg', KEYBOARD_SOUND_VOLUME, 1)
				to_chat(user, SPAN_WARNING("门控系统已被覆盖。请呼叫技术支持。"))
		if("set-automate")
			if(!shuttle)
				return FALSE
			var/almayer_lz = params["hangar_id"]
			var/ground_lz = params["ground_id"]
			var/delay = clamp(params["delay"] SECONDS, DROPSHIP_MIN_AUTO_DELAY, DROPSHIP_MAX_AUTO_DELAY)

			// TODO verify
			if(almayer_lz == ground_lz)
				playsound(loc, 'sound/machines/terminal_error.ogg', KEYBOARD_SOUND_VOLUME, 1)
				return
			var/obj/structure/machinery/computer/shuttle/dropship/flight/root_console = shuttle.getControlConsole()
			if(root_console.dropship_control_lost)
				to_chat(user, SPAN_WARNING("运输机主控系统未接受指令。"))
				playsound(loc, 'sound/machines/terminal_error.ogg', KEYBOARD_SOUND_VOLUME, 1)
				return

			shuttle.automated_hangar_id = almayer_lz
			shuttle.automated_lz_id = ground_lz
			shuttle.automated_delay = delay
			playsound(loc, get_sfx("terminal_button"), KEYBOARD_SOUND_VOLUME, 1)
			if(shuttle.faction == FACTION_MARINE)
				log_ares_flight(user.name, "Enabled autopilot for Dropship [shuttle.name].")
			var/log = "[key_name(user)] has enabled auto pilot on '[shuttle.name]'"
			message_admins(log)
			log_interact(user, msg = "[log]")
			return
		if("disable-automate")
			if(!shuttle)
				return FALSE
			shuttle.automated_hangar_id = null
			shuttle.automated_lz_id = null
			shuttle.automated_delay = null
			playsound(loc, get_sfx("terminal_button"), KEYBOARD_SOUND_VOLUME, 1)
			if(shuttle.faction == FACTION_MARINE)
				log_ares_flight(user.name, "Disabled autopilot for Dropship [shuttle.name].")
			var/log = "[key_name(user)] has disabled auto pilot on '[shuttle.name]'"
			message_admins(log)
			log_interact(user, msg = "[log]")
			return

		if("cancel-flyby")
			if(!shuttle)
				return FALSE
			if(shuttle.in_flyby && shuttle.timer && shuttle.timeLeft(1) >= DROPSHIP_WARMUP_TIME)
				shuttle.setTimer(DROPSHIP_WARMUP_TIME)
		if("play_launch_announcement_alarm")
			if(!shuttle)
				return FALSE
			if (shuttle.mode != SHUTTLE_IDLE && shuttle.mode != SHUTTLE_RECHARGING)
				to_chat(usr, SPAN_WARNING("发射通告警报用于告知人们你即将起飞。"))
				return TRUE
			shuttle.alarm_sound_loop.start()
			shuttle.playing_launch_announcement_alarm = TRUE
			return TRUE
		if ("stop_playing_launch_announcement_alarm")
			if(!shuttle)
				return FALSE
			stop_playing_launch_announcement_alarm()
			return TRUE
		if ("change_shuttle")
			var/new_shuttle = params["new_shuttle"]
			return set_shuttle(new_shuttle)

/obj/structure/machinery/computer/shuttle/dropship/flight/proc/set_shuttle(new_shuttle)
	var/mob/user = usr
	if(!new_shuttle || shuttleId == new_shuttle)
		return FALSE
	var/found = FALSE
	var/list/alternatives = alternative_shuttles()
	for(var/alt_shuttle in alternatives)
		if(alt_shuttle["id"] == new_shuttle)
			found = TRUE
	if(found)
		shuttleId = new_shuttle
		update_static_data(user)
	else
		log_admin("Player [user] attempted to change shuttle illegally.")
	return TRUE

/obj/structure/machinery/computer/shuttle/dropship/flight/proc/stop_playing_launch_announcement_alarm()
	var/obj/docking_port/mobile/marine_dropship/shuttle = SSshuttle.getShuttle(shuttleId)

	shuttle.alarm_sound_loop.stop()
	shuttle.playing_launch_announcement_alarm = FALSE
	return

/obj/structure/machinery/computer/shuttle/dropship/flight/lz1
	icon = 'icons/obj/structures/machinery/computer.dmi'
	icon_state = "shuttle"
	linked_lz = DROPSHIP_LZ1
	is_remote = TRUE
	can_change_shuttle = TRUE

/obj/structure/machinery/computer/shuttle/dropship/flight/lz2
	icon = 'icons/obj/structures/machinery/computer.dmi'
	icon_state = "shuttle"
	linked_lz = DROPSHIP_LZ2
	is_remote = TRUE
	can_change_shuttle = TRUE

/obj/structure/machinery/computer/shuttle/dropship/flight/remote_control
	icon = 'icons/obj/structures/machinery/computer.dmi'
	icon_state = "shuttle"
	is_remote = TRUE
	needs_power = TRUE
	can_change_shuttle = TRUE

/obj/structure/machinery/computer/shuttle/dropship/flight/remote_control/upp
	req_one_access = list(ACCESS_UPP_FLIGHT)
	faction = FACTION_UPP
