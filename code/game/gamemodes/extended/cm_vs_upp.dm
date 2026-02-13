/// How long to delay the round completion (command is immediately notified)
#define ROUND_END_DELAY (2 MINUTES)

/datum/game_mode/extended/faction_clash/cm_vs_upp
	name = "阵营冲突 UPP CM"
	config_tag = "阵营冲突 UPP CM"
	flags_round_type = MODE_THUNDERSTORM|MODE_FACTION_CLASH
	starting_round_modifiers = list(
		/datum/gamemode_modifier/blood_optimization,
		/datum/gamemode_modifier/defib_past_armor,
		/datum/gamemode_modifier/disable_combat_cas,
		/datum/gamemode_modifier/disable_ib,
		/datum/gamemode_modifier/disable_ob,
		/datum/gamemode_modifier/disable_attacking_corpses,
		/datum/gamemode_modifier/disable_long_range_sentry,
		/datum/gamemode_modifier/disable_stripdrag_enemy,
		/datum/gamemode_modifier/indestructible_splints,
		/datum/gamemode_modifier/mortar_laser_warning,
		/datum/gamemode_modifier/no_body_c4,
		/datum/gamemode_modifier/heavy_specialists,
		/datum/gamemode_modifier/weaker_explosions_fire,
	)

	taskbar_icon = 'icons/taskbar/gml_hvh.png'
	var/upp_ship = "ssv_rostock.dmm"

/datum/game_mode/extended/faction_clash/cm_vs_upp/pre_setup()
	. = ..()
	GLOB.round_should_check_for_win = FALSE


/datum/game_mode/extended/faction_clash/cm_vs_upp/get_roles_list()
	return GLOB.ROLES_CM_VS_UPP

/datum/game_mode/extended/faction_clash/cm_vs_upp/post_setup()
	. = ..()
	SSweather.force_weather_holder(/datum/weather_ss_map_holder/faction_clash)
	for(var/area/area in GLOB.all_areas)
		if(is_mainship_level(area.z))
			continue
		area.base_lighting_alpha = 150
		area.update_base_lighting()

/datum/game_mode/extended/faction_clash/cm_vs_upp/process()
	if(--round_started > 0)
		return FALSE //Initial countdown, just to be safe, so that everyone has a chance to spawn before we check anything.
	. = ..()
	if(!round_finished)
		if(++round_checkwin >= 5) //Only check win conditions every 5 ticks.
			if(GLOB.round_should_check_for_win)
				check_win()
			round_checkwin = 0


/datum/game_mode/extended/faction_clash/cm_vs_upp/check_win()
	if(SSticker.current_state != GAME_STATE_PLAYING)
		return

	var/upp_left = 0
	var/uscm_left = 0
	var/loss_threshold = 5
	var/list/z_levels = SSmapping.levels_by_any_trait(list(ZTRAIT_GROUND))
	for(var/mob/mob in GLOB.player_list)
		if(mob.z && (mob.z in z_levels) && mob.stat != DEAD && !istype(mob.loc, /turf/open/space))
			if(ishuman(mob) && !isyautja(mob) && !(mob.status_flags & XENO_HOST) && !iszombie(mob))
				var/mob/living/carbon/human/human = mob
				if(!human.handcuffed && !human.resting)
					if(human.faction == FACTION_UPP)
						upp_left ++
					if(human.faction == FACTION_MARINE)
						uscm_left ++
					if(upp_left >= loss_threshold && uscm_left >= loss_threshold)
						return

	if(upp_left < loss_threshold || uscm_left < loss_threshold)
		if(upp_left < loss_threshold)
			round_finished = MODE_INFESTATION_M_MAJOR
		else
			round_finished = MODE_FACTION_CLASH_UPP_MAJOR
		roundend_ceasefire()

		SSticker.roundend_check_paused = TRUE
		addtimer(VARSET_CALLBACK(SSticker, roundend_check_paused, FALSE), ROUND_END_DELAY)


/datum/game_mode/extended/faction_clash/cm_vs_upp/check_finished()
	if(round_finished)
		return TRUE

