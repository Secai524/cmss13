/obj/structure/machinery/constructable_frame/porta_comms
	name = "便携式电信单元"
	desc = "一个便携紧凑的TC-4T电信建造套件。用于在行星与星际位置之间建立子空间通信线路。需要线缆。"
	icon = 'icons/obj/structures/machinery/comm_tower2.dmi'
	icon_state = "construct_0_0"
	required_skill = SKILL_ENGINEER_TRAINED
	required_dismantle_skill = 5
	density = TRUE
	anchored = FALSE
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/machinery/constructable_frame/porta_comms/update_icon()
	..()
	var/is_wired = 0
	for(var/obj/item/I in contents)
		if(iswire(I))
			is_wired = 1
			break
	if(components)
		switch(length(components))
			if(0 to 8)
				icon_state = "construct_[length(contents)]_[is_wired]"
			else
				icon_state = "construct_8_1"
	else if(state)
		icon_state = "construct_1_0"
	else
		icon_state = "construct_0_0"

/obj/structure/machinery/constructable_frame/porta_comms/ex_act(severity)
	return

/obj/structure/machinery/constructable_frame/porta_comms/attackby(obj/item/I, mob/user)
	var/area/A = get_area(src)
	if (!A.can_build_special)
		to_chat(usr, SPAN_DANGER("你不想在这里部署这个！"))
		return
	if(istype(I, /obj/item/circuitboard/machine) && !istype(I, /obj/item/circuitboard/machine/telecomms/relay/tower))
		return
	. = ..()

