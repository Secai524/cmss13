//------------ CC CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_combat_correspondent, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("必备记者套装", 0, /obj/effect/essentials_set/cc, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),
		list("皮革挎包", 0, /obj/item/storage/backpack/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("按下广播摄像机", 0, /obj/item/device/broadcasting, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),

		list("平民装备（全部拾取）", 0, null, null, null),
		list("便携式传真机", 0, /obj/item/device/fax_backpack, CIVILIAN_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),

		list("制服（选择1件）", 0, null, null, null),
		list("黑色制服", 0, /obj/item/clothing/under/marine/reporter/black, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("橙色制服", 0, /obj/item/clothing/under/marine/reporter/orange, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("红色制服", 0, /obj/item/clothing/under/marine/reporter/red, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),

		list("护甲（选择1件）", 0, null, null, null),
		list("战地记者's Armor", 0, /obj/item/clothing/suit/storage/marine/light/reporter, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),
		list("蓝色背心", 0, /obj/item/clothing/suit/storage/jacket/marine/reporter/blue, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("黑背心", 0, /obj/item/clothing/suit/storage/hazardvest/black, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("黑外套", 0, /obj/item/clothing/suit/storage/jacket/marine/reporter/black, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("绿外套", 0, /obj/item/clothing/suit/storage/jacket/marine/reporter/green, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("绿色夹克", 0, /obj/item/clothing/suit/storage/jacket/marine/correspondent, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("蓝夹克", 0, /obj/item/clothing/suit/storage/jacket/marine/correspondent/blue, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("棕色夹克", 0, /obj/item/clothing/suit/storage/jacket/marine/correspondent/tan, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("棕色夹克", 0, /obj/item/clothing/suit/storage/jacket/marine/correspondent/brown, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),


		list("头盔（选择1个）", 0, null, null, null),
		list("战地记者's Helmet", 0, /obj/item/clothing/head/helmet/marine/reporter, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("战地记者's Cap", 0, /obj/item/clothing/head/cmcap/reporter, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("Fedora", 0, /obj/item/clothing/head/fedora/grey, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("补充", 0, null, null, null),
		list("相机", 10, /obj/item/device/camera, null, VENDOR_ITEM_REGULAR),
		list("相机胶卷", 5, /obj/item/device/camera_film, null, VENDOR_ITEM_REGULAR),
		list("碳粉", 5, /obj/item/device/toner, null, VENDOR_ITEM_REGULAR),
		list("监管磁带", 15, /obj/item/storage/box/tapes, null, VENDOR_ITEM_REGULAR),
		list("废纸篓", 10, /obj/item/paper_bin/uscm, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/combat_correspondent
	name = "\improper ColMarTech（殖民地海军陆战队科技） 战斗通讯员装备架"
	desc = "一个连接着海量标准配发装备存储库的自动化装备架，供记者使用。"
	req_access = list(ACCESS_PRESS)
	vendor_role = list(JOB_COMBAT_REPORTER)

/obj/structure/machinery/cm_vending/clothing/combat_correspondent/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_combat_correspondent

/obj/effect/essentials_set/cc
	spawned_gear_list = list(
		/obj/item/device/flashlight,
		/obj/item/tool/pen,
		/obj/item/device/binoculars,
		/obj/item/notepad,
		/obj/item/device/taperecorder,
	)
