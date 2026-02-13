/mob/living/carbon/verb/give()
	set category = "IC"
	set name = "Give"
	set src in oview(1)

	receive_from(usr)

/mob/living/carbon/proc/receive_from(mob/living/carbon/giver)
	if(stat == DEAD || giver.stat == DEAD || client == null)
		return
	if(src == giver)
		return
	if(giver.mob_flags & GIVING)
		to_chat(giver, SPAN_WARNING("你已经在给别人递东西了！"))
		return
	var/obj/item/I
	if(!giver.hand && giver.r_hand == null)
		to_chat(giver, SPAN_WARNING("你右手里没有东西可以给[name]。"))
		return
	if(giver.hand && giver.l_hand == null)
		to_chat(giver, SPAN_WARNING("你左手里没有东西可以给[name]。"))
		return
	if(!ishuman(src) || !ishuman(giver))
		return
	if(giver.hand)
		I = giver.l_hand
	else if(!giver.hand)
		I = giver.r_hand
	if(!istype(I) || (I.flags_item & (DELONDROP|NODROP|ITEM_ABSTRACT)))
		return
	if(body_position == LYING_DOWN) // replace by mobiilty_flags probably
		to_chat(giver, SPAN_WARNING("[src]躺下时无法拿住那个东西。"))
		return
	if(r_hand && l_hand)
		to_chat(giver, SPAN_WARNING("[src]双手都满了。"))
		return
	giver.mob_flags |= GIVING
	if(tgui_alert(src, "[giver]想给你\a [I]？", "You are being offered an item", list("Yes", "No"), 10 SECONDS) == "Yes")
		giver.mob_flags &= ~GIVING
		if(!I || !giver || !istype(I))
			return
		if(!Adjacent(giver))
			to_chat(giver, SPAN_WARNING("递送物品时，你需要保持在可触及范围内。"))
			to_chat(src, SPAN_WARNING("[giver]移动得太远了。"))
			return
		if((giver.hand && giver.l_hand != I) || (!giver.hand && giver.r_hand != I))
			to_chat(giver, SPAN_WARNING("你需要将物品保持在你的主手中。"))
			to_chat(src, SPAN_WARNING("[giver]似乎放弃了将[I]交给你的打算。"))
			return
		if(body_position == LYING_DOWN)
			to_chat(src, SPAN_WARNING("躺下时你无法手持该物品。"))
			to_chat(giver, SPAN_WARNING("[src]躺下时无法拿住那个东西。"))
			return
		if(r_hand && l_hand)
			to_chat(src, SPAN_WARNING("你的双手已满。"))
			to_chat(giver, SPAN_WARNING("[src]双手都满了。"))
			return
		if(giver.drop_held_item())
			if(put_in_hands(I))
				giver.visible_message(SPAN_NOTICE("[giver]将[I]递给[src]。"),
				SPAN_NOTICE("You hand [I] to [src]."), null, 4)
	else
		giver.mob_flags &= ~GIVING
		return
