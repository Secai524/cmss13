/datum/supply_packs/pouches_ammo
	name = "大型弹匣包 2x(手枪,弹匣,通用)"
	contains = list(
		/obj/item/storage/pouch/magazine/large,
		/obj/item/storage/pouch/magazine/large,
		/obj/item/storage/pouch/magazine/pistol/large,
		/obj/item/storage/pouch/magazine/pistol/large,
		/obj/item/storage/pouch/general,
		/obj/item/storage/pouch/general,
	)
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "Large Pouch"
	group = "Clothing"

/datum/supply_packs/pouches_medical
	name = "医疗包箱 (1x 急救包, 医疗包, 注射器, 医疗包, 自动注射器)"
	contains = list(
		/obj/item/storage/pouch/firstaid,
		/obj/item/storage/pouch/medical,
		/obj/item/storage/pouch/syringe,
		/obj/item/storage/pouch/medkit,
		/obj/item/storage/pouch/autoinjector,
	)
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "medical pouches crate"
	group = "Clothing"

//---------------------------------------------
//HOLSTERS & WEBBING BELOW THIS LINE
//---------------------------------------------

/datum/supply_packs/webbing_brown_black
	name = "棕色与黑色战术背心箱 (各x2)"
	contains = list(
		/obj/item/clothing/accessory/storage/black_vest/brown_vest,
		/obj/item/clothing/accessory/storage/black_vest/brown_vest,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/accessory/storage/black_vest,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/green
	containername = "Brown And Black Webbing Crate"
	group = "Clothing"

/datum/supply_packs/webbing_large
	name = "战术背心箱 (x4)"
	contains = list(
		/obj/item/clothing/accessory/storage/webbing,
		/obj/item/clothing/accessory/storage/webbing,
		/obj/item/clothing/accessory/storage/webbing,
		/obj/item/clothing/accessory/storage/webbing,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/green
	containername = "Webbing Crate"
	group = "Clothing"

/datum/supply_packs/webbing_large_black
	name = "黑色战术背心箱 (x4)"
	contains = list(
		/obj/item/clothing/accessory/storage/webbing/black,
		/obj/item/clothing/accessory/storage/webbing/black,
		/obj/item/clothing/accessory/storage/webbing/black,
		/obj/item/clothing/accessory/storage/webbing/black,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/green
	containername = "Black Webbing Crate"
	group = "Clothing"

/datum/supply_packs/drop_pouches
	name = "降落伞包箱 (x4)"
	contains = list(
		/obj/item/clothing/accessory/storage/droppouch,
		/obj/item/clothing/accessory/storage/droppouch,
		/obj/item/clothing/accessory/storage/droppouch,
		/obj/item/clothing/accessory/storage/droppouch,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/green
	containername = "Drop Pouch Crate"
	group = "Clothing"


/datum/supply_packs/webbing_knives//for the lulz
	name = "刀套背心箱 (x3)"
	contains = list(
		/obj/item/clothing/accessory/storage/knifeharness,//old unathi knife harness updated for our needs
		/obj/item/clothing/accessory/storage/knifeharness,
		/obj/item/clothing/accessory/storage/knifeharness
	)
	cost = 30
	containertype = /obj/structure/closet/crate/green
	containername = "Knife Vest Crate"
	group = "Clothing"

/datum/supply_packs/webbing_holster
	name = "肩挂式枪套箱 (x4)"
	contains = list(
		/obj/item/clothing/accessory/storage/holster,
		/obj/item/clothing/accessory/storage/holster,
		/obj/item/clothing/accessory/storage/holster,
		/obj/item/clothing/accessory/storage/holster,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/green
	containername = "Shoulder Holster Crate"
	group = "Clothing"

/datum/supply_packs/officer_outfits//lmao this shit is so hideously out of date
	contains = list(
		/obj/item/clothing/under/rank/qm_suit,
		/obj/item/clothing/under/marine/officer/bridge,
		/obj/item/clothing/under/marine/officer/bridge,
		/obj/item/clothing/under/marine/dress,
		/obj/item/clothing/under/marine/officer/ce,
	)
	name = "军官制服箱"
	cost = 30
	containertype = /obj/structure/closet/crate
	containername = "officer dress crate"
	group = "Clothing"
