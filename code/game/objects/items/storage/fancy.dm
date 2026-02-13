/*
 * The 'fancy' path is for objects like donut boxes that show how many items are in the storage item on the sprite itself
 * .. Sorry for the shitty path name, I couldn't think of a better one.
 *
 * WARNING: var/icon_type is used for both examine text and sprite name. Please look at the procs below and adjust your sprite names accordingly
 * TODO: Cigarette boxes should be ported to this standard
 *
 * Contains:
 * Donut Box
 * Egg Box
 * Candle Box
 * Crayon Box
 * Cigarette Box
 * Cigar Box
 * Match Box
 * Vial Box
 */

/obj/item/storage/fancy
	icon = null // We don't have fancy sprites for the base type, so don't check
	icon_state = "donutbox"
	name = "甜甜圈盒"
	desc = "一个装着圆形、美味、带孔的糕点的盒子。"
	var/icon_type = "donut"
	var/no_item_state_override = FALSE
	var/plural = "s"

/obj/item/storage/fancy/update_icon()
	icon_state = "[icon_type]box[length(contents)]"
	if(!no_item_state_override)
		item_state = "[icon_type]box[length(contents)]"

/obj/item/storage/fancy/remove_from_storage(obj/item/W, atom/new_location)
	. = ..()
	if(.)
		update_icon()


/obj/item/storage/fancy/get_examine_text(mob/user)
	. = ..()
	if(!length(contents))
		. += "There are no [src.icon_type][plural] left in the box."
	else if(length(contents) == 1)
		. += "There is one [src.icon_type] left in the box."
	else
		. += "There are [length(src.contents)] [src.icon_type][plural] in the box."

// EGG BOX

/obj/item/storage/fancy/egg_box
	icon = 'icons/obj/items/food/eggs.dmi'
	icon_state = "eggbox"
	icon_type = "egg"
	name = "鸡蛋盒"
	desc = "一个装满排列整齐的蛋形凹槽的储存容器。"
	storage_slots = 12
	max_storage_space = 24
	can_hold = list(/obj/item/reagent_container/food/snacks/egg)

/obj/item/storage/fancy/egg_box/fill_preset_inventory()
	for(var/i=1; i <= storage_slots; i++)
		new /obj/item/reagent_container/food/snacks/egg(src)
	return

// CANDLE BOX

/obj/item/storage/fancy/candle_box
	name = "蜡烛包"
	desc = "一包红色蜡烛。"
	icon = 'icons/obj/items/storage/boxes.dmi'
	icon_state = "candlebox5"
	icon_type = "candle"
	item_state = "candlebox5"
	storage_slots = 5
	throwforce = 2
	flags_equip_slot = SLOT_WAIST
	can_hold = list(/obj/item/tool/candle)

/obj/item/storage/fancy/candle_box/fill_preset_inventory()
	for(var/i=1; i <= storage_slots; i++)
		new /obj/item/tool/candle(src)
	return

// CRAYON BOX

/obj/item/storage/fancy/crayons
	name = "一盒蜡笔"
	desc = "一盒各种口味的蜡笔。"
	icon = 'icons/obj/items/paint.dmi'
	icon_state = "crayonbox"
	w_class = SIZE_SMALL
	storage_slots = 6
	icon_type = "crayon"
	can_hold = list(/obj/item/toy/crayon)
	black_market_value = 25

/obj/item/storage/fancy/crayons/fill_preset_inventory()
	new /obj/item/toy/crayon/red(src)
	new /obj/item/toy/crayon/orange(src)
	new /obj/item/toy/crayon/yellow(src)
	new /obj/item/toy/crayon/green(src)
	new /obj/item/toy/crayon/blue(src)
	new /obj/item/toy/crayon/purple(src)

/obj/item/storage/fancy/crayons/update_icon()
	overlays = list() //resets list
	overlays += image('icons/obj/items/paint.dmi',"crayonbox")
	for(var/obj/item/toy/crayon/crayon in contents)
		overlays += image('icons/obj/items/paint.dmi',crayon.colorName)

