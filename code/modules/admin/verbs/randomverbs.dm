
#define ANTIGRIEF_OPTION_ENABLED "Enabled"
#define ANTIGRIEF_OPTION_NEW_PLAYERS "Enabled for New Players"
#define ANTIGRIEF_OPTION_DISABLED "Disabled"

/client/proc/cmd_mentor_check_new_players() //Allows mentors / admins to determine who the newer players are.
	set category = "Admin"
	set name = "Check new Players"

	if(!admin_holder)
		to_chat(src, "你无权使用此功能。")
		return

	if(!CLIENT_IS_STAFF(src))
		if(!CLIENT_IS_MENTOR(src))
			to_chat(src, "只有工作人员有权使用此功能。")
			return
		if(!CONFIG_GET(flag/mentor_tools))
			to_chat(src, "导师无权使用此功能。")

	var/age = alert(src, "年龄检查", "Show accounts up to how many days old ?", "7", "30" , "All")

	if(age == "All")
		age = 9999999
	else
		age = text2num(age)

	var/missing_ages = FALSE
	var/msg = ""

	for(var/client/C in GLOB.clients)
		if(C.player_age == "Requires database")
			missing_ages = 1
			continue
		if(C.player_age < age)
			msg += "[key_name(C, 1, 1, CLIENT_IS_STAFF(src))]: account is [C.player_age] days old<br>"

	if(missing_ages)
		to_chat(src, "部分账户未在客户端设置正确的年龄。此功能需要数据库支持。")

	if(msg != "")
		show_browser(src, msg, "Check New Players", "Player_age_check")
	else
		to_chat(src, "未找到符合该年龄范围的匹配项。")

/proc/cmd_admin_mute(mob/M as mob, mute_type, automute = 0)
	if(automute && !CONFIG_GET(flag/automute_on))
		return FALSE
	if(!M.client)
		to_chat(usr, SPAN_WARNING("此实体没有关联的客户端。"))
		return FALSE
	else
		if(!usr || !usr.client)
			return FALSE
		if(!usr.client.admin_holder || !(usr.client.admin_holder.rights & R_MOD))
			to_chat(usr, SPAN_WARNING("错误：你无权执行此操作。"))
			return FALSE
		if(M.client.admin_holder && (M.client.admin_holder.rights & R_MOD))
			to_chat(usr, SPAN_WARNING("错误：你无法禁言管理员/版主。"))
			return FALSE

	var/muteunmute
	var/mute_string

	switch(mute_type)
		if(MUTE_IC)
			mute_string = "IC (say and emote)"
		if(MUTE_OOC)
			mute_string = "OOC"
		if(MUTE_PRAY)
			mute_string = "pray"
		if(MUTE_ADMINHELP)
			mute_string = "adminhelp, admin PM and ASAY"
		if(MUTE_DEADCHAT)
			mute_string = "deadchat and DSAY"
		if(MUTE_ALL)
			mute_string = "everything"
		else
			return FALSE

	if(automute)
		muteunmute = "auto-muted"
		M.client.prefs.muted |= mute_type
		message_admins("SPAM AUTOMUTE: [muteunmute] [key_name_admin(M)] from [mute_string].", 1)
		to_chat(M, "你已被SPAM自动禁言系统[muteunmute]了[mute_string]权限。请联系管理员。")

		return FALSE

	if(M.client.prefs.muted & mute_type)
		muteunmute = "unmuted"
		M.client.prefs.muted &= ~mute_type
	else
		muteunmute = "muted"
		M.client.prefs.muted |= mute_type

	message_admins("[key_name_admin(usr)] has [muteunmute] [key_name_admin(M)] from [mute_string].", 1)
	to_chat(M, "你已被[muteunmute]了[mute_string]权限。")

/client/proc/toggle_own_ghost_vis()
	set name = "Show/Hide Own Ghost"
	set desc = "Toggle your visibility as a ghost to other ghosts."
	set category = "Preferences.Ghost"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		return

	if(isobserver(usr))
		if(usr.invisibility <> 60 && usr.layer <> 4.0)
			usr.invisibility = 60
			usr.layer = MOB_LAYER
			to_chat(usr, SPAN_WARNING("幽灵可见性已恢复正常。"))
		else
			usr.invisibility = 70
			usr.layer = BELOW_MOB_LAYER
			to_chat(usr, SPAN_WARNING("你的幽灵现在对其他幽灵不可见。"))
		log_admin("Admin [key_name(src)] has toggled Ordukai Mode.")
	else
		to_chat(usr, SPAN_WARNING("你需要处于幽灵状态才能使用此功能。"))

/client/proc/set_explosive_antigrief()
	set name = "Set Explosive Antigrief"
	set category = "Admin.Game"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		return


	var/antigrief_choice = tgui_input_list(usr, "选择首选反恶意破坏类型：", "Select", list(ANTIGRIEF_OPTION_ENABLED, ANTIGRIEF_OPTION_NEW_PLAYERS, ANTIGRIEF_OPTION_DISABLED))
	if(!antigrief_choice)
		return

	switch(antigrief_choice)
		if(ANTIGRIEF_OPTION_DISABLED)
			CONFIG_SET(number/explosive_antigrief, ANTIGRIEF_DISABLED)
			message_admins(FONT_SIZE_LARGE("[key_name_admin(usr)] has disabled explosive antigrief."))
		if(ANTIGRIEF_OPTION_ENABLED)
			message_admins(FONT_SIZE_LARGE("[key_name_admin(usr)] has fully enabled explosive antigrief for all players."))
			CONFIG_SET(number/explosive_antigrief, ANTIGRIEF_ENABLED)
		if(ANTIGRIEF_OPTION_NEW_PLAYERS)
			message_admins(FONT_SIZE_LARGE("[key_name_admin(usr)] has enabled explosive antigrief for new players (less than 10 total human hours)."))
			CONFIG_SET(number/explosive_antigrief, ANTIGRIEF_NEW_PLAYERS)
		else
			message_admins(FONT_SIZE_LARGE("Error! [key_name_admin(usr)] attempted to toggle explosive antigrief but the selected value was [antigrief_choice]. Setting it to enabled."))
			CONFIG_SET(number/explosive_antigrief, ANTIGRIEF_ENABLED)

/client/proc/check_explosive_antigrief()
	set name = "Check Explosive Antigrief"
	set category = "Admin.Game"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		return

	switch(CONFIG_GET(number/explosive_antigrief))
		if(ANTIGRIEF_DISABLED)
			to_chat(src, SPAN_BOLDNOTICE("爆炸物反恶意破坏当前已禁用。"))
		if(ANTIGRIEF_ENABLED)
			to_chat(src, SPAN_BOLDNOTICE("爆炸物反恶意破坏当前已完全启用。"))
		if(ANTIGRIEF_NEW_PLAYERS)
			to_chat(src, SPAN_BOLDNOTICE("爆炸物反恶意破坏当前对新玩家启用。"))
		else
			to_chat(src, SPAN_BOLDNOTICE("爆炸物反恶意破坏值未知...你可能需要修复此问题。"))

#undef ANTIGRIEF_OPTION_ENABLED
#undef ANTIGRIEF_OPTION_NEW_PLAYERS
#undef ANTIGRIEF_OPTION_DISABLED
