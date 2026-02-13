//------------GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_gear_upp_commanding_officer, list(
		list("指挥官主要技能（选择1项）", 0, null, null, null),
		list("71型脉冲步枪", 0, /obj/item/weapon/gun/rifle/type71, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_MANDATORY),
		list("71型脉冲步枪卡宾枪", 0, /obj/item/weapon/gun/rifle/type71/carbine, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_MANDATORY),
		list("64式冲锋枪", 0, /obj/item/weapon/gun/smg/bizon/upp, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_MANDATORY),

		list("主要弹药", 0, null, null, null),
		list("71式弹匣", 10, /obj/item/ammo_magazine/rifle/type71, null, VENDOR_ITEM_RECOMMENDED),
		list("71式穿甲弹弹匣", 20, /obj/item/ammo_magazine/rifle/type71/ap, null, VENDOR_ITEM_RECOMMENDED),
		list("64式螺旋弹匣", 20, /obj/item/ammo_magazine/smg/bizon, null, VENDOR_ITEM_REGULAR),

		list("手枪弹药", 0, null, null, null),
		list("73式弹匣（7.62x25毫米）", 5, /obj/item/ammo_magazine/pistol/t73, null, VENDOR_ITEM_RECOMMENDED),
		list("高威力73型弹匣（7.62x25毫米）", 15, /obj/item/ammo_magazine/pistol/t73_impact , null, VENDOR_ITEM_REGULAR),

		list("爆炸物", 0, null, null, null),
		list("6型破片手榴弹", 5, /obj/item/explosive/grenade/high_explosive/upp, null, VENDOR_ITEM_REGULAR),
		list("8型白磷手榴弹", 5, /obj/item/explosive/grenade/phosphorus/upp, null, VENDOR_ITEM_REGULAR),

		list("轨道附件", 0, null, null, null),
		list("红点瞄准镜", 15, /obj/item/attachable/reddot, null, VENDOR_ITEM_REGULAR),
		list("反射式瞄准镜", 15, /obj/item/attachable/reflex, null, VENDOR_ITEM_REGULAR),
		list("S4 2倍伸缩迷你瞄准镜", 15, /obj/item/attachable/scope/mini, null, VENDOR_ITEM_REGULAR),

		list("头盔面罩", 0, null, null, null),
		list("焊接面罩", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_RECOMMENDED),

		list("下挂式配件", 0, null, null, null),
		list("激光瞄准镜", 15, /obj/item/attachable/lasersight, null, VENDOR_ITEM_REGULAR),
		list("直角握把", 15, /obj/item/attachable/angledgrip, null, VENDOR_ITEM_REGULAR),
		list("垂直握把", 15, /obj/item/attachable/verticalgrip, null, VENDOR_ITEM_REGULAR),
		list("下挂式霰弹枪", 15, /obj/item/attachable/attached_gun/shotgun, null, VENDOR_ITEM_REGULAR),
		list("下挂式灭火器", 15, /obj/item/attachable/attached_gun/extinguisher, null, VENDOR_ITEM_REGULAR),
		list("下挂式火焰喷射器", 15, /obj/item/attachable/attached_gun/flamer, null, VENDOR_ITEM_REGULAR),
		list("下挂式榴弹发射器", 5, /obj/item/attachable/attached_gun/grenade, null, VENDOR_ITEM_REGULAR),

		list("枪管配件", 0, null, null, null),
		list("加长枪管", 15, /obj/item/attachable/extended_barrel, null, VENDOR_ITEM_REGULAR),
		list("后坐力补偿器", 15, /obj/item/attachable/compensator, null, VENDOR_ITEM_REGULAR),
		list("抑制器", 15, /obj/item/attachable/suppressor, null, VENDOR_ITEM_REGULAR),
			))

/obj/structure/machinery/cm_vending/gear/upp_commanding_officer
	name = "\improper 联合阿拉拉特公司指挥官武器架"
	desc = "为指挥官准备的自动化武器架。它精选了仅限UPP高级军官使用的强大武器。"
	req_access = list(ACCESS_UPP_LEADERSHIP)
	vendor_role = list(JOB_UPP_CO_OFFICER, JOB_UPP_MAY_OFFICER, JOB_UPP_LTKOL_OFFICER, JOB_UPP_KOL_OFFICER)
	icon_state = "guns"
	use_snowflake_points = TRUE
	vendor_theme = VENDOR_THEME_UPP

/obj/structure/machinery/cm_vending/gear/upp_commanding_officer/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_upp_commanding_officer

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_upp_commanding_officer, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("耳机", 0, /obj/item/device/radio/headset/distress/UPP/command, MARINE_CAN_BUY_EAR, VENDOR_ITEM_MANDATORY),
		list("国际关系计划", 0, /obj/item/storage/box/mre/upp, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),

		list("指挥官必备套装（全部带走）", 0, null, null, null),
		list("指挥官必备套装", 0, /obj/effect/essentials_set/upp_commanding_officer, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("背包（选择1个）", 0, null, null, null),
		list("指挥官 战斗 包", 0, /obj/item/storage/backpack/lightpack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("安全挎包", 0, /obj/item/storage/backpack/satchel/lockable, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),

		list("战斗装备（全部拾取）", 0, null, null, null),
		list("UL6 个人护甲", 0, /obj/item/clothing/suit/storage/marine/faction/UPP/support, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("UM4头盔", 0, /obj/item/clothing/head/helmet/marine/veteran/UPP, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),
		list("战斗手套", 0, /obj/item/clothing/gloves/marine/veteran/upp, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("士兵战斗靴", 0, /obj/item/clothing/shoes/marine/upp/knife, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_MANDATORY),

		list("配件（选择1件）", 0, null, null, null),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("战术背心", 0, /obj/item/clothing/accessory/storage/black_vest/waistcoat, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("蛛网", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("抬头显示系统（选择1项）", 0, null, null, null),
		list("医疗HUD眼镜", 0, /obj/item/clothing/glasses/hud/health, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_RECOMMENDED),
		list("安全平视显示眼镜", 0, /obj/item/clothing/glasses/sunglasses/sechud, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),

		list("腰带（选择1条）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("宪兵腰带", 0, /obj/item/storage/belt/security/MP/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 医疗存储平台", 0, /obj/item/storage/belt/medical/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("41型弹药装载装置", 0, /obj/item/storage/belt/marine/upp, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("工兵工具装备", 0, /obj/item/storage/belt/gun/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 M82F 枪套装备", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋（任选2个）", 0, null, null, null),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("医疗包袋", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("自动注射器袋", 0, /obj/item/storage/pouch/autoinjector/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型弹匣袋", 0, /obj/item/storage/pouch/magazine/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("侧臂袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工具袋（满）", 0, /obj/item/storage/pouch/tools/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/upp_commanding_officer
	name = "\improper 联合亚拉腊公司指挥官装备架"
	desc = "为指挥官准备的自动化装备供应商。包含仅限UPP高级军官使用的顶级装备。"
	req_access = list(ACCESS_UPP_LEADERSHIP)
	vendor_role = list(JOB_UPP_CO_OFFICER, JOB_UPP_MAY_OFFICER, JOB_UPP_LTKOL_OFFICER, JOB_UPP_KOL_OFFICER)
	vendor_theme = VENDOR_THEME_UPP

/obj/structure/machinery/cm_vending/clothing/upp_commanding_officer/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_upp_commanding_officer

/obj/effect/essentials_set/upp_commanding_officer
	spawned_gear_list = list(
		/obj/item/device/binoculars/range/designator,
		/obj/item/map/current_map,
		/obj/item/clothing/accessory/device/whistle,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/device/megaphone,
	)
