
///handheld distress beacons used by goon chem retrieval team to call for PMC back up
/obj/item/handheld_distress_beacon
	name = "\improper PMC handheld distress beacon"
	desc = "一个标准的手持式求救信标。通常被常规通讯范围外的队伍用来发出求救信号。这个信标印有维兰德-汤谷的标志，并大量出售给尼罗伊德星区的殖民地。"
	icon = 'icons/obj/items/devices.dmi'
	icon_state = "beacon_inactive"
	w_class = SIZE_SMALL

	///The beacons faction that will be sent in message_admins
	var/beacon_type = "PMC beacon"
	///Tells the user who the beacon will be sent to IC
	var/recipient = "the USCSS Royce"
	///The name of the ERT that will be passed to get_specific_call
	var/list/ert_paths = list(/datum/emergency_call/pmc/chem_retrieval) // "维兰德-汤谷PMC（化学调查小队）"
	///The clickable version that will be sent in message_admins
	var/list/ert_short_names = list("SEND PMCs")
	///Whether beacon can be used, or has already been used
	var/active = FALSE

/obj/item/handheld_distress_beacon/get_examine_text(mob/user)
	. = ..()

	if(active)
		. += "The beacon has been activated!"

/obj/item/handheld_distress_beacon/update_icon()
	. = ..()

	if(active)
		icon_state = "beacon_active"
		return
	icon_state = initial(icon_state)

/obj/item/handheld_distress_beacon/attack_self(mob/user)
	. = ..()

	if(active)
		to_chat(user, "[src]已经激活！")
		return FALSE
	var/reason = tgui_input_text(user, "激活此信标的原因是什么？", "Distress Reason")
	if(!reason)
		return FALSE

	active = TRUE
	update_icon()

	if(!ert_paths || !ert_short_names || (length(ert_paths) != length(ert_short_names))) //Make sure they are greater than 0, and both are same length
		to_chat(user, SPAN_BOLDWARNING("[src]已损坏！"))
		CRASH("[src] was improperly set, and has been disabled.") //For the runtime logs

	var/beacon_call_buttons
	for(var/current_ert_num in 1 to length(ert_paths))
		beacon_call_buttons += "(<A href='byond://?_src_=admin_holder;[HrefToken(forceGlobal = TRUE)];distress_handheld=\ref[user];ert_name=[ert_paths[current_ert_num]]'>[ert_short_names[current_ert_num]]</A>) "

	for(var/client/admin_client in GLOB.admins)
		if((R_ADMIN|R_MOD) & admin_client.admin_holder.rights)
			playsound_client(admin_client,'sound/effects/sos-morse-code.ogg', 10)
	message_admins("[key_name(user)] has used a [beacon_type] for the reason '[SPAN_ORANGE(reason)]'! [CC_MARK(user)] [beacon_call_buttons](<A href='byond://?_src_=admin_holder;[HrefToken(forceGlobal = TRUE)];deny_distress_handheld=\ref[user]'>DENY</A>) [ADMIN_JMP_USER(user)] [CC_REPLY(user)]")
	to_chat(user, SPAN_NOTICE("已向[recipient]发送求救信标请求。"))

/// CMB distress beacon held by CMB Marshal for signalling distress to Anchorpoint Station
/obj/item/handheld_distress_beacon/cmb
	name = "\improper CMB handheld distress beacon"
	desc = "一个紧急信标。这个信标印有殖民地治安局的星形标志，侧面蚀刻着'锚点空间站'字样。该设备配发给CMB治安官，并配有扩展中继天线。"

	beacon_type = "CMB beacon"
	recipient = "Anchorpoint Station"
	// "CMB - 巡逻队 - 遇险执法官（友方）", "CMB - 锚点站殖民地海军陆战队快速反应部队（友方）", "CMB - 防暴控制单位 - 遇险执法官（友方）"
	ert_paths = list(/datum/emergency_call/cmb/alt, /datum/emergency_call/cmb/anchorpoint, /datum/emergency_call/cmb/riot_control/alt)
	ert_short_names = list("SEND CMB", "SEND QRF", "SEND CMB RIOT")

// Corporate Lawyer beacon available for 50 points at the CLs briefcase
/obj/item/handheld_distress_beacon/lawyer
	name = "\improper Corporate Affairs Division handheld beacon"
	desc = "一个加密信标。这个信标印有维兰德-汤谷的口号'自2099年起，建设更美好的世界'。侧面蚀刻着'仅限违约者使用'。这个信标印有公司事务部的标志，提供给位于UA或TWE星域的大多数高管。"

	beacon_type = "Lawyer beacon"
	recipient = "the Corporate Affairs Division"
	ert_paths = list(/datum/emergency_call/inspection_wy/lawyer) // "律师 - 企业"
	ert_short_names = list("SEND LAWYERS")

// Corporate Security Bodyguard beacon available for 50 points at the CLs briefcase
/obj/item/handheld_distress_beacon/bodyguard
	name = "\improper Corporate Security Division handheld beacon"
	desc = "一个标准的公司安全信标。这个信标印有维兰德-汤谷的口号'自2099年起，建设更美好的世界'。这个信标印有公司安全部的标志，提供给驻扎在全银河系非常危险地点的高管。"

	beacon_type = "Bodyguard beacon"
	recipient = "the Corporate Security Division"
	ert_paths = list(/datum/emergency_call/wy_bodyguard, /datum/emergency_call/wy_bodyguard/goon, /datum/emergency_call/wy_bodyguard/pmc/sec, /datum/emergency_call/wy_bodyguard/pmc, /datum/emergency_call/wy_bodyguard/commando, /datum/emergency_call/wy_bodyguard/android) // "Weyland-Yutani Goon (Executive Bodyguard Detail)"
	ert_short_names = list("SEND W-Y GUARD", "SEND GOON", "SEND PMC RIOT", "SEND PMC", "SEND COMMANDO", "SEND COMBAT ANDROID")

// Provost office distress beacon held by Inspectors+
/obj/item/handheld_distress_beacon/provost
	name = "\improper Provost Office handheld beacon"
	desc = "一个标准的宪兵办公室信标，印有宪兵办公室标志，供人员在紧急情况下使用。它配有扩展中继天线，可呼叫一队宪兵执法者。"

	beacon_type = "Provost Enforcers beacon"
	recipient = "the USS Superintendent"
	ert_paths = list(/datum/emergency_call/provost_enforcer) // "USCM宪兵执法队"
	ert_short_names = list("SEND ENFORCERS")
