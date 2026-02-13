//------------ADAPTIVE ANTAG CLOSET---------------
//Spawn one of these bad boys and you will have a proper automated closet for CLF/UPP players (for now, more can be always added later)

/obj/structure/machinery/cm_vending/clothing/antag
	name = "\improper 可疑自动化设备机架"
	desc = "虽然功能与ColMarTech自动化货架相似，但这台显然不是USCM的产物。装有各种装备。"
	icon_state = "antag_clothing"
	req_one_access = list(ACCESS_ILLEGAL_PIRATE, ACCESS_UPP_GENERAL, ACCESS_CLF_GENERAL)
	req_access = null

	listed_products = list()

/obj/structure/machinery/cm_vending/clothing/antag/Initialize()
	. = ..()
	vend_flags |= VEND_FACTION_THEMES

/obj/structure/machinery/cm_vending/clothing/antag/get_listed_products(mob/user)
	if(!user)
		var/list/all_equipment = list()
		var/list/presets = typesof(/datum/equipment_preset)
		for(var/i in presets)
			var/datum/equipment_preset/eq = new i
			var/list/equipment = eq.get_antag_clothing_equipment()
			if(LAZYLEN(equipment))
				all_equipment += equipment
			qdel(eq)
		return all_equipment

	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	var/list/products_sets = list()
	if(H.assigned_equipment_preset)
		if(!(H.assigned_equipment_preset.type in listed_products))
			listed_products[H.assigned_equipment_preset.type] = H.assigned_equipment_preset.get_antag_clothing_equipment()
		products_sets = listed_products[H.assigned_equipment_preset.type]
	else
		if(!(/datum/equipment_preset/clf in listed_products))
			listed_products[/datum/equipment_preset/clf] = GLOB.equipment_presets.gear_path_presets_list[/datum/equipment_preset/clf].get_antag_clothing_equipment()
		products_sets = listed_products[/datum/equipment_preset/clf]
	return products_sets

/obj/structure/machinery/cm_vending/clothing/antag/upp
	name = "自动化设备机架"
	icon_state = "upp_clothing"
	req_access = list(ACCESS_UPP_GENERAL)

//--------------RANDOM EQUIPMENT AND GEAR------------------------

/obj/effect/essentials_set/random/clf_shoes
	spawned_gear_list = list(
		/obj/item/clothing/shoes/black,
		/obj/item/clothing/shoes/brown,
		/obj/item/clothing/shoes/combat,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/shoes/leather,
		/obj/item/clothing/shoes/swat,
	)

/obj/effect/essentials_set/random/clf_armor
	spawned_gear_list = list(
		/obj/item/clothing/suit/armor/vest,
		/obj/item/clothing/suit/armor/bulletproof,
		/obj/item/clothing/suit/storage/militia/brace,
		/obj/item/clothing/suit/storage/militia,
		/obj/item/clothing/suit/storage/militia/partial,
		/obj/item/clothing/suit/storage/militia/vest,
	)

/obj/effect/essentials_set/random/clf_gloves
	spawned_gear_list = list(
		/obj/item/clothing/gloves/black,
		/obj/item/clothing/gloves/botanic_leather,
		/obj/item/clothing/gloves/combat,
		/obj/item/clothing/gloves/swat,
	)

/obj/effect/essentials_set/random/clf_head
	spawned_gear_list = list(
		/obj/item/clothing/head/militia,
		/obj/item/clothing/head/militia/bucket,
		/obj/item/clothing/head/helmet/skullcap,
		/obj/item/clothing/head/hardhat,
		/obj/item/clothing/head/helmet,
		/obj/item/clothing/head/bandana,
		/obj/item/clothing/head/headband/red,
		/obj/item/clothing/head/headband/rambo,
		/obj/item/clothing/head/headband/rebel,
		/obj/item/clothing/head/helmet/swat,
	)

/obj/effect/essentials_set/random/clf_belt
	spawned_gear_list = list(
		/obj/item/storage/belt/marine,
		/obj/item/storage/belt/marine,
		/obj/item/storage/belt/marine,
		/obj/item/storage/belt/marine,
		/obj/item/storage/belt/marine,
		/obj/item/storage/belt/gun/flaregun/full,
		/obj/item/storage/belt/gun/flaregun/full,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/belt/knifepouch,
		/obj/item/storage/large_holster/katana/full,
		/obj/item/storage/large_holster/machete/full,
	)

