/obj/structure/machinery/cm_vending/clothing/staff_officer
	name = "\improper 殖民地海军陆战队科技（ColMarTech）参谋军官装备架"
	desc = "参谋军官的自动化装备供应商。"
	req_access = list(ACCESS_MARINE_COMMAND)
	vendor_role = list(JOB_SO)

/obj/structure/machinery/cm_vending/clothing/staff_officer/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_staff_officer

//------------CLOTHING---------------

GLOBAL_LIST_INIT(cm_vending_clothing_staff_officer, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("靴子", 0, /obj/item/clothing/shoes/marine/knife, MARINE_CAN_BUY_COMBAT_SHOES, VENDOR_ITEM_MANDATORY),
		list("单兵即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),


		list("标准装备（全部拾取）", 0, null, null, null),
		list("服务制服", 0, /obj/item/clothing/under/marine/officer/bridge, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("作战制服", 0, /obj/item/clothing/under/marine/officer/boiler, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_RECOMMENDED),
		list("绝缘手套（黑色）", 0, /obj/item/clothing/gloves/marine/insulated/black, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),

		list("夹克（选择1件）", 0, null, null, null),
		list("服务夹克", 0, /obj/item/clothing/suit/storage/jacket/marine/service, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),

		list("帽子（选择1顶）", 0, null, null, null),
		list("贝雷帽，绿色", 0, /obj/item/clothing/head/beret/cm/green, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("贝雷帽，棕褐色", 0, /obj/item/clothing/head/beret/cm/tan, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("巡逻帽", 0, /obj/item/clothing/head/cmcap, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("卡普警官", 0, /obj/item/clothing/head/cmcap/bridge, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("服务帽", 0, /obj/item/clothing/head/marine/peaked/service, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),

		list("补丁", 0, null, null, null),
		list("坠落猎鹰肩章", 1, /obj/item/clothing/accessory/patch/falcon, null, VENDOR_ITEM_REGULAR),
		list("坠落猎鹰UA肩章", 1, /obj/item/clothing/accessory/patch/falconalt, null, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）大型胸章", 1, /obj/item/clothing/accessory/patch/uscmlarge, null, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 肩章", 1, /obj/item/clothing/accessory/patch, null, VENDOR_ITEM_REGULAR),
		list("联合美洲肩章", 1, /obj/item/clothing/accessory/patch/ua, null, VENDOR_ITEM_REGULAR),
		list("联合美洲国旗肩章", 1, /obj/item/clothing/accessory/patch/uasquare, null, VENDOR_ITEM_REGULAR),

		list("个人副武器（选择1）", 0, null, null, null),
		list("M44左轮手枪", 0, /obj/item/storage/belt/gun/m44/mp, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),
		list("88式手枪", 0, /obj/item/storage/belt/gun/m4a3/mod88, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),
		list("M4A3 手枪", 0, /obj/item/storage/belt/gun/m4a3/commander, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),
		list("VP78 手枪", 0, /obj/item/storage/belt/gun/m4a3/vp78, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),

		list("配件（任选其一）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小包（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("蛛网", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("背包（选择1个）", 0, null, null, null),
		list("背包", 0, /obj/item/storage/backpack/marine, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("挎包", 0, /obj/item/storage/backpack/marine/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),


		list("其他S联合人民阵线谎言", 0, null, null, null),
		list("双筒望远镜", 5,/obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("测距仪", 8, /obj/item/device/binoculars/range, null,  VENDOR_ITEM_REGULAR),
		list("激光指示器", 12, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_RECOMMENDED),
		list("手电筒", 1, /obj/item/device/flashlight, null, VENDOR_ITEM_REGULAR),
		list("运动探测器", 5, /obj/item/device/motiondetector, null, VENDOR_ITEM_RECOMMENDED),
		list("太空清洁工", 2, /obj/item/reagent_container/spray/cleaner, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/gear/staff_officer_armory
	name = "\improper 科马尔科技（殖民地海军陆战队科技） 参谋军官军械库装备架"
	desc = "参谋军官的自动化战斗装备供应商。"
	req_access = list(ACCESS_MARINE_COMMAND)
	icon_state = "mar_rack"
	vendor_role = list(JOB_SO)

/obj/structure/machinery/cm_vending/gear/staff_officer_armory/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_staff_officer_armory

//------------ARMORY---------------

GLOBAL_LIST_INIT(cm_vending_gear_staff_officer_armory, list(
		list("战斗装备（全部拾取）", 0, null, null, null),
		list("M3军官装甲", 0, /obj/item/clothing/suit/storage/marine/CIC, MARINE_CAN_BUY_COMBAT_ARMOR, VENDOR_ITEM_MANDATORY),
		list("M10军官头盔", 0, /obj/item/clothing/head/helmet/marine/MP/SO, MARINE_CAN_BUY_COMBAT_HELMET, VENDOR_ITEM_MANDATORY),
		list("海军陆战队员 战斗靴", 0, /obj/item/clothing/shoes/marine/knife, MARINE_CAN_BUY_COMBAT_SHOES, VENDOR_ITEM_MANDATORY),
		list("海军陆战队员 战斗 手套", 0, /obj/item/clothing/gloves/marine, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("单兵即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("飞行员墨镜", 0, /obj/item/clothing/glasses/sunglasses/aviator, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
		list("刺刀", 0, /obj/item/attachable/bayonet, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),

		list("专精套件（选择1项）", 0, null, null, null),
		list("必备工程师套装", 0, /obj/effect/essentials_set/engi, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),
		list("基础医疗套装", 0, /obj/effect/essentials_set/medic, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),
		list("核心领袖套装", 0, /obj/effect/essentials_set/leader_command, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("腰带（选择1）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276弹药装载装置", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276霰弹枪装弹装置", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 工具腰带装备（全套）", 0, /obj/item/storage/belt/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 救生包（满）", 0, /obj/item/storage/belt/medical/lifesaver/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 医疗存储装置（满载）", 0, /obj/item/storage/belt/medical/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M39 枪套装备", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 枪套工具装备（完整版）", 0, /obj/item/storage/belt/gun/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M82F 枪套装备", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M40 榴弹携行具", 0, /obj/item/storage/belt/grenade, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋（选择2个）", 0, null, null, null),
		list("自动注射器袋", 0, /obj/item/storage/pouch/autoinjector/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("大型弹匣袋", 0, /obj/item/storage/pouch/magazine/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("大型霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗包", 0, /obj/item/storage/pouch/medical, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗包袋", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("手枪袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工具袋（满）", 0, /obj/item/storage/pouch/tools/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("建造袋", 0, /obj/item/storage/pouch/construction, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("电子钱包（已满）", 0, /obj/item/storage/pouch/electronics/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("闪光弹包（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("油箱绑带袋", 0, /obj/item/storage/pouch/flamertank, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("其他S联合人民阵线谎言", 0, null, null, null),
		list("焊接面罩", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),
		list("绝缘手套", 3, /obj/item/clothing/gloves/yellow, null, VENDOR_ITEM_REGULAR),
		list("挖掘工具", 1, /obj/item/tool/shovel/etool, null, VENDOR_ITEM_REGULAR),
		list("磁力背带", 12, /obj/item/attachable/magnetic_harness, null, VENDOR_ITEM_RECOMMENDED),
		list("无线电电话包", 15, /obj/item/storage/backpack/marine/satchel/rto, null, VENDOR_ITEM_RECOMMENDED),
		list("运动探测器", 5, /obj/item/device/motiondetector, null, VENDOR_ITEM_RECOMMENDED),
		list("砍刀刀鞘（完整）", 5, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("双筒望远镜", 5,/obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("测距仪", 8, /obj/item/device/binoculars/range, null,  VENDOR_ITEM_REGULAR),
		list("激光指示器", 12, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_RECOMMENDED),
		list("富尔顿回收装置", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("太空清洁工", 2, /obj/item/reagent_container/spray/cleaner, null, VENDOR_ITEM_REGULAR),
		list("手电筒", 1, /obj/item/device/flashlight, null, VENDOR_ITEM_REGULAR),
	))

/obj/effect/essentials_set/leader_command
	spawned_gear_list = list(
		/obj/item/explosive/plastic,
		/obj/item/device/binoculars/range/designator,
		/obj/item/map/current_map,
		/obj/item/stack/fulton,
		/obj/item/device/megaphone,
		/obj/item/storage/box/m94/signal,
		/obj/item/tool/extinguisher/mini,
		/obj/item/storage/box/zipcuffs,
		/obj/item/clothing/accessory/device/whistle/trench,
	)
