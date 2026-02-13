
//Hat Station 13

/obj/item/clothing/head/collectable
	name = "收藏款帽子"
	desc = "一顶稀有的收藏款帽子。"

/obj/item/clothing/head/collectable/tophat
	name = "收藏款高顶礼帽"
	desc = "只有最负盛名的帽子收藏家才会佩戴的高顶礼帽。"
	icon_state = "tophat"
	item_state = "that"
	icon = 'icons/obj/items/clothing/hats/formal_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/formal_hats.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_righthand.dmi',
	)
	flags_armor_protection = 0

/obj/item/clothing/head/collectable/tophat/super
	name = "收藏款超级高顶礼帽"
	desc = "只有最高阶的帽子收藏家才会佩戴的顶级大礼帽。"
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/head_64.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_righthand.dmi',
	)
	icon_state = "super_top_hat"
	item_state = "super_top_hat"
	item_state_slots = list(
		WEAR_L_HAND = "that",
		WEAR_R_HAND = "that"
	)
	worn_x_dimension = 64
	worn_y_dimension = 64
	w_class = SIZE_LARGE

/obj/item/clothing/head/collectable/petehat
	icon_state = "petehat"
	item_state = "petehat"
