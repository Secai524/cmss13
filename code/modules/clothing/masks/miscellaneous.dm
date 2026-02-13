/obj/item/clothing/mask/muzzle
	name = "muzzle"
	desc = "为了阻止那可怕的噪音。"
	icon_state = "muzzle"
	item_state = "muzzle"
	flags_inventory = COVERMOUTH
	flags_armor_protection = 0
	w_class = SIZE_SMALL
	gas_transfer_coefficient = 0.90

/obj/item/clothing/mask/surgical
	name = "无菌口罩"
	desc = "旨在帮助防止疾病传播的无菌口罩。"
	icon_state = "sterile"
	item_state = "sterile"
	w_class = SIZE_SMALL
	flags_inventory = COVERMOUTH
	flags_armor_protection = 0
	gas_transfer_coefficient = 0.90
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_NONE

/obj/item/clothing/mask/fakemoustache
	name = "假胡子"
	desc = "警告：胡子是假的。"
	icon_state = "fake-moustache"
	flags_inv_hide = HIDEFACE
	flags_armor_protection = 0

/obj/item/clothing/mask/snorkel
	name = "呼吸管"
	desc = "为游泳高手准备。"
	icon_state = "snorkel"
	icon = 'icons/obj/items/clothing/masks/gasmasks.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/gasmasks.dmi'
	)
	flags_inv_hide = HIDEFACE
	flags_armor_protection = 0

/obj/item/clothing/mask/balaclava
	name = "balaclava"
	desc = "一种基本的单眼孔巴拉克拉瓦头套，几乎存在于所有体育用品、户外用品或军用剩余物资商店中，既能有效御寒，也能很好地隐藏面容。这款为标准黑色。"
	icon_state = "balaclava"
	item_state = "balaclava"
	icon = 'icons/obj/items/clothing/masks/balaclava.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/balaclava.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/masks_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/masks_righthand.dmi',
	)
	flags_inventory = COVERMOUTH|ALLOWREBREATH|ALLOWCPR
	flags_inv_hide = HIDEFACE|HIDEALLHAIR|HIDEEARS
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	w_class = SIZE_SMALL

/obj/item/clothing/mask/balaclava/tactical
	name = "绿色巴拉克拉瓦头套"
	desc = "一种基本的单眼孔巴拉克拉瓦头套，几乎存在于所有体育用品、户外用品或军用剩余物资商店中，既能有效御寒，也能很好地隐藏面容。这款为非标准绿色。"
	icon_state = "swatclava"
	item_state = "swatclava"

/obj/item/clothing/mask/luchador
	name = "摔角手面具"
	desc = "由强悍的斗士佩戴，高飞以击败对手！"
	icon_state = "luchag"
	item_state = "luchag"
	flags_inv_hide = HIDEFACE|HIDEALLHAIR
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE
	w_class = SIZE_SMALL
	siemens_coefficient = 3

/obj/item/clothing/mask/luchador/tecnicos
	name = "泰克尼科斯面具"
	desc = "由维护正义、光荣战斗的强悍斗士佩戴。"
	icon_state = "luchador"
	item_state = "luchador"

/obj/item/clothing/mask/luchador/rudos
	name = "鲁多斯面具"
	desc = "由不惜一切代价求胜的强悍斗士佩戴。"
	icon_state = "luchar"
	item_state = "luchar"
