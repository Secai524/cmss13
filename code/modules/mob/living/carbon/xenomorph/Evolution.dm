//Xenomorph Evolution Code - Colonial Marines - Apophis775 - Last Edit: 11JUN16

//Recoded and consolidated by Abby -- ALL evolutions come from here now. It should work with any caste, anywhere
//All castes need an evolves_to() list in their defines
//Such as evolves_to = list(XENO_CASTE_WARRIOR, XENO_CASTE_SENTINEL, XENO_CASTE_RUNNER, "Badass") etc

/// A list of ckeys that have been de-evolved willingly or forcefully
GLOBAL_LIST_EMPTY(deevolved_ckeys)

/mob/living/carbon/xenomorph/verb/Evolve()
	set name = "进化"
	set desc = "Evolve into a higher form."
	set category = "Alien"

	do_evolve()

/mob/living/carbon/xenomorph/proc/do_evolve()
	if(!evolve_checks())
		return
	var/mob/living/carbon/human/user = hauled_mob?.resolve()
	if(user)
		to_chat(src, "进化前先释放[user]！")
		return

	var/list/castes_available = caste.evolves_to.Copy()

	// Also offer queen to any tier 1 that can evolve at all if there isn't a queen
	if(tier == 1 && hive.allow_queen_evolve && !hive.living_xeno_queen)
		castes_available |= XENO_CASTE_QUEEN

	// Allow drones to evo into any T2 before first drop
	if(caste_type == XENO_CASTE_DRONE && !SSobjectives.first_drop_complete)
		castes_available = caste.early_evolves_to.Copy()

	castes_available -= hive.blacklisted_castes

	for(var/caste in castes_available)
		if(GLOB.xeno_datum_list[caste].minimum_evolve_time > ROUND_TIME)
			castes_available -= caste

	if(!length(castes_available))
		to_chat(src, SPAN_WARNING("巢穴目前无法支持我们能进化到的任何阶级。"))
		return

	var/castepick
	if((client.prefs && client.prefs.no_radials_preference) || !hive.evolution_menu_images)
		castepick = tgui_input_list(src, "你正在成长为一个美丽的异形！是时候选择一个阶级了。", "进化", castes_available, theme="hive_status")
	else
		var/list/fancy_caste_list = list()
		for(var/caste in castes_available)
			fancy_caste_list[caste] = hive.evolution_menu_images[caste]

		castepick = show_radial_menu(src, client?.get_eye(), fancy_caste_list)
	if(!castepick) //Changed my mind
		return

	if(SEND_SIGNAL(src, COMSIG_XENO_TRY_EVOLVE, castepick) & COMPONENT_OVERRIDE_EVOLVE)
		return // Message will be handled by component

	if(castepick in hive.blacklisted_castes)
		to_chat(src, SPAN_WARNING("巢穴无法支持这个阶级！"))
		return

	var/datum/caste_datum/caste_datum = GLOB.xeno_datum_list[castepick]
	if(caste_datum && caste_datum.minimum_evolve_time > ROUND_TIME)
		to_chat(src, SPAN_WARNING("巢穴目前还无法支持这个阶级！（剩余[floor((caste_datum.minimum_evolve_time - ROUND_TIME) / 10)]秒）"))
		return

	if(!evolve_checks())
		return

	if(!hive.living_xeno_queen && castepick != XENO_CASTE_QUEEN && !islarva(src) && !hive.allow_no_queen_evo)
		if(hive.xeno_queen_timer > world.time)
			to_chat(src, SPAN_WARNING("巢穴因最后一位女王的死亡而动摇。我们找不到进化的力量。"))
		else
			to_chat(src, SPAN_XENONOTICE("巢穴目前没有女王！我们找不到进化的力量。"))
		return

	if(castepick == XENO_CASTE_QUEEN) //Special case for dealing with queenae
		if(SSticker.mode && hive.xeno_queen_timer > world.time)
			to_chat(src, SPAN_WARNING("我们必须等待约[DisplayTimeText(hive.xeno_queen_timer - world.time, 1)]让巢穴从上一位女王的死亡中恢复。"))
			return

		var/required_plasma = min(500, plasma_max)
		if(plasma_stored >= required_plasma)
			if(hive.living_xeno_queen)
				to_chat(src, SPAN_WARNING("已经有一位活着的女王了。"))
				return
		else
			to_chat(src, SPAN_WARNING("我们需要更多等离子体！当前：[plasma_stored] / [required_plasma]。"))
			return

	if(Check_WO())
		if(castepick != XENO_CASTE_QUEEN) //Prevent evolutions into T2s and T3s in WO
			to_chat(src, SPAN_WARNING ("巢穴目前仅支持进化为女王！"))
			return
		on_mob_jump()
		forceMove(get_turf(pick(GLOB.queen_spawns)))
	else if(hardcore)
		to_chat(src, SPAN_WARNING("不行。"))
		return

	if(evolution_threshold && castepick != XENO_CASTE_QUEEN) //Does the caste have an evolution timer? Then check it
		if(evolution_stored < evolution_threshold)
			to_chat(src, SPAN_WARNING("我们必须等待进化时机。当前：[evolution_stored] / [evolution_threshold]。"))
			return

	var/mob/living/carbon/xenomorph/xeno_type = null
	xeno_type = GLOB.RoleAuthority.get_caste_by_text(castepick)

	if(isnull(xeno_type))
		to_chat(src, SPAN_WARNING("[castepick]不是有效的阶级！如果你看到这条信息，请通知程序员！"))
		return

	// Used for restricting benos to evolve to drone/queen when they're the only potential queen
	var/potential_queens = hive.get_potential_queen_count()

	if(!can_evolve(castepick, potential_queens))
		return
	to_chat(src, SPAN_XENONOTICE("看起来巢穴支持我们进化为<SPAN_BOLD(castepick)>！"))

	visible_message(SPAN_XENONOTICE("[src]开始扭曲变形。"),
	SPAN_XENONOTICE("We begin to twist and contort."))
	xeno_jitter(25)
	evolving = TRUE
	var/level_to_switch_to = get_vision_level()

	if(!do_after(src, 2.5 SECONDS, INTERRUPT_INCAPACITATED|INTERRUPT_CHANGED_LYING, BUSY_ICON_HOSTILE)) // Can evolve while moving, resist or rest to cancel it.
		to_chat(src, SPAN_WARNING("我们颤抖着，但无事发生。我们的进化暂时中止了..."))
		evolving = FALSE
		return

	evolving = FALSE

	if(!isturf(loc)) //qdel'd or moved into something
		return
	if(castepick == XENO_CASTE_QUEEN) //Do another check after the tick.
		if(jobban_isbanned(src, XENO_CASTE_QUEEN))
			to_chat(src, SPAN_WARNING("你已被禁止担任女王角色。"))
			return
		if(hive.living_xeno_queen)
			to_chat(src, SPAN_WARNING("已经存在一位女王了。"))
			return
		if(!hive.allow_queen_evolve)
			to_chat(src, SPAN_WARNING("我们找不到进化为女王的力量。"))
			return
	else if(!can_evolve(castepick, potential_queens))
		return

	// subtract the threshold, keep the stored amount
	evolution_stored -= evolution_threshold

	// don't drop their organ
	var/obj/item/organ/xeno/organ = locate() in src
	if(!isnull(organ))
		qdel(organ)

	//From there, the new xeno exists, hopefully
	var/mob/living/carbon/xenomorph/new_xeno = new xeno_type(get_turf(src), src)
	new_xeno.creation_time = creation_time

	if(!istype(new_xeno))
		//Something went horribly wrong!
		to_chat(src, SPAN_WARNING("这里出了严重问题。你的新异形为空！请立即通知程序员！"))
		stack_trace("Xeno evolution failed: [src] attempted to evolve into \'[castepick]\'")
		if(new_xeno)
			qdel(new_xeno)
		return

	var/area/xeno_area = get_area(new_xeno)
	if(!should_block_game_interaction(new_xeno) || (xeno_area.flags_atom & AREA_ALLOW_XENO_JOIN))
		switch(new_xeno.tier) //They have evolved, add them to the slot count IF they are in regular game space
			if(2)
				hive.tier_2_xenos |= new_xeno
			if(3)
				hive.tier_3_xenos |= new_xeno

	log_game("EVOLVE: [key_name(src)] evolved into [new_xeno].")
	if(mind)
		mind.transfer_to(new_xeno)
	else
		new_xeno.key = key
		if(new_xeno.client)
			new_xeno.client.change_view(GLOB.world_view_size)

	//Regenerate the new mob's name now that our player is inside
	new_xeno.generate_name()
	if(new_xeno.client)
		new_xeno.set_lighting_alpha(level_to_switch_to)
	if(new_xeno.health - getBruteLoss(src) - getFireLoss(src) > 0) //Cmon, don't kill the new one! Shouldn't be possible though
		new_xeno.bruteloss = bruteloss //Transfers the damage over.
		new_xeno.fireloss = fireloss //Transfers the damage over.
		new_xeno.updatehealth()

	if(plasma_max == 0)
		new_xeno.plasma_stored = new_xeno.plasma_max
	else
		new_xeno.plasma_stored = new_xeno.plasma_max*(plasma_stored/plasma_max) //preserve the ratio of plasma

	new_xeno.built_structures = built_structures.Copy()

	built_structures = null

	new_xeno.visible_message(SPAN_XENODANGER("一只[new_xeno.caste.caste_type]从[src]的残骸中钻出。"),
	SPAN_XENODANGER("We emerge in a greater form from the husk of our old body. For the hive!"))

	if(hive.living_xeno_queen && hive.living_xeno_queen.observed_xeno == src)
		hive.living_xeno_queen.overwatch(new_xeno)

	transfer_observers_to(new_xeno)
	new_xeno._status_traits = _status_traits

	// Freshly evolved xenos emerge standing.
	// This resets density and resting status traits.
	set_body_position(STANDING_UP)

	qdel(src)
	new_xeno.xeno_jitter(25)

	if (new_xeno.client)
		new_xeno.client.mouse_pointer_icon = initial(new_xeno.client.mouse_pointer_icon)

	if(new_xeno.mind && GLOB.round_statistics)
		GLOB.round_statistics.track_new_participant(new_xeno.faction, 0) //so an evolved xeno doesn't count as two.
	SSround_recording.recorder.track_player(new_xeno)

	// We prevent de-evolved people from being tracked for the rest of the round relating to T1s in order to prevent people
	// Intentionally de/re-evolving to mess with the stats gathered. We don't track t2/3 because it's a legit strategy to open
	// With a t1 into drone before de-evoing later to go t1 into another caste once survs are dead/capped
	if(new_xeno.ckey && !((new_xeno.caste.caste_type in XENO_T1_CASTES) && (new_xeno.ckey in GLOB.deevolved_ckeys) && !(new_xeno.datum_flags & DF_VAR_EDITED)))
		var/caste_cleaned_key = lowertext(replacetext(castepick, " ", "_"))
		if(!SSticker.mode?.round_stats.castes_evolved[caste_cleaned_key])
			SSticker.mode?.round_stats.castes_evolved[caste_cleaned_key] = 1
		else
			SSticker.mode?.round_stats.castes_evolved[caste_cleaned_key] += 1

	SEND_SIGNAL(src, COMSIG_XENO_EVOLVE_TO_NEW_CASTE, new_xeno)

