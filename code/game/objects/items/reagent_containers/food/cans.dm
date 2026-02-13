/obj/item/reagent_container/food/drinks/cans
	var/open = FALSE
	//If it needs can opener to be opened
	var/needs_can_opener = FALSE
	var/crushed = FALSE
	//Can be crushed
	var/crushable = TRUE
	//Can open sound
	var/open_sound = 'sound/effects/canopen.ogg'
	//Can open message
	var/open_message = "You open the drink with an audible pop!"
	//Eating sound
	var/consume_sound = 'sound/items/drink.ogg'
	//What this object is, used during interactions
	var/object_fluff = "drink"
	//If can transfer reagents to food
	var/food_interactable = FALSE
	//If can has a dedicated crushed icon
	var/crushed_icon = null
	//If can has a dedicated open icon
	var/has_open_icon = FALSE
	//Should item be deleted on being empty
	var/delete_on_empty = FALSE
	gulp_size = 10
	icon = 'icons/obj/items/food/drinkcans.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/food_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/food_righthand.dmi'
	)

/obj/item/reagent_container/food/drinks/cans/attackby(obj/item/opening_tool as obj, mob/user as mob)
	var/opening_time
	var/opening_sound
	var/hiss = pick("Nice hiss!", "No hiss.", "A small hiss.") //i couldn't not include stevemre reference
	if(user.action_busy || open || !needs_can_opener || !(opening_tool.type in CAN_OPENER_EFFECTIVE) && !(opening_tool.type in CAN_OPENER_CRUDE))
		return

	if(opening_tool.type in CAN_OPENER_EFFECTIVE)
		if(istype(opening_tool, /obj/item/tool/kitchen/can_opener/compact))
			var/obj/item/tool/kitchen/can_opener/compact/tool = opening_tool
			if(!tool.active)
				to_chat(user, SPAN_WARNING("你需要先把它展开才能使用。"))
				return
		opening_time = 4 SECONDS
		opening_sound = 'sound/items/can_open2.ogg'
		to_chat(user, SPAN_NOTICE("你开始用开罐器打开罐头。[hiss]"))
	if(opening_tool.type in CAN_OPENER_CRUDE)
		opening_time = 12 SECONDS
		opening_sound = 'sound/items/can_open1.ogg'
		to_chat(user, SPAN_NOTICE("你开始用刀片粗暴地撬开罐头。[hiss]"))

	playsound(src.loc, opening_sound, 15, FALSE, 5)

	if(!do_after(user, opening_time, INTERRUPT_ALL, BUSY_ICON_GENERIC))
		return
	if(prob(25) && (opening_tool.type in CAN_OPENER_CRUDE))
		to_chat(user, SPAN_WARNING("你无法用[opening_tool]打开[object_fluff]！再试一次！"))
		playsound(src, "sound/items/can_crush.ogg", 20, FALSE, 5)
		return
	playsound(src.loc, open_sound, 15, 1, 5)
	to_chat(user, SPAN_NOTICE(open_message))
	open = TRUE
	if(has_open_icon)
		icon_state += "_open"
	update_icon()
	user.update_inv_l_hand()
	user.update_inv_r_hand()

/obj/item/reagent_container/food/drinks/cans/get_examine_text(mob/user)
	. = ..()
	if(needs_can_opener)
		. += SPAN_NOTICE("The can is completely sealed, you need some sort of a can opener to open it.")
	if(food_interactable)
		. += SPAN_NOTICE("You can transfer the contents of this [object_fluff] to other foods.")

/obj/item/reagent_container/food/drinks/cans/attack_self(mob/user)
	..()

	if(crushed)
		return

	if(open)
		return

	if(needs_can_opener)
		to_chat(user, SPAN_NOTICE("你需要用某种开罐器来打开[object_fluff]！"))
		return

	playsound(src.loc, open_sound, 15, 1)
	to_chat(user, SPAN_NOTICE(open_message))
	open = TRUE
	if(has_open_icon)
		icon_state += "_open"
	update_icon()

/obj/item/reagent_container/food/drinks/cans/attack_hand(mob/user)
	if(crushed)
		return ..()

	if(open && !reagents.total_volume && crushable)
		if(user.a_intent == INTENT_HARM)
			if(isturf(loc))
				if(user.zone_selected == "r_foot" || user.zone_selected == "l_foot" )
					crush_can(user)
					return FALSE
			else if(loc == user && src == user.get_inactive_hand())
				crush_can(user)
				return FALSE
	return ..()

