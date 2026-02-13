/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/upp_squad_prep
	name = "\improper 联合亚拉腊公司剩余制服供应商"
	desc = "一个连接着小规模存储库的自动化补给架，内含标准士兵制服。"
	icon_state = "upp_clothing"
	req_access = list(ACCESS_UPP_GENERAL)
	vendor_theme = VENDOR_THEME_UPP
	req_one_access = list()
	listed_products = list()
	hackable = TRUE

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/upp_squad_prep/populate_product_list(scale)
	listed_products = list(
		list("标准装备", -1, null, null),
		list("士兵战斗靴", floor(scale * 15), /obj/item/clothing/shoes/marine/upp/knife, VENDOR_ITEM_REGULAR),
		list("联合人民阵线 制服", floor(scale * 15), /obj/item/clothing/under/marine/veteran/UPP, VENDOR_ITEM_REGULAR),
		list("士兵 战斗 手套", floor(scale * 15), /obj/item/clothing/gloves/marine/veteran/upp, VENDOR_ITEM_REGULAR),
		list("士兵无线电耳机", floor(scale * 15), /obj/item/device/radio/headset/distress/UPP, VENDOR_ITEM_REGULAR),
		list("UM4头盔", floor(scale * 15), /obj/item/clothing/head/helmet/marine/veteran/UPP, VENDOR_ITEM_REGULAR),

		list("头部装备", -1, null, null),
		list("UL3装甲贝雷帽", 15, /obj/item/clothing/head/uppcap/beret, VENDOR_ITEM_REGULAR),
		list("UL8 装甲乌沙帽", 15, /obj/item/clothing/head/uppcap/ushanka, VENDOR_ITEM_REGULAR),

		list("织带", -1, null, null),
		list("棕色网眼背心", 1, /obj/item/clothing/accessory/storage/black_vest/brown_vest, VENDOR_ITEM_REGULAR),
		list("黑色网眼背心", 1, /obj/item/clothing/accessory/storage/black_vest, VENDOR_ITEM_REGULAR),
		list("织带", floor(scale * 2), /obj/item/clothing/accessory/storage/webbing, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0.75, /obj/item/clothing/accessory/storage/droppouch, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0.75, /obj/item/clothing/accessory/storage/droppouch/black, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0.75, /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),

		list("护甲", -1, null, null),
		list("UM5中型个人护甲", floor(scale * 15), /obj/item/clothing/suit/storage/marine/faction/UPP, VENDOR_ITEM_REGULAR),
		list("UL6轻型个人护甲", floor(scale * 15), /obj/item/clothing/suit/storage/marine/faction/UPP/support, VENDOR_ITEM_REGULAR),

		list("背包", -1, null, null),
		list("战斗包", floor(scale * 15), /obj/item/storage/backpack/lightpack/upp, VENDOR_ITEM_REGULAR),

		list("受限背包", -1, null, null),
		list("联合人民阵线 工兵焊接包", floor(scale * 2), /obj/item/storage/backpack/marine/engineerpack/upp, VENDOR_ITEM_REGULAR),

		list("腰带", -1, null, null),
		list("41型弹药装载装置", floor(scale * 15), /obj/item/storage/belt/marine/upp, VENDOR_ITEM_REGULAR),
		list("NPZ92手枪枪套装备", floor(scale * 15), /obj/item/storage/belt/gun/type47, VENDOR_ITEM_REGULAR),
		list("信号枪枪套装备", floor(scale * 2), /obj/item/storage/belt/gun/flaregun, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹壳装填装置", floor(scale * 15), /obj/item/storage/belt/shotgun, VENDOR_ITEM_REGULAR),
		list("G8-A 通用工具袋", floor(scale * 15), /obj/item/storage/backpack/general_belt, VENDOR_ITEM_REGULAR),

		list("袋囊", -1, null, null),
		list("刺刀鞘（满）",floor(scale * 15), /obj/item/storage/pouch/bayonet, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", floor(scale * 15), /obj/item/storage/pouch/firstaid/full/alternate, VENDOR_ITEM_REGULAR),
		list("急救包（药丸包）", floor(scale * 15), /obj/item/storage/pouch/firstaid/full/pills, VENDOR_ITEM_REGULAR),
		list("闪光弹包（满）", floor(scale * 15), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("小型文件袋", floor(scale * 15), /obj/item/storage/pouch/document/small, VENDOR_ITEM_REGULAR),
		list("弹匣袋", floor(scale * 15), /obj/item/storage/pouch/magazine, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹袋", floor(scale * 15), /obj/item/storage/pouch/shotgun, VENDOR_ITEM_REGULAR),
		list("中型通用袋", floor(scale * 15), /obj/item/storage/pouch/general/medium, VENDOR_ITEM_REGULAR),
		list("手枪弹匣袋", floor(scale * 15), /obj/item/storage/pouch/magazine/pistol, VENDOR_ITEM_REGULAR),
		list("手枪袋", floor(scale * 15), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),

		list("限制性储物袋", -1, null, null),
		list("建造袋", 1.25, /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("爆裂袋", 1.25, /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("急救包（空）", 2.5, /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", floor(scale * 2), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("工具袋", 1.25, /obj/item/storage/pouch/tools, VENDOR_ITEM_REGULAR),
		list("投石袋", 1.25, /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),

		list("面具", -1, null, null),
		list("防毒面具", floor(scale * 15), /obj/item/clothing/mask/gas, VENDOR_ITEM_REGULAR),
		list("吸热头巾", floor(scale * 10), /obj/item/clothing/mask/rebreather/scarf, VENDOR_ITEM_REGULAR),
		list("循环呼吸器", floor(scale * 10), /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("杂项", -1, null, null),
		list("防弹护目镜", floor(scale * 10), /obj/item/clothing/glasses/mgoggles, VENDOR_ITEM_REGULAR),
		list("M1A1 防弹护目镜", floor(scale * 10), /obj/item/clothing/glasses/mgoggles/v2, VENDOR_ITEM_REGULAR),
		list("处方防弹护目镜", floor(scale * 10), /obj/item/clothing/glasses/mgoggles/prescription, VENDOR_ITEM_REGULAR),
		list("枪械润滑油", floor(scale * 15), /obj/item/prop/helmetgarb/gunoil, VENDOR_ITEM_REGULAR),
		list("可挂载身份牌", floor(scale * 15), /obj/item/clothing/accessory/dogtags, VENDOR_ITEM_REGULAR),
		list("UPP 徽章", floor(scale * 15), /obj/item/clothing/accessory/patch/upp, VENDOR_ITEM_REGULAR),
		list("UPP 海军步兵徽章", floor(scale * 15), /obj/item/clothing/accessory/patch/upp/naval, VENDOR_ITEM_REGULAR),
		list("铺盖卷", floor(scale * 20), /obj/item/roller/bedroll, VENDOR_ITEM_REGULAR),

		list("光学", -1, null, null),
		list("高级医疗光学（仅限医务兵）", floor(scale * 4), /obj/item/device/helmet_visor/medical/advanced, VENDOR_ITEM_REGULAR),

		)
