#define DEFAULT_MAP_SIZE 15

/obj/structure/machinery/computer/cameras
	name = "安保摄像头控制台"
	desc = "用于访问空间站上的各个摄像头。"
	icon_state = "cameras"
	var/obj/structure/machinery/camera/current
	var/list/network = list(CAMERA_NET_MILITARY)
	circuit = /obj/item/circuitboard/computer/cameras

	/// The turf where the camera was last updated.
	var/turf/last_camera_turf
	var/list/concurrent_users = list()

	// Stuff needed to render the map
	var/camera_map_name

	var/colony_camera_mapload = TRUE
	var/admin_console = FALSE
	var/stay_connected = FALSE

/obj/structure/machinery/computer/cameras/Initialize(mapload)
	. = ..()

	RegisterSignal(src, COMSIG_CAMERA_MAPNAME_ASSIGNED, PROC_REF(camera_mapname_update))

	// camera setup
	AddComponent(/datum/component/camera_manager)
	SEND_SIGNAL(src, COMSIG_CAMERA_CLEAR)

	if(colony_camera_mapload && mapload && is_ground_level(z))
		if(SSmapping.configs[GROUND_MAP].map_name == MAP_WHISKEY_OUTPOST)
			return FALSE
		network = list(CAMERA_NET_COLONY)


/obj/structure/machinery/computer/cameras/Destroy()
	SStgui.close_uis(src)
	current = null
	UnregisterSignal(src, COMSIG_CAMERA_MAPNAME_ASSIGNED)
	last_camera_turf = null
	concurrent_users = null
	return ..()

/obj/structure/machinery/computer/cameras/proc/camera_mapname_update(source, value)
	camera_map_name = value

/obj/structure/machinery/computer/cameras/attack_remote(mob/user as mob)
	return attack_hand(user)

/obj/structure/machinery/computer/cameras/attack_hand(mob/user)
	if(!admin_console && should_block_game_interaction(src))
		to_chat(user, SPAN_DANGER("<b>无法建立连接</b>: \black 你离飞船太远了！"))
		return
	if(inoperable())
		return
	if(!isRemoteControlling(user))
		user.set_interaction(src)
	tgui_interact(user)

/obj/structure/machinery/computer/cameras/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	if(inoperable())
		return UI_DISABLED

//Closes UI if you move away from console.
/obj/structure/machinery/computer/cameras/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/computer/cameras/tgui_interact(mob/user, datum/tgui/ui)
	// Update UI
	ui = SStgui.try_update_ui(user, src, ui)

	SEND_SIGNAL(src, COMSIG_CAMERA_REFRESH)

	if(!ui)
		var/user_ref = WEAKREF(user)
		var/is_living = isliving(user)
		// Ghosts shouldn't count towards concurrent users, which produces
		// an audible terminal_on click.
		if(is_living)
			concurrent_users += user_ref
		// Turn on the console
		if(length(concurrent_users) == 1 && is_living)
			update_use_power(USE_POWER_ACTIVE)

		SEND_SIGNAL(src, COMSIG_CAMERA_REGISTER_UI, user)

		// Open UI
		ui = new(user, src, "CameraConsole", name)
		ui.open()

/obj/structure/machinery/computer/cameras/ui_data()
	var/list/data = list()
	data["network"] = network
	data["activeCamera"] = null
	if(current)
		data["activeCamera"] = list(
			name = current.c_tag,
			status = current.status,
		)
	return data

/obj/structure/machinery/computer/cameras/ui_static_data()
	var/list/data = list()
	data["mapRef"] = camera_map_name
	var/list/cameras = get_available_cameras()
	data["cameras"] = list()
	for(var/i in cameras)
		var/obj/structure/machinery/camera/C = cameras[i]
		data["cameras"] += list(list(
			name = C.c_tag,
		))

	return data

/obj/structure/machinery/computer/cameras/ui_act(action, params)
	. = ..()
	if(.)
		return

	if(action == "switch_camera")
		var/c_tag = params["name"]
		var/list/cameras = get_available_cameras()
		var/obj/structure/machinery/camera/selected_camera
		selected_camera = cameras[c_tag]
		// Unicode breaks c_tags
		// Currently the only issues with character names comes from the improper or proper tags and so we strip and recheck if not found.
		if(!selected_camera)
			for(var/I in cameras)
				if(strip_improper(I) == c_tag)
					selected_camera = cameras[I]
					break
		current = selected_camera
		playsound(src, get_sfx("terminal_type"), 25, FALSE)

		if(!selected_camera)
			return TRUE

		SEND_SIGNAL(src, COMSIG_CAMERA_SET_TARGET, selected_camera, selected_camera.view_range, selected_camera.view_range)

		return TRUE


