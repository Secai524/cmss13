/obj/structure/barricade/plasteel
	name = "折叠式塑钢路障"
	desc = "一种由塑钢板制成的非常坚固的路障，是防御工事的巅峰之作。使用喷灯进行修理。可以翻倒以开辟通道。"
	icon_state = "plasteel_closed_0"
	health = 800
	maxhealth = 800
	burn_multiplier = 1.15
	brute_multiplier = 1
	crusher_resistant = TRUE
	force_level_absorption = 20
	stack_type = /obj/item/stack/sheet/plasteel
	debris = list(/obj/item/stack/sheet/plasteel)
	stack_amount = 8
	destroyed_stack_amount = 4
	barricade_hitsound = 'sound/effects/metalhit.ogg'
	barricade_type = "plasteel"
	density = FALSE
	closed = TRUE
	can_wire = TRUE
	repair_materials = list("plasteel" = 0.3)

	var/build_state = BARRICADE_BSTATE_SECURED //Look at __game.dm for barricade defines
	/// Delay to apply tools to prevent spamming
	var/tool_cooldown = 0
	/// Standard busy check
	var/busy = FALSE
	var/linked = 0
	var/recentlyflipped = FALSE
	var/hasconnectionoverlay = TRUE
	var/linkable = TRUE
	welder_lower_damage_limit = BARRICADE_DMG_HEAVY

/obj/structure/barricade/plasteel/update_icon()
	..()
	if(linked)
		for(var/direction in GLOB.cardinals)
			for(var/obj/structure/barricade/plasteel/cade in get_step(src, direction))
				if(((dir & (NORTH|SOUTH) && get_dir(src, cade) & (EAST|WEST)) || (dir & (EAST|WEST) && get_dir(src, cade) & (NORTH|SOUTH))) && dir == cade.dir && cade.linked && cade.closed == src.closed && hasconnectionoverlay)
					if(closed)
						overlays += image('icons/obj/structures/barricades.dmi', icon_state = "[src.barricade_type]_closed_connection_[get_dir(src, cade)]")
					else
						overlays += image('icons/obj/structures/barricades.dmi', icon_state = "[src.barricade_type]_connection_[get_dir(src, cade)]")
					continue


/obj/structure/barricade/plasteel/handle_barrier_chance(mob/living/M)
	if(!closed) // Closed = gate down for plasteel for some reason
		return ..()
	else
		return FALSE

/obj/structure/barricade/plasteel/get_examine_text(mob/user)
	. = ..()

	switch(build_state)
		if(BARRICADE_BSTATE_SECURED)
			. += SPAN_INFO("The protection panel is still tightly screwed in place.")
		if(BARRICADE_BSTATE_UNSECURED)
			. += SPAN_INFO("The protection panel has been removed, you can see the anchor bolts.")
		if(BARRICADE_BSTATE_MOVABLE)
			. += SPAN_INFO("The protection panel has been removed and the anchor bolts loosened. It's ready to be taken apart.")

/obj/structure/barricade/plasteel/try_weld_cade(obj/item/item, mob/user, repeat = TRUE, skip_check = FALSE)
	busy = TRUE
	..()
	busy = FALSE

/obj/structure/barricade/plasteel/can_weld(obj/item/item, mob/user, silent)
	if(!..())
		return FALSE

	if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_NOVICE))
		if(!silent)
			to_chat(user, SPAN_WARNING("你没受过维修[src]的训练..."))
		return FALSE

	return TRUE

