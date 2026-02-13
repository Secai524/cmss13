/obj/item/cprbot_item
	name = "心肺复苏机器人"
	desc = "一个紧凑的心肺复苏机器人9000组件。"
	icon = 'icons/obj/structures/machinery/aibots.dmi'
	icon_state = "cprbot"
	w_class = SIZE_MEDIUM
	var/deployment_path = /obj/structure/machinery/bot/cprbot

/obj/item/cprbot_item/attack_self(mob/user as mob)
	if (..())
		return TRUE

	if(user)
		deploy_cprbot(user, user.loc)

/obj/item/cprbot_item/proc/deploy_cprbot(mob/user, atom/location)
	if(!user || !location)
		return

	if (istype(user) && !skillcheck(user, SKILL_MEDICAL, SKILL_MEDICAL_MEDIC))
		to_chat(user, SPAN_WARNING("你似乎不知道如何使用 [src]..."))
		return

	qdel(src)

	// Proceed with the CPRbot deployment
	var/obj/structure/machinery/bot/cprbot/cprbot_entity = new deployment_path(location)
	if(cprbot_entity)
		cprbot_entity.add_fingerprint(user)
		cprbot_entity.owner = user

/obj/item/cprbot_item/afterattack(atom/target, mob/user, proximity)
	if(proximity && isturf(target))
		var/turf/target_turf = target
		if(!target_turf.density)
			deploy_cprbot(user, target_turf)

/obj/item/cprbot_broken
	name = "心肺复苏机器人"
	desc = "一个紧凑的心肺复苏机器人9000组件，看起来状况不佳。"
	icon = 'icons/obj/structures/machinery/aibots.dmi'
	icon_state = "cprbot_broken"
	w_class = SIZE_MEDIUM

/obj/item/cprbot_broken/attackby(obj/item/attacked_by, mob/living/user)
	if(iswelder(attacked_by))
		if(!HAS_TRAIT(attacked_by, TRAIT_TOOL_BLOWTORCH))
			to_chat(user, SPAN_WARNING("你需要一把更强的喷枪！"))
			return

		var/obj/item/tool/weldingtool/welder_tool = attacked_by
		if(!welder_tool.isOn())
			to_chat(user, SPAN_WARNING("[welder_tool]需要打开！"))
			return

		if(!welder_tool.remove_fuel(5, user))  // Ensure enough fuel is available
			to_chat(user, SPAN_NOTICE("你需要更多焊枪燃料来完成此任务。"))
			return

		playsound(src, 'sound/items/Welder.ogg', 25, 1)

		if(!do_after(user, 10 * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL | BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
			return

		// Create the repaired item
		var/obj/item/cprbot_item/repaired_cprbot_item = new /obj/item/cprbot_item(loc)

		// Check if the broken item is in the user's hand
		var/hand_was_active = user.get_active_hand() == src
		var/hand_was_inactive = user.get_inactive_hand() == src

		// Remove the broken item
		qdel(src)

		// Attempt to place the new item into the user's hands
		if (hand_was_active)
			if (!user.put_in_active_hand(repaired_cprbot_item))
				repaired_cprbot_item.forceMove(user.loc)  // Place it at user's location if hands are full
		else if (hand_was_inactive)
			if (!user.put_in_inactive_hand(repaired_cprbot_item))
				repaired_cprbot_item.forceMove(user.loc)  // Place it at user's location if hands are full
		else
			repaired_cprbot_item.forceMove(user.loc)  // Place at the original location if not in hand
