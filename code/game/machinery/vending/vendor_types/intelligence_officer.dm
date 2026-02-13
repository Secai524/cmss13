//------------GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_gear_intelligence_officer, list(
		list("情报套装（必选）", 0, null, null, null),
		list("必备情报套装", 0, /obj/effect/essentials_set/intelligence_officer, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("工程学S联合人民阵线LIES", 0, null, null, null),
		list("动力控制模块", 5, /obj/item/circuitboard/apc, null, VENDOR_ITEM_REGULAR),
		list("塑胶炸药", 10, /obj/item/explosive/plastic, null, VENDOR_ITEM_REGULAR),
		list("焊接护目镜", 5, /obj/item/clothing/glasses/welding, null, VENDOR_ITEM_REGULAR),

		list("主要弹药", 0, null, null, null),
		list("M4RA AP 弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/m4ra/ap, null, VENDOR_ITEM_REGULAR),
		list("M4RA 扩容弹匣（10x24mm）", 10, /obj/item/ammo_magazine/rifle/m4ra/extended, null, VENDOR_ITEM_REGULAR),
		list("M39穿甲弹匣（10x20毫米）", 10, /obj/item/ammo_magazine/smg/m39/ap , null, VENDOR_ITEM_REGULAR),
		list("M39 加长弹匣（10x20毫米）", 10, /obj/item/ammo_magazine/smg/m39/extended , null, VENDOR_ITEM_REGULAR),
		list("M41A穿甲弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/ap , null, VENDOR_ITEM_REGULAR),
		list("M41A扩容弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/extended , null, VENDOR_ITEM_REGULAR),

		list("手枪弹药", 0, null, null, null),
		list("M44重型快速装弹器（.44口径）", 10, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),
		list("M44神射手快速装弹器（.44口径）", 10, /obj/item/ammo_magazine/revolver/marksman, null, VENDOR_ITEM_REGULAR),
		list("M4A3 HP 弹匣", 5, /obj/item/ammo_magazine/pistol/hp, null, VENDOR_ITEM_REGULAR),
		list("M4A3 穿甲弹匣", 5, /obj/item/ammo_magazine/pistol/ap, null, VENDOR_ITEM_REGULAR),
		list("VP78 弹匣", 5, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6智能手枪弹匣（.45口径）", 10, /obj/item/ammo_magazine/pistol/smart, null, VENDOR_ITEM_REGULAR),

		list("限制性火器", 0, null, null, null),
		list("VP78 手枪", 15, /obj/item/storage/box/guncase/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6 智能手枪", 15, /obj/item/storage/box/guncase/smartpistol, null, VENDOR_ITEM_REGULAR),

		list("限制装备", 0, null, null, null),
		list("M276型 战斗 工具带 装备", 15, /obj/item/storage/belt/gun/utility, null, VENDOR_ITEM_RECOMMENDED),

		list("袋囊", 0, null, null, null),
		list("大型弹匣袋", 10, /obj/item/storage/pouch/magazine/large, null, VENDOR_ITEM_REGULAR),
		list("大型霰弹枪弹袋", 10, /obj/item/storage/pouch/shotgun/large, null, VENDOR_ITEM_REGULAR),
		list("自动注射器袋（满）", 15, /obj/item/storage/pouch/autoinjector/full, null, VENDOR_ITEM_RECOMMENDED),
		list("砍刀袋（已满）", 10, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),

		list("公用事业", 0, null, null, null),
		list("灭火器（便携式）", 5, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("富尔顿装置堆叠", 10, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("运动探测器", 15, /obj/item/device/motiondetector, null, VENDOR_ITEM_RECOMMENDED),
		list("数据探测器", 5, /obj/item/device/motiondetector/intel, null, VENDOR_ITEM_REGULAR),

		list("望远镜", 0, null, null, null),
		list("双筒望远镜", 5, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("测距仪", 10, /obj/item/device/binoculars/range, null, VENDOR_ITEM_REGULAR),
		list("激光指示器", 15, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_REGULAR),

		list("头盔光学系统", 0, null, null, null),
		list("医疗头盔光学镜片", 5, /obj/item/device/helmet_visor/medical, null, VENDOR_ITEM_REGULAR),
		list("焊接面罩", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),
		list("夜视光学镜", 25, /obj/item/device/helmet_visor/night_vision, null, VENDOR_ITEM_RECOMMENDED),

		list("无线电按键", 0, null, null, null),
		list("英特尔无线电加密密钥", 5, /obj/item/device/encryptionkey/intel, null, VENDOR_ITEM_REGULAR),

		list("备用情报套件", 0, null, null, null),
		list("战场情报支援套件（供未受训人员使用）", 20, /obj/item/storage/box/kit/mini_intel, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/gear/intelligence_officer
	name = "殖民地海军陆战队科技情报官装备架"
	desc = "情报官专用自动化装备架。"
	icon_state = "intel_gear"
	req_access = list(ACCESS_MARINE_COMMAND)
	vendor_role = list(JOB_INTEL)

/obj/structure/machinery/cm_vending/gear/intelligence_officer/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_intelligence_officer

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_intelligence_officer, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("绝缘手套（黄色/棕褐色）", 0, /obj/item/clothing/gloves/marine/insulated, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("绝缘手套（黑色）", 0, /obj/item/clothing/gloves/marine/insulated/black, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("军用即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),

		list("护甲（选择1件）", 0, null, null, null),
		list("XM4 型情报装甲", 0, /obj/item/clothing/suit/storage/marine/medium/rto/intel, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("M3-L型轻型护甲", 0, /obj/item/clothing/suit/storage/marine/light, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("服务夹克", 0, /obj/item/clothing/suit/storage/jacket/marine/service, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),

		list("背包（选择1）", 0, null, null, null),
		list("远征背包", 0, /obj/item/storage/backpack/marine/satchel/intel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("远征胸挂", 0, /obj/item/storage/backpack/marine/satchel/intel/chestrig, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("远征行囊", 0, /obj/item/storage/backpack/marine/satchel/intel/expeditionsatchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("无线电电话包", 0, /obj/item/storage/backpack/marine/satchel/rto/io, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),

		list("头盔（选择1个）", 0, null, null, null),
		list("XM12 军官头盔", 0, /obj/item/clothing/head/helmet/marine/rto/intel, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("贝雷帽，标准型", 0, /obj/item/clothing/head/beret/cm, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("贝雷帽，棕褐色", 0, /obj/item/clothing/head/beret/cm/tan, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）军官帽", 0, /obj/item/clothing/head/cmcap/bridge, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("腰带（选择1）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 弹药装载装置", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276通用手枪携行装具", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M39 手枪套装备", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276通用左轮手枪套装备", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276霰弹枪装弹装置", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 工具腰带装备（全套）", 0, /obj/item/storage/belt/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),

		list("小袋（任选2个）", 0, null, null, null),
		list("文件袋", 0, /obj/item/storage/pouch/document, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（可补充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救药包（药片）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("闪光弹袋（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("油箱绑带袋", 0, /obj/item/storage/pouch/flamertank, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("弹匣袋", 0, /obj/item/storage/pouch/magazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("侧臂袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工具袋（满）", 0, /obj/item/storage/pouch/tools/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("配件（选择1件）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("腿部挂包 ", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小包（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("蛛网", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("面具（选择1）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR)
	))

//MARINE_CAN_BUY_SHOES MARINE_CAN_BUY_UNIFORM currently not used
/obj/structure/machinery/cm_vending/clothing/intelligence_officer
	name = "殖民地海军陆战队科技情报官装备架"
	desc = "一个连接着海量情报官标准配发装备存储库的自动化装备架。"
	req_access = list(ACCESS_MARINE_COMMAND)
	vendor_role = list(JOB_INTEL)

/obj/structure/machinery/cm_vending/clothing/intelligence_officer/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_intelligence_officer

//------------GUNS VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/intelligence_officer
	name = "\improper 殖民地海军陆战队科技情报官武器架"
	desc = "一个连接着小批量标准配发武器存储库的自动化武器架。仅限情报官使用。"
	icon_state = "guns"
	req_access = list(ACCESS_MARINE_COMMAND)
	vendor_role = list(JOB_INTEL)
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND

/obj/structure/machinery/cm_vending/sorted/cargo_guns/intelligence_officer/get_listed_products(mob/user)
	return GLOB.cm_vending_guns_intelligence_officer

GLOBAL_LIST_INIT(cm_vending_guns_intelligence_officer, list(
		list("主要火器", -1, null, null),
		list("M4RA 战斗步枪", 4, /obj/item/weapon/gun/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("M39 冲锋枪", 4, /obj/item/weapon/gun/smg/m39, VENDOR_ITEM_REGULAR),
		list("M37A2 泵动式霰弹枪", 4, /obj/item/weapon/gun/shotgun/pump/m37a, VENDOR_ITEM_REGULAR),
		list("M41A脉冲步枪MK2", 4, /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_REGULAR),

		list("主要弹药", -1, null, null),
		list("霰弹盒（12号口径）", 12, /obj/item/ammo_magazine/shotgun/buckshot, VENDOR_ITEM_REGULAR),
		list("霰弹枪箭形弹盒（12号口径）", 12, /obj/item/ammo_magazine/shotgun/flechette, VENDOR_ITEM_REGULAR),
		list("霰弹枪独头弹盒（12号口径）", 12, /obj/item/ammo_magazine/shotgun/slugs, VENDOR_ITEM_REGULAR),
		list("M4RA弹匣（10x24毫米）", 24, /obj/item/ammo_magazine/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("M39 HV 弹匣（10x20毫米）", 24, /obj/item/ammo_magazine/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A弹匣（10x24毫米）", 24, /obj/item/ammo_magazine/rifle, VENDOR_ITEM_REGULAR),

		list("侧臂", -1, null, null),
		list("88 型 4 战斗手枪", 4, /obj/item/weapon/gun/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44 战斗左轮手枪", 4, /obj/item/weapon/gun/revolver/m44, VENDOR_ITEM_REGULAR),
		list("M4A3 制式手枪", 4, /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),

		list("手枪弹药", -1, null, null),
		list("88M4 AP 弹匣（9毫米）", 20, /obj/item/ammo_magazine/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44快速装弹器（.44口径）", 20, /obj/item/ammo_magazine/revolver, VENDOR_ITEM_REGULAR),
		list("M4A3弹匣（9毫米）", 20, /obj/item/ammo_magazine/pistol, VENDOR_ITEM_REGULAR),
		list("M4A3 AP 弹匣（9毫米）", 8, /obj/item/ammo_magazine/pistol/ap, VENDOR_ITEM_REGULAR),
		list("M4A3 HP 弹匣（9毫米）", 8, /obj/item/ammo_magazine/pistol/hp, VENDOR_ITEM_REGULAR),
		list("VP78弹匣（9毫米）", 16, /obj/item/ammo_magazine/pistol/vp78, VENDOR_ITEM_REGULAR),

		list("附件", -1, null, null),
		list("Rail 手电筒", 8, /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
		list("下挂式手电筒握把", 4, /obj/item/attachable/flashlight/grip, VENDOR_ITEM_RECOMMENDED),

		list("公用事业", -1, null, null),
		list("M11 投掷飞刀", 18, /obj/item/weapon/throwing_knife, VENDOR_ITEM_REGULAR),
		list("M5刺刀", 4, /obj/item/attachable/bayonet, VENDOR_ITEM_REGULAR),
		list("M89-S 信号弹包", 2, /obj/item/storage/box/m94/signal, VENDOR_ITEM_REGULAR),
		list("M94 标记信号弹包", 20, /obj/item/storage/box/m94, VENDOR_ITEM_RECOMMENDED)
	))

//------------ESSENTIAL SETS---------------

/obj/effect/essentials_set/intelligence_officer
	spawned_gear_list = list(
		/obj/item/tool/crowbar,
		/obj/item/stack/fulton,
		/obj/item/device/motiondetector/intel,
		/obj/item/device/binoculars,
	)
