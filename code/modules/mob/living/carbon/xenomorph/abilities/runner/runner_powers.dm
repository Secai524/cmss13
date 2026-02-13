/datum/action/xeno_action/activable/runner_skillshot/use_ability(atom/affected_atom)
	var/mob/living/carbon/xenomorph/xeno = owner
	if (!istype(xeno))
		return

	if (!action_cooldown_check())
		return

	if(!affected_atom || affected_atom.layer >= FLY_LAYER || !isturf(xeno.loc) || !xeno.check_state())
		return

	if (!check_and_use_plasma_owner())
		return

	xeno.visible_message(SPAN_XENOWARNING("[xeno]向[affected_atom]喷射出一阵骨片！"), SPAN_XENOWARNING("We fire a burst of bone chips at [affected_atom]!"))

	var/turf/target = locate(affected_atom.x, affected_atom.y, affected_atom.z)
	var/obj/projectile/projectile = new /obj/projectile(xeno.loc, create_cause_data(initial(xeno.caste_type), xeno))

	var/datum/ammo/ammo_datum = GLOB.ammo_list[ammo_type]

	projectile.generate_bullet(ammo_datum)

	projectile.fire_at(target, xeno, xeno, ammo_datum.max_range, ammo_datum.shell_speed)

	apply_cooldown()
	return ..()


/datum/action/xeno_action/activable/acider_acid/use_ability(atom/affected_atom)
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!istype(affected_atom, /obj/item) && !istype(affected_atom, /obj/structure/) && !istype(affected_atom, /obj/vehicle/multitile))
		to_chat(xeno, SPAN_XENOHIGHDANGER("只能熔化路障和物品！"))
		return
	var/datum/behavior_delegate/runner_acider/behavior_delegate = xeno.behavior_delegate
	if (!istype(behavior_delegate))
		return
	if(behavior_delegate.acid_amount < acid_cost)
		to_chat(xeno, SPAN_XENOHIGHDANGER("储存的酸液不足！"))
		return

	xeno.corrosive_acid(affected_atom, acid_type, 0)
	for(var/obj/item/explosive/plastic/plastic_explosive in affected_atom.contents)
		xeno.corrosive_acid(plastic_explosive, acid_type, 0)
	return ..()

