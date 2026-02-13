// The Colonial Marshal Bureau, a UA Federal investigative/law enforcement functionary from Sol which oversees many colonies among the frontier. They are friendly to USCM.
/datum/emergency_call/cmb
	name = "CMB - 殖民地执法官巡逻队（友好）"
	mob_max = 5
	probability = 10
	home_base = /datum/lazy_template/ert/weyland_station

	var/max_synths = 1
	var/synths = 0

	var/will_spawn_icc_liaison
	var/icc_liaison

	var/will_spawn_cmb_observer
	var/cmb_observer


/datum/emergency_call/cmb/New()
	..()
	arrival_message = "Incoming Transmission: [MAIN_SHIP_NAME], this is Anchorpoint Station with the Colonial Marshal Bureau. We are receiving your distress signal and are dispatching a nearby team to board with you now. Standby."
	objectives = "Investigate the distress signal aboard the [MAIN_SHIP_NAME], and assist the crew with rescue if possible. If necessary, a contingent of our Colonial Marines may be ready to act as a QRF to reinforce you."

	will_spawn_icc_liaison = prob(50)
	will_spawn_cmb_observer = prob(20)

/datum/emergency_call/cmb/create_member(datum/mind/M, turf/override_spawn_loc)
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


/datum/emergency_call/cmb/print_backstory(mob/living/carbon/human/M)
	if(M == leader)
		to_chat(M, SPAN_BOLD("你是殖民地执法官，最初来自[pick(70;"美洲联盟", 20;"太阳系", 10;"边疆殖民地")]。"))
		to_chat(M, SPAN_BOLD("你通过[pick(50;"大学期间追求职业发展", 40;"从事执法工作", 10;"因技能被招募")]的方式加入了执法官队伍。"))
		to_chat(M, SPAN_BOLD("通过在银河系各地职位的晋升，你因坚定不移地致力于正义、打击犯罪和腐败而闻名。"))
		to_chat(M, SPAN_BOLD("正在前往处理[pick(20;"凶杀案", 20;"企业腐败调查", 10;"人质事件", 10;"恐怖袭击", 10;"囚犯转移", 10;"缉毒行动", 10;"据守逃犯事件", 5;"疑似走私事件", 5;"人口贩卖事件")]的途中，你被锚点空间站的指挥部因收到[MAIN_SHIP_NAME]的求救信号而转派。"))
		to_chat(M, SPAN_BOLD("地球的法律延伸至太阳系之外。当他人受到诱惑而堕入腐败时，你依然坚守着自己的道德准则。"))
		to_chat(M, SPAN_BOLD("公司官员追逐薪水和晋升，但你的动力是履行誓言职责并关心民众，无论殖民地多么偏远或孤立。"))
		to_chat(M, SPAN_BOLD("在尼禄星区任职期间你见识颇多，但你在这里是因为你是最优秀的，正在做正确的事让边疆变得更美好。"))
		to_chat(M, SPAN_BOLD("尽管力量分散，但执法官坚定的誓言仍在持续保障社区安全，CMB深受许多人尊敬。你是这一誓言的体现，请出色地履行职责。"))
	else if(issynth(M))
		to_chat(M, SPAN_BOLD("尽管是较旧的型号，但你因敏锐的感官和警觉性而在同僚中备受好评。"))
		to_chat(M, SPAN_BOLD("除了执法程序，你被编程为定位证据、分析化学品和调查犯罪的绝对专家。"))
		to_chat(M, SPAN_BOLD("你不强制执行也不遵守《陆战队军法》，但你对其有所了解。"))
		to_chat(M, SPAN_BOLD("在太阳系接受软件和法律更新后，你被派驻到锚点空间站，以协助边疆的CMB单位。"))
		to_chat(M, SPAN_BOLD("在前往调查的途中，你因收到求救信号而被指挥部转派至[MAIN_SHIP_NAME]。"))
		to_chat(M, SPAN_BOLD("如有需要，你目前携带了轻型弹药和装备储备在你的背包中，以备分发给你的小队。"))
		to_chat(M, SPAN_BOLD("尽管力量分散，但执法官坚定的誓言仍在持续保障社区安全，CMB深受许多人尊敬。你是这一誓言的体现，请出色地履行职责。"))
	else if(M == icc_liaison)
		to_chat(M, SPAN_BOLD("你是一名星际商务联络官，最初来自[pick(70;"The United Americas", 25;"Sol", 5;"a colony on the frontier")]."))
		to_chat(M, SPAN_BOLD("你是[pick(30; "skeptical", 40;"ambicable", 30;"supportive")] of Weyland-Yutani."))
		to_chat(M, SPAN_BOLD("你的耳机配备了多个频率，包括来自ICC母公司维兰德-汤谷赠送的密钥，旨在激励你的支持。请用它进行通讯。"))
		to_chat(M, SPAN_BOLD("作为派驻锚点站CMB办公室的ICC特工，你的工作是观察并确保公平贸易行为。"))
		to_chat(M, SPAN_BOLD("与这些声誉卓著的人共事让你成为了一个更有德行的人，尤其是与其他重量级组织的公司联络官相比。"))
		to_chat(M, SPAN_BOLD("与殖民地执法官合作进行调查，如果你怀疑存在走私或非法贸易，请向指挥部报告。"))
		to_chat(M, SPAN_BOLD("你正在前往犯罪现场的路上，但你的飞船因收到求救信号而被转道至[MAIN_SHIP_NAME]。"))
	else if(M == cmb_observer)
		to_chat(M, SPAN_BOLD("你是一名星际人权观察员，最初来自[pick(50;"The United Americas", 10;"Europe", 10;"Luna", 20;"Sol", 10;"a colony on the frontier")]."))
		to_chat(M, SPAN_BOLD("你是[pick(60; "skeptical", 40;"ambicable", 10;"supportive")] of Weyland-Yutani and their practices."))
		to_chat(M, SPAN_BOLD("你是[pick(40; "skeptical", 30;"ambicable", 30;"supportive")] of the USCM's actions on the frontier."))
		to_chat(M, SPAN_BOLD("通过大量艰苦的工作，你的组织成功说服了殖民地执法官带你去前线，撰写一篇关于当地生活质量的报道。"))
		to_chat(M, SPAN_BOLD("观察联邦探员的行动，并留意任何来自他人的不人道行为。尼罗伊德星区各方都充斥着暴行。"))
		to_chat(M, SPAN_BOLD("不要煽动或挑起任何对抗。你是一名观察员，不参与战争。仅在医疗紧急情况下进行干预。"))
		to_chat(M, SPAN_BOLD("你正在前往犯罪现场的路上，但你的飞船因收到求救信号而被转道至[MAIN_SHIP_NAME]。"))
	else
		to_chat(M, SPAN_BOLD("你是一名CMB副手，最初来自[pick(70;"美洲联盟", 20;"太阳系", 10;"边疆殖民地")]。"))
		to_chat(M, SPAN_BOLD("你通过[pick(50;"大学期间追求职业发展", 40;"从事执法工作", 10;"因技能被招募")]的方式加入了执法官队伍。"))
		to_chat(M, SPAN_BOLD("在你的执法官长官带领下，你因坚定不移地致力于正义、打击犯罪和腐败而闻名。"))
		to_chat(M, SPAN_BOLD("在前往调查的途中，你被锚点站的指挥部因收到求救信号而转派至[MAIN_SHIP_NAME]。"))
		to_chat(M, SPAN_BOLD("你已在锚点站驻扎了[pick(80;"several months", 10;"only a week", 10;"years")] investigating henious crimes among the frontier."))
		to_chat(M, SPAN_BOLD("地球的法律延伸至太阳系之外。在他人堕落腐败之时，你坚守着自己的道德准则。"))
		to_chat(M, SPAN_BOLD("公司官员追逐薪水和晋升，但你的动力是履行誓言职责并关心民众，无论殖民地多么偏远或孤立。"))
		to_chat(M, SPAN_BOLD("尽管力量分散，但执法官坚定的誓言仍在持续保障社区安全，CMB深受许多人尊敬。你是这一誓言的体现，请出色地履行职责。"))


