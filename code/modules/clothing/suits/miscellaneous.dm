/*
 * Contains:
 * Lasertag
 * Costume
 * Misc
 */

/*
 * Lasertag
 */
/obj/item/clothing/suit/bluetag
	name = "蓝色激光枪战护甲"
	desc = "蓝色荣耀，遍布全站。"
	icon_state = "bluetag"
	item_state = "bluetag"
	blood_overlay_type = "armor"
	flags_armor_protection = BODY_FLAG_CHEST
	allowed = list(
		/obj/item/weapon/gun,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/pen,
	)
	siemens_coefficient = 3

/obj/item/clothing/suit/redtag
	name = "红色激光枪战护甲"
	desc = "据说能跑得更快。"
	icon_state = "redtag"
	item_state = "redtag"
	blood_overlay_type = "armor"
	flags_armor_protection = BODY_FLAG_CHEST
	allowed = list (
		/obj/item/weapon/gun,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/pen,
	)
	siemens_coefficient = 3

/*
 * Costume
 */
/obj/item/clothing/suit/pirate
	name = "海盗大衣"
	desc = "哟嚯。"
	icon_state = "pirate"
	item_state = "pirate"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS


/obj/item/clothing/suit/hgpirate
	name = "海盗船长大衣"
	desc = "哟嚯。"
	icon_state = "hgpirate"
	item_state = "hgpirate"
	flags_inv_hide = HIDEJUMPSUIT
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/judgerobe
	name = "法官长袍"
	desc = "这件长袍象征着权威。"
	icon_state = "judge"
	item_state = "judge"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	allowed = list(
		/obj/item/storage/fancy/cigarettes,
		/obj/item/spacecash,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/pen,
	)
	flags_inv_hide = HIDEJUMPSUIT

/obj/item/clothing/suit/storage/wcoat
	name = "waistcoat"
	desc = "为了些优雅又致命的乐趣。"
	icon_state = "vest"
	item_state = "wcoat"
	icon = 'icons/obj/items/clothing/suits/vests_aprons.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/vests_aprons.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)
	blood_overlay_type = "armor"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/ammo_magazine,
		/obj/item/ammo_casing,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/device/taperecorder,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/pen,
	)

/obj/item/clothing/suit/storage/apron/overalls
	name = "蓝色连体工作服"
	desc = "一条牛仔背带裤。前面有一个大口袋，这种裤子深受各类工人的喜爱。"
	icon_state = "overalls"
	item_state = "overalls"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/ammo_magazine,
		/obj/item/ammo_casing,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/device/taperecorder,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/pen,
	)

/obj/item/clothing/suit/storage/apron/overalls/tan
	name = "棕褐色连体工作服"
	desc = "一条棕褐色背带裤。前面有一个大口袋，这种裤子深受各类工人的喜爱。"
	icon_state = "overalls_tan"
	item_state = "overalls_tan"

/obj/item/clothing/suit/storage/apron/overalls/red
	name = "红色连体工作服"
	desc = "一条红棕色的背带裤。前面有一个大口袋，这种裤子深受各类工人的喜爱。"
	icon_state = "overalls_red"
	item_state = "overalls_red"

/obj/item/clothing/suit/syndicatefake
	name = "红色太空服复制品"
	desc = "一件辛迪加太空服的塑料复制品，穿上它你会看起来像个真正的辛迪加杀手特工！这是个玩具，不能在太空中使用！"
	icon_state = "syndicate"
	item_state = "syndicate"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
	)
	w_class = SIZE_MEDIUM
	allowed = list(
		/obj/item/toy,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/pen,
	)
	flags_inv_hide = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_HANDS|BODY_FLAG_LEGS|BODY_FLAG_FEET

/obj/item/clothing/suit/imperium_monk
	name = "帝国僧侣"
	desc = "你今天杀异形了吗？"
	icon_state = "imperium_monk"
	item_state = "imperium_monk"
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS
	flags_inv_hide = HIDESHOES|HIDEJUMPSUIT


