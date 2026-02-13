///////////////////////////////////////////////Condiments
//Notes by Darem: The condiments food-subtype is for stuff you don't actually eat but you use to modify existing food. They all
// leave empty containers when used up and can be filled/re-filled with other items. Formatting for first section is identical
// to mixed-drinks code. If you want an object that starts pre-loaded, you need to make it in addition to the other code.

//Food items that aren't eaten normally and leave an empty container behind.
/obj/item/reagent_container/food/condiment
	name = "调味品容器"
	desc = "只是个普通的调味品容器。"
	icon = 'icons/obj/items/food/condiments.dmi'
	icon_state = "emptycondiment"
	flags_atom = FPRINT|OPENCONTAINER
	possible_transfer_amounts = list(1,5,10)
	center_of_mass = "x=16;y=6"
	volume = 50
	var/static_container_icon = FALSE //do I change my icon when a different reagent is inside me? Right now, yes.

/obj/item/reagent_container/food/condiment/attack(mob/M, mob/user)
	if(!reagents?.total_volume)
		to_chat(user, SPAN_DANGER("这[src.name]是空的！"))
		return FALSE

	if(M == user)
		to_chat(M, SPAN_NOTICE("你吞下了一些[src]的内容物。"))

	else if(istype(M, /mob/living/carbon))
		user.affected_message(M,
			SPAN_HELPFUL("You <b>start feeding</b> [user == M ? "yourself" : "[M]"] <b>[src]</b>."),
			SPAN_HELPFUL("[user] <b>starts feeding</b> you <b>[src]</b>."),
			SPAN_NOTICE("[user] starts feeding [user == M ? "themselves" : "[M]"] [src]."))

		if(!do_after(user, 30, INTERRUPT_ALL, BUSY_ICON_FRIENDLY, M))
			return FALSE
		user.affected_message(M,
			SPAN_HELPFUL("You <b>fed</b> [user == M ? "yourself" : "[M]"] <b>[src]</b>."),
			SPAN_HELPFUL("[user] <b>fed</b> you <b>[src]</b>."),
			SPAN_NOTICE("[user] fed [user == M ? "themselves" : "[M]"] [src]."))

		var/rgt_list_text = get_reagent_list_text()

		M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been fed [src.name] by [user.name] ([user.ckey]) Reagents: [rgt_list_text]</font>")
		user.attack_log += text("\[[time_stamp()]\] <font color='red'>Fed [src.name] by [M.name] ([M.ckey]) Reagents: [rgt_list_text]</font>")
		msg_admin_attack("[user.name] ([user.ckey]) fed [M.name] ([M.ckey]) with [src.name] (REAGENTS: [rgt_list_text]) (INTENT: [uppertext(intent_text(user.a_intent))]) in [get_area(src)] ([src.loc.x],[src.loc.y],[src.loc.z]).", src.loc.x, src.loc.y, src.loc.z)
	else
		return FALSE

	if(reagents.total_volume)
		reagents.set_source_mob(user)
		reagents.trans_to_ingest(M, 10)
	playsound(M.loc,'sound/items/drink.ogg', 15, 1)
	return TRUE

/obj/item/reagent_container/food/condiment/attackby(obj/item/W, mob/living/user, list/mods)
	return

/obj/item/reagent_container/food/condiment/afterattack(obj/target, mob/user , flag)
	if(istype(target, /obj/structure/reagent_dispensers)) //A dispenser. Transfer FROM it TO us.

		if(!target.reagents.total_volume)
			to_chat(user, SPAN_DANGER("[target]是空的。"))
			return

		if(reagents.total_volume >= reagents.maximum_volume)
			to_chat(user, SPAN_DANGER("[src]已满。"))
			return

		var/trans = target.reagents.trans_to(src, target:amount_per_transfer_from_this)

		if(!trans)
			to_chat(user, SPAN_DANGER("你未能用[target]中的试剂装满[src]。"))
			return

		to_chat(user, SPAN_NOTICE("你用[target]中的内容物向[src]注入了[trans]单位。"))

	//Something like a glass or a food item. Player probably wants to transfer TO it.
	else if(target.is_open_container() || istype(target, /obj/item/reagent_container/food/snacks))
		if(!reagents.total_volume)
			to_chat(user, SPAN_DANGER("[src]是空的。"))
			return
		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, SPAN_DANGER("你无法再向[target]添加任何东西了。"))
			return
		var/trans = src.reagents.trans_to(target, amount_per_transfer_from_this)
		to_chat(user, SPAN_NOTICE("你将[trans]单位的调味品转移到[target]。"))