/obj/structure/machinery/computer/cameras/ui_close(mob/user)
	var/user_ref = WEAKREF(user)
	var/is_living = isliving(user)
	// Living creature or not, we remove you anyway.
	concurrent_users -= user_ref
	// Unregister map objects
	SEND_SIGNAL(src, COMSIG_CAMERA_UNREGISTER_UI, user)
	// Turn off the console
	if(length(concurrent_users) == 0 && is_living && !stay_connected)
		current = null
		SEND_SIGNAL(src, COMSIG_CAMERA_CLEAR)
		last_camera_turf = null
		if(use_power)
			update_use_power(USE_POWER_IDLE)
	user.unset_interaction()

// Returns the list of cameras accessible from this computer
/obj/structure/machinery/computer/cameras/proc/get_available_cameras()
	var/list/D = list()
	for(var/obj/structure/machinery/camera/C in GLOB.all_cameras)
		if(!C.network)
			stack_trace("Camera in a cameranet has no camera network")
			continue
		if(!(islist(C.network)))
			stack_trace("Camera in a cameranet has a non-list camera network")
			continue
		var/list/tempnetwork = C.network & network
		if(length(tempnetwork))
			D["[C.c_tag]"] = C
	return D

/obj/structure/machinery/computer/cameras/telescreen
	name = "远程屏幕"
	desc = "用于观看一个空荡荡的竞技场。"
	icon = 'icons/obj/structures/props/stationobjs.dmi'
	icon_state = "telescreen"
	network = list("thunder")
	density = FALSE
	circuit = null

/obj/structure/machinery/computer/cameras/telescreen/update_icon()
	icon_state = initial(icon_state)
	if(stat & BROKEN)
		icon_state += "b"
	return

/obj/structure/machinery/computer/cameras/telescreen/entertainment
	name = "娱乐显示器"
	desc = "该死，为什么这些东西上从来没有什么有趣的内容？"
	icon = 'icons/obj/structures/machinery/status_display.dmi'
	icon_state = "entertainment"
	circuit = null

/obj/structure/machinery/computer/cameras/wooden_tv
	name = "安保摄像头"
	desc = "一台连接到空间站摄像头网络的老式电视。"
	icon_state = "security_det"
	circuit = null