/datum/game_mode/extended/faction_clash/cm_vs_upp/proc/roundend_ceasefire()
	set_gamemode_modifier(/datum/gamemode_modifier/ceasefire, enabled = TRUE)
	switch(round_finished)
		if(MODE_FACTION_CLASH_UPP_MAJOR)
			marine_announcement("警报：USCM地面部队正处于被击溃状态。自动指挥命令已发布，所有USCM人员被命令撤离战斗区域。\n\n敌对势力已宣布停火，USCM人员被敌方俘获的风险很高，请避免接触并躲避俘获。\n\n最终报告将在两分钟内准备完毕。", "ARES 3.2", 'sound/AI/commandreport.ogg', FACTION_MARINE)
			marine_announcement("警报：敌军已丧失战斗力，敌军正在撤离作战区域。\n\n停火协议现已生效。联盟部队被指示尝试俘获逃离的敌方人员。\n\n最终报告将在两分钟内准备完毕。", "1VAN/3", 'sound/AI/commandreport.ogg', FACTION_UPP)
		if(MODE_FACTION_CLASH_UPP_MINOR)
			marine_announcement("警报：USCM地面部队正处于被击溃状态。自动指挥命令已发布，所有USCM人员被命令撤离战斗区域。\n\n敌对势力已宣布停火，USCM人员被敌方俘获的风险很高，请避免接触并躲避俘获。\n\n最终报告将在两分钟内准备完毕。", "ARES 3.2", 'sound/AI/commandreport.ogg', FACTION_MARINE)
			marine_announcement("警报：敌军已丧失战斗力，敌军正在撤离作战区域。\n\n停火协议现已生效。联盟部队被指示尝试俘获逃离的敌方人员。\n\n最终报告将在两分钟内准备完毕。", "1VAN/3", 'sound/AI/commandreport.ogg', FACTION_UPP)
		if(MODE_INFESTATION_M_MAJOR)
			marine_announcement("警报：敌对势力正在紧急撤离作战区域。高度确信敌军正在从星球撤退。\n\n停火协议现已生效以减少非战斗人员伤亡，地面部队被指示拦截并扣押撤退的敌军。\n\n最终报告将在两分钟内准备完毕。", "ARES 3.2", 'sound/AI/commandreport.ogg', FACTION_MARINE)
			marine_announcement("警报：检测到不可持续的战斗损失。自动战略重新部署命令现已生效。所有联盟作战人员必须返回登陆艇并重新部署至SSV罗斯托克号。\n\n敌军已实施停火，利用这一点协助躲避俘获。\n\n最终报告将在两分钟内准备完毕。", "1VAN/3", 'sound/AI/commandreport.ogg', FACTION_UPP)
		if(MODE_INFESTATION_M_MINOR)
			marine_announcement("警报：敌对势力正在紧急撤离作战区域。高度确信敌军正在从星球撤退。\n\n停火协议现已生效以减少非战斗人员伤亡，地面部队被指示拦截并扣押撤退的敌军。\n\n最终报告将在两分钟内准备完毕。", "ARES 3.2", 'sound/AI/commandreport.ogg', FACTION_MARINE)
			marine_announcement("警报：检测到不可持续的战斗损失。自动战略重新部署命令现已生效。所有联盟作战人员必须返回登陆艇并重新部署至SSV罗斯托克号。\n\n敌军已实施停火，利用这一点协助躲避俘获。\n\n最终报告将在两分钟内准备完毕。", "1VAN/3", 'sound/AI/commandreport.ogg', FACTION_UPP)
		if(MODE_BATTLEFIELD_DRAW_STALEMATE)
			marine_announcement("警报：停火协议现已生效。更多细节待定。所有作战行动必须停止。更多信息将在两分钟内公布。", "ARES 3.2", 'sound/AI/commandreport.ogg', FACTION_MARINE)
			marine_announcement("警报：停火协议现已生效。更多细节待定。所有作战行动必须停止。更多事实将在两分钟内公布。", "1VAN/3", 'sound/AI/commandreport.ogg', FACTION_UPP)


