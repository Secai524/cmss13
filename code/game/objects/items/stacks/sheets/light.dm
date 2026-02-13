/obj/item/stack/light_w
	name = "带线玻璃砖"
	singular_name = "wired glass floor tile"
	desc = "一块不知为何接上了线的玻璃砖。"
	icon_state = "glass_wire"
	icon = 'icons/obj/items/floor_tiles.dmi'
	w_class = SIZE_MEDIUM
	force = 3
	throwforce = 5
	throw_speed = SPEED_VERY_FAST
	throw_range = 20
	max_amount = 60
	stack_id = "带线玻璃砖"

/obj/item/stack/light_w/attackby(obj/item/O as obj, mob/user as mob)
	..()
	if(HAS_TRAIT(O, TRAIT_TOOL_WIRECUTTERS))
		var/obj/item/stack/cable_coil/CC = new/obj/item/stack/cable_coil(user.loc)
		CC.amount = 5
		amount--
		new/obj/item/stack/sheet/glass(user.loc)
		if(amount <= 0)
			user.temp_drop_inv_item(src)
			qdel(src)

	if(istype(O,/obj/item/stack/sheet/metal))
		var/obj/item/stack/sheet/metal/M = O
		if (M.use(1))
			new/obj/item/stack/tile/light(user.loc, 1)
			use(1)
			to_chat(user, SPAN_NOTICE("你制作了一个发光砖块。"))
		else
			to_chat(user, SPAN_WARNING("你需要一块金属板来完成发光砖块。"))
		return