/obj/item/reagent_container/food/drinks/cans/attack(mob/M, mob/user)
	if(crushed)
		return

	if(!open)
		to_chat(user, SPAN_NOTICE("你需要打开[object_fluff]！"))
		return
	var/datum/reagents/R = src.reagents

	if(!R.total_volume || !R)
		if(M == user && M.a_intent == INTENT_HARM && M.zone_selected == "head" && crushable)
			crush_can(M)
			return
		to_chat(user, SPAN_DANGER("这[src.name]是空的！"))
		return 0

	if(M == user)
		to_chat(M, SPAN_NOTICE("你吞下一口[src]。"))
		if(reagents.total_volume)
			reagents.set_source_mob(user)
			reagents.trans_to_ingest(M, gulp_size)

		playsound(M.loc, consume_sound, 15, 1)
		return 1
	else if( istype(M, /mob/living/carbon) )
		if (!open)
			to_chat(user, SPAN_NOTICE("你需要打开[object_fluff]！"))
			return

		user.affected_message(M,
			SPAN_HELPFUL("You <b>start feeding</b> [user == M ? "yourself" : "[M]"] <b>[src]</b>."),
			SPAN_HELPFUL("[user] <b>starts feeding</b> you <b>[src]</b>."),
			SPAN_NOTICE("[user] starts feeding [user == M ? "themselves" : "[M]"] [src]."))
		if(!do_after(user, 30, INTERRUPT_ALL, BUSY_ICON_FRIENDLY, M))
			return
		user.affected_message(M,
			SPAN_HELPFUL("You <b>fed</b> [user == M ? "yourself" : "[M]"] <b>[src]</b>."),
			SPAN_HELPFUL("[user] <b>fed</b> you <b>[src]</b>."),
			SPAN_NOTICE("[user] fed [user == M ? "themselves" : "[M]"] [src]."))

		var/rgt_list_text = get_reagent_list_text()

		M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been fed [src.name] by [user.name] ([user.ckey]) Reagents: [rgt_list_text]</font>")
		user.attack_log += text("\[[time_stamp()]\] <font color='red'>Fed [M.name] by [M.name] ([M.ckey]) Reagents: [rgt_list_text]</font>")
		msg_admin_attack("[key_name(user)] fed [key_name(M)] with [src.name] (REAGENTS: [rgt_list_text]) (INTENT: [uppertext(intent_text(user.a_intent))]) in [get_area(src)] ([src.loc.x],[src.loc.y],[src.loc.z]).", src.loc.x, src.loc.y, src.loc.z)

		if(reagents.total_volume)
			reagents.set_source_mob(user)
			reagents.trans_to_ingest(M, gulp_size)

		playsound(M.loc,'sound/items/drink.ogg', 15, 1)
		return 1

	return 0


/obj/item/reagent_container/food/drinks/cans/afterattack(obj/target, mob/user, proximity)
	if(crushed || !proximity)
		return

	if(istype(target, /obj/structure/reagent_dispensers)) //A dispenser. Transfer FROM it TO us.
		if (!open)
			to_chat(user, SPAN_NOTICE("你需要打开[object_fluff]！"))
			return


	else if(target.is_open_container()) //Something like a glass. Player probably wants to transfer TO it.
		if (!open)
			to_chat(user, SPAN_NOTICE("你需要打开[object_fluff]！"))
			return

		if(istype(target, /obj/item/reagent_container/food/drinks/cans))
			var/obj/item/reagent_container/food/drinks/cans/cantarget = target
			if(!cantarget.open)
				to_chat(user, SPAN_NOTICE("你需要打开你想倒入的[object_fluff]！"))
				return

	else if(istype(target, /obj/item/reagent_container/food/snacks) && food_interactable)
		if (!open)
			to_chat(user, SPAN_NOTICE("你需要打开[object_fluff]！"))
			return

		if(!reagents.total_volume)
			to_chat(user, SPAN_DANGER("[src]是空的。"))
			return

		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, SPAN_DANGER("你无法再向[target]添加任何东西了。"))
			return
		var/trans = src.reagents.trans_to(target, amount_per_transfer_from_this)
		to_chat(user, SPAN_NOTICE("你将[trans]单位的内容物转移到了[target]中。"))

	return ..()