//------UPP Synthetic Snowflake------

/obj/structure/machinery/cm_vending/clothing/synth/upp
	name = "\improper 合成统一体 联合人民阵线"
	desc = "一台印有大雪花的自动售货机。从维兰德-汤谷时尚部门偷来的。"
	icon_state = "snowflake"
	show_points = TRUE
	use_snowflake_points = TRUE
	vendor_theme = VENDOR_THEME_UPP
	req_access = list(ACCESS_UPP_LEADERSHIP)
	vendor_role = list(JOB_SYNTH, JOB_SYNTH_SURVIVOR, JOB_WORKING_JOE, JOB_UPP_SUPPORT_SYNTH, JOB_UPP_COMBAT_SYNTH, JOB_CMB_SYN, JOB_PMC_SYNTH)

	vend_delay = 1 SECONDS

/obj/structure/machinery/cm_vending/clothing/synth/upp/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_synth_upp

//------------UPP SNOWFLAKE VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_synth_upp, list(
	list("联合人民阵线 作战服", 0, null, null, null),
	list("联合人民阵线 士兵作战服", 12, /obj/item/clothing/under/marine/veteran/UPP, null, VENDOR_ITEM_REGULAR),
	list("联合人民阵线 工程师工作服", 12, /obj/item/clothing/under/marine/veteran/UPP/engi, null, VENDOR_ITEM_REGULAR),
	list("联合人民阵线 医疗兵制服", 12, /obj/item/clothing/under/marine/veteran/UPP/medic, null, VENDOR_ITEM_REGULAR),
	list("联合人民阵线议员制服", 12, /obj/item/clothing/under/marine/veteran/UPP/mp, null, VENDOR_ITEM_REGULAR),
	list("联合人民阵线 军官制服", 12, /obj/item/clothing/under/marine/veteran/UPP/officer, null, VENDOR_ITEM_REGULAR),

	list("非标准制服", 0, null, null, null),
	list("联合人民阵线 民用风格连体服，橙色", 12, /obj/item/clothing/under/marine/veteran/UPP/civi1, null, VENDOR_ITEM_REGULAR),
	list("联合人民阵线 民用式连体服，棕褐色", 12, /obj/item/clothing/under/marine/veteran/UPP/civi2, null, VENDOR_ITEM_REGULAR),
	list("联合人民阵线 平民式衬衫和裤子", 12, /obj/item/clothing/under/marine/veteran/UPP/civi3, null, VENDOR_ITEM_REGULAR),
	list("联合人民阵线 民用式背心与长裤", 12, /obj/item/clothing/under/marine/veteran/UPP/civi4, null, VENDOR_ITEM_REGULAR),
	list("医用手术服，蓝色", 12, /obj/item/clothing/under/rank/medical/blue, null, VENDOR_ITEM_REGULAR),
	list("医用手术服，浅蓝色", 12, /obj/item/clothing/under/rank/medical/lightblue, null, VENDOR_ITEM_REGULAR),
	list("医用手术服，绿色", 12, /obj/item/clothing/under/rank/medical/green, null, VENDOR_ITEM_REGULAR),
	list("紫色医疗工作服", 12, /obj/item/clothing/under/rank/medical/purple, null, VENDOR_ITEM_REGULAR),
	list("医用手术服，橄榄色", 12, /obj/item/clothing/under/rank/medical/olive, null, VENDOR_ITEM_REGULAR),
	list("医用手术服，灰色", 12, /obj/item/clothing/under/rank/medical/grey, null, VENDOR_ITEM_REGULAR),
	list("医用刷手服，棕色", 12, /obj/item/clothing/under/rank/medical/brown, null, VENDOR_ITEM_REGULAR),
	list("医用刷手服，白色", 12, /obj/item/clothing/under/rank/medical/white, null, VENDOR_ITEM_REGULAR),
	list("医用手术服，黑色", 12, /obj/item/clothing/under/rank/medical/morgue, null, VENDOR_ITEM_REGULAR),
	list("医疗工作服，白色与橙色条纹款", 12, /obj/item/clothing/under/rank/medical/pharmacist, null, VENDOR_ITEM_REGULAR),
	list("白色T恤与棕色牛仔裤", 12, /obj/item/clothing/under/tshirt/w_br, null, VENDOR_ITEM_REGULAR),
	list("灰色T恤与蓝色牛仔裤", 12, /obj/item/clothing/under/tshirt/gray_blu, null, VENDOR_ITEM_REGULAR),
	list("红色T恤与黑色牛仔裤", 12, /obj/item/clothing/under/tshirt/r_bla, null, VENDOR_ITEM_REGULAR),
	list("前沿连体服", 12, /obj/item/clothing/under/rank/frontier, null, VENDOR_ITEM_REGULAR),
	list("灰色公用事业", 12, /obj/item/clothing/under/rank/utility/yellow, null, VENDOR_ITEM_REGULAR),
	list("灰色公用事业与蓝色牛仔裤", 12, /obj/item/clothing/under/rank/utility/red, null, VENDOR_ITEM_REGULAR),
	list("蓝色工具与棕色牛仔裤", 12, /obj/item/clothing/under/rank/utility/blue, null, VENDOR_ITEM_REGULAR),
	list("白色勤务制服", 12, /obj/item/clothing/under/colonist/white_service, null, VENDOR_ITEM_REGULAR),
	list("管家服饰", 12, /obj/item/clothing/under/colonist/steward, null, VENDOR_ITEM_REGULAR),
	list("红色连衣裙裙", 12, /obj/item/clothing/under/blackskirt, null, VENDOR_ITEM_REGULAR),
	list("蓝色西装裤", 12, /obj/item/clothing/under/liaison_suit/blue, null, VENDOR_ITEM_REGULAR),
	list("棕色西装裤", 12, /obj/item/clothing/under/liaison_suit/brown, null, VENDOR_ITEM_REGULAR),
	list("白色西装裤", 12, /obj/item/clothing/under/liaison_suit/corporate_formal, null, VENDOR_ITEM_REGULAR),
	list("乔伊工作服", 36, /obj/item/clothing/under/rank/synthetic/joe, null, VENDOR_ITEM_REGULAR),

	list("眼镜", 0, null, null, null),
	list("健康伴侣抬头显示器", 12, /obj/item/clothing/glasses/hud/health, null, VENDOR_ITEM_REGULAR),
	list("陆战队RPG眼镜", 12, /obj/item/clothing/glasses/regular, null, VENDOR_ITEM_REGULAR),
	list("光学介子扫描仪", 12, /obj/item/clothing/glasses/meson, null, VENDOR_ITEM_REGULAR),
	list("巡逻伙伴抬头显示器", 12, /obj/item/clothing/glasses/hud/security, null, VENDOR_ITEM_REGULAR),
	list("安全平视显示眼镜", 12, /obj/item/clothing/glasses/sunglasses/sechud, null, VENDOR_ITEM_REGULAR),
	list("太阳镜", 12, /obj/item/clothing/glasses/sunglasses, null, VENDOR_ITEM_REGULAR),
	list("焊接护目镜", 12, /obj/item/clothing/glasses/welding, null, VENDOR_ITEM_REGULAR),

	list("鞋子", 0, null, null, null),
	list("联合人民阵线 靴子", 12, /obj/item/clothing/shoes/marine/upp/knife, null, VENDOR_ITEM_REGULAR),
	list("鞋子，黑色", 12, /obj/item/clothing/shoes/black, null, VENDOR_ITEM_REGULAR),
	list("鞋子，蓝色", 12, /obj/item/clothing/shoes/blue, null, VENDOR_ITEM_REGULAR),
	list("鞋子，棕色", 12, /obj/item/clothing/shoes/brown, null, VENDOR_ITEM_REGULAR),
	list("鞋子，绿色", 12, /obj/item/clothing/shoes/green, null, VENDOR_ITEM_REGULAR),
	list("鞋子，紫色", 12, /obj/item/clothing/shoes/purple, null, VENDOR_ITEM_REGULAR),
	list("鞋子，红色", 12, /obj/item/clothing/shoes/red, null, VENDOR_ITEM_REGULAR),
	list("鞋子，白色", 12, /obj/item/clothing/shoes/white, null, VENDOR_ITEM_REGULAR),
	list("鞋子，黄色", 12, /obj/item/clothing/shoes/yellow, null, VENDOR_ITEM_REGULAR),
	list("鞋履，希格森", 24, /obj/item/clothing/shoes/dress, null, VENDOR_ITEM_REGULAR),

	list("头部装备", 0, null, null, null),
	list("UL2上限", 12, /obj/item/clothing/head/uppcap, null, VENDOR_ITEM_REGULAR),
	list("UL2c 上限", 12, /obj/item/clothing/head/uppcap/civi, null, VENDOR_ITEM_REGULAR),
	list("UL3 鸭舌帽", 12, /obj/item/clothing/head/uppcap/peaked, null, VENDOR_ITEM_REGULAR),
	list("UL8 乌尚卡帽", 12, /obj/item/clothing/head/uppcap/ushanka, null, VENDOR_ITEM_REGULAR),
	list("UL8c 乌沙帽", 12, /obj/item/clothing/head/uppcap/ushanka/civi, null, VENDOR_ITEM_REGULAR),
	list("手术帽，蓝色", 12, /obj/item/clothing/head/surgery/blue, null, VENDOR_ITEM_REGULAR),
	list("手术帽，绿色", 12, /obj/item/clothing/head/surgery/green, null, VENDOR_ITEM_REGULAR),
	list("手术帽，浅蓝色", 12, /obj/item/clothing/head/surgery/lightblue, null, VENDOR_ITEM_REGULAR),
	list("手术帽，紫色", 12, /obj/item/clothing/head/surgery/purple, null, VENDOR_ITEM_REGULAR),
	list("手术帽，橄榄色", 12, /obj/item/clothing/head/surgery/olive, null, VENDOR_ITEM_REGULAR),
	list("手术帽，灰色", 12, /obj/item/clothing/head/surgery/grey, null, VENDOR_ITEM_REGULAR),
	list("手术帽，棕色", 12, /obj/item/clothing/head/surgery/brown, null, VENDOR_ITEM_REGULAR),
	list("手术帽，白色", 12, /obj/item/clothing/head/surgery/white, null, VENDOR_ITEM_REGULAR),
	list("手术帽，黑色", 12, /obj/item/clothing/head/surgery/morgue, null, VENDOR_ITEM_REGULAR),
	list("手术帽，白橙条纹款", 12, /obj/item/clothing/head/surgery/pharmacist, null, VENDOR_ITEM_REGULAR),
	list("豆豆帽", 12, /obj/item/clothing/head/beanie, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，工程", 12, /obj/item/clothing/head/beret/eng, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，紫色", 12, /obj/item/clothing/head/beret/jan, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，红色", 12, /obj/item/clothing/head/beret/cm/red, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，标准型", 12, /obj/item/clothing/head/beret/cm, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，棕褐色", 12, /obj/item/clothing/head/beret/cm/tan, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，绿色", 12, /obj/item/clothing/head/beret/cm, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，黑色", 12, /obj/item/clothing/head/beret/cm/black, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，白色", 12, /obj/item/clothing/head/beret/cm/white, null, VENDOR_ITEM_REGULAR),
	list("生化头罩", 12, /obj/item/clothing/head/bio_hood/synth, null, VENDOR_ITEM_REGULAR),
	list("Fedora", 12, /obj/item/clothing/head/fedora/grey, null, VENDOR_ITEM_REGULAR),

	list("头盔", 0, null, null, null),
	list("UM4头盔", 12, /obj/item/clothing/head/helmet/marine/veteran/UPP, null, VENDOR_ITEM_REGULAR),
	list("白色医护兵头盔（非标准型）", 12, /obj/item/clothing/head/helmet/marine/medic/white, null, VENDOR_ITEM_REGULAR),
	list("可附加头盔护盾", 12, /obj/item/prop/helmetgarb/riot_shield, null, VENDOR_ITEM_REGULAR),

	list("面具", 0, null, null, null),
	list("医用口罩", 12, /obj/item/clothing/mask/surgical, null, VENDOR_ITEM_REGULAR),
	list("循环呼吸器", 12, /obj/item/clothing/mask/rebreather, null, VENDOR_ITEM_REGULAR),
	list("骷髅头套，蓝色", 12, /obj/item/clothing/mask/rebreather/skull, null, VENDOR_ITEM_REGULAR),
	list("骷髅头套，黑色", 12, /obj/item/clothing/mask/rebreather/skull/black, null, VENDOR_ITEM_REGULAR),
	list("巴拉克拉法帽", 12, /obj/item/clothing/mask/rebreather/scarf, null, VENDOR_ITEM_REGULAR),
	list("巴拉克拉瓦头套（绿色）", 12, /obj/item/clothing/mask/rebreather/scarf/green, null, VENDOR_ITEM_REGULAR),
	list("巴拉克拉瓦头套（棕褐色）", 12, /obj/item/clothing/mask/rebreather/scarf/tan, null, VENDOR_ITEM_REGULAR),
	list("巴拉克拉瓦头套（灰色）", 12, /obj/item/clothing/mask/rebreather/scarf/gray, null, VENDOR_ITEM_REGULAR),
	list("缠绕（灰色）", 12, /obj/item/clothing/mask/rebreather/scarf/tacticalmask, null, VENDOR_ITEM_REGULAR),
	list("缠绕（红色）", 12, /obj/item/clothing/mask/rebreather/scarf/tacticalmask/red, null, VENDOR_ITEM_REGULAR),
	list("缠绕（绿色）", 12, /obj/item/clothing/mask/rebreather/scarf/tacticalmask/green, null, VENDOR_ITEM_REGULAR),
	list("缠绕（棕褐色）", 12, /obj/item/clothing/mask/rebreather/scarf/tacticalmask/tan, null, VENDOR_ITEM_REGULAR),
	list("缠绕（黑色）", 12, /obj/item/clothing/mask/rebreather/scarf/tacticalmask/black, null, VENDOR_ITEM_REGULAR),
	list("围巾", 12, /obj/item/clothing/mask/tornscarf, null, VENDOR_ITEM_REGULAR),
	list("围巾（绿色）", 12, /obj/item/clothing/mask/tornscarf/green, null, VENDOR_ITEM_REGULAR),
	list("围巾（雪地款）", 12, /obj/item/clothing/mask/tornscarf/snow, null, VENDOR_ITEM_REGULAR),
	list("围巾（沙漠）", 12, /obj/item/clothing/mask/tornscarf/desert, null, VENDOR_ITEM_REGULAR),
	list("围巾（都市款）", 12, /obj/item/clothing/mask/tornscarf/urban, null, VENDOR_ITEM_REGULAR),
	list("围巾（黑色）", 12, /obj/item/clothing/mask/tornscarf/black, null, VENDOR_ITEM_REGULAR),

	list("西装", 0, null, null, null),
	list("轰炸机夹克，棕色", 12, /obj/item/clothing/suit/storage/bomber, null, VENDOR_ITEM_REGULAR),
	list("轰炸机夹克，黑色", 12, /obj/item/clothing/suit/storage/bomber/alt, null, VENDOR_ITEM_REGULAR),
	list("外部织带", 12, /obj/item/clothing/suit/storage/webbing, null, VENDOR_ITEM_REGULAR),
	list("实用背心", 12, /obj/item/clothing/suit/storage/utility_vest, null, VENDOR_ITEM_REGULAR),
	list("危险警示背心（橙色）", 12, /obj/item/clothing/suit/storage/hazardvest, null, VENDOR_ITEM_REGULAR),
	list("危险背心（蓝色）", 12, /obj/item/clothing/suit/storage/hazardvest/blue, null, VENDOR_ITEM_REGULAR),
	list("危险警示背心（黄色）", 12, /obj/item/clothing/suit/storage/hazardvest/yellow, null, VENDOR_ITEM_REGULAR),
	list("危险背心（黑色）", 12, /obj/item/clothing/suit/storage/hazardvest/black, null, VENDOR_ITEM_REGULAR),
	list("合成人's Snow Suit", 12, /obj/item/clothing/suit/storage/snow_suit/synth, null, VENDOR_ITEM_REGULAR),
	list("防风夹克，棕色", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_brown, null, VENDOR_ITEM_REGULAR),
	list("防风夹克，灰色", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_gray, null, VENDOR_ITEM_REGULAR),
	list("防风夹克，绿色", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_green, null, VENDOR_ITEM_REGULAR),
	list("防风夹克，第一响应者", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_fr, null, VENDOR_ITEM_REGULAR),
	list("防风服，探索", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_covenant, null, VENDOR_ITEM_REGULAR),
	list("实验服", 12, /obj/item/clothing/suit/storage/labcoat, null, VENDOR_ITEM_REGULAR),
	list("实验服，研究员", 12, /obj/item/clothing/suit/storage/labcoat/researcher, null, VENDOR_ITEM_REGULAR),
	list("实验服，药剂医师", 12, /obj/item/clothing/suit/storage/labcoat/pharmacist, null, VENDOR_ITEM_REGULAR),
	list("高开叉实验服", 12, /obj/item/clothing/suit/storage/labcoat/short, null, VENDOR_ITEM_REGULAR),
	list("低领实验服", 12, /obj/item/clothing/suit/storage/labcoat/long, null, VENDOR_ITEM_REGULAR),
	list("医疗区's Apron", 12, /obj/item/clothing/suit/chef/classic/medical, null, VENDOR_ITEM_REGULAR),
	list("军需官夹克", 12, /obj/item/clothing/suit/storage/jacket/marine/RO, null, VENDOR_ITEM_REGULAR),
	list("生物装甲", 12, /obj/item/clothing/suit/storage/synthbio, null, VENDOR_ITEM_REGULAR),
	list("黑色西装外套", 12, /obj/item/clothing/suit/storage/jacket/marine/corporate/black, null, VENDOR_ITEM_REGULAR),
	list("棕色西装外套", 12, /obj/item/clothing/suit/storage/jacket/marine/corporate/brown, null, VENDOR_ITEM_REGULAR),
	list("蓝色西装外套", 12, /obj/item/clothing/suit/storage/jacket/marine/corporate/blue, null, VENDOR_ITEM_REGULAR),
	list("棕色背心", 12, /obj/item/clothing/suit/storage/jacket/marine/vest, null, VENDOR_ITEM_REGULAR),
	list("棕褐色背心", 12, /obj/item/clothing/suit/storage/jacket/marine/vest/tan, null, VENDOR_ITEM_REGULAR),
	list("灰色背心", 12, /obj/item/clothing/suit/storage/jacket/marine/vest/grey, null, VENDOR_ITEM_REGULAR),

	list("背包", 0, null, null, null),
	list("战斗包", 12, /obj/item/storage/backpack/lightpack/upp, null, VENDOR_ITEM_REGULAR),
	list("联合人民阵线 工兵焊接包", 12, /obj/item/storage/backpack/marine/engineerpack/upp, null, VENDOR_ITEM_REGULAR),
	list("皮制挎包", 12, /obj/item/storage/backpack/satchel, null, VENDOR_ITEM_REGULAR),
	list("医疗包", 12, /obj/item/storage/backpack/satchel/med, null, VENDOR_ITEM_REGULAR),

	list("其他", 0, null, null, null),
	list("UPP 徽章", 6, /obj/item/clothing/accessory/patch/upp, null, VENDOR_ITEM_REGULAR),
	list("UPP 海军步兵徽章", 6, /obj/item/clothing/accessory/patch/upp/naval, null, VENDOR_ITEM_REGULAR),
	list("UPP 空降侦察徽章", 6, /obj/item/clothing/accessory/patch/upp/airborne, null, VENDOR_ITEM_REGULAR),
	list("红袖章", 6, /obj/item/clothing/accessory/armband, null, VENDOR_ITEM_REGULAR),
	list("紫色臂章", 6, /obj/item/clothing/accessory/armband/science, null, VENDOR_ITEM_REGULAR),
	list("黄色臂章", 6, /obj/item/clothing/accessory/armband/engine, null, VENDOR_ITEM_REGULAR),
	list("绿色臂章", 6, /obj/item/clothing/accessory/armband/medgreen, null, VENDOR_ITEM_REGULAR),
	list("蓝色领带", 6, /obj/item/clothing/accessory/tie, null, VENDOR_ITEM_REGULAR),
	list("绿领带", 6, /obj/item/clothing/accessory/tie/green, null, VENDOR_ITEM_REGULAR),
	list("黑领结", 6, /obj/item/clothing/accessory/tie/black, null, VENDOR_ITEM_REGULAR),
	list("金领带", 6, /obj/item/clothing/accessory/tie/gold, null, VENDOR_ITEM_REGULAR),
	list("红领带", 6, /obj/item/clothing/accessory/tie/red, null, VENDOR_ITEM_REGULAR),
	list("紫色领带", 6, /obj/item/clothing/accessory/tie/purple, null, VENDOR_ITEM_REGULAR),
	list("礼服手套", 6, /obj/item/clothing/gloves/marine/dress, null, VENDOR_ITEM_REGULAR),
))
