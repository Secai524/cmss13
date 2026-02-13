/* SNACK
* snack are food items that after being consume destroy themself.
* some snack are slice able.
* some produce trash after being consume/destroyed.
*/

/obj/item/reagent_container/food/snacks
	name = "snack"
	desc = "美味。"
	icon = 'icons/obj/items/food/junkfood.dmi'
	icon_state = null
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/food_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/food_righthand.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/food.dmi',
	)
	var/bitesize = 1
	var/bitecount = 0
	var/trash = null
	var/slice_path
	var/slices_num
	var/package = 0
	var/made_from_player = ""
	center_of_mass = "x=15;y=15"

	//Placeholder for effect that trigger on eating that aren't tied to reagents.
/obj/item/reagent_container/food/snacks/proc/On_Consume(mob/M)
	SEND_SIGNAL(src, COMSIG_SNACK_EATEN, M)
	SEND_SIGNAL(M, COMSIG_MOB_EATEN_SNACK, src)
	if(!usr)
		return

	if(!reagents.total_volume)
		if(M == usr)
			to_chat(usr, SPAN_NOTICE("你吃完了\the [src]。"))
		M.visible_message(SPAN_NOTICE("[M]吃完了\the [src]。"))
		usr.drop_inv_item_on_ground(src) //so icons update :[

		if(trash)
			if(ispath(trash,/obj/item))
				var/obj/item/TrashItem = new trash(usr)
				usr.put_in_hands(TrashItem)
			else if(istype(trash,/obj/item))
				usr.put_in_hands(trash)
		qdel(src)
	return

/obj/item/reagent_container/food/snacks/attack_self(mob/user)
	..()

	if (world.time <= user.next_move)
		return FALSE
	attack(user, user, "head")//zone does not matter
	user.next_move += attack_speed

/obj/item/reagent_container/food/snacks/attack(mob/M, mob/user)
	if(reagents && !reagents.total_volume) //Shouldn't be needed but it checks to see if it has anything left in it.
		to_chat(user, SPAN_DANGER("[src]一点不剩了，糟糕！"))
		M.drop_inv_item_on_ground(src) //so icons update :[
		qdel(src)
		return FALSE

	if(package)
		if(user.a_intent == INTENT_HARM)
			return ..() // chunk box gaming

		if(user == M)
			to_chat(M, SPAN_WARNING("包装都没拆，你怎么吃？"))
		else
			to_chat(M, SPAN_WARNING("[user]试图把带着包装的零食硬塞给你。"))
		return FALSE

	if(istype(M, /mob/living/carbon))
		var/mob/living/carbon/C = M
		var/fullness = M.nutrition + (M.reagents.get_reagent_amount("nutriment") * 25)
		if(fullness > NUTRITION_HIGH && world.time < C.overeat_cooldown)
			to_chat(user, SPAN_WARNING("[user == M ? "You" : "They"] don't feel like eating more right now."))
			return FALSE
		if(issynth(C) || isyautja(C))
			fullness = 200 //Synths and yautja never get full

		if(HAS_TRAIT(M, TRAIT_CANNOT_EAT)) //Do not feed the Working Joes
			to_chat(user, SPAN_DANGER("[user == M ? "You are" : "[M] is"] unable to eat!"))
			return FALSE

		if(fullness > NUTRITION_HIGH)
			C.overeat_cooldown = world.time + OVEREAT_TIME

		if(M == user)//If you're eating it yourself
			if (fullness <= NUTRITION_VERYLOW)
				to_chat(M, SPAN_WARNING("你狼吞虎咽地吞下一大块[src]，囫囵吞下！"))
			if (fullness > NUTRITION_VERYLOW && fullness <= NUTRITION_LOW)
				to_chat(M, SPAN_NOTICE("你饥饿地咬下一块[src]。"))
			if (fullness > NUTRITION_LOW && fullness <= NUTRITION_NORMAL)
				to_chat(M, SPAN_NOTICE("你咬了一口[src]。"))
			if (fullness > NUTRITION_NORMAL && fullness <= NUTRITION_HIGH)
				to_chat(M, SPAN_NOTICE("你勉强嚼了一点[src]。"))
			if (fullness > NUTRITION_HIGH)
				to_chat(M, SPAN_WARNING("你强忍着又咽下一些[src]。"))
		else
			if (fullness <= NUTRITION_HIGH)
				user.affected_message(M,
					SPAN_HELPFUL("You <b>start feeding</b> [user == M ? "yourself" : "[M]"] <b>[src]</b>."),
					SPAN_HELPFUL("[user] <b>starts feeding</b> you <b>[src]</b>."),
					SPAN_NOTICE("[user] starts feeding [user == M ? "themselves" : "[M]"] [src]."))

			if(!do_after(user, 30, INTERRUPT_ALL, BUSY_ICON_FRIENDLY, M))
				return

			var/rgt_list_text = get_reagent_list_text()

			M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been fed [src.name] by [user.name] ([user.ckey]) Reagents: [rgt_list_text]</font>")
			user.attack_log += text("\[[time_stamp()]\] <font color='red'>Fed [src.name] by [M.name] ([M.ckey]) Reagents: [rgt_list_text]</font>")
			msg_admin_attack("[key_name(user)] fed [key_name(M)] with [src.name] (REAGENTS: [rgt_list_text]) (INTENT: [uppertext(intent_text(user.a_intent))]) in [get_area(user)] ([user.loc.x],[user.loc.y],[user.loc.z]).", user.loc.x, user.loc.y, user.loc.z)

			user.affected_message(M,
				SPAN_HELPFUL("You <b>fed</b> [user == M ? "yourself" : "[M]"] <b>[src]</b>."),
				SPAN_HELPFUL("[user] <b>fed</b> you <b>[src]</b>."),
				SPAN_NOTICE("[user] fed [user == M ? "themselves" : "[M]"] [src]."))

		if(reagents) //Handle ingestion of the reagent.
			playsound(M.loc,'sound/items/eatfood.ogg', 15, 1)
			if(reagents.total_volume)
				reagents.set_source_mob(user)
				if(reagents.total_volume > bitesize)
					/*
					 * I totally cannot understand what this code supposed to do.
					 * Right now every snack consumes in 2 bites, my popcorn does not work right, so I simplify it. -- rastaf0
					var/temp_bitesize =  max(reagents.total_volume /2, bitesize)
					reagents.trans_to(M, temp_bitesize)
					*/
					reagents.trans_to_ingest(M, bitesize)
				else
					reagents.trans_to_ingest(M, reagents.total_volume)
				bitecount++
				On_Consume(M)
			return TRUE

	return FALSE

/obj/item/reagent_container/food/snacks/afterattack(obj/target, mob/user, proximity)
	return ..()

/obj/item/reagent_container/food/snacks/get_examine_text(mob/user)
	. = ..()
	if (!(user in range(0)) && user != loc)
		return
	if (!bitecount)
		return
	else if (bitecount==1)
		. += SPAN_NOTICE("\The [src] was bitten by someone!")
	else if (bitecount<=3)
		. += SPAN_NOTICE("\The [src] was bitten [bitecount] times!")
	else
		. += SPAN_NOTICE("\The [src] was bitten multiple times!")

/obj/item/reagent_container/food/snacks/set_origin_name_prefix(name_prefix)
	made_from_player = name_prefix

/obj/item/reagent_container/food/snacks/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/storage))
		..() // -> item/attackby()
	if(istype(W,/obj/item/storage))
		..() // -> item/attackby()

	if(istype(W,/obj/item/tool/kitchen/utensil))

		var/obj/item/tool/kitchen/utensil/U = W

		if(!U.reagents)
			U.create_reagents(5)

		if (U.reagents.total_volume > 0)
			to_chat(user, SPAN_DANGER("你的[U]上已经有东西了。"))
			return

		user.visible_message(
			"[user] scoops up some [src] with \the [U]!",
			SPAN_NOTICE("You scoop up some [src] with \the [U]!")
		)

		src.bitecount++
		U.overlays.Cut()
		U.loaded = "[src]"
		var/image/I = new(U.icon, "loadedfood")
		I.color = src.filling_color
		U.overlays += I

		reagents.trans_to(U,min(reagents.total_volume,5))

		if (reagents.total_volume <= 0)
			qdel(src)
		return

	if((slices_num <= 0 || !slices_num) || !slice_path)
		return 0

	var/inaccurate = 0
	if(W.sharp == IS_SHARP_ITEM_BIG)
		inaccurate = 1
	else if(W.sharp != IS_SHARP_ITEM_ACCURATE)
		return 1
	if ( !istype(loc, /obj/structure/surface/table) && \
			(!isturf(src.loc) || \
			!(locate(/obj/structure/surface/table) in src.loc) && \
			!(locate(/obj/structure/machinery/optable) in src.loc) && \
			!(locate(/obj/item/tool/kitchen/tray) in src.loc)) \
		)
		to_chat(user, SPAN_DANGER("这里不能切[src]！你需要一张桌子或至少一个托盘。"))
		return 1
	var/slices_lost = 0
	if (!inaccurate)
		user.visible_message(
			SPAN_NOTICE("[user] slices \the [src]!"),
			SPAN_NOTICE("You slice \the [src]!")
		)
	else
		user.visible_message(
			SPAN_NOTICE("[user] crudely slices \the [src] with [W]!"),
			SPAN_NOTICE("You crudely slice \the [src] with your [W]!")
		)
		slices_lost = rand(1,max(1,floor(slices_num/2)))
	var/reagents_per_slice = reagents.total_volume/slices_num
	for(var/i=1 to (slices_num-slices_lost))
		var/obj/slice = new slice_path (src.loc)
		reagents.trans_to(slice,reagents_per_slice)
	qdel(src)
	return

/obj/item/reagent_container/food/snacks/attack_animal(mob/M)
	if(isanimal(M))
		if(iscorgi(M))
			if(bitecount == 0 || prob(50))
				M.emote("小口啃着[src]")
			bitecount++
			if(bitecount >= 5)
				var/sattisfaction_text = pick("burps from enjoyment", "yaps for more", "woofs twice", "looks at the area where [src] was")
				if(sattisfaction_text)
					M.emote("[sattisfaction_text].")
				qdel(src)
		if(ismouse(M))
			var/mob/living/simple_animal/small/mouse/N = M
			to_chat(N, text(SPAN_NOTICE("You nibble away at [src].")))
			if(prob(50))
				N.visible_message("[N]小口啃着[src]。", "")
			//N.emote("nibbles away at the [src]")
			N.health = min(N.health + 1, N.maxHealth)


////////////////////////////////////////////////////////////////////////////////
/// FOOD END
////////////////////////////////////////////////////////////////////////////////

/*
* SNACKS
* Comment on what items in subcategory snacks need to behave:
* Items in the "Snacks" subcategory are food items that people actually eat.
* The key points are that they are created already filled with reagents and are destroyed when empty.
* Additionally, they make a "munching" noise when eaten.
*
* Notes by Darem:
* Food in the "snacks" subtype can hold a maximum of 50 units Generally speaking.
* You don't want to go over 40 total for the item because you want to leave space for extra condiments.
* If you want effect besides healing, add a reagent for it.
* Try to stick to existing reagents when possible (so if you want a stronger healing effect, just use Tricordrazine).
* On use effect (such as the old officer eating a donut code) requires a unique reagent (unless you can figure out a better way).
*
* Comment on how the old and new system compare?:
* The nutriment reagent and bitesize variable replace the old heal_amt and amount variables.
* Each unit of nutriment is equal to 2 of the old heal_amt variable. Bitesize is the rate at which the reagents are consumed.
* So if you have 6 nutriment and a bitesize of 2, then it'll take 3 bites to eat.
* Unlike the old system, the contained reagents are evenly spread among all the bites. No more contained reagents = no more bites.
*
* Example on how to add a new snack item:
* here is an example of the new formatting for anyone who wants to add more food items.
* /obj/item/reagent_container/food/snacks/xenoburger ///Identification path for the object.
* name = "Xenoburger" ///Name that displays in the UI.
* desc = "闻起来有腐蚀性。尝起来像异端邪说。" ///Duh
* icon_state = "xburger" ///Refers to an icon in food.dmi
* /obj/item/reagent_container/food/snacks/xenoburger/Initialize() ///Don't mess with this.
* . = ..() ///Same here.
* reagents.add_reagent("xenomicrobes", 10) ///This is what is in the food item. you may copy/paste
* reagents.add_reagent("nutriment", 2) /// this line of code for all the contents.
* bitesize = 3 ///This is the amount each bite consumes.
*/

/obj/item/reagent_container/food/snacks/aesirsalad
	name = "埃希尔沙拉"
	desc = "凡人可能无福完全享受此等美味。"
	icon_state = "aesirsalad"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#468C00"

/obj/item/reagent_container/food/snacks/aesirsalad/Initialize()
	. = ..()
	reagents.add_reagent("plantmatter", 8)
	reagents.add_reagent("doctorsdelight", 8)
	reagents.add_reagent("tricordrazine", 8)
	bitesize = 3

/obj/item/reagent_container/food/snacks/candy
	name = "candy"
	desc = "牛轧糖，爱憎分明。"
	icon_state = "candy"
	trash = /obj/item/trash/candy
	filling_color = "#7D5F46"
	w_class = SIZE_TINY

/obj/item/reagent_container/food/snacks/candy/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 1)
	reagents.add_reagent("sugar", 3)
	bitesize = 2

/obj/item/reagent_container/food/snacks/candy/donor
	name = "献血者糖果"
	desc = "给献血者的一点小奖励。"
	trash = /obj/item/trash/candy

/obj/item/reagent_container/food/snacks/candy/donor/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 10)
	reagents.add_reagent("sugar", 3)
	bitesize = 5

/obj/item/reagent_container/food/snacks/candy_corn
	name = "玉米糖"
	desc = "这是一把玉米糖。可惜不能存放在侦探帽里。"
	icon_state = "candy_corn"
	icon = 'icons/obj/items/food/candies.dmi'
	filling_color = "#FFFCB0"

/obj/item/reagent_container/food/snacks/candy_corn/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 4)
	reagents.add_reagent("sugar", 2)
	bitesize = 2

/obj/item/reagent_container/food/snacks/chips
	name = "chips"
	desc = "瑞克指挥官的神秘薯片。"
	icon_state = "chips"
	trash = /obj/item/trash/chips
	filling_color = "#E8C31E"

/obj/item/reagent_container/food/snacks/chips/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("blackpepper", 1)

/obj/item/reagent_container/food/snacks/wy_chips/pepper
	name = "维兰德-汤谷胡椒薯片"
	desc = "优质薯片，零反式脂肪，添加黑胡椒。"
	icon_state = "wy_chips_pepper"
	item_state = "wy_chips_pepper"
	trash = /obj/item/trash/wy_chips_pepper
	filling_color = "#E8C31E"

/obj/item/reagent_container/food/snacks/wy_chips/pepper/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("blackpepper", 1)
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/snacks/cookie
	name = "cookie"
	desc = "美味酥脆的巧克力曲奇。别喂给鹦鹉。"
	icon_state = "COOKIE!!!"
	item_state = "COOKIE!!!"
	icon = 'icons/obj/items/food/bakery.dmi'
	filling_color = "#DBC94F"

/obj/item/reagent_container/food/snacks/cookie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 4)
	reagents.add_reagent("sugar", 1)

/obj/item/reagent_container/food/snacks/chocolatebar
	name = "巧克力棒"
	desc = "如此甜美、令人发胖的食物。"
	icon_state = "chocolatebar"
	icon = 'icons/obj/items/food/candies.dmi'
	filling_color = "#7D5F46"

/obj/item/reagent_container/food/snacks/chocolatebar/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 2)
	reagents.add_reagent("sugar", 2)
	reagents.add_reagent("coco", 2)
	bitesize = 2

