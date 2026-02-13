

// ***********************************************************
// Foods that are produced from hydroponics ~~~~~~~~~~
// Data from the seeds carry over to these grown foods
// ***********************************************************

//Grown foods
//Subclass so we can pass on values
/obj/item/reagent_container/food/snacks/grown
	var/plantname
	var/potency = -1
	icon = 'icons/obj/items/harvest.dmi'

/obj/item/reagent_container/food/snacks/grown/New(newloc,newpotency)
	if (!isnull(newpotency))
		potency = newpotency
	..()
	src.pixel_x = rand(-5.0, 5)
	src.pixel_y = rand(-5.0, 5)

/obj/item/reagent_container/food/snacks/grown/Initialize()
	. = ..()
	GLOB.grown_snacks_list += src
	addtimer(CALLBACK(src, PROC_REF(update_from_seed)), 1)

/obj/item/reagent_container/food/snacks/grown/Destroy()
	GLOB.grown_snacks_list -= src
	return ..()

/obj/item/reagent_container/food/snacks/grown/proc/update_from_seed()// Fill the object up with the appropriate reagents.
	if(!isnull(plantname))
		var/datum/seed/S = GLOB.seed_types[plantname]
		if(!S)
			return
		name = S.seed_name //Copies the name from the seed, important for renamed plants
		if(!S.chems)
			return
		potency = S.potency

		for(var/rid in S.chems)
			var/list/reagent_data = S.chems[rid]
			var/rtotal = reagent_data[1]
			if(length(reagent_data) > 1 && potency > 0)
				rtotal += floor(potency/reagent_data[2])
			if(reagents)
				reagents.add_reagent(rid, max(1, rtotal))

	if(reagents && reagents.total_volume > 0)
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/reagent_container/food/snacks/grown/corn
	name = "玉米穗"
	desc = "需要加点黄油！"
	plantname = "corn"
	icon_state = "corn"
	potency = 40
	filling_color = "#FFEE00"
	trash = /obj/item/corncob

/obj/item/reagent_container/food/snacks/grown/cherries
	name = "cherries"
	desc = "绝佳的配料！"
	icon_state = "cherry"
	filling_color = COLOR_RED
	gender = PLURAL
	plantname = "cherry"

/obj/item/reagent_container/food/snacks/grown/poppy
	name = "poppy"
	desc = "长久以来被用作休息、和平与死亡的象征。"
	icon_state = "poppy"
	potency = 30
	filling_color = "#CC6464"
	plantname = "poppies"
	black_market_value = 25

/obj/item/reagent_container/food/snacks/grown/nettle
	plantname = "nettle"
	desc = "明智的做法是<B>不要徒手触碰它...</B>"
	name = "nettle"
	icon_state = "nettle"
	damtype = "fire"
	force = 15
	flags_atom = NO_FLAGS
	throwforce = 1
	w_class = SIZE_SMALL
	throw_speed = SPEED_FAST
	throw_range = 3

	attack_verb = list("stung")
	hitsound = ""

	var/potency_divisior = 5

/obj/item/reagent_container/food/snacks/grown/nettle/Initialize()
	. = ..()
	force = round((5+potency/potency_divisior), 1)

/obj/item/reagent_container/food/snacks/grown/nettle/pickup(mob/living/carbon/human/user, silent)
	. = ..()
	if(!istype(user))
		return FALSE
	if(!user.gloves)
		to_chat(user, SPAN_DANGER("荨麻灼伤了你的手！"))
		var/obj/limb/affecting = user.get_limb(user.hand ? "l_hand":"r_hand")
		affecting.take_damage(0, force)

/obj/item/reagent_container/food/snacks/grown/nettle/death
	plantname = "deathnettle"
	desc = "光是看着这株发光的荨麻，就激起了你心中的<B>怒火</B>！"
	name = "deathnettle"
	icon_state = "deathnettle"

	potency_divisior = 2.5

/obj/item/reagent_container/food/snacks/grown/nettle/death/On_Consume(mob/living/carbon/human/user)
	. = ..()
	user.apply_internal_damage(potency/potency_divisior, user.internal_organs_by_name["liver"])

