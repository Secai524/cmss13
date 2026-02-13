#define LOW_MULTIBROADCAST_COOLDOWN 1 MINUTES
#define HIGH_MULTIBROADCAST_COOLDOWN 3 MINUTES

/obj/item/device/radio/headset
	name = "无线电耳机"
	desc = "一款更新的模块化对讲机，可戴在头上。可安装加密密钥。"
	icon_state = "generic_headset"
	item_state = "headset"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/devices_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/devices_righthand.dmi',
	)
	matter = list("metal" = 75)
	subspace_transmission = 1
	canhear_range = 0 // can't hear headsets from very far away

	flags_equip_slot = SLOT_EAR
	inherent_traits = list(TRAIT_ITEM_EAR_EXCLUSIVE)
	var/translate_apollo = FALSE
	var/translate_hive = FALSE
	var/maximum_keys = 3
	var/list/initial_keys //Typepaths of objects to be created at initialisation.
	var/list/keys //Actual objects.
	maxf = 1489

	var/list/inbuilt_tracking_options = list(
		"班长" = TRACKER_SL,
		"火力组长" = TRACKER_FTL,
		"Landing Zone" = TRACKER_LZ
	)
	var/list/tracking_options = list()

	var/list/volume_settings

	var/last_multi_broadcast = -999
	var/multibroadcast_cooldown = HIGH_MULTIBROADCAST_COOLDOWN

	var/has_hud = FALSE
	var/headset_hud_on = FALSE
	var/locate_setting = TRACKER_SL
	var/misc_tracking = FALSE
	var/hud_type = MOB_HUD_FACTION_MARINE //Main faction hud. This determines minimap icons and tracking stuff
	var/list/additional_hud_types = list() //Additional faction huds, doesn't change minimap icon or similar
	var/default_freq

	var/minimap_flag = MINIMAP_FLAG_USCM
	///The type of minimap this headset gives access to
	var/datum/action/minimap/minimap_type

	var/obj/item/device/radio/listening_bug/spy_bug
	var/spy_bug_type

	var/mob/living/carbon/human/wearer

/obj/item/device/radio/headset/Initialize()
	. = ..()
	keys = list()
	for (var/key in initial_keys)
		keys += new key(src)
	recalculateChannels()

	if(length(volume_settings))
		verbs += /obj/item/device/radio/headset/proc/set_volume_setting

	if(has_hud)
		headset_hud_on = TRUE
		verbs += /obj/item/device/radio/headset/proc/toggle_squadhud
		verbs += /obj/item/device/radio/headset/proc/switch_tracker_target

	if(frequency)
		for(var/cycled_channel in GLOB.radiochannels)
			if(GLOB.radiochannels[cycled_channel] == frequency)
				default_freq = cycled_channel

	if(spy_bug_type)
		spy_bug = new spy_bug_type
		spy_bug.forceMove(src)

/obj/item/device/radio/headset/Destroy()
	wearer = null
	if(spy_bug)
		qdel(spy_bug)
		spy_bug = null
	QDEL_NULL_LIST(keys)
	return ..()

/obj/item/device/radio/headset/proc/set_volume_setting()
	set name = "Set Headset Volume"
	set category = "Object"
	set src in usr

	var/static/list/text_to_volume = list(
		RADIO_VOLUME_QUIET_STR = RADIO_VOLUME_QUIET,
		RADIO_VOLUME_RAISED_STR = RADIO_VOLUME_RAISED,
		RADIO_VOLUME_IMPORTANT_STR = RADIO_VOLUME_IMPORTANT,
		RADIO_VOLUME_CRITICAL_STR = RADIO_VOLUME_CRITICAL
	)

	var/volume_setting = tgui_input_list(usr, "选择你希望耳机传输的音量。", "Headset Volume", volume_settings)
	if(!volume_setting)
		return
	volume = text_to_volume[volume_setting]
	to_chat(usr, SPAN_NOTICE("你将\the [src]的音量设置为<b>[volume_setting]</b>。"))

/obj/item/device/radio/headset/handle_message_mode(mob/living/M as mob, message, channel)
	if (channel == RADIO_CHANNEL_SPECIAL)
		if (translate_apollo)
			var/datum/language/apollo = GLOB.all_languages[LANGUAGE_APOLLO]
			apollo.broadcast(M, message)
		if (translate_hive)
			var/datum/language/hivemind = GLOB.all_languages[LANGUAGE_HIVEMIND]
			hivemind.broadcast(M, message)
		return null

	if(default_freq && channel == default_freq)
		return radio_connection

	return ..()

/obj/item/device/radio/headset/attack_self(mob/user as mob)
	on = TRUE //Turn it on if it was off
	. = ..()

/obj/item/device/radio/headset/receive_range(freq, level, aiOverride = 0)
	if (aiOverride)
		return ..(freq, level)
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		if(H.has_item_in_ears(src))
			return ..(freq, level)
	return -1

/obj/item/device/radio/headset/attack_hand(mob/user as mob)
	if(!ishuman(user) || loc != user)
		return ..()
	var/mob/living/carbon/human/H = user
	if (!H.has_item_in_ears(src))
		return ..()
	user.set_interaction(src)
	tgui_interact(user)

/obj/item/device/radio/headset/examine(mob/user as mob)
	if(ishuman(user) && loc == user)
		tgui_interact(user)
	return ..()

/obj/item/device/radio/headset/MouseDrop(obj/over_object as obj)
	if(!CAN_PICKUP(usr, src))
		return ..()
	if(!istype(over_object, /atom/movable/screen))
		return ..()
	if(loc != usr) //Makes sure that the headset is equipped, so that we can't drag it into our hand from miles away.
		return ..()

	switch(over_object.name)
		if("r_hand")
			if(usr.drop_inv_item_on_ground(src))
				usr.put_in_r_hand(src)
		if("l_hand")
			if(usr.drop_inv_item_on_ground(src))
				usr.put_in_l_hand(src)
	add_fingerprint(usr)

/obj/item/device/radio/headset/attackby(obj/item/W as obj, mob/user as mob)
// ..()
	user.set_interaction(src)
	if ( !(HAS_TRAIT(W, TRAIT_TOOL_SCREWDRIVER) || (istype(W, /obj/item/device/encryptionkey)) ))
		return

	if(HAS_TRAIT(W, TRAIT_TOOL_SCREWDRIVER))
		var/turf/T = get_turf(user)
		if(!T)
			to_chat(user, "你不能在这里这么做。")
			return
		var/removed_keys = FALSE
		for (var/obj/item/device/encryptionkey/key in keys)
			if(key.abstract)
				continue
			key.forceMove(T)
			keys -= key
			removed_keys = TRUE
		if(removed_keys)
			recalculateChannels()
			to_chat(user, SPAN_NOTICE("你弹出了\the [src]里的加密密钥！"))
		else
			to_chat(user, SPAN_NOTICE("这个耳机没有任何加密密钥！真没用..."))

	if(istype(W, /obj/item/device/encryptionkey/))
		for (var/obj/item/device/encryptionkey/key as anything in keys)
			if (istype(key, W.type))
				to_chat(user, SPAN_NOTICE("此设备已安装了一个[W.name]！"))
				return

		var/keycount = 0
		for (var/obj/item/device/encryptionkey/key in keys)
			if(!key.abstract)
				keycount++
		if(keycount >= maximum_keys)
			to_chat(user, SPAN_WARNING("\The [src] can't hold another key!"))
			return
		if(user.drop_held_item())
			W.forceMove(src)
			keys += W
			to_chat(user, SPAN_NOTICE("你将\the [W]插入\the [src]！"))
			recalculateChannels()

	return


/obj/item/device/radio/headset/proc/recalculateChannels()
	for(var/ch_name in channels)
		SSradio.remove_object(src, GLOB.radiochannels[ch_name])
		secure_radio_connections[ch_name] = null
	channels = list()
	translate_apollo = FALSE
	translate_hive = FALSE

	tracking_options = length(inbuilt_tracking_options) ? inbuilt_tracking_options.Copy() : list()
	for(var/i in keys)
		var/obj/item/device/encryptionkey/key = i
		for(var/ch_name in key.channels)
			if(ch_name in channels)
				continue
			channels += ch_name
			channels[ch_name] = key.channels[ch_name]
		for(var/tracking_option in key.tracking_options)
			tracking_options[tracking_option] = key.tracking_options[tracking_option]
		if(key.translate_apollo)
			translate_apollo = TRUE
		if(key.translate_hive)
			translate_hive = TRUE

	if(length(tracking_options))
		var/list/tracking_stuff = list()
		for(var/tracking_fluff in tracking_options)
			tracking_stuff += tracking_options[tracking_fluff]
		if(!(locate_setting in tracking_stuff))
			locate_setting = tracking_stuff[1]
	else
		locate_setting = initial(locate_setting)

	for (var/ch_name in channels)
		secure_radio_connections[ch_name] = SSradio.add_object(src, GLOB.radiochannels[ch_name],  RADIO_CHAT)
	SStgui.update_uis(src)

