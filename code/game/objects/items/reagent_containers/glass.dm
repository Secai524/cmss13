////////////////////////////////////////////////////////////////////////////////
/// (Mixing) Glass
////////////////////////////////////////////////////////////////////////////////

/obj/item/reagent_container/glass
	name = " "
	desc = " "
	icon = 'icons/obj/items/chemistry.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_righthand.dmi'
	)
	icon_state = null
	item_state = null
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,40,50,60)
	volume = 60
	flags_atom = FPRINT|OPENCONTAINER
	transparent = TRUE
	var/splashable = TRUE
	var/has_lid = TRUE
	var/base_name = " "


	var/list/can_be_placed_into = list(
		/obj/structure/machinery/chem_master/,
		/obj/structure/machinery/chem_dispenser/,
		/obj/structure/machinery/reagentgrinder,
		/obj/structure/surface/table,
		/obj/structure/closet,
		/obj/structure/sink,
		/obj/item/storage,
		/obj/item/clothing,
		/obj/structure/machinery/cryo_cell,
		/obj/item/explosive,
		/obj/item/mortar_shell/custom,
		/obj/item/ammo_magazine/rocket/custom,
		/obj/structure/machinery/bot/medbot,
		/obj/structure/machinery/computer/pandemic,
		/obj/item/storage/secure/safe,
		/obj/structure/machinery/iv_drip,
		/obj/structure/machinery/disposal,
		/mob/living/simple_animal/big/cow,
		/mob/living/simple_animal/hostile/retaliate/goat,
		/obj/structure/machinery/medical_pod/sleeper,
		/obj/structure/machinery/smartfridge/,
		/obj/structure/machinery/biogenerator,
		/obj/structure/machinery/reagent_analyzer,
		/obj/structure/machinery/centrifuge,
		/obj/structure/machinery/autodispenser,
		/obj/structure/machinery/constructable_frame)

/obj/item/reagent_container/glass/Initialize()
	. = ..()
	base_name = name
	ADD_TRAIT(src, TRAIT_REACTS_UNSAFELY, TRAIT_SOURCE_INHERENT)

/obj/item/reagent_container/glass/get_examine_text(mob/user)
	. = ..()
	if(get_dist(user, src) > 2 && user != loc)
		return
	if(!is_open_container())
		. += SPAN_INFO("An airtight lid seals it completely.")

/obj/item/reagent_container/glass/attack_self()
	..()
	if(!has_lid)
		return
	if(splashable)
		if(is_open_container())
			to_chat(usr, SPAN_NOTICE("你盖上了[src]的盖子。"))
			flags_atom ^= OPENCONTAINER
		else
			to_chat(usr, SPAN_NOTICE("你打开了[src]的盖子。"))
			flags_atom |= OPENCONTAINER
		update_icon()

