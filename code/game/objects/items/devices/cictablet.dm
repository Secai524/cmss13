/obj/item/device/cotablet
	icon = 'icons/obj/items/devices.dmi'
	name = "指挥平板"
	desc = "一种高级军官使用的便携式指挥界面，能够向其连接的计算机远程下达指令。其坚固程度足以承受核弹冲击。"
	suffix = "\[3\]"
	icon_state = "Cotablet"
	item_state = "Cotablet"
	unacidable = TRUE
	explo_proof = TRUE
	req_access = list(ACCESS_MARINE_SENIOR)
	var/on = TRUE // 0 for off
	var/cooldown_between_messages = COOLDOWN_COMM_MESSAGE

	var/tablet_name = "指挥官's Tablet"

	var/announcement_title = COMMAND_ANNOUNCE
	var/announcement_faction = FACTION_MARINE
	var/add_pmcs = FALSE

	///flags that we want to be shown when you interact with this table
	var/minimap_flag = MINIMAP_FLAG_USCM

	COOLDOWN_DECLARE(announcement_cooldown)
	COOLDOWN_DECLARE(distress_cooldown)

/obj/item/device/cotablet/Initialize()
	if(SSticker.mode && MODE_HAS_FLAG(MODE_FACTION_CLASH))
		add_pmcs = FALSE
	else if(SSticker.current_state < GAME_STATE_PLAYING)
		RegisterSignal(SSdcs, COMSIG_GLOB_MODE_PRESETUP, PROC_REF(disable_pmc))
	AddComponent(/datum/component/tacmap, has_drawing_tools=TRUE, minimap_flag=minimap_flag, has_update=TRUE)
	return ..()

/obj/item/device/cotablet/proc/disable_pmc()
	if(MODE_HAS_FLAG(MODE_FACTION_CLASH))
		add_pmcs = FALSE
	UnregisterSignal(SSdcs, COMSIG_GLOB_MODE_PRESETUP)

/obj/item/device/cotablet/attack_self(mob/living/carbon/human/user as mob)
	..()

	var/obj/item/card/id/card = user.get_idcard()
	if(allowed(user) && card?.check_biometrics(user))
		tgui_interact(user)
	else
		to_chat(user, SPAN_DANGER("权限被拒绝。"))

/obj/item/device/cotablet/ui_close(mob/user)
	var/datum/component/tacmap/tacmap_component = GetComponent(/datum/component/tacmap)
	tacmap_component.on_unset_interaction(user)
	tacmap_component.close_popout_tacmaps(user)

/obj/item/device/cotablet/ui_static_data(mob/user)
	var/list/data = list()

	data["faction"] = announcement_faction
	data["cooldown_message"] = cooldown_between_messages
	data["distresstimelock"] = DISTRESS_TIME_LOCK

	return data

/obj/item/device/cotablet/ui_data(mob/user)
	var/list/data = list()

	data["alert_level"] = GLOB.security_level
	data["evac_status"] = SShijack.evac_status
	data["endtime"] = announcement_cooldown
	data["distresstime"] = distress_cooldown
	data["worldtime"] = world.time

	return data

/obj/item/device/cotablet/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	if(!allowed(user))
		return UI_UPDATE
	if(!on)
		return UI_DISABLED

/obj/item/device/cotablet/ui_state(mob/user)
	return GLOB.not_incapacitated_and_inventory_state

/obj/item/device/cotablet/tgui_interact(mob/user, datum/tgui/ui, datum/ui_state/state)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CommandTablet", "Command Tablet")
		ui.open()