/obj/item/reagent_container/food/condiment/on_reagent_change()
	if(static_container_icon) //Noooo, don't turn me into a marketable enzyme/condiment bottle, I have my own icon and description!
		return
	if(length(reagents.reagent_list) > 0)
		switch(reagents.get_master_reagent_id())
			if("ketchup")
				name = "番茄酱"
				desc = "你感觉自己已经更美国化了。"
				icon_state = "ketchup"
				center_of_mass = "x=16;y=6"
			if("enzyme")
				name = "通用酶"
				desc = "用于烹饪各种菜肴。"
				icon_state = "enzyme"
				center_of_mass = "x=16;y=6"
			if("soysauce")
				name = "酱油"
				desc = "一种咸味的酱油基调味料。"
				icon_state = "soysauce"
				center_of_mass = "x=16;y=6"
			if("frostoil")
				name = "冷酱"
				desc = "经过时让舌头麻木。"
				icon_state = "coldsauce"
				center_of_mass = "x=16;y=6"
			if("sodiumchloride")
				name = "盐瓶"
				desc = "盐。大概来自太空海洋。"
				icon_state = "saltshaker"
				center_of_mass = "x=16;y=10"
			if("blackpepper")
				name = "胡椒研磨器"
				desc = "常用于给食物调味或让人打喷嚏。"
				icon_state = "peppermill"
				center_of_mass = "x=16;y=10"
			if("cornoil")
				name = "玉米油"
				desc = "一种用于烹饪的美味油。由玉米制成。"
				icon_state = "cornoil"
				center_of_mass = "x=16;y=6"
			if("sugar")
				name = "糖"
				desc = "美味的太空糖！"
				center_of_mass = "x=16;y=6"
			else
				name = "混合调味瓶"
				if (length(reagents.reagent_list)==1)
					desc = "看起来像是[reagents.get_master_reagent_name()]，但你不确定。"
				else
					desc = "多种调味料的混合物。[reagents.get_master_reagent_name()]是其中之一。"
				icon_state = "mixedcondiments"
				center_of_mass = "x=16;y=6"
	else
		icon_state = "emptycondiment"
		name = "调味瓶"
		desc = "一个空的调味瓶。"
		center_of_mass = "x=16;y=6"
		return

/obj/item/reagent_container/food/condiment/enzyme
	name = "通用酶"
	desc = "用于烹饪各种菜肴。"
	icon_state = "enzyme"

/obj/item/reagent_container/food/condiment/enzyme/Initialize()
	. = ..()
	reagents.add_reagent("enzyme", 50)

/obj/item/reagent_container/food/condiment/sugar

/obj/item/reagent_container/food/condiment/sugar/Initialize()
	. = ..()
	reagents.add_reagent("sugar", 50)

/obj/item/reagent_container/food/condiment/chocolate_syrup
	name = "\improper Chocolate Syrup bottle"
	desc = "一瓶维兰德-汤谷品牌的巧克力糖浆，用于为太空点心增添巧克力风味，或者像小孩一样直接从喷嘴吸吮。"
	icon_state = "chocolate_syrup"
	static_container_icon = TRUE //Yes, I do have my own sprite.
	possible_transfer_amounts = list(1,5,10,15,20,60) //the thought of marines having fisticuffs because somebody drank all the chocolate syrup is beyond hilarious.
	amount_per_transfer_from_this = 5
	volume = 60

