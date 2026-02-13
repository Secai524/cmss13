/datum/xeno_strain/designer
	name = HIVELORD_DESIGNER
	description = "You give up direct resin building, lose some plasma and health, but gain stronger pheromones and longer vision. You can place up to 36 design nodes: optimized nodes boost building by 50%, flexible nodes reduce plasma cost by 50%, and construct nodes allow anyone to donate plasma to build weedbound resin walls or doors, even on surfaces where we can't normally build. Some castes like hivelord, carrier, burrower and queen can stimulate construct nodes to make thick weedbound variant including plasma fruit. You can mark nodes as walls or doors, remotely thicken structures, control doors, and remove nodes. Using Greater Resin Surge turns all design nodes into weaker reflective walls for temporary hive defense. Your tackle is slightly stronger, causing longer knockdowns."
	flavor_description = "You are hive's designer, while you no longer build with your own claws, your influence shapes the very foundation of the swarm, allowing it to expand and adapt beyond limits."
	icon_state_prefix = "Designer"

	actions_to_remove = list(
		/datum/action/xeno_action/activable/secrete_resin/hivelord,
		/datum/action/xeno_action/onclick/choose_resin,
		/datum/action/xeno_action/activable/transfer_plasma/hivelord,
		/datum/action/xeno_action/active_toggle/toggle_speed,
		/datum/action/xeno_action/active_toggle/toggle_meson_vision,
	)
	actions_to_add = list(
		/datum/action/xeno_action/onclick/change_design, //macro 2, macro 1 is for weeds
		/datum/action/xeno_action/activable/place_design, //macro 3
		/datum/action/xeno_action/onclick/toggle_design_icons, //macro 4
		/datum/action/xeno_action/activable/greater_resin_surge, //macro 5
		/datum/action/xeno_action/onclick/toggle_long_range/designer,
		/datum/action/xeno_action/active_toggle/toggle_speed,
		/datum/action/xeno_action/active_toggle/toggle_meson_vision,
	)

	behavior_delegate_type = /datum/behavior_delegate/hivelord_designer

/datum/xeno_strain/designer/apply_strain(mob/living/carbon/xenomorph/hivelord/hivelord)
	hivelord.available_design = list(
		/obj/effect/alien/resin/design/speed_node,
		/obj/effect/alien/resin/design/cost_node,
		/obj/effect/alien/resin/design/construct_node,
		/obj/effect/alien/resin/design/upgrade,
		/obj/effect/alien/resin/design/remove,
	)
	hivelord.selected_design = /obj/effect/alien/resin/design/speed_node
	hivelord.selected_design_mark = /datum/design_mark/resin_wall
	hivelord.plasma_types = list(PLASMA_NUTRIENT, PLASMA_PHEROMONE)
	hivelord.max_design_nodes = 36
	hivelord.viewsize = WHISPERER_VIEWRANGE
	hivelord.health_modifier -= XENO_HEALTH_MOD_LARGE
	hivelord.phero_modifier += XENO_PHERO_MOD_LARGE
	hivelord.speed_modifier += XENO_SPEED_TIER_3 //Lost 30% plasma in sac, you lost some weight
	hivelord.plasmapool_modifier = 0.7 //-30% plasma pool
	hivelord.tacklestrength_min = 5
	hivelord.tacklestrength_max = 6
	hivelord.recalculate_everything()

	// Also change the primacy value for our abilities (because we want the same place but have another primacy ability)
	for(var/datum/action/xeno_action/action in hivelord.actions)
		if(istype(action, /datum/action/xeno_action/activable/place_construction))
			action.ability_primacy = XENO_NOT_PRIMARY_ACTION
			continue
		if(istype(action, /datum/action/xeno_action/active_toggle/toggle_meson_vision))
			action.ability_primacy = XENO_NOT_PRIMARY_ACTION
			continue
		if(istype(action, /datum/action/xeno_action/active_toggle/toggle_speed))
			action.ability_primacy = XENO_NOT_PRIMARY_ACTION
			continue

/datum/behavior_delegate/hivelord_designer
	name = "巢穴领主建造者行为代理"

/datum/behavior_delegate/hivelord_designer/append_to_stat()
	. = list()
	. += "Nodes sustained: [length(bound_xeno.current_design)] / [bound_xeno.max_design_nodes]"

// ""animations"" (effects)
/obj/effect/resin_construct/fastweak
	icon_state = "WeakReflectiveFast"

/obj/effect/resin_construct/speed_node
	icon_state = "speednode"

/obj/effect/resin_construct/cost_node
	icon_state = "costnode"

/obj/effect/resin_construct/construct_node
	icon_state = "constructnode"

/obj/effect/resin_construct/construct_doorslow
	icon_state = "DoorConstrucSlow"

/obj/effect/resin_construct/construct_wallslow
	icon_state = "WeakConstructSlow"

/obj/effect/resin_construct/thickfast
	icon_state = "ThickConstructFast"

/obj/effect/resin_construct/thickdoorfast
	icon_state = "ThickDoorConstructFast"
	layer = FIREDOOR_CLOSED_LAYER

/obj/effect/resin_construct/transparent/thickfast
	icon_state = "WeakTransparentConstructFast"

//Marks

/datum/design_mark
	var/name = "xeno_declare"
	var/icon_state = "empty"
	var/desc = "Xenos make psychic markers with this meaning as positional lasting communication to eachother."

/datum/design_mark/resin_wall
	name = "树脂墙"
	desc = "在此处放置树脂墙！"
	icon_state = "mark_wall"

/datum/design_mark/resin_door
	name = "树脂门"
	desc = "在此处放置树脂门！"
	icon_state = "mark_door"

// Far-sight
/datum/action/xeno_action/onclick/toggle_long_range/designer
	handles_movement = FALSE
	should_delay = FALSE
	ability_primacy = XENO_NOT_PRIMARY_ACTION
	delay = 0

//////////////////////////
/// Designer... Paths. ///
//////////////////////////

/obj/effect/alien/resin/design
	name = "设计节点"
	desc = "一个奇怪的节点，看起来发生了变异。"
	icon = 'icons/mob/xenos/effects.dmi'
	icon_state = "static_speednode"
	density = FALSE
	opacity = FALSE
	layer = RESIN_UNDER_STRUCTURE_LAYER
	plane = FLOOR_PLANE
	health = HEALTH_RESIN_XENO_STICKY

	var/datum/design_mark/mark_meaning = /datum/design_mark/resin_wall
	var/mob/living/carbon/xenomorph/bound_xeno
	var/obj/effect/alien/weeds/bound_weed
	var/hivenumber = XENO_HIVE_NORMAL
	var/plasma_cost = 0

	var/image/choosenMark

