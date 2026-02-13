////////////////////////////////////////////////////////////////////////////////
/// Drinks.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_container/food/drinks
	name = "drink"
	desc = "美味。"
	icon = 'icons/obj/items/food/drinks.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_righthand.dmi',
	)
	icon_state = null
	flags_atom = FPRINT|OPENCONTAINER
	var/gulp_size = 5 //This is now officially broken ... need to think of a nice way to fix it.
	possible_transfer_amounts = list(5,10,25)
	volume = 50

/obj/item/reagent_container/food/drinks/on_reagent_change()
	if(gulp_size < 5)
		gulp_size = 5
	else
		gulp_size = max(floor(reagents.total_volume / 5), 5)

/obj/item/reagent_container/food/drinks/attack(mob/M, mob/user)
	var/datum/reagents/R = src.reagents

	if(!R.total_volume || !R)
		to_chat(user, SPAN_DANGER("这[src.name]是空的！"))
		return FALSE

	if(HAS_TRAIT(M, TRAIT_CANNOT_EAT))
		to_chat(user, SPAN_DANGER("[user == M ? "You are" : "[M] is"] unable to drink!"))
		return FALSE

	if(M == user)
		to_chat(M, SPAN_NOTICE("你吞下了一大口\the [src]。"))
		if(reagents.total_volume)
			reagents.set_source_mob(user)
			reagents.trans_to_ingest(M, gulp_size)

		playsound(M.loc,'sound/items/drink.ogg', 15, 1)
		return TRUE
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
		user.attack_log += text("\[[time_stamp()]\] <font color='red'>Fed [M.name] by [M.name] ([M.ckey]) Reagents: [rgt_list_text]</font>")
		msg_admin_attack("[user.name] ([user.ckey]) fed [M.name] ([M.ckey]) with [src.name] (REAGENTS: [rgt_list_text]) (INTENT: [uppertext(intent_text(user.a_intent))]) in [get_area(src)] ([user.loc.x],[user.loc.y],[user.loc.z]).", user.loc.x, user.loc.y, user.loc.z)

		if(reagents.total_volume)
			reagents.set_source_mob(user)
			reagents.trans_to_ingest(M, gulp_size)

		playsound(M.loc,'sound/items/drink.ogg', 15, 1)
		return TRUE

	return FALSE


/obj/item/reagent_container/food/drinks/afterattack(obj/target, mob/user, proximity)
	if(!proximity)
		return

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

	else if(target.is_open_container()) //Something like a glass. Player probably wants to transfer TO it.
		if(!reagents.total_volume)
			to_chat(user, SPAN_DANGER("[src]是空的。"))
			return

		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, SPAN_DANGER("[target]已满。"))
			return

		var/trans = src.reagents.trans_to(target, amount_per_transfer_from_this)
		to_chat(user, SPAN_NOTICE("你将[trans]单位溶液转移至[target]。"))

	return ..()

/obj/item/reagent_container/food/drinks/get_examine_text(mob/user)
	. = ..()
	if (get_dist(user, src) > 1 && user != loc)
		return
	if(!reagents || reagents.total_volume==0)
		. += SPAN_NOTICE("\The [src] is empty!")
	else if (reagents.total_volume<=src.volume/4)
		. += SPAN_NOTICE("\The [src] is almost empty!")
	else if (reagents.total_volume<=src.volume*0.66)
		. += SPAN_NOTICE("\The [src] is half full!")
	else if (reagents.total_volume<=src.volume*0.90)
		. += SPAN_NOTICE("\The [src] is almost full!")
	else
		. += SPAN_NOTICE("\The [src] is full!")


////////////////////////////////////////////////////////////////////////////////
/// Drinks. END
////////////////////////////////////////////////////////////////////////////////

