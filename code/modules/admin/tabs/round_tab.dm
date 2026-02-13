/client/proc/adjust_predator_round()
	set name = "Adjust Predator Slots"
	set desc = "Adjust the slot modifier for predators."
	set category = "Server.Round"

	if(!admin_holder)
		return

	if(!SSticker?.mode)
		to_chat(src, SPAN_WARNING("游戏尚未开始！"))
		return

	var/cur_extra = SSticker.mode.pred_count_modifier
	var/cur_count = SSticker.mode.pred_current_num
	var/cur_max = SSticker.mode.calculate_pred_max()
	var/real_count = length(SSticker.mode.predators)
	var/possible_min = min(cur_count - cur_max, cur_extra)
	var/value = tgui_input_number(src, "允许多少额外铁血战士加入？当前铁血战士数量：[cur_count]/[cur_max]（实际：[real_count]）当前设置：[cur_extra]", "Input:", default = cur_extra, min_value = possible_min, integer_only = TRUE)

	if(isnull(value))
		return

	if(value == cur_extra)
		return

	cur_count = SSticker.mode.pred_current_num // values could have changed since asking
	cur_max = SSticker.mode.calculate_pred_max()
	possible_min = min(cur_count - cur_max, cur_extra)

	// If we are reducing the count and that exceeds how much we could reduce it by
	if(value < possible_min)
		to_chat(src, SPAN_NOTICE("操作中止。设置的数量不能导致最大人数低于当前铁血战士数量。（当前：[cur_count]/[cur_max]，当前额外：[cur_extra]，尝试设置：[value]）"))
		return

	SSticker.mode.pred_count_modifier = value
	message_admins("[key_name_admin(usr)] adjusted the additional pred amount from [cur_extra] to [value].")

/datum/admins/proc/force_predator_round()
	set name = "Toggle Predator Round"
	set desc = "Force-toggle a predator round for the round type. Only works on maps that support Predator spawns."
	set category = "Server.Round"

	// note: This is a proof of concept. ideally, scenario parameters should all be changeable in the same UI, rather than writing snowflake code everywhere like this
	if(!SSticker || SSticker.current_state < GAME_STATE_PLAYING || !SSticker.mode)
		var/enabled = FALSE
		if(SSnightmare.get_scenario_value("predator_round"))
			enabled = TRUE
		var/ret = tgui_alert(usr, "Are you sure you want to force-toggle a predator round? Nightmare Scenario has the upcoming round as a [(enabled ? "PREDATOR" : "NORMAL")] round.", "Toggle Predator Round", list("Yes", "No"))
		if(ret == "Yes")
			SSnightmare.set_scenario_value("predator_round", !enabled)
			message_admins("[key_name_admin(usr)] has [!enabled ? "allowed predators to spawn" : "prevented predators from spawning"].")
		return

	var/datum/game_mode/predator_round = SSticker.mode
	if(tgui_alert(usr, "Are you sure you want to force-toggle a predator round? Predators are currently [(predator_round.flags_round_type & MODE_PREDATOR) ? "ENABLED" : "DISABLED"].", "Toggle Predator Round", list("Yes", "No")) != "Yes")
		return

	if(!(predator_round.flags_round_type & MODE_PREDATOR))
		var/datum/job/pred_job = GLOB.RoleAuthority.roles_for_mode[JOB_PREDATOR]
		if(istype(pred_job) && !pred_job.spawn_positions)
			pred_job.set_spawn_positions(GLOB.players_preassigned)
		predator_round.flags_round_type |= MODE_PREDATOR
		REDIS_PUBLISH("byond.round", "type" = "predator-round", "map" = SSmapping.configs[GROUND_MAP].map_name)
	else
		predator_round.flags_round_type &= ~MODE_PREDATOR

	message_admins("[key_name_admin(usr)] has [(predator_round.flags_round_type & MODE_PREDATOR) ? "allowed predators to spawn" : "prevented predators from spawning"].")
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_PREDATOR_ROUND_TOGGLED)

