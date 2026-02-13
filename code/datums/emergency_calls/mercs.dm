


//Randomly-equipped mercenaries. May be friendly or hostile to the USCM, hostile to xenos.
/datum/emergency_call/mercs
	name = "自由佣兵（班）"
	mob_max = 8
	probability = 20


/datum/emergency_call/mercs/New()
	. = ..()
	hostility = pick(75;FALSE,25;TRUE)
	arrival_message = "[MAIN_SHIP_NAME], this is Freelancer shuttle [pick(GLOB.alphabet_lowercase)][pick(GLOB.alphabet_lowercase)]-[rand(1, 99)] responding to your distress call. Prepare for boarding."
	if(hostility)
		objectives = "Ransack the [MAIN_SHIP_NAME] and kill anyone who gets in your way. Do what your Warlord says. Ensure your survival at all costs."
	else
		objectives = "Help the crew of the [MAIN_SHIP_NAME] in exchange for payment, and choose your payment well. Do what your Warlord says. Ensure your survival at all costs."

/datum/emergency_call/mercs/friendly //if admins want to specifically call in friendly ones
	name = "友善自由佣兵（班）"
	mob_max = 8
	probability = 0

/datum/emergency_call/mercs/friendly/New()
	. = ..()
	hostility = FALSE
	arrival_message = "[MAIN_SHIP_NAME], this is Freelancer shuttle [pick(GLOB.alphabet_lowercase)][pick(GLOB.alphabet_lowercase)]-[rand(1, 99)] responding to your distress call. Prepare for boarding."
	objectives = "Help the crew of the [MAIN_SHIP_NAME] in exchange for payment, and choose your payment well. Do what your Warlord says. Ensure your survival at all costs."

/datum/emergency_call/mercs/hostile //ditto
	name = "敌对自由佣兵（班）"
	mob_max = 8
	probability = 0

/datum/emergency_call/mercs/hostile/New()
	. = ..()
	hostility = TRUE
	arrival_message = "[MAIN_SHIP_NAME], this is Freelancer shuttle [pick(GLOB.alphabet_lowercase)][pick(GLOB.alphabet_lowercase)]-[rand(1, 99)] responding to your distress call. Prepare for boarding."
	objectives = "Ransack the [MAIN_SHIP_NAME] and kill anyone who gets in your way. Do what your Warlord says. Ensure your survival at all costs."

/datum/emergency_call/mercs/print_backstory(mob/living/carbon/human/H)
	to_chat(H, SPAN_BOLD("你最初在内罗伊德星区作为一名殖民者，在某个已建立的殖民地寻找工作。"))
	to_chat(H, SPAN_BOLD("随着美国联合部队在2180年代初期的撤离，该星系陷入混乱。"))
	to_chat(H, SPAN_BOLD("拿起武器成为雇佣兵，自由佣兵已成为该星系一股强大的秩序力量。"))
	to_chat(H, SPAN_BOLD("虽然他们主要受金钱驱使，但许多殖民者将自由佣兵视为内罗伊德星区主要的秩序维护者。"))
	if(hostility)
		to_chat(H, SPAN_NOTICE(SPAN_BOLD("Despite this, you have been tasked to ransack the [MAIN_SHIP_NAME] and kill anyone who gets in your way.")))
		to_chat(H, SPAN_NOTICE(SPAN_BOLD("Any UPP, CLF or WY forces also responding are to be considered neutral parties unless proven hostile.")))
	else
		to_chat(H, SPAN_NOTICE(SPAN_BOLD("To this end, you have been contacted by Weyland-Yutani of the USCSS Royce to assist the [MAIN_SHIP_NAME]..")))
		to_chat(H, SPAN_NOTICE(SPAN_BOLD("Ensure they are not destroyed.</b>")))
	to_chat(H, SPAN_WARNING(FONT_SIZE_HUGE("YOU ARE [hostility? "HOSTILE":"FRIENDLY"] to the USCM.")))

