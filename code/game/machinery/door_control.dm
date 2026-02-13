#define CONTROL_POD_DOORS 0
#define CONTROL_NORMAL_DOORS 1
#define CONTROL_EMITTERS 2
#define CONTROL_DROPSHIP 3

/obj/structure/machinery/door_control
	name = "远程门控器"
	desc = "它能远程控制门。"
	icon = 'icons/obj/structures/props/stationobjs.dmi'
	icon_state = "doorctrl"
	desc = "一个用于门的远程控制开关。"
	power_channel = POWER_CHANNEL_ENVIRON
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE
	var/id = null
	var/range = 10
	var/normaldoorcontrol = CONTROL_POD_DOORS
	var/desiredstate = 0 // Zero is closed, 1 is open.
	var/specialfunctions = 1
	/*
	Bitflag, 1= open
				2= idscan,
				4= bolts
				8= shock
				16= door safties

	*/

	var/exposedwires = 0
	var/wires = 3
	/*
	Bitflag, 1=checkID
				2=Network Access
	*/

	anchored = TRUE
	use_power = USE_POWER_IDLE
	idle_power_usage = 2
	active_power_usage = 4

	appearance_flags = TILE_BOUND

/obj/structure/machinery/door_control/attack_remote(mob/user as mob)
	if(wires & 2)
		return src.attack_hand(user)
	else
		to_chat(user, "错误，无法连接到主机。")

/obj/structure/machinery/door_control/attack_alien(mob/user as mob)
	return

/obj/structure/machinery/door_control/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	return TAILSTAB_COOLDOWN_NONE

/obj/structure/machinery/door_control/attackby(obj/item/W, mob/user as mob)
	return src.attack_hand(user)

/obj/structure/machinery/door_control/ex_act(severity)
	if(explo_proof)
		return FALSE
	..()

/obj/structure/machinery/door_control/proc/handle_dropship(ship_id)
	var/obj/docking_port/mobile/marine_dropship/shuttle = SSshuttle.getShuttle(ship_id)
	if (!istype(shuttle))
		return
	var/obj/structure/machinery/computer/shuttle/dropship/flight/comp = shuttle.getControlConsole()
	if(comp?.dropship_control_lost)
		return
	if(is_mainship_level(z)) // on the almayer
		return

	shuttle.control_doors("force-lock", "all", force=FALSE)

/obj/structure/machinery/door_control/proc/handle_door()
	for(var/obj/structure/machinery/door/airlock/D in range(range))
		if(D.id_tag == src.id)
			if(specialfunctions & OPEN)
				if (D.density)
					INVOKE_ASYNC(D, TYPE_PROC_REF(/obj/structure/machinery/door, open))
				else
					INVOKE_ASYNC(D, TYPE_PROC_REF(/obj/structure/machinery/door, close))
			if(desiredstate == 1)
				if(specialfunctions & IDSCAN)
					D.remoteDisabledIdScanner = 1
				if(specialfunctions & BOLTS)
					D.lock()
				if(specialfunctions & SHOCK)
					D.secondsElectrified = -1
				if(specialfunctions & SAFE)
					D.safe = 0
			else
				if(specialfunctions & IDSCAN)
					D.remoteDisabledIdScanner = 0
				if(specialfunctions & BOLTS)
					if(!D.isWireCut(4) && D.arePowerSystemsOn())
						D.unlock()
				if(specialfunctions & SHOCK)
					D.secondsElectrified = 0
				if(specialfunctions & SAFE)
					D.safe = 1

/obj/structure/machinery/door_control/proc/handle_pod()
	for(var/obj/structure/machinery/door/poddoor/M in GLOB.machines)
		if(M.id == id)
			if(M.density)
				INVOKE_ASYNC(M, TYPE_PROC_REF(/obj/structure/machinery/door, open))
			else
				INVOKE_ASYNC(M, TYPE_PROC_REF(/obj/structure/machinery/door, close))

