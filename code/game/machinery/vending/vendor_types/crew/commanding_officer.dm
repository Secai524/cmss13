//------------GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_gear_commanding_officer, list(
		list("指挥官的主要技能（选择1项）", 0, null, null, null),
		list("M46C脉冲步枪", 0, /obj/effect/essentials_set/co/riflepreset, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_MANDATORY),
		list("M56A2C智能枪", 0, /obj/item/storage/box/m56a2c_system, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_MANDATORY),

		list("主要弹药", 0, null, null, null),
		list("M41A MK1 弹匣", 30, /obj/item/ammo_magazine/rifle/m41aMK1, null, VENDOR_ITEM_RECOMMENDED),
		list("M41A MK1 穿甲弹匣", 40, /obj/item/ammo_magazine/rifle/m41aMK1/ap, null, VENDOR_ITEM_RECOMMENDED),
		list("M41A 扩容弹匣", 20, /obj/item/ammo_magazine/rifle/extended, null, VENDOR_ITEM_REGULAR),
		list("M41A穿甲弹匣", 20, /obj/item/ammo_magazine/rifle/ap, null, VENDOR_ITEM_REGULAR),
		list("M56智能枪弹鼓", 20, /obj/item/ammo_magazine/smartgun, null, VENDOR_ITEM_REGULAR),

		list("手枪弹药", 0, null, null, null),
		list("高冲击力尤尼卡快速装弹器（.454口径）", 15, /obj/item/ammo_magazine/revolver/mateba/highimpact, null, VENDOR_ITEM_RECOMMENDED),
		list("高冲击力AP尤尼卡快速装弹器（.454口径）", 20, /obj/item/ammo_magazine/revolver/mateba/highimpact/ap, null, VENDOR_ITEM_REGULAR),
		list("高威力沙漠之鹰弹匣（.50口径）", 15, /obj/item/ammo_magazine/pistol/heavy/super/highimpact, null, VENDOR_ITEM_RECOMMENDED),
		list("高威力AP沙漠之鹰弹匣（.50口径）", 20, /obj/item/ammo_magazine/pistol/heavy/super/highimpact/ap, null, VENDOR_ITEM_REGULAR),
		list("高威力M1911C弹匣（.45口径）", 15, /obj/item/ammo_magazine/pistol/m1911/highimpact, null, VENDOR_ITEM_RECOMMENDED),
		list("高威力AP M1911C弹匣（.45口径）", 20, /obj/item/ammo_magazine/pistol/m1911/highimpact/ap, null, VENDOR_ITEM_REGULAR),

		list("霰弹枪弹药", 0, null, null, null),
		list("鹿弹", 20, /obj/item/ammo_magazine/shotgun/buckshot, null, VENDOR_ITEM_REGULAR),
		list("猎枪独头弹", 20, /obj/item/ammo_magazine/shotgun/slugs, null, VENDOR_ITEM_REGULAR),
		list("钢针霰弹", 20, /obj/item/ammo_magazine/shotgun/flechette, null, VENDOR_ITEM_REGULAR),

		list("特殊弹药", 0, null, null, null),
		list("M41A橡胶弹弹匣", 10, /obj/item/ammo_magazine/rifle/rubber, null, VENDOR_ITEM_REGULAR),
		list("豆袋弹", 10, /obj/item/ammo_magazine/shotgun/beanbag, null, VENDOR_ITEM_REGULAR),

		list("爆炸物", 0, null, null, null),
		list("HEDP榴弹包", 15, /obj/item/storage/box/packet/high_explosive, null, VENDOR_ITEM_REGULAR),
		list("HEFA手榴弹包", 15, /obj/item/storage/box/packet/hefa, null, VENDOR_ITEM_REGULAR),
		list("WP 手榴弹包", 15, /obj/item/storage/box/packet/phosphorus, null, VENDOR_ITEM_REGULAR),
		list("G2 电击手雷包（内含3枚手雷）",  15, /obj/item/storage/box/packet/sebb, null, VENDOR_ITEM_REGULAR),

		list("头盔护目镜", 0, null, null, null),
		list("夜视护目镜", 10, /obj/item/device/helmet_visor/night_vision, null, VENDOR_ITEM_RECOMMENDED),
		list("医疗护目镜", 5, /obj/item/device/helmet_visor/medical/advanced, null, VENDOR_ITEM_REGULAR),
		list("焊接面罩", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),

		list("轨道附件", 0, null, null, null),
		list("红点瞄准镜", 15, /obj/item/attachable/reddot, null, VENDOR_ITEM_REGULAR),
		list("S5-微型红点瞄准镜", 15, /obj/item/attachable/reddot/small, null, VENDOR_ITEM_REGULAR),
		list("反射式瞄准镜", 15, /obj/item/attachable/reflex, null, VENDOR_ITEM_REGULAR),
		list("S4 2倍伸缩迷你瞄准镜", 15, /obj/item/attachable/scope/mini, null, VENDOR_ITEM_REGULAR),

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
		list("延长型后坐力补偿器", 15, /obj/item/attachable/extended_barrel/vented, null, VENDOR_ITEM_REGULAR),
		list("后坐力补偿器", 15, /obj/item/attachable/compensator, null, VENDOR_ITEM_REGULAR),
		list("抑制器", 15, /obj/item/attachable/suppressor, null, VENDOR_ITEM_REGULAR),
		list("抑制器，紧凑型", 15, /obj/item/attachable/suppressor/sleek, null, VENDOR_ITEM_REGULAR),
))

