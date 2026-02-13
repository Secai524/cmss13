/datum/supply_packs/upp/sandbags
	name = "UPP空沙袋箱 (x50)"
	contains = list(/obj/item/stack/sandbags_empty/full)
	cost = 20
	containertype = /obj/structure/closet/crate/supply
	containername = "empty sandbags crate"
	group = "UPP Engineering"

/datum/supply_packs/upp/sandbagskit
	name = "UPP沙袋建造套件 (沙袋x50，工兵铲x2)"
	contains = list(
		/obj/item/stack/sandbags_empty/full,
		/obj/item/tool/shovel/etool,
		/obj/item/tool/shovel/etool,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/supply
	containername = "sandbags construction kit"
	group = "UPP Engineering"

/datum/supply_packs/upp/metal
	name = "UPP金属板 (x50)"
	contains = list(/obj/item/stack/sheet/metal/large_stack)
	cost = 20
	containertype = /obj/structure/closet/crate/supply
	containername = "metal sheets crate"
	group = "UPP Engineering"

/datum/supply_packs/upp/plas
	name = "UPP塑钢板 (x40)"
	contains = list(/obj/item/stack/sheet/plasteel/med_large_stack)
	cost = 30
	containertype = /obj/structure/closet/crate/supply
	containername = "plasteel sheets crate"
	group = "UPP Engineering"

/datum/supply_packs/upp/glass
	name = "UPP玻璃板 (x50)"
	contains = list(/obj/item/stack/sheet/glass/large_stack)
	cost = 20
	containertype = /obj/structure/closet/crate/supply
	containername = "glass sheets crate"
	group = "UPP Engineering"

/datum/supply_packs/upp/wood50
	name = "UPP木板 (x50)"
	contains = list(/obj/item/stack/sheet/wood/large_stack)
	cost = 20
	containertype = /obj/structure/closet/crate/supply
	containername = "wooden planks crate"
	group = "UPP Engineering"

/datum/supply_packs/upp/folding_barricades
	name = "UPP折叠式路障 (x3)"
	contains = list(
		/obj/item/stack/folding_barricade/three,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/supply
	containername = "folding barricades crate"
	group = "UPP Engineering"

/datum/supply_packs/upp/smescoil
	name = "UPP超导磁线圈箱 (x1)"
	contains = list(/obj/item/stock_parts/smes_coil)
	cost = 30
	containertype = /obj/structure/closet/crate/construction
	containername = "superconducting magnetic coil crate"
	group = "UPP Engineering"

/datum/supply_packs/upp/flashlights
	name = "UPP手电筒 (x8)"
	contains = list(
		/obj/item/ammo_box/magazine/misc/flashlight,
	)
	cost = 10
	containertype = /obj/structure/closet/crate/supply
	containername = "flashlights crate"
	group = "UPP Engineering"

/datum/supply_packs/upp/batteries
	name = "UPP高容量电池 (x8)"
	contains = list(
		/obj/item/ammo_box/magazine/misc/power_cell,
	)
	cost = 10
	containertype = /obj/structure/closet/crate/supply
	containername = "battery crate"
	group = "UPP Engineering"