/obj/item/device/radio/headset/set_frequency(new_frequency)
	..()
	if(frequency)
		for(var/cycled_channel in GLOB.radiochannels)
			if(GLOB.radiochannels[cycled_channel] == frequency)
				default_freq = cycled_channel

/obj/item/device/radio/headset/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if (slot == WEAR_L_EAR || slot == WEAR_R_EAR)
		RegisterSignal(user, list(
			COMSIG_LIVING_REJUVENATED,
			COMSIG_HUMAN_REVIVED,
		), PROC_REF(turn_on))
		wearer = user
		RegisterSignal(user, COMSIG_MOB_STAT_SET_ALIVE, PROC_REF(update_minimap_icon))
		RegisterSignal(user, COMSIG_MOB_LOGGED_IN, PROC_REF(add_hud_tracker))
		RegisterSignal(user, COMSIG_MOB_DEATH, PROC_REF(update_minimap_icon))
		RegisterSignal(user, COMSIG_HUMAN_SET_UNDEFIBBABLE, PROC_REF(update_minimap_icon))
		RegisterSignal(user, COMSIG_HUMAN_SQUAD_CHANGED, PROC_REF(update_minimap_icon))
		if(headset_hud_on)
			var/datum/mob_hud/H = GLOB.huds[hud_type]
			H.add_hud_to(user, src)
			for(var/per_faction_hud in additional_hud_types)
				var/datum/mob_hud/alt_hud = GLOB.huds[per_faction_hud]
				alt_hud.add_hud_to(user, src)
			//squad leader locator is no longer invisible on our player HUD.
			if(user.mind && (user.assigned_squad || misc_tracking) && user.hud_used && user.hud_used.locate_leader)
				user.show_hud_tracker()
			if(misc_tracking)
				SStracking.start_misc_tracking(user)
			INVOKE_NEXT_TICK(src, PROC_REF(update_minimap_icon), wearer)
			if(minimap_type)
				add_minimap(user)

/obj/item/device/radio/headset/dropped(mob/living/carbon/human/user)
	UnregisterSignal(user, list(
		COMSIG_LIVING_REJUVENATED,
		COMSIG_HUMAN_REVIVED,
		COMSIG_MOB_LOGGED_IN,
		COMSIG_MOB_DEATH,
		COMSIG_HUMAN_SET_UNDEFIBBABLE,
		COMSIG_MOB_STAT_SET_ALIVE,
		COMSIG_HUMAN_SQUAD_CHANGED
	))
	if(istype(user) && user.has_item_in_ears(src)) //dropped() is called before the inventory reference is update.
		var/datum/mob_hud/H = GLOB.huds[hud_type]
		H.remove_hud_from(user, src)
		for(var/per_faction_hud in additional_hud_types)
			var/datum/mob_hud/alt_hud = GLOB.huds[per_faction_hud]
			alt_hud.remove_hud_from(user, src)

		//squad leader locator is invisible again
		if(user.hud_used && user.hud_used.locate_leader)
			user.hide_hud_tracker()
		if(misc_tracking)
			SStracking.stop_misc_tracking(user)
		SSminimaps.remove_marker(wearer)
		if(minimap_type)
			remove_minimap(wearer)
	wearer = null
	..()

/obj/item/device/radio/headset/proc/add_hud_tracker(mob/living/carbon/human/user)
	SIGNAL_HANDLER

	if(headset_hud_on && user.mind && (user.assigned_squad || misc_tracking) && user.hud_used?.locate_leader)
		user.show_hud_tracker()

/obj/item/device/radio/headset/proc/turn_on()
	SIGNAL_HANDLER
	on = TRUE

/obj/item/device/radio/headset/proc/toggle_squadhud()
	set name = "Toggle Headset HUD"
	set category = "Object"
	set src in usr

	if(usr.is_mob_incapacitated())
		return 0
	headset_hud_on = !headset_hud_on
	if(ishuman(usr))
		var/mob/living/carbon/human/user = usr
		if(user.has_item_in_ears(src)) //worn
			var/datum/mob_hud/H = GLOB.huds[hud_type]
			if(headset_hud_on)
				H.add_hud_to(usr, src)
				for(var/per_faction_hud in additional_hud_types)
					var/datum/mob_hud/alt_hud = GLOB.huds[per_faction_hud]
					alt_hud.add_hud_to(usr, src)
				if(user.mind && (misc_tracking || user.assigned_squad) && user.hud_used?.locate_leader)
					user.show_hud_tracker()
				if(misc_tracking)
					SStracking.start_misc_tracking(user)
			else
				H.remove_hud_from(usr, src)
				for(var/per_faction_hud in additional_hud_types)
					var/datum/mob_hud/alt_hud = GLOB.huds[per_faction_hud]
					alt_hud.remove_hud_from(usr, src)
				if(user.hud_used?.locate_leader)
					user.hide_hud_tracker()
				if(misc_tracking)
					SStracking.stop_misc_tracking(user)
	to_chat(usr, SPAN_NOTICE("你切换了[src]的耳机HUD [headset_hud_on ? "on":"off"]."))
	playsound(src,'sound/machines/click.ogg', 20, 1)

/obj/item/device/radio/headset/proc/switch_tracker_target()
	set name = "Switch Tracker Target"
	set category = "Object"
	set src in usr

	if(usr.is_mob_incapacitated())
		return

	handle_switching_tracker_target(usr)

/obj/item/device/radio/headset/proc/handle_switching_tracker_target(mob/living/carbon/human/user)
	var/new_track = tgui_input_list(user, "选择一个新的追踪目标。", "Tracking Selection", tracking_options)
	if(!new_track)
		return
	to_chat(user, SPAN_NOTICE("你将耳机的追踪器设置为指向<b>[new_track]</b>。"))
	locate_setting = tracking_options[new_track]

/obj/item/device/radio/headset/proc/update_minimap_icon()
	SIGNAL_HANDLER
	SSminimaps.remove_marker(wearer)
	if(!wearer.assigned_equipment_preset || !wearer.assigned_equipment_preset.minimap_icon)
		return

	var/obj/item/card/id/ID = wearer.get_idcard()
	var/icon_to_use
	if(ID?.minimap_icon_override)
		icon_to_use = ID.minimap_icon_override
	else
		icon_to_use = wearer.assigned_equipment_preset.minimap_icon ? wearer.assigned_equipment_preset.minimap_icon : "unknown"

	var/image/background = image('icons/ui_icons/map_blips.dmi', wearer.assigned_squad?.background_icon ? wearer.assigned_squad.background_icon : wearer.assigned_equipment_preset.minimap_background)

	if(wearer.stat == DEAD)
		var/defib_icon_to_use
		if(wearer.undefibbable)
			defib_icon_to_use = "undefibbable"
		else if(world.time > wearer.timeofdeath + wearer.revive_grace_period - 1 MINUTES)
			defib_icon_to_use = "defibbable4"
		else if(world.time > wearer.timeofdeath + wearer.revive_grace_period - 2 MINUTES)
			defib_icon_to_use = "defibbable3"
		else if(world.time > wearer.timeofdeath + wearer.revive_grace_period - 3 MINUTES)
			defib_icon_to_use = "defibbable2"
		else
			defib_icon_to_use = "defibbable"

		background.overlays += image('icons/ui_icons/map_blips.dmi', null, defib_icon_to_use, ABOVE_FLOAT_LAYER)
		if(!wearer.mind)
			var/mob/dead/observer/ghost = wearer.get_ghost(TRUE)
			if(!ghost?.can_reenter_corpse)
				background.overlays += image('icons/ui_icons/map_blips.dmi', null, "undefibbable", ABOVE_FLOAT_LAYER)
	if(wearer.assigned_squad)
		var/image/underlay = image('icons/ui_icons/map_blips.dmi', null, "squad_underlay")
		var/image/overlay = image('icons/ui_icons/map_blips.dmi', null, icon_to_use)
		background.overlays += underlay
		background.overlays += overlay

		if(wearer.assigned_squad?.squad_leader == wearer)
			var/image/leader_trim = image('icons/ui_icons/map_blips.dmi', null, "leader_trim")
			background.overlays += leader_trim

		SSminimaps.add_marker(wearer, minimap_flag, background)
		return

	background.overlays += image('icons/ui_icons/map_blips.dmi', null, icon_to_use)
	SSminimaps.add_marker(wearer, minimap_flag, background)