/obj/item/reagent_container/food/drinks/cans/proc/crush_can(mob/user)
	if(!ishuman(user))
		return

	if(user.action_busy)
		return

	var/mob/living/carbon/human/H = user
	var/message
	var/obj/limb/L
	L = H.get_limb(H.zone_selected)

	if(src == H.get_inactive_hand())
		message = "在[user.p_their()]双手之间"
		to_chat(user, SPAN_NOTICE("你开始用双手碾碎[name]！"))
		if(!do_after(user, 2 SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC)) //crushing with hands takes great effort and might
			return
	else
		switch(user.zone_selected)
			if("head")
				if(!L)
					to_chat(user, SPAN_WARNING("你没有[H.zone_selected]，没法凭空捏扁你的罐头！"))
					return
				message = "对着[user.p_their()]的脑袋！"
				L.take_damage(brute = 3) //ouch! but you're a tough badass so it barely hurts
			if("l_foot" , "r_foot")
				if(!L)
					to_chat(user, SPAN_WARNING("你没有[H.zone_selected]，没法凭空踩扁你的罐头！"))
					return
				message = "在[user.p_their()]脚下！"

	crushed = TRUE
	flags_atom &= ~OPENCONTAINER
	desc += "\nIts been crushed! A badass must have been through here..."
	if(!crushed_icon)
		icon_state = "[icon_state]_crushed"
	else
		icon_state = crushed_icon
	user.visible_message(SPAN_BOLDNOTICE("[user]把[name][message]压扁了"), null, null, CHAT_TYPE_FLUFF_ACTION)
	playsound(src,"sound/items/can_crush.ogg", 20, FALSE, 15)

/obj/item/reagent_container/food/drinks/cans/on_reagent_change()
	. = ..()
	if(delete_on_empty && !reagents.total_volume)
		qdel(src)

//SODA

/obj/item/reagent_container/food/drinks/cans/classcola
	name = "\improper Classic Cola"
	desc = "经典可乐，拥有流传数个世纪的风味。无人能及。"
	icon_state = "cola"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/classcola/Initialize()
	. = ..()
	reagents.add_reagent("cola", 30)

/obj/item/reagent_container/food/drinks/cans/space_mountain_wind
	name = "\improper Mountain Wind"
	desc = "像太空风一样穿透你的身体。"
	icon_state = "space_mountain_wind"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/space_mountain_wind/Initialize()
	. = ..()
	reagents.add_reagent("spacemountainwind", 30)

/obj/item/reagent_container/food/drinks/cans/thirteenloko
	name = "\improper Thirteen Loko"
	desc = "饮用十三乐可能导致癫痫、失明、醉酒甚至死亡。请理性饮酒。"
	desc_lore = "A rarity among modern markets, Thirteen Loko is an all-Earth original. With a name coined by the general consensus that only the mildly insane willing to imbibe it, this energy drink has garnered a notorious reputation for itself and a sizeable cult following to match it. After a series of legal proceedings by Weyland-Yutani, denatured cobra venom was removed from the recipe, much to the disappointment of the drink's consumers."
	icon_state = "thirteen_loko"
	center_of_mass = "x=16;y=8"

/obj/item/reagent_container/food/drinks/cans/thirteenloko/Initialize()
	. = ..()
	reagents.add_reagent("thirteenloko", 30)

/obj/item/reagent_container/food/drinks/cans/dr_gibb
	name = "\improper Dr. Gibb"
	desc = "由42种你念不出名字的化学物质混合而成的美味。"
	icon_state = "dr_gibb"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/dr_gibb/Initialize()
	. = ..()
	reagents.add_reagent("dr_gibb", 30)

/obj/item/reagent_container/food/drinks/cans/starkist
	name = "\improper Star-kist"
	desc = "液态恒星的味道。还有一点金枪鱼味……？"
	icon_state = "starkist"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/starkist/Initialize()
	. = ..()
	reagents.add_reagent("cola", 15)
	reagents.add_reagent("orangejuice", 15)

/obj/item/reagent_container/food/drinks/cans/space_up
	name = "\improper Space-Up"
	desc = "尝起来像船体破裂的味道。"
	icon_state = "space-up"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/space_up/Initialize()
	. = ..()
	reagents.add_reagent("space_up", 30)

/obj/item/reagent_container/food/drinks/cans/lemon_lime
	name = "柠檬青柠味"
	desc = "你想要橙子味。它给了你柠檬青柠味。"
	icon_state = "柠檬青柠味"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/lemon_lime/Initialize()
	. = ..()
	reagents.add_reagent("lemon_lime", 30)

