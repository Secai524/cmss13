/datum/player_action/ban
	action_tag = "mob_ban"
	name = "封禁"
	permissions_required = R_BAN

/datum/player_action/ban/act(client/user, mob/target, list/params)
	user.cmd_admin_do_ban(target)
	return TRUE


/datum/player_action/jobban
	action_tag = "mob_jobban"
	name = "职位封禁"
	permissions_required = R_BAN

/datum/player_action/jobban/act(client/user, mob/target, list/params)
	user.cmd_admin_job_ban(target)
	return TRUE

/datum/player_action/eorgban
	action_tag = "mob_eorg_ban"
	name = "EORG封禁"
	permissions_required = R_BAN

/datum/player_action/eorgban/act(client/user, mob/target, list/params)
	if(target.client && target.client.admin_holder)
		return //admins cannot be banned. Even if they could, the ban doesn't affect them anyway

	if(!target.ckey)
		to_chat(user, SPAN_DANGER("<B>警告：未找到[target.name]的实体ckey。</b>"))
		return

	var/mins = 0
	var/reason = ""
	switch(alert("Are you sure you want to EORG ban [target.ckey]?", , "Yes", "No"))
		if("Yes")
			mins = 180
			reason = "EORG - Generating combat logs with, or otherwise griefing, friendly/allied players."
		if("No")
			return

	var/datum/entity/player/P = get_player_from_key(target.ckey) // you may not be logged in, but I will find you and I will ban you
	if(P.is_time_banned && alert(user, "封禁已存在。是否继续？", "确认", "Yes", "No") != "Yes")
		return
	P.add_timed_ban(reason, mins)

	return TRUE

/datum/player_action/permanent_ban
	action_tag = "permanent_ban"
	name = "永久封禁"
	permissions_required = R_BAN

/datum/player_action/permanent_ban/act(client/user, mob/target, list/params)
	var/reason = tgui_input_text(user, "应向被永久封禁的用户显示什么信息？", "永久封禁", encode = FALSE)
	if(!reason)
		return

	var/internal_reason = tgui_input_text(user, "封禁原因是什么？此信息仅内部可见，不会显示在公开记录和封禁信息中。请包含尽可能多的细节。", "永久封禁", multiline = TRUE, encode = FALSE)
	if(!internal_reason)
		return

	var/datum/entity/player/target_entity = target.client?.player_data
	if(!target_entity)
		target_entity = get_player_from_key(target.ckey || target.persistent_ckey)

	if(!target_entity)
		return

	if(!target_entity.add_perma_ban(reason, internal_reason, user.player_data))
		to_chat(user, SPAN_ADMIN("该用户已被永久封禁！如有必要，你可以移除永久封禁，并重新设置一个。"))

/datum/player_action/sticky_ban
	action_tag = "sticky_ban"
	name = "粘性封禁"
	permissions_required = R_BAN

/datum/player_action/sticky_ban/act(client/user, mob/target, list/params)
	var/datum/entity/player/player = get_player_from_key(target.ckey || target.persistent_ckey)
	if(!player)
		return

	var/persistent_ip = target.client?.address || player.last_known_ip
	var/persistent_cid = target.client?.computer_id || player.last_known_cid

	var/message = tgui_input_text(user, "应向受影响的用户显示什么信息？", "BuildABan", encode = FALSE)
	if(!message)
		return

	var/reason = tgui_input_text(user, "封禁原因是什么？此信息仅内部可见，不会显示在公开记录和封禁信息中。请包含尽可能多的细节。", "BuildABan", multiline = TRUE, encode = FALSE)
	if(!reason)
		return

	user.cmd_admin_do_stickyban(target.ckey, reason, message, impacted_ckeys = list(target.ckey), impacted_cids = list(persistent_cid), impacted_ips = list(persistent_ip))
	player.add_note("Stickybanned | [message]", FALSE, NOTE_ADMIN, TRUE)
	player.add_note("Internal reason: [reason]", TRUE, NOTE_ADMIN)

	if(target.client)
		qdel(target.client)

/datum/player_action/mute
	action_tag = "mob_mute"
	name = "禁言"


/datum/player_action/mute/act(client/user, mob/target, list/params)
	if(!target.client)
		return

	target.client.prefs.muted = text2num(params["mute_flag"])
	log_admin("[key_name(user)] set the mute flags for [key_name(target)] to [target.client.prefs.muted].")
	return TRUE

