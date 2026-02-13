/* Toys!
 * Contains:
 * Balloons
 * Fake telebeacon
 * Fake singularity
 * Toy mechs
 * Crayons
 * Snap pops
 * Water flower
 * Therapy dolls
 * Inflatable duck
 * Other things
 */

//recreational items

/obj/item/toy
	icon = 'icons/obj/items/toy.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/toys_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/toys_righthand.dmi'
	)
	throwforce = 0
	throw_speed = SPEED_VERY_FAST
	throw_range = 20
	force = 0
	black_market_value = 5

/*
 * Balloons
 */
/obj/item/toy/balloon
	name = "水球"
	desc = "一个半透明的气球。里面是空的。"
	icon_state = "waterballoon-e"
	item_state = "balloon-empty"

/obj/item/toy/balloon/Initialize()
	. = ..()
	create_reagents(10)

/obj/item/toy/balloon/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	return

/obj/item/toy/balloon/afterattack(atom/A as mob|obj, mob/user as mob, proximity)
	if(!proximity)
		return
	if (istype(A, /obj/structure/reagent_dispensers/tank/water) && get_dist(src,A) <= 1)
		A.reagents.trans_to(src, 10)
		to_chat(user, SPAN_NOTICE("你用[A]的内容物装满了气球。"))
		src.desc = "A translucent balloon with some form of liquid sloshing around in it."
		src.update_icon()
	return

/obj/item/toy/balloon/attackby(obj/O as obj, mob/user as mob)
	if(istype(O, /obj/item/reagent_container/glass))
		if(O.reagents)
			if(O.reagents.total_volume < 1)
				to_chat(user, SPAN_WARNING("[O]是空的。"))
			else if(O.reagents.total_volume >= 1)
				if(O.reagents.has_reagent("pacid", 1))
					to_chat(user, SPAN_WARNING("酸液腐蚀了气球！"))
					O.reagents.reaction(user)
					qdel(src)
				else
					src.desc = "A translucent balloon with some form of liquid sloshing around in it."
					to_chat(user, SPAN_NOTICE("你用[O]的内容物装满了气球。"))
					O.reagents.trans_to(src, 10)
	src.update_icon()
	return

/obj/item/toy/balloon/launch_impact(atom/hit_atom)
	if(src.reagents.total_volume >= 1)
		src.visible_message(SPAN_DANGER("[src]爆裂了！"),"You hear a pop and a splash.")
		src.reagents.reaction(get_turf(hit_atom))
		for(var/atom/A in get_turf(hit_atom))
			src.reagents.reaction(A)
		src.icon_state = "burst"
		spawn(5)
			if(src)
				qdel(src)
	return

/obj/item/toy/balloon/update_icon()
	if(src.reagents.total_volume >= 1)
		icon_state = "waterballoon"
		item_state = "balloon"
	else
		icon_state = "waterballoon-e"
		item_state = "balloon-empty"

/obj/item/toy/syndicateballoon
	name = "辛迪加气球"
	desc = "背面有一个标签，上面写着\"FUK WY!11!\"."
	throwforce = 0
	throw_speed = SPEED_VERY_FAST
	throw_range = 20
	force = 0
	icon = 'icons/obj/items/toy.dmi'
	icon_state = "syndballoon"
	item_state = "syndballoon"
	w_class = SIZE_LARGE

/*
 * Fake telebeacon
 */
/obj/item/toy/blink
	name = "电子闪烁玩具游戏"
	desc = "闪烁...闪烁...闪烁...适合8岁及以上儿童。"
	icon = 'icons/obj/items/radio.dmi'
	icon_state = "beacon"
	item_state = "signaller"

/*
 * Fake singularity
 */
/obj/item/toy/spinningtoy
	name = "引力奇点"
	desc = "\"Singulo\" brand spinning toy."
	icon = 'icons/obj/structures/props/singularity.dmi'
	icon_state = "singularity_s1"


/*
 * Crayons
 */

/obj/item/toy/crayon
	name = "crayon"
	desc = "一支彩色蜡笔。请不要食用或塞入鼻孔。"
	icon = 'icons/obj/items/paint.dmi'
	icon_state = "crayonred"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/crayons.dmi',
		)
	w_class = SIZE_TINY
	attack_verb = list("attacked", "colored")
	black_market_value = 5
	var/crayon_color = COLOR_RED
	var/shade_color = "#220000"
	/// 0 for unlimited uses
	var/uses = 30
	var/instant = 0
	var/colorName = "red" //for updateIcon purposes