/obj/effect/alien/resin/design/Initialize(mapload, obj/effect/alien/weeds/weeds, mob/living/carbon/xenomorph/xeno)
	if(!istype(xeno))
		return INITIALIZE_HINT_QDEL

	bound_xeno = xeno
	bound_weed = weeds
	hivenumber = xeno.hivenumber

	RegisterSignal(bound_weed, COMSIG_PARENT_QDELETING, PROC_REF(on_weed_expire))
	RegisterSignal(bound_xeno, COMSIG_PARENT_QDELETING, PROC_REF(on_xeno_expire))

	set_hive_data(src, hivenumber)
	. = ..()

	if(bound_weed.hivenumber != bound_xeno.hivenumber)
		qdel(src)

	if(xeno.selected_design_mark)
		mark_meaning = new xeno.selected_design_mark

	var/datum/hive_status/hive = GLOB.hive_datum[hivenumber]
	if(hive)
		hive.designer_marks += src
		if(mark_meaning)
			var/icon_state_to_use = get_marker_icon_state()
			if(icon_state_to_use)
				choosenMark = image(icon, src, icon_state_to_use, ABOVE_HUD_LAYER, "pixel_y" = 5)
				choosenMark.plane = ABOVE_HUD_PLANE
				choosenMark.appearance_flags = RESET_COLOR

				for(xeno in hive.totalXenos)
					if(xeno.client)
						xeno.hud_set_design_marks()
						refresh_marker()

/obj/effect/alien/resin/design/Destroy()
	var/datum/hive_status/hive = GLOB.hive_datum[hivenumber]
	if(hive)
		hive.designer_marks -= src
		for(var/mob/living/carbon/xenomorph/xeno in hive.totalXenos)
			if(xeno.client && choosenMark)
				xeno.client.images -= choosenMark
				xeno.hud_set_design_marks()

	if(!QDELETED(bound_xeno))
		bound_xeno.current_design.Remove(src)
	unregister_weed_expiration_signal_design()
	bound_xeno = null
	bound_weed = null
	choosenMark = null
	return ..()

/obj/effect/alien/resin/design/proc/refresh_marker()
	if(!choosenMark || !mark_meaning)
		return

	if(bound_xeno.selected_design_mark == /datum/design_mark/resin_wall || bound_xeno.selected_design_mark == /datum/design_mark/resin_door)
		choosenMark.icon_state = mark_meaning.icon_state

/obj/effect/alien/resin/design/proc/get_marker_icon_state()
	if(!mark_meaning)
		return null
	return mark_meaning.icon_state

/obj/effect/alien/resin/design/proc/on_weed_expire()
	SIGNAL_HANDLER
	qdel(src)

/obj/effect/alien/resin/design/proc/on_xeno_expire()
	SIGNAL_HANDLER
	qdel(src)

/obj/effect/alien/resin/design/proc/check_hivenumber_match()
	if(!bound_weed || !bound_xeno)
		visible_message(SPAN_XENOWARNING("节点颤动并衰变回菌毯。"))
		qdel(src)
	else if(bound_weed.hivenumber != bound_xeno.hivenumber)
		visible_message(SPAN_XENOWARNING("节点枯萎消失了。"))
		qdel(src)

/obj/effect/alien/resin/design/proc/unregister_weed_expiration_signal_design()
	if(bound_weed)
		UnregisterSignal(bound_weed, COMSIG_PARENT_QDELETING)

/obj/effect/alien/resin/design/proc/register_weed_expiration_signal_design(obj/effect/alien/weeds/new_weed)
	RegisterSignal(new_weed, COMSIG_PARENT_QDELETING, PROC_REF(on_weed_expire))
	bound_weed = new_weed
	check_hivenumber_match()

/obj/effect/alien/resin/design/proc/hud_set_queen_overwatch()
	return

/obj/effect/alien/resin/design/speed_node
	name = "设计优化节点 (50)"
	icon_state = "static_speednode"
	plasma_cost = 50

/obj/effect/alien/resin/design/speed_node/refresh_marker()
	if(!choosenMark || !mark_meaning)
		return

	if(bound_xeno.selected_design_mark == /datum/design_mark/resin_wall || bound_xeno.selected_design_mark == /datum/design_mark/resin_door)
		choosenMark.icon_state = mark_meaning.icon_state + "_speed"
	else
		..()

/obj/effect/alien/resin/design/speed_node/get_marker_icon_state()
	if(!mark_meaning)
		return null
	return mark_meaning.icon_state + "_speed"

/obj/effect/alien/resin/design/speed_node/get_examine_text(mob/user)
	. = ..()
	if(ishuman(user))
		. += SPAN_NOTICE("On closer examination, this node looks like it has a big green oozing bulb at its center, making the weeds under it twitch...")
	if(isxeno(user) || isobserver(user))
		. += SPAN_NOTICE("You sense that building on top of this node will speed up your construction speed by [SPAN_BOLDNOTICE("50%")].")

/obj/effect/alien/resin/design/cost_node
	name = "设计柔性节点 (60)"
	icon_state = "static_costnode"
	plasma_cost = 60

/obj/effect/alien/resin/design/cost_node/refresh_marker()
	if(!choosenMark || !mark_meaning)
		return

	if(bound_xeno.selected_design_mark == /datum/design_mark/resin_wall || bound_xeno.selected_design_mark == /datum/design_mark/resin_door)
		choosenMark.icon_state = mark_meaning.icon_state + "_cost"
	else
		..()

/obj/effect/alien/resin/design/cost_node/get_marker_icon_state()
	if(!mark_meaning)
		return null
	return mark_meaning.icon_state + "_cost"

/obj/effect/alien/resin/design/cost_node/get_examine_text(mob/user)
	. = ..()
	if(ishuman(user))
		. += SPAN_NOTICE("On closer examination, this node looks like its made of smaller blue bulbs grown together, making the weeds under them look soft and squishy.")
	if(isxeno(user) || isobserver(user))
		. += SPAN_NOTICE("You sense that building on top of this node will decrease plasma cost of basic resin structures by [SPAN_BOLDNOTICE("50%")].")

/obj/effect/alien/resin/design/construct_node
	name = "设计建造节点 (70)"
	icon_state = "static_constructnode"
	plasma_cost = 70
	var/plasma_donation = 70
	var/building = FALSE
	var/thick_build = FALSE
	var/obj/effect/resin_construct/build_overlay

/obj/effect/alien/resin/design/construct_node/Initialize(mapload)
	. = ..()
	var/area/area = get_area(src)
	if(area)
		if(area.linked_lz)
			AddComponent(/datum/component/resin_cleanup)
		area.current_resin_count++