/obj/item/reagent_container/food/snacks/grown/nettle/death/pickup(mob/living/carbon/human/user)
	. = ..()
	if(!user.gloves && prob(50))
		user.apply_effect(5, PARALYZE)
		to_chat(user, SPAN_DANGER("你试图拾取死亡荨麻时被它击晕了！"))
		return FALSE

/obj/item/reagent_container/food/snacks/grown/harebell
	name = "harebell"
	desc = "\"I'll sweeten thy sad grave: thou shalt not lack the flower that's like thy face, pale primrose, nor the azured hare-bell, like thy veins; no, nor the leaf of eglantine, whom not to slander, out-sweeten'd not thy breath.\""
	icon_state = "harebell"
	potency = 1
	filling_color = "#D4B2C9"
	plantname = "harebells"

/obj/item/reagent_container/food/snacks/grown/potato
	name = "potato"
	desc = "煮了它们！捣碎它们！炖了它们！"
	icon_state = "potato"
	potency = 25
	filling_color = "#E6E8DA"
	plantname = "potato"

/obj/item/reagent_container/food/snacks/grown/grapes
	name = "一串葡萄"
	desc = "营养丰富！"
	icon_state = "grapes"
	filling_color = "#A332AD"
	plantname = "grapes"

/obj/item/reagent_container/food/snacks/grown/greengrapes
	name = "一串青葡萄"
	desc = "营养丰富！"
	icon_state = "greengrapes"
	potency = 25
	filling_color = "#A6FFA3"
	plantname = "greengrapes"

/obj/item/reagent_container/food/snacks/grown/peanut
	name = "peanut"
	desc = "坚果！"
	icon_state = "peanut"
	filling_color = "857e27"
	potency = 25
	plantname = "peanut"

/obj/item/reagent_container/food/snacks/grown/cabbage
	name = "cabbage"
	desc = "呃……卷心菜。"
	icon_state = "cabbage"
	potency = 25
	filling_color = "#A2B5A1"
	plantname = "cabbage"

/obj/item/reagent_container/food/snacks/grown/berries
	name = "一簇浆果"
	desc = "营养丰富！"
	icon_state = "berrypile"
	filling_color = "#C2C9FF"
	plantname = "berries"

/obj/item/reagent_container/food/snacks/grown/plastellium
	name = "一团塑钢矿"
	desc = "嗯，需要加工一下。"
	icon_state = "plastellium"
	filling_color = "#C4C4C4"
	plantname = "plastic"

/obj/item/reagent_container/food/snacks/grown/shand
	name = "斯伦达尔之手叶"
	desc = "来自低地灌木丛的叶片样本。闻起来有强烈的蜡味。"
	icon_state = "shand"
	filling_color = "#70C470"
	plantname = "shand"

/obj/item/reagent_container/food/snacks/grown/mtear
	name = "梅萨之泪嫩枝"
	desc = "一种生长在山地气候的草本植物，开着柔软、冷蓝色的花朵，已知含有丰富的治疗性化学物质。"
	icon_state = "mtear"
	filling_color = "#70C470"
	plantname = "mtear"

/obj/item/reagent_container/food/snacks/grown/mtear/attack_self(mob/user)
	..()

	if(istype(user.loc,/turf/open/space))
		return
	var/obj/item/stack/medical/advanced/ointment/predator/poultice = new /obj/item/stack/medical/advanced/ointment/predator(user.loc)

	poultice.heal_burn = potency
	qdel(src)

	to_chat(user, SPAN_NOTICE("你将花瓣捣成药膏。"))

/obj/item/reagent_container/food/snacks/grown/shand/attack_self(mob/user)
	..()

	if(istype(user.loc,/turf/open/space))
		return
	var/obj/item/stack/medical/advanced/bruise_pack/predator/poultice = new /obj/item/stack/medical/advanced/bruise_pack/predator(user.loc)

	poultice.heal_brute = potency
	qdel(src)

	to_chat(user, SPAN_NOTICE("你将叶片捣成药膏。"))

