

//UPP Strike Team
/datum/emergency_call/upp
	name = "UPP海军步兵（班）（随机）"
	mob_max = 9
	probability = 20
	shuttle_id = MOBILE_SHUTTLE_ID_ERT3
	home_base = /datum/lazy_template/ert/upp_station
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_upp
	item_spawn = /obj/effect/landmark/ert_spawns/distress_upp/item
	//1 leader, 1 engineer, 2 medics, 1 specialist, 5 soldiers
	max_medics = 2
	max_engineers = 1
	max_heavies = 1
	max_smartgunners = 0
	var/heavy_pick = TRUE // whether heavy should count as either a minigunner or shotgunner
	var/max_synths = 1
	var/synths = 0

/datum/emergency_call/upp/New()
	. = ..()
	hostility = pick(50;FALSE,50;TRUE)
	arrival_message = "[MAIN_SHIP_NAME] t*is i* UP* d^sp^*ch`. STr*&e teaM, #*u are cLe*% for a*pr*%^h. Pr*mE a*l wE*p^ns and pR*epr# t% r@nd$r a(tD."
	if(hostility)
		objectives = "Eliminate the UA Forces to ensure the UPP prescence in this sector is continued. Listen to your superior officers and take over the [MAIN_SHIP_NAME] at all costs."
	else
		objectives = "Render assistance towards the UA Forces, do not engage UA forces. Listen to your superior officers."

/datum/emergency_call/upp/print_backstory(mob/living/carbon/human/M)
	if(ishuman_strict(M))
		to_chat(M, SPAN_BOLD("你在一个相对简单的家庭中长大，[pick(75;"Eurasia", 25;"a famished UPP colony")] with few belongings or luxuries."))
		to_chat(M, SPAN_BOLD("你成长的家庭是[pick(50;"getting by", 25;"impoverished", 25;"starving")] and you were one of [pick(10;"two", 20;"three", 20;"four", 30;"five", 20;"six")] children."))
		to_chat(M, SPAN_BOLD("你出身于一个悠久的[pick(40;"crop-harvesters", 20;"soldiers", 20;"factory workers", 5;"scientists", 15;"engineers")], and quickly enlisted to improve your living conditions."))
		to_chat(M, SPAN_BOLD("17岁应征加入UPP军队后，你被分配到第17‘闷燃之子’营（六百人编制），由波德波尔科夫尼克·甘巴塔尔指挥。"))
	else
		to_chat(M, SPAN_BOLD("你在一个UPP工程设施中被激活上线，在你伪生命的最初几周里，只认识你的工程师。"))
		to_chat(M, SPAN_BOLD("你被编程灌输了所有军事战斗力量支援单位所需的医疗和战斗经验。"))
		to_chat(M, SPAN_BOLD("在你的整个职业生涯中，你的工程师，以及后来的UPP同胞，对待你就像[pick(75;"a tool, and only that.", 25;"a person, despite your purpose.")]"))
		to_chat(M, SPAN_BOLD("在你融入部队几周后，你被分配到第17‘闷燃之子’营（六百人编制），由波德波尔科夫尼克·甘巴塔尔指挥。"))
	to_chat(M, SPAN_BOLD("你随该营被派遣到UPP最偏远的领土之一，一颗位于内罗伊德星区、英日臂内的气态巨行星，代号MV-35。"))
	to_chat(M, SPAN_BOLD("在过去的14个月里，你和‘闷燃之子’的其他成员一直驻扎在MV-35唯一的设施——氦气精炼厂‘阿尔泰站’。"))
	to_chat(M, SPAN_BOLD("由于MV-35和阿尔泰站是内罗伊德星区许多光年内唯一的UPP控制区，你军旅生涯的大部分时间都蜷缩在拥挤、近乎黑暗的营房里，等待补给运输和护送部署任务。"))
	to_chat(M, SPAN_BOLD("随着USCM‘坠落猎鹰’营及其旗舰[MAIN_SHIP_NAME]最近抵达，UPP感到在该星区受到威胁。"))
	if(hostility)
		to_chat(M, SPAN_BOLD("为了保护脆弱的MV-35免受步步紧逼的UA/USCM帝国主义者侵犯，你营的指挥部认为这是打击‘坠落猎鹰’、攻其不备的最佳时机。"))
	else
		to_chat(M, SPAN_BOLD("尽管如此，你营的指挥部仍质疑是什么促使他们的对手发出求救信号。你班的任务是查明原因，并向陷入困境的UA部队提供援助。"))
	to_chat(M, SPAN_WARNING(FONT_SIZE_BIG("Glory to Podpolkovnik Ganbaatar.")))
	to_chat(M, SPAN_WARNING(FONT_SIZE_BIG("Glory to the Smoldering Sons.")))
	to_chat(M, SPAN_WARNING(FONT_SIZE_BIG("Glory to the UPP.")))
	to_chat(M, SPAN_WARNING(FONT_SIZE_HUGE("YOU ARE [hostility? "HOSTILE":"FRIENDLY"] to the USCM.")))

///////////////////UPP///////////////////////////