// A Nearby Colonial Marshal patrol team responding to Marshals in Distress.
/datum/emergency_call/cmb/alt
	name = "CMB - 巡逻队 - 遇险执法官（友方）"
	mob_max = 5
	mob_min = 1
	probability = 0

/datum/emergency_call/cmb/alt/New()
	..()
	arrival_message = "CMB Team, this is Anchorpoint Station. We have confirmed you are in distress. Routing nearby units to assist!"
	objectives = "Patrol Unit 5807, we have nearby Marshals in Distress! Locate and assist them immediately."

// Anchorpoint Station Colonial Marines, use this primarily for reinforcing or evacuating the CMB, as the CMB themselves are not equipped to handle heavy engagements.
/datum/emergency_call/cmb/anchorpoint
	name = "CMB - 锚点站殖民地海军陆战队快速反应部队（友方）"
	mob_max = 6
	mob_min = 3
	max_medics = 1
	max_engineers = 1
	max_smartgunners = 1
	probability = 0

/datum/emergency_call/cmb/anchorpoint/New()
	..()
	arrival_message = "[MAIN_SHIP_NAME], this is Anchorpoint Station. Be advised, a QRF Team of our Colonial Marines is currently attempting to board you. Open your ports, transmitting docking codes now. Standby."
	objectives = "QRF Team. You are here to reinforce the CMB team we deployed earlier. Make contact and work with the CMB Marshal and their deputies. Facilitate their protection and evacuation if necessary. Secondary Objective: Investigate the reason for distress aboard the [MAIN_SHIP_NAME], and assist the crew if possible."