/obj/item/reagent_container/food/snacks/grown/glowberries
	name = "一串发光浆果"
	desc = "营养丰富！"
	var/brightness_on = 2 //luminosity when on
	filling_color = "#D3FF9E"
	icon_state = "glowberrypile"
	plantname = "glowberries"

/obj/item/reagent_container/food/snacks/grown/glowberries/Initialize()
	. = ..()

	set_light_range(brightness_on)
	set_light_on(TRUE)

/obj/item/reagent_container/food/snacks/grown/cocoapod
	name = "可可豆荚"
	desc = "可研磨成可可粉。"
	icon_state = "cocoapod"
	potency = 50
	filling_color = "#9C8E54"
	plantname = "cocoa"

/obj/item/reagent_container/food/snacks/grown/sugarcane
	name = "sugarcane"
	desc = "甜得发腻。"
	icon_state = "sugarcane"
	potency = 50
	filling_color = "#C0C9AD"
	plantname = "sugarcane"

/obj/item/reagent_container/food/snacks/grown/poisonberries
	name = "一串毒莓"
	desc = "美味到死！"
	icon_state = "poisonberrypile"
	gender = PLURAL
	potency = 15
	filling_color = "#B422C7"
	plantname = "poisonberries"

/obj/item/reagent_container/food/snacks/grown/deathberries
	name = "一串死亡浆果"
	desc = "美味到必死无疑！"
	icon_state = "deathberrypile"
	gender = PLURAL
	potency = 50
	filling_color = "#4E0957"
	plantname = "deathberries"

/obj/item/reagent_container/food/snacks/grown/ambrosiavulgaris
	name = "普通神食草枝"
	desc = "这种植物含有多种治疗性化学物质。"
	icon_state = "ambrosiavulgaris"
	potency = 10
	filling_color = "#125709"
	plantname = "ambrosia"

/obj/item/reagent_container/food/snacks/grown/ambrosiavulgaris/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/paper))
		to_chat(user, SPAN_NOTICE("你舀起普通神食草，用纸卷起来，做成了一支大麻烟卷。"))
		new /obj/item/clothing/mask/cigarette/weed (user.loc)
		qdel(src)
		qdel(W)
	else
		return ..()


/obj/item/reagent_container/food/snacks/grown/ambrosiadeus
	name = "神圣神食草枝"
	desc = "吃下这个让你感觉永生不死！"
	icon_state = "ambrosiadeus"
	potency = 10
	filling_color = "#229E11"
	plantname = "ambrosiadeus"

/obj/item/reagent_container/food/snacks/grown/apple
	name = "apple"
	desc = "这是伊甸园的一小片。"
	icon_state = "apple"
	potency = 15
	filling_color = "#DFE88B"
	plantname = "apple"

/obj/item/reagent_container/food/snacks/grown/apple/poisoned
	name = "apple"
	desc = "这是伊甸园的一小片。"
	icon_state = "apple"
	potency = 15
	filling_color = "#B3BD5E"
	plantname = "poisonapple"

/obj/item/reagent_container/food/snacks/grown/goldapple
	name = "金苹果"
	desc = "苹果上刻着'Kallisti'这个词。"
	icon_state = "goldapple"
	potency = 15
	filling_color = "#F5CB42"
	plantname = "goldapple"
	black_market_value = 30

/obj/item/reagent_container/food/snacks/grown/watermelon
	name = "watermelon"
	desc = "它充满了水润的精华。"
	icon_state = "watermelon"
	potency = 10
	filling_color = "#FA2863"
	slice_path = /obj/item/reagent_container/food/snacks/watermelonslice
	slices_num = 5
	plantname = "watermelon"

/obj/item/reagent_container/food/snacks/grown/pumpkin
	name = "pumpkin"
	desc = "它又大又吓人。"
	icon_state = "pumpkin"
	potency = 10
	filling_color = "#FAB728"
	plantname = "pumpkin"

/obj/item/reagent_container/food/snacks/grown/pumpkin/attackby(obj/item/W as obj, mob/user as mob)
	if(W.sharp == IS_SHARP_ITEM_ACCURATE || W.sharp == IS_SHARP_ITEM_BIG)
		to_chat(user, SPAN_NOTICE("你在[src]上刻了一张脸！"))
		new /obj/item/clothing/head/pumpkinhead (user.loc)
		qdel(src)
	else
		return ..()

