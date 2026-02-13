// devolve a xeno - lots of old, vaguely shitty code here
/datum/action/xeno_action/onclick/manage_hive/proc/de_evolve_other()
	var/mob/living/carbon/xenomorph/queen/user_xeno = owner
	var/plasma_cost_devolve = 500
	if(!user_xeno.check_state())
		return
	if(!user_xeno.observed_xeno)
		to_chat(user_xeno, SPAN_WARNING("你必须监控你想要退化的异形。"))
		return

	var/mob/living/carbon/xenomorph/target_xeno = user_xeno.observed_xeno
	if(!user_xeno.check_plasma(plasma_cost_devolve))
		return

	if(target_xeno.hivenumber != user_xeno.hivenumber)
		to_chat(user_xeno, SPAN_XENOWARNING("[target_xeno]不属于你的巢穴！"))
		return
	if(target_xeno.is_ventcrawling)
		to_chat(user_xeno, SPAN_XENOWARNING("[target_xeno]不能在此处退化。"))
		return
	if(!isturf(target_xeno.loc))
		to_chat(user_xeno, SPAN_XENOWARNING("[target_xeno]不能在此处退化。"))
		return
	if(target_xeno.health <= 0)
		to_chat(user_xeno, SPAN_XENOWARNING("[target_xeno]太虚弱，无法退化。"))
		return
	if(length(target_xeno.caste.deevolves_to) < 1)
		to_chat(user_xeno, SPAN_XENOWARNING("[target_xeno]无法退化。"))
		return
	if(target_xeno.banished)
		to_chat(user_xeno, SPAN_XENOWARNING("[target_xeno]已被放逐，无法退化。"))
		return


	var/newcaste
	if(length(target_xeno.caste.deevolves_to) == 1)
		newcaste = target_xeno.caste.deevolves_to[1]
	else if(length(target_xeno.caste.deevolves_to) > 1)
		newcaste = tgui_input_list(user_xeno, "选择你想要将[target_xeno]退化成的阶级。", "De-evolve", target_xeno.caste.deevolves_to, theme="hive_status")

	if(!newcaste)
		return
	if(newcaste == XENO_CASTE_LARVA)
		to_chat(user_xeno, SPAN_XENOWARNING("你不能将异形退化为幼虫。"))
		return
	if(user_xeno.observed_xeno != target_xeno)
		return

	var/confirm = tgui_alert(user_xeno, "你确定要将[target_xeno]从[target_xeno.caste.caste_type]退化为[newcaste]吗？", "Deevolution", list("Yes", "No"))
	if(confirm != "Yes")
		return

	var/reason = stripped_input(user_xeno, "提供退化此异形[target_xeno]的理由")
	if(!reason)
		to_chat(user_xeno, SPAN_XENOWARNING("你必须提供退化[target_xeno]的理由。"))
		return

	if(!check_and_use_plasma_owner(plasma_cost))
		return


	to_chat(target_xeno, SPAN_XENOWARNING("女王因以下理由将你退化：[reason]"))

	SEND_SIGNAL(target_xeno, COMSIG_XENO_DEEVOLVE)

	var/mob/living/carbon/xenomorph/new_xeno = target_xeno.transmute(newcaste)

	if(new_xeno)
		message_admins("[key_name_admin(user_xeno)] has deevolved [key_name_admin(target_xeno)]. Reason: [reason]")
		log_admin("[key_name_admin(user_xeno)] has deevolved [key_name_admin(target_xeno)]. Reason: [reason]")

		if(user_xeno.hive.living_xeno_queen && user_xeno.hive.living_xeno_queen.observed_xeno == target_xeno)
			user_xeno.hive.living_xeno_queen.overwatch(new_xeno)

		if(new_xeno.ckey)
			GLOB.deevolved_ckeys += new_xeno.ckey

/datum/action/xeno_action/onclick/remove_eggsac/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/queen/X = owner
	if(!X.check_state())
		return

	if(X.action_busy)
		return
	var/answer = alert(X, "你确定要移除你的产卵器吗？（重新生长需要5分钟冷却）", , "Yes", "No")
	if(answer != "Yes")
		return
	if(!X.check_state())
		return
	if(!X.ovipositor)
		return
	X.visible_message(SPAN_XENOWARNING("\The [X] starts detaching itself from its ovipositor!"),
		SPAN_XENOWARNING("You start detaching yourself from your ovipositor."))
	if(!do_after(X, 50, INTERRUPT_NO_NEEDHAND, BUSY_ICON_HOSTILE, numticks = 10))
		return
	if(!X.check_state())
		return
	if(!X.ovipositor)
		return
	X.dismount_ovipositor()
	return ..()

