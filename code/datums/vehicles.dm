/datum/map_template/interior
	name = "基地内部模板"
	var/prefix = "maps/interiors/"
	var/interior_id = "SHOULD NEVER EXIST"


/datum/map_template/interior/New()
	if(interior_id == "SHOULD NEVER EXIST")
		stack_trace("invalid interior datum")
	mappath = "[prefix][interior_id].dmm"
	return ..()

/datum/map_template/interior/apc
	name = "APC"
	interior_id = "apc"

/datum/map_template/interior/apc_pmc
	name = "维兰德装甲运兵车"
	interior_id = "apc_pmc"

/datum/map_template/interior/apc_command
	name = "指挥装甲运兵车"
	interior_id = "apc_command"

/datum/map_template/interior/apc_med
	name = "医疗装甲运兵车"
	interior_id = "apc_med"

/datum/map_template/interior/apc_no_fpw
	name = "装甲运兵车 - 无FPW"
	interior_id = "apc_no_fpw"

/datum/map_template/interior/tank
	name = "坦克"
	interior_id = "tank"

/datum/map_template/interior/van
	name = "厢式货车"
	interior_id = "van"

/datum/map_template/interior/clf_van
	name = "CLF技术车"
	interior_id = "clf_van"

/datum/map_template/interior/box_van
	name = "箱式货车"
	interior_id = "box_van"

/datum/map_template/interior/pizza_van
	name = "披萨银河货车"
	interior_id = "pizza_van"

/datum/map_template/interior/arc
	name = "ARC"
	interior_id = "arc"
