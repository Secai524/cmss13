//Contains: Engineering department jumpsuits

/obj/item/clothing/under/rank/atmospheric_technician
	desc = "这是大气技术员穿的连体服。"
	name = "大气技术员连体服"
	icon_state = "atmos"
	item_state = "atmos_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/engineering.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/engineering.dmi',
	)
	flags_jumpsuit = null

/obj/item/clothing/under/rank/engineer
	desc = "这是一套工程师穿的橙色高能见度连体服。具有轻微的辐射防护能力。"
	name = "工程师连体服"
	icon_state = "engine"
	item_state = "engi_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/engineering.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/engineering.dmi',
	)
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_jumpsuit = null

/obj/item/clothing/under/rank/roboticist
	desc = "修身黑色设计，接缝处经过加固；非常适合工业作业。"
	name = "机器人专家连体服"
	icon_state = "robotics"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/research.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/research.dmi',
	)

