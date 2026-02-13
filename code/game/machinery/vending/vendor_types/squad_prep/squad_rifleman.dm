//------------SQUAD RIFLEMAN UNIFORM AND GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_marine, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("标准海军陆战队员制服", 0, list(/obj/item/clothing/under/marine, /obj/item/clothing/shoes/marine/knife, /obj/item/clothing/gloves/marine, /obj/item/device/radio/headset/almayer/marine, /obj/item/clothing/head/helmet/marine), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("军用即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("地图", 0, /obj/item/map/current_map, MARINE_CAN_BUY_MAP, VENDOR_ITEM_MANDATORY),

		list("护甲（选择1件）", 0, null, null, null),
		list("轻甲", 0, /obj/item/clothing/suit/storage/marine/light, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("中型护甲", 0, /obj/item/clothing/suit/storage/marine/medium, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("重甲", 0, /obj/item/clothing/suit/storage/marine/heavy, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),

		list("背包（选择1项）", 0, null, null, null),
		list("背包", 0, /obj/item/storage/backpack/marine, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("挎包", 0, /obj/item/storage/backpack/marine/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("霰弹枪枪套", 0, /obj/item/storage/large_holster/m37, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),

		list("腰带（选择1）", 0, null, null, null),
		list("M276弹药装载装置", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276通用手枪套携行系统", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 刀套（完整版）", 0, /obj/item/storage/belt/knifepouch, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M10 枪套装备", 0, /obj/item/storage/belt/gun/m10, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M39 枪套装备", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276通用左轮手枪套装备", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M82F 枪套装备", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276霰弹枪装弹装置", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M40 榴弹携行具（空置）", 0, /obj/item/storage/belt/grenade, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋 (选择 2)", 0, null, null, null),
		list("刺刀鞘（满）", 0, /obj/item/storage/pouch/bayonet, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（药丸包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("闪光弹包（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("小型文件袋", 0, /obj/item/storage/pouch/document/small, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("弹匣袋", 0, /obj/item/storage/pouch/magazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("中型通用袋", 0, /obj/item/storage/pouch/general/medium, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("手枪袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("循环呼吸器", 0, /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("工程学联合人民阵线", 0, null, null, null),
		list("E-工具", 5, /obj/item/tool/shovel/etool/folded, null, VENDOR_ITEM_REGULAR),
		list("沙袋", 20, /obj/item/stack/sandbags_empty/half, null, VENDOR_ITEM_REGULAR),
		list("ES-11 移动燃料罐", 5, /obj/item/tool/weldpack/minitank, null, VENDOR_ITEM_REGULAR),
		list("西格森 MCT", 5, /obj/item/tool/weldingtool/simple, null, VENDOR_ITEM_REGULAR),

		list("限制性火器", 0, null, null, null),
		list("VP78 手枪", 15, /obj/item/storage/box/guncase/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6 智能手枪", 15, /obj/item/storage/box/guncase/smartpistol, null, VENDOR_ITEM_REGULAR),
		list("M85A1 榴弹发射器", 30, /obj/item/storage/box/guncase/m85a1, null, VENDOR_ITEM_REGULAR),

		list("爆炸物", 0, null, null, null),
		list("M40 HEDP 高爆弹（内含3枚榴弹）", 20, /obj/item/storage/box/packet/high_explosive, null, VENDOR_ITEM_REGULAR),
		list("M40 HIDP 燃烧弹包（内含3枚手榴弹）", 20, /obj/item/storage/box/packet/incendiary, null, VENDOR_ITEM_REGULAR),
		list("M40 WPDP 白磷弹包（内含3枚手榴弹）", 20, /obj/item/storage/box/packet/phosphorus, null, VENDOR_ITEM_REGULAR),
		list("M40 HSDP 烟雾弹包（内含3枚手榴弹）", 10, /obj/item/storage/box/packet/smoke, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-Frag 空爆弹包（含3枚空爆榴弹）", 15, /obj/item/storage/box/packet/airburst_he, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-燃烧空爆弹包（内含3枚空爆手榴弹）", 15, /obj/item/storage/box/packet/airburst_incen, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-烟雾空爆弹包（内含3枚空爆榴弹）", 10, /obj/item/storage/box/packet/airburst_smoke, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-大黄蜂空爆弹包（内含3枚空爆榴弹）", 15, /obj/item/storage/box/packet/hornet, null, VENDOR_ITEM_REGULAR),
		list("M20 地雷箱（内含5枚地雷）", 20, /obj/item/storage/box/explosive_mines, null, VENDOR_ITEM_REGULAR),

		list("主要弹药", 0, null, null, null),
		list("M4RA AP 弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/m4ra/ap, null, VENDOR_ITEM_REGULAR),
		list("M4RA 加长弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/m4ra/extended, null, VENDOR_ITEM_REGULAR),
		list("M10 AP 弹匣（10x20mm-APC）", 6, /obj/item/ammo_magazine/pistol/m10/ap , null, VENDOR_ITEM_REGULAR),
		list("M10 AP 扩展弹匣 (10x20mm-APC)", 8, /obj/item/ammo_magazine/pistol/m10/ap/extended , null, VENDOR_ITEM_REGULAR),
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

		list("护甲", 0, null, null, null),
		list("M3 B12型 海军陆战队员 护甲", 30, /obj/item/clothing/suit/storage/marine/medium/leader, null, VENDOR_ITEM_REGULAR),
		list("M4型制式护甲", 20, /obj/item/clothing/suit/storage/marine/medium/rto, null, VENDOR_ITEM_REGULAR),

		list("服装物品", 0, null, null, null),
		list("蛛网", 10, /obj/item/clothing/accessory/storage/webbing, null, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 10, /obj/item/clothing/accessory/storage/webbing/black, null, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 15, /obj/item/clothing/accessory/storage/black_vest/brown_vest, null, VENDOR_ITEM_REGULAR),
		list("腿部挂包", 15, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, null, VENDOR_ITEM_REGULAR),
		list("腿部小包（黑色）", 15, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, null, VENDOR_ITEM_REGULAR),
		list("黑色网眼背心", 15, /obj/item/clothing/accessory/storage/black_vest, null, VENDOR_ITEM_REGULAR),
		list("投掷袋", 10, /obj/item/clothing/accessory/storage/droppouch, null, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 10, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 15, /obj/item/clothing/accessory/storage/holster, null, VENDOR_ITEM_REGULAR),
		list("砍刀刀鞘（完整）", 15, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("砍刀袋（满）", 15, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）无线电通讯背包", 15, /obj/item/storage/backpack/marine/satchel/rto, null, VENDOR_ITEM_REGULAR),
		list("油箱绑带包", 5, /obj/item/storage/pouch/flamertank, null, VENDOR_ITEM_REGULAR),
		list("焊接护目镜", 5, /obj/item/clothing/glasses/welding, null, VENDOR_ITEM_REGULAR),
		list("投石袋", 15, /obj/item/storage/pouch/sling, null, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 15, /obj/item/storage/pouch/general/large, null, VENDOR_ITEM_REGULAR),

		list("公用事业", 0, null, null, null),
		list("滚筒床", 5, /obj/item/roller, null, VENDOR_ITEM_REGULAR),
		list("富尔顿装置堆叠", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("灭火器（便携式）", 5, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("运动探测器", 15, /obj/item/device/motiondetector, null, VENDOR_ITEM_REGULAR),
		list("数据探测器", 15, /obj/item/device/motiondetector/intel, null, VENDOR_ITEM_REGULAR),
		list("哨声", 5, /obj/item/clothing/accessory/device/whistle, null, VENDOR_ITEM_REGULAR),

		list("望远镜", 0, null, null, null),
		list("双筒望远镜", 5, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("测距仪", 10, /obj/item/device/binoculars/range, null, VENDOR_ITEM_REGULAR),
		list("激光指示器", 15, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_REGULAR),

		list("头盔光学系统", 0, null, null, null),
		list("医疗头盔光学镜", 15, /obj/item/device/helmet_visor/medical, null, VENDOR_ITEM_REGULAR),
		list("焊接面罩", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),

		list("宣传册", 0, null, null, null),
		list("JTAC 手册", 15, /obj/item/pamphlet/skill/jtac, null, VENDOR_ITEM_REGULAR),
		list("工程手册", 15, /obj/item/pamphlet/skill/engineer, null, VENDOR_ITEM_REGULAR),

		list("无线电按键", 0, null, null, null),
		list("工程部无线电加密密钥", 5, /obj/item/device/encryptionkey/engi, null, VENDOR_ITEM_REGULAR),
		list("英特尔无线电加密密钥", 5, /obj/item/device/encryptionkey/intel, null, VENDOR_ITEM_REGULAR),
		list("JTAC无线电加密密钥", 5, /obj/item/device/encryptionkey/jtac, null, VENDOR_ITEM_REGULAR),
		list("补给无线电加密密钥", 5, /obj/item/device/encryptionkey/req, null, VENDOR_ITEM_REGULAR),
		list("医疗无线电加密密钥", 5, /obj/item/device/encryptionkey/med, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/marine
	name = "\improper 科马尔科技（殖民地海军陆战队科技）自动化海军陆战队员装备架"
	desc = "连接至大型存储库的自动化装备架，存放陆战队步枪兵标准配发装备。"
	icon_state = "mar_rack"
	show_points = TRUE
	vendor_theme = VENDOR_THEME_USCM

	vendor_role = list(JOB_SQUAD_MARINE)

/obj/structure/machinery/cm_vending/clothing/marine/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_marine

/obj/structure/machinery/cm_vending/clothing/marine/alpha
	squad_tag = SQUAD_MARINE_1
	req_access = list(ACCESS_MARINE_ALPHA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/alpha

/obj/structure/machinery/cm_vending/clothing/marine/bravo
	squad_tag = SQUAD_MARINE_2
	req_access = list(ACCESS_MARINE_BRAVO)
	headset_type = /obj/item/device/radio/headset/almayer/marine/bravo

/obj/structure/machinery/cm_vending/clothing/marine/charlie
	squad_tag = SQUAD_MARINE_3
	req_access = list(ACCESS_MARINE_CHARLIE)
	headset_type = /obj/item/device/radio/headset/almayer/marine/charlie

/obj/structure/machinery/cm_vending/clothing/marine/delta
	squad_tag = SQUAD_MARINE_4
	req_access = list(ACCESS_MARINE_DELTA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/delta
