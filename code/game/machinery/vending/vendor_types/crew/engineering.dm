//------------ MT CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_maintenance_technician, list(
		list("维护套装（必选）", 0, null, null, null),
		list("基础维护套装", 0, /obj/effect/essentials_set/maintenance, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("标准装备（全部拾取）", 0, null, null, null),
		list("绝缘手套", 0, /obj/item/clothing/gloves/yellow, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("军用即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("地图", 0, /obj/item/map/current_map, MARINE_CAN_BUY_MAP, VENDOR_ITEM_MANDATORY),

		list("头盔（选择1）", 0, null, null, null),
		list("贝雷帽，工程", 0, /obj/item/clothing/head/beret/eng, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("白色安全帽", 0, /obj/item/clothing/head/hardhat/white, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("橙色安全帽", 0, /obj/item/clothing/head/hardhat/orange, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("蓝色安全帽", 0, /obj/item/clothing/head/hardhat/dblue, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("焊接头盔", 0, /obj/item/clothing/head/welding, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("套装（选择1）", 0, null, null, null),
		list("黑色危险背心", 0, /obj/item/clothing/suit/storage/hazardvest/black, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("蓝色危险背心", 0, /obj/item/clothing/suit/storage/hazardvest/blue, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("橙色警示背心", 0, /obj/item/clothing/suit/storage/hazardvest, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("黄色警示背心", 0, /obj/item/clothing/suit/storage/hazardvest/yellow, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),

		list("背包（选择1）", 0, null, null, null),
		list("技师背包", 0, /obj/item/storage/backpack/marine/tech, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("技师挎包", 0, /obj/item/storage/backpack/marine/satchel/tech, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("技师焊接包", 0, /obj/item/storage/backpack/marine/engineerpack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("技师焊工-挎包", 0, /obj/item/storage/backpack/marine/engineerpack/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("技师焊工胸挂", 0, /obj/item/storage/backpack/marine/engineerpack/welder_chestrig, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),

		list("腰带（选择1）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 工具腰带装备（全套）", 0, /obj/item/storage/belt/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_MANDATORY),

		list("小袋（任选2个）", 0, null, null, null),
		list("中型通用袋", 0, /obj/item/storage/pouch/general/medium, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("建造袋", 0, /obj/item/storage/pouch/construction, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("电子袋（已满）", 0, /obj/item/storage/pouch/electronics/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工具袋（满）", 0, /obj/item/storage/pouch/tools/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("闪光弹包（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("循环呼吸器", 0, /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("配件（任选其一）", 0, null, null, null),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小包（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("蛛网", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("备用装备", 0, null, null, null),
		list("合成重置密钥", 20, /obj/item/device/defibrillator/synthetic, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/maintenance_technician
	name = "\improper ColMarTech（殖民地海军陆战队科技）维护技师装备架"
	desc = "一个连接着海量标准配发装备存储库的自动化装备架，供维护技术员使用。"
	req_access = list(ACCESS_MARINE_ENGINEERING)
	vendor_role = list(JOB_MAINT_TECH)

/obj/structure/machinery/cm_vending/clothing/maintenance_technician/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_maintenance_technician

/obj/effect/essentials_set/maintenance
	spawned_gear_list = list(
		/obj/item/device/lightreplacer,
		/obj/item/device/demo_scanner,
		/obj/item/storage/bag/trash,
		/obj/item/storage/toolbox/mechanical,
		/obj/item/device/flashlight,
	)
