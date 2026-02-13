// nightvision goggles

/obj/item/clothing/glasses/night
	name = "\improper TV1 night vision goggles"
	gender = PLURAL
	desc = "一副外观整洁的民用级夜视镜。"
	icon = 'icons/obj/items/clothing/glasses/night_vision.dmi'
	icon_state = "night"
	item_state = "night"
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/night_vision.dmi',
	)
	deactive_state = "night_off"
	toggle_on_sound = 'sound/handling/toggle_nv1.ogg'
	toggle_off_sound = 'sound/handling/toggle_nv2.ogg'
	toggleable = TRUE
	actions_types = list(/datum/action/item_action/toggle)
	darkness_view = 12
	vision_flags = SEE_TURFS
	lighting_alpha = LIGHTING_PLANE_ALPHA_SOMEWHAT_INVISIBLE
	fullscreen_vision = null
	eye_protection = EYE_PROTECTION_NEGATIVE

/obj/item/clothing/glasses/night/M4RA
	name = "\improper M4RA Battle sight"
	gender = NEUTER
	desc = "M4RA战斗步枪的耳机和夜视镜系统。可高亮显示周围环境图像，并能查看其他陆战队员的作战服传感器生命状态读数。点击切换。"
	icon_state = "m4ra_goggles"
	deactive_state = "m4ra_goggles_0"
	vision_flags = SEE_TURFS
	hud_type = MOB_HUD_MEDICAL_BASIC
	toggleable = TRUE
	fullscreen_vision = null
	actions_types = list(/datum/action/item_action/toggle)
	flags_item = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE

/obj/item/clothing/glasses/night/medhud
	name = "\improper Mark 4 Battle Medic sight"
	gender = NEUTER
	desc = "M4RA战斗步枪的耳机和夜视镜系统。可高亮显示周围环境图像，并能查看他人的生命状态。点击切换。"
	icon_state = "m4_goggles"
	deactive_state = "m4_goggles_0"
	vision_flags = SEE_TURFS
	hud_type = MOB_HUD_MEDICAL_ADVANCED
	toggleable = TRUE
	fullscreen_vision = null
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/glasses/night/m42_night_goggles
	name = "\improper M42 scout sight"
	gender = NEUTER
	desc = "M42侦察步枪的耳机和夜视镜系统。可高亮显示周围环境图像。点击切换。"
	icon_state = "m42_goggles"
	deactive_state = "m42_goggles_0"
	vision_flags = SEE_TURFS
	toggleable = TRUE
	fullscreen_vision = null
	actions_types = list(/datum/action/item_action/toggle)
	flags_item = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE

/obj/item/clothing/glasses/night/m42_night_goggles/spotter
	name = "\improper M42 spotter sight"
	desc = "USCM观察员的配套耳机和夜视镜系统。可高亮显示周围环境图像。点击切换。"

/obj/item/clothing/glasses/night/m42_night_goggles/m42c
	name = "\improper M42C special operations sight"
	desc = "M42侦察瞄准系统的专用变体，旨在与高威力M42C反坦克狙击步枪配合使用。可高亮显示周围环境图像，并能远距离探测热信号。点击切换。"
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	vision_flags = SEE_TURFS|SEE_MOBS

/obj/item/clothing/glasses/night/m42_night_goggles/upp
	name = "\improper Type 9 commando goggles"
	gender = PLURAL
	desc = "UPP部队使用的耳机和夜视镜系统。可高亮显示周围环境图像。点击切换。"
	icon_state = "upp_goggles"
	deactive_state = "upp_goggles_0"
	req_skill = null
	req_skill_level = null

/obj/item/clothing/glasses/night/m42_night_goggles/rmc
	name = "\improper Royal Marine Commando marksmans goggles"
	gender = PLURAL
	desc = "RMC狙击手使用的耳机和夜视镜系统。可高亮显示周围环境图像。点击切换。"
	icon_state = "m4ra_goggles"
	deactive_state = "m4ra_goggles_0"
	req_skill = null
	req_skill_level = null

