//////Kitchen Spike

/obj/structure/kitchenspike
	name = "肉叉"
	icon = 'icons/obj/structures/machinery/kitchen.dmi'
	icon_state = "spike"
	desc = "用于从动物身上收集肉的尖刺。"
	density = TRUE
	anchored = TRUE
	var/meat = 0
	var/occupied = 0
	var/meattype = 0 // 0 - Nothing, 1 - Monkey, 2 - Xeno

/obj/structure/kitchenspike/attackby(obj/item/grab/G, mob/user)
	if(!istype(G, /obj/item/grab))
		return
	to_chat(user, SPAN_DANGER("它们对这根刺来说太大了，试试小点的东西！"))

// MouseDrop_T(atom/movable/C, mob/user)
// if(istype(C, /obj/mob/carbon/monkey)
// else if(istype(C, /obj/mob/carbon/alien))
// else if(istype(C, /obj/livestock/spesscarp

/obj/structure/kitchenspike/attack_hand(mob/user as mob)
	if(..())
		return
	if(src.occupied)
		if(src.meattype == 1)
			if(src.meat > 1)
				src.meat--
				new /obj/item/reagent_container/food/snacks/meat/monkey( src.loc )
				to_chat(usr, "你从猴子身上取下了一些肉。")
			else if(src.meat == 1)
				src.meat--
				new /obj/item/reagent_container/food/snacks/meat/monkey(src.loc)
				to_chat(usr, "你取下了猴子身上的最后一块肉！")
				src.icon_state = "spike"
				src.occupied = 0
		else if(src.meattype == 2)
			if(src.meat > 1)
				src.meat--
				new /obj/item/reagent_container/food/snacks/meat/xenomeat( src.loc )
				to_chat(usr, "你从异形身上取下了一些肉。")
			else if(src.meat == 1)
				src.meat--
				new /obj/item/reagent_container/food/snacks/meat/xenomeat(src.loc)
				to_chat(usr, "你从异形身上取下了最后一块肉！")
				src.icon_state = "spike"
				src.occupied = 0
