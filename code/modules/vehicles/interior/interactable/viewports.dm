/obj/structure/interior_viewport
	name = "外部摄像头终端"
	desc = "连接载具外部摄像头的小型终端，可对载具周围环境进行360度视觉勘察。"
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "viewport"
	layer = INTERIOR_DOOR_LAYER

	unacidable = TRUE
	unslashable = TRUE
	explo_proof = TRUE

	// The vehicle this seat is tied to
	var/obj/vehicle/multitile/vehicle = null

/obj/structure/interior_viewport/ex_act()
	return

/obj/structure/interior_viewport/attack_hand(mob/M)
	if(!vehicle)
		return

	M.reset_view(vehicle)
	give_action(M, /datum/action/human_action/vehicle_unbuckle)

/obj/structure/interior_viewport/wy
	icon = 'icons/obj/vehicles/interiors/general_wy.dmi'

/obj/structure/interior_viewport/simple
	name = "viewport"
	desc = "嘿，我能从这里看到我的基地！"
	icon_state = "viewport_simple"

//van's frontal window viewport
/obj/structure/interior_viewport/simple/windshield
	name = "windshield"
	desc = "上次清洁是什么时候？角落里有个被压扁的虫子。"
	icon = 'icons/obj/vehicles/interiors/van.dmi'
	icon_state = "windshield_viewport_top"
	alpha = 80