/obj/item/reagent_container/glass/afterattack(obj/target, mob/user , flag)
	if(!reagents)
		create_reagents(volume)

	if(!is_open_container_or_can_be_dispensed_into() || !flag)
		return

	for(var/type in src.can_be_placed_into)
		if(istype(target, type))
			return

	if(is_open_container() && ismob(target) && target.reagents && reagents.total_volume && user.a_intent == INTENT_HARM && splashable)
		to_chat(user, SPAN_NOTICE("你将溶液泼洒到[target]上。"))
		playsound(target, 'sound/effects/slosh.ogg', 25, 1)

		var/mob/living/M = target
		var/list/injected = list()
		for(var/datum/reagent/R in src.reagents.reagent_list)
			injected += R.name
		var/contained = english_list(injected)
		M.last_damage_data = create_cause_data(initial(name), user)
		M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been splashed with [src.name] by [user.name] ([user.ckey]). Reagents: [contained]</font>")
		user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [src.name] to splash [M.name] ([M.key]). Reagents: [contained]</font>")
		msg_admin_attack("[user.name] ([user.ckey]) splashed [M.name] ([M.key]) with [src.name] (REAGENTS: [contained]) (INTENT: [uppertext(intent_text(user.a_intent))]) in [get_area(user)] ([user.loc.x],[user.loc.y],[user.loc.z]).", user.loc.x, user.loc.y, user.loc.z)

		visible_message(SPAN_WARNING("[target]被[user]泼洒了某种东西！"))
		reagents.reaction(target, TOUCH)
		if(!QDELETED(src))
			reagents.clear_reagents()
		return
	else if(istype(target, /obj/structure/reagent_dispensers)) //A dispenser. Transfer FROM it TO us.
		var/obj/structure/reagent_dispensers/dispenser = target
		dispenser.add_fingerprint(user)
		if(dispenser.dispensing)
			if(!target.reagents.total_volume && target.reagents)
				to_chat(user, SPAN_WARNING("\The [target] is empty."))
				return

			if(reagents.total_volume >= reagents.maximum_volume)
				to_chat(user, SPAN_WARNING("\The [src] is full."))
				return

			var/trans = target.reagents.trans_to(src, target:amount_per_transfer_from_this)

			if(!trans)
				to_chat(user, SPAN_DANGER("你未能从[target]中取出试剂。"))
				return

			to_chat(user, SPAN_NOTICE("你用[target]中的内容物向[src]注入了[trans]单位。"))
		else
			if(is_open_container_or_can_be_dispensed_into())
				if(reagents && !reagents.total_volume)
					to_chat(user, SPAN_WARNING("\The [src] is empty."))
					return

				if(dispenser.reagents.total_volume >= dispenser.reagents.maximum_volume)
					to_chat(user, SPAN_WARNING("\The [dispenser] is full."))
					return

				var/trans = reagents.trans_to(dispenser, dispenser:amount_per_transfer_from_this)

				if(!trans)
					to_chat(user, SPAN_DANGER("你未能向[target]添加试剂。"))
					return

				to_chat(user, SPAN_NOTICE("你用[src]中的内容物向[dispenser]注入了[trans]单位。"))
			else
				to_chat(user, SPAN_WARNING("你必须先打开容器！"))

	else if(is_open_container() && target.is_open_container() && target.reagents) //Something like a glass. Player probably wants to transfer TO it.

		if(!reagents.total_volume)
			to_chat(user, SPAN_WARNING("[src]是空的。"))
			return

		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, SPAN_WARNING("\The [target] is full."))
			return

		var/trans = src.reagents.trans_to(target, amount_per_transfer_from_this)

		if(!trans)
			to_chat(user, SPAN_DANGER("你未能向[target]添加试剂。"))
			return

		to_chat(user, SPAN_NOTICE("你将[trans]单位溶液转移至[target]。"))

	else if(istype(target, /obj/structure/machinery/smartfridge))
		return

	else if(is_open_container() && (reagents.total_volume) && (user.a_intent == INTENT_HARM) && splashable)
		to_chat(user, SPAN_NOTICE("你将溶液泼洒到[target]上。"))
		playsound(target, 'sound/effects/slosh.ogg', 25, 1)
		reagents.reaction(target, TOUCH)
		if(!QDELETED(src))
			reagents.clear_reagents()
		return