/datum/action/xeno_action/onclick/grow_ovipositor/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/queen/xeno = owner
	if(!xeno.check_state())
		return

	var/turf/current_turf = get_turf(xeno)
	if(!current_turf || !istype(current_turf))
		return

	if(!action_cooldown_check())
		to_chat(xeno, SPAN_XENOWARNING("你仍在从上次移除产卵器中恢复。请等待[DisplayTimeText(timeleft(cooldown_timer_id))]。"))
		return

	var/obj/effect/alien/weeds/alien_weeds = locate() in current_turf

	if(!alien_weeds)
		to_chat(xeno, SPAN_XENOWARNING("你需要在树脂上才能生长产卵器。"))
		return

	if(SSinterior.in_interior(xeno))
		to_chat(xeno, SPAN_XENOWARNING("这里空间太狭窄，无法生长产卵器。"))
		return

	if(alien_weeds.linked_hive.hivenumber != xeno.hivenumber)
		to_chat(xeno, SPAN_XENOWARNING("这些菌毯不属于你的巢穴！你无法在此生长产卵器。"))
		return

	var/area/current_area = get_area(xeno)
	if(current_area.unoviable_timer)
		to_chat(xeno, SPAN_XENOWARNING("此区域不适合你生长产卵器。"))
		return

	if(!xeno.check_alien_construction(current_turf))
		return

	if(xeno.action_busy)
		return

	if(!xeno.check_plasma(plasma_cost))
		return

	xeno.visible_message(SPAN_XENOWARNING("\The [xeno] starts to grow an ovipositor."),
	SPAN_XENOWARNING("You start to grow an ovipositor...(takes 20 seconds, hold still)"))
	if(!do_after(xeno, 200, INTERRUPT_NO_NEEDHAND, BUSY_ICON_FRIENDLY, numticks = 20) && xeno.check_plasma(plasma_cost))
		return
	if(!xeno.check_state())
		return
	if(!locate(/obj/effect/alien/weeds) in current_turf)
		return
	xeno.use_plasma(plasma_cost)
	xeno.visible_message(SPAN_XENOWARNING("\The [xeno] has grown an ovipositor!"),
	SPAN_XENOWARNING("You have grown an ovipositor!"))
	xeno.mount_ovipositor()
	return ..()

/datum/action/xeno_action/onclick/set_xeno_lead/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/queen/xeno = owner
	if(!xeno.check_state())
		return

	if(!action_cooldown_check())
		return
	var/datum/hive_status/hive = xeno.hive
	if(xeno.observed_xeno)
		if(!length(hive.open_xeno_leader_positions) && IS_NORMAL_XENO(xeno.observed_xeno))
			to_chat(xeno, SPAN_XENOWARNING("你目前有[length(hive.xeno_leader_list)]名晋升的领导者。在你的力量增长之前，你无法维持更多领导者。"))
			return
		var/mob/living/carbon/xenomorph/targeted_xeno = xeno.observed_xeno
		if(targeted_xeno == xeno)
			to_chat(xeno, SPAN_XENOWARNING("你不能将自己设为领袖！"))
			return
		apply_cooldown()
		if(IS_NORMAL_XENO(targeted_xeno))
			if(!hive.add_hive_leader(targeted_xeno))
				to_chat(xeno, SPAN_XENOWARNING("无法添加领袖。"))
				return
			if(targeted_xeno.stat == DEAD)
				to_chat(xeno, SPAN_XENOWARNING("你不能领导死者。"))
				return
			to_chat(xeno, SPAN_XENONOTICE("你已选定[targeted_xeno]为巢穴领袖。"))
			to_chat(targeted_xeno, SPAN_XENOANNOUNCE("[xeno]已选定你为巢穴领袖。其他异形必须听从你的命令。你将成为女王信息素的信标。"))
		else
			hive.remove_hive_leader(targeted_xeno)
			to_chat(xeno, SPAN_XENONOTICE("你已将[targeted_xeno]从巢穴领袖降职。"))
			to_chat(targeted_xeno, SPAN_XENOANNOUNCE("[xeno]已将你从巢穴领袖降职。你的领导权与能力已减弱。"))
	else
		var/list/possible_xenos = list()
		for(var/mob/living/carbon/xenomorph/targeted_xeno in hive.xeno_leader_list)
			possible_xenos += targeted_xeno

		if(length(possible_xenos) > 1)
			var/mob/living/carbon/xenomorph/selected_xeno = tgui_input_list(xeno, "目标", "Watch which leader?", possible_xenos, theme="hive_status")
			if(!selected_xeno || IS_NORMAL_XENO(selected_xeno) || selected_xeno == xeno.observed_xeno || selected_xeno.stat == DEAD || !xeno.check_state())
				return
			xeno.overwatch(selected_xeno)
		else if(length(possible_xenos))
			xeno.overwatch(possible_xenos[1])
		else
			to_chat(xeno, SPAN_XENOWARNING("当前没有异形领袖。监控一个异形以使其成为领袖。"))
	return ..()

/datum/action/xeno_action/activable/queen_heal/use_ability(atom/target, verbose)
	var/mob/living/carbon/xenomorph/queen/queen = owner
	if(!queen.check_state())
		return

	if(!action_cooldown_check())
		return

	var/turf/target_turf = get_turf(target)
	if(!target_turf)
		to_chat(queen, SPAN_WARNING("你必须选择一个有效的菌毯区域进行治疗。"))
		return

	if(!SSmapping.same_z_map(queen.loc.z, target_turf.loc.z))
		to_chat(queen, SPAN_XENOWARNING("你距离太远，无法在此处执行此操作。"))
		return

	if(!check_and_use_plasma_owner())
		return

	for(var/mob/living/carbon/xenomorph/current_xeno in range(4, target_turf))
		if(!queen.can_not_harm(current_xeno))
			continue

		if(SEND_SIGNAL(current_xeno, COMSIG_XENO_PRE_HEAL) & COMPONENT_CANCEL_XENO_HEAL)
			if(verbose)
				to_chat(queen, SPAN_XENOMINORWARNING("你无法治疗[current_xeno]！"))
			continue

		if(current_xeno == queen)
			continue

		if(current_xeno.stat == DEAD || QDELETED(current_xeno))
			continue

		if(!current_xeno.caste.can_be_queen_healed)
			continue

		new /datum/effects/heal_over_time(current_xeno, current_xeno.maxHealth * 0.3, 2 SECONDS, 2)
		current_xeno.flick_heal_overlay(3 SECONDS, "#D9F500") //it's already hard enough to gauge health without hp overlays!

	apply_cooldown()
	to_chat(queen, SPAN_XENONOTICE("你引导等离子能量，治疗该区域内姐妹们的伤口。"))
	return ..()