/obj/structure/machinery/computer/cameras/wooden_tv/almayer
	name = "飞船安保摄像头"
	network = list(CAMERA_NET_ALMAYER)

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast
	name = "电视机"
	desc = "一台连接到录像机的老式电视，你甚至可以用它来录制WOW节目。"
	network = list(CAMERA_NET_CORRESPONDENT)
	stay_connected = TRUE
	wrenchable = TRUE
	circuit = /obj/item/circuitboard/computer/cameras/tv
	var/obj/item/device/broadcasting/broadcastingcamera = null

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast/Destroy()
	broadcastingcamera = null
	return ..()

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast/ui_state(mob/user)
	return GLOB.in_view

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast/ui_act(action, params)
	. = ..()
	if(action != "switch_camera")
		return
	if(broadcastingcamera)
		clear_camera()
	if(!istype(current, /obj/structure/machinery/camera/correspondent))
		return
	var/obj/structure/machinery/camera/correspondent/corr_cam = current
	if(!corr_cam.linked_broadcasting)
		return
	broadcastingcamera = corr_cam.linked_broadcasting
	RegisterSignal(broadcastingcamera, COMSIG_BROADCAST_GO_LIVE, PROC_REF(go_back_live))
	RegisterSignal(broadcastingcamera, COMSIG_COMPONENT_ADDED, PROC_REF(handle_rename))
	RegisterSignal(broadcastingcamera, COMSIG_PARENT_QDELETING, PROC_REF(clear_camera))
	RegisterSignal(broadcastingcamera, COMSIG_BROADCAST_HEAR_TALK, PROC_REF(transfer_talk))
	RegisterSignal(broadcastingcamera, COMSIG_BROADCAST_SEE_EMOTE, PROC_REF(transfer_emote))

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast/ui_close(mob/user)
	. = ..()
	if(!broadcastingcamera)
		return
	if(!current)
		clear_camera()

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast/inoperable(additional_flags = 0)
	return ..(MAINT|additional_flags)

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast/attackby(obj/item/wrench, mob/user)
	if(HAS_TRAIT(wrench, TRAIT_TOOL_WRENCH))
		if(user.action_busy)
			return TRUE
		toggle_anchored(wrench, user)
		return TRUE
	. = ..()

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast/toggle_anchored(obj/item/wrench, mob/user)
	. = ..()
	if(!.)
		return
	if(!anchored)
		stat |= MAINT
		clear_camera()
		current = null
		SEND_SIGNAL(src, COMSIG_CAMERA_CLEAR)
	else
		stat &= ~MAINT
	update_icon()

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast/update_icon()
	. = ..()
	if(stat & BROKEN)
		return
	if(stat & MAINT)
		icon_state = initial(icon_state)
		icon_state += "0"

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast/proc/clear_camera()
	SIGNAL_HANDLER
	UnregisterSignal(broadcastingcamera, list(COMSIG_BROADCAST_GO_LIVE, COMSIG_PARENT_QDELETING, COMSIG_COMPONENT_ADDED, COMSIG_BROADCAST_HEAR_TALK, COMSIG_BROADCAST_SEE_EMOTE))
	broadcastingcamera = null

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast/proc/go_back_live(obj/item/device/broadcasting/broadcastingcamera)
	SIGNAL_HANDLER
	if(current.c_tag == broadcastingcamera.get_broadcast_name())
		current = broadcastingcamera.linked_cam
		SEND_SIGNAL(src, COMSIG_CAMERA_SET_TARGET, broadcastingcamera.linked_cam, broadcastingcamera.linked_cam.view_range, broadcastingcamera.linked_cam.view_range)

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast/proc/transfer_talk(obj/item/camera, mob/living/sourcemob, message, verb = "says", datum/language/language, italics = FALSE, show_message_above_tv = FALSE)
	SIGNAL_HANDLER
	if(inoperable())
		return
	if(show_message_above_tv)
		langchat_speech(message, get_mobs_in_view(7, src), language, sourcemob.langchat_color, FALSE, LANGCHAT_FAST_POP, list(sourcemob.langchat_styles))
	for(var/datum/weakref/user_ref in concurrent_users)
		var/mob/user = user_ref.resolve()
		if(user?.client?.prefs && !user.client.prefs.lang_chat_disabled && !user.ear_deaf && user.say_understands(sourcemob, language))
			sourcemob.langchat_display_image(user)

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast/proc/transfer_emote(obj/item/camera, mob/living/sourcemob, emote, audible = FALSE, show_message_above_tv = FALSE)
	SIGNAL_HANDLER
	if(inoperable())
		return
	if(show_message_above_tv)
		langchat_speech(emote, get_mobs_in_view(7, src), skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("emote"))
	for(var/datum/weakref/user_ref in concurrent_users)
		var/mob/user = user_ref.resolve()
		if(user?.client?.prefs && (user.client.prefs.toggles_langchat & LANGCHAT_SEE_EMOTES) && (!audible || !user.ear_deaf))
			sourcemob.langchat_display_image(user)

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast/examine(mob/user)
	. = ..()
	attack_hand(user) //watch tv on examine

/obj/structure/machinery/computer/cameras/wooden_tv/broadcast/proc/handle_rename(obj/item/camera, datum/component/label)
	SIGNAL_HANDLER
	if(!istype(label, /datum/component/label))
		return
	current.c_tag = broadcastingcamera.get_broadcast_name()

/obj/structure/machinery/computer/cameras/wooden_tv/ot
	name = "迫击炮监控台"
	desc = "一个连接到迫击炮发射摄像头的控制台。"
	network = list(CAMERA_NET_MORTAR)

/obj/structure/machinery/computer/cameras/mining
	name = "前哨摄像头"
	icon = 'icons/obj/structures/machinery/computer.dmi'
	desc = "用于访问前哨站的各种摄像头。"
	icon_state = "cameras"
	network = list("MINE")
	circuit = /obj/item/circuitboard/computer/cameras/mining

/obj/structure/machinery/computer/cameras/engineering
	name = "工程部摄像头"
	icon = 'icons/obj/structures/machinery/computer.dmi'
	desc = "用于监控火灾和破口。"
	icon_state = "cameras"
	network = list("工程部","Power Alarms","Atmosphere Alarms","Fire Alarms")
	circuit = /obj/item/circuitboard/computer/cameras/engineering

