

//whiskey outpost extra marines
/datum/emergency_call/tank_crew
	name = "载具组员冷冻舱增援"
	mob_max = 2
	mob_min = 2
	probability = 0
	objectives = "Assist the USCM forces"
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_cryo
	shuttle_id = ""

/datum/emergency_call/tank_crew/create_member(datum/mind/M, turf/override_spawn_loc)
	set waitfor = 0
	if(SSmapping.configs[GROUND_MAP].map_name == MAP_WHISKEY_OUTPOST)
		name_of_spawn = /obj/effect/landmark/ert_spawns/distress_wo
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/H = new(spawn_loc)
	M.transfer_to(H, TRUE)

	sleep(5)
	arm_equipment(H, /datum/equipment_preset/uscm/tank/full, TRUE, TRUE)
	to_chat(H, SPAN_ROLE_HEADER("你是USCM的一名载具组员。"))
	to_chat(H, SPAN_ROLE_BODY("你奉命前来协助防御[SSmapping.configs[GROUND_MAP].map_name]。听从指挥链。"))
	to_chat(H, SPAN_BOLDWARNING("若在生成后希望进入冷冻舱或成为观察者，必须向管理员求助并告知，以便安排替换人员。"))

	sleep(10)
	to_chat(H, SPAN_BOLD("任务目标：[objectives]"))

	GLOB.data_core.manifest_inject(H) //Put people in crew manifest
