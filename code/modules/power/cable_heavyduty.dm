/obj/item/stack/cable_coil/heavyduty
	name = "重型电缆卷"
	icon = 'icons/obj/structures/machinery/power.dmi'
	icon_state = "wire"

/obj/structure/cable/heavyduty
	icon = 'icons/obj/pipes/power_cond_heavy.dmi'
	name = "大型电源线"
	desc = "这条电缆非常坚韧。无法用简单的手动工具剪断。"
	layer = BELOW_ATMOS_PIPE_LAYER

/obj/structure/cable/heavyduty/attackby(obj/item/W, mob/user)

	var/turf/T = src.loc
	if(T.intact_tile)
		return

	if(HAS_TRAIT(W, TRAIT_TOOL_WIRECUTTERS))
		to_chat(usr, SPAN_NOTICE("这些电缆太坚韧了，无法用那些[W.name]剪断。"))
		return
	else if(istype(W, /obj/item/stack/cable_coil))
		to_chat(usr, SPAN_NOTICE("你需要更粗的电缆才能连接到这些接口。"))
		return
	else
		..()

/obj/structure/cable/heavyduty/cableColor(colorC)
	return