/obj/structure/machinery/cm_vending/gear/commanding_officer
	name = "\improper ColMarTech（殖民地海军陆战队科技）指挥官武器架"
	desc = "指挥官的自动化武器架。精选了仅供USCM高级军官使用的强力武器。"
	req_access = list(ACCESS_MARINE_SENIOR)
	vendor_role = list(JOB_CO, JOB_WO_CO)
	icon_state = "guns"
	use_snowflake_points = TRUE

/obj/structure/machinery/cm_vending/gear/commanding_officer/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_commanding_officer

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_commanding_officer, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("单兵即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),

		list("指挥官必备套装（全部带走）", 0, null, null, null),
		list("指挥官必备工具包", 0, /obj/effect/essentials_set/commanding_officer, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("背包（选择1个）", 0, null, null, null),
		list("指挥官背包", 0, /obj/item/storage/backpack/mcommander, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("安全挎包", 0, /obj/item/storage/backpack/satchel/lockable, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("RTO 电话包", 0, /obj/item/storage/backpack/marine/satchel/rto, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("英特尔探险者套装", 0, /obj/item/storage/backpack/marine/satchel/intel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("远征胸挂", 0, /obj/item/storage/backpack/marine/satchel/intel/chestrig, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("远征行囊", 0, /obj/item/storage/backpack/marine/satchel/intel/expeditionsatchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),

		list("护甲（选择1件）", 0, null, null, null),
		list("指挥官's M3 Armor", 0, /obj/item/clothing/suit/storage/marine/CIC/CO, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),

		list("战斗装备（全部拾取）", 0, null, null, null),
		list("M11C头盔", 0, /obj/item/clothing/head/helmet/marine/leader/CO, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),
		list("绝缘战斗手套", 0, /obj/item/clothing/gloves/marine/insulated/black, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("海军陆战队员 战斗靴", 0, /obj/item/clothing/shoes/marine/knife, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_MANDATORY),

		list("配件（任选其一）", 0, null, null, null),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小包（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("蛛网", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色水滴袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("抬头显示（选择1项）", 0, null, null, null),
		list("医疗HUD眼镜", 0, /obj/item/clothing/glasses/hud/health, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_RECOMMENDED),
		list("安全平视显示眼镜", 0, /obj/item/clothing/glasses/sunglasses/sechud, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),

		list("腰带（选择1条）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("宪兵腰带", 0, /obj/item/storage/belt/security/MP/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 医疗存储装置", 0, /obj/item/storage/belt/medical/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 医疗救生装备", 0, /obj/item/storage/belt/medical/lifesaver/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 弹药装载装置", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 枪套工具装备", 0, /obj/item/storage/belt/gun/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M82F 枪套装备", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋（任选2个）", 0, null, null, null),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("医疗包袋", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("自动注射器袋", 0, /obj/item/storage/pouch/autoinjector/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型弹匣袋", 0, /obj/item/storage/pouch/magazine/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("侧臂袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工具袋（满）", 0, /obj/item/storage/pouch/tools/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("循环呼吸器", 0, /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("补丁（酌情）", 0, null, null, null),
		list("坠落猎鹰肩章", 0, /obj/item/clothing/accessory/patch/falcon, null, VENDOR_ITEM_REGULAR),
		list("坠落猎鹰UA肩章", 0, /obj/item/clothing/accessory/patch/falconalt, null, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）大型胸章", 0, /obj/item/clothing/accessory/patch/uscmlarge, null, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 肩章", 0, /obj/item/clothing/accessory/patch, null, VENDOR_ITEM_REGULAR),
		list("联合美洲肩章", 0, /obj/item/clothing/accessory/patch/ua, null, VENDOR_ITEM_REGULAR),
		list("联合美洲国旗肩章", 0, /obj/item/clothing/accessory/patch/uasquare, null, VENDOR_ITEM_REGULAR),
		list("坠鹰挑战币", 0, /obj/item/coin/silver/falcon, null, VENDOR_ITEM_REGULAR)
))

/obj/structure/machinery/cm_vending/clothing/commanding_officer
	name = "\improper ColMarTech（殖民地海军陆战队科技）指挥官装备架"
	desc = "指挥官的自动化装备供应商。提供仅供USCM高级军官使用的精选装备。"
	req_access = list(ACCESS_MARINE_SENIOR)
	vendor_role = list(JOB_CO, JOB_WO_CO)

/obj/structure/machinery/cm_vending/clothing/commanding_officer/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_commanding_officer

/obj/effect/essentials_set/commanding_officer
	spawned_gear_list = list(
		/obj/item/device/binoculars/range/designator,
		/obj/item/map/current_map,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/device/megaphone,
		/obj/item/clothing/accessory/device/whistle/trench,
	)

// This gets around the COs' weapon not spawning without incendiary mag.
/obj/effect/essentials_set/co/riflepreset
	spawned_gear_list = list(
		/obj/item/weapon/gun/rifle/m46c,
	)
