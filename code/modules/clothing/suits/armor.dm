
/obj/item/clothing/suit/armor
	icon = 'icons/obj/items/clothing/suits/armor.dmi'
	flags_inventory = BLOCKSHARPOBJ
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	flags_bodypart_hidden = BODY_FLAG_CHEST
	min_cold_protection_temperature = HELMET_MIN_COLD_PROT
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROT
	siemens_coefficient = 0.6
	w_class = SIZE_HUGE
	allowed = list(/obj/item/weapon/gun, /obj/item/storage/backpack/general_belt) //Guns only.
	uniform_restricted = list(/obj/item/clothing/under)
	slowdown = SLOWDOWN_ARMOR_LIGHT

	pickup_sound = "armorequip"
	drop_sound = "armorequip"
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/armor.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)

/obj/item/clothing/suit/armor/mob_can_equip(mob/living/carbon/human/M, slot, disable_warning = 0)
	. = ..()
	if (.)
		if(issynth(M) && M.allow_gun_usage == FALSE)
			M.visible_message(SPAN_DANGER("你的程序设定阻止你穿戴这个！"))
			return 0

//armored vest

/obj/item/clothing/suit/armor/vest
	name = "防弹背心"
	desc = "一件能抵御部分伤害的装甲背心。"
	icon_state = "armor"
	item_state = "armor"
	blood_overlay_type = "armor"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	allowed = list(
		/obj/item/weapon/gun/,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/ammo_magazine/,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/device/binoculars,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
	)

/obj/item/clothing/suit/armor/vest/dutch
	name = "装甲夹克"
	desc = "丛林里很热。有时是闷热沉重，有时则是人间地狱。"
	icon = 'icons/obj/items/clothing/suits/misc_ert.dmi'
	icon_state = "dutch_armor"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/dutch)

/obj/item/clothing/suit/armor/vest/security
	name = "维兰德-汤谷安保护甲"
	desc = "一件能抵御部分伤害的装甲背心。这件上面有维兰德-汤谷公司的徽章。"
	icon_state = "armorsec"
	item_state = "armor"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/armor/vest/security/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/suit/armor/vest/warden
	name = "典狱长夹克"
	desc = "一件带有银色军衔徽章和制服的装甲夹克。"
	icon_state = "warden_jacket"
	item_state = "armor"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_ARMS
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)

/obj/item/clothing/suit/armor/laserproof
	name = "烧蚀护甲背心"
	desc = "一件在保护穿戴者免受能量弹丸伤害方面表现出色的背心。"
	icon_state = "armor_reflec"
	item_state = "armor_reflec"
	blood_overlay_type = "armor"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_VERYHIGH
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	siemens_coefficient = 0

/obj/item/clothing/suit/armor/bulletproof
	name = "防弹背心"
	desc = "一件在保护穿戴者免受高速实体弹丸伤害方面表现出色的背心。"
	icon_state = "bulletproof"
	item_state = "armor"
	blood_overlay_type = "armor"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM


/obj/item/clothing/suit/armor/bulletproof/badge
	icon_state = "bulletproofbadge"

/obj/item/clothing/suit/armor/riot
	name = "防暴服"
	desc = "一套带有厚重衬垫以抵御近战攻击的护甲。看起来可能会妨碍行动。"
	icon_state = "riot"
	item_state = "swat_suit"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	slowdown = 1
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_inventory = BLOCKSHARPOBJ
	siemens_coefficient = 0.5
	time_to_unequip = 20
	time_to_equip = 20

/obj/item/clothing/suit/armor/gladiator
	name = "角斗士护甲"
	desc = "你们还不满意吗？这不就是你们来此的目的吗？"
	icon_state = "gladiator"
	item_state = "gladiator"
	icon = 'icons/obj/items/clothing/suits/misc_ert.dmi'
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEJUMPSUIT
	siemens_coefficient = 0.5
	time_to_unequip = 20
	time_to_equip = 20
	allowed = list(
		/obj/item/weapon/sword,
		/obj/item/weapon/shield/riot,
		/obj/item/device/flashlight,
	)
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/misc_ert.dmi',
	)

/obj/item/clothing/suit/armor/riot/marine
	name = "\improper M5 riot control armor"
	desc = "一套经过大量改装的M2宪兵护甲，用于镇压大头兵陆战队员的骚乱。会严重拖慢你的速度。"
	icon_state = "riot"
	item_state = "swat_suit"
	slowdown = SLOWDOWN_ARMOR_LOWHEAVY
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	time_to_unequip = 20
	time_to_equip = 20

/obj/item/clothing/suit/armor/riot/marine/vintage_riot
	desc = "除了颜色略有不均的甲片外，它保存得相当完好。"
	icon_state = "old_riot"

/obj/item/clothing/suit/armor/swat
	name = "特警服"
	desc = "一套能抵御中等伤害的重型装甲服。用于特种作战。"
	icon_state = "deathsquad"
	item_state = "swat_suit"
	icon = 'icons/obj/items/clothing/suits/donator.dmi'
	gas_transfer_coefficient = 0.01

	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/baton,/obj/item/restraint/handcuffs,/obj/item/tank/emergency_oxygen)
	slowdown = 1
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	flags_inventory = BLOCKSHARPOBJ|NOPRESSUREDMAGE
	flags_inv_hide = HIDEGLOVES|HIDESHOES
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROT
	siemens_coefficient = 0.6
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/donator.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)

/obj/item/clothing/suit/armor/swat/officer
	name = "军官夹克"
	desc = "一件用于特种作战的装甲夹克。"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	icon_state = "detective"
	item_state = "det_suit"
	blood_overlay_type = "coat"
	flags_inventory = NO_FLAGS
	flags_inv_hide = NO_FLAGS
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)

/obj/item/clothing/suit/armor/det_suit
	name = "armor"
	desc = "一件带有侦探徽章的装甲背心。"
	icon_state = "detective-armor"
	item_state = "armor"
	blood_overlay_type = "armor"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW

/obj/item/clothing/suit/armor/hos
	name = "装甲大衣"
	desc = "一件用特殊合金增强以提供一定防护和风格的长大衣。"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	icon_state = "hos"
	item_state = "hos"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_inventory = NO_FLAGS
	flags_inv_hide = HIDEJUMPSUIT
	siemens_coefficient = 0.6
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)

/obj/item/clothing/suit/armor/roman
	name = "帝国军团兵护甲"
	desc = "一种金属护甲，也称为板条甲，由被称为军团士兵的罗马重装步兵使用。"
	icon = 'icons/obj/items/clothing/suits/misc_ert.dmi'
	icon_state = "legionary_armor"
	item_state = "legionary_armor"
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/misc_ert.dmi'
	)
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	flags_inventory = BLOCKSHARPOBJ
	siemens_coefficient = 0.5
	time_to_unequip = 20
	time_to_equip = 20
	allowed = list(
		/obj/item/weapon/sword,
		/obj/item/device/flashlight,
	)
	uniform_restricted = list(/obj/item/clothing/under/tunic)
	slowdown = SLOWDOWN_ARMOR_SUPER_LIGHT

/obj/item/clothing/suit/armor/roman/centurion
	name = "帝国百夫长护甲"
	desc = "一种金属护甲，也称为板条甲，由罗马重装步兵使用。这一件为腿部和手臂配备了额外的防护，并配有风格独特的斗篷。"
	icon_state = "centurion_armor"
	item_state = "centurion_armor"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	slowdown = SLOWDOWN_ARMOR_LIGHT