/obj/item/reagent_container/food/snacks/chocolateegg
	name = "巧克力蛋"
	desc = "如此甜美、令人发胖的食物。"
	icon_state = "chocolateegg"
	icon = 'icons/obj/items/food/eggs.dmi'
	filling_color = "#7D5F46"

/obj/item/reagent_container/food/snacks/chocolateegg/Initialize()
	. = ..()
	reagents.add_reagent("egg", 3)
	reagents.add_reagent("sugar", 2)
	reagents.add_reagent("coco", 2)
	bitesize = 2

/obj/item/reagent_container/food/snacks/donut
	name = "donut"
	desc = "一种甜甜圈糕点，地球上的常见零食。与咖啡是绝配。"
	icon_state = "donut1"
	icon = 'icons/obj/items/food/donuts.dmi'
	filling_color = "#D9C386"
	var/overlay_state = "donut"
	w_class = SIZE_TINY

/obj/item/reagent_container/food/snacks/donut/normal
	name = "donut"
	desc = "一个甜甜圈。在边疆很罕见，请珍惜。"
	icon_state = "donut1"

/obj/item/reagent_container/food/snacks/donut/normal/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	src.bitesize = 3
	if(prob(40))
		icon_state = "donut2"
		overlay_state = "fdonut"
		name = "糖霜甜甜圈"
		desc = "一个粉色糖霜甜甜圈。在边疆更为罕见。"
		reagents.add_reagent("sprinkles", 2)

/obj/item/reagent_container/food/snacks/donut/chaos
	name = "混沌甜甜圈"
	desc = "就像生活一样，它的味道从不完全相同。"
	icon_state = "donut1"
	filling_color = "#ED11E6"

/obj/item/reagent_container/food/snacks/donut/chaos/Initialize()
	. = ..()
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("sprinkles", 1)
	bitesize = 10
	var/chaosselect = pick(1,2,3,4,5,6,7,8,9)
	switch(chaosselect)
		if(1)
			reagents.add_reagent("nutriment", 3)
		if(2)
			reagents.add_reagent("hotsauce", 3)
		if(3)
			reagents.add_reagent("frostoil", 3)
		if(4)
			reagents.add_reagent("sprinkles", 3)
		if(5)
			reagents.add_reagent("phoron", 3)
		if(6)
			reagents.add_reagent("coco", 3)
		if(7)
			reagents.add_reagent("banana", 3)
		if(8)
			reagents.add_reagent("berryjuice", 3)
		if(9)
			reagents.add_reagent("tricordrazine", 3)
	if(prob(30))
		src.icon_state = "donut2"
		src.overlay_state = "box-donut2"
		src.name = "Frosted Chaos Donut"
		reagents.add_reagent("sprinkles", 2)

/obj/item/reagent_container/food/snacks/donut/jelly
	name = "果冻甜甜圈"
	desc = "你嫉妒吗？"
	icon_state = "jdonut1"
	filling_color = "#ED1169"

/obj/item/reagent_container/food/snacks/donut/jelly/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("sprinkles", 1)
	reagents.add_reagent("berryjuice", 5)
	bitesize = 5
	if(prob(30))
		src.icon_state = "jdonut2"
		src.overlay_state = "box-donut2"
		src.name = "Frosted Jelly Donut"
		reagents.add_reagent("sprinkles", 2)

/obj/item/reagent_container/food/snacks/donut/cherryjelly
	name = "果冻甜甜圈"
	desc = "你嫉妒吗？"
	icon_state = "jdonut1"
	filling_color = "#ED1169"

/obj/item/reagent_container/food/snacks/donut/cherryjelly/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("sprinkles", 1)
	reagents.add_reagent("cherryjelly", 5)
	bitesize = 5
	if(prob(30))
		src.icon_state = "jdonut2"
		src.overlay_state = "box-donut2"
		src.name = "Frosted Jelly Donut"
		reagents.add_reagent("sprinkles", 2)

/obj/item/reagent_container/food/snacks/egg
	name = "egg"
	desc = "一个蛋！"
	icon_state = "egg"
	icon = 'icons/obj/items/food/eggs.dmi'
	filling_color = "#FDFFD1"
	var/egg_color

/obj/item/reagent_container/food/snacks/egg/Initialize()
	. = ..()
	reagents.add_reagent("egg", 1)

/obj/item/reagent_container/food/snacks/egg/launch_impact(atom/hit_atom)
	..()
	new/obj/effect/decal/cleanable/egg_smudge(loc)
	if(reagents)
		reagents.reaction(hit_atom, TOUCH)
	visible_message(SPAN_WARNING("[name]被压扁了。"),SPAN_WARNING("You hear a smack."))
	qdel(src)

/obj/item/reagent_container/food/snacks/egg/blue
	icon_state = "egg-blue"
	egg_color = "blue"

/obj/item/reagent_container/food/snacks/egg/green
	icon_state = "egg-green"
	egg_color = "green"

/obj/item/reagent_container/food/snacks/egg/mime
	icon_state = "egg-mime"
	egg_color = "mime"

/obj/item/reagent_container/food/snacks/egg/orange
	icon_state = "egg-orange"
	egg_color = "orange"

/obj/item/reagent_container/food/snacks/egg/purple
	icon_state = "egg-purple"
	egg_color = "purple"

/obj/item/reagent_container/food/snacks/egg/rainbow
	icon_state = "egg-rainbow"
	egg_color = "rainbow"

/obj/item/reagent_container/food/snacks/egg/red
	icon_state = "egg-red"
	egg_color = "red"

/obj/item/reagent_container/food/snacks/egg/yellow
	icon_state = "egg-yellow"
	egg_color = "yellow"

/obj/item/reagent_container/food/snacks/egg/random/Initialize()
	. = ..()
	var/newegg = pick(subtypesof(/obj/item/reagent_container/food/snacks/egg))
	new newegg(loc)
	qdel(src)

/obj/item/reagent_container/food/snacks/friedegg
	name = "煎蛋"
	desc = "一个煎蛋，带点盐和胡椒。"
	icon_state = "friedegg"
	icon = 'icons/obj/items/food/dishes.dmi'
	filling_color = "#FFDF78"

/obj/item/reagent_container/food/snacks/friedegg/Initialize()
	. = ..()
	reagents.add_reagent("egg", 2)
	reagents.add_reagent("sodiumchloride", 1)
	reagents.add_reagent("blackpepper", 1)

/obj/item/reagent_container/food/snacks/boiledegg
	name = "煮鸡蛋"
	desc = "一个煮熟的鸡蛋。"
	icon_state = "egg"
	icon = 'icons/obj/items/food/eggs.dmi'
	filling_color = COLOR_WHITE

/obj/item/reagent_container/food/snacks/boiledegg/Initialize()
	. = ..()
	reagents.add_reagent("egg", 2)

/obj/item/reagent_container/food/snacks/flour
	name = "flour"
	desc = "一个装满面粉的小袋子。"
	icon_state = "flour"
	icon = 'icons/obj/items/food/condiments.dmi'

/obj/item/reagent_container/food/snacks/flour/Initialize()
	. = ..()
	reagents.add_reagent("dough", 1)

/obj/item/reagent_container/food/snacks/organ

	name = "organ"
	desc = "这对你有好处。"
	icon = 'icons/obj/items/organs.dmi'
	icon_state = "appendix"
	filling_color = "#E00D34"

/obj/item/reagent_container/food/snacks/organ/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", rand(3,5))
	reagents.add_reagent("toxin", rand(1,3))
	src.bitesize = 3

/obj/item/reagent_container/food/snacks/tofu
	name = "豆腐"
	desc = "我们都爱豆腐。"
	icon_state = "tofu"
	icon = 'icons/obj/items/food/cheese.dmi'
	filling_color = "#FFFEE0"

/obj/item/reagent_container/food/snacks/tofu/Initialize()
	. = ..()
	reagents.add_reagent("tofu", 3)
	src.bitesize = 3

/obj/item/reagent_container/food/snacks/tofurkey
	name = "豆腐火鸡"
	desc = "一种用豆腐制成的假火鸡。"
	icon_state = "tofurkey"
	icon = 'icons/obj/items/food/dishes.dmi'
	filling_color = "#FFFEE0"

/obj/item/reagent_container/food/snacks/tofurkey/Initialize()
	. = ..()
	reagents.add_reagent("tofu", 12)
	reagents.add_reagent("stoxin", 3)
	bitesize = 3

/obj/item/reagent_container/food/snacks/stuffing
	name = "填料"
	desc = "湿润、带胡椒味的面包屑，用于填充死鸟的体腔。开动吧！"
	icon_state = "stuffing"
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	filling_color = "#C9AC83"

/obj/item/reagent_container/food/snacks/stuffing/Initialize()
	. = ..()
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("blackpepper",1)

/obj/item/reagent_container/food/snacks/carpmeat
	name = "鲤鱼鱼片"
	desc = "一片太空鲤鱼肉片。"
	icon_state = "fishfillet"
	icon = 'icons/obj/items/food/fish.dmi'
	filling_color = "#FFDEFE"

/obj/item/reagent_container/food/snacks/carpmeat/Initialize()
	. = ..()
	reagents.add_reagent("fish", 3)
	reagents.add_reagent("carpotoxin", 6)
	src.bitesize = 6

/obj/item/reagent_container/food/snacks/carpmeat/processed
	name = "加工过的鲤鱼鱼片"
	desc = "一块太空鲤鱼肉排。这块肉经过处理，已去除鲤毒素。"

/obj/item/reagent_container/food/snacks/carpmeat/processed/Initialize()
	. = ..()
	reagents.remove_reagent("carpotoxin", 6)

/obj/item/reagent_container/food/snacks/fishfingers
	name = "鱼条"
	desc = "一条鱼肉条。"
	icon_state = "fishfingers"
	icon = 'icons/obj/items/food/fish.dmi'
	filling_color = "#FFDEFE"

/obj/item/reagent_container/food/snacks/fishfingers/Initialize()
	. = ..()
	reagents.add_reagent("fish", 4)
	bitesize = 3

/obj/item/reagent_container/food/snacks/hugemushroomslice
	name = "巨型蘑菇切片"
	desc = "一片来自巨型蘑菇的切片。"
	icon_state = "hugemushroomslice"
	icon = 'icons/obj/items/food/slices.dmi'
	filling_color = "#E0D7C5"

/obj/item/reagent_container/food/snacks/hugemushroomslice/Initialize()
	. = ..()
	reagents.add_reagent("mushroom", 3)
	reagents.add_reagent("psilocybin", 3)
	src.bitesize = 6

/obj/item/reagent_container/food/snacks/tomatomeat
	name = "番茄切片"
	desc = "一片来自巨型番茄的切片。"
	icon_state = "tomatomeat"
	icon = 'icons/obj/items/food/slices.dmi'
	filling_color = "#DB0000"

/obj/item/reagent_container/food/snacks/tomatomeat/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 3)
	src.bitesize = 6

/obj/item/reagent_container/food/snacks/bearmeat
	name = "熊肉"
	desc = "一块非常爷们儿的肉排。"
	icon_state = "bearmeat"
	icon = 'icons/obj/items/food/meat.dmi'
	filling_color = "#DB0000"

/obj/item/reagent_container/food/snacks/bearmeat/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 12)
	src.bitesize = 3

/obj/item/reagent_container/food/snacks/meatball
	name = "meatball"
	desc = "一顿各方面都很棒的餐食。"
	icon_state = "meatball"
	icon = 'icons/obj/items/food/meat.dmi'
	filling_color = "#DB0000"

/obj/item/reagent_container/food/snacks/meatball/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 3)
	bitesize = 2

/obj/item/reagent_container/food/snacks/sausage
	name = "sausage"
	desc = "一块混合的长条肉。"
	icon_state = "sausage"
	icon = 'icons/obj/items/food/meat.dmi'
	filling_color = "#DB0000"

/obj/item/reagent_container/food/snacks/sausage/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 6)
	bitesize = 2

/obj/item/reagent_container/food/snacks/donkpocket
	name = "\improper Donk-pocket"
	desc = "经验丰富的叛徒的首选食物。"
	icon = 'icons/obj/items/food/bakery.dmi'
	icon_state = "donkpocket"
	item_state_slots = list(WEAR_AS_GARB = "donkpocket")
	filling_color = "#DEDEAB"
	var/warm = 0

/obj/item/reagent_container/food/snacks/donkpocket/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 2)
	reagents.add_reagent("bread", 2)

/obj/item/reagent_container/food/snacks/donkpocket/proc/cooltime() //Not working, derp?
	if(warm)
		spawn(4200)
			if(!QDELETED(src)) //not qdel'd
				warm = 0
				reagents.del_reagent("tricordrazine")
				name = "唐克口袋饼"

/obj/item/reagent_container/food/snacks/brainburger
	name = "brainburger"
	desc = "一个看起来奇怪的汉堡。它看起来几乎是有知觉的。"
	icon_state = "brainburger"
	icon = 'icons/obj/items/food/burgers.dmi'
	filling_color = "#F2B6EA"

/obj/item/reagent_container/food/snacks/brainburger/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 6)
	reagents.add_reagent("alkysine", 6)
	bitesize = 2

/obj/item/reagent_container/food/snacks/ghostburger
	name = "幽灵汉堡"
	desc = "诡异！它看起来不太管饱。"
	icon_state = "ghostburger"
	icon = 'icons/obj/items/food/burgers.dmi'
	filling_color = "#FFF2FF"

/obj/item/reagent_container/food/snacks/ghostburger/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 2)
	bitesize = 2

/obj/item/reagent_container/food/snacks/human
	filling_color = "#D63C3C"

/obj/item/reagent_container/food/snacks/human/burger
	name = "鲍勃汉堡"
	desc = "一个血淋淋的汉堡。"
	icon_state = "hamburger"
	icon = 'icons/obj/items/food/burgers.dmi'

/obj/item/reagent_container/food/snacks/human/burger/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("meatprotein", 6)
	bitesize = 2

/obj/item/reagent_container/food/snacks/cheeseburger
	name = "cheeseburger"
	desc = "奶酪增添了绝佳风味。"
	icon_state = "hamburger"
	icon = 'icons/obj/items/food/burgers.dmi'

/obj/item/reagent_container/food/snacks/cheeseburger/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("cheese", 3)
	bitesize = 2

/obj/item/reagent_container/food/snacks/monkeyburger
	name = "burger"
	desc = "每顿营养早餐的基石。"
	icon_state = "hburger"
	icon = 'icons/obj/items/food/burgers.dmi'
	filling_color = "#D63C3C"

/obj/item/reagent_container/food/snacks/monkeyburger/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("meatprotein", 3)
	bitesize = 2

/obj/item/reagent_container/food/snacks/fishburger
	name = "鲤鱼排三明治"
	desc = "几乎能听到鲤鱼在某个地方呐喊……把我的鲤鱼排还给我，把那条鲤鱼给我。"
	icon_state = "fishburger"
	icon = 'icons/obj/items/food/burgers.dmi'
	filling_color = "#FFDEFE"

/obj/item/reagent_container/food/snacks/fishburger/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("fish", 3)
	bitesize = 3

/obj/item/reagent_container/food/snacks/tofuburger
	name = "豆腐汉堡"
	desc = "那……是什么肉？"
	icon_state = "tofuburger"
	icon = 'icons/obj/items/food/burgers.dmi'
	filling_color = "#FFFEE0"

/obj/item/reagent_container/food/snacks/tofuburger/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("tofu", 3)
	bitesize = 2

/obj/item/reagent_container/food/snacks/roburger
	name = "roburger"
	desc = "生菜是唯一的有机成分。哔。"
	icon_state = "roburger"
	icon = 'icons/obj/items/food/burgers.dmi'
	filling_color = "#CCCCCC"

