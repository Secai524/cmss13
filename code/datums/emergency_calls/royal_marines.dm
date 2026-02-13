/datum/emergency_call/royal_marines
	name = "皇家海军陆战队突击队（小队）（友好）"
	mob_max = 6
	probability = 15
	home_base = /datum/lazy_template/ert/twe_station
	shuttle_id = MOBILE_SHUTTLE_ID_ERT4
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_twe
	item_spawn = /obj/effect/landmark/ert_spawns/distress_twe/item
	max_engineers =  1
	max_medics = 1
	max_heavies = 2

/datum/emergency_call/royal_marines/New()
	..()
	arrival_message = "[MAIN_SHIP_NAME], this is [pick_weight(list("HMS Patna"= 50, "HMS Thunderchild" = 50))]; we are responding to your distress call and boarding in accordance with the Military Aid Act of 2177, Authentication code Lima-18153."
	objectives = "Ensure the survival of the [MAIN_SHIP_NAME], eliminate any hostiles, and assist the crew in any way possible."


/datum/emergency_call/royal_marines/create_member(datum/mind/spawning_mind, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	spawning_mind.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("你是皇家海军陆战队突击队的一名军官。出生于三世界帝国。"))
		arm_equipment(mob, /datum/equipment_preset/twe/royal_marine/team_leader, TRUE, TRUE)

	else if(heavies < max_heavies && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_HEAVY) && check_timelock(mob.client, JOB_SQUAD_SPECIALIST))
		var/specialist_kit = pick("Sniper", "Smartgun")
		switch(specialist_kit)
			if("Sniper")
				to_chat(mob, SPAN_ROLE_HEADER("你是皇家海军陆战队突击队的一名神射手。出生于三世界帝国。"))
				arm_equipment(mob, /datum/equipment_preset/twe/royal_marine/spec/marksman, TRUE, TRUE)
			if("Smartgun")
				to_chat(mob, SPAN_ROLE_HEADER("你是皇家海军陆战队突击队的一名智能枪手。出生于三世界帝国。"))
				arm_equipment(mob, /datum/equipment_preset/twe/royal_marine/spec/machinegun, TRUE, TRUE)
		heavies++

	else if(medics < max_medics && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(mob.client, JOB_SQUAD_MEDIC, time_required_for_job))
		to_chat(mob, SPAN_ROLE_HEADER("你是皇家海军陆战队突击队的一名医疗兵兼外科医生。出生于三世界帝国。"))
		arm_equipment(mob, /datum/equipment_preset/twe/royal_marine/medic, TRUE, TRUE)
		medics++

	else if(engineers < max_engineers && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_ENGINEER) && check_timelock(mob.client, JOB_SQUAD_ENGI, time_required_for_job))
		to_chat(mob, SPAN_ROLE_HEADER("你是皇家海军陆战队突击队的一名近战专家。出生于三世界帝国。"))
		arm_equipment(mob, /datum/equipment_preset/twe/royal_marine/spec/breacher, TRUE, TRUE)
		engineers++

	else
		to_chat(mob, SPAN_ROLE_HEADER("你是皇家海军陆战队突击队的一员。出生于三世界帝国。"))
		arm_equipment(mob, /datum/equipment_preset/twe/royal_marine/standard, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)


/datum/emergency_call/royal_marines/print_backstory(mob/living/carbon/human/spawning_mob)
	to_chat(spawning_mob, SPAN_BOLD("你出生在三世界帝国的一个[pick_weight(list("average" = 75, "poor" = 15, "well-established" = 10))] family."))
	to_chat(spawning_mob, SPAN_BOLD("加入皇家海军陆战队让你获得了丰富的战斗经验和实用技能。"))
	to_chat(spawning_mob, SPAN_BOLD("你是[pick_weight(list("unaware" = 70, "faintly aware" = 20, "knowledgeable" = 10))] of the xenomorph threat."))
	to_chat(spawning_mob, SPAN_BOLD("你是三世界帝国的公民，并加入了皇家海军陆战队突击队。"))
	to_chat(spawning_mob, SPAN_BOLD("你是UA/TWE联合特遣队的一员，部署在HMS Patna号和Thunderchild号上。"))
	to_chat(spawning_mob, SPAN_BOLD("根据RMC最高指挥部的指令，你一直在协助USCM部队维持该地区的和平。"))
	to_chat(spawning_mob, SPAN_BOLD("尽你所能协助[MAIN_SHIP_NAME]上的USCMC部队。"))

/datum/emergency_call/royal_marines/platoon
	name = "皇家海军陆战队突击队（排级）（友军）"
	mob_min = 7
	mob_max = 28
	probability = 0
	max_medics = 4
	max_heavies = 8
	max_engineers = 4

/obj/effect/landmark/ert_spawns/distress_twe
	name = "求救信号_TWE"
	icon_state = "spawn_distress_twe"

/obj/effect/landmark/ert_spawns/distress_twe/item
	name = "求救信号_TWE物品"
	icon_state = "distress_item"