/obj/item/storage/fancy/crayons/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/toy/crayon))
		switch(W:colorName)
			if("mime")
				to_chat(usr, "这支蜡笔太悲伤了，无法被装在这个盒子里。")
				return
			if("rainbow")
				to_chat(usr, "这支蜡笔太强大了，无法被装在这个盒子里。")
				return
	..()

// CIGARETTES BOX

/obj/item/storage/fancy/cigarettes
	icon = 'icons/obj/items/smoking/packets/normal.dmi'
	icon_state = "cigpacket"
	name = "香烟盒"
	desc = "一包带有内置打火机隔层的香烟。"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/smoking_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/smoking_righthand.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/smoking.dmi',
	)
	w_class = SIZE_TINY
	throwforce = 2
	flags_equip_slot = SLOT_WAIST
	flags_obj = parent_type::flags_obj|OBJ_IS_HELMET_GARB
	max_w_class = SIZE_TINY
	storage_slots = 20
	can_hold = list(
		/obj/item/clothing/mask/cigarette,
		/obj/item/clothing/mask/cigarette/ucigarette,
		/obj/item/clothing/mask/cigarette/bcigarette,
		/obj/item/tool/lighter,
	)
	icon_type = "cigarette"
	var/default_cig_type = /obj/item/clothing/mask/cigarette

/obj/item/storage/fancy/cigarettes/fill_preset_inventory()
	flags_atom |= NOREACT
	for(var/i = 1 to storage_slots)
		new default_cig_type(src)
	create_reagents(15 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one

/obj/item/storage/fancy/cigarettes/Initialize()
	. = ..()
	icon_state = "[initial(icon_state)]"

/obj/item/storage/fancy/cigarettes/update_icon()
	icon_state = "[initial(icon_state)][length(contents)]"
	return

/obj/item/storage/fancy/cigarettes/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M, /mob))
		return

	if(M == user && user.zone_selected == "mouth" && length(contents) > 0 && !user.wear_mask)
		var/obj/item/clothing/mask/cigarette/C = locate() in src
		if(C)
			remove_from_storage(C, get_turf(user))
			user.equip_to_slot_if_possible(C, WEAR_FACE)
			to_chat(user, SPAN_NOTICE("你从烟盒里取出一支烟。"))
			update_icon()
	else
		..()

/obj/item/storage/fancy/cigarettes/emeraldgreen
	name = "\improper Emerald Green Packet"
	desc = "它们让你想起一个充满焦油的恶心版爱尔兰。这些廉价香烟是维兰德-汤谷进军大众市场的产品。"
	desc_lore = "Instantly recognizable by their price that undercuts even water, these cigarettes have become a fixture wherever budgets and morale run low. Nobody is quite sure what goes into the blend, but most agree you don't buy Emerald Greens for the flavor."
	icon_state = "cigpacket"
	item_state = "cigpacket"
	item_state_slots = list(WEAR_AS_GARB = "cig_cig")

/obj/item/storage/fancy/cigarettes/wypacket
	name = "\improper Weyland-Yutani Gold packet"
	desc = "建设更美好的世界，卷制更好的香烟。这些高档香烟是维兰德-汤谷进军优质烟草市场的产品。由一支强大的法律团队支持。"
	icon_state = "wypacket"
	icon = 'icons/obj/items/smoking/packets/wy_gold.dmi'
	item_state = "wypacket"
	item_state_slots = list(WEAR_AS_GARB = "cig_wypack")

/obj/item/storage/fancy/cigarettes/wypacket/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/storage/fancy/cigarettes/wypacket_4
	name = "\improper Weyland-Yutani Gold mini packet"
	desc = "建设更美好的世界，卷制更好的香烟。小巧便携，随时准备为你的高管事业服务，保护公司资产从未如此酷炫。"
	icon_state = "wy4packet"
	icon = 'icons/obj/items/smoking/packets/wy_gold_mini.dmi'
	item_state = "wypacket"
	item_state_slots = list(WEAR_AS_GARB = "cig_wypack")
	storage_slots = 4