/obj/item/reagent_container/food/drinks/golden_cup
	desc = "一个金杯。"
	name = "金杯"
	icon_state = "golden_cup"
	item_state = "golden_cup" //nope :(? nope my ass
	w_class = SIZE_LARGE
	force = 14
	throwforce = 10
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = null
	volume = 150
	flags_atom = FPRINT|CONDUCT|OPENCONTAINER
	black_market_value = 20

/obj/item/reagent_container/food/drinks/golden_cup/tournament_26_06_2011
	desc = "一个金杯。它将被授予6月26日锦标赛的获胜者，获胜者的名字将被刻在上面。"


///////////////////////////////////////////////Drinks
//Notes by Darem: Drinks are simply containers that start preloaded. Unlike condiments, the contents can be ingested directly
// rather then having to add it to something else first. They should only contain liquids. They have a default container size of 50.
// Formatting is the same as food.

/obj/item/reagent_container/food/drinks/milk
	name = "太空牛奶"
	desc = "这是牛奶。白色且营养丰富！"
	icon_state = "milk"
	item_state = "milk"
	center_of_mass = "x=16;y=9"

/obj/item/reagent_container/food/drinks/milk/Initialize()
	. = ..()
	reagents.add_reagent("milk", 50)

/* Flour is no longer a reagent
/obj/item/reagent_container/food/drinks/flour
	name = "面粉袋"
	desc = "一大袋面粉。非常适合烘焙！"
	icon = 'icons/obj/items/food.dmi'
	icon_state = "flour"
	item_state = "flour"

/obj/item/reagent_container/food/drinks/flour/Initialize()
		..()
		reagents.add_reagent("flour", 30)
		src.pixel_x = rand(-10.0, 10)
		src.pixel_y = rand(-10.0, 10)
*/

/obj/item/reagent_container/food/drinks/soymilk
	name = "豆奶"
	desc = "这是豆奶。白色且营养丰富的好东西！"
	icon_state = "soymilk"
	item_state = "soymilk"
	center_of_mass = "x=16;y=9"

/obj/item/reagent_container/food/drinks/soymilk/Initialize()
	. = ..()
	reagents.add_reagent("soymilk", 50)

/obj/item/reagent_container/food/drinks/coffee
	name = "\improper Coffee"
	desc = "小心，您即将享用的饮料极其滚烫。"
	icon_state = "coffee"
	item_state = "coffee"
	center_of_mass = "x=15;y=10"

/obj/item/reagent_container/food/drinks/coffee/Initialize()
	. = ..()
	reagents.add_reagent("coffee", 20)

/obj/item/reagent_container/food/drinks/coffee/marine
	desc = "回收水、实验室培育的咖啡植株（经过基因设计以最低成本和最高产量生产）以及再回收的咖啡渣混合在一起，创造了这种侮辱性的廉价USCM烹饪‘奇迹’。你只是庆幸部队能免费配发水。"

/obj/item/reagent_container/food/drinks/tea
	name = "\improper Duke Purple Tea"
	desc = "对紫公爵的侮辱就是对太空女王的侮辱！任何一位真正的绅士都会在你玷污这杯茶时与你决斗。"
	icon_state = "tea"
	item_state = "tea"
	center_of_mass = "x=16;y=14"

/obj/item/reagent_container/food/drinks/tea/Initialize()
	. = ..()
	reagents.add_reagent("tea", 30)

/obj/item/reagent_container/food/drinks/ice
	name = "冰杯"
	desc = "小心，冰冷的冰块，请勿咀嚼。"
	icon_state = "coffee_nolid"
	item_state = "coffee"
	center_of_mass = "x=15;y=10"

/obj/item/reagent_container/food/drinks/ice/Initialize()
	. = ..()
	reagents.add_reagent("ice", 30)

/obj/item/reagent_container/food/drinks/h_chocolate
	name = "\improper Dutch hot coco"
	desc = "太空南美制造。"
	icon_state = "hot_coco"
	item_state = "hot_coco"
	center_of_mass = "x=15;y=13"

/obj/item/reagent_container/food/drinks/h_chocolate/Initialize()
	. = ..()
	reagents.add_reagent("hot_coco", 30)