/client/proc/free_slot()
	set name = "Free Job Slots"
	set category = "Server.Round"

	if(!admin_holder)
		return

	var/roles[] = new
	var/i
	var/datum/job/J
	for(i in GLOB.RoleAuthority.roles_for_mode) //All the roles in the game.
		J = GLOB.RoleAuthority.roles_for_mode[i]
		if(J.total_positions > 0 && J.current_positions > 0)
			roles += i

	to_chat(usr, SPAN_BOLDNOTICE("没有任何职位被占用。"))
	var/role = input("This list contains all roles that have at least one slot taken.\nPlease select role slot to free.", "空闲职位")  as null|anything in roles
	if(!role)
		return
	GLOB.RoleAuthority.free_role_admin(GLOB.RoleAuthority.roles_for_mode[role], TRUE, src)

/client/proc/modify_slot()
	set name = "Adjust Job Slots"
	set category = "Server.Round"

	if(!admin_holder)
		return

	var/roles[] = new
	var/datum/job/J

	var/active_role_names = GLOB.gamemode_roles[GLOB.master_mode]
	if(!active_role_names)
		active_role_names = GLOB.ROLES_DISTRESS_SIGNAL

	for(var/role_name as anything in active_role_names)
		var/datum/job/job = GLOB.RoleAuthority.roles_by_name[role_name]
		if(!job)
			continue
		roles += role_name

	var/role = input("Please select role slot to modify", "修改职位数量")  as null|anything in roles
	if(!role)
		return
	J = GLOB.RoleAuthority.roles_by_name[role]
	var/tpos = J.spawn_positions
	var/num = tgui_input_number(src, "职位[J.title]应有多少个名额？\n当前已占用名额：[J.current_positions]\n本轮已开放的总名额：[J.total_positions_so_far]","数字：", tpos)
	if(isnull(num))
		return
	if(!GLOB.RoleAuthority.modify_role(J, num))
		to_chat(usr, SPAN_BOLDNOTICE("无法将职位名额设置为少于当前登录人数或低于最低限额。请先释放名额。"))
	message_admins("[key_name(usr)] adjusted job slots of [J.title] to be [num].")

/client/proc/check_antagonists()
	set name = "Check Antagonists"
	set category = "Server.Round"
	if(admin_holder)
		admin_holder.check_antagonists()
		log_admin("[key_name(usr)] checked antagonists.")
	return

/client/proc/check_round_status()
	set name = "Round Status"
	set category = "Server.Round"
	if(admin_holder)
		admin_holder.check_round_status()
		log_admin("[key_name(usr)] checked round status.")
	return

