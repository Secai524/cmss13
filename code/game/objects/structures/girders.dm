#define STATE_STANDARD 0
#define STATE_DISMANTLING 1
#define STATE_WALL 2
#define STATE_REINFORCED_WALL 3
#define STATE_DISPLACED 4
#define STATE_DESTROYED 5 // this is so they can get destroyed by xenos

#define STATE_SCREWDRIVER 1
#define STATE_WIRECUTTER 2
#define STATE_METAL 3
#define STATE_PLASTEEL 4
#define STATE_RODS 5

#define GIRDER_UPGRADE_MATERIAL_COST 5

/obj/structure/girder
	icon_state = "girder"
	anchored = TRUE
	density = TRUE
	layer = OBJ_LAYER
	unacidable = FALSE
	debris = list(/obj/item/stack/sheet/metal, /obj/item/stack/sheet/metal)
	var/state = STATE_STANDARD
	var/step_state = STATE_STANDARD
	health = 125
	// To store what type of wall it used to be
	var/original

/obj/structure/girder/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_THROUGH|PASS_HIGH_OVER_ONLY

/obj/structure/girder/get_examine_text(mob/user)
	. = ..()
	if (health <= 0)
		. += "It's broken, but can be mended by welding it."
		return

	switch(state)
		if(STATE_STANDARD)
			if(step_state == STATE_STANDARD)
				. += SPAN_NOTICE("It looks ready for a [SPAN_HELPFUL("screwdriver")] to dismantle, [SPAN_HELPFUL("metal")] to create a wall or [SPAN_HELPFUL("plasteel")] to create a reinforced wall.")
				return
		if(STATE_DISMANTLING)
			if(step_state == STATE_SCREWDRIVER)
				. += SPAN_NOTICE("Support struts are unsecured. [SPAN_HELPFUL("Wirecutters")] to remove.")
			else if(step_state == STATE_WIRECUTTER)
				. += SPAN_NOTICE("Support struts are removed. [SPAN_HELPFUL("Crowbar")] to dislodge, [SPAN_HELPFUL("wrench")] to dismantle.")
			return
		if(STATE_WALL)
			if(step_state == STATE_METAL)
				. += SPAN_NOTICE("Metal added. [SPAN_HELPFUL("Screwdrivers")] to attach.")
			else if(step_state == STATE_SCREWDRIVER)
				. += SPAN_NOTICE("Metal attached. [SPAN_HELPFUL("Weld")] to finish.")
			return
		if(STATE_REINFORCED_WALL)
			if(step_state == STATE_PLASTEEL)
				. += SPAN_NOTICE("Plasteel added. Add [SPAN_HELPFUL("金属棒")] to stengthen.")
			else if(step_state == STATE_RODS)
				. += SPAN_NOTICE("Metal rods added. [SPAN_HELPFUL("Screwdrivers")] to attach.")
			else if(step_state == STATE_SCREWDRIVER)
				. += SPAN_NOTICE("Plasteel attached. [SPAN_HELPFUL("Weld")] to finish.")
			return
		if(STATE_DISPLACED)
			. += SPAN_NOTICE("It looks dislodged. [SPAN_HELPFUL("Crowbar")] to secure it.")

/obj/structure/girder/update_icon()
	. = ..()

	if(!anchored)
		icon_state = "displaced"
	else
		icon_state = "girder"

