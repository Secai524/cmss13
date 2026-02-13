
// *************************************
// Hydroponics Tools
// *************************************

/obj/item/tool/plantspray
	icon = 'icons/obj/items/spray.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/hydroponics_tools_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/hydroponics_tools_righthand.dmi',
	)
	item_state = "spraycan"
	flags_item = NOBLUDGEON
	flags_equip_slot = SLOT_WAIST
	throwforce = 4
	w_class = SIZE_SMALL
	throw_speed = SPEED_SLOW
	throw_range = 10
	var/toxicity = 4
	var/pest_kill_str = 0
	var/weed_kill_str = 0

/obj/item/tool/plantspray/weeds // -- Skie

	name = "除草喷雾"
	desc = "这是一种有毒的喷雾混合物，用于杀死小型杂草。"
	icon_state = "weedspray"
	weed_kill_str = 6

/obj/item/tool/plantspray/pests
	name = "杀虫喷雾"
	desc = "这是某种害虫清除喷雾！<I>请勿吸入！</I>"
	icon_state = "pestspray"
	pest_kill_str = 6

/obj/item/tool/plantspray/pests/old
	name = "杀虫剂瓶"

/obj/item/tool/plantspray/pests/old/carbaryl
	name = "西维因药瓶"
	toxicity = 4
	pest_kill_str = 2

/obj/item/tool/plantspray/pests/old/lindane
	name = "林丹药瓶"
	toxicity = 6
	pest_kill_str = 4

/obj/item/tool/plantspray/pests/old/phosmet
	name = "亚胺硫磷药瓶"
	toxicity = 8
	pest_kill_str = 7



/obj/item/tool/weedkiller
	name = "除草剂药瓶"
	icon = 'icons/obj/items/chemistry.dmi'
	var/toxicity = 0
	var/weed_kill_str = 0

/obj/item/tool/weedkiller/triclopyr
	name = "草甘膦药瓶"
	toxicity = 4
	weed_kill_str = 2

/obj/item/tool/weedkiller/lindane
	name = "绿草定药瓶"
	toxicity = 6
	weed_kill_str = 4

/obj/item/tool/weedkiller/D24
	name = "2,4-D药瓶"
	toxicity = 8
	weed_kill_str = 7




/obj/item/tool/minihoe // -- Numbers
	name = "迷你锄头"
	desc = "用于清除杂草或挠背。"
	icon = 'icons/obj/items/tools.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/hydroponics_tools_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/hydroponics_tools_righthand.dmi',
	)
	icon_state = "hoe"
	item_state = "hoe"
	flags_atom = FPRINT|CONDUCT
	flags_item = NOBLUDGEON
	force = 5
	throwforce = 7
	w_class = SIZE_SMALL
	matter = list("metal" = 50)
	attack_verb = list("slashed", "sliced", "cut", "clawed")

/obj/item/tool/minihoe/yautja
	icon = 'icons/obj/structures/props/hunter/32x32_hunter_props.dmi'

//Hatchets and things to kill kudzu
/obj/item/tool/hatchet
	name = "hatchet"
	desc = "一把锋利的手斧，常用于劈开木材或其他物体。常见于伐木工、侦察兵和掠夺者手中。"
	icon = 'icons/obj/items/weapons/melee/axes.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/axes_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/axes_righthand.dmi'
	)
	icon_state = "hatchet"
	flags_atom = FPRINT|CONDUCT
	force = MELEE_FORCE_NORMAL
	w_class = SIZE_SMALL
	throwforce = 20
	throw_speed = SPEED_VERY_FAST
	throw_range = 4
	sharp = IS_SHARP_ITEM_BIG
	edge = 1
	matter = list("metal" = 15000)

	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("chopped", "torn", "cut")


/obj/item/tool/scythe
	name = "scythe"
	desc = "长纤维金属手柄上装有锋利弯曲的刀刃，此工具让你轻松收获所种之物。"
	icon = 'icons/obj/items/tools.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/tools_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/tools_righthand.dmi',
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/melee_weapons.dmi'
	)
	icon_state = "scythe"
	force = 13
	throwforce = 5
	throw_speed = SPEED_FAST
	throw_range = 3
	w_class = SIZE_LARGE
	flags_atom = FPRINT|CONDUCT
	flags_equip_slot = SLOT_BACK

	attack_verb = list("chopped", "sliced", "cut", "reaped")
