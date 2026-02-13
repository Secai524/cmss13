/obj/effect/decal/remains/human
	name = "remains"
	desc = "它们看起来像是人类遗骸。令人不安..."
	gender = PLURAL
	icon = 'icons/effects/blood.dmi'
	icon_state = "remains"
	anchored = TRUE
	layer = BELOW_OBJ_LAYER //Puts them under most objects.

/obj/effect/decal/remains/xeno
	name = "remains"
	desc = "它们看起来像是某种可怕生物的遗骸。看着很不舒服..."
	gender = PLURAL
	icon = 'icons/effects/blood.dmi'
	icon_state = "remainsxeno"
	anchored = TRUE
	layer = BELOW_OBJ_LAYER

/obj/effect/decal/remains/xeno/Initialize(mapload, icon, icon_state, pixel_x)
	. = ..()

	src.icon = icon
	src.icon_state = icon_state
	src.pixel_x = pixel_x


/obj/effect/decal/remains/robot
	name = "remains"
	desc = "它们看起来像是某种机械的残骸。散发着一种奇怪的气息。"
	gender = PLURAL
	icon = 'icons/mob/robots.dmi'
	icon_state = "remainsrobot"
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