/obj/item/storage/fancy/cigarettes/wypacket_4/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/storage/fancy/cigarettes/balaji
	name = "\improper Balaji Imperial packet"
	desc = "有就抽吧！在三世界帝国居民中相当受欢迎。"
	icon_state = "bpacket"
	icon = 'icons/obj/items/smoking/packets/balaji_imperials.dmi'
	item_state = "bpacket"
	item_state_slots = list(WEAR_AS_GARB = "cig_bpack")

/obj/item/storage/fancy/cigarettes/balaji_4
	name = "\improper Balaji Imperial Mini packet"
	desc = "有就抽吧！现在采用全新紧凑包装！"
	icon_state = "b4packet"
	icon = 'icons/obj/items/smoking/packets/balaji_imperials_mini.dmi'
	item_state = "bpacket"
	item_state_slots = list(WEAR_AS_GARB = "cig_bpack")
	storage_slots = 4

/obj/item/storage/fancy/cigarettes/lucky_strikes
	name = "\improper Lucky Strikes Packet"
	desc = "好运牌意味着优质烟草！9/10的医生同意好运牌是……陆战队员肺癌的主要原因。"
	icon_state = "lspacket"
	icon = 'icons/obj/items/smoking/packets/lucky_strike.dmi'
	item_state = "lspacket"
	item_state_slots = list(WEAR_AS_GARB = "cig_ls")
	default_cig_type = /obj/item/clothing/mask/cigarette/ucigarette

/obj/item/storage/fancy/cigarettes/lucky_strikes_4
	name = "\improper Lucky Strikes Mini Packet"
	desc = "这些四支装的好运牌香烟配发给每份单兵口粮。它们不如LACN口粮里的哈瓦那真品，但至少是免费的。"
	icon_state = "ls4packet"
	icon = 'icons/obj/items/smoking/packets/lucky_strike_mini.dmi'
	item_state = "lspacket"
	item_state_slots = list(WEAR_AS_GARB = "cig_ls_mre")
	default_cig_type = /obj/item/clothing/mask/cigarette/ucigarette
	storage_slots = 4

/obj/item/storage/fancy/cigarettes/blackpack
	name = "\improper Executive Select packet"
	desc = "这些香烟是奢侈的巅峰。口感顺滑，感觉酷爽，闻起来像胜利……和烟味。"
	icon_state = "blackpacket"
	icon = 'icons/obj/items/smoking/packets/executive_select.dmi'
	item_state = "blackpacket"
	item_state_slots = list(WEAR_AS_GARB = "cig_blackpack")
	default_cig_type = /obj/item/clothing/mask/cigarette/bcigarette

/obj/item/storage/fancy/cigarettes/blackpack_4
	name = "\improper Executive Select mini packet"
	desc = "就在你的口粮里的奢侈品。你正好可以在观赏核爆并享受它的时候用上。"
	icon_state = "black4packet"
	icon = 'icons/obj/items/smoking/packets/executive_select_mini.dmi'
	item_state = "blackpacket"
	item_state_slots = list(WEAR_AS_GARB = "cig_blackpack")
	default_cig_type = /obj/item/clothing/mask/cigarette/bcigarette
	storage_slots = 4

/obj/item/storage/fancy/cigarettes/kpack
	name = "\improper Koorlander Gold packet"
	desc = "由机器精心卷制，只为取悦你。适用于你想耍酷，而缓慢恐怖死亡的风险并非真正考虑因素之时。"
	desc_lore = "Popularized by Seegson workers during the construction of Sevastopol Station, these cigarettes lit easily, burned evenly, and offered a straightforward, dependable smoke. The flat, dusty flavor and steady draw quickly made them a colonial staple. Koorlander later scaled production on frontier farming worlds and locked in exclusive trade deals with the USCM."
	icon_state = "kpacket"
	icon = 'icons/obj/items/smoking/packets/koorlander.dmi'
	item_state = "kpacket"
	item_state_slots = list(WEAR_AS_GARB = "cig_kpack")

