/obj/structure/machinery/cm_vending/clothing/medical_crew
	name = "\improper 殖民地海军陆战队科技（ColMarTech）医疗设备架"
	desc = "医疗部的自动化装备供应商。"
	req_access = list(ACCESS_MARINE_MEDBAY)
	vendor_role = list(JOB_DOCTOR,JOB_FIELD_DOCTOR,JOB_NURSE,JOB_RESEARCHER,JOB_CMO)
	icon_state = "dress"

/obj/structure/machinery/cm_vending/clothing/medical_crew/get_listed_products(mob/user)
	if(!user)
		var/list/combined = list()
		combined += GLOB.cm_vending_clothing_nurse
		combined += GLOB.cm_vending_clothing_researcher
		combined += GLOB.cm_vending_clothing_cmo
		combined += GLOB.cm_vending_clothing_doctor
		return combined
	if(user.job == JOB_NURSE)
		return GLOB.cm_vending_clothing_nurse
	else if(user.job == JOB_RESEARCHER)
		return GLOB.cm_vending_clothing_researcher
	else if(user.job == JOB_CMO)
		///defined in senior_officers.dm
		return GLOB.cm_vending_clothing_cmo
	else if(user.job == JOB_DOCTOR || user.job == JOB_FIELD_DOCTOR)
		return GLOB.cm_vending_clothing_doctor
	return ..()