/datum/action/xeno_action/onclick/manage_hive/proc/give_evo_points()
	var/mob/living/carbon/xenomorph/queen/user_xeno = owner
	var/plasma_cost_givepoints = 100


	if(!user_xeno.check_state())
		return

	if(!user_xeno.check_plasma(plasma_cost_givepoints))
		return

	if(world.time < SSticker.mode.round_time_lobby + SHUTTLE_TIME_LOCK)
		to_chat(usr, SPAN_XENOWARNING("在献祭幼虫前，必须给予其一些时间孵化。请再等待[floor((SSticker.mode.round_time_lobby + SHUTTLE_TIME_LOCK - world.time) / 600)]分钟。"))
		return

	var/choice = tgui_input_list(user_xeno, "选择一个异形，为其提供来自潜藏幼虫的进化点数：", "Give Evolution Points", user_xeno.hive.totalXenos, theme="hive_status")

	if(!choice)
		return
	var/evo_points_per_larva = 250
	var/required_larva = 1
	var/mob/living/carbon/xenomorph/target_xeno

	for(var/mob/living/carbon/xenomorph/xeno in user_xeno.hive.totalXenos)
		if(html_encode(xeno.name) == html_encode(choice))
			target_xeno = xeno
			break

	if(target_xeno == user_xeno)
		to_chat(user_xeno, SPAN_XENOWARNING("你不能将进化点数给予自己。"))
		return

	if(target_xeno.evolution_stored == target_xeno.evolution_threshold)
		to_chat(user_xeno, SPAN_XENOWARNING("该异形已准备好进化！"))
		return

	if(target_xeno.hivenumber != user_xeno.hivenumber)
		to_chat(user_xeno, SPAN_XENOWARNING("该异形不属于你的巢穴！"))
		return

	if(target_xeno.health < 0)
		to_chat(user_xeno, SPAN_XENOWARNING("这有什么意义？他们快死了。"))
		return

	if(user_xeno.hive.stored_larva < required_larva)
		to_chat(user_xeno, SPAN_XENOWARNING("你需要至少[required_larva]只潜藏幼虫才能献祭一只以获取进化点数。"))
		return

	if(tgui_alert(user_xeno, "你确定要献祭一只幼虫，给予[target_xeno][evo_points_per_larva]点进化点数吗？", "Give Evolution Points", list("Yes", "No")) != "Yes")
		return

	if(!user_xeno.check_state() || !check_and_use_plasma_owner(plasma_cost) || target_xeno.health < 0 || user_xeno.hive.stored_larva < required_larva)
		return

	to_chat(target_xeno, SPAN_XENOWARNING("\The [user_xeno] has given you evolution points! Use them well."))
	to_chat(user_xeno, SPAN_XENOWARNING("\The [target_xeno] was given [evo_points_per_larva] evolution points."))

	if(target_xeno.evolution_stored + evo_points_per_larva > target_xeno.evolution_threshold)
		target_xeno.evolution_stored = target_xeno.evolution_threshold
	else
		target_xeno.evolution_stored += evo_points_per_larva

	user_xeno.hive.stored_larva--
	return



/datum/action/xeno_action/onclick/manage_hive/proc/give_jelly_reward()
	var/mob/living/carbon/xenomorph/queen/xeno = owner
	var/plasma_cost_jelly = 500
	if(!xeno.check_state())
		return
	if(!xeno.check_plasma(plasma_cost_jelly))
		return
	if(give_jelly_award(xeno.hive))
		xeno.use_plasma(plasma_cost_jelly)
		return

/datum/action/xeno_action/onclick/send_thoughts/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/queen/thought_sender = owner
	var/static/list/options = list(
		"Psychic Radiance (100)" = icon(/datum/action/xeno_action::icon_file, "psychic_radiance"),
		"Psychic Whisper (0)" = icon(/datum/action/xeno_action::icon_file, "psychic_whisper"),
		"Give Order (100)" = icon(/datum/action/xeno_action::icon_file, "queen_order")
	)

	var/choice
	if(thought_sender.client?.prefs.no_radials_preference)
		choice = tgui_input_list(thought_sender, "沟通", "Send Thoughts", options, theme="hive_status")
	else
		choice = show_radial_menu(thought_sender, thought_sender?.client.get_eye(), options)

	if(!choice)
		return

	plasma_cost = 0
	switch(choice)
		if("Psychic Radiance (100)")
			psychic_radiance()
		if("Psychic Whisper (0)")
			psychic_whisper()
		if("Give Order (100)")
			queen_order()
	return ..()

/datum/action/xeno_action/onclick/manage_hive/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/queen/queen_manager = owner
	plasma_cost = 0
	var/list/options = list("Banish (500)", "Re-Admit (100)", "De-evolve (500)", "Reward Jelly (500)", "Exchange larva for evolution (100)", "Permissions", "Purchase Buffs")
	if(queen_manager.hive.hivenumber == XENO_HIVE_CORRUPTED)
		var/datum/hive_status/corrupted/hive = queen_manager.hive
		options += "Add Personal Ally"
		if(length(hive.personal_allies))
			options += "Remove Personal Ally"
			options += "Clear Personal Allies"

	if(queen_manager.hive.hivenumber == XENO_HIVE_NORMAL)
		options += "Edit Tacmap"

	var/choice = tgui_input_list(queen_manager, "管理巢穴", "Hive Management", options, theme="hive_status")
	switch(choice)
		if("Banish (500)")
			banish()
		if("Re-Admit (100)")
			readmit()
		if("De-evolve (500)")
			de_evolve_other()
		if("Reward Jelly (500)")
			give_jelly_reward(queen_manager.hive)
		if("Exchange larva for evolution (100)")
			give_evo_points()
		if("Add Personal Ally")
			add_personal_ally()
		if("Remove Personal Ally")
			remove_personal_ally()
		if("Clear Personal Allies")
			clear_personal_allies()
		if("Permissions")
			permissions()
		if("Purchase Buffs")
			purchase_buffs()
		if("Edit Tacmap")
			edit_tacmap()
	return ..()