/obj/item/reagent_container/food/drinks/cans/iced_tea
	name = "冰茶罐头"
	desc = "就跟班里的红脖子他奶奶以前常买的一样。"
	icon_state = "ice_tea_can"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/iced_tea/Initialize()
	. = ..()
	reagents.add_reagent("icetea", 30)

/obj/item/reagent_container/food/drinks/cans/grape_juice
	name = "葡萄汁"
	desc = "一罐可能不是葡萄汁的东西。"
	icon_state = "purple_can"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/grape_juice/Initialize()
	. = ..()
	reagents.add_reagent("grapejuice", 30)

/obj/item/reagent_container/food/drinks/cans/tonic
	name = "汤力水"
	desc = "第一步：汤力水。搞定。第二步：金酒。"
	icon_state = "tonic"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/tonic/Initialize()
	. = ..()
	reagents.add_reagent("tonic", 30)

/obj/item/reagent_container/food/drinks/cans/sodawater
	name = "苏打水"
	desc = "一罐苏打水。据那些欧洲佬说，这玩意儿比自来水更提神。"
	icon_state = "sodawater"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/sodawater/Initialize()
	. = ..()
	reagents.add_reagent("sodawater", 30)

//BODA

/obj/item/reagent_container/food/drinks/cans/boda
	name = "\improper Boda"
	desc = "国家规定的苏打饮料。尽情享用吧，同志们。"
	desc_lore = "Designed back in 2159, the advertising campaign for BODA started out as an attempt by the UPP to win the hearts and minds of colonists and settlers across the galaxy. Soon after, the ubiquitous cyan vendors and large supplies of the drink began to crop up in UA warehouses with seemingly no clear origin. Despite some concerns, after initial testing determined that the stored products were safe for consumption and surprisingly popular when blind-tested with focus groups, the strange surplus of BODA was authorized for usage within the UA-associated colonies. Subsequently, it enjoyed a relative popularity before falling into obscurity in the coming decades as supplies dwindled."
	icon_state = "boda"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/boda/Initialize()
	. = ..()
	reagents.add_reagent("sodawater", 30)

/obj/item/reagent_container/food/drinks/cans/bodaplus
	name = "\improper Boda-Plyus"
	desc = "国家规定的苏打饮料，现已添加剩余调味剂。尽情享用吧，同志们。"
	icon_state = "blank_can"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/bodaplus/Initialize()
	. = ..()
	reagents.add_reagent("cola", 30)

//WEYLAND-YUTANI

/obj/item/reagent_container/food/drinks/cans/cola
	name = "\improper Fruit-Beer"
	desc = "理论上，芒果味根汁啤酒听起来是个好主意。维兰德-汤谷用其最新的可乐产品线再次证明了这个理论的错误。由维兰德-汤谷公司罐装。"
	icon_state = "fruit_beer"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/cola/Initialize()
	. = ..()
	reagents.add_reagent("fruit_beer", 30)

/obj/item/reagent_container/food/drinks/cans/waterbottle
	name = "\improper Weyland-Yutani Bottled Spring Water"
	desc = "价格虚高的‘泉水’。由维兰德-汤谷公司瓶装。"
	icon_state = "wy_water"
	crushed_icon = "wy_water_crushed"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_righthand.dmi',
	)
	has_open_icon = TRUE
	center_of_mass = "x=15;y=8"

/obj/item/reagent_container/food/drinks/cans/waterbottle/Initialize()
	. = ..()
	reagents.add_reagent("water", 30)
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/drinks/cans/waterbottle/upp
	name = "\improper Gerolsteiner Bottled Sparkling Water"
	desc = "德国瓶装气泡水，在进步人民联盟的日耳曼人口中很受欢迎。"
	desc_lore = "After Gerolsteiner company becoming an integrated state enterprise, their products became a common thing in military rations and in other places."
	icon_state = "upp_water"
	crushed_icon = "upp_water_crushed"

/obj/item/reagent_container/food/drinks/cans/waterbottle/upp/Initialize()
	. = ..()
	RemoveElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/drinks/cans/coconutmilk
	name = "\improper Weyland-Yutani Bottled Coconut Milk"
	desc = "富含维生素和（人工）风味，几口就能解渴。由维兰德-汤谷公司瓶装。"
	icon_state = "pmc_cocomilk"
	crushed_icon = "pmc_cocomilk_crushed"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_righthand.dmi',
	)
	has_open_icon = TRUE
	center_of_mass = "x=15;y=8"

