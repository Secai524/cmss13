/obj/structure/machinery/cm_vending/sorted/walkman
	name = "\improper 回收-贩卖"
	desc = "内含维兰德-汤谷批准的娱乐物品，例如随身听和纸牌。"
	icon_state = "walkman"
	wrenchable = TRUE
	hackable = TRUE
	vendor_theme = VENDOR_THEME_COMPANY
	vend_delay = 0.5 SECONDS

/obj/structure/machinery/cm_vending/sorted/walkman/get_listed_products(mob/user)
	return GLOB.cm_vending_walkman

GLOBAL_LIST_INIT(cm_vending_walkman, list(
	list("随身听", -1, null, null),
	list("蓝色卡带", 10, /obj/item/device/cassette_tape/pop1, VENDOR_ITEM_REGULAR),
	list("蓝色条纹磁带", 10, /obj/item/device/cassette_tape/hiphop, VENDOR_ITEM_REGULAR),
	list("绿色卡带", 10, /obj/item/device/cassette_tape/nam, VENDOR_ITEM_REGULAR),
	list("海洋卡带", 10, /obj/item/device/cassette_tape/ocean, VENDOR_ITEM_REGULAR),
	list("橙色卡带", 10, /obj/item/device/cassette_tape/pop3, VENDOR_ITEM_REGULAR),
	list("粉色卡带", 10, /obj/item/device/cassette_tape/pop4, VENDOR_ITEM_REGULAR),
	list("彩虹卡带", 10, /obj/item/device/cassette_tape/pop2, VENDOR_ITEM_REGULAR),
	list("红黑卡带", 10, /obj/item/device/cassette_tape/heavymetal, VENDOR_ITEM_REGULAR),
	list("红色条纹磁带", 10, /obj/item/device/cassette_tape/hairmetal, VENDOR_ITEM_REGULAR),
	list("旭日卡带", 10, /obj/item/device/cassette_tape/indie, VENDOR_ITEM_REGULAR),
	list("随身听", 50, /obj/item/device/walkman, VENDOR_ITEM_REGULAR),
	list("卡带袋", 15, /obj/item/storage/pouch/cassette, VENDOR_ITEM_REGULAR),

	list("卡牌", -1, null, null),
	list("扑克牌", 5, /obj/item/toy/deck, VENDOR_ITEM_REGULAR),
	list("UNO卡牌组", 5, /obj/item/toy/deck/uno, VENDOR_ITEM_REGULAR)
))

/obj/structure/machinery/cm_vending/sorted/walkman/stock(obj/item/item_to_stock, mob/user)
	var/list/R
	for(R in (listed_products))
		if(item_to_stock.type == R[3])
			if(istype(item_to_stock,/obj/item/device/walkman))
				var/obj/item/device/walkman/W = item_to_stock
				if(W.tape)
					to_chat(user,SPAN_WARNING("先把胶带撕掉！"))
					return

			if(item_to_stock.loc == user) //Inside the mob's inventory
				if(item_to_stock.flags_item & WIELDED)
					item_to_stock.unwield(user)
				user.temp_drop_inv_item(item_to_stock)

			if(isstorage(item_to_stock.loc)) //inside a storage item
				var/obj/item/storage/S = item_to_stock.loc
				S.remove_from_storage(item_to_stock, user.loc)

			qdel(item_to_stock)
			user.visible_message(SPAN_NOTICE("[user]向[src]补充了\a [R[1]]。"),
			SPAN_NOTICE("You stock [src] with \a [R[1]]."))
			R[2]++
			updateUsrDialog()
			return //We found our item, no reason to go on.
