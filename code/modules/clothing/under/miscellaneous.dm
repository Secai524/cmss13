/obj/item/clothing/under/pj/red
	name = "红色睡衣"
	desc = "睡衣。"
	icon_state = "red_pyjamas"
	item_state = "w_suit"

/obj/item/clothing/under/pj/blue
	name = "蓝色睡衣"
	desc = "睡衣。"
	icon_state = "blue_pyjamas"
	item_state = "w_suit"

/obj/item/clothing/under/sl_suit
	desc = "这是一件看起来非常简单的白衬衫和黑裤子。"
	name = "白衬衫制服"
	icon_state = "sl_suit"
	icon = 'icons/obj/items/clothing/uniforms/formal_uniforms.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/formal_uniforms.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)

/obj/item/clothing/under/waiter
	name = "侍者服装"
	desc = "这是一套非常得体的制服，有一个专门放小费的口袋。"
	icon_state = "waiter"
	icon = 'icons/obj/items/clothing/uniforms/formal_uniforms.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/formal_uniforms.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)

/obj/item/clothing/under/rank/centcom_officer
	desc = "这是中央司令部军官穿的连体服。"
	name = "\improper CentCom officer's jumpsuit"
	icon_state = "officer"
	item_state = "g_suit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/suit_jacket
	name = "黑色西装"
	desc = "一套黑色西装和红色领带。非常正式。"
	icon_state = "black_suit"
	item_state = "bl_suit"
	icon = 'icons/obj/items/clothing/uniforms/formal_uniforms.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/formal_uniforms.dmi',
	)

/obj/item/clothing/under/suit_jacket/really_black
	name = "行政西装"
	desc = "一套正式的黑色西装和红色领带，专为空间站的精英准备。"
	icon_state = "really_black_suit"
	item_state = "bl_suit"

/obj/item/clothing/under/suit_jacket/female
	name = "行政西装"
	desc = "一套正式的女士裤装，专为空间站的精英准备。"
	icon_state = "black_suit_fem"

/obj/item/clothing/under/suit_jacket/red
	name = "红色西装"
	desc = "一套红色西装和蓝色领带。还算正式。"
	icon_state = "red_suit"
	item_state = "r_suit"

/obj/item/clothing/under/blackskirt
	name = "红色裙装"
	desc = "一件黑色开衫配红色短裙，相当别致！"
	icon_state = "blackskirt"
	icon = 'icons/obj/items/clothing/uniforms/formal_uniforms.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/formal_uniforms.dmi',
	)
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS

/obj/item/clothing/under/schoolgirl
	name = "女学生制服"
	desc = "这就像我喜欢的日本动漫里的那样！"
	icon_state = "schoolgirl"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN

/obj/item/clothing/under/overalls
	name = "劳工连体服"
	desc = "一套耐用的连体服，用于完成工作。"
	icon_state = "overalls"
	item_state = "lb_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/engineering.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/engineering.dmi',
	)

/obj/item/clothing/under/pirate
	name = "海盗装束"
	desc = "哟嚯。"
	icon_state = "pirate"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS

/obj/item/clothing/under/kutjevo
	name = "库特耶沃连体工作服"
	desc = "库特耶沃工人们穿着的重型连体工作服。"
	icon_state = "kutjevo_jumper"
	item_state = "kutjevo_jumper"

/obj/item/clothing/under/kutjevo/drysuit
	name = "库特耶沃干式潜水服"
	desc = "库特耶沃工人们穿着的重型干式潜水服。"
	icon_state = "kutjevo_drysuit"
	item_state = "kutjevo_drysuit"

/obj/item/clothing/under/rank/veteran/soviet_uniform_01
	name = "苏式军服"
	desc = "采用如此坚固统一的布料制成，足以让资本主义裁缝嫉妒。"
	icon_state = "soviet_uniform_01"
	item_state = "soviet_uniform_01_d"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE

/obj/item/clothing/under/rank/miner
	desc = "这是一套时髦的连体服，配有结实的工装裤。非常脏。"
	name = "矿工连体服"
	icon_state = "miner"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/cargo.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/cargo.dmi',
	)

/obj/item/clothing/under/redcoat
	name = "红衫军制服"
	desc = "看起来很旧。"
	icon_state = "redcoat"

/obj/item/clothing/under/wedding
	name = "丝质婚纱"
	desc = "一件用最上等丝绸制成的白色婚纱。"
	icon_state = "bride_white"
	flags_inv_hide = HIDESHOES
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN

/obj/item/clothing/under/assistantformal
	name = "助理正装"
	desc = "助理的正装。为何助理需要正装仍是个谜。"
	icon_state = "assistant_formal"
	item_state = "gy_suit"
	icon = 'icons/obj/items/clothing/uniforms/formal_uniforms.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/formal_uniforms.dmi',
	)

/obj/item/clothing/under/suit_jacket/charcoal
	name = "炭灰色西装"
	desc = "一套炭灰色西装和红色领带。非常专业。"
	icon_state = "charcoal_suit"

/obj/item/clothing/under/suit_jacket/navy
	name = "海军蓝西装"
	desc = "一套海军蓝西装和红色领带，专为空间站精英准备。"
	icon_state = "navy_suit"

/obj/item/clothing/under/suit_jacket/burgundy
	name = "酒红色西装"
	desc = "一套酒红色西装和黑色领带。略显正式。"
	icon_state = "burgundy_suit"

/obj/item/clothing/under/suit_jacket/checkered
	name = "格纹西装"
	desc = "你这套西装真不错。要是出点什么事就太可惜了，嗯？"
	icon_state = "checkered_suit"

/obj/item/clothing/under/suit_jacket/tan
	name = "棕褐色西装"
	desc = "一套带黄色领带的棕褐色西装。时髦，但休闲。"
	icon_state = "tan_suit"

/obj/item/clothing/under/suit_jacket/stowaway
	name = "脏污西装"
	desc = "一套带黄色领带的脏西装。看起来饱经风霜。"
	icon_state = "stowaway_uniform"

/obj/item/clothing/under/suit_jacket/director
	name = "主管西装"
	desc = "这是一套散发着权威气息的西装。属于某个非常重要的人物。"
	item_state = "director_uniform"
	icon_state = "director_uniform"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/WY.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/WY.dmi',
	)

/obj/item/clothing/under/suit_jacket/manager
	desc = "这是一套由那些有本事获得职位的人所穿的西装。\"Corporate Manager\"."
	name = "经理西装"
	icon_state = "manager_uniform"
	item_state = "manager_uniform"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/WY.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/WY.dmi',
	)

/obj/item/clothing/under/suit_jacket/trainee
	name = "实习生制服"
	desc = "这是一套制服，上面有维兰德的徽章，并印有字样。\"Trainee\" stamped below."
	icon_state = "trainee_uniform"
	item_state = "trainee_uniform"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/WY.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/WY.dmi',
	)

/obj/item/clothing/under/tunic
	name = "通用束腰外衣"
	desc = "一件由亚麻织物编织的通用束腰外衣。其历史用途可追溯到古老的人类文明。"
	icon_state = "roman_tunic"
	item_state = "roman_tunic"
	icon = 'icons/obj/items/clothing/uniforms/misc_ert_colony.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/misc_ert_colony.dmi'
	)
