//------------GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_gear_leader, list(
		list("小队队长装备（选择1）", 0, null, null, null),
		list("必备SL套件", 0, /obj/effect/essentials_set/leader, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("小队装备（选择1项，供您或您的小队使用）", 0, null, null, null),
		list("M4RA 狙击手装备", 0, /obj/item/storage/box/kit/mini_sniper, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("M41A标准套件", 0, /obj/item/storage/box/kit/m41a_kit	, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("M240 烟火技师支援套件", 0, /obj/item/storage/box/kit/mini_pyro, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("M2C重型机枪", 0, /obj/item/storage/box/guncase/m2c, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("M56D重型机枪", 0, /obj/item/storage/box/guncase/m56d, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("M85A1 榴弹发射器", 0, /obj/item/storage/box/guncase/m85a1, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("MOU-53 霰弹枪", 0, /obj/item/storage/box/guncase/mou53, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("XM88重型步枪", 0, /obj/item/storage/box/guncase/xm88, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("基础工程物资", 0, /obj/item/storage/box/kit/engineering_supply_kit, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),

		list("护甲", 0, null, null, null),
		list("M4型制式护甲", 16, /obj/item/clothing/suit/storage/marine/medium/rto, null, VENDOR_ITEM_REGULAR),

		list("服装物品", 0, null, null, null),
		list("砍刀刀鞘（完整）", 4, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("砍刀袋（已满）", 4, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）无线电通讯背包", 5, /obj/item/storage/backpack/marine/satchel/rto, null, VENDOR_ITEM_REGULAR),
		list("M276型 战斗 工具带 装备", 15, /obj/item/storage/belt/gun/utility, null, VENDOR_ITEM_REGULAR),

		list("公共设施", 0, null, null, null),
		list("灭火器（便携式）", 3, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("运动探测器", 5, /obj/item/device/motiondetector, null, VENDOR_ITEM_REGULAR),
		list("富尔顿装置堆叠", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),

		list("望远镜", 0, null, null, null),
		list("测距仪", 3, /obj/item/device/binoculars/range, null, VENDOR_ITEM_REGULAR),
		list("激光指示器", 5, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_REGULAR),

		list("头盔光学系统", 0, null, null, null),
		list("焊接面罩", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),
		list("医疗头盔光学镜", 4, /obj/item/device/helmet_visor/medical, null, VENDOR_ITEM_RECOMMENDED),
		list("夜视光学镜", 25, /obj/item/device/helmet_visor/night_vision, null, VENDOR_ITEM_RECOMMENDED),

		list("工程学S联合人民阵线LIES", 0, null, null, null),
		list("绝缘手套（黄色/棕褐色）", 3, /obj/item/clothing/gloves/yellow, null, VENDOR_ITEM_REGULAR),
		list("绝缘手套（黑色）", 3, /obj/item/clothing/gloves/marine/insulated/black, null, VENDOR_ITEM_REGULAR),
		list("金属 x10", 5, /obj/item/stack/sheet/metal/small_stack, null, VENDOR_ITEM_RECOMMENDED),
		list("塑钢 x10", 7, /obj/item/stack/sheet/plasteel/small_stack, null, VENDOR_ITEM_RECOMMENDED),
		list("塑性炸药", 5, /obj/item/explosive/plastic, null, VENDOR_ITEM_RECOMMENDED),
		list("爆破炸药", 7, /obj/item/explosive/plastic/breaching_charge, null, VENDOR_ITEM_RECOMMENDED),
		list("沙袋 x25", 10, /obj/item/stack/sandbags_empty/half, null, VENDOR_ITEM_RECOMMENDED),
		list("信号弹包", 7, /obj/item/storage/box/m94/signal, null, VENDOR_ITEM_REGULAR),
		list("工具袋（满）", 5, /obj/item/storage/pouch/tools/full, null, VENDOR_ITEM_REGULAR),
		list("焊接护目镜", 5, /obj/item/clothing/glasses/welding, null, VENDOR_ITEM_REGULAR),

		list("爆炸物", 0, null, null, null),
		list("M40 HEDP 高爆弹包（内含3枚手榴弹）", 18, /obj/item/storage/box/packet/high_explosive, null, VENDOR_ITEM_REGULAR),
		list("M40 HIDP燃烧弹包（内含3枚手榴弹）", 18, /obj/item/storage/box/packet/incendiary, null, VENDOR_ITEM_REGULAR),
		list("M40 WPDP 白磷弹包（内含3枚手榴弹）", 18, /obj/item/storage/box/packet/phosphorus, null, VENDOR_ITEM_REGULAR),
		list("M40 HSDP 烟雾弹包（内含3枚手榴弹）", 9, /obj/item/storage/box/packet/smoke, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-破片空爆弹包（内含3枚空爆榴弹）", 13, /obj/item/storage/box/packet/airburst_he, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-燃烧空爆弹包（内含3枚空爆手榴弹）", 13, /obj/item/storage/box/packet/airburst_incen, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-烟雾空爆弹包（内含3枚空爆榴弹）", 9, /obj/item/storage/box/packet/airburst_smoke, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-大黄蜂空爆弹包（内含3枚空爆榴弹）", 13, /obj/item/storage/box/packet/hornet, null, VENDOR_ITEM_REGULAR),
		list("M20 地雷箱（内含5枚地雷）", 20, /obj/item/storage/box/explosive_mines, null, VENDOR_ITEM_REGULAR),
		list("M40 MFHS 金属泡沫手榴弹", 5, /obj/item/explosive/grenade/metal_foam, null, VENDOR_ITEM_REGULAR),
		list("G2 电击手雷包（内含3枚手雷）",  16, /obj/item/storage/box/packet/sebb, null, VENDOR_ITEM_REGULAR),

		list("MEDICAL S联合人民阵线谎言", 0, null, null, null),
		list("烧伤急救包", 2, /obj/item/stack/medical/advanced/ointment, null, VENDOR_ITEM_REGULAR),
		list("创伤急救包", 2, /obj/item/stack/medical/advanced/bruise_pack, null, VENDOR_ITEM_REGULAR),
		list("高级急救箱", 12, /obj/item/storage/firstaid/adv, null, VENDOR_ITEM_REGULAR),
		list("医疗夹板", 1, /obj/item/stack/medical/splint, null, VENDOR_ITEM_REGULAR),

		list("自动注射器（比卡瑞丁）", 1, /obj/item/reagent_container/hypospray/autoinjector/bicaridine, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（地塞林+）", 1, /obj/item/reagent_container/hypospray/autoinjector/dexalinp, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（迪洛芬）", 1, /obj/item/reagent_container/hypospray/autoinjector/antitoxin, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（伊纳普洛林）", 1, /obj/item/reagent_container/hypospray/autoinjector/inaprovaline, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（凯洛坦）", 1, /obj/item/reagent_container/hypospray/autoinjector/kelotane, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（羟考酮）", 1, /obj/item/reagent_container/hypospray/autoinjector/oxycodone, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（佩里达松）", 1, /obj/item/reagent_container/hypospray/autoinjector/peridaxon, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（曲马多）", 1, /obj/item/reagent_container/hypospray/autoinjector/tramadol, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（三氯拉嗪）", 1, /obj/item/reagent_container/hypospray/autoinjector/tricord, null, VENDOR_ITEM_REGULAR),

		list("健康分析仪", 4, /obj/item/device/healthanalyzer, null, VENDOR_ITEM_REGULAR),
		list("滚筒床", 2, /obj/item/roller, null, VENDOR_ITEM_REGULAR),

		list("主要弹药", 0, null, null, null),
		list("M4RA AP 弹匣（10x24毫米）", 6, /obj/item/ammo_magazine/rifle/m4ra/ap, null, VENDOR_ITEM_REGULAR),
		list("M4RA 加长弹匣（10x24毫米）", 6, /obj/item/ammo_magazine/rifle/m4ra/extended, null, VENDOR_ITEM_REGULAR),
		list("M10 AP 弹匣（10x20mm-APC）", 6, /obj/item/ammo_magazine/pistol/m10/ap , null, VENDOR_ITEM_REGULAR),
		list("M10 AP 加长弹匣（10x20mm-APC）", 8, /obj/item/ammo_magazine/pistol/m10/ap/extended , null, VENDOR_ITEM_REGULAR),
		list("M39穿甲弹匣（10x20毫米）", 6, /obj/item/ammo_magazine/smg/m39/ap , null, VENDOR_ITEM_REGULAR),
		list("M39加长弹匣（10x20毫米）", 6, /obj/item/ammo_magazine/smg/m39/extended , null, VENDOR_ITEM_REGULAR),
		list("M41A穿甲弹匣（10x24毫米）", 6, /obj/item/ammo_magazine/rifle/ap , null, VENDOR_ITEM_REGULAR),
		list("M41A 扩容弹匣（10x24毫米）", 6, /obj/item/ammo_magazine/rifle/extended , null, VENDOR_ITEM_REGULAR),

		list("手枪弹药", 0, null, null, null),
		list("M10 HV 加长弹匣（10x20mm-APC）", 6, /obj/item/ammo_magazine/pistol/m10/extended , null, VENDOR_ITEM_REGULAR),
		list("M44重型快速装弹器（.44口径）", 6, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),
		list("M44神射手快速装弹器（.44口径）", 6, /obj/item/ammo_magazine/revolver/marksman, null, VENDOR_ITEM_REGULAR),
		list("M4A3 HP 弹匣", 3, /obj/item/ammo_magazine/pistol/hp, null, VENDOR_ITEM_REGULAR),
		list("M4A3 穿甲弹弹匣", 3, /obj/item/ammo_magazine/pistol/ap, null, VENDOR_ITEM_REGULAR),
		list("VP78 弹匣", 3, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6智能手枪弹匣（.45口径）", 6, /obj/item/ammo_magazine/pistol/smart, null, VENDOR_ITEM_REGULAR),

		list("特殊弹药", 0, null, null, null),
		list("M240 焚化坦克（萘酚）", 3, /obj/item/ammo_magazine/flamer_tank, null, VENDOR_ITEM_REGULAR),
		list("M240 焚化坦克（B型凝胶）", 3, /obj/item/ammo_magazine/flamer_tank/gellied, null, VENDOR_ITEM_REGULAR),

		list("限制性火器", 0, null, null, null),
		list("M240 焚化装置", 18, /obj/item/storage/box/guncase/flamer, null, VENDOR_ITEM_REGULAR),
		list("VP78 手枪", 8, /obj/item/storage/box/guncase/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6 智能手枪", 12, /obj/item/storage/box/guncase/smartpistol, null, VENDOR_ITEM_REGULAR),
		list("M85A1 榴弹发射器", 18, /obj/item/storage/box/guncase/m85a1, null, VENDOR_ITEM_REGULAR),

		list("无线电按键", 0, null, null, null),
		list("工程部无线电加密密钥", 3, /obj/item/device/encryptionkey/engi, null, VENDOR_ITEM_REGULAR),
		list("英特尔无线电加密密钥", 3, /obj/item/device/encryptionkey/intel, null, VENDOR_ITEM_REGULAR),
		list("JTAC无线电加密密钥", 3, /obj/item/device/encryptionkey/jtac, null, VENDOR_ITEM_REGULAR),
		list("补给无线电加密密钥", 3, /obj/item/device/encryptionkey/req, null, VENDOR_ITEM_REGULAR),
		list("医疗无线电加密密钥", 3, /obj/item/device/encryptionkey/med, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/gear/leader
	name = "\improper 殖民地海军陆战队科技 小队队长装备架"
	desc = "一个为班长准备的自动化装备架。"
	icon_state = "sl_gear"
	show_points = TRUE
	vendor_role = list(JOB_SQUAD_LEADER)
	req_access = list(ACCESS_MARINE_LEADER)

/obj/structure/machinery/cm_vending/gear/leader/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_leader

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_leader, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("标准海军陆战队员制服", 0, list(/obj/item/clothing/under/marine, /obj/item/clothing/shoes/marine/knife, /obj/item/clothing/gloves/marine, /obj/item/device/radio/headset/almayer/marine, /obj/item/clothing/head/helmet/marine/leader), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("B12型护甲", 0, /obj/item/clothing/suit/storage/marine/medium/leader, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("军用即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("地图", 0, /obj/item/map/current_map, MARINE_CAN_BUY_MAP, VENDOR_ITEM_MANDATORY),

		list("背包（选择1个）", 0, null, null, null),
		list("背包", 0, /obj/item/storage/backpack/marine, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("砍刀刀鞘（完整）", 0, /obj/item/storage/large_holster/machete/full, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("挎包", 0, /obj/item/storage/backpack/marine/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),

		list("腰带（选择1）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276弹药装载装置", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276通用手枪套装备", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 救生包", 0, /obj/item/storage/belt/medical/lifesaver, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 医疗存储平台", 0, /obj/item/storage/belt/medical, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M39 枪套装备", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M10 枪套装备", 0, /obj/item/storage/belt/gun/m10, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276通用左轮手枪套装备", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M82F 枪套装备", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276霰弹枪装弹装置", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 工具腰带装备（全套）", 0, /obj/item/storage/belt/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M40 榴弹携行具", 0, /obj/item/storage/belt/grenade, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋 (选择2个)", 0, null, null, null),
		list("自动注射器袋（满）", 0, /obj/item/storage/pouch/autoinjector/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("闪光弹袋（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("燃料箱绑带袋", 0, /obj/item/storage/pouch/flamertank, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型弹匣袋", 0, /obj/item/storage/pouch/magazine/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("手枪袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("配件（任选其一）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部挂包（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/leader
	name = "\improper 殖民地海军陆战队科技 小队队长装备架"
	desc = "一个连接着海量班长标准制式装备库的自动化装备架。"
	req_access = list(ACCESS_MARINE_LEADER)
	vendor_role = list(JOB_SQUAD_LEADER)

/obj/structure/machinery/cm_vending/clothing/leader/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_leader

/obj/structure/machinery/cm_vending/clothing/leader/alpha
	squad_tag = SQUAD_MARINE_1
	req_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_ALPHA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/alpha/lead

/obj/structure/machinery/cm_vending/clothing/leader/bravo
	squad_tag = SQUAD_MARINE_2
	req_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_BRAVO)
	headset_type = /obj/item/device/radio/headset/almayer/marine/bravo/lead

/obj/structure/machinery/cm_vending/clothing/leader/charlie
	squad_tag = SQUAD_MARINE_3
	req_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_CHARLIE)
	headset_type = /obj/item/device/radio/headset/almayer/marine/charlie/lead

/obj/structure/machinery/cm_vending/clothing/leader/delta
	squad_tag = SQUAD_MARINE_4
	req_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_DELTA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/delta/lead

//------------ESSENTIAL SETS---------------

/obj/effect/essentials_set/leader
	spawned_gear_list = list(
		/obj/item/explosive/plastic,
		/obj/item/device/binoculars/range/designator,
		/obj/item/storage/box/m94/signal,
		/obj/item/tool/extinguisher/mini,
		/obj/item/storage/box/zipcuffs,
		/obj/item/clothing/accessory/device/whistle/trench,
	)