/mob/living/carbon/xenomorph/proc/evolve_checks()
	if(!check_state(TRUE))
		return FALSE

	if(is_ventcrawling)
		to_chat(src, SPAN_WARNING("此地过于狭窄，无法进化。"))
		return FALSE

	if(!isturf(loc))
		to_chat(src, SPAN_WARNING("我们不能在这里进化。"))
		return FALSE

	if(HAS_TRAIT(src, TRAIT_HIVEMIND_INTERFERENCE))
		to_chat(src, SPAN_WARNING("我们与巢穴的连接正受到压制...最好稍等片刻。"))
		return FALSE

	if(lock_evolve)
		if(banished)
			to_chat(src, SPAN_WARNING("我们被放逐了，无法连接蜂巢思维。"))
		else
			to_chat(src, SPAN_WARNING("我们无法进化。"))
		return FALSE

	if(jobban_isbanned(src, JOB_XENOMORPH))//~who so genius to do this is?
		to_chat(src, SPAN_WARNING("你已被禁止扮演异形，无法进化。你到底是怎么变成异形的？"))
		return FALSE

	if(handcuffed || legcuffed)
		to_chat(src, SPAN_WARNING("束缚太紧，我们无法进化。"))
		return FALSE

	if(isnull(caste.evolves_to) || !length(caste.evolves_to))
		to_chat(src, SPAN_WARNING("我们已是形态与功能的顶点。前进吧，去传播巢穴！"))
		return FALSE

	if(health < maxHealth)
		to_chat(src, SPAN_WARNING("我们必须处于完全健康状态才能进化。"))
		return FALSE

	if(agility || fortify || crest_defense || stealth)
		to_chat(src, SPAN_WARNING("我们无法在此姿态下进化。"))
		return FALSE

	if(ROUND_TIME < XENO_ROUNDSTART_BOOSTED_EVO_TIME)
		if(caste_type == XENO_CASTE_LARVA || caste_type == XENO_CASTE_PREDALIEN_LARVA)
			var/turf/evoturf = get_turf(src)
			if(!locate(/obj/effect/alien/weeds) in evoturf)
				to_chat(src, SPAN_WARNING("巢穴尚未发展到足以让你脱离菌毯进化！"))
				return FALSE

	return TRUE

