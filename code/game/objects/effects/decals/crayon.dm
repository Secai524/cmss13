/obj/effect/decal/cleanable/crayon
	name = "rune"
	desc = "一个用蜡笔画出的符文。"
	icon = 'icons/obj/rune.dmi'
	layer = ABOVE_TURF_LAYER
	anchored = TRUE

/obj/effect/decal/cleanable/crayon/New(location, main = COLOR_WHITE,shade = COLOR_BLACK, type = "rune")
	..()
	forceMove(location)

	name = type
	desc = "一个用蜡笔画出的[type]。"

	switch(type)
		if("rune")
			type = "rune[rand(1,6)]"
		if("graffiti")
			type = pick("amyjon","face","matt","revolution","engie","guy","end","dwarf","uboa")

	var/icon/mainOverlay = new/icon('icons/effects/crayondecal.dmi',"[type]",2.1)
	var/icon/shadeOverlay = new/icon('icons/effects/crayondecal.dmi',"[type]s",2.1)

	mainOverlay.Blend(main,ICON_ADD)
	shadeOverlay.Blend(shade,ICON_ADD)

	overlays += mainOverlay
	overlays += shadeOverlay

	add_hiddenprint(usr)
