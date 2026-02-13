/mob/living/carbon/human/proc/mark_panel()
	set name = "Mark Panel"
	set category = "Yautja.Marks"
	set desc = "Allows you to mark your prey."

	if(is_mob_incapacitated())
		to_chat(src, SPAN_DANGER("你现在无法这么做。"))
		return

	var/mob/living/carbon/human/target = src
	if(!isyautja(target))
		return

	var/list/options = list()
	var/list/optionsp = list(
		"Un-Mark as Thralled",
		"Mark as Blooded",
		"Mark as Honored",
		"Un-Mark as Honored",
		"Mark as Dishonorable",
		"Un-Mark as Dishonorable",
		"Mark as Gear Carrier",
		"Un-Mark as Gear Carrier"
	)

	if(!target.hunter_data.prey)
		options += "Mark as Prey"
	else
		options += "Un-Mark as Prey"

	if(!target.hunter_data.thrall)
		options += "Mark as Thralled"

	options += optionsp

	var/input = tgui_input_list(usr, "选择要施加的标记", "Mark Panel", options)

	if(!input)
		return
	else if(input)

		switch(input)
			if("Mark as Prey")
				target.mark_for_hunt()
			if("Un-Mark as Prey")
				target.remove_from_hunt()
			if("Mark as Honored")
				target.mark_honored()
			if("Un-Mark as Honored")
				target.unmark_honored()
			if("Mark as Dishonorable")
				target.mark_dishonored()
			if("Un-Mark as Dishonorable")
				target.unmark_dishonored()
			if("Mark as Gear Carrier")
				target.mark_gear()
			if("Un-Mark as Gear Carrier")
				target.unmark_gear()
			if("Mark as Thralled")
				target.mark_thralled()
			if("Un-Mark as Thralled")
				target.unmark_thralled()
			if("Mark as Blooded")
				target.mark_blooded()

	return

// Mark for Hunt verbs
// Add prey for hunt
/mob/living/carbon/human/proc/mark_for_hunt()
	set category = "Yautja.Marks"
	set name = "标记为猎物"
	set desc = "Mark a target for the hunt."

	if(is_mob_incapacitated())
		to_chat(src, SPAN_DANGER("你现在无法这么做。"))
		return

	// Only one prey per pred
	if(hunter_data.prey)
		to_chat(src, SPAN_DANGER("你已经在追踪某个目标了。"))
		return

	if(!isyautja(src))
		to_chat(src, SPAN_WARNING("你是怎么得到这个指令的？"))
		return

	// List all possible preys
	// We only target living humans and xenos
	var/list/target_list = list()
	for(var/mob/living/prey in range(7, usr.client))
		if((ishuman_strict(prey) || isxeno(prey)) && prey.stat != DEAD)
			target_list += prey

	var/mob/living/carbon/M = tgui_input_list(usr, "目标", "Choose a prey.", target_list)
	if(!M)
		return
	if(M.hunter_data.hunter)
		to_chat(src, SPAN_YAUTJABOLD("[M] 已经被 [M.hunter_data.hunter.real_name] 盯上了！"))
		return
	hunter_data.prey = M
	M.hunter_data.hunter = src
	M.hunter_data.hunted = TRUE
	M.hud_set_hunter()

	// Notify the pred
	to_chat(src, SPAN_YAUTJABOLD("你已选择 [hunter_data.prey] 作为你的下一个猎物。"))

	// Notify other preds
	message_all_yautja("[real_name] has chosen [hunter_data.prey] ([max(hunter_data.prey.life_kills_total, hunter_data.prey.default_honor_value)] honor) as their next target at \the [get_area_name(hunter_data.prey)].")

	// log to server file
	log_interact(src, hunter_data.prey, "[key_name(src)] has marked [key_name(hunter_data.prey)] for the Hunt in [get_area(hunter_data.prey)] ([x],[y],[z]).")

// Removing prey from hunt (i.e. it died, it bugged, it left the game, etc.)
/mob/living/carbon/human/proc/remove_from_hunt()
	set category = "Yautja.Marks"
	set name = "Remove from Hunt"
	set desc = "Unmark your hunt target."

	if(is_mob_incapacitated())
		to_chat(src, SPAN_DANGER("你现在无法这么做。"))
		return

	if(!hunter_data.prey)
		to_chat(src, SPAN_DANGER("你目前没有追踪任何目标。"))
		return

	if(!isyautja(src))
		to_chat(src, SPAN_WARNING("你是怎么得到这个指令的？"))
		return

	if (alert(usr, "你确定要放弃这个猎物吗？", "Remove from Hunt:", "Yes", "No") != "Yes")
		return
	var/mob/living/carbon/prey = hunter_data.prey
	to_chat(src, SPAN_YAUTJABOLD("你已将 [prey] 从你的狩猎名单中移除。"))
	prey.hunter_data.hunter = null
	prey.hunter_data.hunted = FALSE
	log_interact(src, hunter_data.prey, "[key_name(src)] has un-marked [key_name(hunter_data.prey)] for the Hunt")
	hunter_data.prey = null
	prey.hud_set_hunter()



