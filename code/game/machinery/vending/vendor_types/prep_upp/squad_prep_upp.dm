//--------------UPP SQUAD GENERAL MUNITION VENDOR--------------

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/upp_squad
	name = "\improper 联合阿拉拉特公司自动弹药小队供应商"
	desc = "一个连接着小规模存储库的自动化补给架，内含各种弹药类型。任何联盟士兵均可访问。"
	req_access = list(ACCESS_UPP_GENERAL)
	vendor_theme = VENDOR_THEME_UPP
	hackable = TRUE
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_STOCK_DYNAMIC

	vend_x_offset = 2

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/upp_squad/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state


/obj/structure/machinery/cm_vending/sorted/cargo_ammo/upp_squad/populate_product_list(scale)
	listed_products = list(
		list("穿甲弹药", -1, null, null),
		list("71型穿甲弹匣（5.45x39毫米口径）", floor(scale * 6), /obj/item/ammo_magazine/rifle/type71/ap, VENDOR_ITEM_REGULAR),

		list("限制性火器弹药", -1, null, null),
		list("Type-19 弹匣（7.62x25mm）", floor(scale * 6), /obj/item/ammo_magazine/smg/pps43, VENDOR_ITEM_REGULAR),
		list("M240 焚化坦克", floor(scale * 3), /obj/item/ammo_magazine/flamer_tank, VENDOR_ITEM_REGULAR),
		)

//--------------UPP SQUAD ARMAMENTS VENDOR--------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/upp_squad
	name = "\improper 联合亚拉腊公司自动化公共事业小队供应商"
	desc = "一个连接着小规模存储库的自动化补给架，内含各种工具和实用物品。任何联盟士兵均可访问。"
	req_access = list(ACCESS_UPP_GENERAL)
	vendor_theme = VENDOR_THEME_UPP
	hackable = TRUE

	vend_x_offset = 2
	vend_y_offset = 1
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_STOCK_DYNAMIC