/obj/item/reagent_container/food/snacks/roburger/Initialize(mapload, ...)
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("iron", 3)
	bitesize = 2

/obj/item/reagent_container/food/snacks/xenoburger
	name = "xenoburger"
	desc = "闻起来有腐蚀性。尝起来像异端邪说。"
	icon_state = "xburger"
	icon = 'icons/obj/items/food/burgers.dmi'
	filling_color = "#43DE18"

/obj/item/reagent_container/food/snacks/xenoburger/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("meatprotein", 3)
	bitesize = 3

/obj/item/reagent_container/food/snacks/clownburger
	name = "小丑汉堡"
	desc = "这味道有点怪..."
	icon_state = "clownburger"
	icon = 'icons/obj/items/food/burgers.dmi'
	filling_color = COLOR_MAGENTA

/obj/item/reagent_container/food/snacks/clownburger/Initialize()
	. = ..()
	reagents.add_reagent("bread", 6)
	bitesize = 2

/obj/item/reagent_container/food/snacks/mimeburger
	name = "默剧汉堡"
	desc = "它的味道无法用语言形容。"
	icon_state = "mimeburger"
	icon = 'icons/obj/items/food/burgers.dmi'
	filling_color = COLOR_WHITE

/obj/item/reagent_container/food/snacks/mimeburger/Initialize()
	. = ..()
	reagents.add_reagent("bread", 6)
	bitesize = 2

/obj/item/reagent_container/food/snacks/omelette
	name = "奶酪煎蛋卷"
	desc = "你只能说出这句话！"
	icon_state = "omelette"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#FFF9A8"

	//var/herp = 0
/obj/item/reagent_container/food/snacks/omelette/Initialize()
	. = ..()
	reagents.add_reagent("egg", 4)
	reagents.add_reagent("cheese", 4)

/obj/item/reagent_container/food/snacks/muffin
	name = "松饼"
	desc = "一小块松饼。松软、湿润、美味。"
	icon_state = "muffin"
	icon = 'icons/obj/items/food/bakery.dmi'
	filling_color = "#E0CF9B"

/obj/item/reagent_container/food/snacks/muffin/Initialize()
	. = ..()
	reagents.add_reagent("bread", 4)
	reagents.add_reagent("sugar", 2)
	bitesize = 2

/obj/item/reagent_container/food/snacks/pie
	name = "香蕉奶油派"
	desc = "就像回到小丑星球的老家一样！嘀嘀！"
	icon_state = "pie"
	icon = 'icons/obj/items/food/bakery.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#FBFFB8"

/obj/item/reagent_container/food/snacks/pie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 4)
	reagents.add_reagent("banana",5)
	bitesize = 3

/obj/item/reagent_container/food/snacks/pie/launch_impact(atom/hit_atom)
	..()
	new/obj/effect/decal/cleanable/pie_smudge(src.loc)
	src.visible_message(SPAN_DANGER("[src.name] 啪嗒一声。"),SPAN_DANGER("You hear a splat."))
	qdel(src)

/obj/item/reagent_container/food/snacks/berryclafoutis
	name = "浆果克拉芙缇"
	desc = "没有黑鸟，这是个好兆头。"
	icon_state = "berryclafoutis"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/plate

/obj/item/reagent_container/food/snacks/berryclafoutis/Initialize()
	. = ..()
	reagents.add_reagent("bread", 4)
	reagents.add_reagent("berryjuice", 5)
	bitesize = 3

/obj/item/reagent_container/food/snacks/waffles
	name = "waffles"
	desc = "嗯，华夫饼。"
	icon_state = "waffles"
	icon = 'icons/obj/items/food/bakery.dmi'
	trash = /obj/item/trash/waffles
	filling_color = "#E6DEB5"

/obj/item/reagent_container/food/snacks/waffles/Initialize()
	. = ..()
	reagents.add_reagent("bread", 5)
	reagents.add_reagent("sugar", 3)
	bitesize = 2

/obj/item/reagent_container/food/snacks/pancakes
	name = "pancakes"
	desc = "刚从烤盘上取出的金棕色奶油煎饼。淋上枫糖浆，顶部放一片黄油。"
	icon_state = "pancakes"
	icon = 'icons/obj/items/food/bakery.dmi'
	filling_color = "#bb9857"
	bitesize = 2

/obj/item/reagent_container/food/snacks/pancakes/Initialize()
	. = ..()
	reagents.add_reagent("bread", 6)
	reagents.add_reagent("sugar", 4)
	reagents.add_reagent("milk", 5)

/obj/item/reagent_container/food/snacks/eggplantparm
	name = "帕尔马干酪烤茄子"
	desc = "茄子唯一的好食谱。"
	icon_state = "eggplantparm"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#4D2F5E"

/obj/item/reagent_container/food/snacks/eggplantparm/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 4)
	reagents.add_reagent("cheese", 2)
	bitesize = 2

/obj/item/reagent_container/food/snacks/soylentgreen
	name = "绿色索伦"
	desc = "不是用人做的。真的。" //Totally people.
	icon_state = "soylent_green"
	icon = 'icons/obj/items/food/bakery.dmi'
	trash = /obj/item/trash/waffles
	filling_color = "#B8E6B5"

/obj/item/reagent_container/food/snacks/soylentgreen/Initialize()
	. = ..()
	reagents.add_reagent("bread", 7)
	reagents.add_reagent("meatprotein", 3)
	bitesize = 2

/obj/item/reagent_container/food/snacks/soylentviridians
	name = "维迪安索伦"
	desc = "不是用人做的。真的。" //Actually honest for once.
	icon_state = "soylent_yellow"
	icon = 'icons/obj/items/food/bakery.dmi'
	trash = /obj/item/trash/waffles
	filling_color = "#E6FA61"

/obj/item/reagent_container/food/snacks/soylentviridians/Initialize()
	. = ..()
	reagents.add_reagent("bread", 10)
	bitesize = 2

/obj/item/reagent_container/food/snacks/meatpie
	name = "肉馅饼"
	desc = "一个老理发师的食谱，非常美味！"
	icon_state = "meatpie"
	icon = 'icons/obj/items/food/bakery.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#948051"

/obj/item/reagent_container/food/snacks/meatpie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 6)
	reagents.add_reagent("meatprotein", 4)
	bitesize = 2

/obj/item/reagent_container/food/snacks/tofupie
	name = "豆腐馅饼"
	desc = "美味的豆腐馅饼。"
	icon_state = "meatpie"
	icon = 'icons/obj/items/food/bakery.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#FFFEE0"

/obj/item/reagent_container/food/snacks/tofupie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 6)
	reagents.add_reagent("tofu", 4)
	bitesize = 2

/obj/item/reagent_container/food/snacks/amanita_pie
	name = "毒蝇伞派"
	desc = "香甜可口的毒派。"
	icon_state = "amanita_pie"
	icon = 'icons/obj/items/food/bakery.dmi'
	filling_color = "#FFCCCC"

/obj/item/reagent_container/food/snacks/amanita_pie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 5)
	reagents.add_reagent("amatoxin", 3)
	reagents.add_reagent("psilocybin", 1)
	bitesize = 3

/obj/item/reagent_container/food/snacks/plump_pie
	name = "肥菇派"
	desc = "我打赌你喜欢肥菇头盔做的东西！"
	icon_state = "plump_pie"
	icon = 'icons/obj/items/food/bakery.dmi'
	filling_color = "#B8279B"

/obj/item/reagent_container/food/snacks/plump_pie/Initialize()
	. = ..()
	if(prob(10))
		name = "极品肥菇派"
		desc = "微波炉被精灵附体了！它做出了一个极品肥菇派！"
		reagents.add_reagent("bread", 4)
		reagents.add_reagent("mushroom", 4)
		reagents.add_reagent("tricordrazine", 5)
		bitesize = 2
	else
		reagents.add_reagent("mushroom", 4)
		reagents.add_reagent("nutriment", 4)
		bitesize = 2

/obj/item/reagent_container/food/snacks/xemeatpie
	name = "异形派"
	desc = "美味的肉派。可能属于异端。"
	icon_state = "xenomeatpie"
	icon = 'icons/obj/items/food/bakery.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#43DE18"

/obj/item/reagent_container/food/snacks/xemeatpie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 4)
	reagents.add_reagent("meatprotein", 2)
	bitesize = 2

/obj/item/reagent_container/food/snacks/wingfangchu
	name = "钟芳翅"
	desc = "一道用酱油烹制的风味外星翅肉。"
	icon_state = "wingfangchu"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#43DE18"

/obj/item/reagent_container/food/snacks/wingfangchu/Initialize()
	. = ..()
	reagents.add_reagent("soysauce", 4)
	reagents.add_reagent("meatprotein", 4)
	bitesize = 2

/obj/item/reagent_container/food/snacks/human/kabob
	name = "kabob"
	desc = "人肉串。"
	icon_state = "kabob"
	icon = 'icons/obj/items/food/meat.dmi'
	trash = /obj/item/stack/rods
	filling_color = "#A85340"

/obj/item/reagent_container/food/snacks/human/kabob/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 8)
	bitesize = 2

/obj/item/reagent_container/food/snacks/monkeykabob
	name = "烤肉串"
	desc = "美味的肉，串在签子上。"
	icon_state = "kabob"
	icon = 'icons/obj/items/food/meat.dmi'
	trash = /obj/item/stack/rods
	filling_color = "#A85340"

/obj/item/reagent_container/food/snacks/monkeykabob/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 8)
	bitesize = 2

/obj/item/reagent_container/food/snacks/tofukabob
	name = "豆腐串"
	desc = "素食肉，串在签子上。"
	icon_state = "kabob"
	icon = 'icons/obj/items/food/meat.dmi'
	trash = /obj/item/stack/rods
	filling_color = "#FFFEE0"

/obj/item/reagent_container/food/snacks/tofukabob/Initialize()
	. = ..()
	reagents.add_reagent("tofu", 8)
	bitesize = 2

/obj/item/reagent_container/food/snacks/cubancarp
	name = "古巴鲤鱼三明治"
	desc = "一个恶作剧般的三明治，先灼烧你的舌头，然后让它麻木！"
	icon_state = "cubancarp"
	icon = 'icons/obj/items/food/fish.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#E9ADFF"

/obj/item/reagent_container/food/snacks/cubancarp/Initialize()
	. = ..()
	reagents.add_reagent("fish", 6)
	reagents.add_reagent("hotsauce", 3)
	bitesize = 3

/obj/item/reagent_container/food/snacks/popcorn
	name = "爆米花"
	desc = "电影院风格的黄油爆米花。现在得找部电影边看边吃。"
	icon_state = "popcorn"
	trash = /obj/item/trash/popcorn
	var/unpopped = 0
	filling_color = "#FFFAD4"

/obj/item/reagent_container/food/snacks/popcorn/Initialize()
	. = ..()
	unpopped = rand(1,10)
	reagents.add_reagent("plantmatter", 2)
	AddElement(/datum/element/corp_label/wy)
	bitesize = 0.1 //this snack is supposed to be eating during looooong time. And this it not dinner food! --rastaf0

/obj/item/reagent_container/food/snacks/popcorn/On_Consume()
	if(prob(unpopped)) //lol ...what's the point?
		to_chat(usr, SPAN_DANGER("你咬到了一个没爆开的玉米粒！"))
		unpopped = max(0, unpopped-1)
	..()

/obj/item/reagent_container/food/snacks/sosjerky
	name = "胆小鬼私藏牛肉干"
	desc = "用最优质太空牛肉制成的牛肉干。"
	icon_state = "sosjerky"
	trash = /obj/item/trash/sosjerky
	filling_color = "#631212"

/obj/item/reagent_container/food/snacks/sosjerky/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 4)
	bitesize = 2

/obj/item/reagent_container/food/snacks/no_raisin
	name = "4no葡萄干"
	icon_state = "4no_raisins"
	desc = "全宇宙最好的葡萄干。不知道为什么。"
	trash = /obj/item/trash/raisins
	filling_color = "#343834"

/obj/item/reagent_container/food/snacks/no_raisin/Initialize()
	. = ..()
	reagents.add_reagent("fruit", 4)
	reagents.add_reagent("grapejuice", 2)

/obj/item/reagent_container/food/snacks/spacetwinkie
	name = "太空夹心蛋糕"
	icon_state = "space_twinkie"
	desc = "保证比你活得更久。"
	filling_color = "#FFE591"

/obj/item/reagent_container/food/snacks/spacetwinkie/Initialize()
	. = ..()
	reagents.add_reagent("sugar", 4)
	bitesize = 2

/obj/item/reagent_container/food/snacks/cheesiehonkers
	name = "奇西喇叭饼"
	icon_state = "cheesie_honkers"
	desc = "一口大小的芝士零食，让你的嘴巴充满浓郁风味。"
	trash = /obj/item/trash/cheesie
	filling_color = "#FFA305"

/obj/item/reagent_container/food/snacks/cheesiehonkers/Initialize()
	. = ..()
	reagents.add_reagent("cheese", 4)
	bitesize = 2

/obj/item/reagent_container/food/snacks/syndicake
	name = "辛迪蛋糕"
	icon_state = "syndi_cakes"
	desc = "一款极其湿润的零食蛋糕，即使加热后味道也一样好。"
	filling_color = "#FF5D05"
	trash = /obj/item/trash/syndi_cakes

/obj/item/reagent_container/food/snacks/syndicake/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 4)
	reagents.add_reagent("doctorsdelight", 5)
	bitesize = 3

/obj/item/reagent_container/food/snacks/loadedbakedpotato
	name = "满载烤土豆"
	desc = "完全烤透了。"
	icon_state = "loadedbakedpotato"
	icon = 'icons/obj/items/food/dishes.dmi'
	filling_color = "#9C7A68"

/obj/item/reagent_container/food/snacks/loadedbakedpotato/Initialize()
	. = ..()
	reagents.add_reagent("potato", 2)
	reagents.add_reagent("cheese", 4)
	bitesize = 2

/obj/item/reagent_container/food/snacks/fries
	name = "太空薯条"
	desc = "又名：法式薯条、自由薯条等。"
	icon_state = "fries"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#EDDD00"

/obj/item/reagent_container/food/snacks/fries/Initialize()
	. = ..()
	reagents.add_reagent("potato", 2)
	reagents.add_reagent("vegetable", 4)
	bitesize = 2

/obj/item/reagent_container/food/snacks/soydope
	name = "大豆糊"
	desc = "来自大豆的糊状物。"
	icon_state = "soydope"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#C4BF76"

/obj/item/reagent_container/food/snacks/soydope/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 2)
	bitesize = 2

/obj/item/reagent_container/food/snacks/spagetti
	name = "意大利面"
	desc = "一捆生的意大利面。"
	icon_state = "spagetti"
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	filling_color = "#EDDD00"

/obj/item/reagent_container/food/snacks/spagetti/Initialize()
	. = ..()
	reagents.add_reagent("dough", 1)

/obj/item/reagent_container/food/snacks/cheesyfries
	name = "芝士薯条"
	desc = "薯条。覆盖着芝士。显而易见。"
	icon_state = "cheesyfries"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#EDDD00"

/obj/item/reagent_container/food/snacks/cheesyfries/Initialize()
	. = ..()
	reagents.add_reagent("cheese", 4)
	reagents.add_reagent("potato", 2)
	bitesize = 2

/obj/item/reagent_container/food/snacks/badrecipe
	name = "烧焦的烂摊子"
	desc = "有人该为这个被降职，别当厨师了。"
	icon_state = "badrecipe"
	icon = 'icons/obj/items/food/dishes.dmi'
	filling_color = "#211F02"

