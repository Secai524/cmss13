//Reactor damage states
#define BUILDSTATE_FUNCTIONAL 0
#define BUILDSTATE_DAMAGE_WRENCH 1
#define BUILDSTATE_DAMAGE_WIRE 2
#define BUILDSTATE_DAMAGE_WELD 3

//How often it checks if the reactor has failed
#define REACTOR_FAIL_CHECK_TICKS 100

/obj/structure/machinery/power/power_generator/reactor
	name = "\improper S-52 fusion reactor"
	icon = 'icons/obj/structures/machinery/fusion_eng.dmi'
	icon_state = "off"
	desc = "一台威斯汀兰S-52聚变反应堆。"
	directwired = FALSE  //Requires a cable directly underneath
	unslashable = TRUE
	unacidable = TRUE
	anchored = TRUE
	density = TRUE
	throwpass = FALSE
	power_gen = 50000 //50,000W

	///Whether the reactor is on the ship
	var/is_ship_reactor = FALSE
	///Whether the reactor is guaranteed to be fully repaired
	var/is_reserved_level = FALSE
	///If the generator is overloaded
	var/overloaded = FALSE //Only possible during hijack once fuel is at 100%

	///How damaged the reactor is
	var/buildstate = BUILDSTATE_FUNCTIONAL

	///Original fail rate of the reactor
	var/original_fail_rate = 0
	///% chance of the reactor failing every check_failure
	var/fail_rate = 0
	///How often the reactor checks if it can fail
	var/fail_check_ticks = REACTOR_FAIL_CHECK_TICKS
	///How many ticks since last fail check
	var/cur_tick = 0 //Tick updater

	///All icon states split by power_gen_percent
	var/list/power_percent_states = list(10, 25, 50, 75, 100) //Easier to add more icon states to one without also adding them to the other

	///Whether the reactor requires a fusion cell
	var/require_fusion_cell = TRUE
	///The reactors fuel cell, fail rate increases if empty
	var/obj/item/fuel_cell/fusion_cell

/obj/structure/machinery/power/power_generator/reactor/Initialize(mapload, ...)
	. = ..()
	if(is_mainship_level(z)) //Only ship reactors can overload
		is_ship_reactor = TRUE

	if(!buildstate && is_ground_level(z)) //Colony reactors start damaged
		switch(rand(1, 6))
			if(1 to 3) //50%
				buildstate = BUILDSTATE_DAMAGE_WELD
			if(4 to 5) //34%
				buildstate = BUILDSTATE_DAMAGE_WIRE
			if(6) //16%
				buildstate = BUILDSTATE_DAMAGE_WRENCH

	if(!buildstate && is_reserved_level(z))
		buildstate = BUILDSTATE_FUNCTIONAL

	if(require_fusion_cell) //Set up fuel cell if needed
		fusion_cell = new /obj/item/fuel_cell/used(src)
		fusion_cell.fuel_amount = fusion_cell.max_fuel_amount

	fail_rate = original_fail_rate
	update_icon()

	if(is_on)
		start_processing()

	return INITIALIZE_HINT_ROUNDSTART

/obj/structure/machinery/power/power_generator/reactor/LateInitialize() //Need to wait for powernets to start existing first
	. = ..()

	if(QDELETED(src))
		return
	if(powernet)
		return

	if(!connect_to_network()) //Make sure its connected to a powernet
		CRASH("[src] has failed to connect to a power network. Check that it has been mapped correctly.")

/obj/structure/machinery/power/power_generator/reactor/Destroy()
	QDEL_NULL(fusion_cell)
	return ..()