/mob/living/carbon/xenomorph/runner/corrosive_acid(atom/affected_atom, acid_type, plasma_cost)
	if(!istype(strain, /datum/xeno_strain/acider))
		return ..()
	if(!affected_atom.Adjacent(src))
		if(istype(affected_atom,/obj/item/explosive/plastic))
			var/obj/item/explosive/plastic/plastic_explosive = affected_atom
			if(plastic_explosive.plant_target && !plastic_explosive.plant_target.Adjacent(src))
				to_chat(src, SPAN_WARNING("我们无法触及[affected_atom]。"))
				return
		else
			to_chat(src, SPAN_WARNING("[affected_atom]距离太远。"))
			return

	if(!isturf(loc) || HAS_TRAIT(src, TRAIT_ABILITY_BURROWED))
		to_chat(src, SPAN_WARNING("我们无法从这里熔化[affected_atom]！"))
		return

	face_atom(affected_atom)

	var/wait_time = 10

	var/turf/turf = get_turf(affected_atom)

	for(var/obj/effect/xenomorph/acid/acid in turf)
		if(acid_type == acid.type && acid.acid_t == affected_atom)
			to_chat(src, SPAN_WARNING("[affected_atom]已经被酸液浸透了。"))
			return

	var/obj/object
	//OBJ CHECK
	if(isobj(affected_atom))
		object = affected_atom

		wait_time = object.get_applying_acid_time()
		if(wait_time == -1)
			to_chat(src, SPAN_WARNING("我们无法溶解[object]。"))
			return
	else
		to_chat(src, SPAN_WARNING("我们无法溶解[affected_atom]。"))
		return
	wait_time = wait_time / 4
	if(!do_after(src, wait_time, INTERRUPT_NO_NEEDHAND, BUSY_ICON_HOSTILE))
		return

	// AGAIN BECAUSE SOMETHING COULD'VE ACIDED THE PLACE
	for(var/obj/effect/xenomorph/acid/acid in turf)
		if(acid_type == acid.type && acid.acid_t == affected_atom)
			to_chat(src, SPAN_WARNING("[acid]已经被酸液浸透了。"))
			return

	if(!check_state())
		return

	if(!affected_atom || QDELETED(affected_atom)) //Some logic.
		return

	if(!affected_atom.Adjacent(src) || (object && !isturf(object.loc)))//not adjacent or inside something
		if(istype(affected_atom, /obj/item/explosive/plastic))
			var/obj/item/explosive/plastic/plastic_explosive = affected_atom
			if(plastic_explosive.plant_target && !plastic_explosive.plant_target.Adjacent(src))
				to_chat(src, SPAN_WARNING("我们无法触及[affected_atom]。"))
				return
		else
			to_chat(src, SPAN_WARNING("[affected_atom]距离太远。"))
			return

	var/datum/behavior_delegate/runner_acider/behavior_del = behavior_delegate
	if (!istype(behavior_del))
		return
	if(behavior_del.acid_amount < behavior_del.melt_acid_cost)
		to_chat(src, SPAN_XENOHIGHDANGER("储存的酸液不足！"))
		return

	behavior_del.modify_acid(-behavior_del.melt_acid_cost)

	var/obj/effect/xenomorph/acid/acid = new acid_type(turf, affected_atom)

	if(istype(affected_atom, /obj/vehicle/multitile))
		var/obj/vehicle/multitile/multitile_vehicle = affected_atom
		multitile_vehicle.take_damage_type(20 / acid.acid_delay, "acid", src)
		visible_message(SPAN_XENOWARNING("[src]向[multitile_vehicle]呕吐出大团污秽物。它在冒泡的酸液中发出嘶嘶声！"),
			SPAN_XENOWARNING("We vomit globs of vile stuff at [multitile_vehicle]. It sizzles under the bubbling mess of acid!"), null, 5)
		playsound(loc, "sound/bullets/acid_impact1.ogg", 25)
		QDEL_IN(acid, 20)
		return

	acid.add_hiddenprint(src)
	acid.name += " ([affected_atom])"

	visible_message(SPAN_XENOWARNING("[src]向[affected_atom]全身呕吐出大团污秽物。它在冒泡的酸液中开始嘶嘶作响并熔化！"),
	SPAN_XENOWARNING("We vomit globs of vile stuff all over [affected_atom]. It begins to sizzle and melt under the bubbling mess of acid!"), null, 5)
	playsound(loc, "sound/bullets/acid_impact1.ogg", 25)

#define ACIDER_ACID_LEVEL 3

/mob/living/carbon/xenomorph/runner/try_fill_trap(obj/effect/alien/resin/trap/target)
	if(!istype(strain, /datum/xeno_strain/acider))
		return ..()

	if(!istype(target))
		return FALSE

	var/datum/behavior_delegate/runner_acider/behavior_del = behavior_delegate
	if(!istype(behavior_del))
		return FALSE

	if(behavior_del.acid_amount < behavior_del.fill_acid_cost)
		to_chat(src, SPAN_XENOHIGHDANGER("储存的酸液不足！"))
		return FALSE

	var/trap_acid_level = 0
	if(target.trap_type >= RESIN_TRAP_ACID1)
		trap_acid_level = 1 + target.trap_type - RESIN_TRAP_ACID1

	if(trap_acid_level >= ACIDER_ACID_LEVEL) // Acid runners apply /obj/effect/xenomorph/acid/strong generally
		to_chat(src, SPAN_XENONOTICE("它里面已经有足够的酸液了。"))
		return FALSE

	to_chat(src, SPAN_XENONOTICE("你开始用酸液给树脂陷阱加压。"))
	xeno_attack_delay(src)
	if(!do_after(src, 3 SECONDS, INTERRUPT_NO_NEEDHAND, BUSY_ICON_HOSTILE, src))
		return FALSE

	if(target.trap_type >= RESIN_TRAP_ACID1)
		trap_acid_level = 1 + target.trap_type - RESIN_TRAP_ACID1

	if(trap_acid_level >= ACIDER_ACID_LEVEL)
		return FALSE

	if(behavior_del.acid_amount < behavior_del.fill_acid_cost)
		to_chat(src, SPAN_XENOHIGHDANGER("储存的酸液不足！"))
		return FALSE

	behavior_del.modify_acid(-behavior_del.fill_acid_cost)

	target.cause_data = create_cause_data("resin acid trap", src)
	target.setup_tripwires()
	target.set_state(RESIN_TRAP_ACID1 + ACIDER_ACID_LEVEL - 1)

	playsound(target, 'sound/effects/refill.ogg', 25, 1)
	visible_message(SPAN_XENOWARNING("[src]用酸液给树脂陷阱加压！"),
	SPAN_XENOWARNING("You pressurise the resin trap with acid!"), null, 5)
	return TRUE