/obj/item/storage/fancy/cigarettes/kpack/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/koorlander)

/obj/item/storage/fancy/cigarettes/arcturian_ace
	name = "\improper Arcturian Ace packet"
	desc = "一款入门级香烟品牌，采用亮蓝色包装。你猜这对你没什么好处，但如果是阿克图里安产的，那又有什么关系呢！"
	icon_state = "aapacket"
	icon = 'icons/obj/items/smoking/packets/arcturian_ace.dmi'
	item_state = "aapacket"
	item_state_slots = list(WEAR_AS_GARB = "cig_aapack")

/obj/item/storage/fancy/cigarettes/lady_finger
	name = "\improper Lady Fingers packet"
	desc = "这些劲道十足的无过滤嘴薄荷烟似乎不太淑女。说真的，它们看起来也不太像手指。吸烟可能致命，但糟糕的品牌营销也差不多一样糟。"
	desc_lore = "A bold experiment in marketing, these brutal, unfiltered menthol cigarettes come in dusty rose packaging aimed at the women of the USCM. The scent is so overpowering that they are sometimes used to keep bugs out of field tents. Despite the effort, they are rarely chosen and mostly sit untouched in vending machines, quietly daring someone to try. Whether anyone actually likes them is another question."
	icon_state = "lfpacket"
	icon = 'icons/obj/items/smoking/packets/lady_fingers.dmi'
	item_state = "lfpacket"
	item_state_slots = list(WEAR_AS_GARB = "cig_lf")
	default_cig_type = /obj/item/clothing/mask/cigarette/ucigarette

/obj/item/storage/fancy/cigarettes/spirit
	name = "\improper Turquoise American Spirit Packet"
	desc = "一包青绿色的美国精神牌香烟。"
	icon_state = "naspacket"
	icon = 'icons/obj/items/smoking/packets/spirits_cyan.dmi'
	item_state = "naspacket"
	item_state_slots = list(WEAR_AS_GARB = "cig_spirit")
	default_cig_type = /obj/item/clothing/mask/cigarette

/obj/item/storage/fancy/cigarettes/spirit/yellow
	name = "\improper Yellow American Spirit Packet"
	desc = "一包黄色的美国精神牌香烟。"
	icon_state = "y_naspacket"
	icon = 'icons/obj/items/smoking/packets/spirits_yellow.dmi'
	item_state = "y_naspacket"
	item_state_slots = list(WEAR_AS_GARB = "cig_spirityellow")

/obj/item/storage/fancy/cigarettes/trading_card
	name = "\improper WeyYu Gold Military Trading Card packet"
	desc = "必须全部收集，全部抽掉！这款维兰德-汤谷金牌香烟的豪华军事集换卡版本，包含一张属于3套可用5张卡组之一的卡片。"
	icon_state = "collectpacket"
	icon = 'icons/obj/items/smoking/packets/trading_card.dmi'
	item_state = "collectpacket"
	storage_slots = 21
	can_hold = list(
		/obj/item/clothing/mask/cigarette,
		/obj/item/clothing/mask/cigarette/ucigarette,
		/obj/item/clothing/mask/cigarette/bcigarette,
		/obj/item/tool/lighter,
		/obj/item/toy/trading_card,
	)
	var/obj/item/toy/trading_card/trading_card

/obj/item/storage/fancy/cigarettes/trading_card/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/storage/fancy/cigarettes/trading_card/fill_preset_inventory()
	flags_atom |= NOREACT
	for(var/i = 1 to (storage_slots-1))
		new default_cig_type(src)
	trading_card = new(src)

