/datum/job/marine/leader
	title = JOB_SQUAD_LEADER
	total_positions = 4
	spawn_positions = 4
	supervisors = "代理指挥官"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/leader
	entry_message_body = "<a href='"+WIKI_PLACEHOLDER+"'>你对你小队的男女士兵负责。</a> 确保他们执行任务、协同合作并保持沟通。你还负责与指挥部沟通，让他们第一时间了解情况。远离危险。"

/datum/job/marine/leader/whiskey
	title = JOB_WO_SQUAD_LEADER
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/wo/marine/sl

AddTimelock(/datum/job/marine/leader, list(
	JOB_SQUAD_ROLES = 10 HOURS
))

/obj/effect/landmark/start/marine/leader
	name = JOB_SQUAD_LEADER
	icon_state = "leader_spawn"
	job = /datum/job/marine/leader

/obj/effect/landmark/start/marine/leader/alpha
	icon_state = "leader_spawn_alpha"
	squad = SQUAD_MARINE_1

/obj/effect/landmark/start/marine/leader/bravo
	icon_state = "leader_spawn_bravo"
	squad = SQUAD_MARINE_2

/obj/effect/landmark/start/marine/leader/charlie
	icon_state = "leader_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/leader/delta
	icon_state = "leader_spawn_delta"
	squad = SQUAD_MARINE_4