/datum/action/xeno_action/onclick/manage_hive/proc/edit_tacmap()
	var/mob/living/carbon/xenomorph/queen/xeno = owner
	var/datum/component/tacmap/tacmap_component = xeno.GetComponent(/datum/component/tacmap)

	if(xeno in tacmap_component.interactees)
		tacmap_component.on_unset_interaction(xeno)
		tacmap_component.close_popout_tacmaps(xeno)
	else
		tacmap_component.show_tacmap(xeno)

/datum/action/xeno_action/onclick/manage_hive/proc/permissions()
	var/mob/living/carbon/xenomorph/queen/xeno = owner
	var/choice = tgui_input_list(xeno, "选择要更改的巢穴权限。", "Hive Permissions", list("Harming", "Construction", "Deconstruction", "Unnesting"), theme="hive_status")
	switch(choice)
		if("Harming")
			xeno.claw_toggle()
		if("Construction")
			xeno.construction_toggle()
		if("Deconstruction")
			xeno.destruction_toggle()
		if("Unnesting")
			xeno.unnesting_toggle()

/datum/action/xeno_action/onclick/manage_hive/proc/purchase_buffs()
	var/mob/living/carbon/xenomorph/queen/xeno = owner

	var/list/datum/hivebuff/buffs = list()
	var/list/names = list()
	var/list/radial_images = list()
	var/major_available = FALSE
	for(var/datum/hivebuff/buff as anything in xeno.hive.get_available_hivebuffs())
		var/buffname = initial(buff.name)
		names += buffname
		buffs[buffname] = buff
		if(!major_available)
			if(initial(buff.tier) == HIVEBUFF_TIER_MAJOR)
				major_available = TRUE

	if(!length(buffs))
		to_chat(xeno, SPAN_XENONOTICE("没有可用的恩赐！"))
		return

	var/selection
	var/list/radial_images_tiers = list(HIVEBUFF_TIER_MINOR = image('icons/ui_icons/hivebuff_radial.dmi', "minor"), HIVEBUFF_TIER_MAJOR = image('icons/ui_icons/hivebuff_radial.dmi', "major"))

	if(xeno.client?.prefs?.no_radials_preference)
		selection = tgui_input_list(xeno, "选择一个增益效果。", "Select Buff", names)
	else
		var/tier = HIVEBUFF_TIER_MINOR
		if(major_available)
			tier = show_radial_menu(xeno, xeno?.client?.get_eye(), radial_images_tiers)

		if(tier == HIVEBUFF_TIER_MAJOR)
			for(var/filtered_buffname as anything in buffs)
				var/datum/hivebuff/filtered_buff = buffs[filtered_buffname]
				if(initial(filtered_buff.tier) == HIVEBUFF_TIER_MAJOR)
					radial_images[initial(filtered_buff.name)] += image(initial(filtered_buff.hivebuff_radial_dmi), initial(filtered_buff.radial_icon))
		else
			for(var/filtered_buffname as anything in buffs)
				var/datum/hivebuff/filtered_buff = buffs[filtered_buffname]
				if(initial(filtered_buff.tier) == HIVEBUFF_TIER_MINOR)
					radial_images[initial(filtered_buff.name)] += image(initial(filtered_buff.hivebuff_radial_dmi), initial(filtered_buff.radial_icon))

		selection = show_radial_menu(xeno, xeno?.client?.get_eye(), radial_images, radius = 72, tooltips = TRUE)

	if(!selection)
		return FALSE

	if(!buffs[selection])
		to_chat(xeno, "此选择无法实现！")
		return FALSE

	if(buffs[selection].must_select_pylon)
		var/list/pylon_to_area_dictionary = list()
		for(var/obj/effect/alien/resin/special/pylon/endgame/pylon as anything in xeno.hive.active_endgame_pylons)
			pylon_to_area_dictionary[get_area_name(pylon.loc)] = pylon

		var/choice = tgui_input_list(xeno, "选择一个神经塔来施加增益：", "Choice", pylon_to_area_dictionary, 1 MINUTES)

		if(!choice)
			to_chat(xeno, "你必须选择一个神经塔。")
			return FALSE

		xeno.hive.attempt_apply_hivebuff(buffs[selection], xeno, pylon_to_area_dictionary[choice])
		return TRUE

	xeno.hive.attempt_apply_hivebuff(buffs[selection], xeno, pick(xeno.hive.active_endgame_pylons))
	return TRUE