/*
 * Snap pops
 */
/obj/item/toy/snappop
	name = "摔炮"
	desc = "哇！"
	icon_state = "snappop"
	w_class = SIZE_TINY

/obj/item/toy/snappop/launch_impact(atom/hit_atom)
	..()
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	new /obj/effect/decal/cleanable/ash(src.loc)
	src.visible_message(SPAN_DANGER("这个[src.name]爆炸了！"),SPAN_DANGER("You hear a snap!"))
	playsound(src, 'sound/effects/snap.ogg', 25, 1)
	qdel(src)

/obj/item/toy/snappop/Crossed(H as mob|obj)
	if((ishuman(H))) //i guess carp and shit shouldn't set them off
		var/mob/living/carbon/M = H
		to_chat(M, SPAN_WARNING("你踩到了摔炮！"))

		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(2, 0, src)
		s.start()
		new /obj/effect/decal/cleanable/ash(src.loc)
		src.visible_message(SPAN_DANGER("这个[src.name]爆炸了！"),SPAN_DANGER("You hear a snap!"))
		playsound(src, 'sound/effects/snap.ogg', 25, 1)
		qdel(src)

/*
 * Water flower
 */
/obj/item/toy/waterflower
	name = "水花"
	desc = "一朵看似无害的向日葵……暗藏玄机。"
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "sunflower"
	item_state = "sunflower"
	var/empty = 0
	flags

/obj/item/toy/waterflower/Initialize()
	. = ..()
	create_reagents(10)
	reagents.add_reagent("water", 10)

/obj/item/toy/waterflower/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	return

/obj/item/toy/waterflower/afterattack(atom/A as mob|obj, mob/user as mob)

	if (istype(A, /obj/item/storage/backpack ))
		return

	else if (locate (/obj/structure/surface/table, src.loc))
		return

	else if (istype(A, /obj/structure/reagent_dispensers/tank/water) && get_dist(src,A) <= 1)
		A.reagents.trans_to(src, 10)
		to_chat(user, SPAN_NOTICE("你重新装满了你的水花！"))
		return

	else if (src.reagents.total_volume < 1)
		src.empty = 1
		to_chat(user, SPAN_NOTICE("你的水花已经没水了！"))
		return

	else
		src.empty = 0


		var/obj/effect/decal/D = new/obj/effect/decal/(get_turf(src))
		D.name = "water"
		D.icon = 'icons/obj/items/chemistry.dmi'
		D.icon_state = "chempuff"
		D.create_reagents(5)
		src.reagents.trans_to(D, 1)
		playsound(src.loc, 'sound/effects/spray3.ogg', 15, 1, 3)

		spawn(0)
			for(var/i=0, i<1, i++)
				step_towards(D,A)
				D.reagents.reaction(get_turf(D))
				for(var/atom/T in get_turf(D))
					D.reagents.reaction(T)
					if(ismob(T) && T:client)
						to_chat(T:client, SPAN_WARNING("[user]用水喷了你！"))
				sleep(4)
			qdel(D)

		return

/obj/item/toy/waterflower/get_examine_text(mob/user)
	. = ..()
	. += "[reagents.total_volume] units of water left!"


/*
 * Mech prizes
 */
/obj/item/toy/prize
	icon_state = "ripleytoy"
	var/cooldown = 0
	w_class = SIZE_TINY

//all credit to skasi for toy mech fun ideas
/obj/item/toy/prize/attack_self(mob/user)
	..()

	if(cooldown < world.time - 8)
		to_chat(user, SPAN_NOTICE("你玩着[src]。"))
		playsound(user, 'sound/mecha/mechstep.ogg', 15, 1)
		cooldown = world.time

/obj/item/toy/prize/attack_hand(mob/user)
	if(loc == user)
		if(cooldown < world.time - 8)
			to_chat(user, SPAN_NOTICE("你玩着[src]。"))
			playsound(user, 'sound/mecha/mechturn.ogg', 15, 1)
			cooldown = world.time
			return
	..()