/mob/living/carbon/human/proc/mark_honored()
	if(is_mob_incapacitated())
		to_chat(src, SPAN_DANGER("你现在无法这么做。"))
		return

	if(!isyautja(src))
		to_chat(src, SPAN_WARNING("你是怎么得到这个指令的？"))
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/target in range(7, usr.client))
		if(ishuman_strict(target) && (target.stat != DEAD))
			target_list += target

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "Choose a target.", target_list)
	if(!T)
		return
	if(T.hunter_data.honored)
		to_chat(src, SPAN_YAUTJABOLD("[T] 已经被 [T.hunter_data.honored_set.real_name] 因'[T.hunter_data.honored_reason]'而授予荣誉！"))
		return

	var/reason = stripped_input(usr, "输入将目标标记为荣誉猎物的原因。", "Mark as Honored", "", 120)

	if(!reason)
		return

	log_interact(src, T, "[key_name(src)] has marked [key_name(T)] as Honored for '[reason]'.")
	message_all_yautja("[real_name] has marked [T] as Honored for '[reason]'.")

	T.hunter_data.honored_set = src
	hunter_data.honored_targets += T
	T.hunter_data.honored = TRUE
	T.hunter_data.honored_reason = "[reason]' by '[src.real_name]"
	T.hud_set_hunter()



/mob/living/carbon/human/proc/unmark_honored()
	if(is_mob_incapacitated())
		to_chat(src, SPAN_DANGER("你现在无法这么做。"))
		return

	if(!isyautja(src))
		to_chat(src, SPAN_WARNING("你是怎么得到这个指令的？"))
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/target in range(7, usr.client))
		if(ishuman_strict(target))
			if(target.hunter_data.honored)
				target_list += target

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "Choose a target.", target_list)
	if(!T)
		return
	if(!T.hunter_data.honored)
		to_chat(src, SPAN_YAUTJABOLD("[T] 并未被标记为荣誉猎物！"))
		return

	if(!T.hunter_data.honored_set || src == T.hunter_data.honored_set)

		log_interact(src, T, "[key_name(src)] has un-marked [key_name(T)] as honored!")
		message_all_yautja("[real_name] has un-marked [T] as honored!'.")

		T.hunter_data.honored_set = null
		hunter_data.honored_targets += T
		T.hunter_data.honored = FALSE
		T.hunter_data.honored_reason = null
		T.hud_set_hunter()
	else
		to_chat(src, SPAN_YAUTJABOLD("你不能撤销一位尚在世的兄弟或姐妹的行为！"))



/mob/living/carbon/human/proc/mark_dishonored()
	if(is_mob_incapacitated())
		to_chat(src, SPAN_DANGER("你现在无法这么做。"))
		return

	if(!isyautja(src))
		to_chat(src, SPAN_WARNING("你是怎么得到这个指令的？"))
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/target in range(7, usr.client))
		if((ishuman_strict(target) || isxeno(target)) && target.stat != DEAD)
			target_list += target

	if(isyautja(src) && src.hunter_data.thrall)
		target_list += src.hunter_data.thrall

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "Choose a target.", target_list)
	if(!T)
		return
	if(T.hunter_data.dishonored)
		to_chat(src, SPAN_YAUTJABOLD("[T] 已经被 [T.hunter_data.dishonored_set.real_name] 因'[T.hunter_data.dishonored_reason]'而标记为不荣誉！"))
		return

	var/reason = stripped_input(usr, "输入将目标标记为不荣誉的原因。", "Mark as Dishonorable", "", 120)

	if(!reason)
		return

	log_interact(src, T, "[key_name(src)] has marked [key_name(T)] as Dishonorable for '[reason]'.")
	message_all_yautja("[real_name] has marked [T] as Dishonorable for '[reason]'.")

	T.hunter_data.dishonored_set = src
	hunter_data.dishonored_targets += T
	T.hunter_data.dishonored = TRUE
	T.hunter_data.dishonored_reason = "[reason]' by '[src.real_name]"
	T.hud_set_hunter()



