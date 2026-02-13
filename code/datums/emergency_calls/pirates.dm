
//A gaggle of gladiators
/datum/emergency_call/pirates
	name = "娱乐 - 海盗"
	mob_max = 35
	mob_min = 10
	arrival_message = "'What shall we do with a drunken sailor? What shall we do with a drunken sailor? What shall we do with a drunken sailor early in the morning?'"
	objectives = "Pirate! Loot! Ransom!"
	probability = 0
	hostility = TRUE

/datum/emergency_call/pirates/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/H = new(spawn_loc)
	M.transfer_to(H, TRUE)
	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = H
		arm_equipment(H, /datum/equipment_preset/fun/pirate/captain, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是这群快乐海盗的头儿！"))
		to_chat(H, SPAN_ROLE_BODY("把这地方值钱的东西都抢光！所有没钉死的好东西都拿走！"))
	else
		arm_equipment(H, /datum/equipment_preset/fun/pirate, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是个快乐的海盗！哟嚯！"))
		to_chat(H, SPAN_ROLE_BODY("把这地方值钱的东西都抢光！所有没钉死的好东西都拿走！"))

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)