/obj/item/reagent_container/food/snacks/badrecipe/Initialize()
	. = ..()
	reagents.add_reagent("toxin", 1)
	reagents.add_reagent("carbon", 3)
	bitesize = 2

/obj/item/reagent_container/food/snacks/meatsteak
	name = "steak"
	desc = "一块上好的烤肉排，用盐和胡椒调味。至于肉的来源嘛，嗯，最好还是别问了。"
	icon_state = "meatstake"
	icon = 'icons/obj/items/food/meat.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#7A3D11"

/obj/item/reagent_container/food/snacks/meatsteak/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 4)
	reagents.add_reagent("sodiumchloride", 1)
	reagents.add_reagent("blackpepper", 1)
	bitesize = 3

/obj/item/reagent_container/food/snacks/spacylibertyduff
	name = "太空自由达夫"
	desc = "果冻，源自阿尔弗雷德·哈伯德的食谱。"
	icon_state = "spacylibertyduff"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#42B873"

/obj/item/reagent_container/food/snacks/spacylibertyduff/Initialize()
	. = ..()
	reagents.add_reagent("mushroom", 6)
	reagents.add_reagent("psilocybin", 6)
	bitesize = 3

/obj/item/reagent_container/food/snacks/amanitajelly
	name = "毒蝇伞果冻"
	desc = "看起来有种可疑的毒性。"
	icon_state = "amanitajelly"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#ED0758"

/obj/item/reagent_container/food/snacks/amanitajelly/Initialize()
	. = ..()
	reagents.add_reagent("mushroom", 6)
	reagents.add_reagent("amatoxin", 6)
	reagents.add_reagent("psilocybin", 3)
	bitesize = 3

/obj/item/reagent_container/food/snacks/poppypretzel
	name = "罂粟椒盐卷饼"
	desc = "它完全扭曲了！"
	icon_state = "poppypretzel"
	icon = 'icons/obj/items/food/bakery.dmi'
	bitesize = 2
	filling_color = "#916E36"

/obj/item/reagent_container/food/snacks/poppypretzel/Initialize()
	. = ..()
	reagents.add_reagent("plantmatter", 1)
	reagents.add_reagent("bread", 4)
	bitesize = 2

/obj/item/reagent_container/food/snacks/meatballsoup
	name = "肉丸汤"
	desc = "小子，你有种，真有胆量！"
	icon_state = "meatballsoup"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#785210"

/obj/item/reagent_container/food/snacks/meatballsoup/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 8)
	reagents.add_reagent("water", 5)
	bitesize = 5

/obj/item/reagent_container/food/snacks/bloodsoup
	name = "番茄汤"
	desc = "闻起来有股铜腥味。"
	icon_state = "tomatosoup"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	filling_color = COLOR_RED

/obj/item/reagent_container/food/snacks/bloodsoup/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 2)
	reagents.add_reagent("blood", 10)
	reagents.add_reagent("water", 5)
	bitesize = 5

/obj/item/reagent_container/food/snacks/clownstears
	name = "小丑的眼泪"
	desc = "不怎么好笑。"
	icon_state = "clownstears"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	filling_color = "#C4FBFF"

/obj/item/reagent_container/food/snacks/clownstears/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 4)
	reagents.add_reagent("banana", 5)
	reagents.add_reagent("water", 10)
	bitesize = 5

/obj/item/reagent_container/food/snacks/vegetablesoup
	name = "蔬菜汤"
	desc = "一顿真正的素食餐。"
	icon_state = "vegetablesoup"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#AFC4B5"

/obj/item/reagent_container/food/snacks/vegetablesoup/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 8)
	reagents.add_reagent("water", 5)
	bitesize = 5

/obj/item/reagent_container/food/snacks/nettlesoup
	name = "荨麻汤"
	desc = "想想看，植物学家可能会用这东西打死你。"
	icon_state = "nettlesoup"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#AFC4B5"

/obj/item/reagent_container/food/snacks/nettlesoup/Initialize()
	. = ..()
	reagents.add_reagent("plantmatter", 8)
	reagents.add_reagent("water", 5)
	reagents.add_reagent("tricordrazine", 5)
	bitesize = 5

/obj/item/reagent_container/food/snacks/mysterysoup
	name = "神秘汤"
	desc = "神秘之处在于，你为什么不吃？"
	icon_state = "mysterysoup"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#F082FF"

/obj/item/reagent_container/food/snacks/mysterysoup/Initialize()
	. = ..()
	var/mysteryselect = pick(1,2,3,4,5,6,7,8,9)
	switch(mysteryselect)
		if(1)
			reagents.add_reagent("plantmatter", 6)
			reagents.add_reagent("hotsauce", 3)
			reagents.add_reagent("tomatojuice", 2)
		if(2)
			reagents.add_reagent("plantmatter", 6)
			reagents.add_reagent("frostoil", 3)
			reagents.add_reagent("tomatojuice", 2)
		if(3)
			reagents.add_reagent("nutriment", 5)
			reagents.add_reagent("water", 5)
			reagents.add_reagent("tricordrazine", 5)
		if(4)
			reagents.add_reagent("nutriment", 5)
			reagents.add_reagent("water", 10)
		if(5)
			reagents.add_reagent("fruit", 2)
			reagents.add_reagent("banana", 10)
		if(6)
			reagents.add_reagent("meatprotein", 6)
			reagents.add_reagent("blood", 10)
		if(7)
			reagents.add_reagent("carbon", 10)
			reagents.add_reagent("toxin", 10)
		if(8)
			reagents.add_reagent("vegetable", 5)
			reagents.add_reagent("tomatojuice", 10)
		if(9)
			reagents.add_reagent("nutriment", 6)
			reagents.add_reagent("tomatojuice", 5)
			reagents.add_reagent("imidazoline", 5)
	bitesize = 5

/obj/item/reagent_container/food/snacks/wishsoup
	name = "愿望汤"
	desc = "我真希望这是汤。"
	icon_state = "wishsoup"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#D1F4FF"

/obj/item/reagent_container/food/snacks/wishsoup/Initialize()
	. = ..()
	reagents.add_reagent("water", 10)
	bitesize = 5
	if(prob(25))
		src.desc = "A wish come true!"
		reagents.add_reagent("nutriment", 8)

/obj/item/reagent_container/food/snacks/hotchili
	name = "辣味辣椒"
	desc = "五级警报的德克萨斯辣椒！"
	icon_state = "hotchili"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#FF3C00"

/obj/item/reagent_container/food/snacks/hotchili/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 6)
	reagents.add_reagent("hotsauce", 3)
	reagents.add_reagent("tomatojuice", 2)
	bitesize = 5

/obj/item/reagent_container/food/snacks/coldchili
	name = "冷辣椒"
	desc = "这糊状物几乎算不上液体！"
	icon_state = "coldchili"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	filling_color = "#2B00FF"

	trash = /obj/item/trash/snack_bowl

/obj/item/reagent_container/food/snacks/coldchili/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 6)
	reagents.add_reagent("frostoil", 3)
	reagents.add_reagent("tomatojuice", 2)
	bitesize = 5

/obj/item/reagent_container/food/snacks/monkeycube
	name = "猴子方块"
	desc = "只需加水！"
	icon_state = "monkeycube"
	icon = 'icons/obj/items/food/monkeycubes.dmi'
	bitesize = 12
	filling_color = "#ADAC7F"
	black_market_value = 25
	var/monkey_type = /mob/living/carbon/human/monkey

/obj/item/reagent_container/food/snacks/monkeycube/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein",10)

/obj/item/reagent_container/food/snacks/monkeycube/afterattack(obj/O, mob/user, proximity)
	if(!proximity)
		return
	if(istype(O,/obj/structure/sink) && !package)
		to_chat(user, "你将\the [name]放在水流下...")
		user.drop_held_item()
		return Expand()
	..()

/obj/item/reagent_container/food/snacks/monkeycube/attack_self(mob/user)
	..()

	if(package)
		icon_state = "monkeycube"
		desc = "只需加水！"
		to_chat(user, "你拆开了方块包装。")
		package = 0

/obj/item/reagent_container/food/snacks/monkeycube/On_Consume(mob/M)
	to_chat(M, SPAN_WARNING("你体内的某个东西突然膨胀了！"))

	if (istype(M, /mob/living/carbon/human))
		//Do not try to understand.
		var/obj/item/surprise = new(M)
		var/mob/ook = monkey_type
		surprise.icon = initial(ook.icon)
		surprise.icon_state = initial(ook.icon_state)
		surprise.name = "malformed [initial(ook.name)]"
		surprise.desc = "Looks like \a very deformed [initial(ook.name)], a little small for its kind. It shows no signs of life."
		surprise.transform *= 0.6
		surprise.add_mob_blood(M)
		var/mob/living/carbon/human/H = M
		var/obj/limb/E = H.get_limb("chest")
		E.fracture(100)
		H.recalculate_move_delay = TRUE
		for (var/datum/internal_organ/I in E.internal_organs)
			I.take_damage(rand(I.min_bruised_damage, I.min_broken_damage+1))
		if (!E.hidden && prob(60)) //set it snuggly
			E.hidden = surprise
		else //someone is having a bad day
			E.createwound(CUT, 30)
			E.embed(surprise)
	..()

/obj/item/reagent_container/food/snacks/monkeycube/proc/Expand()
	for(var/mob/M as anything in viewers(src,7))
		to_chat(M, SPAN_WARNING("\The [src] expands!"))
	var/turf/T = get_turf(src)
	if(T)
		new monkey_type(T)
	qdel(src)

/obj/item/reagent_container/food/snacks/monkeycube/extinguish()
	. = ..()
	if(!package)
		Expand()

/obj/item/reagent_container/food/snacks/monkeycube/wrapped
	desc = "仍然用纸包裹着。"
	icon_state = "monkeycubewrap"
	package = 1

/obj/item/reagent_container/food/snacks/monkeycube/farwacube
	name = "法瓦方块"
	monkey_type = /mob/living/carbon/human/farwa
/obj/item/reagent_container/food/snacks/monkeycube/wrapped/farwacube
	name = "法瓦方块"
	monkey_type =/mob/living/carbon/human/farwa

/obj/item/reagent_container/food/snacks/monkeycube/stokcube
	name = "斯托克方块"
	monkey_type = /mob/living/carbon/human/stok
/obj/item/reagent_container/food/snacks/monkeycube/wrapped/stokcube
	name = "斯托克方块"
	monkey_type =/mob/living/carbon/human/stok

/obj/item/reagent_container/food/snacks/monkeycube/neaeracube
	name = "尼埃拉方块"
	monkey_type = /mob/living/carbon/human/neaera
/obj/item/reagent_container/food/snacks/monkeycube/wrapped/neaeracube
	name = "尼埃拉方块"
	monkey_type =/mob/living/carbon/human/neaera

/obj/item/reagent_container/food/snacks/monkeycube/yirencube
	name = "伊伦方块"
	monkey_type = /mob/living/carbon/human/yiren
/obj/item/reagent_container/food/snacks/monkeycube/wrapped/yirencube
	name = "伊伦方块"
	monkey_type =/mob/living/carbon/human/yiren

/obj/item/reagent_container/food/snacks/spellburger
	name = "咒术汉堡"
	desc = "这绝对是艾·纳特。"
	icon_state = "spellburger"
	icon = 'icons/obj/items/food/burgers.dmi'
	filling_color = "#D505FF"

/obj/item/reagent_container/food/snacks/spellburger/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 6)
	bitesize = 2

/obj/item/reagent_container/food/snacks/bigbiteburger
	name = "巨无霸汉堡"
	desc = "忘掉巨无霸吧。这才是未来！"
	icon_state = "bigbiteburger"
	icon = 'icons/obj/items/food/burgers.dmi'
	filling_color = "#E3D681"

/obj/item/reagent_container/food/snacks/bigbiteburger/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 7)
	reagents.add_reagent("bread", 7)
	bitesize = 3

/obj/item/reagent_container/food/snacks/enchiladas
	name = "墨西哥卷饼"
	desc = "墨西哥万岁！"
	icon_state = "enchiladas"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/tray
	filling_color = "#A36A1F"

/obj/item/reagent_container/food/snacks/enchiladas/Initialize()
	. = ..()
	reagents.add_reagent("vegetable",2)
	reagents.add_reagent("meatprotein", 4)
	reagents.add_reagent("hotsauce", 6)
	bitesize = 4

/obj/item/reagent_container/food/snacks/monkeysdelight
	name = "猴子的喜悦"
	desc = "咿咿咿！"
	icon_state = "monkeysdelight"
	icon = 'icons/obj/items/food/meat.dmi'
	trash = /obj/item/trash/tray
	filling_color = "#5C3C11"

/obj/item/reagent_container/food/snacks/monkeysdelight/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 10)
	reagents.add_reagent("banana", 5)
	reagents.add_reagent("blackpepper", 1)
	reagents.add_reagent("sodiumchloride", 1)
	bitesize = 6

/obj/item/reagent_container/food/snacks/baguette
	name = "法棍面包"
	desc = "祝你好胃口！"
	icon_state = "baguette"
	icon = 'icons/obj/items/food/bread.dmi'
	filling_color = "#E3D796"

/obj/item/reagent_container/food/snacks/baguette/Initialize()
	. = ..()
	reagents.add_reagent("bread", 6)
	reagents.add_reagent("blackpepper", 1)
	reagents.add_reagent("sodiumchloride", 1)
	bitesize = 3

/obj/item/reagent_container/food/snacks/fishandchips
	name = "炸鱼薯条"
	desc = "我自己也这么说，老兄。"
	icon_state = "fishandchips"
	icon = 'icons/obj/items/food/fish.dmi'
	filling_color = "#E3D796"

/obj/item/reagent_container/food/snacks/fishandchips/Initialize()
	. = ..()
	reagents.add_reagent("fish", 6)
	bitesize = 3

/obj/item/reagent_container/food/snacks/sandwich
	name = "三明治"
	desc = "肉、奶酪、面包和几片生菜组成的伟大创造！亚瑟·邓特会为此骄傲。"
	icon_state = "sandwich"
	icon = 'icons/obj/items/food/bread.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#D9BE29"

/obj/item/reagent_container/food/snacks/sandwich/Initialize()
	. = ..()
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("cheese", 2)
	reagents.add_reagent("meatprotein", 2)
	bitesize = 2

/obj/item/reagent_container/food/snacks/toastedsandwich
	name = "烤三明治"
	desc = "现在要是再来根胡椒棒就好了。"
	icon_state = "toastedsandwich"
	icon = 'icons/obj/items/food/bread.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#D9BE29"

/obj/item/reagent_container/food/snacks/toastedsandwich/Initialize()
	. = ..()
	reagents.add_reagent("bread", 6)
	reagents.add_reagent("carbon", 2)
	bitesize = 2

/obj/item/reagent_container/food/snacks/grilledcheese
	name = "烤奶酪三明治"
	desc = "和番茄汤是绝配！"
	icon_state = "toastedsandwich"
	icon = 'icons/obj/items/food/bread.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#D9BE29"

/obj/item/reagent_container/food/snacks/grilledcheese/Initialize()
	. = ..()
	reagents.add_reagent("bread", 4)
	reagents.add_reagent("cheese", 3)
	bitesize = 2

/obj/item/reagent_container/food/snacks/tomatosoup
	name = "番茄汤"
	desc = "喝这个感觉就像变成了吸血鬼！一个番茄吸血鬼……"
	icon_state = "tomatosoup"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#D92929"

/obj/item/reagent_container/food/snacks/tomatosoup/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 5)
	reagents.add_reagent("tomatojuice", 10)
	bitesize = 3

