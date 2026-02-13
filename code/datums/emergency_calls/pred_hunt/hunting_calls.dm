//Predator Hunting Ground ERTs


/datum/emergency_call/pred
	name = "template"
	probability = 0
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress/hunt_spawner
	shuttle_id = ""
	ert_message = "Prey is being set loose in the Yautja Hunting Grounds"
	var/hunt_name
	var/message = "You are still expected to uphold the RP of the standard as this character!"
	var/mercs = 0
	var/royal_marines= 0
	var/upp = 0
	var/clf = 0
	var/pmc = 0
	var/misc = 0
	var/max_mercs = 1
	var/max_royal_marines= 1
	var/max_upp = 1
	var/max_clf = 1
	var/max_pmc = 1
	var/max_misc = 1

/datum/emergency_call/pred/mixed
	name = "猎场 - 多阵营 - 小型"
	hunt_name = "Multi Faction (small)"
	mob_max = 4
	mob_min = 1
	max_clf = 1
	max_upp = 1
	max_royal_marines = 1
	max_pmc = 1
	max_misc = 1

/datum/emergency_call/pred/mixed/spawn_candidates(quiet_launch, announce_incoming, override_spawn_loc)
	. = ..()
	if(length(members) < mob_min)
		message_all_yautja("Not enough humans in storage for the hunt to start.")
		COOLDOWN_RESET(GLOB, hunt_timer_yautja)
	else
		message_all_yautja("Released [length(members)] humans from storage, let the hunt commence!")

