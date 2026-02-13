//USCM Provost
/datum/emergency_call/inspection_provost
	name = "巡查 - USCM宪兵司令部 - 需具备陆战队军法知识及宪兵游玩时长。"
	mob_max = 2
	mob_min = 1
	probability = 0
	ert_message = "A Provost investigation has been requested!"

/datum/emergency_call/inspection_provost/New()
	..()
	objectives = "Investigate any issues with ML enforcement on the [MAIN_SHIP_NAME]."

/datum/emergency_call/inspection_provost/remove_nonqualifiers(list/datum/mind/candidates_list)
	var/list/datum/mind/candidates_clean = list()
	for(var/datum/mind/single_candidate in candidates_list)
		if(check_timelock(single_candidate.current?.client, JOB_POLICE, time_required_for_job))
			candidates_clean.Add(single_candidate)
			continue
		if(single_candidate.current)
			to_chat(single_candidate.current, SPAN_WARNING("你未达到紧急响应小组信标资格，因为你的宪兵游玩时长（5小时）不足！"))
	return candidates_clean

/datum/emergency_call/inspection_provost/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/T = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(T))
		return FALSE

	var/mob/living/carbon/human/H = new(T)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, list(JOB_WARDEN, JOB_CHIEF_POLICE), time_required_for_job))
		leader = H
		arm_equipment(H, /datum/equipment_preset/uscm_event/provost/inspector, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是美国殖民地海军陆战队宪兵司令部的巡查官！"))
		to_chat(H, SPAN_ROLE_BODY("你正被派往[MAIN_SHIP_NAME]，调查一起未公开的陆战队军法执行问题。宪兵司令部可能会提供更多细节，但你应该前往禁闭室评估情况。"))
		to_chat(H, SPAN_ROLE_BODY("在你的责任区内，你对陆战队军法的执行拥有最终决定权，但仍需遵守军法。运用此权力拨乱反正，确保正义得到伸张！"))
		to_chat(H, SPAN_WARNING("此角色要求熟悉陆战队军法和标准操作程序。如有任何疑问或希望将此角色转交他人，请使用管理员求助。"))
	else
		arm_equipment(H, /datum/equipment_preset/uscm_event/provost/enforcer, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是美国殖民地海军陆战队宪兵司令部的执法官！"))
		to_chat(H, SPAN_ROLE_BODY("你被指派为即将抵达[MAIN_SHIP_NAME]的视察官提供护卫、助理及部分执法支持。"))
		to_chat(H, SPAN_ROLE_BODY("你无需在舰上执行陆战队军法，但视察官可能要求你履行宪兵职责以协助调查，届时你必须像其他宪兵一样行动。"))
		to_chat(H, SPAN_WARNING("此角色要求熟悉陆战队军法和标准操作程序。如有任何疑问或希望将此角色转交他人，请使用管理员求助。"))
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)


/datum/emergency_call/inspection_provost/spawn_items()
	var/turf/drop_spawn

	drop_spawn = get_spawn_point(TRUE)
	new /obj/item/storage/box/handcuffs(drop_spawn)
	new /obj/item/storage/box/handcuffs(drop_spawn)

//USCM High Command
/datum/emergency_call/inspection_hc
	name = "视察 - USCM最高指挥部"
	mob_max = 2
	mob_min = 1
	probability = 0
	ert_message = "A USCM High Command investigation has been requested!"

/datum/emergency_call/inspection_hc/New()
	..()
	objectives = "Inspect and evaluate the [MAIN_SHIP_NAME] and its crew."

/datum/emergency_call/inspection_hc/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/T = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(T))
		return FALSE

	var/mob/living/carbon/human/H = new(T)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, list(JOB_SO), time_required_for_job))
		leader = H
		arm_equipment(H, /datum/equipment_preset/uscm_ship/so, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是USCM最高指挥部派出的视察官！"))
		to_chat(H, SPAN_ROLE_BODY("在[MAIN_SHIP_NAME]当前任务期间，已安排对其进行视察。最高指挥部可能通过无线电向你传达其他指令。"))
		to_chat(H, SPAN_ROLE_BODY("巡视舰船，监督各部门的组织、效率及标准作业程序合规性，约谈船员并发现问题。将视察结果同时汇报给舰船指挥官及USCM最高指挥部。"))
		to_chat(H, SPAN_WARNING("记住，你的视察不得干扰舰船正常运作，且无权做出与陆战队军法执法相关的决定。如有疑问或希望将角色让给他人，请使用管理员求助。"))
	else
		arm_equipment(H, /datum/equipment_preset/uscm/engineer_equipped, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是USCM最高指挥部派出的视察小组的一员！"))
		to_chat(H, SPAN_ROLE_BODY("在[MAIN_SHIP_NAME]当前任务期间，已安排对其进行视察。你既是执行视察的军官的安保人员，也是其需要专业协助时的助手。"))
		to_chat(H, SPAN_ROLE_BODY("跟随视察官执行舰上职责。如有见解可随时提出，并根据其要求提供协助。记住，虽然你不直接听命于舰上军官，但仍需尊重他们的职位。"))
		to_chat(H, SPAN_WARNING("记住，你不得干扰正常运作，且必须始终服从视察官的命令。如有疑问或希望将角色让给他人，请使用管理员求助。"))
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)

//Weyland-Yutani
/datum/emergency_call/inspection_wy
	name = "视察 - 企业"
	mob_max = 2
	mob_min = 1
	shuttle_id = MOBILE_SHUTTLE_ID_ERT2
	home_base = /datum/lazy_template/ert/weyland_station
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	item_spawn = /obj/effect/landmark/ert_spawns/distress_pmc/item
	max_heavies = 1
	probability = 0
	ert_message = "A Weyland-Yutani investigation has been requested!"

/datum/emergency_call/inspection_wy/New()
	..()
	objectives = "Make sure the crew of the [MAIN_SHIP_NAME] is aware of your presence. Investigate the Corporate Liaison and any other Company assets and make sure they remain loyal to the Company. Make a detailed report back to Dispatch."

/datum/emergency_call/inspection_wy/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/T = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(T))
		return FALSE

	var/mob/living/carbon/human/H = new(T)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, list(JOB_SQUAD_LEADER), time_required_for_job))
		leader = H
		arm_equipment(H, /datum/equipment_preset/pmc/pmc_lead_investigator, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是维兰德-汤谷PMC视察员！"))
		to_chat(H, SPAN_ROLE_BODY("虽然你的团队名义上为维兰德-汤谷执行常规安保工作，但实际上你负责对公司人员的行为进行正式与非正式调查。你被派往[MAIN_SHIP_NAME]，以确保当地联络官未忘记其首要任务，或更糟地试图反咬雇主。"))
		to_chat(H, SPAN_ROLE_BODY("记住舰上的USCM人员可能不欢迎你的到来。若联络官被关押，除非接到调度指令，否则不得以任何形式充当法律顾问。你的基本职责是详细报告涉及联络官及舰上其他维兰德-汤谷人员的一切情况。"))
		to_chat(H, SPAN_WARNING("除非调度另有指令，否则应避免与陆战队员公开冲突。若他们表现出明显敌意，则撤退并提交报告。如有更多疑问或希望将此角色让给其他玩家，请使用管理员求助。"))
	else if(heavies < max_heavies && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_HEAVY) && check_timelock(H.client, JOB_SQUAD_SPECIALIST))
		heavies++
		arm_equipment(H, /datum/equipment_preset/pmc/pmc_riot_control, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是维兰德-汤谷PMC人群控制专家！"))
		to_chat(H, SPAN_ROLE_BODY("虽然你的团队名义上为维兰德-汤谷执行常规安保工作，但实际上你负责对公司人员的行为进行正式与非正式调查。领队调查员负责指挥，你的职责是提供支援、建议及任何其他形式的协助，以确保其任务成功。"))
		to_chat(H, SPAN_ROLE_BODY("记住USCM，或至少其中部分人员，可能对你们在舰上的存在抱有敌意。除非调度另有指令，否则你与你的队长应避免与陆战队员公开冲突。你的首要任务是确保领队能活着完成报告。"))
		to_chat(H, SPAN_WARNING("除非调度另有指令，否则应避免与陆战队员公开冲突。你的优先事项是团队安全，若舰上局势过热，最佳选择是撤离。如有更多疑问或希望将此角色让给其他玩家，请使用管理员求助。"))
	else
		arm_equipment(H, /datum/equipment_preset/pmc/pmc_security, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是维兰德-汤谷PMC调查小组的一员！"))
		to_chat(H, SPAN_ROLE_BODY("虽然你的团队名义上为维兰德-汤谷执行常规安保工作，但实际上你负责对公司人员的行为进行正式与非正式调查。领队调查员负责指挥，你的职责是提供支援、建议及任何其他形式的协助，以确保其任务成功。"))
		to_chat(H, SPAN_ROLE_BODY("记住USCM，或至少其中部分人员，可能对你们在舰上的存在抱有敌意。除非调度另有指令，否则你与你的队长应避免与陆战队员公开冲突。你的首要任务是确保领队能活着完成报告。"))
		to_chat(H, SPAN_WARNING("除非调度另有指令，否则应避免与陆战队员公开冲突。你的优先事项是团队安全，若舰上局势过热，最佳选择是撤离。如有更多疑问或希望将此角色让给其他玩家，请使用管理员求助。"))
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)

/datum/emergency_call/inspection_wy/spawn_items()
	var/turf/drop_spawn

	drop_spawn = get_spawn_point(TRUE)
	new /obj/item/storage/box/handcuffs(drop_spawn)
	new /obj/item/storage/box/handcuffs(drop_spawn)

/datum/emergency_call/inspection_wy/lawyer
	name = "律师 - 企业"
	mob_max = 2
	mob_min = 1
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	item_spawn = /obj/effect/landmark/ert_spawns/distress_pmc/item
	probability = 0
	ert_message = "A corporate lawyer beacon has been activated!"

/datum/emergency_call/inspection_wy/lawyer/New()
	..()
	objectives = "Make sure the crew of the [MAIN_SHIP_NAME] is aware of your presence. Investigate who the Corporate Liaison reported for breaking their contract and any review other Company assets and make sure they remain loyal to the Company. Make a detailed report back to Corporate."

/datum/emergency_call/inspection_wy/lawyer/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/T = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(T))
		return FALSE

	var/mob/living/carbon/human/H = new(T)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, list(JOB_SQUAD_LEADER), time_required_for_job))
		leader = H
		arm_equipment(H, /datum/equipment_preset/wy/exec_supervisor/lawyer, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是维兰德-汤谷首席企业律师！"))
		to_chat(H, SPAN_ROLE_BODY("虽然企业事务部名义上为维兰德-汤谷处理常规文书工作，但实际上你负责对公司及非公司人员的行为进行正式与非正式调查。你被派往[MAIN_SHIP_NAME]，以确保USCM遵守当地联络官提供的已签署合同，且未忘记真正的雇主。"))
		to_chat(H, SPAN_ROLE_BODY("记住舰上的USCM人员可能不欢迎你的到来。若联络官被关押，你必须以法律顾问身份采取行动。你的基本职责是详细报告涉及联络官、其他维兰德-汤谷人员以及舰上任何合同违约行为的一切情况。"))
		to_chat(H, SPAN_WARNING("你应避免与陆战队员发生公开冲突。如果他们表现出明显敌意，立即撤退并报告。如有任何疑问或希望释放此角色供其他玩家使用，请使用管理员求助。"))
	else
		arm_equipment(H, /datum/equipment_preset/wy/exec_spec/lawyer, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是一名维兰德-汤谷公司法务律师！"))
		to_chat(H, SPAN_ROLE_BODY("虽然公司法务部名义上只为维兰德-汤谷处理日常文书工作，但实际上你既是官方也是非官方调查员，负责调查公司及非公司人员的行为。首席律师负责指挥，你的职责是提供法律建议及任何形式的协助，以确保任务成功。"))
		to_chat(H, SPAN_ROLE_BODY("记住，USCM，至少其中一部分人，可能对你出现在舰上抱有敌意。你和首席律师应避免与陆战队员发生公开冲突。你们的首要任务是确保两人都能活下来，撰写公司要求的报告。"))
		to_chat(H, SPAN_WARNING("你应避免与陆战队员发生公开冲突。如果他们表现出明显敌意，立即撤退并报告。如有任何疑问或希望释放此角色供其他玩家使用，请使用管理员求助。"))
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)


// Colonial Marshals - UA Law Enforcement / Investigative Federal Agents which usually watch over Colonies. Also a good option for prisoner transfers, investigating corporate corruption, survivor rescues, or illict trade practices(black market).
/datum/emergency_call/inspection_cmb
	name = "检查 - 殖民地执法官调查组"
	mob_max = 4
	mob_min = 1
	probability = 0
	home_base = /datum/lazy_template/ert/weyland_station
	ert_message = "A Colonial Marshal investigation has been requested!"

	var/max_synths = 1
	var/synths = 0

	var/will_spawn_icc_liaison
	var/icc_liaison

	var/will_spawn_cmb_observer
	var/cmb_observer

/datum/emergency_call/inspection_cmb/New()
	..()
	arrival_message = "[MAIN_SHIP_NAME], this is Anchorpoint Station with the Colonial Marshal Bureau. Be advised, a CMB transport vessel is preparing to board you, submitting Federal docking clearances now. Standby."
	objectives = "Get your instructions from the CMB Office at Anchorpoint Station, and carry out your orders. Ensure that Colonial assets are safe and in your custody. Do not enforce or override Marine Law on a Marine Ship unless requested, as it's outside of your juristiction."

	will_spawn_icc_liaison = prob(90)
	will_spawn_cmb_observer = prob(10)

/datum/emergency_call/inspection_cmb/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("你是殖民地执法官！"))
		arm_equipment(mob, /datum/equipment_preset/cmb/leader, TRUE, TRUE)
	else if(synths < max_synths && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_SYNTH) && mob.client.check_whitelist_status(WHITELIST_SYNTHETIC))
		synths++
		to_chat(mob, SPAN_ROLE_HEADER("你是一名CMB调查用合成人！"))
		arm_equipment(mob, /datum/equipment_preset/cmb/synth, TRUE, TRUE)
	else if(!icc_liaison && will_spawn_icc_liaison && check_timelock(mob.client, JOB_CORPORATE_LIAISON, time_required_for_job))
		icc_liaison = mob
		to_chat(mob, SPAN_ROLE_HEADER("你是隶属于CMB的星际商业委员会联络官！"))
		arm_equipment(mob, /datum/equipment_preset/cmb/liaison, TRUE, TRUE)
	else if(!cmb_observer && will_spawn_cmb_observer)
		cmb_observer = mob
		to_chat(mob, SPAN_ROLE_HEADER("你是一名星际人权观察员！"))
		arm_equipment(mob, /datum/equipment_preset/cmb/observer, TRUE, TRUE)
	else
		to_chat(mob, SPAN_ROLE_HEADER("你是一名CMB副官！"))
		arm_equipment(mob, /datum/equipment_preset/cmb/standard, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)


