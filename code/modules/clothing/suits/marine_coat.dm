/obj/item/clothing/suit/storage/jacket/marine //BASE ITEM
	name = "陆战队夹克"
	//This really should not be spawned
	desc = "这玩意儿怎么会在这儿？"
	icon = 'icons/obj/items/clothing/suits/suits_by_map/jungle.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_map/jungle.dmi'
	)
	sprite_sheets = list(SPECIES_MONKEY = 'icons/mob/humans/species/monkeys/onmob/suit_monkey_1.dmi')
	blood_overlay_type = "coat"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_ARMS
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_NONE
	allowed = list(
		/obj/item/weapon/gun/,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,
		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
		/obj/item/storage/belt/gun/mateba,
		/obj/item/storage/belt/gun/smartpistol,
		/obj/item/storage/backpack/general_belt,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/pen,
		/obj/item/storage/large_holster/machete,
	)

	//Buttons
	var/has_buttons = FALSE
	var/buttoned = TRUE
	var/initial_icon_state

/obj/item/clothing/suit/storage/jacket/marine/proc/toggle()
	set name = "Toggle Buttons"
	set category = "Object"
	set src in usr

	if(usr.is_mob_incapacitated())
		return 0

	if(src.buttoned == TRUE)
		src.icon_state = "[initial_icon_state]_o"
		src.buttoned = FALSE
		to_chat(usr, SPAN_INFO("你解开了\the [src]的纽扣。"))
	else
		src.icon_state = "[initial_icon_state]"
		src.buttoned = TRUE
		to_chat(usr, SPAN_INFO("你扣上了\the [src]的纽扣。"))
	update_clothing_icon()

/obj/item/clothing/suit/storage/jacket/marine/Initialize()
	. = ..()
	if(!(flags_atom & NO_GAMEMODE_SKIN))
		select_gamemode_skin(type)
		initial_icon_state = icon_state
	if(has_buttons)
		verbs += /obj/item/clothing/suit/storage/jacket/marine/proc/toggle

/obj/item/clothing/suit/storage/jacket/marine/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'icons/obj/items/clothing/suits/suits_by_map/jungle.dmi'
			item_icons[WEAR_JACKET] = 'icons/mob/humans/onmob/clothing/suits/suits_by_map/jungle.dmi'
		if("classic")
			icon = 'icons/obj/items/clothing/suits/suits_by_map/classic.dmi'
			item_icons[WEAR_JACKET] = 'icons/mob/humans/onmob/clothing/suits/suits_by_map/classic.dmi'
		if("desert")
			icon = 'icons/obj/items/clothing/suits/suits_by_map/desert.dmi'
			item_icons[WEAR_JACKET] = 'icons/mob/humans/onmob/clothing/suits/suits_by_map/desert.dmi'
		if("snow")
			icon = 'icons/obj/items/clothing/suits/suits_by_map/snow.dmi'
			item_icons[WEAR_JACKET] = 'icons/mob/humans/onmob/clothing/suits/suits_by_map/snow.dmi'
		if("urban")
			icon = 'icons/obj/items/clothing/suits/suits_by_map/urban.dmi'
			item_icons[WEAR_JACKET] = 'icons/mob/humans/onmob/clothing/suits/suits_by_map/urban.dmi'

//Marine service & tanker jacket + MP themed variants
/obj/item/clothing/suit/storage/jacket/marine/service
	name = "陆战队常服夹克"
	desc = "美国殖民地海军陆战队军官通常穿着的常服夹克。它含有轻型凯夫拉碎片，有助于防护刺击武器和子弹。"
	has_buttons = TRUE
	icon_state = "coat_officer"

/obj/item/clothing/suit/storage/jacket/marine/pilot/armor
	name = "\improper M70 flak jacket"
	desc = "运输机飞行员在驾驶舱飞行时用于保护自己的防弹背心。擅长保护穿戴者免受高速实体弹丸的伤害。"
	icon_state = "pilot"
	has_buttons = TRUE
	initial_icon_state = "pilot"
	blood_overlay_type = "armor"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	flags_bodypart_hidden = BODY_FLAG_CHEST
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	slowdown = SLOWDOWN_ARMOR_LIGHT
	allowed = list(
		/obj/item/weapon/gun/,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/ammo_magazine/,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/explosive/grenade,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
	)
	uniform_restricted = list(/obj/item/clothing/under/marine/officer/pilot)
	sprite_sheets = list(SPECIES_MONKEY = 'icons/mob/humans/species/monkeys/onmob/suit_monkey_1.dmi')