/datum/game_mode/extended/faction_clash/cm_vs_upp/declare_completion()
	announce_ending()
	var/musical_track
	var/end_icon = "draw"
	switch(round_finished)
		if(MODE_FACTION_CLASH_UPP_MAJOR)
			marine_announcement("ALERT: All ground forces killed in action or non-responsive. Landing zone overrun. Impossible to sustain combat operations.\n\nMission Abort Authorized! Commencing automatic vessel deorbit procedure from operations zone.\n\nSaving operational report to archive, commencing final systems scan.", "ARES 3.2", 'sound/AI/commandreport.ogg', FACTION_MARINE)
			marine_announcement("ALERT: Enemy landing zone status. Under Union Military Control. Enemy ground forces. Deceased and/or in Union Military custody.\n\nMission Accomplished! Dispatching subspace signal to Sector Command.\n\nConcluding operational report for dispatch, commencing final data entry and systems scan.", "1VAN/3", 'sound/AI/commandreport.ogg', FACTION_UPP)
			musical_track = pick('sound/theme/lastmanstanding_upp.ogg')
			end_icon = "upp_major"
		if(MODE_FACTION_CLASH_UPP_MINOR)
			marine_announcement("ALERT: All ground forces killed in action or non-responsive. Landing zone overrun. Impossible to sustain combat operations.\n\nMission Abort Authorized! Commencing automatic vessel deorbit procedure from operations zone.\n\nSaving operational report to archive, commencing final systems scan.", "ARES 3.2", 'sound/AI/commandreport.ogg', FACTION_MARINE)
			marine_announcement("ALERT: Enemy landing zone status. Under Union Military Control. Enemy ground forces. Deceased and/or in Union Military custody.\n\nMission Accomplished! Dispatching subspace signal to Sector Command.\n\nConcluding operational report for dispatch, commencing final data entry and systems scan.", "1VAN/3", 'sound/AI/commandreport.ogg', FACTION_UPP)
			musical_track = pick('sound/theme/lastmanstanding_upp.ogg')
			end_icon = "upp_minor"
		if(MODE_INFESTATION_M_MAJOR)
			marine_announcement("ALERT: Opposing Force landing zone under USCM force control. Orbital scans concludes all opposing force combat personnel are combat inoperative.\n\nMission Accomplished!\n\nSaving operational report to archive, commencing final systems.", "ARES 3.2", 'sound/AI/commandreport.ogg', FACTION_MARINE)
			marine_announcement("ALERT: Union landing zone compromised. Union ground forces are non-responsive. Further combat operations impossible.\n\nMission Abort Authorized\n\nConcluding operational report for dispatch, commencing final data entry and systems scan.", "1VAN/3", 'sound/AI/commandreport.ogg', FACTION_UPP)
			musical_track = pick('sound/theme/winning_triumph1.ogg','sound/theme/winning_triumph2.ogg','sound/theme/winning_triumph3.ogg')
			end_icon = "marine_major"
		if(MODE_INFESTATION_M_MINOR)
			marine_announcement("警报：敌方登陆区已处于USCM部队控制之下。轨道扫描确认所有敌方作战人员已丧失战斗力。\n\n任务完成！\n\n正在将行动报告保存至档案，开始最终系统扫描。", "ARES 3.2", 'sound/AI/commandreport.ogg', FACTION_MARINE)
			marine_announcement("警报：联盟登陆区失守。联盟地面部队无响应。无法继续作战行动。\n\n任务中止已授权\n\n正在完成待发送的行动报告，开始最终数据录入和系统扫描。", "1VAN/3", 'sound/AI/commandreport.ogg', FACTION_UPP)
			musical_track = pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg')
			end_icon = "marine_minor"
		if(MODE_BATTLEFIELD_DRAW_STALEMATE)
			marine_announcement("警报：战斗结果无法判定。无法评估战术或战略态势。\n\n正在向最高指挥部发送自动化请求以获取进一步指令。\n\n正在将行动报告保存至档案，开始最终系统扫描。", "ARES 3.2", 'sound/AI/commandreport.ogg', FACTION_MARINE)
			marine_announcement("警报：战局发展未必对联盟有利\n\n正在向战区司令部发送新指令请求。\n\n正在完成待发送的行动报告，开始最终数据录入和系统扫描。", "1VAN/3", 'sound/AI/commandreport.ogg', FACTION_UPP)
			end_icon = "draw"
			musical_track = 'sound/theme/neutral_hopeful2.ogg'
		else
			end_icon = "draw"
			musical_track = 'sound/theme/neutral_hopeful2.ogg'
	var/sound/theme = sound(musical_track, channel = SOUND_CHANNEL_LOBBY)
	theme.status = SOUND_STREAM
	sound_to(world, theme)

	calculate_end_statistics()
	show_end_statistics(end_icon)

	declare_completion_announce_fallen_soldiers()
	declare_completion_announce_predators()
	declare_completion_announce_medal_awards()
	declare_fun_facts()

	return TRUE

