//------------WHISKEY OUTPOST VENDOR VEERSIONS---------------

//------------UNIFORM VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/wo
	req_access = list()
	req_one_access = list()

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/wo/populate_product_list(scale)
	listed_products = list(
		list("标准装备", -1, null, null, null),
		list("海军陆战队员 战斗靴", floor(scale * 10), /obj/item/clothing/shoes/marine, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 Brown 战斗靴", floor(scale * 2), /obj/item/clothing/shoes/marine/brown, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 制服", floor(scale * 10), /obj/item/clothing/under/marine, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 战斗 手套", floor(scale * 10), /obj/item/clothing/gloves/marine, VENDOR_ITEM_REGULAR),
		list("海军陆战队员布朗战斗手套", floor(scale * 2), /obj/item/clothing/gloves/marine/brown, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 Black 战斗手套", floor(scale * 2), /obj/item/clothing/gloves/marine/black, VENDOR_ITEM_REGULAR),
		list("M10型海军陆战队员头盔", floor(scale * 10), /obj/item/clothing/head/helmet/marine, VENDOR_ITEM_REGULAR),

		list("无线电耳机", -1, null, null),
		list("海军陆战队员阿尔法无线电耳机", floor(scale * 5), /obj/item/device/radio/headset/almayer/marine/alpha, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 Bravo 无线电耳机", floor(scale * 5), /obj/item/device/radio/headset/almayer/marine/bravo, VENDOR_ITEM_REGULAR),
		list("海军陆战队员查理无线电耳机", floor(scale * 5), /obj/item/device/radio/headset/almayer/marine/charlie, VENDOR_ITEM_REGULAR),
		list("海军陆战队员 Delta 无线电耳机", floor(scale * 5), /obj/item/device/radio/headset/almayer/marine/delta, VENDOR_ITEM_REGULAR),
		list("海军陆战队员无线电耳机", floor(scale * 5), /obj/item/device/radio/headset/almayer, VENDOR_ITEM_REGULAR),

		list("织带", -1, null, null),
		list("棕色网眼背心", floor(scale * 1), /obj/item/clothing/accessory/storage/black_vest/brown_vest, VENDOR_ITEM_REGULAR),
		list("黑色网眼背心", floor(scale * 1), /obj/item/clothing/accessory/storage/black_vest, VENDOR_ITEM_REGULAR),
		list("织带", floor(scale * 2), /obj/item/clothing/accessory/storage/webbing, VENDOR_ITEM_REGULAR),
		list("投掷袋", floor(scale * 1), /obj/item/clothing/accessory/storage/droppouch, VENDOR_ITEM_REGULAR),
		list("肩部枪套", floor(scale * 1), /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),

		list("护甲", -1, null, null),
		list("M3型运输车 海军陆战队员 装甲", floor(scale * 10), /obj/item/clothing/suit/storage/marine/medium/carrier, VENDOR_ITEM_REGULAR),
		list("M3型加厚海军陆战队员护甲", floor(scale * 10), /obj/item/clothing/suit/storage/marine/medium/padded, VENDOR_ITEM_REGULAR),
		list("M3型无衬垫海军陆战队员护甲", floor(scale * 10), /obj/item/clothing/suit/storage/marine/medium/padless, VENDOR_ITEM_REGULAR),
		list("M3型棱纹海军陆战队员护甲", floor(scale * 10), /obj/item/clothing/suit/storage/marine/medium/padless_lines, VENDOR_ITEM_REGULAR),
		list("M3型骷髅头海军陆战队员护甲", floor(scale * 10), /obj/item/clothing/suit/storage/marine/medium/skull, VENDOR_ITEM_REGULAR),
		list("M3型平滑式海军陆战队员护甲", floor(scale * 10), /obj/item/clothing/suit/storage/marine/medium/smooth, VENDOR_ITEM_REGULAR),
		list("M3-EOD型重型护甲", floor(scale * 5), /obj/item/clothing/suit/storage/marine/heavy, VENDOR_ITEM_REGULAR),
		list("M3-L型轻量化装甲", floor(scale * 5), /obj/item/clothing/suit/storage/marine/light, VENDOR_ITEM_REGULAR),

		list("背包", -1, null, null, null),
		list("轻量化IMP背包", floor(scale * 10), /obj/item/storage/backpack/marine, VENDOR_ITEM_REGULAR),
		list("技师背包", floor(scale * 10), /obj/item/storage/backpack/marine/tech, VENDOR_ITEM_REGULAR),
		list("医疗背包", floor(scale * 10), /obj/item/storage/backpack/marine/medic, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 背包", floor(scale * 10), /obj/item/storage/backpack/marine/satchel, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）战术背心", floor(scale * 10), /obj/item/storage/backpack/marine/satchel/chestrig, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）技术炸药包", floor(scale * 10), /obj/item/storage/backpack/marine/satchel/tech, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）技术携行具", floor(scale * 10), /obj/item/storage/backpack/marine/engineerpack/welder_chestrig, VENDOR_ITEM_REGULAR),
		list("医疗挎包", floor(scale * 10), /obj/item/storage/backpack/marine/satchel/medic, VENDOR_ITEM_REGULAR),
		list("霰弹枪枪套", floor(scale * 10), /obj/item/storage/large_holster/m37, VENDOR_ITEM_REGULAR),

		list("限制背包", -1, null, null),
		list("USCM（殖民地海军陆战队） 技师焊接包", floor(scale * 1), /obj/item/storage/backpack/marine/engineerpack, VENDOR_ITEM_REGULAR),
		list("技术员焊工-工具包", floor(scale * 2), /obj/item/storage/backpack/marine/engineerpack/satchel, VENDOR_ITEM_REGULAR),

		list("腰带", -1, null, null),
		list("M276 型弹药装载背带", floor(scale * 10), /obj/item/storage/belt/marine, VENDOR_ITEM_REGULAR),
		list("M276型M40榴弹携行具", floor(scale * 5), /obj/item/storage/belt/grenade, VENDOR_ITEM_REGULAR),
		list("M276型霰弹枪弹装填装置", floor(scale * 10), /obj/item/storage/belt/shotgun, VENDOR_ITEM_REGULAR),
		list("M276型通用手枪套携行系统", floor(scale * 10), /obj/item/storage/belt/gun/m4a3, VENDOR_ITEM_REGULAR),
		list("M276型M39手枪套装备", floor(scale * 10), /obj/item/storage/large_holster/m39, VENDOR_ITEM_REGULAR),
		list("M276型M39手枪套与弹匣袋", floor(scale * 5), /obj/item/storage/belt/gun/m39, VENDOR_ITEM_REGULAR),
		list("M276型通用左轮手枪套携行系统", floor(scale * 10), /obj/item/storage/belt/gun/m44, VENDOR_ITEM_REGULAR),
		list("M276型M82F手枪套装备", floor(scale * 2), /obj/item/storage/belt/gun/flaregun, VENDOR_ITEM_REGULAR),
		list("M276 刀套（完整版）", floor(scale * 10), /obj/item/storage/belt/knifepouch, VENDOR_ITEM_REGULAR),
		list("M276 G8-A 通用工具袋", floor(scale * 10), /obj/item/storage/backpack/general_belt, VENDOR_ITEM_REGULAR),

		list("袋囊", -1, null, null, null),
		list("刺刀鞘（满）",floor(scale * 10), /obj/item/storage/pouch/bayonet, VENDOR_ITEM_REGULAR),
		list("急救包（含夹板、纱布、药膏）", floor(scale * 10), /obj/item/storage/pouch/firstaid/full/alternate, VENDOR_ITEM_REGULAR),
		list("急救包（药片包）", floor(scale * 10), /obj/item/storage/pouch/firstaid/full/pills, VENDOR_ITEM_REGULAR),
		list("闪光弹袋（满）", floor(scale * 10), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("小型文件袋", floor(scale * 10), /obj/item/storage/pouch/document/small, VENDOR_ITEM_REGULAR),
		list("弹匣袋", floor(scale * 10), /obj/item/storage/pouch/magazine, VENDOR_ITEM_REGULAR),
		list("霰弹枪弹袋", floor(scale * 10), /obj/item/storage/pouch/shotgun, VENDOR_ITEM_REGULAR),
		list("中型通用袋", floor(scale * 10), /obj/item/storage/pouch/general/medium, VENDOR_ITEM_REGULAR),
		list("手枪弹匣袋", floor(scale * 10), /obj/item/storage/pouch/magazine/pistol, VENDOR_ITEM_REGULAR),
		list("手枪袋", floor(scale * 10), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),

		list("限制性包裹", -1, null, null, null),
		list("建筑袋", floor(scale * 1), /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("爆裂袋", floor(scale * 1), /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("急救包（空）", floor(scale * 2), /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("大型手枪弹匣袋", floor(scale * 2), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("工具袋", floor(scale * 1), /obj/item/storage/pouch/tools, VENDOR_ITEM_REGULAR),
		list("投石袋", floor(scale * 1), /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),

		list("面具", -1, null, null, null),
		list("防毒面具", floor(scale * 10), /obj/item/clothing/mask/gas, VENDOR_ITEM_REGULAR),
		list("吸热头巾", floor(scale * 5), /obj/item/clothing/mask/rebreather/scarf, VENDOR_ITEM_REGULAR),
		list("循环呼吸器", floor(scale * 5), /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("杂项", -1, null, null, null),
		list("防弹护目镜", floor(scale * 5), /obj/item/clothing/glasses/mgoggles, VENDOR_ITEM_REGULAR),
		list("M1A1 弹道护目镜", floor(scale * 5), /obj/item/clothing/glasses/mgoggles/v2, VENDOR_ITEM_REGULAR),
		list("处方防弹护目镜", floor(scale * 5), /obj/item/clothing/glasses/mgoggles/prescription, VENDOR_ITEM_REGULAR),
		list("陆战队员RPG眼镜", floor(scale * 5), /obj/item/clothing/glasses/regular, VENDOR_ITEM_REGULAR),
		list("M5集成式防毒面具", floor(scale * 5), /obj/item/prop/helmetgarb/helmet_gasmask, VENDOR_ITEM_REGULAR),
		list("M10头盔伪装网", floor(scale * 5), /obj/item/clothing/accessory/helmet/cover/netting, VENDOR_ITEM_REGULAR),
		list("M10头盔防雨罩", floor(scale * 5), /obj/item/clothing/accessory/helmet/cover/raincover, VENDOR_ITEM_REGULAR),
		list("枪械润滑油", floor(scale * 10), /obj/item/prop/helmetgarb/gunoil, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 徽章", floor(scale * 10), /obj/item/prop/helmetgarb/flair_uscm, VENDOR_ITEM_REGULAR),
		list("坠落猎鹰肩章", floor(scale * 10), /obj/item/clothing/accessory/patch/falcon, VENDOR_ITEM_REGULAR),
		list("坠落猎鹰UA肩章", floor(scale * 10), /obj/item/clothing/accessory/patch/falconalt, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）大型胸章", floor(scale * 10), /obj/item/clothing/accessory/patch/uscmlarge, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 肩章", floor(scale * 10), /obj/item/clothing/accessory/patch, VENDOR_ITEM_REGULAR),
		list("联合美洲肩章", floor(scale * 10), /obj/item/clothing/accessory/patch/ua, VENDOR_ITEM_REGULAR),
		list("联合美洲国旗肩章", floor(scale * 10), /obj/item/clothing/accessory/patch/uasquare, VENDOR_ITEM_REGULAR),
		list("铺盖卷", floor(scale * 10), /obj/item/roller/bedroll, VENDOR_ITEM_REGULAR),

		list("光学", -1, null, null, null),
		list("高级医疗光学（仅限医务兵）", floor(scale * 2), /obj/item/device/helmet_visor/medical/advanced, VENDOR_ITEM_REGULAR),
		list("小队光学", floor(scale * 10), /obj/item/device/helmet_visor, VENDOR_ITEM_REGULAR),
		)

//------------WEAPON RACKS---------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/wo
	req_access = list()
	req_one_access = list()
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_LOAD_AMMO_BOXES | VEND_STOCK_DYNAMIC

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/wo/populate_product_list(scale)
	listed_products = list(
		list("主要火器", -1, null, null),
		list("M4RA 战斗步枪", floor(scale * 10), /obj/item/weapon/gun/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("M37A2 泵动式霰弹枪", floor(scale * 15), /obj/item/weapon/gun/shotgun/pump/m37a, VENDOR_ITEM_REGULAR),
		list("M39 冲锋枪", floor(scale * 30), /obj/item/weapon/gun/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A脉冲步枪MK1", floor(scale * 30), /obj/item/weapon/gun/rifle/m41aMK1, VENDOR_ITEM_REGULAR),
		list("M41A脉冲步枪MK2", floor(scale * 30), /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_REGULAR),

		list("主要弹药", -1, null, null),
		list("霰弹枪子弹盒（12号口径）", floor(scale * 10), /obj/item/ammo_magazine/shotgun/buckshot, VENDOR_ITEM_REGULAR),
		list("霰弹枪箭形弹盒（12号口径）", floor(scale * 4), /obj/item/ammo_magazine/shotgun/flechette, VENDOR_ITEM_REGULAR),
		list("霰弹枪独头弹盒（12号口径）", floor(scale * 10), /obj/item/ammo_magazine/shotgun/slugs, VENDOR_ITEM_REGULAR),
		list("M4RA 弹匣（10x24毫米）", floor(scale * 15), /obj/item/ammo_magazine/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("M39 HV 弹匣（10x20毫米）", floor(scale * 25), /obj/item/ammo_magazine/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A MK1 弹匣（10x24毫米）", floor(scale * 25), /obj/item/ammo_magazine/rifle/m41aMK1, VENDOR_ITEM_REGULAR),
		list("M41A MK2 弹匣（10x24毫米）", floor(scale * 25), /obj/item/ammo_magazine/rifle, VENDOR_ITEM_REGULAR),

		list("侧臂", -1, null, null),
		list("88 型 4 战斗手枪", floor(scale * 25), /obj/item/weapon/gun/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44 战斗左轮手枪", floor(scale * 25), /obj/item/weapon/gun/revolver/m44, VENDOR_ITEM_REGULAR),
		list("M4A3 制式手枪", floor(scale * 25), /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),
		list("M82F信号枪", floor(scale * 5), /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("手枪弹药", -1, null, null),
		list("88M4 AP 弹匣（9毫米）", floor(scale * 25), /obj/item/ammo_magazine/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44快速装弹器（.44口径）", floor(scale * 20), /obj/item/ammo_magazine/revolver, VENDOR_ITEM_REGULAR),
		list("M4A3弹匣（9毫米）", floor(scale * 25), /obj/item/ammo_magazine/pistol, VENDOR_ITEM_REGULAR),

		list("附件", -1, null, null),
		list("M39 折叠式枪托", floor(scale * 10), /obj/item/attachable/stock/smg/collapsible, VENDOR_ITEM_REGULAR),
		list("Rail 手电筒", floor(scale * 25), /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
		list("下挂式手电筒握把", floor(scale * 10), /obj/item/attachable/flashlight/grip, VENDOR_ITEM_REGULAR),
		list("下挂式榴弹发射器", floor(scale * 25), /obj/item/attachable/attached_gun/grenade, VENDOR_ITEM_REGULAR), //They already get these as on-spawns, might as well formalize some spares.
		list("下挂式信号弹发射器", floor(scale * 25), /obj/item/attachable/attached_gun/flare_launcher, VENDOR_ITEM_REGULAR),

		list("公用事业", -1, null, null),
		list("M5刺刀", floor(scale * 25), /obj/item/attachable/bayonet, VENDOR_ITEM_REGULAR),
		list("M11 投掷飞刀", floor(scale * 10), /obj/item/weapon/throwing_knife, VENDOR_ITEM_REGULAR),
		list("M94 标记信号弹包", floor(scale * 10), /obj/item/storage/box/m94, VENDOR_ITEM_REGULAR),
		list("塑胶炸药", floor(scale * 2), /obj/item/explosive/plastic, VENDOR_ITEM_REGULAR),
	)

//------------REQ AMMUNITION VENDOR---------------
/obj/structure/machinery/cm_vending/sorted/cargo_ammo/cargo/wo
	req_access = list(ACCESS_MARINE_CARGO)
	req_one_access = list()

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/cargo/wo/populate_product_list(scale)
	..()
	listed_products += list(
		list("额外侦察弹药", -1, null, null, null),
		list("A19高速冲击弹匣（10x24毫米）", floor(scale * 1), /obj/item/ammo_magazine/rifle/m4ra/custom/impact, VENDOR_ITEM_REGULAR),
		list("A19高速燃烧弹匣（10x24毫米）", floor(scale * 1), /obj/item/ammo_magazine/rifle/m4ra/custom/incendiary, VENDOR_ITEM_REGULAR),
		list("A19高速弹匣（10x24毫米）", floor(scale * 1.5), /obj/item/ammo_magazine/rifle/m4ra/custom, VENDOR_ITEM_REGULAR),

		list("额外狙击弹药", -1, null, null, null),
		list("M42A 高射炮弹匣（10x28毫米）", floor(scale * 1), /obj/item/ammo_magazine/sniper/flak, VENDOR_ITEM_REGULAR),
		list("M42A燃烧弹匣（10x28毫米）", floor(scale * 1), /obj/item/ammo_magazine/sniper/incendiary, VENDOR_ITEM_REGULAR),
		list("M42A神射手弹匣（10x28毫米无壳弹）", floor(scale * 1.5), /obj/item/ammo_magazine/sniper, VENDOR_ITEM_REGULAR),
		list("XM43E1 神射手弹匣（10x99毫米无壳弹）", floor(scale * 3), /obj/item/ammo_magazine/sniper/anti_materiel, VENDOR_ITEM_REGULAR),

		list("额外爆破手弹药", -1, null, null, null),
		list("84毫米反装甲火箭弹", floor(scale * 1), /obj/item/ammo_magazine/rocket/ap, VENDOR_ITEM_REGULAR),
		list("84毫米高爆火箭", floor(scale * 1), /obj/item/ammo_magazine/rocket, VENDOR_ITEM_REGULAR),
		list("84毫米白磷火箭弹", floor(scale * 1), /obj/item/ammo_magazine/rocket/wp, VENDOR_ITEM_REGULAR),

		list("超锐利弹药", -1, null, null, null),
		list("SHARP 9X-E 粘性爆炸镖弹匣（飞镖）", round(scale * 1.5), /obj/item/ammo_magazine/rifle/sharp/explosive, null, VENDOR_ITEM_REGULAR),
		list("SHARP 9X-T 粘性燃烧飞镖弹匣（飞镖）", round(scale * 1), /obj/item/ammo_magazine/rifle/sharp/incendiary, null, VENDOR_ITEM_REGULAR),
		list("SHARP 9X-F 飞镖弹匣（飞镖）", round(scale * 1), /obj/item/ammo_magazine/rifle/sharp/flechette, null, VENDOR_ITEM_REGULAR),

		list("额外手榴弹", -1, null, null, null),
		list("M40 HEDP榴弹包（x6）", floor(scale * 1.5), /obj/effect/essentials_set/hedp_6_pack, VENDOR_ITEM_REGULAR),
		list("M40 HIDP 手榴弹包（x6）", floor(scale * 1.5), /obj/effect/essentials_set/hidp_6_pack, VENDOR_ITEM_REGULAR),
		list("M74 AGM-F 手榴弹包（x6）", floor(scale * 1.5), /obj/effect/essentials_set/agmf_6_pack, VENDOR_ITEM_REGULAR),
		list("M74 AGM-I 手榴弹包（x6）", floor(scale * 1.5), /obj/effect/essentials_set/agmi_6_pack, VENDOR_ITEM_REGULAR),

		list("额外火焰喷射器储罐", -1, null, null, null),
		list("大型焚化炉储罐", floor(scale * 1), /obj/item/ammo_magazine/flamer_tank/large, VENDOR_ITEM_REGULAR),
		list("大型焚化炉罐（B型）（绿色火焰）", floor(scale * 1), /obj/item/ammo_magazine/flamer_tank/large/B, VENDOR_ITEM_REGULAR),
		list("大型焚化炉罐（X）（蓝焰）", floor(scale * 1), /obj/item/ammo_magazine/flamer_tank/large/X, VENDOR_ITEM_REGULAR),
		)

//------------ARMAMENTS VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/cargo/wo
	req_access = list(ACCESS_MARINE_CARGO)
	vend_dir = NORTH
	vend_dir_whitelist = list(EAST, WEST)

//---- ATTACHIES
/obj/structure/machinery/cm_vending/sorted/attachments/wo
	req_access = list(ACCESS_MARINE_CARGO)
	vend_dir = NORTH
	vend_dir_whitelist = list(SOUTHWEST, SOUTHEAST)