/obj/effect/alien/resin/design/construct_node/proc/complete_construction(turf/Turf, design_mark, mob/living/carbon/xenomorph/xeno)
	if(QDELETED(src) || QDELETED(Turf))
		return

	if(build_overlay && !QDELETED(build_overlay))
		qdel(build_overlay)
		build_overlay = null

	building = FALSE

	if(istype(design_mark, /datum/design_mark/resin_wall))
		if(!istype(Turf, /turf/closed/wall))
			var/turf/placed
			if(thick_build)
				placed = Turf.PlaceOnTop(/turf/closed/wall/resin/weedbound/thick)
			else
				placed = Turf.PlaceOnTop(/turf/closed/wall/resin/weedbound/normal)

			var/turf/closed/wall/resin/Res = get_turf(Turf)
			if(istype(Res))
				Res.hivenumber = src.hivenumber
				set_hive_data(Res, Res.hivenumber)

			to_chat(xeno, SPAN_NOTICE("我们建造了一堵菌毯树脂墙。"))
			playsound(placed, "alien_resin_build", 25)
		else
			to_chat(xeno, SPAN_WARNING("此处已有一堵墙。"))

	else if(istype(design_mark, /datum/design_mark/resin_door))
		if(!istype(Turf, /obj/structure/mineral_door))
			var/obj/new_structure
			if(thick_build)
				new_structure = new /obj/structure/mineral_door/resin/weedbound/thick(Turf)
			else
				new_structure = new /obj/structure/mineral_door/resin/weedbound/normal(Turf)

			var/obj/structure/mineral_door/resin/Res = locate(/obj/structure/mineral_door/resin) in get_turf(Turf)
			if(istype(Res))
				Res.hivenumber = src.hivenumber
				set_hive_data(Res, Res.hivenumber)

			to_chat(xeno, SPAN_NOTICE("我们建造了一扇菌毯树脂门。"))
			playsound(new_structure, "alien_resin_build", 25)
		else
			to_chat(xeno, SPAN_WARNING("此处已有一扇门。"))

	qdel(src)

/obj/effect/alien/resin/design/construct_node/Destroy()
	if(build_overlay && !QDELETED(build_overlay))
		qdel(build_overlay)
	if(bound_weed)
		unregister_weed_expiration_signal_design()
	var/area/area = get_area(src)
	area?.current_resin_count--
	return ..()

/obj/effect/alien/resin/design/construct_node/attack_hand(mob/user)
	if(!isxeno(user))
		to_chat(user, SPAN_WARNING("你不明白如何与这个奇怪的节点互动。"))
		return

	var/mob/living/carbon/xenomorph/xeno = user

	if(!can_begin_construction(xeno))
		return

	var/total_plasma_cost = get_total_plasma_cost(xeno)
	if(xeno.plasma_stored < total_plasma_cost)
		to_chat(xeno, SPAN_WARNING("你没有足够的等离子体来供养这个节点。[xeno.plasma_stored]/[total_plasma_cost]"))
		return

	xeno.plasma_stored -= total_plasma_cost
	to_chat(xeno, SPAN_NOTICE("你激活了节点，它附着在我们身上并强行消耗了我们[total_plasma_cost]点等离子体。"))

	begin_construction(xeno)

/obj/effect/alien/resin/design/construct_node/attackby(obj/item/item, mob/user)
	if(isxeno(user) && user.a_intent != INTENT_HARM)
		if(istype(item, /obj/item/reagent_container/food/snacks/resin_fruit/plasma))
			to_chat(user, SPAN_NOTICE("我们将等离子果实汁液挤在节点上，激活其生长。"))
			qdel(item)
			thick_build = TRUE

			var/mob/living/carbon/xenomorph/xeno = user
			begin_construction(xeno)
			return

		//Do NOT call attack_hand here — that bypasses destruction
		to_chat(user, SPAN_NOTICE("你好奇地检查节点，但什么都没发生。"))
		return

	. = ..()

/obj/effect/alien/resin/design/construct_node/attack_alien(mob/living/carbon/xenomorph/xeno)
	if(xeno.a_intent != INTENT_HARM)
		return attack_hand(xeno)
	else
		return ..()

/obj/effect/alien/resin/design/construct_node/proc/get_total_plasma_cost(mob/living/carbon/xenomorph/xeno)
	var/area/target_area = get_area(get_turf(src))
	var/total_plasma_cost = plasma_donation

	if(target_area && target_area.openable_turf_count)
		var/density_ratio = target_area.current_resin_count / target_area.openable_turf_count
		if(density_ratio > 0.4)
			total_plasma_cost = ceil(total_plasma_cost * (density_ratio + 0.35) * 2)
			if(total_plasma_cost > xeno.plasma_max && (XENO_RESIN_BASE_COST + plasma_donation) < xeno.plasma_max)
				total_plasma_cost = xeno.plasma_max

	return total_plasma_cost

/obj/effect/alien/resin/design/construct_node/proc/can_begin_construction(mob/living/carbon/xenomorph/xeno)
	if(building)
		to_chat(xeno, SPAN_WARNING("这个节点已经在被注入等离子体。"))
		return FALSE

	if(xeno.hivenumber != src.hivenumber)
		to_chat(xeno, SPAN_WARNING("这个建造节点不属于你的巢穴。"))
		return FALSE

	if(!mark_meaning)
		to_chat(xeno, SPAN_WARNING("此节点未选择有效的设计。"))
		return FALSE

	var/turf/Turf = get_turf(src)
	if(!istype(Turf))
		to_chat(xeno, SPAN_WARNING("这不是一个有效的位置。"))
		return FALSE

	return TRUE

/obj/effect/alien/resin/design/construct_node/proc/begin_construction(mob/living/carbon/xenomorph/xeno)
	if(!can_begin_construction(xeno))
		return

	var/turf/Turf = get_turf(src)
	building = TRUE

	var/obj/effect/resin_construct/overlay

	if(istype(mark_meaning, /datum/design_mark/resin_wall))
		overlay = new /obj/effect/resin_construct/construct_wallslow(Turf)
	else if(istype(mark_meaning, /datum/design_mark/resin_door))
		overlay = new /obj/effect/resin_construct/construct_doorslow(Turf)

	build_overlay = overlay

	if(bound_weed.weed_strength >= WEED_LEVEL_HIVE)
		thick_build = TRUE

	if((xeno.caste_type in XENO_CONSTRUCT_NODE_BOOST) && !istype(xeno.strain, /datum/xeno_strain/designer))
		thick_build = TRUE

	addtimer(CALLBACK(src, PROC_REF(complete_construction), Turf, mark_meaning, xeno), 4 SECONDS)