/obj/item/reagent_container/food/drinks/cans/coconutmilk/Initialize()
	. = ..()
	reagents.add_reagent("coconutmilk", 30)
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/drinks/cans/soylent
	name = "\improper Weyland-Yutani Premium Choco Soylent"
	desc = "装满粘稠美味巧克力的塑料瓶。一瓶的热量就够一顿午餐——别一口气喝完，最好别冒拉肚子的风险。"
	desc_lore = "Initially designed in 2173 as meal replacement for high-intensity workers, MRD was recalled from the market multiple times due to reports of gastrointestinal illness, including nausea, vomiting, and diarrhea. Improved formula was created, but the brand name was already stained (quite literally), so now the drink remains as emergency food supply for internal Company use."
	icon_state = "wy_soylent"
	crushed_icon = "wy_soylent_crushed"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_righthand.dmi',
	)
	has_open_icon = TRUE
	center_of_mass = "x=15;y=8"
	volume = 30

/obj/item/reagent_container/food/drinks/cans/soylent/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 10)
	reagents.add_reagent("soymilk", 10)
	reagents.add_reagent("coco_drink", 10)
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/drinks/cans/bugjuice
	name = "\improper Weyland-Yutani Bug Juice Protein Drink"
	desc = "维兰德-汤谷品牌的塑料瓶，装满了看起来有毒的绿色粘稠物，尝起来像猕猴桃，但你非常确定这里面一点猕猴桃都没有。"
	desc_lore = "'虫汁' Protein Drink, more commonly labeled Bug Juice, is an inexpensive and calorific beverage made with farmed and processed insects such as cockroaches, mealworms, and beetles. Offered by a variety of manufacturers, Bug Juice is packaged in cartons and bottles, and is widely consumed on the Frontier. It is classified as both a drink and a foodstuff, and is a source of protein and water."
	icon_state = "wy_bug_juice"
	crushed_icon = "wy_bug_juice_crushed"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_righthand.dmi',
	)
	has_open_icon = TRUE
	center_of_mass = "x=15;y=8"
	volume = 30

/obj/item/reagent_container/food/drinks/cans/bugjuice/Initialize()
	. = ..()
	reagents.add_reagent("bugjuice", 30)
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/drinks/cans/beer
	name = "\improper Weyland-Yutani Lite"
	desc = "啤酒。你已经锁定了目标。是时候开火见效了。"
	icon_state = "beer"
	center_of_mass = "x=16;y=12"

/obj/item/reagent_container/food/drinks/cans/beer/Initialize()
	. = ..()
	reagents.add_reagent("beer", 30)
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/drinks/cans/ale
	name = "\improper Weyland-Yutani IPA"
	desc = "啤酒那被误解的表亲。"
	icon_state = "ale"
	item_state = "beer"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/ale/Initialize()
	. = ..()
	reagents.add_reagent("ale", 30)
	AddElement(/datum/element/corp_label/wy)

//SOUTO

/obj/item/reagent_container/food/drinks/cans/souto
	name = "\improper Souto Can"
	desc = "哈瓦那罐装。"
	icon_state = "souto_classic"
	item_state = "souto_classic"
	center_of_mass = "x=16;y=10"
	embeddable = 1

/obj/item/reagent_container/food/drinks/cans/souto/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/souta)

/obj/item/reagent_container/food/drinks/cans/souto/diet
	name = "\improper Diet Souto"
	desc = "现在含有0%果汁！哈瓦那罐装。"
	icon_state = "souto_diet_classic"
	item_state = "souto_diet_classic"

/obj/item/reagent_container/food/drinks/cans/souto/diet/Initialize()
	. = ..()
	reagents.add_reagent("water", 25)

/obj/item/reagent_container/food/drinks/cans/souto/classic
	name = "\improper Souto Classic"
	desc = "罐子上大胆地宣称这是橘子口味。你忍不住觉得这是个谎言。哈瓦那罐装。"
	icon_state = "souto_classic"
	item_state = "souto_classic"

/obj/item/reagent_container/food/drinks/cans/souto/classic/Initialize()
	. = ..()
	reagents.add_reagent("souto_classic", 50)