/obj/item/reagent_container/food/snacks/grown/lime
	name = "lime"
	desc = "酸得让你脸都扭曲了。"
	icon_state = "lime"
	potency = 20
	filling_color = "#28FA59"
	plantname = "lime"

/obj/item/reagent_container/food/snacks/grown/lemon
	name = "lemon"
	desc = "当生活给你柠檬时，要庆幸它们不是酸橙。"
	icon_state = "lemon"
	potency = 20
	filling_color = "#FAF328"
	plantname = "lemon"

/obj/item/reagent_container/food/snacks/grown/orange
	name = "orange"
	desc = "这是一种味道浓烈的水果。"
	icon_state = "orange"
	potency = 20
	filling_color = "#FAAD28"
	plantname = "orange"

/obj/item/reagent_container/food/snacks/grown/whitebeet
	name = "白甜菜"
	desc = "白甜菜，无可匹敌。"
	icon_state = "whitebeet"
	potency = 15
	filling_color = "#FFFCCC"
	plantname = "whitebeet"

/obj/item/reagent_container/food/snacks/grown/banana
	name = "banana"
	desc = "这是绝佳的喜剧道具。"
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "banana"
	item_state = "banana"
	filling_color = "#FCF695"
	trash = /obj/item/bananapeel
	plantname = "banana"

/obj/item/reagent_container/food/snacks/grown/chili
	name = "chili"
	desc = "好辣！等等……它在烧我！！"
	icon_state = "chilipepper"
	filling_color = COLOR_RED
	plantname = "chili"

/obj/item/reagent_container/food/snacks/grown/eggplant
	name = "eggplant"
	desc = "里面说不定有只鸡？"
	icon_state = "eggplant"
	filling_color = "#550F5C"
	plantname = "eggplant"

/obj/item/reagent_container/food/snacks/grown/soybeans
	name = "soybeans"
	desc = "味道很淡，但可能性无限..."
	gender = PLURAL
	filling_color = "#E6E8B7"
	icon_state = "soybeans"
	plantname = "soybean"

/obj/item/reagent_container/food/snacks/grown/tomato
	name = "tomato"
	desc = "我说“土-豆”，你说“马-铃-薯”。"
	icon_state = "tomato"
	filling_color = COLOR_RED
	potency = 10
	plantname = "tomato"

/obj/item/reagent_container/food/snacks/grown/tomato/launch_impact(atom/hit_atom)
	..()
	new/obj/effect/decal/cleanable/tomato_smudge(src.loc)
	src.visible_message(SPAN_NOTICE("[src.name]被压扁了。"),SPAN_MODERATE("You hear a smack."))
	qdel(src)
	return

/obj/item/reagent_container/food/snacks/grown/killertomato
	name = "杀手番茄"
	desc = "我说“土-豆”，你说“马-铃-薯”……天哪它在啃我的腿！！"
	icon_state = "killertomato"
	potency = 10
	filling_color = COLOR_RED
	potency = 30
	plantname = "killertomato"

/obj/item/reagent_container/food/snacks/grown/killertomato/attack_self(mob/user)
	..()

	if(istype(user.loc,/turf/open/space))
		return
	new /mob/living/simple_animal/small/tomato(user.loc)
	qdel(src)

	to_chat(user, SPAN_NOTICE("你种下了杀手番茄。"))

/obj/item/reagent_container/food/snacks/grown/bloodtomato
	name = "血番茄"
	desc = "如此血腥...如此...非常...血腥....啊啊啊！！！！"
	icon_state = "bloodtomato"
	potency = 10
	filling_color = COLOR_RED
	plantname = "bloodtomato"

/obj/item/reagent_container/food/snacks/grown/bloodtomato/launch_impact(atom/hit_atom)
	..()
	new/obj/effect/decal/cleanable/blood/splatter(src.loc)
	src.visible_message(SPAN_NOTICE("[src.name]被压扁了。"),SPAN_MODERATE("You hear a smack."))
	src.reagents.reaction(get_turf(hit_atom))
	for(var/atom/A in get_turf(hit_atom))
		src.reagents.reaction(A)
	qdel(src)
	return

