/obj/structure/machinery/computer/aifixer
	name = "AI系统完整性修复器"
	icon = 'icons/obj/structures/machinery/computer.dmi'
	icon_state = "ai-fixer"
	circuit = /obj/item/circuitboard/computer/aifixer
	req_one_access = list(ACCESS_CIVILIAN_ENGINEERING)
	processing = TRUE

/obj/structure/machinery/computer/aifixer/New()
	..()
	src.overlays += image('icons/obj/structures/machinery/computer.dmi', "ai-fixer-empty")

/obj/structure/machinery/computer/drone_control
	name = "维护无人机控制台"
	desc = "用于监控空间站的无人机群及其维护组装器。"
	icon = 'icons/obj/structures/machinery/computer.dmi'
	icon_state = "power"
	circuit = /obj/item/circuitboard/computer/drone_control

