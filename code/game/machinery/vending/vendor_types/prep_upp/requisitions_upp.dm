//------------UPP REQ VENDORS---------------

//------------ARMAMENTS VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/upp_cargo_guns
	name = "\improper 联合阿拉拉特公司自动化军备供应商"
	desc = "一个连接着大型存储库的自动化补给架，内含各种枪械、爆炸物、携行装备及其他杂项物品。可由后勤技术员访问。"
	icon_state = "upp_guns"
	req_access = list(ACCESS_UPP_GENERAL)
	vendor_theme = VENDOR_THEME_UPP

/obj/structure/machinery/cm_vending/sorted/cargo_guns/upp_cargo_guns/populate_product_list(scale)
	listed_products = list(
		list("主要火器", -1, null, null),
		list("71型脉冲步枪", floor(scale * 60), /obj/item/weapon/gun/rifle/type71, VENDOR_ITEM_REGULAR),
		list("71型脉冲步枪卡宾枪", floor(scale * 20), /obj/item/weapon/gun/rifle/type71/carbine, VENDOR_ITEM_REGULAR),
		list("64式冲锋枪", floor(scale * 60), /obj/item/weapon/gun/smg/bizon/upp, VENDOR_ITEM_REGULAR),
		list("23型防暴霰弹枪", floor(scale * 20), /obj/item/weapon/gun/shotgun/type23, VENDOR_ITEM_REGULAR),

		list("侧臂", -1, null, null),
		list("73式手枪", floor(scale * 50), /obj/item/weapon/gun/pistol/t73, VENDOR_ITEM_REGULAR),
		list("NP92 手枪", floor(scale * 50), /obj/item/weapon/gun/pistol/np92, VENDOR_ITEM_REGULAR),
		list("ZHNK-72 左轮手枪", floor(scale * 50), /obj/item/weapon/gun/revolver/upp, VENDOR_ITEM_REGULAR),
		list("M82F信号枪", floor(scale * 20), /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("限制性火器", -1, null, null),
		list("Type-19 冲锋枪", floor(scale * 3), /obj/item/storage/box/guncase/type19, VENDOR_ITEM_REGULAR),
		list("M240 焚化装置", floor(scale * 2), /obj/item/storage/box/guncase/flamer, VENDOR_ITEM_REGULAR),

		list("爆炸物", -1, null, null),
		list("6型破片手榴弹", floor(scale * 25), /obj/item/explosive/grenade/high_explosive/upp, VENDOR_ITEM_REGULAR),
		list("8型白磷手榴弹", floor(scale * 4), /obj/item/explosive/grenade/phosphorus/upp, VENDOR_ITEM_REGULAR),
		list("烟雾弹", floor(scale * 5), /obj/item/explosive/grenade/smokebomb, VENDOR_ITEM_REGULAR),
		list("塑胶炸药", floor(scale * 4), /obj/item/explosive/plastic, VENDOR_ITEM_REGULAR),
		list("爆破炸药", floor(scale * 4), /obj/item/explosive/plastic/breaching_charge, VENDOR_ITEM_REGULAR),

		list("织带", -1, null, null),
		list("黑色网眼背心", floor(scale * 2), /obj/item/clothing/accessory/storage/black_vest, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", floor(scale * 2), /obj/item/clothing/accessory/storage/black_vest/brown_vest, VENDOR_ITEM_REGULAR),
		list("肩部枪套", floor(scale * 1.5), /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),
		list("蛛网", floor(scale * 5), /obj/item/clothing/accessory/storage/webbing, VENDOR_ITEM_REGULAR),
		list("刀鞘编织", floor(scale * 1), /obj/item/clothing/accessory/storage/knifeharness, VENDOR_ITEM_REGULAR),
		list("投掷袋", floor(scale * 2), /obj/item/clothing/accessory/storage/droppouch, VENDOR_ITEM_REGULAR),
		list("黑色水滴袋", floor(scale * 2), /obj/item/clothing/accessory/storage/droppouch/black, VENDOR_ITEM_REGULAR),
		list("外部织带", floor(scale * 5), /obj/item/clothing/suit/storage/webbing, VENDOR_ITEM_REGULAR),

		list("背包", -1, null, null),
		list("战斗包", floor(scale * 15), /obj/item/storage/backpack/lightpack/upp, VENDOR_ITEM_REGULAR),
		list("烟火技师 G4-1 燃料罐", floor(scale * 2), /obj/item/storage/backpack/marine/engineerpack/flamethrower/kit, VENDOR_ITEM_REGULAR),
		list("联合人民阵线 工兵焊接包", floor(scale * 2), /obj/item/storage/backpack/marine/engineerpack/upp, VENDOR_ITEM_REGULAR),
		list("迫击炮弹背包", floor(scale * 1), /obj/item/storage/backpack/marine/mortarpack, VENDOR_ITEM_REGULAR),
		list("IMP弹药架", floor(scale * 2), /obj/item/storage/backpack/marine/ammo_rack, VENDOR_ITEM_REGULAR),
		list("降落伞", floor(scale * 20), /obj/item/parachute, VENDOR_ITEM_REGULAR),
		list("手榴弹挎包", floor(scale * 2), /obj/item/storage/backpack/marine/grenadepack, VENDOR_ITEM_REGULAR),

		list("腰带", -1, null, null),
		list("41型弹药装载装备", floor(scale * 15), /obj/item/storage/belt/marine/upp, VENDOR_ITEM_REGULAR),
		list("NPZ92 手枪枪套装备", floor(scale * 15), /obj/item/storage/belt/gun/type47, VENDOR_ITEM_REGULAR),
		list("G8-A 通用工具袋", floor(scale * 2), /obj/item/storage/backpack/general_belt, VENDOR_ITEM_REGULAR),
		list("M276 刀锋装备", floor(scale * 5), /obj/item/storage/belt/knifepouch, VENDOR_ITEM_REGULAR),
		list("M276 M82F 枪套装备", floor(scale * 2), /obj/item/storage/belt/gun/flaregun, VENDOR_ITEM_REGULAR),
		list("M276霰弹枪装弹装置", floor(scale * 10), /obj/item/storage/belt/shotgun, VENDOR_ITEM_REGULAR),
		list("M276迫击炮操作员腰带", floor(scale * 2), /obj/item/storage/belt/gun/mortarbelt, VENDOR_ITEM_REGULAR),

		list("袋囊", -1, null, null),
		list("自动注射器袋", floor(scale * 1), /obj/item/storage/pouch/autoinjector, VENDOR_ITEM_REGULAR),
		list("医疗包袋", floor(scale * 2), /obj/item/storage/pouch/medkit, VENDOR_ITEM_REGULAR),
		list("急救包（满）", floor(scale * 5), /obj/item/storage/pouch/firstaid/full, VENDOR_ITEM_REGULAR),
		list("急救响应包", floor(scale * 2), /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("注射器袋", floor(scale * 2), /obj/item/storage/pouch/syringe, VENDOR_ITEM_REGULAR),
		list("工具袋（满）", floor(scale * 2), /obj/item/storage/pouch/tools/full, VENDOR_ITEM_REGULAR),
		list("建造袋", floor(scale * 2), /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("电子钱包", floor(scale * 2), /obj/item/storage/pouch/electronics, VENDOR_ITEM_REGULAR),
		list("爆裂袋", floor(scale * 2), /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("闪光弹包（满）", floor(scale * 5), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("文件袋", floor(scale * 2), /obj/item/storage/pouch/document/small, VENDOR_ITEM_REGULAR),
		list("投石袋", floor(scale * 2), /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),
		list("砍刀袋（已满）", 1, /obj/item/storage/pouch/machete/full, VENDOR_ITEM_REGULAR),
		list("刺刀套", floor(scale * 2), /obj/item/storage/pouch/bayonet, VENDOR_ITEM_REGULAR),
		list("中型通用袋", floor(scale * 2), /obj/item/storage/pouch/general/medium, VENDOR_ITEM_REGULAR),
		list("弹匣袋", floor(scale * 5), /obj/item/storage/pouch/magazine, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹袋", floor(scale * 5), /obj/item/storage/pouch/shotgun, VENDOR_ITEM_REGULAR),
		list("侧臂袋", floor(scale * 5), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", floor(scale * 5), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("油箱绑带袋", floor(scale * 4), /obj/item/storage/pouch/flamertank, VENDOR_ITEM_REGULAR),
		list("大型通用袋", floor(scale * 1), /obj/item/storage/pouch/general/large, VENDOR_ITEM_REGULAR),
		list("大型弹匣袋", floor(scale * 1), /obj/item/storage/pouch/magazine/large, VENDOR_ITEM_REGULAR),
		list("大型霰弹枪弹袋", floor(scale * 1), /obj/item/storage/pouch/shotgun/large, VENDOR_ITEM_REGULAR),

		list("杂项", -1, null, null),
		list("战斗 手电筒", floor(scale * 8), /obj/item/device/flashlight/combat, VENDOR_ITEM_REGULAR),
		list("挖掘工具", floor(scale * 4), /obj/item/tool/shovel/etool/folded, VENDOR_ITEM_REGULAR),
		list("防毒面具", floor(scale * 10), /obj/item/clothing/mask/gas, VENDOR_ITEM_REGULAR),
		list("M89-S 信号弹包", floor(scale * 2), /obj/item/storage/box/m94/signal, VENDOR_ITEM_REGULAR),
		list("M94 标记信号弹包", floor(scale * 10), /obj/item/storage/box/m94, VENDOR_ITEM_REGULAR),
		list("砍刀刀鞘（完整）", floor(scale * 6), /obj/item/storage/large_holster/machete/full, VENDOR_ITEM_REGULAR),
		list("双筒望远镜", floor(scale * 2), /obj/item/device/binoculars, VENDOR_ITEM_REGULAR),
		list("测距仪", floor(scale * 1), /obj/item/device/binoculars/range, VENDOR_ITEM_REGULAR),
		list("激光指示器", floor(scale * 1), /obj/item/device/binoculars/range/designator, VENDOR_ITEM_REGULAR),
		list("焊接护目镜", floor(scale * 3), /obj/item/clothing/glasses/welding, VENDOR_ITEM_REGULAR),
		list("灭火器（便携式）", floor(scale * 3), /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("高容量动力电池", floor(scale * 1), /obj/item/cell/high, VENDOR_ITEM_REGULAR),
		list("哨戒炮网络笔记本电脑", 4, /obj/item/device/sentry_computer, VENDOR_ITEM_REGULAR),
		list("JTAC 手册", floor(scale * 1), /obj/item/pamphlet/skill/jtac, VENDOR_ITEM_REGULAR),
		list("工程手册", floor(scale * 1), /obj/item/pamphlet/skill/engineer, VENDOR_ITEM_REGULAR),
		list("动力装载机认证", 0.75, /obj/item/pamphlet/skill/powerloader, VENDOR_ITEM_REGULAR),
		list("备用PDT/L战斗伙伴套装", floor(scale * 4), /obj/item/storage/box/pdt_kit, VENDOR_ITEM_REGULAR),
		list("W-Y品牌可充电迷你电池", floor(scale * 3), /obj/item/cell/crap, VENDOR_ITEM_REGULAR),
		list("钉枪弹匣（7x45毫米）", floor(scale * 4), /obj/item/ammo_magazine/smg/nailgun, VENDOR_ITEM_REGULAR),

		list("炸药箱", -1, null, null),
		list("M15 破片手榴弹包", 0, /obj/item/storage/box/packet/m15, VENDOR_ITEM_REGULAR),
		list("8型白磷手榴弹包", 0, /obj/item/storage/box/packet/phosphorus/upp, VENDOR_ITEM_REGULAR),
		list("HSDP 手榴弹包", 0, /obj/item/storage/box/packet/smoke, VENDOR_ITEM_REGULAR),
		list("M40 HEDP榴弹包", 0, /obj/item/storage/box/packet/high_explosive, VENDOR_ITEM_REGULAR),
		list("M40 HEDP榴弹箱", 0, /obj/item/storage/box/nade_box, VENDOR_ITEM_REGULAR),
		list("M40 HIDP 手榴弹包", 0, /obj/item/storage/box/packet/incendiary, VENDOR_ITEM_REGULAR),
		list("M40 HIDP 手榴弹箱", 0, /obj/item/storage/box/nade_box/incen, VENDOR_ITEM_REGULAR),

		list("其他箱子", -1, null, null),
		list("战斗手电筒盒", 0, /obj/item/ammo_box/magazine/misc/flashlight/combat, VENDOR_ITEM_REGULAR),
		list("M94标记信号弹包盒", 0, /obj/item/ammo_box/magazine/misc/flares, VENDOR_ITEM_REGULAR),
		list("M89信号弹包箱", 0, /obj/item/ammo_box/magazine/misc/flares/signal, VENDOR_ITEM_REGULAR),
		list("高容量能量电池箱", 0, /obj/item/ammo_box/magazine/misc/power_cell, VENDOR_ITEM_REGULAR),
		list("钉枪弹匣盒（7x45毫米）", floor(scale * 2), /obj/item/ammo_box/magazine/nailgun, VENDOR_ITEM_REGULAR),
		)

//Special cargo-specific vendor with vending offsets
/obj/structure/machinery/cm_vending/sorted/cargo_guns/upp_cargo_guns
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_LOAD_AMMO_BOXES | VEND_STOCK_DYNAMIC //We want to vend to turf not hand, since we are in requisitions
	vend_dir = NORTH
	vend_dir_whitelist = list(WEST, EAST)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/upp_cargo_guns/blend
	icon_state = "upp_req_guns_wall"
	vend_delay = 3
	vend_sound = 'sound/machines/vending_drop.ogg'
	tiles_with = list(
		/obj/structure/window/framed/upp_ship,
		/obj/structure/machinery/door/airlock,
		/turf/closed/wall/upp_ship,
	)

//------------UPP AMMUNITION VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/upp_cargo_ammo
	name = "\improper 联合阿拉拉特公司自动军火贩卖机"
	desc = "一个连接着大型存储库的自动化补给架，内含各种弹药类型。可由后勤技术员访问。"
	icon_state = "req_ammo"
	req_access = list(ACCESS_UPP_GENERAL)
	vendor_theme = VENDOR_THEME_UPP

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/upp_cargo_ammo/populate_product_list(scale)
	listed_products = list(
		list("常规弹药", -1, null, null),
		list("Type 71 弹匣（5.45x39mm）", floor(scale * 100), /obj/item/ammo_magazine/rifle/type71, VENDOR_ITEM_REGULAR),
		list("64式螺旋弹匣（7.62x19毫米）", floor(scale * 100), /obj/item/ammo_magazine/smg/bizon, VENDOR_ITEM_REGULAR),
		list("重型鹿弹弹盒（8克）", floor(scale * 56), /obj/item/ammo_magazine/shotgun/heavy/buckshot, VENDOR_ITEM_REGULAR),
		list("重型弹丸盒（8克）", floor(scale * 56), /obj/item/ammo_magazine/shotgun/heavy/slug, VENDOR_ITEM_REGULAR),
		list("重型箭弹弹匣（8克）", floor(scale * 56), /obj/item/ammo_magazine/shotgun/heavy/flechette, VENDOR_ITEM_REGULAR),
		list("73式弹匣（7.62x25mm 托卡列夫）", floor(scale * 40), /obj/item/ammo_magazine/pistol/t73, VENDOR_ITEM_REGULAR),
		list("ZHNK-72 快速装弹器（7.62x38mmR）", floor(scale * 40), /obj/item/ammo_magazine/revolver/upp, VENDOR_ITEM_REGULAR),
		list("NP92弹匣（9x18毫米马卡洛夫）", floor(scale * 40), /obj/item/ammo_magazine/pistol/np92, VENDOR_ITEM_REGULAR),

		list("穿甲弹药", -1, null, null),
		list("71型穿甲弹匣（5.45x39毫米口径）", floor(scale * 10), /obj/item/ammo_magazine/rifle/type71/ap, VENDOR_ITEM_REGULAR),

		list("限制级火器弹药", -1, null, null),
		list("Type-19弹匣（7.62x25mm口径）", floor(scale * 12), /obj/item/ammo_magazine/smg/pps43, VENDOR_ITEM_REGULAR),
		list("Type-19弹鼓（7.62x25mm口径）", floor(scale * 1), /obj/item/ammo_magazine/smg/pps43/extended, VENDOR_ITEM_REGULAR),
		list("M240 焚化坦克", floor(scale * 3), /obj/item/ammo_magazine/flamer_tank, VENDOR_ITEM_REGULAR),

		list("弹匣盒", -1, null, null),
		list("弹匣盒（71式步枪用 x 10）", 0, /obj/item/ammo_box/magazine/type71, VENDOR_ITEM_REGULAR),
		list("弹匣盒（AP Type 71步枪 x 10）", 0, /obj/item/ammo_box/magazine/type71/ap, VENDOR_ITEM_REGULAR),
		list("弹匣盒（64型野牛 x 10）", 0, /obj/item/ammo_box/magazine/type64, VENDOR_ITEM_REGULAR),
		list("弹匣盒（73式手枪 x 16）", 0, /obj/item/ammo_box/magazine/type73, VENDOR_ITEM_REGULAR),
		list("快速装弹器盒（ZhNK-72 x 12）", 0, /obj/item/ammo_box/magazine/zhnk, VENDOR_ITEM_REGULAR),
		list("弹匣盒（Type19 x 12）", 0, /obj/item/ammo_box/magazine/type19, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹盒（独头弹 8g x 100）", 0, /obj/item/ammo_box/magazine/shotgun/upp, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹盒（8号鹿弹 x 100发）", 0, /obj/item/ammo_box/magazine/shotgun/upp/buckshot, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹盒（箭形弹 8g x 100）", 0, /obj/item/ammo_box/magazine/shotgun/upp/flechette, VENDOR_ITEM_REGULAR),
		list("火焰坦克补给箱（UT-萘燃料 x 8）", 0, /obj/item/ammo_box/magazine/flamer, VENDOR_ITEM_REGULAR),
		)

//Special cargo-specific vendor with vending offsets
/obj/structure/machinery/cm_vending/sorted/cargo_ammo/upp_cargo_ammo
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_LOAD_AMMO_BOXES | VEND_STOCK_DYNAMIC //We want to vend to turf not hand, since we are in requisitions
	vend_dir = NORTH
	vend_dir_whitelist = list(NORTHWEST, NORTHEAST)

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/upp_cargo_ammo/blend
	icon_state = "upp_req_ammo_wall"
	vend_delay = 3
	vend_sound = 'sound/machines/vending_drop.ogg'
	tiles_with = list(
		/obj/structure/window/framed/upp_ship,
		/obj/structure/machinery/door/airlock,
		/turf/closed/wall/upp_ship,
	)

//------------ATTACHMENTS VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/attachments/upp_attachments
	name = "\improper 联合阿拉拉特公司配件供应商"
	desc = "一个连接着大型存储库的自动化补给架，内含各种武器配件。可由后勤技术员访问。"
	req_access = list(ACCESS_UPP_GENERAL)
	vendor_theme = VENDOR_THEME_UPP

/obj/structure/machinery/cm_vending/sorted/attachments/upp_attachments/populate_product_list(scale)
	listed_products = list(
		list("枪管", -1, null, null),
		list("加长枪管", 6.5, /obj/item/attachable/extended_barrel, VENDOR_ITEM_REGULAR),
		list("M5刺刀", 10.5, /obj/item/attachable/bayonet, VENDOR_ITEM_REGULAR),
		list("后坐力补偿器", 6.5, /obj/item/attachable/compensator, VENDOR_ITEM_REGULAR),
		list("消音器", 6.5, /obj/item/attachable/suppressor, VENDOR_ITEM_REGULAR),

		list("铁路", -1, null, null),
		list("B8智能瞄准镜", 3.5, /obj/item/attachable/alt_iff_scope, VENDOR_ITEM_REGULAR),
		list("磁力束带", 8.5, /obj/item/attachable/magnetic_harness, VENDOR_ITEM_REGULAR),
		list("Rail 手电筒", 10.5, /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
		list("S4 2倍伸缩迷你瞄准镜", 4.5, /obj/item/attachable/scope/mini, VENDOR_ITEM_REGULAR),
		list("S5 红点瞄准镜", 9.5, /obj/item/attachable/reddot, VENDOR_ITEM_REGULAR),
		list("S6 反射式瞄准镜", 9.5, /obj/item/attachable/reflex, VENDOR_ITEM_REGULAR),
		list("S8 4倍伸缩瞄准镜", 4.5, /obj/item/attachable/scope, VENDOR_ITEM_REGULAR),

		list("下挂式枪管", -1, null, null),
		list("直角握把", 6.5, /obj/item/attachable/angledgrip, VENDOR_ITEM_REGULAR),
		list("两脚架", 6.5, /obj/item/attachable/bipod, VENDOR_ITEM_REGULAR),
		list("连发组件", 4.5, /obj/item/attachable/burstfire_assembly, VENDOR_ITEM_REGULAR),
		list("陀螺稳定器", 4.5, /obj/item/attachable/gyro, VENDOR_ITEM_REGULAR),
		list("激光瞄准镜", 9.5, /obj/item/attachable/lasersight, VENDOR_ITEM_REGULAR),
		list("迷你火焰喷射器", 4.5, /obj/item/attachable/attached_gun/flamer, VENDOR_ITEM_REGULAR),
		list("XM-VESG-1 火焰喷射器喷嘴", 4.5, /obj/item/attachable/attached_gun/flamer_nozzle, VENDOR_ITEM_REGULAR),
		list("U7 下挂式霰弹枪", 4.5, /obj/item/attachable/attached_gun/shotgun, VENDOR_ITEM_REGULAR),
		list("下挂式灭火器", 4.5, /obj/item/attachable/attached_gun/extinguisher, VENDOR_ITEM_REGULAR),
		list("下挂式手电筒握把", 9.5, /obj/item/attachable/flashlight/grip, VENDOR_ITEM_REGULAR),
		list("垂直握把", 9.5, /obj/item/attachable/verticalgrip, VENDOR_ITEM_REGULAR),
		)

//Special cargo-specific vendor with vending offsets
/obj/structure/machinery/cm_vending/sorted/attachments/upp_attachments
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_LOAD_AMMO_BOXES | VEND_STOCK_DYNAMIC //We want to vend to turf not hand, since we are in requisitions
	vend_dir = NORTH
	vend_dir_whitelist = list(SOUTHWEST, SOUTHEAST)

/obj/structure/machinery/cm_vending/sorted/attachments/upp_attachments/blend
	icon_state = "upp_req_attach_wall"
	vend_delay = 3
	vend_sound = 'sound/machines/vending_drop.ogg'
	tiles_with = list(
		/obj/structure/window/framed/upp_ship,
		/obj/structure/machinery/door/airlock,
		/turf/closed/wall/upp_ship,
	)

//------------UNIFORM VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/uniform_supply/upp_uniform
	name = "\improper 联合阿拉拉特公司剩余制服供应商"
	desc = "一个连接着大型存储库的自动化补给架，内含标准陆战队员制服。可由后勤技术员访问。"
	icon_state = "upp_clothing"
	req_access = list()
	req_one_access = list(ACCESS_UPP_GENERAL)
	vendor_theme = VENDOR_THEME_UPP

/obj/structure/machinery/cm_vending/sorted/uniform_supply/upp_uniform/populate_product_list(scale)
	listed_products = list(
		list("制服", -1, null, null),
		list("联合人民阵线 作战服", floor(scale * 20), /obj/item/clothing/under/marine/veteran/UPP, VENDOR_ITEM_REGULAR),
		list("联合人民阵线 医疗兵制服", 5, /obj/item/clothing/under/marine/veteran/UPP/medic, VENDOR_ITEM_REGULAR),
		list("联合人民阵线 工兵作战服", 5, /obj/item/clothing/under/marine/veteran/UPP/engi, VENDOR_ITEM_REGULAR),

		list("靴子", -1, null, null),
		list("士兵战斗靴", 20, /obj/item/clothing/shoes/marine/upp/knife, VENDOR_ITEM_REGULAR),

		list("背包", -1, null, null),
		list("战斗包", 20, /obj/item/storage/backpack/lightpack/upp, VENDOR_ITEM_REGULAR),
		list("联合人民阵线 工兵焊接包", 10, /obj/item/storage/backpack/marine/engineerpack/upp, VENDOR_ITEM_REGULAR),

		list("护甲", -1, null, null),
		list("UM5中型个人护甲", 20, /obj/item/clothing/suit/storage/marine/faction/UPP, VENDOR_ITEM_REGULAR),
		list("UL6轻型个人护甲", 20, /obj/item/clothing/suit/storage/marine/faction/UPP/support, VENDOR_ITEM_REGULAR),

		list("手套", -1, null, null),
		list("士兵战斗手套", 40, /obj/item/clothing/gloves/marine/veteran/upp, VENDOR_ITEM_REGULAR),

		list("无线电", -1, null, null),
		list("工程/JTAC加密密钥", 5, /obj/item/device/encryptionkey/upp/engi, VENDOR_ITEM_REGULAR),
		list("医疗加密密钥", 5, /obj/item/device/encryptionkey/upp/medic, VENDOR_ITEM_REGULAR),

		list("面具", -1, null, null, null),
		list("防毒面具", 20, /obj/item/clothing/mask/gas, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 10, /obj/item/clothing/mask/rebreather/scarf, VENDOR_ITEM_REGULAR),

		list("杂项", -1, null, null),
		list("铺盖卷", 30, /obj/item/roller/bedroll, VENDOR_ITEM_REGULAR),
		)