/obj/item/reagent_container/food/snacks/grown/bluetomato
	name = "蓝番茄"
	desc = "我说“蓝-豆”，你说“蓝-铃-薯”。"
	icon_state = "bluetomato"
	potency = 10
	filling_color = "#586CFC"
	plantname = "bluetomato"

/obj/item/reagent_container/food/snacks/grown/bluetomato/launch_impact(atom/hit_atom)
	..()
	new/obj/effect/decal/cleanable/blood/oil(src.loc)
	src.visible_message(SPAN_NOTICE("[src.name]被压扁了。"),SPAN_MODERATE("You hear a smack."))
	src.reagents.reaction(get_turf(hit_atom))
	for(var/atom/A in get_turf(hit_atom))
		src.reagents.reaction(A)
	qdel(src)
	return

/obj/item/reagent_container/food/snacks/grown/bluetomato/Crossed(AM as mob|obj)
	if (iscarbon(AM))
		var/mob/living/carbon/C = AM
		C.slip(name, 8, 5)

/obj/item/reagent_container/food/snacks/grown/wheat
	name = "wheat"
	desc = "唉...小麦...一粒？"
	gender = PLURAL
	icon_state = "wheat"
	filling_color = "#F7E186"
	plantname = "wheat"

/obj/item/reagent_container/food/snacks/grown/ricestalk
	name = "稻秆"
	desc = "稻见你了。"
	gender = PLURAL
	icon_state = "rice"
	filling_color = "#FFF8DB"
	plantname = "rice"

/obj/item/reagent_container/food/snacks/grown/kudzupod
	name = "野葛荚"
	desc = "<I>Pueraria Virallis</I>：一种入侵物种，其藤蔓会迅速蔓延并缠绕接触到的任何物体。"
	icon_state = "kudzupod"
	filling_color = "#59691B"
	plantname = "kudzu"

/obj/item/reagent_container/food/snacks/grown/icepepper
	name = "冰椒"
	desc = "这是一种变种辣椒。"
	icon_state = "icepepper"
	potency = 20
	filling_color = "#66CEED"
	plantname = "icechili"

/obj/item/reagent_container/food/snacks/grown/carrot
	name = "carrot"
	desc = "对眼睛有好处！"
	icon_state = "carrot"
	potency = 10
	filling_color = "#FFC400"
	plantname = "carrot"

/obj/item/reagent_container/food/snacks/grown/mushroom/reishi
	name = "reishi"
	desc = "<I>Ganoderma lucidum</I>：一种据信有助于缓解压力的特殊真菌。"
	icon_state = "reishi"
	potency = 10
	filling_color = "#FF4800"
	plantname = "reishi"

/obj/item/reagent_container/food/snacks/grown/mushroom/amanita
	name = "毒蝇伞"
	desc = "<I>Amanita Muscaria</I>：用心记住毒蘑菇。只采摘你认识的蘑菇。"
	icon_state = "amanita"
	potency = 10
	filling_color = COLOR_RED
	plantname = "amanita"

/obj/item/reagent_container/food/snacks/grown/mushroom/angel
	name = "毁灭天使"
	desc = "<I>Amanita Virosa</I>：充满α-鹅膏毒素的致命毒担子菌。"
	icon_state = "angel"
	potency = 35
	filling_color = "#FFDEDE"
	plantname = "destroyingangel"

/obj/item/reagent_container/food/snacks/grown/mushroom/libertycap
	name = "自由帽"
	desc = "<I>裸盖菇</I>：解放自我！"
	icon_state = "libertycap"
	potency = 15
	filling_color = "#F714BE"
	plantname = "libertycap"

/obj/item/reagent_container/food/snacks/grown/mushroom/plumphelmet
	name = "圆顶菇"
	desc = "<I>紫圆顶菇</I>：一种紫色的饱满蘑菇。适合烘烤。"
	icon_state = "plumphelmet"
	filling_color = "#F714BE"
	plantname = "plumphelmet"