/datum/game_mode/extended/faction_clash/cm_vs_upp/ds_first_landed(obj/docking_port/stationary/marine_dropship)
	if(round_started > 0) //we enter here on shipspawn but do not want this
		return
	.=..()
	marine_announcement("首批部队已在殖民地登陆！五分钟停火生效，以便平民撤离。", "ARES 3.2", 'sound/AI/commandreport.ogg', FACTION_MARINE)
	marine_announcement("首批部队已在殖民地登陆！五分钟停火生效，以便平民撤离。", "1VAN/3", 'sound/AI/commandreport.ogg', FACTION_UPP)
	set_gamemode_modifier(/datum/gamemode_modifier/ceasefire, enabled = TRUE)
	addtimer(CALLBACK(src,PROC_REF(ceasefire_warning)), 4 MINUTES)
	addtimer(CALLBACK(src,PROC_REF(ceasefire_end)), 5 MINUTES)
	addtimer(VARSET_CALLBACK(GLOB, round_should_check_for_win, TRUE), 15 MINUTES)

/datum/game_mode/extended/faction_clash/cm_vs_upp/proc/ceasefire_warning()
	marine_announcement("停火一分钟后结束。", "ARES 3.2", 'sound/AI/commandreport.ogg', FACTION_MARINE)
	marine_announcement("停火一分钟后结束。", "1VAN/3", 'sound/AI/commandreport.ogg', FACTION_UPP)

/datum/game_mode/extended/faction_clash/cm_vs_upp/proc/ceasefire_end()
	marine_announcement("停火结束。可以开始作战行动。", "ARES 3.2", 'sound/AI/commandreport.ogg', FACTION_MARINE)
	marine_announcement("停火结束。可以开始作战行动。", "1VAN/3", 'sound/AI/commandreport.ogg', FACTION_UPP)
	set_gamemode_modifier(/datum/gamemode_modifier/ceasefire, enabled = FALSE)
	GLOB.round_should_check_for_win = TRUE



/datum/game_mode/extended/faction_clash/cm_vs_upp/announce()
	. = ..()
	addtimer(CALLBACK(src,PROC_REF(deleyed_announce)), 10 SECONDS)

/datum/game_mode/extended/faction_clash/cm_vs_upp/proc/deleyed_announce()
	marine_announcement("已收到来自当地殖民地的自动化求救信号。\n\n警报！传感器探测到一艘进步人民联盟的战舰在殖民地轨道上。敌舰已拒绝自动化呼叫，并正在进入低行星轨道。敌舰极有可能准备向当地殖民地部署运输机。已授权拦截并将敌对势力从盟军领土驱逐。正在自动化解冻冷冻舱内的陆战队员储备。", "ARES 3.2", 'sound/AI/commandreport.ogg', FACTION_MARINE)
	marine_announcement("警报！传感器探测到一艘逼近的USCM舰船，其航线正拦截当地殖民地。\n\n情报表明这是[MAIN_SHIP_NAME]。USCM部队极有可能在此区域采取有悖于联盟利益的行动。已授权部署地面部队，以阻挠外国势力企图侵犯联盟利益的行为。正在紧急唤醒冷冻舱内的部队储备。", "1VAN/3", 'sound/AI/commandreport.ogg', FACTION_UPP)


#undef ROUND_END_DELAY
