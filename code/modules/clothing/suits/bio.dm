//Biosuit complete with shoes (in the item sprite)
//Standard biosuit, orange stripe

/obj/item/clothing/head/bio_hood
	name = "生化防护兜帽"
	desc = "一种保护头部和面部免受生物污染物侵害的头罩。"
	icon_state = "bio_general"
	icon = 'icons/obj/items/clothing/hats/hazard.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hazard.dmi'
	)
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_HARDCORE
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_inventory = COVEREYES|COVERMOUTH|BLOCKGASEFFECT
	flags_inv_hide = HIDEFACE|HIDEMASK|HIDEEARS|HIDEALLHAIR
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE|BODY_FLAG_EYES
	siemens_coefficient = 0.9

/obj/item/clothing/head/bio_hood/synth
	desc = "一种保护头部和面部免受生物污染物侵害的头罩，合成人适用。不提供实际防护。"
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_NONE

/obj/item/clothing/suit/bio_suit
	name = "生物防护服"
	desc = "一种防止生物污染的防护服。"
	icon_state = "bio_general"
	item_state = "bio_suit"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	w_class = SIZE_LARGE//bulky item
	gas_transfer_coefficient = 0.01
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS
	slowdown = SLOWDOWN_ARMOR_LIGHT
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_HARDCORE
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_inv_hide = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAIL
	siemens_coefficient = 0.9
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/knives_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/knives_righthand.dmi'
	)

/obj/item/clothing/suit/storage/synthbio
	name = "生物防护服"
	desc = "合成人适用的生物危害防护服。旨在让合成人给人类一种感染控制的假象。其内部大部分防护衬里已被移除，以便容纳装备并减轻移动负担。"
	icon_state = "bio_general"
	item_state = "bio_suit"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	allowed = list(
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tool/crowbar,
		/obj/item/tool/crew_monitor,
		/obj/item/tool/pen,
		/obj/item/storage/large_holster/machete,
		/obj/item/device/motiondetector,
	)
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)

//Medical biosuit, blue wrist bands
/obj/item/clothing/head/bio_hood/medical
	icon_state = "bio_med"
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE|BODY_FLAG_EYES

/obj/item/clothing/suit/bio_suit/medical
	icon_state = "bio_med"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS|BODY_FLAG_HANDS|BODY_FLAG_FEET
	flags_inv_hide = HIDEGLOVES|HIDEJUMPSUIT|HIDETAIL

//Virology biosuit, green stripe
/obj/item/clothing/head/bio_hood/virology
	icon_state = "bio_virology"

/obj/item/clothing/suit/bio_suit/virology
	icon_state = "bio_virology"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	flags_inv_hide = HIDEGLOVES|HIDEJUMPSUIT|HIDETAIL

//Security biosuit, red wrist bands
/obj/item/clothing/head/bio_hood/security
	icon_state = "bio_security"

/obj/item/clothing/suit/bio_suit/security
	icon_state = "bio_security"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	flags_inv_hide = HIDEGLOVES|HIDEJUMPSUIT|HIDETAIL

//Scientist's biosuit, purple wrist bands
/obj/item/clothing/head/bio_hood/scientist
	icon_state = "bio_scientist"

/obj/item/clothing/suit/bio_suit/scientist
	icon_state = "bio_scientist"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	flags_inv_hide = HIDEGLOVES|HIDEJUMPSUIT|HIDETAIL

