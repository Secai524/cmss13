
//UPP COMMANDOS
/datum/emergency_call/upp_commando
	name = "UPP突击队（！死亡小队！）"
	mob_max = 6
	probability = 0
	objectives = "Stealthily assault the ship. Use your silenced weapons, tranquilizers, and night vision to get the advantage on the enemy. Take out the power systems, comms and engine. Stick together and keep a low profile."
	shuttle_id = MOBILE_SHUTTLE_ID_ERT3
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_upp
	item_spawn = /obj/effect/landmark/ert_spawns/distress_upp/item
	hostility = TRUE

/datum/emergency_call/upp_commando/print_backstory(mob/living/carbon/human/M)
	to_chat(M, SPAN_BOLD("你在一个相对简单的家庭中长大，[pick(75;"Eurasia", 25;"a famished UPP colony")] with few belongings or luxuries."))
	to_chat(M, SPAN_BOLD("你成长的家庭是[pick(50;"getting by", 25;"impoverished", 25;"starving")] and you were one of [pick(10;"two", 20;"three", 20;"four", 30;"five", 20;"six")] children."))
	to_chat(M, SPAN_BOLD("你出身于一个悠久的[pick(40;"crop-harvesters", 20;"soldiers", 20;"factory workers", 5;"scientists", 15;"engineers")], and quickly enlisted to improve your living conditions."))
	to_chat(M, SPAN_BOLD("你在17岁应征加入UPP军队后，被分配到由甘巴塔尔中校指挥的第17‘闷燃之子’营（编制六百人）。"))
	to_chat(M, SPAN_BOLD("你随该营被派遣到UPP最偏远的领土之一，一颗位于内罗伊德星区、英日臂内的气态巨行星，代号MV-35。"))
	to_chat(M, SPAN_BOLD("在过去的14个月里，你和‘闷燃之子’的其他成员一直驻扎在MV-35唯一的设施——氦气精炼厂‘阿尔泰站’。"))
	to_chat(M, SPAN_BOLD("由于MV-35和阿尔泰站是内罗伊德星区许多光年内唯一的UPP控制区，你军旅生涯的大部分时间都蜷缩在拥挤、近乎黑暗的营房里，等待补给运输和护送部署任务。"))
	to_chat(M, SPAN_BOLD("随着敌方USCM营‘坠落猎鹰’及其旗舰[MAIN_SHIP_NAME]最近抵达该星区，UPP感到了威胁。"))
	to_chat(M, SPAN_BOLD("为了保护脆弱的MV-35免受步步紧逼的UA/USCM帝国主义者侵害，你所在营的指挥部认为这是打击‘坠落猎鹰’、攻其不备的最佳时机。"))
	to_chat(M, SPAN_WARNING(FONT_SIZE_BIG("Glory to Podpolkovnik Ganbaatar.")))
	to_chat(M, SPAN_WARNING(FONT_SIZE_BIG("Glory to the Smoldering Sons.")))
	to_chat(M, SPAN_WARNING(FONT_SIZE_BIG("Glory to the UPP.")))
	to_chat(M, SPAN_NOTICE("使用 say :3 <text> 来说你的母语。"))
	to_chat(M, SPAN_NOTICE("这让你可以私下与你的UPP盟友交谈。"))
	to_chat(M, SPAN_NOTICE("配合你的无线电使用，以防被敌方无线电截获。"))

/datum/emergency_call/upp_commando/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/H = new(spawn_loc)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, JOB_SQUAD_LEADER, time_required_for_job))    //First one spawned is always the leader.
		leader = H
		arm_equipment(H, /datum/equipment_preset/upp/commando/leader/dressed, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是进步人民联盟的一名突击队队长，这是一个能与美利坚合众国抗衡的强大社会主义国家！"))
	else if(medics < max_medics && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(H.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		to_chat(H, SPAN_ROLE_HEADER("你是进步人民联盟的一名突击队医疗兵，这是一个能与美利坚合众国抗衡的强大社会主义国家！"))
		arm_equipment(H, /datum/equipment_preset/upp/commando/medic/dressed, TRUE, TRUE)
	else
		to_chat(H, SPAN_ROLE_HEADER("你是进步人民联盟的一名突击队员，这是一个能与美利坚合众国抗衡的强大社会主义国家！"))
		arm_equipment(H, /datum/equipment_preset/upp/commando/dressed, TRUE, TRUE)
	print_backstory(H)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)

/datum/emergency_call/upp_commando/low_threat
	name = "UPP突击队"

/datum/emergency_call/upp_commando/low_threat/create_member(datum/mind/mind, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/person = new(spawn_loc)
	mind.transfer_to(person, TRUE)

	if(!leader && HAS_FLAG(person.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(person.client, JOB_SQUAD_LEADER, time_required_for_job))    //First one spawned is always the leader.
		leader = person
		arm_equipment(person, /datum/equipment_preset/upp/commando/leader/low_threat, TRUE, TRUE)
		to_chat(person, SPAN_ROLE_HEADER("你是进步人民联盟的一名突击队队长，这是一个能与美利坚合众国抗衡的强大社会主义国家！"))
	else if(medics < max_medics && HAS_FLAG(person.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(person.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		to_chat(person, SPAN_ROLE_HEADER("你是进步人民联盟的一名突击队医疗兵，这是一个能与美利坚合众国抗衡的强大社会主义国家！"))
		arm_equipment(person, /datum/equipment_preset/upp/commando/medic/low_threat, TRUE, TRUE)
	else
		to_chat(person, SPAN_ROLE_HEADER("你是进步人民联盟的一名突击队员，这是一个能与美利坚合众国抗衡的强大社会主义国家！"))
		arm_equipment(person, /datum/equipment_preset/upp/commando/low_threat, TRUE, TRUE)
	print_backstory(person)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), person, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)
