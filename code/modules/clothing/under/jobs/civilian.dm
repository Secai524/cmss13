//Alphabetical order of civilian jobs.

/obj/item/clothing/under/rank
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE

/obj/item/clothing/under/rank/bartender
	desc = "看起来它还需要一些点缀。"
	name = "酒保制服"
	icon_state = "ba_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/service.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/service.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/cargo
	name = "军需官连体服"
	desc = "这是军需官穿着的连体服。其专门设计用于防止因处理文件导致的背部损伤。"
	icon_state = "qm"
	item_state = "lb_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/cargo.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/cargo.dmi',
	)
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/cargotech
	name = "货舱技术员连体服"
	desc = "短裤！它们舒适又易穿！"
	icon_state = "cargotech"
	item_state = "lb_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/cargo.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/cargo.dmi',
	)
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS

/obj/item/clothing/under/rank/chaplain
	desc = "这是一件黑色的连体服，通常为宗教人士所穿着。"
	name = "牧师连体服"
	icon_state = "chaplain"
	item_state = "chaplain"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/service.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/service.dmi',
	)
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/chaplain/cultist
	name = "邪教徒连体服"

/obj/item/clothing/suit/priest_robe
	name = "牧师袍"
	desc = "一条配有紫色围巾的长裙，通常为宗教人士所穿着。"
	icon_state = "priest_robe"
	item_state = "priest_robe"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)

/obj/item/clothing/under/rank/worker_overalls
	name = "工人工作服"
	desc = "一套适合勤劳工作者的装束。"
	icon_state = "worker_overalls"
	item_state = "bl_suit"
	icon = 'icons/obj/items/clothing/uniforms/workwear.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/workwear.dmi',
	)
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/chef
	desc = "这是一件只授予太空中最<b>硬核</b>厨师的围裙。"
	name = "厨师制服"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/service.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/service.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)
	icon_state = "chef"

/obj/item/clothing/under/rank/clown
	name = "小丑服"
	desc = "<i>'HONK!'</i>"
	icon_state = "clown"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/service.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/service.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)
	flags_jumpsuit = FALSE
	black_market_value = 25

/obj/item/clothing/under/rank/hydroponics
	desc = "这是一件设计用于防护轻微植物相关危害的连体服。"
	name = "植物学家连体服"
	icon_state = "hydroponics"
	item_state = "g_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/service.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/service.dmi',
	)

/obj/item/clothing/under/rank/janitor
	desc = "这是空间站清洁工的正式制服。它对生物危害有轻微的防护作用。"
	name = "清洁工连体服"
	icon_state = "janitor"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/service.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/service.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/lawyer
	desc = "时髦的装束。"
	name = "律师西装"
	icon = 'icons/obj/items/clothing/uniforms/formal_uniforms.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/formal_uniforms.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)
	flags_jumpsuit = FALSE

/obj/item/clothing/under/lawyer/black
	name = "黑色律师西装"
	icon_state = "lawyer_black"

/obj/item/clothing/under/lawyer/female
	name = "黑色律师西装"
	icon_state = "black_suit_fem"

/obj/item/clothing/under/lawyer/red
	name = "红色律师西装"
	icon_state = "lawyer_red"

/obj/item/clothing/under/lawyer/blue
	name = "蓝色律师西装"
	icon_state = "lawyer_blue"

/obj/item/clothing/under/lawyer/bluesuit
	name = "蓝色西装"
	desc = "一套经典的西装领带。"
	icon_state = "bluesuit"

/obj/item/clothing/under/lawyer/purpsuit
	name = "紫色西装"
	icon_state = "lawyer_purp"

/obj/item/clothing/under/lawyer/oldman
	name = "老式西装"
	desc = "为年长绅士设计的经典西装，内置背部支撑。"
	icon_state = "oldman"

/obj/item/clothing/under/librarian
	name = "实用西装"
	desc = "它非常……实用。"
	icon_state = "red_suit"
	icon = 'icons/obj/items/clothing/uniforms/formal_uniforms.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/formal_uniforms.dmi',
	)
	flags_jumpsuit = FALSE

/obj/item/clothing/under/lawyer/comedian
	name = "彩色西装"
	desc = "一套花哨的服装，兼具表演性和威胁感。色彩极其鲜艳，给人留下难以磨灭的印象。"
	icon_state = "comedian"