/obj/item/storage/fancy/cigarettes/trading_card/attack_hand(mob/user, mods)
	if(trading_card?.loc == src && loc == user)
		to_chat(user, SPAN_NOTICE("你从香烟盒里抽出一张[trading_card.collection_color]集换卡。"))
		//have to take two disparate systems n' ram 'em together
		remove_from_storage(trading_card, user.loc)
		user.put_in_hands(trading_card)
		trading_card = null

	return ..()

/obj/item/storage/fancy/cigarettes/trading_card/attackby(obj/item/attacked_by_item, mob/user)
	if(istype(attacked_by_item, /obj/item/toy/trading_card))
		trading_card = attacked_by_item

	return ..()

/////////////
//CIGAR BOX//
/////////////
// CIGAR BOX

/obj/item/storage/fancy/cigar
	name = "雪茄盒"
	desc = "一个在你不想抽雪茄时用来存放它们的盒子。"
	icon_state = "cigarcase"
	item_state = "cigarcase"
	icon = 'icons/obj/items/smoking/cigars.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/smoking_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/smoking_righthand.dmi'
	)
	throwforce = 2
	w_class = SIZE_SMALL
	flags_equip_slot = SLOT_WAIST
	storage_slots = 7
	can_hold = list(/obj/item/clothing/mask/cigarette/cigar)
	icon_type = "cigar"
	black_market_value = 30
	var/default_cigar_type = /obj/item/clothing/mask/cigarette/cigar

/obj/item/storage/fancy/cigar/fill_preset_inventory()
	flags_atom |= NOREACT
	for(var/i = 1 to storage_slots)
		new default_cigar_type(src)
	create_reagents(15 * storage_slots)

/obj/item/storage/fancy/cigar/Initialize()
	. = ..()
	icon_state = "[initial(icon_state)]"

/obj/item/storage/fancy/cigar/update_icon()
	icon_state = "[initial(icon_state)][length(contents)]"
	return

/obj/item/storage/fancy/cigar/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M, /mob))
		return

	if(M == user && user.zone_selected == "mouth" && length(contents) > 0 && !user.wear_mask)
		var/obj/item/clothing/mask/cigarette/cigar/C = locate() in src
		if(C)
			remove_from_storage(C, get_turf(user))
			user.equip_to_slot_if_possible(C, WEAR_FACE)
			to_chat(user, SPAN_NOTICE("你取出一支雪茄。"))
			update_icon()
	else
		..()

/obj/item/storage/fancy/cigar/tarbacks
	name = "\improper Tarbacks case"
	desc = "别让这花哨的盒子和那张大谈传统与品质的废纸骗了你。这些雪茄是垫底货。哥伦比亚卷制。"
	icon_state = "tarbackbox"
	item_state = "tarbackbox"
	storage_slots = 5
	default_cigar_type = /obj/item/clothing/mask/cigarette/cigar/tarbacks

/obj/item/storage/fancy/cigar/tarbacktube
	name = "\improper Tarback tube"
	desc = "一支装在保护性金属管里的塔巴克雪茄。差不多是你能买到的最低端货。哥伦比亚卷制。"
	icon_state = "tarbacktube"
	item_state = "tarbacktube"
	storage_slots = 1
	default_cigar_type = /obj/item/clothing/mask/cigarette/cigar/tarbacks

// MATCH BOX

/obj/item/storage/fancy/cigar/matchbook
	name = "\improper Lucky Strikes matchbook"
	desc = "一小本廉价纸火柴。祝你好运能点着它们。由好运牌生产，但当你试图用它点火烧到手时，可一点好运都不会有。"
	icon_state = "mpacket"
	icon = 'icons/obj/items/smoking/matches.dmi'
	icon_type = "match"
	item_state_slots = list(WEAR_AS_GARB = "matches_mre")
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/smoking.dmi',
		)
	storage_slots = 6
	can_hold = list()
	default_cigar_type = /obj/item/tool/match/paper
	w_class = SIZE_TINY
	var/light_chance = 70 //how likely you are to light the match on the book
	var/burn_chance = 20 //how likely you are to burn yourself once you light it
	plural = "es"

