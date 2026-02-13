//------------ MP CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_military_police, list(
		list("警察套装（强制）", 0, null, null, null),
		list("基础警用装备套装", 0, /obj/effect/essentials_set/police, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("标准装备（全部拾取）", 0, null, null, null),
		list("手套", 0, /obj/item/clothing/gloves/marine, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("制服", 0, /obj/item/clothing/under/marine/mp, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("海军陆战队员 战斗靴", 0, /obj/item/clothing/shoes/marine/knife, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_MANDATORY),

		list("护甲（全部拾取）", 0, null, null, null),
		list("宪兵M2型装甲", 0, /obj/item/clothing/suit/storage/marine/MP, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("MP贝雷帽", 0, /obj/item/clothing/head/beret/marine/mp, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),

		list("手枪箱（选择1）", 0, null, null, null),
		list("88 模组 4 战斗手枪箱", 0, /obj/item/storage/box/guncase/mod88, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_MANDATORY),
		list("M44 战斗左轮手枪箱", 0, /obj/item/storage/box/guncase/m44, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_MANDATORY),
		list("M4A4 制式手枪箱", 0, /obj/item/storage/box/guncase/m4a4, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_MANDATORY),

		list("背包（选择1件）", 0, null, null, null),
		list("宪兵挎包", 0, /obj/item/storage/backpack/satchel/sec, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),

		list("腰带（选择1）", 0, null, null, null),
		list("M276通用手枪携行装具", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276通用左轮手枪套装备", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋（任选2个）", 0, null, null, null),
		list("中型通用袋", 0, /obj/item/storage/pouch/general/medium, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（可补充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("手枪袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("循环呼吸器", 0, /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("配件（任选其一）", 0, null, null, null),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小包（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/military_police
	name = "\improper ColMarTech（殖民地海军陆战队科技） 宪兵装备架"
	desc = "一个连接着海量标准配发装备存储库的自动化装备架，供宪兵使用。"
	req_access = list(ACCESS_MARINE_BRIG)
	vendor_role = list(JOB_POLICE,JOB_POLICE_HG)

/obj/structure/machinery/cm_vending/clothing/military_police/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_military_police

//------------ Warden CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_military_police_warden, list(
		list("警察套装（强制）", 0, null, null, null),
		list("基础警用装备套装", 0, /obj/effect/essentials_set/police, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("标准装备（全部拾取）", 0, null, null, null),
		list("手套", 0, /obj/item/clothing/gloves/marine, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("守望者制服", 0, /obj/item/clothing/under/marine/warden, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("海军陆战队员 战斗靴", 0, /obj/item/clothing/shoes/marine/knife, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_MANDATORY),

		list("护甲（全部拾取）", 0, null, null, null),
		list("军事典狱长M3装甲", 0, /obj/item/clothing/suit/storage/marine/MP/warden, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("典狱长帽", 0, /obj/item/clothing/head/beret/marine/mp/warden, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),

		list("手枪箱（选择1）", 0, null, null, null),
		list("88 模组 4 战斗手枪箱", 0, /obj/item/storage/box/guncase/mod88, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_MANDATORY),
		list("M44 战斗左轮手枪箱", 0, /obj/item/storage/box/guncase/m44, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_MANDATORY),
		list("M4A4 制式手枪箱", 0, /obj/item/storage/box/guncase/m4a4, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_MANDATORY),

		list("背包（选择1件）", 0, null, null, null),
		list("宪兵挎包", 0, /obj/item/storage/backpack/satchel/sec, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),

		list("腰带（选择1）", 0, null, null, null),
		list("M276通用手枪套携行系统", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276通用左轮手枪套装备", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋（任选2种）", 0, null, null, null),
		list("中型通用袋", 0, /obj/item/storage/pouch/general/medium, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（药丸包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("手枪袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("循环呼吸器", 0, /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("配件（选择1件）", 0, null, null, null),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/military_police_warden
	name = "\improper ColMarTech（殖民地海军陆战队科技） 军事典狱长装备架"
	desc = "一个连接着海量标准配发装备存储库的自动化装备架，供宪兵使用。"
	req_access = list(ACCESS_MARINE_BRIG)
	vendor_role = list(JOB_WARDEN)

/obj/structure/machinery/cm_vending/clothing/military_police_warden/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_military_police_warden

/obj/effect/essentials_set/police
	spawned_gear_list = list(
		/obj/item/clothing/glasses/sunglasses/sechud,
		/obj/item/storage/belt/security/MP/full,
		/obj/item/clothing/head/helmet/marine/MP,
	)
