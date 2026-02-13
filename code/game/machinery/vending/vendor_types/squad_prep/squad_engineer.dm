//------------GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_gear_engi, list(
		list("工程师套装（必选）", 0, null, null, null),
		list("必备工程师套装", 0, /obj/effect/essentials_set/engi, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("手持防御（选择1项）", 0, null, null, null),
		list("21S特斯拉线圈", 0, /obj/item/defenses/handheld/tesla_coil, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_MANDATORY),
		list("JIMA 插旗", 0, /obj/item/defenses/handheld/planted_flag, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_MANDATORY),
		list("UA 42-F 哨兵火焰喷射器", 0, /obj/item/defenses/handheld/sentry/flamer, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_MANDATORY),
		list("UA 571-C 哨戒炮", 0, /obj/item/defenses/handheld/sentry, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_MANDATORY),
		list("M6H-BRUTE 破门发射器",0, /obj/item/storage/belt/gun/brutepack/full, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_MANDATORY),
		list("哨兵升级套件", 15, /obj/item/engi_upgrade_kit, null, VENDOR_ITEM_REGULAR),


		list("工程学联合人民阵线", 0, null, null, null),
		list("气闸电路板", 2, /obj/item/circuitboard/airlock, null, VENDOR_ITEM_REGULAR),
		list("APC电路板", 2, /obj/item/circuitboard/apc, null, VENDOR_ITEM_REGULAR),
		list("挖掘工具 (ET)", 2, /obj/item/tool/shovel/etool, null, VENDOR_ITEM_REGULAR),
		list("高容量动力电池", 3, /obj/item/cell/high, null, VENDOR_ITEM_REGULAR),
		list("金属 x10", 5, /obj/item/stack/sheet/metal/small_stack, null, VENDOR_ITEM_RECOMMENDED),
		list("塑钢 x10", 7, /obj/item/stack/sheet/plasteel/small_stack, null, VENDOR_ITEM_RECOMMENDED),
		list("塑胶炸药", 3, /obj/item/explosive/plastic, null, VENDOR_ITEM_REGULAR),
		list("爆破炸药", 5, /obj/item/explosive/plastic/breaching_charge, null, VENDOR_ITEM_RECOMMENDED),
		list("沙袋 x25", 10, /obj/item/stack/sandbags_empty/half, null, VENDOR_ITEM_RECOMMENDED),
		list("超级容量动力电池", 10, /obj/item/cell/super, null, VENDOR_ITEM_REGULAR),
		list("ES-11 移动燃料罐", 4, /obj/item/tool/weldpack/minitank, null, VENDOR_ITEM_REGULAR),

		list("爆炸物", 0, null, null, null),
		list("M40 HEDP 高爆弹（内含3枚榴弹）", 18, /obj/item/storage/box/packet/high_explosive, null, VENDOR_ITEM_REGULAR),
		list("M40 HIDP 燃烧弹包（内含3枚手榴弹）", 18, /obj/item/storage/box/packet/incendiary, null, VENDOR_ITEM_REGULAR),
		list("M40 WPDP 白磷弹包（内含3枚手榴弹）", 18, /obj/item/storage/box/packet/phosphorus, null, VENDOR_ITEM_REGULAR),
		list("M40 HSDP 烟雾弹包（内含3枚手榴弹）", 9, /obj/item/storage/box/packet/smoke, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-Frag 空爆弹包（内含3枚空爆榴弹）", 13, /obj/item/storage/box/packet/airburst_he, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-燃烧空爆弹包（内含3枚空爆手榴弹）", 13, /obj/item/storage/box/packet/airburst_incen, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-烟雾空爆弹包（内含3枚空爆榴弹）", 9, /obj/item/storage/box/packet/airburst_smoke, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-大黄蜂空爆弹包（内含3枚空爆榴弹）", 13, /obj/item/storage/box/packet/hornet, null, VENDOR_ITEM_REGULAR),
		list("M20 地雷箱（内含5枚地雷）", 18, /obj/item/storage/box/explosive_mines, null, VENDOR_ITEM_REGULAR),
		list("M40 MFHS 金属泡沫手榴弹", 5, /obj/item/explosive/grenade/metal_foam, null, VENDOR_ITEM_REGULAR),
		list("G2 电击手雷包（内含3枚手雷）",  16, /obj/item/storage/box/packet/sebb, null, VENDOR_ITEM_REGULAR),

		list("主要弹药", 0, null, null, null),
		list("M4RA AP 弹匣（10x24毫米）", 6, /obj/item/ammo_magazine/rifle/m4ra/ap, null, VENDOR_ITEM_REGULAR),
		list("M4RA 加长弹匣（10x24毫米）", 6, /obj/item/ammo_magazine/rifle/m4ra/extended, null, VENDOR_ITEM_REGULAR),
		list("M10穿甲弹匣（10x20毫米-穿甲弹）", 6, /obj/item/ammo_magazine/pistol/m10/ap , null, VENDOR_ITEM_REGULAR),
		list("M10 AP 扩展弹匣（10x20mm-APC）", 8, /obj/item/ammo_magazine/pistol/m10/ap/extended , null, VENDOR_ITEM_REGULAR),
		list("M39穿甲弹匣（10x20毫米）", 6, /obj/item/ammo_magazine/smg/m39/ap , null, VENDOR_ITEM_REGULAR),
		list("M39加长弹匣（10x20毫米）", 6, /obj/item/ammo_magazine/smg/m39/extended , null, VENDOR_ITEM_REGULAR),
		list("M41A穿甲弹匣（10x24毫米）", 6, /obj/item/ammo_magazine/rifle/ap , null, VENDOR_ITEM_REGULAR),
		list("M41A加长弹匣（10x24毫米）", 6, /obj/item/ammo_magazine/rifle/extended , null, VENDOR_ITEM_REGULAR),

		list("手枪弹药", 0, null, null, null),
		list("M10 HV 加长弹匣（10x20mm-APC）", 6, /obj/item/ammo_magazine/pistol/m10/extended , null, VENDOR_ITEM_REGULAR),
		list("M44重型快速装弹器（.44口径）", 6, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),
		list("M44神射手快速装弹器（.44口径）", 6, /obj/item/ammo_magazine/revolver/marksman, null, VENDOR_ITEM_REGULAR),
		list("M4A3 HP 弹匣", 3, /obj/item/ammo_magazine/pistol/hp, null, VENDOR_ITEM_REGULAR),
		list("M4A3 穿甲弹弹匣", 3, /obj/item/ammo_magazine/pistol/ap, null, VENDOR_ITEM_REGULAR),
		list("VP78 弹匣", 3, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6智能手枪弹匣（.45口径）", 6, /obj/item/ammo_magazine/pistol/smart, null, VENDOR_ITEM_REGULAR),

		list("护甲", 0, null, null, null),
		list("M3 B12型 海军陆战队员 护甲", 24, /obj/item/clothing/suit/storage/marine/medium/leader, null, VENDOR_ITEM_REGULAR),
		list("M4型制式护甲", 16, /obj/item/clothing/suit/storage/marine/medium/rto, null, VENDOR_ITEM_REGULAR),

		list("限制性火器", 0, null, null, null),
		list("VP78 手枪", 8, /obj/item/storage/box/guncase/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6 智能手枪", 12, /obj/item/storage/box/guncase/smartpistol, null, VENDOR_ITEM_REGULAR),
		list("M240 焚化装置", 12, /obj/item/storage/box/guncase/flamer, null, VENDOR_ITEM_REGULAR),
		list("M85A1 榴弹发射器", 24, /obj/item/storage/box/guncase/m85a1, null, VENDOR_ITEM_REGULAR),
		list("M56D重型机枪", 24, /obj/item/storage/box/guncase/m56d, null, VENDOR_ITEM_REGULAR),

		list("服装物品", 0, null, null, null),
		list("砍刀刀鞘（完整）", 6, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("砍刀袋（已满）", 8, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）无线电通讯背包", 15, /obj/item/storage/backpack/marine/satchel/rto, null, VENDOR_ITEM_REGULAR),
		list("油箱绑带包", 4, /obj/item/storage/pouch/flamertank, null, VENDOR_ITEM_REGULAR),
		list("投石袋", 6, /obj/item/storage/pouch/sling, null, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 6, /obj/item/storage/pouch/general/large, null, VENDOR_ITEM_REGULAR),
		list("M276型 战斗 工具腰带 装备", 15, /obj/item/storage/belt/gun/utility, null, VENDOR_ITEM_REGULAR),

		list("公共事业", 0, null, null, null),
		list("滚筒床", 5, /obj/item/roller, null, VENDOR_ITEM_REGULAR),
		list("富尔顿装置堆叠", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("灭火器（便携式）", 3, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("运动探测器", 8, /obj/item/device/motiondetector, null, VENDOR_ITEM_REGULAR),
		list("哨声", 3, /obj/item/clothing/accessory/device/whistle, null, VENDOR_ITEM_REGULAR),
		list("合成重置密钥", 10, /obj/item/device/defibrillator/synthetic, null, VENDOR_ITEM_REGULAR),

		list("望远镜", 0, null, null, null),
		list("双筒望远镜", 5, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("测距仪", 10, /obj/item/device/binoculars/range, null, VENDOR_ITEM_REGULAR),
		list("激光指示器", 15, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_REGULAR),

		list("头盔光学系统", 0, null, null, null),
		list("医疗头盔光学镜片", 12, /obj/item/device/helmet_visor/medical, null, VENDOR_ITEM_REGULAR),
		list("焊接面罩", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),

		list("宣传册", 0, null, null, null),
		list("JTAC 手册", 15, /obj/item/pamphlet/skill/jtac, null, VENDOR_ITEM_REGULAR),

		list("无线电按键", 0, null, null, null),
		list("英特尔无线电加密密钥", 3, /obj/item/device/encryptionkey/intel, null, VENDOR_ITEM_REGULAR),
		list("JTAC无线电加密密钥", 3, /obj/item/device/encryptionkey/jtac, null, VENDOR_ITEM_REGULAR),
		list("补给无线电加密密钥", 3, /obj/item/device/encryptionkey/req, null, VENDOR_ITEM_REGULAR),
		list("医疗无线电加密密钥", 3, /obj/item/device/encryptionkey/med, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/gear/engi
	name = "\improper 殖民地海军陆战队科技（ColMarTech） 小队通讯技术装备架"
	desc = "一个为战斗技术员准备的自动化装备架。"
	icon_state = "eng_gear"
	vendor_role = list(JOB_SQUAD_ENGI)
	req_access = list(ACCESS_MARINE_ENGPREP)

/obj/structure/machinery/cm_vending/gear/engi/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_engi

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_engi, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("标准海军陆战队员制服", 0, list(/obj/item/clothing/under/marine/engineer, /obj/item/clothing/shoes/marine/knife, /obj/item/device/radio/headset/almayer/marine), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("绝缘手套（黑色）", 0, /obj/item/clothing/gloves/marine/insulated/black, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("绝缘手套（黄色/棕褐色）", 0, /obj/item/clothing/gloves/marine/insulated, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("单兵即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("地图", 0, /obj/item/map/current_map, MARINE_CAN_BUY_MAP, VENDOR_ITEM_MANDATORY),

		list("头盔（选择1）", 0, null, null, null),
		list("M10技术员头盔", 0, /obj/item/clothing/head/helmet/marine/tech, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("M10焊接头盔", 0, /obj/item/clothing/head/helmet/marine/welding, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("护甲（选择1件）", 0, null, null, null),
		list("轻甲", 0, /obj/item/clothing/suit/storage/marine/light, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("中型护甲", 0, /obj/item/clothing/suit/storage/marine/medium, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),
		list("重甲", 0, /obj/item/clothing/suit/storage/marine/heavy, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),

		list("背包（选择1件）", 0, null, null, null),
		list("砍刀鞘（完整）", 0, /obj/item/storage/large_holster/machete/full, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("技师背包", 0, /obj/item/storage/backpack/marine/tech, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("技师挎包", 0, /obj/item/storage/backpack/marine/satchel/tech, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("技师焊接包", 0, /obj/item/storage/backpack/marine/engineerpack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("技师焊工-挎包", 0, /obj/item/storage/backpack/marine/engineerpack/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("技师焊工胸挂", 0, /obj/item/storage/backpack/marine/engineerpack/welder_chestrig, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("手榴弹挎包", 0, /obj/item/storage/backpack/marine/grenadepack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),

		list("腰带（选择1）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276弹药装载装置", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276通用手枪套携行系统", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M39 手枪套装备", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276通用左轮手枪套装备", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M82F 枪套装备", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276霰弹枪装弹装置", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 工具腰带装备（全套）", 0, /obj/item/storage/belt/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_MANDATORY),
		list("M276 M40 榴弹携行具", 0, /obj/item/storage/belt/grenade, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M277型构造平台", 0, /obj/item/storage/belt/utility/construction, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),

		list("小袋 (选择 2)", 0, null, null, null),
		list("建筑袋", 0, /obj/item/storage/pouch/construction, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("电子钱包（已满）", 0, /obj/item/storage/pouch/electronics/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("爆裂袋", 0, /obj/item/storage/pouch/explosive, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("闪光弹包（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("弹匣袋", 0, /obj/item/storage/pouch/magazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("中型通用袋", 0, /obj/item/storage/pouch/general/medium, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("手枪袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工具袋（已满）", 0, /obj/item/storage/pouch/tools/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工程师工具包袋", 0, /obj/item/storage/pouch/engikit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),


		list("配件（任选其一）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小包（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("蛛网", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("小型工具织带（完整版）", 0, /obj/item/clothing/accessory/storage/tool_webbing/small/equipped, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("小型工具掉落袋（满）", 0, /obj/item/clothing/accessory/storage/tool_webbing/yellow_drop/small/equipped, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/engi
	name = "\improper 殖民地海军陆战队科技（ColMarTech） 小队通讯技术装备架"
	desc = "一个连接着海量战斗技术员标准制式装备库的自动化装备架。"
	req_access = list(ACCESS_MARINE_ENGPREP)
	vendor_role = list(JOB_SQUAD_ENGI)

/obj/structure/machinery/cm_vending/clothing/engi/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_engi

/obj/structure/machinery/cm_vending/clothing/engi/alpha
	squad_tag = SQUAD_MARINE_1
	req_access = list(ACCESS_MARINE_ENGPREP, ACCESS_MARINE_ALPHA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/alpha/engi

/obj/structure/machinery/cm_vending/clothing/engi/bravo
	squad_tag = SQUAD_MARINE_2
	req_access = list(ACCESS_MARINE_ENGPREP, ACCESS_MARINE_BRAVO)
	headset_type = /obj/item/device/radio/headset/almayer/marine/bravo/engi

/obj/structure/machinery/cm_vending/clothing/engi/charlie
	squad_tag = SQUAD_MARINE_3
	req_access = list(ACCESS_MARINE_ENGPREP, ACCESS_MARINE_CHARLIE)
	headset_type = /obj/item/device/radio/headset/almayer/marine/charlie/engi

/obj/structure/machinery/cm_vending/clothing/engi/delta
	squad_tag = SQUAD_MARINE_4
	req_access = list(ACCESS_MARINE_ENGPREP, ACCESS_MARINE_DELTA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/delta/engi

//------------ESSENTIAL SETS---------------

/obj/effect/essentials_set/engi
	spawned_gear_list = list(
		/obj/item/explosive/plastic,
		/obj/item/stack/sandbags_empty = 25,
		/obj/item/stack/sheet/metal/large_stack,
		/obj/item/stack/sheet/plasteel/med_large_stack,
		/obj/item/circuitboard/apc,
		/obj/item/cell/high,
		/obj/item/tool/shovel/etool/folded,
		/obj/item/device/lightreplacer,
		/obj/item/weapon/gun/smg/nailgun/compact/tactical,
	)
