//------------SQUAD PREP VENDORS -------------------

//------------SQUAD PREP WEAPON RACKS---------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep
	name = "\improper 科马尔科技（殖民地海军陆战队科技）自动武器架"
	desc = "连接至大型存储库的自动化武器架，存放标准配发武器。"
	icon_state = "guns"
	req_access = list()
	req_one_access = list(ACCESS_MARINE_GENERAL, ACCESS_MARINE_PREP)
	hackable = TRUE
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_STOCK_DYNAMIC

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/populate_product_list(scale)
	listed_products = list(
		list("主要火器", -1, null, null),
		list("M4RA 战斗步枪", floor(scale * 5), /obj/item/weapon/gun/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("M37A2 泵动式霰弹枪", floor(scale * 10), /obj/item/weapon/gun/shotgun/pump/m37a, VENDOR_ITEM_REGULAR),
		list("M39 冲锋枪", floor(scale * 10), /obj/item/weapon/gun/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A脉冲步枪MK2", floor(scale * 15), /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_RECOMMENDED),

		list("主要弹药", -1, null, null),
		list("霰弹枪箭形弹盒（12号口径）", floor(scale * 3), /obj/item/ammo_magazine/shotgun/flechette, VENDOR_ITEM_REGULAR),
		list("霰弹枪子弹盒（12号口径）", floor(scale * 5), /obj/item/ammo_magazine/shotgun/buckshot, VENDOR_ITEM_REGULAR),
		list("霰弹枪独头弹盒（12号口径）", floor(scale * 5), /obj/item/ammo_magazine/shotgun/slugs, VENDOR_ITEM_REGULAR),
		list("M4RA 弹匣（10x24毫米）", floor(scale * 15), /obj/item/ammo_magazine/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("M39 高压弹匣（10x20毫米）", floor(scale * 15), /obj/item/ammo_magazine/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A弹匣（10x24毫米）", floor(scale * 15), /obj/item/ammo_magazine/rifle, VENDOR_ITEM_REGULAR),

		list("侧臂", -1, null, null),
		list("M10自动手枪", floor(scale * 10), /obj/item/weapon/gun/pistol/m10, VENDOR_ITEM_REGULAR),
		list("88 型 4 战斗手枪", floor(scale * 10), /obj/item/weapon/gun/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44 战斗左轮手枪", floor(scale * 10), /obj/item/weapon/gun/revolver/m44, VENDOR_ITEM_REGULAR),
		list("M4A3 制式手枪", floor(scale * 10), /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),
		list("M82F 信号枪", floor(scale * 5), /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("手枪弹药", -1, null, null),
		list("M10 高威力弹匣（10x20毫米穿甲弹）", floor(scale * 10), /obj/item/ammo_magazine/pistol/m10, VENDOR_ITEM_REGULAR),
		list("88M4 AP 弹匣（9毫米）", floor(scale * 10), /obj/item/ammo_magazine/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44快速装弹器（.44口径）", floor(scale * 10), /obj/item/ammo_magazine/revolver, VENDOR_ITEM_REGULAR),
		list("M4A3弹匣（9毫米）", floor(scale * 10), /obj/item/ammo_magazine/pistol, VENDOR_ITEM_REGULAR),

		list("配件", -1, null, null),
		list("M10折叠式枪托", floor(scale * 5), /obj/item/attachable/stock/pistol/collapsible, VENDOR_ITEM_REGULAR),
		list("M39折叠式枪托", floor(scale * 5), /obj/item/attachable/stock/smg/collapsible, VENDOR_ITEM_REGULAR),
		list("M41A折叠式枪托", floor(scale * 5), /obj/item/attachable/stock/rifle/collapsible, VENDOR_ITEM_REGULAR),
		list("Rail 手电筒", floor(scale * 10), /obj/item/attachable/flashlight, VENDOR_ITEM_RECOMMENDED),
		list("下挂式手电筒握把", floor(scale * 5), /obj/item/attachable/flashlight/grip, VENDOR_ITEM_RECOMMENDED),
		list("下挂式榴弹发射器", floor(scale * 10), /obj/item/attachable/attached_gun/grenade, VENDOR_ITEM_REGULAR), //They already get these as on-spawns, might as well formalize some spares.
		list("下挂式信号弹发射器", floor(scale * 10), /obj/item/attachable/attached_gun/flare_launcher, VENDOR_ITEM_REGULAR),

		list("公共事业", -1, null, null),
		list("M5 刺刀", floor(scale * 10), /obj/item/attachable/bayonet, VENDOR_ITEM_REGULAR),
		list("M94 标记信号弹包", floor(scale * 5), /obj/item/storage/box/m94, VENDOR_ITEM_RECOMMENDED)
	)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/tutorial
	name = "\improper 科马尔科技（殖民地海军陆战队科技）自动武器架"
	desc = "连接至大型存储库的自动化武器架，存放标准配发武器。"
	icon_state = "guns"
	req_access = list(ACCESS_TUTORIAL_LOCKED)
	req_one_access = list()
	hackable = FALSE
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/tutorial/populate_product_list(scale)
	listed_products = list(
		list("主要火器", -1, null, null),
		list("M41A脉冲步枪MK2", 1, /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_RECOMMENDED),

		list("主要弹药", -1, null, null),
		list("M41A弹匣（10x24毫米）", 1, /obj/item/ammo_magazine/rifle, VENDOR_ITEM_RECOMMENDED),
	)

/// Called if the tutorial mob somehow uses an entire magazine without the xeno dying
/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/tutorial/proc/load_ammo()
	listed_products = list(
		list("主要火器", -1, null, null),
		list("M41A脉冲步枪MK2", 0, /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_RECOMMENDED),

		list("主要弹药", -1, null, null),
		list("M41A弹匣（10x24毫米）", 99, /obj/item/ammo_magazine/rifle, VENDOR_ITEM_RECOMMENDED),
	)

//------------SQUAD PREP UNIFORM VENDOR---------------


/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep
	name = "\improper 殖民地海军陆战队科技剩余制服供应商"
	desc = "连接至小型存储库的自动化补给架，存放陆战队员标准制服。"
	req_access = list(ACCESS_MARINE_PREP)
	req_one_access = list()
	listed_products = list()
	hackable = TRUE
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_STOCK_DYNAMIC | VEND_UNIFORM_AUTOEQUIP

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/populate_product_list(scale)
	listed_products = list(
		list("标准装备", -1, null, null, null),
		list("海军陆战队员 战斗靴", floor(scale * 15), /obj/item/clothing/shoes/marine, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 Brown 战斗靴", floor(scale * 15), /obj/item/clothing/shoes/marine/brown, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 Grey 战斗靴", floor(scale * 15), /obj/item/clothing/shoes/marine/grey, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 制服", floor(scale * 15), /obj/item/clothing/under/marine, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 战斗 手套", floor(scale * 15), /obj/item/clothing/gloves/marine, VENDOR_ITEM_REGULAR),
		list("海军陆战队员布朗战斗手套", floor(scale * 15), /obj/item/clothing/gloves/marine/brown, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 Black 战斗手套", floor(scale * 15), /obj/item/clothing/gloves/marine/black, VENDOR_ITEM_REGULAR),
		list("海军陆战队员格雷战斗手套", floor(scale * 15), /obj/item/clothing/gloves/marine/grey, VENDOR_ITEM_REGULAR),
		list("海军陆战队员无指战斗手套", floor(scale * 15), /obj/item/clothing/gloves/marine/fingerless, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 无线电耳机", floor(scale * 15), /obj/item/device/radio/headset/almayer, VENDOR_ITEM_REGULAR),
		list("M10型海军陆战队员头盔", floor(scale * 15), /obj/item/clothing/head/helmet/marine, VENDOR_ITEM_REGULAR),

		list("织带", -1, null, null),
		list("棕色网眼背心", 1, /obj/item/clothing/accessory/storage/black_vest/brown_vest, VENDOR_ITEM_REGULAR),
		list("黑色网眼背心", 1, /obj/item/clothing/accessory/storage/black_vest, VENDOR_ITEM_REGULAR),
		list("腿部挂包", 1, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, VENDOR_ITEM_REGULAR),
		list("黑色腿部挂包", 1, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, VENDOR_ITEM_REGULAR),
		list("织带", floor(scale * 2), /obj/item/clothing/accessory/storage/webbing, VENDOR_ITEM_REGULAR),
		list("黑色蛛网", floor(scale * 2), /obj/item/clothing/accessory/storage/webbing/black, VENDOR_ITEM_REGULAR),
		list("投掷袋", 0.75, /obj/item/clothing/accessory/storage/droppouch, VENDOR_ITEM_REGULAR),
		list("黑色滴液袋", 0.75, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("肩部枪套", 0.75, /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),

		list("护甲", -1, null, null),
		list("M3型运输车 海军陆战队员 装甲", floor(scale * 15), /obj/item/clothing/suit/storage/marine/medium/carrier, VENDOR_ITEM_REGULAR),
		list("M3型加厚海军陆战队员护甲", floor(scale * 15), /obj/item/clothing/suit/storage/marine/medium/padded, VENDOR_ITEM_REGULAR),
		list("M3型无衬垫式海军陆战队员护甲", floor(scale * 15), /obj/item/clothing/suit/storage/marine/medium/padless, VENDOR_ITEM_REGULAR),
		list("M3型棱纹海军陆战队员护甲", floor(scale * 15), /obj/item/clothing/suit/storage/marine/medium/padless_lines, VENDOR_ITEM_REGULAR),
		list("M3型骷髅头海军陆战队员护甲", floor(scale * 15), /obj/item/clothing/suit/storage/marine/medium/skull, VENDOR_ITEM_REGULAR),
		list("M3型平滑式海军陆战队员护甲", floor(scale * 15), /obj/item/clothing/suit/storage/marine/medium/smooth, VENDOR_ITEM_REGULAR),
		list("M3-EOD型重型护甲", floor(scale * 10), /obj/item/clothing/suit/storage/marine/heavy, VENDOR_ITEM_REGULAR),
		list("M3-L型轻量化装甲", floor(scale * 10), /obj/item/clothing/suit/storage/marine/light, VENDOR_ITEM_REGULAR),

		list("背包", -1, null, null, null),
		list("轻量化IMP背包", floor(scale * 15), /obj/item/storage/backpack/marine, VENDOR_ITEM_REGULAR),
		list("技师背包", floor(scale * 15), /obj/item/storage/backpack/marine/tech, VENDOR_ITEM_REGULAR),
		list("医疗背包", floor(scale * 15), /obj/item/storage/backpack/marine/medic, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 背包", floor(scale * 15), /obj/item/storage/backpack/marine/satchel, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）战术背心", floor(scale * 15), /obj/item/storage/backpack/marine/satchel/chestrig, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）技术炸药包", floor(scale * 15), /obj/item/storage/backpack/marine/satchel/tech, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）技术胸挂", floor(scale * 15), /obj/item/storage/backpack/marine/engineerpack/welder_chestrig, VENDOR_ITEM_REGULAR),
		list("医疗挎包", floor(scale * 15), /obj/item/storage/backpack/marine/satchel/medic, VENDOR_ITEM_REGULAR),
		list("霰弹枪枪套", floor(scale * 5), /obj/item/storage/large_holster/m37, VENDOR_ITEM_REGULAR),

		list("受限背包", -1, null, null),
		list("USCM（殖民地海军陆战队） 技师焊接包", 1.25, /obj/item/storage/backpack/marine/engineerpack, VENDOR_ITEM_REGULAR),
		list("技师焊工-挎包", floor(scale * 2), /obj/item/storage/backpack/marine/engineerpack/satchel, VENDOR_ITEM_REGULAR),
		list("无线电电话背包", 0.75, /obj/item/storage/backpack/marine/satchel/rto, VENDOR_ITEM_REGULAR),

		list("腰带", -1, null, null),
		list("M276 型弹药装载背带", floor(scale * 15), /obj/item/storage/belt/marine, VENDOR_ITEM_REGULAR),
		list("M276型M40榴弹携行具", floor(scale * 10), /obj/item/storage/belt/grenade, VENDOR_ITEM_REGULAR),
		list("M276型霰弹枪弹装填装置", floor(scale * 15), /obj/item/storage/belt/shotgun, VENDOR_ITEM_REGULAR),
		list("M276型通用手枪套携行系统", floor(scale * 15), /obj/item/storage/belt/gun/m4a3, VENDOR_ITEM_REGULAR),
		list("M276型M39手枪套装备", floor(scale * 15), /obj/item/storage/large_holster/m39, VENDOR_ITEM_REGULAR),
		list("M276型M39手枪套与弹匣包", floor(scale * 10), /obj/item/storage/belt/gun/m39, VENDOR_ITEM_REGULAR),
		list("M276 型 M10 枪套装备与弹药袋", floor(scale * 10), /obj/item/storage/belt/gun/m10, VENDOR_ITEM_REGULAR),
		list("M276型通用左轮手枪套携行系统", floor(scale * 15), /obj/item/storage/belt/gun/m44, VENDOR_ITEM_REGULAR),
		list("M276型M82F手枪套装备", floor(scale * 5), /obj/item/storage/belt/gun/flaregun, VENDOR_ITEM_REGULAR),
		list("M276 刀套（完整版）", floor(scale * 15), /obj/item/storage/belt/knifepouch, VENDOR_ITEM_REGULAR),
		list("M276 G8-A 通用工具袋", floor(scale * 15), /obj/item/storage/backpack/general_belt, VENDOR_ITEM_REGULAR),

		list("袋囊", -1, null, null, null),
		list("刺刀鞘（满）",floor(scale * 15), /obj/item/storage/pouch/bayonet, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", floor(scale * 15), /obj/item/storage/pouch/firstaid/full/alternate, VENDOR_ITEM_REGULAR),
		list("急救包（药丸包）", floor(scale * 15), /obj/item/storage/pouch/firstaid/full/pills, VENDOR_ITEM_REGULAR),
		list("闪光弹包（满）", floor(scale * 15), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("小型文件袋", floor(scale * 15), /obj/item/storage/pouch/document/small, VENDOR_ITEM_REGULAR),
		list("弹匣袋", floor(scale * 15), /obj/item/storage/pouch/magazine, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹袋", floor(scale * 15), /obj/item/storage/pouch/shotgun, VENDOR_ITEM_REGULAR),
		list("中型通用袋", floor(scale * 15), /obj/item/storage/pouch/general/medium, VENDOR_ITEM_REGULAR),
		list("手枪弹匣袋", floor(scale * 15), /obj/item/storage/pouch/magazine/pistol, VENDOR_ITEM_REGULAR),
		list("手枪袋", floor(scale * 15), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),

		list("限制性包裹", -1, null, null, null),
		list("建造袋", 1.25, /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("爆裂袋", 1.25, /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("急救包（空）", 2.5, /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", floor(scale * 2), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("工具袋", 1.25, /obj/item/storage/pouch/tools, VENDOR_ITEM_REGULAR),
		list("投石袋", 1.25, /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),

		list("面具", -1, null, null, null),
		list("防毒面具", floor(scale * 15), /obj/item/clothing/mask/gas, VENDOR_ITEM_REGULAR),
		list("吸热头巾", floor(scale * 10), /obj/item/clothing/mask/rebreather/scarf, VENDOR_ITEM_REGULAR),
		list("循环呼吸器", floor(scale * 10), /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("杂项", -1, null, null, null),
		list("防弹护目镜", floor(scale * 10), /obj/item/clothing/glasses/mgoggles, VENDOR_ITEM_REGULAR),
		list("M1A1 弹道护目镜", floor(scale * 10), /obj/item/clothing/glasses/mgoggles/v2, VENDOR_ITEM_REGULAR),
		list("处方防弹护目镜", floor(scale * 10), /obj/item/clothing/glasses/mgoggles/prescription, VENDOR_ITEM_REGULAR),
		list("陆战队员RPG眼镜", floor(scale * 10), /obj/item/clothing/glasses/regular, VENDOR_ITEM_REGULAR),
		list("M5综合防毒面具", floor(scale * 10), /obj/item/prop/helmetgarb/helmet_gasmask, VENDOR_ITEM_REGULAR),
		list("M10头盔伪装网", floor(scale * 10), /obj/item/clothing/accessory/helmet/cover/netting, VENDOR_ITEM_REGULAR),
		list("M10头盔防雨罩", floor(scale * 10), /obj/item/clothing/accessory/helmet/cover/raincover, VENDOR_ITEM_REGULAR),
		list("枪械润滑油", floor(scale * 15), /obj/item/prop/helmetgarb/gunoil, VENDOR_ITEM_REGULAR),
		list("可挂载身份牌", floor(scale * 15), /obj/item/clothing/accessory/dogtags, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 徽章", floor(scale * 15), /obj/item/prop/helmetgarb/flair_uscm, VENDOR_ITEM_REGULAR),
		list("坠落猎鹰肩章", floor(scale * 15), /obj/item/clothing/accessory/patch/falcon, VENDOR_ITEM_REGULAR),
		list("坠落猎鹰UA肩章", floor(scale * 15), /obj/item/clothing/accessory/patch/falconalt, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）大型胸章", floor(scale * 15), /obj/item/clothing/accessory/patch/uscmlarge, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 肩章", floor(scale * 15), /obj/item/clothing/accessory/patch, VENDOR_ITEM_REGULAR),
		list("联合美洲肩章", floor(scale * 10), /obj/item/clothing/accessory/patch/ua, VENDOR_ITEM_REGULAR),
		list("联合美洲国旗肩章", floor(scale * 10), /obj/item/clothing/accessory/patch/uasquare, VENDOR_ITEM_REGULAR),
		list("铺盖卷", floor(scale * 20), /obj/item/roller/bedroll, VENDOR_ITEM_REGULAR),
		list("M5摄像装备", floor(scale * 2), /obj/item/device/overwatch_camera, VENDOR_ITEM_REGULAR),

		list("光学", -1, null, null, null),
		list("高级医疗光学（仅限医护兵）", floor(scale * 4), /obj/item/device/helmet_visor/medical/advanced, VENDOR_ITEM_REGULAR),
		list("小队光学", floor(scale * 15), /obj/item/device/helmet_visor, VENDOR_ITEM_REGULAR),

		)

//--------------SQUAD SPECIFIC VERSIONS--------------
//Those vendors aren't being used i will make them us the main vendor a parent to avoid having four different
// list with just the headset changed.

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/alpha
	req_access = list(ACCESS_MARINE_PREP)
	req_one_access = list(ACCESS_MARINE_ALPHA, ACCESS_MARINE_GENERAL, ACCESS_MARINE_CARGO)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/alpha/populate_product_list(scale)
	..()
	listed_products += list(
		list("耳机", -1, null, null),
		list("海军陆战队员 Alpha 无线电耳机", 10, /obj/item/device/radio/headset/almayer/marine/alpha, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/bravo
	req_access = list(ACCESS_MARINE_PREP)
	req_one_access = list(ACCESS_MARINE_BRAVO, ACCESS_MARINE_GENERAL, ACCESS_MARINE_CARGO)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/bravo/populate_product_list(scale)
	..()
	listed_products += list(
		list("耳机", -1, null, null),
		list("海军陆战队员 Bravo 无线电耳机", 10, /obj/item/device/radio/headset/almayer/marine/bravo, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/charlie
	req_access = list(ACCESS_MARINE_PREP)
	req_one_access = list(ACCESS_MARINE_CHARLIE, ACCESS_MARINE_GENERAL, ACCESS_MARINE_CARGO)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/charlie/populate_product_list(scale)
	..()
	listed_products += list(
		list("耳机", -1, null, null),
		list("海军陆战队员查理无线电耳机", 10, /obj/item/device/radio/headset/almayer/marine/charlie, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/delta
	req_access = list(ACCESS_MARINE_PREP)
	req_one_access = list(ACCESS_MARINE_DELTA, ACCESS_MARINE_GENERAL, ACCESS_MARINE_CARGO)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/delta/populate_product_list(scale)
	..()
	listed_products += list(
		list("耳机", -1, null, null),
		list("海军陆战队员 Delta 无线电耳机", 10, /obj/item/device/radio/headset/almayer/marine/delta, VENDOR_ITEM_REGULAR),
		)

//--------------SQUAD MUNITION VENDOR--------------

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/squad
	name = "\improper 科马尔科技（殖民地海军陆战队科技）自动弹药小队供应商"
	desc = "连接至小型存储库的自动化补给架，存放各类弹药。任何陆战队步枪兵均可使用。"
	req_access = list(ACCESS_MARINE_ALPHA)
	req_one_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_SPECPREP, ACCESS_MARINE_RO)
	hackable = TRUE
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_STOCK_DYNAMIC

	vend_x_offset = 2

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/squad/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state


/obj/structure/machinery/cm_vending/sorted/cargo_ammo/squad/populate_product_list(scale)
	listed_products = list(
		list("穿甲弹药", -1, null, null),
		list("M4RA AP 弹匣（10x24毫米）", 3.5, /obj/item/ammo_magazine/rifle/m4ra/ap, VENDOR_ITEM_REGULAR),
		list("M10 AP 弹匣（10x20mm-APC）", floor(scale * 4), /obj/item/ammo_magazine/pistol/m10/ap , VENDOR_ITEM_REGULAR),
		list("M10 AP 加长弹匣（10x20mm-APC）", floor(scale * 2), /obj/item/ammo_magazine/pistol/m10/ap/extended , VENDOR_ITEM_REGULAR),
		list("M39穿甲弹匣（10x20毫米）", floor(scale * 3), /obj/item/ammo_magazine/smg/m39/ap, VENDOR_ITEM_REGULAR),
		list("M41A穿甲弹匣（10x24毫米）", floor(scale * 3), /obj/item/ammo_magazine/rifle/ap, VENDOR_ITEM_REGULAR),

		list("扩充弹药", -1, null, null),
		list("M4RA 扩展弹匣（10x24毫米）", 1.8, /obj/item/ammo_magazine/rifle/m4ra/extended, null, VENDOR_ITEM_REGULAR),
		list("M39加长弹匣（10x20毫米）", 1.8, /obj/item/ammo_magazine/smg/m39/extended, VENDOR_ITEM_REGULAR),
		list("M41A加长弹匣（10x24毫米）", 1.9, /obj/item/ammo_magazine/rifle/extended, VENDOR_ITEM_REGULAR),
		list("M10 HV 加长弹匣（10x20mm-APC）", floor(scale * 4), /obj/item/ammo_magazine/pistol/m10/extended , VENDOR_ITEM_REGULAR),

		list("特殊弹药", -1, null, null),
		list("M56智能枪弹鼓", 1, /obj/item/ammo_magazine/smartgun, VENDOR_ITEM_REGULAR),
		list("M44重型快速装弹器（.44口径）", floor(scale * 2), /obj/item/ammo_magazine/revolver/heavy, VENDOR_ITEM_REGULAR),
		list("M44神射手快速装弹器（.44口径）", floor(scale * 2), /obj/item/ammo_magazine/revolver/marksman, VENDOR_ITEM_REGULAR),
		list("M4A3 穿甲弹弹匣", floor(scale * 2), /obj/item/ammo_magazine/pistol/ap, VENDOR_ITEM_REGULAR),

		list("限制级枪械弹药", -1, null, null),
		list("VP78 弹匣", floor(scale * 5), /obj/item/ammo_magazine/pistol/vp78, VENDOR_ITEM_REGULAR),
		list("SU-6智能手枪弹匣（.45口径）", floor(scale * 5), /obj/item/ammo_magazine/pistol/smart, VENDOR_ITEM_REGULAR),
		list("M240 焚化坦克", floor(scale * 3), /obj/item/ammo_magazine/flamer_tank, VENDOR_ITEM_REGULAR),
		list("M56D 弹鼓", floor(scale * 2), /obj/item/ammo_magazine/m56d, VENDOR_ITEM_REGULAR),
		list("M2C 弹匣", floor(scale * 2), /obj/item/ammo_magazine/m2c, VENDOR_ITEM_REGULAR),
		list("HIRR 警棍弹", floor(scale * 6), /obj/item/explosive/grenade/slug/baton, VENDOR_ITEM_REGULAR),
		list("M74 AGM-S 星爆弹", floor(scale * 4), /obj/item/explosive/grenade/high_explosive/airburst/starshell, VENDOR_ITEM_REGULAR),
		list("M74 AGM-H 大黄蜂炮弹", floor(scale * 4), /obj/item/explosive/grenade/high_explosive/airburst/hornet_shell, VENDOR_ITEM_REGULAR),
		)

//--------------SQUAD ARMAMENTS VENDOR--------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad
	name = "\improper 科马科技（殖民地海军陆战队科技）自动化公共事业小队供应商"
	desc = "连接至小型存储库的自动化补给架，存放各类工具和实用装备。任何陆战队步枪兵均可使用。"
	req_access = list(ACCESS_MARINE_ALPHA)
	req_one_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_SPECPREP, ACCESS_MARINE_RO)
	hackable = TRUE

	vend_x_offset = 2
	vend_y_offset = 1
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_STOCK_DYNAMIC

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/populate_product_list(scale)
	listed_products = list(
		list("食物", -1, null, null),
		list("单兵即食口粮", floor(scale * 5), /obj/item/storage/box/mre, VENDOR_ITEM_REGULAR),
		list("MRE 补给箱", floor(scale * 1), /obj/item/ammo_box/magazine/misc/mre, VENDOR_ITEM_REGULAR),

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
		list("M89-S 信号弹包", floor(scale * 1), /obj/item/storage/box/m94/signal, VENDOR_ITEM_REGULAR),

		list("杂项", -1, null, null),
		list("工程师套件", floor(scale * 1), /obj/item/storage/toolkit/empty, VENDOR_ITEM_REGULAR),
		list("地图", floor(scale * 5), /obj/item/map/current_map, VENDOR_ITEM_REGULAR),
		list("灭火器", floor(scale * 5), /obj/item/tool/extinguisher, VENDOR_ITEM_REGULAR),
		list("灭火器（便携式）", floor(scale * 1), /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("滚筒床", floor(scale * 1), /obj/item/roller, VENDOR_ITEM_REGULAR),
		list("砍刀刀鞘（完整）", floor(scale * 5), /obj/item/storage/large_holster/machete/full, VENDOR_ITEM_REGULAR),
		list("望远镜", floor(scale * 1), /obj/item/device/binoculars, VENDOR_ITEM_REGULAR),
		list("MB-6 折叠式路障 (x3)", floor(scale * 2), /obj/item/stack/folding_barricade/three, VENDOR_ITEM_REGULAR),
		list("备用PDT/L战斗伙伴套件", floor(scale * 3), /obj/item/storage/box/pdt_kit, VENDOR_ITEM_REGULAR),
		list("W-Y品牌可充电迷你电池", floor(scale * 2.5), /obj/item/cell/crap, VENDOR_ITEM_REGULAR),
		list("钉枪弹匣（7x45毫米）", floor(scale * 4), /obj/item/ammo_magazine/smg/nailgun, VENDOR_ITEM_REGULAR)
		)

//--------------SQUAD ATTACHMENTS VENDOR--------------

/obj/structure/machinery/cm_vending/sorted/attachments/squad
	name = "\improper 阿玛特战场系统小队配件供应商"
	desc = "连接至小型存储库的自动化补给架，存放武器配件。任何陆战队步枪兵均可使用。"
	req_access = list(ACCESS_MARINE_ALPHA)
	req_one_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_SPECPREP, ACCESS_MARINE_RO)
	hackable = TRUE
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_STOCK_DYNAMIC

	vend_y_offset = 1

/obj/structure/machinery/cm_vending/sorted/attachments/squad/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/attachments/squad/populate_product_list(scale)
	listed_products = list(
		list("枪管", -1, null, null),
		list("桶装冲锋者", 0.75, /obj/item/attachable/heavy_barrel, VENDOR_ITEM_REGULAR),
		list("延长型后坐力补偿器", 2.5, /obj/item/attachable/extended_barrel/vented, VENDOR_ITEM_REGULAR),
		list("加长枪管", 2.5, /obj/item/attachable/extended_barrel, VENDOR_ITEM_REGULAR),
		list("后坐力补偿器", 2.5, /obj/item/attachable/compensator, VENDOR_ITEM_REGULAR),
		list("M10补偿器", 2.5, /obj/item/attachable/compensator/m10, VENDOR_ITEM_REGULAR),
		list("消音器", 2.5, /obj/item/attachable/suppressor, VENDOR_ITEM_REGULAR),
		list("抑制器，紧凑型", 2.5, /obj/item/attachable/suppressor/sleek, VENDOR_ITEM_REGULAR),
		list("霰弹枪收束器", 1.5, /obj/item/attachable/shotgun_choke, VENDOR_ITEM_REGULAR),

		list("铁路", -1, null, null),
		list("B8智能瞄准镜", 1.5, /obj/item/attachable/alt_iff_scope, VENDOR_ITEM_REGULAR),
		list("磁力束带", 4, /obj/item/attachable/magnetic_harness, VENDOR_ITEM_REGULAR),
		list("S4 2倍伸缩迷你瞄准镜", 2, /obj/item/attachable/scope/mini, VENDOR_ITEM_REGULAR),
		list("S5 红点瞄准镜", 3, /obj/item/attachable/reddot, VENDOR_ITEM_REGULAR),
		list("S5-微型红点瞄准镜", 3, /obj/item/attachable/reddot/small, VENDOR_ITEM_REGULAR),
		list("S6 反射式瞄准镜", 3, /obj/item/attachable/reflex, VENDOR_ITEM_REGULAR),
		list("S8 4倍伸缩式瞄准镜", 2, /obj/item/attachable/scope, VENDOR_ITEM_REGULAR),

		list("下挂式枪管", -1, null, null),
		list("直角握把", 2.5, /obj/item/attachable/angledgrip, VENDOR_ITEM_REGULAR),
		list("两脚架", 2.5, /obj/item/attachable/bipod, VENDOR_ITEM_REGULAR),
		list("连发组件", 1.5, /obj/item/attachable/burstfire_assembly, VENDOR_ITEM_REGULAR),
		list("陀螺稳定器", 1.5, /obj/item/attachable/gyro, VENDOR_ITEM_REGULAR),
		list("激光瞄准镜", 3, /obj/item/attachable/lasersight, VENDOR_ITEM_REGULAR),
		list("微型激光瞄准镜", 1.5, /obj/item/attachable/lasersight/micro, VENDOR_ITEM_REGULAR),
		list("迷你火焰喷射器", 1.5, /obj/item/attachable/attached_gun/flamer, VENDOR_ITEM_REGULAR),
		list("XM-VESG-1 火焰喷射器喷嘴", 1.5, /obj/item/attachable/attached_gun/flamer_nozzle, VENDOR_ITEM_REGULAR),
		list("U7 下挂式霰弹枪", 1.5, /obj/item/attachable/attached_gun/shotgun, VENDOR_ITEM_REGULAR),
		list("下挂式灭火器", 1.5, /obj/item/attachable/attached_gun/extinguisher, VENDOR_ITEM_REGULAR),
		list("垂直握把", 3, /obj/item/attachable/verticalgrip, VENDOR_ITEM_REGULAR),

		list("库存", -1, null, null),
		list("M10 实心库存", 1.5, /obj/item/attachable/stock/m10_solid, VENDOR_ITEM_REGULAR),
		list("M37A2 可折叠枪托", 1.5, /obj/item/attachable/stock/synth/collapsible, VENDOR_ITEM_REGULAR),
		list("M39 臂托", 1.5, /obj/item/attachable/stock/smg/collapsible/brace, VENDOR_ITEM_REGULAR),
		list("M39 枪托", 1.5, /obj/item/attachable/stock/smg, VENDOR_ITEM_REGULAR),
		list("M41A 实心枪托", 1.5, /obj/item/attachable/stock/rifle, VENDOR_ITEM_REGULAR),
		list("M44马格南神射手枪托", 1.5, /obj/item/attachable/stock/revolver, VENDOR_ITEM_REGULAR)
		)

//------------ESSENTIAL SETS---------------
/obj/effect/essentials_set/random/uscm_light_armor
	spawned_gear_list = list(
		/obj/item/clothing/suit/storage/marine/light/padded,
		/obj/item/clothing/suit/storage/marine/light/padless,
		/obj/item/clothing/suit/storage/marine/light/padless_lines,
		/obj/item/clothing/suit/storage/marine/light/carrier,
		/obj/item/clothing/suit/storage/marine/light/skull,
		/obj/item/clothing/suit/storage/marine/light/smooth,
	)

/obj/effect/essentials_set/random/uscm_heavy_armor
	spawned_gear_list = list(
		/obj/item/clothing/suit/storage/marine/heavy/padded,
		/obj/item/clothing/suit/storage/marine/heavy/padless,
		/obj/item/clothing/suit/storage/marine/heavy/padless_lines,
		/obj/item/clothing/suit/storage/marine/heavy/carrier,
		/obj/item/clothing/suit/storage/marine/heavy/skull,
		/obj/item/clothing/suit/storage/marine/heavy/smooth,
	)

//------------MARINE CIVILIAN CLOTHING---------------

GLOBAL_LIST_INIT(cm_vending_clothing_marine_snowflake, list(
	list("衬衫与制服", 0, null, null, null),
	list("白色T恤与棕色牛仔裤", 12, /obj/item/clothing/under/tshirt/w_br, null, VENDOR_ITEM_REGULAR),
	list("灰色T恤与蓝色牛仔裤", 12, /obj/item/clothing/under/tshirt/gray_blu, null, VENDOR_ITEM_REGULAR),
	list("红色T恤与黑色牛仔裤", 12, /obj/item/clothing/under/tshirt/r_bla, null, VENDOR_ITEM_REGULAR),
	list("前沿连体服", 12, /obj/item/clothing/under/rank/frontier, null, VENDOR_ITEM_REGULAR),
	list("UA灰色连体服", 12, /obj/item/clothing/under/rank/utility/gray, null, VENDOR_ITEM_REGULAR),
	list("UA棕色连体服", 12, /obj/item/clothing/under/rank/utility/brown, null, VENDOR_ITEM_REGULAR),
	list("UA绿色公用事业制服", 12, /obj/item/clothing/under/rank/utility, null, VENDOR_ITEM_REGULAR),
	list("灰色公用事业", 12, /obj/item/clothing/under/rank/utility/yellow, null, VENDOR_ITEM_REGULAR),
	list("灰色公用事业与蓝色牛仔裤", 12, /obj/item/clothing/under/rank/utility/red, null, VENDOR_ITEM_REGULAR),
	list("蓝色工具与棕色牛仔裤", 12, /obj/item/clothing/under/rank/utility/blue, null, VENDOR_ITEM_REGULAR),
	list("白色服务制服", 12, /obj/item/clothing/under/colonist/white_service, null, VENDOR_ITEM_REGULAR),
	list("管家服饰", 12, /obj/item/clothing/under/colonist/steward, null, VENDOR_ITEM_REGULAR),
	list("红色连衣裙裙", 12, /obj/item/clothing/under/blackskirt, null, VENDOR_ITEM_REGULAR),
	list("蓝色西装裤", 12, /obj/item/clothing/under/liaison_suit/blue, null, VENDOR_ITEM_REGULAR),
	list("棕色西装裤", 12, /obj/item/clothing/under/liaison_suit/brown, null, VENDOR_ITEM_REGULAR),
	list("白色西装裤", 12, /obj/item/clothing/under/liaison_suit/corporate_formal, null, VENDOR_ITEM_REGULAR),
	list("乔伊工作服", 36, /obj/item/clothing/under/rank/synthetic/joe, null, VENDOR_ITEM_REGULAR),

	list("眼镜", 0, null, null, null),
	list("陆战队RPG眼镜", 12, /obj/item/clothing/glasses/regular, null, VENDOR_ITEM_REGULAR),
	list("太阳镜", 12, /obj/item/clothing/glasses/sunglasses, null, VENDOR_ITEM_REGULAR),

	list("鞋子", 0, null, null, null),
	list("靴子", 12, /obj/item/clothing/shoes/marine, null, VENDOR_ITEM_REGULAR),
	list("鞋子，黑色", 12, /obj/item/clothing/shoes/black, null, VENDOR_ITEM_REGULAR),
	list("鞋子，蓝色", 12, /obj/item/clothing/shoes/blue, null, VENDOR_ITEM_REGULAR),
	list("鞋子，棕色", 12, /obj/item/clothing/shoes/brown, null, VENDOR_ITEM_REGULAR),
	list("鞋子，绿色", 12, /obj/item/clothing/shoes/green, null, VENDOR_ITEM_REGULAR),
	list("鞋子，紫色", 12, /obj/item/clothing/shoes/purple, null, VENDOR_ITEM_REGULAR),
	list("鞋子，红色", 12, /obj/item/clothing/shoes/red, null, VENDOR_ITEM_REGULAR),
	list("鞋子，白色", 12, /obj/item/clothing/shoes/white, null, VENDOR_ITEM_REGULAR),
	list("鞋子，黄色", 12, /obj/item/clothing/shoes/yellow, null, VENDOR_ITEM_REGULAR),

	list("头部装备", 0, null, null, null),
	list("豆豆帽", 12, /obj/item/clothing/head/beanie, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，工程", 12, /obj/item/clothing/head/beret/eng, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，紫色", 12, /obj/item/clothing/head/beret/jan, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，红色", 12, /obj/item/clothing/head/beret/cm/red, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，标准型", 12, /obj/item/clothing/head/beret/cm, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，棕褐色", 12, /obj/item/clothing/head/beret/cm/tan, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，绿色", 12, /obj/item/clothing/head/beret/cm, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
	list("贝雷帽，黑色", 12, /obj/item/clothing/head/beret/cm/black, null, VENDOR_ITEM_REGULAR),
	list("贝雷帽，白色", 12, /obj/item/clothing/head/beret/cm/white, null, VENDOR_ITEM_REGULAR),
	list("乌沙帽", 12, /obj/item/clothing/head/ushanka, null, VENDOR_ITEM_REGULAR),
	list("帽子", 12, /obj/item/clothing/head/cmcap, null, VENDOR_ITEM_REGULAR),

	list("西装", 0, null, null, null),
	list("轰炸机夹克，棕色", 12, /obj/item/clothing/suit/storage/bomber, null, VENDOR_ITEM_REGULAR),
	list("轰炸机夹克，黑色", 12, /obj/item/clothing/suit/storage/bomber/alt, null, VENDOR_ITEM_REGULAR),
	list("外部织带", 12, /obj/item/clothing/suit/storage/webbing, null, VENDOR_ITEM_REGULAR),
	list("实用背心", 12, /obj/item/clothing/suit/storage/utility_vest, null, VENDOR_ITEM_REGULAR),
	list("危险警示背心（橙色）", 12, /obj/item/clothing/suit/storage/hazardvest, null, VENDOR_ITEM_REGULAR),
	list("危险背心（蓝色）", 12, /obj/item/clothing/suit/storage/hazardvest/blue, null, VENDOR_ITEM_REGULAR),
	list("危险警示背心（黄色）", 12, /obj/item/clothing/suit/storage/hazardvest/yellow, null, VENDOR_ITEM_REGULAR),
	list("危险背心（黑色）", 12, /obj/item/clothing/suit/storage/hazardvest/black, null, VENDOR_ITEM_REGULAR),
	list("USCM（殖民地海军陆战队）服役档案", 12, /obj/item/clothing/suit/storage/jacket/marine/service, null, VENDOR_ITEM_REGULAR),
	list("防风夹克，棕色", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_brown, null, VENDOR_ITEM_REGULAR),
	list("防风夹克，灰色", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_gray, null, VENDOR_ITEM_REGULAR),
	list("防风夹克，绿色", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_green, null, VENDOR_ITEM_REGULAR),
	list("防风夹克，第一响应者", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_fr, null, VENDOR_ITEM_REGULAR),
	list("防风外套，探索", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_covenant, null, VENDOR_ITEM_REGULAR),
	list("黑色西装外套", 12, /obj/item/clothing/suit/storage/jacket/marine/corporate/black, null, VENDOR_ITEM_REGULAR),
	list("棕色西装外套", 12, /obj/item/clothing/suit/storage/jacket/marine/corporate/brown, null, VENDOR_ITEM_REGULAR),
	list("蓝色西装外套", 12, /obj/item/clothing/suit/storage/jacket/marine/corporate/blue, null, VENDOR_ITEM_REGULAR),
	list("棕色背心", 12, /obj/item/clothing/suit/storage/jacket/marine/vest, null, VENDOR_ITEM_REGULAR),
	list("棕褐色背心", 12, /obj/item/clothing/suit/storage/jacket/marine/vest/tan, null, VENDOR_ITEM_REGULAR),
	list("灰色背心", 12, /obj/item/clothing/suit/storage/jacket/marine/vest/grey, null, VENDOR_ITEM_REGULAR),

	list("背包", 0, null, null, null),
	list("背包，工业型", 12, /obj/item/storage/backpack/industrial, null, VENDOR_ITEM_REGULAR),
	list("皮制挎包", 12, /obj/item/storage/backpack/satchel, null, VENDOR_ITEM_REGULAR),
	list("挎包，医疗", 12, /obj/item/storage/backpack/satchel/med, null, VENDOR_ITEM_REGULAR),

	list("其他", 0, null, null, null),
	list("红袖章", 6, /obj/item/clothing/accessory/armband, null, VENDOR_ITEM_REGULAR),
	list("紫色臂章", 6, /obj/item/clothing/accessory/armband/science, null, VENDOR_ITEM_REGULAR),
	list("黄色臂章", 6, /obj/item/clothing/accessory/armband/engine, null, VENDOR_ITEM_REGULAR),
	list("绿色臂章", 6, /obj/item/clothing/accessory/armband/medgreen, null, VENDOR_ITEM_REGULAR),
	list("礼服手套", 6, /obj/item/clothing/gloves/marine/dress, null, VENDOR_ITEM_REGULAR),

))

/obj/structure/machinery/cm_vending/clothing/marine/snowflake
	name = "\improper 个人便服存储单元"
	desc = "存放你执勤期间个人便服的自动售货机。"
	icon_state = "snowflake"
	show_points = TRUE
	use_snowflake_points = TRUE
	vendor_theme = VENDOR_THEME_COMPANY
	req_access = list()
	vendor_role = list()

	vend_delay = 1 SECONDS

/obj/structure/machinery/cm_vending/clothing/marine/snowflake/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_marine_snowflake