/obj/item/clothing/suit/chickensuit
	name = "小鸡套装"
	desc = "一件由古老帝国KFC在很久以前制作的套装。"
	icon_state = "chickensuit"
	item_state = "chickensuit"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_inv_hide = HIDESHOES|HIDEJUMPSUIT
	siemens_coefficient = 2


/obj/item/clothing/suit/holidaypriest
	name = "节日牧师"
	desc = "这是个愉快的节日，我的孩子。"
	icon_state = "holidaypriest"
	item_state = "holidaypriest"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	flags_inv_hide = HIDEJUMPSUIT
	allowed = list(
		/obj/item/weapon/gun,
	)


/obj/item/clothing/suit/cardborg
	name = "纸板箱套装"
	desc = "一个普通的纸板箱，侧面挖了几个洞。"
	icon_state = "cardborg"
	item_state = "cardborg"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	flags_inv_hide = HIDEJUMPSUIT

/*
 * Misc
 */

/obj/item/clothing/suit/straight_jacket
	name = "约束衣"
	desc = "一件能完全限制穿着者行动的服装。"
	icon_state = "straight_jacket"
	item_state = "straight_jacket"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS
	flags_inv_hide = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAIL

/obj/item/clothing/suit/straight_jacket/equipped(mob/user, slot)
	if(slot == WEAR_JACKET && ishuman(user))
		var/mob/living/carbon/human/H = user
		H.drop_inv_item_on_ground(H.handcuffed)
		H.drop_l_hand()
		H.drop_r_hand()
	..()

/obj/item/clothing/suit/storage/webbing
	name = "外部战术背心"
	desc = "设计用于穿在连体服外，而非夹在衣服上。"
	icon_state = "webbing"
	item_state = "webbing"
	allowed = list(
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,

		/obj/item/storage/belt/gun/m10,
		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
		/obj/item/storage/belt/gun/mateba,
		/obj/item/storage/belt/gun/smartpistol,
		/obj/item/storage/belt/gun/type47,
		/obj/item/weapon/gun,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tool/crowbar,
		/obj/item/tool/crew_monitor,
		/obj/item/tool/pen,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/large_holster/katana,
		/obj/item/device/motiondetector,
	)

/obj/item/clothing/suit/storage/webbing/black
	icon_state = "webbing_black"
	item_state = "webbing_black"

/obj/item/clothing/suit/storage/webbing/brown
	icon_state = "webbing_brown"
	item_state = "webbing_brown"

/obj/item/clothing/suit/storage/utility_vest
	name = "工具背心"
	desc = "一件用于存放工具的工具背心。"
	icon_state = "synth_utility_vest"
	item_state = "synth_utility_vest"
	icon = 'icons/obj/items/clothing/suits/vests_aprons.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/vests_aprons.dmi'
	)
	allowed = list(
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
		/obj/item/tool/crowbar,
		/obj/item/tool/crew_monitor,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/large_holster/katana,
		/obj/item/device/motiondetector,
	)

//Blue suit jacket toggle
/obj/item/clothing/suit/suit/verb/toggle()
	set name = "Toggle Jacket Buttons"
	set category = "Object"
	set src in usr

	if(usr.is_mob_incapacitated())
		return 0

	if(src.icon_state == "suitjacket_blue_open")
		src.icon_state = "suitjacket_blue"
		src.item_state = "suitjacket_blue"
		to_chat(usr, "你扣上了西装外套的扣子。")
	else if(src.icon_state == "suitjacket_blue")
		src.icon_state = "suitjacket_blue_open"
		src.item_state = "suitjacket_blue_open"
		to_chat(usr, "你解开了西装外套的扣子。")
	else
		to_chat(usr, "你在你的[src]上扣上了一些想象中的扣子。")
		return
	update_clothing_icon()

//pyjamas
//originally intended to be pinstripes >.>