/obj/item/reagent_container/food/snacks/grown/mushroom/chanterelle
	name = "鸡油菌丛"
	desc = "<I>鸡油菌</I>：这些欢快的黄色小蘑菇看起来真美味！"
	icon_state = "chanterelle"
	filling_color = "#FFE991"
	plantname = "mushrooms"

/obj/item/reagent_container/food/snacks/grown/mushroom/glowshroom
	name = "荧光菇丛"
	desc = "<I>布雷普罗克斯小菇</I>：这种蘑菇在黑暗中会发光。真的吗？"
	icon_state = "glowshroom"
	filling_color = "#DAFF91"
	potency = 30
	plantname = "glowshroom"
	black_market_value = 20

/obj/item/reagent_container/food/snacks/grown/mushroom/glowshroom/attack_self(mob/user)
	..()

	if(istype(user.loc,/turf/open/space))
		return
	var/obj/effect/glowshroom/planted = new /obj/effect/glowshroom(user.loc)

	planted.delay = 50
	planted.endurance = 100
	planted.potency = potency
	qdel(src)

	to_chat(user, SPAN_NOTICE("你种下了荧光菇。"))

// *************************************
// Complex Grown Object Defines -
// Putting these at the bottom so they don't clutter the list up. -Cheridan
// *************************************

/obj/item/reagent_container/food/snacks/grown/bluespacetomato
	name = "蓝空番茄"
	desc = "如此润滑，你可能会滑过时空。"
	icon_state = "bluespacetomato"
	potency = 20

	filling_color = "#91F8FF"
	plantname = "bluespacetomato"

/obj/item/reagent_container/food/snacks/grown/bluespacetomato/launch_impact(atom/hit_atom)
	..()
	var/mob/M = usr
	var/outer_teleport_radius = potency/10 //Plant potency determines radius of teleport.
	var/inner_teleport_radius = potency/15
	var/list/turfs = new/list()
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	if(inner_teleport_radius < 1) //Wasn't potent enough, it just splats.
		new/obj/effect/decal/cleanable/blood/oil(src.loc)
		src.visible_message(SPAN_NOTICE("[src.name]被压扁了。"),SPAN_MODERATE("You hear a smack."))
		qdel(src)
		return
	for(var/turf/T as anything in (RANGE_TURFS(outer_teleport_radius, M) - RANGE_TURFS(inner_teleport_radius, M)))
		if(istype(T,/turf/open/space))
			continue
		if(T.density)
			continue
		if(T.x>world.maxx-outer_teleport_radius || T.x<outer_teleport_radius)
			continue
		if(T.y>world.maxy-outer_teleport_radius || T.y<outer_teleport_radius)
			continue
		turfs += T
	if(!length(turfs))
		turfs += pick(RANGE_TURFS(outer_teleport_radius, M) - RANGE_TURFS(inner_teleport_radius, M))
	var/turf/picked = pick(turfs)
	if(!isturf(picked))
		return
	switch(rand(1,2))//Decides randomly to teleport the thrower or the throwee.
		if(1) // Teleports the person who threw the tomato.
			s.set_up(3, 1, M)
			s.start()
			new/obj/effect/decal/cleanable/molten_item(M.loc) //Leaves a pile of goo behind for dramatic effect.
			M.forceMove(picked )//
			sleep(1)
			s.set_up(3, 1, M)
			s.start() //Two set of sparks, one before the teleport and one after.
		if(2) //Teleports mob the tomato hit instead.
			for(var/mob/A in get_turf(hit_atom))//For the mobs in the tile that was hit...
				s.set_up(3, 1, A)
				s.start()
				new/obj/effect/decal/cleanable/molten_item(A.loc) //Leave a pile of goo behind for dramatic effect...
				A.forceMove(picked)//And teleport them to the chosen location.
				sleep(1)
				s.set_up(3, 1, A)
				s.start()
	new/obj/effect/decal/cleanable/blood/oil(src.loc)
	src.visible_message(SPAN_NOTICE("[src.name]被压扁了，导致时空扭曲。"),SPAN_MODERATE("You hear a splat and a crackle."))
	qdel(src)
	return