/obj/item/clothing/suit/storage/jacket/marine/pilot
	name = "\improper M70B1 light flak jacket"
	desc = "运输机飞行员在驾驶舱飞行时用于保护自己的轻型防弹背心。这款特定的防弹背心在设计上更注重风格和舒适度而非防护，这一点显而易见。别被任何流弹击中！"
	icon_state = "pilot_alt"
	has_buttons = TRUE
	initial_icon_state = "pilot_alt"

/obj/item/clothing/suit/storage/jacket/marine/RO
	name = "军需官夹克"
	desc = "美国殖民地海军陆战队人员穿着的绿色夹克。背面印有美利坚合众国的旗帜。"
	icon_state = "RO_jacket"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UA.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UA.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/suit/storage/jacket/marine/service/mp
	name = "宪兵常服夹克"
	desc = "美国殖民地海军陆战队舰上宪兵人员采用的陆战队常服夹克。讽刺的是，大多数舰船要求其宪兵部门穿戴全套护甲，使得执勤宪兵几乎用不上这些。普通陆战队员也可获得此款式，如果他们愿意承受这份耻辱的话。"
	has_buttons = TRUE
	icon_state = "coat_mp"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UA.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UA.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN
	initial_icon_state = "coat_mp"

/obj/item/clothing/suit/storage/jacket/marine/service/warden
	name = "军事典狱长常服夹克"
	desc = "美国殖民地海军陆战队舰上军事典狱长采用的陆战队常服夹克。讽刺的是，大多数舰船要求其宪兵部门穿戴全套护甲，使得执勤典狱长几乎用不上这些。这是通宵盯着一堆监视器时的首选夹克，任由烟蒂在你周围堆积。"
	has_buttons = TRUE
	icon_state = "coat_warden"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UA.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UA.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN
	initial_icon_state = "coat_warden"

/obj/item/clothing/suit/storage/jacket/marine/service/cmp
	name = "宪兵长常服夹克"
	desc = "美国殖民地海军陆战队舰上宪兵人员采用的陆战队常服夹克。讽刺的是，大多数舰船要求其宪兵部门穿戴全套护甲，使得执勤宪兵几乎用不上这些。在那些莫名想闻起来像甜甜圈的人中非常受欢迎。"
	has_buttons = TRUE
	icon_state = "coat_cmp"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UA.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UA.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN
	initial_icon_state = "coat_cmp"

/obj/item/clothing/suit/storage/jacket/marine/service/tanker
	name = "坦克兵夹克"
	desc = "为需要在重型机械附近或内部操作的人员提供的舒适夹克。其袖子的特殊材料能在被卷入机械时卡住机器，保护穿着者免受伤害。"
	has_buttons = TRUE
	flags_atom = NO_GAMEMODE_SKIN
	icon_state = "jacket_tanker"
	icon = 'icons/obj/items/clothing/suits/jackets.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/jackets.dmi'
	)
	initial_icon_state = "jacket_tanker"

/obj/item/clothing/suit/storage/jacket/marine/chef
	name = "食堂技术员夹克"
	desc = "闻起来有香草味。象征着声望与权力，虽然有点花哨。"
	icon_state = "chef_jacket"
	icon = 'icons/obj/items/clothing/suits/jackets.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/jackets.dmi'
	)
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/suit/storage/jacket/marine/dress
	name = "陆战队员正式勤务夹克"
	desc = "闻起来有香草味。象征着声望与权力，虽然有点花哨。"
	icon_state = "coat_formal"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UA.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UA.dmi'
	)
	initial_icon_state = "coat_formal"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_atom = NO_GAMEMODE_SKIN
	has_buttons = TRUE

/obj/item/clothing/suit/storage/jacket/marine/dress/officer
	name = "陆战队军官礼服夹克"
	desc = "美国殖民地海军陆战队指挥官穿着的礼服夹克。"
	icon_state = "co_jacket"
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/dress/officer/bomber
	name = "指挥官轰炸机夹克"
	desc = "一款仿照旧时飞行员夹克的轰炸机夹克。是高级军官经典而时尚的选择。"
	has_buttons = TRUE
	icon_state = "co_bomber"
	initial_icon_state = "co_bomber"

