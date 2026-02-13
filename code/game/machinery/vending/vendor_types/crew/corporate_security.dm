//------------ CL CLOTHING VENDOR---------------
GLOBAL_LIST_INIT(cm_vending_clothing_corporate_security, list(
	list("标准装备（全部拾取）", 0, null, null, null),
	list("耳机", 0, /obj/item/device/radio/headset/distress/WY/security/guard, MARINE_CAN_BUY_EAR, VENDOR_ITEM_MANDATORY),
	list("企业战靴", 0, /obj/item/clothing/shoes/veteran/pmc/knife, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_MANDATORY),
	list("SecHUD 眼镜", 0, /obj/item/clothing/glasses/sunglasses/sechud/blue, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_MANDATORY),
	list("处方安全抬头显示眼镜", 0, /obj/item/clothing/glasses/sunglasses/sechud/blue/prescription, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_MANDATORY),

	list("衬衫（最多5件）", 0, null, null, null),
	list("黑色西装裤", 0, /obj/item/clothing/under/liaison_suit/black, CIVILIAN_CAN_BUY_UNIFORM, VENDOR_ITEM_RECOMMENDED),
	list("黑色西装裙", 0, /obj/item/clothing/under/liaison_suit/black/skirt, CIVILIAN_CAN_BUY_UNIFORM, VENDOR_ITEM_RECOMMENDED),
	list("蓝色西装裤", 0, /obj/item/clothing/under/liaison_suit/blue, CIVILIAN_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
	list("棕色西装裤", 0, /obj/item/clothing/under/liaison_suit/brown, CIVILIAN_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
	list("白色西装裤", 0, /obj/item/clothing/under/liaison_suit/corporate_formal, CIVILIAN_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),

	list("夹克（最多5件）", 0, null, null, null),
	list("黑色西装外套", 0, /obj/item/clothing/suit/storage/jacket/marine/corporate/black, CIVILIAN_CAN_BUY_SUIT, VENDOR_ITEM_RECOMMENDED),
	list("蓝色西装外套", 0, /obj/item/clothing/suit/storage/jacket/marine/corporate/blue, CIVILIAN_CAN_BUY_SUIT, VENDOR_ITEM_REGULAR),
	list("棕色西装外套", 0, /obj/item/clothing/suit/storage/jacket/marine/corporate/brown, CIVILIAN_CAN_BUY_SUIT, VENDOR_ITEM_REGULAR),
	list("正式西装外套", 0, /obj/item/clothing/suit/storage/jacket/marine/corporate/formal, CIVILIAN_CAN_BUY_SUIT, VENDOR_ITEM_REGULAR),
	list("米色风衣", 0, /obj/item/clothing/suit/storage/CMB/trenchcoat, CIVILIAN_CAN_BUY_SUIT, VENDOR_ITEM_REGULAR),
	list("棕色风衣", 0, /obj/item/clothing/suit/storage/CMB/trenchcoat/brown, CIVILIAN_CAN_BUY_SUIT, VENDOR_ITEM_REGULAR),
	list("灰色风衣", 0, /obj/item/clothing/suit/storage/CMB/trenchcoat/grey, CIVILIAN_CAN_BUY_SUIT, VENDOR_ITEM_REGULAR),

	list("背包（选择1件）", 0, null, null, null),
	list("黑色皮革挎包", 0, /obj/item/storage/backpack/satchel/black, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),

	list("配件（任选其一）", 0, null, null, null),
	list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
	list("蛛网", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
))

GLOBAL_LIST_INIT(cm_vending_gear_corporate_security_full, list(
	list("头部装备（选择1件）", 0, null, null, null),
	list("安保人员防暴头盔", 0, /obj/item/clothing/head/helmet/marine/veteran/pmc/guard/ppo, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),
	list("企业安全头盔", 0, /obj/item/clothing/head/helmet/marine/veteran/pmc/corporate/ppo, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),

	list("面具（选择1个）", 0, null, null, null),
	list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
	list("循环呼吸器", 0, /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

	list("护甲（选择1件）", 0, null, null, null),
	list("企业安全护甲", 0, /obj/item/clothing/suit/storage/marine/veteran/pmc/light/corporate/ppo, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),
	list("M4 PPO 护甲", 0, /obj/item/clothing/suit/storage/marine/veteran/pmc/light/corporate/ppo/strong, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),

	list("手套（选择1）", 0, null, null, null),
	list("企业安保手套", 0, /obj/item/clothing/gloves/marine/veteran/ppo, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),

	list("小袋（任选2个）", 0, null, null, null),
	list("急救包（可补充注射器）", 0, /obj/item/storage/pouch/firstaid/full/black, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
	list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate/wy, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
	list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills/wy, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
	list("弹匣袋", 0, /obj/item/storage/pouch/magazine/wy, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
	list("中型通用袋", 0, /obj/item/storage/pouch/general/medium, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

	list("主武器（选择1）", 0, null, null, null),
	list("ES-7 超新星静电冲击枪", 15, /obj/effect/essentials_set/es7_nonlethal, MARINE_CAN_BUY_KIT, VENDOR_ITEM_RECOMMENDED),
	list("M39 冲锋枪", 0, /obj/effect/essentials_set/wy_m39, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
	list("M41A脉冲步枪MK2", 0, /obj/effect/essentials_set/wy_m41a, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
	list("NSG23 突击步枪", 0, /obj/effect/essentials_set/wy_nsg23, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),

	list("副武器（选择1）", 0, null, null, null),
	list("ES-4 静电手枪", 0, /obj/item/storage/belt/gun/m4a3/wy/es4, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
	list("88 型 4 战斗手枪", 0, /obj/item/storage/belt/gun/m4a3/wy/mod88, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
	list("VP78 手枪", 8, /obj/item/storage/belt/gun/m4a3/wy/vp78, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

	list("主要弹药", 0, null, null, null),
	list("X21 震撼弹", 10, /obj/item/ammo_magazine/shotgun/beanbag/es7, null, VENDOR_ITEM_REGULAR),
	list("X21 致命弹丸", 15, /obj/item/ammo_magazine/shotgun/beanbag/es7/slug, null, VENDOR_ITEM_REGULAR),
	list("M39弹匣（10x20毫米）", 6, /obj/item/ammo_magazine/smg/m39 , null, VENDOR_ITEM_REGULAR),
	list("M39加长弹匣（10x20毫米）", 8, /obj/item/ammo_magazine/smg/m39/extended , null, VENDOR_ITEM_REGULAR),
	list("M39穿甲弹匣（10x20毫米）", 10, /obj/item/ammo_magazine/smg/m39/ap , null, VENDOR_ITEM_REGULAR),
	list("M41A弹匣（10x24毫米）", 6, /obj/item/ammo_magazine/rifle , null, VENDOR_ITEM_REGULAR),
	list("M41A扩展弹匣（10x24毫米）", 8, /obj/item/ammo_magazine/rifle/extended , null, VENDOR_ITEM_REGULAR),
	list("M41A穿甲弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/ap , null, VENDOR_ITEM_REGULAR),
	list("NSG 23 弹匣（10x24毫米）", 6, /obj/item/ammo_magazine/rifle/nsg23, null, VENDOR_ITEM_REGULAR),
	list("NSG 23 加长弹匣（10x24毫米）", 8, /obj/item/ammo_magazine/rifle/nsg23/extended, null, VENDOR_ITEM_REGULAR),
	list("NSG 23 穿甲弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/nsg23/ap, null, VENDOR_ITEM_REGULAR),

	list("手枪弹药", 0, null, null, null),
	list("ES-4 眩晕弹匣（9毫米）", 4, /obj/item/ammo_magazine/pistol/es4, null, VENDOR_ITEM_REGULAR),
	list("88M4 AP 弹匣（9毫米）", 4, /obj/item/ammo_magazine/pistol/mod88, null, VENDOR_ITEM_REGULAR),
	list("VP78弹匣（9毫米）", 6, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),

	list("导轨附件（选择2项）", 0, null, null, null),
	list("红点瞄准镜", 0, /obj/item/attachable/reddot, CIVILIAN_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
	list("反射式瞄准镜", 0, /obj/item/attachable/reflex, CIVILIAN_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
	list("S4 2倍伸缩迷你瞄准镜", 0, /obj/item/attachable/scope/mini, CIVILIAN_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
	list("磁力束带", 0, /obj/item/attachable/magnetic_harness, CIVILIAN_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
	list("激光瞄准镜", 0, /obj/item/attachable/lasersight, CIVILIAN_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
	list("直角握把", 0, /obj/item/attachable/angledgrip, CIVILIAN_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
	list("垂直握把", 0, /obj/item/attachable/verticalgrip, CIVILIAN_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
	list("加长枪管", 0, /obj/item/attachable/extended_barrel, CIVILIAN_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
	list("抑制器", 0, /obj/item/attachable/suppressor, CIVILIAN_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),

	list("备用装备", 0, null, null, null),
	list("手持式闪光灯", 2, /obj/item/device/flash, null, VENDOR_ITEM_REGULAR),
	list("胡椒喷雾", 4, /obj/item/reagent_container/spray/pepper, null, VENDOR_ITEM_REGULAR),
	list("电击棍", 4, /obj/item/weapon/baton, null, VENDOR_ITEM_REGULAR),
	list("一盒束线带", 4, /obj/item/storage/box/zipcuffs/small, null, VENDOR_ITEM_REGULAR),
))

/obj/structure/machinery/cm_vending/clothing/corporate_security
	name = "企业安保制服"
	desc = "一个衣柜，装有个人保护官所需的所有衣物。"
	icon_state = "wardrobe_vendor"
	vendor_theme = VENDOR_THEME_COMPANY
	req_access = list(ACCESS_WY_SECURITY)
	vendor_role = list(JOB_CORPORATE_BODYGUARD)
	desc = "一个连接着海量标准配发装备存储库的自动化装备架，供公司安保人员使用。"
	show_points = FALSE

/obj/structure/machinery/cm_vending/clothing/corporate_security/get_listed_products(mob/living/carbon/human/user)
	return GLOB.cm_vending_clothing_corporate_security

/obj/structure/machinery/cm_vending/gear/corporate_security
	name = "\improper 企业安全设备机架"
	desc = "一个衣柜，装有个人保护官所需的所有衣物。"
	icon_state = "clothing"
	vendor_theme = VENDOR_THEME_COMPANY
	req_access = list(ACCESS_WY_SECURITY)
	vendor_role = list(JOB_CORPORATE_BODYGUARD)
	desc = "一个连接着海量标准配发装备存储库的自动化装备架，供公司安保人员使用。"

/obj/structure/machinery/cm_vending/gear/corporate_security/get_listed_products(mob/living/carbon/human/user)
	return GLOB.cm_vending_gear_corporate_security_full

/obj/effect/essentials_set/wy_m41a
	spawned_gear_list = list(
		/obj/item/weapon/gun/rifle/m41a/corporate,
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/rifle,
	)

/obj/effect/essentials_set/wy_m39
	spawned_gear_list = list(
		/obj/item/weapon/gun/smg/m39/corporate,
		/obj/item/ammo_magazine/smg/m39,
		/obj/item/ammo_magazine/smg/m39,
		/obj/item/ammo_magazine/smg/m39,
	)

/obj/effect/essentials_set/wy_nsg23
	spawned_gear_list = list(
		/obj/item/weapon/gun/rifle/nsg23/stripped,
		/obj/item/ammo_magazine/rifle/nsg23,
		/obj/item/ammo_magazine/rifle/nsg23,
		/obj/item/ammo_magazine/rifle/nsg23,
	)

/obj/effect/essentials_set/es7_nonlethal
	spawned_gear_list = list(
		/obj/item/weapon/gun/shotgun/es7,
		/obj/item/storage/belt/shotgun/black,
		/obj/item/ammo_magazine/shotgun/beanbag/es7,
	)