/obj/item/clothing/glasses/night/m56_goggles
	name = "\improper M56 head mounted sight"
	gender = NEUTER
	desc = "M56智能枪的耳机和护目镜系统。配备低分辨率短程成像仪，可观察地形。"
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	toggleable = TRUE
	actions_types = list(/datum/action/item_action/toggle/m56goggles)
	vision_flags = SEE_TURFS
	fullscreen_vision = null
	req_skill = SKILL_SPEC_WEAPONS
	req_skill_level = SKILL_SPEC_SMARTGUN

	var/far_sight = FALSE
	var/obj/item/weapon/gun/smartgun/linked_smartgun = null
	var/obj/structure/machinery/camera/camera

/obj/item/clothing/glasses/night/m56_goggles/Initialize(mapload, ...)
	. = ..()
	camera = new /obj/structure/machinery/camera/overwatch(src)
	AddComponent(/datum/component/overwatch_console_control)

/obj/item/clothing/glasses/night/m56_goggles/Destroy()
	linked_smartgun = null
	disable_far_sight()
	QDEL_NULL(camera)
	return ..()

/obj/item/clothing/glasses/night/m56_goggles/proc/link_smartgun(mob/user)
	if(!QDELETED(user))
		linked_smartgun = locate() in user
		if(linked_smartgun)
			return TRUE
	return FALSE

/obj/item/clothing/glasses/night/m56_goggles/mob_can_equip(mob/user, slot)
	if(slot == WEAR_EYES)
		if(!link_smartgun(user))
			to_chat(user, SPAN_NOTICE("你必须装备智能枪才能佩戴这些。"))
			return FALSE
	return ..()

/obj/item/clothing/glasses/night/m56_goggles/equipped(mob/user, slot)
	if(slot != SLOT_EYES)
		disable_far_sight(user)
	if(camera)
		camera.c_tag = user.name
		camera.status = TRUE
	..()

/obj/item/clothing/glasses/night/m56_goggles/dropped(mob/living/carbon/human/user)
	linked_smartgun = null
	disable_far_sight(user)
	if(camera)
		camera.c_tag = "未知"
	return ..()

/obj/item/clothing/glasses/night/m56_goggles/hear_talk(mob/living/sourcemob, message, verb, datum/language/language, italics)
	SEND_SIGNAL(src, COMSIG_BROADCAST_HEAR_TALK, sourcemob, message, verb, language, italics, loc == sourcemob)

/obj/item/clothing/glasses/night/m56_goggles/see_emote(mob/living/sourcemob, emote, audible)
	SEND_SIGNAL(src, COMSIG_BROADCAST_SEE_EMOTE, sourcemob, emote, audible, loc == sourcemob && audible)

/obj/item/clothing/glasses/night/m56_goggles/proc/set_far_sight(mob/living/carbon/human/user, set_to_state = TRUE)
	if(set_to_state)
		if(user.glasses != src)
			to_chat(user, SPAN_WARNING("不穿戴\the [src]无法激活远视功能！"))
			return
		if(!link_smartgun(user))
			to_chat(user, SPAN_WARNING("没有智能枪无法使用此功能！"))
			return
		far_sight = TRUE
		if(user)
			if(user.client)
				user.client.change_view(8, src)
		START_PROCESSING(SSobj, src)
	else
		linked_smartgun = null
		far_sight = FALSE
		if(user)
			if(user.client)
				user.client.change_view(GLOB.world_view_size, src)
		STOP_PROCESSING(SSobj, src)

	var/datum/action/item_action/m56_goggles/far_sight/FT = locate(/datum/action/item_action/m56_goggles/far_sight) in actions
	if(FT)
		FT.update_button_icon()

/obj/item/clothing/glasses/night/m56_goggles/proc/disable_far_sight(mob/living/carbon/human/user)
	if(!istype(user))
		user = loc
		if(!istype(user))
			user = null
	set_far_sight(user, FALSE)