/obj/item/clothing/under/bluepyjamas
	name = "蓝色睡衣"
	desc = "略显老式的睡衣。"
	icon_state = "blue_pyjamas"
	item_state = "blue_pyjamas"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS

/obj/item/clothing/under/redpyjamas
	name = "红色睡衣"
	desc = "略显老式的睡衣。"
	icon_state = "red_pyjamas"
	item_state = "red_pyjamas"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS

/obj/item/clothing/suit/xenos
	name = "异形戏服"
	desc = "由廉价布料制成的戏服。"
	icon_state = "xenos"
	item_state = "xenos_suit"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS
	flags_inv_hide = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	siemens_coefficient = 2

//swimsuit

/obj/item/clothing/under/swimsuit
	siemens_coefficient = 1
	flags_armor_protection = 0
	icon = 'icons/obj/items/clothing/uniforms/underwear_uniforms.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/underwear_uniforms.dmi',
	)

/obj/item/clothing/under/swimsuit/black
	name = "黑色泳衣"
	desc = "一件老式的黑色泳衣。"
	icon_state = "swim_black"
	siemens_coefficient = 1

/obj/item/clothing/under/swimsuit/blue
	name = "蓝色泳衣"
	desc = "一件老式的蓝色泳衣。"
	icon_state = "swim_blue"
	siemens_coefficient = 1

/obj/item/clothing/under/swimsuit/purple
	name = "紫色泳衣"
	desc = "一件老式的紫色泳衣。"
	icon_state = "swim_purp"
	siemens_coefficient = 1

/obj/item/clothing/under/swimsuit/green
	name = "绿色泳衣"
	desc = "一件老式的绿色泳衣。"
	icon_state = "swim_green"
	siemens_coefficient = 1

/obj/item/clothing/under/swimsuit/red
	name = "红色泳衣"
	desc = "一件老式的红色泳衣。"
	icon_state = "swim_red"
	siemens_coefficient = 1

/obj/item/clothing/suit/poncho
	name = "poncho"
	desc = "一件简单舒适的斗篷。"
	icon_state = "classicponcho"

/obj/item/clothing/suit/poncho/green
	name = "绿色斗篷"
	desc = "你经典、非种族主义的斗篷。这件是绿色的。"
	icon_state = "greenponcho"

/obj/item/clothing/suit/poncho/red
	name = "红色斗篷"
	desc = "经典的、非种族主义的斗篷。这件是红色的。"
	icon_state = "redponcho"

/obj/item/clothing/suit/storage/bomber
	name = "棕色轰炸机夹克"
	desc = "一件磨损的皮制轰炸机夹克。"
	icon_state = "bomber"
	icon = 'icons/obj/items/clothing/suits/jackets.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/jackets.dmi'
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

/obj/item/clothing/suit/storage/bomber/alt
	name = "黑色轰炸机夹克"
	icon_state = "bomber_2"

/obj/item/clothing/suit/storage/manager
	name = "经理夹克"
	desc = "属于某位重要人物的西装。由绝缘材料制成，能提供对所有形式伤害的轻微防护。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/WY.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/WY.dmi'
	)
	item_state = "manager_suit"
	icon_state = "manager_suit"

	allowed = list(
		/obj/item/weapon/gun/pistol,
		/obj/item/device/flashlight,
	)

	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_GROIN
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_GROIN

	min_cold_protection_temperature = ICE_COLONY_TEMPERATURE

	storage_slots = 1

	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/storage/director
	name = "主管夹克"
	desc = "属于某位非常重要人物的夹克。由绝缘材料制成，能提供对所有形式伤害的轻微防护。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/WY.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/WY.dmi'
	)
	item_state = "director_suit"
	icon_state = "director_suit"

	allowed = list(
		/obj/item/weapon/gun/pistol,
		/obj/item/device/flashlight,
	)

	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_GROIN
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_GROIN

	min_cold_protection_temperature = ICE_COLONY_TEMPERATURE
	siemens_coefficient = 0

	storage_slots = 3

	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_HARDCORE // Immune to tasers
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_LOW
