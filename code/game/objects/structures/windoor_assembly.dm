/* Windoor (window door) assembly -Nodrak
 * Step 1: Create a windoor out of rglass
 * Step 2: Add r-glass to the assembly to make a secure windoor (Optional)
 * Step 3: Rotate or Flip the assembly to face and open the way you want
 * Step 4: Wrench the assembly in place
 * Step 5: Add cables to the assembly
 * Step 6: Set access for the door.
 * Step 7: Screwdriver the door to complete
 */


/obj/structure/windoor_assembly
	icon = 'icons/obj/structures/doors/windoor.dmi'

	name = "风门组件"
	icon_state = "l_windoor_assembly01"
	anchored = FALSE
	density = FALSE
	dir = NORTH

	var/obj/item/circuitboard/airlock/electronics = null

	//Vars to help with the icon's name
	///Does the windoor open to the left or right? (used in update_icon)
	var/facing = "l"
	///Whether or not this creates a secure windoor (used in update_icon)
	var/secure = ""
	///How far the door assembly has progressed in terms of sprites (used in update_icon)
	var/state = WINDOOR_STATE_01

	///Whether this is currently being manipulated to prevent doubling up
	var/construction_busy = FALSE

/obj/structure/windoor_assembly/New(Loc, start_dir=NORTH, constructed=0)
	..()
	if(constructed)
		state = WINDOOR_STATE_01
		anchored = FALSE
	switch(start_dir)
		if(NORTH, SOUTH, EAST, WEST)
			setDir(start_dir)
		else //If the user is facing northeast. northwest, southeast, southwest or north, default to north
			setDir(NORTH)


/obj/structure/windoor_assembly/Destroy()
	density = FALSE
	return ..()

/obj/structure/windoor_assembly/update_icon()
	icon_state = "[facing]_[secure]windoor_assembly[state]"