/mob/living/carbon/human/proc/unmark_dishonored()
	if(is_mob_incapacitated())
		to_chat(src, SPAN_DANGER("你现在无法这么做。"))
		return

	if(!isyautja(src))
		to_chat(src, SPAN_WARNING("你是怎么得到这个指令的？"))
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/target in range(7, usr.client))
		if(ishuman_strict(target) || isxeno(target))
			if(target.job != "Predalien" && target.job != "Predalien Larva")
				if(target.hunter_data.dishonored)
					target_list += target

	if(isyautja(src) && src.hunter_data.thrall)
		target_list += src.hunter_data.thrall

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "Choose a target.", target_list)
	if(!T)
		return
	if(!T.hunter_data.dishonored)
		to_chat(src, SPAN_YAUTJABOLD("[T] 并未被标记为不荣誉！"))
		return

	if(!T.hunter_data.dishonored_set || src == T.hunter_data.dishonored_set)

		log_interact(src, T, "[key_name(src)] has un-marked [key_name(T)] as dishonorable!")
		message_all_yautja("[real_name] has un-marked [T] as dishonorable!'.")

		T.hunter_data.dishonored_set = null
		hunter_data.dishonored_targets -= T
		T.hunter_data.dishonored = FALSE
		T.hunter_data.dishonored_reason = null
		T.hud_set_hunter()
	else
		to_chat(src, SPAN_YAUTJABOLD("你不能撤销一位尚在世的兄弟或姐妹的行为！"))



/mob/living/carbon/human/proc/mark_gear()
	if(is_mob_incapacitated())
		to_chat(src, SPAN_DANGER("你现在无法这么做。"))
		return

	if(!isyautja(src))
		to_chat(src, SPAN_WARNING("你是怎么得到这个指令的？"))
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/target in range(7, usr.client))
		if(ishuman(target))
			target_list += target

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "Choose a target.", target_list)
	if(!T)
		return
	if(T.hunter_data.gear)
		to_chat(src, SPAN_YAUTJABOLD("[T] 已经被 [T.hunter_data.gear_set] 标记为装备携带者！"))
		return

	log_interact(src, T, "[key_name(src)] has marked [key_name(T)] as a Gear Carrier!")
	message_all_yautja("[real_name] has marked [T] as a Gear Carrier!'.")

	T.hunter_data.gear_set = src
	hunter_data.gear_targets += T
	T.hunter_data.gear = TRUE
	T.hud_set_hunter()



/mob/living/carbon/human/proc/unmark_gear()
	if(is_mob_incapacitated())
		to_chat(src, SPAN_DANGER("你现在无法这么做。"))
		return

	if(!isyautja(src))
		to_chat(src, SPAN_WARNING("你是怎么得到这个指令的？"))
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/target in range(7, usr.client))
		if(ishuman(target))
			if(target.hunter_data.gear)
				target_list += target

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "Choose a target.", target_list)
	if(!T)
		return
	if(!T.hunter_data.gear)
		to_chat(src, SPAN_YAUTJABOLD("[T] 并未被标记为装备携带者！"))
		return


	log_interact(src, T, "[key_name(src)] has un-marked [key_name(T)] as a Gear Carrier!")
	message_all_yautja("[real_name] has un-marked [T] as a Gear Carrier!'.")

	T.hunter_data.gear_set = null
	hunter_data.gear_targets -= T
	T.hunter_data.gear = FALSE
	T.hud_set_hunter()


/mob/living/carbon/human/proc/mark_thralled()
	if(is_mob_incapacitated())
		to_chat(src, SPAN_DANGER("你现在无法这么做。"))
		return

	if(!isyautja(src))
		to_chat(src, SPAN_WARNING("你是怎么得到这个指令的？"))
		return

	if(hunter_data.thrall)
		to_chat(src, SPAN_WARNING("你已经有一个仆从了。"))
		return

	// List all possible targets
	// We only target living humans
	var/list/target_list = list()
	for(var/mob/living/carbon/target in range(7, usr.client))
		if(ishuman_strict(target) && target.stat != DEAD)
			target_list += target

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "Choose a target.", target_list)
	if(!T)
		return
	if(T.hunter_data.thralled)
		to_chat(src, SPAN_YAUTJABOLD("[T] 已经被 [T.hunter_data.thralled_set.real_name] 因'[T.hunter_data.thralled_reason]'而收为仆从！"))
		return

	var/reason = stripped_input(usr, "输入将目标标记为仆从的原因。", "Mark as Thralled", "", 120)

	if(!reason)
		return

	log_interact(src, T, "[key_name(src)] has taken [key_name(T)] as their Thrall for '[reason]'.")
	message_all_yautja("[real_name] has taken [T] as their Thrall for '[reason]'.")

	T.hunter_data.thralled_set = src
	T.hunter_data.thralled = TRUE
	T.hunter_data.thralled_reason = reason
	hunter_data.thrall = T
	T.hud_set_hunter()