/obj/item/clothing/glasses/night/m56_goggles/process(delta_time)
	var/mob/living/carbon/human/user = loc
	if(!istype(user))
		set_far_sight(null, FALSE)
		return PROCESS_KILL
	if(!link_smartgun(user))
		set_far_sight(user, FALSE)
		return PROCESS_KILL
	if(!linked_smartgun.drain_battery(25 * delta_time))
		set_far_sight(user, FALSE)

/datum/action/item_action/m56_goggles/far_sight/New()
	. = ..()
	name = "切换远视"
	action_icon_state = "far_sight"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/m56_goggles/far_sight/action_activate()
	. = ..()
	if(target)
		var/obj/item/clothing/glasses/night/m56_goggles/G = target
		G.set_far_sight(owner, !G.far_sight)
		to_chat(owner, SPAN_NOTICE("你[G.far_sight ? "enable" : "disable"] \the [G]'s far sight system."))

/datum/action/item_action/m56_goggles/far_sight/update_button_icon()
	if(!target)
		return
	var/obj/item/clothing/glasses/night/m56_goggles/G = target
	if(G.far_sight)
		button.icon_state = "template_on"
	else
		button.icon_state = "template"

/obj/item/clothing/glasses/night/m56_goggles/whiteout
	name = "\improper M56T head mounted sight"
	desc = "M56T'终结者'智能枪的耳机和护目镜系统。配备微光视觉处理器，以及一套能透过固体表面探测热信号的系统。"
	vision_flags = SEE_TURFS|SEE_MOBS
	actions_types = list(/datum/action/item_action/toggle/m56goggles, /datum/action/item_action/m56_goggles/far_sight)

/obj/item/clothing/glasses/night/m56_goggles/upp
	name = "\improper RADIO head rig"
	desc = "为配合RFVS-37而开发，集成自动步枪手光电设备使UPP特种作战部队的步枪手能在低能见度条件下视觉搜索目标，同时确保武器本身的安全使用。"
	icon_state = "radio_head_rig"
	deactive_state = "radio_head_rig_0"

/obj/item/clothing/glasses/night/yautja
	name = "生物面具夜视"
	gender = NEUTER
	desc = "由生物面具生成的视觉覆盖层。用于低光照条件。"
	icon = 'icons/obj/items/hunter/pred_gear.dmi'
	icon_state = "visor_nvg"
	item_state = "visor_nvg"
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/hunter/pred_gear.dmi'
	)
	flags_inventory = COVEREYES
	flags_item = NODROP|DELONDROP
	fullscreen_vision = null
	actions_types = null

/obj/item/clothing/glasses/night/cultist
	name = "\improper unusual thermal imaging goggles"
	desc = "看起来像是热成像护目镜，但设计不同寻常。看着它让你感到恶心。"
	icon = 'icons/obj/items/clothing/glasses/goggles.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/goggles.dmi',
	)
	icon_state = "thermal"
	item_state = "thermal"
	w_class = SIZE_SMALL
	vision_flags = SEE_MOBS
	fullscreen_vision = null

/obj/item/clothing/glasses/night/cultist/mob_can_equip(mob/user, slot)
	if(slot == WEAR_EYES)
		if(iscarbon(user))
			var/mob/living/carbon/H = user
			if(!H.hivenumber)
				to_chat(user, SPAN_WARNING("你不想戴上这个，它们让你感到恶心。"))
				return FALSE
	return ..()

/obj/item/clothing/glasses/night/experimental_mesons
	name = "\improper Experimental Meson Goggles"
	desc = "标准配发介子护目镜的改进实验型号，由于复杂度增加，只能由合成人佩戴。提供完整的夜视及环境观察能力。点击切换。"
	icon = 'icons/obj/items/clothing/glasses/huds.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/huds.dmi',
	)
	icon_state = "refurb_meson"
	deactive_state = "degoggles"
	vision_flags = SEE_TURFS
	toggleable = TRUE
	fullscreen_vision = null
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/glasses/night/experimental_mesons/mob_can_equip(mob/user, slot)
	if(slot == WEAR_EYES)
		if(!issynth(user))
			to_chat(user, "实验型介子护目镜开始探查你的眼睛，寻找附着点，你立刻将其取下。")
			return FALSE
	return ..()
