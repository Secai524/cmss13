//------------REQ VENDORS AND THEIR SQUAD VARIANTS---------------

//------------ARMAMENTS VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns
	name = "\improper 科马尔科技（殖民地海军陆战队科技）自动武器供应商"
	desc = "一个连接大型存储库的自动化补给架，存储各种枪支、爆炸物、携行装备及其他杂项物品。可由军需官和货舱技术员访问。"
	icon_state = "req_guns"
	req_access = list(ACCESS_MARINE_CARGO)
	vendor_theme = VENDOR_THEME_USCM
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_LOAD_AMMO_BOXES | VEND_STOCK_DYNAMIC

/obj/structure/machinery/cm_vending/sorted/cargo_guns/vend_fail()
	return

/obj/structure/machinery/cm_vending/sorted/cargo_guns/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_state

/obj/structure/machinery/cm_vending/sorted/cargo_guns/populate_product_list(scale)
	listed_products = list(
		list("主要火器", -1, null, null),
		list("M37A2 泵动式霰弹枪", floor(scale * 30), /obj/item/weapon/gun/shotgun/pump/m37a, VENDOR_ITEM_REGULAR),
		list("M39 冲锋枪", floor(scale * 60), /obj/item/weapon/gun/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A脉冲步枪MK2", floor(scale * 60), /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_REGULAR),
		list("M4RA 战斗步枪", floor(scale * 20), /obj/item/weapon/gun/rifle/m4ra, VENDOR_ITEM_REGULAR),

		list("侧臂", -1, null, null),
		list("M10自动手枪", floor(scale * 50), /obj/item/weapon/gun/pistol/m10, VENDOR_ITEM_REGULAR),
		list("88 型 4 战斗手枪", floor(scale * 50), /obj/item/weapon/gun/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44 战斗左轮手枪", floor(scale * 50), /obj/item/weapon/gun/revolver/m44, VENDOR_ITEM_REGULAR),
		list("M4A3 制式手枪", floor(scale * 50), /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),
		list("M82F 信号枪", floor(scale * 20), /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("限制性火器", -1, null, null),
		list("VP78 手枪", floor(scale * 4), /obj/item/storage/box/guncase/vp78, VENDOR_ITEM_REGULAR),
		list("SU-6 智能手枪", floor(scale * 3), /obj/item/storage/box/guncase/smartpistol, VENDOR_ITEM_REGULAR),
		list("MOU-53 霰弹枪", floor(scale * 2), /obj/item/storage/box/guncase/mou53, VENDOR_ITEM_REGULAR),
		list("XM88重型步枪", floor(scale * 3), /obj/item/storage/box/guncase/xm88, VENDOR_ITEM_REGULAR),
		list("M41AE2重型脉冲步枪", 2.5, /obj/item/storage/box/guncase/lmg, VENDOR_ITEM_REGULAR),
		list("M41A脉冲步枪MK1", floor(scale * 3), /obj/item/storage/box/guncase/m41aMK1, VENDOR_ITEM_REGULAR),
		list("M56D重型机枪", floor(scale * 2), /obj/item/storage/box/guncase/m56d, VENDOR_ITEM_REGULAR),
		list("M2C重型机枪", floor(scale * 2), /obj/item/storage/box/guncase/m2c, VENDOR_ITEM_REGULAR),
		list("M240 焚化装置", floor(scale * 2), /obj/item/storage/box/guncase/flamer, VENDOR_ITEM_REGULAR),
		list("M85A1 榴弹发射器", floor(scale * 3), /obj/item/storage/box/guncase/m85a1, VENDOR_ITEM_REGULAR),
		list("M10自动手枪，定制版", floor(scale * 3), /obj/item/storage/box/guncase/m10_custom_kit, VENDOR_ITEM_REGULAR),

		list("爆炸物", -1, null, null),
		list("M15破片手榴弹", floor(scale * 2), /obj/item/explosive/grenade/high_explosive/m15, VENDOR_ITEM_REGULAR),
		list("M20 阔刀反步兵地雷", floor(scale * 4), /obj/item/explosive/mine, VENDOR_ITEM_REGULAR),
		list("M40高爆双用途榴弹", floor(scale * 25), /obj/item/explosive/grenade/high_explosive, VENDOR_ITEM_REGULAR),
		list("M40 HIDP燃烧手榴弹", floor(scale * 4), /obj/item/explosive/grenade/incendiary, VENDOR_ITEM_REGULAR),
		list("M40 CCDP 化学复合烟雾弹", floor(scale * 4), /obj/item/explosive/grenade/phosphorus, VENDOR_ITEM_REGULAR),
		list("M40 HSDP 烟雾弹", floor(scale * 5), /obj/item/explosive/grenade/smokebomb, VENDOR_ITEM_REGULAR),
		list("M74 AGM-Frag 空爆榴弹", floor(scale * 4), /obj/item/explosive/grenade/high_explosive/airburst, VENDOR_ITEM_REGULAR),
		list("M74 空爆燃烧榴弹", floor(scale * 4), /obj/item/explosive/grenade/incendiary/airburst, VENDOR_ITEM_REGULAR),
		list("M74 AGM-烟雾空爆手榴弹", floor(scale * 4), /obj/item/explosive/grenade/smokebomb/airburst, VENDOR_ITEM_REGULAR),
		list("M74 AGM-星爆弹", floor(scale * 2), /obj/item/explosive/grenade/high_explosive/airburst/starshell, VENDOR_ITEM_REGULAR),
		list("M74 AGM-大黄蜂炮弹", floor(scale * 4), /obj/item/explosive/grenade/high_explosive/airburst/hornet_shell, VENDOR_ITEM_REGULAR),
		list("G2 电击手雷", floor(scale * 5), /obj/item/explosive/grenade/sebb, VENDOR_ITEM_REGULAR),
		list("M40 HIRR 警棍弹", floor(scale * 8), /obj/item/explosive/grenade/slug/baton, VENDOR_ITEM_REGULAR),
		list("M40 MFHS 金属泡沫手榴弹", floor(scale * 6), /obj/item/explosive/grenade/metal_foam, VENDOR_ITEM_REGULAR),
		list("塑胶炸药", floor(scale * 3), /obj/item/explosive/plastic, VENDOR_ITEM_REGULAR),
		list("爆破炸药", floor(scale * 2), /obj/item/explosive/plastic/breaching_charge, VENDOR_ITEM_REGULAR),
		list("M6H-BRUTE 破门火箭", floor(scale * 3), /obj/item/ammo_magazine/rocket/brute, VENDOR_ITEM_REGULAR),

		list("织带", -1, null, null),
		list("黑色网眼背心", floor(scale * 2), /obj/item/clothing/accessory/storage/black_vest, VENDOR_ITEM_REGULAR),
		list("棕色网眼背心", floor(scale * 2), /obj/item/clothing/accessory/storage/black_vest/brown_vest, VENDOR_ITEM_REGULAR),
		list("腿部挂包", floor(scale * 2), /obj/item/clothing/accessory/storage/black_vest/leg_pouch, VENDOR_ITEM_REGULAR),
		list("腿部小包（黑色）", floor(scale * 2), /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, VENDOR_ITEM_REGULAR),
		list("肩部枪套", floor(scale * 1.5), /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),
		list("织带", floor(scale * 5), /obj/item/clothing/accessory/storage/webbing, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", floor(scale * 5), /obj/item/clothing/accessory/storage/webbing/black, VENDOR_ITEM_REGULAR),
		list("刀鞘织带", floor(scale * 1), /obj/item/clothing/accessory/storage/knifeharness, VENDOR_ITEM_REGULAR),
		list("投掷袋", floor(scale * 2), /obj/item/clothing/accessory/storage/droppouch, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", floor(scale * 2), /obj/item/clothing/accessory/storage/droppouch/black, VENDOR_ITEM_REGULAR),
		list("外部织带", floor(scale * 5), /obj/item/clothing/suit/storage/webbing, VENDOR_ITEM_REGULAR),

		list("背包", -1, null, null),
		list("轻量化IMP背包", floor(scale * 15), /obj/item/storage/backpack/marine, VENDOR_ITEM_REGULAR),
		list("霰弹枪枪套", floor(scale * 10), /obj/item/storage/large_holster/m37, VENDOR_ITEM_REGULAR),
		list("烟火技师 G4-1 燃料罐", floor(scale * 2), /obj/item/storage/backpack/marine/engineerpack/flamethrower/kit, VENDOR_ITEM_REGULAR),
		list("技师焊接包", floor(scale * 2), /obj/item/storage/backpack/marine/engineerpack, VENDOR_ITEM_REGULAR),
		list("迫击炮弹背包", floor(scale * 1), /obj/item/storage/backpack/marine/mortarpack, VENDOR_ITEM_REGULAR),
		list("技师焊工-挎包", floor(scale * 5), /obj/item/storage/backpack/marine/engineerpack/satchel, VENDOR_ITEM_REGULAR),
		list("IMP弹药架", floor(scale * 2), /obj/item/storage/backpack/marine/ammo_rack, VENDOR_ITEM_REGULAR),
		list("无线电电话包", floor(scale * 2), /obj/item/storage/backpack/marine/satchel/rto, VENDOR_ITEM_REGULAR),
		list("降落伞", floor(scale * 20), /obj/item/parachute, VENDOR_ITEM_REGULAR),
		list("手榴弹挎包", floor(scale * 2), /obj/item/storage/backpack/marine/grenadepack, VENDOR_ITEM_REGULAR),

		list("腰带", -1, null, null),
		list("G8-A 通用工具袋", floor(scale * 2), /obj/item/storage/backpack/general_belt, VENDOR_ITEM_REGULAR),
		list("M276弹药装载装置", floor(scale * 15), /obj/item/storage/belt/marine, VENDOR_ITEM_REGULAR),
		list("M276通用手枪携行装具", floor(scale * 10), /obj/item/storage/belt/gun/m4a3, VENDOR_ITEM_REGULAR),
		list("M276 刀锋装备", floor(scale * 5), /obj/item/storage/belt/knifepouch, VENDOR_ITEM_REGULAR),
		list("M276 M39 手枪套装备", floor(scale * 5), /obj/item/storage/belt/gun/m39, VENDOR_ITEM_REGULAR),
		list("M276 M10 枪套装备", floor(scale * 5), /obj/item/storage/belt/gun/m10, VENDOR_ITEM_REGULAR),
		list("M276 M40 榴弹携行具", floor(scale * 2), /obj/item/storage/belt/grenade, VENDOR_ITEM_REGULAR),
		list("M276通用左轮手枪套装备", floor(scale * 5), /obj/item/storage/belt/gun/m44, VENDOR_ITEM_REGULAR),
		list("M276 M82F 枪套装备", floor(scale * 2), /obj/item/storage/belt/gun/flaregun, VENDOR_ITEM_REGULAR),
		list("M276霰弹枪装弹装置", floor(scale * 10), /obj/item/storage/belt/shotgun, VENDOR_ITEM_REGULAR),
		list("M276迫击炮操作员腰带", floor(scale * 2), /obj/item/storage/belt/gun/mortarbelt, VENDOR_ITEM_REGULAR),

		list("袋囊", -1, null, null),
		list("自动注射器袋", floor(scale * 1), /obj/item/storage/pouch/autoinjector, VENDOR_ITEM_REGULAR),
		list("医疗包袋", floor(scale * 2), /obj/item/storage/pouch/medkit, VENDOR_ITEM_REGULAR),
		list("急救包（满）", floor(scale * 5), /obj/item/storage/pouch/firstaid/full, VENDOR_ITEM_REGULAR),
		list("急救员腰包", floor(scale * 2), /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("注射器袋", floor(scale * 2), /obj/item/storage/pouch/syringe, VENDOR_ITEM_REGULAR),
		list("工具袋（满）", floor(scale * 2), /obj/item/storage/pouch/tools/full, VENDOR_ITEM_REGULAR),
		list("建造袋", floor(scale * 2), /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("电子钱包", floor(scale * 2), /obj/item/storage/pouch/electronics, VENDOR_ITEM_REGULAR),
		list("爆裂袋", floor(scale * 2), /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("闪光弹袋（满）", floor(scale * 5), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("文件袋", floor(scale * 2), /obj/item/storage/pouch/document/small, VENDOR_ITEM_REGULAR),
		list("投石袋", floor(scale * 2), /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),
		list("砍刀刀套（已满）", 1, /obj/item/storage/pouch/machete/full, VENDOR_ITEM_REGULAR),
		list("刺刀袋", floor(scale * 2), /obj/item/storage/pouch/bayonet, VENDOR_ITEM_REGULAR),
		list("中型通用袋", floor(scale * 2), /obj/item/storage/pouch/general/medium, VENDOR_ITEM_REGULAR),
		list("弹匣袋", floor(scale * 5), /obj/item/storage/pouch/magazine, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹袋", floor(scale * 5), /obj/item/storage/pouch/shotgun, VENDOR_ITEM_REGULAR),
		list("侧臂袋", floor(scale * 5), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", floor(scale * 5), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("燃料箱绑带袋", floor(scale * 4), /obj/item/storage/pouch/flamertank, VENDOR_ITEM_REGULAR),
		list("大型通用袋", floor(scale * 1), /obj/item/storage/pouch/general/large, VENDOR_ITEM_REGULAR),
		list("大型弹匣袋", floor(scale * 1), /obj/item/storage/pouch/magazine/large, VENDOR_ITEM_REGULAR),
		list("大型霰弹枪弹袋", floor(scale * 1), /obj/item/storage/pouch/shotgun/large, VENDOR_ITEM_REGULAR),

		list("闪耀与光芒", -1, null, null),
		list("战斗 手电筒", floor(scale * 8), /obj/item/device/flashlight/combat, VENDOR_ITEM_REGULAR),
		list("M89-S 信号弹包", floor(scale * 2), /obj/item/storage/box/m94/signal, VENDOR_ITEM_REGULAR),
		list("M94 标记信号弹包", floor(scale * 10), /obj/item/storage/box/m94, VENDOR_ITEM_REGULAR),

		list("必备设备", -1, null, null),
		list("运动探测器", floor(scale * 4), /obj/item/device/motiondetector, VENDOR_ITEM_REGULAR),
		list("数据探测器", floor(scale * 4), /obj/item/device/motiondetector/intel, VENDOR_ITEM_REGULAR),
		list("双筒望远镜", floor(scale * 2), /obj/item/device/binoculars, VENDOR_ITEM_REGULAR),
		list("测距仪", floor(scale * 1), /obj/item/device/binoculars/range, VENDOR_ITEM_REGULAR),
		list("激光指示器", floor(scale * 1), /obj/item/device/binoculars/range/designator, VENDOR_ITEM_REGULAR),
		list("富尔顿装置堆叠", floor(scale * 1), /obj/item/stack/fulton, VENDOR_ITEM_REGULAR),
		list("哨戒炮网络笔记本电脑", 4, /obj/item/device/sentry_computer, VENDOR_ITEM_REGULAR),
		list("备用PDT/L战斗伙伴套件", floor(scale * 4), /obj/item/storage/box/pdt_kit, VENDOR_ITEM_REGULAR),
		list("W-Y品牌可充电迷你电池", floor(scale * 3), /obj/item/cell/crap, VENDOR_ITEM_REGULAR),

		list("杂项", -1, null, null),
		list("挖掘工具", floor(scale * 4), /obj/item/tool/shovel/etool/folded, VENDOR_ITEM_REGULAR),
		list("防毒面具", floor(scale * 10), /obj/item/clothing/mask/gas, VENDOR_ITEM_REGULAR),
		list("砍刀刀鞘（完整）", floor(scale * 6), /obj/item/storage/large_holster/machete/full, VENDOR_ITEM_REGULAR),
		list("MB-6 折叠式路障 (x3)", floor(scale * 3), /obj/item/stack/folding_barricade/three, VENDOR_ITEM_REGULAR),
		list("焊接护目镜", floor(scale * 3), /obj/item/clothing/glasses/welding, VENDOR_ITEM_REGULAR),
		list("灭火器（便携式）", floor(scale * 3), /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("高容量动力电池", floor(scale * 1), /obj/item/cell/high, VENDOR_ITEM_REGULAR),
		list("钉枪弹匣（7x45毫米）", floor(scale * 4), /obj/item/ammo_magazine/smg/nailgun, VENDOR_ITEM_REGULAR),

		list("技能手册", -1, null, null),
		list("JTAC 手册", floor(scale * 1), /obj/item/pamphlet/skill/jtac, VENDOR_ITEM_REGULAR),
		list("工程手册", floor(scale * 1), /obj/item/pamphlet/skill/engineer, VENDOR_ITEM_REGULAR),
		list("动力装载机认证", 0.75, /obj/item/pamphlet/skill/powerloader, VENDOR_ITEM_REGULAR),

		list("炸药箱", -1, null, null),
		list("M15 破片手榴弹包", 0, /obj/item/storage/box/packet/m15, VENDOR_ITEM_REGULAR),
		list("M40 HEDP榴弹包", 0, /obj/item/storage/box/packet/high_explosive, VENDOR_ITEM_REGULAR),
		list("M40 HEDP榴弹箱", 0, /obj/item/storage/box/nade_box, VENDOR_ITEM_REGULAR),
		list("M40 HIDP 手榴弹包", 0, /obj/item/storage/box/packet/incendiary, VENDOR_ITEM_REGULAR),
		list("M40 HIDP 手榴弹箱", 0, /obj/item/storage/box/nade_box/incen, VENDOR_ITEM_REGULAR),
		list("M40 CCDP 手榴弹包", 0, /obj/item/storage/box/packet/phosphorus/strong, VENDOR_ITEM_REGULAR),
		list("M40 CCDP 榴弹箱", 0, /obj/item/storage/box/nade_box/phophorus, VENDOR_ITEM_REGULAR),
		list("M40 HSDP 手榴弹包", 0, /obj/item/storage/box/packet/smoke, VENDOR_ITEM_REGULAR),
		list("M40 MFHS 手榴弹包", 0, /obj/item/storage/box/packet/foam, VENDOR_ITEM_REGULAR),
		list("M40 HIRR 警棍弹包", 0, /obj/item/storage/box/packet/baton_slug, VENDOR_ITEM_REGULAR),
		list("M74 AGM-F 手榴弹包", 0, /obj/item/storage/box/packet/airburst_he, VENDOR_ITEM_REGULAR),
		list("M74 AGM-F 手榴弹箱", 0, /obj/item/storage/box/nade_box/airburst, VENDOR_ITEM_REGULAR),
		list("M74 AGM-I 手榴弹包", 0, /obj/item/storage/box/packet/airburst_incen, VENDOR_ITEM_REGULAR),
		list("M74 AGM-I 手榴弹箱", 0, /obj/item/storage/box/nade_box/airburstincen, VENDOR_ITEM_REGULAR),
		list("M74 AGM-S 烟雾弹包", 0, /obj/item/storage/box/packet/airburst_smoke, VENDOR_ITEM_REGULAR),
		list("M74 AGM-S 星弹包", 0, /obj/item/storage/box/packet/flare, VENDOR_ITEM_REGULAR),
		list("M74 AGM-H 大黄蜂炮弹包", 0, /obj/item/storage/box/packet/hornet, VENDOR_ITEM_REGULAR),
		list("G2 电击手雷包", 0, /obj/item/storage/box/packet/sebb, VENDOR_ITEM_REGULAR),
		list("M20 地雷箱", 0, /obj/item/storage/box/explosive_mines, VENDOR_ITEM_REGULAR),

		list("其他箱子", -1, null, null),
		list("战斗手电筒盒", 0, /obj/item/ammo_box/magazine/misc/flashlight/combat, VENDOR_ITEM_REGULAR),
		list("M94标记信号弹包盒", 0, /obj/item/ammo_box/magazine/misc/flares, VENDOR_ITEM_REGULAR),
		list("M89信号弹包箱", 0, /obj/item/ammo_box/magazine/misc/flares/signal, VENDOR_ITEM_REGULAR),
		list("高容量能量电池箱", 0, /obj/item/ammo_box/magazine/misc/power_cell, VENDOR_ITEM_REGULAR),
		list("钉枪弹匣盒（7x45毫米）", floor(scale * 2), /obj/item/ammo_box/magazine/nailgun, VENDOR_ITEM_REGULAR)
		)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/stock(obj/item/item_to_stock, mob/user)
	if(istype(item_to_stock, /obj/item/storage) && !istype(item_to_stock, /obj/item/storage/box/m94) && !istype(item_to_stock, /obj/item/storage/large_holster/machete))
		to_chat(user, SPAN_WARNING("无法补充\the [item_to_stock]。"))
		return

	//this below is in case we have subtype of an object, that SHOULD be treated as parent object (like /empty ammo box)
	var/corrected_path = return_corresponding_type(item_to_stock.type)

	var/list/R
	for(R in (listed_products))
		if(item_to_stock.type == R[3] || corrected_path && corrected_path == R[3])
			if(!check_if_item_is_good_to_restock(item_to_stock, user))
				return

			if(item_to_stock.loc == user) //Inside the mob's inventory
				if(item_to_stock.flags_item & WIELDED)
					item_to_stock.unwield(user)
				user.temp_drop_inv_item(item_to_stock)

			if(isstorage(item_to_stock.loc)) //inside a storage item
				var/obj/item/storage/S = item_to_stock.loc
				S.remove_from_storage(item_to_stock, user.loc)

			qdel(item_to_stock)
			user.visible_message(SPAN_NOTICE("[user]向[src]补充了\a [R[1]]。"),
			SPAN_NOTICE("You stock [src] with \a [R[1]]."))
			R[2]++
			if(vend_flags & VEND_LOAD_AMMO_BOXES)
				update_derived_ammo_and_boxes_on_add(R)
			updateUsrDialog()
			return //We found our item, no reason to go on.

//Special cargo-specific vendor with vending offsets
/obj/structure/machinery/cm_vending/sorted/cargo_guns/cargo
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_LOAD_AMMO_BOXES | VEND_STOCK_DYNAMIC //We want to vend to turf not hand, since we are in requisitions
	vend_dir = WEST
	vend_dir_whitelist = list(NORTH, SOUTH)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/cargo/blend
	icon_state = "req_guns_wall"
	vend_delay = 3
	vend_sound = 'sound/machines/vending_drop.ogg'
	tiles_with = list(
		/obj/structure/window/framed/almayer,
		/obj/structure/machinery/door/airlock,
		/turf/closed/wall/almayer,
	)

//------------AMMUNITION VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/cargo_ammo
	name = "\improper 科马尔科技（殖民地海军陆战队科技）自动弹药供应商"
	desc = "一个连接大型存储库的自动化补给架，存储各种弹药类型。可由军需官和货舱技术员访问。"
	icon_state = "req_ammo"
	req_access = list(ACCESS_MARINE_CARGO)
	vendor_theme = VENDOR_THEME_USCM
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_LOAD_AMMO_BOXES | VEND_STOCK_DYNAMIC
	vend_dir = WEST
	vend_dir_whitelist = list(SOUTHWEST, NORTHWEST)

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/vend_fail()
	return

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_state

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/populate_product_list(scale)
	listed_products = list(
		list("常规弹药", -1, null, null),
		list("散弹枪子弹盒", floor(scale * 56), /obj/item/ammo_magazine/shotgun/buckshot, VENDOR_ITEM_REGULAR),
		list("钢钉弹匣", floor(scale * 56), /obj/item/ammo_magazine/shotgun/flechette, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹匣盒", floor(scale * 56), /obj/item/ammo_magazine/shotgun/slugs, VENDOR_ITEM_REGULAR),
		list("M4RA 弹匣（10x24毫米）", floor(scale * 60), /obj/item/ammo_magazine/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("M41A MK2 弹匣（10x24毫米）", floor(scale * 100), /obj/item/ammo_magazine/rifle, VENDOR_ITEM_REGULAR),
		list("M39 HV 弹匣（10x20毫米）", floor(scale * 100), /obj/item/ammo_magazine/smg/m39, VENDOR_ITEM_REGULAR),
		list("M10 HV 弹匣（10x20mm-APC）", floor(scale * 100), /obj/item/ammo_magazine/pistol/m10, VENDOR_ITEM_REGULAR),
		list("M44快速装弹器（.44口径）", floor(scale * 80), /obj/item/ammo_magazine/revolver, VENDOR_ITEM_REGULAR),
		list("M4A3弹匣（9毫米）", floor(scale * 100), /obj/item/ammo_magazine/pistol, VENDOR_ITEM_REGULAR),

		list("穿甲弹药", -1, null, null),
		list("88 型 4 AP 弹匣（9毫米）", floor(scale * 50), /obj/item/ammo_magazine/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M10 AP 弹匣（10x20mm-APC）", floor(scale * 14), /obj/item/ammo_magazine/pistol/m10/ap, VENDOR_ITEM_REGULAR),
		list("M10 AP 加长弹匣（10x20mm-APC）", floor(scale * 6), /obj/item/ammo_magazine/pistol/m10/ap/extended , VENDOR_ITEM_REGULAR),
		list("M4RA AP 弹匣（10x24毫米）", floor(scale * 16), /obj/item/ammo_magazine/rifle/m4ra/ap, VENDOR_ITEM_REGULAR),
		list("M39穿甲弹匣（10x20毫米）", floor(scale * 12), /obj/item/ammo_magazine/smg/m39/ap, VENDOR_ITEM_REGULAR),
		list("M41A MK2 AP 弹匣（10x24毫米）", floor(scale * 10), /obj/item/ammo_magazine/rifle/ap, VENDOR_ITEM_REGULAR),
		list("M4A3 AP 弹匣（9毫米）", floor(scale * 2), /obj/item/ammo_magazine/pistol/ap, VENDOR_ITEM_REGULAR),

		list("扩充弹药", -1, null, null),
		list("M10 HV 加长弹匣（10x20mm-APC）", floor(scale * 10), /obj/item/ammo_magazine/pistol/m10/extended , VENDOR_ITEM_REGULAR),
		list("M39 加长弹匣（10x20毫米）", floor(scale * 10), /obj/item/ammo_magazine/smg/m39/extended, VENDOR_ITEM_REGULAR),
		list("M4RA 加长弹匣（10x24毫米）", floor(scale * 10), /obj/item/ammo_magazine/rifle/m4ra/extended, VENDOR_ITEM_REGULAR),
		list("M41A MK2 加长弹匣（10x24毫米）", floor(scale * 8), /obj/item/ammo_magazine/rifle/extended, VENDOR_ITEM_REGULAR),

		list("特殊弹药", -1, null, null),
		list("M56 DV9 电池", 4, /obj/item/smartgun_battery, VENDOR_ITEM_REGULAR),
		list("M56智能枪弹鼓", 4, /obj/item/ammo_magazine/smartgun, VENDOR_ITEM_REGULAR),
		list("M44重型快速装弹器（.44口径）", 10, /obj/item/ammo_magazine/revolver/heavy, VENDOR_ITEM_REGULAR),
		list("M44神射手快速装弹器（.44口径）", 6, /obj/item/ammo_magazine/revolver/marksman, VENDOR_ITEM_REGULAR),
		list("M4A3 HP 弹匣（9毫米）", floor(scale * 2), /obj/item/ammo_magazine/pistol/hp, VENDOR_ITEM_REGULAR),
		list("M41AE2 全息瞄准目标弹（10x24毫米）", floor(scale * 2), /obj/item/ammo_magazine/rifle/lmg/holo_target, VENDOR_ITEM_REGULAR),
		list(".458 SOCOM 弹药箱 (.458 SOCOM)", floor(scale * 4), /obj/item/ammo_magazine/lever_action/xm88, VENDOR_ITEM_REGULAR),

		list("限制性火器弹药", -1, null, null),
		list("VP78 弹匣", 11, /obj/item/ammo_magazine/pistol/vp78, VENDOR_ITEM_REGULAR),
		list("SU-6智能手枪弹匣（.45口径）", 13, /obj/item/ammo_magazine/pistol/smart, VENDOR_ITEM_REGULAR),
		list("M240 焚化坦克", floor(scale * 3), /obj/item/ammo_magazine/flamer_tank, VENDOR_ITEM_REGULAR),
		list("M41AE2 弹匣（10x24mm）", floor(scale * 3), /obj/item/ammo_magazine/rifle/lmg, VENDOR_ITEM_REGULAR),
		list("M41A MK1 弹匣（10x24毫米）", 4.5, /obj/item/ammo_magazine/rifle/m41aMK1, VENDOR_ITEM_REGULAR),
		list("M41A MK1 穿甲弹匣（10x24毫米）", floor(scale * 2), /obj/item/ammo_magazine/rifle/m41aMK1/ap, VENDOR_ITEM_REGULAR),
		list("M56D 弹鼓", floor(scale * 2), /obj/item/ammo_magazine/m56d, VENDOR_ITEM_REGULAR),
		list("M2C 弹匣", floor(scale * 2), /obj/item/ammo_magazine/m2c, VENDOR_ITEM_REGULAR),

		list("弹匣盒", -1, null, null),
		list("弹匣盒（M10 x 22）", 0, /obj/item/ammo_box/magazine/m10, VENDOR_ITEM_REGULAR),
		list("弹匣盒（外螺纹 M10 x 14）", 0, /obj/item/ammo_box/magazine/m10/extended, VENDOR_ITEM_REGULAR),
		list("弹匣盒（鼓式 M10 x 12）", 0, /obj/item/ammo_box/magazine/m10/drum, VENDOR_ITEM_REGULAR),
		list("弹匣盒（M10穿甲弹 x 22）", 0, /obj/item/ammo_box/magazine/m10/ap, VENDOR_ITEM_REGULAR),
		list("弹匣盒（外部M10 AP x 14）", 0, /obj/item/ammo_box/magazine/m10/ap/extended, VENDOR_ITEM_REGULAR),
		list("弹匣盒（鼓式M10穿甲弹 x 12）", 0, /obj/item/ammo_box/magazine/m10/ap/drum, VENDOR_ITEM_REGULAR),
		list("弹匣盒（M39 x 12）", 0, /obj/item/ammo_box/magazine/m39, VENDOR_ITEM_REGULAR),
		list("弹匣盒（AP M39 x 12）", 0, /obj/item/ammo_box/magazine/m39/ap, VENDOR_ITEM_REGULAR),
		list("弹匣盒（外螺纹M39 x 10）", 0, /obj/item/ammo_box/magazine/m39/ext, VENDOR_ITEM_REGULAR),
		list("弹匣盒（M41A x 10）", 0, /obj/item/ammo_box/magazine, VENDOR_ITEM_REGULAR),
		list("弹匣箱（AP M41A x 10）", 0, /obj/item/ammo_box/magazine/ap, VENDOR_ITEM_REGULAR),
		list("弹匣箱（外部 M41A x 8）", 0, /obj/item/ammo_box/magazine/ext, VENDOR_ITEM_REGULAR),
		list("弹匣盒（M4A3 x 16）", 0, /obj/item/ammo_box/magazine/m4a3, VENDOR_ITEM_REGULAR),
		list("弹匣箱（AP M4A3 x 16）", 0, /obj/item/ammo_box/magazine/m4a3/ap, VENDOR_ITEM_REGULAR),
		list("弹匣盒（HP M4A3 x 16）", 0, /obj/item/ammo_box/magazine/m4a3/hp, VENDOR_ITEM_REGULAR),
		list("弹匣盒（M4RA x 16）", 0, /obj/item/ammo_box/magazine/m4ra, VENDOR_ITEM_REGULAR),
		list("弹匣箱（AP M4RA x 16）", 0, /obj/item/ammo_box/magazine/m4ra/ap, VENDOR_ITEM_REGULAR),
		list("弹匣盒（外部 M4RA x 16）", 0, /obj/item/ammo_box/magazine/m4ra/ext, VENDOR_ITEM_REGULAR),
		list("弹匣盒（M41AE2 x 8）", 0, /obj/item/ammo_box/magazine/m41ae2, VENDOR_ITEM_REGULAR),
		list("弹匣盒（M41AE2 全息瞄准靶 x 8）", 0, /obj/item/ammo_box/magazine/m41ae2/holo, VENDOR_ITEM_REGULAR),
		list("弹匣箱（M41A MK1 x 8）", 0, /obj/item/ammo_box/magazine/mk1, VENDOR_ITEM_REGULAR),
		list("弹匣盒（M41A MK1 AP x 8）", 0, /obj/item/ammo_box/magazine/mk1/ap, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹盒（鹿弹 x 100）", 0, /obj/item/ammo_box/magazine/shotgun/buckshot, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹匣（箭形弹 x 100）", 0, /obj/item/ammo_box/magazine/shotgun/flechette, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹盒（独头弹 x 100）", 0, /obj/item/ammo_box/magazine/shotgun, VENDOR_ITEM_REGULAR),
		list("弹匣盒（88型 4发穿甲弹 x 16）", 0, /obj/item/ammo_box/magazine/mod88, VENDOR_ITEM_REGULAR),
		list("弹匣盒（SU-6 x 16）", 0, /obj/item/ammo_box/magazine/su6, VENDOR_ITEM_REGULAR),
		list("弹匣盒（VP78 x 16）", 0, /obj/item/ammo_box/magazine/vp78, VENDOR_ITEM_REGULAR),
		list("弹匣箱（XM51 x 8）", 0, /obj/item/ammo_box/magazine/xm51, VENDOR_ITEM_REGULAR),
		list("弹药箱（.458 SOCOM x 300发）", 0, /obj/item/ammo_box/magazine/lever_action/xm88, VENDOR_ITEM_REGULAR),
		list("弹药箱（M2C x 8）", 0, /obj/item/ammo_box/magazine/m2c, VENDOR_ITEM_REGULAR),
		list("鼓盒 (M56 x 8)", 0, /obj/item/ammo_box/magazine/m56a2, VENDOR_ITEM_REGULAR),
		list("鼓盒（M56D x 8）", 0, /obj/item/ammo_box/magazine/m56d, VENDOR_ITEM_REGULAR),
		list("快速装弹器盒（M44 x 16）", 0, /obj/item/ammo_box/magazine/m44, VENDOR_ITEM_REGULAR),
		list("快速装弹器盒（神射手M44 x 16）", 0, /obj/item/ammo_box/magazine/m44/marksman, VENDOR_ITEM_REGULAR),
		list("快速装弹器盒（重型M44 x 16）", 0, /obj/item/ammo_box/magazine/m44/heavy, VENDOR_ITEM_REGULAR),
		list("火焰坦克补给箱（UT-萘燃料 x 8）", 0, /obj/item/ammo_box/magazine/flamer, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/stock(obj/item/item_to_stock, mob/user)
	//these are exempted because checks would be huge and not worth it
	if(istype(item_to_stock, /obj/item/storage))
		to_chat(user, SPAN_WARNING("无法补充\the [item_to_stock]。"))
		return
	var/list/R

	//this below is in case we have subtype of an object, that SHOULD be treated as parent object (like /empty ammo box)
	var/corrected_path = return_corresponding_type(item_to_stock.type)

	for(R in (listed_products))
		if(item_to_stock.type == R[3] || corrected_path && corrected_path == R[3])
			if(!check_if_item_is_good_to_restock(item_to_stock, user))
				return

			if(item_to_stock.loc == user) //Inside the mob's inventory
				if(item_to_stock.flags_item & WIELDED)
					item_to_stock.unwield(user)
				user.temp_drop_inv_item(item_to_stock)

			if(isstorage(item_to_stock.loc)) //inside a storage item
				var/obj/item/storage/S = item_to_stock.loc
				S.remove_from_storage(item_to_stock, user.loc)

			qdel(item_to_stock)
			user.visible_message(SPAN_NOTICE("[user]向[src]补充了\a [R[1]]。"),
			SPAN_NOTICE("You stock [src] with \a [R[1]]."))
			R[2]++
			if(vend_flags & VEND_LOAD_AMMO_BOXES)
				update_derived_ammo_and_boxes_on_add(R)
			updateUsrDialog()
			return //We found our item, no reason to go on.

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/cargo/blend
	icon_state = "req_ammo_wall"
	vend_delay = 3
	vend_sound = 'sound/machines/vending_drop.ogg'
	tiles_with = list(
		/obj/structure/window/framed/almayer,
		/obj/structure/machinery/door/airlock,
		/turf/closed/wall/almayer,
	)

//Special cargo-specific vendor with vending offsets
/obj/structure/machinery/cm_vending/sorted/cargo_ammo/cargo
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_LOAD_AMMO_BOXES | VEND_STOCK_DYNAMIC //We want to vend to turf not hand, since we are in requisitions

//------------ATTACHMENTS VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/attachments
	name = "\improper 阿玛特战场系统配件供应商"
	desc = "一个连接大型存储库的自动化补给架，存储各种武器配件。可由军需官和货舱技术员访问。"
	req_access = list(ACCESS_MARINE_CARGO)
	vendor_theme = VENDOR_THEME_USCM
	icon_state = "req_attach"
	vend_dir = WEST
	vend_dir_whitelist = list(SOUTHEAST, NORTHEAST)
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_STOCK_DYNAMIC //We want to vend to turf not hand, since we are in requisitions

/obj/structure/machinery/cm_vending/sorted/attachments/squad/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/structure/machinery/cm_vending/sorted/attachments/vend_fail()
	return

/obj/structure/machinery/cm_vending/sorted/attachments/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_state

/obj/structure/machinery/cm_vending/sorted/attachments/populate_product_list(scale)
	listed_products = list(
		list("枪管", -1, null, null),
		list("桶装冲锋者", 1.5, /obj/item/attachable/heavy_barrel, VENDOR_ITEM_REGULAR),
		list("加长枪管", 6.5, /obj/item/attachable/extended_barrel, VENDOR_ITEM_REGULAR),
		list("M5 刺刀", 10.5, /obj/item/attachable/bayonet, VENDOR_ITEM_REGULAR),
		list("延长型后坐力补偿器", 6.5, /obj/item/attachable/extended_barrel/vented, VENDOR_ITEM_REGULAR),
		list("后坐力补偿器", 6.5, /obj/item/attachable/compensator, VENDOR_ITEM_REGULAR),
		list("M10补偿器", 6.5, /obj/item/attachable/compensator/m10, VENDOR_ITEM_REGULAR),
		list("抑制器", 6.5, /obj/item/attachable/suppressor, VENDOR_ITEM_REGULAR),
		list("抑制器，紧凑型", 6, /obj/item/attachable/suppressor/sleek, VENDOR_ITEM_REGULAR),
		list("霰弹枪收束器", 4.5, /obj/item/attachable/shotgun_choke, VENDOR_ITEM_REGULAR),

		list("铁路", -1, null, null),
		list("B8智能瞄准镜", 3.5, /obj/item/attachable/alt_iff_scope, VENDOR_ITEM_REGULAR),
		list("磁力束带", 8.5, /obj/item/attachable/magnetic_harness, VENDOR_ITEM_REGULAR),
		list("Rail 手电筒", 10.5, /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
		list("S4 2倍伸缩迷你瞄准镜", 4.5, /obj/item/attachable/scope/mini, VENDOR_ITEM_REGULAR),
		list("S5 红点瞄准镜", 9.5, /obj/item/attachable/reddot, VENDOR_ITEM_REGULAR),
		list("S5-微型红点瞄准镜", 9.5, /obj/item/attachable/reddot/small, VENDOR_ITEM_REGULAR),
		list("S6 反射式瞄准镜", 9.5, /obj/item/attachable/reflex, VENDOR_ITEM_REGULAR),
		list("S8 4倍伸缩瞄准镜", 4.5, /obj/item/attachable/scope, VENDOR_ITEM_REGULAR),

		list("下挂式枪管", -1, null, null),
		list("直角握把", 6.5, /obj/item/attachable/angledgrip, VENDOR_ITEM_REGULAR),
		list("两脚架", 6.5, /obj/item/attachable/bipod, VENDOR_ITEM_REGULAR),
		list("连发组件", 4.5, /obj/item/attachable/burstfire_assembly, VENDOR_ITEM_REGULAR),
		list("陀螺稳定器", 4.5, /obj/item/attachable/gyro, VENDOR_ITEM_REGULAR),
		list("激光瞄准镜", 9.5, /obj/item/attachable/lasersight, VENDOR_ITEM_REGULAR),
		list("微型激光瞄准镜", 3.5, /obj/item/attachable/lasersight/micro, VENDOR_ITEM_REGULAR),
		list("迷你火焰喷射器", 4.5, /obj/item/attachable/attached_gun/flamer, VENDOR_ITEM_REGULAR),
		list("XM-VESG-1 火焰喷射器喷嘴", 4.5, /obj/item/attachable/attached_gun/flamer_nozzle, VENDOR_ITEM_REGULAR),
		list("U7 下挂式霰弹枪", 4.5, /obj/item/attachable/attached_gun/shotgun, VENDOR_ITEM_REGULAR),
		list("下挂式灭火器", 4.5, /obj/item/attachable/attached_gun/extinguisher, VENDOR_ITEM_REGULAR),
		list("下挂式手电筒握把", 9.5, /obj/item/attachable/flashlight/grip, VENDOR_ITEM_REGULAR),
		list("下挂式榴弹发射器", 9.5, /obj/item/attachable/attached_gun/grenade, VENDOR_ITEM_REGULAR),
		list("下挂式信号弹发射器", 9.5, /obj/item/attachable/attached_gun/flare_launcher, VENDOR_ITEM_REGULAR),
		list("垂直握把", 9.5, /obj/item/attachable/verticalgrip, VENDOR_ITEM_REGULAR),

		list("库存", -1, null, null),
		list("M10折叠式枪托", 4.5, /obj/item/attachable/stock/pistol/collapsible, VENDOR_ITEM_REGULAR),
		list("M10 实心库存", 4.5, /obj/item/attachable/stock/m10_solid, VENDOR_ITEM_REGULAR),
		list("M37A2 可折叠枪托", 4.5, /obj/item/attachable/stock/synth/collapsible, VENDOR_ITEM_REGULAR),
		list("M39 臂托", 4.5, /obj/item/attachable/stock/smg/collapsible/brace, VENDOR_ITEM_REGULAR),
		list("M39 折叠式枪托", 4.5, /obj/item/attachable/stock/smg/collapsible, VENDOR_ITEM_REGULAR),
		list("M39 枪托", 4.5, /obj/item/attachable/stock/smg, VENDOR_ITEM_REGULAR),
		list("M41A 实心枪托", 4.5, /obj/item/attachable/stock/rifle, VENDOR_ITEM_REGULAR),
		list("M41A折叠式枪托", 4.5, /obj/item/attachable/stock/rifle/collapsible, VENDOR_ITEM_REGULAR),
		list("M44马格南神射手枪托", 4.5, /obj/item/attachable/stock/revolver, VENDOR_ITEM_REGULAR)
		)

/obj/structure/machinery/cm_vending/sorted/attachments/blend
	icon_state = "req_attach_wall"
	vend_delay = 3
	vend_sound = 'sound/machines/vending_drop.ogg'
	tiles_with = list(
		/obj/structure/window/framed/almayer,
		/obj/structure/machinery/door/airlock,
		/turf/closed/wall/almayer,
	)

//------------UNIFORM VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/uniform_supply
	name = "\improper 殖民地海军陆战队科技（ColMarTech）剩余制服供应商"
	desc = "一个连接大型存储库的自动化补给架，存储标准陆战队制服。可由军需官和货舱技术员访问。"
	icon_state = "clothing"
	req_access = list()
	req_one_access = list(ACCESS_MARINE_CARGO)
	vendor_theme = VENDOR_THEME_USCM
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_UNIFORM_AUTOEQUIP

	listed_products = list(
		list("制服", -1, null, null),
		list("USCM（殖民地海军陆战队） 制服", 20, /obj/item/clothing/under/marine, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）战斗技师制服", 5, /obj/item/clothing/under/marine/engineer, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）医务兵制服", 5, /obj/item/clothing/under/marine/medic, VENDOR_ITEM_REGULAR),

		list("靴子", -1, null, null),
		list("海军陆战队员 战斗靴", 20, /obj/item/clothing/shoes/marine, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 Brown 战斗靴", 5, /obj/item/clothing/shoes/marine/brown, VENDOR_ITEM_REGULAR),
		list("海军陆战队员丛林作战靴", 5, /obj/item/clothing/shoes/marine/jungle, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 Grey 战斗靴", 5, /obj/item/clothing/shoes/marine/grey, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 Urban 战斗靴", 5, /obj/item/clothing/shoes/marine/urban, VENDOR_ITEM_REGULAR),

		list("背包", -1, null, null),
		list("轻量化IMP背包", 20, /obj/item/storage/backpack/marine, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 背包", 20, /obj/item/storage/backpack/marine/satchel, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）战术背心", 10, /obj/item/storage/backpack/marine/satchel/chestrig, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 技术员背包", 10, /obj/item/storage/backpack/marine/tech, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）技术员胸挂", 10, /obj/item/storage/backpack/marine/satchel/tech, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）医护兵背包", 10, /obj/item/storage/backpack/marine/medic, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）医疗兵挎包", 10, /obj/item/storage/backpack/marine/satchel/medic, VENDOR_ITEM_REGULAR),

		list("护甲", -1, null, null),
		list("M10型海军陆战队员头盔", 20, /obj/item/clothing/head/helmet/marine, VENDOR_ITEM_REGULAR),
		list("M10型技师头盔", 20, /obj/item/clothing/head/helmet/marine/tech, VENDOR_ITEM_REGULAR),
		list("M10型医护兵头盔", 20, /obj/item/clothing/head/helmet/marine/medic, VENDOR_ITEM_REGULAR),
		list("M3型运输车 海军陆战队员 装甲", 20, /obj/item/clothing/suit/storage/marine/medium/carrier, VENDOR_ITEM_REGULAR),
		list("M3型加厚海军陆战队员护甲", 20, /obj/item/clothing/suit/storage/marine/medium/padded, VENDOR_ITEM_REGULAR),
		list("M3型无衬垫护甲 海军陆战队员专用", 20, /obj/item/clothing/suit/storage/marine/medium/padless, VENDOR_ITEM_REGULAR),
		list("M3型棱纹海军陆战队员护甲", 20, /obj/item/clothing/suit/storage/marine/medium/padless_lines, VENDOR_ITEM_REGULAR),
		list("M3型骷髅头海军陆战队员护甲", 20, /obj/item/clothing/suit/storage/marine/medium/skull, VENDOR_ITEM_REGULAR),
		list("M3型平滑式海军陆战队员护甲", 20, /obj/item/clothing/suit/storage/marine/medium/smooth, VENDOR_ITEM_REGULAR),
		list("M3-EOD型重型护甲", 10, /obj/item/clothing/suit/storage/marine/heavy, VENDOR_ITEM_REGULAR),
		list("M3-L型轻型护甲", 10, /obj/item/clothing/suit/storage/marine/light, VENDOR_ITEM_REGULAR),

		list("手套", -1, null, null),
		list("海军陆战队员 战斗 手套", 40, /obj/item/clothing/gloves/marine, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 Black 战斗手套", 40, /obj/item/clothing/gloves/marine/black, VENDOR_ITEM_REGULAR),
		list("海军陆战队员布朗战斗手套", 20, /obj/item/clothing/gloves/marine/brown, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 Grey 战斗手套", 20, /obj/item/clothing/gloves/marine/grey, VENDOR_ITEM_REGULAR),
		list("海军陆战队员无指战斗手套", 20, /obj/item/clothing/gloves/marine/fingerless, VENDOR_ITEM_REGULAR),

		list("加密密钥", -1, null, null),
		list("阿尔法小队无线电加密密钥", 5, /obj/item/device/encryptionkey/alpha, VENDOR_ITEM_REGULAR),
		list("布拉沃小队无线电加密密钥", 5, /obj/item/device/encryptionkey/bravo, VENDOR_ITEM_REGULAR),
		list("查理小队无线电加密密钥", 5, /obj/item/device/encryptionkey/charlie, VENDOR_ITEM_REGULAR),
		list("三角洲小队无线电加密密钥", 5, /obj/item/device/encryptionkey/delta, VENDOR_ITEM_REGULAR),
		list("回声小队无线电加密密钥", 5, /obj/item/device/encryptionkey/echo, VENDOR_ITEM_REGULAR),
		list("工程部无线电加密密钥", 5, /obj/item/device/encryptionkey/engi, VENDOR_ITEM_REGULAR),
		list("英特尔无线电加密密钥", 5, /obj/item/device/encryptionkey/intel, VENDOR_ITEM_REGULAR),
		list("JTAC无线电加密密钥", 5, /obj/item/device/encryptionkey/jtac, VENDOR_ITEM_REGULAR),
		list("医疗无线电加密密钥", 5, /obj/item/device/encryptionkey/med, VENDOR_ITEM_REGULAR),
		list("补给无线电加密密钥", 5, /obj/item/device/encryptionkey/req, VENDOR_ITEM_REGULAR),
		list("哨戒炮网络加密密钥", 8, /obj/item/device/encryptionkey/sentry_laptop, VENDOR_ITEM_REGULAR),

		list("阿尔迈耶备用无线电", -1, null, null),
		list("阿尔迈耶号无线电加密密钥", 3, /obj/item/device/encryptionkey/almayer, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 无线电耳机", 5, /obj/item/device/radio/headset/almayer, VENDOR_ITEM_REGULAR),

		list("面具", -1, null, null, null),
		list("防毒面具", 20, /obj/item/clothing/mask/gas, VENDOR_ITEM_REGULAR),
		list("吸热头巾", 10, /obj/item/clothing/mask/rebreather/scarf, VENDOR_ITEM_REGULAR),

		list("杂项", -1, null, null),
		list("防弹护目镜", 10, /obj/item/clothing/glasses/mgoggles, VENDOR_ITEM_REGULAR),
		list("M1A1 防弹护目镜", 10, /obj/item/clothing/glasses/mgoggles/v2, VENDOR_ITEM_REGULAR),
		list("处方防弹护目镜", 10, /obj/item/clothing/glasses/mgoggles/prescription, VENDOR_ITEM_REGULAR),
		list("陆战队员RPG眼镜", 10, /obj/item/clothing/glasses/regular, VENDOR_ITEM_REGULAR),
		list("M5集成式防毒面具", 10, /obj/item/prop/helmetgarb/helmet_gasmask, VENDOR_ITEM_REGULAR),
		list("M10头盔伪装网", 10, /obj/item/clothing/accessory/helmet/cover/netting, VENDOR_ITEM_REGULAR),
		list("M10头盔防雨罩", 10, /obj/item/clothing/accessory/helmet/cover/raincover, VENDOR_ITEM_REGULAR),
		list("可挂载身份牌", 15, /obj/item/clothing/accessory/dogtags, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 徽章", 15, /obj/item/prop/helmetgarb/flair_uscm, VENDOR_ITEM_REGULAR),
		list("坠落猎鹰肩章", 15, /obj/item/clothing/accessory/patch/falcon, VENDOR_ITEM_REGULAR),
		list("坠落猎鹰UA肩章", 15, /obj/item/clothing/accessory/patch/falconalt, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）大型胸章", 15, /obj/item/clothing/accessory/patch/uscmlarge, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 肩章", 15, /obj/item/clothing/accessory/patch, VENDOR_ITEM_REGULAR),
		list("联合美洲肩章", 10, /obj/item/clothing/accessory/patch/ua, VENDOR_ITEM_REGULAR),
		list("联合美洲国旗肩章", 10, /obj/item/clothing/accessory/patch/uasquare, VENDOR_ITEM_REGULAR),
		list("铺盖卷", 30, /obj/item/roller/bedroll, VENDOR_ITEM_REGULAR),
		list("M5摄像装备", 5, /obj/item/device/overwatch_camera, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/uniform_supply/populate_product_list(scale)
	return

/obj/structure/machinery/cm_vending/sorted/uniform_supply/vend_fail()
	return

/obj/structure/machinery/cm_vending/sorted/uniform_supply/stock(obj/item/item_to_stock, mob/user)
	var/list/R
	for(R in (listed_products))
		if(item_to_stock.type == R[3] && !istype(item_to_stock,/obj/item/storage))
			//Marine armor handling
			if(istype(item_to_stock, /obj/item/clothing/suit/storage/marine))
				var/obj/item/clothing/suit/storage/marine/AR = item_to_stock
				if(AR.pockets && length(AR.pockets.contents))
					to_chat(user, SPAN_WARNING("\The [AR] has something inside it. Empty it before restocking."))
					return
			//Marine helmet handling
			else if(istype(item_to_stock, /obj/item/clothing/head/helmet/marine))
				var/obj/item/clothing/head/helmet/marine/H = item_to_stock
				if(H.pockets && length(H.pockets.contents))
					to_chat(user, SPAN_WARNING("\The [H] has something inside it. Empty it before restocking."))
					return

			if(item_to_stock.loc == user) //Inside the mob's inventory
				if(item_to_stock.flags_item & WIELDED)
					item_to_stock.unwield(user)
				user.temp_drop_inv_item(item_to_stock)

			if(isstorage(item_to_stock.loc)) //inside a storage item
				var/obj/item/storage/S = item_to_stock.loc
				S.remove_from_storage(item_to_stock, user.loc)

			qdel(item_to_stock)
			user.visible_message(SPAN_NOTICE("[user]向\the [src]补充了\a [R[1]]。"),
			SPAN_NOTICE("You stock \the [src] with \a [R[1]]."))
			R[2]++
			if(vend_flags & VEND_LOAD_AMMO_BOXES)
				update_derived_ammo_and_boxes_on_add(R)
			updateUsrDialog()
			return //We found our item, no reason to go on.

//------------TRAINING WEAPONS RACK---------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/training //Nonlethal stuff for events.
	name = "\improper ColMarTech（殖民地海军陆战队科技） 自动化训练武器架"
	desc = "一个连接大型存储库的自动化武器架，存储标准配发武器和非致命弹药。"

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/training/populate_product_list(scale)
	listed_products = list(
		list("主要火器", -1, null, null),
		list("M4RA 战斗步枪", floor(scale * 10), /obj/item/weapon/gun/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("M37A2 泵动式霰弹枪", floor(scale * 15), /obj/item/weapon/gun/shotgun/pump/m37a, VENDOR_ITEM_REGULAR),
		list("M39 冲锋枪", floor(scale * 30), /obj/item/weapon/gun/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A脉冲步枪MK2", floor(scale * 30), /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_RECOMMENDED),

		list("主要非致命弹药", -1, null, null),
		list("豆袋弹盒（12克）", floor(scale * 15), /obj/item/ammo_magazine/shotgun/beanbag, VENDOR_ITEM_REGULAR),
		list("M4RA 橡胶弹匣（10x24毫米）", floor(scale * 15), /obj/item/ammo_magazine/rifle/m4ra/rubber, VENDOR_ITEM_REGULAR),
		list("M39橡胶弹匣（10x20毫米）", floor(scale * 25), /obj/item/ammo_magazine/smg/m39/rubber, VENDOR_ITEM_REGULAR),
		list("M41A橡胶弹弹匣 (10x24mm)", floor(scale * 25), /obj/item/ammo_magazine/rifle/rubber, VENDOR_ITEM_REGULAR),

		list("侧臂", -1, null, null),
		list("88 型 4 战斗手枪", floor(scale * 25), /obj/item/weapon/gun/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M4A3 制式手枪", floor(scale * 25), /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),

		list("侧臂非致命弹药", -1, null, null),
		list("88M4 橡胶弹匣（9毫米）", floor(scale * 25), /obj/item/ammo_magazine/pistol/mod88/rubber, VENDOR_ITEM_REGULAR),
		list("M4A3橡胶弹匣（9毫米）", floor(scale * 25), /obj/item/ammo_magazine/pistol/rubber, VENDOR_ITEM_REGULAR),

		list("附件", -1, null, null),
		list("Rail 手电筒", floor(scale * 25), /obj/item/attachable/flashlight, VENDOR_ITEM_RECOMMENDED),
		list("下挂式手电筒握把", floor(scale * 10), /obj/item/attachable/flashlight/grip, VENDOR_ITEM_RECOMMENDED),
		list("下挂式榴弹发射器", floor(scale * 25), /obj/item/attachable/attached_gun/grenade, VENDOR_ITEM_REGULAR), //They already get these as on-spawns, might as well formalize some spares.
		list("下挂式信号弹发射器", floor(scale * 25), /obj/item/attachable/attached_gun/flare_launcher, VENDOR_ITEM_REGULAR),

		list("公共事业", -1, null, null),
		list("M07 训练手榴弹", floor(scale * 15), /obj/item/explosive/grenade/high_explosive/training, VENDOR_ITEM_REGULAR),
		list("M15橡胶弹手榴弹", floor(scale * 10), /obj/item/explosive/grenade/high_explosive/m15/rubber, VENDOR_ITEM_REGULAR),
		list("M5刺刀", floor(scale * 25), /obj/item/attachable/bayonet, VENDOR_ITEM_REGULAR),
		list("M94 标记信号弹包", floor(scale * 10), /obj/item/storage/box/m94, VENDOR_ITEM_RECOMMENDED)
	)