/mob/living/carbon/human/proc/unmark_thralled()
	if(is_mob_incapacitated())
		to_chat(src, SPAN_DANGER("你现在无法这么做。"))
		return

	if(!isyautja(src))
		to_chat(src, SPAN_WARNING("你是怎么得到这个指令的？"))
		return

	// List all possible targets
	// We only target living humans
	var/list/target_list = list()
	for(var/mob/living/carbon/target in range(7, usr.client))
		if(ishuman_strict(target))
			if(target.hunter_data.thralled)
				target_list += target

	if(isyautja(src) && src.hunter_data.thrall)
		target_list += src.hunter_data.thrall

	var/mob/living/carbon/human/thrall  = tgui_input_list(usr, "目标", "Choose a target.", target_list)

	if(!thrall)
		return
	if(!thrall.hunter_data.thralled)
		to_chat(src, SPAN_YAUTJABOLD("[thrall]未被标记为仆从！"))
		return

	if(!thrall.hunter_data.thralled_set || src == thrall.hunter_data.thralled_set)

		log_interact(src, thrall, "[key_name(src)] has released [key_name(thrall)] from thralldom!")
		message_all_yautja("[real_name] has released [thrall] from thralldom!'.")

		thrall.set_species("人类")
		thrall.allow_gun_usage = TRUE
		thrall.hunter_data.thralled_set = null
		thrall.hunter_data.thralled = FALSE
		thrall.hunter_data.thralled_reason = null
		hunter_data.thrall = null
		thrall.hud_set_hunter()
	else
		to_chat(src, SPAN_YAUTJABOLD("你不能撤销一位尚在世的兄弟或姐妹的行为！"))

/mob/living/carbon/human/proc/mark_blooded() //No mark_unblooded, once a thrall becomes a blooded hunter, there is no going back.
	if(is_mob_incapacitated())
		to_chat(src, SPAN_DANGER("你现在无法这么做。"))
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/target in long_range(7, usr))
		if(ishuman_strict(target) && target.stat != DEAD)
			target_list += target

	var/mob/living/carbon/newblood = tgui_input_list(usr, "目标", "Choose a target.", target_list)
	if(!newblood)
		return
	if(newblood.hunter_data.blooded)
		to_chat(src, SPAN_YAUTJABOLD("[newblood]已被[newblood.hunter_data.blooded_set.real_name]以'[newblood.hunter_data.blooded_reason]'为由授予血契！"))
		return
	if(newblood.faction == FACTION_YAUTJA_YOUNG || newblood.hunter_data.thralled) //Only youngbloods or thralls can become blooded hunters.

		var/reason = stripped_input(usr, "输入将你的目标标记为血契猎物的理由。", "Mark as Blooded", "", 120)

		if(!reason)
			return

		log_interact(src, newblood, "[key_name(src)] has blooded [key_name(newblood)] for '[reason]'.")
		message_all_yautja("[real_name] has blooded [newblood] for '[reason]'.")

		ADD_TRAIT(newblood, TRAIT_YAUTJA_TECH, "Yautja Tech")
		to_chat(newblood, SPAN_YAUTJABOLD("你是一名血契仆从。专注于与铁血战士互动并提升你的声望。狩猎有价值的猎物时，你应保持观察力与谨慎，并行使克制的判断力。学习铁血战士的传说与荣誉准则。如有任何疑问，请在LOOC中询问白名单玩家。"))

		newblood.set_skills(/datum/skills/yautja/warrior) //Overrides exsiting skill path to allow for use of the medicomp. SKills never updated to proper hero mob status prior to this.
		newblood.hunter_data.blooded_set = src
		newblood.hunter_data.blooded = TRUE
		newblood.hunter_data.blooded_reason = reason
		hunter_data.newblood = newblood
		newblood.hud_set_hunter()

	if(newblood.faction == FACTION_YAUTJA_YOUNG)
		return

	else if(newblood.hunter_data.thralled)
		var/predtitle = (stripped_input(usr, "输入新血猎手的新名字。", "Blooded Name", "" , MAX_NAME_LEN))
		change_real_name(newblood, html_decode(predtitle))
		GLOB.yautja_mob_list += newblood
		newblood.faction = FACTION_BLOODED_HUNTER
		newblood.faction_group = FACTION_LIST_YAUTJA

	else if(!newblood.hunter_data.thralled)
		to_chat(src, SPAN_YAUTJABOLD("[newblood]尚未证明自己配得上血契。"))
		return

/mob/living/carbon/human/proc/call_combi()
	set name = "拉回组合矛"
	set category = "Yautja.Weapons"
	set desc = "Yank on your combi-stick's chain, if it's in range. Otherwise... recover it yourself."

	if(usr.is_mob_incapacitated())
		return FALSE
	call_combi_internal(usr)

/mob/living/carbon/human/proc/call_combi_internal(mob/user, forced = FALSE)
	for(var/datum/effects/tethering/tether in user.effects_list)
		if(istype(tether.tethered.affected_atom, /obj/item/weapon/yautja/chained))
			var/obj/item/weapon/yautja/chained/stick = tether.tethered.affected_atom
			stick.recall()