///Give minimap action to wearer
/obj/item/device/radio/headset/proc/add_minimap(mob/living/carbon/human/user)
	remove_minimap(user)
	var/datum/action/minimap/mini = new minimap_type
	mini.give_to(user, mini)
	INVOKE_NEXT_TICK(src, PROC_REF(update_minimap_icon)) //Mobs are spawned inside nullspace sometimes so this is to avoid that hijinks

///Remove all action of type minimap from the wearer, and make him disappear from the minimap
/obj/item/device/radio/headset/proc/remove_minimap(mob/living/carbon/human/user)
	SSminimaps.remove_marker(wearer)
	if(!user)
		return
	for(var/datum/action/action as anything in user.actions)
		if(istype(action, /datum/action/minimap))
			action.remove_from(user)

//MARINE HEADSETS

/obj/item/device/radio/headset/almayer
	name = "陆战队员无线电耳机"
	desc = "一款标准的军用无线电耳机。比战斗型号更笨重。"
	icon_state = "generic_headset"
	item_state = "headset"
	frequency = PUB_FREQ
	has_hud = TRUE
	minimap_type = /datum/action/minimap/marine

/obj/item/device/radio/headset/almayer/verb/enter_tree()
	set name = "Enter Techtree"
	set desc = "Enter the Marine techtree."
	set category = "Object.Techtree"
	set src in usr

	var/datum/techtree/T = GET_TREE(TREE_MARINE)
	T.enter_mob(usr)

/obj/item/device/radio/headset/almayer/verb/give_medal_recommendation()
	set name = "Give Medal Recommendation"
	set desc = "Send a medal recommendation for approval by the Commanding Officer."
	set category = "Object.Medals"
	set src in usr

	var/mob/living/carbon/human/wearer = usr
	if(!istype(wearer))
		return
	var/obj/item/card/id/id_card = wearer.get_idcard()
	if(!id_card)
		return

	var/datum/paygrade/paygrade_actual = GLOB.paygrades[id_card.paygrade]
	if(!paygrade_actual)
		return
	if(!istype(paygrade_actual, /datum/paygrade/marine)) //We only want marines to be able to recommend for medals
		return
	if(paygrade_actual.ranking < 3) //E1 starts at 0, so anyone above Corporal (ranking = 3) can recommend for medals
		to_chat(wearer, SPAN_WARNING("只有军官或士官（ME4+）可以推荐勋章！"))
		return
	if(add_medal_recommendation(usr))
		to_chat(usr, SPAN_NOTICE("推荐已成功提交。"))


/obj/item/device/radio/headset/almayer/mt
	name = "工程部无线电耳机"
	desc = "用于协调维护工作和轨道轰炸。结构坚固耐用。使用 :n 访问工程频道。"
	icon_state = "eng_headset"
	frequency = ENG_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/almayer)

/obj/item/device/radio/headset/almayer/chef
	name = "厨房无线电耳机"
	desc = "供舰上厨房人员使用，充满煎炸锅具的背景噪音。可使用 :u 与补给频道协调，使用 :v 向指挥部通报送餐服务。"
	icon_state = "req_headset"
	initial_keys = list(/obj/item/device/encryptionkey/req/mst)

/obj/item/device/radio/headset/almayer/doc
	name = "医疗无线电耳机"
	desc = "医疗舱训练有素的工作人员使用的耳机。使用 :m 访问医疗频道。"
	icon_state = "med_headset"
	frequency = MED_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/almayer)

/obj/item/device/radio/headset/almayer/research
	name = "研究员无线电耳机"
	desc = "医疗舱熟练研究员使用的耳机。频道如下：:m - 医疗，:t - 情报。"
	icon_state = "med_headset"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/medres, /obj/item/device/encryptionkey/wy_pub)
	additional_hud_types = list(MOB_HUD_FACTION_WY)

/obj/item/device/radio/headset/almayer/ct
	name = "补给无线电耳机"
	desc = "美国殖民地海军陆战队底层补给技术员使用，轻便便携。使用:u接入补给频道。"
	icon_state = "req_headset"
	frequency = REQ_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/req/ct)

/obj/item/device/radio/headset/almayer/mmpo
	name = "陆战队宪兵无线电耳机"
	desc = "陆战队宪兵成员使用。频道如下：:p - 宪兵，:v - 陆战队指挥。:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班。"
	icon_state = "sec_headset"
	additional_hud_types = list(MOB_HUD_FACTION_CMB)
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/mmpo)
	frequency = SEC_FREQ
	locate_setting = TRACKER_CMP
	misc_tracking = TRUE

	inbuilt_tracking_options = list(
		"宪兵长" = TRACKER_CMP,
		"军事典狱长" = TRACKER_WARDEN,
	)

/obj/item/device/radio/headset/almayer/marine/mp_honor
	name = "陆战队仪仗队无线电耳机"
	desc = "陆战队仪仗队成员使用。频道如下：:p - 宪兵，:v - 陆战队指挥。:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班。"
	icon_state = "sec_headset"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/mmpo)
	additional_hud_types = list(MOB_HUD_FACTION_CMB)
	frequency = SEC_FREQ
	volume = RADIO_VOLUME_RAISED
	locate_setting = TRACKER_CO
	misc_tracking = TRUE

	inbuilt_tracking_options = list(
		"指挥官" = TRACKER_CO,
		"副指挥官" = TRACKER_XO,
		"宪兵长" = TRACKER_CMP,
		"军事典狱长" = TRACKER_WARDEN,
	)

// junior command headsets
/obj/item/device/radio/headset/almayer/mcom
	name = "陆战队指挥无线电耳机"
	desc = "作战指挥中心人员及高级军官使用，采用非标准支架。频道如下：:v - 陆战队指挥，:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班，:n - 工程部，:m - 医疗舱，:u - 补给处，:j - JTAC，:t - 情报。"
	icon_state = "mcom_headset"
	initial_keys = list(/obj/item/device/encryptionkey/mcom)
	volume = RADIO_VOLUME_CRITICAL
	multibroadcast_cooldown = LOW_MULTIBROADCAST_COOLDOWN
	misc_tracking = TRUE
	locate_setting = TRACKER_CO

	inbuilt_tracking_options = list(
		"指挥官" = TRACKER_CO,
		"副指挥官" = TRACKER_XO,
		"Landing Zone" = TRACKER_LZ,
		"Alpha SL" = TRACKER_ASL,
		"Bravo SL" = TRACKER_BSL,
		"Charlie SL" = TRACKER_CSL,
		"Delta SL" = TRACKER_DSL,
		"Echo SL" = TRACKER_ESL,
		"Foxtrot SL" = TRACKER_FSL,
		"Intel SL" = TRACKER_ISL
	)

/obj/item/device/radio/headset/almayer/mcom/alt
	initial_keys = list(/obj/item/device/encryptionkey/mcom/alt)

/obj/item/device/radio/headset/almayer/mcom/qm
	desc = "军需官用于控制其下属的耳机。频道如下：:u - 补给处，:v - 陆战队指挥，:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班。"
	name = "补给官无线电耳机"
	icon_state = "ro_headset"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/qm)
	frequency = REQ_FREQ
	misc_tracking = FALSE

	inbuilt_tracking_options = list(
		"班长" = TRACKER_SL,
		"火力组长" = TRACKER_FTL,
		"Landing Zone" = TRACKER_LZ
	)

/obj/item/device/radio/headset/almayer/mcom/ce
	name = "总工程师耳机"
	desc = "负责启动引擎、管理战斗技术员以及拆地板回收金属的家伙所用的耳机。结构坚固耐用。频道如下：:n - 工程部，:v - 陆战队指挥，:m - 医疗，:u - 补给处，:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班。"
	icon_state = "ce_headset"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/ce)
	frequency = ENG_FREQ
	misc_tracking = TRUE
	locate_setting = TRACKER_LZ // for selene

	inbuilt_tracking_options = list(
		"Landing Zone" = TRACKER_LZ,
		"班长" = TRACKER_SL,
		"火力组长" = TRACKER_FTL
	)

/obj/item/device/radio/headset/almayer/mcom/cmo
	name = "首席医疗官耳机"
	desc = "配发给医疗部门高级官员的耳机。频道如下：:m - 医疗，:v - 陆战队指挥。"
	icon_state = "cmo_headset"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/cmo)
	frequency = MED_FREQ
	misc_tracking = FALSE

	inbuilt_tracking_options = list(
		"班长" = TRACKER_SL,
		"火力组长" = TRACKER_FTL,
		"Landing Zone" = TRACKER_LZ
	)