/datum/action/xeno_action/onclick/manage_hive/proc/add_personal_ally()
	var/mob/living/carbon/xenomorph/queen/user_xeno = owner
	if(user_xeno.hive.hivenumber != XENO_HIVE_CORRUPTED)
		return

	if(!user_xeno.check_state())
		return

	var/datum/hive_status/corrupted/hive = user_xeno.hive
	var/list/target_list = list()
	if(!user_xeno.client)
		return
	for(var/mob/living/carbon/human/possible_target in range(7, user_xeno.client.get_eye()))
		if(possible_target.stat == DEAD)
			continue
		if(possible_target.status_flags & CORRUPTED_ALLY)
			continue
		if(possible_target.hivenumber)
			continue
		target_list += possible_target

	if(!length(target_list))
		to_chat(user_xeno, SPAN_WARNING("视野内没有高个目标。"))
		return
	var/mob/living/target_mob = tgui_input_list(usr, "目标", "Set Up a Personal Alliance With...", target_list, theme="hive_status")

	if(!user_xeno.check_state(TRUE))
		return

	if(!target_mob)
		return

	if(target_mob.hivenumber)
		to_chat(user_xeno, SPAN_WARNING("我们无法与巢穴异教徒建立个人同盟。"))
		return

	hive.add_personal_ally(target_mob)

/datum/action/xeno_action/onclick/manage_hive/proc/remove_personal_ally()
	var/mob/living/carbon/xenomorph/queen/user_xeno = owner
	if(user_xeno.hive.hivenumber != XENO_HIVE_CORRUPTED)
		return

	if(!user_xeno.check_state())
		return

	var/datum/hive_status/corrupted/hive = user_xeno.hive

	if(!length(hive.personal_allies))
		to_chat(user_xeno, SPAN_WARNING("我们没有个人盟友。"))
		return

	var/list/mob/living/allies = list()
	var/list/datum/weakref/dead_refs = list()
	for(var/datum/weakref/ally_ref as anything in hive.personal_allies)
		var/mob/living/ally = ally_ref.resolve()
		if(ally)
			allies += ally
			continue
		dead_refs += ally_ref

	hive.personal_allies -= dead_refs

	if(!length(allies))
		to_chat(user_xeno, SPAN_WARNING("我们没有个人盟友。"))
		return

	var/mob/living/target_mob = tgui_input_list(usr, "目标", "Break the Personal Alliance With...", allies, theme="hive_status")

	if(!target_mob)
		return

	var/target_mob_ref = WEAKREF(target_mob)

	if(!(target_mob_ref in hive.personal_allies))
		return

	if(!user_xeno.check_state(TRUE))
		return

	hive.remove_personal_ally(target_mob_ref)

/datum/action/xeno_action/onclick/manage_hive/proc/clear_personal_allies()
	var/mob/living/carbon/xenomorph/queen/user_xeno = owner
	if(user_xeno.hive.hivenumber != XENO_HIVE_CORRUPTED)
		return

	if(!user_xeno.check_state())
		return

	var/datum/hive_status/corrupted/hive = user_xeno.hive
	if(!length(hive.personal_allies))
		to_chat(user_xeno, SPAN_WARNING("我们没有个人盟友。"))
		return

	if(tgui_alert(user_xeno, "你确定要清除个人盟友吗？", "Clear Personal Allies", list("Yes", "No"), 10 SECONDS) != "Yes")
		return

	if(!length(hive.personal_allies))
		return

	hive.clear_personal_allies()


/datum/action/xeno_action/onclick/manage_hive/proc/banish()
	var/mob/living/carbon/xenomorph/queen/user_xeno = owner
	var/plasma_cost_banish = 500
	if(!user_xeno.check_state())
		return

	if(!user_xeno.check_plasma(plasma_cost_banish))
		return

	var/choice = tgui_input_list(user_xeno, "选择一个异形来放逐：", "Banish", user_xeno.hive.totalXenos, theme="hive_status")

	if(!choice)
		return

	var/mob/living/carbon/xenomorph/target_xeno

	for(var/mob/living/carbon/xenomorph/xeno in user_xeno.hive.totalXenos)
		if(html_encode(xeno.name) == html_encode(choice))
			target_xeno = xeno
			break

	if(target_xeno == user_xeno)
		to_chat(user_xeno, SPAN_XENOWARNING("你不能放逐自己。"))
		return

	if(target_xeno.banished)
		to_chat(user_xeno, SPAN_XENOWARNING("这个异形已经被放逐了！"))
		return

	if(target_xeno.hivenumber != user_xeno.hivenumber)
		to_chat(user_xeno, SPAN_XENOWARNING("该异形不属于你的巢穴！"))
		return

	// No banishing critted xenos
	if(target_xeno.health < 0)
		to_chat(user_xeno, SPAN_XENOWARNING("有什么意义？他们反正都快死了。"))
		return

	var/confirm = tgui_alert(user_xeno, "你确定要将[target_xeno]从巢穴中放逐吗？这必须有充分的理由。（注意：这也将阻止他们在死亡后30分钟内重新加入巢穴，除非被重新接纳）", "Banishment", list("Yes", "No"))
	if(confirm != "Yes")
		return

	var/reason = stripped_input(user_xeno, "请提供放逐[target_xeno]的理由。这将向整个巢穴宣布！")
	if(!reason)
		to_chat(user_xeno, SPAN_XENOWARNING("你必须提供放逐[target_xeno]的理由。"))
		return

	if(!user_xeno.check_state() || !check_and_use_plasma_owner(plasma_cost_banish) || target_xeno.health < 0)
		return

	// Let everyone know they were banished
	xeno_announcement("根据[user_xeno]的意志，[target_xeno]已被从巢穴中放逐！\n\n[reason]", user_xeno.hivenumber, title=SPAN_ANNOUNCEMENT_HEADER_BLUE("Banishment"))
	to_chat(target_xeno, FONT_SIZE_LARGE(SPAN_XENOWARNING("The [user_xeno] has banished you from the hive! Other xenomorphs may now attack you freely, but your link to the hivemind remains, preventing you from harming other sisters.")))

	target_xeno.banished = TRUE
	target_xeno.hud_update_banished()
	target_xeno.lock_evolve = TRUE
	user_xeno.hive.banished_ckeys[target_xeno.name] = target_xeno.ckey
	addtimer(CALLBACK(src, PROC_REF(remove_banish), user_xeno.hive, target_xeno.name), 30 MINUTES)

	message_admins("[key_name_admin(user_xeno)] has banished [key_name_admin(target_xeno)]. Reason: [reason]")
	return

