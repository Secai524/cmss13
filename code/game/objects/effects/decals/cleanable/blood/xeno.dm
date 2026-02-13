

//Alien blood effects.
/obj/effect/decal/cleanable/blood/xeno
	name = "嘶嘶作响的血液"
	desc = "它是黄色的，带有酸性。看起来像是……<i>血液？</i>"
	icon = 'icons/effects/blood.dmi'
	basecolor = BLOOD_COLOR_XENO
	amount = 1

/obj/effect/decal/cleanable/blood/gibs/xeno
	name = "冒着热气的碎块"
	gender = PLURAL
	desc = "真恶心……"
	icon_state = "xgib1"
	random_icon_states = list("xgib1", "xgib2", "xgib3", "xgib4", "xgib5", "xgib6")
	basecolor = BLOOD_COLOR_XENO

/obj/effect/decal/cleanable/blood/gibs/xeno/update_icon()
	color = "#FFFFFF"

/obj/effect/decal/cleanable/blood/gibs/xeno/up
	random_icon_states = list("xgib1", "xgib2", "xgib3", "xgib4", "xgib5", "xgib6", "xgibup1", "xgibup1", "xgibup1")

/obj/effect/decal/cleanable/blood/gibs/xeno/down
	random_icon_states = list("xgib1", "xgib2", "xgib3", "xgib4", "xgib5", "xgib6", "xgibdown1", "xgibdown1", "xgibdown1")

/obj/effect/decal/cleanable/blood/gibs/xeno/body
	random_icon_states = list("xgibhead", "xgibtorso")

/obj/effect/decal/cleanable/blood/gibs/xeno/limb
	random_icon_states = list("xgibleg", "xgibarm")

/obj/effect/decal/cleanable/blood/gibs/xeno/core
	random_icon_states = list("xgibmid1", "xgibmid2", "xgibmid3")

/obj/effect/decal/cleanable/blood/xtracks
	basecolor = BLOOD_COLOR_XENO