/obj/item/device/radio/headset/almayer/mcom/po
	name = "陆战队飞行员无线电耳机"
	desc = "飞行员军官使用。频道如下：:v - 陆战队指挥，:n - 工程部，:m - 医疗，:j - JTAC，:t - 情报。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/po)
	frequency = JTAC_FREQ
	volume = RADIO_VOLUME_RAISED // raised for DCCs, POs already have their volume boosted with their leadership
	misc_tracking = TRUE
	locate_setting = TRACKER_LZ // mostly just in case

	inbuilt_tracking_options = list(
		"Landing Zone" = TRACKER_LZ
	)

/obj/item/device/radio/headset/almayer/mcom/io
	name = "陆战队情报无线电耳机"
	desc = "情报官使用。频道如下：:v - 陆战队指挥，:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班，:n - 工程部，:m - 医疗，:j - JTAC，:t - 情报。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/io)
	frequency = INTEL_FREQ

/obj/item/device/radio/headset/almayer/mcom/mw
	name = "陆战队军事典狱长无线电耳机"
	desc = "看起来和宪兵长的耳机出奇地相似……闻起来也有甜甜圈的味道。频道如下：:v - 陆战队指挥，:p - 宪兵，:n - 工程部，:m - 医疗舱，:u - 补给处，:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班。"
	icon_state = "sec_headset"
	additional_hud_types = list(MOB_HUD_FACTION_CMB, MOB_HUD_FACTION_WY)
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/cmpcom)
	frequency = SEC_FREQ
	locate_setting = TRACKER_CMP

	inbuilt_tracking_options = list(
		"指挥官" = TRACKER_CO,
		"副指挥官" = TRACKER_XO,
		"宪兵长" = TRACKER_CMP,
	)

/obj/item/device/radio/headset/almayer/mcom/cmp
	name = "陆战队宪兵长无线电耳机"
	desc = "用于讨论购买甜甜圈和逮捕流氓。频道如下：:v - 陆战队指挥，:p - 宪兵，:n - 工程部，:m - 医疗舱，:u - 补给处，:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班。"
	icon_state = "sec_headset"
	additional_hud_types = list(MOB_HUD_FACTION_CMB, MOB_HUD_FACTION_WY)
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/cmpcom)
	frequency = SEC_FREQ
	locate_setting = TRACKER_CO

	inbuilt_tracking_options = list(
		"指挥官" = TRACKER_CO,
		"副指挥官" = TRACKER_XO,
		"军事典狱长" = TRACKER_WARDEN,
	)

/obj/item/device/radio/headset/almayer/marine/mp_honor/com
	name = "陆战队仪仗队指挥无线电耳机"
	desc = "仅配发给高度信任的陆战队仪仗队员。采用非标准支架。频道如下：:v - 陆战队指挥，:p - 宪兵，:n - 工程部，:m - 医疗舱，:u - 补给处，:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班。"
	icon_state = "mcom_headset"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/cmpcom)

/obj/item/device/radio/headset/almayer/mcl
	name = "公司联络官无线电耳机"
	desc = "公司联络官用于说服人们签署保密协议。频道如下：:v - 陆战队指挥，:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班，:n - 工程部，:m - 医疗舱，:u - 补给处，:j - JTAC，:t - 情报，:y - 维兰德。"
	icon_state = "wy_headset"
	maximum_keys = 5
	initial_keys = list(/obj/item/device/encryptionkey/mcom/cl)
	additional_hud_types = list(MOB_HUD_FACTION_WY, MOB_HUD_FACTION_PMC)
	spy_bug_type = /obj/item/device/radio/listening_bug/radio_linked/fax/wy

/obj/item/device/radio/headset/almayer/mcl/Initialize()
	. = ..()
	if(spy_bug)
		spy_bug.nametag = "CL Radio"
	AddElement(/datum/element/corp_label/wy)

/obj/item/device/radio/headset/almayer/reporter
	name = "战地记者无线电耳机"
	desc = "供战地记者获取第一手消息使用。频道如下：:v - 陆战队指挥，:a - 阿尔法小队，:b - 布拉沃小队，:c - 查理小队，:d - 德尔塔小队，:n - 工程部，:m - 医疗舱，:u - 补给处，:j - JTAC，:t - 情报。"
	initial_keys = list(/obj/item/device/encryptionkey/mcom)

/obj/item/device/radio/headset/almayer/rep
	name = "代表无线电耳机"
	desc = "这是有史以来最糟糕的发明，里面总有喋喋不休的杂音。"
	icon_state = "wy_headset"
	initial_keys = list(/obj/item/device/encryptionkey/mcom/rep)

// senior (mostly) command headsets
/obj/item/device/radio/headset/almayer/mcom/cdrcom
	name = "陆战队高级指挥耳机"
	desc = "仅配发给高级指挥人员。频道如下：:v - 陆战队指挥，:p - 宪兵，:a - 阿尔法小队，:b - 布拉沃小队，:c - 查理小队，:d - 德尔塔小队，:n - 工程部，:m - 医疗舱，:u - 补给处，:j - JTAC，:t - 情报。"
	icon_state = "mco_headset"
	initial_keys = list(/obj/item/device/encryptionkey/cmpcom/cdrcom)
	additional_hud_types = list(MOB_HUD_FACTION_WY, MOB_HUD_FACTION_CMB)
	minimap_type = /datum/action/minimap/marine/live

/obj/item/device/radio/headset/almayer/mcom/spare
	name = "陆战队代理指挥耳机"
	desc = "仅配发给担任代理指挥官或值班军官的军官。频道如下：:v - 陆战队指挥，:p - 宪兵，:a - 阿尔法小队，:b - 布拉沃小队，:c - 查理小队，:d - 德尔塔小队，:n - 工程部，:m - 医疗舱，:u - 补给处，:j - JTAC，:t - 情报。"
	icon_state = "mco_headset"
	initial_keys = list(/obj/item/device/encryptionkey/mcom, /obj/item/device/encryptionkey/mmpo)
	additional_hud_types = list(MOB_HUD_FACTION_WY, MOB_HUD_FACTION_CMB)

/obj/item/device/radio/headset/almayer/mcom/cdrcom/xo
	locate_setting = TRACKER_CO

	inbuilt_tracking_options = list(
		"指挥官" = TRACKER_CO,
		"Landing Zone" = TRACKER_LZ,
		"Alpha SL" = TRACKER_ASL,
		"Bravo SL" = TRACKER_BSL,
		"Charlie SL" = TRACKER_CSL,
		"Delta SL" = TRACKER_DSL,
		"Echo SL" = TRACKER_ESL,
		"Foxtrot SL" = TRACKER_FSL,
		"Intel SL" = TRACKER_ISL
	)

/obj/item/device/radio/headset/almayer/mcom/cdrcom/co
	locate_setting = TRACKER_XO

	inbuilt_tracking_options = list(
		"副指挥官" = TRACKER_XO,
		"Landing Zone" = TRACKER_LZ,
		"Alpha SL" = TRACKER_ASL,
		"Bravo SL" = TRACKER_BSL,
		"Charlie SL" = TRACKER_CSL,
		"Delta SL" = TRACKER_DSL,
		"Echo SL" = TRACKER_ESL,
		"Foxtrot SL" = TRACKER_FSL,
		"Intel SL" = TRACKER_ISL
	)

/obj/item/device/radio/headset/almayer/mcom/sea
	name = "陆战队高级士官顾问耳机"
	desc = "仅配发给高级士官顾问。频道如下：:v - 陆战队指挥，:p - 宪兵，:a - 阿尔法小队，:b - 布拉沃小队，:c - 查理小队，:d - 德尔塔小队，:n - 工程部，:m - 医疗舱，:u - 补给处，:j - JTAC，:t - 情报。"
	icon_state = "mco_headset"
	misc_tracking = TRUE
	locate_setting = TRACKER_CO
	initial_keys = list(/obj/item/device/encryptionkey/mcom, /obj/item/device/encryptionkey/mmpo)

	inbuilt_tracking_options = list(
		"指挥官" = TRACKER_CO,
		"副指挥官" = TRACKER_XO,
		"宪兵长" = TRACKER_CMP
	)

/obj/item/device/radio/headset/almayer/mcom/synth
	name = "陆战队合成人耳机"
	desc = "仅配发给USCM合成人。频道如下：:v - 陆战队指挥，:p - 宪兵，:a - 阿尔法小队，:b - 布拉沃小队，:c - 查理小队，:d - 德尔塔小队，:n - 工程部，:m - 医疗舱，:u - 补给处，:j - JTAC，:t - 情报。"
	icon_state = "ms_headset"
	initial_keys = list(/obj/item/device/encryptionkey/cmpcom/synth)

/obj/item/device/radio/headset/almayer/mcom/ai
	initial_keys = list(/obj/item/device/encryptionkey/cmpcom/synth/ai)

