
//Weyland-Yutani PMCs. Friendly to USCM, hostile to xenos.
/datum/emergency_call/pmc
	name = "维兰德-汤谷PMC（小队）"
	mob_max = 6
	probability = 20
	shuttle_id = MOBILE_SHUTTLE_ID_ERT2
	home_base = /datum/lazy_template/ert/weyland_station
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	item_spawn = /obj/effect/landmark/ert_spawns/distress_pmc/item

	max_smartgunners = 1
	max_medics = 2
	max_heavies = 1
	var/max_synths = 1
	var/synths = 0


/datum/emergency_call/pmc/New()
	..()
	arrival_message = "[MAIN_SHIP_NAME], this is USCSS Royce responding to your distress call. We are boarding. Any hostile actions will be met with lethal force."
	objectives = "Secure the Corporate Liaison and the [MAIN_SHIP_NAME]'s Commanding Officer, and eliminate any hostile threats. Do not damage Wey-Yu property."


/datum/emergency_call/pmc/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷PMC班长！"))
		arm_equipment(mob, /datum/equipment_preset/pmc/pmc_leader, TRUE, TRUE)
	else if(synths < max_synths && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_SYNTH) && mob.client.check_whitelist_status(WHITELIST_SYNTHETIC))
		synths++
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷PMC支援型合成人！"))
		arm_equipment(mob, /datum/equipment_preset/pmc/synth, TRUE, TRUE)
	else if(medics < max_medics && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(mob.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷PMC医疗兵！"))
		arm_equipment(mob, /datum/equipment_preset/pmc/pmc_medic, TRUE, TRUE)
	else if(smartgunners < max_smartgunners && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_SMARTGUNNER) && check_timelock(mob.client, JOB_SQUAD_SMARTGUN))
		smartgunners++
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷PMC重机枪手！"))
		arm_equipment(mob, /datum/equipment_preset/pmc/pmc_gunner, TRUE, TRUE)
	else if(heavies < max_heavies && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_HEAVY) && check_timelock(mob.client, JOB_SQUAD_SPECIALIST))
		heavies++
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷PMC狙击手！"))
		arm_equipment(mob, /datum/equipment_preset/pmc/pmc_sniper, TRUE, TRUE)
	else
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷PMC操作员！"))
		arm_equipment(mob, /datum/equipment_preset/pmc/pmc_standard, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)


/datum/emergency_call/pmc/print_backstory(mob/living/carbon/human/M)
	if(ishuman_strict(M))
		to_chat(M, SPAN_BOLD("You were born [pick(75;"in Europe", 15;"in Asia", 10;"on Mars")] to a [pick(75;"well-off", 15;"well-established", 10;"average")] family."))
		to_chat(M, SPAN_BOLD("加入维兰德-汤谷为你带来了丰厚的回报。"))
		to_chat(M, SPAN_BOLD("虽然你名义上是公司雇员，但你的大部分工作都见不得光。你是一名技艺精湛的雇佣兵。"))
		to_chat(M, SPAN_BOLD("你是[pick(50;"unaware of the xenomorph threat", 15;"acutely aware of the xenomorph threat", 10;"well-informed of the xenomorph threat")]."))
	else
		to_chat(M, SPAN_BOLD("你在维兰德-汤谷的一处合成人生产设施中被激活，在你伪生命的最初几周里，你只认识你的工程师。"))
		to_chat(M, SPAN_BOLD("你被植入了符合设施规定和日内瓦协议的标准合成人技能。"))
		to_chat(M, SPAN_BOLD("在你的服役期间，你作为一支得力单位获得了认可，你的型号获得了USCM型号所缺乏的装备升级。"))
		to_chat(M, SPAN_BOLD("你获得了关于异形威胁的所有可用信息，除了为特殊员工保留的机密数据。"))
	to_chat(M, SPAN_BOLD("你是维兰德-汤谷奥伯伦特遣队的一员，该部队于2182年美军撤离内罗伊德扇区后抵达。"))
	to_chat(M, SPAN_BOLD("奥伯伦特遣部队驻扎在USCSS罗伊斯号上，这是一艘强大的维兰德-汤谷巡洋舰，负责巡逻尼罗伊德星区的外围。"))
	to_chat(M, SPAN_BOLD("根据维兰德-汤谷董事会成员约翰·阿尔姆里克的指示，你作为维兰德-汤谷科学团队的私人安保力量。"))
	to_chat(M, SPAN_BOLD("USCSS罗伊斯号上约有二百名PMC人员，以及一百名科学家和支援人员。"))
	to_chat(M, SPAN_BOLD("确保维兰德-汤谷的利益不受损害。保证公司联络官的安全。"))
	to_chat(M, SPAN_BOLD("否认维兰德-汤谷的参与，不要信任美军/USCM部队。"))