/mob/living/carbon/xenomorph/proc/transmute_verb()
	set name = "嬗变"
	set desc = "Transmute into a different caste of the same tier."
	set category = "Alien"

	if(!check_state())
		return
	if(is_ventcrawling)
		to_chat(src, SPAN_XENOWARNING("我们不能在这里转化。"))
		return
	if(!isturf(loc))
		to_chat(src, SPAN_XENOWARNING("我们不能在这里转化。"))
		return
	if(HAS_TRAIT(src, TRAIT_HIVEMIND_INTERFERENCE))
		to_chat(src, SPAN_WARNING("我们与巢穴的连接正受到压制...最好稍等片刻。"))
		return FALSE
	if(health < maxHealth)
		to_chat(src, SPAN_XENOWARNING("我们太虚弱了，无法转化，必须先恢复健康。"))
		return
	if(tier == 0 || tier == 4)
		to_chat(src, SPAN_XENOWARNING("我们无法转化。"))
		return
	if(agility || fortify || crest_defense || stealth)
		to_chat(src, SPAN_XENOWARNING("在此姿态下我们无法转化。"))
		return
	if(lock_evolve)
		if(banished)
			to_chat(src, SPAN_WARNING("我们被放逐了，无法连接蜂巢思维。"))
		else
			to_chat(src, SPAN_WARNING("我们无法转化。"))
		return FALSE

	var/newcaste
	var/list/options = list()
	var/static/list/option_images = list()

	if(tier == 1)
		options = XENO_T1_CASTES
	else if (tier == 2)
		options = XENO_T2_CASTES
	else if (tier == 3)
		options = XENO_T3_CASTES

	if(!option_images["[tier]"])
		option_images["[tier]"] = collect_xeno_images(options)

	if(!client.prefs.no_radial_labels_preference)
		newcaste = show_radial_menu(src, src, option_images["[tier]"])
	else
		newcaste = tgui_input_list(src, "选择你想要转化成的阶级。", "嬗变", options, theme="hive_status")

	if(!newcaste)
		return

	transmute(newcaste, "We transmute into a new form.")

