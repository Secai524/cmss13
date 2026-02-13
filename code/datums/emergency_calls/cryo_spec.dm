/datum/emergency_call/cryo_spec
	name = "陆战队员冷冻增援（专家）"
	mob_max = 1
	mob_min = 1
	probability = 0
	objectives = "Assist the USCM forces"
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_cryo
	shuttle_id = ""
	spawn_max_amount = TRUE

/datum/emergency_call/cryo_spec/remove_nonqualifiers(list/datum/mind/candidates_list)
	var/list/datum/mind/candidates_clean = list()
	for(var/datum/mind/single_candidate in candidates_list)
		if(check_timelock(single_candidate.current?.client, JOB_SQUAD_ROLES_LIST, time_required_for_job))
			candidates_clean.Add(single_candidate)
			continue
		if(single_candidate.current)
			to_chat(single_candidate.current, SPAN_WARNING("你未获得ERT信标资格，因为你尚未解锁专家职位！"))
	return candidates_clean

/datum/emergency_call/cryo_spec/create_member(datum/mind/mind, turf/override_spawn_loc)
	set waitfor = FALSE
	if(SSmapping.configs[GROUND_MAP].map_name == MAP_WHISKEY_OUTPOST)
		name_of_spawn = /obj/effect/landmark/ert_spawns/distress_wo
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/human = new(spawn_loc)

	if(mind)
		mind.transfer_to(human, TRUE)
	else
		human.create_hud()

	if(!mind)
		FOR_DVIEW(var/obj/structure/machinery/cryopod/pod, 7, human, HIDE_INVISIBLE_OBSERVER)
			if(pod && !pod.occupant)
				pod.go_in_cryopod(human, silent = TRUE)
				break
		FOR_DVIEW_END

	sleep(5)
	human.client?.prefs.copy_all_to(human, JOB_SQUAD_SPECIALIST, TRUE, TRUE)
	arm_equipment(human, /datum/equipment_preset/uscm/spec/cryo,  mind == null, TRUE)
	to_chat(human, SPAN_ROLE_HEADER("你是USCM的一名武器专家。"))
	to_chat(human, SPAN_ROLE_BODY("你的班奉命前来协助防御[SSmapping.configs[GROUND_MAP].map_name]。听从指挥链。"))
	to_chat(human, SPAN_BOLDWARNING("若在生成后希望进入冷冻舱或成为观察者，必须向管理员求助并告知，以便安排替换人员。"))

	sleep(10)
	if(!mind)
		human.free_for_ghosts()
	to_chat(human, SPAN_BOLD("任务目标：[objectives]"))
