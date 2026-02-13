//------------VEHICLE MODULES VENDOR---------------

/obj/structure/machinery/cm_vending/gear/vehicle_crew
	name = "ColMarTech车辆零件输送系统"
	desc = "一个连接在舰船腹部的自动化补给系统。允许载具乘员在行动开始时为其载具选择一套免费装备，并在指挥部提供额外预算时订购更多备用零件。仅限载具乘员访问。"
	icon = 'icons/obj/structures/machinery/vending_64x32.dmi'
	icon_state = "vehicle_gear"

	req_access = list(ACCESS_MARINE_CREWMAN)
	vendor_role = list(JOB_TANK_CREW)
	bound_width = 64

	unslashable = TRUE

	vend_delay = 4 SECONDS
	vend_sound = 'sound/machines/medevac_extend.ogg'

	var/selected_vehicle
	var/budget_points = 0
	var/available_categories = VEHICLE_ALL_AVAILABLE

	available_points_to_display = 0

	vend_flags = VEND_CLUTTER_PROTECTION|VEND_CATEGORY_CHECK|VEND_TO_HAND|VEND_USE_VENDOR_FLAGS
	var/faction = FACTION_MARINE
	var/datum/controller/supply/linked_supply_controller

/obj/structure/machinery/cm_vending/gear/vehicle_crew/Initialize(mapload, ...)
	. = ..()
	switch(faction)
		if(FACTION_MARINE)
			linked_supply_controller = GLOB.supply_controller
		if(FACTION_UPP)
			linked_supply_controller = GLOB.supply_controller_upp
		else
			linked_supply_controller = GLOB.supply_controller //we default to normal budget on wrong input

	RegisterSignal(SSdcs, COMSIG_GLOB_VEHICLE_ORDERED, PROC_REF(populate_products))
	if(!GLOB.VehicleGearConsole)
		GLOB.VehicleGearConsole = src

/obj/structure/machinery/cm_vending/gear/vehicle_crew/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOB_VEHICLE_ORDERED)
	GLOB.VehicleGearConsole = null
	return ..()

/obj/structure/machinery/cm_vending/gear/vehicle_crew/get_appropriate_vend_turf(mob/living/carbon/human/H)
	var/turf/target = get_turf(src)
	target = get_step(target, SOUTH)
	return target

/obj/structure/machinery/cm_vending/gear/vehicle_crew/tip_over() //we don't do this here
	return

/obj/structure/machinery/cm_vending/gear/vehicle_crew/flip_back()
	return

/obj/structure/machinery/cm_vending/gear/vehicle_crew/ex_act(severity)
	if(severity > EXPLOSION_THRESHOLD_LOW)
		if(prob(25))
			malfunction()
			return

/obj/structure/machinery/cm_vending/gear/vehicle_crew/proc/populate_products(datum/source, obj/vehicle/multitile/V)
	SIGNAL_HANDLER
	UnregisterSignal(SSdcs, COMSIG_GLOB_VEHICLE_ORDERED)

	if(!selected_vehicle)
		selected_vehicle = "TANK" // The whole thing seems to be based upon the assumption you unlock tank as an override, defaulting to APC
	if(selected_vehicle == "TANK")
		available_categories &= ~(VEHICLE_INTEGRAL_AVAILABLE) //APC lacks these, so we need to remove these flags to be able to access spare parts section
		marine_announcement("一辆坦克正被派来增援此次行动。")

/obj/structure/machinery/cm_vending/gear/vehicle_crew/get_listed_products(mob/user)
	var/list/display_list = list()

	if(!user)
		display_list += GLOB.cm_vending_vehicle_crew_tank
		display_list += GLOB.cm_vending_vehicle_crew_apc
		return display_list

	switch(selected_vehicle)
		if("TANK")
			if(available_categories)
				display_list = GLOB.cm_vending_vehicle_crew_tank

		if("ARC")
			display_list = GLOB.cm_vending_vehicle_crew_arc

		if("APC")
			if(available_categories)
				display_list = GLOB.cm_vending_vehicle_crew_apc
		else //APC stuff costs more to prevent 4000 points spent on shitton of ammunition
			display_list = GLOB.cm_vending_vehicle_crew_apc_spare
	return display_list

