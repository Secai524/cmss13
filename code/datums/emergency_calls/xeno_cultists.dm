//Xeno Cultists
/datum/emergency_call/xeno_cult
	name = "异形邪教徒"
	mob_max = 6
	arrival_message = "'Ia! Ia!'"
	objectives = "Support the Xenomorphs in any way, up to and including giving your life for them!"
	probability = 0
	hostility = TRUE
	var/max_synths = 1
	var/synths = 0

/datum/emergency_call/xeno_cult/print_backstory(mob/living/carbon/human/H)
	to_chat(H, SPAN_BOLD("异形降临内罗伊德星区！是时候将它们的荣光播撒群星！"))

/datum/emergency_call/xeno_cult/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/H = new(spawn_loc)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = H
		to_chat(H, SPAN_ROLE_HEADER("你是这支异形邪教的首领！为女王陛下带来荣耀！"))
		arm_equipment(H, /datum/equipment_preset/other/xeno_cultist/leader, TRUE, TRUE)
	else if(synths < max_synths && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_SYNTH) && H.client.check_whitelist_status(WHITELIST_SYNTHETIC))
		synths++
		to_chat(H, SPAN_ROLE_HEADER("你是异形邪教的合成人！照料巢穴与被俘宿主，确保巢穴壮大！"))
		arm_equipment(H, /datum/equipment_preset/synth/survivor/cultist_synth, TRUE, TRUE)
	else
		to_chat(H, SPAN_ROLE_HEADER("你是一名异形邪教徒！遵循女王陛下、女王以及你教派首领的命令，按此顺序！"))
		arm_equipment(H, /datum/equipment_preset/other/xeno_cultist, TRUE, TRUE)
	print_backstory(H)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)
