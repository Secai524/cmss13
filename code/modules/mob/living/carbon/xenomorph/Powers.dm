/mob/living/carbon/xenomorph/proc/build_resin(atom/target, thick = FALSE, message = TRUE, use_plasma = TRUE, add_build_mod = 1)
	if(!selected_resin)
		return SECRETE_RESIN_FAIL

	var/datum/resin_construction/resin_construct = GLOB.resin_constructions_list[selected_resin]

	var/total_resin_cost = XENO_RESIN_BASE_COST + resin_construct.cost // Live, diet, shit code, repeat

	if(resin_construct.scaling_cost && use_plasma)
		var/area/target_area = get_area(target)
		if(target_area && target_area.openable_turf_count)
			var/density_ratio = target_area.current_resin_count / target_area.openable_turf_count
			if(density_ratio > 0.4)
				total_resin_cost = ceil(total_resin_cost * (density_ratio + 0.35) * 2)
				if(total_resin_cost > plasma_max && (XENO_RESIN_BASE_COST + resin_construct.cost) < plasma_max)
					total_resin_cost = plasma_max

	if(action_busy && !can_stack_builds)
		return SECRETE_RESIN_FAIL
	if(!check_state())
		return SECRETE_RESIN_FAIL
	if(use_plasma && !check_plasma(total_resin_cost))
		return SECRETE_RESIN_FAIL
	if(SSinterior.in_interior(src))
		to_chat(src, SPAN_XENOWARNING("这里空间太狭窄，无法建造。"))
		return SECRETE_RESIN_FAIL

	if(resin_construct.max_per_xeno != RESIN_CONSTRUCTION_NO_MAX)
		var/current_amount = length(built_structures[resin_construct.build_path])
		if(current_amount >= resin_construct.max_per_xeno)
			to_chat(src, SPAN_XENOWARNING("我们已经建造了最大数量的结构！"))
			return SECRETE_RESIN_FAIL

	var/turf/current_turf = get_turf(target)

	if(extra_build_dist != IGNORE_BUILD_DISTANCE && get_dist(src, target) > src.caste.max_build_dist + extra_build_dist) // Hivelords and eggsac carriers have max_build_dist of 1, drones and queens 0
		to_chat(src, SPAN_XENOWARNING("距离太远，无法建造！"))
		return SECRETE_RESIN_FAIL
	else if(thick) //hivelords can thicken existing resin structures.
		var/thickened = FALSE
		if(istype(target, /turf/closed/wall/resin))
			var/turf/closed/wall/resin/wall = target

			if(istype(target, /turf/closed/wall/resin/weak))
				to_chat(src, SPAN_XENOWARNING("[wall]过于脆弱，无法加固。"))
				return SECRETE_RESIN_FAIL

			for(var/datum/effects/xeno_structure_reinforcement/sf in wall.effects_list)
				to_chat(src, SPAN_XENOWARNING("多余的树脂阻碍了我们加固[wall]。请等待其消退。"))
				return SECRETE_RESIN_FAIL

			if (wall.hivenumber != hivenumber)
				to_chat(src, SPAN_XENOWARNING("[wall]不属于你的巢穴！"))
				return SECRETE_RESIN_FAIL

			if(wall.type == /turf/closed/wall/resin)
				wall.ChangeTurf(/turf/closed/wall/resin/thick)
				total_resin_cost = XENO_THICKEN_WALL_COST
			else if(wall.type == /turf/closed/wall/resin/membrane)
				wall.ChangeTurf(/turf/closed/wall/resin/membrane/thick)
				total_resin_cost = XENO_THICKEN_MEMBRANE_COST
			else
				to_chat(src, SPAN_XENOWARNING("[wall]无法被加厚。"))
				return SECRETE_RESIN_FAIL
			thickened = TRUE

		else if(istype(target, /obj/structure/mineral_door/resin))
			var/obj/structure/mineral_door/resin/door = target
			if (door.hivenumber != hivenumber)
				to_chat(src, SPAN_XENOWARNING("[door]不属于你的巢穴！"))
				return SECRETE_RESIN_FAIL

			for(var/datum/effects/xeno_structure_reinforcement/sf in door.effects_list)
				to_chat(src, SPAN_XENOWARNING("多余的树脂阻碍了我们加固[door]。请等待其消退。"))
				return SECRETE_RESIN_FAIL

			if(door.hardness == 1.5) //non thickened
				var/oldloc = door.loc
				qdel(door)
				new /obj/structure/mineral_door/resin/thick (oldloc, door.hivenumber)
				total_resin_cost = XENO_THICKEN_DOOR_COST
			else
				to_chat(src, SPAN_XENOWARNING("[door]无法被加厚。"))
				return SECRETE_RESIN_FAIL
			thickened = TRUE

		if(thickened)
			if(message)
				visible_message(SPAN_XENONOTICE("[src]反刍出粘稠物质，加厚了[target]。"),
					SPAN_XENONOTICE("We regurgitate some resin and thicken [target], using [total_resin_cost] plasma."), null, 5)
				if(use_plasma)
					use_plasma(total_resin_cost)
				playsound(loc, "alien_resin_build", 25)
			target.add_hiddenprint(src) //so admins know who thickened the walls
			return TRUE

	var/wait_time = resin_construct.build_time * caste.build_time_mult * add_build_mod

	var/obj/effect/alien/weeds/alien_weeds = current_turf.weeds
	if(!alien_weeds || alien_weeds.secreting)
		return SECRETE_RESIN_FAIL

	for(var/obj/effect/alien/resin/design/speed_node/sn in current_turf.contents)
		wait_time -= ((resin_construct.build_time * caste.build_time_mult) / 2)

	for(var/obj/effect/alien/resin/design/cost_node/cn in current_turf.contents)
		total_resin_cost -= (total_resin_cost / 2)

	if(!resin_construct.can_build_here(current_turf, src))
		return SECRETE_RESIN_FAIL

	var/obj/warning
	var/succeeded = TRUE
	if(resin_construct.build_overlay_icon)
		warning = new resin_construct.build_overlay_icon(current_turf)

	if(resin_construct.build_animation_effect)
		warning = new resin_construct.build_animation_effect(current_turf)

		switch(wait_time)
			if(1 SECONDS)
				warning.icon_state = "[warning.icon_state]Fast"
			if(4 SECONDS)
				warning.icon_state = "[warning.icon_state]Slow"

		update_icons(warning)

	alien_weeds.secreting = TRUE
	alien_weeds.update_icon()

	if(!do_after(src, wait_time, INTERRUPT_NO_NEEDHAND|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, alien_weeds))
		succeeded = FALSE

	qdel(warning)

	if(!QDELETED(alien_weeds))
		alien_weeds.secreting = FALSE
		alien_weeds.update_icon()

	if(!succeeded)
		return SECRETE_RESIN_INTERRUPT

	if(maybe_convert_to_weedbound(current_turf, resin_construct, thick))
		if(use_plasma)
			use_plasma(total_resin_cost)
		if(message)
			visible_message(SPAN_XENONOTICE("[src]反刍出粘稠物质，并将其塑造成\a [resin_construct.construction_name]！"),
				SPAN_XENONOTICE("We regurgitate some resin and shape it into \a [resin_construct.construction_name][use_plasma ? " at the cost of a total [total_resin_cost] plasma" : ""]."), null, 5)
			playsound(loc, "alien_resin_build", 25)
		return SECRETE_RESIN_SUCCESS

	if(!resin_construct.can_build_here(current_turf, src))
		return SECRETE_RESIN_FAIL

	if(use_plasma)
		use_plasma(total_resin_cost)
	if(message)
		visible_message(SPAN_XENONOTICE("[src]反刍出粘稠物质，并将其塑造成\a [resin_construct.construction_name]！"),
			SPAN_XENONOTICE("We regurgitate some resin and shape it into \a [resin_construct.construction_name][use_plasma ? " at the cost of a total [total_resin_cost] plasma" : ""]."), null, 5)
		playsound(loc, "alien_resin_build", 25)

	var/atom/new_resin = resin_construct.build(current_turf, hivenumber, src)
	if(succeeded)
		for(var/obj/effect/alien/resin/design/node in current_turf)
			qdel(node)
	if(resin_construct.max_per_xeno != RESIN_CONSTRUCTION_NO_MAX)
		LAZYADD(built_structures[resin_construct.build_path], new_resin)
		RegisterSignal(new_resin, COMSIG_PARENT_QDELETING, PROC_REF(remove_built_structure))

	new_resin.add_hiddenprint(src) //so admins know who placed it

	var/area/resin_area = get_area(new_resin)
	if(resin_area && resin_area.linked_lz)
		new_resin.AddComponent(/datum/component/resin_cleanup)

	if(istype(new_resin, /turf/closed))
		for(var/mob/living/carbon/human/enclosed_human in new_resin.contents)
			if(enclosed_human.stat == DEAD && enclosed_human.is_revivable(TRUE))
				msg_admin_niche("[src.ckey]/([src]) has built a closed resin structure, [new_resin.name], on top of a dead human, [enclosed_human.ckey]/([enclosed_human]), at [new_resin.x],[new_resin.y],[new_resin.z] [ADMIN_JMP(new_resin)]")

	return SECRETE_RESIN_SUCCESS