/obj/item/reagent_container/food/condiment/chocolate_syrup/Initialize()
	. = ..()
	reagents.add_reagent("chocolatesyrup", 60)
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/condiment/saltshaker //Separate from above since it's a small shaker rather then
	name = "盐瓶" // a large one.
	desc = "盐。大概来自太空海洋。"
	icon_state = "saltshakersmall"
	static_container_icon = TRUE
	possible_transfer_amounts = list(1,20) //for clown turning the lid off
	amount_per_transfer_from_this = 1
	volume = 20

/obj/item/reagent_container/food/condiment/saltshaker/Initialize()
	. = ..()
	reagents.add_reagent("sodiumchloride", 20)

/obj/item/reagent_container/food/condiment/peppermill
	name = "胡椒研磨器"
	desc = "常用于给食物调味或让人打喷嚏。"
	icon_state = "peppermillsmall"
	static_container_icon = TRUE
	possible_transfer_amounts = list(1,20) //for clown turning the lid off
	amount_per_transfer_from_this = 1
	volume = 20

/obj/item/reagent_container/food/condiment/peppermill/Initialize()
	. = ..()
	reagents.add_reagent("blackpepper", 20)

/obj/item/reagent_container/food/condiment/hotsauce
	icon = 'icons/obj/items/food/condiments.dmi'
	name = "辣酱父对象"
	static_container_icon = TRUE
	possible_transfer_amounts = list(1,5,60) //60 allows marines to chug the bottle in one go.
	volume = 60

/obj/item/reagent_container/food/condiment/hotsauce/Initialize()
	. = ..()
	reagents.add_reagent("hotsauce", 60)

/obj/item/reagent_container/food/condiment/hotsauce/cholula
	name = "\improper Cholula bottle"
	desc = "一瓶维兰德-汤谷品牌的Cholula辣酱。"
	icon_state = "hotsauce_cholula"
	item_state = "hotsauce_cholula"

/obj/item/reagent_container/food/condiment/hotsauce/cholula/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/condiment/hotsauce/franks
	name = "\improper Frank's Red Hot bottle"
	desc = "一瓶维兰德-汤谷品牌的Frank's Red Hot辣酱。"
	desc_lore = "Supposedly designed as a middle-ground flavor between ketchup and cayenne, this brand of spicy goodness achieved critical acclaim throughout UA space within both colonies and vessels alike. The sudden and widespread adoption was curiously timed with the near-simultaneous shelving of the original Frank's 'ULTRA' hot sauce."
	icon_state = "hotsauce_franks"
	item_state = "hotsauce_franks"

/obj/item/reagent_container/food/condiment/hotsauce/franks/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/condiment/hotsauce/sriracha
	name = "\improper Sriracha bottle"
	desc = "一瓶维兰德-汤谷品牌的Sriracha辣酱。"
	icon_state = "hotsauce_sriracha"
	item_state = "hotsauce_sriracha"

/obj/item/reagent_container/food/condiment/hotsauce/sriracha/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/condiment/hotsauce/tabasco
	name = "\improper Tabasco bottle"
	desc = "一瓶维兰德-汤谷品牌的Tabasco辣酱。"
	icon_state = "hotsauce_tabasco"
	item_state = "hotsauce_tabasco"

/obj/item/reagent_container/food/condiment/hotsauce/tabasco/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/condiment/hotsauce/franks/macho
	name = "\improper Frank's ULTRA Hot bottle"
	desc = "一瓶维兰德-汤谷品牌的Frank's ULTRA超辣酱，在报告称饮用者发生'更像是点燃而非消化'的情况后已从市场下架。"
	icon_state = "hotsauce_franks"
	item_state = "hotsauce_franks"

/obj/item/reagent_container/food/condiment/hotsauce/franks/macho/Initialize()
	. = ..()
	reagents.add_reagent("machosauce", 60)

/obj/item/reagent_container/food/condiment/coldsauce
	name = "科尔冷酱瓶"
	desc = "一瓶在湿婆雪球当地生产的冷酱。你或许不该直接喝这个。"
	icon_state = "coldsauce_cole"
	static_container_icon = TRUE

/obj/item/reagent_container/food/condiment/coldsauce/Initialize()
	. = ..()
	reagents.add_reagent("frostoil", 60)
