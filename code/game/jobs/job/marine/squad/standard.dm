#define STANDARD_MARINE_TO_TOTAL_SPAWN_RATIO 0.4

/datum/job/marine/standard
	title = JOB_SQUAD_MARINE
	total_positions = -1
	spawn_positions = -1
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/pfc

/datum/job/marine/standard/on_config_load()
	entry_message_body = "你是一名普通的<a href='[CONFIG_GET(string/wikiarticleurl)]/[URL_WIKI_MARINE_QUICKSTART]'>美国殖民地海军陆战队员</a>，而这正是你的力量所在。单枪匹马时你所欠缺的，将在与陆战队同袍并肩作战时获得。呜-哈！"
	return ..()

/datum/job/marine/standard/set_spawn_positions(count)
	spawn_positions = max((floor(count * STANDARD_MARINE_TO_TOTAL_SPAWN_RATIO)), 8)

/datum/job/marine/standard/whiskey
	title = JOB_WO_SQUAD_MARINE
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/wo/marine/pfc

/obj/effect/landmark/start/marine
	name = JOB_SQUAD_MARINE
	icon_state = "marine_spawn"
	job = /datum/job/marine/standard

/obj/effect/landmark/start/marine/alpha
	icon_state = "marine_spawn_alpha"
	squad = SQUAD_MARINE_1

/obj/effect/landmark/start/marine/bravo
	icon_state = "marine_spawn_bravo"
	squad = SQUAD_MARINE_2

/obj/effect/landmark/start/marine/charlie
	icon_state = "marine_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/delta
	icon_state = "marine_spawn_delta"
	squad = SQUAD_MARINE_4
