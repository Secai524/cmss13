
/obj/structure/lawnmower
	name = "割草机"
	desc = "一种装甲车辆，在近距离战斗中极为有效。"
	icon = 'icons/obj/structures/mememower.dmi'
	icon_state = "lawnmower"
	dir = WEST
	anchored = FALSE
	density = TRUE
	layer = ABOVE_LYING_MOB_LAYER

/obj/structure/lawnmower/Move(atom/NewLoc, dir)
	. = ..()
	if(.)
		var/mowed = FALSE
		for(var/mob/living/carbon/C in NewLoc)
			C.apply_damage(100, BRUTE, "r_foot")
			mowed = TRUE
		if(mowed)
			playsound(src, 'sound/machines/lawnmower.ogg',70, TRUE)

/obj/structure/lawnmower/Destroy()
	new /obj/item/limb/foot/r_foot(get_turf(loc))
	. = ..()
