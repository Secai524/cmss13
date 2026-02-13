/*
 * Contains:
 * Security
 * Detective
 * Head of Security
 */

/*
 * Security
 */
/obj/item/clothing/under/rank/warden
	desc = "采用比标准连体服更坚固的材料制成，以提供更可靠的防护。上面印有\"典狱长\" written on the shoulders."
	name = "典狱长连体服"
	icon_state = "warden"
	item_state = "r_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/security.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/security.dmi',
	)
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/security
	name = "安保官员连体服"
	desc = "采用比标准连体服更坚固的材料制成，以提供可靠的防护。"
	icon_state = "security"
	item_state = "r_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/security.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/security.dmi',
	)
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	siemens_coefficient = 0.9
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/dispatch
	name = "调度员制服"
	desc = "一件正装衬衫和卡其裤，缝有安保徽章。"
	icon_state = "dispatch"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/security.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/security.dmi',
	)
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS
	siemens_coefficient = 0.9
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/security2
	name = "安保官员制服"
	desc = "采用更坚固的材料制成，以提供可靠的防护。"
	icon_state = "redshirt2"
	item_state = "r_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/security.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/security.dmi',
	)
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	siemens_coefficient = 0.9
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/security/corp
	icon_state = "sec_corporate"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/warden/corp
	icon_state = "warden_corporate"
	flags_jumpsuit = FALSE

/*
 * Detective
 */
/obj/item/clothing/under/detective
	name = "\improper detective suit pants"
	desc = "一件褪色的白衬衫，配黑色领带和棕色休闲裤。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/security.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/security.dmi',
	)
	icon_state = "detective_brown"
	worn_state = "detective_brown"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/detective/neutral
	name = "棕色西裤"

/obj/item/clothing/under/detective/grey
	name = "\improper grey suit pants"
	desc = "一件褪色的白衬衫，配红色领带和黑色休闲裤。"
	icon_state = "detective_grey"
	worn_state = "detective_grey"

/obj/item/clothing/under/rank/warden/navyblue
	desc = "这套制服上的徽章表明它属于典狱长。"
	name = "典狱长制服"
	icon_state = "wardenblueclothes"
	item_state = "wardenblueclothes"
	flags_jumpsuit = FALSE