/obj/effect/alien/resin/design/construct_node/get_examine_text(mob/user)
	. = ..()
	if(ishuman(user))
		. += SPAN_NOTICE("On closer examination, this node looks like big blub composed of smaller purple glowing cups, pumping some strange liquid trough weeds.")
	if(isxeno(user) || isobserver(user))
		var/mob/living/carbon/xenomorph/xeno = user
		var/total_plasma_cost = get_total_plasma_cost(xeno)
		. += SPAN_NOTICE("You sense that feeding [SPAN_BOLDNOTICE("[total_plasma_cost]")] plasma with our hand to this node will secrete a [SPAN_BOLDNOTICE("[mark_meaning]")], you also heard that using plasma fruit works too.")

//Should not be upgradable because its not "stable" but special actions should create thick variant
/turf/closed/wall/resin/weedbound //NEVER use this variant, use subtypes
	name = "菌毯树脂墙"
	desc = "一堵奇怪地凝固的树脂墙，其分层图案让你联想到花蕾。"
	icon_state = "weedboundresin"
	walltype = WALL_WEEDBOUND_RESIN

	var/obj/effect/alien/weeds/bound_weed
	var/old_hivenumber

/turf/closed/wall/resin/weedbound/Initialize()
	. = ..()
	bound_weed = locate(/obj/effect/alien/weeds) in get_turf(src)
	if(!bound_weed)
		addtimer(CALLBACK(src, PROC_REF(check_weed_replacement)), 3 SECONDS)
		return
	if(bound_weed)
		old_hivenumber = bound_weed.hivenumber
		RegisterSignal(bound_weed, COMSIG_PARENT_QDELETING, PROC_REF(on_weed_expire))

/turf/closed/wall/resin/weedbound/Destroy()
	if(bound_weed)
		UnregisterSignal(bound_weed, COMSIG_PARENT_QDELETING)
		bound_weed = null

	var/turf/Turf = get_turf(src)
	if(Turf)
		visible_message(SPAN_ALERT("菌毯墙坍塌成一滩粘稠的黏液。"))
		spawn_nutriplasm(Turf)

	return ..()

/turf/closed/wall/resin/weedbound/proc/spawn_nutriplasm(turf/Turf)
	return

/turf/closed/wall/resin/weedbound/proc/on_weed_expire()
	SIGNAL_HANDLER

	if(!old_hivenumber)
		ScrapeAway()
		return

	addtimer(CALLBACK(src, PROC_REF(check_weed_replacement)), 1 DECISECONDS)

/turf/closed/wall/resin/weedbound/proc/check_weed_replacement()
	var/turf/Turf = get_turf(src)
	if(!Turf)
		ScrapeAway()
		return

	var/obj/effect/alien/weeds/new_weed = locate(/obj/effect/alien/weeds) in Turf

	if(new_weed && new_weed.hivenumber == old_hivenumber)
		bound_weed = new_weed
		RegisterSignal(bound_weed, COMSIG_PARENT_QDELETING, PROC_REF(on_weed_expire))
	else
		playsound(src, "alien_resin_break", 25)
		ScrapeAway()

/turf/closed/wall/resin/weedbound/normal/spawn_nutriplasm(turf/Turf)
	new /obj/effect/alien/resin/sticky/weak_nutriplasm(Turf)

/turf/closed/wall/resin/weedbound/normal/get_examine_text(mob/user)
	. = ..()
	if(ishuman(user))
		. += SPAN_NOTICE("On closer examination, this strange wall appears to have merged with the resin below to hold itself together.")
	if(isxeno(user) || isobserver(user))
		. += SPAN_NOTICE("You sense that this resin wall will collapse if the weeds it is merged with disappear.")

/turf/closed/wall/resin/weedbound/thick
	name = "厚菌毯树脂墙"
	desc = "一堵奇怪地凝固的厚树脂墙，其分层图案让你联想到花蕾。"
	icon_state = "thickweedboundresin"
	damage_cap = HEALTH_WALL_XENO_THICK
	walltype = WALL_THICK_WEEDBOUND_RESIN

/turf/closed/wall/resin/weedbound/thick/spawn_nutriplasm(turf/Turf)
	new /obj/effect/alien/resin/sticky/strong_nutriplasm(Turf)

/turf/closed/wall/resin/weedbound/thick/get_examine_text(mob/user)
	. = ..()
	if(ishuman(user))
		. += SPAN_NOTICE("On closer examination, this strange darker wall appears to have merged with the resin below to hold itself together.")
	if(isxeno(user) || isobserver(user))
		. += SPAN_NOTICE("You sense that this thick resin wall will collapse if the weeds it is merged with disappear.")

/obj/structure/mineral_door/resin/weedbound //NEVER use this variant, use subtypes
	name = "菌毯缠绕树脂门"
	desc = "一扇怪异的树脂门，以奇特的方式凝固，形成了花瓣状的图案。"
	icon_state = "weedbound resin"
	mineralType = "weedbound resin"
	hardness = 1.4

	var/obj/effect/alien/weeds/bound_weed
	var/old_hivenumber

/obj/structure/mineral_door/resin/weedbound/Initialize()
	. = ..()
	bound_weed = locate(/obj/effect/alien/weeds) in get_turf(src)
	if(!bound_weed)
		addtimer(CALLBACK(src, PROC_REF(check_weed_replacement)), 3 SECONDS)
		return
	if(bound_weed)
		old_hivenumber = bound_weed.hivenumber
		RegisterSignal(bound_weed, COMSIG_PARENT_QDELETING, PROC_REF(on_weed_expire))

/obj/structure/mineral_door/resin/weedbound/Destroy()
	if(bound_weed)
		UnregisterSignal(bound_weed, COMSIG_PARENT_QDELETING)
		bound_weed = null

	var/turf/Turf = get_turf(src)
	if(Turf)
		visible_message(SPAN_ALERT("菌毯墙坍塌成一滩粘稠的黏液。"))
		spawn_nutriplasm(Turf)

	return ..()

/obj/structure/mineral_door/resin/weedbound/proc/spawn_nutriplasm(turf/Turf)
	return

/obj/structure/mineral_door/resin/weedbound/proc/on_weed_expire()
	SIGNAL_HANDLER

	if(!old_hivenumber)
		Dismantle()
		return

	addtimer(CALLBACK(src, PROC_REF(check_weed_replacement)), 1 DECISECONDS)

/obj/structure/mineral_door/resin/weedbound/proc/check_weed_replacement()
	var/turf/Turf = get_turf(src)
	if(!Turf)
		Dismantle()
		return

	var/obj/effect/alien/weeds/new_weed = locate(/obj/effect/alien/weeds) in Turf

	if(new_weed && new_weed.hivenumber == old_hivenumber)
		bound_weed = new_weed
		RegisterSignal(bound_weed, COMSIG_PARENT_QDELETING, PROC_REF(on_weed_expire))
	else
		playsound(src, "alien_resin_break", 25)
		Dismantle()