/obj/item/reagent_container/food/snacks/rofflewaffles
	name = "罗夫华夫饼"
	desc = "来自罗夫公司的华夫饼。"
	icon_state = "rofflewaffles"
	icon = 'icons/obj/items/food/bakery.dmi'
	trash = /obj/item/trash/waffles
	filling_color = "#FF00F7"

/obj/item/reagent_container/food/snacks/rofflewaffles/Initialize()
	. = ..()
	reagents.add_reagent("bread", 8)
	reagents.add_reagent("psilocybin", 8)
	bitesize = 4

/obj/item/reagent_container/food/snacks/stew
	name = "炖菜"
	desc = "一份美味温热的炖菜。健康又强身。"
	icon_state = "stew"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	filling_color = "#9E673A"

/obj/item/reagent_container/food/snacks/stew/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 4)
	reagents.add_reagent("meatprotein", 3)
	reagents.add_reagent("mushroom", 3)
	reagents.add_reagent("tomatojuice", 5)
	reagents.add_reagent("imidazoline", 5)
	reagents.add_reagent("water", 5)
	bitesize = 10

/obj/item/reagent_container/food/snacks/jelliedtoast
	name = "果酱吐司"
	desc = "一片涂满美味果酱的面包。"
	icon_state = "jellytoast"
	icon = 'icons/obj/items/food/bread.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#B572AB"

/obj/item/reagent_container/food/snacks/jelliedtoast/Initialize()
	. = ..()
	reagents.add_reagent("bread", 1)
	bitesize = 3

/obj/item/reagent_container/food/snacks/jelliedtoast/cherry

/obj/item/reagent_container/food/snacks/jelliedtoast/cherry/Initialize()
	. = ..()
	reagents.add_reagent("cherryjelly", 5)

/obj/item/reagent_container/food/snacks/jellyburger
	name = "果冻汉堡"
	desc = "烹饪界的享受..？"
	icon_state = "jellyburger"
	icon = 'icons/obj/items/food/burgers.dmi'
	filling_color = "#B572AB"

/obj/item/reagent_container/food/snacks/jellyburger/Initialize()
	. = ..()
	reagents.add_reagent("bread", 5)
	bitesize = 2

/obj/item/reagent_container/food/snacks/jellyburger/cherry

/obj/item/reagent_container/food/snacks/jellyburger/cherry/Initialize()
	. = ..()
	reagents.add_reagent("cherryjelly", 5)

/obj/item/reagent_container/food/snacks/milosoup
	name = "米洛汤"
	desc = "全宇宙最好的汤！美味！！！"
	icon_state = "milosoup"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl

/obj/item/reagent_container/food/snacks/milosoup/Initialize()
	. = ..()
	reagents.add_reagent("tofu", 8)
	reagents.add_reagent("water", 5)
	bitesize = 4

/obj/item/reagent_container/food/snacks/stewedsoymeat
	name = "炖素肉"
	desc = "就连非素食者也会爱上它！"
	icon_state = "stewedsoymeat"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/plate

/obj/item/reagent_container/food/snacks/stewedsoymeat/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 8)
	bitesize = 2

/obj/item/reagent_container/food/snacks/boiledspagetti
	name = "水煮意面"
	desc = "一盘寡淡的面条，真差劲。"
	icon_state = "spagettiboiled"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#FCEE81"

/obj/item/reagent_container/food/snacks/boiledspagetti/Initialize()
	. = ..()
	reagents.add_reagent("noodles", 2)
	bitesize = 2

/obj/item/reagent_container/food/snacks/boiledrice
	name = "白米饭"
	desc = "一碗无聊的米饭，无聊的菜。"
	icon_state = "boiledrice"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#FFFBDB"

/obj/item/reagent_container/food/snacks/boiledrice/Initialize()
	. = ..()
	reagents.add_reagent("rice", 2)
	bitesize = 2

/obj/item/reagent_container/food/snacks/ricepudding
	name = "米布丁"
	desc = "果酱在哪儿！"
	icon_state = "rpudding"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#FFFBDB"

/obj/item/reagent_container/food/snacks/ricepudding/Initialize()
	. = ..()
	reagents.add_reagent("rice", 3)
	reagents.add_reagent("milk", 1)
	bitesize = 2

/obj/item/reagent_container/food/snacks/pastatomato
	name = "意大利面"
	desc = "意面和碎番茄。就像你那虐待成性的老爹以前做的那样！"
	icon_state = "pastatomato"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#DE4545"

/obj/item/reagent_container/food/snacks/pastatomato/Initialize()
	. = ..()
	reagents.add_reagent("noodles", 6)
	reagents.add_reagent("tomatojuice", 10)
	bitesize = 4

/obj/item/reagent_container/food/snacks/meatballspagetti
	name = "意面肉丸"
	desc = "这才叫好肉丸！"
	icon_state = "meatballspagetti"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#DE4545"

/obj/item/reagent_container/food/snacks/meatballspagetti/Initialize()
	. = ..()
	reagents.add_reagent("noodles", 4)
	reagents.add_reagent("meatprotein", 4)
	bitesize = 2

/obj/item/reagent_container/food/snacks/spesslaw
	name = "太空法条"
	desc = "律师的最爱。"
	icon_state = "spesslaw"
	icon = 'icons/obj/items/food/dishes.dmi'
	filling_color = "#DE4545"

/obj/item/reagent_container/food/snacks/spesslaw/Initialize()
	. = ..()
	reagents.add_reagent("noodles", 6)
	reagents.add_reagent("meatprotein", 6)
	bitesize = 2

/obj/item/reagent_container/food/snacks/carrotfries
	name = "胡萝卜薯条"
	desc = "用新鲜胡萝卜制成的美味薯条。"
	icon_state = "carrotfries"
	icon = 'icons/obj/items/food/dishes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#FAA005"

/obj/item/reagent_container/food/snacks/carrotfries/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 3)
	reagents.add_reagent("imidazoline", 3)
	bitesize = 2

/obj/item/reagent_container/food/snacks/superbiteburger
	name = "超级一口堡"
	desc = "这是一座汉堡山。食物！"
	icon_state = "superbiteburger"
	icon = 'icons/obj/items/food/burgers.dmi'
	filling_color = "#CCA26A"

/obj/item/reagent_container/food/snacks/superbiteburger/Initialize()
	. = ..()
	reagents.add_reagent("bread", 20)
	reagents.add_reagent("meatprotein", 10)
	reagents.add_reagent("egg", 5)
	reagents.add_reagent("sodiumchloride", 2)
	reagents.add_reagent("blackpepper", 3)
	reagents.add_reagent("cheese", 10)
	reagents.add_reagent("tomatojuice", 10)
	bitesize = 10

/obj/item/reagent_container/food/snacks/candiedapple
	name = "糖衣苹果"
	desc = "一个裹着糖衣的甜美苹果。"
	icon_state = "candiedapple"
	icon = 'icons/obj/items/food/candies.dmi'
	filling_color = "#F21873"

/obj/item/reagent_container/food/snacks/candiedapple/Initialize()
	. = ..()
	reagents.add_reagent("fruit", 3)
	reagents.add_reagent("sugar", 3)
	bitesize = 3

/obj/item/reagent_container/food/snacks/applepie
	name = "苹果派"
	desc = "一个馅饼，里面充满了甜蜜的爱……或者是苹果。"
	icon_state = "applepie"
	icon = 'icons/obj/items/food/bakery.dmi'
	filling_color = "#E0EDC5"

/obj/item/reagent_container/food/snacks/applepie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("fruit", 3)
	reagents.add_reagent("sugar", 3)
	bitesize = 3


/obj/item/reagent_container/food/snacks/cherrypie
	name = "樱桃派"
	desc = "美味到让硬汉落泪。"
	icon_state = "cherrypie"
	icon = 'icons/obj/items/food/bakery.dmi'
	filling_color = "#FF525A"

/obj/item/reagent_container/food/snacks/cherrypie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("cherryjelly", 3)
	reagents.add_reagent("sugar", 3)
	bitesize = 3

/obj/item/reagent_container/food/snacks/twobread
	name = "双份面包"
	desc = "它非常苦涩，带有酒味。"
	icon_state = "twobread"
	icon = 'icons/obj/items/food/bread.dmi'
	filling_color = "#DBCC9A"

/obj/item/reagent_container/food/snacks/twobread/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("wine", 3)
	bitesize = 3

/obj/item/reagent_container/food/snacks/jellysandwich
	name = "果冻三明治"
	desc = "你多希望有点花生酱来配这个……"
	icon_state = "jellysandwich"
	icon = 'icons/obj/items/food/bread.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#9E3A78"

/obj/item/reagent_container/food/snacks/jellysandwich/Initialize()
	. = ..()
	reagents.add_reagent("bread", 2)
	bitesize = 3

/obj/item/reagent_container/food/snacks/jellysandwich/cherry

/obj/item/reagent_container/food/snacks/jellysandwich/cherry/Initialize()
	. = ..()
	reagents.add_reagent("cherryjelly", 5)

/obj/item/reagent_container/food/snacks/mint
	name = "mint"
	desc = "它薄如威化。"
	icon_state = "mint"
	icon = 'icons/obj/items/food/dishes.dmi'
	filling_color = "#F2F2F2"

/obj/item/reagent_container/food/snacks/mint/Initialize()
	. = ..()
	reagents.add_reagent("minttoxin", 1)

/obj/item/reagent_container/food/snacks/mushroomsoup
	name = "鸡油菌汤"
	desc = "一道美味丰盛的蘑菇汤。"
	icon_state = "mushroomsoup"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#E386BF"

/obj/item/reagent_container/food/snacks/mushroomsoup/Initialize()
	. = ..()
	reagents.add_reagent("mushroom", 6)
	reagents.add_reagent("milk", 2)
	bitesize = 3

/obj/item/reagent_container/food/snacks/plumphelmetbiscuit
	name = "肥美菌帽饼干"
	desc = "这是一块精心制作的肥美菌帽饼干。配料是切得极细的肥美菌帽和研磨精细的矮人小麦粉。"
	icon_state = "phelmbiscuit"
	icon = 'icons/obj/items/food/bakery.dmi'
	filling_color = "#CFB4C4"

/obj/item/reagent_container/food/snacks/plumphelmetbiscuit/Initialize()
	. = ..()
	if(prob(10))
		name = "极品肥美菌帽饼干"
		desc = "微波炉被一阵奇思妙想占据！它烹制出了一块极品的肥美菌帽饼干！"
		reagents.add_reagent("bread", 4)
		reagents.add_reagent("mushroom", 4)
		reagents.add_reagent("tricordrazine", 5)
		bitesize = 2
	else
		reagents.add_reagent("bread", 3)
		reagents.add_reagent("mushroom", 2)
		bitesize = 2

/obj/item/reagent_container/food/snacks/chawanmushi
	name = "chawanmushi"
	desc = "一份传奇的蛋奶冻，能让敌人化敌为友。可能太烫了，猫吃不了。"
	icon_state = "chawanmushi"
	icon = 'icons/obj/items/food/bakery.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#F0F2E4"

/obj/item/reagent_container/food/snacks/chawanmushi/Initialize()
	. = ..()
	reagents.add_reagent("egg", 2)
	reagents.add_reagent("mushroom", 2)
	reagents.add_reagent("soysauce", 1)

/obj/item/reagent_container/food/snacks/beetsoup
	name = "甜菜汤"
	desc = "等等，这词怎么拼来着..？"
	icon_state = "beetsoup"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#FAC9FF"

/obj/item/reagent_container/food/snacks/beetsoup/Initialize()
	. = ..()
	switch(rand(1,6))
		if(1)
			name = "borsch"
		if(2)
			name = "bortsch"
		if(3)
			name = "borstch"
		if(4)
			name = "borsh"
		if(5)
			name = "borshch"
		if(6)
			name = "borscht"
	reagents.add_reagent("vegetable", 8)
	bitesize = 2

/obj/item/reagent_container/food/snacks/tossedsalad
	name = "拌沙拉"
	desc = "一份像样的沙拉，基础而简单，混合着小块的胡萝卜、番茄和苹果。纯素！"
	icon_state = "herbsalad"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#76B87F"

/obj/item/reagent_container/food/snacks/tossedsalad/Initialize()
	. = ..()
	reagents.add_reagent("fruit", 4)
	reagents.add_reagent("vegetable", 4)
	bitesize = 3

/obj/item/reagent_container/food/snacks/validsalad
	name = "可疑沙拉"
	desc = "这只是一份由可疑‘香草’、肉丸和炸土豆片组成的沙拉。没什么可疑的。"
	icon_state = "validsalad"
	icon = 'icons/obj/items/food/soups_salads.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#76B87F"

/obj/item/reagent_container/food/snacks/validsalad/Initialize()
	. = ..()
	reagents.add_reagent("plantmatter", 4)
	reagents.add_reagent("meatprotein", 4)
	reagents.add_reagent("potato", 1)
	bitesize = 3

/obj/item/reagent_container/food/snacks/appletart
	name = "黄金苹果酥皮挞"
	desc = "一道美味的甜点，但它过不了金属探测器。"
	icon_state = "gappletart"
	icon = 'icons/obj/items/food/bakery.dmi'
	trash = /obj/item/trash/plate
	filling_color = COLOR_YELLOW

/obj/item/reagent_container/food/snacks/appletart/Initialize()
	. = ..()
	reagents.add_reagent("fruit", 8)
	reagents.add_reagent("gold", 5)
	bitesize = 3

/*
*Sliceable
* All the food items that can be sliced into smaller bits like Meatbread and Cheesewheels
* sliceable is just an organization type path, it doesn't have any additional code or variables tied to it.
* Make it that every big items are cut down into six smaller slice as a standart.
*/

/obj/item/reagent_container/food/snacks/sliceable
	slices_num = 6

/obj/item/reagent_container/food/snacks/sliceable/meatbread
	name = "肉面包卷"
	desc = "每一位自尊自爱的雄辩绅士的烹饪基础。"
	icon_state = "meatbread"
	icon = 'icons/obj/items/food/bread.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/meatbreadslice
	filling_color = "#FF7575"

/obj/item/reagent_container/food/snacks/sliceable/meatbread/Initialize()
	. = ..()
	reagents.add_reagent("bread", 10)
	reagents.add_reagent("meatprotein", 10)
	reagents.add_reagent("cheese", 10)
	bitesize = 2

/obj/item/reagent_container/food/snacks/meatbreadslice
	name = "肉面包切片"
	desc = "一片美味的肉面包。"
	icon_state = "meatbreadslice"
	icon = 'icons/obj/items/food/bread.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#FF7575"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/xenomeatbread
	name = "异形肉面包条"
	desc = "每一位自尊自爱的雄辩绅士的烹饪基础。额外异端。"
	icon_state = "xenomeatbread"
	icon = 'icons/obj/items/food/bread.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/xenomeatbreadslice
	filling_color = "#8AFF75"

/obj/item/reagent_container/food/snacks/sliceable/xenomeatbread/Initialize()
	. = ..()
	reagents.add_reagent("bread", 10)
	reagents.add_reagent("meatprotein", 10)
	reagents.add_reagent("cheese", 10)
	bitesize = 2

/obj/item/reagent_container/food/snacks/xenomeatbreadslice
	name = "异形肉面包切片"
	desc = "一片美味的肉面包。额外异端。"
	icon_state = "xenobreadslice"
	icon = 'icons/obj/items/food/bread.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#8AFF75"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/bananabread
	name = "香蕉坚果面包"
	desc = "一份天堂般的美味，饱腹感十足。"
	icon_state = "bananabread"
	icon = 'icons/obj/items/food/bread.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/bananabreadslice
	filling_color = "#EDE5AD"