/obj/item/device/radio/headset/almayer/marine
	initial_keys = list(/obj/item/device/encryptionkey/almayer)

/obj/item/device/radio/headset/almayer/cia
	name = "无线电耳机"
	desc = "一个无线电耳机。"
	frequency = CIA_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/cia, /obj/item/device/encryptionkey/soc, /obj/item/device/encryptionkey/almayer)


//############################## ALPHA ###############################
/obj/item/device/radio/headset/almayer/marine/alpha
	name = "陆战队阿尔法小队无线电耳机"
	desc = "供阿尔法小队成员使用。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	icon_state = "alpha_headset"
	frequency = ALPHA_FREQ //default frequency is alpha squad channel, not PUB_FREQ

/obj/item/device/radio/headset/almayer/marine/alpha/lead
	name = "陆战队阿尔法小队班长无线电耳机"
	desc = "供陆战队阿尔法小队班长使用。频道如下：:u - 补给处，:v - 陆战队指挥，:j - JTAC。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/squadlead)
	locate_setting = TRACKER_LZ
	volume = RADIO_VOLUME_CRITICAL

	inbuilt_tracking_options = list(
		"班长" = TRACKER_SL,
		"火力组长" = TRACKER_FTL,
		"Landing Zone" = TRACKER_LZ,
		"指挥官" = TRACKER_CO,
		"副指挥官" = TRACKER_XO,
		"Bravo SL" = TRACKER_BSL,
		"Charlie SL" = TRACKER_CSL,
		"Delta SL" = TRACKER_DSL,
		"Echo SL" = TRACKER_ESL,
		"Foxtrot SL" = TRACKER_FSL,
		"Intel SL" = TRACKER_ISL
	)

/obj/item/device/radio/headset/almayer/marine/alpha/tl
	name = "陆战队阿尔法火力组长无线电耳机"
	desc = "供陆战队阿尔法火力组长使用。频道如下：:u - 补给处，:j - JTAC。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/jtac)
	volume = RADIO_VOLUME_RAISED

/obj/item/device/radio/headset/almayer/marine/alpha/engi
	name = "陆战队阿尔法小队工程师无线电耳机"
	desc = "供陆战队阿尔法小队战斗工程师使用。要访问工程频道，请使用 :n。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/engi)

/obj/item/device/radio/headset/almayer/marine/alpha/med
	name = "陆战队阿尔法小队医疗兵无线电耳机"
	desc = "供陆战队阿尔法小队战斗医疗兵使用。要访问医疗频道，请使用 :m。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/med)

//############################## BRAVO ###############################
/obj/item/device/radio/headset/almayer/marine/bravo
	name = "陆战队布拉沃小队无线电耳机"
	desc = "供布拉沃小队成员使用。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	icon_state = "bravo_headset"
	frequency = BRAVO_FREQ

/obj/item/device/radio/headset/almayer/marine/bravo/lead
	name = "陆战队员布拉沃班班长无线电耳机"
	desc = "供陆战队员布拉沃班班长使用。频道如下：:u - 补给处，:v - 陆战队指挥，:j - JTAC。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/squadlead)
	locate_setting = TRACKER_LZ
	volume = RADIO_VOLUME_CRITICAL

	inbuilt_tracking_options = list(
		"班长" = TRACKER_SL,
		"火力组长" = TRACKER_FTL,
		"Landing Zone" = TRACKER_LZ,
		"指挥官" = TRACKER_CO,
		"副指挥官" = TRACKER_XO,
		"Alpha SL" = TRACKER_ASL,
		"Charlie SL" = TRACKER_CSL,
		"Delta SL" = TRACKER_DSL,
		"Echo SL" = TRACKER_ESL,
		"Foxtrot SL" = TRACKER_FSL,
		"Intel SL" = TRACKER_ISL
	)

/obj/item/device/radio/headset/almayer/marine/bravo/tl
	name = "陆战队员布拉沃火力组长无线电耳机"
	desc = "供陆战队员布拉沃火力组长使用。频道如下：:u - 补给处，:j - JTAC。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/jtac)
	volume = RADIO_VOLUME_RAISED

/obj/item/device/radio/headset/almayer/marine/bravo/engi
	name = "陆战队员布拉沃工程师无线电耳机"
	desc = "供陆战队员布拉沃战斗工程师使用。使用 :n 访问工程频道。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/engi)

/obj/item/device/radio/headset/almayer/marine/bravo/med
	name = "陆战队员布拉沃医疗兵无线电耳机"
	desc = "供陆战队员布拉沃战斗医疗兵使用。使用 :m 访问医疗频道。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/med)

//############################## CHARLIE ###############################
/obj/item/device/radio/headset/almayer/marine/charlie
	name = "陆战队员查理无线电耳机"
	desc = "供查理班成员使用。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	icon_state = "charlie_headset"
	frequency = CHARLIE_FREQ

/obj/item/device/radio/headset/almayer/marine/charlie/lead
	name = "陆战队员查理班班长无线电耳机"
	desc = "供陆战队员查理班班长使用。频道如下：:u - 补给处，:v - 陆战队指挥，:j - JTAC。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/squadlead)
	locate_setting = TRACKER_LZ
	volume = RADIO_VOLUME_CRITICAL

	inbuilt_tracking_options = list(
		"班长" = TRACKER_SL,
		"火力组长" = TRACKER_FTL,
		"Landing Zone" = TRACKER_LZ,
		"指挥官" = TRACKER_CO,
		"副指挥官" = TRACKER_XO,
		"Alpha SL" = TRACKER_ASL,
		"Bravo SL" = TRACKER_BSL,
		"Delta SL" = TRACKER_DSL,
		"Echo SL" = TRACKER_ESL,
		"Foxtrot SL" = TRACKER_FSL,
		"Intel SL" = TRACKER_ISL
	)

/obj/item/device/radio/headset/almayer/marine/charlie/tl
	name = "陆战队员查理火力组长无线电耳机"
	desc = "供陆战队员查理火力组长使用。频道如下：:u - 补给处，:j - JTAC。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/jtac)
	volume = RADIO_VOLUME_RAISED

/obj/item/device/radio/headset/almayer/marine/charlie/engi
	name = "陆战队员查理工程师无线电耳机"
	desc = "供陆战队员查理战斗工程师使用。使用 :n 访问工程频道。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/engi)

/obj/item/device/radio/headset/almayer/marine/charlie/med
	name = "陆战队员查理医疗兵无线电耳机"
	desc = "供陆战队员查理战斗医疗兵使用。使用 :m 访问医疗频道。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/med)

//############################## DELTA ###############################
/obj/item/device/radio/headset/almayer/marine/delta
	name = "陆战队员德尔塔无线电耳机"
	desc = "供德尔塔班成员使用。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	icon_state = "delta_headset"
	frequency = DELTA_FREQ

/obj/item/device/radio/headset/almayer/marine/delta/lead
	name = "陆战队员德尔塔班班长无线电耳机"
	desc = "供陆战队员德尔塔班班长使用。频道如下：:u - 补给处，:v - 陆战队指挥，:j - JTAC。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/squadlead)
	locate_setting = TRACKER_LZ
	volume = RADIO_VOLUME_CRITICAL

	inbuilt_tracking_options = list(
		"班长" = TRACKER_SL,
		"火力组长" = TRACKER_FTL,
		"Landing Zone" = TRACKER_LZ,
		"指挥官" = TRACKER_CO,
		"副指挥官" = TRACKER_XO,
		"Alpha SL" = TRACKER_ASL,
		"Bravo SL" = TRACKER_BSL,
		"Charlie SL" = TRACKER_CSL,
		"Echo SL" = TRACKER_ESL,
		"Foxtrot SL" = TRACKER_FSL,
		"Intel SL" = TRACKER_ISL
	)

/obj/item/device/radio/headset/almayer/marine/delta/tl
	name = "陆战队员德尔塔火力组长无线电耳机"
	desc = "供陆战队员德尔塔火力组长使用。频道如下：:u - 补给处，:j - JTAC。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/jtac)
	volume = RADIO_VOLUME_RAISED

/obj/item/device/radio/headset/almayer/marine/delta/engi
	name = "陆战队员德尔塔工程师无线电耳机"
	desc = "德尔塔班战斗工程师使用此装备。使用 :n 接入工程频道。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/engi)

/obj/item/device/radio/headset/almayer/marine/delta/med
	name = "德尔塔班医疗兵无线电耳机"
	desc = "德尔塔班战斗医疗兵使用此装备。使用 :m 接入医疗频道。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/med)

//############################## ECHO ###############################
/obj/item/device/radio/headset/almayer/marine/echo
	name = "回声班无线电耳机"
	desc = "回声班成员使用此装备。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	icon_state = "echo_headset"
	frequency = ECHO_FREQ