/datum/emergency_call/cmb/anchorpoint/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("你是锚点站的陆战队火力组长！"))
		arm_equipment(mob, /datum/equipment_preset/uscm/cmb/leader, TRUE, TRUE) // placeholder
	else if(smartgunners < max_smartgunners && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_SMARTGUNNER) && check_timelock(mob.client, JOB_SQUAD_SMARTGUN, time_required_for_job))
		smartgunners++
		to_chat(mob, SPAN_ROLE_HEADER("你是锚点站的智能枪手！"))
		arm_equipment(mob, /datum/equipment_preset/uscm/cmb/smartgunner, TRUE, TRUE)
	else if (medics < max_medics && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(mob.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		to_chat(mob, SPAN_ROLE_HEADER("你是锚点站的陆战队医疗兵！"))
		arm_equipment(mob, /datum/equipment_preset/uscm/cmb/medic, TRUE, TRUE)
	else if(engineers < max_engineers && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_ENGINEER) && check_timelock(mob.client, JOB_SQUAD_ENGI, time_required_for_job))
		engineers++
		to_chat(mob, SPAN_ROLE_HEADER("你是锚点站的技术专家！"))
		arm_equipment(mob, /datum/equipment_preset/uscm/cmb/rto, TRUE, TRUE)
	else
		to_chat(mob, SPAN_ROLE_HEADER("你是锚点站的陆战队员步枪兵！"))
		arm_equipment(mob, /datum/equipment_preset/uscm/cmb, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)


/datum/emergency_call/cmb/anchorpoint/print_backstory(mob/living/carbon/human/M)
	if(M == leader)
		to_chat(M, SPAN_BOLD("你是锚点站快速反应部队火力组长，原籍[pick(70;"The United Americas", 20;"Sol", 10;"a colony on the frontier")]."))
		to_chat(M, SPAN_BOLD("你在空间站服役了[pick(50;"a Sol year, and a tour of duty", 40;"a couple months", 10;"six years, three tours")]."))
		to_chat(M, SPAN_BOLD("在锚点站与殖民地法警一同生活、训练和工作使你纪律严明，你一直为身为快速反应部队的一员感到自豪。"))
		to_chat(M, SPAN_BOLD("在锚点站期间，你[pick(20;"had your life saved by a Colonial Marshal", 20;"quelled a corporate riot", 10; "defended the station against a UPP incursion", 10;"experienced a pathogenic outbreak", 10;"assisted the Colonial Marshals during an enacted martial law", 10;"were deployed to the [MAIN_SHIP_NAME], and understand its layout", 10;"assisted the Colonial Marshals with barricaded fugitive situation", 5;"helped the ICC take down a suspected smuggling ring", 5;"helped take down a human trafficking scheme alongside the Colonial Marshals" )]."))
		to_chat(M, SPAN_BOLD("与殖民地法警在多起事件中协同作战，在你们的组织间建立了战友情谊。法警负责调查和治安，而你们则在暴乱或入侵时介入解决问题。任何需要重火力支援的任务，都有你们的身影。"))
		to_chat(M, SPAN_BOLD("你作为快速反应部队的一员被激活，以增援陷入困境的殖民地法警。"))
		to_chat(M, SPAN_BOLD("你不确定这是否是虚惊一场。现在看来并非如此……"))
		to_chat(M, SPAN_BOLD("现在，再次轮到你们扮演快速反应部队的角色了。向你的部下下达简报，然后出发！"))
	else if(M == smartgunners)
		to_chat(M, SPAN_BOLD("你是锚点站快速反应部队智能枪手，原籍[pick(70;"The United Americas", 20;"Sol", 10;"a colony on the frontier")]."))
		to_chat(M, SPAN_BOLD("你在空间站服役了[pick(45;"a Sol year, and a tour of duty", 20;"a couple months", 5;"six long years, three consecutive tours")]."))
		to_chat(M, SPAN_BOLD("在锚点站与殖民地法警一同生活、训练和工作使你纪律严明，你一直为身为快速反应部队的一员感到自豪。"))
		to_chat(M, SPAN_BOLD("在锚点站期间，你[pick(20;"had your life saved by a Colonial Marshal", 20;"quelled a corporate riot", 10; "defended the station against a UPP incursion", 10;"experienced a pathogenic outbreak", 10;"assisted the Colonial Marshals during an enacted martial law", 10;"were deployed to the [MAIN_SHIP_NAME], and understand its layout", 10;"assisted the Colonial Marshals with barricaded fugitive situation", 5;"helped the ICC take down a suspected smuggling ring", 5;"helped take down a human trafficking scheme alongside the Colonial Marshals" )]."))
		to_chat(M, SPAN_BOLD("与殖民地法警在多起事件中协同作战，在你们的组织间建立了战友情谊。法警负责调查和治安，而你们则在暴乱或入侵时介入解决问题。任何需要重火力支援的任务，都有你们的身影。"))
		to_chat(M, SPAN_BOLD("你作为快速反应部队的一员被激活，以增援陷入困境的殖民地法警。"))
		to_chat(M, SPAN_BOLD("你不确定这是否是虚惊一场。现在看来并非如此……但你早就想找个借口让那挺M56智能枪开开荤了。"))
		to_chat(M, SPAN_BOLD("现在，再次轮到你们扮演快速反应部队的角色了。让我们大干一场！"))
	else if(M == medics)
		to_chat(M, SPAN_BOLD("你是锚点站快速反应部队医疗兵，原籍[pick(70;"The United Americas", 20;"Sol", 10;"a colony on the frontier")]."))
		to_chat(M, SPAN_BOLD("你在空间站服役了[pick(45;"a Sol year, and a tour of duty", 20;"a couple months", 5;"six long years, three consecutive tours")]."))
		to_chat(M, SPAN_BOLD("在锚点站与殖民地法警一同生活、训练和工作使你纪律严明，你一直为身为快速反应部队的一员感到自豪。"))
		to_chat(M, SPAN_BOLD("在锚点站期间，你[pick(20;"had your life saved by a Colonial Marshal", 20;"quelled a corporate riot", 10; "defended the station against a UPP incursion", 10;"experienced a pathogenic outbreak", 10;"assisted the Colonial Marshals during an enacted martial law", 10;"were deployed to the [MAIN_SHIP_NAME], and understand its layout", 10;"assisted the Colonial Marshals with barricaded fugitive situation", 5;"helped the ICC take down a suspected smuggling ring", 5;"helped take down a human trafficking scheme alongside the Colonial Marshals" )]."))
		to_chat(M, SPAN_BOLD("与殖民地法警在多起事件中协同作战，在你们的组织间建立了战友情谊。法警负责调查和治安，而你们则在暴乱或入侵时介入解决问题。任何需要重火力支援的任务，都有你们的身影。"))
		to_chat(M, SPAN_BOLD("你作为快速反应部队的一员被激活，以增援陷入困境的殖民地法警。"))
		to_chat(M, SPAN_BOLD("你不确定这是否是虚惊一场。现在看来并非如此……"))
		to_chat(M, SPAN_BOLD("现在，再次轮到你们扮演快速反应部队的角色了。"))
	else if(M == engineers)
		to_chat(M, SPAN_BOLD("你是锚点站快速反应部队技术专家，原籍[pick(70;"The United Americas", 20;"Sol", 10;"a colony on the frontier")]."))
		to_chat(M, SPAN_BOLD("你在空间站服役了[pick(45;"a Sol year, and a tour of duty", 20;"a couple months", 5;"six long years, three consecutive tours")]."))
		to_chat(M, SPAN_BOLD("在锚点站与殖民地法警一同生活、训练和工作使你纪律严明，你一直为身为快速反应部队的一员感到自豪。"))
		to_chat(M, SPAN_BOLD("在锚点站期间，你[pick(20;"had your life saved by a Colonial Marshal", 20;"quelled a corporate riot", 10; "defended the station against a UPP incursion", 10;"experienced a pathogenic outbreak", 10;"assisted the Colonial Marshals during an enacted martial law", 10;"were deployed to the [MAIN_SHIP_NAME], and understand its layout", 10;"assisted the Colonial Marshals with barricaded fugitive situation", 5;"helped the ICC take down a suspected smuggling ring", 5;"helped take down a human trafficking scheme alongside the Colonial Marshals" )]."))
		to_chat(M, SPAN_BOLD("与殖民地法警在多起事件中协同作战，在你们的组织间建立了战友情谊。法警负责调查和治安，而你们则在暴乱或入侵时介入解决问题。任何需要重火力支援的任务，都有你们的身影。"))
		to_chat(M, SPAN_BOLD("你作为快速反应部队的一员被激活，以增援陷入困境的殖民地法警。"))
		to_chat(M, SPAN_BOLD("你不确定这是否是虚惊一场。现在看来并非如此……"))
		to_chat(M, SPAN_BOLD("现在，再次轮到你们扮演快速反应部队的角色了。信号清晰。"))
	else
		to_chat(M, SPAN_BOLD("你是锚点站快速反应部队步枪兵，原籍[pick(70;"The United Americas", 20;"Sol", 10;"a colony on the frontier")]."))
		to_chat(M, SPAN_BOLD("你在空间站服役了[pick(45;"a Sol year, and a tour of duty", 20;"a couple months", 5;"six long years, three consecutive tours")]."))
		to_chat(M, SPAN_BOLD("在锚点站与殖民地法警一同生活、训练和工作使你纪律严明，你一直为身为快速反应部队的一员感到自豪。"))
		to_chat(M, SPAN_BOLD("在锚点站期间，你[pick(20;"had your life saved by a Colonial Marshal", 20;"quelled a corporate riot", 10; "defended the station against a UPP incursion", 10;"experienced a pathogenic outbreak", 10;"assisted the Colonial Marshals during an enacted martial law", 10;"were deployed to the [MAIN_SHIP_NAME], and understand its layout", 10;"assisted the Colonial Marshals with barricaded fugitive situation", 5;"helped the ICC take down a suspected smuggling ring", 5;"helped take down a human trafficking scheme alongside the Colonial Marshals" )]."))
		to_chat(M, SPAN_BOLD("与殖民地法警在多起事件中协同作战，在你们的组织间建立了战友情谊。法警负责调查和治安，而你们则在暴乱或入侵时介入解决问题。任何需要重火力支援的任务，都有你们的身影。"))
		to_chat(M, SPAN_BOLD("你作为快速反应部队的一员被激活，以增援陷入困境的殖民地法警。"))
		to_chat(M, SPAN_BOLD("你不确定这是否是虚惊一场。现在看来并非如此……"))
		to_chat(M, SPAN_BOLD("现在，再次轮到你们扮演快速反应部队的角色了。"))

/datum/emergency_call/cmb/riot_control
	name = "CMB - 殖民地法警防暴部队（友方）"
	mob_max = 8
	mob_min = 3
	probability = 20
	home_base = /datum/lazy_template/ert/weyland_station
	max_heavies = 1
	max_medics = 2
	max_synths = 1
	max_engineers = 1

/datum/emergency_call/cmb/riot_control/New()
	..()
	arrival_message = "Incoming Transmission: [MAIN_SHIP_NAME], this is Anchorpoint Station with the Colonial Marshal Bureau. We are receiving your distress signal and are dispatching a nearby riot control team to board with you now. Standby."

/datum/emergency_call/cmb/riot_control/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("你是殖民地执法官！"))
		arm_equipment(mob, /datum/equipment_preset/cmb/leader/riot, TRUE, TRUE)
	else if(medics < max_medics && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(mob.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		to_chat(mob, SPAN_ROLE_HEADER("你是CMB医疗技术员！"))
		arm_equipment(mob, /datum/equipment_preset/cmb/med, TRUE, TRUE)
	else if(engineers < max_engineers && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_ENGINEER) && check_timelock(mob.client, JOB_SQUAD_ENGI, time_required_for_job))
		engineers++
		to_chat(mob, SPAN_ROLE_HEADER("你是CMB破门技术员！"))
		arm_equipment(mob, /datum/equipment_preset/cmb/eng, TRUE, TRUE)
	else if(heavies < max_heavies && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_HEAVY) && check_timelock(mob.client, JOB_SQUAD_SPECIALIST, time_required_for_job))
		heavies++
		to_chat(mob, SPAN_ROLE_HEADER("你是CMB特警专家！"))
		arm_equipment(mob, /datum/equipment_preset/cmb/spec, TRUE, TRUE)
	else if(synths < max_synths && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_SYNTH) && mob.client.check_whitelist_status(WHITELIST_SYNTHETIC))
		synths++
		to_chat(mob, SPAN_ROLE_HEADER("你是CMB防暴合成人！"))
		arm_equipment(mob, /datum/equipment_preset/cmb/synth/riot, TRUE, TRUE)
	else
		to_chat(mob, SPAN_ROLE_HEADER("你是防暴警官！"))
		arm_equipment(mob, /datum/equipment_preset/cmb/riot, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)