/datum/emergency_call/mercs/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/H = new(spawn_loc)
	H.name = H.real_name
	M.transfer_to(H, TRUE)
	H.job = "雇佣兵"

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = H
		arm_equipment(H, /datum/equipment_preset/other/freelancer/leader, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是自由佣兵首领！"))
	else if(medics < max_medics && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(H.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		arm_equipment(H, /datum/equipment_preset/other/freelancer/medic, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是一名自由佣兵医疗兵！"))
	else
		arm_equipment(H, /datum/equipment_preset/other/freelancer/standard, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是一名自由佣兵！"))
	print_backstory(H)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)

/datum/emergency_call/mercs/platoon
	name = "自由佣兵（排）"
	mob_min = 8
	mob_max = 30
	probability = 0
	max_medics = 3

/datum/emergency_call/heavy_mercs
	name = "精英雇佣兵（随机阵营）"
	mob_min = 4
	mob_max = 8
	probability = 0
	max_medics = 1
	max_engineers = 1
	max_heavies = 1

/datum/emergency_call/heavy_mercs/New()
	. = ..()
	hostility = pick(75;FALSE,25;TRUE)
	arrival_message = "[MAIN_SHIP_NAME], this is Elite Freelancer shuttle [pick(GLOB.alphabet_lowercase)][pick(GLOB.alphabet_lowercase)]-[rand(1, 99)] responding to your distress call. Prepare for boarding."
	if(hostility)
		objectives = "Ransack the [MAIN_SHIP_NAME] and kill anyone who gets in your way. Do what your Captain says. Ensure your survival at all costs."
	else
		objectives = "Help the crew of the [MAIN_SHIP_NAME] in exchange for payment, and choose your payment well. Do what your Captain says. Ensure your survival at all costs."

/datum/emergency_call/heavy_mercs/hostile
	name = "精英雇佣兵（对USCM敌对）"

/datum/emergency_call/heavy_mercs/hostile/New()
	. = ..()
	hostility = TRUE
	arrival_message = "[MAIN_SHIP_NAME], this is Elite Freelancer shuttle [pick(GLOB.alphabet_lowercase)][pick(GLOB.alphabet_lowercase)]-[rand(1, 99)] responding to your distress call. Prepare for boarding."
	objectives = "Ransack the [MAIN_SHIP_NAME] and kill anyone who gets in your way. Do what your Captain says. Ensure your survival at all costs."

/datum/emergency_call/heavy_mercs/friendly
	name = "精英雇佣兵（友善）"

/datum/emergency_call/heavy_mercs/friendly/New()
	. = ..()
	hostility = FALSE
	arrival_message = "[MAIN_SHIP_NAME], this is Elite Freelancer shuttle [pick(GLOB.alphabet_lowercase)][pick(GLOB.alphabet_lowercase)]-[rand(1, 99)] responding to your distress call. Prepare for boarding."
	objectives = "Help the crew of the [MAIN_SHIP_NAME] in exchange for payment, and choose your payment well. Do what your Captain says. Ensure your survival at all costs."

/datum/emergency_call/heavy_mercs/print_backstory(mob/living/carbon/human/H)
	to_chat(H, SPAN_BOLD("你最初在内罗伊德星区作为一名经验丰富的矿工，在某个已建立的殖民地寻找工作。"))
	to_chat(H, SPAN_BOLD("随着美国联合部队在2180年代初期的撤离，该星系陷入混乱。"))
	to_chat(H, SPAN_BOLD("拿起武器成为雇佣兵，自由佣兵已成为该星系一股强大的秩序力量。"))
	to_chat(H, SPAN_BOLD("虽然他们主要受金钱驱使，但许多殖民者将自由佣兵视为内罗伊德星区主要的秩序维护者。"))
	if(hostility)
		to_chat(H, SPAN_NOTICE(SPAN_BOLD("Despite this, you have been specially tasked to ransack the [MAIN_SHIP_NAME] and kill anyone who gets in your way.")))
		to_chat(H, SPAN_NOTICE(SPAN_BOLD("Any UPP, CLF or WY forces also responding are to be considered neutral parties unless proven hostile.")))
	else
		to_chat(H, SPAN_NOTICE(SPAN_BOLD("To this end, you have been contacted by Weyland-Yutani of the USCSS Royce to assist the [MAIN_SHIP_NAME]..")))
		to_chat(H, SPAN_NOTICE(SPAN_BOLD("Ensure they are not destroyed.</b>")))
	to_chat(H, SPAN_WARNING(FONT_SIZE_HUGE("YOU ARE [hostility? "HOSTILE":"FRIENDLY"] to the USCM.")))

/datum/emergency_call/heavy_mercs/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/H = new(spawn_loc)
	H.name = H.real_name
	M.transfer_to(H, TRUE)
	H.job = "雇佣兵"

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, JOB_SQUAD_LEADER, time_required_for_job))    //First one spawned is always the leader.
		leader = H
		arm_equipment(H, /datum/equipment_preset/other/elite_merc/leader, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是精英雇佣兵队长！"))
	else if(medics < max_medics && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(H.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		arm_equipment(H, /datum/equipment_preset/other/elite_merc/medic, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是精英雇佣兵医疗兵！"))
	else if(engineers < max_engineers && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_ENGINEER) && check_timelock(H.client, JOB_SQUAD_ENGI, time_required_for_job))
		engineers++
		arm_equipment(H, /datum/equipment_preset/other/elite_merc/engineer, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是精英雇佣兵工程师！"))
	else if(heavies < max_heavies && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_SMARTGUNNER) && check_timelock(H.client, JOB_SQUAD_SMARTGUN, time_required_for_job))
		heavies++
		arm_equipment(H, /datum/equipment_preset/other/elite_merc/heavy, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是精英雇佣兵专家！"))
	else
		arm_equipment(H, /datum/equipment_preset/other/elite_merc/standard, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是精英雇佣兵！"))
	print_backstory(H)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)