/obj/structure/windoor_assembly/attackby(obj/item/attacking_item, mob/living/user, list/mods)
	if(construction_busy)
		to_chat(user, SPAN_WARNING("其他人已经在处理[src]了。"))
		return

	//I really should have spread this out across more states but thin little windoors are hard to sprite.
	switch(state)
		if(WINDOOR_STATE_01)
			if(iswelder(attacking_item) && !anchored)
				if(!HAS_TRAIT(attacking_item, TRAIT_TOOL_BLOWTORCH))
					to_chat(user, SPAN_WARNING("你需要一把更强的喷枪！"))
					return
				var/obj/item/tool/weldingtool/welder = attacking_item
				if(welder.remove_fuel(0,user))
					user.visible_message("[user]拆解了风门组件。", "You start to dissassemble the windoor assembly.")
					playsound(loc, 'sound/items/Welder2.ogg', 25, 1)

					construction_busy = TRUE
					if(do_after(user, 40 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, src))
						construction_busy = FALSE
						if(QDELETED(src) || !welder.isOn())
							return
						to_chat(user, SPAN_NOTICE("你已拆解风门组件！"))
						deconstruct()
					construction_busy = FALSE
				else
					to_chat(user, SPAN_NOTICE("你需要更多焊料来拆解风门组件。"))
					return

			//Wrenching an unsecure assembly anchors it in place. Step 4 complete
			if(HAS_TRAIT(attacking_item, TRAIT_TOOL_WRENCH) && !anchored)
				var/area/area = get_area(attacking_item)
				if(!area.allow_construction)
					to_chat(user, SPAN_WARNING("[src]必须被固定在合适的表面上！"))
					return
				var/turf/open/turf = loc
				if(!(istype(turf) && turf.allow_construction))
					to_chat(user, SPAN_WARNING("[src]必须被固定在合适的表面上！"))
					return
				playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
				user.visible_message("[user]将风门组件固定在地板上。", "You start to secure the windoor assembly to the floor.")

				construction_busy = TRUE
				if(do_after(user, 40 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					construction_busy = FALSE
					if(QDELETED(src))
						return
					to_chat(user, SPAN_NOTICE("你已固定风门组件！"))
					anchored = TRUE
					if(secure)
						name = "固定已锚定的风门组件"
					else
						name = "已锚定的风门组件"
				construction_busy = FALSE

			//Unwrenching an unsecure assembly un-anchors it. Step 4 undone
			else if(HAS_TRAIT(attacking_item, TRAIT_TOOL_WRENCH) && anchored)
				playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
				user.visible_message("[user]解除了风门组件与地板的固定。", "You start to unsecure the windoor assembly to the floor.")

				construction_busy = TRUE
				if(do_after(user, 40 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					construction_busy = FALSE
					if(QDELETED(src))
						return
					to_chat(user, SPAN_NOTICE("你已解除了风门组件的固定！"))
					anchored = FALSE
					if(secure)
						name = "固定风门组件"
					else
						name = "风门组件"
				construction_busy = FALSE

			//Adding plasteel makes the assembly a secure windoor assembly. Step 2 (optional) complete.
			else if(istype(attacking_item, /obj/item/stack/rods) && !secure)
				var/obj/item/stack/rods/rods = attacking_item
				if(rods.get_amount() < 4)
					to_chat(user, SPAN_WARNING("你需要更多金属杆来完成此操作。"))
					return
				to_chat(user, SPAN_NOTICE("你开始用金属杆加固风门。"))

				construction_busy = TRUE
				if(do_after(user, 40 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD) && !secure)
					if(rods.use(4))
						to_chat(user, SPAN_NOTICE("你加固了风门。"))
						secure = "secure_"
						if(anchored)
							name = "固定已锚定的风门组件"
						else
							name = "固定风门组件"
				construction_busy = FALSE

			//Adding cable to the assembly. Step 5 complete.
			else if(istype(attacking_item, /obj/item/stack/cable_coil) && anchored)
				user.visible_message("[user]给风门组件接线。", "You start to wire the windoor assembly.")

				var/obj/item/stack/cable_coil/coil = attacking_item
				construction_busy = TRUE
				if(do_after(user, 40 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					if(coil.use(1))
						to_chat(user, SPAN_NOTICE("你给风门接好了线！"))
						state = WINDOOR_STATE_02
						if(secure)
							name = "固定已接线的风门组件"
						else
							name = "已接线的风门组件"
				construction_busy = FALSE
			else
				. = ..()

		if(WINDOOR_STATE_02)
			//Removing wire from the assembly. Step 5 undone.
			if(HAS_TRAIT(attacking_item, TRAIT_TOOL_WIRECUTTERS) && !electronics)
				playsound(loc, 'sound/items/Wirecutter.ogg', 25, 1)
				user.visible_message("[user]切断了风门组件的电线。", "You start to cut the wires from airlock assembly.")

				construction_busy = TRUE
				if(do_after(user, 40 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					construction_busy = FALSE
					if(QDELETED(src))
						return

					to_chat(user, SPAN_NOTICE("你切断了风门的电线！"))
					new/obj/item/stack/cable_coil(get_turf(user), 1)
					state = WINDOOR_STATE_01
					if(secure)
						name = "固定已锚定的风门组件"
					else
						name = "已锚定的风门组件"
				construction_busy = FALSE

			//Adding airlock electronics for access. Step 6 complete.
			else if(istype(attacking_item, /obj/item/circuitboard/airlock))
				var/obj/item/circuitboard/airlock/board = attacking_item
				if(board.fried)
					return
				playsound(loc, 'sound/items/Screwdriver.ogg', 25, 1)
				user.visible_message("[user]将电子元件安装到风门组件中。", "You start to install electronics into the airlock assembly.")

				construction_busy = TRUE
				if(do_after(user, 40 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					construction_busy = FALSE
					if(QDELETED(src))
						return

					user.drop_held_item()
					attacking_item.forceMove(src)
					to_chat(user, SPAN_NOTICE("你已安装好风门电子元件！"))
					name = "接近完成的风门组件"
					electronics = attacking_item
				else
					construction_busy = FALSE
					attacking_item.forceMove(loc)

			//Screwdriver to remove airlock electronics. Step 6 undone.
			else if(HAS_TRAIT(attacking_item, TRAIT_TOOL_SCREWDRIVER) && electronics)
				playsound(loc, 'sound/items/Screwdriver.ogg', 25, 1)
				user.visible_message("[user]从风门组件中拆除了电子元件。", "You start to uninstall electronics from the airlock assembly.")

				construction_busy = TRUE
				if(do_after(user, 40 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					construction_busy = FALSE
					if(QDELETED(src) || !electronics)
						return
					to_chat(user, SPAN_NOTICE("你已拆除风门电子元件！"))
					if(secure)
						name = "固定已接线的风门组件"
					else
						name = "已接线的风门组件"
					var/obj/item/circuitboard/airlock/airlock_board = electronics
					electronics = null
					airlock_board.forceMove(loc)
				construction_busy = FALSE

			//Crowbar to complete the assembly, Step 7 complete.
			else if(HAS_TRAIT(attacking_item, TRAIT_TOOL_CROWBAR))
				if(!electronics)
					to_chat(user, SPAN_DANGER("该组件缺少电子元件。"))
					return
				close_browser(user, "windoor_access")
				playsound(loc, 'sound/items/Crowbar.ogg', 25, 1)
				user.visible_message("[user]将风门撬入框架。", "You start prying the windoor into the frame.")

				construction_busy = TRUE
				if(do_after(user, 40 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					construction_busy = FALSE
					if(QDELETED(src))
						return

					density = TRUE //Shouldn't matter but just incase
					to_chat(user, SPAN_NOTICE("你完成了风门的安装！"))

					if(secure)
						var/obj/structure/machinery/door/window/brigdoor/windoor = new /obj/structure/machinery/door/window/brigdoor(loc)
						if(facing == "l")
							windoor.icon_state = "leftsecureopen"
							windoor.base_state = "leftsecure"
						else
							windoor.icon_state = "rightsecureopen"
							windoor.base_state = "rightsecure"
						windoor.setDir(dir)
						windoor.density = FALSE

						if(electronics.one_access)
							windoor.req_access = null
							windoor.req_one_access = electronics.conf_access
						else
							windoor.req_access = electronics.conf_access
						windoor.electronics = electronics
						electronics.forceMove(windoor)
					else
						var/obj/structure/machinery/door/window/windoor = new /obj/structure/machinery/door/window(loc)
						if(facing == "l")
							windoor.icon_state = "leftopen"
							windoor.base_state = "left"
						else
							windoor.icon_state = "rightopen"
							windoor.base_state = "right"
						windoor.setDir(dir)
						windoor.density = FALSE

						if(electronics.one_access)
							windoor.req_access = null
							windoor.req_one_access = electronics.conf_access
						else
							windoor.req_access = electronics.conf_access
						windoor.electronics = electronics
						electronics.forceMove(windoor)


					qdel(src)
				construction_busy = FALSE

			else
				. = ..()

	//Update to reflect changes(if applicable)
	update_icon()

/obj/structure/windoor_assembly/deconstruct(disassembled = TRUE)
	if(disassembled)
		new /obj/item/stack/sheet/glass/reinforced(get_turf(src), 5)
		if(secure)
			new /obj/item/stack/rods(get_turf(src), 4)
	return ..()

//Rotates the windoor assembly clockwise
/obj/structure/windoor_assembly/verb/revrotate()
	set name = "Rotate Windoor Assembly"
	set category = "Object"
	set src in oview(1)

	if(anchored)
		to_chat(usr, "它已固定在地板上，因此你无法旋转它！")
		return
	setDir(turn(dir, 270))
	update_icon()
	return

//Flips the windoor assembly, determines whather the door opens to the left or the right
/obj/structure/windoor_assembly/verb/flip()
	set name = "Flip Windoor Assembly"
	set category = "Object"
	set src in oview(1)

	if(facing == "l")
		to_chat(usr, "风门现在将向右滑动。")
		facing = "r"
	else
		facing = "l"
		to_chat(usr, "风门现在将向左滑动。")

	update_icon()
	return
