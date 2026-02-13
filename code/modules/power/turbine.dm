/obj/structure/machinery/compressor
	name = "compressor"
	desc = "燃气涡轮发电机的压缩级。"
	icon = 'icons/obj/pipes/pipes3.dmi'
	icon_state = "compressor"
	anchored = TRUE
	density = TRUE
	var/obj/structure/machinery/power/turbine/turbine
	var/turf/inturf
	var/starter = 0
	var/rpm = 0
	var/rpmtarget = 0
	var/capacity = 1e6
	var/comp_id = 0

/obj/structure/machinery/power/turbine
	name = "燃气涡轮发电机"
	desc = "用于备用发电的燃气涡轮。"
	icon = 'icons/obj/pipes/pipes3.dmi'
	icon_state = "turbine"
	anchored = TRUE
	density = TRUE
	var/obj/structure/machinery/compressor/compressor
	directwired = 1
	var/turf/outturf
	var/lastgen

/obj/structure/machinery/computer/turbine_computer
	name = "燃气涡轮控制计算机"
	desc = "用于远程控制燃气涡轮的计算机。"
	icon = 'icons/obj/structures/machinery/computer.dmi'
	icon_state = "turbinecomp"
	circuit = /obj/item/circuitboard/computer/turbine_control
	anchored = TRUE
	density = TRUE