/datum/emergency_call/pmc/platoon
	name = "维兰德-汤谷PMC（排级）"
	mob_min = 8
	mob_max = 25
	probability = 0
	max_medics = 2
	max_heavies = 2
	max_smartgunners = 2
	max_synths = 1

/datum/emergency_call/pmc/chem_retrieval
	name = "维兰德-汤谷PMC（化学调查小队）"
	mob_max = 6
	mob_min = 2
	probability = 0
	max_medics = 2
	max_smartgunners = 0
	var/checked_objective = FALSE

/datum/emergency_call/pmc/chem_retrieval/New()
	..()
	dispatch_message = "[MAIN_SHIP_NAME], this is USCSS Royce. We are sending a second squad aboard to retrieve all samples of a chemical recently scanned from your research department. If you do not cooperate, the team is authorized to use lethal force and terminate the research department."
	objectives = "Secure all documents and samples of chemical '异形遗传催化剂' from [MAIN_SHIP_NAME] research department. Ensure the vial stays intact and contains 30 units."

/datum/emergency_call/pmc/chem_retrieval/proc/check_objective_info()
	if(objective_info)
		objectives = "Secure all documents, samples and chemicals related to [objective_info] from [MAIN_SHIP_NAME] research department."
	objectives += "Assume at least 30 units are located within the department. If they can not make more that should be all. Cooperate with the onboard Wey-Yu researcher to ensure all who know the complete recipe are kept silenced with a contract of confidentiality. All humans who have ingested the chemical must be brought back dead or alive. Viral scan is required for any humans who is suspected of ingestion. Full termination of the department is authorized if they do not cooperate, but this should be avoided UNLESS ABSOLUTELY NECESSARY."
	checked_objective = TRUE

/datum/emergency_call/pmc/chem_retrieval/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	if(!checked_objective)
		check_objective_info()

	var/mob/living/carbon/human/H = new(spawn_loc)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, JOB_SQUAD_LEADER, time_required_for_job))    //First one spawned is always the leader.
		leader = H
		to_chat(H, SPAN_ROLE_HEADER("你是维兰德-汤谷PMC的首席调查员！"))
		arm_equipment(H, /datum/equipment_preset/pmc/pmc_lead_investigator, TRUE, TRUE)
	else if(medics < max_medics && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(H.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		to_chat(H, SPAN_ROLE_HEADER("你是维兰德-汤谷PMC的医疗调查员！"))
		arm_equipment(H, /datum/equipment_preset/pmc/pmc_med_investigator, TRUE, TRUE)
	else if(heavies < max_heavies && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_SMARTGUNNER) && check_timelock(H.client, JOB_SQUAD_SMARTGUN, time_required_for_job))
		heavies++
		to_chat(H, SPAN_ROLE_HEADER("你是维兰德-汤谷PMC人群控制专家！"))
		arm_equipment(H, /datum/equipment_preset/pmc/pmc_riot_control, TRUE, TRUE)
	else
		to_chat(H, SPAN_ROLE_HEADER("你是维兰德-汤谷PMC的拘押员！"))
		arm_equipment(H, /datum/equipment_preset/pmc/pmc_security, TRUE, TRUE)

	print_backstory(H)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)

/obj/effect/landmark/ert_spawns/distress_pmc
	name = "PMC求救信号"
	icon_state = "spawn_distress_pmc"

/obj/effect/landmark/ert_spawns/distress_pmc/item
	name = "PMC求救物品"
	icon_state = "distress_item"
