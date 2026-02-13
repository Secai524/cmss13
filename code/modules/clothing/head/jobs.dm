
//Bartender
/obj/item/clothing/head/chefhat
	name = "厨师帽"
	desc = "这是厨师用来防止头发掉进食物里的帽子。从食堂的食物来看，这玩意儿没什么用。"
	icon_state = "chefhat"
	item_state = "chefhat"
	desc = "厨师长的头部装备。"
	siemens_coefficient = 0.9

//Cult
/obj/item/clothing/head/cultist_hood
	name = "黑色兜帽"
	desc = "一个覆盖头部的兜帽。"
	icon_state = "chaplain_hood"
	flags_inventory = COVEREYES
	flags_inv_hide = HIDEEARS|HIDEALLHAIR
	siemens_coefficient = 0.9
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_EYES

	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROT

	armor_bio = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_HARDCORE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW

//Chaplain
/obj/item/clothing/head/nun_hood
	name = "修女兜帽"
	desc = "本星系最虔诚的象征。"
	icon_state = "nun_hood"
	flags_inventory = COVEREYES
	flags_inv_hide = HIDEEARS|HIDEALLHAIR
	siemens_coefficient = 0.9

//Mime
/obj/item/clothing/head/beret
	name = "beret"
	desc = "一顶贝雷帽，艺术家的最爱。"
	icon_state = "beret"
	siemens_coefficient = 0.9
	flags_armor_protection = 0
	pickup_sound = null
	drop_sound = null
	icon = 'icons/obj/items/clothing/hats/berets.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/berets.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_righthand.dmi'
	)

//Security
/obj/item/clothing/head/beret/sec
	name = "安保贝雷帽"
	desc = "一顶印有安保徽章的贝雷帽。适合那些更注重风格而非安全的军官。"
	icon_state = "beret_badge"

/obj/item/clothing/head/beret/sec/alt
	name = "军官贝雷帽"
	desc = "一顶藏青色贝雷帽，带有军官军衔徽章。适合那些更注重风格而非安全的军官。"
	icon_state = "officerberet"

/obj/item/clothing/head/beret/sec/hos
	name = "军官贝雷帽"
	desc = "一顶藏青色贝雷帽，带有上尉军衔徽章。适合那些更注重风格而非安全的军官。"
	icon_state = "hosberet"

/obj/item/clothing/head/beret/sec/warden
	name = "典狱长贝雷帽"
	desc = "一顶藏青色贝雷帽，带有典狱长军衔徽章。适合那些更注重风格而非安全的军官。"
	icon_state = "wardenberet"

/obj/item/clothing/head/beret/eng
	name = "工程部贝雷帽"
	desc = "一顶印有工程部徽章的贝雷帽。适合那些更注重风格而非安全的工程师。"
	icon_state = "e_beret_badge"

/obj/item/clothing/head/beret/jan
	name = "紫色贝雷帽"
	desc = "一顶时髦的，尽管是紫色的，贝雷帽。"
	icon_state = "purpleberet"


//Medical
/obj/item/clothing/head/surgery
	name = "手术帽"
	desc = "外科医生在手术时佩戴的帽子。防止他们的头发搔到你的内脏。"
	icon_state = "surgcap_blue"
	icon = 'icons/obj/items/clothing/hats/surgical_caps.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/surgical_caps.dmi'
	)
	flags_inv_hide = HIDETOPHAIR

/obj/item/clothing/head/surgery/blue
	name = "医生手术帽"
	desc = "医生在手术时佩戴的帽子。防止他们的头发搔到你的内脏。通常由医生佩戴，这顶帽子让你想起蓝莓。"
	icon_state = "surgcap_blue"

/obj/item/clothing/head/surgery/lightblue
	name = "护士手术帽"
	desc = "护士在协助手术时佩戴的帽子。防止她们的头发搔到你的内脏。通常由护士佩戴，这顶是浅蓝色的。"
	icon_state = "surgcap_lightblue"

/obj/item/clothing/head/surgery/green
	name = "外科医生手术帽"
	desc = "外科医生在手术时佩戴的帽子。防止他们的头发搔到你的内脏。通常由外科医生佩戴，这顶是翡翠绿色的。"
	icon_state = "surgcap_green"

/obj/item/clothing/head/surgery/morgue
	name = "停尸房手术帽"
	desc = "医生在进行尸检而非手术时佩戴的帽子。防止他们的头发掉落并干扰切口扫描。这顶帽子黑如煤炭。"
	icon_state = "surgcap_morgue"

/obj/item/clothing/head/surgery/pharmacist
	name = "药剂医师手术帽"
	desc = "药剂医师佩戴的帽子，用于保护头皮免受化学事故伤害。在他们手术时也能防止头发搔到你的内脏。它是白色的，带有橙色边缘。"
	icon_state = "surgcap_pharm"

/obj/item/clothing/head/surgery/cmo
	name = "医疗长手术帽"
	desc = "医疗长在手术时佩戴的条纹帽。防止他们的头发搔到你的内脏。它是绿色的，带有桃色条纹，以匹配他们实验袍上的条纹。"
	icon_state = "surgcap_cmo"

/obj/item/clothing/head/surgery/purple
	name = "紫色手术帽"
	desc = "外科医生在手术时佩戴的帽子。防止他们的头发搔到你的内脏。这顶是浓郁的酒红色。"
	icon_state = "surgcap_purple"

/obj/item/clothing/head/surgery/olive
	name = "橄榄绿手术帽"
	desc = "外科医生在手术时佩戴的帽子。防止他们的头发搔到你的内脏。这顶是橄榄绿色的。"
	icon_state = "surgcap_olive"

/obj/item/clothing/head/surgery/brown
	name = "棕色手术帽"
	desc = "外科医生在手术时佩戴的帽子。防止他们的头发搔到你的内脏。这顶是铁锈棕色的。"
	icon_state = "surgcap_brown"

/obj/item/clothing/head/surgery/grey
	name = "灰色手术帽"
	desc = "外科医生在手术时佩戴的帽子。防止他们的头发搔到你的内脏。这顶是普通的灰色。"
	icon_state = "surgcap_grey"

/obj/item/clothing/head/surgery/white
	name = "白色手术帽"
	desc = "外科医生在手术时佩戴的帽子。防止他们的头发搔到你的内脏。这顶是雪白色的。"
	icon_state = "surgcap_white"

//Detective

/obj/item/clothing/head/fedora
	name = "\improper tan fedora"
	desc = "一顶经典的棕褐色软呢帽。"
	icon = 'icons/obj/items/clothing/hats/formal_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/formal_hats.dmi'
	)
	icon_state = "fedora_tan"
	item_state = "fedora_tan"
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS

/obj/item/clothing/head/fedora/brown
	name = "\improper brown fedora"
	desc = "一顶经典的棕色软呢帽。"
	icon_state = "fedora_brown"
	item_state = "fedora_brown"

/obj/item/clothing/head/fedora/grey
	name = "\improper grey fedora"
	desc = "一顶经典的灰色软呢帽。"
	icon_state = "fedora_grey"
	item_state = "fedora_grey"