/obj/item/reagent_container/glass/attackby(obj/item/attacking_object, mob/living/user)
	if(HAS_TRAIT(attacking_object, TRAIT_TOOL_PEN))
		var/prior_label_text
		var/datum/component/label/labelcomponent = GetComponent(/datum/component/label)
		if(labelcomponent && labelcomponent.has_label())
			prior_label_text = labelcomponent.label_name
		var/tmp_label = tgui_input_text(user, "为[src]输入标签（或留空以移除）", "Label", prior_label_text, MAX_NAME_LEN, ui_state=GLOB.not_incapacitated_state)
		if(isnull(tmp_label))
			return // Canceled
		if(!tmp_label)
			if(prior_label_text)
				log_admin("[key_name(usr)] has removed label from [src].")
				user.visible_message(SPAN_NOTICE("[user]移除了[src]上的标签。"),
									SPAN_NOTICE("You remove the label from [src]."))
				labelcomponent.clear_label()
			return
		if(length(tmp_label) > MAX_NAME_LEN)
			to_chat(user, SPAN_WARNING("标签长度最多为[MAX_NAME_LEN]个字符。"))
			return
		if(prior_label_text == tmp_label)
			to_chat(user, SPAN_WARNING("标签上已经写着\"[tmp_label]\"."))
			return
		user.visible_message(SPAN_NOTICE("[user]将[src]标记为\"[tmp_label]\"."),
		SPAN_NOTICE("You label [src] as \"[tmp_label]\"."))
		AddComponent(/datum/component/label, tmp_label)
		playsound(src, "paper_writing", 15, TRUE)
		return

	if(istype(attacking_object, /obj/item/storage/pill_bottle)) //dumping a pill bottle's contents in a container
		var/obj/item/storage/pill_bottle/pbottle = attacking_object
		if(reagents)
			if(!is_open_container())
				to_chat(user, SPAN_WARNING("[src]盖着盖子。有盖子挡着，你无法将药片倒入[src]。"))
				return
			if(reagents?.total_volume <= 0)
				to_chat(user, SPAN_WARNING("[src]需要含有液体来溶解药片。"))
				return
			if(reagents.total_volume >= reagents.maximum_volume)
				to_chat(user, SPAN_WARNING("[src]已满。你无法溶解更多药片。"))
				return
			if(length(pbottle.contents) <= 0)
				to_chat(user, SPAN_WARNING("你没有任何药片可以从\the [pbottle.name]中倒出。"))
				return
			user.visible_message(SPAN_NOTICE("[user]开始将\the [pbottle.name]中的东西倒入[src]..."),
			SPAN_NOTICE("You start to empty \the [pbottle.name] into [src]..."),
			SPAN_NOTICE("You hear the emptying of a pill bottle and pills dropping into liquid."), 2)

			var/waiting_time = (length(pbottle.contents)) * 0.125 SECONDS
			if(!do_after(user, waiting_time, INTERRUPT_NO_NEEDHAND|BEHAVIOR_IMMOBILE, BUSY_ICON_FRIENDLY, src))
				user.visible_message(SPAN_NOTICE("[user]停止了将\the [pbottle.name]倒入[src]的尝试。"),
				SPAN_WARNING("You get distracted and stop trying to empty \the [pbottle.name] into [src]."))
				return

			var/list/reagent_list_text = list()
			for(var/obj/item/reagent_container/pill/pill in pbottle.contents)
				var/temp_reagent_text = pill.get_reagent_list_text()
				if(temp_reagent_text in reagent_list_text)
					reagent_list_text[temp_reagent_text]++
				else
					reagent_list_text += temp_reagent_text

				var/amount = pill.reagents.total_volume + reagents.total_volume
				var/loss = amount - reagents.maximum_volume

				pill.reagents.trans_to(src, reagents.total_volume)
				pbottle.forced_item_removal(pill)
				if(amount > reagents.maximum_volume)
					user.visible_message(SPAN_WARNING("[user]使[src]溢出，洒出了一些内容物。"),
					SPAN_WARNING("[src] overflows and spills [loss]u of the last pill you dissolved."))
					break

			var/output_text
			for(var/reagent_text in reagent_list_text)
				output_text += "[output_text ? "," : ":" ] [reagent_list_text[reagent_text]+1] Pill[reagent_list_text[reagent_text] > 0 ? "s" : ""] of " + reagent_text
			user.visible_message(SPAN_NOTICE("[user]完成了将\the [pbottle.name]倒入[src]的操作。"), SPAN_NOTICE("You stop emptying \the [pbottle.name] into [src]."))
			log_interact(user, null, "[key_name(user)] dissolved the contents of \the [pbottle.name] containing [output_text] into [src].")
			return // No call parent AFTER loop is done. Prevents pill bottles from attempting to gather pills.

	return ..()

/obj/item/reagent_container/glass/beaker
	name = "beaker"
	desc = "一个烧杯。最多可容纳60单位。"
	icon = 'icons/obj/items/chemistry.dmi'
	icon_state = "beaker"
	item_state = "beaker"
	matter = list("glass" = 500)
	attack_speed = 4