/obj/structure/machinery/cm_vending/gear/vehicle_crew/ui_data(mob/user)
	. = list()
	. += ui_static_data(user)

	if(linked_supply_controller.tank_points) //we steal points from GLOB.supply_controller, meh-he-he. Solely to be able to modify amount of points in vendor if needed by just changing one var.
		available_points_to_display = linked_supply_controller.tank_points
		linked_supply_controller.tank_points = 0
	.["current_m_points"] = available_points_to_display

	var/list/ui_listed_products = get_listed_products(user)
	var/list/stock_values = list()
	for (var/i in 1 to length(ui_listed_products))
		var/list/myprod = ui_listed_products[i] //we take one list from listed_products
		var/prod_available = FALSE
		var/p_cost = myprod[2]
		var/avail_flag = myprod[4]
		if(budget_points >= p_cost && (!avail_flag || available_categories & avail_flag))
			prod_available = TRUE
		stock_values += list(prod_available)

	.["stock_listing"] = stock_values

/obj/structure/machinery/cm_vending/gear/vehicle_crew/handle_points(mob/living/carbon/human/H, list/L)
	. = TRUE
	if(available_categories)
		if(!(available_categories & L[4]))
			to_chat(usr, SPAN_WARNING("此类别模块已被占用。"))
			vend_fail()
			return FALSE
		available_categories &= ~L[4]
	else
		if(available_points_to_display < L[2])
			to_chat(H, SPAN_WARNING("点数不足。"))
			vend_fail()
			return FALSE
		budget_points -= L[2]

