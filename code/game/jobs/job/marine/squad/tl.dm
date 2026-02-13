/datum/job/marine/tl
	title = JOB_SQUAD_TEAM_LEADER
	total_positions = 8
	spawn_positions = 8
	allow_additional = 1
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/tl
	entry_message_body = "你是<a href='"+WIKI_PLACEHOLDER+"'>火力小组组长。</a> 你的任务是协助小队长领导小队，以及使用轨道轰炸、近距离空中支援和迫击炮等军械，并与军需部和指挥信息中心协调补给。如果小队长阵亡，你将被期望接替其领导职责。"

/datum/job/marine/tl/generate_entry_conditions(mob/living/carbon/human/spawning_human)
	. = ..()
	spawning_human.important_radio_channels += JTAC_FREQ

AddTimelock(/datum/job/marine/tl, list(
	JOB_SQUAD_ROLES = 8 HOURS
))

/obj/effect/landmark/start/marine/tl
	name = JOB_SQUAD_TEAM_LEADER
	icon_state = "tl_spawn"
	job = /datum/job/marine/tl

/obj/effect/landmark/start/marine/tl/alpha
	icon_state = "tl_spawn_alpha"
	squad = SQUAD_MARINE_1

/obj/effect/landmark/start/marine/tl/bravo
	icon_state = "tl_spawn_bravo"
	squad = SQUAD_MARINE_2

/obj/effect/landmark/start/marine/tl/charlie
	icon_state = "tl_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/tl/delta
	icon_state = "tl_spawn_delta"
	squad = SQUAD_MARINE_4
