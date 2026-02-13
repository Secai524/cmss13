
///////////////////////////////////////////////Alchohol bottles and juice mixers! -Agouri //////////////////////////
//Functionally identical to regular drinks. The only difference is that the default bottle size is 100. - Darem
//Bottles now weaken and break when smashed on people's heads. - Giacom

//Booze bottles have two unqiue functions: They be used to smack someone in the head and turned into a molotov.

/obj/item/reagent_container/food/drinks/bottle
	amount_per_transfer_from_this = 5
	volume = 100
	item_state = "broken_beer" //Generic held-item sprite until unique ones are made.
	///This excludes all the juices and dairy in cartons that are also defined in this file.
	var/isGlass = TRUE
	black_market_value = 25

/obj/item/reagent_container/food/drinks/bottle/bullet_act(obj/projectile/P)
	. = ..()
	if(isGlass)
		smash()

///Audio/visual bottle breaking effects start here
/obj/item/reagent_container/food/drinks/bottle/proc/smash(mob/living/target, mob/living/user)
	var/obj/item/weapon/broken_bottle/B
	if(user)
		user.temp_drop_inv_item(src)
		B = new /obj/item/weapon/broken_bottle(user.loc)
		user.put_in_active_hand(B)
	else
		B = new /obj/item/weapon/broken_bottle(src.loc)
	if(prob(33))
		if(target)
			new/obj/item/shard(target.loc) // Create a glass shard at the target's location!
		else
			new/obj/item/shard(src.loc)

	B.icon_state = icon_state

	var/icon/I = new('icons/obj/items/food/drinks.dmi', icon_state)
	I.Blend(B.broken_outline, ICON_OVERLAY, rand(5), 1)
	I.SwapColor(rgb(255, 0, 220, 255), rgb(0, 0, 0, 0))
	B.icon = I

	playsound(src, "windowshatter", 15, 1)
	transfer_fingerprints_to(B)

	qdel(src)

/obj/item/reagent_container/food/drinks/bottle/attack(mob/living/target as mob, mob/living/user as mob)
	if(!target)
		return

	if(user.a_intent != INTENT_HARM || !isGlass)
		return ..()

	force = 15

	var/obj/limb/affecting = user.zone_selected
	var/drowsy_threshold = 0

	drowsy_threshold = CLOTHING_ARMOR_MEDIUM - target.getarmor(affecting, ARMOR_MELEE)

	target.apply_damage(force, BRUTE, affecting, sharp=0)

	if(affecting == "head" && iscarbon(target) && !isxeno(target))
		for(var/mob/O in viewers(user, null))
			if(target != user)
				O.show_message(text(SPAN_DANGER("<B>[target] has been hit over the head with a bottle of [name], by [user]!</B>")), SHOW_MESSAGE_VISIBLE)
			else
				O.show_message(text(SPAN_DANGER("<B>[target] hit \himself with a bottle of [name] on the head!</B>")), SHOW_MESSAGE_VISIBLE)
		if(drowsy_threshold > 0)
			target.apply_effect(min(drowsy_threshold, 10) , DROWSY)

	else //Regular attack text
		for(var/mob/O in viewers(user, null))
			if(target != user)
				O.show_message(text(SPAN_DANGER("<B>[target] has been attacked with a bottle of [name], by [user]!</B>")), SHOW_MESSAGE_VISIBLE)
			else
				O.show_message(text(SPAN_DANGER("<B>[target] has attacked \himself with a bottle of [name]!</B>")), SHOW_MESSAGE_VISIBLE)

	user.attack_log += text("\[[time_stamp()]\] <font color='red'>Has attacked [target.name] ([target.ckey]) with a bottle!</font>")
	target.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been smashed with a bottle by [user.name] ([user.ckey])</font>")
	msg_admin_attack("[user.name] ([user.ckey]) attacked [target.name] ([target.ckey]) with a bottle (INTENT: [uppertext(intent_text(user.a_intent))]) in [get_area(user)] ([user.loc.x],[user.loc.y],[user.loc.z]).", user.loc.x, user.loc.y, user.loc.z)

	if(reagents)
		for(var/mob/O in viewers(user, null))
			O.show_message(text(SPAN_NOTICE("<B>The contents of \the [src] splashes all over [target]!</B>")), SHOW_MESSAGE_VISIBLE)
		reagents.reaction(target, TOUCH)

	smash(target, user)

	return

