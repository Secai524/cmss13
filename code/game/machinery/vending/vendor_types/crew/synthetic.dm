//------------GEAR VENDOR---------------

/obj/structure/machinery/cm_vending/gear/synth
	name = "\improper 殖民地海军陆战队科技 合成辅助装备架"
	desc = "一个连接着海量各类医疗和工程物资存储库的自动化装备架。仅限合成人单位访问。"
	icon_state = "gear"
	req_access = list(ACCESS_MARINE_SYNTH)
	vendor_role = list(JOB_SYNTH, JOB_SYNTH_SURVIVOR, JOB_UPP_SUPPORT_SYNTH, JOB_CMB_SYN, JOB_CMB_RSYN, JOB_PMC_SYNTH)

	listed_products = list(
		list("工程师S联合人民阵线谎言", 0, null, null, null),
		list("气闸电路板", 2, /obj/item/circuitboard/airlock, null, VENDOR_ITEM_REGULAR),
		list("APC电路板", 2, /obj/item/circuitboard/apc, null, VENDOR_ITEM_REGULAR),
		list("挖掘工具", 2, /obj/item/tool/shovel/etool, null, VENDOR_ITEM_REGULAR),
		list("高容量动力电池", 3, /obj/item/cell/high, null, VENDOR_ITEM_REGULAR),
		list("灯泡更换器", 2, /obj/item/device/lightreplacer, null, VENDOR_ITEM_REGULAR),
		list("金属 x10", 5, /obj/item/stack/sheet/metal/small_stack, null, VENDOR_ITEM_REGULAR),
		list("多功能工具", 4, /obj/item/device/multitool, null, VENDOR_ITEM_REGULAR),
		list("塑钢 x10", 7, /obj/item/stack/sheet/plasteel/small_stack, null, VENDOR_ITEM_REGULAR),
		list("沙袋 x25", 10, /obj/item/stack/sandbags_empty/half, null, VENDOR_ITEM_REGULAR),
		list("塑胶炸药", 3, /obj/item/explosive/plastic, null, VENDOR_ITEM_REGULAR),
		list("ES-11 移动燃料罐", 4, /obj/item/tool/weldpack/minitank, null, VENDOR_ITEM_REGULAR),
		list("工程师套件", 1, /obj/item/storage/toolkit/empty, null, VENDOR_ITEM_REGULAR),
		list("战术撬棍", 5, /obj/item/tool/crowbar/tactical, null, VENDOR_ITEM_REGULAR),

		list("急救包", 0, null, null, null),
		list("高级急救箱", 12, /obj/item/storage/firstaid/adv, null, VENDOR_ITEM_REGULAR),
		list("急救箱", 5, /obj/item/storage/firstaid/regular, null, VENDOR_ITEM_REGULAR),
		list("消防急救箱", 6, /obj/item/storage/firstaid/fire, null, VENDOR_ITEM_REGULAR),
		list("毒素急救包", 6, /obj/item/storage/firstaid/toxin, null, VENDOR_ITEM_REGULAR),
		list("氧气急救包", 6, /obj/item/storage/firstaid/o2, null, VENDOR_ITEM_REGULAR),
		list("辐射急救包", 6, /obj/item/storage/firstaid/rad, null, VENDOR_ITEM_REGULAR),

		list("MEDICAL S联合人民阵线谎言", 0, null, null, null),
		list("烧伤急救包", 2, /obj/item/stack/medical/advanced/ointment, null, VENDOR_ITEM_REGULAR),
		list("创伤急救包", 2, /obj/item/stack/medical/advanced/bruise_pack, null, VENDOR_ITEM_REGULAR),
		list("医疗后送床", 6, /obj/item/roller/medevac, null, VENDOR_ITEM_REGULAR),
		list("医疗夹板", 1, /obj/item/stack/medical/splint, null, VENDOR_ITEM_REGULAR),
		list("滚筒床", 4, /obj/item/roller, null, VENDOR_ITEM_REGULAR),
		list("停滞袋", 6, /obj/item/bodybag/cryobag, null, VENDOR_ITEM_REGULAR),
		list("MS-11 智能补给坦克", 6, /obj/item/reagent_container/glass/minitank, null, VENDOR_ITEM_REGULAR),
		list("血液", 5, /obj/item/reagent_container/blood/OMinus, null, VENDOR_ITEM_REGULAR),
		list("手术床", 10, /obj/structure/bed/portable_surgery, null, VENDOR_ITEM_REGULAR),

		list("药瓶（比卡瑞丁）", 5, /obj/item/storage/pill_bottle/bicaridine, null, VENDOR_ITEM_RECOMMENDED),
		list("药瓶（德克萨林）", 5, /obj/item/storage/pill_bottle/dexalin, null, VENDOR_ITEM_REGULAR),
		list("药瓶（地洛芬）", 5, /obj/item/storage/pill_bottle/antitox, null, VENDOR_ITEM_REGULAR),
		list("药瓶（伊那普洛林）", 5, /obj/item/storage/pill_bottle/inaprovaline, null, VENDOR_ITEM_REGULAR),
		list("药瓶（凯洛坦）", 5, /obj/item/storage/pill_bottle/kelotane, null, VENDOR_ITEM_RECOMMENDED),
		list("药瓶（佩里达松）", 5, /obj/item/storage/pill_bottle/peridaxon, null, VENDOR_ITEM_REGULAR),
		list("药瓶（曲马多）", 5, /obj/item/storage/pill_bottle/tramadol, null, VENDOR_ITEM_RECOMMENDED),

		list("自动注射器（比卡瑞丁）", 1, /obj/item/reagent_container/hypospray/autoinjector/bicaridine, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（地塞林+）", 1, /obj/item/reagent_container/hypospray/autoinjector/dexalinp, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（地洛文）", 1, /obj/item/reagent_container/hypospray/autoinjector/antitoxin, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（肾上腺素）", 2, /obj/item/reagent_container/hypospray/autoinjector/adrenaline, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（伊纳普洛林）", 1, /obj/item/reagent_container/hypospray/autoinjector/inaprovaline, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（凯洛坦）", 1, /obj/item/reagent_container/hypospray/autoinjector/kelotane, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（羟考酮）", 1, /obj/item/reagent_container/hypospray/autoinjector/oxycodone, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（佩里达松）", 1, /obj/item/reagent_container/hypospray/autoinjector/peridaxon, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（曲马多）", 1, /obj/item/reagent_container/hypospray/autoinjector/tramadol, null, VENDOR_ITEM_REGULAR),
		list("自动注射器（三氯拉嗪）", 1, /obj/item/reagent_container/hypospray/autoinjector/tricord, null, VENDOR_ITEM_REGULAR),

		list("15u 定制自动注射器（空）", 1, /obj/item/reagent_container/hypospray/autoinjector/empty/small, null, VENDOR_ITEM_REGULAR),
		list("30u 定制自动注射器（空）", 2, /obj/item/reagent_container/hypospray/autoinjector/empty/medium, null, VENDOR_ITEM_REGULAR),
		list("60u定制自动注射器（空）", 4, /obj/item/reagent_container/hypospray/autoinjector/empty/large, null, VENDOR_ITEM_REGULAR),

		list("紧急除颤器", 4, /obj/item/device/defibrillator, null, VENDOR_ITEM_MANDATORY),
		list("健康分析仪", 4, /obj/item/device/healthanalyzer, null, VENDOR_ITEM_REGULAR),
		list("手术线", 4, /obj/item/tool/surgery/surgical_line, null, VENDOR_ITEM_REGULAR),
		list("合成体移植", 4, /obj/item/tool/surgery/synthgraft, null, VENDOR_ITEM_REGULAR),

		list("其他S联合人民阵线谎言", 0, null, null, null),
		list("双筒望远镜", 5,/obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("测距仪", 8, /obj/item/device/binoculars/range, null,  VENDOR_ITEM_REGULAR),
		list("激光指示器", 12, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_RECOMMENDED),
		list("数据探测器", 5, /obj/item/device/motiondetector/intel, null, VENDOR_ITEM_REGULAR),
		list("手电筒", 1, /obj/item/device/flashlight, null, VENDOR_ITEM_RECOMMENDED),
		list("富尔顿回收装置", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("运动探测器", 5, /obj/item/device/motiondetector, null, VENDOR_ITEM_REGULAR),
		list("太空清洁工", 2, /obj/item/reagent_container/spray/cleaner, null, VENDOR_ITEM_REGULAR),
		list("哨声", 5, /obj/item/clothing/accessory/device/whistle, null, VENDOR_ITEM_REGULAR),
		list("砍刀刀鞘（完整）", 2, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("听诊器", 2, /obj/item/clothing/accessory/stethoscope, null, VENDOR_ITEM_REGULAR),
		list("手电筒", 2, /obj/item/device/flashlight/pen, null, VENDOR_ITEM_REGULAR)
	)

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_synth, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("实验性工具供应商令牌", 0, /obj/item/coin/marine/synth, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),
		list("合成重置密钥", 0, /obj/item/device/defibrillator/synthetic, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("耳机", 0, /obj/item/device/radio/headset/almayer/mcom/synth, MARINE_CAN_BUY_EAR, VENDOR_ITEM_MANDATORY),

		list("制服（选择1件）", 0, null, null, null),
		list("USCM（殖民地海军陆战队）标准制服", 0, /obj/item/clothing/under/marine, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),

		list("织带（选择1项）", 0, null, null, null),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("腿部挂包", 0, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("腿部小袋（黑色）", 0, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("织带", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色水滴袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("鞋子（选择1）", 0, null, null, null),
		list("靴子", 0, /obj/item/clothing/shoes/marine/knife, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_REGULAR),
		list("鞋子，白色", 0, /obj/item/clothing/shoes/white, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_RECOMMENDED),

		list("套装（选择1）", 0, null, null, null),
		list("M3A1型合成材料多功能背心（任务专用迷彩）", 0, /obj/item/clothing/suit/storage/marine/light/synvest, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),
		list("M3A1型合成材料多功能背心（UA灰色）", 0, /obj/item/clothing/suit/storage/marine/light/synvest/grey, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("M3A1型合成多功能背心（UA深灰色）", 0, /obj/item/clothing/suit/storage/marine/light/synvest/dgrey, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("M3A1型合成材料通用背心（丛林迷彩版）", 0, /obj/item/clothing/suit/storage/marine/light/synvest/jungle, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("M3A1型合成多功能背心（雪地迷彩）", 0, /obj/item/clothing/suit/storage/marine/light/synvest/snow, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("M3A1型合成材料通用背心（UA沙漠色）", 0, /obj/item/clothing/suit/storage/marine/light/synvest/desert, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),

		list("手套（选择1）", 0, null, null, null),
		list("绝缘手套", 0, /obj/item/clothing/gloves/yellow, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_RECOMMENDED),
		list("黑手套", 0, /obj/item/clothing/gloves/black, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_REGULAR),
		list("乳胶手套", 0, /obj/item/clothing/gloves/latex, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_REGULAR),

		list("背包（选择1）", 0, null, null, null),
		list("S-V42智能背包，蓝色", 0, /obj/item/storage/backpack/marine/smartpack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("S-V42智能包，绿色", 0, /obj/item/storage/backpack/marine/smartpack/green, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("S-V42 智能背包，棕褐色", 0, /obj/item/storage/backpack/marine/smartpack/tan, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("S-V42 智能包装，白色", 0, /obj/item/storage/backpack/marine/smartpack/white, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("S-V42 智能背包，黑色", 0, /obj/item/storage/backpack/marine/smartpack/black, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("S-V42A1 智能背包，蓝色", 0, /obj/item/storage/backpack/marine/smartpack/a1, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("S-V42A1 智能包，绿色", 0, /obj/item/storage/backpack/marine/smartpack/a1/green, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("S-V42A1智能背包，棕褐色", 0, /obj/item/storage/backpack/marine/smartpack/a1/tan, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("S-V42A1 智能背包，黑色", 0, /obj/item/storage/backpack/marine/smartpack/a1/black, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("S-V42A1 智能包装，白色", 0, /obj/item/storage/backpack/marine/smartpack/a1/white, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),

		list("腰带（选择1）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 救生包", 0, /obj/item/storage/belt/medical/lifesaver/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 医疗存储腰带", 0, /obj/item/storage/belt/medical/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 工具腰带装备（全套）", 0, /obj/item/storage/belt/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋（任选2个）", 0, null, null, null),
		list("自动注射器袋", 0, /obj/item/storage/pouch/autoinjector, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("建造袋", 0, /obj/item/storage/pouch/construction, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("文件袋", 0, /obj/item/storage/pouch/document, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("电子钱包（已满）", 0, /obj/item/storage/pouch/electronics/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（可补充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救包（药丸包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("急救人员随身包", 0, /obj/item/storage/pouch/first_responder, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("闪光弹包（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗袋", 0, /obj/item/storage/pouch/medical, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("医疗包袋", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("加压试剂罐包（碧卡利定）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/bicaridine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("加压试剂罐包（凯洛坦）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/kelotane, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("加压试剂罐袋（复苏合剂 - 三氯达嗪）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/revival_tricord, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("加压试剂罐袋（复苏混合剂 - 佩里达松）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/revival_peri, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐包（三合剂）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/tricordrazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("加压试剂罐包（野战麻醉剂）", 0, /obj/item/storage/pouch/pressurized_reagent_canister/oxycodone, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("加压试剂罐袋（空）", 0, /obj/item/storage/pouch/pressurized_reagent_canister, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工具袋（满）", 0, /obj/item/storage/pouch/tools/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("砍刀袋（已满）", 0, /obj/item/storage/pouch/machete/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("面具", 0, null, null, null),
		list("无菌口罩", 0, /obj/item/clothing/mask/surgical, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR)
	))

/obj/structure/machinery/cm_vending/clothing/synth
	name = "\improper 殖民地海军陆战队科技合成装备架"
	desc = "一个连接着海量各类装备存储库的自动化装备架。仅限合成人单位访问。"
	req_access = list(ACCESS_MARINE_SYNTH)
	vendor_role = list(JOB_SYNTH, JOB_SYNTH_SURVIVOR, JOB_UPP_SUPPORT_SYNTH, JOB_CMB_SYN, JOB_CMB_RSYN, JOB_PMC_SYNTH)

/obj/structure/machinery/cm_vending/clothing/synth/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_synth

//------------SNOWFLAKE VENDOR---------------

/datum/gear/synthetic
	category = "其他"
	allowed_roles = list(JOB_SYNTH)

	fluff_cost = 0
	loadout_cost = 12

/datum/gear/synthetic/uscm
	category = "USCM Uniforms"

/datum/gear/synthetic/uscm/medical_blue
	path = /obj/item/clothing/under/rank/medical/blue

/datum/gear/synthetic/uscm/medical_lightblue
	path = /obj/item/clothing/under/rank/medical/lightblue

/datum/gear/synthetic/uscm/medical_green
	path = /obj/item/clothing/under/rank/medical/green

/datum/gear/synthetic/uscm/medical_purple
	path = /obj/item/clothing/under/rank/medical/purple

/datum/gear/synthetic/uscm/medical_olive
	path = /obj/item/clothing/under/rank/medical/olive

/datum/gear/synthetic/uscm/medical_grey
	path = /obj/item/clothing/under/rank/medical/grey

/datum/gear/synthetic/uscm/medical_white
	path = /obj/item/clothing/under/rank/medical/white

/datum/gear/synthetic/uscm/medical_black
	path = /obj/item/clothing/under/rank/medical/morgue

/datum/gear/synthetic/uscm/medical_pharmacist
	path = /obj/item/clothing/under/rank/medical/pharmacist

/datum/gear/synthetic/uscm/standard_synth
	path = /obj/item/clothing/under/rank/synthetic

/datum/gear/synthetic/uscm/standard_synth_old
	path = /obj/item/clothing/under/rank/synthetic/old

/datum/gear/synthetic/uscm/marine_jungle
	path = /obj/item/clothing/under/marine/jungle

/datum/gear/synthetic/uscm/marine_desert
	path = /obj/item/clothing/under/marine/desert

/datum/gear/synthetic/uscm/marine_classic
	path = /obj/item/clothing/under/marine/classic

/datum/gear/synthetic/uscm/marine_snow
	path = /obj/item/clothing/under/marine/snow

/datum/gear/synthetic/uscm/marine_urban
	path = /obj/item/clothing/under/marine/urban

/datum/gear/synthetic/uscm/service_tan
	path = /obj/item/clothing/under/marine/officer/bridge

/datum/gear/synthetic/uscm/service_white
	path = /obj/item/clothing/under/marine/dress

/datum/gear/synthetic/uscm/engineer_jungle
	path = /obj/item/clothing/under/marine/engineer/jungle

/datum/gear/synthetic/uscm/engineer_desert
	path = /obj/item/clothing/under/marine/engineer/desert

/datum/gear/synthetic/uscm/engineer_classic
	path = /obj/item/clothing/under/marine/engineer/classic

/datum/gear/synthetic/uscm/engineer_snow
	path = /obj/item/clothing/under/marine/engineer/snow

/datum/gear/synthetic/uscm/engineer_urban
	path = /obj/item/clothing/under/marine/engineer/urban

/datum/gear/synthetic/uscm/engineer_officer
	path = /obj/item/clothing/under/marine/officer/engi

/datum/gear/synthetic/uscm/engineer_OT
	path = /obj/item/clothing/under/marine/officer/engi/OT

/datum/gear/synthetic/uscm/corpsman_jungle
	path = /obj/item/clothing/under/marine/medic/jungle

/datum/gear/synthetic/uscm/corpsman_desert
	path = /obj/item/clothing/under/marine/medic/desert

/datum/gear/synthetic/uscm/corpsman_classic
	path = /obj/item/clothing/under/marine/medic/classic

/datum/gear/synthetic/uscm/corpsman_snow
	path = /obj/item/clothing/under/marine/medic/snow

/datum/gear/synthetic/uscm/corpsman_urban
	path = /obj/item/clothing/under/marine/medic/urban

/datum/gear/synthetic/uscm/mp_jungle
	path = /obj/item/clothing/under/marine/mp/jungle

/datum/gear/synthetic/uscm/mp_desert
	path = /obj/item/clothing/under/marine/mp/desert

/datum/gear/synthetic/uscm/mp_classic
	path = /obj/item/clothing/under/marine/mp/classic

/datum/gear/synthetic/uscm/mp_snow
	path = /obj/item/clothing/under/marine/mp/snow

/datum/gear/synthetic/uscm/mp_urban
	path = /obj/item/clothing/under/marine/mp/urban

/datum/gear/synthetic/uscm/operations_uniform_jungle
	path = /obj/item/clothing/under/marine/officer/boiler/jungle

/datum/gear/synthetic/uscm/operations_uniform_desert
	path = /obj/item/clothing/under/marine/officer/boiler/desert

/datum/gear/synthetic/uscm/operations_uniform_classic
	path = /obj/item/clothing/under/marine/officer/boiler/classic

/datum/gear/synthetic/uscm/operations_uniform_snow
	path = /obj/item/clothing/under/marine/officer/boiler/snow

/datum/gear/synthetic/uscm/operations_uniform_urban
	path = /obj/item/clothing/under/marine/officer/boiler/urban

/datum/gear/synthetic/civilian
	category = "Civilian Uniforms"

/datum/gear/synthetic/civilian/white_tshirt_brown_jeans
	path = /obj/item/clothing/under/tshirt/w_br

/datum/gear/synthetic/civilian/gray_tshirt_blue_jeans
	path = /obj/item/clothing/under/tshirt/gray_blu

/datum/gear/synthetic/civilian/red_tshirt_black_jeans
	path = /obj/item/clothing/under/tshirt/r_bla

/datum/gear/synthetic/civilian/frontier
	path = /obj/item/clothing/under/rank/frontier

/datum/gear/synthetic/civilian/grey_jumpsuit
	path = /obj/item/clothing/under/rank/utility/gray

/datum/gear/synthetic/civilian/brown_jumpsuit
	path = /obj/item/clothing/under/rank/utility/brown

/datum/gear/synthetic/civilian/green_utility
	path = /obj/item/clothing/under/rank/utility

/datum/gear/synthetic/civilian/grey_utility
	path = /obj/item/clothing/under/rank/utility/yellow

/datum/gear/synthetic/civilian/grey_utility_blue_jeans
	path = /obj/item/clothing/under/rank/utility/red

/datum/gear/synthetic/civilian/blue_utility_brown_jeans
	path = /obj/item/clothing/under/rank/utility/blue

/datum/gear/synthetic/civilian/white_service
	path = /obj/item/clothing/under/colonist/white_service

/datum/gear/synthetic/civilian/steward
	path = /obj/item/clothing/under/colonist/steward

/datum/gear/synthetic/civilian/blue_suit_pants
	path = /obj/item/clothing/under/liaison_suit/blue

/datum/gear/synthetic/civilian/brown_suit_pants
	path = /obj/item/clothing/under/liaison_suit/brown

/datum/gear/synthetic/civilian/white_suit_pants
	path = /obj/item/clothing/under/liaison_suit/corporate_formal

/datum/gear/synthetic/civilian/grey_suit_pants
	path = /obj/item/clothing/under/detective/grey

/datum/gear/synthetic/civilian/alt_brown_suit_pants
	path = /obj/item/clothing/under/detective/neutral

/datum/gear/synthetic/glasses
	category = "Glasses"

/datum/gear/synthetic/glasses/marine_rpg
	path = /obj/item/clothing/glasses/regular

/datum/gear/synthetic/glasses/reagent_scanner
	path = /obj/item/clothing/glasses/science


/datum/gear/synthetic/glasses/security_hud
	path = /obj/item/clothing/glasses/sunglasses/sechud

/datum/gear/synthetic/glasses/sunglasses
	path = /obj/item/clothing/glasses/sunglasses

/datum/gear/synthetic/glasses/sunglasses_aviator_tan
	path = /obj/item/clothing/glasses/sunglasses/aviator

/datum/gear/synthetic/glasses/sunglasses_aviator_silver
	path = /obj/item/clothing/glasses/sunglasses/aviator/silver

/datum/gear/synthetic/glasses/bimex
	path = /obj/item/clothing/glasses/sunglasses/big

/datum/gear/synthetic/glasses/bimex_new
	path = /obj/item/clothing/glasses/sunglasses/big/new_bimex

/datum/gear/synthetic/glasses/bimex_new_black
	path = /obj/item/clothing/glasses/sunglasses/big/new_bimex/black

/datum/gear/synthetic/glasses/bimex_new_bronze
	path = /obj/item/clothing/glasses/sunglasses/big/new_bimex/bronze

/datum/gear/synthetic/glasses/fake_bimex_red
	path = /obj/item/clothing/glasses/sunglasses/big/fake/red

/datum/gear/synthetic/glasses/fake_bimex_orange
	path = /obj/item/clothing/glasses/sunglasses/big/fake/orange

/datum/gear/synthetic/glasses/fake_bimex_yellow
	path = /obj/item/clothing/glasses/sunglasses/big/fake/yellow

/datum/gear/synthetic/glasses/fake_bimex_green
	path = /obj/item/clothing/glasses/sunglasses/big/fake/green

/datum/gear/synthetic/glasses/fake_bimex_blue
	path = /obj/item/clothing/glasses/sunglasses/big/fake/blue


/datum/gear/synthetic/shoes
	category = "Shoes"

/datum/gear/synthetic/shoes/black
	path = /obj/item/clothing/shoes/marine

/datum/gear/synthetic/shoes/blue
	path = /obj/item/clothing/shoes/black

/datum/gear/synthetic/shoes/brown
	path = /obj/item/clothing/shoes/brown

/datum/gear/synthetic/shoes/green
	path = /obj/item/clothing/shoes/green

/datum/gear/synthetic/shoes/purple
	path = /obj/item/clothing/shoes/purple

/datum/gear/synthetic/shoes/red
	path = /obj/item/clothing/shoes/red

/datum/gear/synthetic/shoes/white
	path = /obj/item/clothing/shoes/white

/datum/gear/synthetic/shoes/yellow
	path = /obj/item/clothing/shoes/yellow

/datum/gear/synthetic/headwear
	category = "Headwear"

/datum/gear/synthetic/headwear/surgcap_green
	path = /obj/item/clothing/head/surgery/green

/datum/gear/synthetic/headwear/surgcap_blue
	path = /obj/item/clothing/head/surgery/blue

/datum/gear/synthetic/headwear/surgcap_lightblue
	path = /obj/item/clothing/head/surgery/lightblue

/datum/gear/synthetic/headwear/surgcap_purple
	path = /obj/item/clothing/head/surgery/purple

/datum/gear/synthetic/headwear/surgcap_olive
	path = /obj/item/clothing/head/surgery/olive

/datum/gear/synthetic/headwear/surgcap_grey
	path = /obj/item/clothing/head/surgery/grey

/datum/gear/synthetic/headwear/surgcap_brown
	path = /obj/item/clothing/head/surgery/brown

/datum/gear/synthetic/headwear/surgcap_white
	path = /obj/item/clothing/head/surgery/white

/datum/gear/synthetic/headwear/surgcap_black
	path = /obj/item/clothing/head/surgery/morgue

/datum/gear/synthetic/headwear/surgcap_pharmacist
	path = /obj/item/clothing/head/surgery/pharmacist

/datum/gear/synthetic/headwear/beanie
	path = /obj/item/clothing/head/beanie

/datum/gear/synthetic/headwear/hardhat_yellow
	path = /obj/item/clothing/head/hardhat

/datum/gear/synthetic/headwear/hardhat_yellow
	path = /obj/item/clothing/head/hardhat

/datum/gear/synthetic/headwear/hardhat_orange
	path = /obj/item/clothing/head/hardhat/orange

/datum/gear/synthetic/headwear/hardhat_white
	path = /obj/item/clothing/head/hardhat/white

/datum/gear/synthetic/headwear/hardhat_blue
	path = /obj/item/clothing/head/hardhat/dblue

/datum/gear/synthetic/headwear/welding_helmet
	path = /obj/item/clothing/head/welding

/datum/gear/synthetic/headwear/beret_engineering
	path = /obj/item/clothing/head/beret/eng

/datum/gear/synthetic/headwear/beret_purple
	path = /obj/item/clothing/head/beret/jan

/datum/gear/synthetic/headwear/beret_red
	path = /obj/item/clothing/head/beret/cm/red

/datum/gear/synthetic/headwear/beret
	path = /obj/item/clothing/head/beret/cm

/datum/gear/synthetic/headwear/beret_tan
	path = /obj/item/clothing/head/beret/cm/tan

/datum/gear/synthetic/headwear/beret_black
	path = /obj/item/clothing/head/beret/cm/black

/datum/gear/synthetic/headwear/beret_white
	path = /obj/item/clothing/head/beret/cm/white

/datum/gear/synthetic/headwear/cap
	path = /obj/item/clothing/head/cmcap

/datum/gear/synthetic/headwear/cap
	path = /obj/item/clothing/head/cmcap/flap

/datum/gear/synthetic/headwear/mp_cap
	path = /obj/item/clothing/head/beret/marine/mp/mpcap

/datum/gear/synthetic/headwear/ro_cap
	path = /obj/item/clothing/head/cmcap/req/ro

/datum/gear/synthetic/headwear/req_cap
	path = /obj/item/clothing/head/cmcap/req

/datum/gear/synthetic/headwear/officer_cap
	path = /obj/item/clothing/head/cmcap/bridge

/datum/gear/synthetic/headwear/fedora_tan
	path = /obj/item/clothing/head/fedora

/datum/gear/synthetic/headwear/fedora_grey
	path = /obj/item/clothing/head/fedora/grey

/datum/gear/synthetic/headwear/fedora_brown
	path = /obj/item/clothing/head/fedora/brown

/datum/gear/synthetic/headwear/trucker_blue
	path = /obj/item/clothing/head/soft/trucker

/datum/gear/synthetic/headwear/trucker_red
	path = /obj/item/clothing/head/soft/trucker/red

/datum/gear/synthetic/helmet
	category = "Helmet"

/datum/gear/synthetic/helmet/marine
	path = /obj/item/clothing/head/helmet/marine

/datum/gear/synthetic/helmet/marine_grey
	path = /obj/item/clothing/head/helmet/marine/grey

/datum/gear/synthetic/helmet/marine_jungle
	path = /obj/item/clothing/head/helmet/marine/jungle

/datum/gear/synthetic/helmet/marine_snow
	path = /obj/item/clothing/head/helmet/marine/snow

/datum/gear/synthetic/helmet/marine_desert
	path = /obj/item/clothing/head/helmet/marine/desert

/datum/gear/synthetic/helmet/marine_urban
	path = /obj/item/clothing/head/helmet/marine/urban

/datum/gear/synthetic/helmet/marine_medic
	path = /obj/item/clothing/head/helmet/marine/medic

/datum/gear/synthetic/helmet/marine_medic_grey
	path = /obj/item/clothing/head/helmet/marine/medic/grey

/datum/gear/synthetic/helmet/marine_medic_white
	path = /obj/item/clothing/head/helmet/marine/medic/white

/datum/gear/synthetic/helmet/marine_medic_jungle
	path = /obj/item/clothing/head/helmet/marine/medic/jungle

/datum/gear/synthetic/helmet/marine_medic_snow
	path = /obj/item/clothing/head/helmet/marine/medic/snow

/datum/gear/synthetic/helmet/marine_medic_desert
	path = /obj/item/clothing/head/helmet/marine/medic/desert

/datum/gear/synthetic/helmet/marine_medic_urban
	path = /obj/item/clothing/head/helmet/marine/medic/urban

/datum/gear/synthetic/helmet/marine_intel
	path = /obj/item/clothing/head/helmet/marine/rto/intel

/datum/gear/synthetic/helmet/marine_intel_grey
	path = /obj/item/clothing/head/helmet/marine/rto/intel/grey

/datum/gear/synthetic/helmet/marine_intel_jungle
	path = /obj/item/clothing/head/helmet/marine/rto/intel/jungle

/datum/gear/synthetic/helmet/marine_intel_snow
	path = /obj/item/clothing/head/helmet/marine/rto/intel/snow

/datum/gear/synthetic/helmet/marine_intel_desert
	path = /obj/item/clothing/head/helmet/marine/rto/intel/desert

/datum/gear/synthetic/helmet/marine_mp
	path = /obj/item/clothing/head/helmet/marine/MP

/datum/gear/synthetic/helmet/marine_mp_grey
	path = /obj/item/clothing/head/helmet/marine/MP/grey

/datum/gear/synthetic/helmet/marine_mp_jungle
	path = /obj/item/clothing/head/helmet/marine/MP/jungle

/datum/gear/synthetic/helmet/marine_mp_snow
	path = /obj/item/clothing/head/helmet/marine/MP/snow

/datum/gear/synthetic/helmet/marine_mp_desert
	path = /obj/item/clothing/head/helmet/marine/MP/desert

/datum/gear/synthetic/helmet/marine_mp_urban
	path = /obj/item/clothing/head/helmet/marine/MP/urban

/datum/gear/synthetic/mask
	category = "Mask"

/datum/gear/synthetic/mask/surgical
	path = /obj/item/clothing/mask/surgical

/datum/gear/synthetic/mask/tacticalmask
	path = /obj/item/clothing/mask/rebreather/scarf/tacticalmask

/datum/gear/synthetic/mask/tacticalmask_red
	path = /obj/item/clothing/mask/rebreather/scarf/tacticalmask/red

/datum/gear/synthetic/mask/tacticalmask_green
	path = /obj/item/clothing/mask/rebreather/scarf/tacticalmask/green

/datum/gear/synthetic/mask/tacticalmask_tan
	path = /obj/item/clothing/mask/rebreather/scarf/tacticalmask/tan

/datum/gear/synthetic/mask/tacticalmask_black
	path = /obj/item/clothing/mask/rebreather/scarf/tacticalmask/black

/datum/gear/synthetic/mask/tornscarf
	path = /obj/item/clothing/mask/tornscarf

/datum/gear/synthetic/mask/tornscarf_green
	path = /obj/item/clothing/mask/tornscarf/green

/datum/gear/synthetic/mask/tornscarf_snow
	path = /obj/item/clothing/mask/tornscarf/snow

/datum/gear/synthetic/mask/tornscarf_desert
	path = /obj/item/clothing/mask/tornscarf/desert

/datum/gear/synthetic/mask/tornscarf_urban
	path = /obj/item/clothing/mask/tornscarf/urban

/datum/gear/synthetic/mask/tornscarf_black
	path = /obj/item/clothing/mask/tornscarf/black

/datum/gear/synthetic/suit
	category = "Suit"

/datum/gear/synthetic/suit/bomber
	path = /obj/item/clothing/suit/storage/bomber

/datum/gear/synthetic/suit/grey_bomber
	path = /obj/item/clothing/suit/storage/jacket/marine/bomber/grey

/datum/gear/synthetic/suit/red_bomber
	path = /obj/item/clothing/suit/storage/jacket/marine/bomber/red

/datum/gear/synthetic/suit/bomber_alt
	path = /obj/item/clothing/suit/storage/bomber/alt

/datum/gear/synthetic/suit/khaki_bomber
	path = /obj/item/clothing/suit/storage/jacket/marine/bomber

/datum/gear/synthetic/suit/webbing
	path = /obj/item/clothing/suit/storage/webbing

/datum/gear/synthetic/suit/utility_vest
	path = /obj/item/clothing/suit/storage/utility_vest

/datum/gear/synthetic/suit/hazardvest
	path = /obj/item/clothing/suit/storage/hazardvest

/datum/gear/synthetic/suit/hazardvest_hivis
	path = /obj/item/clothing/suit/storage/hazardvest/sanitation

/datum/gear/synthetic/suit/hazardvest_blue
	path = /obj/item/clothing/suit/storage/hazardvest/blue

/datum/gear/synthetic/suit/hazardvest_yellow
	path = /obj/item/clothing/suit/storage/hazardvest/yellow

/datum/gear/synthetic/suit/hazardvest_black
	path = /obj/item/clothing/suit/storage/hazardvest/black

/datum/gear/synthetic/suit/medicalvest_green
	path = /obj/item/clothing/suit/storage/hazardvest/medical_green

/datum/gear/synthetic/suit/medicalvest_red
	path = /obj/item/clothing/suit/storage/hazardvest/medical_red

/datum/gear/synthetic/suit/snowsuit
	path = /obj/item/clothing/suit/storage/snow_suit/synth

/datum/gear/synthetic/suit/marine_service
	path = /obj/item/clothing/suit/storage/jacket/marine/service

/datum/gear/synthetic/suit/windbreaker_brown
	path = /obj/item/clothing/suit/storage/windbreaker/windbreaker_brown

/datum/gear/synthetic/suit/windbreaker_gray
	path = /obj/item/clothing/suit/storage/windbreaker/windbreaker_gray

/datum/gear/synthetic/suit/windbreaker_green
	path = /obj/item/clothing/suit/storage/windbreaker/windbreaker_green

/datum/gear/synthetic/suit/windbreaker_fr
	path = /obj/item/clothing/suit/storage/windbreaker/windbreaker_fr

/datum/gear/synthetic/suit/windbreaker_covenant
	path = /obj/item/clothing/suit/storage/windbreaker/windbreaker_covenant

/datum/gear/synthetic/suit/labcoat
	path = /obj/item/clothing/suit/storage/labcoat

/datum/gear/synthetic/suit/labcoat_researcher
	path = /obj/item/clothing/suit/storage/labcoat/researcher

/datum/gear/synthetic/suit/ro_jacket
	path = /obj/item/clothing/suit/storage/jacket/marine/RO

/datum/gear/synthetic/suit/corporate_black
	path = /obj/item/clothing/suit/storage/jacket/marine/corporate/black

/datum/gear/synthetic/suit/corporate_brown
	path = /obj/item/clothing/suit/storage/jacket/marine/corporate/brown

/datum/gear/synthetic/suit/corporate_blue
	path = /obj/item/clothing/suit/storage/jacket/marine/corporate/blue

/datum/gear/synthetic/suit/vest
	path = /obj/item/clothing/suit/storage/jacket/marine/vest

/datum/gear/synthetic/suit/vest_tan
	path = /obj/item/clothing/suit/storage/jacket/marine/vest/tan

/datum/gear/synthetic/suit/vest_gray
	path = /obj/item/clothing/suit/storage/jacket/marine/vest/grey

/datum/gear/synthetic/suit/tan_trenchcoat
	path = /obj/item/clothing/suit/storage/CMB/trenchcoat

/datum/gear/synthetic/suit/brown_trenchcoat
	path = /obj/item/clothing/suit/storage/CMB/trenchcoat/brown

/datum/gear/synthetic/suit/grey_trenchcoat
	path = /obj/item/clothing/suit/storage/CMB/trenchcoat/grey

/datum/gear/synthetic/suit/blue_overalls
	path = /obj/item/clothing/suit/storage/apron/overalls

/datum/gear/synthetic/suit/tan_overalls
	path = /obj/item/clothing/suit/storage/apron/overalls/tan

/datum/gear/synthetic/suit/red_overalls
	path = /obj/item/clothing/suit/storage/apron/overalls/red

/datum/gear/synthetic/backpack
	category = "Backpack"

/datum/gear/synthetic/backpack/industrial
	path = /obj/item/storage/backpack/industrial

/datum/gear/synthetic/backpack/marine_medic
	path = /obj/item/storage/backpack/marine/medic

/datum/gear/synthetic/backpack/marine_medic_satchel
	path = /obj/item/storage/backpack/marine/satchel/tech

/datum/gear/synthetic/backpack/marine_satchel
	path = /obj/item/storage/backpack/marine/satchel

/datum/gear/synthetic/backpack/marine_satchel_med
	path = /obj/item/storage/backpack/marine/satchel/medic

/datum/gear/synthetic/backpack/satchel
	path = /obj/item/storage/backpack/satchel

/datum/gear/synthetic/backpack/satchel_blue
	path = /obj/item/storage/backpack/satchel/blue

/datum/gear/synthetic/backpack/satchel_black
	path = /obj/item/storage/backpack/satchel/black

/datum/gear/synthetic/backpack/marine_engineer_satchel
	path = /obj/item/storage/backpack/marine/engineerpack/satchel

/datum/gear/synthetic/backpack/marine_engineer_chestrig
	path = /obj/item/storage/backpack/marine/engineerpack/welder_chestrig

/datum/gear/synthetic/backpack/marine_radio_telephone
	path = /obj/item/storage/backpack/marine/satchel/rto
	loadout_cost = 24

/datum/gear/synthetic/armband
	path = /obj/item/clothing/accessory/armband

/datum/gear/synthetic/armband_sci
	path = /obj/item/clothing/accessory/armband/science

/datum/gear/synthetic/armband_eng
	path = /obj/item/clothing/accessory/armband/engine

/datum/gear/synthetic/armband_med
	path = /obj/item/clothing/accessory/armband/medgreen

/datum/gear/synthetic/blue_tie
	path = /obj/item/clothing/accessory/tie

/datum/gear/synthetic/green_tie
	path = /obj/item/clothing/accessory/tie/green

/datum/gear/synthetic/black_tie
	path = /obj/item/clothing/accessory/tie/black

/datum/gear/synthetic/gold_tie
	path = /obj/item/clothing/accessory/tie/gold

/datum/gear/synthetic/red_tie
	path = /obj/item/clothing/accessory/tie/red

/datum/gear/synthetic/purple_tie
	path = /obj/item/clothing/accessory/tie/purple

/datum/gear/synthetic/dress_gloves
	path = /obj/item/clothing/gloves/marine/dress

//------------EXPERIMENTAL TOOLS---------------
/obj/structure/machinery/cm_vending/own_points/experimental_tools
	name = "\improper W-Y 实验工具供应商"
	desc = "一个较小的供应商，连接着由维兰德-汤谷研发部™特别提供的实验性工具和装备缓存。小心处理。"
	icon_state = "robotics"
	available_points = 0
	available_points_to_display = 0
	vendor_theme = VENDOR_THEME_COMPANY
	req_access = list(ACCESS_MARINE_SYNTH)
	vendor_role = list(JOB_SYNTH)

/obj/structure/machinery/cm_vending/own_points/experimental_tools/redeem_token(obj/item/coin/marine/token, mob/user)
	if(token.token_type == VEND_TOKEN_SYNTH)
		if(user.drop_inv_item_to_loc(token, src))
			available_points = 30
			available_points_to_display = available_points
			to_chat(user, SPAN_NOTICE("你将\the [token]插入\the [src]。"))
			return TRUE
	return ..()

/obj/structure/machinery/cm_vending/own_points/experimental_tools/get_listed_products(mob/user)
	return GLOB.cm_vending_synth_tools

GLOBAL_LIST_INIT(cm_vending_synth_tools, list(
	list("破门锤", 15, /obj/item/weapon/twohanded/breacher/synth, null, VENDOR_ITEM_REGULAR),
	list("便携式除颤器", 15, /obj/item/device/defibrillator/compact, null, VENDOR_ITEM_REGULAR),
	list("紧凑型钉枪套装", 15, /obj/effect/essentials_set/cnailgun, null, VENDOR_ITEM_REGULAR),
	list("伸缩警棍", 15, /obj/item/weapon/telebaton, null, VENDOR_ITEM_REGULAR),
	list("手术网眼背心", 15, /obj/item/clothing/accessory/storage/surg_vest, null, VENDOR_ITEM_REGULAR),
	list("手术网眼背心（蓝色）", 15, /obj/item/clothing/accessory/storage/surg_vest/blue, null, VENDOR_ITEM_REGULAR),
	list("手术式降落袋", 15, /obj/item/clothing/accessory/storage/surg_vest/drop_green, null, VENDOR_ITEM_REGULAR),
	list("外科手术降落袋（蓝色）", 15, /obj/item/clothing/accessory/storage/surg_vest/drop_blue, null, VENDOR_ITEM_REGULAR),
	list("手术式降落伞包（黑色）", 15, /obj/item/clothing/accessory/storage/surg_vest/drop_black, null, VENDOR_ITEM_REGULAR),
	list("工具背带", 15, /obj/item/clothing/accessory/storage/tool_webbing/equipped, null, VENDOR_ITEM_REGULAR),
	list("工具垂降挂包", 15, /obj/item/clothing/accessory/storage/tool_webbing/yellow_drop/equipped, null, VENDOR_ITEM_REGULAR),
	list("后勤增强背包", 15, /obj/item/storage/backpack/marine/satchel/big, null, VENDOR_ITEM_REGULAR),
	list("远征胸挂", 15, /obj/item/storage/backpack/marine/satchel/intel/chestrig, null, VENDOR_ITEM_REGULAR),
))

//------------EXPERIMENTAL TOOL KITS---------------
/obj/effect/essentials_set/cnailgun
	spawned_gear_list = list(
		/obj/item/weapon/gun/smg/nailgun/compact,
		/obj/item/ammo_magazine/smg/nailgun,
		/obj/item/ammo_magazine/smg/nailgun,
		/obj/item/storage/belt/gun/m4a3/nailgun,
	)
