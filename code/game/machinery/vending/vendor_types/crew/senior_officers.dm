/obj/structure/machinery/cm_vending/clothing/senior_officer
	name = "\improper 殖民地海军陆战队科技高级军官装备架"
	desc = "高级军官的自动化装备供应商。"
	req_access = list(ACCESS_MARINE_SENIOR)
	vendor_role = list(JOB_CHIEF_POLICE, JOB_CMO, JOB_XO, JOB_CHIEF_ENGINEER, JOB_CHIEF_REQUISITION, JOB_AUXILIARY_OFFICER)

/obj/structure/machinery/cm_vending/clothing/senior_officer/get_listed_products(mob/user)
	if(!user)
		var/list/combined = list()
		combined += GLOB.cm_vending_clothing_xo
		combined += GLOB.cm_vending_clothing_chief_engineer
		combined += GLOB.cm_vending_clothing_req_officer
		combined += GLOB.cm_vending_clothing_cmo
		combined += GLOB.cm_vending_clothing_military_police_chief
		combined += GLOB.cm_vending_clothing_auxiliary_officer
		return combined
	if(user.job == JOB_XO)
		return GLOB.cm_vending_clothing_xo
	else if(user.job == JOB_CHIEF_ENGINEER)
		return GLOB.cm_vending_clothing_chief_engineer
	else if(user.job == JOB_CHIEF_REQUISITION)
		return GLOB.cm_vending_clothing_req_officer
	else if(user.job == JOB_CMO)
		return GLOB.cm_vending_clothing_cmo
	else if(user.job == JOB_CHIEF_POLICE)
		return GLOB.cm_vending_clothing_military_police_chief
	else if(user.job == JOB_AUXILIARY_OFFICER)
		return GLOB.cm_vending_clothing_auxiliary_officer
	return ..()