/obj/item/toy/prize/ripley
	name = "雷普利玩具"
	desc = "迷你机甲可动人偶！集齐全套！1/11。"

/obj/item/toy/prize/fireripley
	name = "消防雷普利玩具"
	desc = "迷你机甲可动人偶！集齐全套！2/11。"
	icon_state = "fireripleytoy"

/obj/item/toy/prize/deathripley
	name = "死亡小队雷普利玩具"
	desc = "迷你机甲可动人偶！集齐全套！3/11。"
	icon_state = "deathripleytoy"

/obj/item/toy/prize/gygax
	name = "吉格斯玩具"
	desc = "迷你机甲可动人偶！集齐全套！4/11。"
	icon_state = "gygaxtoy"


/obj/item/toy/prize/durand
	name = "杜兰德玩具"
	desc = "迷你机甲可动人偶！集齐全套！5/11。"
	icon_state = "durandprize"

/obj/item/toy/prize/honk
	name = "玩具 H.O.N.K."
	desc = "迷你机甲可动人偶！集齐全套！6/11。"
	icon_state = "honkprize"

/obj/item/toy/prize/marauder
	name = "玩具掠夺者"
	desc = "迷你机甲可动人偶！集齐全套！7/11。"
	icon_state = "marauderprize"

/obj/item/toy/prize/seraph
	name = "玩具六翼天使"
	desc = "迷你机甲可动人偶！集齐全套！8/11。"
	icon_state = "seraphprize"

/obj/item/toy/prize/mauler
	name = "玩具粉碎者"
	desc = "迷你机甲可动人偶！集齐全套！9/11。"
	icon_state = "maulerprize"

/obj/item/toy/prize/odysseus
	name = "玩具奥德修斯"
	desc = "迷你机甲可动人偶！集齐全套！10/11。"
	icon_state = "odysseusprize"

/obj/item/toy/prize/phazon
	name = "玩具法泽恩"
	desc = "迷你机甲可动人偶！集齐全套！11/11。"
	icon_state = "phazonprize"


/obj/item/toy/inflatable_duck
	name = "充气鸭"
	desc = "既然能浮着，何必纠结沉浮！"
	icon_state = "inflatable"
	item_state = "inflatable"
	icon = 'icons/obj/items/clothing/belts/misc.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/misc.dmi'
	)
	flags_equip_slot = SLOT_WAIST
	black_market_value = 20

/obj/item/toy/beach_ball
	name = "沙滩球"
	icon_state = "beachball"
	item_state = "beachball"
	density = FALSE
	anchored = FALSE
	w_class = SIZE_SMALL
	force = 0
	throwforce = 0
	throw_speed = SPEED_SLOW
	throw_range = 20

/obj/item/toy/beach_ball/afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
	user.drop_held_item()
	throw_atom(target, throw_range, throw_speed, user)

/obj/item/toy/dice
	name = "d6"
	desc = "一个六面骰子。"
	icon = 'icons/obj/items/dice.dmi'
	icon_state = "d66"
	w_class = SIZE_TINY
	var/sides = 6
	attack_verb = list("diced")

/obj/item/toy/dice/Initialize()
	. = ..()
	icon_state = "[name][rand(1, sides)]"

/obj/item/toy/dice/d20
	name = "d20"
	desc = "一个二十面骰子。"
	icon_state = "d2020"
	sides = 20

/obj/item/toy/dice/attack_self(mob/user)
	..()
	var/result = rand(1, sides)
	var/comment = ""
	if(sides == 20 && result == 20)
		comment = "Nat 20!"
	else if(sides == 20 && result == 1)
		comment = "Ouch, bad luck."
	icon_state = "[name][result]"
	user.visible_message(SPAN_NOTICE("[user]掷出了[src]。结果是[result]。[comment]"),
						SPAN_NOTICE("You throw [src]. It lands on a [result]. [comment]"),
						SPAN_NOTICE("You hear [src] landing on a [result]. [comment]"))