/datum/player_action/show_notes
	action_tag = "show_notes"
	name = "显示备注"


/datum/player_action/show_notes/act(client/user, mob/target, list/params)
	user.admin_holder.player_notes_show(target.ckey)
	return TRUE

/datum/player_action/check_ckey
	action_tag = "check_ckey"
	name = "检查Ckey"


/datum/player_action/check_ckey/act(client/user, mob/target, list/params)
	user.admin_holder.check_ckey(target.ckey)
	return TRUE

/datum/player_action/reset_xeno_name
	action_tag = "reset_xeno_name"
	name = "重置异形名称"


/datum/player_action/reset_xeno_name/act(client/user, mob/target, list/params)
	var/mob/living/carbon/xenomorph/X = target
	if(!isxeno(X))
		to_chat(user, SPAN_WARNING("[target.name]不是异形！"))
		return

	if(alert(user, "你确定要重置[X.ckey]的异形名称吗？", , "Yes", "No") != "Yes")
		return

	if(!X.ckey)
		to_chat(user, SPAN_DANGER("警告：未找到 [X.name] 的实体 CKEY。"))
		return

	message_admins("[user.ckey] has reset [X.ckey] xeno name")

	to_chat(X, SPAN_DANGER("警告：你的异形名称已被[user.ckey]重置。"))

	X.client.xeno_prefix = "XX"
	X.client.xeno_postfix = ""
	X.client.prefs.xeno_prefix = "XX"
	X.client.prefs.xeno_postfix = ""

	X.client.prefs.save_preferences()
	X.generate_name()

/datum/player_action/xeno_name_ban
	action_tag = "ban_xeno_name"
	name = "封禁异形名称"
	permissions_required = R_BAN



/datum/player_action/xeno_name_ban/act(client/user, mob/target, list/params)
	if(!target.client)
		return

	var/client/targetClient = target.client

	if(targetClient.xeno_name_ban)
		if(alert(user, "你确定要解封[target.ckey]并允许其使用异形名称吗？", ,"Yes", "No") != "Yes")
			return
		targetClient.xeno_name_ban = FALSE
		targetClient.prefs.xeno_name_ban = FALSE

		targetClient.prefs.save_preferences()
		message_admins("[user.ckey] has unbanned [target.ckey] from using xeno names")

		notes_add(target.ckey, "Xeno Name Unbanned by [user.ckey]", user.mob)
		to_chat(target, SPAN_DANGER("警告：你现在可以再次使用异形名称了。"))
		return

	if(!isxeno(target))
		to_chat(user, SPAN_DANGER("目标不是异形。操作中止。"))
		return

	if(alert("Are you sure you want to BAN [target.ckey] from ever using any xeno name?", , "Yes", "No") != "Yes")
		return

	if(!target.ckey)
		to_chat(user, SPAN_DANGER("警告：未找到[target.name]的实体ckey。"))
		return

	message_admins("[user.ckey] has banned [target.ckey] from using xeno names")

	notes_add(target.ckey, "Xeno Name Banned by [user.ckey]|Reason: Xeno name was [target.name]", user.mob)

	to_chat(target, SPAN_DANGER("警告：你已被[user.ckey]禁止使用异形名称。"))

	targetClient.xeno_prefix = "XX"
	targetClient.xeno_postfix = ""
	targetClient.xeno_name_ban = TRUE
	targetClient.prefs.xeno_prefix = "XX"
	targetClient.prefs.xeno_postfix = ""
	targetClient.prefs.xeno_name_ban = TRUE

	targetClient.prefs.save_preferences()

	var/mob/living/carbon/xenomorph/X = target
	X.generate_name()

/datum/player_action/reset_human_name
	action_tag = "reset_human_name"
	name = "重置人类名称"


