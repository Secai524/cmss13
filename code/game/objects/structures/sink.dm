/obj/structure/sink
	name = "sink"
	icon = 'icons/obj/structures/props/watercloset.dmi'
	icon_state = "sink_emptied_animation"
	desc = "一个用来洗手洗脸的水槽。"
	anchored = TRUE
	/// if something's being washed at the moment
	var/busy = FALSE


/obj/structure/sink/Initialize()
	. = ..()
	if(prob(50))
		icon_state = "sink_emptied"


/obj/structure/sink/proc/stop_flow() //sets sink animation to normal sink (without running water)

	if(prob(50))
		icon_state = "sink_emptied_animation"
	else
		icon_state = "sink_emptied"
	flick("sink_animation_empty", src)


/obj/structure/sink/attack_hand(mob/user)
	if(isRemoteControlling(user))
		return

	if(!Adjacent(user))
		return

	if(busy)
		to_chat(user, SPAN_DANGER("已经有人在这里洗了。"))
		return

	to_chat(usr, SPAN_NOTICE("你开始洗手。"))
	flick("sink_animation_fill", src) //<- play the filling animation then automatically switch back to the loop
	icon_state = "sink_animation_fill_loop" //<- set it to the loop
	addtimer(CALLBACK(src, PROC_REF(stop_flow)), 6 SECONDS)
	playsound(loc, 'sound/effects/sinkrunning.ogg', 25, TRUE)

	busy = TRUE
	sleep(40)
	busy = FALSE

	if(!Adjacent(user))
		return //Person has moved away from the sink

	user.clean_blood()
	if(ishuman(user))
		user:update_inv_gloves()
	for(var/mob/V in viewers(src, null))
		V.show_message(SPAN_NOTICE("[user] 使用 \the [src] 洗手。"), SHOW_MESSAGE_VISIBLE)


/obj/structure/sink/attackby(obj/item/O as obj, mob/user as mob)
	if(busy)
		to_chat(user, SPAN_DANGER("已经有人在这里洗了。"))
		return

	var/obj/item/reagent_container/RG = O
	if (istype(RG) && RG.is_open_container())
		RG.reagents.add_reagent("water", min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
		user.visible_message(SPAN_NOTICE("[user] 使用 \the [src] 将 \the [RG] 装满。"),SPAN_NOTICE("You fill \the [RG] using \the [src]."))
		return

	else if (istype(O, /obj/item/weapon/baton))
		var/obj/item/weapon/baton/B = O
		if(B.bcell)
			if(B.bcell.charge > 0 && B.status == 1)
				flick("baton_active", src)
				user.apply_effect(10, STUN)
				user.stuttering = 10
				user.apply_effect(10, WEAKEN)
				B.deductcharge(B.hitcost)
				user.visible_message(
					SPAN_DANGER("[user] was stunned by \his wet [O]!"),
					SPAN_DANGER("You were stunned by your wet [O]!"))
				return

	var/turf/location = user.loc
	if(!isturf(location))
		return

	var/obj/item/I = O
	if(!I || !istype(I,/obj/item))
		return

	to_chat(usr, SPAN_NOTICE("你开始清洗 \the [I]。"))

	busy = TRUE
	sleep(40)
	busy = FALSE

	if(user.loc != location)
		return //User has moved
	if(!I)
		return //Item's been destroyed while washing
	if(user.get_active_hand() != I)
		return //Person has switched hands or the item in their hands

	O.clean_blood()
	user.visible_message(
		SPAN_NOTICE("[user] washes \a [I] using \the [src]."),
		SPAN_NOTICE("You wash \a [I] using \the [src]."))


/obj/structure/sink/clicked(mob/user, list/mods)
	if(!mods[ALT_CLICK])
		return ..()

	var/obj/item/held_item = user.get_active_hand()
	if(!held_item)
		user.visible_message(SPAN_NOTICE("[user]用手拂过\the [src]。"))
		return TRUE

	// Check if it's a reagent container
	var/obj/item/reagent_container/RG = held_item
	if(!istype(RG) || !RG.is_open_container())
		return TRUE

	var/remaining_space = RG.volume - RG.reagents.total_volume
	if(remaining_space > 0)
		RG.reagents.add_reagent("water", remaining_space)
		user.visible_message(SPAN_NOTICE("[user] 使用 \the [src] 将 \the [RG] 完全装满。"), SPAN_NOTICE("You fill \the [RG] completely using \the [src]."))
	else
		user.visible_message(SPAN_NOTICE("[user] 试图装满 \the [RG]，但它已经满了。"), SPAN_NOTICE("The [RG] is already full."))

	return TRUE

/obj/structure/sink/kitchen
	name = "厨房水槽"
	icon_state = "sink_alt"


/obj/structure/sink/puddle //splishy splashy ^_^
	name = "puddle"
	icon_state = "puddle"


/obj/structure/sink/puddle/attack_hand(mob/M as mob)
	icon_state = "puddle-splash"
	..()
	icon_state = "puddle"


/obj/structure/sink/puddle/attackby(obj/item/O as obj, mob/user as mob)
	icon_state = "puddle-splash"
	. = ..()
	icon_state = "puddle"
