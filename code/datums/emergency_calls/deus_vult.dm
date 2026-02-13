
//A gaggle of gladiators
/datum/emergency_call/deus_vult
	name = "神意如此！"
	mob_max = 35
	mob_min = 10
	max_heavies = 10
	arrival_message = "'Deus le volt. Deus le volt! DEUS LE VOLT!!'"
	objectives = "Clense the place of all that is unholy! Die in glory!"
	probability = 0
	hostility = TRUE

/datum/emergency_call/deus_vult/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/H = new(spawn_loc)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = H
		arm_equipment(H, /datum/equipment_preset/other/gladiator/leader, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是这些神圣战士的领袖！"))
		to_chat(H, SPAN_ROLE_BODY("你必须清除这污秽之地中所有不洁的痕迹！"))
		to_chat(H, SPAN_ROLE_BODY("直接服从上级的一切命令！"))
	else if(heavies < max_heavies && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_HEAVY))
		heavies++
		arm_equipment(H, /datum/equipment_preset/other/gladiator/champion, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是神圣战士的冠军！"))
		to_chat(H, SPAN_ROLE_BODY("你必须清除这污秽之地中所有不洁的痕迹！"))
		to_chat(H, SPAN_ROLE_BODY("直接服从上级的一切命令！"))
	else
		arm_equipment(H, /datum/equipment_preset/other/gladiator, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("你是一名神圣战士！"))
		to_chat(H, SPAN_ROLE_BODY("你必须清除这污秽之地中所有不洁的痕迹！"))
		to_chat(H, SPAN_ROLE_BODY("直接服从上级的一切命令！"))


	to_chat(M, SPAN_WARNING(FONT_SIZE_HUGE("YOU ARE [hostility? "HOSTILE":"FRIENDLY"] to the USCM.")))

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)
