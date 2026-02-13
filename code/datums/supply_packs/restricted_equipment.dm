// here they will be all the Equipment that are restricted to a role/job.

/datum/supply_packs/armor_leader
	name = "B12型陆战队员护甲箱（x1头盔，x1护甲）"
	contains = list(
		/obj/item/clothing/head/helmet/marine/leader,
		/obj/item/clothing/suit/storage/marine/medium/leader,
	)
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "B12 pattern marine armor crate"
	group = "Restricted Equipment"

/datum/supply_packs/armor_tl
	name = "M4型陆战队员护甲箱（x1头盔，x1护甲）"
	contains = list(
		/obj/item/clothing/head/helmet/marine/rto,
		/obj/item/clothing/suit/storage/marine/medium/rto,
	)
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "M4 pattern marine armor crate"
	group = "Restricted Equipment"

/datum/supply_packs/intel_kit
	name = "野战情报支援装备箱（x1富尔顿回收包，x1数据探测器，x1情报手册，x1大型文件袋，1x情报无线电密钥）"
	contains = list(
		/obj/item/storage/box/kit/mini_intel,
	)
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "Field Intelligence Support Kit crate"
	group = "Restricted Equipment"

/datum/supply_packs/jtac_kit
	name = "JTAC无线电装备箱（x1满装信号枪腰带，x2 M89-S信号弹包，1x激光指示器，1x JTAC无线电密钥，1x无线电背包）"
	contains = list(
		/obj/item/storage/box/kit/mini_jtac,
	)
	cost = 30
	containertype = /obj/structure/closet/crate
	containername = "JTAC Radio Kit crate"
	group = "Restricted Equipment"