/obj/structure/machinery/computer/cameras/nuclear
	name = "任务监控器"
	icon = 'icons/obj/structures/machinery/computer.dmi'
	desc = "用于访问头盔内置摄像头。"
	icon_state = "syndicam"
	network = list("NUKE")
	circuit = null


/obj/structure/machinery/computer/cameras/almayer
	density = FALSE
	icon_state = "security_cam"
	network = list(CAMERA_NET_ALMAYER)

/obj/structure/machinery/computer/cameras/almayer/containment
	name = "收容区摄像头"
	network = list(CAMERA_NET_CONTAINMENT)

/obj/structure/machinery/computer/cameras/almayer/ares
	name = "ARES核心摄像头"
	network = list(CAMERA_NET_ARES)

/obj/structure/machinery/computer/cameras/almayer/vehicle
	name = "飞船安保摄像头"
	network = list(CAMERA_NET_ALMAYER, CAMERA_NET_VEHICLE)

/obj/structure/machinery/computer/cameras/hangar
	name = "运输机安全摄像头控制台"
	icon_state = "security_cam"
	density = FALSE
	network = list(CAMERA_NET_ALAMO, CAMERA_NET_NORMANDY)

/obj/structure/machinery/computer/cameras/containment
	name = "收容区摄像头"
	network = list(CAMERA_NET_CONTAINMENT, CAMERA_NET_RESEARCH)

/obj/structure/machinery/computer/cameras/containment/hidden
	network = list(CAMERA_NET_CONTAINMENT, CAMERA_NET_RESEARCH, CAMERA_NET_CONTAINMENT_HIDDEN)

/obj/structure/machinery/computer/cameras/almayer_network
	network = list(CAMERA_NET_ALMAYER)

/obj/structure/machinery/computer/cameras/almayer_network/vehicle
	network = list(CAMERA_NET_ALMAYER, CAMERA_NET_VEHICLE)

/obj/structure/machinery/computer/cameras/almayer_brig
	name = "禁闭室摄像头控制台"
	network = list(CAMERA_NET_BRIG)

/obj/structure/machinery/computer/cameras/mortar
	name = "迫击炮摄像头界面"
	alpha = 0
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	density = FALSE
	use_power = USE_POWER_NONE
	idle_power_usage = 0
	active_power_usage = 0
	needs_power = FALSE
	network = list(CAMERA_NET_MORTAR)
	explo_proof = TRUE
	colony_camera_mapload = FALSE

/obj/structure/machinery/computer/cameras/mortar/set_broken()
	return

/obj/structure/machinery/computer/cameras/dropship
	name = "运输机摄像头计算机"
	desc = "一台用于监控与运输机连接的摄像头的计算机。"
	density = TRUE
	icon = 'icons/obj/structures/machinery/shuttle-parts.dmi'
	icon_state = "consoleleft"
	circuit = null
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE


/obj/structure/machinery/computer/cameras/dropship/one
	name = "\improper '阿拉莫' camera controls"
	network = list(CAMERA_NET_ALAMO, CAMERA_NET_LASER_TARGETS)

/obj/structure/machinery/computer/cameras/dropship/two
	name = "\improper '诺曼底' camera controls"
	network = list(CAMERA_NET_NORMANDY, CAMERA_NET_LASER_TARGETS)

/obj/structure/machinery/computer/cameras/dropship/three
	name = "\improper '塞班' camera controls"
	network = list(CAMERA_NET_RESEARCH, CAMERA_NET_LASER_TARGETS)

/obj/structure/machinery/computer/cameras/internal
	name = "内部摄像头链接"
	desc = "如果你能看到这个，说明有人搞砸了。"
	alpha = 0
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	density = FALSE
	use_power = USE_POWER_NONE
	idle_power_usage = 0
	active_power_usage = 0
	needs_power = FALSE
	network = list(CAMERA_NET_ALMAYER)
	explo_proof = TRUE

/obj/structure/machinery/computer/cameras/internal/yautja
	name = "地狱犬观察界面"
	network = list(CAMERA_NET_YAUTJA)

/obj/structure/machinery/computer/cameras/internal/yautja/Initialize()
	. = ..()
	SEND_SIGNAL(src, COMSIG_CAMERA_SET_NVG, 5, NV_COLOR_RED)

#undef DEFAULT_MAP_SIZE
