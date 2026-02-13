GLOBAL_LIST_INIT(cm_vending_clothing_tutorial, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("标准海军陆战队员制服", 0, list(/obj/item/clothing/under/marine, /obj/item/clothing/shoes/marine/knife, /obj/item/clothing/gloves/marine, /obj/item/clothing/head/helmet/marine), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),

		list("护甲（选择1件）", 0, null, null, null),
		list("中型护甲", 0, /obj/item/clothing/suit/storage/marine/medium, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),

		list("背包（选择1）", 0, null, null, null),
		list("挎包", 0, /obj/item/storage/backpack/marine/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),

		list("腰带（选择1）", 0, null, null, null),
		list("M276弹药装载装置", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),

		list("袋装物品（任选其一）", 0, null, null, null),
		list("闪光弹袋（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_RECOMMENDED),

	)) // The pouch uses a different category so they only get one

/obj/structure/machinery/cm_vending/clothing/tutorial
	name = "\improper ColMarTech（殖民地海军陆战队科技）自动化海军陆战队员装备架"
	desc = "连接至大型存储库的自动化装备架，存放陆战队步枪兵标准配发装备。"
	icon_state = "mar_rack"
	show_points = TRUE
	vendor_theme = VENDOR_THEME_USCM
	req_access = list(ACCESS_TUTORIAL_LOCKED)

	vendor_role = list()

/obj/structure/machinery/cm_vending/clothing/tutorial/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_tutorial

