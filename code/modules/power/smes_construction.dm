// Constructable SMES version. Based on Coils. Each SMES can hold 6 Coils by default.
// Each coil adds 250kW I/O and 5M capacity.
// This is second version, now subtype of regular SMES.




// SMES itself
/obj/structure/machinery/power/smes/buildable
	var/max_coils = 6 //30M capacity, 1.5MW input/output when fully upgraded /w default coils
	var/cur_coils = 1 // Current amount of installed coils
	var/safeties_enabled = 1 // If 0 modifications can be done without discharging the SMES, at risk of critical failure.
	var/failing = 0 // If 1 critical failure has occurred and SMES explosion is imminent.
	should_be_mapped = 1
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/machinery/power/smes/buildable/charged
	charge = 1e+006

/obj/structure/machinery/power/smes/buildable/Initialize()
	. = ..()
	QDEL_NULL_LIST(component_parts)
	LAZYADD(component_parts, new /obj/item/stack/cable_coil(src,30))
	LAZYADD(component_parts, new /obj/item/circuitboard/machine/smes(src))

	// Allows for mapped-in SMESs with larger capacity/IO
	for(var/i = 1, i <= cur_coils, i++)
		LAZYADD(component_parts, new /obj/item/stock_parts/smes_coil(src))

	recalc_coils()

/obj/structure/machinery/power/smes/buildable/proc/recalc_coils()
	if ((cur_coils <= max_coils) && (cur_coils >= 1))
		capacity = 0
		input_level_max = 0
		output_level_max = 0
		for(var/obj/item/stock_parts/smes_coil/C in component_parts)
			capacity += C.ChargeCapacity
			input_level_max += C.IOCapacity
			output_level_max += C.IOCapacity
		charge = clamp(charge, 0, capacity)
		return 1
	else
		return 0

	// SMESs store very large amount of power. If someone screws up (ie: Disables safeties and attempts to modify the SMES) very bad things happen.
	// Bad things are based on charge percentage.
	// Possible effects:
	// Sparks - Lets out few sparks, mostly fire hazard if phoron present. Otherwise purely aesthetic.
	// Shock - Depending on intensity harms the user. Insultated Gloves protect against weaker shocks, but strong shock bypasses them.
	// EMP Pulse - Lets out EMP pulse discharge which screws up nearby electronics.
	// Light Overload - X% chance to overload each lighting circuit in connected powernet. APC based.
	// APC Failure - X% chance to destroy APC causing very weak explosion too. Won't cause hull breach or serious harm.
	// SMES Explosion - X% chance to destroy the SMES, in moderate explosion. May cause small hull breach.
/obj/structure/machinery/power/smes/buildable/proc/total_system_failure(intensity = 0, mob/user as mob)
	if (!intensity)
		return

	var/mob/living/carbon/human/h_user = null
	if (!istype(user, /mob/living/carbon/human))
		return
	else
		h_user = user


	// Preparations
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	// Check if user has protected gloves.
	var/user_protected = 0
	if(h_user.gloves)
		var/obj/item/clothing/gloves/G = h_user.gloves
		if(G.siemens_coefficient == 0)
			user_protected = 1
	log_game("SMES FAILURE: <b>[src.x]X [src.y]Y [src.z]Z</b> User: [usr.ckey], Intensity: [intensity]/100")
	message_admins("SMES FAILURE: <b>[src.x]X [src.y]Y [src.z]Z</b> User: [usr.ckey], Intensity: [intensity]/100 [ADMIN_JMP(src)]")


	switch (intensity)
		if (0 to 15)
			// Small overcharge
			// Sparks, Weak shock
			s.set_up(2, 1, src)
			s.start()
			if (user_protected && prob(80))
				to_chat(h_user, "小型电弧差点灼伤你的手。幸好你戴着手套！")
			else
				to_chat(h_user, "当你触碰[src]时，小型电弧迸发并灼伤了你的手！")
				h_user.apply_damage(rand(5,10), BURN)
				h_user.apply_effect(2, PARALYZE)
			charge = 0

		if (16 to 35)
			// Medium overcharge
			// Sparks, Medium shock, Weak EMP
			s.set_up(4,1,src)
			s.start()
			if (user_protected && prob(25))
				to_chat(h_user, "中型电弧迸发，差点灼伤你的手。幸好你戴着手套！")
			else
				to_chat(h_user, "当你触碰[src]时，中型电弧迸发，严重灼伤了你的手！")
				h_user.apply_damage(rand(10,25), BURN)
				h_user.apply_effect(5, PARALYZE)
			spawn(0)
				empulse(src.loc, 2, 4)
			charge = 0

		if (36 to 60)
			// Strong overcharge
			// Sparks, Strong shock, Strong EMP, 10% light overload. 1% APC failure
			s.set_up(7,1,src)
			s.start()
			if (user_protected)
				to_chat(h_user, "强电弧在你和[src]之间迸发，无视了你的手套并灼伤了你的手！")
				h_user.apply_damage(rand(25,60), BURN)
				h_user.apply_effect(8, PARALYZE)
			else
				to_chat(user, "强电弧在你和[src]之间迸发，将你击晕了片刻！")
				h_user.apply_damage(rand(35,75), BURN)
				h_user.apply_effect(12, PARALYZE)
			spawn(0)
				empulse(src.loc, 8, 16)
			charge = 0
			apcs_overload(1, 10)
			src.ping("Caution. Output regulators malfunction. Uncontrolled discharge detected.")

		if (61 to INFINITY)
			// Massive overcharge
			// Sparks, Near - instantkill shock, Strong EMP, 25% light overload, 5% APC failure. 50% of SMES explosion. This is bad.
			s.set_up(10,1,src)
			s.start()
			to_chat(h_user, "巨大的电弧在你和[src]之间迸发。你最后能想到的是\"Oh shit...\"")
			// Remember, we have few gigajoules of electricity here... Turn them into crispy toast.
			h_user.apply_damage(rand(150,195), BURN)
			h_user.apply_effect(25, PARALYZE)
			spawn(0)
				empulse(src.loc, 32, 64)
			charge = 0
			apcs_overload(5, 25)
			src.ping("Caution. Output regulators malfunction. Significant uncontrolled discharge detected.")

			if (prob(50))
				// Added admin-notifications so they can stop it when griffed.
				log_game("SMES explosion imminent.")
				message_admins("SMES explosion imminent.")
				src.ping("DANGER! Magnetic containment field unstable! Containment field failure imminent!")
				failing = 1
				// 30 - 60 seconds and then BAM!
				spawn(rand(300,600))
					if(!failing) // Admin can manually set this var back to 0 to stop overload, for use when griffed.
						update_icon()
						src.ping("Magnetic containment stabilised.")
						return
					src.ping("DANGER! Magnetic containment field failure in 3 ... 2 ... 1 ...")
					explosion(src.loc,1,2,4,8)
					// Not sure if this is necessary, but just in case the SMES *somehow* survived..
					qdel(src)



	// Gets powernet APCs and overloads lights or breaks the APC completely, depending on percentages.