/datum/emergency_call/pred/mixed/create_member(datum/mind/player, turf/override_spawn_loc)
	set waitfor = 0
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return

	var/mob/living/carbon/human/hunted = new(spawn_loc)

	if(player)
		player.transfer_to(hunted, TRUE)
	else
		hunted.create_hud()

	if(mercs < max_mercs && HAS_FLAG(hunted.client.prefs.toggles_ert_pred, PLAY_MERC))
		mercs++
		var/list/hunted_types = list(/datum/equipment_preset/other/freelancer/leader/hunted, /datum/equipment_preset/other/freelancer/standard/hunted)
		var/hunted_type = pick(hunted_types)
		arm_equipment(hunted, hunted_type , TRUE, TRUE)
		to_chat(hunted, SPAN_BOLD("没人比我更专业。与其他雇佣兵不同，你的团队是一家注册合法的、从事暴力业务的实体。为各种高调客户服务，那些对公众保密的信息在你的圈子里流传得相当自由——那些你曾当作轶事或传闻而嗤之以鼻的故事。你接的最后一单任务被证明异常危险且真实：当你在一个挖掘点周围清理当地动物群时，一个巨大的人形闪烁物体向你猛扑过来，一击就将你打晕。你晕乎乎地睁开眼睛，试图弄清周围的环境，然后站了起来。"))
	else if(upp < max_upp && HAS_FLAG(hunted.client.prefs.toggles_ert_pred, PLAY_UPP))
		upp++
		var/list/hunted_types = list(/datum/equipment_preset/upp/soldier/hunted, /datum/equipment_preset/upp/leader/hunted, /datum/equipment_preset/upp/machinegunner/hunted, /datum/equipment_preset/upp/sapper/hunted)
		var/hunted_type = pick(hunted_types)
		arm_equipment(hunted, hunted_type , TRUE, TRUE)
		to_chat(hunted, SPAN_BOLD("生活本来还算安稳。你从前线一个更嘈杂的岗位调离，现在驻扎在联盟领土的外围边缘。战斗巡逻和锯末口粮变成了无聊的站岗和像样的食物，让你的维和任务成了人人羡慕的美差。然后，你的生活崩塌了。一个未知的外星生物突袭了你和整个驻军，高效地屠杀了几乎所有人。就在你即将逃脱时，它设下陷阱抓住了你，把你拖进了黑暗。如今在一个完全陌生的地方醒来，身上还带着战斗的伤痛，你思索着如何才能安然无恙地回到家乡。"))
	else if(royal_marines < max_royal_marines && HAS_FLAG(hunted.client.prefs.toggles_ert_pred, PLAY_TWE))
		royal_marines++
		var/list/hunted_types = list(/datum/equipment_preset/twe/royal_marine/standard/hunted, /datum/equipment_preset/twe/royal_marine/team_leader/hunted, /datum/equipment_preset/twe/royal_marine/lieuteant/hunted)
		var/hunted_type = pick(hunted_types)
		arm_equipment(hunted, hunted_type , TRUE, TRUE)
		to_chat(hunted, SPAN_BOLD("你开始对这些澳大利亚人感到厌烦了。在大洋洲各地被派驻和调遣，过去五年你辗转于难民营和大都市之间，大部分时间维持秩序，偶尔参与镇压骚乱。你几乎愿意付出任何代价，只求工作能更有趣些，而就像猴爪许愿一样，愿望成真了。一天晚上，你站岗时亲眼目睹营房被炸毁，更糟的是，袭击者并非恐怖分子。你试图射杀那头怪物，但失败了，朋友们在你眼前被撕碎。作为唯一的幸存者，那东西抓住了你，给你戴上镣铐，扔进了牢房。你再次昏迷，醒来时已身处此地，无论这是哪里。至少你希望现在事情会更有趣些，或者你如此告诉自己。"))
	else if(clf < max_clf && HAS_FLAG(hunted.client.prefs.toggles_ert_pred, PLAY_CLF))
		clf++
		var/list/hunted_types = list(/datum/equipment_preset/clf/soldier/hunted, /datum/equipment_preset/clf/leader/hunted, /datum/equipment_preset/clf/engineer/hunted, /datum/equipment_preset/clf/specialist/hunted)
		var/hunted_type = pick(hunted_types)
		arm_equipment(hunted, hunted_type , TRUE, TRUE)
		to_chat(hunted, SPAN_BOLD("你的一生都在挣扎。为了殖民地从一个个主子手中争取独立而拼死战斗，却收效甚微，你的家园最终被压迫者的铁蹄踏碎。满腔怒火，你跟随自由战士小队从一个星系转战到另一个星系，制造破坏与混乱，最终因残忍处决政府官员和军人而恶名昭著。在一次失手的突袭中，你的战友被一支陆战队员小队屠杀，当你仓皇逃窜时，却被别的东西打了个措手不及。被击昏带走后，你在与之前相差无几的环境中醒来，决心再次向压迫者复仇。"))
	else if(pmc < max_pmc && HAS_FLAG(hunted.client.prefs.toggles_ert_pred, PLAY_PMC))
		pmc++
		var/list/hunted_types = list(/datum/equipment_preset/pmc/pmc_standard/hunted, /datum/equipment_preset/pmc/pmc_medic/hunted, /datum/equipment_preset/pmc/technician/hunted, /datum/equipment_preset/goon/standard/hunted, /datum/equipment_preset/goon/lead/hunted)
		var/hunted_type = pick(hunted_types)
		arm_equipment(hunted, hunted_type , TRUE, TRUE)
		to_chat(hunted, SPAN_BOLD("你是维兰德-汤谷麾下最顶尖的人员之一，至少他们是这么告诉你的。为公司巨头效力多年，你拥有舒适安逸的工作。即使受伤，卓越的医疗保障也让你远离死亡。最近，你被派往一颗陌生星球，守卫一个与世隔绝的公司设施外围。他们没告诉你守卫的是什么，你只瞥见几支精英部队和一些科学家推着一张重型滚轮床，上面盖着防水布，布下是一具严重变形的外星生物尸体。你的任务本该很轻松……至少你是这么想的。一天，你目睹设施内发生爆炸，同僚被某种等离子弹蒸发。你试图逃跑，但一张网突然在你面前发射，将你击倒在地。你在这里醒来，大部分装备完好无损。这是你第一次孤身一人。"))
	else if(misc < max_misc && HAS_FLAG(hunted.client.prefs.toggles_ert_pred, PLAY_HUNT_MISC))
		misc++
		var/list/hunted_types = list(/datum/equipment_preset/other/hunted/roman, /datum/equipment_preset/other/hunted/roman/centurion, /datum/equipment_preset/other/hunted/roman/eaglebearer, /datum/equipment_preset/other/hunted/vietnam)
		var/hunted_type = pick(hunted_types)
		arm_equipment(hunted, hunted_type , TRUE, TRUE)
		to_chat(hunted, SPAN_BOLD("你是一位来自遥远古代的战士。在你进行日常活动时，一头人形怪兽出现在你面前，给你戴上镣铐并俘虏了你。极度的恐惧让你昏厥，醒来时身处一个难以理解的结构内，窗外是满天星辰。你被拖走，被迫进入某种舱体，舱门紧闭，你最后的记忆是感到刺骨的寒冷。你再次醒来，被绑架前的物品都在，但环境和空气感觉截然不同。是时候考验你的生存技能了。"))
	else
		var/list/hunted_types = list(/datum/equipment_preset/uscm/hunted/rifleman,/datum/equipment_preset/uscm/hunted/tl, /datum/equipment_preset/uscm/hunted/sg,)
		var/hunted_type = pick(hunted_types)
		arm_equipment(hunted, hunted_type , TRUE, TRUE)
		to_chat(hunted, SPAN_BOLD("你从小就梦想成为终极狠人。核弹、刀子、尖木棍——军队是你的归宿，一达到年龄你就加入了陆战队。你几乎没有遗憾，乐于在任何时间、任何地点、奉命射杀任何目标……直到现在。在一次丛林巡逻中，你的整个小队被一个隐形单位撕成了碎片——这东西你以前还以为是用来吓唬新兵的传说。你用子弹在那怪物身上开了无数个洞，但它最终还是让你措手不及，之后的一切都模糊不清。醒来时，你发现自己还活着……而且它把你的武器留给了你。大错特错。你站了起来。"))

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound_client), hunted.client, 'sound/misc/hunt_begin.ogg'), 10 SECONDS)
	show_blurb(hunted, 15, message, null, "center", "center", COLOR_RED, null, null, 1)