/obj/structure/machinery/door_control/verb/push_button()
	set name = "Push Button"
	set category = "Object"
	if(isliving(usr))
		var/mob/living/L = usr
		attack_hand(L)

/obj/structure/machinery/door_control/attack_hand(mob/living/user)
	add_fingerprint(user)
	if(istype(user,/mob/living/carbon/xenomorph))
		return
	use_button(user)

/obj/structure/machinery/door_control/proc/use_button(mob/living/user, force = FALSE)
	if(inoperable())
		to_chat(user, SPAN_WARNING("[src]似乎无法工作。"))
		return

	if(!allowed(user) && (wires & 1) && !force )
		to_chat(user, SPAN_DANGER("权限被拒绝。"))
		flick(initial(icon_state) + "-denied",src)
		return

	use_power(5)
	icon_state = initial(icon_state) + "1"
	add_fingerprint(user)
	to_chat(user, SPAN_NOTICE("你按下了\the [name]按钮。"))

	switch(normaldoorcontrol)
		if(CONTROL_NORMAL_DOORS)
			handle_door()
		if(CONTROL_POD_DOORS)
			handle_pod()
		if(CONTROL_DROPSHIP)
			handle_dropship(id)

	desiredstate = !desiredstate
	spawn(15)
		if(!(stat & NOPOWER))
			icon_state = initial(icon_state) + "0"

/obj/structure/machinery/door_control/power_change()
	..()
	if(stat & NOPOWER)
		icon_state = initial(icon_state) + "-p"
	else
		icon_state = initial(icon_state) + "0"

// Controls elevator railings
/obj/structure/machinery/door_control/railings
	name = "护栏控制器"
	desc = "当车辆ASRS电梯升起时，用于升降其防护栏。"
	id = "vehicle_elevator_railing_aux"
	gender = PLURAL
	var/busy = FALSE

/obj/structure/machinery/door_control/railings/use_button(mob/living/user, force = FALSE)
	if(inoperable())
		to_chat(user, SPAN_WARNING("[src]似乎无法工作。"))
		return

	if(busy)
		flick(initial(icon_state) + "-denied",src)
		return

	if(!allowed(user) && (wires & 1) && !force)
		to_chat(user, SPAN_DANGER("权限被拒绝。"))
		flick(initial(icon_state) + "-denied",src)
		return

	if(!SSshuttle.vehicle_elevator)
		flick(initial(icon_state) + "-denied",src)
		return

	// If someone's trying to lower the railings but the elevator isn't in the vehicle bay.
	if(!desiredstate && !is_mainship_level(SSshuttle.vehicle_elevator.z))
		flick(initial(icon_state) + "-denied", src) // Safety first!
		return

	use_power(5)
	icon_state = initial(icon_state) + "1"
	busy = TRUE
	add_fingerprint(user)

	var/effective = 0
	for(var/obj/structure/machinery/door/poddoor/M in GLOB.machines)
		if(M.id == id)
			effective = 1
			spawn()
				if(desiredstate)
					M.open()
				else
					M.close()
	if(effective)
		playsound(get_turf(SSshuttle.vehicle_elevator), 'sound/machines/elevator_openclose.ogg', 50, 0)

	desiredstate = !desiredstate
	spawn(15)
		busy = FALSE
		if(!(stat & NOPOWER))
			icon_state = initial(icon_state) + "0"

/obj/structure/machinery/door_control/yautja
	icon = 'icons/obj/structures/machinery/yautja_machines.dmi'

/obj/structure/machinery/door_control/brbutton
	icon_state = "big_red_button_wallv"


/obj/structure/machinery/door_control/brbutton/alt
	icon_state = "big_red_button_tablev"

/obj/structure/machinery/door_control/airlock
	icon = 'icons/obj/structures/machinery/computer.dmi'
	icon_state = "elevator_screen"

