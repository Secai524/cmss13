/datum/emergency_call/solar_devils
	name = "USCM 太阳恶魔（半班）"
	arrival_message = "This is the Solar Devils of the USCM 2nd Division, responding to your distress beacon. Don't worry, the grown-ups are here to clean up your mess."
	objectives = "Assist local Marine forces in dealing with whatever issue they can't handle. Further orders may be forthcoming."
	home_base = /datum/lazy_template/ert/uscm_station
	probability = 0
	mob_min = 3
	mob_max = 5

	max_medics = 1
	max_smartgunners = 1

/datum/emergency_call/solar_devils/create_member(datum/mind/new_mind, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	new_mind.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		arm_equipment(mob, /datum/equipment_preset/uscm/pve/tl, TRUE, TRUE)
		to_chat(mob, SPAN_ROLE_HEADER("你是太阳恶魔小队队长！"))

	else if(medics < max_medics && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(mob.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		arm_equipment(mob, /datum/equipment_preset/uscm/pve/medic, TRUE, TRUE)
		to_chat(mob, SPAN_ROLE_HEADER("你是太阳恶魔排的医疗兵！"))

	else if(smartgunners < max_smartgunners && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_SMARTGUNNER) && check_timelock(mob.client, JOB_SQUAD_SMARTGUN))
		smartgunners++
		to_chat(mob, SPAN_ROLE_HEADER("你是太阳恶魔的智能枪手！"))
		arm_equipment(mob,/datum/equipment_preset/uscm/pve/sg, TRUE, TRUE)

	else
		arm_equipment(mob, /datum/equipment_preset/uscm/pve, TRUE, TRUE)
		to_chat(mob, SPAN_ROLE_HEADER("你是太阳恶魔的步枪兵！"))

	to_chat(mob, SPAN_ROLE_BODY("你是USCM第2师第1团第3营‘太阳恶魔’的一员。与阿尔迈耶号上的大多数部队不同，你是训练有素、装备精良的职业陆战队员。永远忠诚。"))
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)

/datum/emergency_call/solar_devils_full
	name = "USCM 太阳恶魔（满编班）"
	arrival_message = "This is the Solar Devils of the USCM 2nd Division, responding to your distress beacon. Don't worry, the grown-ups are here to clean up your mess."
	objectives = "Assist local Marine forces in dealing with whatever issue they can't handle. Further orders may be forthcoming."
	home_base = /datum/lazy_template/ert/uscm_station
	probability = 0
	mob_min = 3
	mob_max = 10

	max_engineers = 2
	max_medics = 1
	max_smartgunners = 2

/datum/emergency_call/solar_devils_full/create_member(datum/mind/new_mind, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	new_mind.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		arm_equipment(mob, /datum/equipment_preset/uscm/pve/sl, TRUE, TRUE)
		to_chat(mob, SPAN_ROLE_HEADER("你是太阳恶魔排长！"))

	else if(engineers < max_engineers && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_ENGINEER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		engineers++
		arm_equipment(mob, /datum/equipment_preset/uscm/pve/tl, TRUE, TRUE)
		to_chat(mob, SPAN_ROLE_HEADER("你是太阳恶魔小队队长！"))

	else if(medics < max_medics && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(mob.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		arm_equipment(mob, /datum/equipment_preset/uscm/pve/medic, TRUE, TRUE)
		to_chat(mob, SPAN_ROLE_HEADER("你是太阳恶魔排的医疗兵！"))

	else if(smartgunners < max_smartgunners && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_SMARTGUNNER) && check_timelock(mob.client, JOB_SQUAD_SMARTGUN))
		smartgunners++
		to_chat(mob, SPAN_ROLE_HEADER("你是太阳恶魔的智能枪手！"))
		arm_equipment(mob, /datum/equipment_preset/uscm/pve/sg, TRUE, TRUE)

	else
		arm_equipment(mob, /datum/equipment_preset/uscm/pve, TRUE, TRUE)
		to_chat(mob, SPAN_ROLE_HEADER("你是太阳恶魔的步枪兵！"))

	to_chat(mob, SPAN_ROLE_BODY("你是USCM第2师第1团第3营‘太阳恶魔’的一员。与阿尔迈耶号上的大多数部队不同，你是训练有素、装备精良的职业陆战队员。永远忠诚。"))
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)