/obj/item/reagent_container/food/drinks/cans/souto/diet/classic
	name = "\improper Diet Souto"
	desc = "现在含有0%果汁！哈瓦那罐装。"
	icon_state = "souto_diet_classic"
	item_state = "souto_diet_classic"

/obj/item/reagent_container/food/drinks/cans/souto/diet/classic/Initialize()
	. = ..()
	reagents.add_reagent("souto_classic", 25)

/obj/item/reagent_container/food/drinks/cans/souto/cherry
	name = "\improper Cherry Souto"
	desc = "现在含有人工风味剂更多了！哈瓦那罐装。"
	icon_state = "souto_cherry"
	item_state = "souto_cherry"

/obj/item/reagent_container/food/drinks/cans/souto/cherry/Initialize()
	. = ..()
	reagents.add_reagent("souto_cherry", 50)

/obj/item/reagent_container/food/drinks/cans/souto/diet/cherry
	name = "\improper Diet Cherry Souto"
	desc = "它既不是无糖的，也不是樱桃味的。哈瓦那罐装。"
	icon_state = "souto_diet_cherry"
	item_state = "souto_diet_cherry"

/obj/item/reagent_container/food/drinks/cans/souto/diet/cherry/Initialize()
	. = ..()
	reagents.add_reagent("souto_cherry", 25)

/obj/item/reagent_container/food/drinks/cans/souto/lime
	name = "\improper Lime Souto"
	desc = "不算差。也不算好，但不算差。哈瓦那罐装。"
	icon_state = "souto_lime"
	item_state = "souto_lime"

/obj/item/reagent_container/food/drinks/cans/souto/lime/Initialize()
	. = ..()
	reagents.add_reagent("souto_lime", 50)

/obj/item/reagent_container/food/drinks/cans/souto/diet/lime
	name = "\improper Diet Lime Souto"
	desc = "十种酸，两杯假糖，几乎一整罐二氧化碳，外加大约210千帕的压力，全塞进一个铝罐里。有什么不喜欢的呢？哈瓦那罐装。"
	icon_state = "souto_diet_lime"
	item_state = "souto_diet_lime"

/obj/item/reagent_container/food/drinks/cans/souto/diet/lime/Initialize()
	. = ..()
	reagents.add_reagent("souto_lime", 25)

/obj/item/reagent_container/food/drinks/cans/souto/grape
	name = "\improper Grape Souto"
	desc = "苏打口味的老牌选择。然而，这个尝起来像葡萄味的止咳糖浆。哈瓦那罐装。"
	icon_state = "souto_grape"
	item_state = "souto_grape"

/obj/item/reagent_container/food/drinks/cans/souto/grape/Initialize()
	. = ..()
	reagents.add_reagent("souto_grape", 50)

/obj/item/reagent_container/food/drinks/cans/souto/diet/grape
	name = "\improper Diet Grape Souto"
	desc = "你相当确定这只是葡萄止咳糖浆和苏打水。哈瓦那罐装。"
	icon_state = "souto_diet_grape"
	item_state = "souto_diet_grape"

/obj/item/reagent_container/food/drinks/cans/souto/diet/grape/Initialize()
	. = ..()
	reagents.add_reagent("souto_grape", 25)

/obj/item/reagent_container/food/drinks/cans/souto/blue
	name = "\improper Blue Raspberry Souto"
	desc = "尝起来像蓝色的味道。科技真是神奇。哈瓦那罐装。"
	icon_state = "souto_blueraspberry"
	item_state = "souto_blueraspberry"
	black_market_value = 10 //mendoza likes blue souto

/obj/item/reagent_container/food/drinks/cans/souto/blue/Initialize()
	. = ..()
	reagents.add_reagent("souto_blueraspberry", 50)

/obj/item/reagent_container/food/drinks/cans/souto/diet/blue
	name = "\improper Diet Blue Raspberry Souto"
	desc = "真是骗局！尝起来根本不像蓝色！最多像青色。哈瓦那罐装。"
	icon_state = "souto_diet_blueraspberry"
	item_state = "souto_diet_blueraspberry"

/obj/item/reagent_container/food/drinks/cans/souto/diet/blue/Initialize()
	. = ..()
	reagents.add_reagent("souto_blueraspberry", 25)

/obj/item/reagent_container/food/drinks/cans/souto/peach
	name = "\improper Peach Souto"
	desc = "一方面，味道不错。另一方面，你觉得能听到里面有桃核在响。哈瓦那罐装。"
	icon_state = "souto_peach"
	item_state = "souto_peach"