/obj/item/reagent_container/glass/beaker/on_reagent_change()
	update_icon()

/obj/item/reagent_container/glass/beaker/pickup(mob/user)
	. = ..()
	update_icon()

/obj/item/reagent_container/glass/beaker/dropped(mob/user)
	..()
	update_icon()

/obj/item/reagent_container/glass/beaker/attack_hand()
	..()
	update_icon()

/obj/item/reagent_container/glass/beaker/update_icon()
	overlays.Cut()

	if(reagents && reagents.total_volume)
		var/image/filling = image('icons/obj/items/reagentfillings.dmi', src, "[icon_state]-20")

		var/percent = floor((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0)
				filling.icon_state = null
			if(1 to 20)
				filling.icon_state = "[icon_state]-20"
			if(21 to 40)
				filling.icon_state = "[icon_state]-40"
			if(41 to 60)
				filling.icon_state = "[icon_state]-60"
			if(61 to 80)
				filling.icon_state = "[icon_state]-80"
			if(81 to INFINITY)
				filling.icon_state = "[icon_state]-100"

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		overlays += filling

	if(!is_open_container())
		var/image/lid = image(icon, src, "lid_[initial(icon_state)]")
		overlays += lid

/obj/item/reagent_container/glass/minitank
	name = "\improper MS-11 Smart Refill Tank"
	desc = "一个坚固的小型储罐，能够为以前需要纳米医疗系统才能补充的自动注射器重新装填。利用微型芯片的奇迹，它能自动将正确的化学品分类注入大多数单试剂自动注射器。但它无法部分填充它们。顶部有一个阀门，用于将试剂转移到另一个容器或完全清空。"
	icon = 'icons/obj/items/tank.dmi'
	icon_state = "mini_reagent_tank"
	matter = list("metal" = 500)
	attack_speed = 4
	volume = 180
	w_class = SIZE_MEDIUM
	splashable = FALSE
	can_be_placed_into = list(
		/obj/structure/machinery/chem_master/,
		/obj/structure/machinery/chem_dispenser/,
		/obj/structure/machinery/reagentgrinder,
		/obj/structure/surface/table,
		/obj/structure/closet,
		/obj/structure/sink,
		/obj/item/storage,
		/obj/item/clothing,
		/obj/structure/machinery/bot/medbot,
		/obj/structure/machinery/computer/pandemic,
		/obj/item/storage/secure/safe,
		/obj/structure/machinery/iv_drip,
		/obj/structure/machinery/disposal,
		/obj/structure/machinery/medical_pod/sleeper,
		/obj/structure/machinery/smartfridge/,
		/obj/structure/machinery/biogenerator,
		/obj/structure/machinery/reagent_analyzer,
		/obj/structure/machinery/centrifuge,
		/obj/structure/machinery/autodispenser,
		/obj/structure/machinery/constructable_frame,
	)

/obj/item/reagent_container/glass/minitank/on_reagent_change()
	update_icon()


/obj/item/reagent_container/glass/minitank/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/reagent_container/hypospray/autoinjector))
		var/obj/item/reagent_container/hypospray/autoinjector/A = W
		if(A.mixed_chem)
			to_chat(user, SPAN_WARNING("该自动注射器无法装入[src]的阀门。可能不兼容。"))
			return
		if(reagents.has_reagent(A.chemname, A.volume))
			reagents.trans_id_to(A, A.chemname, A.volume)
			A.uses_left = 3
			A.update_icon()
			playsound(src.loc, 'sound/effects/refill.ogg', 25, 1, 3)
		else
			to_chat(user, SPAN_WARNING("[src]上的一个小LED灯闪烁。储罐无法为[A]重新装填——要么不兼容，要么没有化学品可供填充！"))
			. = ..()
			return
		to_chat(user, SPAN_INFO("你成功用[src]为[A]重新装填！"))

