//The effect when you wrap a dead body in gift wrap
/obj/effect/spresent
	name = "奇怪的礼物"
	desc = "这是个……礼物？"
	icon = 'icons/obj/items/gifts.dmi'
	icon_state = "strangepresent"
	density = TRUE
	anchored = FALSE






/obj/effect/mark
	var/mark = ""
	icon = 'icons/old_stuff/mark.dmi'
	icon_state = "blank"
	anchored = TRUE
	layer = 99
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	unacidable = TRUE//Just to be sure.

/obj/effect/beam
	name = "beam"
	unacidable = TRUE//Just to be sure.
	var/def_zone

/obj/effect/beam/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_pass = PASS_OVER|PASS_THROUGH

/obj/effect/list_container
	name = "列表容器"

/obj/effect/list_container/mobl
	name = "mobl"
	var/master = null

	var/list/container = list(  )

/obj/effect/projection
	name = "投影"
	desc = "这看起来像是某物的投影。"
	anchored = TRUE


/obj/effect/shut_controller
	name = "关闭控制器"
	var/moving = null
	var/list/parts = list(  )




//Exhaust effect
/obj/effect/engine_exhaust
	name = "引擎排气"
	icon = 'icons/effects/effects.dmi'
	icon_state = "exhaust"
	anchored = TRUE

/obj/effect/engine_exhaust/New(turf/nloc, ndir, temp)
	setDir(ndir)
	..(nloc)

	spawn(20)
		moveToNullspace()
