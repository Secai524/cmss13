// Impenetrable and invincible barriers
/obj/structure/blocker
	name = "blocker"
	density = TRUE
	anchored = TRUE
	unacidable = TRUE
	unslashable = TRUE
	explo_proof = TRUE
	icon = 'icons/landmarks.dmi'
	icon_state = "map_blocker"

/obj/structure/blocker/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = NONE

/obj/structure/blocker/ex_act(severity)
	return

/obj/structure/blocker/invisible_wall
	name = "隐形墙"
	desc = "此路不通。"
	icon_state = "invisible_wall"
	opacity = FALSE
	layer = ABOVE_FLY_LAYER + 0.1 //to make it visible in the map editor
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/blocker/invisible_wall/Collided(atom/movable/AM)
	var/msg = desc
	if(!msg)
		msg = "此路不通。"
	to_chat(AM, SPAN_WARNING(msg))

/obj/structure/blocker/invisible_wall/New()
	..()
	icon_state = null

/obj/structure/blocker/invisible_wall/water
	desc = "你无法再涉水前行。"
	icon_state = "map_blocker"

/obj/structure/blocker/fog
	name = "浓雾"
	desc = "看起来穿越此地过于危险。最好等它散去。"
	icon = 'icons/effects/effects.dmi'
	icon_state = "smoke"
	opacity = TRUE

/obj/structure/blocker/fog/Initialize(mapload, time_to_dispel)
	. = ..()

	if(!time_to_dispel)
		return INITIALIZE_HINT_QDEL

	dir = pick(CARDINAL_DIRS)
	QDEL_IN(src, time_to_dispel + rand(-5 SECONDS, 5 SECONDS))

/obj/structure/blocker/fog/attack_hand(mob/M)
	to_chat(M, SPAN_NOTICE("你透过浓雾窥视，但无法看清另一侧有什么……"))

/obj/structure/blocker/fog/attack_alien(M)
	attack_hand(M)
	return XENO_NONCOMBAT_ACTION

/obj/structure/blocker/preserve_edge
	name = "浓雾"
	desc = "你觉得你看到了一条通路。"
	icon = 'icons/effects/effects.dmi'
	icon_state = "smoke"
	opacity = TRUE

/obj/structure/blocker/preserve_edge/attack_hand(mob/user)
	if(isyautja(user))
		to_chat(user, SPAN_WARNING("你为什么要这么做？"))///no leaving for preds
		return

	if(user.action_busy)
		return

	var/choice = tgui_alert(user, "你确定要穿越迷雾，逃离保护区吗？", "[src]", list("Yes", "No"), 15 SECONDS)
	if(!choice)
		return

	if(choice == "No")
		return

	if(choice == "Yes")
		to_chat(user, SPAN_DANGER("你开始逃亡！"))

	if(!do_after(user, 5 SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC))
		to_chat(user, SPAN_NOTICE("你迷失了方向，又绕了回来。"))
		return

	announce_dchat("[user.real_name] has escaped from the hunting grounds!")
	playsound(user, 'sound/misc/fog_escape.ogg')
	qdel(user)

/obj/structure/blocker/preserve_edge/attack_alien(user)
	attack_hand(user)
	return XENO_NONCOMBAT_ACTION

/obj/structure/blocker/forcefield
	name = "forcefield"

	icon = 'icons/landmarks.dmi'
	icon_state = "map_blocker"
	anchored = TRUE
	unacidable = TRUE
	density = FALSE

	var/is_whitelist = FALSE
	var/strict_types = FALSE

	var/list/types = list()
	var/visible = FALSE

/obj/structure/blocker/forcefield/get_projectile_hit_boolean(obj/projectile/P)
	if(!is_whitelist)
		return FALSE
	. = ..()

/obj/structure/blocker/forcefield/BlockedPassDirs(atom/movable/AM, target_dir)
	var/whitelist_no_block = is_whitelist? NO_BLOCKED_MOVEMENT : BLOCKED_MOVEMENT

	if(strict_types)
		if(AM.type in types)
			return whitelist_no_block
	else
		for(var/type in types)
			if(istype(AM, type))
				return whitelist_no_block

	return !whitelist_no_block

/obj/structure/blocker/forcefield/Initialize(mapload, ...)
	. = ..()

	if(!visible)
		invisibility = 101


/obj/structure/blocker/forcefield/vehicles
	types = list(/obj/vehicle/)


/obj/structure/blocker/forcefield/vehicles/handle_vehicle_bump(obj/vehicle/multitile/multitile_vehicle)
	if(multitile_vehicle.vehicle_flags & VEHICLE_BYPASS_BLOCKERS)
		return TRUE
	return FALSE

/obj/structure/blocker/forcefield/multitile_vehicles
	types = list(/obj/vehicle/multitile/)


/obj/structure/blocker/forcefield/multitile_vehicles/handle_vehicle_bump(obj/vehicle/multitile/multitile_vehicle)
	if(multitile_vehicle.vehicle_flags & VEHICLE_BYPASS_BLOCKERS)
		return TRUE
	return FALSE

/obj/structure/blocker/forcefield/human
	types = list(/mob/living/carbon/human)
	icon_state = "purple_line"

	visible = TRUE

/obj/structure/blocker/forcefield/human/bulletproof/get_projectile_hit_boolean()
	return TRUE

// for fuel pump since it's a large sprite.
/obj/structure/blocker/fuelpump
	name = "\improper Fuel Pump"
	desc = "这是一台为整艘舰船输送燃料的机器。"
	invisibility = 101
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