/obj/structure/machinery/power/power_generator/reactor/get_examine_text(mob/user)
	. = ..()

	if(!is_on)
		. += SPAN_INFO("It is offline.")

	if(!ishuman(user))
		return
	if(is_on)
		. += SPAN_INFO("The power gauge reads: [power_gen_percent]%")

	switch(buildstate)
		if(BUILDSTATE_DAMAGE_WELD)
			. += SPAN_INFO(SPAN_BOLD("Use a blowtorch to repair it."))
		if(BUILDSTATE_DAMAGE_WIRE)
			. += SPAN_INFO(SPAN_BOLD("Use wirecutters to repair it."))
		if(BUILDSTATE_DAMAGE_WRENCH)
			. += SPAN_INFO(SPAN_BOLD("使用扳手来修复它。"))

	if(buildstate || require_fusion_cell && !HasFuel())
		if(is_on)
			. += SPAN_INFO("The emergency shutdown button is visible.")
		else
			. += SPAN_INFO("The emergency start lever is visible.")

	if(!fusion_cell)
		. += SPAN_INFO("There is no fuel cell in it.")
	else
		switch(fusion_cell.get_fuel_percent())
			if(-INFINITY to 0)
				. += SPAN_INFO("[fusion_cell] is empty.")
			if(1 to 9)
				. += SPAN_INFO("[fusion_cell] is critically low.")
			if(10 to 24)
				. += SPAN_INFO("[fusion_cell] is low.")
			if(25 to 49)
				. += SPAN_INFO("[fusion_cell] is less than half full.")
			if(50 to 74)
				. += SPAN_INFO("[fusion_cell] is over half full.")
			if(75 to 99)
				. += SPAN_INFO("[fusion_cell] is nearly full.")
			if(99 to INFINITY)
				. += SPAN_INFO("[fusion_cell] is full.")

	if(is_ship_reactor && SShijack.sd_unlocked)
		if(overloaded)
			. += SPAN_INFO("It is overloaded.")
			return
		if(skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
			. += SPAN_INFO("You could overload its safeties with a multitool.")

/obj/structure/machinery/power/power_generator/reactor/power_change()
	. = ..()
	if(overloaded)
		set_overloading(FALSE)
		visible_message(SPAN_NOTICE("随着主电源的丢失，[src]的过载突然停止了。"))

/obj/structure/machinery/power/power_generator/reactor/HasFuel()
	return fusion_cell && fusion_cell.fuel_amount > 0

/obj/structure/machinery/power/power_generator/reactor/process()
	if(!is_on) //if off, turn off
		start_functioning(FALSE)
		return

	if(buildstate)
		if(require_fusion_cell) //if broken and fuel cell, lose fuel
			if(fusion_cell && fusion_cell.fuel_amount)
				fusion_cell.modify_fuel(rand(-5, -20))
				visible_message(SPAN_DANGER("[src]嘶嘶作响，燃料开始在其周围积聚。"))
		else //Otherwise just start to break down faster
			visible_message(SPAN_DANGER("[src]迸出火花并停止了运转。"))
			fail_rate += 2.5

	if(require_fusion_cell && !HasFuel()) //empty fuel
		if(prob(20))
			visible_message(SPAN_DANGER("[src]闪烁显示燃料单元[fusion_cell ? "empty" : "missing"] as the engine seizes."))
		fail_rate += 2.5

	if(overloaded && prob(1)) // up to 18 generators at 1% every 3.5 seconds means that every ~21 seconds or so, one generator will make noise assuming all are overloaded
		if(prob(50))
			visible_message(SPAN_NOTICE("[src]发出响亮的嗡鸣声。"))
			playsound(src, 'sound/machines/resource_node/node_idle.ogg', 60, TRUE)
		else
			visible_message(SPAN_NOTICE("[src]发出令人不安的嘶嘶声。"))
			playsound(src, 'sound/machines/hiss.ogg', 60, TRUE)

	if(power_gen_percent < 100)
		power_gen_percent = min(power_gen_percent + 1, 100)

	add_avail(power_gen * (power_gen_percent / 100))
	check_failure(buildstate > BUILDSTATE_DAMAGE_WIRE || require_fusion_cell && !HasFuel())
	update_icon()

/obj/structure/machinery/power/power_generator/reactor/proc/check_failure(damaged_reactor = FALSE)
	if(cur_tick < fail_check_ticks) //Nope, not time for it yet
		cur_tick++
		if(damaged_reactor)
			cur_tick += fail_check_ticks/5 //fail much faster if damaged
		return
	cur_tick = 0 //reset the timer

	fail_rate = clamp(fail_rate, 0, 100)
	if(!prob(fail_rate)) //Oh snap, we failed! Shut it down!
		return

	visible_message(SPAN_DANGER("[src]停止运转并发生故障。"))
	if(buildstate >= BUILDSTATE_DAMAGE_WELD)
		start_functioning(FALSE)
	buildstate = clamp(buildstate + 1, BUILDSTATE_FUNCTIONAL, BUILDSTATE_DAMAGE_WELD)

/obj/structure/machinery/power/power_generator/reactor/attack_hand(mob/user)
	. = TRUE
	if(overloaded)
		to_chat(user, SPAN_DANGER("[src]没有响应你关闭反应堆的尝试。"))
		return FALSE
	add_fingerprint(user)

	if(buildstate || require_fusion_cell && !HasFuel())
		if(is_on)
			to_chat(user, SPAN_NOTICE("你按下了[src]的紧急关闭按钮。"))
			visible_message(SPAN_NOTICE("[user]按下了[src]的紧急关闭按钮。"))
			start_functioning(FALSE)
			return

		visible_message(SPAN_NOTICE("[user]开始握住[src]的紧急启动杆。"))
		if(!do_after(user, 3 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD, src))
			to_chat(user, SPAN_NOTICE("你松开了紧急启动杆。"))
			return FALSE
		start_functioning(TRUE)
		return

	if(is_on)
		visible_message(SPAN_WARNING("随着[user]关闭发电机，[src]发出轻柔的哔哔声并停止了嗡鸣。"))
		start_functioning(FALSE)
		return

	visible_message(SPAN_NOTICE("随着[user]启动反应堆，[src]发出响亮的哔哔声。"))
	start_functioning(TRUE)

/obj/structure/machinery/power/power_generator/reactor/attack_alien(mob/living/carbon/xenomorph/xeno)
	. = XENO_NONCOMBAT_ACTION
	if(buildstate >= BUILDSTATE_DAMAGE_WELD)
		to_chat(xeno, SPAN_WARNING("你认为没有理由攻击[src]。"))
		return

	if(xeno.action_busy)
		to_chat(xeno, SPAN_WARNING("你在做其他事情时无法损坏[src]。"))
		return

	if(overloaded)
		xeno.animation_attack_on(src)
		playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
		xeno.visible_message(SPAN_DANGER("[xeno][xeno.slashes_verb]了[src]，阻止了它的过载进程！"),
		SPAN_DANGER("You [xeno.slash_verb] [src], stopping its overload process!"), null, 5, CHAT_TYPE_XENO_COMBAT)
		set_overloading(FALSE)
		return

	var/looping = FALSE
	while(buildstate < BUILDSTATE_DAMAGE_WELD)
		to_chat(xeno, SPAN_NOTICE("你[looping ? "continue damaging" : "start to damage"] [src]."))
		if(!do_after(xeno, 10 SECONDS, INTERRUPT_ALL, BUSY_ICON_HOSTILE, src))
			to_chat(xeno, SPAN_DANGER("你停止损坏[src]。"))
			break
		xeno.animation_attack_on(src)
		playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
		xeno.visible_message(SPAN_DANGER("[xeno][xeno.slashes_verb]了[src]，[is_on ? "disabling" : "damaging"] it!"))
		switch(buildstate)
			if(BUILDSTATE_FUNCTIONAL)
				visible_message(SPAN_DANGER("[src]开始解体！"))
			if(BUILDSTATE_DAMAGE_WRENCH)
				visible_message(SPAN_DANGER("[src]迸出火花，电线脱落！"))
			if(BUILDSTATE_DAMAGE_WIRE)
				visible_message(SPAN_DANGER("[src]被撕碎了！"))
		buildstate = clamp(buildstate + 1, BUILDSTATE_FUNCTIONAL, BUILDSTATE_DAMAGE_WELD)
		update_icon()
		looping = TRUE

/obj/structure/machinery/power/power_generator/reactor/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	return TAILSTAB_COOLDOWN_NONE

/obj/structure/machinery/power/power_generator/reactor/attackby(obj/item/attacking_item, mob/user)
	//Fuel Cells
	if(user.action_busy)
		return

	if(istype(attacking_item, /obj/item/fuel_cell))
		var/obj/item/fuel_cell/cell = attacking_item
		if(fusion_cell)
			to_chat(user, SPAN_WARNING("[src]已经装有[fusion_cell]。在你用[cell]替换它之前，你需要用撬棍将其移除。"))
			return

		to_chat(user, SPAN_NOTICE("你开始将[cell]插入[src]。"))
		if(!do_after(user, 10 SECONDS * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL, BUSY_ICON_BUILD, src))
			return

		if(!user.drop_inv_item_to_loc(cell, src))
			to_chat(user, SPAN_NOTICE("你未能将[cell]插入[src]。"))
			return
		to_chat(user, SPAN_NOTICE("你将[cell]插入[src]。"))
		fusion_cell = cell
		update_icon()
		if(cell.new_cell)
			fail_rate = original_fail_rate
			cell.new_cell = FALSE
		return

	if(HAS_TRAIT(attacking_item, TRAIT_TOOL_CROWBAR))
		if(!fusion_cell)
			to_chat(user, SPAN_WARNING("[src]中没有可移除的燃料电池。"))
			return

		to_chat(user, SPAN_NOTICE("你开始从[src]中撬出[fusion_cell]。"))
		if(!do_after(user, 10 SECONDS * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL, BUSY_ICON_BUILD, src))
			return

		to_chat(user, SPAN_NOTICE("你从[src]中移除了[fusion_cell]。"))
		fusion_cell.update_icon()
		user.put_in_hands(fusion_cell)
		fusion_cell = null
		update_icon()
		return

	//Repairing
	if(HAS_TRAIT(attacking_item, TRAIT_TOOL_BLOWTORCH))
		if(!attempt_repair(attacking_item, BUILDSTATE_DAMAGE_WELD, user))
			return
		var/obj/item/tool/weldingtool/welder = attacking_item
		if(!welder.remove_fuel(1, user))
			return
		playsound(loc, 'sound/items/Welder2.ogg', 25, 1)
		buildstate = BUILDSTATE_DAMAGE_WIRE
		update_icon()
		return

	if(HAS_TRAIT(attacking_item, TRAIT_TOOL_WIRECUTTERS))
		if(!attempt_repair(attacking_item, BUILDSTATE_DAMAGE_WIRE, user))
			return
		playsound(loc, 'sound/items/Wirecutter.ogg', 25, 1)
		buildstate = BUILDSTATE_DAMAGE_WRENCH
		update_icon()
		return

	if(HAS_TRAIT(attacking_item, TRAIT_TOOL_WRENCH))
		if(!attempt_repair(attacking_item, BUILDSTATE_DAMAGE_WRENCH, user))
			return
		playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
		buildstate = BUILDSTATE_FUNCTIONAL
		update_icon()
		return

	//Self Destruct
	if(HAS_TRAIT(attacking_item, TRAIT_TOOL_MULTITOOL))
		if(!SShijack.sd_unlocked)
			return
		if(!is_ship_reactor)
			return

		if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
			return

		to_chat(user, SPAN_WARNING("你开始[overloaded ? "restoring" : "overloading"] the safeties on [src]."))
		if(!do_after(user, 2 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD))
			return

		if(inoperable())
			to_chat(user, SPAN_WARNING("[src]需要处于工作状态并连接外部电源才能[overloaded ? "restored" : "overloaded"]."))
			return

		set_overloading(!overloaded)
		to_chat(user, SPAN_WARNING("你完成了[overloaded ? "overloading" : "restoring"] the safeties on [src]."))
		log_game("[key_name(user)] has [overloaded ? "overloaded" : "restored the safeties of"] a generator.")
		return

	. = ..()

/obj/structure/machinery/power/power_generator/reactor/update_icon()
	switch(buildstate)
		if(BUILDSTATE_DAMAGE_WELD)
			icon_state = "weld"
		if(BUILDSTATE_DAMAGE_WIRE)
			icon_state = "wire"
		if(BUILDSTATE_DAMAGE_WRENCH)
			icon_state = "wrench"
	if(buildstate)
		return

	if(!is_on)
		icon_state = "off"
		return

	if(require_fusion_cell && !fusion_cell)
		icon_state = "cell_missing"
		return

	if(overloaded)
		icon_state = "overloaded"
		return

	var/abs_percent = 100
	var/closest_percent
	for(var/current_percent in power_percent_states)
		if(abs(current_percent-power_gen_percent) >= abs_percent)
			continue
		abs_percent = abs(current_percent-power_gen_percent)
		closest_percent = current_percent
		if(!abs_percent)
			break
	icon_state = "on-[closest_percent]"

/obj/structure/machinery/power/power_generator/reactor/ex_act(severity)
	. = FALSE
	if(severity <= EXPLOSION_THRESHOLD_MLOW)
		return

	var/datum/effect_system/spark_spread/sparks = new
	sparks.set_up(7, FALSE, loc)
	buildstate = clamp(buildstate + 1, BUILDSTATE_FUNCTIONAL, BUILDSTATE_DAMAGE_WELD)
	sparks.start()

	if(!overloaded)
		return
	set_overloading(FALSE)

/obj/structure/machinery/power/power_generator/reactor/bullet_act(obj/projectile/bullet)
	. = ..()
	if(buildstate >= BUILDSTATE_DAMAGE_WELD)
		return
	if(!prob(5))
		return

	var/datum/effect_system/spark_spread/sparks = new
	sparks.set_up(7, FALSE, loc)
	buildstate = clamp(buildstate + 1, BUILDSTATE_FUNCTIONAL, BUILDSTATE_DAMAGE_WELD)
	sparks.start()

/obj/structure/machinery/power/power_generator/reactor/proc/start_functioning(enabling)
	if(enabling)
		is_on = TRUE
		start_processing()
		update_icon()
		return
	is_on = FALSE
	power_gen_percent = 0
	cur_tick = 0
	set_overloading(FALSE)
	update_icon()

/obj/structure/machinery/power/power_generator/reactor/proc/attempt_repair(obj/item/tool, repair_type, mob/user)
	if(!tool || !repair_type)
		return
	if(!buildstate)
		to_chat(user, SPAN_NOTICE("[src]不需要修理。"))
		return
	if(buildstate != repair_type)
		to_chat(user, SPAN_WARNING("你需要其他工具来修理[src]。"))
		return

	var/repair_time = 20 SECONDS
	repair_time *= user.get_skill_duration_multiplier(SKILL_ENGINEER)
	if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
		repair_time += 5 SECONDS

	switch(repair_type)
		if(BUILDSTATE_DAMAGE_WELD)
			playsound(loc, 'sound/items/Welder.ogg', 25, 1)
		if(BUILDSTATE_DAMAGE_WIRE)
			playsound(loc, 'sound/items/Wirecutter.ogg', 25, 1)
		if(BUILDSTATE_DAMAGE_WRENCH)
			playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)

	to_chat(user, SPAN_NOTICE("你开始用[tool]修理[src]。"))
	if(!do_after(user, repair_time, INTERRUPT_ALL, BUSY_ICON_BUILD, src))
		return

	return TRUE

/obj/structure/machinery/power/power_generator/reactor/proc/set_overloading(new_overloading)
	if(!is_ship_reactor)
		return
	if(overloaded == new_overloading)
		return

	overloaded = new_overloading
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_GENERATOR_SET_OVERLOADING, overloaded)
	update_icon()

/obj/structure/machinery/power/power_generator/reactor/colony
	name = "\improper G-11 geothermal generator"
	icon = 'icons/obj/structures/machinery/geothermal.dmi'
	desc = "一个位于充满等离子体的钻孔顶部的热电发电机。"

	is_on = FALSE
	power_gen = 100000 //100,000W at full capacity
	original_fail_rate = 10

/obj/structure/machinery/power/power_generator/reactor/rostock
	name = "\improper RDS-168 fusion reactor"
	desc = "一台RDS-168聚变反应堆。"


#undef BUILDSTATE_FUNCTIONAL
#undef BUILDSTATE_DAMAGE_WELD
#undef BUILDSTATE_DAMAGE_WIRE
#undef BUILDSTATE_DAMAGE_WRENCH
#undef REACTOR_FAIL_CHECK_TICKS
