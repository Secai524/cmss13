/obj/item/toy/trading_card
	name = "维兰德-汤谷军事集换卡"
	icon = 'icons/obj/items/playing_cards.dmi'
	icon_state = "trading_red"
	w_class = SIZE_TINY

	var/trading_card_number = "1"
	var/picture_description = "枪管增压器"
	var/collection_color
	var/is_front = FALSE
	var/back_name = "Red WeyYu Military Trading Card"
	var/front_name = "Red WeyYu Military Trading Card Number One"
	var/back_description = "The back of a red trading card with the text: WeyYu Military Trading Cards! GOTTA COLLECT EM ALL!"
	var/front_description = "A red trading card with a picture of the United Americas flag emblazoned on it. It is number one out of the five red cards."
	var/back_icon_state = "trading_red"
	var/front_icon_state = "trading_red_one"
	var/picture_descriptions = list("5" = list("red" = "a fanatical colonial seditionist", "green" = "Almirante Joelle De La Cruz (the United Americas Secretary of Defense)", "blue" = "the United Americas flag"),
									"4" = list("red" = "a UPPA soldier", "green" = "Marechal-do-ar Enzo Gabriel Lurdes (the Chief of Naval Operations of the Latin American Colonial Navy)", "blue" = "the Union of Progressive Peoples flag"),
									"3" = list("red" = "a UPPA minigunner", "green" = "Generale d'armee Felix Couture (the Commandant of the Canadian Colonial Armed Forces)", "blue" = "the Three World Empire flag"),
									"2" = list("red" = "a UPPA officer", "green" = "General Diego Dellamarggio (the Commandant of the United States Colonial Marines)", "blue" = "the Weyland Yutani logo"),
									"1" = list("red" = "a Holy Order of the HEFA cultist", "green" = "General Delyla S. Vaughn (the Assistant Commandant of the United States Colonial Marines)", "blue" = "the Independent Core System Colonies logo",)
									)

/obj/item/toy/trading_card/Initialize()
	. = ..()

	if(istype(loc, /obj/item/storage/fancy/trading_card))
		var/obj/item/storage/fancy/trading_card/packet = loc
		collection_color = packet.collection_color

	if(!collection_color)
		collection_color = pick("red", "green", "blue")
	trading_card_number = pick_weight(list("5" = 25, "4" = 20, "3" = 15, "2" = 10, "1" = 5))
	picture_description = picture_descriptions[trading_card_number][collection_color]

	name = "[capitalize(collection_color)] 维兰德-汤谷军事集换卡"
	back_name = "[capitalize(collection_color)] 维兰德-汤谷军事集换卡"
	front_name = "[capitalize(collection_color)] WeyYu Military Trading Card #[trading_card_number]"

	desc = "一张[collection_color]集换卡的背面，印有文字：维兰德-汤谷军事集换卡！全部集齐！"
	back_description = "一张[collection_color]集换卡的背面，印有文字：维兰德-汤谷军事集换卡！全部集齐！"
	front_description = "A [collection_color] trading card with a picture of [picture_description] emblazoned on it. It is #[trading_card_number] out of the five [collection_color] cards."

	icon_state = "trading_[collection_color]"
	back_icon_state = "trading_[collection_color]"
	front_icon_state = "trading_[collection_color]_[trading_card_number]"

/obj/item/toy/trading_card/attack_self(mob/user)
	if(loc == user)
		if(is_front)
			name = back_name
			desc = back_description
			icon_state = back_icon_state
			is_front = FALSE
		else
			to_chat(user, SPAN_NOTICE("你翻开了卡牌。上面有一张[picture_description]的图片！"))
			name = front_name
			desc = front_description
			icon_state = front_icon_state
			is_front = TRUE
	return ..()