/obj/item/clothing/suit/storage/jacket/marine/dress/officer/white
	name = "指挥官白色礼服夹克"
	desc = "用于炎热天气阅兵的白色礼服上衣。明亮、无污渍、一尘不染，并带有金色点缀。"
	icon_state = "co_formal_white"

/obj/item/clothing/suit/storage/jacket/marine/dress/officer/black
	name = "指挥官灰色礼服夹克"
	desc = "用于要求颜色更深沉、更内敛场合的灰色礼服上衣。结合了流畅、内敛的风格与金色点缀。"
	icon_state = "co_formal_black"

/obj/item/clothing/suit/storage/jacket/marine/dress/officer/suit
	name = "指挥官礼服蓝色大衣"
	desc = "高级军官穿着的海军制式礼服蓝色大衣。适合那些追求风格与权威的人。"
	icon_state = "co_suit"

/obj/item/clothing/suit/storage/jacket/marine/dress/officer/patchless
	name = "指挥官夹克"
	desc = "军官夹克的无徽章版本，其存在感依然强势。"
	icon_state = "co_plain"

/obj/item/clothing/suit/storage/jacket/marine/dress/officer/commander

	name = "指挥官夹克"
	desc = "光是想到看一眼那军衔徽章，就让你害怕会被送上军事法庭。"
	icon_state = "co_falcon"

/obj/item/clothing/suit/storage/jacket/marine/dress/officer/falcon
	name = "指挥官猎鹰夹克"
	desc = "为高级军官量身定制的翻新夹克衬里。这款衬里已成为一件更正式的服装，增加了新的面料层、袖口、前口袋，以及背部定制的猎鹰刺绣。无论情况如何，从凉爽的周日驾车到寒冷的秋夜，这件夹克都能让穿着者保持温暖。"
	icon_state = "co_falcon"

/obj/item/clothing/suit/storage/jacket/marine/dress/general
	name = "USCM A类军官勤务夹克"
	desc = "一款USCM军官A类勤务夹克，通常由军官在正式访问时穿着。剪裁合身、熨烫平整，非常适合需要出色完成的工作。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UA.dmi'
	icon_state = "general_jacket"
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UA.dmi'
	)
	item_state = "general_jacket"
	has_buttons = FALSE
	storage_slots = 4
	w_class = SIZE_MEDIUM

/obj/item/clothing/suit/storage/jacket/marine/dress/general/executive
	name = "主管夹克"
	desc = "一件带有金色金属镶边的黑色风衣。华丽、高度防护且夸张。适合国王——或者，在这种情况下，适合主管。有很多口袋。"
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/dress/bridge_coat
	name = "舰桥大衣"
	desc = "配发给USCM军官的厚重合成羊毛大衣。基于经典设计，无论是在作战指挥中心的空调房里度过寒夜，还是在荒芜星球上忍受凄冷的夜晚，这件大衣都非常合适。这款是适合指挥官的深蓝色礼服款。"
	has_buttons = FALSE
	item_state = "bridge_coat"
	icon_state = "bridge_coat"

/obj/item/clothing/suit/storage/jacket/marine/dress/bridge_coat_grey
	name = "舰桥大衣"
	desc = "配发给USCM军官的厚重合成羊毛大衣。基于经典设计，无论是在作战指挥中心的空调房里度过寒夜，还是在荒芜星球上忍受凄冷的夜晚，这件大衣都非常合适。这款是黑色。"
	has_buttons = FALSE
	item_state = "bridge_coat_grey"
	icon_state = "bridge_coat_grey"

/obj/item/clothing/suit/storage/jacket/marine/service/aso
	name = "辅助支援军官夹克"
	desc = "为需要长时间工作、盯着成排数字、检查从刀具到鱼雷乃至整艘运输机装备的军官准备的舒适背心。"
	icon_state = "aso_jacket"
	blood_overlay_type = "coat"
	flags_armor_protection = BODY_FLAG_CHEST
	has_buttons = FALSE


//=========================//PROVOST\\================================\\
//=======================================================================\\

/obj/item/clothing/suit/storage/jacket/marine/provost
	name = "\improper USCM service 'A' officer winter service jacket"
	desc = "一种罕见的USCM军官'A'型常服夹克，专为在冰雪战场保持干爽温暖而设计，这款为黑色。"
	icon_state = "provost_jacket"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UA.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UA.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

//=========================//DRESS BLUES\\================================\\
//=======================================================================\\