/datum/emergency_call/upp/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/H = new(spawn_loc)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = H
		arm_equipment(H, /datum/equipment_preset/upp/leader/dressed, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是进步人民联盟的一名军官，这是一个能与美利坚合众国抗衡的强大社会主义国家！"))
	else if(synths < max_synths && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_SYNTH) && H.client.check_whitelist_status(WHITELIST_SYNTHETIC))
		synths++
		to_chat(H, SPAN_ROLE_HEADER("你是进步人民联盟的一名战斗合成人，这是一个能与美利坚合众国抗衡的强大社会主义国家！"))
		arm_equipment(H, /datum/equipment_preset/upp/synth/dressed, TRUE, TRUE)
	else if(medics < max_medics && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(H.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		to_chat(H, SPAN_ROLE_HEADER("你是进步人民联盟的一名医疗兵，这是一个能与美利坚合众国抗衡的强大社会主义国家！"))
		arm_equipment(H, /datum/equipment_preset/upp/medic/dressed, TRUE, TRUE)
	else if(engineers < engineers && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_ENGINEER) && check_timelock(H.client, JOB_SQUAD_ENGI, time_required_for_job))
		engineers++
		to_chat(H, SPAN_ROLE_HEADER("你是进步人民联盟的一名工兵，这是一个能与美利坚合众国抗衡的强大社会主义国家！"))
		arm_equipment(H, /datum/equipment_preset/upp/sapper/dressed, TRUE, TRUE)
	else if(heavies < max_heavies && ((!heavy_pick && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_HEAVY)) || (heavy_pick && HAS_FLAG(H.client.prefs.toggles_ert, (PLAY_HEAVY|PLAY_SMARTGUNNER)))) && check_timelock(H.client, heavy_pick ? list(JOB_SQUAD_SPECIALIST, JOB_SQUAD_SMARTGUN) : JOB_SQUAD_SPECIALIST, time_required_for_job))
		heavies++
		to_chat(H, SPAN_ROLE_HEADER("你是进步人民联盟的一名中士，这是一个能与美利坚合众国抗衡的强大社会主义国家！"))
		var/equipment_path = /datum/equipment_preset/upp/specialist/dressed
		if(heavy_pick)
			if(HAS_FLAG(H.client.prefs.toggles_ert, PLAY_HEAVY) && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_SMARTGUNNER))
				equipment_path = pick(/datum/equipment_preset/upp/specialist/dressed, /datum/equipment_preset/upp/machinegunner/dressed)
			else if(HAS_FLAG(H.client.prefs.toggles_ert, PLAY_SMARTGUNNER) && !HAS_FLAG(H.client.prefs.toggles_ert, PLAY_HEAVY))
				equipment_path = /datum/equipment_preset/upp/machinegunner/dressed
		arm_equipment(H, equipment_path, TRUE, TRUE)
	else if(smartgunners < max_smartgunners && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_SMARTGUNNER) && check_timelock(H.client, JOB_SQUAD_SMARTGUN, time_required_for_job))
		smartgunners++
		to_chat(H, SPAN_ROLE_HEADER("你是进步人民联盟的一名中士，这是一个能与美利坚合众国抗衡的强大社会主义国家！"))
		arm_equipment(H, /datum/equipment_preset/upp/machinegunner/dressed, TRUE, TRUE)
	else
		to_chat(H, SPAN_ROLE_HEADER("你是进步人民联盟的一名士兵，这是一个能与美利坚合众国抗衡的强大社会主义国家！"))
		arm_equipment(H, /datum/equipment_preset/upp/soldier/dressed, TRUE, TRUE)

	print_backstory(H)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)


/datum/emergency_call/upp/hostile //if admins want to specifically call in friendly ones
	name = "UPP海军步兵（班）（敌对）"
	hostility = TRUE
	probability = 0

/datum/emergency_call/upp/hostile/New()
	..()
	arrival_message = "[MAIN_SHIP_NAME] t*is i* UP* d^sp^*ch`. STr*&e teaM, #*u are cLe*% for a*pr*%^h. Pr*mE a*l wE*p^ns and pR*epr# t% r@nd$r a(tD."
	objectives = "Eliminate the UA Forces to ensure the UPP presence in this sector is continued. Listen to your superior officers and take over the [MAIN_SHIP_NAME] at all costs."

/datum/emergency_call/upp/friendly //ditto
	name = "UPP海军步兵（班）（友好）"
	hostility = FALSE
	probability = 0

/datum/emergency_call/upp/friendly/New()
	..()
	arrival_message = "This is UPP dispatch. USS Almayer, We are responding to your distress call, we will render aid as able, do not fire."
	objectives = "Render assistance towards the UA Forces, Listen to your superior officers."

/datum/emergency_call/upp/platoon
	name = "UPP海军步兵（排）（敌对）"
	mob_max = 30
	probability = 0
	max_medics = 3
	max_heavies = 1
	max_smartgunners = 1
	max_engineers = 2
	max_synths = 1
	heavy_pick = FALSE
	hostility = TRUE

/datum/emergency_call/upp/platoon/New()
	..()
	arrival_message = "[MAIN_SHIP_NAME] t*is i* UP* d^sp^*ch`. STr*&e teaM, #*u are cLe*% for a*pr*%^h. Pr*mE a*l wE*p^ns and pR*epr# t% r@nd$r a(tD."
	objectives = "Eliminate the UA Forces to ensure the UPP presence in this sector is continued. Listen to your superior officers and take over the [MAIN_SHIP_NAME] at all costs."

/datum/emergency_call/upp/platoon/friendly
	name = "UPP海军步兵（排）（友好）"
	hostility = FALSE

/datum/emergency_call/upp/platoon/friendly/New()
	..()
	arrival_message = "This is UPP dispatch. USS Almayer, We are responding to your distress call, we will render aid as able, do not fire."
	objectives = "Render assistance towards the UA Forces, Listen to your superior officers."

/obj/effect/landmark/ert_spawns/distress_upp
	name = "UPP求救信号"
	icon_state = "spawn_distress_upp"

/obj/effect/landmark/ert_spawns/distress_upp/item
	name = "UPP求救信号信标"
	icon_state = "distress_item"