/obj/item/reagent_container/food/drinks/dry_ramen
	name = "杯面"
	desc = "只需加入10毫升水，即可自热！一种让你想起学生时代的味道。"
	icon_state = "ramen"
	center_of_mass = "x=16;y=11"

/obj/item/reagent_container/food/drinks/dry_ramen/Initialize()
	. = ..()
	reagents.add_reagent("dry_ramen", 30)


/obj/item/reagent_container/food/drinks/sillycup
	name = "纸杯"
	desc = "一个纸水杯。"
	icon_state = "water_cup_e"
	item_state = "water_cup_e"
	possible_transfer_amounts = null
	volume = 10
	center_of_mass = "x=16;y=12"

/obj/item/reagent_container/food/drinks/sillycup/Initialize()
	. = ..()

/obj/item/reagent_container/food/drinks/sillycup/on_reagent_change()
	if(reagents.total_volume)
		icon_state = "water_cup"
	else
		icon_state = "water_cup_e"

/obj/item/reagent_container/food/drinks/cup
	name = "塑料杯"
	desc = "一个普通的红色杯子。来玩啤酒乒乓吗？"
	icon = 'icons/obj/items/food/drinks.dmi'
	icon_state = "solocup"
	throwforce = 0
	w_class = SIZE_TINY
	matter = list("plastic" = 5)
	attack_verb = list("bludgeoned", "whacked", "slapped")

/obj/item/reagent_container/food/drinks/cup/attack_self(mob/user)
	. = ..()
	if(user.a_intent == INTENT_HARM)
		user.visible_message(SPAN_WARNING("[user] 捏碎了 \the [src]！"), SPAN_WARNING("You crush \the [src]!"))
		if(reagents.total_volume > 0)
			reagents.clear_reagents()
			playsound(src.loc, 'sound/effects/slosh.ogg', 25, 1, 3)
			to_chat(user, SPAN_WARNING("\the [src] 里的东西洒了出来！"))
		qdel(src)
		var/obj/item/trash/crushed_cup/C = new /obj/item/trash/crushed_cup(user)
		user.equip_to_slot_if_possible(C, (user.hand ? WEAR_L_HAND : WEAR_R_HAND))

/obj/item/trash/crushed_cup
	name = "被捏碎的杯子"
	desc = "一个可悲的被压扁毁坏的杯子。现在它只是无用的垃圾。真是浪费。"
	icon = 'icons/obj/items/food/drinks.dmi'
	icon_state = "crushed_solocup"
	throwforce = 0
	w_class = SIZE_TINY
	matter = list("plastic" = 5)
	attack_verb = list("bludgeoned", "whacked", "slapped")

//////////////////////////drinkingglass and shaker//
//Note by Darem: This code handles the mixing of drinks. New drinks go in three places: In Chemistry-Reagents.dm (for the drink
// itself), in Chemistry-Recipes.dm (for the reaction that changes the components into the drink), and here (for the drinking glass
// icon states.

/obj/item/reagent_container/food/drinks/shaker
	name = "shaker"
	desc = "一个用来调制饮品的金属摇酒器。"
	icon_state = "shaker"
	amount_per_transfer_from_this = 10
	volume = 100
	center_of_mass = "x=17;y=10"

/obj/item/reagent_container/food/drinks/flask
	name = "金属酒壶"
	desc = "一个具有不错液体容量的金属酒壶。"
	icon_state = "flask"
	item_state = "flask"
	item_state_slots = list(WEAR_AS_GARB = "flask")
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/misc.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_righthand.dmi',
	)
	volume = 60
	center_of_mass = "x=17;y=8"

/obj/item/reagent_container/food/drinks/flask/marine
	name = "\improper USCM flask"
	desc = "一个压印有USCM标志的金属酒壶，里面很可能装满了水、机油和医用酒精的混合物。"
	icon_state = "flask_uscm"
	item_state = "flask_uscm"
	volume = 60
	center_of_mass = "x=17;y=8"