/datum/emergency_call/pred/mixed/medium
	name = "猎场 - 多阵营 - 中型"
	hunt_name = "Multi Faction (group)"
	mob_max = 6
	mob_min = 2
	max_clf = 2
	max_upp = 2
	max_royal_marines = 1
	max_pmc = 1
	max_misc = 2
	max_mercs = 1


/datum/emergency_call/pred/mixed/hard
	name = "猎场 - 多阵营 - 大型"
	hunt_name = "Multi Faction (large)"
	mob_max = 8
	mob_min = 3
	max_clf = 2
	max_upp = 1
	max_royal_marines = 2
	max_pmc = 1
	max_misc = 2
	max_mercs = 2

/datum/emergency_call/pred/mixed/harder
	name = "猎场 - 多阵营 - 超大型"
	hunt_name = "Multi Faction (larger)"
	mob_max = 12
	mob_min = 4
	max_clf = 2
	max_upp = 2
	max_royal_marines = 3
	max_pmc = 1
	max_misc = 2
	max_mercs = 2

/datum/emergency_call/pred/xeno
	name = "猎场 - 异形 - 小型"
	hunt_name = "Serpents (small)"
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress/hunt_spawner/xeno
	mob_max = 4
	mob_min = 1
	hostility = TRUE
	max_xeno_t3 = 1
	max_xeno_t2 = 1


/datum/emergency_call/pred/xeno/spawn_candidates(quiet_launch, announce_incoming, override_spawn_loc)
	. = ..()
	if(length(members) < mob_min)
		COOLDOWN_RESET(GLOB, hunt_timer_yautja)
		message_all_yautja("Not enough serpents in storage for the hunt to start.")
	else
		message_all_yautja("Released [length(members)] serpents from storage, let the hunt commence!")