/obj/item/reagent_container/food/drinks/cans/souto/peach/Initialize()
	. = ..()
	reagents.add_reagent("souto_peach", 50)

/obj/item/reagent_container/food/drinks/cans/souto/diet/peach
	name = "\improper Diet Peach Souto"
	desc = "一方面，味道不错。另一方面，你觉得能听到半颗桃核在响。哈瓦那罐装。"
	icon_state = "souto_diet_peach"
	item_state = "souto_diet_peach"

/obj/item/reagent_container/food/drinks/cans/souto/diet/peach/Initialize()
	. = ..()
	reagents.add_reagent("souto_peach", 25)

/obj/item/reagent_container/food/drinks/cans/souto/cranberry
	name = "\improper Cranberry Souto"
	desc = "仔细一看，罐子上写着‘CRAMberry Souto’。Cramberry到底是什么鬼东西？哈瓦那罐装。"
	icon_state = "souto_cranberry"
	item_state = "souto_cranberry"

/obj/item/reagent_container/food/drinks/cans/souto/cranberry/Initialize()
	. = ..()
	reagents.add_reagent("souto_cranberry", 50)

/obj/item/reagent_container/food/drinks/cans/souto/diet/cranberry
	name = "\improper Diet Cranberry Souto"
	desc = "这尝起来更像李子而不是蔓越莓。不差，但就是不对味。哈瓦那罐装。"
	icon_state = "souto_diet_cranberry"
	item_state = "souto_diet_cranberry"

/obj/item/reagent_container/food/drinks/cans/souto/diet/cranberry/Initialize()
	. = ..()
	reagents.add_reagent("souto_cranberry", 25)
	reagents.add_reagent("water", 25)

/obj/item/reagent_container/food/drinks/cans/souto/vanilla
	name = "\improper Vanilla Souto"
	desc = "大多数软饮料说‘香草味’，其实是指经典口味加一点香草。但索托公司可不一样，伙计！这罐子里装满了100%纯碳酸香草精！味道糟透了。哈瓦那罐装。"
	icon_state = "souto_vanilla"
	item_state = "souto_vanilla"

/obj/item/reagent_container/food/drinks/cans/souto/vanilla/Initialize()
	. = ..()
	reagents.add_reagent("souto_vanilla", 50)

/obj/item/reagent_container/food/drinks/cans/souto/diet/vanilla
	name = "\improper Diet Vanilla Souto"
	desc = "这是一罐水状苦涩的香草精。你无法想象谁会批准这种概念。哈瓦那罐装。"
	icon_state = "souto_diet_vanilla"
	item_state = "souto_diet_vanilla"

/obj/item/reagent_container/food/drinks/cans/souto/diet/vanilla/Initialize()
	. = ..()
	reagents.add_reagent("souto_vanilla", 25)
	reagents.add_reagent("water", 25)

/obj/item/reagent_container/food/drinks/cans/souto/pineapple
	name = "\improper Pineapple Souto"
	desc = "尝起来像电池酸液混了满满一杯糖。哈瓦那罐装。"
	icon_state = "souto_pineapple"
	item_state = "souto_pineapple"

/obj/item/reagent_container/food/drinks/cans/souto/pineapple/Initialize()
	. = ..()
	reagents.add_reagent("souto_pineapple", 50)

/obj/item/reagent_container/food/drinks/cans/souto/diet/pineapple
	name = "\improper Diet Pineapple Souto"
	desc = "尝起来像电池酸液混了半杯糖。哈瓦那罐装。"
	icon_state = "souto_diet_pineapple"
	item_state = "souto_diet_pineapple"

/obj/item/reagent_container/food/drinks/cans/souto/diet/pineapple/Initialize()
	. = ..()
	reagents.add_reagent("souto_pineapple", 25)
	reagents.add_reagent("water", 25)

//ASPEN

/obj/item/reagent_container/food/drinks/cans/aspen
	name = "\improper Weyland-Yutani Aspen Beer"
	desc = "一旦忽略它尝起来像尿的事实，其实还不错。维兰德-汤谷公司罐装。"
	icon_state = "6_pack_1"
	item_state = "6_pack_1"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/cans/aspen/Initialize()
	. = ..()
	reagents.add_reagent("beer", 50)
	AddElement(/datum/element/corp_label/wy)