/obj/structure/mineral_door/resin/weedbound/normal/spawn_nutriplasm(turf/Turf)
	new /obj/effect/alien/resin/sticky/weak_nutriplasm(Turf)

/obj/structure/mineral_door/resin/weedbound/normal/get_examine_text(mob/user)
	. = ..()
	if(ishuman(user))
		. += SPAN_NOTICE("On closer examination, this strange door appears to have merged with the resin below to hold itself together.")
	if(isxeno(user) || isobserver(user))
		. += SPAN_NOTICE("You sense that this resin door will collapse if the weeds it is merged with disappear.")

/obj/structure/mineral_door/resin/weedbound/thick
	name = "厚实菌毯缠绕树脂门"
	desc = "一扇怪异的厚实树脂门，以奇特的方式凝固，形成了花瓣状的图案。"
	icon_state = "thick weedbound resin"
	mineralType = "thick weedbound resin"
	health = HEALTH_DOOR_XENO_THICK
	hardness = 1.9

/obj/structure/mineral_door/resin/weedbound/thick/spawn_nutriplasm(turf/Turf)
	new /obj/effect/alien/resin/sticky/strong_nutriplasm(Turf)

/obj/structure/mineral_door/resin/weedbound/thick/get_examine_text(mob/user)
	. = ..()
	if(ishuman(user))
		. += SPAN_NOTICE("On closer examination, this strange darker door appears to have merged with the resin below to hold itself together.")
	if(isxeno(user) || isobserver(user))
		. += SPAN_NOTICE("You sense that this thick resin door will collapse if the weeds it is merged with disappear.")

/obj/effect/alien/resin/sticky/weak_nutriplasm
	name = "稀薄粘稠营养质"
	desc = "一层稀薄的、令人作呕的粘稠粘液。"
	icon_state = "weak_nutriplasm"
	slow_amt = 5

/obj/effect/alien/resin/sticky/weak_nutriplasm/get_examine_text(mob/user)
	. = ..()
	if(ishuman(user))
		. += SPAN_NOTICE("On closer examination, this thin sticky substance remainds you of sticky resin.")
	if(isxeno(user) || isobserver(user))
		. += SPAN_NOTICE("We stare at the remains of weedbound walls - nutriplasm. As edible as it sounds, it's just another kind of sticky resin.")

/obj/effect/alien/resin/sticky/strong_nutriplasm
	name = "粘稠营养质"
	desc = "一层厚厚的、令人作呕的粘稠粘液。"
	icon_state = "strong_nutriplasm"
	slow_amt = 10

/obj/effect/alien/resin/sticky/strong_nutriplasm/get_examine_text(mob/user)
	. = ..()
	if(ishuman(user))
		. += SPAN_NOTICE("On closer examination, this thick sticky substance remainds you of sticky resin.")
	if(isxeno(user) || isobserver(user))
		. += SPAN_NOTICE("We stare at thick nutriplasm, the remains from weedbound resin, it sound delicious but you remember, its just different sticky resin.")

/obj/effect/alien/resin/design/upgrade
	name = "增厚树脂 (60)"
	desc = "引导我们的血浆和养分来增厚结构。"
	icon = 'icons/mob/hud/actions_xeno.dmi'
	icon_state = "upgrade_resin"
	plasma_cost = 60

/obj/effect/alien/resin/design/remove
	name = "移除设计节点 (25)"
	desc = "引导我们的血浆将设计节点还原为菌毯。"
	icon = 'icons/mob/hud/actions_xeno.dmi'
	icon_state = "remove_node"
	plasma_cost = 25

//////////////////////////
// Greater Resin Surge. //
//////////////////////////

/datum/action/xeno_action/verb/verb_greater_surge()
	set category = "Alien"
	set name = "Greater Resin Surge"
	set hidden = TRUE
	var/action_name = "Greater Resin Surge"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/activable/greater_resin_surge
	name = "强力树脂涌动 (250)"
	action_icon_state = "greater_resin_surge"
	plasma_cost = 250
	xeno_cooldown = 30 SECONDS
	macro_path = /datum/action/xeno_action/verb/verb_greater_surge
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_5

/datum/action/xeno_action/activable/greater_resin_surge/use_ability(atom/target_atom)
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!action_cooldown_check())
		return

	if(!xeno.check_state())
		return

	if(!check_and_use_plasma_owner())
		return

	for(var/obj/effect/alien/resin/design/node in xeno.current_design)
		if(get_dist(xeno, node) > 7)
			continue

		var/turf/node_loc = get_turf(node.loc)
		if(node_loc)
			create_animation_overlay(node_loc, /obj/effect/resin_construct/fastweak)

	addtimer(CALLBACK(src, PROC_REF(replace_nodes)), 1 SECONDS)
	apply_cooldown()
	xeno_cooldown = initial(xeno_cooldown)
	return ..()

/datum/action/xeno_action/activable/greater_resin_surge/proc/replace_nodes()
	var/mob/living/carbon/xenomorph/xeno = owner
	for(var/obj/effect/alien/resin/design/node in xeno.current_design.Copy())
		if(get_dist(xeno, node) > 7)
			continue

		var/turf/node_loc = get_turf(node.loc)
		if(!node_loc)
			continue

		var/obj/effect/alien/weeds/target_weeds = node_loc.weeds
		if(target_weeds && target_weeds.hivenumber == xeno.hivenumber)
			xeno.visible_message(SPAN_XENODANGER("\The [xeno] surges the resin, creating an unstable wall!"),
				SPAN_XENONOTICE("We surge the resin, creating an unstable wall!"), null, 5)

			node_loc.PlaceOnTop(/turf/closed/wall/resin/reflective/weak)
			var/turf/closed/wall/resin/reflective/weak/good_wall = node_loc
			if(good_wall)
				good_wall.hivenumber = xeno.hivenumber
				set_hive_data(good_wall, xeno.hivenumber)
			playsound(node_loc, "alien_resin_build", 25)

		qdel(node)
		xeno.current_design -= node

/datum/action/xeno_action/activable/greater_resin_surge/proc/create_animation_overlay(turf/target_turf, animation_type)
	if(!istype(target_turf, /turf))
		return

	if(!ispath(animation_type, /obj/effect/resin_construct/fastweak))
		return
	var/obj/effect/resin_construct/fastweak/animation = new animation_type(target_turf)

	addtimer(CALLBACK(animation, TYPE_PROC_REF(/obj/effect/resin_construct/fastweak, delete_animation)), 2 SECONDS)

/obj/effect/resin_construct/fastweak/proc/delete_animation()
	if(!QDELETED(src))
		qdel(src)

