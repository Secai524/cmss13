//the idea is to put all the bulk items scanner secure crate with lot's of flares MRE in it and at the end OB and non buyable.

//non buyable

/datum/supply_packs/ob_incendiary
	contains = list(
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/warhead/incendiary,
	)

	name = "轨道轰炸燃烧弹箱"
	cost = 0
	containertype = /obj/structure/closet/crate/secure/ob
	containername = "OB Ammo Crate (Incendiary)"
	buyable = 0
	group = "Operations"

/datum/supply_packs/ob_explosive
	contains = list(
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/warhead/explosive,
	)

	name = "轨道轰炸高爆弹箱"
	cost = 0
	containertype = /obj/structure/closet/crate/secure/ob
	containername = "OB Ammo Crate (HE)"
	buyable = 0
	group = "Operations"

/datum/supply_packs/ob_cluster
	contains = list(
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/ob_fuel,
		/obj/structure/ob_ammo/warhead/cluster,
	)

	name = "轨道轰炸集束弹箱"
	cost = 0
	containertype = /obj/structure/closet/crate/secure/ob
	containername = "OB Ammo Crate (Cluster)"
	buyable = 0
	group = "Operations"

/datum/supply_packs/telecommsparts
	name = "替换用电信部件"
	contains = list(
		/obj/item/circuitboard/machine/telecomms/relay/tower,
		/obj/item/stock_parts/manipulator,
		/obj/item/stock_parts/manipulator,
		/obj/item/stock_parts/subspace/filter,
		/obj/item/stock_parts/subspace/filter,
		/obj/item/cell,
		/obj/item/cell,
		/obj/item/stack/cable_coil,
		/obj/item/stack/cable_coil,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/supply
	buyable = 0
	containername = "replacement telecommunications crate"
	group = "Operations"

/datum/supply_packs/nuclearbomb
	name = "已解密的行动大片"
	contains = list(
		/obj/item/book/manual/nuclear,
	)
	cost = 0
	containertype = /obj/structure/machinery/nuclearbomb
	buyable = 0
	group = "Operations"

/datum/supply_packs/technuclearbomb
	name = "加密的行动大片"
	contains = list(
		/obj/item/book/manual/nuclear,
	)
	cost = 0
	containertype = /obj/structure/machinery/nuclearbomb/tech
	buyable = 0
	group = "Operations"

/datum/supply_packs/spec_kits
	name = "武器专家套件"
	contains = list(
		/obj/item/spec_kit/rifleman,
		/obj/item/spec_kit/rifleman,
		/obj/item/spec_kit/rifleman,
		/obj/item/spec_kit/rifleman,
	)
	cost = 0
	containertype = /obj/structure/closet/crate/supply
	containername = "weapons specialist kits crate"
	buyable = 0
	group = "Operations"
