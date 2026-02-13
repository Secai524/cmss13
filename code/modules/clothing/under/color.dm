
/obj/item/clothing/under/color
	flags_jumpsuit = FALSE
	icon = 'icons/obj/items/clothing/uniforms/jumpsuits.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/jumpsuits.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)

/obj/item/clothing/under/color/black
	name = "黑色连体服"
	icon_state = "black"
	item_state = "bl_suit"
	worn_state = "black"

/obj/item/clothing/under/color/blue
	name = "蓝色连体服"
	icon_state = "blue"
	item_state = "b_suit"
	worn_state = "blue"

/obj/item/clothing/under/color/green
	name = "绿色连体服"
	icon_state = "green"
	item_state = "g_suit"
	worn_state = "green"

/obj/item/clothing/under/color/grey
	name = "灰色连体服"
	icon_state = "grey"
	item_state = "gy_suit"
	worn_state = "grey"

/obj/item/clothing/under/color/orange
	name = "橙色连体服"
	desc = "这是标准化的囚犯服装。其服装传感器卡在\"Fully On\" position."
	icon_state = "orange"
	item_state = "o_suit"
	worn_state = "orange"
	has_sensor = UNIFORM_FORCED_SENSORS
	sensor_mode = SENSOR_MODE_LOCATION

/obj/item/clothing/under/color/white
	name = "白色连体服"
	icon_state = "white"
	item_state = "w_suit"
	worn_state = "white"

/obj/item/clothing/under/color/yellow
	name = "黄色连体服"
	icon_state = "yellow"
	item_state = "y_suit"
	worn_state = "yellow"

/obj/item/clothing/under/color/lightbrown
	name = "浅棕色连体服"
	desc = "lightbrown"
	icon_state = "lightbrown"
	worn_state = "lightbrown"

/obj/item/clothing/under/color/brown
	name = "棕色连体服"
	desc = "brown"
	icon_state = "brown"
	worn_state = "brown"

/obj/item/clothing/under/color/lightred
	name = "浅红色连体服"
	desc = "lightred"
	icon_state = "lightred"
	worn_state = "lightred"

/obj/item/clothing/under/color/darkred
	name = "深红色连体服"
	desc = "darkred"
	icon_state = "darkred"
	worn_state = "darkred"

/obj/item/clothing/under/color/white/alt
	name = "白色连体服"
	icon_state = "white_alt"
	item_state = "w_suit"
	worn_state = "white_alt"

/obj/item/clothing/under/color/escaped_prisoner_colony
	name = "战损囚犯连体服"
	desc = "一件破烂的囚服，沾满干涸的血污和泥垢。左臂和左腿缠着临时绷带——浸透且肮脏，几乎要散开。布料接缝处撕裂，多处有烧焦痕迹，但囚服传感器仍在顽固地闪烁，卡在‘完全开启’状态。"
	icon_state = "escaped_prisoner"
	item_state = "escaped_prisoner"
	worn_state = "escaped_prisoner"
	has_sensor = UNIFORM_FORCED_SENSORS
	sensor_mode = SENSOR_MODE_LOCATION