/obj/structure/barricade/plasteel/attackby(obj/item/item, mob/user)
	if(iswelder(item))
		try_weld_cade(item, user)
		return

	if(try_nailgun_usage(item, user))
		return

	for(var/obj/effect/xenomorph/acid/A in src.loc)
		if(A.acid_t == src)
			to_chat(user, "你无法靠近，它正在融化！")
			return

	switch(build_state)
		if(BARRICADE_BSTATE_SECURED) //Fully constructed step. Use screwdriver to remove the protection panels to reveal the bolts
			if(HAS_TRAIT(item, TRAIT_TOOL_SCREWDRIVER))
				if(busy || tool_cooldown > world.time)
					return
				tool_cooldown = world.time + 10
				if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
					to_chat(user, SPAN_WARNING("你没受过组装[src]的训练..."))
					return

				for(var/obj/structure/barricade/B in loc)
					if(B != src && B.dir == dir)
						to_chat(user, SPAN_WARNING("这里已经有一个路障了。"))
						return
				if(!do_after(user, 10, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, src))
					return
				user.visible_message(SPAN_NOTICE("[user]移除了[src]的保护面板。"),
				SPAN_NOTICE("You remove [src]'s protection panels, exposing the anchor bolts."))
				playsound(src.loc, 'sound/items/Screwdriver.ogg', 25, 1)
				build_state = BARRICADE_BSTATE_UNSECURED
				return

			if(HAS_TRAIT(item, TRAIT_TOOL_CROWBAR))
				if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
					to_chat(user, SPAN_WARNING("你没受过改装[src]的训练..."))
					return
				playsound(src.loc, 'sound/items/Crowbar.ogg', 25, 1)
				if(linked)
					user.visible_message(SPAN_NOTICE("[user]移除了[src]上的连接。"),
					SPAN_NOTICE("You remove the linking on [src]."))
				else if(linkable)
					user.visible_message(SPAN_NOTICE("[user]为[src]设置了连接点。"),
					SPAN_NOTICE("You set up [src] for linking."))
				else
					to_chat(user, SPAN_WARNING("[src]没有连接点..."))
					return
				linked = !linked
				for(var/direction in GLOB.cardinals)
					for(var/obj/structure/barricade/plasteel/cade in get_step(src, direction))
						cade.update_icon()
				update_icon()

		if(BARRICADE_BSTATE_UNSECURED) //Protection panel removed step. Screwdriver to put the panel back, wrench to unsecure the anchor bolts
			if(HAS_TRAIT(item, TRAIT_TOOL_SCREWDRIVER))
				if(busy || tool_cooldown > world.time)
					return
				tool_cooldown = world.time + 10
				if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
					to_chat(user, SPAN_WARNING("你没受过组装[src]的训练..."))
					return
				if(!do_after(user, 10, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, src))
					return
				user.visible_message(SPAN_NOTICE("[user]将[src]的保护面板装回原位。"),
				SPAN_NOTICE("You set [src]'s protection panel back."))
				playsound(src.loc, 'sound/items/Screwdriver.ogg', 25, 1)
				build_state = BARRICADE_BSTATE_SECURED
				return

			if(HAS_TRAIT(item, TRAIT_TOOL_WRENCH))
				if(busy || tool_cooldown > world.time)
					return
				tool_cooldown = world.time + 10
				if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
					to_chat(user, SPAN_WARNING("你没受过组装[src]的训练..."))
					return
				if(!do_after(user, 10, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, src))
					return
				user.visible_message(SPAN_NOTICE("[user]拧松了[src]的锚定螺栓。"),
				SPAN_NOTICE("You loosen [src]'s anchor bolts."))
				playsound(src.loc, 'sound/items/Ratchet.ogg', 25, 1)
				anchored = FALSE
				build_state = BARRICADE_BSTATE_MOVABLE
				update_icon() //unanchored changes layer
				return

		if(BARRICADE_BSTATE_MOVABLE) //Anchor bolts loosened step. Apply crowbar to unseat the panel and take apart the whole thing. Apply wrench to rescure anchor bolts
			if(HAS_TRAIT(item, TRAIT_TOOL_WRENCH))
				if(busy || tool_cooldown > world.time)
					return
				tool_cooldown = world.time + 10
				if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
					to_chat(user, SPAN_WARNING("你没受过组装[src]的训练..."))
					return
				var/area/area = get_area(src)
				if(!area.allow_construction)
					to_chat(user, SPAN_WARNING("[src]必须被固定在合适的表面上！"))
					return
				if(area.flags_area & AREA_NOSECURECADES)
					to_chat(user, SPAN_WARNING("[src]必须被固定在合适的表面上！"))
					return
				var/turf/open/T = loc
				if(!(istype(T) && T.allow_construction))
					to_chat(user, SPAN_WARNING("[src]必须被固定在合适的表面上！"))
					return
				if(!do_after(user, 10, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, src))
					return
				user.visible_message(SPAN_NOTICE("[user]拧紧了[src]的锚定螺栓。"),
				SPAN_NOTICE("You secure [src]'s anchor bolts."))
				playsound(src.loc, 'sound/items/Ratchet.ogg', 25, 1)
				anchored = TRUE
				build_state = BARRICADE_BSTATE_UNSECURED
				update_icon() //unanchored changes layer
				return

			if(HAS_TRAIT(item, TRAIT_TOOL_CROWBAR))
				if(busy || tool_cooldown > world.time)
					return
				tool_cooldown = world.time + 10
				if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
					to_chat(user, SPAN_WARNING("你没受过组装[src]的训练..."))
					return
				user.visible_message(SPAN_NOTICE("[user]开始拆卸[src]的面板。"),
				SPAN_NOTICE("You start unseating [src]'s panels."))
				playsound(src.loc, 'sound/items/Crowbar.ogg', 25, 1)
				busy = TRUE
				if(do_after(user, 50 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, src))
					user.visible_message(SPAN_NOTICE("[user]拆开了[src]的面板。"),
					SPAN_NOTICE("You take [src]'s panels apart."))
					playsound(loc, 'sound/items/Deconstruct.ogg', 25, 1)
					deconstruct(TRUE) //Note : Handles deconstruction too !
				busy = FALSE
				return

	return ..()