/obj/item/device/radio/headset/almayer/marine/echo/lead
	name = "回声班班长无线电耳机"
	desc = "回声班班长使用此装备。频道如下：:u - 补给处，:v - 陆战队指挥，:j - JTAC。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/squadlead)
	locate_setting = TRACKER_LZ
	volume = RADIO_VOLUME_CRITICAL

	inbuilt_tracking_options = list( //unknown if this, as of Sept 2024, given to echo leads but adding this here just in case
		"班长" = TRACKER_SL,
		"火力组长" = TRACKER_FTL,
		"Landing Zone" = TRACKER_LZ,
		"指挥官" = TRACKER_CO,
		"副指挥官" = TRACKER_XO,
		"Alpha SL" = TRACKER_ASL,
		"Bravo SL" = TRACKER_BSL,
		"Charlie SL" = TRACKER_CSL,
		"Delta SL" = TRACKER_DSL,
		"Foxtrot SL" = TRACKER_FSL,
		"Intel SL" = TRACKER_ISL
	)

/obj/item/device/radio/headset/almayer/marine/echo/tl
	name = "回声班火力组长无线电耳机"
	desc = "回声班火力组长使用此装备。频道如下：:u - 补给处，:j - JTAC。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/jtac)
	volume = RADIO_VOLUME_RAISED

/obj/item/device/radio/headset/almayer/marine/echo/engi
	name = "回声班工程师无线电耳机"
	desc = "回声班战斗工程师使用此装备。使用 :n 接入工程频道。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/engi)

/obj/item/device/radio/headset/almayer/marine/echo/med
	name = "回声班医疗兵无线电耳机"
	desc = "回声班战斗医疗兵使用此装备。使用 :m 接入医疗频道。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/med)


//############################## CRYO ###############################
/obj/item/device/radio/headset/almayer/marine/cryo
	name = "狐步班无线电耳机"
	desc = "狐步班成员使用此装备。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	icon_state = "cryo_headset"
	frequency = CRYO_FREQ

/obj/item/device/radio/headset/almayer/marine/cryo/lead
	name = "狐步班班长无线电耳机"
	desc = "狐步班班长使用此装备。频道如下：:u - 补给处，:v - 陆战队指挥，:j - JTAC。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/squadlead)
	locate_setting = TRACKER_LZ
	volume = RADIO_VOLUME_CRITICAL

	inbuilt_tracking_options = list(
		"班长" = TRACKER_SL,
		"火力组长" = TRACKER_FTL,
		"Landing Zone" = TRACKER_LZ,
		"指挥官" = TRACKER_CO,
		"副指挥官" = TRACKER_XO,
		"Alpha SL" = TRACKER_ASL,
		"Bravo SL" = TRACKER_BSL,
		"Charlie SL" = TRACKER_CSL,
		"Delta SL" = TRACKER_DSL,
		"Echo SL" = TRACKER_ESL,
		"Intel SL" = TRACKER_ISL
	)

/obj/item/device/radio/headset/almayer/marine/cryo/tl
	name = "狐步班火力组长无线电耳机"
	desc = "狐步班火力组长使用此装备。频道如下：:u - 补给处，:j - JTAC。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/jtac)
	volume = RADIO_VOLUME_RAISED

/obj/item/device/radio/headset/almayer/marine/cryo/engi
	name = "狐步班工程师无线电耳机"
	desc = "狐步班战斗工程师使用此装备。使用 :n 接入工程频道。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/engi)

/obj/item/device/radio/headset/almayer/marine/cryo/med
	name = "狐步班医疗兵无线电耳机"
	desc = "狐步班战斗医疗兵使用此装备。使用 :m 接入医疗频道。佩戴时可访问班长追踪器。空手点击追踪器以打开小队信息窗口。"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/med)

/obj/item/device/radio/headset/almayer/marine/mortar
	name = "迫击炮组无线电耳机"
	desc = "尘暴袭击者地堡迫击炮组使用此装备，以获取那80毫米钢铁之雨的命中效果反馈。配备以下频道权限：:e 接入工程频道，:j 与JTAC协调，:t 接入情报频道，以及 :u 请求更多炮弹补给——这里可不是温彻斯特前哨！"
	icon_state = "ce_headset"
	initial_keys = list(/obj/item/device/encryptionkey/mortar)
	volume = RADIO_VOLUME_RAISED

//*************************************
//-----SELF SETTING MARINE HEADSET-----
//*************************************/
//For events. Currently used for WO only. After equipping it, self_set() will adapt headset to marine.

/obj/item/device/radio/headset/almayer/marine/self_setting/proc/self_set()
	var/mob/living/carbon/human/H = loc
	if(istype(H, /mob/living/carbon/human))
		if(H.assigned_squad)
			switch(H.assigned_squad.name)
				if(SQUAD_MARINE_1)
					name = "[SQUAD_MARINE_1]无线电耳机"
					desc = "供[SQUAD_MARINE_1]班组成员使用。"
					icon_state = "alpha_headset"
					frequency = ALPHA_FREQ
				if(SQUAD_MARINE_2)
					name = "[SQUAD_MARINE_2]无线电耳机"
					desc = "供[SQUAD_MARINE_2]班组成员使用。"
					icon_state = "bravo_headset"
					frequency = BRAVO_FREQ
				if(SQUAD_MARINE_3)
					name = "[SQUAD_MARINE_3]无线电耳机"
					desc = "供[SQUAD_MARINE_3]班组成员使用。"
					icon_state = "charlie_headset"
					frequency = CHARLIE_FREQ
				if(SQUAD_MARINE_4)
					name = "[SQUAD_MARINE_4]无线电耳机"
					desc = "供[SQUAD_MARINE_4]班组成员使用。"
					icon_state = "delta_headset"
					frequency = DELTA_FREQ
				if(SQUAD_MARINE_5)
					name = "[SQUAD_MARINE_5]无线电耳机"
					desc = "供[SQUAD_MARINE_5]班组成员使用。"
					frequency = ECHO_FREQ
				if(SQUAD_MARINE_CRYO)
					name = "[SQUAD_MARINE_CRYO]无线电耳机"
					desc = "供[SQUAD_MARINE_CRYO]班组成员使用。"
					frequency = CRYO_FREQ

			switch(GET_DEFAULT_ROLE(H.job))
				if(JOB_SQUAD_LEADER)
					name = "陆战队员班长" + name
					keys += new /obj/item/device/encryptionkey/squadlead(src)
					volume = RADIO_VOLUME_CRITICAL
				if(JOB_SQUAD_MEDIC)
					name = "陆战队员医疗兵" + name
					keys += new /obj/item/device/encryptionkey/med(src)
				if(JOB_SQUAD_ENGI)
					name = "陆战队员战斗技术员" + name
					keys += new /obj/item/device/encryptionkey/engi(src)
				if(JOB_SQUAD_TEAM_LEADER)
					name = "陆战队员火力组长" + name
					keys += new /obj/item/device/encryptionkey/jtac(src)
				else
					name = "marine " + name

			set_frequency(frequency)
			for(var/ch_name in channels)
				secure_radio_connections[ch_name] = SSradio.add_object(src, GLOB.radiochannels[ch_name],  RADIO_CHAT)
			recalculateChannels()
			if(H.mind && H.hud_used && H.hud_used.locate_leader) //make SL tracker visible
				H.hud_used.locate_leader.alpha = 255
				H.hud_used.locate_leader.mouse_opacity = MOUSE_OPACITY_ICON

//Distress (ERT) headsets.

/obj/item/device/radio/headset/distress
	name = "殖民地耳机"
	desc = "殖民者使用的标准耳机。"
	frequency = COLONY_FREQ

/obj/item/device/radio/headset/distress/WY
	name = "维兰德公司耳机"
	desc = "维兰德公司人员常用的耳机。"
	icon_state = "wy_headset"
	frequency = WY_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/wy_pub)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_WY

/obj/item/device/radio/headset/distress/WY/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/device/radio/headset/distress/WY/security
	name = "维兰德公司安保耳机"
	desc = "维兰德公司安保人员常用的耳机。"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/wy_sec)

/obj/item/device/radio/headset/distress/WY/security/guard
	name = "维兰德个人防护耳机"
	desc = "配发给公司安保人员。频道如下：:v - 陆战队指挥，:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班，:n - 工程部，:m - 医疗舱，:u - 补给处，:j - JTAC，:t - 情报，:1 - 维兰德公共频道，:y - 维兰德公司频道，#y - 维兰德安保频道。"
	misc_tracking = TRUE
	locate_setting = TRACKER_CL
	inbuilt_tracking_options = list(
		"公司联络官" = TRACKER_CL
	)
	additional_hud_types = list(MOB_HUD_FACTION_MARINE)
	initial_keys = list(/obj/item/device/encryptionkey/mcom/cl, /obj/item/device/encryptionkey/wy_sec)

