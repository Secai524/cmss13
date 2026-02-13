/obj/item/storage/bible
	name = "圣经"
	desc = "一本包含那位你耳熟能详的知名人物神圣经文的书。"
	icon = 'icons/obj/items/books.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/books_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/books_righthand.dmi',
	)
	icon_state ="bible"
	throw_speed = SPEED_FAST
	throw_range = 5
	w_class = SIZE_MEDIUM
	attack_verb = list("blessed", "whacked", "purified")
	pickup_sound = "sound/handling/book_pickup.ogg"
	drop_sound = "sound/handling/book_pickup.ogg"
	cant_hold = list(
		/obj/item/tool/screwdriver,
		/obj/item/tool/crowbar,
		/obj/item/tool/weldingtool,
		/obj/item/tool/wirecutters,
		/obj/item/tool/wrench,
		/obj/item/device/multitool,
		/obj/item/device/flashlight,
		/obj/item/stack/cable_coil,
		/obj/item/device/t_scanner,
		/obj/item/device/analyzer,
		/obj/item/tool/shovel/etool,
	)
	storage_slots = null
	max_storage_space = 8
	black_market_value = 15
	var/mob/affecting = null
	var/deity_name = "Christ"

/obj/item/storage/bible/booze
	name = "Booze先生的圣经"
	desc = "如果你招惹Booze先生，你最终会穿着破烂的鞋子，所以如果你一直僵硬到以为自己死了，在你作证之后就会感觉好多了！这本圣经中包含的所有烈酒仅用于医疗目的。"

/obj/item/storage/bible/booze/fill_preset_inventory()
	new /obj/item/reagent_container/food/drinks/bottle/whiskey(src)
	new /obj/item/reagent_container/food/drinks/bottle/whiskey(src)
	new /obj/item/reagent_container/food/drinks/cans/beer(src)
	new /obj/item/reagent_container/food/drinks/cans/beer(src)

/obj/item/storage/bible/hefa
	name = "高爆破片杀伤手榴弹的圣典。"
	desc = "赞美您，Clearsmire牧师，您将我们带入弹片的光芒之中！我们宣誓效忠于HEFA之主的圣职，虽然人数不多，但我们代表沉默的大多数发声！由RESS印制。"
	icon_state ="tome_hefa"

/obj/item/storage/bible/hefa/Initialize()
	. = ..()
	new /obj/item/explosive/grenade/high_explosive/frag(src)
	new /obj/item/explosive/grenade/high_explosive/frag(src)
	new /obj/item/explosive/grenade/high_explosive/frag(src)

/obj/item/storage/bible/afterattack(atom/A, mob/user as mob, proximity)
	if(!proximity)
		return
	if(user.job == "Chaplain")
		if(A.reagents && A.reagents.has_reagent("water")) //blesses all the water in the holder
			to_chat(user, SPAN_NOTICE("你祝福了[A]。"))
			var/water2holy = A.reagents.get_reagent_amount("water")
			A.reagents.del_reagent("water")
			A.reagents.add_reagent("holywater",water2holy)

/obj/item/storage/bible/attackby(obj/item/W as obj, mob/user as mob)
	if (use_sound)
		playsound(loc, use_sound, 25, TRUE, 6)
	..()
