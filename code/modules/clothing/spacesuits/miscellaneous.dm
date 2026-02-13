//Space santa outfit suit
/obj/item/clothing/head/helmet/space/santahat
	name = "圣诞帽"
	desc = "呵呵呵。圣诞快乐！"
	icon_state = "santa_hat_red"
	item_state = "santa_hat_red"
	icon = 'icons/obj/items/clothing/hats/hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_righthand.dmi',
	)
	flags_inventory = NOPRESSUREDMAGE|BLOCKSHARPOBJ
	flags_inv_hide = HIDEEYES
	flags_armor_protection = BODY_FLAG_HEAD

/obj/item/clothing/head/helmet/space/santahat/green
	icon_state = "santa_hat_green"

/obj/item/clothing/suit/space/santa
	name = "圣诞老人套装"
	desc = "节日气氛！"
	icon_state = "santa"
	item_state = "santa"
	icon = 'icons/obj/items/clothing/suits/misc_ert.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/misc_ert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)
	slowdown = 0
	allowed = list(/obj/item) //for stuffing extra special presents

/obj/item/clothing/head/helmet/space/compression
	name = "\improper MK.50 compression helmet"
	desc = "一顶沉重的太空头盔，设计用于搭配MK.50压缩服，但其坚固性不如护甲本身。感觉你可以在里面抽上一支。"
	item_state = "compression"
	icon_state = "compression"
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_ULTRAHIGH
	armor_rad = CLOTHING_ARMOR_ULTRAHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW

/obj/item/clothing/suit/space/compression
	name = "\improper MK.50 compression suit"
	desc = "一套沉重、笨重的民用太空服，配有装甲板。常见于雇佣兵、探险家、拾荒者和研究人员之手。"
	item_state = "compression"
	icon_state = "compression"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_ULTRAHIGH
	armor_rad = CLOTHING_ARMOR_ULTRAHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
	)

/obj/item/clothing/head/helmet/space/compression/uscm
	name = "\improper MK.50 compression helmet"
	desc = "一顶沉重的太空头盔，设计用于搭配MK.50压缩服，带有USCM的风格。感觉你可以在里面抽上一支。"

/obj/item/clothing/suit/space/compression/uscm
	name = "\improper MK.50 compression suit"
	desc = "一套沉重、笨重的民用太空服，配有装甲板。这套特定的护甲不知怎地流入了USCM巡逻艇补给系统的杂牌库存中。"
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/baton,/obj/item/restraint/handcuffs,/obj/item/tank)

// Souto man

/obj/item/clothing/suit/space/souto
	name = "\improper Souto Man tank top"
	desc = "Souto Man穿着的背心。就像一罐新鲜的Souto Classic一样清爽！"
	item_state = "souto_man"
	icon_state = "souto_man"
	icon = 'icons/obj/items/clothing/suits/misc_ert.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/misc_ert.dmi',
	)
	armor_melee = CLOTHING_ARMOR_HARDCORE
	armor_bullet = CLOTHING_ARMOR_HARDCORE
	armor_laser = CLOTHING_ARMOR_HARDCORE
	armor_energy = CLOTHING_ARMOR_HARDCORE
	armor_bomb = CLOTHING_ARMOR_HARDCORE
	armor_bio = CLOTHING_ARMOR_HARDCORE
	armor_rad = CLOTHING_ARMOR_HARDCORE
	armor_internaldamage = CLOTHING_ARMOR_HARDCORE
	flags_inventory = CANTSTRIP|BLOCKSHARPOBJ
	unacidable = TRUE
	flags_inv_hide = null
	slowdown = 0

/obj/item/clothing/head/helmet/space/souto
	name = "\improper Souto Man hat"
	desc = "Souto Man戴着的帽子。像新的24盎司Souto Lime罐子一样高！"
	item_state = "souto_man"
	icon_state = "souto_man"
	icon = 'icons/obj/items/clothing/hats/hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats.dmi'
	)
	armor_melee = CLOTHING_ARMOR_HARDCORE
	armor_bullet = CLOTHING_ARMOR_HARDCORE
	armor_laser = CLOTHING_ARMOR_HARDCORE
	armor_energy = CLOTHING_ARMOR_HARDCORE
	armor_bomb = CLOTHING_ARMOR_HARDCORE
	armor_bio = CLOTHING_ARMOR_HARDCORE
	armor_rad = CLOTHING_ARMOR_HARDCORE
	armor_internaldamage = CLOTHING_ARMOR_HARDCORE
	flags_inventory = CANTSTRIP|COVEREYES|COVERMOUTH|ALLOWINTERNALS|ALLOWREBREATH|BLOCKGASEFFECT|ALLOWCPR|BLOCKSHARPOBJ
	unacidable = TRUE
	flags_inv_hide = null
