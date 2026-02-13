/obj/item/clothing/head/soft
	name = "货运帽"
	desc = "这是一顶品味不佳的黄色棒球帽。"
	icon_state = "cargosoft"
	flags_inventory = COVEREYES
	item_state = "helmet"
	icon = 'icons/obj/items/clothing/hats/soft_caps.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/soft_caps.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_righthand.dmi',
	)
	var/cap_color = "cargo"
	var/flipped = 0
	siemens_coefficient = 0.9
	flags_armor_protection = 0

/obj/item/clothing/head/soft/dropped()
	icon_state = "[cap_color]soft"
	flipped=0
	..()

/obj/item/clothing/head/soft/verb/flip()
	set category = "Object"
	set name = "Flip cap"
	set src in usr
	if(!usr.is_mob_incapacitated())
		src.flipped = !src.flipped
		if(src.flipped)
			icon_state = "[cap_color]soft_flipped"
			to_chat(usr, "你将帽子反戴。")
		else
			icon_state = "[cap_color]soft"
			to_chat(usr, "你将帽子戴回正常位置。")
		update_clothing_icon() //so our mob-overlays update

/obj/item/clothing/head/soft/red
	name = "红色帽子"
	desc = "这是一顶品味不佳的红色棒球帽。"
	icon_state = "redsoft"
	cap_color = "red"

/obj/item/clothing/head/soft/blue
	name = "蓝色帽子"
	desc = "这是一顶品味不佳的蓝色棒球帽。"
	icon_state = "bluesoft"
	cap_color = "blue"

/obj/item/clothing/head/soft/green
	name = "绿色帽子"
	desc = "这是一顶品味不佳的绿色棒球帽。"
	icon_state = "greensoft"
	cap_color = "green"

/obj/item/clothing/head/soft/yellow
	name = "黄色帽子"
	desc = "这是一顶品味不佳的黄色棒球帽。"
	icon_state = "yellowsoft"
	cap_color = "yellow"

/obj/item/clothing/head/soft/grey
	name = "灰色帽子"
	desc = "这是一顶品味不错的灰色棒球帽。"
	icon_state = "greysoft"
	cap_color = "grey"

/obj/item/clothing/head/soft/orange
	name = "橙色棒球帽"
	desc = "这是一顶品味不佳的橙色棒球帽。"
	icon_state = "orangesoft"
	cap_color = "orange"

/obj/item/clothing/head/soft/mime
	name = "白色帽子"
	desc = "这是一顶品味不佳的白色棒球帽。"
	icon_state = "mimesoft"
	cap_color = "mime"

/obj/item/clothing/head/soft/purple
	name = "紫色棒球帽"
	desc = "这是一顶品味不佳的紫色棒球帽。"
	icon_state = "purplesoft"
	cap_color = "purple"

/obj/item/clothing/head/soft/rainbow
	name = "彩虹棒球帽"
	desc = "这是一顶色彩鲜艳的彩虹色棒球帽。"
	icon_state = "rainbowsoft"
	cap_color = "rainbow"

/obj/item/clothing/head/soft/ferret
	name = "\improper Ferret Heavy Industries trucker hat"
	desc = "这是一顶卡车司机帽。自2180年雪貂公司倒闭后，它们已成为收藏品。"
	icon_state = "ferretsoft"
	cap_color = "ferret"
	black_market_value = 25

/obj/item/clothing/head/soft/trucker
	name = "\improper blue trucker hat"
	desc = "这是一顶蓝色卡车司机帽。"
	icon_state = "truckercap_bluesoft"
	cap_color = "truckercap_blue"

/obj/item/clothing/head/soft/trucker/red
	name = "\improper red trucker hat"
	desc = "这是一顶红色卡车司机帽。"
	icon_state = "truckercap_redsoft"
	cap_color = "truckercap_red"

/obj/item/clothing/head/soft/sec
	name = "安保帽"
	desc = "这是一顶品味尚可的红色棒球帽。"
	icon_state = "secsoft"
	cap_color = "sec"

/obj/item/clothing/head/cmcap/wy_cap
	name = "\improper Weyland-Yutani cap"
	desc = "一顶深色帽子，印有维兰德-汤谷的“飞翼”标志，代表着公司的正义。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/WY.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/WY.dmi',
	)
	icon_state = "newcorpo_cap"
	item_state = "newcorpo_cap"
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
	flags_atom = FPRINT|NO_GAMEMODE_SKIN

//marine cap

/obj/item/clothing/head/soft/marine
	name = "陆战队中士帽"
	desc = "这是一顶由先进防弹纤维制成的软帽。无法防止头部起包。"
	icon_state = "greysoft"
	cap_color = "grey"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/soft/marine/alpha
	name = "阿尔法班中士帽"
	icon_state = "redsoft"
	cap_color = "red"

/obj/item/clothing/head/soft/marine/beta
	name = "布拉沃班中士帽"
	icon_state = "yellowsoft"
	cap_color = "yellow"

/obj/item/clothing/head/soft/marine/charlie
	name = "查理班中士帽"
	icon_state = "purplesoft"
	cap_color = "purple"

/obj/item/clothing/head/soft/marine/delta
	name = "德尔塔班中士帽"
	icon_state = "bluesoft"
	cap_color = "blue"

/obj/item/clothing/head/soft/marine/mp
	name = "陆战队宪兵中士帽"
	icon_state = "greensoft"
	cap_color = "green"