/obj/item/reagent_container/glass/minitank/verb/flush_tank()
	set category = "Object"
	set name = "Flush Tank"
	set src in usr

	if(usr.is_mob_incapacitated())
		return
	if(src.reagents.total_volume == 0)
		to_chat(usr, SPAN_WARNING("已经空了！"))
		return
	playsound(src.loc, 'sound/effects/slosh.ogg', 25, 1, 3)
	to_chat(usr, SPAN_WARNING("你操作冲洗阀，成功冲走了[src]的内容物！"))
	reagents.clear_reagents()
	update_icon() // just to be sure
	return

/obj/item/reagent_container/glass/minitank/update_icon()
	overlays.Cut()
	if(reagents && reagents.total_volume)
		var/image/filling = image('icons/obj/items/reagentfillings.dmi', src, "[icon_state]10")
		var/percent = floor((reagents.total_volume / volume) * 100)
		var/round_percent = 0
		if(percent > 24)
			round_percent = round(percent, 25)
		else
			round_percent = 10
		filling.icon_state = "[icon_state][round_percent]"
		filling.color = mix_color_from_reagents(reagents.reagent_list)
		overlays += filling

/obj/item/reagent_container/glass/beaker/large
	name = "大烧杯"
	desc = "一个大烧杯。最多可容纳120单位。"
	icon_state = "beakerlarge"
	item_state = "beakerlarge"
	matter = list("glass" = 5000)
	volume = 120
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,40,60,80,120)

/obj/item/reagent_container/glass/beaker/catalyst/silver
	name = "大银烧杯"
	desc = "一个大银烧杯。最多可容纳240单位。烧杯本身可作为银催化剂。"
	icon_state = "beakersilver"
	item_state = "beakersilver"
	volume = 240
	matter = list("silver" = 5000)
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,30,40,60,80,120,240)
	pixel_y = 5

/obj/item/reagent_container/glass/beaker/catalyst/update_icon()
	overlays.Cut()

	if(reagents && reagents.total_volume)
		var/image/filling = image('icons/obj/items/reagentfillings.dmi', src, "beakerlarge-10") //If we make another type of large beaker that acts as a catalyst for reagents, it will always use the beakerlarge fill icon.

		var/percent = floor((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0)
				filling.icon_state = null
			if(1 to 20)
				filling.icon_state = "beakerlarge-20"
			if(21 to 40)
				filling.icon_state = "beakerlarge-40"
			if(41 to 60)
				filling.icon_state = "beakerlarge-60"
			if(61 to 80)
				filling.icon_state = "beakerlarge-80"
			if(81 to INFINITY)
				filling.icon_state = "beakerlarge-100"
		filling.color = mix_color_from_reagents(reagents.reagent_list)
		overlays += filling

/obj/item/reagent_container/glass/beaker/noreact
	name = "低温静滞烧杯"
	desc = "一个低温静滞烧杯，可储存化学品而不发生反应。最多可容纳60单位。"
	icon_state = "beakernoreact"
	matter = list("glass" = 500)
	volume = 60
	amount_per_transfer_from_this = 10

	flags_atom = FPRINT|OPENCONTAINER|NOREACT

/obj/item/reagent_container/glass/beaker/bluespace
	name = "高容量烧杯"
	desc = "一个容量增大的烧杯，由蓝色调有机玻璃制成，以承受更大压力。最多可容纳500单位。"
	icon_state = "beakerbluespace"
	item_state = "beakerbluespace"
	matter = list("glass" = 30000)
	volume = 500
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,30,40,60,120,240,500)

/obj/item/reagent_container/glass/beaker/vial
	name = "vial"
	desc = "一个小玻璃瓶。最多可容纳30单位。"
	icon_state = "vial"
	item_state = "vial"
	volume = 30
	amount_per_transfer_from_this = 10
	matter = list()
	possible_transfer_amounts = list(5,10,15,20,25,30)
	flags_atom = FPRINT|OPENCONTAINER
	ground_offset_x = 9
	ground_offset_y = 8


/obj/item/reagent_container/glass/beaker/vial/random
	var/tier

