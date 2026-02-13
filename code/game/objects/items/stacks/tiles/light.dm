/obj/item/stack/tile/light
	name = "发光地板砖"
	singular_name = "发光地板砖"
	desc = "一种由玻璃制成的地板砖。它能发光。"
	icon_state = "tile_e"
	force = 3
	throwforce = 5
	attack_verb = list("bashed", "battered", "bludgeoned", "thrashed", "smashed")
	stack_id = "发光地板砖"
	turf_type = /turf/open/floor/light

/obj/item/stack/tile/light/attackby(obj/item/item_in_hand as obj, mob/user as mob)
	..()
	if (HAS_TRAIT(item_in_hand, TRAIT_TOOL_CROWBAR))
		new/obj/item/stack/sheet/metal(user.loc)
		amount--
		new/obj/item/stack/light_w(user.loc)
		if(amount <= 0)
			user.temp_drop_inv_item(src)
			qdel(src)
