/obj/structure/machinery/ignition_switch
	name = "点火开关"
	icon = 'icons/obj/structures/props/stationobjs.dmi'
	icon_state = "launcherbtt"
	desc = "用于已安装点火器的遥控开关。"
	var/id = null
	var/active = 0
	anchored = TRUE
	use_power = USE_POWER_IDLE
	idle_power_usage = 2
	active_power_usage = 4

/obj/structure/machinery/flasher_button
	name = "闪光器按钮"
	desc = "用于已安装闪光器的遥控开关。"
	icon = 'icons/obj/structures/props/stationobjs.dmi'
	icon_state = "launcherbtt"
	var/id = null
	var/active = 0
	anchored = TRUE
	use_power = USE_POWER_IDLE
	idle_power_usage = 2
	active_power_usage = 4

/obj/structure/machinery/crema_switch
	desc = "烧吧，宝贝，烧吧！"
	name = "焚化炉点火器"
	icon = 'icons/obj/structures/machinery/power.dmi'
	icon_state = "light0"
	anchored = TRUE
	req_access = list(ACCESS_MARINE_MEDBAY)
	var/on = 0
	var/area/area = null
	var/otherarea = null
	var/id = 1