/datum/emergency_call/pred/xeno/create_member(datum/mind/player, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()
	var/mob/current_mob = player.current
	var/mob/living/carbon/xenomorph/new_xeno

	if(!istype(spawn_loc))
		return // Didn't find a usable spawn point.

	if(xeno_t3 < max_xeno_t3 && HAS_FLAG(current_mob.client.prefs.toggles_ert_pred, PLAY_XENO_T3))
		xeno_t3++
		var/list/xeno_types = list(/mob/living/carbon/xenomorph/praetorian, /mob/living/carbon/xenomorph/ravager, /mob/living/carbon/xenomorph/despoiler)
		var/xeno_type = pick(xeno_types)
		new_xeno = new xeno_type(spawn_loc, null, XENO_HIVE_HUNTED)
		player.transfer_to(new_xeno, TRUE)
		QDEL_NULL(current_mob)
		to_chat(new_xeno, SPAN_BOLD("你是一只被释放到陌生星球上的异形。"))
	else if(xeno_t2 < max_xeno_t2 && HAS_FLAG(current_mob.client.prefs.toggles_ert_pred, PLAY_XENO_T2))
		xeno_t2++
		var/list/xeno_types = list(/mob/living/carbon/xenomorph/lurker, /mob/living/carbon/xenomorph/warrior)
		var/xeno_type = pick(xeno_types)
		new_xeno = new xeno_type(spawn_loc, null, XENO_HIVE_HUNTED)
		player.transfer_to(new_xeno, TRUE)
		QDEL_NULL(current_mob)
		to_chat(new_xeno, SPAN_BOLD("你是一只被释放到陌生星球上的异形。"))
	else
		var/list/xeno_types = list(/mob/living/carbon/xenomorph/warrior)
		var/xeno_type = pick(xeno_types)
		new_xeno = new xeno_type(spawn_loc, null, XENO_HIVE_HUNTED)
		player.transfer_to(new_xeno, TRUE)
		to_chat(new_xeno, SPAN_BOLD("你是一只被释放到陌生星球上的异形。"))

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound_client), new_xeno.client, 'sound/misc/hunt_begin.ogg'), 10 SECONDS)
	show_blurb(new_xeno, 15, message, null, "center", "center", COLOR_RED, null, null, 1)
	new /obj/effect/alien/weeds/node/pylon/hunted(spawn_loc)

/datum/emergency_call/pred/xeno/med
	name = "猎场 - 异形 - 中型"
	hunt_name = "Serpents (group)"
	mob_max = 6
	mob_min = 3
	hostility = TRUE
	max_xeno_t3 = 3
	max_xeno_t2 = 1

/datum/emergency_call/pred/xeno/hard
	name = "猎场 - 异形 - 大型"
	hunt_name = "Serpents (large)"
	mob_max = 8
	mob_min = 4
	hostility = TRUE
	max_xeno_t3 = 3
	max_xeno_t2 = 3

/datum/emergency_call/young_bloods //YOUNG BLOOD ERT ONLY FOR HUNTING GROUNDS IF SOME MOD USES THIS INSIDE THE MAIN GAME THE COUNCIL WONT BE HAPPY (Joe Lampost)
	name = "模板"
	var/blooding_name
	var/youngblood_time
	probability = 0
	mob_max = 3
	mob_min = 1
	ert_message = "A group of Yautja Youngbloods are being awakened for a hunt"
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress/hunt_spawner/pred
	shuttle_id = ""

/datum/emergency_call/young_bloods/New()
	. = ..()
	objectives = "Hunt down and defeat prey within the hunting grounds to earn your mark. While hunting, you are not allowed to: Stun hit prey, hit prey while cloaked, excessively run away to heal and steal hunted marks of your fellow youngbloods!"

/datum/emergency_call/young_bloods/remove_nonqualifiers(list/datum/mind/candidates_list)
	var/list/datum/mind/youngblood_candidates_clean = list()
	for(var/datum/mind/youngblood_candidate in candidates_list)
		if(youngblood_candidate.current?.client?.check_whitelist_status(WHITELIST_YAUTJA) || jobban_isbanned(youngblood_candidate.current, ERT_JOB_YOUNGBLOOD))
			to_chat(youngblood_candidate.current, SPAN_WARNING("你不符合紧急响应小组信标资格，因为你已拥有铁血战士白名单权限，或已被禁止担任幼血者职位。"))
			continue
		if(check_timelock(youngblood_candidate.current?.client, JOB_YOUNGBLOOD_ROLES_LIST, youngblood_time))
			to_chat(youngblood_candidate.current, SPAN_WARNING("你不符合紧急响应小组信标资格，因为你已达到幼血者的最大允许时长，请考虑在论坛申请铁血战士资格。"))
			continue
		if(check_timelock(youngblood_candidate.current?.client, JOB_SQUAD_ROLES_LIST, time_required_for_job) && (youngblood_candidate.current?.client.get_total_xeno_playtime() >= time_required_for_job))
			youngblood_candidates_clean.Add(youngblood_candidate)
			continue
		if(youngblood_candidate.current)
			to_chat(youngblood_candidate.current, SPAN_WARNING("你不符合紧急响应小组信标资格，因为你未满足该职位所需的小队角色和异形角色总时长要求 [round(time_required_for_job / 18000)] 小时。"))
	return youngblood_candidates_clean