//------------ CHIEF MP ---------------
GLOBAL_LIST_INIT(cm_vending_clothing_military_police_chief, list(
		list("警察套装（强制）", 0, null, null, null),
		list("基础警用套装", 0, /obj/effect/essentials_set/chiefmilitarypolice, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("标准装备（全部拾取）", 0, null, null, null),
		list("手套", 0, /obj/item/clothing/gloves/marine, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("CMP制服", 0, /obj/item/clothing/under/marine/officer/warrant, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("海军陆战队员 战斗靴", 0, /obj/item/clothing/shoes/marine/knife, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_MANDATORY),

		list("护甲（全部拾取）", 0, null, null, null),
		list("宪兵队长M3装甲", 0, /obj/item/clothing/suit/storage/marine/MP/WO, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),
		list("首席MP M10头盔", 0, /obj/item/clothing/head/helmet/marine/MP/WO, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),
		list("CMP贝雷帽", 0, /obj/item/clothing/head/beret/marine/mp/cmp, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),

		list("手枪箱（选择1）", 0, null, null, null),
		list("88 模组 4 战斗手枪箱", 0, /obj/item/storage/box/guncase/mod88, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_MANDATORY),
		list("M44 战斗左轮手枪箱", 0, /obj/item/storage/box/guncase/m44, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_MANDATORY),
		list("M4A4 制式手枪箱", 0, /obj/item/storage/box/guncase/m4a4, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_MANDATORY),

		list("背包（选择1）", 0, null, null, null),
		list("宪兵挎包", 0, /obj/item/storage/backpack/satchel/sec, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),

		list("腰带（选择1）", 0, null, null, null),
		list("M276通用手枪携行装具", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276通用左轮手枪套装备", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋（任选2件）", 0, null, null, null),
		list("中型通用袋", 0, /obj/item/storage/pouch/general/medium, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（药丸包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("手枪袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("循环呼吸器", 0, /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("配件（选择1件）", 0, null, null, null),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小袋（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("蛛网", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("备用装备", 0, null, null, null),
		list("警官's Headset", 15, /obj/item/device/radio/headset/almayer/mmpo, null, VENDOR_ITEM_REGULAR),
		list("守望者头戴式耳机", 30, /obj/item/device/radio/headset/almayer/mcom/mw, null, VENDOR_ITEM_REGULAR),
	))


//------------ CHIEF ENGINEER ---------------
GLOBAL_LIST_INIT(cm_vending_clothing_chief_engineer, list(

		list("舰载装备", 0, null, null, null),

		list("标准装备（全部拾取）", 0, null, null, null),
		list("标准装备", 0, list( /obj/item/clothing/glasses/welding, /obj/item/device/working_joe_pda/uscm, /obj/item/weapon/gun/smg/nailgun/compact/tactical, /obj/item/ammo_magazine/smg/nailgun), MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),
		list("手套", 0, /obj/item/clothing/gloves/yellow, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),

		list("制服（选择1件）", 0, null, null, null),
		list("首席工程师制服", 0, /obj/item/clothing/under/marine/officer/ce, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_RECOMMENDED),
		list("服务制服", 0, /obj/item/clothing/under/marine/officer/bridge, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),

		list("头盔（选择1）", 0, null, null, null),
		list("贝雷帽，工程", 0, /obj/item/clothing/head/beret/eng, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("安全帽", 0, /obj/item/clothing/head/hardhat/white, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("巡逻帽", 0, /obj/item/clothing/head/cmcap, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("焊接头盔", 0, /obj/item/clothing/head/welding, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("套装（选择1）", 0, null, null, null),
		list("黑色危险背心", 0, /obj/item/clothing/suit/storage/hazardvest/black, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("蓝色危险背心", 0, /obj/item/clothing/suit/storage/hazardvest/blue, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("橙色警示背心", 0, /obj/item/clothing/suit/storage/hazardvest, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("黄色警示背心", 0, /obj/item/clothing/suit/storage/hazardvest/yellow, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）服役档案", 0, /obj/item/clothing/suit/storage/jacket/marine/service, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),

		list("背包（选择1件）", 0, null, null, null),
		list("皮革挎包", 0, /obj/item/storage/backpack/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("技师胸挂", 0, /obj/item/storage/backpack/marine/satchel/tech, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("技师焊工-炸药包", 0, /obj/item/storage/backpack/marine/engineerpack/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("技师焊接包", 0, /obj/item/storage/backpack/marine/engineerpack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("焊接工具包", 0, /obj/item/tool/weldpack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),

		list("腰带（选择1）", 0, null, null, null),
		list("M277型构造平台", 0, /obj/item/storage/belt/utility/construction, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("工具腰带", 0, /obj/item/storage/belt/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋（任选2件）", 0, null, null, null),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工具袋（已满）", 0, /obj/item/storage/pouch/tools/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("建造袋", 0, /obj/item/storage/pouch/construction, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("电子袋（已满）", 0, /obj/item/storage/pouch/electronics/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("弹匣袋", 0, /obj/item/storage/pouch/magazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("侧臂袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("闪光弹袋（已满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("燃料箱绑带包", 0, /obj/item/storage/pouch/flamertank, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工程师工具包袋", 0, /obj/item/storage/pouch/engikit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("个人副武器（选择1）", 0, null, null, null),
		list("M4A3 制式手枪", 0, /obj/item/storage/belt/gun/m4a3/full, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),
		list("88式手枪", 0, /obj/item/storage/belt/gun/m4a3/mod88, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),
		list("M44左轮手枪", 0, /obj/item/storage/belt/gun/m44/mp, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),

		list("配件（任选其一）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小包（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("蛛网", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("小型工具织带（完整版）", 0, /obj/item/clothing/accessory/storage/tool_webbing/small/equipped, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("小型工具掉落袋（满）", 0, /obj/item/clothing/accessory/storage/tool_webbing/yellow_drop/small/equipped, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("部署装备", 0, null, null, null),

		list("战斗装备（全部拾取）", 0, null, null, null),
		list("军官部署装备", 0, list(/obj/item/clothing/gloves/marine/insulated/black, /obj/item/clothing/suit/storage/marine/CIC, /obj/item/device/binoculars/range/designator,), MARINE_CAN_BUY_COMBAT_ARMOR, VENDOR_ITEM_REGULAR),

		list("战斗头盔（选择1）", 0, null, null, null),
		list("M10军官头盔", 0, /obj/item/clothing/head/helmet/marine/MP/SO/basic, MARINE_CAN_BUY_COMBAT_HELMET, VENDOR_ITEM_REGULAR),
		list("M10技师头盔", 0, /obj/item/clothing/head/helmet/marine/tech, MARINE_CAN_BUY_COMBAT_HELMET, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("主要武器（选择1）", 0, null, null, null),
		list("M37A2 泵动式霰弹枪", 0, /obj/item/storage/box/guncase/pumpshotgun, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("M41A脉冲步枪MK2", 0, /obj/item/storage/box/guncase/m41a, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("M240 焚化装置", 0, /obj/item/storage/box/guncase/flamer, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),

		list("备用装备", 0, null, null, null),
		list("技师耳机", 15, /obj/item/device/radio/headset/almayer/mt, null, VENDOR_ITEM_REGULAR),
		list("合成重置密钥", 15, /obj/item/device/defibrillator/synthetic, null, VENDOR_ITEM_REGULAR),

	))


//------------ CHIEF REQ ---------------
GLOBAL_LIST_INIT(cm_vending_clothing_req_officer, list(

		list("标准装备（全部拾取）", 0, null, null, null),
		list("绝缘手套", 0, /obj/item/clothing/gloves/yellow, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("军需官制服", 0, /obj/item/clothing/under/rank/qm_suit, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("挎包", 0, /obj/item/storage/backpack/marine/satchel/tech, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("军需官夹克", 0, /obj/item/clothing/suit/storage/jacket/marine/RO, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),

		list("头部装备（选择1项）", 0, null, null, null),
		list("军需官帽", 0, /obj/item/clothing/head/cmcap/req/ro, MARINE_CAN_BUY_MASK, VENDOR_ITEM_RECOMMENDED),
		list("军需官贝雷帽", 0, /obj/item/clothing/head/beret/marine/ro, MARINE_CAN_BUY_MASK, VENDOR_ITEM_RECOMMENDED),
		list("征募上限", 0, /obj/item/clothing/head/cmcap/req, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("个人副武器（选择1）", 0, null, null, null),
		list("M4A3 制式手枪", 0, /obj/item/storage/belt/gun/m4a3/full, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),
		list("88式手枪", 0, /obj/item/storage/belt/gun/m4a3/mod88, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),
		list("M44定制左轮手枪", 0, /obj/item/storage/belt/gun/m44/custom, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),

		list("战斗装备（全部拾取）", 0, null, null, null),
		list("M3军官装甲", 0, /obj/item/clothing/suit/storage/marine/CIC, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("M10军官头盔", 0, /obj/item/clothing/head/helmet/marine/MP/SO/basic, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),
		list("海军陆战队员 战斗靴", 0, /obj/item/clothing/shoes/marine/knife, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_MANDATORY),

		list("小袋（任选2个）", 0, null, null, null),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工具袋（空）", 0, /obj/item/storage/pouch/tools, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("建造袋", 0, /obj/item/storage/pouch/construction, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("配件（任选其一）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("蛛网", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("备用装备", 0, null, null, null),
		list("橡皮图章", 10, /obj/item/tool/stamp/ro, null, VENDOR_ITEM_REGULAR),
	))


//------------ CHIEF MEDICAL OFFICER ---------------
GLOBAL_LIST_INIT(cm_vending_clothing_cmo, list(

		list("医疗套装（必备）", 0, null, null, null),
		list("基础医疗套装", 0, /obj/effect/essentials_set/medical/doctor/cmo, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("标准装备", 0, null, null, null),
		list("手套", 0, /obj/item/clothing/gloves/latex, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),

		list("眼镜（选择1款）", 0, null, null, null),
		list("综合医疗与试剂扫描仪HUD眼镜", 0, /obj/item/clothing/glasses/hud/health/science, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_MANDATORY),
		list("处方组合医疗与试剂扫描仪HUD眼镜", 0, /obj/item/clothing/glasses/hud/health/science/prescription, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_MANDATORY),

		list("制服（选择1件）", 0, null, null, null),
		list("首席医疗官制服", 0, /obj/item/clothing/under/rank/cmo, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_RECOMMENDED),
		list("首席医务官手术服", 0, /obj/item/clothing/under/rank/medical/cmo, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_RECOMMENDED),
		list("医生's Uniform", 0, /obj/item/clothing/under/rank/medical, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("医生's Scrubs", 0, /obj/item/clothing/under/rank/medical/blue, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("外科医生手术服", 0, /obj/item/clothing/under/rank/medical/green, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("制药医师手术服", 0, /obj/item/clothing/under/rank/medical/pharmacist, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("护士's Scrubs", 0, /obj/item/clothing/under/rank/medical/lightblue, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("紫色手术服", 0, /obj/item/clothing/under/rank/medical/purple, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("橄榄绿手术服", 0, /obj/item/clothing/under/rank/medical/olive, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("灰色手术服", 0, /obj/item/clothing/under/rank/medical/grey, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("棕色手术服", 0, /obj/item/clothing/under/rank/medical/brown, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("白色手术服", 0, /obj/item/clothing/under/rank/medical/white, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("停尸房工作服", 0, /obj/item/clothing/under/rank/medical/morgue, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),


		list("套装（选择1）", 0, null, null, null),
		list("首席医疗官实验服", 0, /obj/item/clothing/suit/storage/labcoat/cmo, MARINE_CAN_BUY_MRE, VENDOR_ITEM_RECOMMENDED),
		list("实验服", 0, /obj/item/clothing/suit/storage/labcoat, MARINE_CAN_BUY_MRE, VENDOR_ITEM_REGULAR),
		list("制药医师实验服", 0, /obj/item/clothing/suit/storage/labcoat/pharmacist, MARINE_CAN_BUY_MRE, VENDOR_ITEM_REGULAR),
		list("高开叉实验袍", 0, /obj/item/clothing/suit/storage/labcoat/short, MARINE_CAN_BUY_MRE, VENDOR_ITEM_REGULAR),
		list("低胸实验服", 0, /obj/item/clothing/suit/storage/labcoat/long, MARINE_CAN_BUY_MRE, VENDOR_ITEM_REGULAR),
		list("医疗区's Apron", 0, /obj/item/clothing/suit/chef/classic/medical, MARINE_CAN_BUY_MRE, VENDOR_ITEM_REGULAR),


		list("雪地装备（仅限雪地使用）", 0, null, null, null),
		list("雪衣", 0, /obj/item/clothing/suit/storage/snow_suit/doctor, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("巴拉克拉法帽", 0, /obj/item/clothing/mask/balaclava, MARINE_CAN_BUY_MASK, VENDOR_ITEM_MANDATORY),
		list("雪绒围巾", 0, /obj/item/clothing/mask/tornscarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_MANDATORY),

		list("头部装备（选择1件）", 0, null, null, null),
		list("首席医疗官的尖顶帽", 0, /obj/item/clothing/head/cmo, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("首席医疗官手术帽", 0, /obj/item/clothing/head/surgery/cmo, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("医生's Surgical Cap", 0, /obj/item/clothing/head/surgery/blue, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("外科医生手术帽", 0, /obj/item/clothing/head/surgery/green, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("制药医师手术帽", 0, /obj/item/clothing/head/surgery/pharmacist, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("护士's Surgical Cap", 0, /obj/item/clothing/head/surgery/lightblue, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("紫色手术帽", 0, /obj/item/clothing/head/surgery/purple, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("橄榄绿手术帽", 0, /obj/item/clothing/head/surgery/olive, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("灰色手术帽", 0, /obj/item/clothing/head/surgery/grey, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("棕色手术帽", 0, /obj/item/clothing/head/surgery/brown, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("白色手术帽", 0, /obj/item/clothing/head/surgery/white, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("太平间手术帽", 0, /obj/item/clothing/head/surgery/morgue, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("背包（选择1个）", 0, null, null, null),
		list("标准挎包", 0, /obj/item/storage/backpack/marine/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("标准背包", 0, /obj/item/storage/backpack/marine, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("医疗挎包", 0, /obj/item/storage/backpack/marine/satchel/medic, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("医疗背包", 0, /obj/item/storage/backpack/marine/medic, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),

		list("腰带（选择1）", 0, null, null, null),
		list("M276 救生包（满）", 0, /obj/item/storage/belt/medical/lifesaver/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 医疗存储装置（满载）", 0, /obj/item/storage/belt/medical/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),

		list("个人副武器（选择1）", 0, null, null, null),
		list("M4A3 制式手枪", 0, /obj/item/storage/belt/gun/m4a3/full, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),
		list("88式手枪", 0, /obj/item/storage/belt/gun/m4a3/mod88, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),
		list("M44左轮手枪", 0, /obj/item/storage/belt/gun/m44/mp, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),

		list("战斗装备（仅限战斗使用）", 0, null, null, null),
		list("M3军官装甲", 0, /obj/item/clothing/suit/storage/marine/CIC, MARINE_CAN_BUY_COMBAT_ARMOR, VENDOR_ITEM_MANDATORY),
		list("M10军官头盔", 0, /obj/item/clothing/head/helmet/marine/MP/SO, MARINE_CAN_BUY_COMBAT_HELMET, VENDOR_ITEM_MANDATORY),
		list("海军陆战队员 战斗靴", 0, /obj/item/clothing/shoes/marine/knife, MARINE_CAN_BUY_COMBAT_SHOES, VENDOR_ITEM_MANDATORY),

		list("小袋 (选择2个)", 0, null, null, null),
		list("自动注射器袋", 0, /obj/item/storage/pouch/autoinjector, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（可补充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（药丸包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救响应包", 0, /obj/item/storage/pouch/first_responder, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗包", 0, /obj/item/storage/pouch/medical, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("医疗包袋", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（碧卡利定）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/bicaridine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（凯洛坦）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/kelotane, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（复苏合剂 - 三氯哒嗪）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/revival_tricord, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（复苏合剂 - 佩里达松）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/revival_peri, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（三合剂）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/tricordrazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（野战麻醉剂）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/oxycodone, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（空）", 0, /obj/item/storage/pouch/pressurized_reagent_canister, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("配件（任选其一）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("备用装备", 0, null, null, null),
		list("医生's Headset", 15, /obj/item/device/radio/headset/almayer/doc, null, VENDOR_ITEM_REGULAR),
		list("研究员's Headset", 30, /obj/item/device/radio/headset/almayer/research, null, VENDOR_ITEM_REGULAR),
	))


/obj/effect/essentials_set/medical/doctor/cmo
	spawned_gear_list = list(
		/obj/item/device/defibrillator,
		/obj/item/storage/firstaid/adv,
		/obj/item/device/healthanalyzer,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/tool/surgery/synthgraft,
		/obj/item/device/flashlight/pen,
		/obj/item/clothing/accessory/stethoscope,
		/obj/item/storage/syringe_case,
	)



//------------ EXECUTIVE OFFFICER ---------------

//------------WEAPON VENDOR---------------
GLOBAL_LIST_INIT(cm_vending_gear_xo, list(
		list("舰长主要技能（选择1项）", 0, null, null, null),
		list("M41A MK1 脉冲步枪", 0, /obj/item/storage/box/guncase/m41aMK1AP, MARINE_CAN_BUY_KIT, VENDOR_ITEM_MANDATORY),
		list("MK221战术霰弹枪", 0, /obj/effect/essentials_set/xo/shotgunpreset, MARINE_CAN_BUY_KIT, VENDOR_ITEM_MANDATORY),

		list("主要弹药", 0, null, null, null),
		list("M41A MK1 弹匣", 40, /obj/item/ammo_magazine/rifle/m41aMK1, null, VENDOR_ITEM_RECOMMENDED),
		list("M41A MK1 AP 弹匣", 60, /obj/item/ammo_magazine/rifle/m41aMK1/ap, null, VENDOR_ITEM_RECOMMENDED),
		list("鹿弹霰弹", 20, /obj/item/ammo_magazine/shotgun/buckshot, null, VENDOR_ITEM_REGULAR),
		list("霰弹枪独头弹", 20, /obj/item/ammo_magazine/shotgun/slugs, null, VENDOR_ITEM_REGULAR),
		list("钢针霰弹", 20, /obj/item/ammo_magazine/shotgun/flechette, null, VENDOR_ITEM_REGULAR),

		list("专精套件（选择1项）", 0, null, null, null),
		list("必备工程师套装", 0, /obj/effect/essentials_set/engi, MARINE_CAN_BUY_SPECIALIZATION, VENDOR_ITEM_RECOMMENDED),
		list("基础医疗套装", 0, /obj/effect/essentials_set/medic, MARINE_CAN_BUY_SPECIALIZATION, VENDOR_ITEM_RECOMMENDED),

		list("爆炸物", 0, null, null, null),
		list("HEDP榴弹包", 15, /obj/item/storage/box/packet/high_explosive, null, VENDOR_ITEM_REGULAR),
		list("HEFA手榴弹包", 15, /obj/item/storage/box/packet/hefa, null, VENDOR_ITEM_REGULAR),
		list("WP 手榴弹包", 15, /obj/item/storage/box/packet/phosphorus, null, VENDOR_ITEM_REGULAR),

		list("轨道附件", 0, null, null, null),
		list("磁力束带", 12, /obj/item/attachable/magnetic_harness, null, VENDOR_ITEM_RECOMMENDED),
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
		list("延长后坐力补偿器", 15, /obj/item/attachable/extended_barrel/vented, null, VENDOR_ITEM_REGULAR),
		list("后坐力补偿器", 15, /obj/item/attachable/compensator, null, VENDOR_ITEM_REGULAR),
		list("M10补偿器", 15, /obj/item/attachable/compensator/m10, null, VENDOR_ITEM_REGULAR),
		list("抑制器", 15, /obj/item/attachable/suppressor, null, VENDOR_ITEM_REGULAR),
		list("抑制器，紧凑型", 15, /obj/item/attachable/suppressor/sleek, null, VENDOR_ITEM_REGULAR),

		list("其他S联合人民阵线谎言", 0, null, null, null),
		list("焊接面罩", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),
		list("绝缘手套", 3, /obj/item/clothing/gloves/yellow, null, VENDOR_ITEM_REGULAR),
		list("挖掘工具", 1, /obj/item/tool/shovel/etool, null, VENDOR_ITEM_REGULAR),
		list("磁力束缚装置", 12, /obj/item/attachable/magnetic_harness, null, VENDOR_ITEM_RECOMMENDED),
		list("无线电电话包", 15, /obj/item/storage/backpack/marine/satchel/rto, null, VENDOR_ITEM_RECOMMENDED),
		list("运动探测器", 5, /obj/item/device/motiondetector, null, VENDOR_ITEM_RECOMMENDED),
		list("砍刀刀鞘（完整）", 5, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("双筒望远镜", 5,/obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("测距仪", 8, /obj/item/device/binoculars/range, null,  VENDOR_ITEM_REGULAR),
		list("激光指示器", 12, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_RECOMMENDED),
		list("富尔顿回收装置", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("太空清洁工", 2, /obj/item/reagent_container/spray/cleaner, null, VENDOR_ITEM_REGULAR),
		list("手电筒", 1, /obj/item/device/flashlight, null, VENDOR_ITEM_REGULAR),
		list("合成重置密钥", 10, /obj/item/device/defibrillator/synthetic, null, VENDOR_ITEM_REGULAR),
	))

/obj/effect/essentials_set/xo/shotgunpreset
	spawned_gear_list = list(
		/obj/item/weapon/gun/shotgun/combat,
		/obj/item/ammo_magazine/shotgun/buckshot,
		/obj/item/ammo_magazine/shotgun/slugs,
	)

/obj/structure/machinery/cm_vending/gear/executive_officer
	name = "\improper 科马科技（殖民地海军陆战队科技） 执行官武器架"
	desc = "副指挥官的自动化武器架。精选了仅供舰船二把手使用的精良武器。"
	req_access = list(ACCESS_MARINE_SENIOR)
	vendor_role = list(JOB_XO)
	icon_state = "guns"
	use_snowflake_points = TRUE

/obj/structure/machinery/cm_vending/gear/executive_officer/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_xo

//------------UNIFORM/GEAR VENDOR---------------
GLOBAL_LIST_INIT(cm_vending_clothing_xo, list(
		list("战斗装备（全部拾取）", 0, null, null, null),
		list("M3军官装甲", 0, /obj/item/clothing/suit/storage/marine/CIC, MARINE_CAN_BUY_COMBAT_ARMOR, VENDOR_ITEM_MANDATORY),
		list("M10军官头盔", 0, /obj/item/clothing/head/helmet/marine/MP/SO, MARINE_CAN_BUY_COMBAT_HELMET, VENDOR_ITEM_MANDATORY),
		list("海军陆战队员 战斗靴", 0, /obj/item/clothing/shoes/marine/knife, MARINE_CAN_BUY_COMBAT_SHOES, VENDOR_ITEM_MANDATORY),
		list("海军陆战队员 战斗 手套", 0, /obj/item/clothing/gloves/marine, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),

		list("标准装备（全部拾取）", 0, null, null, null),
		list("挎包", 0, /obj/item/storage/backpack/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("单兵即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("战壕哨", 0, /obj/item/clothing/accessory/device/whistle/trench, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("制服（请选择一款）", 0, null, null, null),
		list("服务制服", 0, /obj/item/clothing/under/marine/officer/bridge, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_RECOMMENDED),
		list("作战制服", 0, /obj/item/clothing/under/marine/officer/boiler, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_RECOMMENDED),
		list("正式制服", 0, /obj/effect/essentials_set/xoformal, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_RECOMMENDED),

		list("个人武器（选择1）", 0, null, null, null),
		list("VP78 手枪", 0, /obj/item/storage/belt/gun/m4a3/vp78, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),
		list("M4A3 制式手枪", 0, /obj/item/storage/belt/gun/m4a3/commander, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),
		list("Mod 88 手枪", 0, /obj/item/storage/belt/gun/m4a3/mod88, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),
		list("M44左轮手枪", 0, /obj/item/storage/belt/gun/m44/mp, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_REGULAR),

		list("眼镜（选择1副）", 0, null, null, null),
		list("医疗HUD眼镜", 0, /obj/item/clothing/glasses/hud/health, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_RECOMMENDED),
		list("安全平视显示眼镜", 0, /obj/item/clothing/glasses/sunglasses/sechud, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
		list("比美克斯个人遮光镜", 0, /obj/item/clothing/glasses/sunglasses/big, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_RECOMMENDED),
		list("飞行员墨镜", 0, /obj/item/clothing/glasses/sunglasses/aviator, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),

		list("帽子（选择1顶）", 0, null, null, null),
		list("贝雷帽警官", 0, /obj/item/clothing/head/beret/marine/chiefofficer, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("服务帽", 0, /obj/item/clothing/head/marine/peaked/service, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("巡逻帽", 0, /obj/item/clothing/head/cmcap, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("卡普警官", 0, /obj/item/clothing/head/cmcap/bridge, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("补丁", 0, null, null, null),
		list("坠鹰肩章", 1, /obj/item/clothing/accessory/patch/falcon, null, VENDOR_ITEM_REGULAR),
		list("坠落猎鹰UA肩章", 1, /obj/item/clothing/accessory/patch/falconalt, null, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）大型胸章", 1, /obj/item/clothing/accessory/patch/uscmlarge, null, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）肩章", 1, /obj/item/clothing/accessory/patch, null, VENDOR_ITEM_REGULAR),
		list("联合美洲肩章", 1, /obj/item/clothing/accessory/patch/ua, null, VENDOR_ITEM_REGULAR),
		list("联合美洲国旗肩章", 1, /obj/item/clothing/accessory/patch/uasquare, null, VENDOR_ITEM_REGULAR),


		list("腰带（选择1）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276弹药装载装置", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276霰弹枪装弹装置", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 工具腰带装备（全套）", 0, /obj/item/storage/belt/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 枪套工具装备（完整版）", 0, /obj/item/storage/belt/gun/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 救生包（满）", 0, /obj/item/storage/belt/medical/lifesaver/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 医疗存储装置（满载）", 0, /obj/item/storage/belt/medical/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M39 手枪套装备", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M82F 枪套装备", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M40 榴弹携行具", 0, /obj/item/storage/belt/grenade, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("宪兵腰带", 0, /obj/item/storage/belt/security/MP/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),

		list("小袋（任选2件）", 0, null, null, null),
		list("自动注射器袋", 0, /obj/item/storage/pouch/autoinjector/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("大型弹匣袋", 0, /obj/item/storage/pouch/magazine/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("大型霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗袋", 0, /obj/item/storage/pouch/medical, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗包袋", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("手枪袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工具袋（满）", 0, /obj/item/storage/pouch/tools/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("建造袋", 0, /obj/item/storage/pouch/construction, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("电子钱包（已满）", 0, /obj/item/storage/pouch/electronics/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("闪光弹包（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("燃料箱绑带袋", 0, /obj/item/storage/pouch/flamertank, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("配件（任选1件）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	))



//------------ AUXILIARY SUPPORT OFFICER ---------------
GLOBAL_LIST_INIT(cm_vending_clothing_auxiliary_officer, list(

		list("标准装备（全部拾取）", 0, null, null, null),
		list("绝缘手套", 0, /obj/item/clothing/gloves/yellow, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("军官制服", 0, /obj/item/clothing/under/marine/officer/bridge, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("辅助支援官夹克", 0, /obj/item/clothing/suit/storage/jacket/marine/service/aso, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),

		list("背包（选择1个）", 0, null, null, null),
		list("USCM（殖民地海军陆战队）技术员胸挂", 0, /obj/item/storage/backpack/marine/satchel/tech, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("皮革挎包", 0, /obj/item/storage/backpack/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),

		list("个人副武器（选择1）", 0, null, null, null),
		list("M4A3 制式手枪", 0, /obj/item/storage/belt/gun/m4a3/full, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),
		list("88式手枪", 0, /obj/item/storage/belt/gun/m4a3/mod88, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),
		list("M44定制左轮手枪", 0, /obj/item/storage/belt/gun/m44/custom, MARINE_CAN_BUY_SECONDARY, VENDOR_ITEM_RECOMMENDED),

		list("帽子（选择1顶）", 0, null, null, null),
		list("贝雷帽，绿色", 0, /obj/item/clothing/head/beret/cm, MARINE_CAN_BUY_MASK, VENDOR_ITEM_RECOMMENDED),
		list("贝雷帽，棕褐色", 0, /obj/item/clothing/head/beret/cm/tan, MARINE_CAN_BUY_MASK, VENDOR_ITEM_RECOMMENDED),
		list("巡逻帽", 0, /obj/item/clothing/head/cmcap, MARINE_CAN_BUY_MASK, VENDOR_ITEM_RECOMMENDED),
		list("卡普警官", 0, /obj/item/clothing/head/cmcap/bridge, MARINE_CAN_BUY_MASK, VENDOR_ITEM_RECOMMENDED),
		list("服务帽", 0, /obj/item/clothing/head/marine/peaked/service, MARINE_CAN_BUY_MASK, VENDOR_ITEM_RECOMMENDED),

		list("战斗装备（全部拾取）", 0, null, null, null),
		list("M3军官装甲", 0, /obj/item/clothing/suit/storage/marine/CIC, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("M10军官头盔", 0, /obj/item/clothing/head/helmet/marine/MP/SO, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),
		list("海军陆战队员 战斗靴", 0, /obj/item/clothing/shoes/marine/knife, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_MANDATORY),

		list("小袋（任选2个）", 0, null, null, null),
		list("文件袋", 0, /obj/item/storage/pouch/document, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（可补充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工具袋（空）", 0, /obj/item/storage/pouch/tools, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("建造袋", 0, /obj/item/storage/pouch/construction, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("配件（任选其一）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("蛛网", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	))

/obj/effect/essentials_set/chiefmilitarypolice
	spawned_gear_list = list(
		/obj/item/clothing/glasses/sunglasses/sechud,
		/obj/item/storage/belt/security/MP/full,
		/obj/item/clothing/head/helmet/marine/MP/WO,
	)

/obj/effect/essentials_set/xoformal
	spawned_gear_list = list(
		/obj/item/clothing/suit/storage/jacket/marine/dress,
		/obj/item/clothing/head/marine/peaked,
		/obj/item/clothing/under/marine/dress,
	)
