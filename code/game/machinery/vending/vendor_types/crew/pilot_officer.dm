//------------PILOT OFFICER REQUIPMENT RACK---------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/pilot_officer
	name = "\improper ColMarTech（殖民地海军陆战队科技） 空降艇乘员武器架"
	desc = "一个连接着小规模标准配发武器存储库的自动化武器架。仅限运输机机组人员访问。"
	icon_state = "guns"
	req_access = list(ACCESS_MARINE_PILOT)
	vendor_role = list(JOB_CAS_PILOT, JOB_DROPSHIP_PILOT, JOB_DROPSHIP_CREW_CHIEF)
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND

	listed_products = list(
		list("主要火器", -1, null, null),
		list("M4RA 战斗步枪", 4, /obj/item/weapon/gun/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("M39 冲锋枪", 4, /obj/item/weapon/gun/smg/m39, VENDOR_ITEM_REGULAR),
		list("M37A2 泵动式霰弹枪", 4, /obj/item/weapon/gun/shotgun/pump/m37a, VENDOR_ITEM_REGULAR),
		list("M41A脉冲步枪MK2", 4, /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_REGULAR),

		list("主要弹药", -1, null, null),
		list("霰弹枪弹盒（12号口径）", 12, /obj/item/ammo_magazine/shotgun/buckshot, VENDOR_ITEM_REGULAR),
		list("霰弹枪箭弹盒（12号口径）", 12, /obj/item/ammo_magazine/shotgun/flechette, VENDOR_ITEM_REGULAR),
		list("霰弹枪独头弹盒（12号口径）", 12, /obj/item/ammo_magazine/shotgun/slugs, VENDOR_ITEM_REGULAR),
		list("M4RA 弹匣（10x24毫米）", 24, /obj/item/ammo_magazine/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("M39 HV 弹匣（10x20毫米）", 24, /obj/item/ammo_magazine/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A弹匣（10x24毫米）", 24, /obj/item/ammo_magazine/rifle, VENDOR_ITEM_REGULAR),

		list("侧臂", -1, null, null),
		list("M10自动手枪", 4, /obj/item/weapon/gun/pistol/m10, VENDOR_ITEM_REGULAR),
		list("88 型 4 战斗手枪", 4, /obj/item/weapon/gun/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44 战斗左轮手枪", 4, /obj/item/weapon/gun/revolver/m44, VENDOR_ITEM_REGULAR),
		list("M4A3 制式手枪", 4, /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),
		list("M82F 信号枪", 4, /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("手枪弹药", -1, null, null),
		list("M10 HV 加长弹匣（10x20mm-APC）", 6, /obj/item/ammo_magazine/pistol/m10/extended , null, VENDOR_ITEM_REGULAR),
		list("88M4 AP 弹匣（9毫米）", 20, /obj/item/ammo_magazine/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44快速装弹器（.44口径）", 20, /obj/item/ammo_magazine/revolver, VENDOR_ITEM_REGULAR),
		list("M4A3弹匣（9毫米）", 20, /obj/item/ammo_magazine/pistol, VENDOR_ITEM_REGULAR),
		list("M4A3 AP 弹匣（9毫米）", 12, /obj/item/ammo_magazine/pistol/ap, VENDOR_ITEM_REGULAR),
		list("M4A3 HP 弹匣（9毫米）", 12, /obj/item/ammo_magazine/pistol/hp, VENDOR_ITEM_REGULAR),
		list("VP78弹匣（9毫米）", 16, /obj/item/ammo_magazine/pistol/vp78, VENDOR_ITEM_REGULAR),

		list("附件", -1, null, null),
		list("Rail 手电筒", 8, /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
		list("下挂式手电筒握把", 4, /obj/item/attachable/flashlight/grip, VENDOR_ITEM_REGULAR),

		list("公用事业", -1, null, null),
		list("战斗 手电筒", 4, /obj/item/device/flashlight/combat, VENDOR_ITEM_REGULAR),
		list("M5 刺刀", 4, /obj/item/attachable/bayonet, VENDOR_ITEM_REGULAR),
		list("M89-S 信号弹包", 1, /obj/item/storage/box/m94/signal, VENDOR_ITEM_REGULAR),
		list("M94 标记信号弹包", 10, /obj/item/storage/box/m94, VENDOR_ITEM_REGULAR)
	)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/pilot_officer/populate_product_list(scale)
	return

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_pilot_officer, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("飞行员军官连体服", 0, /obj/item/clothing/under/marine/officer/pilot, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("战术飞行员军官飞行服", 0, /obj/item/clothing/under/marine/officer/pilot/flight, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("绝缘手套（黄色）", 0, /obj/item/clothing/gloves/marine/insulated, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("绝缘手套（黑色）", 0, /obj/item/clothing/gloves/marine/insulated/black, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("MK30战术头盔", 0, /obj/item/clothing/head/helmet/marine/pilot/novisor, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),
		list("皮革挎包", 0, /obj/item/storage/backpack/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("军用即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),

		list("护甲（选择1件）", 0, null, null, null),
		list("M70防弹背心", 0, /obj/item/clothing/suit/storage/jacket/marine/pilot/armor, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("M3-VL型防弹背心", 0, /obj/item/clothing/suit/storage/marine/light/vest/dcc, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("M70B1轻型防弹衣", 0, /obj/item/clothing/suit/storage/jacket/marine/pilot, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),

		list("个人副武器（选择1）", 0, null, null, null),
		list("88 型 4 战斗手枪", 0, /obj/item/weapon/gun/pistol/mod88, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("VP78 手枪", 0, /obj/item/weapon/gun/pistol/vp78, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),

		list("腰带（选择2条）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 弹药装载装置", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 救生包（满）", 0, /obj/item/storage/belt/medical/lifesaver/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 医疗存储装置（满载）", 0, /obj/item/storage/belt/medical/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 M39 手枪套装备", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),
		list("M276 M10 枪套装备", 0, /obj/item/storage/belt/gun/m10, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),
		list("M276通用左轮手枪套装备", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),
		list("M276 M82F 枪套装备", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),
		list("M276通用手枪携行具", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),
		list("M276霰弹枪装弹装置", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋（任选2个）", 0, null, null, null),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（药丸包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救响应包", 0, /obj/item/storage/pouch/first_responder, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("闪光弹袋（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型弹匣袋", 0, /obj/item/storage/pouch/magazine/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗袋", 0, /obj/item/storage/pouch/medical, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗包袋", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("侧臂袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("配件（任选1件）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小包（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色水滴袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("眼镜（选择1副）", 0, null, null, null),
		list("飞行员墨镜，金色", 0, /obj/item/clothing/glasses/sunglasses/aviator, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
		list("飞行员墨镜，银色", 0, /obj/item/clothing/glasses/sunglasses/aviator/silver, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
		list("医疗HUD眼镜", 0, /obj/item/clothing/glasses/hud/health, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_RECOMMENDED),
		list("太阳镜", 0, /obj/item/clothing/glasses/sunglasses, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),

		list("飞行面罩（选择1）", 0, null, null, null),
		list("MK30飞行护目镜，黑色", 0, /obj/item/device/helmet_visor/po_visor, MARINE_CAN_BUY_PILOT_VISOR, VENDOR_ITEM_REGULAR),
		list("MK30飞行护目镜，紫色", 0, /obj/item/device/helmet_visor/po_visor/purple, MARINE_CAN_BUY_PILOT_VISOR, VENDOR_ITEM_REGULAR),
		list("MK30飞行护目镜，浅蓝色", 0, /obj/item/device/helmet_visor/po_visor/lightblue, MARINE_CAN_BUY_PILOT_VISOR, VENDOR_ITEM_REGULAR),
		list("MK30飞行护目镜，红色", 0, /obj/item/device/helmet_visor/po_visor/red, MARINE_CAN_BUY_PILOT_VISOR, VENDOR_ITEM_REGULAR),
		list("MK30飞行护目镜，深蓝色", 0, /obj/item/device/helmet_visor/po_visor/darkblue, MARINE_CAN_BUY_PILOT_VISOR, VENDOR_ITEM_REGULAR),
		list("MK30飞行护目镜，黄色", 0, /obj/item/device/helmet_visor/po_visor/yellow, MARINE_CAN_BUY_PILOT_VISOR, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("循环呼吸器", 0, /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("附件", 0, null, null, null),

		list("抑制器", 10, /obj/item/attachable/suppressor, null, VENDOR_ITEM_REGULAR),
		list("抑制器，紧凑型", 10, /obj/item/attachable/suppressor/sleek, null, VENDOR_ITEM_REGULAR),
		list("加长枪管", 10, /obj/item/attachable/extended_barrel, null, VENDOR_ITEM_REGULAR),
		list("霰弹枪收束器", 10, /obj/item/attachable/shotgun_choke, null, VENDOR_ITEM_REGULAR),
		list("后坐力补偿器", 10, /obj/item/attachable/compensator, null, VENDOR_ITEM_REGULAR),
		list("延长型后坐力补偿器", 10, /obj/item/attachable/extended_barrel/vented, null, VENDOR_ITEM_REGULAR),
		list("M10补偿器", 10, /obj/item/attachable/compensator/m10, null, VENDOR_ITEM_REGULAR),

		list("红点瞄准镜", 10, /obj/item/attachable/reddot, null, VENDOR_ITEM_REGULAR),
		list("S5-微型红点瞄准镜", 10, /obj/item/attachable/reddot/small, null, VENDOR_ITEM_REGULAR),
		list("反射式瞄准镜", 10, /obj/item/attachable/reflex, null, VENDOR_ITEM_REGULAR),

		list("直角握把", 10, /obj/item/attachable/angledgrip, null, VENDOR_ITEM_REGULAR),
		list("垂直握把", 10, /obj/item/attachable/verticalgrip, null, VENDOR_ITEM_REGULAR),
		list("激光瞄准镜", 10, /obj/item/attachable/lasersight, null, VENDOR_ITEM_REGULAR),
		list("陀螺稳定器", 10, /obj/item/attachable/gyro, null, VENDOR_ITEM_REGULAR),
		list("万能钥匙霰弹枪", 10, /obj/item/attachable/attached_gun/shotgun, null, VENDOR_ITEM_REGULAR),

		list("M41A 实心枪托", 10, /obj/item/attachable/stock/rifle, null, VENDOR_ITEM_REGULAR),
		list("M37A2 可折叠枪托", 10, /obj/item/attachable/stock/synth/collapsible, null, VENDOR_ITEM_REGULAR),
		list("M10 实心库存", 10, /obj/item/attachable/stock/m10_solid, null, VENDOR_ITEM_REGULAR),
		list("M39 枪托", 10, /obj/item/attachable/stock/smg, null, VENDOR_ITEM_REGULAR),

		list("弹药", 0, null, null, null),
		list("M10 HV 弹匣（10x20mm-APC）", 10, /obj/item/ammo_magazine/pistol/m10, null, VENDOR_ITEM_REGULAR),
		list("M4RA AP 弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/m4ra/ap, null, VENDOR_ITEM_REGULAR),
		list("M4RA 加长弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/m4ra/extended, null, VENDOR_ITEM_REGULAR),
		list("M39穿甲弹匣（10x20毫米）", 10, /obj/item/ammo_magazine/smg/m39/ap, null, VENDOR_ITEM_REGULAR),
		list("M39 加长弹匣（10x20毫米）", 10, /obj/item/ammo_magazine/smg/m39/extended, null, VENDOR_ITEM_REGULAR),
		list("M41A穿甲弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/ap, null, VENDOR_ITEM_REGULAR),
		list("M41A加长弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/extended, null, VENDOR_ITEM_REGULAR),
		list("M44重型快速装弹器（.44口径）", 10, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),

		list("公用事业", 0, null, null, null),
		list("大型通用袋", 15, /obj/item/storage/pouch/general/large, null, VENDOR_ITEM_REGULAR),
		list("大型弹匣袋", 15, /obj/item/storage/pouch/magazine/large, null, VENDOR_ITEM_REGULAR),
		list("砍刀刀鞘（完整）", 10, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("砍刀袋（已满）", 15, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),
		list("灭火器（便携式）", 5, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("哨声", 5, /obj/item/clothing/accessory/device/whistle, null, VENDOR_ITEM_REGULAR),
		list("双筒望远镜", 5, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("运动探测器", 15, /obj/item/device/motiondetector, null, VENDOR_ITEM_RECOMMENDED)
	))

GLOBAL_LIST_INIT(cm_vending_clothing_dropship_crew_chief, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("手套", 0, /obj/item/clothing/gloves/yellow, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("MK30战术头盔", 0, /obj/item/clothing/head/helmet/marine/pilot/novisor, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),
		list("巡逻帽", 0, /obj/item/clothing/head/cmcap, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),
		list("皮革挎包", 0, /obj/item/storage/backpack/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("单兵即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),

		list("护甲（选择1件）", 0, null, null, null),
		list("M70防弹背心", 0, /obj/item/clothing/suit/storage/jacket/marine/pilot/armor, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("M3-VL型防弹背心", 0, /obj/item/clothing/suit/storage/marine/light/vest/dcc, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),

		list("个人副武器（选择1）", 0, null, null, null),
		list("88 型 4 战斗手枪", 0, /obj/item/weapon/gun/pistol/mod88, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("VP78 手枪", 0, /obj/item/weapon/gun/pistol/vp78, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),

		list("腰带（选择2条）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 弹药装载装置", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 救生包（满）", 0, /obj/item/storage/belt/medical/lifesaver/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 医疗存储装置（满载）", 0, /obj/item/storage/belt/medical/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 M39 枪套装备", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),
		list("M276通用左轮手枪套装备", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),
		list("M276 M82F 枪套装备", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),
		list("M276通用手枪携行装具", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),
		list("M276霰弹枪装弹装置", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋 (选择 2)", 0, null, null, null),
		list("急救包（可补充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救响应包", 0, /obj/item/storage/pouch/first_responder, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("闪光弹袋（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型弹匣袋", 0, /obj/item/storage/pouch/magazine/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗袋", 0, /obj/item/storage/pouch/medical, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗包袋", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("侧臂袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("配件（选择1件）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小袋（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("眼镜（选择1副）", 0, null, null, null),
		list("飞行员墨镜，金色", 0, /obj/item/clothing/glasses/sunglasses/aviator, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
		list("飞行员墨镜，银色", 0, /obj/item/clothing/glasses/sunglasses/aviator/silver, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
		list("医疗HUD眼镜", 0, /obj/item/clothing/glasses/hud/health, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_RECOMMENDED),
		list("医疗护目镜", 0, /obj/item/device/helmet_visor/medical/advanced, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_RECOMMENDED),
		list("太阳镜", 0, /obj/item/clothing/glasses/sunglasses, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),

		list("飞行面罩（选择1）", 0, null, null, null),
		list("MK30飞行护目镜，黑色", 0, /obj/item/device/helmet_visor/po_visor, MARINE_CAN_BUY_PILOT_VISOR, VENDOR_ITEM_REGULAR),
		list("MK30飞行护目镜，紫色", 0, /obj/item/device/helmet_visor/po_visor/purple, MARINE_CAN_BUY_PILOT_VISOR, VENDOR_ITEM_REGULAR),
		list("MK30飞行护目镜，浅蓝色", 0, /obj/item/device/helmet_visor/po_visor/lightblue, MARINE_CAN_BUY_PILOT_VISOR, VENDOR_ITEM_REGULAR),
		list("MK30飞行护目镜，红色", 0, /obj/item/device/helmet_visor/po_visor/red, MARINE_CAN_BUY_PILOT_VISOR, VENDOR_ITEM_REGULAR),
		list("MK30飞行护目镜，深蓝色", 0, /obj/item/device/helmet_visor/po_visor/darkblue, MARINE_CAN_BUY_PILOT_VISOR, VENDOR_ITEM_REGULAR),
		list("MK30飞行护目镜，黄色", 0, /obj/item/device/helmet_visor/po_visor/yellow, MARINE_CAN_BUY_PILOT_VISOR, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("循环呼吸器", 0, /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("配件", 0, null, null, null),

		list("消音器", 10, /obj/item/attachable/suppressor, null, VENDOR_ITEM_REGULAR),
		list("抑制器，紧凑型", 10, /obj/item/attachable/suppressor/sleek, null, VENDOR_ITEM_REGULAR),
		list("加长枪管", 10, /obj/item/attachable/extended_barrel, null, VENDOR_ITEM_REGULAR),
		list("霰弹枪收束器", 10, /obj/item/attachable/shotgun_choke, null, VENDOR_ITEM_REGULAR),
		list("后坐力补偿器", 10, /obj/item/attachable/compensator, null, VENDOR_ITEM_REGULAR),
		list("加长型后坐力补偿器", 10, /obj/item/attachable/extended_barrel/vented, null, VENDOR_ITEM_REGULAR),
		list("M10补偿器", 10, /obj/item/attachable/compensator/m10, null, VENDOR_ITEM_REGULAR),

		list("红点瞄准镜", 10, /obj/item/attachable/reddot, null, VENDOR_ITEM_REGULAR),
		list("S5-微型红点瞄准镜", 10, /obj/item/attachable/reddot/small, null, VENDOR_ITEM_REGULAR),
		list("反射式瞄准镜", 10, /obj/item/attachable/reflex, null, VENDOR_ITEM_REGULAR),

		list("直角握把", 10, /obj/item/attachable/angledgrip, null, VENDOR_ITEM_REGULAR),
		list("垂直握把", 10, /obj/item/attachable/verticalgrip, null, VENDOR_ITEM_REGULAR),
		list("激光瞄准镜", 10, /obj/item/attachable/lasersight, null, VENDOR_ITEM_REGULAR),
		list("陀螺稳定器", 10, /obj/item/attachable/gyro, null, VENDOR_ITEM_REGULAR),
		list("万能钥匙霰弹枪", 10, /obj/item/attachable/attached_gun/shotgun, null, VENDOR_ITEM_REGULAR),

		list("M41A 实心枪托", 10, /obj/item/attachable/stock/rifle, null, VENDOR_ITEM_REGULAR),
		list("M37A2 可折叠枪托", 10, /obj/item/attachable/stock/synth/collapsible, null, VENDOR_ITEM_REGULAR),
		list("M10 实心库存", 10, /obj/item/attachable/stock/m10_solid, null, VENDOR_ITEM_REGULAR),
		list("M39 枪托", 10, /obj/item/attachable/stock/smg, null, VENDOR_ITEM_REGULAR),

		list("弹药", 0, null, null, null),
		list("M4RA AP 弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/m4ra/ap, null, VENDOR_ITEM_REGULAR),
		list("M4RA 加长弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/m4ra/extended, null, VENDOR_ITEM_REGULAR),
		list("M39穿甲弹匣（10x20毫米）", 10, /obj/item/ammo_magazine/smg/m39/ap, null, VENDOR_ITEM_REGULAR),
		list("M39加长弹匣（10x20毫米）", 10, /obj/item/ammo_magazine/smg/m39/extended, null, VENDOR_ITEM_REGULAR),
		list("M41A穿甲弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/ap, null, VENDOR_ITEM_REGULAR),
		list("M41A扩展弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/extended, null, VENDOR_ITEM_REGULAR),
		list("M44重型快速装弹器（.44口径）", 10, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),

		list("公用事业", 0, null, null, null),
		list("大型通用袋", 15, /obj/item/storage/pouch/general/large, null, VENDOR_ITEM_REGULAR),
		list("大型弹匣袋", 15, /obj/item/storage/pouch/magazine/large, null, VENDOR_ITEM_REGULAR),
		list("砍刀刀鞘（完整）", 10, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("砍刀袋（已满）", 15, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),
		list("灭火器（便携式）", 5, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("双筒望远镜", 5, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("哨声", 5, /obj/item/clothing/accessory/device/whistle, null, VENDOR_ITEM_REGULAR),
		list("运动探测器", 15, /obj/item/device/motiondetector, null, VENDOR_ITEM_RECOMMENDED)
	))

//MARINE_CAN_BUY_SHOES MARINE_CAN_BUY_UNIFORM currently not used
/obj/structure/machinery/cm_vending/clothing/pilot_officer
	name = "\improper ColMarTech（殖民地海军陆战队科技） 空降艇乘员装备架"
	desc = "一个连接着海量标准配发装备存储库的自动化装备架，供运输机机组人员使用。"
	req_access = list(ACCESS_MARINE_PILOT)
	vendor_role = list(JOB_CAS_PILOT, JOB_DROPSHIP_PILOT, JOB_DROPSHIP_CREW_CHIEF)

/obj/structure/machinery/cm_vending/clothing/pilot_officer/get_listed_products(mob/user)
	if(!user)
		var/list/combined = list()
		combined += GLOB.cm_vending_clothing_dropship_crew_chief
		combined += GLOB.cm_vending_clothing_pilot_officer
		return combined
	if(user.job == JOB_DROPSHIP_CREW_CHIEF)
		return GLOB.cm_vending_clothing_dropship_crew_chief
	if(user.job == JOB_CAS_PILOT)
		return GLOB.cm_vending_clothing_pilot_officer
	if(user.job == JOB_DROPSHIP_PILOT)
		return GLOB.cm_vending_clothing_pilot_officer
	return ..()