//------------ DOCTOR ---------------
GLOBAL_LIST_INIT(cm_vending_clothing_doctor, list(

		list("医疗套装（必备）", 0, null, null, null),
		list("必备医疗套装", 0, /obj/effect/essentials_set/medical/doctor, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("标准装备", 0, null, null, null),
		list("手套", 0, /obj/item/clothing/gloves/latex, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),

		list("眼镜（选择1款）", 0, null, null, null),
		list("医疗HUD眼镜", 0, /obj/item/clothing/glasses/hud/health, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_MANDATORY),
		list("处方医疗HUD眼镜", 0, /obj/item/clothing/glasses/hud/health/prescription, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_MANDATORY),

		list("制服（选择1件）", 0, null, null, null),
		list("医生's Scrubs", 0, /obj/item/clothing/under/rank/medical/blue, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_RECOMMENDED),
		list("外科医生手术服", 0, /obj/item/clothing/under/rank/medical/green, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_RECOMMENDED),
		list("医药医师手术服", 0, /obj/item/clothing/under/rank/medical/pharmacist, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_RECOMMENDED),
		list("护士's Scrubs", 0, /obj/item/clothing/under/rank/medical/lightblue, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("紫色手术服", 0, /obj/item/clothing/under/rank/medical/purple, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("橄榄绿手术服", 0, /obj/item/clothing/under/rank/medical/olive, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("灰色手术服", 0, /obj/item/clothing/under/rank/medical/grey, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("棕色手术服", 0, /obj/item/clothing/under/rank/medical/brown, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("白色手术服", 0, /obj/item/clothing/under/rank/medical/white, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("停尸房工作服", 0, /obj/item/clothing/under/rank/medical/morgue, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),


		list("套装（选择1）", 0, null, null, null),
		list("实验服", 0, /obj/item/clothing/suit/storage/labcoat, MARINE_CAN_BUY_MRE, VENDOR_ITEM_RECOMMENDED),
		list("制药医师实验服", 0, /obj/item/clothing/suit/storage/labcoat/pharmacist, MARINE_CAN_BUY_MRE, VENDOR_ITEM_RECOMMENDED),
		list("高开衩实验服", 0, /obj/item/clothing/suit/storage/labcoat/short, MARINE_CAN_BUY_MRE, VENDOR_ITEM_REGULAR),
		list("低领实验服", 0, /obj/item/clothing/suit/storage/labcoat/long, MARINE_CAN_BUY_MRE, VENDOR_ITEM_REGULAR),
		list("医疗区's Apron", 0, /obj/item/clothing/suit/chef/classic/medical, MARINE_CAN_BUY_MRE, VENDOR_ITEM_REGULAR),

		list("雪地装备（仅限雪地使用）", 0, null, null, null),
		list("雪衣", 0, /obj/item/clothing/suit/storage/snow_suit/doctor, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("巴拉克拉法帽", 0, /obj/item/clothing/mask/balaclava, MARINE_CAN_BUY_MASK, VENDOR_ITEM_MANDATORY),
		list("雪绒围巾", 0, /obj/item/clothing/mask/tornscarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_MANDATORY),

		list("头部装备（选择1件）", 0, null, null, null),
		list("医生's Surgical Cap", 0, /obj/item/clothing/head/surgery/blue, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("外科医生手术帽", 0, /obj/item/clothing/head/surgery/green, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("制药医师手术帽", 0, /obj/item/clothing/head/surgery/pharmacist, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("护士's Surgical Cap", 0, /obj/item/clothing/head/surgery/lightblue, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("紫色手术帽", 0, /obj/item/clothing/head/surgery/purple, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("橄榄绿手术帽", 0, /obj/item/clothing/head/surgery/olive, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("灰色手术帽", 0, /obj/item/clothing/head/surgery/grey, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("棕色手术帽", 0, /obj/item/clothing/head/surgery/brown, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("白色手术帽", 0, /obj/item/clothing/head/surgery/white, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("太平间手术帽", 0, /obj/item/clothing/head/surgery/morgue, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("背包（选择1）", 0, null, null, null),
		list("标准挎包", 0, /obj/item/storage/backpack/marine/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("标准背包", 0, /obj/item/storage/backpack/marine, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("医疗挎包", 0, /obj/item/storage/backpack/marine/satchel/medic, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("医疗背包", 0, /obj/item/storage/backpack/marine/medic, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),

		list("腰带（选择1）", 0, null, null, null),
		list("M276 救生包（满）", 0, /obj/item/storage/belt/medical/lifesaver/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 医疗存储装置（满载）", 0, /obj/item/storage/belt/medical/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),

		list("小袋（任选2种）", 0, null, null, null),
		list("自动注射器袋", 0, /obj/item/storage/pouch/autoinjector, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（可补充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（药丸包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救人员随身包", 0, /obj/item/storage/pouch/first_responder, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗包", 0, /obj/item/storage/pouch/medical, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("医疗包袋", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("化学袋", 0, /obj/item/storage/pouch/chem, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（碧卡利定）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/bicaridine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（凯洛坦）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/kelotane, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（复苏合剂 - 三氯二嗪）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/revival_tricord, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（复苏混合剂 - 佩里达松）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/revival_peri, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（三合剂）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/tricordrazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（野战麻醉剂）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/oxycodone, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（空）", 0, /obj/item/storage/pouch/pressurized_reagent_canister, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("配件（任选其一）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小袋（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	))

//------------ NURSE ---------------
GLOBAL_LIST_INIT(cm_vending_clothing_nurse, list(

		list("医疗套装（必备）", 0, null, null, null),
		list("必备医疗套装", 0, /obj/effect/essentials_set/medical, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("标准装备", 0, null, null, null),
		list("手套", 0, /obj/item/clothing/gloves/latex, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),

		list("眼镜（选择1副）", 0, null, null, null),
		list("医疗HUD眼镜", 0, /obj/item/clothing/glasses/hud/health, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_MANDATORY),
		list("处方医疗HUD眼镜", 0, /obj/item/clothing/glasses/hud/health/prescription, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_MANDATORY),

		list("制服（选择1件）", 0, null, null, null),
		list("护士's Scrubs", 0, /obj/item/clothing/under/rank/medical/lightblue, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_RECOMMENDED),
		list("医生's Scrubs", 0, /obj/item/clothing/under/rank/medical/blue, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("外科医生手术服", 0, /obj/item/clothing/under/rank/medical/green, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("制药医师手术服", 0, /obj/item/clothing/under/rank/medical/pharmacist, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("紫色手术服", 0, /obj/item/clothing/under/rank/medical/purple, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("橄榄绿手术服", 0, /obj/item/clothing/under/rank/medical/olive, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("灰色手术服", 0, /obj/item/clothing/under/rank/medical/grey, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("棕色手术服", 0, /obj/item/clothing/under/rank/medical/brown, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("白色手术服", 0, /obj/item/clothing/under/rank/medical/white, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("停尸房工作服", 0, /obj/item/clothing/under/rank/medical/morgue, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),

		list("套装（选择1）", 0, null, null, null),
		list("医疗区's Apron", 0, /obj/item/clothing/suit/chef/classic/medical, MARINE_CAN_BUY_MRE, VENDOR_ITEM_REGULAR),

		list("雪地装备（仅限雪地使用）", 0, null, null, null),
		list("雪衣", 0, /obj/item/clothing/suit/storage/snow_suit/doctor, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("巴拉克拉法帽", 0, /obj/item/clothing/mask/balaclava, MARINE_CAN_BUY_MASK, VENDOR_ITEM_MANDATORY),
		list("雪地围巾", 0, /obj/item/clothing/mask/tornscarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_MANDATORY),

		list("头部装备（选择1件）", 0, null, null, null),
		list("护士's Surgical Cap", 0, /obj/item/clothing/head/surgery/lightblue, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("医生's Surgical Cap", 0, /obj/item/clothing/head/surgery/blue, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("外科医生手术帽", 0, /obj/item/clothing/head/surgery/green, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("制药医师手术帽", 0, /obj/item/clothing/head/surgery/pharmacist, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
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

		list("小袋（任选2个）", 0, null, null, null),
		list("自动注射器袋", 0, /obj/item/storage/pouch/autoinjector, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救人员随身包", 0, /obj/item/storage/pouch/first_responder, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗袋", 0, /obj/item/storage/pouch/medical, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("医疗包袋", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("化学袋", 0, /obj/item/storage/pouch/chem, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（碧卡利定）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/bicaridine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（凯洛坦）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/kelotane, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（复苏合剂 - 三氯拉嗪）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/revival_tricord, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（复苏合剂 - 佩里达松）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/revival_peri, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（三合剂）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/tricordrazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（野战麻醉剂）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/oxycodone, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（空）", 0, /obj/item/storage/pouch/pressurized_reagent_canister, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("配件（任选其一）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	))

//------------ RESEARCHER ---------------
GLOBAL_LIST_INIT(cm_vending_clothing_researcher, list(

		list("医疗套装（必备）", 0, null, null, null),
		list("必备医疗套装", 0, /obj/effect/essentials_set/medical/doctor, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("标准装备", 0, null, null, null),
		list("手套", 0, /obj/item/clothing/gloves/latex, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),

		list("眼镜（选择1副）", 0, null, null, null),
		list("医疗HUD眼镜", 0, /obj/item/clothing/glasses/hud/health, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_RECOMMENDED),
		list("处方医疗HUD眼镜", 0, /obj/item/clothing/glasses/hud/health/prescription, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_RECOMMENDED),
		list("试剂 扫描仪 HUD 护目镜", 0, /obj/item/clothing/glasses/science, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_MANDATORY),
		list("处方 试剂 扫描仪 抬头显示器 护目镜", 0, /obj/item/clothing/glasses/science/prescription, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_MANDATORY),

		list("制服（选择1件）", 0, null, null, null),
		list("研究员制服", 0, /obj/item/clothing/under/marine/officer/researcher, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("医生's Scrubs", 0, /obj/item/clothing/under/rank/medical/blue, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("外科医生手术服", 0, /obj/item/clothing/under/rank/medical/green, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("医药医师手术服", 0, /obj/item/clothing/under/rank/medical/pharmacist, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("护士's Scrubs", 0, /obj/item/clothing/under/rank/medical/lightblue, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("紫色手术服", 0, /obj/item/clothing/under/rank/medical/purple, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("橄榄绿手术服", 0, /obj/item/clothing/under/rank/medical/olive, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("灰色手术服", 0, /obj/item/clothing/under/rank/medical/grey, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("棕色手术服", 0, /obj/item/clothing/under/rank/medical/brown, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("白色手术服", 0, /obj/item/clothing/under/rank/medical/white, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("停尸房工作服", 0, /obj/item/clothing/under/rank/medical/morgue, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),

		list("套装（选择1）", 0, null, null, null),
		list("实验服", 0, /obj/item/clothing/suit/storage/labcoat/researcher, MARINE_CAN_BUY_MRE, VENDOR_ITEM_RECOMMENDED),

		list("雪地装备（仅限雪地使用）", 0, null, null, null),
		list("雪衣", 0, /obj/item/clothing/suit/storage/snow_suit/doctor, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("巴拉克拉法帽", 0, /obj/item/clothing/mask/balaclava, MARINE_CAN_BUY_MASK, VENDOR_ITEM_MANDATORY),
		list("雪绒围巾", 0, /obj/item/clothing/mask/tornscarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_MANDATORY),

		list("头部装备（选择1件）", 0, null, null, null),
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

		list("小袋（任选2件）", 0, null, null, null),
		list("药剂袋", 0, /obj/item/storage/pouch/vials, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_MANDATORY),
		list("化学袋", 0, /obj/item/storage/pouch/chem, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_MANDATORY),
		list("自动注射器袋", 0, /obj/item/storage/pouch/autoinjector, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救员腰包", 0, /obj/item/storage/pouch/first_responder, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("医疗袋", 0, /obj/item/storage/pouch/medical, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗包袋", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（碧卡利定）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/bicaridine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（凯洛坦）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/kelotane, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（复苏合剂 - 三氯二嗪）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/revival_tricord, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（复苏合剂 - 佩里达克松）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/revival_peri, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（三合剂）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/tricordrazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（野战麻醉剂）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/oxycodone, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（空）", 0, /obj/item/storage/pouch/pressurized_reagent_canister, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("配件（任选其一）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	))

/obj/effect/essentials_set/medical
	spawned_gear_list = list(
		/obj/item/device/defibrillator,
		/obj/item/storage/firstaid/adv,
		/obj/item/device/healthanalyzer,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/tool/surgery/synthgraft,
		/obj/item/storage/syringe_case,
		/obj/item/storage/surgical_case/regular,
		/obj/item/clothing/accessory/stethoscope,
		/obj/item/device/flashlight/pen,
	)

/obj/effect/essentials_set/medical/doctor
	spawned_gear_list = list(
		/obj/item/device/defibrillator,
		/obj/item/storage/firstaid/adv,
		/obj/item/device/healthanalyzer,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/tool/surgery/synthgraft,
		/obj/item/clothing/accessory/stethoscope,
		/obj/item/device/flashlight/pen,
		/obj/item/storage/syringe_case,
	)