/obj/item/reagent_container/food/snacks/sliceable/bananabread/Initialize()
	. = ..()
	reagents.add_reagent("banana", 15)
	reagents.add_reagent("bread", 15)
	reagents.add_reagent("sugar", 10)
	bitesize = 2

/obj/item/reagent_container/food/snacks/bananabreadslice
	name = "香蕉坚果面包切片"
	desc = "一片美味的香蕉面包。"
	icon_state = "bananabreadslice"
	icon = 'icons/obj/items/food/bread.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#EDE5AD"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/tofubread
	name = "豆腐面包"
	icon_state = "Like meatbread but for vegetarians. Not guaranteed to give superpowers."
	icon_state = "tofubread"
	icon = 'icons/obj/items/food/bread.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/tofubreadslice
	filling_color = "#F7FFE0"

/obj/item/reagent_container/food/snacks/sliceable/tofubread/Initialize()
	. = ..()
	reagents.add_reagent("bread", 10)
	reagents.add_reagent("tofu", 10)
	reagents.add_reagent("cheese", 10)
	bitesize = 2

/obj/item/reagent_container/food/snacks/tofubreadslice
	name = "豆腐面包切片"
	desc = "一片美味的豆腐面包。"
	icon_state = "tofubreadslice"
	icon = 'icons/obj/items/food/bread.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#F7FFE0"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/carrotcake
	name = "胡萝卜蛋糕"
	desc = "某只狡猾兔子的最爱甜点。此言不虚。"
	icon_state = "carrotcake"
	icon = 'icons/obj/items/food/cakes.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/carrotcakeslice
	filling_color = "#FFD675"

/obj/item/reagent_container/food/snacks/sliceable/carrotcake/Initialize()
	. = ..()
	reagents.add_reagent("bread", 15)
	reagents.add_reagent("vegetable", 5)
	reagents.add_reagent("sugar", 5)
	reagents.add_reagent("imidazoline", 10)
	bitesize = 2

/obj/item/reagent_container/food/snacks/carrotcakeslice
	name = "胡萝卜蛋糕切片"
	desc = "胡萝卜蛋糕的胡萝卜切片，胡萝卜对你的眼睛有好处！同样不是谎言。"
	icon_state = "carrotcake_slice"
	icon = 'icons/obj/items/food/cakes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#FFD675"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/braincake
	name = "脑蛋糕"
	desc = "一个软趴趴的蛋糕状物体。"
	icon_state = "braincake"
	icon = 'icons/obj/items/food/cakes.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/braincakeslice
	filling_color = "#E6AEDB"

/obj/item/reagent_container/food/snacks/sliceable/braincake/Initialize()
	. = ..()
	reagents.add_reagent("bread", 15)
	reagents.add_reagent("meatprotein", 10)
	reagents.add_reagent("alkysine", 10)
	bitesize = 2

/obj/item/reagent_container/food/snacks/braincakeslice
	name = "脑蛋糕切片"
	desc = "让我告诉你一些关于朊病毒的事。它们美味极了。"
	icon_state = "braincakeslice"
	icon = 'icons/obj/items/food/cakes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#E6AEDB"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/cheesecake
	name = "芝士蛋糕"
	desc = "危险地充满芝士。"
	icon_state = "cheesecake"
	icon = 'icons/obj/items/food/cakes.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/cheesecakeslice
	filling_color = "#FAF7AF"
	black_market_value = 30

/obj/item/reagent_container/food/snacks/sliceable/cheesecake/Initialize()
	. = ..()
	reagents.add_reagent("bread", 10)
	reagents.add_reagent("cheese", 15)
	bitesize = 2

/obj/item/reagent_container/food/snacks/cheesecakeslice
	name = "芝士蛋糕切片"
	desc = "一片纯粹的芝士满足感。"
	icon_state = "cheesecake_slice"
	icon = 'icons/obj/items/food/cakes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#FAF7AF"
	bitesize = 2
	black_market_value = 20

/obj/item/reagent_container/food/snacks/sliceable/plaincake
	name = "香草蛋糕"
	desc = "一个普通的蛋糕，不是谎言。"
	icon_state = "plaincake"
	icon = 'icons/obj/items/food/cakes.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/plaincakeslice
	filling_color = "#F7EDD5"

/obj/item/reagent_container/food/snacks/sliceable/plaincake/Initialize()
	. = ..()
	reagents.add_reagent("bread", 10)
	reagents.add_reagent("sugar", 15)

/obj/item/reagent_container/food/snacks/plaincakeslice
	name = "香草蛋糕切片"
	desc = "只是一片蛋糕，足够分给每个人。"
	icon_state = "plaincake_slice"
	icon = 'icons/obj/items/food/cakes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#F7EDD5"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/orangecake
	name = "橙子蛋糕"
	desc = "添加了橙子的蛋糕。"
	icon_state = "orangecake"
	icon = 'icons/obj/items/food/cakes.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/orangecakeslice
	filling_color = "#FADA8E"

/obj/item/reagent_container/food/snacks/sliceable/orangecake/Initialize()
	. = ..()
	reagents.add_reagent("bread", 5)
	reagents.add_reagent("fruit", 5)
	reagents.add_reagent("sugar", 10)
	reagents.add_reagent("orangejuice", 10)

/obj/item/reagent_container/food/snacks/orangecakeslice
	name = "橙子蛋糕切片"
	desc = "只是一片蛋糕，足够分给每个人。"
	icon_state = "orangecake_slice"
	icon = 'icons/obj/items/food/cakes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#FADA8E"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/limecake
	name = "青柠蛋糕"
	desc = "添加了青柠的蛋糕。"
	icon_state = "limecake"
	icon = 'icons/obj/items/food/cakes.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/limecakeslice
	filling_color = "#CBFA8E"

/obj/item/reagent_container/food/snacks/sliceable/limecake/Initialize()
	. = ..()
	reagents.add_reagent("bread", 5)
	reagents.add_reagent("fruit", 5)
	reagents.add_reagent("sugar", 10)
	reagents.add_reagent("limejuice", 10)

/obj/item/reagent_container/food/snacks/limecakeslice
	name = "青柠蛋糕切片"
	desc = "只是一片蛋糕，足够分给每个人。"
	icon_state = "limecake_slice"
	icon = 'icons/obj/items/food/cakes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#CBFA8E"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/lemoncake
	name = "柠檬蛋糕"
	desc = "添加了柠檬的蛋糕。"
	icon_state = "lemoncake"
	icon = 'icons/obj/items/food/cakes.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/lemoncakeslice
	filling_color = "#FAFA8E"

/obj/item/reagent_container/food/snacks/sliceable/lemoncake/Initialize()
	. = ..()
	reagents.add_reagent("bread", 5)
	reagents.add_reagent("fruit", 5)
	reagents.add_reagent("sugar", 10)
	reagents.add_reagent("lemonjuice", 10)

/obj/item/reagent_container/food/snacks/lemoncakeslice
	name = "柠檬蛋糕切片"
	desc = "只是一片蛋糕，足够分给每个人。"
	icon_state = "lemoncake_slice"
	icon = 'icons/obj/items/food/cakes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#FAFA8E"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/chocolatecake
	name = "巧克力蛋糕"
	desc = "添加了巧克力的蛋糕。"
	icon_state = "chocolatecake"
	icon = 'icons/obj/items/food/cakes.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/chocolatecakeslice
	filling_color = "#805930"

/obj/item/reagent_container/food/snacks/sliceable/chocolatecake/Initialize()
	. = ..()
	reagents.add_reagent("bread", 10)
	reagents.add_reagent("sugar", 5)
	reagents.add_reagent("coco", 10)

/obj/item/reagent_container/food/snacks/chocolatecakeslice
	name = "巧克力蛋糕切片"
	desc = "只是一片蛋糕，足够分给每个人。"
	icon_state = "chocolatecake_slice"
	icon = 'icons/obj/items/food/cakes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#805930"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/cheesewheel
	name = "奶酪轮"
	desc = "一大轮美味的切达干酪。"
	icon_state = "cheesewheel"
	icon = 'icons/obj/items/food/cheese.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/cheesewedge
	filling_color = "#FFF700"
	black_market_value = 25 //mendoza likes cheese.

/obj/item/reagent_container/food/snacks/sliceable/cheesewheel/Initialize()
	. = ..()
	reagents.add_reagent("cheese", 20)
	bitesize = 2

/obj/item/reagent_container/food/snacks/cheesewedge
	name = "奶酪楔"
	desc = "一块美味的切达干酪楔。切下它的奶酪轮肯定没走远。"
	icon_state = "cheesewedge"
	icon = 'icons/obj/items/food/cheese.dmi'
	filling_color = "#FFF700"
	bitesize = 2
	black_market_value = 10

/obj/item/reagent_container/food/snacks/sliceable/cheesewheel/immature
	name = "未熟成奶酪轮"
	desc = "一大轮据说是美味的切达干酪，但熟成时间不够，因此味道相当糟糕。"
	slice_path = /obj/item/reagent_container/food/snacks/cheesewedge/immature

/obj/item/reagent_container/food/snacks/sliceable/cheesewheel/immature/Initialize()
	. = ..()
	reagents.add_reagent("cheese", 15)
	reagents.add_reagent("milk", 5)
	bitesize = 4

/obj/item/reagent_container/food/snacks/cheesewedge/immature
	name = "未熟成奶酪楔"
	desc = "一块未熟成的切达干酪楔，没有任何明显的好味道。切下它的奶酪轮肯定没走远。它太嫩了，你基本上可以一口吃完。"
	bitesize = 4

/obj/item/reagent_container/food/snacks/sliceable/cheesewheel/mature
	name = "熟成奶酪轮"
	desc = "一大轮美味的切达干酪，已充分陈化。"
	slice_path = /obj/item/reagent_container/food/snacks/cheesewedge/mature

/obj/item/reagent_container/food/snacks/sliceable/cheesewheel/mature/Initialize()
	. = ..()
	reagents.add_reagent("cheese", 20)
	reagents.add_reagent("sodiumchloride", 5)
	bitesize = 2

/obj/item/reagent_container/food/snacks/cheesewedge/mature
	name = "成熟干酪块"
	desc = "一块成熟的切达干酪，味道相当不错。切下它的那轮干酪应该没走远。"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/cheesewheel/verymature
	name = "陈年干酪轮"
	desc = "一大轮美味的切达干酪，已陈化很长时间，味道相当浓烈。"
	slice_path = /obj/item/reagent_container/food/snacks/cheesewedge/verymature

/obj/item/reagent_container/food/snacks/sliceable/cheesewheel/verymature/Initialize()
	. = ..()
	reagents.add_reagent("cheese", 25)
	bitesize = 2

/obj/item/reagent_container/food/snacks/cheesewedge/verymature
	name = "陈年干酪块"
	desc = "一块非常成熟的切达干酪。这块已经陈化了一段时间。切下它的那轮干酪应该没走远。"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/cheesewheel/extramature
	name = "太古干酪轮"
	desc = "一大轮美味的切达干酪，它几乎已经陈化了无数个世纪。光是看到这块干酪就让你冒出一身冷汗。由于其浓烈程度，你无法大口食用。"
	slice_path = /obj/item/reagent_container/food/snacks/cheesewedge/extramature

/obj/item/reagent_container/food/snacks/sliceable/cheesewheel/extramature/Initialize()
	. = ..()
	reagents.add_reagent("cheese", 25)
	reagents.add_reagent("sugar", 1)
	reagents.add_reagent("sodiumchloride", 1)
	reagents.add_reagent("enzyme", 1)

/obj/item/reagent_container/food/snacks/cheesewedge/extramature
	name = "太古干酪块"
	desc = "一块特级成熟的切达干酪。味道浓烈到你一次只能放几克在嘴里。切下它的那轮干酪应该没走远。"

/obj/item/reagent_container/food/snacks/sliceable/birthdaycake
	name = "生日蛋糕"
	desc = "生日快乐……"
	icon_state = "birthdaycake"
	icon = 'icons/obj/items/food/cakes.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/birthdaycakeslice
	filling_color = "#FFD6D6"

/obj/item/reagent_container/food/snacks/sliceable/birthdaycake/Initialize()
	. = ..()
	reagents.add_reagent("bread", 10)
	reagents.add_reagent("sugar", 10)
	reagents.add_reagent("sprinkles", 10)
	bitesize = 3

/obj/item/reagent_container/food/snacks/birthdaycakeslice
	name = "生日蛋糕切片"
	desc = "属于你生日的一片。"
	icon_state = "birthdaycakeslice"
	icon = 'icons/obj/items/food/cakes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#FFD6D6"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/bread
	name = "面包"
	desc = "一些普通的老式地球面包。"
	icon_state = "bread"
	icon = 'icons/obj/items/food/bread.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/breadslice
	filling_color = "#FFE396"

/obj/item/reagent_container/food/snacks/sliceable/bread/Initialize()
	. = ..()
	reagents.add_reagent("bread", 6)
	bitesize = 2

/obj/item/reagent_container/food/snacks/breadslice
	name = "面包切片"
	desc = "一片家乡的味道。"
	icon_state = "breadslice"
	icon = 'icons/obj/items/food/bread.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#D27332"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/creamcheesebread
	name = "奶油芝士面包"
	desc = "好吃好吃好吃！"
	icon_state = "creamcheesebread"
	icon = 'icons/obj/items/food/bread.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/creamcheesebreadslice
	filling_color = "#FFF896"

/obj/item/reagent_container/food/snacks/sliceable/creamcheesebread/Initialize()
	. = ..()
	reagents.add_reagent("bread", 10)
	reagents.add_reagent("cheese", 10)
	bitesize = 2

/obj/item/reagent_container/food/snacks/creamcheesebreadslice
	name = "奶油芝士面包切片"
	desc = "一片美味！"
	icon_state = "creamcheesebreadslice"
	icon = 'icons/obj/items/food/bread.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#FFF896"
	bitesize = 2

/obj/item/reagent_container/food/snacks/watermelonslice
	name = "西瓜切片"
	desc = "一片多汁的美味。"
	icon_state = "watermelonslice"
	icon = 'icons/obj/items/food/slices.dmi'
	filling_color = "#FF3867"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/applecake
	name = "苹果蛋糕"
	desc = "以苹果为中心点缀的蛋糕。"
	icon_state = "applecake"
	icon = 'icons/obj/items/food/cakes.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/applecakeslice
	filling_color = "#EBF5B8"

/obj/item/reagent_container/food/snacks/sliceable/applecake/Initialize()
	. = ..()
	reagents.add_reagent("bread", 5)
	reagents.add_reagent("fruit", 10)
	reagents.add_reagent("sugar", 10)

/obj/item/reagent_container/food/snacks/applecakeslice
	name = "苹果蛋糕切片"
	desc = "一片天堂般的美味蛋糕。"
	icon_state = "applecakeslice"
	icon = 'icons/obj/items/food/cakes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#EBF5B8"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/pumpkinpie
	name = "南瓜派"
	desc = "秋日的美味佳品。"
	icon_state = "pumpkinpie"
	icon = 'icons/obj/items/food/cakes.dmi'
	slice_path = /obj/item/reagent_container/food/snacks/pumpkinpieslice
	filling_color = "#F5B951"

/obj/item/reagent_container/food/snacks/sliceable/pumpkinpie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 5)
	reagents.add_reagent("vegetable", 5)
	reagents.add_reagent("sugar", 10)

/obj/item/reagent_container/food/snacks/pumpkinpieslice
	name = "南瓜派切片"
	desc = "一片南瓜派，顶上配有搅打奶油。完美。"
	icon_state = "pumpkinpieslice"
	icon = 'icons/obj/items/food/cakes.dmi'
	trash = /obj/item/trash/plate
	filling_color = "#F5B951"
	bitesize = 2

