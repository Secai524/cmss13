// APC interior stuff

//wall

/obj/structure/interior_wall/Initialize()
	. = ..()

	if(loc.opacity)
		loc.opacity = FALSE

/obj/structure/interior_wall/apc
	name = "\improper APC interior wall"
	icon = 'icons/obj/vehicles/interiors/apc.dmi'
	icon_state = "apc_right_1"

/obj/structure/interior_exit/vehicle/apc
	name = "装甲运兵车侧门"
	icon = 'icons/obj/vehicles/interiors/apc.dmi'
	icon_state = "exit_door"

/obj/structure/interior_exit/vehicle/apc/rear
	name = "装甲运兵车后舱门"
	icon_state = "door_rear_center"

/obj/structure/interior_exit/vehicle/apc/rear/left
	icon_state = "door_rear_left"

/obj/structure/interior_exit/vehicle/apc/rear/right
	icon_state = "door_rear_right"

/obj/structure/interior_wall/apc_pmc
	name = "\improper APC interior wall"
	icon = 'icons/obj/vehicles/interiors/apc_pmc.dmi'
	icon_state = "apc_right_1"

/obj/structure/interior_exit/vehicle/apc_pmc
	name = "装甲运兵车侧门"
	icon = 'icons/obj/vehicles/interiors/apc_pmc.dmi'
	icon_state = "exit_door"

/obj/structure/interior_exit/vehicle/apc_pmc/rear
	name = "装甲运兵车后舱门"
	icon_state = "door_rear_center"

/obj/structure/interior_exit/vehicle/apc_pmc/rear/left
	icon_state = "door_rear_left"

/obj/structure/interior_exit/vehicle/apc_pmc/rear/right
	icon_state = "door_rear_right"

/obj/structure/prop/vehicle
	name = "通用载具道具"
	desc = "为载具内部增添更多细节。"

	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = ""

	unacidable = TRUE
	unslashable = TRUE
	breakable = FALSE
	explo_proof = TRUE

/obj/structure/prop/vehicle/firing_port_weapon
	name = "M56固定式武器站握把"
	desc = "A control handle for a modified M56A2 Smartgun installed on the sides of M577 Armored Personnel Carrier as a Firing Port Weapon. \
	Used by support gunners to cover friendly infantry entering or exiting APC via side doors. \
	For ease of use, firing ports are marked with green (right side) and red (left side) marks. \
	Do not be mistaken however, this is not a piece of an actual weapon, but a joystick made in a familiar to marines form."

	icon = 'icons/obj/vehicles/interiors/apc.dmi'
	icon_state = "m56_FPW"

	density = FALSE

	var/obj/structure/bed/chair/comfy/vehicle/support_gunner/SG_seat

/obj/structure/prop/vehicle/firing_port_weapon/get_examine_text(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	if(!SG_seat)
		SG_seat = locate() in get_turf(src)
		if(!SG_seat)
			. += SPAN_WARNING("发生错误！未找到座位，请通知开发人员！")
			return
	for(var/obj/item/hardpoint/special/firing_port_weapon/FPW in SG_seat.vehicle.hardpoints)
		if(FPW.allowed_seat == SG_seat.seat)
			if(FPW.ammo)
				. += SPAN_NOTICE("[FPW.name]的弹药数量为：[SPAN_HELPFUL(FPW.ammo.current_rounds)]/[SPAN_WARNING(FPW.ammo.max_rounds)]。")
				break
	. += SPAN_HELPFUL("Clicking on the [name] while being adjacent to support gunner seat will buckle you in and give you the control of the M56 FPW.")

/obj/structure/prop/vehicle/firing_port_weapon/attack_hand(mob/living/carbon/human/H)
	if(!istype(H))
		return
	if(!SG_seat)
		SG_seat = locate() in get_turf(src)
		if(!SG_seat)
			to_chat(H, SPAN_WARNING("发生错误！未找到座位，请通知开发人员！"))
			return
	if(!SG_seat.buckled_mob && !H.buckled)
		SG_seat.do_buckle(H, H)
		for(var/obj/item/hardpoint/special/firing_port_weapon/FPW in SG_seat.vehicle.hardpoints)
			if(FPW.allowed_seat == SG_seat.seat)
				if(FPW.ammo)
					to_chat(H, SPAN_NOTICE("[FPW.name]的弹药数量为：[SPAN_HELPFUL(FPW.ammo.current_rounds)]/[SPAN_WARNING(FPW.ammo.max_rounds)]。"))
					break
		return

/obj/structure/prop/vehicle/sensor_equipment
	name = "数据分析中枢"
	desc = "这台机器收集并分析来自M577指挥型装甲运兵车传感器集群的数据，然后将结果反馈给阿尔迈耶号的战术地图显示网络。最好别碰它。"

	icon = 'icons/obj/vehicles/interiors/apc.dmi'
	icon_state = "sensors_equipment"
