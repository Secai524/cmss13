/*
	HOW DO I LOG DREAM DAEMON RUNTIMES?
	Firstly, start dreamdeamon if it isn't already running. Then select "world>Log Session" (or press the F3 key)
	navigate the popup window to the data/logs/runtime/ folder from where your tgstation .dmb is located.
	(you may have to make this folder yourself)

	OPTIONAL: you can select the little checkbox down the bottom to make dreamdeamon save the log everytime you
				start a world. Just remember to repeat these steps with a new name when you update to a new revision!

	Save it with the name of the revision your server uses (e.g. r3459.txt).
*/

/// This proc allows download of past server logs saved within the data/logs/ folder.
/datum/admins/proc/getserverlog()
	set name = ".getserverlog"
	set desc = "Pick a logfile from data/logs to view."
	set category = null

	if(!check_rights(R_MOD|R_DEBUG))
		return

	var/path = usr.client.browse_files("data/logs/")
	if(!path)
		return

	if(usr.client.file_spam_check())
		return

	message_admins("[key_name_admin(src)] accessed file: [path]")
	to_chat(src, "正在尝试发送文件，如果文件非常大，这可能需要相当几分钟。")
	src << ftp(file(path))

/// Shows this round's game log
/datum/admins/proc/view_game_log()
	set name = "Show Server Game Log"
	set desc = "Shows this round's game log."
	set category = "Server"

	if(!check_rights(R_MOD|R_DEBUG))
		return

	var/path = GLOB.world_game_log
	if(!fexists(path))
		to_chat(src, "<font color='red'>错误：view_log()：文件未找到/路径无效([path])。</font>")
		return

	if(usr.client.file_spam_check())
		return

	message_admins("[key_name_admin(src)] accessed file: [path]")
	to_chat(src, "正在尝试发送文件，如果文件非常大，这可能需要相当几分钟。")
	src << ftp(file(path))

/// Shows this round's attack log
/datum/admins/proc/view_attack_log()
	set name = "Show Server Attack Log"
	set desc = "Shows this round's attack log."
	set category = "Server"

	if(!check_rights(R_MOD|R_DEBUG))
		return

	var/path = GLOB.world_attack_log
	if(!fexists(path))
		to_chat(src, "<font color='red'>错误：view_log()：文件未找到/路径无效([path])。</font>")
		return

	if(usr.client.file_spam_check())
		return

	message_admins("[key_name_admin(src)] accessed file: [path]")
	to_chat(src, "正在尝试发送文件，如果文件非常大，这可能需要相当几分钟。")
	src << ftp(file(path))

/// Shows this round's runtime log
/datum/admins/proc/view_runtime_log()
	set name = "Show Server Runtime Log"
	set desc = "Shows this round's runtime log."
	set category = "Server"

	if(!check_rights(R_MOD|R_DEBUG))
		return

	var/path = GLOB.world_runtime_log
	if(!fexists(path))
		to_chat(src, "<font color='red'>错误：view_log()：文件未找到/路径无效([path])。</font>")
		return

	if(usr.client.file_spam_check())
		return

	message_admins("[key_name_admin(src)] accessed file: [path]")
	to_chat(src, "正在尝试发送文件，如果文件非常大，这可能需要相当几分钟。")
	src << ftp(file(path))

/// Shows this round's href log
/datum/admins/proc/view_href_log()
	set name = "Show Server HREF Log"
	set desc = "Shows this round's HREF log."
	set category = "Server"

	if(!check_rights(R_MOD|R_DEBUG))
		return

	var/path = GLOB.world_href_log
	if(!fexists(path))
		to_chat(src, "<font color='red'>错误：view_log()：文件未找到/路径无效([path])。</font>")
		return

	if(usr.client.file_spam_check())
		return

	message_admins("[key_name_admin(src)] accessed file: [path]")
	to_chat(src, "正在尝试发送文件，如果文件非常大，这可能需要相当几分钟。")
	src << ftp(file(path))

/// Shows this round's tgui log
/datum/admins/proc/view_tgui_log()
	set name = "Show Server TGUI Log"
	set desc = "Shows this round's TGUI log."
	set category = "Server"

	if(!check_rights(R_MOD|R_DEBUG))
		return

	var/path = GLOB.tgui_log
	if(!fexists(path))
		to_chat(src, "<font color='red'>错误：view_log()：文件未找到/路径无效([path])。</font>")
		return

	if(usr.client.file_spam_check())
		return

	message_admins("[key_name_admin(src)] accessed file: [path]")
	to_chat(src, "正在尝试发送文件，如果文件非常大，这可能需要相当几分钟。")
	src << ftp(file(path))