/obj/item/reagent_container/glass/beaker/vial/random/Initialize()
	. = ..()
	var/random_chem
	if(tier)
		random_chem = pick(GLOB.chemical_gen_classes_list[tier])
	else
		random_chem = pick(GLOB.chemical_gen_classes_list["C5"])
	if(prob(4))
		random_chem = "xenogenic"
	if(random_chem)
		reagents.add_reagent(random_chem, 30)
		update_icon()

/obj/item/reagent_container/glass/beaker/vial/epinephrine
	name = "肾上腺素小瓶"

/obj/item/reagent_container/glass/beaker/vial/epinephrine/Initialize()
	. = ..()
	reagents.add_reagent("adrenaline", 30)
	update_icon()

/obj/item/reagent_container/glass/beaker/vial/tricordrazine
	name = "三合剂小瓶"

/obj/item/reagent_container/glass/beaker/vial/tricordrazine/Initialize()
	. = ..()
	reagents.add_reagent("tricordrazine", 30)
	update_icon()

/obj/item/reagent_container/glass/beaker/vial/sedative
	name = "水合氯醛小瓶"

/obj/item/reagent_container/glass/beaker/vial/sedative/Initialize()
	. = ..()
	reagents.add_reagent("chloralhydrate", 30)
	update_icon()
/obj/item/reagent_container/glass/beaker/cryoxadone
	name = "低温克萨酮烧杯"

/obj/item/reagent_container/glass/beaker/cryoxadone/Initialize()
	. = ..()
	reagents.add_reagent("cryoxadone", 30)
	update_icon()

/obj/item/reagent_container/glass/beaker/phoron
	name = "福罗宁烧杯"

/obj/item/reagent_container/glass/beaker/phoron/Initialize()
	. = ..()
	reagents.add_reagent("phoron", 30)
	update_icon()

/obj/item/reagent_container/glass/beaker/cryopredmix
	name = "低温混合剂烧杯"

/obj/item/reagent_container/glass/beaker/cryopredmix/Initialize()
	. = ..()
	reagents.add_reagent("cryoxadone", 30)
	reagents.add_reagent("clonexadone", 30)
	update_icon()

/obj/item/reagent_container/glass/beaker/sulphuric
	name = "硫酸烧杯"

/obj/item/reagent_container/glass/beaker/sulphuric/Initialize()
	. = ..()
	reagents.add_reagent("sulphuric acid", 60)
	update_icon()

/obj/item/reagent_container/glass/beaker/ethanol
	name = "乙醇烧杯"

/obj/item/reagent_container/glass/beaker/ethanol/Initialize()
	. = ..()
	reagents.add_reagent("ethanol", 60)
	update_icon()

/obj/item/reagent_container/glass/beaker/large/phosphorus
	name = "磷烧杯"

/obj/item/reagent_container/glass/beaker/large/phosphorus/Initialize()
	. = ..()
	reagents.add_reagent("phosphorus", 120)
	update_icon()

/obj/item/reagent_container/glass/beaker/large/lithium
	name = "锂烧杯"

/obj/item/reagent_container/glass/beaker/large/lithium/Initialize()
	. = ..()
	reagents.add_reagent("lithium", 120)
	update_icon()

/obj/item/reagent_container/glass/beaker/large/sodiumchloride
	name = "氯化钠烧杯"

/obj/item/reagent_container/glass/beaker/large/sodiumchloride/Initialize()
	. = ..()
	reagents.add_reagent("sodiumchloride", 120)
	update_icon()

/obj/item/reagent_container/glass/beaker/large/potassiumchloride
	name = "氯化钾烧杯"

/obj/item/reagent_container/glass/beaker/large/potassiumchloride/Initialize()
	. = ..()
	reagents.add_reagent("potassium_chloride", 120)
	update_icon()

/obj/item/reagent_container/glass/canister
	name = "氢气罐"
	desc = "一个装有加压氢气的罐子。可用于补充储罐。"
	icon = 'icons/obj/items/tank.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/tanks_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/tanks_righthand.dmi',
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/misc.dmi'
	)
	icon_state = "canister_hydrogen"
	item_state = "canister_hydrogen"
	amount_per_transfer_from_this = 100
	possible_transfer_amounts = list(50,100,200,300,400)
	volume = 400
	splashable = FALSE // you can't spill a canister
	var/reagent = "hydrogen"