/obj/item/clothing/suit/storage/jacket/marine/dress/blues
	name = "陆战队员列兵礼服蓝夹克"
	desc = "传奇的陆战队礼服蓝夹克，自19世纪以来几乎未曾改变。你正穿着历史，陆战队员。别让你的先辈们失望。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UA.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UA.dmi'
	)
	icon_state = "e_jacket"
	item_state = "e_jacket"
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/dress/blues/nco
	name = "陆战队士官礼服蓝夹克"
	desc = "传奇的陆战队礼服蓝夹克，自19世纪以来几乎未曾改变。带有受勋士官的装饰。这是传统的体现。"
	icon_state = "nco_jacket"
	item_state = "nco_jacket"

/obj/item/clothing/suit/storage/jacket/marine/dress/blues/officer
	name = "陆战队军官礼服蓝夹克"
	desc = "传奇的陆战队礼服蓝夹克，自19世纪以来几乎未曾改变。采用军官制服流畅的深色设计。"
	icon_state = "o_jacket"
	item_state = "o_jacket"

//==================Combat Correspondent==================\\

/obj/item/clothing/suit/storage/jacket/marine/reporter
	name = "战地记者夹克"
	desc = "为最时尚的战地记者准备的夹克。"
	icon_state = "cc_brown"
	item_state = "cc_brown"
	icon = 'icons/obj/items/clothing/suits/jackets.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/jackets.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/reporter/green
	icon_state = "cc_green"
	item_state = "cc_green"


/obj/item/clothing/suit/storage/jacket/marine/reporter/black
	icon_state = "cc_black"
	item_state = "cc_black"

/obj/item/clothing/suit/storage/jacket/marine/reporter/blue
	icon_state = "cc_blue"
	item_state = "cc_blue"
	icon = 'icons/obj/items/clothing/suits/vests_aprons.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/vests_aprons.dmi'
	)

/obj/item/clothing/suit/storage/jacket/marine/correspondent
	name = "绿色夹克"
	desc = "一件绿色夹克。"
	icon_state = "correspondent_green"
	item_state = "correspondent_green"
	icon = 'icons/obj/items/clothing/suits/jackets.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/jackets.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/correspondent/blue
	name = "蓝色夹克"
	desc = "一件蓝色夹克。"
	icon_state = "correspondent_blue"
	item_state = "correspondent_blue"
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/correspondent/tan
	name = "棕褐色夹克"
	desc = "一件棕褐色夹克。"
	icon_state = "correspondent_tan"
	item_state = "correspondent_tan"
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/correspondent/brown
	name = "棕色夹克"
	desc = "一件棕色夹克。"
	icon_state = "correspondent_brown"
	item_state = "correspondent_brown"
	has_buttons = FALSE

//==================Corporate Liaison==================\\

/obj/item/clothing/suit/storage/jacket/marine/vest
	name = "棕色背心"
	desc = "一件休闲棕色背心。"
	icon_state = "vest_brown"
	item_state = "vest_brown"
	icon = 'icons/obj/items/clothing/suits/vests_aprons.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/vests_aprons.dmi'
	)
	flags_bodypart_hidden = BODY_FLAG_CHEST
	flags_atom = NO_GAMEMODE_SKIN
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/vest/tan
	name = "棕褐色背心"
	desc = "一件休闲棕褐色背心。"
	icon_state = "vest_tan"
	item_state = "vest_tan"
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/vest/grey
	name = "灰色背心"
	desc = "一件休闲的灰色背心。"
	icon_state = "vest_grey"
	item_state = "vest_grey"
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/corporate
	name = "卡其色西装外套"
	desc = "一件卡其色西装外套。"
	icon_state = "corporate_ivy"
	item_state = "corporate_ivy"
	icon = 'icons/obj/items/clothing/suits/jackets.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/jackets.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/corporate/formal
	name = "正式西装外套"
	desc = "一件象牙色西装外套；右翻领上别着一枚维兰德-汤谷公司的徽章。"
	icon_state = "corporate_formal"
	item_state = "corporate_formal"
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/corporate/black
	name = "黑色西装外套"
	desc = "一件黑色西装外套。"
	icon_state = "corporate_black"
	item_state = "corporate_black"
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/corporate/brown
	name = "棕色西装外套"
	desc = "一件棕色西装外套。"
	icon_state = "corporate_brown"
	item_state = "corporate_brown"
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/corporate/blue
	name = "蓝色西装外套"
	desc = "一件蓝色西装外套。"
	icon_state = "corporate_blue"
	item_state = "corporate_blue"
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/bomber
	name = "卡其色轰炸机夹克"
	desc = "一件在各地空间站工作人员和蓝领工人中流行的卡其色轰炸机夹克。"
	icon_state = "jacket_khaki"
	item_state = "jacket_khaki"
	icon = 'icons/obj/items/clothing/suits/jackets.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/jackets.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/bomber/red
	name = "红色轰炸机夹克"
	desc = "一件在各地空间站工作人员和蓝领工人中流行的红褐色轰炸机夹克。"
	icon_state = "jacket_red"
	item_state = "jacket_red"
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/bomber/grey
	name = "灰色轰炸机夹克"
	desc = "一件在各地空间站工作人员和蓝领工人中流行的蓝灰色轰炸机夹克。"
	icon_state = "jacket_grey"
	item_state = "jacket_grey"
	has_buttons = FALSE