/obj/item/toy/bikehorn
	name = "自行车喇叭"
	desc = "一个从自行车上拆下来的喇叭。"
	icon = 'icons/obj/items/toy.dmi'
	icon_state = "bike_horn"
	item_state = "bike_horn"
	throwforce = 3
	w_class = SIZE_TINY
	throw_speed = SPEED_VERY_FAST
	throw_range = 15
	attack_verb = list("HONKED")
	black_market_value = 25
	var/spam_flag = 0
	var/sound_effect = 'sound/items/bikehorn.ogg'

/obj/item/toy/bikehorn/attack_self(mob/user)
	..()

	if (!spam_flag)
		spam_flag = TRUE
		playsound(src.loc, sound_effect, 25, 1)
		src.add_fingerprint(user)
		addtimer(VARSET_CALLBACK(src, spam_flag, FALSE), 2 SECONDS)

// rubber duck
/obj/item/toy/bikehorn/rubberducky
	name = "橡皮小鸭"
	desc = "橡皮小鸭你真棒，洗澡时光乐陶陶。橡皮小鸭我真是，好喜欢好喜欢你~" //thanks doohl
	icon_state = "rubberducky"
	item_state = "rubberducky"

/obj/item/computer3_part
	name = "电脑零件"
	desc = "老天爷啊，这下你可闯祸了。"
	gender = PLURAL
	icon = 'icons/obj/structures/machinery/stock_parts.dmi'
	icon_state = "hdd1"
	w_class = SIZE_SMALL
	crit_fail = 0

/obj/item/computer3_part/toybox
	var/list/prizes = list( /obj/item/storage/box/snappops = 2,
							/obj/item/toy/blink = 2,
							/obj/item/toy/sword = 2,
							/obj/item/toy/gun = 2,
							/obj/item/toy/crossbow = 2,
							/obj/item/clothing/suit/syndicatefake = 2,
							/obj/item/storage/fancy/crayons = 2,
							/obj/item/toy/spinningtoy = 2,
							/obj/item/toy/prize/ripley = 1,
							/obj/item/toy/prize/fireripley = 1,
							/obj/item/toy/prize/deathripley = 1,
							/obj/item/toy/prize/gygax = 1,
							/obj/item/toy/prize/durand = 1,
							/obj/item/toy/prize/honk = 1,
							/obj/item/toy/prize/marauder = 1,
							/obj/item/toy/prize/seraph = 1,
							/obj/item/toy/prize/mauler = 1,
							/obj/item/toy/prize/odysseus = 1,
							/obj/item/toy/prize/phazon = 1,
							/obj/item/clothing/shoes/slippers = 1,
							/obj/item/clothing/shoes/slippers_worn = 1,
							/obj/item/clothing/head/collectable/tophat/super = 1,
							)

/obj/item/toy/festivizer
	name = "\improper C92 pattern 'Festivizer' decorator"
	desc = "最先进的、维兰德品牌、高科技……啊，骗谁呢，就是个节日装饰器。你发现上面有个标签写着：<i> 注意：本设备并非用节日彩线包裹物品，而是将其涂成节日颜色。</i> 真坑人！"
	icon = 'icons/obj/items/marine-items_christmas.dmi'
	icon_state = "festive_wire"
	attack_speed = 0.8 SECONDS

/obj/item/toy/festivizer/get_examine_text(mob/user)
	. = ..()
	. += SPAN_BOLDNOTICE("You see another label on \the [src] that says: <i> INCLUDES SUPPORT FOR FOREIGN BIOFORMS! </i> You're not sure you like the sound of that.")

/obj/item/toy/festivizer/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!target.Adjacent(user))
		return
	if(ismob(target) || isVehicle(target))
		to_chat(user, SPAN_NOTICE("\The [src] is not able to festivize lifeforms or vehicles for safety concerns."))
		return
	if(target.color)
		to_chat(user, SPAN_NOTICE("\The [target] is already colored, don't be greedy!"))
		return
	var/red = prob(50)
	target.color = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, red? 0.2 : 0,!red? 0.2 : 0,0,0)
	target.visible_message(SPAN_GREEN("\The [target] has been festivized by [user]! Merry Christmas!"))
	to_chat(user, SPAN_GREEN("你为\the [target]增添了节日气氛！圣诞快乐！"))
	playsound(user, pick(95;'sound/items/jingle_short.wav', 5;'sound/items/jingle_long.wav'), 25, TRUE)
	if(prob(5))
		playsound(target, pick('sound/voice/alien_queen_xmas.ogg', 'sound/voice/alien_queen_xmas_2.ogg'), 25, TRUE)
	user.festivizer_hits_total++