GLOBAL_LIST_INIT(cm_vending_vehicle_crew_tank, list(
	list("初始装备选择：", 0, null, null, null),

	list("组成部分", 0, null, null, null),
	list("M34A2-A 多用途炮塔", 0, /obj/effect/essentials_set/tank/turret, VEHICLE_INTEGRAL_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("主武器", 0, null, null, null),
	list("AC3-E 自动加农炮", 0, /obj/effect/essentials_set/tank/autocannon, VEHICLE_PRIMARY_AVAILABLE, VENDOR_ITEM_RECOMMENDED),
	list("DRG-N 进攻型火焰喷射器单位", 0, /obj/effect/essentials_set/tank/dragonflamer, VEHICLE_PRIMARY_AVAILABLE, VENDOR_ITEM_REGULAR),
	list("LTAA-AP 迷你炮", 0, /obj/effect/essentials_set/tank/gatling, VEHICLE_PRIMARY_AVAILABLE, VENDOR_ITEM_REGULAR),

	list("副武器", 0, null, null, null),
	list("M92T 榴弹发射器", 0, /obj/effect/essentials_set/tank/tankgl, VEHICLE_SECONDARY_AVAILABLE, VENDOR_ITEM_REGULAR),
	list("M56 炮塔", 0, /obj/effect/essentials_set/tank/m56cupola, VEHICLE_SECONDARY_AVAILABLE, VENDOR_ITEM_REGULAR),
	list("LZR-N 火焰喷射器单元", 0, /obj/effect/essentials_set/tank/tankflamer, VEHICLE_SECONDARY_AVAILABLE, VENDOR_ITEM_RECOMMENDED),

	list("S联合人民阵线ORT模块", 0, null, null, null),
	list("火炮模块", 0, /obj/item/hardpoint/support/artillery_module, VEHICLE_SUPPORT_AVAILABLE, VENDOR_ITEM_REGULAR),
	list("集成武器传感器阵列", 0, /obj/item/hardpoint/support/weapons_sensor, VEHICLE_SUPPORT_AVAILABLE, VENDOR_ITEM_REGULAR),
	list("超频增强器", 0, /obj/item/hardpoint/support/overdrive_enhancer, VEHICLE_SUPPORT_AVAILABLE, VENDOR_ITEM_RECOMMENDED),

	list("护甲", 0, null, null, null),
	list("扫雪车", 0, /obj/item/hardpoint/armor/snowplow, VEHICLE_ARMOR_AVAILABLE, VENDOR_ITEM_REGULAR),

	list("履带", 0, null, null, null),
	list("强化履带", 0, /obj/item/hardpoint/locomotion/treads/robust, VEHICLE_TREADS_AVAILABLE, VENDOR_ITEM_REGULAR),
	list("履带", 0, /obj/item/hardpoint/locomotion/treads, VEHICLE_TREADS_AVAILABLE, VENDOR_ITEM_REGULAR)))

GLOBAL_LIST_INIT(cm_vending_vehicle_crew_apc, list(
	list("初始装备选择：", 0, null, null, null),

	list("主武器", 0, null, null, null),
	list("PARS-159 博雅尔双管炮", 0, /obj/effect/essentials_set/apc/dualcannon, VEHICLE_PRIMARY_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("次要武器", 0, null, null, null),
	list("RE-RE700 正面加农炮", 0, /obj/effect/essentials_set/apc/frontalcannon, VEHICLE_SECONDARY_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("S联合人民阵线ORT模块", 0, null, null, null),
	list("M-97F 信号弹发射器", 0, /obj/effect/essentials_set/apc/flarelauncher, VEHICLE_SUPPORT_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("车轮", 0, null, null, null),
	list("APC轮毂", 0, /obj/item/hardpoint/locomotion/apc_wheels, VEHICLE_TREADS_AVAILABLE, VENDOR_ITEM_MANDATORY)))

GLOBAL_LIST_INIT(cm_vending_vehicle_crew_apc_spare, list(
	list("备用零件选择：", 0, null, null, null),

	list("主武器", 0, null, null, null),
	list("PARS-159 博雅尔双联炮", 500, /obj/item/hardpoint/primary/dualcannon, null, VENDOR_ITEM_REGULAR),

	list("主要弹药", 0, null, null, null),
	list("PARS-159 双管炮弹匣", 150, /obj/item/ammo_magazine/hardpoint/ace_autocannon, null, VENDOR_ITEM_REGULAR),

	list("副武器", 0, null, null, null),
	list("RE-RE700 正面加农炮", 400, /obj/item/hardpoint/secondary/frontalcannon, null, VENDOR_ITEM_REGULAR),

	list("次要弹药", 0, null, null, null),
	list("RE-RE700 前部加农炮弹匣", 150, /obj/item/ammo_magazine/hardpoint/tank_glauncher, null, VENDOR_ITEM_REGULAR),

	list("S联合人民阵线ORT模块", 0, null, null, null),
	list("M-97F 信号弹发射器", 300, /obj/item/hardpoint/support/flare_launcher, null, VENDOR_ITEM_REGULAR),

	list("S联合人民阵线弹药", 0, null, null, null),
	list("M-97F 信号弹发射器弹匣", 50, /obj/item/ammo_magazine/hardpoint/flare_launcher, null, VENDOR_ITEM_REGULAR),

	list("车轮", 0, null, null, null),
	list("APC轮毂", 200, /obj/item/hardpoint/locomotion/apc_wheels, null, VENDOR_ITEM_REGULAR)))

GLOBAL_LIST_INIT(cm_vending_vehicle_crew_arc, list(
	list("初始装备选择：", 0, null, null, null),

	list("车轮", 0, null, null, null),
	list("替换ARC轮毂", 0, /obj/item/hardpoint/locomotion/arc_wheels, VEHICLE_TREADS_AVAILABLE, VENDOR_ITEM_MANDATORY)))

//------------WEAPONS RACK---------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/vehicle_crew
	name = "\improper 殖民地海军陆战队科技 载具乘员武器架"
	desc = "一个连接着小规模标准制式武器库的自动化武器架。仅限载具乘员访问。"
	icon_state = "guns"
	req_access = list(ACCESS_MARINE_CREWMAN)
	vendor_role = list(JOB_TANK_CREW)
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND

	listed_products = list(
		list("主要火器", -1, null, null),
		list("M4RA 战斗步枪", 2, /obj/item/weapon/gun/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("M37A2 泵动式霰弹枪", 2, /obj/item/weapon/gun/shotgun/pump/m37a, VENDOR_ITEM_REGULAR),
		list("M39 冲锋枪", 2, /obj/item/weapon/gun/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A脉冲步枪MK2", 2, /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_REGULAR),

		list("主要弹药", -1, null, null),
		list("霰弹盒（12号口径）", 6, /obj/item/ammo_magazine/shotgun/buckshot, VENDOR_ITEM_REGULAR),
		list("盒装箭弹（12号口径）", 6, /obj/item/ammo_magazine/shotgun/flechette, VENDOR_ITEM_REGULAR),
		list("霰弹枪独头弹盒（12号口径）", 6, /obj/item/ammo_magazine/shotgun/slugs, VENDOR_ITEM_REGULAR),
		list("M4RA 弹匣（10x24毫米）", 12, /obj/item/ammo_magazine/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("M39 HV 弹匣（10x20毫米）", 12, /obj/item/ammo_magazine/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A弹匣（10x24毫米）", 12, /obj/item/ammo_magazine/rifle, VENDOR_ITEM_REGULAR),

		list("侧臂", -1, null, null),
		list("M10自动手枪", 2, /obj/item/weapon/gun/pistol/m10, VENDOR_ITEM_REGULAR),
		list("88 型 4 战斗手枪", 2, /obj/item/weapon/gun/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44 战斗左轮手枪", 2, /obj/item/weapon/gun/revolver/m44, VENDOR_ITEM_REGULAR),
		list("M4A3 制式手枪", 2, /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),
		list("M82F信号枪", 2, /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("手枪弹药", -1, null, null),
		list("M10 高威力弹匣（10x20mm-APC）", 10, /obj/item/ammo_magazine/pistol/m10, VENDOR_ITEM_REGULAR),
		list("88M4 AP 弹匣（9毫米）", 10, /obj/item/ammo_magazine/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44快速装弹器（.44口径）", 10, /obj/item/ammo_magazine/revolver, VENDOR_ITEM_REGULAR),
		list("M4A3弹匣（9毫米）", 10, /obj/item/ammo_magazine/pistol, VENDOR_ITEM_REGULAR),
		list("M4A3 穿甲弹匣（9毫米）", 6, /obj/item/ammo_magazine/pistol/ap, VENDOR_ITEM_REGULAR),
		list("M4A3 HP 弹匣（9毫米）", 6, /obj/item/ammo_magazine/pistol/hp, VENDOR_ITEM_REGULAR),
		list("VP78 弹匣（9毫米）", 8, /obj/item/ammo_magazine/pistol/vp78, VENDOR_ITEM_REGULAR),

		list("附件", -1, null, null),
		list("磁力背带", 2, /obj/item/attachable/magnetic_harness, VENDOR_ITEM_REGULAR),
		list("Rail 手电筒", 4, /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
		list("下挂式手电筒握把", 4, /obj/item/attachable/flashlight/grip, VENDOR_ITEM_REGULAR),

		list("公用事业", -1, null, null),
		list("战斗 手电筒", 2, /obj/item/device/flashlight/combat, VENDOR_ITEM_REGULAR),
		list("M5刺刀", 2, /obj/item/attachable/bayonet, VENDOR_ITEM_REGULAR),
		list("M89-S 信号弹包", 1, /obj/item/storage/box/m94/signal, VENDOR_ITEM_REGULAR),
		list("M94 标记信号弹包", 10, /obj/item/storage/box/m94, VENDOR_ITEM_REGULAR),
		list("砍刀刀鞘（完整）", 2, /obj/item/storage/large_holster/machete/full, VENDOR_ITEM_REGULAR)
	)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/vehicle_crew/populate_product_list(scale)
	return

//------------CLOTHING RACK---------------

GLOBAL_LIST_INIT(cm_vending_clothing_vehicle_crew, list(
		list("标准装备（全部拾取）", 0, null, null, null),
		list("手套", 0, /obj/item/clothing/gloves/yellow, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("坦克装甲", 0, /obj/item/clothing/suit/storage/marine/tanker, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("M50坦克头盔", 0, /obj/item/clothing/head/helmet/marine/tech/tanker, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),
		list("医疗头盔光学镜", 0, /obj/item/device/helmet_visor/medical, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_MANDATORY),
		list("焊接工具包", 0, /obj/item/tool/weldpack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("单兵即食口粮", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),

		list("个人副武器（选择1）", 0, null, null, null),
		list("88 型 4 战斗手枪", 0, /obj/item/weapon/gun/pistol/mod88, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("VP78 手枪", 0, /obj/item/weapon/gun/pistol/vp78, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),

		list("腰带（选择1）", 0, null, null, null),
		list("G8-A 通用工具袋", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M103 车辆弹药补给车", 0, /obj/item/storage/belt/tank, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276弹药装载装置", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276通用手枪套携行系统", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M39 手枪套装备", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M10 枪套装备", 0, /obj/item/storage/belt/gun/m10, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276通用左轮手枪套装备", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M82F 枪套装备", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276霰弹枪装弹装置", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 工具腰带装备（全套）", 0, /obj/item/storage/belt/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("小袋（任选2个）", 0, null, null, null),
		list("急救包（可重复填充自动注射器）", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（含夹板、纱布、药膏）", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("急救包（药片包）", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("闪光弹袋（满）", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型通用袋", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型弹匣袋", 0, /obj/item/storage/pouch/magazine/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("大型霰弹枪弹袋", 0, /obj/item/storage/pouch/shotgun/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("侧臂袋", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("投石袋", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("工具袋（满）", 0, /obj/item/storage/pouch/tools/tank, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),

		list("配件（任选1件）", 0, null, null, null),
		list("棕色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("黑色网眼背心", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("蛛网", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("面具（选择1个）", 0, null, null, null),
		list("防毒面具", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("附件", 0, null, null, null),
		list("直角握把", 10, /obj/item/attachable/angledgrip, null, VENDOR_ITEM_REGULAR),
		list("加长枪管", 10, /obj/item/attachable/extended_barrel, null, VENDOR_ITEM_REGULAR),
		list("陀螺稳定器", 10, /obj/item/attachable/gyro, null, VENDOR_ITEM_REGULAR),
		list("激光瞄准镜", 10, /obj/item/attachable/lasersight, null, VENDOR_ITEM_REGULAR),
		list("万能钥匙霰弹枪", 10, /obj/item/attachable/attached_gun/shotgun, null, VENDOR_ITEM_REGULAR),
		list("M10 实心库存", 10, /obj/item/attachable/stock/m10_solid, null, VENDOR_ITEM_REGULAR),
		list("M37A2 可折叠枪托", 10, /obj/item/attachable/stock/synth/collapsible, null, VENDOR_ITEM_REGULAR),
		list("M39 枪托", 10, /obj/item/attachable/stock/smg, null, VENDOR_ITEM_REGULAR),
		list("M41A 实心枪托", 10, /obj/item/attachable/stock/rifle, null, VENDOR_ITEM_REGULAR),
		list("延长型后坐力补偿器", 10, /obj/item/attachable/extended_barrel/vented, null, VENDOR_ITEM_REGULAR),
		list("后坐力补偿器", 10, /obj/item/attachable/compensator, null, VENDOR_ITEM_REGULAR),
		list("M10补偿器", 10, /obj/item/attachable/compensator/m10, null, VENDOR_ITEM_REGULAR),
		list("红点瞄准镜", 10, /obj/item/attachable/reddot, null, VENDOR_ITEM_REGULAR),
		list("S5-微型红点瞄准镜", 10, /obj/item/attachable/reddot/small, null, VENDOR_ITEM_REGULAR),
		list("反射式瞄准镜", 10, /obj/item/attachable/reflex, null, VENDOR_ITEM_REGULAR),
		list("抑制器", 10, /obj/item/attachable/suppressor, null, VENDOR_ITEM_REGULAR),
		list("抑制器，紧凑型", 10, /obj/item/attachable/suppressor/sleek, null, VENDOR_ITEM_REGULAR),
		list("垂直握把", 10, /obj/item/attachable/verticalgrip, null, VENDOR_ITEM_REGULAR),

		list("弹药", 0, null, null, null),
		list("M4RA AP 弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/m4ra/ap, null, VENDOR_ITEM_REGULAR),
		list("M4RA 加长弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/m4ra/extended, null, VENDOR_ITEM_REGULAR),
		list("M39穿甲弹匣（10x20毫米）", 10, /obj/item/ammo_magazine/smg/m39/ap , null, VENDOR_ITEM_REGULAR),
		list("M39加长弹匣（10x20毫米）", 10, /obj/item/ammo_magazine/smg/m39/extended , null, VENDOR_ITEM_REGULAR),
		list("M40高爆双用途榴弹", 10, /obj/item/explosive/grenade/high_explosive, null, VENDOR_ITEM_REGULAR),
		list("M41A穿甲弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/ap , null, VENDOR_ITEM_REGULAR),
		list("M41A扩容弹匣（10x24毫米）", 10, /obj/item/ammo_magazine/rifle/extended , null, VENDOR_ITEM_REGULAR),
		list("M44重型快速装弹器（.44口径）", 10, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),

		list("公用事业", 0, null, null, null),
		list("双筒望远镜", 10, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("灭火器（便携式）", 5, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("油箱绑带袋", 5, /obj/item/storage/pouch/flamertank, null, VENDOR_ITEM_REGULAR),
		list("富尔顿装置堆叠", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("大型霰弹枪弹袋", 10, /obj/item/storage/pouch/shotgun/large, null, VENDOR_ITEM_REGULAR),
		list("运动探测器", 15, /obj/item/device/motiondetector, null, VENDOR_ITEM_REGULAR),
		list("塑胶炸药", 10, /obj/item/explosive/plastic, null, VENDOR_ITEM_REGULAR),
		list("滚筒床", 5, /obj/item/roller, null, VENDOR_ITEM_REGULAR),
		list("哨声", 5, /obj/item/clothing/accessory/device/whistle, null, VENDOR_ITEM_REGULAR),
	))

//MARINE_CAN_BUY_SHOES MARINE_CAN_BUY_UNIFORM currently not used
/obj/structure/machinery/cm_vending/clothing/vehicle_crew
	name = "\improper 殖民地海军陆战队科技（ColMarTech）车辆乘员装备架"
	desc = "一个连接着海量载具乘员标准制式装备库的自动化装备架。"
	req_access = list(ACCESS_MARINE_CREWMAN)
	vendor_role = list(JOB_TANK_CREW)

/obj/structure/machinery/cm_vending/clothing/vehicle_crew/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_vehicle_crew

//------------ESSENTIAL SETS---------------

//Not essentials sets but fuck it the code's here
/obj/effect/essentials_set/tank/ltb
	desc = "一门发射86毫米爆破弹的巨炮。被它击中的目标能留下点灰烬都算你走运。"
	spawned_gear_list = list(
		/obj/item/hardpoint/primary/cannon,
		/obj/item/ammo_magazine/hardpoint/ltb_cannon,
		/obj/item/ammo_magazine/hardpoint/ltb_cannon,
		/obj/item/ammo_magazine/hardpoint/ltb_cannon,
		/obj/item/ammo_magazine/hardpoint/ltb_cannon,
		/obj/item/ammo_magazine/hardpoint/ltb_cannon,
	)

/obj/effect/essentials_set/tank/gatling
	desc = "一种使用穿甲弹药的坦克主武器LTAA转轮机炮。枪管在射击时会旋转启动，大幅提升射速和精度。能在数秒内撕碎最厚的墙壁。"
	spawned_gear_list = list(
		/obj/item/hardpoint/primary/minigun,
		/obj/item/ammo_magazine/hardpoint/ltaaap_minigun,
		/obj/item/ammo_magazine/hardpoint/ltaaap_minigun,
	)

/obj/effect/essentials_set/tank/dragonflamer
	desc = "一种重型火焰喷射器，可在广阔范围内喷射高燃烧性凝固汽油。燃料燃烧剧烈而迅速，使其可供装甲载具用于进攻。"
	spawned_gear_list = list(
		/obj/item/hardpoint/primary/flamer,
		/obj/item/ammo_magazine/hardpoint/primary_flamer,
		/obj/item/ammo_magazine/hardpoint/primary_flamer,
	)

/obj/effect/essentials_set/tank/autocannon
	desc = "一种坦克用自动机炮，即使在远距离也能精确射击。装填20毫米爆破弹。"
	spawned_gear_list = list(
		/obj/item/hardpoint/primary/autocannon,
		/obj/item/ammo_magazine/hardpoint/ace_autocannon,
		/obj/item/ammo_magazine/hardpoint/ace_autocannon,
		/obj/item/ammo_magazine/hardpoint/ace_autocannon,
		/obj/item/ammo_magazine/hardpoint/ace_autocannon,
	)

/obj/effect/essentials_set/tank/tankflamer
	desc = "一个小型LZR-N火焰喷射单元——标准火焰喷射器的改进型号。"
	spawned_gear_list = list(
		/obj/item/hardpoint/secondary/small_flamer,
		/obj/item/ammo_magazine/hardpoint/secondary_flamer,
	)

/obj/effect/essentials_set/tank/tow
	desc = "一种五联装火箭发射器，能够快速连续发射四枚火箭弹。"
	spawned_gear_list = list(
		/obj/item/hardpoint/secondary/towlauncher,
		/obj/item/ammo_magazine/hardpoint/towlauncher,
		/obj/item/ammo_magazine/hardpoint/towlauncher,
	)

/obj/effect/essentials_set/tank/m56cupola
	desc = "一挺固定式M56D，发射标准制式10x28毫米弹药。"
	spawned_gear_list = list(
		/obj/item/hardpoint/secondary/m56cupola,
		/obj/item/ammo_magazine/hardpoint/m56_cupola,
	)

/obj/effect/essentials_set/tank/tankgl
	desc = "一种弹匣供弹的榴弹发射器，可容纳10枚榴弹。此型号装填M40榴弹。"
	spawned_gear_list = list(
		/obj/item/hardpoint/secondary/grenade_launcher,
		/obj/item/ammo_magazine/hardpoint/tank_glauncher,
		/obj/item/ammo_magazine/hardpoint/tank_glauncher,
		/obj/item/ammo_magazine/hardpoint/tank_glauncher,
		/obj/item/ammo_magazine/hardpoint/tank_glauncher,
	)

/obj/effect/essentials_set/tank/turret
	spawned_gear_list = list(
		/obj/item/hardpoint/holder/tank_turret,
		/obj/item/ammo_magazine/hardpoint/turret_smoke,
		/obj/item/ammo_magazine/hardpoint/turret_smoke,
	)

/obj/effect/essentials_set/apc/dualcannon
	spawned_gear_list = list(
		/obj/item/hardpoint/primary/dualcannon,
		/obj/item/ammo_magazine/hardpoint/boyars_dualcannon,
		/obj/item/ammo_magazine/hardpoint/boyars_dualcannon,
		/obj/item/ammo_magazine/hardpoint/boyars_dualcannon,
		/obj/item/ammo_magazine/hardpoint/boyars_dualcannon,
	)

/obj/effect/essentials_set/apc/frontalcannon
	spawned_gear_list = list(
		/obj/item/hardpoint/secondary/frontalcannon,
		/obj/item/ammo_magazine/hardpoint/m56_cupola/frontal_cannon,
	)

/obj/effect/essentials_set/apc/flarelauncher
	spawned_gear_list = list(
		/obj/item/hardpoint/support/flare_launcher,
		/obj/item/ammo_magazine/hardpoint/flare_launcher,
		/obj/item/ammo_magazine/hardpoint/flare_launcher,
		/obj/item/ammo_magazine/hardpoint/flare_launcher,
	)