/obj/item/reagent_container/glass/canister/Initialize()
	. = ..()
	reagents.add_reagent(reagent, 400)

/obj/item/reagent_container/glass/canister/afterattack(obj/target, mob/user , flag)
	if(!istype(target, /obj/structure/reagent_dispensers))
		return
	. = ..()

/obj/item/reagent_container/glass/canister/ammonia
	name = "氨气罐"
	desc = "一个装有加压氨气的罐体。可用于补充储罐。"
	icon_state = "canister_ammonia"
	item_state = "canister_ammonia"
	reagent = "ammonia"

/obj/item/reagent_container/glass/canister/methane
	name = "甲烷罐"
	desc = "一个装有加压甲烷的罐体。可用于补充储罐。"
	icon_state = "canister_methane"
	item_state = "canister_methane"
	reagent = "methane"

/obj/item/reagent_container/glass/canister/pacid
	name = "聚三硝酸罐"
	desc = "一个装有加压聚三硝酸的罐体。可用于补充储罐。"
	icon_state = "canister_pacid"
	item_state = "canister_pacid"
	reagent = "pacid"

/obj/item/reagent_container/glass/canister/oxygen
	name = "氧气罐"
	desc = "一个装有加压氧气的罐体。可用于补充储罐。"
	icon_state = "canister_oxygen"
	item_state = "canister_oxygen"
	reagent = "oxygen"

/obj/item/reagent_container/glass/pressurized_canister // See the Pressurized Reagent Canister Pouch
	name = "加压罐体"
	desc = "一个加压容器。是加压试剂罐袋的内部组件。仅与其罐袋、机械设备或储罐兼容。"
	icon = 'icons/obj/items/tank.dmi'
	icon_state = "pressurized_reagent_container"
	item_state = "anesthetic"
	amount_per_transfer_from_this = 0
	possible_transfer_amounts = null
	volume = 480
	splashable = FALSE
	w_class = SIZE_MASSIVE
	flags_atom = CAN_BE_DISPENSED_INTO
	matter = list("glass" = 2000)

/obj/item/reagent_container/glass/pressurized_canister/Initialize()
	. = ..()
	update_icon()

/obj/item/reagent_container/glass/pressurized_canister/on_reagent_change()
	update_icon()

/obj/item/reagent_container/glass/pressurized_canister/afterattack(obj/target, mob/user, flag)
	if(!istype(target, /obj/structure/reagent_dispensers))
		return
	. = ..()

/obj/item/reagent_container/glass/pressurized_canister/update_icon() 	 //Canister now has a clear indicator on what's inside and how much.
	overlays.Cut()

	if(reagents && reagents.total_volume)
		var/image/filling
		var/percent = floor((reagents.total_volume / volume) * 100)
		switch(percent)
			if(1 to 25)
				filling = image('icons/obj/items/reagentfillings.dmi', src, "[icon_state]-25")
			if(26 to 50)
				filling = image('icons/obj/items/reagentfillings.dmi', src, "[icon_state]-50")
			if(51 to 75)
				filling = image('icons/obj/items/reagentfillings.dmi', src, "[icon_state]-75")
			if(76 to INFINITY)
				filling = image('icons/obj/items/reagentfillings.dmi', src, "[icon_state]-100")
			else
				return ..()

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		overlays += filling
	..()


/obj/item/reagent_container/glass/bucket
	desc = "这是一个水桶。容量120单位。"
	name = "bucket"
	icon = 'icons/obj/janitor.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/janitor_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/janitor_righthand.dmi',
	)
	icon_state = "bucket"
	item_state = "bucket"
	matter = list("metal" = 2000)
	w_class = SIZE_MEDIUM
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = list(5,10,15,20,25,30,40,60,80,120)
	volume = 120
	flags_atom = FPRINT|OPENCONTAINER

