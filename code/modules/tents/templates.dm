/datum/map_template/tent
	name = "基地帐篷"
	var/map_id = "change this"

/datum/map_template/tent/New()
	mappath = "maps/tents/[map_id].dmm"
	return ..()

/datum/map_template/tent/cmd
	name = "指挥帐篷"
	map_id = "tent_cmd"

/datum/map_template/tent/med
	name = "医疗帐篷"
	map_id = "tent_med"

/datum/map_template/tent/big
	name = "大型帐篷"
	map_id = "tent_big"

/datum/map_template/tent/reqs
	name = "补给帐篷"
	map_id = "tent_reqs"

/datum/map_template/tent/mess
	name = "食堂帐篷"
	map_id = "tent_mess"