/datum/emergency_call/inspection_cmb/print_backstory(mob/living/carbon/human/M)
	if(M == leader)
		to_chat(M, SPAN_BOLD("你是殖民地执法官，最初来自[pick(70;"美洲联盟", 20;"太阳系", 10;"边疆殖民地")]。"))
		to_chat(M, SPAN_BOLD("你通过[pick(50;"大学期间追求职业发展", 40;"从事执法工作", 10;"因技能被招募")]的方式加入了执法官队伍。"))
		to_chat(M, SPAN_BOLD("通过在银河系各地职位的晋升，你因坚定不移地致力于正义、打击犯罪和腐败而闻名。"))
		to_chat(M, SPAN_BOLD("作为CMB官员，你拥有执行殖民地及地球法律的星际管辖权，但你不能也不应在一艘海军陆战队舰船上凌驾于《陆战队军法》之上。"))
		to_chat(M, SPAN_BOLD("地球的法律延伸至太阳系之外。当他人受到诱惑而堕入腐败时，你依然坚守着自己的道德准则。"))
		to_chat(M, SPAN_BOLD("公司官员追逐薪水和晋升，但你的动力是履行誓言职责并关心民众，无论殖民地多么偏远或孤立。"))
		to_chat(M, SPAN_BOLD("在尼禄星区任职期间你见识颇多，但你在这里是因为你是最优秀的，正在做正确的事让边疆变得更美好。"))
		to_chat(M, SPAN_BOLD("尽管力量分散，但执法官坚定的誓言仍在持续保障社区安全，CMB深受许多人尊敬。你是这一誓言的体现，请出色地履行职责。"))
	else if(issynth(M))
		to_chat(M, SPAN_BOLD("尽管是较旧的型号，但你因敏锐的感官和警觉性而在同僚中备受好评。"))
		to_chat(M, SPAN_BOLD("除了执法程序，你被编程为定位证据、分析化学品和调查犯罪的绝对专家。"))
		to_chat(M, SPAN_BOLD("你不强制执行也不遵守《陆战队军法》，但你对其有所了解。"))
		to_chat(M, SPAN_BOLD("在太阳系接受软件和法律更新后，你被派驻到锚点空间站，以协助边疆的CMB单位。"))
		to_chat(M, SPAN_BOLD("虽然预计不会发生战斗，但你的背包中携带着小组的轻武器弹药和装备储备，以备不时之需。"))
		to_chat(M, SPAN_BOLD("尽管力量分散，但执法官坚定的誓言仍在持续保障社区安全，CMB深受许多人尊敬。你是这一誓言的体现，请出色地履行职责。"))
	else if(M == icc_liaison)
		to_chat(M, SPAN_BOLD("你是一名星际商务联络官，最初来自[pick(70;"The United Americas", 25;"Sol", 5;"a colony on the frontier")]."))
		to_chat(M, SPAN_BOLD("你是[pick(30; "skeptical", 40;"ambicable", 30;"supportive")] of Weyland-Yutani."))
		to_chat(M, SPAN_BOLD("你的耳机配备了多个频率，包括来自ICC母公司维兰德-汤谷赠送的密钥，旨在激励你的支持。请用它进行通讯。"))
		to_chat(M, SPAN_BOLD("作为派驻锚点站CMB办公室的ICC特工，你的工作是观察并确保公平贸易。根据需要检查和记录货运货物是否存在可疑非法活动。你应与执法官协调，并在必要时向指挥部（最好申请逮捕令）申请以执行逮捕。"))
		to_chat(M, SPAN_BOLD("与这些声誉卓著的人共事让你成为了一个更有德行的人，尤其是与其他重量级组织的公司联络官相比。"))
		to_chat(M, SPAN_BOLD("与殖民地执法官合作进行调查，如果你怀疑存在走私或非法贸易，请向指挥部报告。"))
	else if(M == cmb_observer)
		to_chat(M, SPAN_BOLD("你是一名星际人权观察员，最初来自[pick(50;"The United Americas", 10;"Europe", 10;"Luna", 20;"Sol", 10;"a colony on the frontier")]."))
		to_chat(M, SPAN_BOLD("你是[pick(60; "skeptical", 40;"ambicable", 10;"supportive")] of Weyland-Yutani and their practices."))
		to_chat(M, SPAN_BOLD("你是[pick(40; "skeptical", 30;"ambicable", 30;"supportive")] with the USCM's actions on the frontier."))
		to_chat(M, SPAN_BOLD("通过大量艰苦的工作，你的组织成功说服了殖民地执法官带你去前线，撰写一篇关于当地生活质量的报道。"))
		to_chat(M, SPAN_BOLD("观察联邦探员的行动，并留意任何来自他人的不人道行为。尼罗伊德星区各方都充斥着暴行。"))
		to_chat(M, SPAN_BOLD("不要煽动或挑起任何对抗。你是一名观察员，不参与战争。仅在医疗紧急情况下进行干预。"))
	else
		to_chat(M, SPAN_BOLD("你是一名CMB副手，最初来自[pick(70;"美洲联盟", 20;"太阳系", 10;"边疆殖民地")]。"))
		to_chat(M, SPAN_BOLD("你通过[pick(50;"大学期间追求职业发展", 40;"从事执法工作", 10;"因技能被招募")]的方式加入了执法官队伍。"))
		to_chat(M, SPAN_BOLD("在你的执法官长官带领下，你因坚定不移地致力于正义、打击犯罪和腐败而闻名。"))
		to_chat(M, SPAN_BOLD("作为CMB官员，你拥有执行殖民地及地球法律的星际管辖权，但你不能也不应在一艘海军陆战队舰船上凌驾于《陆战队军法》之上。"))
		to_chat(M, SPAN_BOLD("你已在锚点站驻扎了[pick(80;"several months", 10;"only a week", 10;"years")] investigating henious crimes among the frontier."))
		to_chat(M, SPAN_BOLD("法律之光远播太阳系之外。当他人沉沦于腐败时，你仍坚守道德准则。"))
		to_chat(M, SPAN_BOLD("公司官员追逐薪水和晋升，但你的动力是履行誓言职责并关心民众，无论殖民地多么偏远或孤立。"))
		to_chat(M, SPAN_BOLD("尽管力量分散，但执法官坚定的誓言仍在持续保障社区安全，CMB深受许多人尊敬。你是这一誓言的体现，请出色地履行职责。"))