/obj/item/toy/festivizer/attack_alien(mob/living/carbon/xenomorph/M)
	attack_hand(M) //xenos can use them too.
	return XENO_NONCOMBAT_ACTION

/obj/item/toy/festivizer/xeno
	name = "奇怪的、覆盖着树脂的节日装饰器"
	desc = "这个怪异的节日装饰器覆盖着黏糊糊的胶状物和污渍。真恶心！它太黏了，*任何东西*都能粘上去！抓住它并触碰其他东西来为它们增添节日气氛！"

/obj/item/toy/plush
	name = "普通毛绒玩具"
	desc = "非常普通。"
	icon = 'icons/obj/items/toy.dmi'
	icon_state = "debug"
	w_class = SIZE_SMALL
	COOLDOWN_DECLARE(last_hug_time)
	black_market_value = 10

/obj/item/toy/plush/attack_self(mob/user)
	..()
	if(!COOLDOWN_FINISHED(src, last_hug_time))
		return
	user.visible_message(SPAN_NOTICE("[user]紧紧地拥抱了[src]！"), SPAN_NOTICE("You hug [src]."))
	playsound(user, "plush", 25, TRUE)
	COOLDOWN_START(src, last_hug_time, 2.5 SECONDS)

/obj/item/toy/plush/farwa
	name = "法瓦玩偶"
	desc = "一个法瓦毛绒玩偶。它柔软又令人安心！"
	icon_state = "farwa"
	item_state = "farwaplush"
	black_market_value = 25

/obj/item/toy/plush/barricade
	name = "毛绒玩具路障"
	desc = "在你害怕、轻微受伤或任何其他情况下，都非常适合用来挤压。"
	icon_state = "barricade"
	item_state = "plushie_cade"

/obj/item/toy/plush/shark //A few more generic plushies to increase the size of the plushie loot pool
	name = "鲨鱼毛绒玩具"
	desc = "一个描绘了有些卡通化的鲨鱼的毛绒玩具。标签上注明它由斯堪的纳维亚一家不知名的家具制造商生产。"
	icon_state = "shark"

/obj/item/toy/plush/bee
	name = "蜜蜂毛绒玩具"
	desc = "一个可爱的玩具，能唤醒最沉默寡言的陆战队员心中的战士精神。"
	icon_state = "bee"

/obj/item/toy/plush/rock
	name = "岩石毛绒玩具"
	desc = "至少标签上说它是一个毛绒玩具。"
	icon_state = "rock"

/obj/item/toy/plush/gnarp
	name = "格纳普毛绒玩具"
	desc = "格纳普 格纳普。"
	icon_state = "gnarp"

/obj/item/toy/plush/gnarp/alt
	name = "格纳普毛绒玩具"
	desc = "格纳普 格纳普。"
	icon_state = "gnarp_alt"

/obj/item/toy/plush/therapy
	name = "治疗用毛绒玩具"
	desc = "一种治疗性玩具，用于协助陆战队员在经历战斗创伤后，从精神和行为障碍中恢复。"
	icon_state = "therapy"

/obj/item/toy/plush/therapy/red
	name = "红色治疗用毛绒玩具"
	color = "#FC5274"

/obj/item/toy/plush/therapy/blue
	name = "蓝色治疗用毛绒玩具"
	color = "#9EBAE0"

/obj/item/toy/plush/therapy/green
	name = "绿色治疗用毛绒玩具"
	color = "#A3C940"

/obj/item/toy/plush/therapy/orange
	name = "橙色治疗用毛绒玩具"
	color = "#FD8535"

/obj/item/toy/plush/therapy/purple
	name = "紫色治疗用毛绒玩具"
	color = "#A26AC7"

/obj/item/toy/plush/therapy/yellow
	name = "黄色治疗用毛绒玩具"
	color = "#FFE492"

/obj/item/toy/plush/therapy/random_color
	///Hexadecimal 0-F (0-15)
	var/static/list/hexadecimal = list("0", "1", "2", "3" , "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F")