// The queen de-evo, but on yourself.
/mob/living/carbon/xenomorph/verb/Deevolve()
	set name = "De-Evolve"
	set desc = "De-evolve into a lesser form."
	set category = "Alien"

	if(!check_state())
		return
	if(is_ventcrawling)
		to_chat(src, SPAN_XENOWARNING("你无法在此处退化。"))
		return
	if(!isturf(loc))
		to_chat(src, SPAN_XENOWARNING("你无法在此处退化。"))
		return
	if(health < maxHealth)
		to_chat(src, SPAN_XENOWARNING("我们太虚弱了，无法退化，必须先恢复健康。"))
		return
	if(HAS_TRAIT(src, TRAIT_HIVEMIND_INTERFERENCE))
		to_chat(src, SPAN_WARNING("我们与巢穴的连接正受到压制...最好稍等片刻。"))
		return FALSE
	if(length(caste.deevolves_to) < 1)
		to_chat(src, SPAN_XENOWARNING("我们无法进一步退化。"))
		return
	if(lock_evolve)
		if(banished)
			to_chat(src, SPAN_WARNING("我们被放逐了，无法连接蜂巢思维。"))
		else
			to_chat(src, SPAN_WARNING("我们无法退化。"))
		return FALSE

	if(hardcore)
		to_chat(src, SPAN_WARNING("我们无法退化。"))
		return FALSE

	var/alleged_queens = hive.get_potential_queen_count()
	if(hive.allow_queen_evolve && !hive.living_xeno_queen && alleged_queens < 2 && isdrone(src))
		to_chat(src, SPAN_XENONOTICE("巢穴目前没有能成为女王的姐妹！巢穴的存续需要你保持工蜂形态！"))
		return FALSE

	var/newcaste
	if(length(caste.deevolves_to) == 1)
		newcaste = caste.deevolves_to[1]
	else if(length(caste.deevolves_to) > 1)
		newcaste = tgui_input_list(src, "选择你想要退化成的阶级。", "De-evolve", caste.deevolves_to, theme="hive_status")

	if(!newcaste)
		return

	var/confirm = tgui_alert(src, "你确定要从[caste.caste_type]退化到[newcaste]吗？你将暂时无法返回原阶级。", "Deevolution", list("Yes", "No"))
	if(confirm != "Yes")
		return

	if(!check_state())
		return
	if(is_ventcrawling)
		return
	if(!isturf(loc))
		return
	if(health <= 0)
		return
	if(lock_evolve)
		to_chat(src, SPAN_WARNING("你已被放逐，无法连接蜂巢思维。"))
		return


	SEND_SIGNAL(src, COMSIG_XENO_DEEVOLVE)

	var/mob/living/carbon/xenomorph/new_xeno = transmute(newcaste)
	if(new_xeno)
		log_game("EVOLVE: [key_name(src)] de-evolved into [new_xeno].")

	if(new_xeno.ckey)
		GLOB.deevolved_ckeys += new_xeno.ckey

