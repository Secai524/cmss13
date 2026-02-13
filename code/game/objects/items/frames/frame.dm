
//items that are frames or assembly used to construct something (table parts, camera assembly, etc...)

/obj/item/frame
	appearance_flags = TILE_BOUND

// APC FRAME

/obj/item/frame/apc
	name = "\improper APC frame"
	desc = "用于维修或建造装甲运兵车。"
	icon = 'icons/obj/structures/machinery/apc.dmi'
	icon_state = "apc_frame"
	flags_atom = FPRINT|CONDUCT

/obj/item/frame/apc/attackby(obj/item/W as obj, mob/user as mob)
	..()
	if (HAS_TRAIT(W, TRAIT_TOOL_WRENCH))
		new /obj/item/stack/sheet/metal( get_turf(src.loc), 2 )
		qdel(src)

/obj/item/frame/apc/proc/try_build(turf/on_wall)
	if (get_dist(on_wall,usr)>1)
		return
	var/ndir = get_dir(usr,on_wall)
	if (!(ndir in GLOB.cardinals))
		return
	var/turf/loc = get_turf(usr)
	var/area/A = get_area(loc)
	if (!istype(loc, /turf/open/floor))
		to_chat(usr, SPAN_WARNING("此处无法放置装甲运兵车。"))
		return
	if (A.requires_power == 0 || istype(A, /area/space))
		to_chat(usr, SPAN_WARNING("此区域无法放置装甲运兵车。"))
		return
	if (A.get_apc())
		to_chat(usr, SPAN_WARNING("此区域已有装甲运兵车。"))
		return //only one APC per area
	if (A.always_unpowered)
		to_chat(usr, SPAN_WARNING("此区域不适合放置装甲运兵车。"))
		return
	for(var/obj/structure/terminal/T in loc)
		if (T.master)
			to_chat(usr, SPAN_WARNING("此处已有另一个网络终端。"))
			return
		else
			var/obj/item/stack/cable_coil/C = new /obj/item/stack/cable_coil(loc)
			C.amount = 10
			to_chat(usr, "你切断电缆并拆解了未使用的电源终端。")
			qdel(T)
	new /obj/structure/machinery/power/apc(loc, ndir, 1)
	qdel(src)