/////////////////////////////
///     Place Design      ///
/////////////////////////////

/datum/action/xeno_action/activable/place_design
	name = "影响力"
	action_icon_state = "secrete_resin"
	plasma_cost = 0
	macro_path = /datum/action/xeno_action/verb/place_design
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_3
	xeno_cooldown = 0
	var/max_reach = 10
	var/design_toggle = TRUE

/datum/action/xeno_action/verb/place_design()
	set category = "Alien"
	set name = "Place Design"
	set hidden = TRUE
	var/action_name = "Place Design"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/activable/place_design/use_ability(atom/target_atom, mods, use_plasma = TRUE, message = TRUE)
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!can_remote_build())
		to_chat(owner, SPAN_XENONOTICE("我们必须站在菌毯上才能引导养分和影响力。"))
		return

	if(!action_cooldown_check())
		return

	if(!xeno.check_state())
		return

	if(mods["click_catcher"])
		return

	if(ismob(target_atom))
		if(!can_see(xeno, target_atom, max_reach))
			to_chat(xeno, SPAN_XENODANGER("我们无法看见那个位置！"))
			return
	else
		if(get_dist(xeno, target_atom) > max_reach)
			to_chat(xeno, SPAN_WARNING("距离太远了！"))
			return

	var/turf/target_turf = get_turf(target_atom)
	if(!istype(target_turf))
		to_chat(xeno, SPAN_WARNING("没有菌毯我们无法进行设计。"))
		return

	var/obj/effect/alien/weeds/target_weeds = locate(/obj/effect/alien/weeds) in target_turf
	if(!target_weeds)
		to_chat(xeno, SPAN_WARNING("没有菌毯来建立连接！"))
		return

	if(target_weeds.hivenumber != xeno.hivenumber)
		to_chat(xeno, SPAN_WARNING("这些菌毯不属于我们的巢穴；它们排斥我们的影响力。"))
		return

	var/plasma_cost
	if(xeno.selected_design && xeno.selected_design.plasma_cost)
		plasma_cost = xeno.selected_design.plasma_cost

	if(ispath(xeno.selected_design, /obj/effect/alien/resin/design/upgrade))
		if(!(istype(target_atom, /turf/closed/wall/resin) || istype(target_atom, /turf/closed/wall/resin/membrane) || istype(target_atom, /obj/structure/mineral_door/resin)))
			to_chat(xeno, SPAN_XENOWARNING("我们只能升级树脂墙、膜和门！"))
			return

		if(istype(target_atom, /turf/closed/wall/resin) || istype(target_atom, /turf/closed/wall/resin/membrane))
			var/turf/closed/wall/resin/wall = target_atom

			if(wall.hivenumber != xeno.hivenumber)
				to_chat(xeno, SPAN_XENOWARNING("[wall]不属于我们的巢穴！"))
				return

			if(wall.upgrading_now) //<--- Prevent spam and waste of plasma
				to_chat(xeno, SPAN_WARNING("这面墙已经在被加固了！"))
				return

			wall.upgrading_now = TRUE

			if(wall.type == /turf/closed/wall/resin)
				var/obj/thick_wall = new /obj/effect/resin_construct/thickfast(target_turf, src, xeno)
				if(!do_after(xeno, 1 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD))
					qdel(thick_wall)
					wall.upgrading_now = FALSE
					return
				qdel(thick_wall)
				wall.ChangeTurf(/turf/closed/wall/resin/thick)

			else if(wall.type == /turf/closed/wall/resin/membrane)
				var/obj/thick_membrane = new /obj/effect/resin_construct/transparent/thickfast(target_turf, src, xeno)
				if(!do_after(xeno, 1 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD))
					qdel(thick_membrane)
					wall.upgrading_now = FALSE
					return
				qdel(thick_membrane)
				wall.ChangeTurf(/turf/closed/wall/resin/membrane/thick)
			else
				to_chat(xeno, SPAN_XENOWARNING("[wall]无法被加厚。"))
				return

			wall.upgrading_now = FALSE

		else if(istype(target_atom, /obj/structure/mineral_door/resin))
			var/obj/structure/mineral_door/resin/door = target_atom

			if(door.hivenumber != xeno.hivenumber)
				to_chat(xeno, SPAN_XENOWARNING("[door]不属于你的巢穴！"))
				return

			if(door.upgrading_now)
				to_chat(xeno, SPAN_WARNING("这扇门已经在被加固了！"))
				return

			if(door.hardness == 1.5)
				door.upgrading_now = TRUE
				var/obj/thick_door = new /obj/effect/resin_construct/thickdoorfast(target_turf, src, xeno)
				if(!do_after(xeno, 1 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD))
					qdel(thick_door)
					door.upgrading_now = FALSE
					return
				qdel(thick_door)
				var/oldloc = door.loc
				qdel(door)
				new /obj/structure/mineral_door/resin/thick(oldloc, door.hivenumber)
			else
				if(xeno.try_toggle_resin_door(door))
					if(!check_and_use_plasma_owner())
						return TRUE
					return
				return

		else
			to_chat(xeno, SPAN_XENOWARNING("我们只能升级树脂结构！"))
			return

		if(!check_and_use_plasma_owner(plasma_cost))
			return

		xeno.visible_message(SPAN_XENONOTICE("[target_atom]周围的菌毯开始抽动，并向其泵送物质，使其在过程中增厚！"),
			SPAN_XENONOTICE("We start to channel nutrients towards [target_atom], using [plasma_cost] plasma."), null, 5)
		playsound(target_atom, "alien_resin_build", 25)

		target_atom.add_hiddenprint(xeno) //Tracks who reinforced it for admins
		return TRUE

	if(xeno.try_toggle_resin_door(target_atom))
		if(!check_and_use_plasma_owner())
			return TRUE
		return

	if(ispath(xeno.selected_design, /obj/effect/alien/resin/design/remove))
		var/obj/effect/alien/resin/design/target_node = locate(/obj/effect/alien/resin/design) in target_turf
		if(!target_node)
			to_chat(xeno, SPAN_XENOWARNING("这里没有树脂节点可以移除！"))
			return

		if(target_node.hivenumber != xeno.hivenumber)
			to_chat(xeno, SPAN_XENOWARNING("这个节点不属于你的巢穴！"))
			return

		if(target_node.bound_xeno != xeno)
			to_chat(xeno, SPAN_XENOWARNING("你不能移除另一位姐妹放置的节点！"))
			return

		qdel(target_node)
		to_chat(xeno, SPAN_XENONOTICE("我们切断了与节点的连接，使其溶解入地面。"))
		playsound(xeno.loc, "alien_resin_move2", 25)
		return

	if(length(xeno.current_design) >= xeno.max_design_nodes) //Check if there are more nodes than lenght that was defined
		to_chat(xeno, SPAN_XENOWARNING("我们无法维持另一个节点，必须有一个枯萎才能让这个存活！"))
		var/obj/effect/alien/resin/design/old_design = xeno.current_design[1] //Check with node is first for deletion on list
		xeno.current_design.Remove(old_design) //Removes first node stored inside list
		qdel(old_design) //Delete node.

	var/selected_design = xeno.selected_design

	if(ispath(xeno.selected_design, /obj/effect/alien/resin/design/speed_node)) //Check path you selected from list
		if(!is_turf_clean(target_turf, check_resin_doors = TRUE))
			to_chat(src, SPAN_WARNING("这里已经有建筑了。"))
			return
		var/obj/speed_warn = new /obj/effect/resin_construct/speed_node(target_turf, src, xeno) //Create "Animation" overlay
		if(!do_after(xeno, 0.5 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD) || selected_design != xeno.selected_design)
			qdel(speed_warn) //Delete "Animation" overlay after defined time
			return
		qdel(speed_warn) //Delete again just in case overlay don't get deleted
		if(!is_turf_clean(target_turf)) //Recheck the turf again just in case
			to_chat(xeno, SPAN_XENOWARNING("有别的东西在我们之前在此扎根了。"))
			return
		if(!check_and_use_plasma_owner(plasma_cost))
			return
		xeno.visible_message(SPAN_XENONOTICE("\The [xeno] channel nutrients and shape it into a node!"))
		var/obj/effect/alien/resin/design/design = new xeno.selected_design(target_weeds.loc, target_weeds, xeno) //Create node you selected from list
		if(!design)
			to_chat(xeno, SPAN_XENOHIGHDANGER("找不到放置节点的位置！请联系程序员！"))
			return
		playsound(xeno.loc, "alien_resin_build", 25)
		xeno.current_design.Add(design) //Add Node to list.

	if(ispath(xeno.selected_design, /obj/effect/alien/resin/design/cost_node))
		if(!is_turf_clean(target_turf, check_resin_doors = TRUE))
			to_chat(src, SPAN_WARNING("这里已经有建筑了。"))
			return
		var/obj/cost_warn = new /obj/effect/resin_construct/cost_node(target_turf, src, xeno)
		if(!do_after(xeno, 0.5 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD) || selected_design != xeno.selected_design)
			qdel(cost_warn)
			return
		qdel(cost_warn)
		if(!is_turf_clean(target_turf))
			to_chat(xeno, SPAN_XENOWARNING("有别的东西在我们之前在此扎根了。"))
			return
		if(!check_and_use_plasma_owner(plasma_cost))
			return
		xeno.visible_message(SPAN_XENONOTICE("[xeno]引导养分并将其塑造成一个节点！"))
		var/obj/effect/alien/resin/design/design = new xeno.selected_design(target_weeds.loc, target_weeds, xeno)
		if(!design)
			to_chat(xeno, SPAN_XENOHIGHDANGER("找不到放置节点的位置！请联系程序员！"))
			return
		playsound(xeno.loc, "alien_resin_build", 25)
		xeno.current_design.Add(design)

	if(ispath(xeno.selected_design, /obj/effect/alien/resin/design/construct_node))
		if(!is_turf_clean(target_turf, check_resin_doors = TRUE))
			to_chat(src, SPAN_WARNING("这里已经有建筑了。"))
			return
		if(!xeno.check_alien_construction(target_turf, check_doors = FALSE))
			return FALSE
		var/obj/const_warn = new /obj/effect/resin_construct/construct_node(target_turf, src, xeno)
		if(!do_after(xeno, 0.5 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD) || selected_design != xeno.selected_design)
			qdel(const_warn)
			return
		qdel(const_warn)
		if(!is_turf_clean(target_turf))
			to_chat(xeno, SPAN_XENOWARNING("有别的东西在我们之前在此扎根了。"))
			return
		if(!check_and_use_plasma_owner(plasma_cost))
			return
		xeno.visible_message(SPAN_XENONOTICE("[xeno]引导养分并将其塑造成一个节点！"))
		var/obj/effect/alien/resin/design/design = new xeno.selected_design(target_weeds.loc, target_weeds, xeno)
		if(!design)
			to_chat(xeno, SPAN_XENOHIGHDANGER("找不到放置节点的位置！请联系程序员！"))
			return
		playsound(xeno.loc, "alien_resin_build", 25)
		xeno.current_design.Add(design)
	apply_cooldown()
	return ..()

