//------------GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_gear_sea, list(
		list("个人主要（选择1项）", 0, null, null, null),
		list("M41A MK1 脉冲步枪", 0, /obj/item/weapon/gun/rifle/m41aMK1, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),

		list("备用弹药", 0, null, null, null),
		list("M41A MK1 弹匣", 9, /obj/item/ammo_magazine/rifle/m41aMK1, null, VENDOR_ITEM_REGULAR),

		list("枪械配件（选择1项）", 0, null, null, null),
		list("激光瞄准镜", 0, /obj/item/attachable/lasersight, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("红点瞄准镜", 0, /obj/item/attachable/reddot, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("S5微型红点瞄准镜", 0, /obj/item/attachable/reddot/small, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("反射式瞄准镜", 0, /obj/item/attachable/reflex, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Rail 手电筒", 0, /obj/item/attachable/flashlight, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/gear/sea
	name = "ColMarTech SEA武器架"
	desc = "高级士兵顾问的自动化装备架。"
	req_access = list(ACCESS_MARINE_SEA)
	vendor_role = list(JOB_SEA)
	icon_state = "guns"

/obj/structure/machinery/cm_vending/gear/sea/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_sea

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_sea, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("钻头帽", 0, /obj/item/clothing/head/drillhat, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("军官制服", 0, /obj/item/clothing/under/marine/dress, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("USCM（殖民地海军陆战队）服役档案", 0, /obj/item/clothing/suit/storage/jacket/marine/service, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 战斗靴", 0, /obj/item/clothing/shoes/marine/knife, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_MANDATORY),
		list("挎包", 0, /obj/item/storage/backpack/satchel/lockable, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("军用即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("战壕哨", 0, /obj/item/clothing/accessory/device/whistle/trench, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("手套（选择1）", 0, null, null, null),
		list("绝缘手套", 0, /obj/item/clothing/gloves/yellow, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 战斗 手套", 0, /obj/item/clothing/gloves/marine, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_REGULAR),

		list("腰带（选择1）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 救生包（满）", 0, /obj/item/storage/belt/medical/lifesaver/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 工具腰带装备（全套）", 0, /obj/item/storage/belt/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 战斗工具腰带装备（全套）", 0, /obj/item/storage/belt/gun/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋（任选2个）", 0, null, null, null),
		list("自动注射器袋", 0, /obj/item/storage/pouch/autoinjector/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型弹匣袋", 0, /obj/item/storage/pouch/magazine/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗包袋", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("侧臂袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("战斗装备", 0, null, null, null),
		list("M10头盔", 0, /obj/item/clothing/head/helmet/marine, MARINE_CAN_BUY_COMBAT_HELMET, VENDOR_ITEM_REGULAR),
		list("M3-VL型防弹背心", 0, /obj/item/clothing/suit/storage/marine/light/vest, MARINE_CAN_BUY_COMBAT_ARMOR, VENDOR_ITEM_REGULAR),
		list("M3-L型轻量化装甲", 0, /obj/item/clothing/suit/storage/marine/light, MARINE_CAN_BUY_COMBAT_ARMOR, VENDOR_ITEM_RECOMMENDED),
		list("M3型加垫护甲", 0, /obj/item/clothing/suit/storage/marine/medium/padded, MARINE_CAN_BUY_COMBAT_ARMOR, VENDOR_ITEM_REGULAR),
		list("防弹背心", 0, /obj/item/clothing/suit/armor/bulletproof, MARINE_CAN_BUY_COMBAT_ARMOR, VENDOR_ITEM_REGULAR),

		list("眼镜（选择1副）", 0, null, null, null),
		list("焊接护目镜", 0, /obj/item/clothing/glasses/welding, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
		list("医疗HUD眼镜", 0, /obj/item/clothing/glasses/hud/health, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
		list("处方医疗HUD眼镜", 0, /obj/item/clothing/glasses/hud/health/prescription, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
		list("太阳镜", 0, /obj/item/clothing/glasses/sunglasses, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),

		list("配件（任选其一）", 0, null, null, null),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/sea
	name = "ColMarTech SEA装备架"
	desc = "一个连接着海量标准配发装备存储库的自动化装备架，供高级士兵顾问使用。"
	req_access = list(ACCESS_MARINE_SEA)
	vendor_role = list(JOB_SEA)

/obj/structure/machinery/cm_vending/clothing/sea/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_sea
