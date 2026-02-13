/obj/item/stack/sheet/animalhide/human
	name = "人皮"
	desc = "人类养殖的副产品。"
	singular_name = "human skin piece"
	icon_state = "sheet-hide"
	sheettype = "leather"
	stack_id = "人皮"

/obj/item/stack/sheet/animalhide/corgi
	name = "柯基皮"
	desc = "柯基养殖的副产品。"
	singular_name = "corgi hide piece"
	icon_state = "sheet-corgi"
	sheettype = "leather"
	stack_id = "柯基皮"

/obj/item/stack/sheet/animalhide/cat
	name = "猫皮"
	desc = "猫养殖的副产品。"
	singular_name = "cat hide piece"
	icon_state = "sheet-cat"
	sheettype = "leather"
	stack_id = "猫皮"

/obj/item/stack/sheet/animalhide/monkey
	name = "猴皮"
	desc = "猴养殖的副产品。"
	singular_name = "monkey hide piece"
	icon_state = "sheet-monkey"
	sheettype = "leather"
	stack_id = "猴皮"

/obj/item/stack/sheet/animalhide/lizard
	name = "蜥蜴皮"
	desc = "嘶嘶嘶……"
	singular_name = "lizard skin piece"
	icon_state = "sheet-lizard"
	sheettype = "leather"
	stack_id = "蜥蜴皮"

/obj/item/stack/sheet/animalhide/xeno
	name = "异形皮"
	desc = "一种可怕生物的皮。"
	singular_name = "alien hide piece"
	icon_state = "sheet-xeno"
	sheettype = "leather"
	stack_id = "异形皮"

/obj/item/stack/sheet/animalhide/xeno/kinghide
	name = "国王皮"
	desc = "一种不规则变种的皮，它已经破烂且腐烂。"
	color = "#f7897c"

//don't see anywhere else to put these, maybe together they could be used to make the xenos suit?
/obj/item/stack/sheet/xenochitin
	name = "异形甲壳"
	desc = "一块来自可怕生物的甲壳。"
	singular_name = "alien hide piece"
	icon_state = "chitin"
	icon = 'icons/obj/items/Marine_Research.dmi'
	sheettype = "chitin"
	stack_id = "异形甲壳"

/obj/item/xenos_claw
	name = "异形爪"
	desc = "一只可怕生物的爪子。"
	icon_state = "claw"
	icon = 'icons/obj/items/Marine_Research.dmi'

/obj/item/weed_extract
	name = "菌毯提取物"
	desc = "一块黏滑、发绿的菌毯。"
	icon_state = "weed_extract"
	icon = 'icons/obj/items/Marine_Research.dmi'

/obj/item/stack/sheet/hairlesshide
	name = "无毛皮"
	desc = "这张皮已被去除毛发，但仍需鞣制。"
	singular_name = "hairless hide piece"
	icon_state = "sheet-hairlesshide"
	sheettype = "leather"
	stack_id = "无毛皮"

/obj/item/stack/sheet/wetleather
	name = "湿皮革"
	desc = "这块皮革已经清洗过，但仍需干燥。"
	singular_name = "wet leather piece"
	icon_state = "sheet-wetleather"
	sheettype = "leather"
	stack_id = "湿皮革"
	var/wetness = 30 //Reduced when exposed to high temperatures.
	var/drying_threshold_temperature = 500 //Kelvin to start drying

/obj/item/stack/sheet/leather
	name = "leather"
	desc = "群体碾压的副产品。"
	singular_name = "leather piece"
	icon_state = "sheet-leather"
	sheettype = "leather"
	stack_id = "leather"



//Step one - dehairing.

/obj/item/stack/sheet/animalhide/attackby(obj/item/W, mob/user)
	if(W.sharp)
		//visible message on mobs is defined as visible_message(message, self_message, blind_message)
		user.visible_message(SPAN_NOTICE("\the [usr] starts cutting hair off \the [src]."), SPAN_NOTICE("You start cutting the hair off \the [src]"), "You hear the sound of a knife rubbing against flesh.")
		if(do_after(user,50, INTERRUPT_ALL, BUSY_ICON_HOSTILE))
			to_chat(user, SPAN_NOTICE("你剪下了这个[src.singular_name]的头发。"))
			//Try locating an existing stack on the tile and add to there if possible
			for(var/obj/item/stack/sheet/hairlesshide/HS in user.loc)
				if(HS.amount < 50)
					HS.amount++
					src.use(1)
					break
			//If it gets to here it means it did not find a suitable stack on the tile.
			var/obj/item/stack/sheet/hairlesshide/HS = new(usr.loc)
			HS.amount = 1
			src.use(1)
	else
		return ..()


//Step two - washing..... it's actually in washing machine code.

//Step three - drying
/obj/item/stack/sheet/wetleather/fire_act(exposed_temperature, exposed_volume)
	..()
	if(exposed_temperature >= drying_threshold_temperature)
		wetness--
		if(wetness == 0)
			//Try locating an existing stack on the tile and add to there if possible
			for(var/obj/item/stack/sheet/leather/HS in src.loc)
				if(HS.amount < 50)
					HS.amount++
					src.use(1)
					wetness = initial(wetness)
					break
			//If it gets to here it means it did not find a suitable stack on the tile.
			var/obj/item/stack/sheet/leather/HS = new(src.loc)
			HS.amount = 1
			wetness = initial(wetness)
			src.use(1)
