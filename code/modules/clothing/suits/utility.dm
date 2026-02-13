/*
 * Contains:
 * Fire protection
 * Bomb protection
 * Radiation protection
 */

/*
 * Fire protection
 */

/obj/item/clothing/suit/fire
	name = "firesuit"
	desc = "一套能防护火焰和高温的服装。"
	icon_state = "fire"
	item_state = "fire_suit"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)
	w_class = SIZE_LARGE//bulky item
	gas_transfer_coefficient = 0.90

	fire_intensity_resistance = BURN_LEVEL_TIER_1
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS
	allowed = list(
		/obj/item/tool/extinguisher,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/pen,
	)
	slowdown = 1
	flags_inventory = NOPRESSUREDMAGE
	flags_inv_hide = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAIL
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROT
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS

/obj/item/clothing/suit/fire/equipped(mob/user, slot)
	if(slot == WEAR_JACKET)
		RegisterSignal(user, COMSIG_LIVING_FLAMER_CROSSED, PROC_REF(flamer_fire_crossed_callback))
	..()

/obj/item/clothing/suit/fire/dropped(mob/user)
	UnregisterSignal(user, COMSIG_LIVING_FLAMER_CROSSED)
	..()

/obj/item/clothing/suit/fire/proc/flamer_fire_crossed_callback(mob/living/L, datum/reagent/R)
	SIGNAL_HANDLER

	if(R.fire_penetrating)
		return

	return COMPONENT_NO_IGNITE

/obj/item/clothing/suit/fire/firefighter
	icon_state = "firesuit"
	item_state = "fire_suit"

/*
 * Bomb protection
 */
/obj/item/clothing/head/bomb_hood
	name = "防爆头罩"
	desc = "炸弹处理时使用。"
	icon_state = "bombsuit"
	icon = 'icons/obj/items/clothing/hats/hazard.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hazard.dmi'
	)
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_ULTRAHIGH
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_inventory = COVEREYES|COVERMOUTH
	flags_inv_hide = HIDEFACE|HIDEMASK|HIDEEARS|HIDEALLHAIR
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE|BODY_FLAG_EYES
	siemens_coefficient = 0


/obj/item/clothing/suit/bomb_suit
	name = "防爆服"
	desc = "为处理爆炸物时的安全而设计的服装。"
	icon_state = "bombsuit"
	item_state = "bombsuit"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
	)
	w_class = SIZE_LARGE//bulky item
	gas_transfer_coefficient = 0.01

	slowdown = 2
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_ULTRAHIGH
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_inv_hide = HIDEJUMPSUIT|HIDETAIL
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROT
	siemens_coefficient = 0


/obj/item/clothing/head/bomb_hood/security
	icon_state = "bombsuitsec"
	item_state = "bombsuitsec"
	flags_armor_protection = BODY_FLAG_HEAD

/obj/item/clothing/suit/bomb_suit/security
	icon_state = "bombsuitsec"
	item_state = "bombsuitsec"
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/pen,
	)
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS

/*
 * Radiation protection
 */
/obj/item/clothing/head/radiation
	name = "辐射防护头罩"
	desc = "具有辐射防护性能的头罩。标签：含铅制造，请勿食用绝缘材料。"
	icon_state = "rad"
	icon = 'icons/obj/items/clothing/hats/hazard.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hazard.dmi'
	)
	flags_inventory = COVEREYES|COVERMOUTH
	flags_inv_hide = HIDEFACE|HIDEMASK|HIDEEARS|HIDEALLHAIR
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE|BODY_FLAG_EYES
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_ULTRAHIGH
	armor_internaldamage = CLOTHING_ARMOR_LOW


/obj/item/clothing/suit/radiation
	name = "辐射防护服"
	desc = "一套能防护辐射的服装。标签：含铅制造，请勿食用绝缘材料。"
	icon_state = "rad"
	item_state = "rad_suit"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/knives_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/knives_righthand.dmi'
	)
	w_class = SIZE_LARGE//bulky item
	gas_transfer_coefficient = 0.90

	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS|BODY_FLAG_HANDS|BODY_FLAG_FEET
	allowed = list(
		/obj/item/clothing/head/radiation,
		/obj/item/clothing/mask/gas,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/pen,
	)
	slowdown = 1.5
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_ULTRAHIGH
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_inv_hide = HIDEJUMPSUIT|HIDETAIL