/datum/emergency_call/cmb/riot_control/print_backstory(mob/living/carbon/human/M)
	if(M == leader)
		to_chat(M, SPAN_BOLD("You are the Colonial Marshal, originally from [pick(70;"The United Americas", 20;"Sol", 10;"a colony on the frontier")]."))
		to_chat(M, SPAN_BOLD("You started in the Marshals through [pick(50; "pursuing a career during college", 40;"working for law enforcement", 10;"being recruited for your skills")]."))
		to_chat(M, SPAN_BOLD("Rising through positions across the galaxy, you have become renown for your steadfast commitment to justice, fighting against crime and corruption alike."))
		to_chat(M, SPAN_BOLD("Enroute to a [pick(20; "homicide", 20;"corporate corruption investigation", 10; "hostage situation", 10;"terrorist attack", 10;"prisoner transfer", 10;"drug raid", 10;"barricaded fugitive situation", 5;"suspected smuggling incident", 5;"human trafficking situation" )] you were diverted by your command at Anchorpoint Station to the [MAIN_SHIP_NAME] because of a distress beacon."))
		to_chat(M, SPAN_BOLD("The laws of Earth stretch beyond the Sol. Where others are tempted and fall to corruption, you stay steadfast in your morals."))
		to_chat(M, SPAN_BOLD("Corporate Officers chase after paychecks and promotions, but you are motivated to do your sworn duty and care for the population, no matter how far or isolated a colony may be."))
		to_chat(M, SPAN_BOLD("You've seen a lot during your time in the Neroid Sector, but you're here because you're the best, doing the right thing to make the frontier a better place."))
		to_chat(M, SPAN_BOLD("Despite being stretched thin, the stalwart oath of the Marshals has continued to keep communities safe, with the CMB well respected by many. You are the representation of that oath, serve with distinction."))
	else if(issynth(M))
		to_chat(M, SPAN_BOLD("尽管是较旧的型号，但你因敏锐的感官和警觉性而在同僚中备受好评。"))
		to_chat(M, SPAN_BOLD("你不强制执行也不遵守《陆战队军法》，但你对其有所了解。"))
		to_chat(M, SPAN_BOLD("在太阳系接受软件和法律更新后，你被派驻到锚点空间站，以协助边疆的CMB单位。"))
		to_chat(M, SPAN_BOLD("在前往任务地点的途中，你因收到一个求救信号而被指挥部紧急调往[MAIN_SHIP_NAME]。"))
		to_chat(M, SPAN_BOLD("尽管力量分散，但执法官坚定的誓言仍在持续保障社区安全，CMB深受许多人尊敬。你是这一誓言的体现，请出色地履行职责。"))
	else
		to_chat(M, SPAN_BOLD("You are a CMB Riot Control Officer, originally from [pick(70;"The United Americas", 20;"Sol", 10;"a colony on the frontier")]."))
		to_chat(M, SPAN_BOLD("You joined the Marshals through [pick(50; "pursuing a career during college", 40;"working for law enforcement", 10;"being recruited for your skills")]."))
		to_chat(M, SPAN_BOLD("Following the lead of your Marshal, you have become renown for your steadfast commitment to justice, fighting against crime and corruption alike."))
		to_chat(M, SPAN_BOLD("While enroute to your mission you were diverted by your command at Anchorpoint Station to the [MAIN_SHIP_NAME] because of a distress beacon."))
		to_chat(M, SPAN_BOLD("You have been stationed at Anchorpoint Station for [pick(80;"several months", 10;"only a week", 10;"years")] keeping orden on the frontier."))
		to_chat(M, SPAN_BOLD("The laws of Earth stretch beyond the Sol. Where others fall to corruption, you stay steadfast in your morals."))
		to_chat(M, SPAN_BOLD("Corporate Officers chase after paychecks and promotions, but you are motivated to do your sworn duty and care for the population, no matter how far or isolated a colony may be."))
		to_chat(M, SPAN_BOLD("Despite being stretched thin, the stalwart oath of the Marshals has continued to keep communities safe, with the CMB well respected by many. You are a representation of that oath, serve with distinction."))

// A Nearby Colonial Marshal riot control team responding to Marshals in Distress.
/datum/emergency_call/cmb/riot_control/alt
	name = "CMB - 防暴控制单位 - 遇险执法官（友方）"
	mob_max = 5
	mob_min = 1
	max_medics = 1
	probability = 0

/datum/emergency_call/cmb/riot_control/alt/New()
	..()
	arrival_message = "CMB Team, this is Anchorpoint Station. We have confirmed you are in distress. Routing nearby units to assist!"
	objectives = "Patrol Unit 5807, we have nearby Marshals in Distress! Locate and assist them immediately."