/datum/emergency_call/young_bloods/spawn_candidates(quiet_launch, announce_incoming, override_spawn_loc)
	. = ..()
	if(length(members) < mob_min)
		message_all_yautja("No youngbloods answered the call.")
		COOLDOWN_RESET(GLOB, youngblood_timer_yautja)
	else
		message_all_yautja("Awoke [length(members)] youngbloods for the ritual.")

/datum/emergency_call/young_bloods/create_member(datum/mind/player, turf/override_spawn_loc)
	set waitfor = 0
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))  //Didn't find a useable spawn point.
		return

	var/mob/living/carbon/human/hunter = new(spawn_loc)

	if(player)
		player.transfer_to(hunter, TRUE)
	else
		hunter.create_hud()

	if(player)
		FOR_DVIEW(var/obj/structure/machinery/cryopod/pod, 7, hunter, HIDE_INVISIBLE_OBSERVER)
			if(pod && !pod.occupant)
				pod.go_in_cryopod(hunter, silent = TRUE)
				break
		FOR_DVIEW_END

	if(!leader && HAS_FLAG(hunter?.client.prefs.toggles_ert, PLAY_LEADER)) // If someone wants to play as the dominant youngblood, they can. The role is purely roleplay-oriented with no mechanical advantage
		leader = hunter
		arm_equipment(hunter, /datum/equipment_preset/yautja/non_wl_leader, TRUE, TRUE)
		to_chat(hunter, SPAN_ROLE_HEADER("你是一名铁血战士幼血者小队领袖！"))
		to_chat(hunter, SPAN_YAUTJABOLDBIG("你必须始终保持角色扮演，服从所有白名单玩家的命令，并遵守荣誉准则。如果你未能遵守其中任何一条，嵌入所有幼血者体内的处决开关将被激活。你也可能面临场外惩罚。祝你好运，玩得开心。"))
	else
		arm_equipment(hunter, /datum/equipment_preset/yautja/non_wl, TRUE, TRUE)
		to_chat(hunter, SPAN_ROLE_HEADER("你是一名铁血战士幼血者！"))
		to_chat(hunter, SPAN_YAUTJABOLDBIG("你必须始终保持角色扮演，服从所有白名单玩家的命令，并遵守荣誉准则。如果你未能遵守其中任何一条，嵌入所有幼血者体内的处决开关将被激活。你也可能面临场外惩罚。祝你好运，玩得开心。"))

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), hunter, SPAN_YAUTJABOLD("Objectives:</b> [objectives]")), 30 SECONDS)

	if(SSticker.mode)
		SSticker.mode.initialize_predator(hunter, ignore_pred_num = TRUE)

/datum/emergency_call/young_bloods/inexperienced
	name = "猎场 - 新手幼血者小队" //For completly new youngblood players
	blooding_name = "Inexperienced Youngblood Party (Three members)"
	time_required_for_job = 5 HOURS
	youngblood_time = 2 HOURS

/datum/emergency_call/young_bloods/intermediate
	name = "猎场 - 中级幼血者小队" //For players who have played a few rounds as youngblood
	blooding_name = "Intermediate Youngblood Party (Three members)"
	time_required_for_job = 10 HOURS
	youngblood_time = 5 HOURS

/datum/emergency_call/young_bloods/experienced //Regular youngblood party
	name = "猎场 - 资深幼血者小队"
	blooding_name = "Experienced Youngblood Party (Three members)"
	time_required_for_job = 20 HOURS
	youngblood_time = 10 HOURS