/obj/item/device/radio/headset/distress/hyperdyne
	name = "HC公司耳机"
	desc = "海柏戴恩公司人员常用的耳机。"
	icon_state = "generic_headset"
	frequency = HDC_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/hyperdyne)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_HC

/obj/item/device/radio/headset/distress/dutch
	name = "荷兰佬十二人组耳机"
	desc = "供训练有素的小型行动小组（或恐怖分子）使用的特殊耳机。使用 :h 接入殖民地频道。"
	frequency = DUT_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/colony)
	ignore_z = TRUE

/obj/item/device/radio/headset/distress/cbrn
	name = "\improper CBRN headset"
	desc = "配发给CBRN陆战队员的耳机。频道如下：:g - 公共，:v - 陆战队指挥，:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班，:n - 工程部，:m - 医疗舱，:u - 补给处，:j - JTAC，:t - 情报。"
	frequency = CBRN_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/mcom)
	ignore_z = TRUE
	has_hud = TRUE

/obj/item/device/radio/headset/distress/forecon
	name = "\improper Force Recon headset"
	desc = "配发给FORECON陆战队员的耳机。频道如下：:g - 公共，:v - 陆战队指挥，:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班，:n - 工程部，:m - 医疗舱，:u - 补给处，:j - JTAC，:t - 情报。"
	frequency = FORECON_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/mcom)
	ignore_z = TRUE
	has_hud = TRUE

//WY Headsets

/obj/item/device/radio/headset/distress/wy_android
	name = "维兰德-汤谷合成人耳机"
	desc = "身份不明的合成人使用的特殊耳机。频道如下：:o - 殖民地 :y - 公司 #pmc - PMC"
	frequency = WY_WO_FREQ
	icon_state = "ms_headset"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/WY, /obj/item/device/encryptionkey/pmc/command)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_WO
	additional_hud_types = list(MOB_HUD_FACTION_WY, MOB_HUD_FACTION_PMC)

/obj/item/device/radio/headset/distress/pmc
	name = "PMC耳机"
	desc = "公司人员使用的特殊耳机。频道如下：:g - 公共，:v - 陆战队指挥，:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班，:n - 工程部，:m - 医疗舱，:u - 补给处，:j - JTAC，:t - 情报，:y - 公司。"
	frequency = PMC_FREQ
	icon_state = "pmc_headset"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/mcom/cl)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_PMC

	misc_tracking = TRUE
	locate_setting = TRACKER_CL
	inbuilt_tracking_options = list(
		"公司联络官" = TRACKER_CL
	)
	additional_hud_types = list(MOB_HUD_FACTION_WY)

/obj/item/device/radio/headset/distress/pmc/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/device/radio/headset/distress/pmc/commando
	name = "维兰德-汤谷突击队耳机"
	desc = "身份不明的行动人员使用的特殊耳机。频道如下：:g - 公共，:v - 陆战队指挥，:a - 阿尔法班，:b - 布拉沃班，:c - 查理班，:d - 德尔塔班，:n - 工程部，:m - 医疗舱，:u - 补给处，:j - JTAC，:t - 情报，:y - 公司。"
	icon_state = "pmc_headset"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/mcom/cl, /obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/WY, /obj/item/device/encryptionkey/pmc)
	maximum_keys = 5

/obj/item/device/radio/headset/distress/pmc/commando/hvh
	name = "维兰德-汤谷突击队耳机"
	desc = "身份不明的行动人员使用的特殊耳机。频道如下：:o - 殖民地 :y - 公司 #pmc - PMC。"
	icon_state = "pmc_headset"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/WY, /obj/item/device/encryptionkey/pmc)

/obj/item/device/radio/headset/distress/pmc/commando/leader
	name = "维兰德-汤谷突击队队长耳机"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/mcom/cl, /obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/WY, /obj/item/device/encryptionkey/pmc/command)

/obj/item/device/radio/headset/distress/pmc/hvh
	desc = "公司人员使用的特殊耳机。频道如下：:o - 殖民地。"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/WY)
	misc_tracking = FALSE

/obj/item/device/radio/headset/distress/pmc/cct
	name = "PMC-CCT耳机"
	desc = "公司人员使用的特殊耳机。频道如下：:o - 殖民地，#e - 工程部，#o - JTAC，#p - 通用。"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/engi, /obj/item/device/encryptionkey/mcom/cl)

/obj/item/device/radio/headset/distress/pmc/cct/hvh
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/engi)
	misc_tracking = FALSE

/obj/item/device/radio/headset/distress/pmc/medic
	name = "PMC-MED耳机"
	desc = "公司人员使用的特殊耳机。频道如下：:o - 殖民地，#f - 医疗，#p - 通用。"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/medic, /obj/item/device/encryptionkey/mcom/cl)

/obj/item/device/radio/headset/distress/pmc/medic/hvh
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/medic)
	misc_tracking = FALSE

/obj/item/device/radio/headset/distress/pmc/command
	name = "PMC-CMD耳机"
	desc = "公司人员使用的特殊耳机。频道如下：:o - 殖民地，#z - 指挥，#f - 医疗，#e - 工程部，#o - JTAC，#p - 通用。"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/command, /obj/item/device/encryptionkey/mcom/cl)
	additional_hud_types = list(MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_WY)

/obj/item/device/radio/headset/distress/pmc/command/hvh
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/command)
	misc_tracking = FALSE
	additional_hud_types = list(MOB_HUD_FACTION_WY)

/obj/item/device/radio/headset/distress/pmc/command/director
	name = "维兰德-汤谷主管耳机"
	desc = "公司主管使用的特殊耳机。频道如下：:o - 殖民地，#z - 指挥，#f - 医疗，#e - 工程部，#o - JTAC，#p - 通用。"
	maximum_keys = 4
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/command, /obj/item/device/encryptionkey/commando, /obj/item/device/encryptionkey/mcom/cl)
	additional_hud_types = list(MOB_HUD_FACTION_WY, MOB_HUD_FACTION_WO, MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_MARINE)

/obj/item/device/radio/headset/distress/pmc/command/director/hvh
	maximum_keys = 3
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/command, /obj/item/device/encryptionkey/commando)
	misc_tracking = FALSE



//UPP Headsets
/obj/item/device/radio/headset/distress/UPP
	name = "UPP耳机"
	desc = "UPP军队使用的特殊耳机。使用 :o 接入殖民地频道。"
	frequency = UPP_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/colony)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_UPP
	minimap_flag = MINIMAP_FLAG_UPP
	minimap_type = /datum/action/minimap/marine/upp

/obj/item/device/radio/headset/distress/UPP/cct
	name = "UPP-CCT耳机"
	desc = "UPP军队使用的专用耳机。频道如下：:o - 殖民地， #j - 战斗控制员， #n - 工程部。"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/upp/engi)

/obj/item/device/radio/headset/distress/UPP/medic
	name = "UPP医疗耳机"
	desc = "UPP军队使用的专用耳机。频道如下：:o - 殖民地， #m - 医疗。"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/upp/medic)

/obj/item/device/radio/headset/distress/UPP/command
	name = "UPP指挥耳机"
	desc = "UPP军队使用的专用耳机。频道如下：:o - 殖民地， #j - 战斗控制员， #n - 工程部， #m - 医疗， #v - 指挥， #u - UPP通用。"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/upp/command)

/obj/item/device/radio/headset/distress/UPP/kdo
	name = "UPP突击队耳机"
	desc = "UPP突击队使用的专家耳机。频道如下：:o - 殖民地， #j - 战斗控制员， #u - UPP通用， #T - 突击队。"
	initial_keys = list(/obj/item/device/encryptionkey/upp/kdo, /obj/item/device/encryptionkey/colony)

/obj/item/device/radio/headset/distress/UPP/kdo/medic
	name = "UPP突击队医疗耳机"
	desc = "UPP突击队使用的专家耳机。频道如下：:o - 殖民地， #j - 战斗控制员， #m - 医疗， #u - UPP通用， #T - 突击队。"
	initial_keys = list(/obj/item/device/encryptionkey/upp/kdo, /obj/item/device/encryptionkey/colony)

/obj/item/device/radio/headset/distress/UPP/kdo/command
	name = "UPP突击队指挥耳机"
	desc = "UPP突击队使用的专家耳机。频道如下：:o - 殖民地， #j - 战斗控制员， #n - 工程部， #m - 医疗， #v - 指挥， #u - UPP通用， #T - 突击队。"
	initial_keys = list(/obj/item/device/encryptionkey/upp/kdo, /obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/upp/command)