/datum/action/xeno_action/proc/remove_banish(datum/hive_status/hive, name)
	hive.banished_ckeys.Remove(name)


// Readmission = un-banish

/datum/action/xeno_action/onclick/manage_hive/proc/readmit()
	var/mob/living/carbon/xenomorph/queen/user_xeno = owner
	var/plasma_cost_readmit = 100
	if(!user_xeno.check_state())
		return

	if(!user_xeno.check_plasma(plasma_cost_readmit))
		return

	var/choice = tgui_input_list(user_xeno, "选择一个异形来重新接纳：", "Re-admit", user_xeno.hive.banished_ckeys, theme="hive_status")

	if(!choice)
		return

	var/banished_ckey
	var/banished_name

	for(var/mob_name in user_xeno.hive.banished_ckeys)
		if(user_xeno.hive.banished_ckeys[mob_name] == user_xeno.hive.banished_ckeys[choice])
			banished_ckey = user_xeno.hive.banished_ckeys[mob_name]
			banished_name = mob_name
			break

	var/banished_living = FALSE
	var/mob/living/carbon/xenomorph/target_xeno

	for(var/mob/living/carbon/xenomorph/xeno in user_xeno.hive.totalXenos)
		if(xeno.ckey == banished_ckey)
			target_xeno = xeno
			banished_living = TRUE
			break

	if(banished_living)
		if(!target_xeno.banished)
			to_chat(user_xeno, SPAN_XENOWARNING("这个异形没有被放逐！"))
			return

		var/confirm = tgui_alert(user_xeno, "你确定要将[target_xeno]重新接纳回巢穴吗？", "Readmittance", list("Yes", "No"))
		if(confirm != "Yes")
			return

		if(!user_xeno.check_state() || !check_and_use_plasma_owner(plasma_cost))
			return

		to_chat(target_xeno, FONT_SIZE_LARGE(SPAN_XENOWARNING("The [user_xeno] has readmitted you into the hive.")))
		target_xeno.banished = FALSE
		target_xeno.hud_update_banished()
		target_xeno.lock_evolve = FALSE

	user_xeno.hive.banished_ckeys.Remove(banished_name)
	return

/datum/action/xeno_action/onclick/eye
	name = "进入眼形态"
	action_icon_state = "queen_eye"
	plasma_cost = 0

/datum/action/xeno_action/onclick/eye/use_ability(atom/target)
	. = ..()
	if(!owner)
		return

	new /mob/hologram/queen(owner.loc, owner)
	qdel(src)

/datum/action/xeno_action/activable/expand_weeds
	var/list/recently_built_turfs

/datum/action/xeno_action/activable/expand_weeds/New(Target, override_icon_state)
	. = ..()
	recently_built_turfs = list()

/datum/action/xeno_action/activable/expand_weeds/Destroy()
	recently_built_turfs = null
	return ..()

/datum/action/xeno_action/activable/expand_weeds/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/queen/xeno = owner

	if(!xeno.check_state())
		return

	if(!action_cooldown_check())
		return

	var/turf/turf_to_get = get_turf(target)

	if(!turf_to_get || turf_to_get.is_weedable < FULLY_WEEDABLE || turf_to_get.density || !SSmapping.same_z_map(turf_to_get.z, xeno.z))
		to_chat(xeno, SPAN_XENOWARNING("你不能在这里这么做。"))
		return

	var/area/area_to_get = get_area(turf_to_get)
	if(isnull(area_to_get) || !area_to_get.is_resin_allowed)
		if(!area_to_get || area_to_get.flags_area & AREA_UNWEEDABLE)
			to_chat(xeno, SPAN_XENOWARNING("此区域不适合建立巢穴。"))
			return
		to_chat(xeno, SPAN_XENOWARNING("现在将巢穴扩张至此还为时过早。"))
		return

	var/obj/effect/alien/weeds/located_weeds = locate() in turf_to_get
	if(located_weeds)
		if(istype(located_weeds, /obj/effect/alien/weeds/node))
			to_chat(xeno, SPAN_XENOWARNING("这里已经有一个节点了。"))
			return
		if(located_weeds.weed_strength > xeno.weed_level)
			to_chat(xeno, SPAN_XENOWARNING("这里已经有更强的菌毯了。"))
			return
		if(!check_and_use_plasma_owner(node_plant_plasma_cost))
			return

		to_chat(xeno, SPAN_XENOWARNING("你在[turf_to_get]种植了一个节点"))
		new /obj/effect/alien/weeds/node(turf_to_get, null, owner)
		playsound(turf_to_get, "alien_resin_build", 35)
		apply_cooldown_override(node_plant_cooldown)
		return

	var/obj/effect/alien/weeds/node/node
	for(var/direction in GLOB.cardinals)
		var/turf/turf_to_weed = get_step(turf_to_get, direction)
		var/obj/effect/alien/weeds/weeds_to_locate = locate() in turf_to_weed
		if(weeds_to_locate && weeds_to_locate.hivenumber == xeno.hivenumber && weeds_to_locate.parent && !weeds_to_locate.hibernate && !LinkBlocked(weeds_to_locate, turf_to_weed, turf_to_get))
			node = weeds_to_locate.parent
			break

	if(!node)
		to_chat(xeno, SPAN_XENOWARNING("你只能在有附近节点的地方种植菌毯。"))
		return
	if(turf_to_get in recently_built_turfs)
		to_chat(xeno, SPAN_XENOWARNING("你最近已经在这里建造过了。"))
		return

	if(!check_and_use_plasma_owner())
		return

	new /obj/effect/alien/weeds(turf_to_get, node, FALSE, TRUE)
	playsound(turf_to_get, "alien_resin_build", 35)
	recently_built_turfs += turf_to_get
	addtimer(CALLBACK(src, PROC_REF(reset_turf_cooldown), turf_to_get), turf_build_cooldown)

	to_chat(xeno, SPAN_XENOWARNING("你在[turf_to_get]处播撒了菌毯。"))
	apply_cooldown()
	return ..()