/mob/living/carbon/xenomorph/proc/transmute(newcaste, message="We regress into our previous form.")
	// We have to delete the organ before creating the new xeno because all old_xeno contents are dropped to the ground on Initialize()
	var/obj/item/organ/xeno/organ = locate() in src
	if(!isnull(organ))
		qdel(organ)

	var/level_to_switch_to = get_vision_level()
	var/xeno_type = GLOB.RoleAuthority.get_caste_by_text(newcaste)
	var/mob/living/carbon/xenomorph/new_xeno = new xeno_type(get_turf(src), src)
	new_xeno.creation_time = creation_time

	if(!istype(new_xeno))
		//Something went horribly wrong
		to_chat(src, SPAN_WARNING("这里出了严重问题。你的新异形为空！请立即通知程序员！"))
		if(new_xeno)
			qdel(new_xeno)

		if(organ_value != 0)
			organ = new()
			organ.forceMove(src)
			organ.research_value = organ_value
			organ.caste_origin = caste_type
			organ.icon_state = get_organ_icon()
		return FALSE

	new_xeno.built_structures = built_structures.Copy()
	built_structures = null

	if(mind)
		mind.transfer_to(new_xeno)
	else
		new_xeno.key = key
		if(new_xeno.client)
			new_xeno.client.change_view(GLOB.world_view_size)
			new_xeno.client.set_pixel_x(0)
			new_xeno.client.set_pixel_y(0)

	//Regenerate the new mob's name now that our player is inside
	if(newcaste == XENO_CASTE_LARVA)
		var/mob/living/carbon/xenomorph/larva/new_larva = new_xeno
		new_larva.larva_state = LARVA_STATE_NORMAL
		new_larva.update_icons()
	new_xeno.generate_name()
	if(new_xeno.client)
		new_xeno.set_lighting_alpha(level_to_switch_to)

	// If the player has lost the Deevolve verb before, don't allow them to do it again
	if(!(/mob/living/carbon/xenomorph/verb/Deevolve in verbs))
		remove_verb(new_xeno, /mob/living/carbon/xenomorph/verb/Deevolve)

	new_xeno.visible_message(SPAN_XENODANGER("一只[new_xeno.caste.caste_type]从\the [src]的残骸中诞生。"),
	SPAN_XENODANGER(message))

	transfer_observers_to(new_xeno)
	new_xeno._status_traits = src._status_traits

	if(GLOB.round_statistics && !new_xeno.statistic_exempt)
		GLOB.round_statistics.track_new_participant(faction, 0) //so an evolved xeno doesn't count as two.
	SSround_recording.recorder.stop_tracking(src)
	SSround_recording.recorder.track_player(new_xeno)

	qdel(src)

	return new_xeno

