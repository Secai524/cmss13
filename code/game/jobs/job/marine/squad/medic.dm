/datum/job/marine/medic
	title = JOB_SQUAD_MEDIC
	total_positions = 16
	spawn_positions = 16
	allow_additional = 1
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/medic
	entry_message_body = "<a href='"+WIKI_PLACEHOLDER+"'>你治疗小队队友的伤口</a>，确保他们健康且活跃。你可能不是一名完全合格的医生，但在关键时刻你站在生与死之间。"

/datum/job/marine/medic/set_spawn_positions(count)
	for(var/datum/squad/target_squad in GLOB.RoleAuthority.squads)
		if(target_squad)
			target_squad.roles_cap[title] = medic_slot_formula(count)

/datum/job/marine/medic/get_total_positions(latejoin=0)
	var/slots = medic_slot_formula(get_total_marines())

	if(slots <= total_positions_so_far)
		slots = total_positions_so_far
	else
		total_positions_so_far = slots

	if(latejoin)
		for(var/datum/squad/target_squad in GLOB.RoleAuthority.squads)
			if(target_squad)
				target_squad.roles_cap[title] = slots

	return (slots*4)

/datum/job/marine/medic/whiskey
	title = JOB_WO_SQUAD_MEDIC
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/wo/marine/medic

AddTimelock(/datum/job/marine/medic, list(
	JOB_MEDIC_ROLES = 1 HOURS,
	JOB_SQUAD_ROLES = 1 HOURS
))

/obj/effect/landmark/start/marine/medic
	name = JOB_SQUAD_MEDIC
	icon_state = "medic_spawn"
	job = /datum/job/marine/medic

/obj/effect/landmark/start/marine/medic/alpha
	icon_state = "medic_spawn_alpha"
	squad = SQUAD_MARINE_1

/obj/effect/landmark/start/marine/medic/bravo
	icon_state = "medic_spawn_bravo"
	squad = SQUAD_MARINE_2

/obj/effect/landmark/start/marine/medic/charlie
	icon_state = "medic_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/medic/delta
	icon_state = "medic_spawn_delta"
	squad = SQUAD_MARINE_4
