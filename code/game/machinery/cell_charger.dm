/obj/structure/machinery/cell_charger
	name = "\improper heavy-duty cell charger"
	desc = "这是标准充电器的强化版本，专为电池充电设计。"
	icon = 'icons/obj/structures/machinery/power.dmi'
	icon_state = "ccharger0"
	anchored = TRUE
	use_power = USE_POWER_IDLE
	idle_power_usage = 5
	active_power_usage = 40000 //40 kW. (this the power drawn when charging)
	power_channel = POWER_CHANNEL_EQUIP
	var/obj/item/cell/charging = null
	var/chargelevel = -1

/obj/structure/machinery/cell_charger/proc/updateicon()
	icon_state = "ccharger[charging ? 1 : 0]"

	if(charging && !(inoperable()) )

		var/newlevel = floor(charging.percent() * 4 / 99)

		if(chargelevel != newlevel)

			overlays.Cut()
			overlays += "ccharger-o[newlevel]"

			chargelevel = newlevel
	else
		overlays.Cut()

/obj/structure/machinery/cell_charger/get_examine_text(mob/user)
	. = ..()
	. += "There's [charging ? "a" : "no"] cell in the charger."
	if(charging)
		. += "Current charge: [charging.charge] ([charging.percent()]%)"

/obj/structure/machinery/cell_charger/attackby(obj/item/W, mob/user)
	if(stat & BROKEN)
		return

	if(istype(W, /obj/item/cell) && anchored)
		if(charging)
			to_chat(user, SPAN_DANGER("充电器里已经有电池了。"))
			return
		else
			var/area/a = loc.loc // Gets our locations location, like a dream within a dream
			if(!isarea(a))
				return
			if(a.power_equip == 0) // There's no APC in this area, don't try to cheat power!
				to_chat(user, SPAN_DANGER("当你试图插入电池时，[name]闪烁起红光！"))
				return

			if(user.drop_inv_item_to_loc(W, src))
				charging = W
				user.visible_message("[user]将一块电池插入充电器。", "You insert a cell into the charger.")
				chargelevel = -1
				start_processing()
		updateicon()
	else if(HAS_TRAIT(W, TRAIT_TOOL_WRENCH))
		if(charging)
			to_chat(user, SPAN_DANGER("先把电池取出来！"))
			return

		anchored = !anchored
		to_chat(user, "你[anchored ? "attach" : "detach"] the cell charger [anchored ? "to" : "from"] the ground.")
		playsound(src.loc, 'sound/items/Ratchet.ogg', 25, 1)

/obj/structure/machinery/cell_charger/attack_hand(mob/user)
	if(charging)
		usr.put_in_hands(charging)
		charging.add_fingerprint(user)
		charging.update_icon()

		src.charging = null
		user.visible_message("[user]从充电器中取出电池。", "You remove the cell from the charger.")
		chargelevel = -1
		updateicon()
		stop_processing()

/obj/structure/machinery/cell_charger/attack_remote(mob/user)
	return

/obj/structure/machinery/cell_charger/emp_act(severity)
	. = ..()
	if(inoperable())
		return
	if(charging)
		charging.emp_act(severity)


/obj/structure/machinery/cell_charger/process()
	if((inoperable()) || !anchored)
		update_use_power(USE_POWER_NONE)
		return

	if (charging && !charging.fully_charged())
		charging.give(active_power_usage*CELLRATE)
		update_use_power(USE_POWER_ACTIVE)

		updateicon()
	else
		update_use_power(USE_POWER_IDLE)