/datum/emergency_call/inspection_cmb/black_market
	name = "检查 - 殖民地执法官账目调查组"
	mob_max = 3 //Marshal, Deputy, ICC CL
	mob_min = 2
	shuttle_id = MOBILE_SHUTTLE_ID_ERT2

	max_synths = 0
	will_spawn_icc_liaison = TRUE
	will_spawn_cmb_observer = FALSE
	ert_message = "A blackmarket investigation has been requested!"

/datum/emergency_call/inspection_cmb/black_market/New()
	..()
	dispatch_message = "Third Fleet High Command to [MAIN_SHIP_NAME], we have received inconsistent supply manifests and irregularities on the ASRS system aboard your ship, and have requested a CMB Investigation Team to board and clear you of any wrongdoing."
	arrival_message = "Incoming Transmission: [MAIN_SHIP_NAME], this is Anchorpoint Station with the Colonial Marshal Bureau. Be advised, we are dispatching a team of Marshals to board with you by request of GSO-91. Submitting authorized docking clearances, over."
	objectives = "Investigate the inconsistencies aboard the [MAIN_SHIP_NAME]'s ASRS. In the case of illegal activity, collect evidence, and submit a report to the CMB Command at Anchorpoint Station. If required, the ICC Liaison's Tradeband is capable of fixing ASRS computers. Work with the [MAIN_SHIP_NAME]'s military police force."

/datum/emergency_call/inspection_cmb/black_market/create_member(datum/mind/current_mind, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	current_mind.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("你是殖民地执法官！"))
		arm_equipment(mob, /datum/equipment_preset/cmb/leader, TRUE, TRUE)
	else if(!icc_liaison && will_spawn_icc_liaison && check_timelock(mob.client, JOB_CORPORATE_LIAISON, time_required_for_job))
		icc_liaison = mob
		to_chat(mob, SPAN_ROLE_HEADER("你是隶属于CMB的星际商业委员会联络官！"))
		arm_equipment(mob, /datum/equipment_preset/cmb/liaison/black_market, TRUE, TRUE) //ICC CL gets a custom item
	else
		to_chat(mob, SPAN_ROLE_HEADER("你是一名CMB副官！"))
		arm_equipment(mob, /datum/equipment_preset/cmb/standard, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)