/obj/item/device/cotablet/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	var/mob/user = ui.user
	switch(action)
		if("announce")
			if(user.client.prefs.muted & MUTE_IC)
				to_chat(user, SPAN_DANGER("你无法发送公告（已被禁言）。"))
				return

			if(!COOLDOWN_FINISHED(src, announcement_cooldown))
				to_chat(user, SPAN_WARNING("请等待[COOLDOWN_TIMELEFT(src, announcement_cooldown)/10]秒再进行下一次广播。"))
				return FALSE

			var/input = stripped_multiline_input(user, "请输入一条消息，向[MAIN_SHIP_NAME]全体舰员及所有地面人员广播。", "Priority Announcement", "")
			if(!input || !COOLDOWN_FINISHED(src, announcement_cooldown) || !(user in dview(1, src)))
				return FALSE

			var/signed = null
			if(ishuman(user))
				var/mob/living/carbon/human/human_user = user
				var/obj/item/card/id/id = human_user.get_idcard()
				if(id)
					var/paygrade = get_paygrades(id.paygrade, FALSE, human_user.gender)
					signed = "[paygrade] [id.registered_name]"

			marine_announcement(input, announcement_title, faction_to_display = announcement_faction, add_PMCs = add_pmcs, signature = signed)
			message_admins("[key_name(user)] has made a command announcement.")
			log_announcement("[key_name(user)] has announced the following: [input]")
			COOLDOWN_START(src, announcement_cooldown, cooldown_between_messages)
			. = TRUE

		if("award")
			if(announcement_faction != FACTION_MARINE)
				return
			open_medal_panel(user, src)
			. = TRUE

		if("mapview")
			var/datum/component/tacmap/tacmap_component = GetComponent(/datum/component/tacmap)

			if(user in tacmap_component.interactees)
				tacmap_component.on_unset_interaction(user)
			else
				tacmap_component.show_tacmap(user)
			. = TRUE

		if("evacuation_start")
			if(announcement_faction != FACTION_MARINE)
				return

			if(GLOB.security_level < SEC_LEVEL_RED)
				to_chat(user, SPAN_WARNING("舰船必须处于红色警报状态才能启动撤离程序。"))
				return FALSE

			if(SShijack.evac_admin_denied)
				to_chat(user, SPAN_WARNING("USCM已锁定逃生舱的部署。"))
				return FALSE

			if(!SShijack.initiate_evacuation())
				to_chat(user, SPAN_WARNING("你现在无法启动撤离程序！"))
				return FALSE

			log_game("[key_name(user)] has called for an emergency evacuation.")
			message_admins("[key_name_admin(user)] has called for an emergency evacuation.")
			log_ares_security("Initiate Evacuation", "Called for an emergency evacuation.", user)
			. = TRUE

		if("distress")
			if(!SSticker.mode)
				return FALSE //Not a game mode?

			if(GLOB.security_level == SEC_LEVEL_DELTA)
				to_chat(user, SPAN_WARNING("舰船已启动自毁程序！"))
				return FALSE

			for(var/client/C in GLOB.admins)
				if((R_ADMIN|R_MOD) & C.admin_holder.rights)
					playsound_client(C,'sound/effects/sos-morse-code.ogg',10)
			SSticker.mode.request_ert(user)
			to_chat(user, SPAN_NOTICE("已向USCM中央司令部发送求救信标请求。"))
			COOLDOWN_START(src, distress_cooldown, COOLDOWN_COMM_REQUEST)
			return TRUE

/obj/item/device/cotablet/pmc
	desc = "一种供公司PMC主管使用的特殊设备。"

	tablet_name = "站点主管's Tablet"

	announcement_title = PMC_COMMAND_ANNOUNCE
	announcement_faction = FACTION_PMC
	add_pmcs = TRUE
	minimap_flag = MINIMAP_FLAG_WY

/obj/item/device/cotablet/upp

	desc = "一种供UPP战地指挥官使用的特殊设备。"

	tablet_name = "UPP Field Commander's Tablet"

	announcement_title = UPP_COMMAND_ANNOUNCE
	announcement_faction = FACTION_UPP
	req_access = list(ACCESS_UPP_LEADERSHIP)

	minimap_flag = MINIMAP_FLAG_UPP
