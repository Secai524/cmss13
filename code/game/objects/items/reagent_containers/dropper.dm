////////////////////////////////////////////////////////////////////////////////
/// Droppers.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_container/dropper
	name = "dropper"
	desc = "一种用于测量和转移少量液体的工具。最多可转移5单位。"
	icon = 'icons/obj/items/chemistry.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
	)
	icon_state = "dropper"
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(1,2,3,4,5)
	w_class = SIZE_TINY
	volume = 5
	matter = list("plastic" = 150)
	transparent = TRUE
	var/filled = 0

/obj/item/reagent_container/dropper/update_icon() //droppers now have fill icon states for each unit inside the dropper
	overlays.Cut()

	if(reagents?.total_volume)
		var/image/filling
		var/percent = floor((reagents.total_volume / volume) * 100)
		switch(percent)
			if(1 to 20)
				filling = image('icons/obj/items/reagentfillings.dmi', src, "[icon_state]-1")
			if(21 to 40)
				filling = image('icons/obj/items/reagentfillings.dmi', src, "[icon_state]-2")
			if(41 to 60)
				filling = image('icons/obj/items/reagentfillings.dmi', src, "[icon_state]-3")
			if(61 to 80)
				filling = image('icons/obj/items/reagentfillings.dmi', src, "[icon_state]-4")
			if(81 to INFINITY)
				filling = image('icons/obj/items/reagentfillings.dmi', src, "[icon_state]-5")
			else
				return ..()

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		overlays += filling
	..()

/obj/item/reagent_container/dropper/afterattack(obj/target, mob/user , flag)
	if(!target.reagents || !flag)
		return

	if(filled)

		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, SPAN_DANGER("[target]已满。"))
			return

		if(!target.is_open_container() && !ismob(target) && !istype(target,/obj/item/reagent_container/food) && !istype(target, /obj/item/clothing/mask/cigarette)) //You can inject humans and food but you can't remove the shit.
			to_chat(user, SPAN_DANGER("你无法直接填充此物体。"))
			return

		var/trans = 0

		if(ismob(target))

			var/time = 20 //2/3rds the time of a syringe
			for(var/mob/O in viewers(GLOB.world_view_size, user))
				O.show_message(SPAN_DANGER("<B>[user]正试图将什么东西挤进[target]的眼睛里！</B>"), SHOW_MESSAGE_VISIBLE)

			if(!do_after(user, time, INTERRUPT_ALL, BUSY_ICON_FRIENDLY, target, INTERRUPT_MOVED, BUSY_ICON_MEDICAL))
				return

			if(istype(target , /mob/living/carbon/human))
				var/mob/living/carbon/human/victim = target

				var/obj/item/safe_thing = null
				if( victim.wear_mask )
					if ( victim.wear_mask.flags_inventory & COVEREYES )
						safe_thing = victim.wear_mask
				if( victim.head )
					if ( victim.head.flags_inventory & COVEREYES )
						safe_thing = victim.head
				if(victim.glasses)
					if ( !safe_thing )
						safe_thing = victim.glasses

				if(safe_thing)
					if(!safe_thing.reagents)
						safe_thing.create_reagents(100)
					trans = src.reagents.trans_to(safe_thing, amount_per_transfer_from_this)

					for(var/mob/O in viewers(GLOB.world_view_size, user))
						O.show_message(SPAN_DANGER("<B>[user]试图将什么东西挤进[target]的眼睛里，但失败了！</B>"), SHOW_MESSAGE_VISIBLE)
					spawn(5)
						src.reagents.reaction(safe_thing, TOUCH)

					to_chat(user, SPAN_NOTICE("你转移了[trans]单位的溶液。"))
					if(src.reagents.total_volume<=0)
						filled = 0
						update_icon()
						user.update_inv_l_hand()
						user.update_inv_r_hand()
					return

			for(var/mob/O in viewers(GLOB.world_view_size, user))
				O.show_message(SPAN_DANGER("<B>[user]将什么东西挤进了[target]的眼睛里！</B>"), SHOW_MESSAGE_VISIBLE)
			src.reagents.reaction(target, TOUCH)

			var/mob/living/M = target

			var/list/injected = list()
			for(var/datum/reagent/R in src.reagents.reagent_list)
				injected += R.name
			var/contained = english_list(injected)
			M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been squirted with [src.name] by [user.name] ([user.ckey]). Reagents: [contained]</font>")
			user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [src.name] to squirt [M.name] ([M.key]). Reagents: [contained]</font>")
			msg_admin_attack("[user.name] ([user.ckey]) squirted [M.name] ([M.key]) with [src.name] (REAGENTS: [contained]) (INTENT: [uppertext(intent_text(user.a_intent))]) in [get_area(src)] ([src.loc.x],[src.loc.y],[src.loc.z]).", src.loc.x, src.loc.y, src.loc.z)

		trans = src.reagents.trans_to(target, amount_per_transfer_from_this)
		to_chat(user, SPAN_NOTICE("你转移了[trans]单位的溶液。"))
		if(src.reagents.total_volume<=0)
			filled = 0
			update_icon()
			user.update_inv_l_hand()
			user.update_inv_r_hand()

	else

		if(!target.is_open_container() && !istype(target,/obj/structure/reagent_dispensers))
			to_chat(user, SPAN_DANGER("你无法直接从[target]中移除试剂。"))
			return

		if(!target.reagents.total_volume)
			to_chat(user, SPAN_DANGER("[target]是空的。"))
			return

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this)

		if(!trans)
			to_chat(user, SPAN_DANGER("你未能从[target]中取出试剂。"))
			return

		to_chat(user, SPAN_NOTICE("你向滴管中注入了[trans]单位溶液。"))

		filled = 1
		update_icon()
		user.update_inv_l_hand()
		user.update_inv_r_hand()

	return

////////////////////////////////////////////////////////////////////////////////
/// Droppers. END
////////////////////////////////////////////////////////////////////////////////
