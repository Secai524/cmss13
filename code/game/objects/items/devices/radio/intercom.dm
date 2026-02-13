/obj/item/device/radio/intercom
	name = "空间站内部通话器"
	desc = "通过此设备通话。要对身旁的内部通话器直接讲话，请使用 :i。"
	icon_state = "intercom"
	anchored = TRUE
	w_class = SIZE_LARGE
	canhear_range = 2
	flags_atom = FPRINT|CONDUCT|NOBLOODY
	var/number = 0
	var/anyai = 1
	var/list/mob/living/silicon/ai/ai
	var/last_tick //used to delay the powercheck
	volume = RADIO_VOLUME_RAISED

	appearance_flags = TILE_BOUND

/obj/item/device/radio/intercom/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/device/radio/intercom/Destroy()
	STOP_PROCESSING(SSobj, src)
	ai = null
	. = ..()

/obj/item/device/radio/intercom/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_state

/obj/item/device/radio/intercom/attack_remote(mob/user as mob)
	src.add_fingerprint(user)
	spawn (0)
		attack_self(user)

/obj/item/device/radio/intercom/attack_hand(mob/user as mob)
	src.add_fingerprint(user)
	spawn (0)
		attack_self(user)

/obj/item/device/radio/intercom/receive_range(freq, level)
	if (!on)
		return -1
	if (!(src.wires & WIRE_RECEIVE))
		return -1
	if(!(0 in level))
		var/turf/position = get_turf(src)
		if(QDELETED(position) || !(position.z in level))
			return -1
	if (!src.listening)
		return -1

	return canhear_range


/obj/item/device/radio/intercom/hear_talk(mob/M as mob, msg)
	if(!src.anyai && !(M in src.ai))
		return
	..()

/obj/item/device/radio/intercom/process()
	if(((world.timeofday - last_tick) > 30) || ((world.timeofday - last_tick) < 0))
		last_tick = world.timeofday

		if(!src.loc)
			on = FALSE
		else
			var/area/A = src.loc.loc
			if(!A || !isarea(A))
				on = FALSE
			else
				on = A.powered(POWER_CHANNEL_EQUIP) // set "on" to the power status

		if(!on)
			icon_state = "intercom-p"
		else
			icon_state = "intercom"

/obj/item/device/radio/intercom/alamo
	name = "运输机阿拉莫号内部通话器"
	frequency = DS1_FREQ

/obj/item/device/radio/intercom/normandy
	name = "运输机诺曼底号内部通话器"
	frequency = DS2_FREQ

/obj/item/device/radio/intercom/saipan
	name = "运输机塞班号内部通话器"
	frequency = DS3_FREQ

/obj/item/device/radio/intercom/morana
	name = "运输机莫拉纳号内部通话器"
	frequency = UPP_DS1_FREQ

/obj/item/device/radio/intercom/devana
	name = "运输机德瓦纳号内部通话器"
	frequency = UPP_DS2_FREQ

/obj/item/device/radio/intercom/fax
	name = "监听频率扬声器"
	canhear_range = 4

/obj/item/device/radio/intercom/fax/wy
	frequency = FAX_WY_FREQ

/obj/item/device/radio/intercom/fax/uscm_hc
	frequency = FAX_USCM_HC_FREQ

/obj/item/device/radio/intercom/fax/uscm_pvst
	frequency = FAX_USCM_PVST_FREQ