// TWE - RMC - Royal Marine Commandos

/obj/item/clothing/suit/storage/jacket/marine/rmc/service
	name = "\improper Royal Marine Commando service jacket"
	desc = "一件通常由RMC军官穿着的常服夹克。它嵌有轻型凯夫拉碎片，有助于防御刺击武器和子弹。"
	icon_state = "rmc_service"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/TWE.dmi'
	)
	has_buttons = FALSE
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/co
	name = "\improper Royal Marine Commando senior officer's service jacket"
	desc = "一件由RMC高级军官穿着的常服夹克。它嵌有轻型凯夫拉碎片，有助于防御刺击武器和子弹。"
	icon_state = "rmc_service_co"

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/black
	name = "\improper Royal Marine Commando service jacket"
	desc = "一件通常由RMC军官穿着的常服夹克。它嵌有轻型凯夫拉碎片，有助于防御刺击武器和子弹。"
	icon_state = "rmc_service_black"

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/co/black
	name = "\improper Royal Marine Commando senior officer's service jacket"
	desc = "一件由RMC高级军官穿着的常服夹克。它嵌有轻型凯夫拉碎片，有助于防御刺击武器和子弹。"
	icon_state = "rmc_service_black_co"

/obj/item/clothing/suit/storage/jacket/marine/dress/officer/bomber/rmc
	name = "指挥官轰炸机夹克"
	desc = "一件RMC军官穿着的轰炸机夹克。对于高级军官来说，这是一个经典、时尚的选择。"
	has_buttons = TRUE
	icon_state = "rmc_bomber"
	initial_icon_state = "rmc_bomber"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/TWE.dmi'
	)

// TWE - IASF - Imperial Armed Space Force

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/iasf_co
	name = "\improper IASF Commanding Officer’s service jacket"
	desc = "一件通常由IASF指挥官穿着的常服夹克。采用轻型凯夫拉碎片加固，对刺击武器和小型枪械火力提供有限防护，同时保持了为战场空中指挥设计的正式而实用的风格。"
	icon_state = "iasf_service_co"
	has_buttons = FALSE

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/iasf_co/alt
	icon_state = "iasf_service_co_alt"

/obj/item/clothing/suit/storage/jacket/marine/rmc/service/iasf_combat_jacket
	name = "\improper IASF combat jacket"
	desc = "一件发给帝国武装太空军的坚固全天候战斗夹克。设计用途多样，既可作为野战服，也可作为轻量防护层。采用防弹纤维加固并经过防风雨处理，对弹片和小型枪械火力提供有限防御，同时让空降兵在恶劣条件下保持舒适。其深绿色调和耐用面料使其成为现役部署和休班穿着的必备品。"
	has_buttons = TRUE
	icon_state = "iasf_jacket"
	initial_icon_state = "iasf_jacket"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/TWE.dmi'
	)

	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS

	allowed = list (
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,

		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
		/obj/item/storage/belt/gun/mateba,
		/obj/item/storage/belt/gun/smartpistol,
		/obj/item/weapon/gun,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/crew_monitor,
		/obj/item/tool/pen,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/large_holster/katana,
		/obj/item/device/motiondetector,
	)
	min_cold_protection_temperature = T0C
	siemens_coefficient = 0.7
	valid_accessory_slots = list(ACCESSORY_SLOT_ARMBAND, ACCESSORY_SLOT_DECOR, ACCESSORY_SLOT_MEDAL)
