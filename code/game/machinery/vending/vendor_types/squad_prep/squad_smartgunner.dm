//------------GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_gear_smartgun, list(
		list("智能枪套装（必选）", 0, null, null, null),
		list("必备智能枪手套装", 0, /obj/item/storage/box/m56a2_system/armorless, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),
		list("M56 标准战斗背带", 0, /obj/item/clothing/suit/storage/marine/smartgunner, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("M56 强化型战斗护甲", 0, /obj/item/clothing/suit/storage/marine/smartgunner/reinforced, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),

		list("限制性火器", 0, null, null, null),
		list("VP78 手枪", 15, /obj/item/storage/box/guncase/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6 智能手枪", 15, /obj/item/storage/box/guncase/smartpistol, null, VENDOR_ITEM_REGULAR),

		list("手枪配件（选择1项）", 0, null, null, null),
		list("激光瞄准镜", 0, /obj/item/attachable/lasersight, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("红点瞄准镜", 0, /obj/item/attachable/reddot, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("S5-微型红点瞄准镜", 0, /obj/item/attachable/reddot/small, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("反射式瞄准镜", 0, /obj/item/attachable/reflex, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),

		list("爆炸物", 0, null, null, null),
		list("M40 HEDP 高爆弹（内含3枚榴弹）", 30, /obj/item/storage/box/packet/high_explosive, null, VENDOR_ITEM_REGULAR),
		list("M40 HIDP 燃烧弹包（内含3枚手榴弹）", 30, /obj/item/storage/box/packet/incendiary, null, VENDOR_ITEM_REGULAR),
		list("M40 WPDP 白磷弹包（内含3枚手榴弹）", 30, /obj/item/storage/box/packet/phosphorus, null, VENDOR_ITEM_REGULAR),
		list("M40 HSDP 烟雾弹包（内含3枚手榴弹）", 15, /obj/item/storage/box/packet/smoke, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-破片空爆弹包（内含3枚空爆榴弹）", 20, /obj/item/storage/box/packet/airburst_he, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-燃烧空爆弹包（内含3枚空爆手榴弹）", 20, /obj/item/storage/box/packet/airburst_incen, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-烟雾空爆弹包（内含3枚空爆榴弹）", 10, /obj/item/storage/box/packet/airburst_smoke, null, VENDOR_ITEM_REGULAR),
		list("M74 AGM-大黄蜂空爆弹包（内含3枚空爆榴弹）", 20, /obj/item/storage/box/packet/hornet, null, VENDOR_ITEM_REGULAR),
		list("M20 地雷箱（内含5枚地雷）", 20, /obj/item/storage/box/explosive_mines, null, VENDOR_ITEM_REGULAR),

		list("手枪弹药", 0, null, null, null),
		list("M10 HV 加长弹匣（10x20mm-APC）", 6, /obj/item/ammo_magazine/pistol/m10/extended , null, VENDOR_ITEM_REGULAR),
		list("M44重型快速装弹器（.44口径）", 10, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),
		list("M44神射手快速装弹器（.44口径）", 10, /obj/item/ammo_magazine/revolver/marksman, null, VENDOR_ITEM_REGULAR),
		list("M4A3 HP 弹匣", 5, /obj/item/ammo_magazine/pistol/hp, null, VENDOR_ITEM_REGULAR),
		list("M4A3 穿甲弹弹匣", 5, /obj/item/ammo_magazine/pistol/ap, null, VENDOR_ITEM_REGULAR),
		list("VP78 弹匣", 5, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6智能手枪弹匣（.45口径）", 10, /obj/item/ammo_magazine/pistol/smart, null, VENDOR_ITEM_REGULAR),

		list("服装物品", 0, null, null, null),
		list("智能枪手砍刀鞘", 15, /obj/item/storage/large_holster/machete/smartgunner/full, null, VENDOR_ITEM_REGULAR),
		list("油箱绑带袋", 5, /obj/item/storage/pouch/flamertank, null, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 6, /obj/item/storage/pouch/general/large, null, VENDOR_ITEM_REGULAR),

		list("公用事业", 0, null, null, null),
		list("灭火器（便携式）", 5, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("哨声", 5, /obj/item/clothing/accessory/device/whistle, null, VENDOR_ITEM_REGULAR),
		list("滚筒床", 5, /obj/item/roller, null, VENDOR_ITEM_REGULAR),
		list("富尔顿装置堆叠", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("DV9智能枪电池", 15, /obj/item/smartgun_battery, null, VENDOR_ITEM_REGULAR),

		list("望远镜", 0, null, null, null),
		list("双筒望远镜", 5, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("测距仪", 10, /obj/item/device/binoculars/range, null, VENDOR_ITEM_REGULAR),
		list("激光指示器", 15, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_REGULAR),

		list("头盔光学系统", 0, null, null, null),
		list("医疗头盔光学镜片", 15, /obj/item/device/helmet_visor/medical, null, VENDOR_ITEM_REGULAR),
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

/obj/structure/machinery/cm_vending/gear/smartgun
	name = "\improper 殖民地海军陆战队科技（ColMarTech） 小队智能枪手装备架"
	desc = "班组智能枪手专用自动化装备架。"
	icon_state = "sg_gear"
	show_points = TRUE
	vendor_role = list(JOB_SQUAD_SMARTGUN)
	req_access = list(ACCESS_MARINE_SMARTPREP)

/obj/structure/machinery/cm_vending/gear/smartgun/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_smartgun

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_smartgun, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("标准海军陆战队员制服", 0, list(/obj/item/clothing/under/marine, /obj/item/clothing/shoes/marine/knife, /obj/item/clothing/gloves/marine, /obj/item/device/radio/headset/almayer/marine, /obj/item/clothing/head/helmet/marine), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("军用即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("地图", 0, /obj/item/map/current_map, MARINE_CAN_BUY_MAP, VENDOR_ITEM_MANDATORY),

		list("腰带", 0, null, null, null),
		list("M802智能枪手侧臂腰带", 0, /obj/item/storage/belt/gun/smartgunner/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_MANDATORY),
		list("M280智能枪手转轮弹链", 0, /obj/item/storage/belt/marine/smartgunner, MARINE_CAN_BUY_BELT, VENDOR_ITEM_MANDATORY),

		list("小袋（任选2件）", 0, null, null, null),
		list("闪光弹包（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("电子钱包", 0, /obj/item/storage/pouch/electronics, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（药丸包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("弹匣袋", 0, /obj/item/storage/pouch/magazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("中型通用袋", 0, /obj/item/storage/pouch/general/medium, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("手枪袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("砍刀袋（已满）", 0, /obj/item/storage/pouch/machete/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("配件（任选其一）", 0, null, null, null),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小包（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
))

/obj/structure/machinery/cm_vending/clothing/smartgun
	name = "\improper 殖民地海军陆战队科技（ColMarTech） 小队智能枪装备架"
	desc = "连接至大型存储库的自动化装备架，存放班组智能枪手标准配发装备。"
	req_access = list(ACCESS_MARINE_SMARTPREP)
	vendor_role = list(JOB_SQUAD_SMARTGUN)

/obj/structure/machinery/cm_vending/clothing/smartgun/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_smartgun

/obj/structure/machinery/cm_vending/clothing/smartgun/alpha
	squad_tag = SQUAD_MARINE_1
	req_access = list(ACCESS_MARINE_SMARTPREP, ACCESS_MARINE_ALPHA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/alpha

/obj/structure/machinery/cm_vending/clothing/smartgun/bravo
	squad_tag = SQUAD_MARINE_2
	req_access = list(ACCESS_MARINE_SMARTPREP, ACCESS_MARINE_BRAVO)
	headset_type = /obj/item/device/radio/headset/almayer/marine/bravo

/obj/structure/machinery/cm_vending/clothing/smartgun/charlie
	squad_tag = SQUAD_MARINE_3
	req_access = list(ACCESS_MARINE_SMARTPREP, ACCESS_MARINE_CHARLIE)
	headset_type = /obj/item/device/radio/headset/almayer/marine/charlie

/obj/structure/machinery/cm_vending/clothing/smartgun/delta
	squad_tag = SQUAD_MARINE_4
	req_access = list(ACCESS_MARINE_SMARTPREP, ACCESS_MARINE_DELTA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/delta

//------------ESSENTIAL SETS---------------