/obj/item/storage/fancy/cigar/matchbook/attackby(obj/item/tool/match/W as obj, mob/living/carbon/human/user as mob)
	if(!istype(user))
		return
	if(prob(light_chance))
		if(istype(W) && !W.heat_source && !W.burnt)
			if(prob(burn_chance))
				to_chat(user, SPAN_WARNING("\The [W] lights, but you burn your hand in the process! Ouch!"))
				user.apply_damage(3, BURN, pick("r_hand", "l_hand"))
				if((user.pain.feels_pain) && prob(25))
					user.emote("scream")
				W.light_match(user)
			else
				W.light_match(user)
				to_chat(user, SPAN_NOTICE("你用\the [W]点燃了\the [src]。"))
	else
		to_chat(user, SPAN_NOTICE("\The [W] fails to light."))

/obj/item/storage/fancy/cigar/matchbook/brown
	name = "棕色纸板火柴"
	desc = "一本廉价的纸板火柴。祝你好运能把它点着。由普通的棕色纸张制成。"
	icon_state = "mpacket_br"

/obj/item/storage/fancy/cigar/matchbook/koorlander
	name = "\improper Koorlander matchbook"
	desc = "一本廉价的纸板火柴。祝你好运能把它点着。"
	icon_state = "mpacket_kl"

/obj/item/storage/fancy/cigar/matchbook/koorlander/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/koorlander)

/obj/item/storage/fancy/cigar/matchbook/exec_select
	name = "\improper Executive Select matchbook"
	desc = "一本昂贵的纸板火柴。这些几乎每次都能点着！"
	icon_state = "mpacket_es"
	light_chance = 90
	burn_chance = 0

/obj/item/storage/fancy/cigar/matchbook/balaji_imperial
	name = "\improper Balaji Imperial matchbook"
	desc = "一本为讲究的吸烟者设计的昂贵皇家纸板火柴。这些几乎每次都能点着！"
	icon_state = "bpacket"
	light_chance = 80
	burn_chance = 10

/obj/item/storage/fancy/cigar/matchbook/wy_gold
	name = "\improper Weyland-Yutani Gold matchbook"
	desc = "一本昂贵的纸板火柴。这些几乎每次都能点着，至少包装上是这么说的。"
	icon_state = "mpacket_wy"
	light_chance = 60
	burn_chance = 40

/obj/item/storage/fancy/cigar/matchbook/wy_gold/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

// VIAL BOX

/obj/item/storage/fancy/vials
	name = "小瓶储存盒"
	desc = "一个在你不用时存放易碎小瓶的地方。"
	icon = 'icons/obj/items/vialbox.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
	)
	icon_state = "vialbox0"
	item_state = "vialbox"
	icon_type = "vial"
	no_item_state_override = TRUE
	is_objective = TRUE
	storage_slots = 6
	storage_flags = STORAGE_FLAGS_DEFAULT|STORAGE_CLICK_GATHER
	can_hold = list(/obj/item/reagent_container/glass/beaker/vial,/obj/item/reagent_container/hypospray/autoinjector)
	matter = list("plastic" = 2000)
	var/start_vials = 6
	var/is_random


/obj/item/storage/fancy/vials/fill_preset_inventory()
	if(is_random)
		var/spawns = rand(1,4)
		for(var/i=1; i <= storage_slots; i++)
			if(i<=spawns && prob(40))
				new /obj/item/reagent_container/glass/beaker/vial/random(src)
			else
				new /obj/item/reagent_container/glass/beaker/vial(src)
	else
		for(var/i=1; i <= start_vials; i++)
			new /obj/item/reagent_container/glass/beaker/vial(src)

/obj/item/storage/fancy/vials/random
	unacidable = TRUE
	is_random = TRUE


/obj/item/storage/fancy/vials/empty
	start_vials = 0

/obj/item/storage/fancy/vials/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/storage/pouch/vials))
		var/obj/item/storage/pouch/vials/M = W
		dump_into(M,user)
	else if(istype(W, /obj/item/storage/box/autoinjectors))
		var/obj/item/storage/box/autoinjectors/M = W
		dump_into(M,user)
	else
		return ..()

