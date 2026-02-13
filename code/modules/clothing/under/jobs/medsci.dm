/*
 * Science
 */

/obj/item/clothing/under/rank/rd
	desc = "由特殊纤维制成，提供对生物危害的轻微防护。带有标识，表明穿着者是研究主管。"
	name = "研究主管制服"
	icon_state = "rdalt_s"
	worn_state = "rdalt_s"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/research.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/research.dmi',
	)
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/rdalt
	desc = "由特殊纤维制成，提供对生物危害的轻微防护。带有标识，表明穿着者是研究主管。"
	name = "研究主管连体服"
	icon_state = "rdalt"
	icon = 'icons/obj/items/clothing/uniforms/synthetic_uniforms.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/synthetic_uniforms.dmi',
	)
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/scientist
	desc = "由特殊纤维制成，提供对生物危害的轻微防护。其标记表明穿着者为科学家。"
	name = "科学家连体服"
	icon_state = "science"
	item_state = "w_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/research.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/research.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW

/*
 * Medical
 */
/obj/item/clothing/under/rank/cmo
	desc = "这是由那些有经验成为 \"Chief Medical Officer\". It provides minor biological protection."
	name = "首席医疗官连体服"
	icon_state = "cmo"
	item_state = "w_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/rank/geneticist
	desc = "由特殊纤维制成，提供对生物危害的特殊防护。上面有一条遗传学等级条纹。"
	name = "遗传学家连体服"
	icon_state = "genetics"
	item_state = "w_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/rank/virologist
	desc = "由特殊纤维制成，提供对生物危害的特殊防护。上面有一条病毒学家等级条纹。"
	name = "病毒学家连体服"
	icon_state = "virology"
	item_state = "w_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/nursesuit
	desc = "这是医疗部门护理人员常穿的连体服。"
	name = "护士服"
	icon_state = "nursesuit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/nurse
	desc = "医疗部护理人员常穿的一种制服。"
	name = "护士裙装"
	icon_state = "nurse"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/medical
	desc = "由特殊纤维制成，能提供对生物危害的轻微防护。胸前有十字标识，表明穿着者是受过训练的医疗人员。"
	name = "医生制服"
	icon_state = "medical"
	item_state = "w_suit"
	icon = 'icons/obj/items/clothing/uniforms/jumpsuits.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/jumpsuits.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	item_state_slots = list(WEAR_BODY = "medical")

/obj/item/clothing/under/rank/medical/lightblue
	name = "护士手术服"
	desc = "由特殊纤维制成，能提供对生物危害的轻微防护。与护士相关，采用令人平静的天蓝色。"
	icon_state = "scrubslightblue"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	flags_jumpsuit = FALSE
	item_state_slots = list(WEAR_BODY = "scrubslightblue")

/obj/item/clothing/under/rank/medical/blue
	name = "医生手术服"
	desc = "由特殊纤维制成，能提供对生物危害的轻微防护。无专科的医生穿着此款。这让你想起了蓝莓。"
	icon_state = "scrubsblue"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	flags_jumpsuit = FALSE
	item_state_slots = list(WEAR_BODY = "scrubsblue")

/obj/item/clothing/under/rank/medical/green
	name = "外科医生手术服"
	desc = "由特殊纤维制成，能提供对生物危害的轻微防护。由专攻外科手术的医生穿着，以翡翠绿为代表色。"
	icon_state = "scrubsgreen"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	flags_jumpsuit = FALSE
	item_state_slots = list(WEAR_BODY = "scrubsgreen")

/obj/item/clothing/under/rank/medical/purple
	name = "紫色手术服"
	desc = "由特殊纤维制成，能提供对生物危害的轻微防护。讲究的医生喜欢穿这种酒红色的手术服。"
	icon_state = "scrubspurple"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	flags_jumpsuit = FALSE
	item_state_slots = list(WEAR_BODY = "scrubspurple")

/obj/item/clothing/under/rank/medical/olive
	name = "橄榄绿手术服"
	desc = "由特殊纤维制成，能提供对生物危害的轻微防护。无专科的医生穿着此款以安抚和稳定患者情绪。采用橄榄绿色。"
	icon_state = "scrubsolive"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	flags_jumpsuit = FALSE
	item_state_slots = list(WEAR_BODY = "scrubsolive")

/obj/item/clothing/under/rank/medical/grey
	name = "灰色手术服"
	desc = "由特殊纤维制成，能提供对生物危害的轻微防护。无专科的医生穿着此款以安抚患者并保持专业形象。采用中性灰色。"
	icon_state = "scrubsgrey"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	flags_jumpsuit = FALSE
	item_state_slots = list(WEAR_BODY = "scrubsgrey")

/obj/item/clothing/under/rank/medical/brown
	name = "棕色手术服"
	desc = "由特殊纤维制成，能提供对生物危害的轻微防护。无专科的医生穿着此款以安抚和稳定患者情绪。采用红棕色。"
	icon_state = "scrubsbrown"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	flags_jumpsuit = FALSE
	item_state_slots = list(WEAR_BODY = "scrubsbrown")

/obj/item/clothing/under/rank/medical/morgue
	name = "停尸房手术服"
	desc = "由特殊纤维制成，能提供对生物危害的轻微防护。由进行尸检的医生穿着。漆黑如煤。令人毛骨悚然。"
	icon_state = "scrubsblack"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	flags_jumpsuit = FALSE
	item_state_slots = list(WEAR_BODY = "scrubsblack")

/obj/item/clothing/under/rank/medical/white
	name = "白色手术服"
	desc = "由特殊纤维制成，能提供对生物危害的轻微防护。深受所有喜爱洁净的医生珍视，洁白如雪。"
	icon_state = "scrubswhite"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	flags_jumpsuit = FALSE
	item_state_slots = list(WEAR_BODY = "scrubswhite")

/obj/item/clothing/under/rank/medical/orange
	name = "禁闭室手术服"
	desc = "由特殊纤维制成，能提供对生物危害的轻微防护。采用囚犯橙色。"
	icon_state = "scrubsorange"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	flags_jumpsuit = FALSE
	item_state_slots = list(WEAR_BODY = "scrubsorange")

/obj/item/clothing/under/rank/medical/pharmacist
	name = "药剂医师医疗服"
	desc = "由特殊纤维制成，提供对生物危害的轻微防护。专攻药学的医师穿着此款。白色为主，带有橙色肩章条纹。"
	icon_state = "scrubspharm"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	flags_jumpsuit = FALSE
	item_state_slots = list(WEAR_BODY = "scrubspharm")

/obj/item/clothing/under/rank/medical/cmo
	name = "医疗长医疗服"
	desc = "由特殊纤维制成，提供对生物危害的轻微防护。翡翠绿色，饰有桃红色条纹，表明穿着者为医疗长。"
	icon_state = "scrubscmo"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	flags_jumpsuit = FALSE
	item_state_slots = list(WEAR_BODY = "scrubscmo")