/obj/item/reagent_container/food/snacks/cracker
	name = "薄脆饼干"
	desc = "这是一块咸味薄脆饼干。"
	icon_state = "cracker"
	icon = 'icons/obj/items/food/mre_food/uscm.dmi'
	filling_color = "#F5DEB8"

/obj/item/reagent_container/food/snacks/cracker/Initialize()
	. = ..()
	reagents.add_reagent("bread", 1)
	reagents.add_reagent("sodiumchloride", 1)

/*
*PIZZA.
*object parent for all the object pizza give the number of slice produce and the filling color.
*example of how it work for each pizza.
*object 1 here is the first item : the pizza it give him name description icon and where to find the corresponding slice object.
*object 2 child to pizza to initialize corresponding pizza and fill it with reagent and define the number of bite to eat it.
*object 3 here is the second item : the pizza slice it give him name description icon filling color and number of bites.
*/

/obj/item/reagent_container/food/snacks/sliceable/pizza
	filling_color = "#BAA14C"
	icon = 'icons/obj/items/food/pizza.dmi'
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/pizza/mystery
	name = "神秘披萨"
	desc = "看起来能吃，勾起食欲的神秘披萨。"
	slice_path = /obj/item/reagent_container/food/snacks/mysteryslice

/obj/item/reagent_container/food/snacks/sliceable/pizza/mystery/Initialize()
	. = ..()
	reagents.add_reagent("bread", 15)
	icon_state = pick("pizzamargherita","meatpizza","mushroompizza","vegetablepizza")
	if(prob(60))
		reagents.add_reagent("tomatojuice", 6)
	for(var/i in 1 to 3)
		var/ingredient = pick(200;"vegetable", 150;"meatprotein", "mushroom", "fish", "cheese", 80;"potato", 80;"egg", 50;"coco", 50;"fruit", 50;"soysauce", 50;"ketchup", 50;"tofu", 30;"noodles", 30;"honey", 30;"banana")
		reagents.add_reagent(ingredient, rand(6,12))

/obj/item/reagent_container/food/snacks/mysteryslice
	name = "神秘披萨切片"
	desc = "你先请。"
	icon = 'icons/obj/items/food/pizza.dmi'
	filling_color = "#BAA14C"
	bitesize = 2

/obj/item/reagent_container/food/snacks/mysteryslice/Initialize()
	. = ..() // I'm not rewriting a chunk of cooking backend for this, so this just slices into random icons. Intriguing!
	icon_state = pick("pizzamargheritaslice","meatpizzaslice","mushroompizzaslice","vegetablepizzaslice")

/obj/item/reagent_container/food/snacks/sliceable/pizza/margherita
	name = "玛格丽塔披萨"
	desc = "披萨的黄金标准。"
	icon_state = "pizzamargherita"
	slice_path = /obj/item/reagent_container/food/snacks/margheritaslice

/obj/item/reagent_container/food/snacks/sliceable/pizza/margherita/Initialize()
	. = ..()
	reagents.add_reagent("bread", 20)
	reagents.add_reagent("cheese", 20)
	reagents.add_reagent("tomatojuice", 6)

/obj/item/reagent_container/food/snacks/margheritaslice
	name = "玛格丽塔披萨切片"
	desc = "一片经典披萨。"
	icon_state = "pizzamargheritaslice"
	icon = 'icons/obj/items/food/pizza.dmi'
	filling_color = "#BAA14C"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/pizza/meatpizza
	name = "肉类披萨"
	desc = "配有肉类配料的披萨。"
	icon_state = "meatpizza"
	slice_path = /obj/item/reagent_container/food/snacks/meatpizzaslice

/obj/item/reagent_container/food/snacks/sliceable/pizza/meatpizza/Initialize()
	. = ..()
	reagents.add_reagent("bread", 10)
	reagents.add_reagent("cheese", 20)
	reagents.add_reagent("meatprotein", 10)
	reagents.add_reagent("tomatojuice", 6)

/obj/item/reagent_container/food/snacks/meatpizzaslice
	name = "肉类披萨切片"
	desc = "一片多肉的披萨。"
	icon = 'icons/obj/items/food/pizza.dmi'
	icon_state = "meatpizzaslice"
	item_state_slots = list(WEAR_AS_GARB = "pizza")
	filling_color = "#BAA14C"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/pizza/mushroompizza
	name = "蘑菇披萨"
	desc = "非常特别的披萨。"
	icon_state = "mushroompizza"
	slice_path = /obj/item/reagent_container/food/snacks/mushroompizzaslice

/obj/item/reagent_container/food/snacks/sliceable/pizza/mushroompizza/Initialize()
	. = ..()
	reagents.add_reagent("bread", 15)
	reagents.add_reagent("mushroom", 20)

/obj/item/reagent_container/food/snacks/mushroompizzaslice
	name = "蘑菇披萨切片"
	desc = "也许这是你人生中最后一片披萨。"
	icon = 'icons/obj/items/food/pizza.dmi'
	icon_state = "mushroompizzaslice"
	item_state_slots = list(WEAR_AS_GARB = "pizza")
	filling_color = "#BAA14C"
	bitesize = 2

/obj/item/reagent_container/food/snacks/sliceable/pizza/vegetablepizza
	name = "素食披萨"
	desc = "制作此披萨时，没有任何番茄智人受到伤害。"
	icon_state = "vegetablepizza"
	slice_path = /obj/item/reagent_container/food/snacks/vegetablepizzaslice

/obj/item/reagent_container/food/snacks/sliceable/pizza/vegetablepizza/Initialize()
	. = ..()
	reagents.add_reagent("bread", 15)
	reagents.add_reagent("vegetable", 15)
	reagents.add_reagent("tomatojuice", 6)
	reagents.add_reagent("imidazoline", 12)

/obj/item/reagent_container/food/snacks/vegetablepizzaslice
	name = "素食披萨切片"
	desc = "一片所有不含绿色配料的披萨中最绿的披萨。"
	icon = 'icons/obj/items/food/pizza.dmi'
	icon_state = "vegetablepizzaslice"
	item_state_slots = list(WEAR_AS_GARB = "pizza")
	filling_color = "#BAA14C"
	bitesize = 2

//pizzabox

/obj/item/pizzabox
	name = "披萨盒"
	desc = "一个适合装披萨的盒子。"
	icon = 'icons/obj/items/food/pizza.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/food_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/food_righthand.dmi'
	)
	icon_state = "pizzabox1"

	var/open = 0 // Is the box open?
	var/ismessy = 0 // Fancy mess on the lid
	var/obj/item/reagent_container/food/snacks/sliceable/pizza/pizza // Content pizza
	var/list/boxes = list() // If the boxes are stacked, they come here
	var/boxtag = ""

/obj/item/pizzabox/Destroy(force)
	QDEL_NULL(pizza)
	return ..()

/obj/item/pizzabox/update_icon()

	overlays = list()

	// Set appropriate description
	if( open && pizza )
		desc = "一个适合装披萨的盒子。里面似乎有一个[pizza.name]。"
	else if( length(boxes) > 0 )
		desc = "一堆适合装披萨的盒子。这堆里似乎有[length(boxes) + 1]个盒子。"

		var/obj/item/pizzabox/topbox = boxes[length(boxes)]
		var/toptag = topbox.boxtag
		if( toptag != "" )
			desc = "[desc] 最上面的盒子有一个标签，上面写着：'[toptag]'。"
	else
		desc = "一个适合装披萨的盒子。"

		if( boxtag != "" )
			desc = "[desc] 这个盒子有一个标签，上面写着：'[boxtag]'。"

	// Icon states and overlays
	if( open )
		if( ismessy )
			icon_state = "pizzabox_messy"
		else
			icon_state = "pizzabox_open"

		if( pizza )
			var/image/pizzaimg = image("food.dmi", icon_state = pizza.icon_state)
			pizzaimg.pixel_y = -3
			overlays += pizzaimg

		return
	else
		// Stupid code because byondcode sucks
		var/doimgtag = 0
		if( length(boxes) > 0 )
			var/obj/item/pizzabox/topbox = boxes[length(boxes)]
			if( topbox.boxtag != "" )
				doimgtag = 1
		else
			if( boxtag != "" )
				doimgtag = 1

		if( doimgtag )
			var/image/tagimg = image("food.dmi", icon_state = "pizzabox_tag")
			tagimg.pixel_y = length(boxes) * 3
			overlays += tagimg

	icon_state = "pizzabox[length(boxes)+1]"

/obj/item/pizzabox/attack_hand( mob/user as mob )

	if( open && pizza )
		user.put_in_hands( pizza )

		to_chat(user, SPAN_DANGER("你从[src]中取出了[src.pizza]。"))
		src.pizza = null
		update_icon()
		return

	if( length(boxes) > 0 )
		if( user.get_inactive_hand() != src )
			..()
			return

		var/obj/item/pizzabox/box = boxes[length(boxes)]
		boxes -= box

		user.put_in_hands( box )
		to_chat(user, SPAN_DANGER("你从手中移除了最上面的[src]。"))
		box.update_icon()
		update_icon()
		return
	..()

/obj/item/pizzabox/attack_self(mob/user)
	..()

	if(length(boxes) > 0)
		return

	open = !open
	if(open && pizza)
		ismessy = TRUE

	update_icon()

/obj/item/pizzabox/attackby( obj/item/I as obj, mob/user as mob )
	if( istype(I, /obj/item/pizzabox/) )
		var/obj/item/pizzabox/box = I

		if( !box.open && !src.open )
			// Make a list of all boxes to be added
			var/list/boxestoadd = list()
			boxestoadd += box
			for(var/obj/item/pizzabox/i in box.boxes)
				boxestoadd += i

			if( (length(boxes)+1) + length(boxestoadd) <= 5 )
				user.drop_inv_item_to_loc(box, src)
				box.boxes = list() // Clear the box boxes so we don't have boxes inside boxes. - Xzibit
				src.boxes.Add( boxestoadd )

				box.update_icon()
				update_icon()

				to_chat(user, SPAN_DANGER("你将[box]放到了[src]上面！"))
			else
				to_chat(user, SPAN_DANGER("堆得太高了！"))
		else
			to_chat(user, SPAN_DANGER("先把[box]关上！"))

		return

	if( istype(I, /obj/item/reagent_container/food/snacks/sliceable/pizza/) ) // Long ass fucking object name

		if(open)
			user.drop_inv_item_to_loc(I, src)
			pizza = I

			update_icon()

			to_chat(user, SPAN_DANGER("你将[I]放入了[src]！"))
		else
			to_chat(user, SPAN_DANGER("你试图将[I]从盒盖塞进去，但失败了！"))
		return

	if( istype(I, /obj/item/tool/pen/) )

		if( src.open )
			return

		var/t = stripped_input(user,"输入你想添加到标签上的内容：", "Write", "", 30)

		var/obj/item/pizzabox/boxtotagto = src
		if( length(boxes) > 0 )
			boxtotagto = boxes[length(boxes)]

		boxtotagto.boxtag = "[boxtotagto.boxtag][t]"
		playsound(src, "paper_writing", 15, TRUE)
		update_icon()
		return
	..()

/obj/item/pizzabox/margherita/Initialize()
	. = ..()
	pizza = new /obj/item/reagent_container/food/snacks/sliceable/pizza/margherita(src)
	boxtag = "Margherita Deluxe"

/obj/item/pizzabox/vegetable/Initialize()
	. = ..()
	pizza = new /obj/item/reagent_container/food/snacks/sliceable/pizza/vegetablepizza(src)
	boxtag = "Gourmet Vegatable"

/obj/item/pizzabox/mushroom/Initialize()
	. = ..()
	pizza = new /obj/item/reagent_container/food/snacks/sliceable/pizza/mushroompizza(src)
	boxtag = "Mushroom Special"

/obj/item/pizzabox/meat/Initialize()
	. = ..()
	pizza = new /obj/item/reagent_container/food/snacks/sliceable/pizza/meatpizza(src)
	boxtag = "Meatlover's Supreme"

/// Mystery Pizza, made with random ingredients!
/obj/item/pizzabox/mystery/Initialize(mapload, ...)
	. = ..()
	pizza = new /obj/item/reagent_container/food/snacks/sliceable/pizza/mystery(src)
	boxtag = "神秘披萨"

// Pre-stacked boxes for reqs
/obj/item/pizzabox/mystery/stack/Initialize(mapload, ...)
	. = ..()
	for(var/i in 1 to 2)
		var/obj/item/pizzabox/mystery/extra = new(src)
		boxes += extra
	update_icon()

// Pizza Galaxy Pizza

/obj/item/pizzabox/pizza_galaxy
	icon = 'icons/obj/items/pizza_galaxy_pizza.dmi'

/obj/item/pizzabox/pizza_galaxy/margherita/Initialize()
	. = ..()
	pizza = new /obj/item/reagent_container/food/snacks/sliceable/pizza/margherita(src)
	boxtag = "Margherita Deluxe"

/obj/item/pizzabox/pizza_galaxy/vegetable/Initialize()
	. = ..()
	pizza = new /obj/item/reagent_container/food/snacks/sliceable/pizza/vegetablepizza(src)
	boxtag = "Gourmet Vegatable"

/obj/item/pizzabox/pizza_galaxy/mushroom/Initialize()
	. = ..()
	pizza = new /obj/item/reagent_container/food/snacks/sliceable/pizza/mushroompizza(src)
	boxtag = "Mushroom Special"

/obj/item/pizzabox/pizza_galaxy/meat/Initialize()
	. = ..()
	pizza = new /obj/item/reagent_container/food/snacks/sliceable/pizza/meatpizza(src)
	boxtag = "Meatlover's Supreme"

/// Mystery Pizza, made with random ingredients!
/obj/item/pizzabox/pizza_galaxy/mystery/Initialize(mapload, ...)
	. = ..()
	pizza = new /obj/item/reagent_container/food/snacks/sliceable/pizza/mystery(src)
	boxtag = "神秘披萨"

// Pre-stacked boxes for reqs
/obj/item/pizzabox/pizza_galaxy/mystery/stack/Initialize(mapload, ...)
	. = ..()
	for(var/i in 1 to 2)
		var/obj/item/pizzabox/pizza_galaxy/mystery/extra = new(src)
		boxes += extra
	update_icon()

///////////////////////////////////////////
// new old food stuff from bs12
///////////////////////////////////////////

// Flour + egg = dough
/obj/item/reagent_container/food/snacks/flour/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/reagent_container/food/snacks/egg))
		new /obj/item/reagent_container/food/snacks/dough(get_turf(src))
		to_chat(user, "你揉了些面团。")
		qdel(W)
		qdel(src)

// Egg + flour = dough
/obj/item/reagent_container/food/snacks/egg/attackby(obj/item/W, mob/living/user, list/mods)
	if(istype(W, /obj/item/reagent_container/food/snacks/flour))
		new /obj/item/reagent_container/food/snacks/dough(get_turf(src))
		to_chat(user, "你揉了些面团。")
		qdel(W)
		qdel(src)
		return TRUE

	if(istype(W, /obj/item/toy/crayon))
		var/obj/item/toy/crayon/C = W
		var/clr = C.colorName

		if(!(clr in list("blue","green","mime","orange","purple","rainbow","red","yellow")))
			to_chat(usr, SPAN_NOTICE("鸡蛋拒绝染上这种颜色！"))
			return

		to_chat(usr, SPAN_NOTICE("你将[src]染成了[clr]色"))
		icon_state = "egg-[clr]"
		egg_color = clr
		return TRUE

	return ..()

/obj/item/reagent_container/food/snacks/dough
	name = "dough"
	desc = "一块面团。"
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "dough"
	bitesize = 2