/obj/structure/barricade/plasteel/attack_hand(mob/user as mob)
	if(isxeno(user))
		return

	if(closed)
		if(recentlyflipped)
			to_chat(user, SPAN_NOTICE("[src]刚刚被翻转，操作过快！"))
			return
		user.visible_message(SPAN_NOTICE("[user]将[src]翻下关闭。"),
		SPAN_NOTICE("You flip [src] closed."))
		open(src)
		recentlyflipped = TRUE
		spawn(10)
			if(istype(src, /obj/structure/barricade/plasteel))
				recentlyflipped = FALSE

	else
		if(recentlyflipped)
			to_chat(user, SPAN_NOTICE("[src]刚刚被翻转，操作过快！"))
			return
		user.visible_message(SPAN_NOTICE("[user]将[src]翻开。"),
		SPAN_NOTICE("You flip [src] open."))
		close(src)
		recentlyflipped = TRUE
		spawn(10)
			if(istype(src, /obj/structure/barricade/plasteel))
				recentlyflipped = FALSE

/obj/structure/barricade/plasteel/proc/open(obj/structure/barricade/plasteel/origin)
	if(!closed)
		return
	playsound(src.loc, 'sound/items/Ratchet.ogg', 25, 1)
	closed = 0
	density = TRUE
	if(linked)
		for(var/direction in GLOB.cardinals)
			for(var/obj/structure/barricade/plasteel/cade in get_step(src, direction))
				if(((dir & (NORTH|SOUTH) && get_dir(src, cade) & (EAST|WEST)) || (dir & (EAST|WEST) && get_dir(src, cade) & (NORTH|SOUTH))) && dir == cade.dir && cade != origin && cade.linked)
					cade.open(src)
	update_icon()

/obj/structure/barricade/plasteel/proc/close(obj/structure/barricade/plasteel/origin)
	if(closed)
		return
	playsound(src.loc, 'sound/items/Ratchet.ogg', 25, 1)
	closed = 1
	density = FALSE
	if(linked)
		for(var/direction in GLOB.cardinals)
			for(var/obj/structure/barricade/plasteel/cade in get_step(src, direction))
				if(((dir & (NORTH|SOUTH) && get_dir(src, cade) & (EAST|WEST)) || (dir & (EAST|WEST) && get_dir(src, cade) & (NORTH|SOUTH))) && dir == cade.dir && cade != origin && cade.linked)
					cade.close(src)
	update_icon()


/obj/structure/barricade/plasteel/wired/New()
	can_wire = FALSE
	is_wired = TRUE
	climbable = FALSE
	update_icon()
	return ..()

/obj/structure/barricade/plasteel/wired/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	flags_can_pass_front_temp &= ~PASS_OVER_THROW_MOB
	flags_can_pass_behind_temp &= ~PASS_OVER_THROW_MOB

/obj/structure/barricade/plasteel/metal
	name = "折叠式金属路障"
	desc = "一种由金属制成的折叠路障，比普通金属路障稍弱。使用喷灯修复。可以翻下以开辟通道。"
	icon_state = "folding_metal_closed_0"
	health = 400
	maxhealth = 400
	force_level_absorption = 10
	stack_type = /obj/item/stack/sheet/metal
	debris = list(/obj/item/stack/sheet/metal)
	stack_amount = 6
	destroyed_stack_amount = 3
	barricade_type = "folding_metal"
	repair_materials = list("metal" = 0.3, "plasteel" = 0.45)

	linkable = FALSE