/obj/structure/machinery/door_control/airlock/use_button(mob/living/user, force = FALSE)
	if(inoperable())
		to_chat(user, SPAN_WARNING("\The [src] doesn't seem to be working."))
		return

	use_power(5)
	add_fingerprint(user)
	to_chat(user, SPAN_NOTICE("你按下了\the [name]按钮。"))

	switch(normaldoorcontrol)
		if(CONTROL_NORMAL_DOORS)
			handle_door()
		if(CONTROL_POD_DOORS)
			handle_pod()
		if(CONTROL_DROPSHIP)
			handle_dropship(id)

	desiredstate = !desiredstate

/obj/structure/machinery/door_control/cl
	req_access_txt = "200"
	needs_power = FALSE
	use_power = FALSE

// seperating quarter and office because we might want to allow more access to the office than quarter in the future.
/obj/structure/machinery/door_control/cl/office

/obj/structure/machinery/door_control/cl/office/lobby_door
	name = "大厅门闸"
	id = "cl_lobby_door"

/obj/structure/machinery/door_control/cl/office/office_door
	name = "办公室门闸"
	id = "cl_office_door_s"

/obj/structure/machinery/door_control/cl/office/office_door_remote
	name = "办公室门控制器"
	id = "cl_office_door"
	normaldoorcontrol = TRUE


/obj/structure/machinery/door_control/cl/office/lobby_window
	name = "大厅窗户闸门"
	id = "cl_lobby_windows"

/obj/structure/machinery/door_control/cl/office/office_window
	name = "办公室窗户闸门"
	id = "cl_office_windows"

/obj/structure/machinery/door_control/cl/office/divider
	name = "房间隔断"
	id = "RoomDivider"

//special button that unlock the cl lock on is evac pod door bypassing general lockdown.
/obj/structure/machinery/door_control/cl/office/evac
	name = "逃生舱门控制器"
	id = "cl_evac"
	normaldoorcontrol = 1

/obj/structure/machinery/door_control/cl/quarter

/obj/structure/machinery/door_control/cl/quarter/office_door
	name = "舱室门闸"
	id = "cl_quarter_door"

/obj/structure/machinery/door_control/cl/quarter/backdoor
	name = "维修门闸"
	id = "cl_quarter_maintenance"

/obj/structure/machinery/door_control/cl/quarter/windows
	name = "舱室窗户闸门"
	id = "cl_quarter_windows"

// Hybrisa lockdown announcements

/obj/structure/machinery/door_control/colony_lockdown
	var/used = FALSE
	var/colony_lockdown_time = 25 MINUTES

/obj/structure/machinery/door_control/colony_lockdown/use_button(mob/living/user,force)
	if(world.time < SSticker.mode.round_time_lobby + colony_lockdown_time)
		to_chat(user, SPAN_WARNING("全殖民地封锁尚无法解除。请再等待[floor((SSticker.mode.round_time_lobby + colony_lockdown_time-world.time)/600)]分钟后再试。"))
		return
	if(used)
		to_chat(user, SPAN_WARNING("全殖民地封锁已经解除。"))
		return
	. = ..()
	marine_announcement("全殖民地封锁协议已解除。")
	used = TRUE

// Research

/obj/structure/machinery/door_control/research_lockdown
	var/used = FALSE
	var/colony_lockdown_time = 10 MINUTES

/obj/structure/machinery/door_control/research_lockdown/use_button(mob/living/user,force)
	if(world.time < SSticker.mode.round_time_lobby + colony_lockdown_time)
		to_chat(user, SPAN_WARNING("维兰德研究设施封锁尚无法解除。请再等待[floor((SSticker.mode.round_time_lobby + colony_lockdown_time-world.time)/600)]分钟后再试。"))
		return
	if(used)
		to_chat(user, SPAN_WARNING("维兰德研究设施封锁已经解除。"))
		return
	. = ..()
	marine_announcement("维兰德研究设施封锁协议已解除。")
	used = TRUE
