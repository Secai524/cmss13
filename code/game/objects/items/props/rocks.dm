//these are rock props that aren't map specific.
//to-do, sort all map specific rock props into generic variants and put them into this file.

//keep in mind that some of these are DENSE, and some are NOT
//And also take note that some maps use auto_turfs (see auto_turfs.dm)

/obj/structure/prop/rock
	name = "岩石"
	icon = 'icons/obj/structures/props/natural/rocks.dmi'
	icon_state = "rock"//go figure
	desc = "当地矿物的凝固集合体。熔化后，会变成一种最广为人知的物质——熔岩。"

	opacity = FALSE
	density = TRUE
	var/dir_list_full = list(1,2,4,8,5,6,9,10)
	var/dir_list_limited = list(1,2,4,8)

/obj/structure/prop/rock/brown//these are sprited with the same colors as the recolorable moonsand walls used on LV, Whiskey Outpost, & New Varadero (Aka Water_world.dmm)
	icon_state = "brown"

/obj/structure/prop/rock/brown_degree
	icon_state = "educated_rock"
	name = "一块聪明的石头"
	desc = "现在画他们接受教育的样子。"

/obj/structure/prop/rock/brown/Initialize()//why do we do this on subtypes? Because some people didn't make 4 or 8 version of a single rock, so we either instance or code those individual. Fucking old spriters, I swear.
	. = ..()
	dir = pick(dir_list_full)
	if(prob(50))
		icon_state = "brown_alt"

/obj/structure/prop/rock/black_ground//the colors on these make them kinda look like actual shit, can't lie. Exercise discretion fellow mappers.
	icon_state = "black_ground"
	desc = "松散的石头、泥土、碎石、石板、峭壁、鹅卵石、采石场的碎屑、页岩、砾石、凝固的碳以及其他东西。你知道的，就是那些你可以走过或踢来踢去的石头。"
	density = FALSE//these guys don't look like they'd block movement
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT//don't want these to eat clicks, that'd be like... bad (Lookin' at you grass tufts)

/obj/structure/prop/rock/black_ground/Initialize()
	. = ..()
	dir = pick(dir_list_full)//they actually made 7, but a quick bit of sprite magic and we have 8 variants

/obj/structure/prop/rock/black_ground/dense//surprise surprise, they made 3 versions of these rocks that are near full tile. Fuck you old spriter.
	icon_state = "black_ground_alt"
	density = TRUE
	desc = "拒绝让步的土地。也许你应该绕过去，或者拿把镐（或类似的工具）来。"

/obj/structure/prop/rock/black_ground/dense/Initialize()
	. = ..()
	dir = pick(dir_list_limited)//only 4 variants of this, and thusly on 4 directions on the icon to randomize from

/obj/structure/prop/colorable_rock/colorable
	name = "rocks"
	desc = "当地矿物的凝固集合体。熔化后，会变成一种最广为人知的物质——熔岩。"
	icon_state = "ground_colorable"
	icon = 'icons/obj/structures/props/natural/rocks.dmi'
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = TURF_LAYER

/obj/structure/prop/colorable_rock/colorable/alt
	icon_state = "ground_colorable_alt"
