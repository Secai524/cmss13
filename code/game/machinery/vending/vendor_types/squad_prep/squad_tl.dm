//------------GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_gear_tl, list(
		list("爆炸物", 0, null, null, null),
		list("M40 HEDP 高爆弹（内含3枚榴弹）", 18, /obj/item/storage/box/packet/high_explosive, null, VENDOR_ITEM_REGULAR),
		list("M40 HIDP 燃烧弹包（内含3枚手榴弹）", 18, /obj/item/storage/box/packet/incendiary, null, VENDOR_ITEM_REGULAR),
		list("M40 WPDP 白磷弹包（内含3枚手榴弹）", 18, /obj/item/storage/box/packet/phosphorus, null, VENDOR_ITEM_REGULAR),
		list("M40 HSDP 烟雾弹包（内含3枚手榴弹）", 9, /obj/item/storage/box/packet/smoke, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-破片空爆弹包（内含3枚空爆榴弹）", 13, /obj/item/storage/box/packet/airburst_he, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-燃烧弹空爆弹包（内含3枚空爆手榴弹）", 13, /obj/item/storage/box/packet/airburst_incen, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-烟雾空爆弹包（内含3枚空爆榴弹）", 9, /obj/item/storage/box/packet/airburst_smoke, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-大黄蜂空爆弹包（内含3枚空爆榴弹）", 13, /obj/item/storage/box/packet/hornet, null, VENDOR_ITEM_REGULAR),
		list("M20 地雷箱（内含5枚地雷）", 20, /obj/item/storage/box/explosive_mines, null, VENDOR_ITEM_REGULAR),
		list("M40 MFHS 金属泡沫手榴弹", 5, /obj/item/explosive/grenade/metal_foam, null, VENDOR_ITEM_REGULAR),
		list("G2 电击手雷包（内含3枚手雷）",  16, /obj/item/storage/box/packet/sebb, null, VENDOR_ITEM_REGULAR),

		list("主要弹药", 0, null, null, null),
		list("M4RA AP 弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/m4ra/ap, null, VENDOR_ITEM_REGULAR),
		list("M4RA 加长弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/m4ra/extended, null, VENDOR_ITEM_REGULAR),
		list("M10 AP 弹匣（10x20mm-APC）", 6, /obj/item/ammo_magazine/pistol/m10/ap , null, VENDOR_ITEM_REGULAR),
		list("M10 AP 加长弹匣（10x20mm-APC）", 8, /obj/item/ammo_magazine/pistol/m10/ap/extended , null, VENDOR_ITEM_REGULAR),
		list("M39穿甲弹匣（10x20毫米）", 10, /obj/item/ammo_magazine/smg/m39/ap , null, VENDOR_ITEM_REGULAR),
		list("M39加长弹匣（10x20毫米）", 10, /obj/item/ammo_magazine/smg/m39/extended , null, VENDOR_ITEM_REGULAR),
		list("M41A穿甲弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/ap , null, VENDOR_ITEM_REGULAR),
		list("M41A加长弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/extended , null, VENDOR_ITEM_REGULAR),

		list("手枪弹药", 0, null, null, null),
		list("M10 HV 加长弹匣（10x20mm-APC）", 6, /obj/item/ammo_magazine/pistol/m10/extended , null, VENDOR_ITEM_REGULAR),
		list("M44重型快速装弹器（.44口径）", 10, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),
		list("M44神射手快速装弹器（.44口径）", 10, /obj/item/ammo_magazine/revolver/marksman, null, VENDOR_ITEM_REGULAR),
		list("M4A3 HP 弹匣", 5, /obj/item/ammo_magazine/pistol/hp, null, VENDOR_ITEM_REGULAR),
		list("M4A3 穿甲弹弹匣", 5, /obj/item/ammo_magazine/pistol/ap, null, VENDOR_ITEM_REGULAR),
		list("VP78 弹匣", 5, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6智能手枪弹匣（.45口径）", 10, /obj/item/ammo_magazine/pistol/smart, null, VENDOR_ITEM_REGULAR),

		list("限制性火器", 0, null, null, null),
		list("VP78 手枪", 10, /obj/item/storage/box/guncase/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6 智能手枪", 15, /obj/item/storage/box/guncase/smartpistol, null, VENDOR_ITEM_REGULAR),
		list("M85A1 榴弹发射器", 30, /obj/item/storage/box/guncase/m85a1, null, VENDOR_ITEM_REGULAR),

		list("护甲", 0, null, null, null),
		list("M3 B12型 海军陆战队员 护甲", 30, /obj/item/clothing/suit/storage/marine/medium/leader, null, VENDOR_ITEM_REGULAR),

		list("服装物品", 0, null, null, null),
		list("砍刀刀鞘（完整）", 5, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("砍刀袋（已满）", 15, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),
		list("焊接护目镜", 3, /obj/item/clothing/glasses/welding, null, VENDOR_ITEM_REGULAR),
		list("M276型 战斗 工具腰带 装备", 15, /obj/item/storage/belt/gun/utility, null, VENDOR_ITEM_REGULAR),
		list("自动注射器袋（满）", 15, /obj/item/storage/pouch/autoinjector/full, null, VENDOR_ITEM_REGULAR),
		list("绝缘手套", 3, /obj/item/clothing/gloves/yellow, null, VENDOR_ITEM_REGULAR),
		list("夜视光学镜", 30, /obj/item/device/helmet_visor/night_vision, null, VENDOR_ITEM_RECOMMENDED),

		list("工程学联合人民阵线", 0, null, null, null),
		list("塑胶炸药", 10, /obj/item/explosive/plastic, null, VENDOR_ITEM_REGULAR),
		list("信号弹包", 5, /obj/item/storage/box/m94/signal, null, VENDOR_ITEM_REGULAR),
		list("破门炸药", 10, /obj/item/explosive/plastic/breaching_charge, null, VENDOR_ITEM_REGULAR),
		list("ES-11 移动燃料罐", 5, /obj/item/tool/weldpack/minitank, null, VENDOR_ITEM_REGULAR),
		list("西格森 MCT", 5, /obj/item/tool/weldingtool/simple, null, VENDOR_ITEM_REGULAR),

		list("公用事业", 0, null, null, null),
		list("运动探测器", 15, /obj/item/device/motiondetector, null, VENDOR_ITEM_RECOMMENDED),
		list("滚筒床", 5, /obj/item/roller, null, VENDOR_ITEM_REGULAR),
		list("富尔顿装置堆叠", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("灭火器（便携式）", 5, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),

		list("望远镜", 0, null, null, null),
		list("双筒望远镜", 5, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("测距仪", 10, /obj/item/device/binoculars/range, null, VENDOR_ITEM_REGULAR),
		list("激光指示器", 15, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_REGULAR),

		list("头盔光学系统", 0, null, null, null),
		list("医疗头盔光学镜片", 15, /obj/item/device/helmet_visor/medical, null, VENDOR_ITEM_REGULAR),
		list("焊接面罩", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),

		list("无线电按键", 0, null, null, null),
		list("工程部无线电加密密钥", 5, /obj/item/device/encryptionkey/engi, null, VENDOR_ITEM_REGULAR),
		list("英特尔无线电加密密钥", 5, /obj/item/device/encryptionkey/intel, null, VENDOR_ITEM_REGULAR),
		list("JTAC无线电加密密钥", 5, /obj/item/device/encryptionkey/jtac, null, VENDOR_ITEM_REGULAR),
		list("补给无线电加密密钥", 5, /obj/item/device/encryptionkey/req, null, VENDOR_ITEM_REGULAR),
		list("医疗无线电加密密钥", 5, /obj/item/device/encryptionkey/med, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/gear/tl
	name = "殖民地军事科技火力组长装备架"
	desc = "火力组长专用自动化装备架。"
	icon_state = "intel_gear"
	show_points = TRUE
	req_access = list(ACCESS_MARINE_TL_PREP)
	vendor_role = list(JOB_SQUAD_TEAM_LEADER)

/obj/structure/machinery/cm_vending/gear/tl/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_tl

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_tl, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("标准海军陆战队员制服", 0, list(/obj/item/clothing/under/marine, /obj/item/clothing/shoes/marine/knife, /obj/item/device/radio/headset/almayer/marine, /obj/item/clothing/head/helmet/marine/rto), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("绝缘手套（黄色/棕褐色）", 0, /obj/item/clothing/gloves/marine/insulated, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("绝缘手套（黑色）", 0, /obj/item/clothing/gloves/marine/insulated/black, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("M4型装甲", 0, /obj/item/clothing/suit/storage/marine/medium/rto, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("单兵即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("地图", 0, /obj/item/map/current_map, MARINE_CAN_BUY_MAP, VENDOR_ITEM_MANDATORY),
		list("核心火力小队队长必备工具", 0, /obj/effect/essentials_set/tl, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("团队领袖专精（选择1项）", 0, null, null, null),
		list("USCM（殖民地海军陆战队）无线电通讯背包", 0, /obj/item/storage/backpack/marine/satchel/rto, MARINE_CAN_BUY_SPECIALIZATION, VENDOR_ITEM_MANDATORY),
		list("战壕哨", 0, /obj/item/clothing/accessory/device/whistle/trench, MARINE_CAN_BUY_SPECIALIZATION, VENDOR_ITEM_MANDATORY),

		list("腰带（选择1）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276弹药装载装置", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276通用手枪套携行系统", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M39 手枪套装备", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M10 枪套装备", 0, /obj/item/storage/belt/gun/m10, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276通用左轮手枪套装备", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M82F 枪套装备", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276霰弹枪装弹装置", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 工具腰带装备（全套）", 0, /obj/item/storage/belt/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 M40 榴弹携行具", 0, /obj/item/storage/belt/grenade, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋（任选2个）", 0, null, null, null),
		list("急救包（可补充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救员腰包", 0, /obj/item/storage/pouch/first_responder, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("闪光弹袋（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("燃料箱绑带袋", 0, /obj/item/storage/pouch/flamertank, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("弹匣袋", 0, /obj/item/storage/pouch/magazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("侧臂袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工具袋（满）", 0, /obj/item/storage/pouch/tools/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),

		list("配件（任选其一）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小包（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR)
	))

//MARINE_CAN_BUY_SHOES MARINE_CAN_BUY_UNIFORM currently not used
/obj/structure/machinery/cm_vending/clothing/tl
	name = "殖民地军事科技火力组长装备架"
	desc = "连接至大型存储库的自动化装备架，存放火力组长标准配发装备。"
	req_access = list(ACCESS_MARINE_TL_PREP)
	vendor_role = list(JOB_SQUAD_TEAM_LEADER)

/obj/structure/machinery/cm_vending/clothing/tl/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_tl

/obj/structure/machinery/cm_vending/clothing/tl/alpha
	squad_tag = SQUAD_MARINE_1
	req_access = list(ACCESS_MARINE_TL_PREP, ACCESS_MARINE_ALPHA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/alpha/tl

/obj/structure/machinery/cm_vending/clothing/tl/bravo
	squad_tag = SQUAD_MARINE_2
	req_access = list(ACCESS_MARINE_TL_PREP, ACCESS_MARINE_BRAVO)
	headset_type = /obj/item/device/radio/headset/almayer/marine/bravo/tl

/obj/structure/machinery/cm_vending/clothing/tl/charlie
	squad_tag = SQUAD_MARINE_3
	req_access = list(ACCESS_MARINE_TL_PREP, ACCESS_MARINE_CHARLIE)
	headset_type = /obj/item/device/radio/headset/almayer/marine/charlie/tl

/obj/structure/machinery/cm_vending/clothing/tl/delta
	squad_tag = SQUAD_MARINE_4
	req_access = list(ACCESS_MARINE_TL_PREP, ACCESS_MARINE_DELTA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/delta/tl

//------------ESSENTIAL SETS---------------
/obj/effect/essentials_set/tl
	spawned_gear_list = list(
		/obj/item/device/binoculars/range/designator,
		/obj/item/storage/box/m94/signal,
		/obj/item/storage/box/m94/signal,
	)