/obj/item/reagent_container/food/snacks/dough/Initialize()
	. = ..()
	reagents.add_reagent("dough", 3)

// Dough + rolling pin = flat dough
/obj/item/reagent_container/food/snacks/dough/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/tool/kitchen/rollingpin))
		new /obj/item/reagent_container/food/snacks/sliceable/flatdough(get_turf(src))
		to_chat(user, "你将面团压平。")
		qdel(src)

// slicable into 3xdoughslices
/obj/item/reagent_container/food/snacks/sliceable/flatdough
	name = "压平的面团"
	desc = "一块被压平的面团。"
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "压平的面团"
	slice_path = /obj/item/reagent_container/food/snacks/doughslice

/obj/item/reagent_container/food/snacks/sliceable/flatdough/Initialize()
	. = ..()
	reagents.add_reagent("dough", 3)

/obj/item/reagent_container/food/snacks/doughslice
	name = "生面团片"
	desc = "一道佳肴的基石。"
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "doughslice"
	bitesize = 2

/obj/item/reagent_container/food/snacks/doughslice/Initialize()
	. = ..()
	reagents.add_reagent("dough", 1)

/obj/item/reagent_container/food/snacks/bun
	name = "bun"
	desc = "任何体面汉堡的基础。"
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "bun"
	bitesize = 2

/obj/item/reagent_container/food/snacks/bun/Initialize()
	. = ..()
	reagents.add_reagent("bread", 4)

/obj/item/reagent_container/food/snacks/bun/attackby(obj/item/W as obj, mob/user as mob)
	// Bun + meatball = burger
	if(istype(W,/obj/item/reagent_container/food/snacks/meatball))
		new /obj/item/reagent_container/food/snacks/monkeyburger(get_turf(src))
		to_chat(user, "你做了一个汉堡。")
		qdel(W)
		qdel(src)

	// Bun + cutlet = hamburger
	else if(istype(W,/obj/item/reagent_container/food/snacks/cutlet))
		new /obj/item/reagent_container/food/snacks/monkeyburger(get_turf(src))
		to_chat(user, "你做了一个汉堡。")
		qdel(W)
		qdel(src)

	// Bun + sausage = hotdog
	else if(istype(W,/obj/item/reagent_container/food/snacks/sausage))
		new /obj/item/reagent_container/food/snacks/hotdog(get_turf(src))
		to_chat(user, "你做了一个热狗。")
		qdel(W)
		qdel(src)

// Burger + cheese wedge = cheeseburger
/obj/item/reagent_container/food/snacks/monkeyburger/attackby(obj/item/reagent_container/food/snacks/cheesewedge/W as obj, mob/user as mob)
	if(istype(W))// && !istype(src,/obj/item/reagent_container/food/snacks/cheesewedge))
		new /obj/item/reagent_container/food/snacks/cheeseburger(get_turf(src))
		to_chat(user, "你做了一个芝士汉堡。")
		qdel(W)
		qdel(src)
		return
	else
		..()

// Human Burger + cheese wedge = cheeseburger
/obj/item/reagent_container/food/snacks/human/burger/attackby(obj/item/reagent_container/food/snacks/cheesewedge/W as obj, mob/user as mob)
	if(istype(W))
		new /obj/item/reagent_container/food/snacks/cheeseburger(get_turf(src))
		to_chat(user, "你做了一个芝士汉堡。")
		qdel(W)
		qdel(src)
		return
	else
		..()

/obj/item/reagent_container/food/snacks/taco
	name = "taco"
	desc = "咬一口！"
	icon_state = "taco"
	bitesize = 3

/obj/item/reagent_container/food/snacks/taco/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 7)

/obj/item/reagent_container/food/snacks/rawcutlet
	name = "生肉排"
	desc = "一片薄生肉。"
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "rawcutlet"

/obj/item/reagent_container/food/snacks/rawcutlet/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 1)

/obj/item/reagent_container/food/snacks/cutlet
	name = "cutlet"
	desc = "一片美味的肉片。"
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "cutlet"
	bitesize = 2

/obj/item/reagent_container/food/snacks/cutlet/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 2)

/obj/item/reagent_container/food/snacks/rawmeatball
	name = "生肉丸"
	desc = "一个生肉丸。"
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "rawmeatball"
	bitesize = 2

/obj/item/reagent_container/food/snacks/rawmeatball/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 2)

/obj/item/reagent_container/food/snacks/hotdog
	name = "hotdog"
	desc = "可能和狗无关。"
	icon_state = "open-hotdog"
	bitesize = 2

/obj/item/reagent_container/food/snacks/hotdog/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("meatprotein", 3)

/obj/item/reagent_container/food/snacks/flatbread
	name = "flatbread"
	desc = "平淡但管饱。"
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "flatbread"
	bitesize = 2

/obj/item/reagent_container/food/snacks/flatbread/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)

// potato + knife = raw sticks
/obj/item/reagent_container/food/snacks/grown/potato/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/tool/kitchen/utensil/knife))
		new /obj/item/reagent_container/food/snacks/rawsticks(get_turf(src))
		to_chat(user, "你切了土豆。")
		qdel(src)
		return TRUE

	if(istype(W, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/C = W
		if(C.use(5))
			to_chat(user, SPAN_NOTICE("你在土豆上加了些电缆，然后把它滑进电池外壳里。"))
			var/obj/item/cell/potato/pocell = new /obj/item/cell/potato(user.loc)
			pocell.maxcharge = src.potency * 10
			pocell.charge = pocell.maxcharge
			qdel(src)
			return TRUE

	return ..()

/obj/item/reagent_container/food/snacks/rawsticks
	name = "生土豆条"
	desc = "生薯条，不太好吃。"
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "rawsticks"
	bitesize = 2

/obj/item/reagent_container/food/snacks/rawsticks/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 3)
	reagents.add_reagent("potato", 3)

/obj/item/reagent_container/food/snacks/packaged_burrito
	name = "包装墨西哥卷饼"
	desc = "一个硬邦邦的微波卷饼。包装上没有标明加热时间。由维兰德-汤谷公司包装。"
	icon_state = "packaged-burrito"
	item_state = "pburrito"
	bitesize = 2
	package = 1
	flags_obj = OBJ_NO_HELMET_BAND|OBJ_IS_HELMET_GARB

/obj/item/reagent_container/food/snacks/packaged_burrito/Initialize()
	. = ..()
	reagents.add_reagent("bread", 5)
	reagents.add_reagent("meatprotein", 5)
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/snacks/packaged_burrito/attack_self(mob/user)
	..()

	if(package)
		playsound(src.loc,'sound/effects/pageturn2.ogg', 15, 1)
		to_chat(user, SPAN_NOTICE("你从软趴趴的卷饼上扯下了包装！"))
		RemoveElement(/datum/element/corp_label/wy)
		package = 0
		new /obj/item/trash/buritto (user.loc)
		icon_state = "open-burrito"
		item_state = "burrito"

/obj/item/reagent_container/food/snacks/packaged_burger
	name = "包装芝士汉堡"
	desc = "一个湿乎乎的微波汉堡。包装上没有标明加热时间。由维兰德-汤谷公司包装。"
	icon_state = "burger"
	item_state = "pburger"
	icon = 'icons/obj/items/food/burgers.dmi'
	bitesize = 3
	package = 1

/obj/item/reagent_container/food/snacks/packaged_burger/Initialize()
	. = ..()
	reagents.add_reagent("bread", 5)
	reagents.add_reagent("meatprotein", 5)
	reagents.add_reagent("sodiumchloride", 2)
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/snacks/packaged_burger/attack_self(mob/user)
	..()

	if(package)
		playsound(src.loc,'sound/effects/pageturn2.ogg', 15, 1)
		to_chat(user, SPAN_NOTICE("你从软趴趴的汉堡上扯下了包装！"))
		RemoveElement(/datum/element/corp_label/wy)
		package = 0
		new /obj/item/trash/burger (user.loc)
		icon_state = "hburger"
		item_state = "burger"

/obj/item/reagent_container/food/snacks/packaged_hdogs
	name = "包装热狗"
	desc = "一根软趴趴、室温状态的热狗。包装上没有注明烹饪时间，所以你估计直接吃也行。由维兰德-汤谷公司包装。"
	icon_state = "packaged-hotdog"
	item_state = "photdog"
	flags_obj = OBJ_NO_HELMET_BAND|OBJ_IS_HELMET_GARB
	bitesize = 2
	package = 1

/obj/item/reagent_container/food/snacks/packaged_hdogs/Initialize()
	. = ..()
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("meatprotein", 1)
	reagents.add_reagent("sodiumchloride", 2)
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/snacks/packaged_hdogs/attack_self(mob/user)
	..()

	if(package)
		playsound(src.loc,'sound/effects/pageturn2.ogg', 15, 1)
		to_chat(user, SPAN_NOTICE("你撕开了软趴趴热狗的包装！"))
		RemoveElement(/datum/element/corp_label/wy)
		package = 0
		new /obj/item/trash/hotdog (user.loc)
		icon_state = "open-hotdog"
		item_state = "hotdog"

/obj/item/reagent_container/food/snacks/eat_bar
	name = "肉条"
	desc = "这是一个真空密封的、可疑的肉管。人工填满了你念都念不出来的营养成分。侧面印着M，所以看起来就是EAT（吃）。看来这就是口号的来源。"
	icon_state = "eat_bar"
	item_state_slots = list(WEAR_AS_GARB = "snack_eat")
	bitesize = 2
	w_class = SIZE_TINY
	trash = /obj/item/trash/eat

/obj/item/reagent_container/food/snacks/eat_bar/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 4)
	reagents.add_reagent("meatprotein", 4)
	AddElement(/datum/element/corp_label/wy) //Had WY logo (wings) in Alien Isolation

/obj/item/reagent_container/food/snacks/kepler_crisps
	name = "开普勒薯片"
	desc = "“它们好吃得吓人！” 现在含0%反式脂肪，并添加了真正的海盐。"
	icon_state = "kepler"
	item_state = "kepler"
	bitesize = 2
	trash = /obj/item/trash/kepler

/obj/item/reagent_container/food/snacks/kepler_crisps/Initialize()
	. = ..()
	reagents.add_reagent("bread", 4)
	reagents.add_reagent("sodiumchloride", 12)
	AddElement(/datum/element/corp_label/wy) //Had WY logo (wings) in Alien Isolation

/obj/item/reagent_container/food/snacks/kepler_crisps/flamehot
	name = "开普勒烈焰辣条"
	desc = "“它们好吃得吓人！” 由于在2165年开普勒烈焰辣条发布时进行了一场时机绝佳的广告活动，开普勒品牌得以在当年第三季度超越了维兰德的其他糖果产品。含0%反式脂肪。"
	icon_state = "flamehotkepler"
	item_state = "flamehotkepler"
	bitesize = 2
	trash = /obj/item/trash/kepler/flamehot

/obj/item/reagent_container/food/snacks/kepler_crisps/flamehot/Initialize()
	. = ..()
	reagents.add_reagent("bread", 4)
	reagents.add_reagent("sodiumchloride", 4)
	reagents.add_reagent("hotsauce", 8)

//Wrapped candy bars

/obj/item/reagent_container/food/snacks/wrapped
	package = 1
	bitesize = 3
	black_market_value = 5
	var/obj/item/trash/wrapper = null //Why this and not trash? Because it pulls the wrapper off when you unwrap it as a trash item.

/obj/item/reagent_container/food/snacks/wrapped/attack_self(mob/user)
	..()

	if(package)
		to_chat(user, SPAN_NOTICE("你撕开了[src]的包装！"))
		playsound(loc,'sound/effects/pageturn2.ogg', 15, 1)

		if(wrapper)
			new wrapper(user.loc)
		icon_state = "[initial(icon_state)]-o"
		item_state = "[initial(item_state)]-o"
		package = 0

//CM SNACKS
/obj/item/reagent_container/food/snacks/wrapped/booniebars
	name = "\improper Boonie Bars"
	desc = "两条美味的薄荷巧克力棒。<i>\"Sometimes things are just... out of reach.\"</i>"
	icon_state = "boonie"
	item_state = "boonie"
	item_state_slots = list(WEAR_AS_GARB = "boonie-bars")
	wrapper = /obj/item/trash/boonie

/obj/item/reagent_container/food/snacks/wrapped/booniebars/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 6)
	reagents.add_reagent("coco", 4)

/obj/item/reagent_container/food/snacks/wrapped/chunk
	name = "\improper CHUNK box"
	desc = "一条\"The <b>CHUNK</b>\" brand chocolate. <i>\"The densest chocolate permitted to exist according to federal law. We are legally required to ask you not to use this blunt object for anything other than nutrition.\"</i>"
	icon_state = "chunk"
	item_state = "chunk"
	item_state_slots = list(WEAR_AS_GARB = "chunkbox")
	hitsound = "swing_hit"
	force = 15
	throwforce = 10
	attack_speed = 10
	demolition_mod = 0.3
	bitesize = 2
	wrapper = /obj/item/trash/chunk

/obj/item/reagent_container/food/snacks/wrapped/chunk/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 7)
	reagents.add_reagent("coco", 10)

/obj/item/reagent_container/food/snacks/wrapped/chunk/hunk
	name = "HUNK箱"
	desc = "一个按营销说法叫“箱”的东西，装着\"The <b>HUNK</b>\" brand chocolate. An early version of the CHUNK box, the HUNK bar was hit by a class action lawsuit and forced to go into bankruptcy and get bought out by the Company when hundreds of customers had their teeth crack from simply attempting to eat the bar."
	icon_state = "hunk"
	item_state = "hunk"
	w_class = SIZE_MEDIUM
	force = 35
	throwforce = 50
	bitesize = 20
	wrapper = /obj/item/trash/chunk/hunk

/obj/item/reagent_container/food/snacks/wrapped/chunk/hunk/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 5)
	reagents.add_reagent("iron", 30)
	reagents.add_reagent("coco", 5)

/obj/item/reagent_container/food/snacks/wrapped/barcardine
	name = "碧卡利定条"
	desc = "一条巧克力，闻起来像医疗舱。<i>\"Chocolate always helps the pain go away.\"</i>"
	icon_state = "barcardine"
	item_state = "barcardine"
	item_state_slots = list(WEAR_AS_GARB = "barcardine-bars")
	wrapper = /obj/item/trash/barcardine

/obj/item/reagent_container/food/snacks/wrapped/barcardine/Initialize()
	. = ..()
	reagents.add_reagent("nutriment", 4)
	reagents.add_reagent("coco", 2)
	reagents.add_reagent("tramadol", 1) //May be powergamed but it's a single unit.
	reagents.add_reagent("bicaridine", 2) //The namesake of the bar.

/obj/item/reagent_container/food/snacks/wrapped/twe_bar
	name = "ORP燕麦饼干"
	desc = "一条燕麦饼干，里面有些干果碎。配茶很不错。"
	icon = 'icons/obj/items/food/mre_food/twe.dmi'
	icon_state = "cookie_bar"
	wrapper = null

/obj/item/reagent_container/food/snacks/wrapped/twe_bar/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	reagents.add_reagent("fruit", 1)
	reagents.add_reagent("sugar", 1)

/obj/item/reagent_container/food/snacks/wrapped/upp_biscuits
	name = "IRP军用饼干"
	desc = "也被称为军用硬饼干。一种烤箱烘烤的、酥脆咸香的饼干，可以搭配酱料或直接食用。"
	icon = 'icons/obj/items/food/mre_food/upp.dmi'
	icon_state = "Biscuits_package"
	wrapper = null

/obj/item/reagent_container/food/snacks/wrapped/upp_biscuits/Initialize()
	. = ..()
	reagents.add_reagent("bread", 4)
	reagents.add_reagent("sodiumchloride", 1)
