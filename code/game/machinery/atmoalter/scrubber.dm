/obj/structure/machinery/portable_atmospherics/powered/scrubber
	name = "便携式空气净化器"
	needs_power = FALSE
	icon = 'icons/obj/structures/machinery/atmos.dmi'
	icon_state = "pscrubber:0"
	density = TRUE


	var/on = 0

/obj/structure/machinery/portable_atmospherics/powered/scrubber/New()
	..()
	cell = new/obj/item/cell(src)

/obj/structure/machinery/portable_atmospherics/powered/scrubber/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_OVER|PASS_AROUND|PASS_UNDER

/obj/structure/machinery/portable_atmospherics/powered/scrubber/emp_act(severity)
	. = ..()
	if(inoperable())
		return

	if(prob(50/severity))
		on = !on
		update_icon()

/obj/structure/machinery/portable_atmospherics/powered/scrubber/update_icon()
	src.overlays = 0

	if(on && cell && cell.charge)
		icon_state = "pscrubber:1"
	else
		icon_state = "pscrubber:0"

	return


//Huge scrubber
/obj/structure/machinery/portable_atmospherics/powered/scrubber/huge
	name = "大型空气净化器"
	icon_state = "scrubber:0"
	anchored = TRUE

	chan
	use_power = USE_POWER_NONE

	var/global/gid = 1
	var/id = 0

/obj/structure/machinery/portable_atmospherics/powered/scrubber/huge/New()
	..()
	cell = null

	id = gid
	gid++

	name = "[name] (ID [id])"

/obj/structure/machinery/portable_atmospherics/powered/scrubber/huge/attack_hand(mob/user as mob)
		to_chat(usr, SPAN_NOTICE("你无法直接与此机器交互。请使用净化器控制台。"))

/obj/structure/machinery/portable_atmospherics/powered/scrubber/huge/update_icon()
	src.overlays = 0

	if(on && !(inoperable()))
		icon_state = "scrubber:1"
	else
		icon_state = "scrubber:0"


/obj/structure/machinery/portable_atmospherics/powered/scrubber/huge/attackby(obj/item/I as obj, mob/user as mob)
	if(HAS_TRAIT(I, TRAIT_TOOL_WRENCH))
		if(on)
			to_chat(user, SPAN_NOTICE("先把它关掉！"))
			return

		anchored = !anchored
		playsound(src.loc, 'sound/items/Ratchet.ogg', 25, 1)
		to_chat(user, SPAN_NOTICE("你[anchored ? "wrench" : "unwrench"] \the [src]."))

		return

	//doesn't use power cells
	if(istype(I, /obj/item/cell))
		return
	if (HAS_TRAIT(I, TRAIT_TOOL_SCREWDRIVER))
		return

	//doesn't hold tanks
	if(istype(I, /obj/item/tank))
		return

	. = ..()


/obj/structure/machinery/portable_atmospherics/powered/scrubber/huge/stationary
	name = "固定式空气净化器"

/obj/structure/machinery/portable_atmospherics/powered/scrubber/huge/stationary/attackby(obj/item/I as obj, mob/user as mob)
	if(HAS_TRAIT(I, TRAIT_TOOL_WRENCH))
		to_chat(user, SPAN_NOTICE("螺栓太紧，你无法拧开！"))
		return

	. = ..()