/datum/admins/proc/end_round()
	set name = "End Round"
	set desc = "Immediately ends the round, be very careful."
	set category = "Server.Round"

	if(!check_rights(R_SERVER) || !SSticker.mode)
		return

	// trying to end the round before it even starts. bruh
	if(!SSticker.mode)
		return

	if(tgui_alert(usr, "你确定要结束本回合吗？", "End Round", list("Yes", "No"), 0) != "Yes")
		return

	var/winstate = tgui_input_list(usr, "你希望回合结束状态是什么？", "End Round", list("Custom", "Admin Intervention", MODE_INFESTATION_X_MAJOR, MODE_INFESTATION_X_MINOR, MODE_INFESTATION_M_MAJOR, MODE_INFESTATION_M_MINOR, MODE_INFESTATION_DRAW_DEATH, MODE_FACTION_CLASH_UPP_MAJOR, MODE_FACTION_CLASH_UPP_MINOR, MODE_INFECTION_ZOMBIE_WIN, MODE_GENERIC_DRAW_NUKE, MODE_BATTLEFIELD_W_MAJOR, MODE_BATTLEFIELD_W_MINOR, MODE_BATTLEFIELD_DRAW_STALEMATE, MODE_BATTLEFIELD_DRAW_DEATH))

	if(winstate == "Custom")
		winstate = tgui_input_text(usr, "请输入自定义的回合结束状态。", "End Round", timeout = 0)
	if(!winstate)
		return

	SSticker.force_ending = TRUE
	SSticker.mode.round_finished = winstate

	log_admin("[key_name(usr)] has made the round end early - [winstate].")
	message_admins("[key_name(usr)] has made the round end early - [winstate].")
	for(var/client/C in GLOB.admins)
		to_chat(C, {"
		<hr>
		[SPAN_CENTERBOLD("Staff-Only Alert: <EM>[usr.key]</EM> has made the round end early - [winstate]")]
		<hr>
		"})
	return

/datum/admins/proc/delay()
	set name = "Delay Round Start/End"
	set desc = "Delay the game start/end."
	set category = "Server.Round"

	if(!check_rights(R_SERVER))
		return
	if(SSticker.current_state != GAME_STATE_PREGAME)
		if(SSticker.delay_end)
			if(tgui_alert(usr, "回合结束延迟已启用，你确定要禁用它吗？", "确认", list("Yes", "No"), 30 SECONDS) != "Yes")
				return
		SSticker.delay_end = !SSticker.delay_end
		message_admins("[SPAN_NOTICE("[key_name(usr)] [SSticker.delay_end ? "delayed the round end" : "has made the round end normally"].")]")
		for(var/client/C in GLOB.admins)
			to_chat(C, {"<hr>
			[SPAN_CENTERBOLD("Staff-Only Alert: <EM>[usr.key]</EM> [SSticker.delay_end ? "delayed the round end" : "has made the round end normally"]")]
			<hr>"})
		return
	else
		SSticker.delay_start = !SSticker.delay_start
		message_admins("[SPAN_NOTICE("[key_name(usr)] [SSticker.delay_start ? "delayed the round start" : "has made the round start normally"].")]")
		to_chat(world, SPAN_CENTERBOLD("游戏开始已[SSticker.delay_start ? "delayed" : "continued"]."))
		return

/datum/admins/proc/startnow()
	set name = "Start Round"
	set desc = "Start the round RIGHT NOW"
	set category = "Server.Round"
	var/response = tgui_alert(usr, "你确定要提前开始回合吗？", "Force Start Round", list("Yes", "Bypass Checks", "No"), 30 SECONDS)
	if (response != "Yes" && response != "Bypass Checks")
		return FALSE
	SSticker.bypass_checks = response == "Bypass Checks"
	if (SSticker.current_state == GAME_STATE_STARTUP)
		message_admins("Game is setting up and will launch as soon as it is ready.")
		message_admins(SPAN_ADMINNOTICE("[usr.key] has started the process to start the game when loading is finished."))
		while (SSticker.current_state == GAME_STATE_STARTUP)
			sleep(50) // it patiently waits for the game to be ready here before moving on.
	if (SSticker.current_state == GAME_STATE_PREGAME)
		SSticker.request_start()
		message_admins(SPAN_BLUE("[usr.key] has started the game."))

		return TRUE
	else
		to_chat(usr, "<font color='red'>错误：立即开始：游戏已开始。</font>")
		return FALSE

/client/proc/toggle_cdn()
	set name = "Toggle CDN"
	set category = "Server"
	var/static/admin_disabled_cdn_transport = null
	if(alert(usr, "你确定要切换CDN资源传输吗？", "确认", "Yes", "No") != "Yes")
		return

	var/current_transport = CONFIG_GET(string/asset_transport)
	if(!current_transport || current_transport == "simple")
		if(admin_disabled_cdn_transport)
			CONFIG_SET(string/asset_transport, admin_disabled_cdn_transport)
			admin_disabled_cdn_transport = null
			SSassets.OnConfigLoad()
			message_admins("[key_name_admin(usr)] re-enabled the CDN asset transport")
			log_admin("[key_name(usr)] re-enabled the CDN asset transport")
			return

		to_chat(usr, SPAN_ADMINNOTICE("CDN未启用！"))
		if(alert(usr, "CDN资源传输未启用！如果你遇到资源问题，也可以尝试禁用文件名变异。", "CDN asset transport is not enabled!", "Try disabling filename mutations", "Nevermind") == "Try disabling filename mutations")
			SSassets.transport.dont_mutate_filenames = !SSassets.transport.dont_mutate_filenames
			message_admins("[key_name_admin(usr)] [(SSassets.transport.dont_mutate_filenames ? "disabled" : "re-enabled")] asset filename transforms.")
			log_admin("[key_name(usr)] [(SSassets.transport.dont_mutate_filenames ? "disabled" : "re-enabled")] asset filename transforms.")
		return

	admin_disabled_cdn_transport = current_transport
	CONFIG_SET(string/asset_transport, "simple")
	SSassets.OnConfigLoad()
	SSassets.transport.dont_mutate_filenames = TRUE
	message_admins("[key_name_admin(usr)] disabled CDN asset transport")
	log_admin("[key_name(usr)] disabled CDN asset transport")