/datum/action/xeno_action/activable/expand_weeds/proc/reset_turf_cooldown(turf/T)
	recently_built_turfs -= T

/datum/action/xeno_action/onclick/screech/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/queen/xeno = owner

	if (!istype(xeno))
		return

	if (!action_cooldown_check())
		return

	if (!xeno.check_state())
		return

	if (!check_and_use_plasma_owner())
		return

	//screech is so powerful it kills huggers in our hands
	if(istype(xeno.r_hand, /obj/item/clothing/mask/facehugger))
		var/obj/item/clothing/mask/facehugger/hugger = xeno.r_hand
		if(hugger.stat != DEAD)
			hugger.die()

	if(istype(xeno.l_hand, /obj/item/clothing/mask/facehugger))
		var/obj/item/clothing/mask/facehugger/hugger = xeno.l_hand
		if(hugger.stat != DEAD)
			hugger.die()

	playsound(xeno.loc, pick(xeno.screech_sound_effect_list), 75, 0, status = 0)
	xeno.visible_message(SPAN_XENOHIGHDANGER("[xeno]发出一声震耳欲聋的嘶吼！"))
	xeno.create_shriekwave(14) //Adds the visual effect. Wom wom wom, 14 shriekwaves

	SScmtv.spectate_event("Queen Screech", xeno, 10 SECONDS)

	FOR_DVIEW(var/mob/mob, world.view, owner, HIDE_INVISIBLE_OBSERVER)
		if(mob && mob.client)
			if(isxeno(mob))
				shake_camera(mob, 10, 1)
			else
				shake_camera(mob, 30, 1) //50 deciseconds, SORRY 5 seconds was way too long. 3 seconds now
	FOR_DVIEW_END

	var/list/mobs_in_view = list()
	FOR_DOVIEW(var/mob/living/carbon/M, 7, xeno, HIDE_INVISIBLE_OBSERVER)
		mobs_in_view += M
	FOR_DOVIEW_END
	for(var/mob/living/carbon/M in orange(10, xeno))
		if(SEND_SIGNAL(M, COMSIG_MOB_SCREECH_ACT, xeno) & COMPONENT_SCREECH_ACT_CANCEL)
			continue
		M.handle_queen_screech(xeno, mobs_in_view)

	apply_cooldown()

	return ..()

/datum/action/xeno_action/activable/gut/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/queen/xeno = owner
	if(!action_cooldown_check())
		return
	if(xeno.queen_gut(target))
		apply_cooldown()
	return ..()

/datum/action/xeno_action/onclick/send_thoughts/proc/psychic_whisper()
	var/mob/living/carbon/xenomorph/xeno_player = owner
	if(xeno_player.client.prefs.muted & MUTE_IC)
		to_chat(xeno_player, SPAN_DANGER("你无法低语（被禁言）。"))
		return
	if(!xeno_player.check_state(TRUE))
		return
	var/list/target_list = list()
	for(var/mob/living/carbon/possible_target in view(7, xeno_player))
		if(possible_target == xeno_player || !possible_target.client)
			continue
		target_list += possible_target

	var/mob/living/carbon/target_mob = tgui_input_list(usr, "目标", "Send a Psychic Whisper to whom?", target_list, theme="hive_status")
	if(!target_mob)
		return

	if(!xeno_player.check_state(TRUE))
		return

	var/whisper = tgui_input_text(xeno_player, "你想说什么？", "心灵低语")
	if(whisper)
		log_say("PsychicWhisper: [key_name(xeno_player)]->[target_mob.key] : [whisper] (AREA: [get_area_name(target_mob)])")
		if(!istype(target_mob, /mob/living/carbon/xenomorph))
			to_chat(target_mob, SPAN_XENOQUEEN("你脑海中响起一个奇怪的外星声音。\"[SPAN_PSYTALK(whisper)]\""))
		else
			to_chat(target_mob, SPAN_XENOQUEEN("你脑海中回响着[xeno_player]的声音。\"[SPAN_PSYTALK(whisper)]\""))
		to_chat(xeno_player, SPAN_XENONOTICE("你说：\"[whisper]\" to [target_mob]"))

		for(var/mob/dead/observer/ghost as anything in GLOB.observer_list)
			if(!ghost.client || isnewplayer(ghost))
				continue
			if(ghost.client.prefs.toggles_chat & CHAT_GHOSTHIVEMIND)
				var/rendered_message
				var/xeno_track = "(<a href='byond://?src=\ref[ghost];track=\ref[xeno_player]'>F</a>)"
				var/target_track = "(<a href='byond://?src=\ref[ghost];track=\ref[target_mob]'>F</a>)"
				rendered_message = SPAN_XENOLEADER("PsychicWhisper: [xeno_player.real_name][xeno_track] to [target_mob.real_name][target_track], <span class='normal'>'[SPAN_PSYTALK(whisper)]'</span>")
				ghost.show_message(rendered_message, SHOW_MESSAGE_AUDIBLE)

	return