/obj/item/storage/lockbox/vials
	name = "安全小瓶储存盒"
	desc = "一个上锁的盒子，用来防止儿童接触。"
	icon = 'icons/obj/items/vialbox.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
	)
	icon_state = "vialbox0"
	item_state = "vialbox"
	max_w_class = SIZE_MEDIUM
	can_hold = list(/obj/item/reagent_container/glass/beaker/vial)
	max_storage_space = 14 //The sum of the w_classes of all the items in this storage item.
	storage_slots = 6
	req_access = list(ACCESS_MARINE_MEDBAY)

/obj/item/storage/lockbox/vials/update_icon(itemremoved = 0)
	var/total_contents = length(src.contents) - itemremoved
	src.icon_state = "vialbox[total_contents]"
	src.overlays.Cut()
	if (!broken)
		overlays += image(icon, src, "led[locked]")
		if(locked)
			overlays += image(icon, src, "cover")
	else
		overlays += image(icon, src, "ledb")
	return

/obj/item/storage/lockbox/vials/attackby(obj/item/W as obj, mob/user as mob)
	..()
	update_icon()
// Trading Card Pack

/obj/item/storage/fancy/trading_card
	name = "红色维兰德-汤谷军事集换卡包"
	desc = "一包5张的红色维兰德-汤谷军事集换卡。"
	icon = 'icons/obj/items/playing_cards.dmi'
	icon_state = "trading_red_pack_closed"
	storage_slots = 5
	icon_type = "trading card"
	can_hold = list(/obj/item/toy/trading_card)
	foldable = /obj/item/stack/sheet/cardboard
	var/collection_color = null
	var/obj/item/toy/trading_card/top_trading_card

/obj/item/storage/fancy/trading_card/Initialize()
	if(!collection_color)
		collection_color = pick("red", "green", "blue") // because of vodoo shenanigans with fill_preset_inventory happening during parent's initialize this'll have to run prior to that

	. = ..()

	name = "[capitalize(collection_color)]色维兰德-汤谷军事集换卡包"
	desc = "一包5张的[capitalize(collection_color)]色维兰德-汤谷军事集换卡。"
	icon_state = "trading_[collection_color]_pack_closed"
	AddElement(/datum/element/corp_label/wy)

/obj/item/storage/fancy/trading_card/fill_preset_inventory()

	for(var/i in 1 to storage_slots)
		top_trading_card = new /obj/item/toy/trading_card(src)

/obj/item/storage/fancy/trading_card/update_icon()
	if(!(top_trading_card))
		icon_state = "trading_[collection_color]_pack_empty"
		return
	if(length(contents) == storage_slots)
		icon_state = "trading_[collection_color]_pack_closed"
		return
	icon_state = "trading_[collection_color]_pack_open"

/obj/item/storage/fancy/trading_card/attack_hand(mob/user, mods)
	if(top_trading_card?.loc == src && loc == user)
		to_chat(user, SPAN_NOTICE("你从卡包里抽出一张[top_trading_card.collection_color]色的集换卡。"))
		//have to take two disparate systems n' ram 'em together
		remove_from_storage(top_trading_card, user.loc)
		user.put_in_hands(top_trading_card)
		if(!(length(contents)))
			top_trading_card = null
			update_icon()
			return
		top_trading_card = contents[(length(contents))]
		update_icon()
		return

	return ..()

/obj/item/storage/fancy/trading_card/attackby(obj/item/attacked_by_item, mob/user)
	if(istype(attacked_by_item, /obj/item/toy/trading_card))
		top_trading_card = attacked_by_item

	return ..()

/obj/item/storage/fancy/trading_card/red
	collection_color = "red"

/obj/item/storage/fancy/trading_card/green
	collection_color = "green"

/obj/item/storage/fancy/trading_card/blue
	collection_color = "blue"