/obj/structure/girder/attackby(obj/item/W, mob/user)
	for(var/obj/effect/xenomorph/acid/A in src.loc)
		if(A.acid_t == src)
			to_chat(user, "你无法靠近，它正在融化！")
			return

	if(user.action_busy)
		return TRUE //no afterattack

	if(istype(W, /obj/item/weapon/twohanded/breacher))
		var/obj/item/weapon/twohanded/breacher/current_hammer = W
		if(user.action_busy)
			return
		if(!(HAS_TRAIT(user, TRAIT_SUPER_STRONG) || !current_hammer.really_heavy))
			to_chat(user, SPAN_WARNING("你无法正常使用\the [current_hammer]！"))
			return

		to_chat(user, SPAN_NOTICE("你开始拆除\the [src]。"))
		if(!do_after(user, 3 SECONDS, INTERRUPT_ALL_OUT_OF_RANGE, BUSY_ICON_BUILD))
			to_chat(user, SPAN_NOTICE("你停止拆除\the [src]。"))
			return
		to_chat(user, SPAN_NOTICE("你拆除了\the [src]。"))

		playsound(loc, 'sound/effects/metal_shatter.ogg', 40, 1)
		dismantle()
		return

	if(istool(W) && !skillcheck(user, SKILL_CONSTRUCTION, SKILL_CONSTRUCTION_TRAINED))
		to_chat(user, SPAN_WARNING("你没有接受过配置[src]的训练..."))
		return TRUE

	if(health > 0)
		if(change_state(W, user))
			return
	else if(iswelder(W))
		if(!HAS_TRAIT(W, TRAIT_TOOL_BLOWTORCH))
			to_chat(user, SPAN_WARNING("你需要一把更强的喷枪！"))
			return
		for(var/obj/object in loc)
			if(object.density)
				to_chat(user, SPAN_WARNING("[object]阻挡了你将[src]焊接在一起！"))
				return
		if(do_after(user, 3 SECONDS, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
			if(QDELETED(src))
				return
			to_chat(user, SPAN_NOTICE("你将大梁焊接好了！"))
			repair()
			return
	. = ..()

/obj/structure/girder/proc/change_state(obj/item/W, mob/user)
	switch(state)
		if(STATE_STANDARD)
			if(HAS_TRAIT(W, TRAIT_TOOL_SCREWDRIVER))
				playsound(loc, 'sound/items/Screwdriver.ogg', 25, 1)
				to_chat(user, SPAN_NOTICE("正在解除支撑杆的固定。"))
				if(!do_after(user, 4 SECONDS * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					return TRUE
				to_chat(user, SPAN_NOTICE("你解除了支撑杆的固定！"))
				state = STATE_DISMANTLING
				step_state = STATE_SCREWDRIVER
				return TRUE

			else if(istype(W, /obj/item/stack/sheet/metal))
				if(istype(get_area(loc), /area/shuttle))
					to_chat(user, SPAN_WARNING("不行。这片区域是运输机和人员必需的。"))
					return TRUE

				var/obj/item/stack/sheet/metal/M = W
				to_chat(user, SPAN_NOTICE("你开始将金属添加到内部结构中。"))
				if(!do_after(user, 4 SECONDS * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					return TRUE
				if(M.use(GIRDER_UPGRADE_MATERIAL_COST))
					state = STATE_WALL
					step_state = STATE_METAL
					to_chat(user, SPAN_NOTICE("你已将金属添加到内部结构中！"))
				else
					to_chat(user, SPAN_NOTICE("金属不足！"))
				return TRUE

			else if(istype(W, /obj/item/stack/sheet/plasteel))
				if(istype(get_area(loc), /area/shuttle))
					to_chat(user, SPAN_WARNING("不行。这片区域是运输机和人员必需的。"))
					return TRUE

				var/obj/item/stack/sheet/plasteel/P = W
				to_chat(user, SPAN_NOTICE("你开始将板材安装到内部结构上。"))
				if(!do_after(user, 4 SECONDS * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					return TRUE
				if(P.use(GIRDER_UPGRADE_MATERIAL_COST))
					state = STATE_REINFORCED_WALL
					step_state = STATE_PLASTEEL
					to_chat(user, SPAN_NOTICE("你已将板材安装到内部结构上！"))
				else
					to_chat(user, SPAN_NOTICE("塑钢不足！"))
				return TRUE

		if(STATE_DISMANTLING)
			return do_dismantle(W, user)
		if(STATE_WALL)
			return do_wall(W, user)
		if(STATE_REINFORCED_WALL)
			return do_reinforced_wall(W, user)
		if(STATE_DISPLACED)
			if(HAS_TRAIT(W, TRAIT_TOOL_CROWBAR))
				var/area/area = get_area(W)
				if(!area.allow_construction)
					to_chat(user, SPAN_WARNING("大梁必须固定在合适的表面上！"))
					return
				var/turf/open/floor = loc
				if(!floor.allow_construction)
					to_chat(user, SPAN_WARNING("大梁必须固定在合适的表面上！"))
					return
				var/obj/structure/tunnel/tunnel = locate(/obj/structure/tunnel) in loc
				if(tunnel)
					to_chat(user, SPAN_WARNING("大梁无法固定在隧道上！"))
					return
				playsound(loc, 'sound/items/Crowbar.ogg', 25, 1)
				to_chat(user, SPAN_NOTICE("正在固定大梁..."))
				if(!do_after(user, 4 SECONDS * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
					return TRUE
				to_chat(user, SPAN_NOTICE("你固定好了大梁！"))
				anchored = TRUE
				state = STATE_STANDARD
				step_state = STATE_STANDARD
				update_icon()
				return TRUE
	return FALSE

/obj/structure/girder/proc/do_dismantle(obj/item/W, mob/user)
	if(!(state == STATE_DISMANTLING))
		return FALSE

	else if(HAS_TRAIT(W, TRAIT_TOOL_WIRECUTTERS) && step_state == STATE_SCREWDRIVER)
		playsound(loc, 'sound/items/Wirecutter.ogg', 25, 1)
		to_chat(user, SPAN_NOTICE("正在移除支撑杆。"))
		if(!do_after(user, 4 SECONDS * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
			return TRUE
		to_chat(user, SPAN_NOTICE("你移除了支撑杆！"))
		step_state = STATE_WIRECUTTER
		return TRUE

	else if(HAS_TRAIT(W, TRAIT_TOOL_CROWBAR) && step_state == STATE_WIRECUTTER)
		playsound(loc, 'sound/items/Crowbar.ogg', 25, 1)
		to_chat(user, SPAN_NOTICE("正在撬动大梁..."))
		if(!do_after(user, 4 SECONDS * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
			return TRUE
		to_chat(user, SPAN_NOTICE("你撬动了大梁！"))
		anchored = FALSE
		state = STATE_DISPLACED
		step_state = STATE_STANDARD
		update_icon()
		return TRUE

	else if(HAS_TRAIT(W, TRAIT_TOOL_WRENCH) && step_state == STATE_WIRECUTTER)
		to_chat(user, SPAN_NOTICE("你开始用扳手将其拆开。"))
		playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
		if(!do_after(user, 4 SECONDS * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, src))
			return TRUE
		to_chat(user, SPAN_NOTICE("你用扳手把它拆开了！"))
		deconstruct(TRUE)

		return TRUE
	return FALSE

/obj/structure/girder/deconstruct(disassembled = TRUE)
	if(disassembled)
		new /obj/item/stack/sheet/metal(loc, 2)
	return ..()

/obj/structure/girder/proc/do_wall(obj/item/W, mob/user)
	if(!(state == STATE_WALL))
		return FALSE

	if(HAS_TRAIT(W, TRAIT_TOOL_SCREWDRIVER) && step_state == STATE_METAL)
		playsound(loc, 'sound/items/Screwdriver.ogg', 25, 1)
		to_chat(user, SPAN_NOTICE("你正在将金属固定到内部结构上。"))
		if(!do_after(user, 4 SECONDS * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_NO_NEEDHAND|BEHAVIOR_IMMOBILE, BUSY_ICON_FRIENDLY, src))
			return TRUE
		to_chat(user, SPAN_NOTICE("你已将金属固定到内部结构上！"))
		step_state = STATE_SCREWDRIVER
		return TRUE

	if(iswelder(W) && step_state == STATE_SCREWDRIVER)
		if(!HAS_TRAIT(W, TRAIT_TOOL_BLOWTORCH))
			to_chat(user, SPAN_WARNING("你需要一把更强的喷枪！"))
			return
		var/obj/item/tool/weldingtool/WT = W
		if(WT.remove_fuel(5, user))
			to_chat(user, SPAN_NOTICE("你开始焊接新部件。"))
			playsound(loc, 'sound/items/Welder2.ogg', 25, 1)
			if(!do_after(user, 5 SECONDS * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_NO_NEEDHAND|BEHAVIOR_IMMOBILE, BUSY_ICON_FRIENDLY, src))
				WT.remove_fuel(-5)
				return TRUE

			if(QDELETED(src))
				return

			to_chat(user, SPAN_NOTICE("你已焊接好新部件！"))
			playsound(loc, 'sound/items/Welder2.ogg', 25, 1)
			var/turf/T = get_turf(src)
			if(is_mainship_level(z))
				T.PlaceOnTop(/turf/closed/wall/almayer)
				SEND_SIGNAL(user, COMSIG_MOB_CONSTRUCT_WALL, /turf/closed/wall/almayer)
			else
				T.PlaceOnTop(/turf/closed/wall)
				SEND_SIGNAL(user, COMSIG_MOB_CONSTRUCT_WALL, /turf/closed/wall)
			var/obj/effect/alien/weeds/weeds_in_tile = locate(/obj/effect/alien/weeds) in T
			if(weeds_in_tile)
				qdel(weeds_in_tile)
			T.add_fingerprint(user)
			qdel(src)
		return TRUE
	return FALSE

/obj/structure/girder/proc/do_reinforced_wall(obj/item/W, mob/user)
	if(!(state == STATE_REINFORCED_WALL))
		return FALSE

	if(istype(W, /obj/item/stack/rods) && step_state == STATE_PLASTEEL)
		var/obj/item/stack/rods/R = W
		if(R.use(2))
			to_chat(user, SPAN_NOTICE("你加固了连接杆。"))
			step_state = STATE_RODS
		else
			to_chat(user, SPAN_NOTICE("你未能加固连接杆。需要更多连接杆。"))
		return TRUE

	if(HAS_TRAIT(W, TRAIT_TOOL_SCREWDRIVER) && step_state == STATE_RODS)
		playsound(loc, 'sound/items/Screwdriver.ogg', 25, 1)
		to_chat(user, SPAN_NOTICE("你正在将塑钢固定到内部结构上。"))
		if(!do_after(user, 4 SECONDS * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_NO_NEEDHAND|BEHAVIOR_IMMOBILE, BUSY_ICON_FRIENDLY, src))
			return TRUE
		to_chat(user, SPAN_NOTICE("你已将塑钢固定到内部结构上！"))
		step_state = STATE_SCREWDRIVER
		return TRUE

	if(iswelder(W) && step_state == STATE_SCREWDRIVER)
		if(!HAS_TRAIT(W, TRAIT_TOOL_BLOWTORCH))
			to_chat(user, SPAN_WARNING("你需要一把更强的喷枪！"))
			return
		var/obj/item/tool/weldingtool/WT = W
		if(WT.remove_fuel(5, user))
			to_chat(user, SPAN_NOTICE("你开始焊接新部件。"))
			playsound(loc, 'sound/items/Welder2.ogg', 25, 1)
			if(!do_after(user, 5 SECONDS * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_NO_NEEDHAND|BEHAVIOR_IMMOBILE, BUSY_ICON_FRIENDLY, src))
				WT.remove_fuel(-5)
				return TRUE

			if(QDELETED(src))
				return

			to_chat(user, SPAN_NOTICE("你已焊接好新部件！"))
			playsound(loc, 'sound/items/Welder2.ogg', 25, 1)
			var/turf/T = get_turf(src)
			if(is_mainship_level(z))
				T.PlaceOnTop(/turf/closed/wall/almayer/reinforced)
			else
				T.PlaceOnTop(/turf/closed/wall/r_wall)
			var/obj/effect/alien/weeds/weeds_in_tile = locate(/obj/effect/alien/weeds) in T
			if(weeds_in_tile)
				qdel(weeds_in_tile)
			T.add_fingerprint(user)
			qdel(src)
		return TRUE

	return FALSE

/obj/structure/girder/bullet_act(obj/projectile/P)
	//Tasers and the like should not damage girders.
	if(P.ammo.damage_type == HALLOSS || P.ammo.damage_type == TOX || P.ammo.damage_type == CLONE || P.damage == 0)
		return FALSE
	var/dmg = 0
	if(P.ammo.damage_type == BURN)
		dmg = P.damage
	else
		dmg = floor(P.damage * 0.5)
	if(dmg)
		take_damage(dmg)
		bullet_ping(P)
	if(health <= 0)
		update_state()
	return TRUE

/obj/structure/girder/proc/take_damage(damage)
	health -= damage
	if(health <= -100)
		qdel(src)
	if(health <= 0)
		update_state()


/obj/structure/girder/proc/dismantle()
	health = 0
	update_state()

/obj/structure/girder/proc/repair()
	health = initial(health)
	state = STATE_STANDARD
	update_state()

/obj/structure/girder/proc/update_state()
	if(health <= 0 && density)
		icon_state = "[icon_state]_damaged"
		density = FALSE
		state = STATE_DESTROYED

	else if(health > 0 && !density)
		var/underscore_position =  findtext(icon_state,"_")
		var/new_state = copytext(icon_state, 1, underscore_position)
		icon_state = new_state
		density = TRUE

/obj/structure/girder/attack_animal(mob/living/simple_animal/user)
	if(user.wall_smash)
		visible_message(SPAN_DANGER("[user]砸碎了[src]！"))
		dismantle()
		return
	return ..()

/obj/structure/girder/ex_act(severity, direction, datum/cause_data/cause_data)
	health -= severity
	if(health <= 0)
		var/location = get_turf(src)
		handle_debris(severity, direction)
		deconstruct(FALSE)
		create_shrapnel(location, rand(2,5), direction, 45, /datum/ammo/bullet/shrapnel/light, cause_data) // Shards go flying
	else
		update_state()

/obj/structure/girder/displaced
	icon_state = "displaced"
	anchored = FALSE
	state = STATE_DISPLACED

/obj/structure/girder/reinforced
	icon_state = "reinforced"
	health = 500


/obj/structure/girder/attack_alien(mob/living/carbon/xenomorph/M)
	if((M.caste && M.caste.tier < 2 && M.claw_type < CLAW_TYPE_VERY_SHARP) || unacidable)
		to_chat(M, SPAN_WARNING("我们的爪子不够锋利，无法破坏[src]。"))
		return XENO_NO_DELAY_ACTION
	M.animation_attack_on(src)
	health -= floor(rand(M.melee_damage_lower, M.melee_damage_upper) * 0.5)
	if(health <= 0)
		M.visible_message(SPAN_DANGER("[M]砸碎了[src]！"),
		SPAN_DANGER("We slice [src] apart!"), null, 5, CHAT_TYPE_XENO_COMBAT)
		playsound(loc, 'sound/effects/metalhit.ogg', 25, TRUE)
		dismantle()
	if(state == STATE_DESTROYED)
		qdel(src)
	else
		M.visible_message(SPAN_DANGER("[M]砸碎了[src]！"),
		SPAN_DANGER("We [M.slash_verb] [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
		playsound(loc, 'sound/effects/metalhit.ogg', 25, TRUE)
	return XENO_ATTACK_ACTION

/obj/structure/girder/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(xeno.caste && xeno.caste.tier < 2 && xeno.claw_type < CLAW_TYPE_VERY_SHARP)
		return TAILSTAB_COOLDOWN_NONE
	if(unacidable || unslashable)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	health -= xeno.melee_damage_upper
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
		dismantle()
	if(state == STATE_DESTROYED)
		qdel(src)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

#undef STATE_STANDARD
#undef STATE_DISMANTLING
#undef STATE_WALL
#undef STATE_REINFORCED_WALL
#undef STATE_DESTROYED

#undef STATE_SCREWDRIVER
#undef STATE_WIRECUTTER
#undef STATE_METAL
#undef STATE_PLASTEEL
#undef STATE_RODS

#undef GIRDER_UPGRADE_MATERIAL_COST