/obj/item/reagent_container/food/drinks/flask/marine/Initialize()
	. = ..()
	reagents.add_reagent("water", 59)
	reagents.add_reagent("hooch", 1)

/obj/item/reagent_container/food/drinks/flask/weylandyutani
	name = "\improper Weyland-Yutani flask"
	desc = "一个压印有维兰德-汤谷标志性logo的金属酒壶，可能是某个公司马屁精下令配给USS军用舰船食堂贩卖机的。"
	icon_state = "flask_wy"
	item_state = "flask_wy"
	volume = 60
	center_of_mass = "x=17;y=8"

/obj/item/reagent_container/food/drinks/flask/weylandyutani/Initialize()
	. = ..()
	reagents.add_reagent("fruit_beer", 60)
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/drinks/flask/canteen
	name = "canteen"
	desc = "你从你可靠的USCM水壶里喝了一口……"
	icon_state = "canteen"
	item_state = "canteen"
	volume = 60
	center_of_mass = "x=17;y=8"

/obj/item/reagent_container/food/drinks/flask/canteen/Initialize()
	. = ..()
	reagents.add_reagent("water", 60)

/obj/item/reagent_container/food/drinks/flask/detflask
	name = "棕色皮革酒壶"
	desc = "一个侧面环绕着皮革带子的扁酒壶，常见于装满威士忌、由粗犷坚韧的侦探携带。"
	icon_state = "brownflask"
	item_state = "brownflask"
	volume = 60
	center_of_mass = "x=17;y=8"

/obj/item/reagent_container/food/drinks/flask/detflask/Initialize()
	. = ..()
	if(prob(15))
		reagents.add_reagent("whiskey", 30)

/obj/item/reagent_container/food/drinks/flask/barflask
	name = "黑色皮革扁酒壶"
	desc = "一个侧面环绕着光滑黑色皮革带的扁酒壶。专为那些懒得去酒吧喝酒的人准备。"
	icon_state = "blackflask"
	item_state = "blackflask"
	volume = 60
	center_of_mass = "x=17;y=7"

/obj/item/reagent_container/food/drinks/flask/vacuumflask
	name = "保温瓶"
	desc = "自1892年起，为您的饮品保持完美温度。"
	icon_state = "vacuumflask"
	volume = 60
	center_of_mass = "x=15;y=4"

/obj/item/reagent_container/food/drinks/coffeecup
	name = "咖啡杯"
	desc = "一个陶瓷咖啡杯。几乎肯定会掉落，并将滚烫的饮料洒在你崭新的衬衫上。哎哟。"
	icon_state = "coffeecup"
	item_state = "coffecup"
	volume = 30
	center_of_mass = "x=15;y=13"

/obj/item/reagent_container/food/drinks/coffeecup/uscm
	name = "\improper USCM coffee mug"
	desc = "一个红白蓝三色、绘有USCM徽章的咖啡杯。爱国且醒目，常被老兵当作新奇玩意儿。"
	icon_state = "uscmcup"
	item_state = "uscmcup"

/obj/item/reagent_container/food/drinks/coffeecup/wy
	name = "\improper Weyland-Yutani coffee mug"
	desc = "一个哑光灰色的咖啡杯，正面印有维兰德-汤谷的标志。要么是公司标配，要么是那些热爱公司的人买来当纪念品。很可能是前者。"
	icon_state = "wycup"
	item_state = "wycup"

/obj/item/reagent_container/food/drinks/coffeecup/wy/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

// Hybrisa

/obj/item/reagent_container/food/drinks/coffee/cuppa_joes
	name = "\improper Cuppa Joe's coffee"
	desc = "你拥有CuppaJoe的微笑吗？保持活力！冻干CuppaJoe咖啡。"
	icon_state = "coffeecuppajoe"
	center_of_mass = "x=15;y=10"