/obj/item/reagent_container/food/drinks/bottle/attackby(obj/item/I, mob/living/user)
	if(!isGlass || !istype(I, /obj/item/paper))
		return ..()
	if(!reagents || !length(reagents.reagent_list))
		to_chat(user, SPAN_NOTICE("\The [src] is empty..."))
		return
	var/alcohol_potency = 0
	for(var/datum/reagent/R in reagents.reagent_list)
		if(R.intensitymod)
			alcohol_potency += R.intensitymod * R.volume
		else if(istype(R, /datum/reagent/ethanol))
			var/datum/reagent/ethanol/RA = R
			alcohol_potency += RA.boozepwr * (R.volume / 8)

	if(alcohol_potency < BURN_LEVEL_TIER_1)
		to_chat(user, SPAN_NOTICE("\the [src]里的可燃液体不够！"))
		return
	alcohol_potency = clamp(alcohol_potency, BURN_LEVEL_TIER_1, BURN_LEVEL_TIER_7)

	if(!do_after(user, 20, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		return
	var/turf/T = get_turf(src)
	var/obj/item/explosive/grenade/incendiary/molotov/M = new /obj/item/explosive/grenade/incendiary/molotov(T, alcohol_potency)
	to_chat(user, SPAN_NOTICE("你制作了\a [M]！"))
	user.put_in_hands(M)
	qdel(I)
	qdel(src)

///Alcohol bottles and their contents.
/obj/item/reagent_container/food/drinks/bottle/gin
	name = "\improper Griffeater Gin"
	desc = "一瓶高品质杜松子酒，产自新伦敦空间站。"
	icon_state = "ginbottle"

	center_of_mass = "x=16;y=4"

/obj/item/reagent_container/food/drinks/bottle/gin/Initialize()
	. = ..()
	reagents.add_reagent("gin", 100)

/obj/item/reagent_container/food/drinks/bottle/whiskey
	name = "\improper Uncle Git's Special Reserve"
	desc = "一瓶优质单一麦芽威士忌，由阿拉巴马州偏远地区的乡民精心陈酿四年。"
	icon_state = "whiskeybottle"
	item_state = "whiskeybottle"
	center_of_mass = "x=16;y=3"

/obj/item/reagent_container/food/drinks/bottle/whiskey/Initialize()
	. = ..()
	reagents.add_reagent("whiskey", 100)

/obj/item/reagent_container/food/drinks/bottle/sake
	name = "\improper Weyland-Yutani Sake"
	desc = "采用传承数千年的古老技艺酿造的清酒。由维兰德-汤谷公司在爱荷华州发酵。"
	icon_state = "sakebottle"
	item_state = "sakebottle"
	center_of_mass = "x=17;y=7"

/obj/item/reagent_container/food/drinks/bottle/sake/Initialize()
	. = ..()
	reagents.add_reagent("sake", 100)
	AddElement(/datum/element/corp_label/wy)

/obj/item/reagent_container/food/drinks/bottle/vodka
	name = "\improper Red Star Vodka"
	desc = "红星伏特加：敌人饮食中的主食。谁能想到液态土豆闻起来能这么冲。瓶子上写着，‘啦啦红星人：精致事物的爱好者。’或者至少你是这么猜的……你看不懂俄语。"
	icon_state = "red_star_vodka"
	center_of_mass = "x=17;y=3"

/obj/item/reagent_container/food/drinks/bottle/vodka/Initialize()
	. = ..()
	reagents.add_reagent("vodka", 100)

//chess bottles

/obj/item/reagent_container/food/drinks/bottle/vodka/chess
	name = "\improper Red Star Vodka promotional bottle"
	desc = "一瓶以国际象棋为主题的促销红星伏特加。"
	icon_state = "chess"
	black_market_value = 15

/obj/item/reagent_container/food/drinks/bottle/vodka/chess/b_pawn
	name = "\improper Black Pawn bottle"
	icon_state = "b_pawn"

/obj/item/reagent_container/food/drinks/bottle/vodka/chess/w_pawn
	name = "\improper White Pawn bottle"
	icon_state = "w_pawn"

/obj/item/reagent_container/food/drinks/bottle/vodka/chess/b_bishop
	name = "\improper Black Bishop bottle"
	icon_state = "b_bishop"

/obj/item/reagent_container/food/drinks/bottle/vodka/chess/w_bishop
	name = "\improper White Bishop bottle"
	icon_state = "w_bishop"

/obj/item/reagent_container/food/drinks/bottle/vodka/chess/b_knight
	name = "\improper Black Knight bottle"
	icon_state = "b_knight"

/obj/item/reagent_container/food/drinks/bottle/vodka/chess/w_knight
	name = "\improper White Knight bottle"
	icon_state = "w_knight"

/obj/item/reagent_container/food/drinks/bottle/vodka/chess/b_rook
	name = "\improper Black Rook bottle"
	icon_state = "b_rook"

/obj/item/reagent_container/food/drinks/bottle/vodka/chess/w_rook
	name = "\improper White Rook bottle"
	icon_state = "w_rook"

/obj/item/reagent_container/food/drinks/bottle/vodka/chess/b_king
	name = "\improper Black King bottle"
	icon_state = "b_king"

/obj/item/reagent_container/food/drinks/bottle/vodka/chess/w_king
	name = "\improper White King bottle"
	icon_state = "w_king"

/obj/item/reagent_container/food/drinks/bottle/vodka/chess/b_queen
	name = "\improper Black Queen bottle"
	icon_state = "b_queen"

/obj/item/reagent_container/food/drinks/bottle/vodka/chess/w_queen
	name = "\improper White Queen bottle"
	icon_state = "w_queen"

/obj/item/reagent_container/food/drinks/bottle/vodka/chess/random/Initialize()
	. = ..()
	var/newbottle = pick(subtypesof(/obj/item/reagent_container/food/drinks/bottle/vodka/chess))
	new newbottle(loc)
	qdel(src)


/obj/item/reagent_container/food/drinks/bottle/tequila
	name = "\improper Caccavo Guaranteed Quality tequila"
	desc = "由优质石油馏分、纯反应停及其他高品质原料制成！"
	icon_state = "tequilabottle"
	item_state = "tequilabottle"
	center_of_mass = "x=16;y=3"

/obj/item/reagent_container/food/drinks/bottle/tequila/Initialize()
	. = ..()
	reagents.add_reagent("tequila", 100)

/obj/item/reagent_container/food/drinks/bottle/davenport
	name = "\improper Davenport Rye Whiskey"
	desc = "一款风味独特的高档威士忌。酒瓶骄傲地宣称其为“真正的经典”。"
	icon_state = "davenport"
	center_of_mass = "x=16;y=3"

/obj/item/reagent_container/food/drinks/bottle/davenport/Initialize()
	. = ..()
	reagents.add_reagent("specialwhiskey", 50)

/obj/item/reagent_container/food/drinks/bottle/bottleofnothing
	name = "空无一物之瓶"
	desc = "一个空无一物的瓶子。"
	icon_state = "bottleofnothing"
	center_of_mass = "x=17;y=5"

/obj/item/reagent_container/food/drinks/bottle/bottleofnothing/Initialize()
	. = ..()
	reagents.add_reagent("nothing", 100)

/obj/item/reagent_container/food/drinks/bottle/patron
	name = "Wrapp Artiste 赞助人龙舌兰"
	desc = "掺有银粉的龙舌兰酒，在全银河系的太空夜总会供应。"
	icon_state = "patronbottle"
	center_of_mass = "x=16;y=6"

/obj/item/reagent_container/food/drinks/bottle/patron/Initialize()
	. = ..()
	reagents.add_reagent("patron", 100)

/obj/item/reagent_container/food/drinks/bottle/rum
	name = "皮特上尉的古巴香料朗姆酒"
	desc = "以著名的“古巴”皮特上尉命名，这款朗姆酒和他最后一次任务一样变幻莫测。"
	icon_state = "rumbottle"
	item_state = "rumbottle"
	center_of_mass = "x=16;y=8"

/obj/item/reagent_container/food/drinks/bottle/rum/Initialize()
	. = ..()
	reagents.add_reagent("rum", 100)

/obj/item/reagent_container/food/drinks/bottle/holywater
	name = "圣水扁瓶"
	desc = "一个装有随军牧师圣水的扁瓶。"
	icon_state = "holyflask"
	item_state = "holyflask"
	center_of_mass = "x=17;y=10"

/obj/item/reagent_container/food/drinks/bottle/holywater/Initialize()
	. = ..()
	reagents.add_reagent("holywater", 100)

/obj/item/reagent_container/food/drinks/bottle/vermouth
	name = "黄金眼味美思"
	desc = "甜美，美妙的干涩感~"
	icon_state = "vermouthbottle"
	center_of_mass = "x=17;y=3"

/obj/item/reagent_container/food/drinks/bottle/vermouth/Initialize()
	. = ..()
	reagents.add_reagent("vermouth", 100)

/obj/item/reagent_container/food/drinks/bottle/kahlua
	name = "罗伯特·罗巴斯特咖啡利口酒"
	desc = "一种广为人知的墨西哥咖啡风味利口酒。自1936年开始生产，HONK"
	icon_state = "kahluabottle"
	item_state = "kahluabottle"
	center_of_mass = "x=17;y=3"

/obj/item/reagent_container/food/drinks/bottle/kahlua/Initialize()
	. = ..()
	reagents.add_reagent("kahlua", 100)

/obj/item/reagent_container/food/drinks/bottle/goldschlager
	name = "大学女生金万利"
	desc = "因为只有她们才会喝100度的肉桂烈酒。"
	icon_state = "goldschlagerbottle"
	center_of_mass = "x=15;y=3"

/obj/item/reagent_container/food/drinks/bottle/goldschlager/Initialize()
	. = ..()
	reagents.add_reagent("goldschlager", 100)

/obj/item/reagent_container/food/drinks/bottle/cognac
	name = "巴顿堡特级干邑"
	desc = "一种经过多次蒸馏和多年陈酿制成的甜味烈酒。这次你或许不该再喊“狗屎安保”了。"
	icon_state = "cognacbottle"
	center_of_mass = "x=16;y=6"

/obj/item/reagent_container/food/drinks/bottle/cognac/Initialize()
	. = ..()
	reagents.add_reagent("cognac", 100)

/obj/item/reagent_container/food/drinks/bottle/wine
	name = "双胡子特酿葡萄酒"
	desc = "瓶子周围萦绕着淡淡的不安和恼人气息。"
	icon_state = "winebottle"
	item_state = "winebottle"
	center_of_mass = "x=16;y=4"

/obj/item/reagent_container/food/drinks/bottle/wine/Initialize()
	. = ..()
	reagents.add_reagent("wine", 100)

/obj/item/reagent_container/food/drinks/bottle/absinthe
	name = "越狱者绿茴香酒"
	desc = "只需一口，你就知道好时光即将来临。"
	icon_state = "absinthebottle"
	center_of_mass = "x=16;y=6"

/obj/item/reagent_container/food/drinks/bottle/absinthe/Initialize()
	. = ..()
	reagents.add_reagent("absinthe", 100)

/obj/item/reagent_container/food/drinks/bottle/blackout //used for testing alcohol code
	name = "昏天黑地烈性黑啤"
	desc = "驰名时空，一瓶“昏厥”足以放倒几乎任何人。对真正酒鬼的终极考验。"
	icon_state = "pwineglass"
	center_of_mass = "x=16;y=6"

/obj/item/reagent_container/food/drinks/bottle/blackout/Initialize()
	. = ..()
	reagents.add_reagent("blackout", 100)

/obj/item/reagent_container/food/drinks/bottle/melonliquor
	name = "翠玉甜瓜利口酒"
	desc = "一瓶46度的翡翠瓜利口酒。口感清甜。"
	icon_state = "alco-green" //Placeholder.
	center_of_mass = "x=16;y=6"

/obj/item/reagent_container/food/drinks/bottle/melonliquor/Initialize()
	. = ..()
	reagents.add_reagent("melonliquor", 100)

/obj/item/reagent_container/food/drinks/bottle/bluecuracao
	name = "蓝色库拉索小姐"
	desc = "一款果味浓郁、色泽湛蓝的饮品。饮用者无法施展第五种魔法。"
	icon_state = "alco-blue" //Placeholder.
	center_of_mass = "x=16;y=6"

/obj/item/reagent_container/food/drinks/bottle/bluecuracao/Initialize()
	. = ..()
	reagents.add_reagent("bluecuracao", 100)

/obj/item/reagent_container/food/drinks/bottle/grenadine
	name = "野蔷薇石榴糖浆"
	desc = "酸甜可口，一种用于为饮品增色或调味的酒吧糖浆。"
	icon_state = "grenadinebottle"
	center_of_mass = "x=16;y=6"

/obj/item/reagent_container/food/drinks/bottle/grenadine/Initialize()
	. = ..()
	reagents.add_reagent("grenadine", 100)

/obj/item/reagent_container/food/drinks/bottle/pwine
	name = "术士的天鹅绒"
	desc = "这包装真精美，里面的葡萄酒品质一定很高！年份肯定棒极了！"
	icon_state = "pwinebottle"
	center_of_mass = "x=16;y=4"

/obj/item/reagent_container/food/drinks/bottle/pwine/Initialize()
	. = ..()
	reagents.add_reagent("pwine", 100)

////////////////////////// BEERS ///////////////////////

/obj/item/reagent_container/food/drinks/bottle/beer/craft
	name = "彭德尔顿三星拉格啤酒"
	desc = "一种在外环殖民地盛行但在内星系几乎无人知晓的殖民拉格啤酒，可能出于健康考虑。它的味道对你来说完全陌生，但出奇地清爽并带有果味。背标上写着：‘使用科斯塔古纳的异域啤酒花酿造。’你几乎可以肯定那是个虚构的国家。"
	icon_state = "pendleton"
	center_of_mass = "x=16;y=13"

/obj/item/reagent_container/food/drinks/bottle/beer/craft/Initialize()
	. = ..()
	reagents.add_reagent("beer", 30)

/obj/item/reagent_container/food/drinks/bottle/beer/craft/tuxedo
	name = "燕尾服特酿"
	desc = "一款最初在英国酿造的精酿艾尔啤酒，燕尾服特酿品牌被广泛宣传为绅士之选；不应在酒吧畅饮，而应在正式晚宴上小口品尝。它销量不佳，部分原因是味道与其他啤酒差别不大，部分原因是价格贵了三倍。但请珍惜它！这可是富人的琼浆玉液。"
	icon_state = "tuxedo"

/obj/item/reagent_container/food/drinks/bottle/beer/craft/ganucci
	name = "加努奇纯正淡啤酒"
	desc = "一款口感寡淡、带有酸涩余味的淡啤酒。它不是最好的，但极其廉价，并且在意大利酿造，因此自然广受大众欢迎。与普遍看法相反，它是真正的啤酒，并非德鲁伊的泥浆水。"
	icon_state = "ganucci"

/obj/item/reagent_container/food/drinks/bottle/beer/craft/bluemalt
	name = "蓝色麦芽"
	desc = "一款酒精度游走在法律边缘的麦芽啤酒。之所以称为‘蓝色’，是因为当你灌下太多导致心脏停跳时，脸色就会发青。瓶身背面用巨大字体印有卫生局长的警告。枪械算重型机械吗？"
	icon_state = "bluemalt"

/obj/item/reagent_container/food/drinks/bottle/beer/craft/partypopper
	name = "派对爆竹艾尔"
	desc = "一款来自殖民地的有趣异国情调精酿啤酒，混合了少量糖分和清淡果味艾尔。其结果是让你口中的味蕾跳起一小段舞（大概是困惑之舞），据说抿一口就能让人微笑。最适合在派对上享用，最不适合在葬礼上饮用。在你最好朋友的坟墓上微笑吧，何乐而不为。"
	icon_state = "partypopper"

/obj/item/reagent_container/food/drinks/bottle/beer/craft/tazhushka
	name = "塔祖什卡绿松石啤酒"
	desc = "一款源自UPP的啤酒，由同名的塔祖什卡国营啤酒厂酿造。喝下去时会灼烧你的喉咙，但也让你感觉准备好应对一切。至少在一段时间内如此，直到该品牌闻名遐迩的宿醉袭来，将你内外摧毁。"
	icon_state = "tazhushka"

/obj/item/reagent_container/food/drinks/bottle/beer/craft/reaper
	name = "收割者红啤"
	desc = "一款强劲的日本啤酒，以‘大胆’和‘冒险’为营销卖点。考虑到其标签简直就是‘危险’的通用标志，可以肯定地说，喝够这玩意儿将是一场足以让你提前预约医生、处理你那‘哭泣的肝脏’的大胆冒险。"
	icon_state = "reaper"

/obj/item/reagent_container/food/drinks/bottle/beer/craft/mono
	name = "单色拉格"
	desc = "这个黑白相间的啤酒瓶没有标明产地，也没有说明它应该是什么。你只知道它是一种啤酒，味道相当平淡。让你感觉像是在看一张四个世纪前的照片。传闻如果你念名字念得足够快，会让你想说一段冗长而邪恶的演讲。"
	icon_state = "mono"

//////////////////////////JUICES AND STUFF ///////////////////////

/obj/item/reagent_container/food/drinks/bottle/orangejuice
	name = "橙汁"
	desc = "富含维生素，美味可口！"
	icon_state = "orangejuice"
	item_state = "orangejuice"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_righthand.dmi',
	)
	center_of_mass = "x=16;y=7"
	isGlass = 0

/obj/item/reagent_container/food/drinks/bottle/orangejuice/Initialize()
	. = ..()
	reagents.add_reagent("orangejuice", 100)
	var/probability = rand(0, 101)
	switch(probability)
		if(0 to 49)
			desc = "富含维生素，美味可口！不含果肉！"
		if(50 to 100)
			desc = "富含维生素，美味可口！含果肉！"
		else
			desc = "富含维生素，美味可口！含100%果肉！"

/obj/item/reagent_container/food/drinks/bottle/cream
	name = "牛奶奶油"
	desc = "这是奶油。用牛奶制成。你还指望在里面找到什么？"
	icon_state = "cream"
	item_state = "cream"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_righthand.dmi',
	)
	center_of_mass = "x=16;y=8"
	isGlass = 0

/obj/item/reagent_container/food/drinks/bottle/cream/Initialize()
	. = ..()
	reagents.add_reagent("cream", 100)

/obj/item/reagent_container/food/drinks/bottle/tomatojuice
	name = "番茄汁"
	desc = "好吧，至少它看起来像番茄汁。在那一大片红色里你也分不清。"
	icon_state = "tomatojuice"
	item_state = "tomatojuice"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_righthand.dmi',
	)
	center_of_mass = "x=16;y=8"
	isGlass = 0

/obj/item/reagent_container/food/drinks/bottle/tomatojuice/Initialize()
	. = ..()
	reagents.add_reagent("tomatojuice", 100)

/obj/item/reagent_container/food/drinks/bottle/limejuice
	name = "青柠汁"
	desc = "酸甜可口的美味。"
	icon_state = "limejuice"
	item_state = "limejuice"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/bottles_righthand.dmi',
	)
	center_of_mass = "x=16;y=8"
	isGlass = 0

/obj/item/reagent_container/food/drinks/bottle/limejuice/Initialize()
	. = ..()
	reagents.add_reagent("limejuice", 100)