/mob/living/carbon/xenomorph/proc/can_evolve(castepick, potential_queens)
	var/selected_caste = GLOB.xeno_datum_list[castepick]?.type
	var/free_slot = LAZYACCESS(hive.free_slots, selected_caste)
	var/used_slot = LAZYACCESS(hive.used_slots, selected_caste)
	if(free_slot > used_slot)
		return TRUE

	var/used_tier_2_slots = length(hive.tier_2_xenos)
	var/used_tier_3_slots = length(hive.tier_3_xenos)
	for(var/caste_path in hive.free_slots)
		var/slots_free = hive.free_slots[caste_path]
		var/slots_used = hive.used_slots[caste_path]
		if(!slots_used)
			continue
		var/datum/caste_datum/current_caste = caste_path
		switch(initial(current_caste.tier))
			if(2)
				used_tier_2_slots -= min(slots_used, slots_free)
			if(3)
				used_tier_3_slots -= min(slots_used, slots_free)

	var/burrowed_factor = min(hive.stored_larva, sqrt(4*hive.stored_larva))
	var/totalXenos = floor(burrowed_factor)
	for(var/mob/living/carbon/xenomorph/xeno as anything in hive.totalXenos)
		if(xeno.counts_for_slots)
			totalXenos++

	if(tier == 1 && (((used_tier_2_slots + used_tier_3_slots) / totalXenos) * hive.tier_slot_multiplier) >= 0.5 && castepick != XENO_CASTE_QUEEN)
		to_chat(src, SPAN_WARNING("巢穴无法支撑另一只二级异形，等待更多异形诞生或有异形死亡。"))
		return FALSE
	else if(tier == 2 && ((used_tier_3_slots / totalXenos) * hive.tier_slot_multiplier) >= 0.20 && castepick != XENO_CASTE_QUEEN)
		to_chat(src, SPAN_WARNING("巢穴无法支撑另一只三级异形，等待更多异形诞生或有异形死亡。"))
		return FALSE
	else if(hive.allow_queen_evolve && !hive.living_xeno_queen && potential_queens == 1 && islarva(src) && castepick != XENO_CASTE_DRONE)
		to_chat(src, SPAN_XENONOTICE("巢穴目前没有能成为女王的姐妹！巢穴的存续需要你保持工蜂形态！"))
		return FALSE

	return TRUE
