/datum/emergency_call/goon
	name = "维兰德-汤谷公司安保（小队）"
	mob_max = 6
	probability = 0
	shuttle_id = MOBILE_SHUTTLE_ID_ERT2
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	home_base = /datum/lazy_template/ert/weyland_station

/datum/emergency_call/goon/New()
	..()
	arrival_message = "[MAIN_SHIP_NAME], this is a Weyland-Yutani Corporate Security shuttle inbound to your distress beacon. We are coming to help."
	objectives = "Secure the Corporate Liaison and the [MAIN_SHIP_NAME]'s Commanding Officer, and eliminate any hostile threats. Do not damage Wey-Yu property."

/datum/emergency_call/goon/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷公司安保领队！"))
		arm_equipment(mob, /datum/equipment_preset/goon/lead, TRUE, TRUE)
	else
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷公司安保官员！"))
		arm_equipment(mob, /datum/equipment_preset/goon/standard, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)

/datum/emergency_call/goon/print_backstory(mob/living/carbon/human/M)
	to_chat(M, SPAN_BOLD("You were born [pick(75;"in Europe", 15;"in Asia", 10;"on Mars")] to a poor family."))
	to_chat(M, SPAN_BOLD("加入维兰德-汤谷是你唯一能让自己和所爱之人糊口的选择。"))
	to_chat(M, SPAN_BOLD("你完全不知道异形是什么。"))
	to_chat(M, SPAN_BOLD("你是维兰德-汤谷雇佣的普通安保官员，负责守卫他们的前哨站和殖民地。"))
	to_chat(M, SPAN_BOLD("你很久以前就收到了最初的求救信号，但直到现在才获得公司许可进入该区域。"))
	to_chat(M, SPAN_BOLD("确保维兰德-汤谷的利益不受损害。保证公司联络官的安全。"))

/datum/emergency_call/goon/chem_retrieval
	name = "维兰德-汤谷打手（化学调查小队）"
	mob_max = 6
	mob_min = 2
	max_medics = 1
	var/checked_objective = FALSE

/datum/emergency_call/goon/chem_retrieval/New()
	..()
	dispatch_message = "[MAIN_SHIP_NAME], this is USCSS Royce. Our squad is boarding to retrieve all samples of a chemical recently scanned from your research department. You should already have received a significant sum of money for your department's discovery. In return we ask that you cooperate and provide everything related to the chemical to our retrieval team."
	objectives = "Secure all documents and samples of chemical '异形遗传催化剂' from [MAIN_SHIP_NAME] research department. Ensure the vial stays intact, contains 30 units and return them to Response Team Station."

/datum/emergency_call/goon/chem_retrieval/proc/check_objective_info()
	if(objective_info)
		objectives = "Secure all documents, samples and chemicals related to [objective_info] from [MAIN_SHIP_NAME] research department and return them to Response Team Station."
	objectives += "Assume at least 30 units are located within the department. If they can not make more that should be all. Cooperate with the onboard CL to ensure all who know the complete recipe are kept silenced with a contract of confidentiality. All humans who have ingested the chemical must be brought back dead or alive. Viral scan is required for any humans who is suspected of ingestion. You must not deploy to the colony without explicit permission from PMC Dispatch. The professor may call for PMC back up if things get out of hand."
	checked_objective = TRUE

/datum/emergency_call/goon/chem_retrieval/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷公司安保领队！"))
		arm_equipment(mob, /datum/equipment_preset/goon/lead, TRUE, TRUE)
	else if(medics < max_medics && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(mob.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷公司研究顾问！"))
		arm_equipment(mob, /datum/equipment_preset/goon/researcher, TRUE, TRUE)
	else
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷公司安保官员！"))
		arm_equipment(mob, /datum/equipment_preset/goon/standard, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)

/datum/emergency_call/goon/chem_retrieval/print_backstory(mob/living/carbon/human/backstory_human)
	if(backstory_human.job == JOB_WY_RESEARCHER)
		to_chat(backstory_human, SPAN_BOLD("You were born [pick(75;"in Europe", 15;"in Asia", 10;"on Mars")] to a wealthy family."))
		to_chat(backstory_human, SPAN_BOLD("加入维兰德-汤谷是实现你研究目标的绝佳途径。"))
		to_chat(backstory_human, SPAN_BOLD("你对异形有着非常深入的了解。"))
		to_chat(backstory_human, SPAN_BOLD("你是维兰德-汤谷雇佣的受过良好教育的科学家，负责研究各种非人类生物。"))
		to_chat(backstory_human, SPAN_BOLD("你很久以前就收到了最初的求救信号，但直到现在才获得公司许可进入该区域。"))
		to_chat(backstory_human, SPAN_BOLD("你的唯一目标是回收阿尔迈耶号上的化学品。不惜一切代价。"))
	else
		to_chat(backstory_human, SPAN_BOLD("You were born [pick(75;"in Europe", 15;"in Asia", 10;"on Mars")] to a poor family."))
		to_chat(backstory_human, SPAN_BOLD("加入维兰德-汤谷是你唯一能让自己和所爱之人糊口的选择。"))
		to_chat(backstory_human, SPAN_BOLD("你已接受过关于异形的基本简报。"))
		to_chat(backstory_human, SPAN_BOLD("你是维兰德-汤谷雇佣的普通安保官员，负责守卫他们的前哨站和殖民地。"))
		to_chat(backstory_human, SPAN_BOLD("你很久以前就收到了最初的求救信号，但直到现在才获得公司许可进入该区域。"))
		to_chat(backstory_human, SPAN_BOLD("确保维兰德-汤谷的利益不受损害。保证研究员的安全并遵循其指示。"))

/datum/emergency_call/goon/platoon
	name = "维兰德-汤谷公司安保（排）"
	mob_min = 8
	mob_max = 25
	probability = 0
