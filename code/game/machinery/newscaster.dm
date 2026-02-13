/obj/structure/machinery/newscaster
	name = "newscaster"
	desc = "一台标准的维兰德-汤谷授权新闻播报器，用于商业空间站。所有你绝对用不上的新闻，都在这儿了！"
	icon = 'icons/obj/structures/machinery/terminals.dmi'
	icon_state = "newscaster_normal"
	anchored = TRUE

/obj/structure/machinery/newscaster/security_unit
	name = "安保新闻播报器"

/obj/item/newspaper
	name = "newspaper"
	desc = "一份《狮鹫报》，这份报纸在维兰德-汤谷空间站上流通。"
	icon = 'icons/obj/items/paper.dmi'
	item_icons = list(
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/tools.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/paperwork_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/paperwork_righthand.dmi'
	)
	icon_state = "newspaper"
	w_class = SIZE_TINY //Let's make it fit in trashbags!
	attack_verb = list("bapped")
