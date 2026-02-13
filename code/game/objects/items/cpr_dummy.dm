/obj/item/cpr_dummy
	name = "\improper CPR dummy"
	desc = "一个心肺复苏训练假人，用于训练所有列兵如何拯救生命！无法准确模拟战场创伤，无法模拟肋骨断裂，塑料接触有毒，如果皮肤刺激持续超过两小时，请联系医生。"
	icon = 'icons/obj/items/cpr_dummy.dmi'
	icon_state = "cpr_dummy"
	var/successful_cprs = 0
	var/failed_cprs = 0
	var/cpr_cooldown = 0

/obj/item/cpr_dummy/get_examine_text(mob/user)
	. = ..()
	. += "Successful CPRs: [SPAN_GREEN(successful_cprs)]."
	. += "Failed CPRs: [SPAN_RED(failed_cprs)]."

/obj/item/cpr_dummy/update_icon()
	if(anchored)
		icon_state = "[initial(icon_state)]_deployed"
	else
		icon_state = initial(icon_state)
	return ..()

/obj/item/cpr_dummy/attack_self(mob/user)
	. = ..()
	user.visible_message(SPAN_NOTICE("[user]设置好\the [src]准备使用！"), SPAN_NOTICE("You set up \the [src] for use."))
	user.drop_inv_item_on_ground(src)
	anchored = TRUE
	update_icon()

/obj/item/cpr_dummy/MouseDrop(obj/over_object as obj)
	if(CAN_PICKUP(usr, src) && !usr.is_mob_restrained())
		var/success = FALSE
		if(usr == over_object && usr.put_in_hands(src))
			success = TRUE
		else
			switch(over_object.name)
				if("r_hand")
					if(src.loc != usr || usr.drop_inv_item_on_ground(src))
						usr.put_in_r_hand(src)
						success = TRUE
				if("l_hand")
					if(src.loc != usr || usr.drop_inv_item_on_ground(src))
						usr.put_in_l_hand(src)
						success = TRUE
		if(success)
			if(anchored)
				anchored = FALSE
				update_icon()
			add_fingerprint(usr)

/obj/item/cpr_dummy/attack_hand(mob/living/carbon/human/H)
	if(!anchored || !istype(H))
		return ..()
	if(H.action_busy)
		return FALSE
	if(H.a_intent != INTENT_HELP)
		to_chat(H, SPAN_WARNING("你需要处于帮助意图才能进行心肺复苏！"))
		return
	if((H.head && (H.head.flags_inventory & COVERMOUTH)) || (H.wear_mask && (H.wear_mask.flags_inventory & COVERMOUTH) && !(H.wear_mask.flags_inventory & ALLOWCPR)))
		to_chat(H, SPAN_BOLDNOTICE("摘掉你的面罩！"))
		return FALSE
	H.visible_message(SPAN_NOTICE("<b>[H]</b>开始对<b>[src]</b>进行<b>心肺复苏</b>。"), SPAN_HELPFUL("You start <b>performing CPR</b> on <b>[src]</b>."))
	if(!do_after(H, HUMAN_STRIP_DELAY * H.get_skill_duration_multiplier(SKILL_MEDICAL), INTERRUPT_ALL, BUSY_ICON_GENERIC, src, INTERRUPT_MOVED, BUSY_ICON_MEDICAL))
		return
	if(cpr_cooldown < world.time)
		H.visible_message(SPAN_NOTICE("<b>[H]</b>对<b>[src]</b>进行了<b>心肺复苏</b>。"), SPAN_HELPFUL("You perform <b>CPR</b> on <b>[src]</b>."))
		successful_cprs++
	else
		H.visible_message(SPAN_NOTICE("<b>[H]</b>未能对<b>[src]</b>进行心肺复苏。"), SPAN_HELPFUL("You <b>fail</b> to perform <b>CPR</b> on <b>[src]</b>. Incorrect rhythm. Do it <b>slower</b>."))
		failed_cprs++
	cpr_cooldown = world.time + 7 SECONDS

/obj/item/cpr_dummy/verb/reset_counter()
	set name = "Reset CPR Counter"
	set category = "Object"
	set src in oview(1)

	if(!isSEA(usr))
		to_chat(usr, SPAN_WARNING("只有高级士官顾问才能重置这个假人的计数器！"))
		return
	successful_cprs = 0
	failed_cprs = 0
	to_chat(usr, SPAN_NOTICE("你重置了\the [src]的计数器。"))