/obj/item/reagent_container/glass/bucket/attackby(obj/item/something, mob/user)
	if(isprox(something))
		to_chat(user, "你将\the [something]加入[src]。")
		qdel(something)
		user.put_in_hands(new /obj/item/frame/bucket_sensor)
		user.drop_inv_item_on_ground(src)
		qdel(src)
	else if(istype(something, /obj/item/tool/mop))
		var/obj/item/tool/mop/mop = something
		if(reagents.total_volume < 1)
			to_chat(user, SPAN_WARNING("[src]没水了！"))
		else
			reagents.trans_to(mop, mop.max_reagent_volume)
			mop.update_icon()
			to_chat(user, SPAN_NOTICE("你将\the [mop]在[src]中浸湿。"))
			playsound(loc, 'sound/effects/slosh.ogg', 25, 1)
		return
	else
		..()

/obj/item/reagent_container/glass/bucket/on_reagent_change()
	update_icon()

/obj/item/reagent_container/glass/bucket/pickup(mob/user)
	. = ..()
	update_icon()

/obj/item/reagent_container/glass/bucket/dropped(mob/user)
	..()
	update_icon()

/obj/item/reagent_container/glass/bucket/attack_hand()
	..()
	update_icon()

/obj/item/reagent_container/glass/bucket/update_icon()
	overlays.Cut()

	if(reagents && reagents.total_volume)
		var/image/filling = image('icons/obj/items/reagentfillings.dmi', src, "[icon_state]-00-65")

		var/percent = floor((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0 to 33)
				filling.icon_state = "[icon_state]-00-33"
			if(34 to 65)
				filling.icon_state = "[icon_state]-34-65"
			if(66 to INFINITY)
				filling.icon_state = "[icon_state]-66-100"

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		overlays += filling

	if(!is_open_container())
		var/image/lid = image(icon, src, "lid_[initial(icon_state)]")
		overlays += lid

/obj/item/reagent_container/glass/bucket/mopbucket
	name = "拖把桶"
	desc = "一个更大的水桶，通常与拖把配合使用。容量240单位。"
	icon_state = "mopbucket"
	item_state = "mopbucket"
	matter = list("metal" = 4000)
	w_class = SIZE_LARGE
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = list(5,10,15,20,30,40,60,80,120,240)
	volume = 240
	flags_atom = FPRINT|OPENCONTAINER

/obj/item/reagent_container/glass/bucket/janibucket
	name = "清洁桶"
	desc = "这是一个可放入清洁车的大型水桶。容量300单位。"
	icon_state = "janibucket"
	item_state = "janibucket"
	matter = list("metal" = 8000)
	volume = 300
	possible_transfer_amounts = list(5,10,15,20,30,40,60,120,240,300)
	w_class = SIZE_LARGE

/obj/item/reagent_container/glass/rag
	name = "湿抹布"
	desc = "你觉得是用来清理污渍的。"
	w_class = SIZE_TINY
	icon = 'icons/obj/janitor.dmi'
	icon_state = "rag"
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(5)
	volume = 5
	can_be_placed_into = null
	flags_atom = FPRINT|OPENCONTAINER
	flags_item = NOBLUDGEON
	has_lid = FALSE

/obj/item/reagent_container/glass/rag/attack(atom/target, mob/user)
	if(ismob(target) && target.reagents && reagents.total_volume)
		user.visible_message(SPAN_DANGER("[target]被[user]用[src]捂住了！"), SPAN_DANGER("You smother [target] with [src]!"), "You hear some struggling and muffled cries of surprise!")
		src.reagents.reaction(target, TOUCH)
		spawn(5) src.reagents.clear_reagents()
		return
	else
		..()

/obj/item/reagent_container/glass/rag/afterattack(atom/movable/AM, mob/user, proximity)
	if(!proximity)
		return
	if(istype(AM) && (src in user))
		user.visible_message("[user]开始用[src]擦拭[AM]！")
		if(do_after(user,30, INTERRUPT_ALL, BUSY_ICON_GENERIC))
			user.visible_message("[user]完成了对[AM]的擦拭！")
			AM.clean_blood()