/obj/structure/machinery/power/smes/buildable/proc/apcs_overload(failure_chance, overload_chance)
	if (!src.powernet)
		return

	for(var/obj/structure/machinery/power/apc/apc in src.powernet.nodes)
		if (prob(overload_chance))
			apc.overload_lighting()
		if (prob(failure_chance))
			apc.set_broken()

	// Failing SMES has special icon overlay.
/obj/structure/machinery/power/smes/buildable/updateicon()
	if (failing)
		overlays.Cut()
		overlays += image('icons/obj/structures/machinery/power.dmi', "smes_crit")
	else
		..()

/obj/structure/machinery/power/smes/buildable/attackby(obj/item/W as obj, mob/user as mob)
	// No more disassembling of overloaded SMESs. You broke it, now enjoy the consequences.
	if (failing)
		to_chat(user, SPAN_WARNING("[src]的屏幕正闪烁着警报。它似乎过载了！现在触碰它可能不是个好主意。"))
		return
	// If parent returned 1:
	// - Hatch is open, so we can modify the SMES
	// - No action was taken in parent function (terminal de/construction atm).
	. = ..()
	if (.)

		// Charged above 1% and safeties are enabled.
		if((charge > (capacity/100)) && safeties_enabled && !HAS_TRAIT(W, TRAIT_TOOL_MULTITOOL))
			to_chat(user, SPAN_WARNING("[src]的安全电路在其充电时阻止修改！"))
			return

		if (outputting || input_attempt)
			to_chat(user, SPAN_WARNING("先关闭[src]！"))
			return

		// Probability of failure if safety circuit is disabled (in %)
		var/failure_probability = floor((charge / capacity) * 100)

		// If failure probability is below 5% it's usually safe to do modifications
		if (failure_probability < 5)
			failure_probability = 0

		// Crowbar - Disassemble the SMES.
		if(HAS_TRAIT(W, TRAIT_TOOL_CROWBAR))
			if (terminal)
				to_chat(user, SPAN_WARNING("你必须先拆解终端！"))
				return

			playsound(get_turf(src), 'sound/items/Crowbar.ogg', 25, 1)
			to_chat(user, SPAN_WARNING("你开始拆解[src]！"))
			if (do_after(usr, 100 * cur_coils * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD)) // More coils = takes longer to disassemble. It's complex so largest one with 5 coils will take 50s

				if (failure_probability && prob(failure_probability))
					total_system_failure(failure_probability, user)
					return

				to_chat(usr, SPAN_DANGER("你已拆解SMES电池单元！"))
				var/obj/structure/machinery/constructable_frame/M = new /obj/structure/machinery/constructable_frame(src.loc)
				M.state = CONSTRUCTION_STATE_PROGRESS
				M.update_icon()
				for(var/obj/I in component_parts)
					if(I.reliability != 100 && crit_fail)
						I.crit_fail = 1
					I.forceMove(src.loc)
				qdel(src)
				return

		// Superconducting Magnetic Coil - Upgrade the SMES
		else if(istype(W, /obj/item/stock_parts/smes_coil))
			if (cur_coils < max_coils)

				if (failure_probability && prob(failure_probability))
					total_system_failure(failure_probability, user)
					return

				to_chat(usr, "你将线圈安装到SMES单元中！")
				if(user.drop_inv_item_to_loc(W, src))
					cur_coils ++
					LAZYADD(component_parts, W)
					recalc_coils()
			else
				to_chat(usr, SPAN_DANGER("你无法向此SMES单元插入更多线圈！"))

		// Multitool - Toggle the safeties.
		else if(HAS_TRAIT(W, TRAIT_TOOL_MULTITOOL))
			safeties_enabled = !safeties_enabled
			to_chat(user, SPAN_WARNING("You [safeties_enabled ? "connected" : "disconnected"] the safety circuit."))
			src.visible_message("[icon2html(src, viewers(src))] <b>[src]</b> beeps: \"Caution. Safety circuit has been: [safeties_enabled ? "re-enabled" : "disabled. Please excercise caution."]\"")
