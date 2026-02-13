/datum/supply_packs/medical
	name = "医疗箱"
	contains = list(
		/obj/item/storage/box/syringes,
		/obj/item/reagent_container/glass/bottle/inaprovaline,
		/obj/item/reagent_container/glass/bottle/antitoxin,
		/obj/item/reagent_container/glass/bottle/bicaridine,
		/obj/item/reagent_container/glass/bottle/dexalin,
		/obj/item/reagent_container/glass/bottle/kelotane,
		/obj/item/reagent_container/glass/bottle/tramadol,
		/obj/item/storage/pill_bottle/inaprovaline,
		/obj/item/storage/pill_bottle/antitox,
		/obj/item/storage/pill_bottle/bicaridine,
		/obj/item/storage/pill_bottle/dexalin,
		/obj/item/storage/pill_bottle/kelotane,
		/obj/item/storage/pill_bottle/tramadol,
		/obj/item/storage/pill_bottle/peridaxon,
		/obj/item/storage/box/pillbottles,
	)
	cost = 15
	containertype = /obj/structure/closet/crate/medical
	containername = "医疗箱"
	group = "医疗区"

/datum/supply_packs/medical_restock_cart
	name = "医疗补给推车"
	contains = list(
		/obj/structure/restock_cart/medical,
	)
	cost = 20
	containertype = null
	containername = "医疗补给推车"
	group = "医疗区"

/datum/supply_packs/medical_reagent_cart
	name = "医疗试剂补给推车"
	contains = list(
		/obj/structure/restock_cart/medical/reagent,
	)
	cost = 20
	containertype = null
	containername = "医疗试剂补给推车"
	group = "医疗区"

/datum/supply_packs/pillbottle
	name = "药瓶箱 (每种x2)"
	contains = list(
		/obj/item/storage/pill_bottle/inaprovaline,
		/obj/item/storage/pill_bottle/antitox,
		/obj/item/storage/pill_bottle/bicaridine,
		/obj/item/storage/pill_bottle/dexalin,
		/obj/item/storage/pill_bottle/kelotane,
		/obj/item/storage/pill_bottle/tramadol,
		/obj/item/storage/pill_bottle/peridaxon,
		/obj/item/storage/pill_bottle/inaprovaline,
		/obj/item/storage/pill_bottle/antitox,
		/obj/item/storage/pill_bottle/bicaridine,
		/obj/item/storage/pill_bottle/dexalin,
		/obj/item/storage/pill_bottle/kelotane,
		/obj/item/storage/pill_bottle/tramadol,
		/obj/item/storage/pill_bottle/peridaxon,
		/obj/item/storage/box/pillbottles,
		/obj/item/storage/box/pillbottles,
	)
	cost = 15
	containertype = /obj/structure/closet/crate/medical
	containername = "医疗箱"
	group = "医疗区"

/datum/supply_packs/firstaid
	name = "急救包箱 (每种x2)"
	contains = list(
		/obj/item/storage/firstaid/regular,
		/obj/item/storage/firstaid/regular,
		/obj/item/storage/firstaid/fire,
		/obj/item/storage/firstaid/fire,
		/obj/item/storage/firstaid/toxin,
		/obj/item/storage/firstaid/toxin,
		/obj/item/storage/firstaid/o2,
		/obj/item/storage/firstaid/o2,
		/obj/item/storage/firstaid/adv,
		/obj/item/storage/firstaid/adv,
	)
	cost = 11
	containertype = /obj/structure/closet/crate/medical
	containername = "医疗箱"
	group = "医疗区"

/datum/supply_packs/bodybag
	name = "裹尸袋箱 (x28)"
	contains = list(
		/obj/item/storage/box/bodybags,
		/obj/item/storage/box/bodybags,
		/obj/item/storage/box/bodybags,
		/obj/item/storage/box/bodybags,
	)
	cost = 7
	containertype = /obj/structure/closet/crate/medical
	containername = "body bag crate"
	group = "医疗区"

/datum/supply_packs/cryobag
	name = "静滞袋箱 (x3)"
	contains = list(
		/obj/item/bodybag/cryobag,
		/obj/item/bodybag/cryobag,
		/obj/item/bodybag/cryobag,
	)
	cost = 15
	containertype = /obj/structure/closet/crate/medical
	containername = "stasis bag crate"
	group = "医疗区"

/datum/supply_packs/surgery
	name = "手术箱 (托盘、麻醉剂、外科医生装备)"
	contains = list(
		/obj/item/storage/surgical_tray,
		/obj/item/clothing/mask/breath/medical,
		/obj/item/tank/anesthetic,
		/obj/item/clothing/under/rank/medical/green,
		/obj/item/storage/box/masks,
		/obj/item/storage/box/gloves,
	)
	cost = 25
	containertype = /obj/structure/closet/crate/secure/surgery
	containername = "手术箱"
	access = ACCESS_MARINE_MEDBAY
	group = "医疗区"

/datum/supply_packs/surgery/beds
	name = "手术箱 (手术床)"
	contains = list(
		/obj/item/roller/surgical,
		/obj/item/roller/surgical,
		/obj/item/roller/surgical,
		/obj/item/roller/surgical,
		/obj/item/roller/surgical,
		/obj/item/roller/surgical,
	)
	cost = 25
	containertype = /obj/structure/closet/crate/secure/surgery
	containername = "手术箱"
	access = ACCESS_MARINE_MEDBAY
	group = "医疗区"

/datum/supply_packs/field_doc
	name = "战地医生箱 (替换用战地医生装备)"
	contains = list(
		/obj/item/folded_tent/med,
		/obj/item/clothing/accessory/storage/surg_vest/equipped,
		/obj/item/roller/surgical,
		/obj/item/tool/portadialysis,
		/obj/structure/machinery/iv_drip,
		/obj/item/reagent_container/spray/cleaner,
		/obj/item/clothing/mask/breath/medical,
		/obj/item/storage/box/masks,
		/obj/item/storage/box/gloves,
		/obj/item/storage/box/bloodbag,
		/obj/item/tool/wrench,
		/obj/item/tool/crowbar,
	)
	cost = 35 //that tent is expensive, man. Only order this crate if the old tent was destroyed.
	containertype = /obj/structure/closet/crate/secure/medical
	containername = "field doctor's replacement personal crate"
	access = ACCESS_MARINE_MEDBAY
	group = "医疗区"

/datum/supply_packs/upgraded_medical_kits
	name = "升级医疗设备箱 (x4)"
	contains = list(
		/obj/item/storage/box/czsp/medic_upgraded_kits/full,
		/obj/item/storage/box/czsp/medic_upgraded_kits/full,
		/obj/item/storage/box/czsp/medic_upgraded_kits/full,
		/obj/item/storage/box/czsp/medic_upgraded_kits/full,
	)
	cost = 0
	buyable = FALSE
	containertype = /obj/structure/closet/crate/medical
	containername = "upgraded medical equipment crate"
	group = "医疗区"