/mob/living/carbon/xenomorph/proc/maybe_convert_to_weedbound(turf/current_turf, datum/resin_construction/resin_construct, thick = FALSE)
	if(current_turf.is_weedable != SEMI_WEEDABLE)
		return FALSE

	var/obj/effect/alien/resin/design/the_node = null
	for(var/obj/effect/alien/resin/design/node in current_turf)
		the_node = node
		break

	if(!the_node)
		return FALSE

	if(istype(resin_construct, /datum/resin_construction/resin_turf/wall))
		if(thick)
			current_turf.PlaceOnTop(/turf/closed/wall/resin/weedbound/thick)
		else
			current_turf.PlaceOnTop(/turf/closed/wall/resin/weedbound/normal)

		qdel(the_node)
		return TRUE

	else if(istype(resin_construct, /datum/resin_construction/resin_obj/door))
		if(thick)
			new /obj/structure/mineral_door/resin/weedbound/thick(current_turf)
		else
			new /obj/structure/mineral_door/resin/weedbound/normal(current_turf)

		qdel(the_node)
		return TRUE

	to_chat(src, SPAN_XENOWARNING("此节点仅接受坚固的墙壁或门。"))
	return FALSE

/mob/living/carbon/xenomorph/proc/remove_built_structure(atom/A)
	SIGNAL_HANDLER
	LAZYREMOVE(built_structures[A.type], A)
	if(!built_structures[A.type])
		built_structures -= A.type