/datum/action/xeno_action/activable/place_design/proc/can_remote_build()
	if(!locate(/obj/effect/alien/weeds) in get_turf(owner))
		return FALSE
	return TRUE

/mob/living/carbon/xenomorph/proc/try_toggle_resin_door(atom/target_atom)
	if(!istype(target_atom, /obj/structure/mineral_door/resin))
		return FALSE

	var/obj/structure/mineral_door/resin/resin_door = target_atom

	if(resin_door.hivenumber != hivenumber)
		to_chat(src, SPAN_XENOWARNING("这扇门不属于我们的巢穴！"))
		return TRUE

	if(resin_door.TryToSwitchState(src))
		if(resin_door.open)
			to_chat(src, SPAN_XENONOTICE("我们集中与树脂的连接，远程关闭了树脂门。"))
		else
			to_chat(src, SPAN_XENONOTICE("我们集中与树脂的连接，远程打开了树脂门。"))

	return TRUE

/datum/action/xeno_action/activable/place_design/proc/is_turf_clean(turf/current_turf, check_resin_additions = FALSE, check_doors = FALSE, check_resin_doors = FALSE)
	var/has_obstacle = FALSE
	for(var/obj/target in current_turf)
		if(check_doors)
			if(istype(target, /obj/structure/machinery/door))
				to_chat(src, SPAN_WARNING("[target]挡住了树脂！这里没有足够的空间建造。"))
				return FALSE
		if(check_resin_additions)
			if(istype(target, /obj/effect/alien/resin/sticky) || istype(target, /obj/effect/alien/resin/spike) || istype(target, /obj/effect/alien/resin/sticky/fast))
				has_obstacle = TRUE
				to_chat(src, SPAN_WARNING("[target]挡住了树脂！"))
				return FALSE
		if(check_resin_doors)
			if(istype(target, /obj/structure/mineral_door/resin))
				to_chat(src, SPAN_WARNING("[target]挡住了树脂节点！这里没有足够的空间建造。"))
				return FALSE
	if(current_turf.density || has_obstacle || locate(/obj/effect/alien/resin/design) in current_turf)
		return FALSE
	return TRUE

///////////////////////////////
///   Change Node Marker    ///
///////////////////////////////