#undef ACIDER_ACID_LEVEL

/datum/action/xeno_action/activable/acider_for_the_hive/use_ability(atom/affected_atom)
	var/mob/living/carbon/xenomorph/xeno = owner

	if(!istype(xeno))
		return

	if(!isturf(xeno.loc))
		to_chat(xeno, SPAN_XENOWARNING("这里太狭窄，无法激活此能力！"))
		return

	var/area/xeno_area = get_area(xeno)
	if(xeno_area.flags_area & AREA_CONTAINMENT)
		to_chat(xeno, SPAN_XENOWARNING("我们无法在此处激活！"))
		return

	if(!xeno.check_state())
		return

	if(!action_cooldown_check())
		return

	var/datum/behavior_delegate/runner_acider/behavior_delegate = xeno.behavior_delegate
	if(!istype(behavior_delegate))
		return

	if(behavior_delegate.caboom_trigger)
		cancel_ability()
		return

	if(behavior_delegate.acid_amount < minimal_acid)
		to_chat(xeno, SPAN_XENOWARNING("积聚的酸液不足以引发爆炸。"))
		return

	notify_ghosts(header = "为了巢穴！", message = "[xeno] is going to explode for the Hive!", source = xeno, action = NOTIFY_ORBIT)

	to_chat(xeno, SPAN_XENOWARNING("我们的胃开始翻腾扭曲，准备压缩积聚的酸液。"))
	xeno.color = "#22FF22"
	xeno.set_light_color("#22FF22")
	xeno.set_light_range(3)

	behavior_delegate.caboom_trigger = TRUE
	behavior_delegate.caboom_left = behavior_delegate.caboom_timer
	behavior_delegate.caboom_last_proc = 0
	xeno.set_effect(behavior_delegate.caboom_timer*2, SUPERSLOW)

	START_PROCESSING(SSfasteffects, src)

	xeno.say("；为了巢穴！！！")
	return ..()

/datum/action/xeno_action/activable/acider_for_the_hive/proc/cancel_ability()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!istype(xeno))
		return
	var/datum/behavior_delegate/runner_acider/behavior_delegate = xeno.behavior_delegate
	if(!istype(behavior_delegate))
		return

	behavior_delegate.caboom_trigger = FALSE
	xeno.color = null
	xeno.set_light_range(0)
	behavior_delegate.modify_acid(-behavior_delegate.max_acid / 4)

	// Done this way rather than setting to 0 in case something else slowed us
	// -Original amount set - (time exploding + timer inaccuracy) * how much gets removed per tick / 2
	xeno.adjust_effect(behavior_delegate.caboom_timer * -2 - (behavior_delegate.caboom_timer - behavior_delegate.caboom_left + 2) * xeno.life_slow_reduction * 0.5, SUPERSLOW)

	to_chat(xeno, SPAN_XENOWARNING("我们在其爆炸前清除了所有爆炸性酸液。"))

	STOP_PROCESSING(SSfasteffects, src)
	button.set_maptext()

/datum/action/xeno_action/activable/acider_for_the_hive/process(delta_time)
	return update_caboom_maptext()

/datum/action/xeno_action/activable/acider_for_the_hive/proc/update_caboom_maptext()
	var/mob/living/carbon/xenomorph/xeno = owner
	var/datum/behavior_delegate/runner_acider/delegate = xeno.behavior_delegate
	if(!istype(delegate) || !delegate.caboom_trigger || delegate.caboom_left <= 0)
		button.set_maptext()
		return PROCESS_KILL

	button.set_maptext(SMALL_FONTS_COLOR(7, delegate.caboom_left, "#e69d00"), 19, 2)
	return