/mob/living/carbon/xenomorph/proc/place_construction(turf/current_turf, datum/construction_template/xenomorph/structure_template)
	if(!structure_template || !check_state() || action_busy)
		return

	var/current_area_name = get_area_name(current_turf)
	var/obj/effect/alien/resin/construction/new_structure = new(current_turf, hive)
	new_structure.set_template(structure_template)
	hive.add_construction(new_structure)

	var/max_constructions = hive.hive_structures_limit[structure_template.name]
	var/remaining_constructions = max_constructions - hive.get_structure_count(structure_template.name)
	visible_message(SPAN_XENONOTICE("粘稠物质从地面涌出，塑造成\a [new_structure]。"),
		SPAN_XENONOTICE("We designate a new [structure_template] construction. ([remaining_constructions]/[max_constructions] remaining)"), null, 5)
	playsound(new_structure, "alien_resin_build", 25)

	if(hive.living_xeno_queen)
		xeno_message("Hive: A new <b>[structure_template]<b> construction has been designated at [sanitize_area(current_area_name)]!", 3, hivenumber)

/mob/living/carbon/xenomorph/proc/make_marker(turf/target_turf)
	if(!target_turf)
		return FALSE
	if(istype(target_turf, /turf/open/space/transit))
		to_chat(src, SPAN_NOTICE("那有什么意义？！"))
		return
	var/found_weeds = FALSE
	if(!selected_mark)
		to_chat(src, SPAN_NOTICE("你必须先为标记赋予意义。"))
		hive.mark_ui.open_mark_menu(src)
		return FALSE

	if(!SSmapping.same_z_map(z, target_turf.loc.z))
		to_chat(src, SPAN_XENOWARNING("我们的精神无法触及那么远。"))
		return

	if(!(istype(target_turf)) || target_turf.density)
		return FALSE
	for(var/atom/movable/AM  in target_turf.contents)
		if(istype(AM, /obj/effect/alien/weeds))
			found_weeds = TRUE
		if(AM.density || istype(AM, /obj/effect/alien/resin))
			to_chat(src, SPAN_XENONOTICE("那里没有足够的空间放置树脂标记。"))
			return FALSE

	var/obj/effect/alien/resin/marker/NM = new /obj/effect/alien/resin/marker(target_turf, src)
	playsound(target_turf, "alien_resin_build", 25)

	if(!found_weeds)
		to_chat(src, SPAN_XENOMINORWARNING("我们在没有菌毯的地面上制作了树脂标记，没有菌毯它很快就会损坏。"))

	if(isqueen(src))
		NM.color = "#7a21c4"
	else
		NM.color = "#db6af1"
	if(hive.living_xeno_queen)
		var/current_area_name = get_area_name(target_turf)

		for(var/mob/living/carbon/xenomorph/X in hive.totalXenos)
			to_chat(X, SPAN_XENOANNOUNCE("[src.name]已宣告：[NM.mark_meaning.desc]，位于[sanitize_area(current_area_name)]！(<a href='byond://?src=\ref[X];overwatch=1;target=\ref[NM]'>监控</a>) (<a href='byond://?src=\ref[X];track=1;target=\ref[NM]'>追踪</a>)"))
			//this is killing the tgui chat and I don't know why
	return TRUE