/datum/action/xeno_action/verb/verb_toggle_design_icons()
	set category = "Alien"
	set name = "更改设计标记"
	set hidden = TRUE
	var/action_name = "更改设计标记"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/onclick/toggle_design_icons
	name = "更改设计标记"
	action_icon_state = "design_mark_1"
	plasma_cost = 0
	macro_path = /datum/action/xeno_action/verb/verb_toggle_design_icons
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_4

/datum/action/xeno_action/onclick/toggle_design_icons/can_use_action()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(xeno && !xeno.buckled && !xeno.is_mob_incapacitated())
		return TRUE

/datum/action/xeno_action/onclick/toggle_design_icons/use_ability()
	var/mob/living/carbon/xenomorph/xeno = owner

	if (!istype(xeno))
		return

	if(!xeno.check_state(TRUE))
		return

	var/datum/action/xeno_action/activable/place_design/cAction = get_action(xeno, /datum/action/xeno_action/activable/place_design)

	if(!istype(cAction))
		return

	cAction.design_toggle = !cAction.design_toggle

	var/action_icon_result
	if(cAction.design_toggle)
		action_icon_result = "design_mark_1"
		to_chat(xeno, SPAN_INFO("我们现在将放置墙壁标记。"))
		xeno.selected_design_mark = /datum/design_mark/resin_wall
	else
		action_icon_result = "design_mark_2"
		to_chat(xeno, SPAN_INFO("我们现在将放置门标记。"))
		xeno.selected_design_mark = /datum/design_mark/resin_door

	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions_xeno.dmi', button, action_icon_result)
	return ..()

//////////////////////////
///   Change Design    ///
//////////////////////////

/datum/action/xeno_action/verb/verb_change_design()
	set category = "Alien"
	set name = "更改设计标记"
	set hidden = TRUE
	var/action_name = "更改设计标记"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/onclick/change_design
	name = "选择行动"
	action_icon_state = "static_speednode"
	plasma_cost = 0
	xeno_cooldown = 0
	macro_path = /datum/action/xeno_action/verb/verb_change_design
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_2

/datum/action/xeno_action/onclick/change_design/use_ability(atom/Atom)
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!xeno.check_state())
		return

	var/static/list/options = list(
		"Optimized Node (50)" = icon(/datum/action/xeno_action::icon_file, "static_speednode"),
		"Construct Node (70)" = icon(/datum/action/xeno_action::icon_file, "static_constructnode"),
		"增厚树脂 (60)" = icon(/datum/action/xeno_action::icon_file, "upgrade_resin"),
		"Open Old UI" = icon(/datum/action/xeno_action::icon_file, "open_ui"),
		"Remove Node (25)" = icon(/datum/action/xeno_action::icon_file, "remove_node"),
		"Flexible Node (60)" = icon(/datum/action/xeno_action::icon_file, "static_costnode")
	)

	var/choice
	if(owner.client.prefs.no_radials_preference)
		choice = tgui_input_list(owner, "选择设计选项", "Pick", options, theme="hive_status")
	else
		choice = show_radial_menu(owner, owner?.client.get_eye(), options, radius = 50)

	var/des = FALSE
	var/rem = FALSE
	plasma_cost = 0
	switch(choice)
		if("Optimized Node (50)")
			xeno.selected_design = /obj/effect/alien/resin/design/speed_node
			des = TRUE
		if("Flexible Node (60)")
			xeno.selected_design = /obj/effect/alien/resin/design/cost_node
			des = TRUE
		if("Construct Node (70)")
			xeno.selected_design = /obj/effect/alien/resin/design/construct_node
			des = TRUE
		if("增厚树脂 (60)")
			xeno.selected_design = /obj/effect/alien/resin/design/upgrade
			rem = TRUE
		if("Remove Node (25)")
			xeno.selected_design = /obj/effect/alien/resin/design/remove
			rem = TRUE
		if("Open Old UI")
			tgui_interact(xeno)

	if(des)
		to_chat(xeno, SPAN_NOTICE("我们现在将建造<b>[xeno.selected_design.name]</b>。"))
	if(rem)
		to_chat(xeno, SPAN_NOTICE("我们现在将远程<b>[xeno.selected_design.name]</b>。"))

	xeno.update_icons()
	button.overlays.Cut()
	button.overlays += image(icon_file, button, xeno.selected_design.icon_state)

	return ..()

// Below is UI for old players.

/datum/action/xeno_action/onclick/change_design/give_to(mob/living/carbon/xenomorph/xeno)
	. = ..()

	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions_xeno.dmi', button, initial(xeno.selected_design.icon_state))
	button.overlays += image(icon_file, button, action_icon_state)

/datum/action/xeno_action/onclick/change_design/ui_assets(mob/user)
	return list(get_asset_datum(/datum/asset/spritesheet/choose_design))

/datum/action/xeno_action/onclick/change_design/ui_static_data(mob/user)
	var/mob/living/carbon/xenomorph/xeno = user
	if(!istype(xeno))
		return

	. = list()

	var/list/design_list = list()
	for(var/obj/effect/alien/resin/design/design as anything in xeno.available_design)
		var/list/entry = list()

		entry["name"] = initial(design.name)
		entry["desc"] = initial(design.desc)
		entry["image"] = replacetext(initial(design.icon_state), " ", "-")
		entry["id"] = "[design]"
		design_list += list(entry)

	.["design"] = design_list

/datum/action/xeno_action/onclick/change_design/ui_data(mob/user)
	var/mob/living/carbon/xenomorph/xeno = user
	if(!istype(xeno))
		return

	. = list()
	.["selected_design"] = xeno.selected_design

/datum/action/xeno_action/onclick/change_design/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ChooseDesign", "Choose Design")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/action/xeno_action/onclick/change_design/Destroy()
	SStgui.close_uis(src)
	return ..()

/datum/action/xeno_action/onclick/change_design/ui_state(mob/user)
	return GLOB.always_state

/datum/action/xeno_action/onclick/change_design/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/mob/living/carbon/xenomorph/xeno = ui.user
	if(!istype(xeno))
		return

	switch(action)
		if("choose_design")
			var/selected_type = text2path(params["type"])
			if(!(selected_type in xeno.available_design))
				return

			var/obj/effect/alien/resin/design/design = selected_type
			to_chat(xeno, SPAN_NOTICE("设计时，我们现在将建造<b>[initial(design.name)]</b>。"))
			//update the button's overlay with new choice
			xeno.update_icons()
			button.overlays.Cut()
			button.overlays += image(icon_file, button, action_icon_state)
			button.overlays += image('icons/mob/hud/actions_xeno.dmi', button, initial(design.icon_state))
			xeno.selected_design = selected_type
			. = TRUE

		if("refresh_ui")
			. = TRUE