/datum/player_action/reset_human_name/act(client/user, mob/target, list/params)
	var/mob/target_mob = target
	if(!ismob(target_mob))
		to_chat(user, SPAN_WARNING("[target.name]不是一个实体！"))
		return

	if(isxeno(target_mob))
		to_chat(user, SPAN_WARNING("[target.name]是异形！"))
		return

	if(!target_mob.client)
		to_chat(user, SPAN_WARNING("[target.name]没有客户端！"))
		return

	if(!target_mob.ckey)
		to_chat(user, SPAN_DANGER("警告：未找到[target_mob.name]的实体ckey。"))
		return

	if(alert(user, "你确定要重置[target_mob.ckey]的名称吗？", "确认", "Yes", "No") != "Yes")
		return

	var/new_name

	switch(alert(user, "你想为[target_mob.ckey]手动设置名称吗？", "确认", "Yes", "No", "Cancel"))
		if("Cancel")
			return
		if("No")
			new_name = random_name(target_mob.gender)
		if("Yes")
			var/raw_name = input(user, "选择新名称：", "Name Input")  as text|null
			if(!isnull(raw_name)) // Check to ensure that the user entered text (rather than cancel.)
				new_name = reject_bad_name(raw_name)

	if(!new_name)
		to_chat(user, SPAN_NOTICE("名称无效。名称长度应至少为2个字符，最多为[MAX_NAME_LEN]个字符。只能包含A-Z、a-z、-、'和.字符。"))
		return

	if(!target_mob.client)
		to_chat(user, SPAN_WARNING("[target.name]没有客户端！"))
		return

	if(!target_mob.ckey)
		to_chat(user, SPAN_DANGER("警告：未找到[target_mob.name]的实体ckey。"))
		return

	target_mob.change_real_name(target_mob, new_name)
	GLOB.data_core.manifest_modify(new_name, WEAKREF(target_mob))
	if(ishuman(target_mob))
		var/mob/living/carbon/human/target_human = target_mob
		var/obj/item/card/id/card = target_human.get_idcard()
		if(card?.registered_ref == WEAKREF(target_human))
			card.name = "[target_human.real_name]'s [card.id_type]"
			card.registered_name = "[target_human.real_name]"
			if(card.assignment)
				card.name += " ([card.assignment])"

	target_mob.client.prefs.real_name = new_name
	target_mob.client.prefs.save_character()

	message_admins("[user.ckey] has reset [target_mob.ckey]'s name.")

	to_chat(target_mob, FONT_SIZE_HUGE(SPAN_ADMINHELP("Warning: Your name has been reset by [user.ckey].")))

	playsound_client(target_mob.client, sound('sound/effects/adminhelp_new.ogg'), src, 50)

/datum/player_action/ban_human_name
	action_tag = "ban_human_name"
	name = "禁止人类名称"
	permissions_required = R_BAN


/datum/player_action/ban_human_name/act(client/user, mob/target, list/params)
	if(!target.client || !target.ckey)
		to_chat(user, SPAN_NOTICE("目标缺少客户端或ckey。操作中止。"))
		return

	var/client/target_client = target.client

	if(target_client.human_name_ban)
		if(alert(user, "你确定要解除对[target.ckey]的禁令，允许其使用人类名称吗？", "确认", "Yes", "No") != "Yes")
			return

		if(!target.client || !target.ckey)
			to_chat(user, SPAN_NOTICE("目标缺少客户端或ckey。操作中止。"))
			return

		target_client.human_name_ban = FALSE
		target_client.prefs.human_name_ban = FALSE

		target_client.prefs.save_preferences()
		message_admins("[user.ckey] has unbanned [target.ckey] from using human names.")

		notes_add(target.ckey, "Human Name Unbanned by [user.ckey]", user.mob)

		to_chat(target, FONT_SIZE_HUGE(SPAN_ADMINHELP("Warning: You can use human names again.")))
		return


	if(alert("Are you sure you want to BAN [target.ckey] from ever using any human names?", "确认", "Yes", "No") != "Yes")
		return

	if(!target.client || !target.ckey)
		to_chat(user, SPAN_NOTICE("目标缺少客户端或ckey。操作中止。"))
		return

	message_admins("[user.ckey] has banned [target.ckey] from using human names.")

	notes_add(target.ckey, "Human Name Banned by [user.ckey]", user.mob)

	to_chat(target, FONT_SIZE_HUGE(SPAN_ADMINHELP("Warning: You were banned from using human names by [user.ckey].")))
	playsound_client(target_client, sound('sound/effects/adminhelp_new.ogg'), src, 50)

	var/new_name = random_name(target.gender)
	target_client.prefs.real_name = new_name

	target_client.human_name_ban = TRUE
	target_client.prefs.real_name = ""
	target_client.prefs.human_name_ban = TRUE

	target_client.prefs.save_character()
	target_client.prefs.save_preferences()