//CLF Headsets
/obj/item/device/radio/headset/distress/CLF
	name = "CLF耳机"
	desc = "小型训练有素的特工（或恐怖分子）使用的专用耳机。使用 :o 接入殖民地频道。"
	frequency = CLF_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/colony)
	minimap_flag = MINIMAP_FLAG_CLF
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_CLF

/obj/item/device/radio/headset/distress/CLF/cct
	name = "CLF战斗控制耳机"
	desc = "小型训练有素的特工（或恐怖分子）使用的专用耳机。频道如下：:o - 殖民地， #d - 战斗控制员， #b - 工程部。"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/clf/engi)

/obj/item/device/radio/headset/distress/CLF/medic
	name = "CLF医疗耳机"
	desc = "小型训练有素的特工（或恐怖分子）使用的专用耳机。频道如下：:o - 殖民地， #a - 医疗。"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/clf/medic)

/obj/item/device/radio/headset/distress/CLF/command
	desc = "小型训练有素的特工（或恐怖分子）使用的专用耳机。频道如下：:o - 殖民地， #a - 医疗， #b - 工程部， #c - 指挥， #d - 战斗控制员， #g - CLF通用。"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/clf/command)

//WY Headsets
/obj/item/device/radio/headset/distress/commando
	name = "突击队耳机"
	desc = "身份不明特工使用的专用耳机。频道如下：:g - 公共， :v - 陆战队指挥， :a - 阿尔法小队， :b - 布拉沃小队， :c - 查理小队， :d - 德尔塔小队， :n - 工程部， :m - 医疗舱， :u - 补给处， :j - JTAC， :t - 情报。"
	frequency = WY_WO_FREQ
	icon_state = "pmc_headset"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/mcom)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_WO
	minimap_flag = MINIMAP_FLAG_PMC

/obj/item/device/radio/headset/distress/contractor
	name = "VAI耳机"
	desc = "先锋之箭公司雇佣兵使用的专用耳机，配有非标准支架。频道如下：:g - 公共， :v - 陆战队指挥， :n - 工程部， :m - 医疗舱， :u - 补给处， :j - JTAC， :t - 情报。"
	frequency = VAI_FREQ
	icon_state = "vai_headset"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/contractor)
	has_hud = TRUE

/obj/item/device/radio/headset/distress/royal_marine
	name = "皇家海军陆战队耳机"
	desc = "皇家海军陆战队突击队使用的流线型耳机。外形低矮，足以适配其独特的头盔。"
	frequency = RMC_FREQ
	icon_state = "vai_headset"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/royal_marine)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_TWE
	volume = RADIO_VOLUME_IMPORTANT

/obj/item/device/radio/headset/distress/iasf
	name = "IASF耳机"
	desc = "IASF使用的流线型耳机。外形低调，可置于任何头戴装备之下。"
	frequency = RMC_FREQ
	icon_state = "vai_headset"
	initial_keys = list(/obj/item/device/encryptionkey/colony)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_IASF
	additional_hud_types = list(MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_IASF, MOB_HUD_FACTION_MARINE)
	volume = RADIO_VOLUME_IMPORTANT

//CMB Headsets
/obj/item/device/radio/headset/distress/CMB
	name = "\improper CMB Earpiece"
	desc = "殖民地执法局使用的流线型耳机，于太阳系制造。外形低调，佩戴舒适。法律面前，人人平等。特色频道包括：; - CMB, :o - 殖民地, :g - 公共, :v - 陆战队指挥, :m - 医疗舱, :t - 情报。"
	frequency = CMB_FREQ
	icon_state = "cmb_headset"
	initial_keys = list(/obj/item/device/encryptionkey/cmb)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_CMB
	additional_hud_types = list(MOB_HUD_FACTION_MARINE)

/obj/item/device/radio/headset/distress/CMB/limited
	name = "\improper Damaged CMB Earpiece"
	desc = "殖民地执法局使用的流线型耳机，于太阳系制造。外形低调，佩戴舒适。法律面前，人人平等。此耳机已损坏，可用频道为：; - CMB, :o - 殖民地。"
	initial_keys = list(/obj/item/device/encryptionkey/colony)

/obj/item/device/radio/headset/distress/CMB/ICC
	name = "\improper ICC Liaison Headset"
	desc = "星际商业委员会使用的昂贵耳机。此型号特别配备了与CMB的联络芯片。特色频道包括：; - CMB, :o - 殖民地, :g - 公共, :v - 陆战队指挥, :m - 医疗舱, :t - 情报, :y - 维兰德-汤谷。"
	icon_state = "wy_headset"
	additional_hud_types = list(MOB_HUD_FACTION_WY)
	initial_keys = list(/obj/item/device/encryptionkey/WY, /obj/item/device/encryptionkey/cmb)

/obj/item/device/radio/headset/distress/NSPA
	name = "NSPA耳机"
	desc = "NSPA使用的特殊耳机。"
	frequency = RMC_FREQ
	icon_state = "vai_headset"
	initial_keys = list(/obj/item/device/encryptionkey/almayer, /obj/item/device/encryptionkey/royal_marine)
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_NSPA
	additional_hud_types = list(MOB_HUD_FACTION_TWE)
	volume = RADIO_VOLUME_IMPORTANT

/obj/item/device/radio/headset/almayer/highcom
	name = "USCM最高指挥部耳机"
	desc = "配发给USCM最高指挥部成员及其直属部下。频道如下：:v - 陆战队指挥, :p - 宪兵, :a - 阿尔法班, :b - 布拉沃班, :c - 查理班, :d - 德尔塔班, :n - 工程部, :m - 医疗舱, :u - 补给处, :j - JTAC, :t - 情报, :z - 最高指挥部。"
	icon_state = "mhc_headset"
	frequency = HC_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/highcom)
	additional_hud_types = list(MOB_HUD_FACTION_WY, MOB_HUD_FACTION_CMB, MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_MARINE)
	volume = RADIO_VOLUME_CRITICAL
	has_hud = TRUE
	hud_type = MOB_HUD_SECURITY_ADVANCED

/obj/item/device/radio/headset/almayer/provost
	name = "USCM宪兵总监耳机"
	desc = "配发给USCM宪兵总监办公室成员及其直属部下。"
	icon_state = "pvst_headset"
	frequency = PVST_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/provost)
	additional_hud_types = list(MOB_HUD_FACTION_CMB, MOB_HUD_FACTION_MARINE)
	volume = RADIO_VOLUME_CRITICAL
	has_hud = TRUE
	hud_type = MOB_HUD_SECURITY_ADVANCED

/obj/item/device/radio/headset/almayer/sof
	name = "USCM特种作战部队耳机"
	desc = "仅配发给陆战队袭击者与USCM武装侦察部队成员。"
	icon_state = "soc_headset"
	frequency = SOF_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/soc)
	additional_hud_types = list(MOB_HUD_FACTION_WY, MOB_HUD_FACTION_CMB, MOB_HUD_FACTION_TWE)
	volume = RADIO_VOLUME_IMPORTANT

/obj/item/device/radio/headset/almayer/sof/survivor_forecon
	name = "USCM特种作战部队耳机"
	desc = "仅配发给陆战队袭击者与USCM武装侦察部队成员。"
	icon_state = "soc_headset"
	frequency = SOF_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/soc/forecon)
	volume = RADIO_VOLUME_QUIET
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_MARINE

/obj/item/device/radio/headset/almayer/mcom/vc
	name = "陆战队载具乘员无线电耳机"
	desc = "USCM载具乘员使用，配有非标准支架。频道如下：:v - 陆战队指挥, :n - 工程部, :m - 医疗舱, :u - 补给处。"
	initial_keys = list(/obj/item/device/encryptionkey/vc)
	volume = RADIO_VOLUME_RAISED
	multibroadcast_cooldown = HIGH_MULTIBROADCAST_COOLDOWN

/obj/item/device/radio/headset/distress/UPP/recon
	name = "\improper UPP headset"
	desc = "UPP军队侦察单位使用的特殊耳机。"
	frequency = UPP_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/upp)
	volume = RADIO_VOLUME_QUIET
	ignore_z = FALSE
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_UPP

/obj/item/device/radio/headset/distress/PaP
	name = "\improper UPP PaP headset"
	desc = "UPP人民武装警察使用的特殊耳机。"
	frequency = UPP_FREQ
	icon_state = "sec_headset"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/upp)
	ignore_z = FALSE
	has_hud = TRUE
	hud_type = MOB_HUD_FACTION_PAP
	additional_hud_types = list(MOB_HUD_FACTION_UPP)
	volume = RADIO_VOLUME_IMPORTANT