//------------GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_gear_medic_sandbox, list(
		list("医疗套装（必备）", 0, null, null, null),
		list("基础医疗套装", 0, /obj/effect/essentials_set/medic, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("FIELD S联合人民阵线LIES", 0, null, null, null),
		list("烧伤急救包", 2, /obj/item/stack/medical/advanced/ointment, null, VENDOR_ITEM_RECOMMENDED),
		list("创伤急救包", 2, /obj/item/stack/medical/advanced/bruise_pack, null, VENDOR_ITEM_RECOMMENDED),
		list("医疗夹板", 1, /obj/item/stack/medical/splint, null, VENDOR_ITEM_RECOMMENDED),
		list("血袋（O-型）", 4, /obj/item/reagent_container/blood/OMinus, null, VENDOR_ITEM_REGULAR),

		list("急救包", 0, null, null, null),
		list("高级急救箱", 12, /obj/item/storage/firstaid/adv, null, VENDOR_ITEM_RECOMMENDED),
		list("急救箱", 5, /obj/item/storage/firstaid/regular, null, VENDOR_ITEM_REGULAR),
		list("消防急救箱", 6, /obj/item/storage/firstaid/fire, null, VENDOR_ITEM_REGULAR),
		list("毒素急救包", 6, /obj/item/storage/firstaid/toxin, null, VENDOR_ITEM_REGULAR),
		list("氧气急救箱", 6, /obj/item/storage/firstaid/o2, null, VENDOR_ITEM_REGULAR),
		list("辐射急救包", 6, /obj/item/storage/firstaid/rad, null, VENDOR_ITEM_REGULAR),

		list("药瓶", 0, null, null, null),
		list("药瓶（比卡瑞丁）", 5, /obj/item/storage/pill_bottle/bicaridine, null, VENDOR_ITEM_RECOMMENDED),
		list("药瓶（地塞林）", 5, /obj/item/storage/pill_bottle/dexalin, null, VENDOR_ITEM_REGULAR),
		list("药瓶（地洛芬）", 5, /obj/item/storage/pill_bottle/antitox, null, VENDOR_ITEM_REGULAR),
		list("药瓶（伊纳普洛林）", 5, /obj/item/storage/pill_bottle/inaprovaline, null, VENDOR_ITEM_REGULAR),
		list("药瓶（凯洛坦）", 5, /obj/item/storage/pill_bottle/kelotane, null, VENDOR_ITEM_RECOMMENDED),
		list("药瓶（羟考酮）", 5, /obj/item/storage/pill_bottle/oxycodone, null, VENDOR_ITEM_RECOMMENDED),
		list("药瓶（佩里达松）", 5, /obj/item/storage/pill_bottle/peridaxon, null, VENDOR_ITEM_REGULAR),
		list("药瓶（曲马多）", 5, /obj/item/storage/pill_bottle/tramadol, null, VENDOR_ITEM_RECOMMENDED),

		list("自动注射器", 0, null, null, null),
		list("自动注射器（比卡瑞丁）", 1, /obj/item/reagent_container/hypospray/autoinjector/bicaridine, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（地塞林+）", 1, /obj/item/reagent_container/hypospray/autoinjector/dexalinp, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（迪洛芬）", 1, /obj/item/reagent_container/hypospray/autoinjector/antitoxin, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（肾上腺素）", 2, /obj/item/reagent_container/hypospray/autoinjector/adrenaline, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（伊纳普拉林）", 1, /obj/item/reagent_container/hypospray/autoinjector/inaprovaline, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（凯洛坦）", 1, /obj/item/reagent_container/hypospray/autoinjector/kelotane, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（羟考酮）", 1, /obj/item/reagent_container/hypospray/autoinjector/oxycodone, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（佩里达松）", 1, /obj/item/reagent_container/hypospray/autoinjector/peridaxon, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（曲马多）", 1, /obj/item/reagent_container/hypospray/autoinjector/tramadol, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（三氯二嗪）", 1, /obj/item/reagent_container/hypospray/autoinjector/tricord, null, VENDOR_ITEM_REGULAR),

		list("医疗设施", 0, null, null, null),
		list("MS-11智能补给坦克", 6, /obj/item/reagent_container/glass/minitank, null, VENDOR_ITEM_REGULAR),
		list("菲克索文", 7, /obj/item/tool/surgery/FixOVein, null, VENDOR_ITEM_REGULAR),
		list("滚筒床", 4, /obj/item/roller, null, VENDOR_ITEM_REGULAR),
		list("健康分析仪", 4, /obj/item/device/healthanalyzer, null, VENDOR_ITEM_REGULAR),
		list("静滞袋", 6, /obj/item/bodybag/cryobag, null, VENDOR_ITEM_REGULAR),

		list("护甲", 0, null, null, null),
		list("M3 B12型 海军陆战队员 护甲", 24, /obj/item/clothing/suit/storage/marine/medium/leader, null, VENDOR_ITEM_REGULAR),
		list("M4型制式护甲", 16, /obj/item/clothing/suit/storage/marine/medium/rto, null, VENDOR_ITEM_REGULAR),

		list("公用事业", 0, null, null, null),
		list("灭火器（便携式）", 3, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("哨声", 3, /obj/item/clothing/accessory/device/whistle, null, VENDOR_ITEM_REGULAR),

		list("望远镜", 0, null, null, null),
		list("双筒望远镜", 5, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),

		list("头盔光学系统", 0, null, null, null),
		list("焊接面罩", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),

		list("宣传册", 0, null, null, null),
		list("工程手册", 15, /obj/item/pamphlet/skill/engineer, null, VENDOR_ITEM_REGULAR),

	))

/obj/structure/machinery/cm_vending/gear/medic/tutorial
	req_access = null

/obj/structure/machinery/cm_vending/gear/medic/tutorial/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_medic_sandbox

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_medic_sandbox, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("标准海军陆战队员制服", 0, list(/obj/item/clothing/under/marine/medic, /obj/item/clothing/shoes/marine/knife, /obj/item/clothing/gloves/marine), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("战斗无菌手套", 0, /obj/item/clothing/gloves/marine/medical, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_REGULAR),
		list("单兵即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),

		list("护甲（选择1件）", 0, null, null, null),
		list("轻甲", 0, /obj/item/clothing/suit/storage/marine/light, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("中型护甲", 0, /obj/item/clothing/suit/storage/marine/medium, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),
		list("重甲", 0, /obj/item/clothing/suit/storage/marine/heavy, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),

		list("头盔（选择1）", 0, null, null, null),
		list("M10 医护兵头盔", 0, /obj/item/clothing/head/helmet/marine/medic, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("M10 白色医护兵头盔", 0, /obj/item/clothing/head/helmet/marine/medic/white, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("背包（选择1）", 0, null, null, null),
		list("医疗背包", 0, /obj/item/storage/backpack/marine/medic, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("医疗挎包", 0, /obj/item/storage/backpack/marine/satchel/medic, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),

		list("腰带（选择1）", 0, null, null, null),
		list("M276 救生包（满）", 0, /obj/item/storage/belt/medical/lifesaver/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_MANDATORY),
		list("M276 医疗存储装置（满载）", 0, /obj/item/storage/belt/medical/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_MANDATORY),

		list("小袋（选择2个）", 0, null, null, null),
		list("加压试剂罐袋（复苏合剂 - 三氯拉嗪）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/revival_tricord, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（复苏合剂 - 佩里达克松）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/revival_peri, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗包袋", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("自动注射器袋", 0, /obj/item/storage/pouch/autoinjector, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救员腰包", 0, /obj/item/storage/pouch/first_responder, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("加压试剂罐包（碧卡利定）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/bicaridine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("加压试剂罐包（凯洛坦）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/kelotane, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("加压试剂罐包（三合剂）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/tricordrazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("加压试剂罐包（野战麻醉剂）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/oxycodone, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（空）", 0, /obj/item/storage/pouch/pressurized_reagent_canister, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("药水瓶袋（满）", 0, /obj/item/storage/pouch/vials/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗包", 0, /obj/item/storage/pouch/medical, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("闪光弹包（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("弹匣袋", 0, /obj/item/storage/pouch/magazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("手枪袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("配件（任选其一）", 0, null, null, null),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小袋（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("无菌口罩", 0, /obj/item/clothing/mask/surgical, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR)
	))

/obj/structure/machinery/cm_vending/clothing/medic/tutorial
	req_access = null

/obj/structure/machinery/cm_vending/clothing/medic/tutorial/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_medic_sandbox
