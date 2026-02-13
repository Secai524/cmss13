//=============================//WY COMMANDOS\\==================================\\
//=======================================================================\\

/obj/item/clothing/head/helmet/marine/veteran/pmc/enclosed/commando
	name = "\improper W-Y Commando helmet"
	desc = "维兰德-汤谷突击队使用的标准封闭式头盔。"
	icon_state = "commando_helmet"
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE|BODY_FLAG_EYES
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_VERYHIGH
	armor_internaldamage = CLOTHING_ARMOR_VERYHIGH
	flags_inventory = COVEREYES|COVERMOUTH|BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEEYES|HIDEFACE|HIDEMASK|HIDEALLHAIR
	clothing_traits = list(TRAIT_EAR_PROTECTION)
	anti_hug = 6

/obj/item/clothing/head/helmet/marine/veteran/pmc/enclosed/commando/damaged
	name = "受损的维兰德-汤谷突击队头盔"
	desc = "维兰德-汤谷突击队使用的标准封闭式头盔。已经历大量磨损。"
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	anti_hug = 0

/obj/item/clothing/head/helmet/marine/veteran/pmc/enclosed/commando/sg
	icon_state = "commando_helmet_sg"

/obj/item/clothing/head/helmet/marine/veteran/pmc/enclosed/commando/leader
	name = "\improper W-Y Commando Leader helmet"
	desc = "维兰德-汤谷突击队使用的标准封闭式头盔。这顶由一名高级公司军官佩戴。"
	icon_state = "commando_helmet_leader"

/obj/item/clothing/head/helmet/marine/veteran/pmc/apesuit
	name = "\improper M5X Apesuit helmet"
	desc = "一个全封闭的装甲头盔，用于搭配M5X外骨骼护甲。"
	icon_state = "apesuit_helmet"
	item_state = "apesuit_helmet"
	unacidable = TRUE
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE|BODY_FLAG_EYES
	armor_melee = CLOTHING_ARMOR_VERYHIGHPLUS
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_VERYHIGHPLUS
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	flags_inventory = COVEREYES|COVERMOUTH|BLOCKSHARPOBJ|BLOCKGASEFFECT|FULL_DECAP_PROTECTION
	flags_inv_hide = HIDEEARS|HIDEEYES|HIDEFACE|HIDEMASK|HIDEALLHAIR
	flags_marine_helmet = HELMET_DAMAGE_OVERLAY
	unacidable = TRUE
	anti_hug = 100

