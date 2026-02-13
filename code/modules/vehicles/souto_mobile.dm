/obj/vehicle/souto
	name = "\improper Soutomobile"
	icon_state = "soutomobile"
	desc = "几乎是，但还不完全是，全宇宙最棒的座驾。"
	move_delay = 3 //The speed of a fed but shoeless pajamarine, or a bit slower than a heavy-armor marine.
	buckling_y = 4
	layer = ABOVE_LYING_MOB_LAYER //Allows it to drive over people, but is below the driver.

/obj/vehicle/souto/Initialize()
	. = ..()
	var/image/I = new(icon = 'icons/obj/vehicles/vehicles.dmi', icon_state = "soutomobile_overlay", layer = ABOVE_MOB_LAYER) //over mobs
	overlays += I
	AddElement(/datum/element/corp_label/souta)

/obj/vehicle/souto/manual_unbuckle(mob/user)
	if(buckled_mob && buckled_mob != user)
		if(do_after(user, 20, INTERRUPT_ALL, BUSY_ICON_GENERIC))
			..()
	else ..()

/obj/vehicle/souto/relaymove(mob/user, direction)
	if(user.is_mob_incapacitated())
		return
	if(world.time > l_move_time + move_delay)
		. = step(src, direction)

/obj/vehicle/souto/super
	desc = "全宇宙最棒的座驾，专为独一无二的索托侠准备！"
	health = 1000
	locked = FALSE
	unacidable = TRUE
	explo_proof = TRUE

/obj/vehicle/souto/super/explode()
	for(var/mob/M as anything in viewers(7, src))
		M.show_message("不知为何，[src]看起来仍然像一罐崭新的经典索托汽水一样明亮闪亮。", SHOW_MESSAGE_VISIBLE)
	health = initial(health) //Souto Man never dies, and neither does his bike.

/obj/vehicle/souto/super/buckle_mob(mob/M, mob/user)
	if(!locked) //Vehicle is unlocked until first being mounted, since the Soutomobile is faction-locked and otherwise Souto Man cannot automatically buckle in on spawn as his equipment is spawned before his ID.
		locked = TRUE
	else if(M == user && M.faction != FACTION_SOUTO && locked == TRUE) //Are you a cool enough dude to drive this bike? Nah, nobody's THAT cool.
		to_chat(user, SPAN_WARNING("不知为何，当你握住把手时，[src]竟然瞪了你一眼。你退了回来。伙计，我们可没签合同来对付闹鬼的摩托车。"))
		return
	..()