/datum/action/xeno_action/onclick/send_thoughts/proc/psychic_radiance()
	var/radiance_plasma_cost = 100
	var/mob/living/carbon/xenomorph/xeno_player = owner

	if(!xeno_player.check_plasma(radiance_plasma_cost))
		return
	if(xeno_player.client.prefs.muted & MUTE_IC)
		to_chat(xeno_player, SPAN_DANGER("你无法低语（被禁言）。"))
		return
	if(!xeno_player.check_state(TRUE))
		return
	var/list/target_list = list()
	var/whisper = tgui_input_text(xeno_player, "你想说什么？", "心灵辐射")
	if(!whisper || !xeno_player.check_state(TRUE))
		return
	FOR_DVIEW(var/mob/living/possible_target, 12, xeno_player, HIDE_INVISIBLE_OBSERVER)
		if(possible_target == xeno_player || !possible_target.client)
			continue
		target_list += possible_target
		if(!istype(possible_target, /mob/living/carbon/xenomorph))
			to_chat(possible_target, SPAN_XENOQUEEN("你脑海中响起一个奇怪的外星声音。\"[SPAN_PSYTALK(whisper)]\""))
		else
			to_chat(possible_target, SPAN_XENOQUEEN("你脑海中回响着[xeno_player]的声音。\"[SPAN_PSYTALK(whisper)]\""))
	FOR_DVIEW_END
	if(!length(target_list))
		return
	var/targetstring = english_list(target_list)
	to_chat(xeno_player, SPAN_XENONOTICE("你说：\"[whisper]\" to [targetstring]"))
	xeno_player.use_plasma(radiance_plasma_cost)
	log_say("PsychicRadiance: [key_name(xeno_player)]->[targetstring] : [whisper] (AREA: [get_area_name(xeno_player)])")
	for (var/mob/dead/observer/ghost as anything in GLOB.observer_list)
		if(!ghost.client || isnewplayer(ghost))
			continue
		if(ghost.client.prefs.toggles_chat & CHAT_GHOSTHIVEMIND)
			var/rendered_message
			var/xeno_track = "(<a href='byond://?src=\ref[ghost];track=\ref[xeno_player]'>F</a>)"
			rendered_message = SPAN_XENOLEADER("PsychicRadiance: [xeno_player.real_name][xeno_track] to [targetstring], <span class='normal'>'[SPAN_PSYTALK(whisper)]'</span>")
			ghost.show_message(rendered_message, SHOW_MESSAGE_AUDIBLE)
	return

/datum/action/xeno_action/activable/queen_give_plasma/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/queen/queen = owner
	if(!queen.check_state())
		return

	if(!action_cooldown_check())
		return

	var/mob/living/carbon/xenomorph/target_xeno = target
	if(!istype(target_xeno) || target_xeno.stat == DEAD)
		to_chat(queen, SPAN_WARNING("你必须指定要给予灵能的异形。"))
		return

	if(target_xeno == queen)
		to_chat(queen, SPAN_XENOWARNING("不能给自己灵能！"))
		return

	if(!queen.can_not_harm(target_xeno))
		to_chat(queen, SPAN_WARNING("你只能指定同巢穴的异形！"))
		return

	if(!target_xeno.caste.can_be_queen_healed)
		to_chat(queen, SPAN_XENOWARNING("该阶级无法接收灵能！"))
		return

	if(SEND_SIGNAL(target_xeno, COMSIG_XENO_PRE_HEAL) & COMPONENT_CANCEL_XENO_HEAL)
		to_chat(queen, SPAN_XENOWARNING("该异形无法接收灵能！"))
		return

	if(!check_and_use_plasma_owner())
		return

	target_xeno.gain_plasma(target_xeno.plasma_max * 0.75)
	target_xeno.flick_heal_overlay(3 SECONDS, COLOR_CYAN)
	apply_cooldown()
	to_chat(queen, SPAN_XENONOTICE("你向[target_xeno]传输了一些灵能。"))
	return ..()

/datum/action/xeno_action/onclick/send_thoughts/proc/queen_order()
	var/mob/living/carbon/xenomorph/queen/xenomorph = owner
	var/give_order_plasma_cost = 100

	if(!xenomorph.check_plasma(give_order_plasma_cost))
		return
	if(!xenomorph.check_state())
		return
	if(xenomorph.observed_xeno)
		var/mob/living/carbon/xenomorph/target = xenomorph.observed_xeno
		if(target.stat != DEAD && target.client)
			if(xenomorph.check_plasma(plasma_cost))
				var/input = stripped_input(xenomorph, "此信息将发送给被监控的异形。", "Queen Order", "")
				if(!input)
					return
				var/queen_order = SPAN_XENOANNOUNCE("<b>[xenomorph]</b> reaches you:\"[input]\"")
				if(!xenomorph.check_state() || !xenomorph.check_plasma(plasma_cost) || xenomorph.observed_xeno != target || target.stat == DEAD)
					return
				if(target.client)
					xenomorph.use_plasma(plasma_cost)
					to_chat(target, "[queen_order]")
					log_admin("[queen_order]")
					message_admins("[key_name_admin(xenomorph)] has given the following Queen order to [target]: \"[input]\"", 1)
					xenomorph.use_plasma(give_order_plasma_cost)

	else
		to_chat(xenomorph, SPAN_WARNING("你必须监控你想要下达命令的异形。"))
		return
	return

/datum/action/xeno_action/onclick/queen_word/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/queen/xeno = owner
	// We don't test or apply the cooldown here because the proc does it since verbs can activate it too
	xeno.hive_message()
	return ..()
