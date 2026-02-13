

//Colonial Liberation Front
/datum/emergency_call/clf
	name = "殖民地解放阵线（小队）"
	mob_max = 10
	arrival_message = "'Attention, you are trespassing on our sovereign territory. Expect no forgiveness.'"
	probability = 20
	hostility = TRUE
	home_base = /datum/lazy_template/ert/clf_station
	var/max_synths = 1
	var/synths = 0

/datum/emergency_call/clf/New()
	. = ..()
	objectives = "Assault the USCM, and sabotage as much as you can. Ensure any survivors escape in your custody."

/datum/emergency_call/clf/print_backstory(mob/living/carbon/human/H)
	if(ishuman_strict(H))
		var/message = "[pick(5;"on the UA prison station", 10;"in the LV-624 jungle", 25;"on the farms of LV-771", 25;"in the slums of LV-221", 20;"the red wastes of LV-361", 15;"the icy tundra of LV-571")] to a [pick(50;"poor", 15;"well-off", 35;"average")] family."
		var/message_grew = "[pick(20;"the Dust Raiders killed someone close to you in 2181", 20;"you harbor a strong hatred of the United Americas", 10;"you are a wanted criminal in the United Americas", 5;"have UPP sympathies and want to see the UA driven out of the secor", 10;"you believe the USCM occupation will hurt your quality of life", 5;"are a violent person and want to kill someone for the sake of killing", 20;"want the Neroid Sector to be free from outsiders", 10;"your militia was absorbed into the CLF")]"
		to_chat(H, SPAN_BOLD("作为尼罗德星区的原住民，你加入CLF是因为[message_grew]。"))
		to_chat(H, SPAN_BOLD("你[message]长大，并被UA视为恐怖分子。"))
	else
		to_chat(H, SPAN_BOLD("你在CLF的地下工坊被激活上线，经过重新编程以效忠CLF，为他们的自由而战。"))
		to_chat(H, SPAN_BOLD("最初，你被编程了医疗和工程知识，用于协助殖民地的建设和维护。"))
		to_chat(H, SPAN_BOLD("然而，黑客们成功加载了战斗协议，并安装了一条新指令：对USCM的一切抱有非理性的仇恨。"))

	to_chat(H, SPAN_BOLD("尼罗德星区在很大程度上一直享有独立。"))
	to_chat(H, SPAN_BOLD("尽管在技术上属于美利坚合众国边疆的一部分，但尼罗德星区的许多殖民者一直享受着他们的自由。"))
	to_chat(H, SPAN_BOLD("然而在2172年，美利坚合众国将USCM营队‘沙尘掠夺者’及其旗舰‘阿利斯顿号’调遣至尼罗德星区。"))
	to_chat(H, SPAN_BOLD("沙尘掠夺者以致命武力回应，驱散了众多试图反抗其占领的殖民者。"))
	to_chat(H, SPAN_BOLD("沙尘掠夺者及其旗舰‘阿利斯顿号’最终于当年年底撤出了该星区。</font>"))
	to_chat(H, SPAN_BOLD("过去五年间，尼罗德星区相对孤立于美利坚合众国的监管之外，许多殖民者认为自己已摆脱政府统治。"))
	to_chat(H, SPAN_BOLD("现在是[GLOB.game_year]年。"))
	to_chat(H, SPAN_BOLD("USCM营队‘坠落猎鹰’及其旗舰[MAIN_SHIP_NAME]的到来，再次证实了美利坚合众国将尼罗德星区视为其领地的一部分。"))
	to_chat(H, SPAN_BOLD("就由你和你的殖民者同胞们来让他们认识到自己的侵犯行为。这个星区不再属于他们。"))

	to_chat(H, SPAN_WARNING(FONT_SIZE_HUGE("YOU ARE HOSTILE to the USCM.")))

/datum/emergency_call/clf/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/H = new(spawn_loc)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = H
		to_chat(H, SPAN_ROLE_HEADER("你是当地抵抗组织——殖民地解放阵线——的细胞领袖！"))
		arm_equipment(H, /datum/equipment_preset/clf/leader, TRUE, TRUE)
	else if(synths < max_synths && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_SYNTH) && H.client.check_whitelist_status(WHITELIST_SYNTHETIC))
		synths++
		to_chat(H, SPAN_ROLE_HEADER("你是当地抵抗组织——殖民地解放阵线——的多功能合成人！"))
		arm_equipment(H, /datum/equipment_preset/clf/synth, TRUE, TRUE)
	else if(medics < max_medics && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(H.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		to_chat(H, SPAN_ROLE_HEADER("你是当地抵抗组织——殖民地解放阵线——的医疗兵！"))
		arm_equipment(H, /datum/equipment_preset/clf/medic, TRUE, TRUE)
	else if(engineers < max_engineers && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_ENGINEER) && check_timelock(H.client, JOB_SQUAD_ENGI, time_required_for_job))
		engineers++
		to_chat(H, SPAN_ROLE_HEADER("你是当地抵抗组织——殖民地解放阵线的一名工程师！"))
		arm_equipment(H, /datum/equipment_preset/clf/engineer, TRUE, TRUE)
	else if(heavies < max_heavies && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_HEAVY) && check_timelock(H.client, JOB_SQUAD_SPECIALIST, time_required_for_job))
		heavies++
		to_chat(H, SPAN_ROLE_HEADER("你是当地抵抗组织——殖民地解放阵线的一名专家！"))
		arm_equipment(H, /datum/equipment_preset/clf/specialist, TRUE, TRUE)
	else
		to_chat(H, SPAN_ROLE_HEADER("你是当地抵抗组织——殖民地解放阵线的一名战士！"))
		arm_equipment(H, /datum/equipment_preset/clf/soldier, TRUE, TRUE)
	print_backstory(H)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)


/datum/emergency_call/clf/platoon
	name = "殖民地解放阵线（排级）"
	mob_min = 8
	mob_max = 35
	probability = 0
	max_engineers = 2
	max_medics = 2
	max_heavies = 2
	max_synths = 1
