/datum/supply_packs/sandbags
	name = "空沙袋箱 (x50)"
	contains = list(/obj/item/stack/sandbags_empty/full)
	cost = 20
	containertype = /obj/structure/closet/crate/supply
	containername = "empty sandbags crate"
	group = "工程部"

/datum/supply_packs/sandbagskit
	name = "沙袋建造套件 (沙袋 x50, 工兵铲 x2)"
	contains = list(
		/obj/item/stack/sandbags_empty/full,
		/obj/item/tool/shovel/etool,
		/obj/item/tool/shovel/etool,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/supply
	containername = "sandbags construction kit"
	group = "工程部"

/datum/supply_packs/metal
	name = "金属板 (x50)"
	contains = list(/obj/item/stack/sheet/metal/large_stack)
	cost = 20
	containertype = /obj/structure/closet/crate/supply
	containername = "metal sheets crate"
	group = "工程部"

/datum/supply_packs/plas
	name = "塑钢板 (x40)"
	contains = list(/obj/item/stack/sheet/plasteel/med_large_stack)
	cost = 30
	containertype = /obj/structure/closet/crate/supply
	containername = "plasteel sheets crate"
	group = "工程部"

/datum/supply_packs/glass
	name = "玻璃板 (x50)"
	contains = list(/obj/item/stack/sheet/glass/large_stack)
	cost = 20
	containertype = /obj/structure/closet/crate/supply
	containername = "glass sheets crate"
	group = "工程部"

/datum/supply_packs/wood50
	name = "木板 (x50)"
	contains = list(/obj/item/stack/sheet/wood/large_stack)
	cost = 20
	containertype = /obj/structure/closet/crate/supply
	containername = "wooden planks crate"
	group = "工程部"

/datum/supply_packs/folding_barricades
	contains = list(
		/obj/item/stack/folding_barricade/three,
	)
	name = "折叠式路障 (x3)"
	cost = 20
	containertype = /obj/structure/closet/crate/supply
	containername = "folding barricades crate"
	group = "工程部"

/datum/supply_packs/smescoil
	name = "超导磁线圈箱 (x1)"
	contains = list(/obj/item/stock_parts/smes_coil)
	cost = 30
	containertype = /obj/structure/closet/crate/construction
	containername = "superconducting magnetic coil crate"
	group = "工程部"

/datum/supply_packs/electrical
	name = "电气维护箱 (工具箱 x2, 绝缘手套 x2, 电池 x2, 高容量电池 x2)"
	contains = list(
		/obj/item/storage/toolbox/electrical,
		/obj/item/storage/toolbox/electrical,
		/obj/item/clothing/gloves/yellow,
		/obj/item/clothing/gloves/yellow,
		/obj/item/cell,
		/obj/item/cell,
		/obj/item/cell/high,
		/obj/item/cell/high,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/construction
	containername = "electrical maintenance crate"
	group = "工程部"

/datum/supply_packs/mechanical
	name = "机械维护箱 (工具腰带 x3, 危险背心 x3, 焊接头盔 x2, 安全帽 x1)"
	contains = list(
		/obj/item/storage/belt/utility/full,
		/obj/item/storage/belt/utility/full,
		/obj/item/storage/belt/utility/full,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/head/welding,
		/obj/item/clothing/head/welding,
		/obj/item/clothing/head/hardhat,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/construction
	containername = "mechanical maintenance crate"
	group = "工程部"

/datum/supply_packs/inflatable
	name = "充气路障（门x9，墙x12）"
	contains = list(
		/obj/item/storage/briefcase/inflatable,
		/obj/item/storage/briefcase/inflatable,
		/obj/item/storage/briefcase/inflatable,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/construction
	containername = "inflatable barriers crate"
	group = "工程部"

/datum/supply_packs/lightbulbs
	name = "替换灯管（灯管x42，灯泡x21）"
	contains = list(
		/obj/item/storage/box/lights/mixed,
		/obj/item/storage/box/lights/mixed,
		/obj/item/storage/box/lights/mixed,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/supply
	containername = "replacement lights crate"
	group = "工程部"

/datum/supply_packs/pacman_parts
	name = "P.A.C.M.A.N.便携式发电机零件"
	contains = list(
		/obj/item/stock_parts/micro_laser,
		/obj/item/stock_parts/capacitor,
		/obj/item/stock_parts/matter_bin,
		/obj/item/circuitboard/machine/pacman,
	)
	cost = 30
	containername = "\improper P.A.C.M.A.N. portable generator construction kit"
	containertype = /obj/structure/closet/crate/secure
	group = "工程部"

/datum/supply_packs/super_pacman_parts
	name = "超级P.A.C.M.A.N.便携式发电机零件"
	cost = 40
	containername = "\improper Super P.A.C.M.A.N. portable generator construction kit"
	containertype = /obj/structure/closet/crate/secure
	group = "工程部"
	contains = list(
		/obj/item/stock_parts/micro_laser,
		/obj/item/stock_parts/capacitor,
		/obj/item/stock_parts/matter_bin,
		/obj/item/circuitboard/machine/pacman/super,
	)

/datum/supply_packs/flashlights
	name = "手电筒（x8）"
	contains = list(
		/obj/item/ammo_box/magazine/misc/flashlight,
	)
	cost = 10
	containertype = /obj/structure/closet/crate/supply
	containername = "flashlights crate"
	group = "工程部"

/datum/supply_packs/batteries
	name = "高容量电池（x8）"
	contains = list(
		/obj/item/ammo_box/magazine/misc/power_cell,
	)
	cost = 10
	containertype = /obj/structure/closet/crate/supply
	containername = "battery crate"
	group = "工程部"