/obj/structure/machinery/cm_vending/sorted/cargo_guns/upp_squad/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/cargo_guns/upp_squad/populate_product_list(scale)
	listed_products = list(
		list("食物", -1, null, null),
		list("配给", floor(scale * 20), /obj/item/storage/box/mre/upp, VENDOR_ITEM_REGULAR),

		list("工具", -1, null, null),
		list("挖掘工具 (ET)", floor(scale * 2), /obj/item/tool/shovel/etool/folded, VENDOR_ITEM_REGULAR),
		list("螺丝起子", floor(scale * 5), /obj/item/tool/screwdriver, VENDOR_ITEM_REGULAR),
		list("剪线钳", floor(scale * 5), /obj/item/tool/wirecutters, VENDOR_ITEM_REGULAR),
		list("撬棍", floor(scale * 5), /obj/item/tool/crowbar, VENDOR_ITEM_REGULAR),
		list("扳手", floor(scale * 5), /obj/item/tool/wrench, VENDOR_ITEM_REGULAR),
		list("多功能工具", floor(scale * 1), /obj/item/device/multitool, VENDOR_ITEM_REGULAR),
		list("西格森 MCT", floor(scale * 1), /obj/item/tool/weldingtool/simple, VENDOR_ITEM_REGULAR),

		list("闪耀与光芒", -1, null, null),
		list("战斗 手电筒", floor(scale * 5), /obj/item/device/flashlight/combat, VENDOR_ITEM_REGULAR),
		list("手电筒盒", floor(scale * 1), /obj/item/ammo_box/magazine/misc/flashlight, VENDOR_ITEM_REGULAR),
		list("信号弹盒", floor(scale * 1), /obj/item/ammo_box/magazine/misc/flares, VENDOR_ITEM_REGULAR),
		list("M94 标记信号弹包", floor(scale * 10), /obj/item/storage/box/m94, VENDOR_ITEM_REGULAR),
//		list("M89-S 信号弹包", floor(scale * 1), /obj/item/storage/box/m94/signal, VENDOR_ITEM_REGULAR), (removed until signal flares work per faction)

		list("杂项", -1, null, null),
		list("工程师套件", floor(scale * 1), /obj/item/storage/toolkit/empty, VENDOR_ITEM_REGULAR),
		list("地图", floor(scale * 5), /obj/item/map/current_map, VENDOR_ITEM_REGULAR),
		list("灭火器", floor(scale * 5), /obj/item/tool/extinguisher, VENDOR_ITEM_REGULAR),
		list("灭火器（便携式）", floor(scale * 1), /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("滚筒床", floor(scale * 1), /obj/item/roller, VENDOR_ITEM_REGULAR),
		list("砍刀刀鞘（完整）", floor(scale * 5), /obj/item/storage/large_holster/machete/full, VENDOR_ITEM_REGULAR),
		list("双筒望远镜", floor(scale * 1), /obj/item/device/binoculars, VENDOR_ITEM_REGULAR),
		list("备用PDT/L战斗伙伴套件", floor(scale * 3), /obj/item/storage/box/pdt_kit, VENDOR_ITEM_REGULAR),
		list("W-Y品牌可充电迷你电池", floor(scale * 2.5), /obj/item/cell/crap, VENDOR_ITEM_REGULAR),
		list("钉枪弹匣（7x45毫米）", floor(scale * 4), /obj/item/ammo_magazine/smg/nailgun, VENDOR_ITEM_REGULAR)
		)

//--------------UPP SQUAD ATTACHMENTS VENDOR--------------

/obj/structure/machinery/cm_vending/sorted/attachments/upp_squad
	name = "\improper 联盟阿拉拉特公司小队配件供应商"
	desc = "一个连接着小规模存储库的自动化补给架，内含各种武器配件。任何联盟士兵均可访问。"
	req_access = list(ACCESS_UPP_GENERAL)
	vendor_theme = VENDOR_THEME_UPP
	hackable = TRUE
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_STOCK_DYNAMIC

	vend_y_offset = 1

/obj/structure/machinery/cm_vending/sorted/attachments/upp_squad/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/attachments/upp_squad/populate_product_list(scale)
	listed_products = list(
		list("枪管", -1, null, null),
		list("加长枪管", 2.5, /obj/item/attachable/extended_barrel, VENDOR_ITEM_REGULAR),
		list("后坐力补偿器", 2.5, /obj/item/attachable/compensator, VENDOR_ITEM_REGULAR),
		list("抑制器", 2.5, /obj/item/attachable/suppressor, VENDOR_ITEM_REGULAR),

		list("铁路", -1, null, null),
		list("B8智能瞄准镜", 1.5, /obj/item/attachable/alt_iff_scope, VENDOR_ITEM_REGULAR),
		list("磁力束带", 4, /obj/item/attachable/magnetic_harness, VENDOR_ITEM_REGULAR),
		list("S4 2倍伸缩迷你瞄准镜", 2, /obj/item/attachable/scope/mini, VENDOR_ITEM_REGULAR),
		list("S5 红点瞄准镜", 3, /obj/item/attachable/reddot, VENDOR_ITEM_REGULAR),
		list("S6 反射式瞄准镜", 3, /obj/item/attachable/reflex, VENDOR_ITEM_REGULAR),
		list("S8 4倍伸缩式瞄准镜", 2, /obj/item/attachable/scope, VENDOR_ITEM_REGULAR),

		list("下挂式枪管", -1, null, null),
		list("直角握把", 2.5, /obj/item/attachable/angledgrip, VENDOR_ITEM_REGULAR),
		list("两脚架", 2.5, /obj/item/attachable/bipod, VENDOR_ITEM_REGULAR),
		list("连发组件", 1.5, /obj/item/attachable/burstfire_assembly, VENDOR_ITEM_REGULAR),
		list("陀螺稳定器", 1.5, /obj/item/attachable/gyro, VENDOR_ITEM_REGULAR),
		list("激光瞄准镜", 3, /obj/item/attachable/lasersight, VENDOR_ITEM_REGULAR),
		list("迷你火焰喷射器", 1.5, /obj/item/attachable/attached_gun/flamer, VENDOR_ITEM_REGULAR),
		list("XM-VESG-1 火焰喷射器喷嘴", 1.5, /obj/item/attachable/attached_gun/flamer_nozzle, VENDOR_ITEM_REGULAR),
		list("U7 下挂式霰弹枪", 1.5, /obj/item/attachable/attached_gun/shotgun, VENDOR_ITEM_REGULAR),
		list("下挂式灭火器", 1.5, /obj/item/attachable/attached_gun/extinguisher, VENDOR_ITEM_REGULAR),
		list("垂直握把", 3, /obj/item/attachable/verticalgrip, VENDOR_ITEM_REGULAR),

		)

//--------------UPP SQUAD GUN  VENDOR--------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/upp_squad_guns
	name = "\improper 联合阿拉拉特公司小队武器架"
	desc = "一个连接着小规模存储库的自动化补给架，内含各种武器配件。任何联盟士兵均可访问。"
	icon_state = "upp_guns"
	req_access = list(ACCESS_UPP_GENERAL)
	vendor_theme = VENDOR_THEME_UPP
	hackable = TRUE
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_STOCK_DYNAMIC

/obj/structure/machinery/cm_vending/sorted/cargo_guns/upp_squad_guns/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/cargo_guns/upp_squad_guns/populate_product_list(scale)
	listed_products = list(
		list("主要武器", -1, null, null),
		list("71型脉冲步枪", floor(scale * 30), /obj/item/weapon/gun/rifle/type71, VENDOR_ITEM_REGULAR),
		list("71型脉冲步枪卡宾枪", floor(scale * 10), /obj/item/weapon/gun/rifle/type71/carbine, VENDOR_ITEM_REGULAR),
		list("64式冲锋枪", floor(scale * 20), /obj/item/weapon/gun/smg/bizon/upp, VENDOR_ITEM_REGULAR),
		list("23型防暴霰弹枪", floor(scale * 20), /obj/item/weapon/gun/shotgun/type23, VENDOR_ITEM_REGULAR),

		list("常规弹药", -1, null, null),
		list("Type 71 弹匣（5.45x39mm）", floor(scale * 30), /obj/item/ammo_magazine/rifle/type71, VENDOR_ITEM_REGULAR),
		list("64式螺旋弹匣（7.62x19毫米）", floor(scale * 30), /obj/item/ammo_magazine/smg/bizon, VENDOR_ITEM_REGULAR),
		list("重型鹿弹弹盒（8克）", floor(scale * 10), /obj/item/ammo_magazine/shotgun/heavy/buckshot, VENDOR_ITEM_REGULAR),
		list("重型霰弹盒（8克）", floor(scale * 10), /obj/item/ammo_magazine/shotgun/heavy/slug, VENDOR_ITEM_REGULAR),
		list("重型箭弹弹匣（8克）", floor(scale * 6), /obj/item/ammo_magazine/shotgun/heavy/flechette, VENDOR_ITEM_REGULAR),

		list("侧臂", -1, null, null),
		list("73式手枪", floor(scale * 20), /obj/item/weapon/gun/pistol/t73, VENDOR_ITEM_REGULAR),
		list("NP92 手枪", floor(scale * 20), /obj/item/weapon/gun/pistol/np92, VENDOR_ITEM_REGULAR),
		list("ZHNK-72 左轮手枪", floor(scale * 20), /obj/item/weapon/gun/revolver/upp, VENDOR_ITEM_REGULAR),
		list("M82F 信号枪", floor(scale * 10), /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("手枪弹药", -1, null, null),
		list("73式弹匣（7.62x25毫米托卡列夫）", floor(scale * 20), /obj/item/ammo_magazine/pistol/t73, VENDOR_ITEM_REGULAR),
		list("ZHNK-72 快速装弹器（7.62x38mmR）", floor(scale * 20), /obj/item/ammo_magazine/revolver/upp, VENDOR_ITEM_REGULAR),
		list("NP92弹匣（9x18毫米马卡洛夫）", floor(scale * 20), /obj/item/ammo_magazine/pistol/np92, VENDOR_ITEM_REGULAR),

		list("配件", -1, null, null),
		list("Rail 手电筒", floor(scale * 20), /obj/item/attachable/flashlight, VENDOR_ITEM_RECOMMENDED),
		list("下挂式手电筒握把", floor(scale * 10), /obj/item/attachable/flashlight/grip, VENDOR_ITEM_RECOMMENDED),
		list("下挂式榴弹发射器", floor(scale * 20), /obj/item/attachable/attached_gun/grenade, VENDOR_ITEM_REGULAR),
		list("下挂式信号弹发射器", floor(scale * 20), /obj/item/attachable/attached_gun/flare_launcher, VENDOR_ITEM_REGULAR),

		list("公用事业", -1, null, null),
		list("M5 刺刀", floor(scale * 20), /obj/item/attachable/bayonet/upp, VENDOR_ITEM_REGULAR),
		list("M94 标记信号弹包", floor(scale * 10), /obj/item/storage/box/m94, VENDOR_ITEM_RECOMMENDED)
	)