/obj/item/toy/plush/therapy/random_color/Initialize(mapload, ...)
	. = ..()
	var/color_code = "#[pick(hexadecimal)][pick(hexadecimal)][pick(hexadecimal)][pick(hexadecimal)][pick(hexadecimal)][pick(hexadecimal)]" //This is dumb and I hope theres a better way I'm missing
	color = color_code
	desc = "一个定制版治疗玩偶，颜色独特。"

/obj/item/toy/plush/random_plushie //Not using an effect so it can fit into storage from loadout
	name = "随机玩偶"
	desc = "这个玩偶看起来极其普通乏味。它真是你的吗？"
	/// Standard plushies for the spawner to pick from
	var/list/plush_list = list(
		/obj/item/toy/plush/farwa,
		/obj/item/toy/plush/barricade,
		/obj/item/toy/plush/bee,
		/obj/item/toy/plush/shark,
		/obj/item/toy/plush/gnarp,
		/obj/item/toy/plush/gnarp/alt,
		/obj/item/toy/plush/rock,
	)
	///Therapy plushies left separately to not flood the entire list
	var/list/therapy_plush_list = list(
		/obj/item/toy/plush/therapy,
		/obj/item/toy/plush/therapy/red,
		/obj/item/toy/plush/therapy/blue,
		/obj/item/toy/plush/therapy/green,
		/obj/item/toy/plush/therapy/orange,
		/obj/item/toy/plush/therapy/purple,
		/obj/item/toy/plush/therapy/yellow,
		/obj/item/toy/plush/therapy/random_color,
	)

/obj/item/toy/plush/random_plushie/Initialize(mapload, ...)
	. = ..()
	if(mapload) //Placed in mapping, will be randomized instantly on spawn
		create_plushie()
		return INITIALIZE_HINT_QDEL

/obj/item/toy/plush/random_plushie/pickup(mob/user, silent)
	. = ..()
	RegisterSignal(user, COMSIG_POST_SPAWN_UPDATE, PROC_REF(create_plushie), override = TRUE)

///The randomizer picking and spawning a plushie on either the ground or in the humans backpack. Needs var/source due to signals
/obj/item/toy/plush/random_plushie/proc/create_plushie(datum/source)
	SIGNAL_HANDLER
	if(source)
		UnregisterSignal(source, COMSIG_POST_SPAWN_UPDATE)
	var/turf/spawn_location = get_turf(src)
	var/plush_list_variety = pick(60; plush_list, 40; therapy_plush_list)
	var/random_plushie = pick(plush_list_variety)
	var/obj/item/toy/plush/plush = new random_plushie(spawn_location) //Starts on floor by default
	var/mob/living/carbon/human/user = source

	if(!user) //If it didn't spawn on a humanoid
		qdel(src)
		return

	var/obj/item/storage/backpack/storage = locate() in user //If the user has a backpack, put it there
	if(storage?.can_be_inserted(plush, user, stop_messages = TRUE))
		storage.attempt_item_insertion(plush, TRUE, user)
	if(plush.loc == spawn_location) // Still on the ground
		user.put_in_hands(plush, drop_on_fail = TRUE)
	qdel(src)

//Admin plushies
/obj/item/toy/plush/yautja
	name = "奇怪的玩偶"
	desc = "一个描绘了某种高大类人双足生物的玩偶..？"
	icon_state = "yautja"
	black_market_value = 100

/obj/item/toy/plush/runner
	name = "\improper XX-121 therapy plush"
	desc = "别难过！要高兴（你还活着）！"
	icon_state = "runner"
	/// If the runner is wearing a beret
	var/beret = FALSE

/obj/item/toy/plush/runner/Initialize(mapload, ...)
	. = ..()
	if(beret)
		update_icon()

/obj/item/toy/plush/runner/attackby(obj/item/attacking_object, mob/user)
	. = ..()
	if(beret)
		return
	if(!istypestrict(attacking_object, /obj/item/clothing/head/beret/marine/mp))
		return
	var/beret_attack = attacking_object
	to_chat(user, SPAN_NOTICE("你将[beret_attack]戴在[src]头上。"))
	qdel(beret_attack)
	beret = TRUE
	update_icon()

/obj/item/toy/plush/runner/update_icon()
	. = ..()
	if(beret)
		icon_state = "runner_beret"
		return
	icon_state = "runner"
