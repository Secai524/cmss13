//Best ert ever

/datum/emergency_call/souto
	name = "索托人"
	mob_max = 1
	mob_min = 1
	objectives = "Party like it's 1999!"
	probability = 0

/datum/emergency_call/souto/New()
	arrival_message = "Give a round of applause for the marine who sent in ten-thousand Souto tabs to get me here! [MAIN_SHIP_NAME], Souto Man's here to party with YOU!"
	return ..()

/datum/emergency_call/souto/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/H = new(spawn_loc)
	M.transfer_to(H, TRUE)

	arm_equipment(H, /datum/equipment_preset/other/souto, TRUE, TRUE)

	to_chat(H, SPAN_ROLE_HEADER("你是索托侠！你应该提升索托品牌的知名度！"))
	to_chat(H, SPAN_ROLE_BODY("你的职责是尽情狂欢并分享索托。确保那些陆战队员永不口渴！"))

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)

/datum/emergency_call/souto/cryo
	name = "索托人（冷冻舱）"
	probability = 0
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_cryo
	shuttle_id = ""
