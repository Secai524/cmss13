/datum/admins/proc/CheckAdminHref(href, href_list)
	var/auth = href_list["admin_token"]
	. = auth && (auth == href_token || auth == GLOB.href_token)
	if(.)
		return
	var/msg = !auth ? "no" : "a bad"
	message_admins("[key_name_admin(usr)] clicked an href with [msg] authorization key!")
	if(CONFIG_GET(flag/debug_admin_hrefs))
		message_admins("Debug mode enabled, call not blocked. Please ask your coders to review this round's logs.")
		log_world("UAH: [href]")
		return TRUE
	log_admin_private("[key_name(usr)] clicked an href with [msg] authorization key! [href]")

/datum/admins/Topic(href, href_list)
	..()

	if(usr.client != src.owner || !check_rights(0))
		message_admins("[usr.key] has attempted to override the admin panel!")
		return

	if(!CheckAdminHref(href, href_list))
		return


	if(href_list["ahelp"])
		if(!check_rights(R_ADMIN|R_MOD, TRUE))
			return

		var/ahelp_ref = href_list["ahelp"]
		var/datum/admin_help/AH = locate(ahelp_ref)
		if(AH)
			AH.Action(href_list["ahelp_action"])
		else
			to_chat(usr, "工单[ahelp_ref]已被删除！", confidential = TRUE)
		return

	if(href_list["adminplayeropts"])
		var/mob/M = locate(href_list["adminplayeropts"])
		show_player_panel(M)
		return

	if(href_list["editrights"])
		if(!check_rights(R_PERMISSIONS))
			message_admins("[key_name_admin(usr)] attempted to edit the admin permissions without sufficient rights.")
			return

		var/adm_ckey

		var/task = href_list["editrights"]
		if(task == "add")
			var/new_ckey = ckey(input(usr,"新管理员的CKEY","Admin ckey", null) as text|null)
			if(!new_ckey)
				return
			if(new_ckey in GLOB.admin_datums)
				to_chat(usr, "<font color='red'>错误：主题'editrights'：[new_ckey]已是管理员</font>")
				return
			adm_ckey = new_ckey
			task = "rank"
		else if(task != "show")
			adm_ckey = ckey(href_list["ckey"])
			if(!adm_ckey)
				to_chat(usr, "<font color='red'>错误：主题'editrights'：CKEY无效</font>")
				return

		var/datum/admins/D = GLOB.admin_datums[adm_ckey]

		if(task == "remove")
			if(alert("Are you sure you want to remove [adm_ckey]?","消息","Yes","Cancel") == "Yes")
				if(!D)
					return
				GLOB.admin_datums -= adm_ckey
				D.disassociate()

				message_admins("[key_name_admin(usr)] removed [adm_ckey] from the admins list")

		else if(task == "rank")
			var/new_rank
			if(length(GLOB.admin_ranks))
				new_rank = tgui_input_list(usr, "请选择等级", "New rank", (GLOB.admin_ranks|"*New Rank*"))
			else
				new_rank = tgui_input_list(usr, "请选择等级", "New rank", list("Game Master","Game Admin", "Trial Admin", "Admin Observer","*New Rank*"))

			var/rights = 0
			if(D)
				rights = D.rights
			switch(new_rank)
				if(null,"")
					return
				if("*New Rank*")
					new_rank = input("Please input a new rank", "新自定义等级", null, null) as null|text
					if(CONFIG_GET(flag/admin_legacy_system))
						new_rank = ckeyEx(new_rank)
					if(!new_rank)
						to_chat(usr, "<font color='red'>错误：主题'editrights'：等级无效</font>")
						return
					if(CONFIG_GET(flag/admin_legacy_system))
						if(length(GLOB.admin_ranks))
							if(new_rank in GLOB.admin_ranks)
								rights = GLOB.admin_ranks[new_rank] //we typed a rank which already exists, use its rights
							else
								GLOB.admin_ranks[new_rank] = 0 //add the new rank to admin_ranks
				else
					if(CONFIG_GET(flag/admin_legacy_system))
						new_rank = ckeyEx(new_rank)
						rights = GLOB.admin_ranks[new_rank] //we input an existing rank, use its rights

			if(D)
				D.disassociate() //remove adminverbs and unlink from client
				D.rank = new_rank //update the rank
				D.rights = rights //update the rights based on admin_ranks (default: 0)
			else
				D = new /datum/admins(new_rank, rights, adm_ckey)

			var/client/C = GLOB.directory[adm_ckey] //find the client with the specified ckey (if they are logged in)
			D.associate(C) //link up with the client and add verbs

			message_admins("[key_name_admin(usr)] edited the admin rank of [adm_ckey] to [new_rank]")

		else if(task == "permissions")
			if(!D)
				return
			var/list/permissionlist = list()
			for(var/i=1, i<=R_HOST, i<<=1) //that <<= is shorthand for i = i << 1. Which is a left bitshift
				permissionlist[rights2text(i)] = i
			var/new_permission = tgui_input_list(usr, "选择要开启/关闭的权限", "Permission toggle", permissionlist)
			if(!new_permission)
				return
			D.rights ^= permissionlist[new_permission]

			message_admins("[key_name_admin(usr)] toggled the [new_permission] permission of [adm_ckey]")

//======================================================
//Everything that has to do with evac and self-destruct.
//The rest of this is awful.
//======================================================
	if(href_list["evac_authority"])
		switch(href_list["evac_authority"])
			if("init_evac")
				if(!SShijack.initiate_evacuation())
					to_chat(usr, SPAN_WARNING("你现在无法启动撤离程序！"))
				else
					message_admins("[key_name_admin(usr)] called an evacuation.")

			if("cancel_evac")
				if(!SShijack.cancel_evacuation())
					to_chat(usr, SPAN_WARNING("你现在无法取消撤离程序！"))
				else
					message_admins("[key_name_admin(usr)] canceled an evacuation.")

			if("toggle_evac")
				SShijack.evac_admin_denied = !SShijack.evac_admin_denied
				message_admins("[key_name_admin(usr)] has [SShijack.evac_admin_denied ? "forbidden" : "allowed"] ship-wide evacuation.")

//======================================================
//======================================================

	else if(href_list["delay_round_end"])
		if(!check_rights(R_SERVER))
			return

		SSticker.delay_end = !SSticker.delay_end
		message_admins("[key_name(usr)] [SSticker.delay_end ? "delayed the round end" : "has made the round end normally"].")

	/////////////////////////////////////new ban stuff

	else if(href_list["sticky"])
		if(href_list["view_all_ckeys"])
			var/list/datum/view_record/stickyban_matched_ckey/all_ckeys = DB_VIEW(/datum/view_record/stickyban_matched_ckey,
				DB_COMP("linked_stickyban", DB_EQUALS, href_list["sticky"])
			)

			var/list/keys = list()
			var/list/whitelisted = list()
			for(var/datum/view_record/stickyban_matched_ckey/match as anything in all_ckeys)
				if(match.whitelisted)
					whitelisted += match.ckey
				else
					keys += match.ckey

			show_browser(owner, "Impacted: [english_list(keys)]<br><br>Whitelisted: [english_list(whitelisted)]", "Stickyban Keys", "stickykeys")
			return

		if(href_list["view_all_cids"])
			var/list/datum/view_record/stickyban_matched_cid/all_cids = DB_VIEW(/datum/view_record/stickyban_matched_cid,
				DB_COMP("linked_stickyban", DB_EQUALS, href_list["sticky"])
			)

			var/list/cids = list()
			for(var/datum/view_record/stickyban_matched_cid/match as anything in all_cids)
				cids += match.cid

			show_browser(owner, english_list(cids), "Stickyban CIDs", "stickycids")
			return

		if(href_list["view_all_ips"])
			var/list/datum/view_record/stickyban_matched_ip/all_ips = DB_VIEW(/datum/view_record/stickyban_matched_ip,
				DB_COMP("linked_stickyban", DB_EQUALS, href_list["sticky"])
			)

			var/list/ips = list()
			for(var/datum/view_record/stickyban_matched_ip/match as anything in all_ips)
				ips += match.ip

			show_browser(owner, english_list(ips), "Stickyban IPs", "stickycips")
			return

		if(href_list["find_sticky"])
			var/ckey = ckey(tgui_input_text(owner, "我们应该为哪个CKEY查找粘性封禁？", "FindABan"))
			if(!ckey)
				return

			var/list/datum/view_record/stickyban/stickies = SSstickyban.check_for_sticky_ban(ckey)
			if(!stickies)
				to_chat(owner, SPAN_ADMIN("未找到影响 [ckey] 的任何粘性封禁。"))
				return

			var/list/impacting_stickies = list()

			for(var/datum/view_record/stickyban/sticky as anything in stickies)
				impacting_stickies += sticky.identifier

			to_chat(owner, SPAN_ADMIN("找到 [ckey] 的以下粘性封禁：[english_list(impacting_stickies)]"))

		if(!check_rights_for(owner, R_BAN))
			return

		if(href_list["new_sticky"])
			owner.cmd_admin_do_stickyban()
			return

		var/datum/entity/stickyban/sticky = DB_ENTITY(/datum/entity/stickyban, href_list["sticky"])
		if(!sticky)
			return

		sticky.sync()

		if(href_list["whitelist_ckey"])
			var/ckey_to_whitelist = ckey(tgui_input_text(owner, "应将哪个 CKEY 加入白名单？正在编辑粘性封禁：[sticky.identifier]"))
			if(!ckey_to_whitelist)
				return

			SSstickyban.whitelist_ckey(sticky.id, ckey_to_whitelist)
			message_admins("[key_name_admin(owner)] has whitelisted [ckey_to_whitelist] against stickyban '[sticky.identifier]'.")
			important_message_external("[owner] has whitelisted [ckey_to_whitelist] against stickyban '[sticky.identifier]'.", "CKEY Whitelisted")

		if(href_list["add"])
			var/option = tgui_input_list(owner, "你想添加什么？", "AddABan", list("CID", "CKEY", "IP"))
			if(!option)
				return

			var/to_add = tgui_input_text(owner, "提供要添加到粘性封禁的 [option]。", "AddABan")
			if(!to_add)
				return

			switch(option)
				if("CID")
					SSstickyban.add_matched_cid(sticky.id, to_add)
				if("CKEY")
					SSstickyban.add_matched_ckey(sticky.id, to_add)
				if("IP")
					SSstickyban.add_matched_ip(sticky.id, to_add)

			message_admins("[key_name_admin(owner)] has added a [option] ([to_add]) to stickyban '[sticky.identifier]'.")
			important_message_external("[owner] has added a [option] ([to_add]) to stickyban '[sticky.identifier]'.", "[option] Added to Stickyban")

		if(href_list["remove"])
			var/option = tgui_input_list(owner, "你想移除什么？", "DelABan", list("Entire Stickyban", "CID", "CKEY", "IP"))
			switch(option)
				if("Entire Stickyban")
					if(!(tgui_alert(owner, "你确定要移除这个粘性封禁吗？标识符：[sticky.identifier] 原因：[sticky.reason]", "确认", list("Yes", "No")) == "Yes"))
						return

					sticky.active = FALSE
					sticky.save()

					message_admins("[key_name_admin(owner)] has deactivated stickyban '[sticky.identifier]'.")
					important_message_external("[owner] has deactivated stickyban '[sticky.identifier]'.", "Stickyban Deactivated")

				if("CID")
					var/list/datum/view_record/stickyban_matched_cid/all_cids = DB_VIEW(/datum/view_record/stickyban_matched_cid,
						DB_COMP("linked_stickyban", DB_EQUALS, sticky.id)
					)

					var/list/cid_to_record_id = list()
					for(var/datum/view_record/stickyban_matched_cid/match in all_cids)
						cid_to_record_id["[match.cid]"] = match.id

					var/picked = tgui_input_list(owner, "要移除哪个 CID？", "DelABan", cid_to_record_id)
					if(!picked)
						return

					var/selected = cid_to_record_id[picked]

					var/datum/entity/stickyban_matched_cid/sticky_cid = DB_ENTITY(/datum/entity/stickyban_matched_cid, selected)
					sticky_cid.delete()

					message_admins("[key_name_admin(owner)] has removed a CID ([picked]) from stickyban '[sticky.identifier]'.")
					important_message_external("[owner] has removed a CID ([picked]) from stickyban '[sticky.identifier]'.", "CID Removed from Stickyban")

				if("CKEY")
					var/list/datum/view_record/stickyban_matched_ckey/all_ckeys = DB_VIEW(/datum/view_record/stickyban_matched_ckey,
						DB_COMP("linked_stickyban", DB_EQUALS, sticky.id)
					)

					var/list/ckey_to_record_id = list()
					for(var/datum/view_record/stickyban_matched_ckey/match in all_ckeys)
						ckey_to_record_id["[match.ckey]"] = match.id

					var/picked = tgui_input_list(owner, "要移除哪个 CKEY？", "DelABan", ckey_to_record_id)
					if(!picked)
						return

					var/selected = ckey_to_record_id[picked]

					var/datum/entity/stickyban_matched_ckey/sticky_ckey = DB_ENTITY(/datum/entity/stickyban_matched_ckey, selected)
					sticky_ckey.delete()

					message_admins("[key_name_admin(owner)] has removed a CKEY ([picked]) from stickyban '[sticky.identifier]'.")
					important_message_external("[owner] has removed a CKEY ([picked]) from stickyban '[sticky.identifier]'.", "CKEY Removed from Stickyban")

				if("IP")
					var/list/datum/view_record/stickyban_matched_ip/all_ips = DB_VIEW(/datum/view_record/stickyban_matched_ip,
						DB_COMP("linked_stickyban", DB_EQUALS, sticky.id)
					)

					var/list/ip_to_record_id = list()
					for(var/datum/view_record/stickyban_matched_ip/match in all_ips)
						ip_to_record_id["[match.ip]"] = match.id

					var/picked = tgui_input_list(owner, "要移除哪个 IP？", "DelABan", ip_to_record_id)
					if(!picked)
						return

					var/selected = ip_to_record_id[picked]

					var/datum/entity/stickyban_matched_ip/sticky_ip = DB_ENTITY(/datum/entity/stickyban_matched_ip, selected)
					sticky_ip.delete()

					message_admins("[key_name_admin(owner)] has removed an IP ([picked]) from stickyban [sticky.identifier].")
					important_message_external("[owner] has removed an IP ([picked]) from stickyban '[sticky.identifier].", "IP Removed from Stickyban")

	else if(href_list["warn"])
		usr.client.warn(href_list["warn"])

	else if(href_list["unbanupgradeperma"])
		if(!check_rights(R_ADMIN))
			return
		UpdateTime()
		var/reason

		var/banfolder = href_list["unbanupgradeperma"]
		GLOB.Banlist.cd = "/base/[banfolder]"
		var/reason2 = GLOB.Banlist["reason"]

		var/minutes = GLOB.Banlist["minutes"]

		var/banned_key = GLOB.Banlist["key"]
		GLOB.Banlist.cd = "/base"

		var/mins = 0
		if(minutes > GLOB.CMinutes)
			mins = minutes - GLOB.CMinutes
		if(!mins)
			return
		mins = max(5255990,mins) // 10 years
		minutes = GLOB.CMinutes + mins
		reason = input(usr,"原因？","reason",reason2) as message|null
		if(!reason)
			return

		ban_unban_log_save("[key_name(usr)] upgraded [banned_key]'s ban to a permaban. Reason: [sanitize(reason)]")
		message_admins("[key_name_admin(usr)] upgraded [banned_key]'s ban to a permaban. Reason: [sanitize(reason)]")
		GLOB.Banlist.cd = "/base/[banfolder]"
		GLOB.Banlist["reason"] << sanitize(reason)
		GLOB.Banlist["temp"] << 0
		GLOB.Banlist["minutes"] << minutes
		GLOB.Banlist["bannedby"] << usr.ckey
		GLOB.Banlist.cd = "/base"
		unbanpanel()

	else if(href_list["unbane"])
		if(!check_rights(R_BAN))
			return

		UpdateTime()
		var/reason

		var/banfolder = href_list["unbane"]
		GLOB.Banlist.cd = "/base/[banfolder]"
		var/reason2 = GLOB.Banlist["reason"]
		var/temp = GLOB.Banlist["temp"]

		var/minutes = GLOB.Banlist["minutes"]

		var/banned_key = GLOB.Banlist["key"]
		GLOB.Banlist.cd = "/base"

		var/duration

		var/mins = 0
		if(minutes > GLOB.CMinutes)
			mins = minutes - GLOB.CMinutes
		mins = tgui_input_number(usr,"时长（分钟）？\n 1440 = 1天 \n 4320 = 3天 \n 10080 = 7天 \n 43800 = 1个月","Ban time", 1440, 262800, 1)
		if(!mins)
			return
		mins = min(525599,mins)
		minutes = GLOB.CMinutes + mins
		duration = GetExp(minutes)
		reason = input(usr,"原因？","reason",reason2) as message|null
		if(!reason)
			return

		ban_unban_log_save("[key_name(usr)] edited [banned_key]'s ban. Reason: [sanitize(reason)] Duration: [duration]")
		message_admins("[key_name_admin(usr)] edited [banned_key]'s ban. Reason: [sanitize(reason)] Duration: [duration]")
		GLOB.Banlist.cd = "/base/[banfolder]"
		GLOB.Banlist["reason"] << sanitize(reason)
		GLOB.Banlist["temp"] << temp
		GLOB.Banlist["minutes"] << minutes
		GLOB.Banlist["bannedby"] << usr.ckey
		GLOB.Banlist.cd = "/base"
		unbanpanel()

	/////////////////////////////////////new ban stuff

	//JOBBAN'S INNARDS
	else if(href_list["jobban3"])
		if(!check_rights(R_MOD,0) && !check_rights(R_ADMIN))  return

		var/mob/M = locate(href_list["jobban4"])
		if(!ismob(M))
			to_chat(usr, "这只能用于类型为 /mob 的实例。")
			return

		if(M != usr) //we can jobban ourselves
			if(M.client && M.client.admin_holder && (M.client.admin_holder.rights & R_BAN)) //they can ban too. So we can't ban them
				alert("你无法执行此操作。你必须拥有更高的管理员等级！")
				return

		if(!GLOB.RoleAuthority)
			to_chat(usr, "角色权限尚未设置！")
			return


		var/datum/entity/player/P1 = M.client?.player_data
		if(!P1)
			P1 = get_player_from_key(M.ckey)

		//get jobs for department if specified, otherwise just return the one job in a list.
		var/list/joblist = list()
		switch(href_list["jobban3"])
			if("CICdept")
				joblist += get_job_titles_from_list(GLOB.ROLES_COMMAND)
			if("Supportdept")
				joblist += get_job_titles_from_list(GLOB.ROLES_AUXIL_SUPPORT)
			if("Policedept")
				joblist += get_job_titles_from_list(GLOB.ROLES_POLICE)
			if("Engineeringdept")
				joblist += get_job_titles_from_list(GLOB.ROLES_ENGINEERING)
			if("Requisitiondept")
				joblist += get_job_titles_from_list(GLOB.ROLES_REQUISITION)
			if("Medicaldept")
				joblist += get_job_titles_from_list(GLOB.ROLES_MEDICAL)
			if("Marinesdept")
				joblist += get_job_titles_from_list(GLOB.ROLES_MARINES)
			if("Miscdept")
				joblist += get_job_titles_from_list(GLOB.ROLES_MISC)
			if("Xenosdept")
				joblist += get_job_titles_from_list(GLOB.ROLES_XENO)
			else
				joblist += href_list["jobban3"]

		var/list/notbannedlist = list()
		for(var/job in joblist)
			if(!jobban_isbanned(M, job, P1))
				notbannedlist += job

		//Banning comes first
		if(length(notbannedlist))
			if(!check_rights(R_BAN))  return
			var/reason = input(usr,"原因？","Please State Reason","") as text|null
			if(reason)
				var/datum/entity/player/P = get_player_from_key(M.ckey)
				P.add_job_ban(reason, notbannedlist)

				href_list["jobban2"] = 1 // lets it fall through and refresh
				return 1

		//Unbanning joblist
		//all jobs in joblist are banned already OR we didn't give a reason (implying they shouldn't be banned)
		if(length(joblist)) //at least 1 banned job exists in joblist so we have stuff to unban.
			for(var/job in joblist)
				var/reason = jobban_isbanned(M, job, P1)
				if(!reason)
					continue //skip if it isn't jobbanned anyway
				switch(alert("Job: '[job]' Reason: '[reason]' Un-jobban?","请确认","Yes","No"))
					if("Yes")
						P1.remove_job_ban(job)
					else
						continue
			href_list["jobban2"] = 1 // lets it fall through and refresh

			return 1
		return 0 //we didn't do anything!
	else if(href_list["adminplayerobservefollow"])
		if(!isobserver(usr) && !check_rights(R_ADMIN))
			return

		usr.client?.admin_follow(locate(href_list["adminplayerobservefollow"]))
	else if(href_list["boot2"])
		var/mob/M = locate(href_list["boot2"])
		if (ismob(M))
			if(!check_if_greater_rights_than(M.client))
				return
			var/reason = input("Please enter reason")
			if(!reason)
				to_chat_forced(M, SPAN_WARNING("You have been kicked from the server."))
			else
				to_chat_forced(M, SPAN_WARNING("You have been kicked from the server: [reason]"))
			message_admins("[key_name_admin(usr)] booted [key_name_admin(M)].")
			qdel(M.client)

	else if(href_list["removejobban"])
		if(!check_rights(R_BAN))
			return

		var/t = href_list["removejobban"]
		if(t)
			if((alert("Do you want to unjobban [t]?","解除职位封禁确认", "Yes", "No") == "Yes") && t) //No more misclicks! Unless you do it twice.
				message_admins("[key_name_admin(usr)] removed [t]")
				jobban_remove(t)
				jobban_savebanfile()
				href_list["ban"] = 1 // lets it fall through and refresh

	else if(href_list["newban"])
		if(!check_rights(R_MOD,0) && !check_rights(R_BAN))  return

		var/mob/M = locate(href_list["newban"])
		if(!ismob(M))
			return

		if(M.client && M.client.admin_holder && (M.client.admin_holder.rights & R_MOD))
			return //mods+ cannot be banned. Even if they could, the ban doesn't affect them anyway

		if(!M.ckey)
			to_chat(usr, SPAN_DANGER("<B>警告：未找到 [M.name] 的 Mob ckey。</b>"))
			return
		var/mob_key = M.ckey
		var/mins = tgui_input_number(usr,"时长（分钟）？\n 1440 = 1天 \n 4320 = 3天 \n 10080 = 7天 \n 43800 = 1个月","Ban time", 1440, 262800, 1)
		if(!mins)
			return
		if(mins >= 525600)
			mins = 525599
		var/reason = input(usr,"原因？ \n\n按‘确定’完成封禁。","reason","Griefer") as message|null
		if(!reason)
			return
		var/datum/entity/player/P = get_player_from_key(mob_key) // you may not be logged in, but I will find you and I will ban you
		if(P.is_time_banned && alert(usr, "封禁已存在。是否继续？", "确认", "Yes", "No") != "Yes")
			return
		P.add_timed_ban(reason, mins)

	else if(href_list["eorgban"])
		if(!check_rights(R_MOD,0) && !check_rights(R_BAN))  return

		var/mob/M = locate(href_list["eorgban"])
		if(!ismob(M))
			return

		if(M.client && M.client.admin_holder)
			return //admins cannot be banned. Even if they could, the ban doesn't affect them anyway

		if(!M.ckey)
			to_chat(usr, SPAN_DANGER("<B>警告：未找到 [M.name] 的 Mob ckey。</b>"))
			return

		var/mins = 0
		var/reason = ""
		switch(alert("Are you sure you want to EORG ban [M.ckey]?", , "Yes", "No"))
			if("Yes")
				mins = 180
				reason = "EORG - Generating combat logs with, or otherwise griefing, friendly/allied players."
			if("No")
				return
		var/datum/entity/player/P = get_player_from_key(M.ckey) // you may not be logged in, but I will find you and I will ban you
		if(P.is_time_banned && alert(usr, "封禁已存在。是否继续？", "确认", "Yes", "No") != "Yes")
			return
		P.add_timed_ban(reason, mins)

	else if(href_list["xenoresetname"])
		if(!check_rights(R_MOD,0) && !check_rights(R_BAN))
			return

		var/mob/living/carbon/xenomorph/X = locate(href_list["xenoresetname"])
		if(!isxeno(X))
			to_chat(usr, SPAN_WARNING("不是异形。"))
			return

		if(alert("你确定要重置[X.ckey]的异形名称吗？", , "Yes", "No") != "Yes")
			return

		if(!X.ckey)
			to_chat(usr, SPAN_DANGER("警告：未找到 [X.name] 的实体 CKEY。"))
			return

		message_admins("[usr.client.ckey] has reset [X.ckey] xeno name")

		to_chat(X, SPAN_DANGER("警告：你的异形名称已被 [usr.client.ckey] 重置。"))

		X.client.xeno_prefix = "XX"
		X.client.xeno_postfix = ""
		X.client.prefs.xeno_prefix = "XX"
		X.client.prefs.xeno_postfix = ""

		X.client.prefs.save_preferences()
		X.generate_name()

	else if(href_list["xenobanname"])
		if(!check_rights(R_MOD,0) && !check_rights(R_BAN))
			return

		var/mob/living/carbon/xenomorph/X = locate(href_list["xenobanname"])
		var/mob/M = locate(href_list["xenobanname"])

		if(ismob(M) && X.client && X.client.xeno_name_ban)
			if(alert("Are you sure you want to UNBAN [X.ckey] and let them use xeno name?", ,"Yes", "No") != "Yes")
				return
			X.client.xeno_name_ban = FALSE
			X.client.prefs.xeno_name_ban = FALSE

			X.client.prefs.save_preferences()
			message_admins("[usr.client.ckey] has unbanned [X.ckey] from using xeno names")

			notes_add(X.ckey, "Xeno Name Unbanned by [usr.client.ckey]", usr)
			to_chat(X, SPAN_DANGER("警告：你现在可以再次使用异形名称了。"))
			return


		if(!isxeno(X))
			to_chat(usr, SPAN_WARNING("不是异形。"))
			return

		if(alert("Are you sure you want to BAN [X.ckey] from ever using any xeno name?", , "Yes", "No") != "Yes")
			return

		if(!X.ckey)
			to_chat(usr, SPAN_DANGER("警告：未找到 [X.name] 的实体 CKEY。"))
			return

		message_admins("[usr.client.ckey] has banned [X.ckey] from using xeno names")

		notes_add(X.ckey, "Xeno Name Banned by [usr.client.ckey]|Reason: Xeno name was [X.name]", usr)

		to_chat(X, SPAN_DANGER("警告：你已被 [usr.client.ckey] 禁止使用异形名称。"))

		X.client.xeno_prefix = "XX"
		X.client.xeno_postfix = ""
		X.client.xeno_name_ban = TRUE
		X.client.prefs.xeno_prefix = "XX"
		X.client.prefs.xeno_postfix = ""
		X.client.prefs.xeno_name_ban = TRUE

		X.client.prefs.save_preferences()
		X.generate_name()

	else if(href_list["mute"])
		if(!check_rights(R_MOD,0) && !check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["mute"])
		if(!ismob(M))
			return
		if(!M.client)
			return

		var/mute_type = href_list["mute_type"]
		if(istext(mute_type))
			mute_type = text2num(mute_type)
		if(!isnum(mute_type))
			return

		cmd_admin_mute(M, mute_type)

	else if(href_list["chem_panel"])
		topic_chems(href_list["chem_panel"])

	else if(href_list["c_mode"])
		if(!check_rights(R_ADMIN))
			return

		var/dat = {"<B>What mode do you wish to play?</B><HR>"}
		for(var/mode in config.modes)
			dat += {"<A href='byond://?_src_=admin_holder;[HrefToken(forceGlobal = TRUE)];c_mode2=[mode]'>[config.mode_names[mode]]</A><br>"}
		dat += {"Now: [GLOB.master_mode]"}
		show_browser(usr, dat, "Change Gamemode", "c_mode")

	else if(href_list["c_mode2"])
		if(!check_rights(R_ADMIN|R_SERVER))
			return

		GLOB.master_mode = href_list["c_mode2"]
		message_admins("[key_name_admin(usr)] set the mode as [GLOB.master_mode].")
		to_world(SPAN_NOTICE("<b><i>The mode is now: [GLOB.master_mode]!</i></b>"))
		Game() // updates the main game menu
		SSticker.save_mode(GLOB.master_mode)

	else if(href_list["monkeyone"])
		if(!check_rights(R_SPAWN))
			return

		var/mob/living/carbon/human/H = locate(href_list["monkeyone"])
		if(!istype(H))
			to_chat(usr, "这只能用于 /mob/living/carbon/human 类型的实例。")
			return

		message_admins("[key_name_admin(usr)] attempting to monkeyize [key_name_admin(H)]")
		H.monkeyize()

	else if(href_list["forcespeech"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["forcespeech"])
		if(!ismob(M))
			to_chat(usr, "这只能用于类型为 /mob 的实例。")
			return

		var/speech = input("What will [key_name(M)] say?.", "强制发言", "")// Don't need to sanitize, since it does that in say(), we also trust our admins.
		if(!speech)
			return
		M.say(speech)
		speech = sanitize(speech) // Nah, we don't trust them
		message_admins("[key_name_admin(usr)] forced [key_name_admin(M)] to say: [speech]")

	else if(href_list["zombieinfect"])
		if(!check_rights(R_ADMIN))
			return
		var/mob/living/carbon/human/H = locate(href_list["zombieinfect"])
		if(!istype(H))
			to_chat(usr, "这只能用于 /human 类型的实例。")
			return

		if(alert(usr, "你确定要让他们感染僵尸病毒吗？这可能触发重大事件！", "消息", "Yes", "No") != "Yes")
			return

		var/datum/disease/black_goo/bg = new()
		if(alert(usr, "使其成为无症状携带者？", "消息", "Yes", "No") == "Yes")
			bg.carrier = TRUE
		else
			bg.carrier = FALSE

		H.AddDisease(bg, FALSE)

		message_admins("[key_name_admin(usr)] infected [key_name_admin(H)] with a ZOMBIE VIRUS")
	else if(href_list["larvainfect"])
		if(!check_rights(R_ADMIN))
			return
		var/mob/living/carbon/human/H = locate(href_list["larvainfect"])
		if(!istype(H))
			to_chat(usr, "这只能用于 /human 类型的实例。")
			return

		if(alert(usr, "你确定要让他们感染异形幼虫吗？", "消息", "Yes", "No") != "Yes")
			return

		var/list/hives = list()
		var/datum/hive_status/hive
		for(var/hivenumber in GLOB.hive_datum)
			hive = GLOB.hive_datum[hivenumber]
			hives += list("[hive.name]" = hive.hivenumber)

		var/newhive = tgui_input_list(usr,"选择一个巢穴。", "Infect Larva", hives)

		if(!H)
			to_chat(usr, "该单位已不存在。")
			return

		var/obj/item/alien_embryo/embryo = new /obj/item/alien_embryo(H)
		embryo.hivenumber = hives[newhive]
		embryo.faction = newhive

		message_admins("[key_name_admin(usr)] infected [key_name_admin(H)] with a xeno ([newhive]) larva.")

	else if(href_list["makemutineer"])
		if(!check_rights(R_DEBUG|R_SPAWN))
			return

		var/mob/living/carbon/human/H = locate(href_list["makemutineer"])
		if(!istype(H))
			to_chat(usr, "此操作仅能对 /mob/living/carbon/human 类型的实例执行。")
			return

		if(H.faction != FACTION_MARINE)
			to_chat(usr, "该玩家的派系必须等于 '[FACTION_MARINE]' 才能使其成为叛变者。")
			return

		var/datum/equipment_preset/other/mutiny/mutineer/leader/leader_preset = new()
		leader_preset.load_status(H)

		message_admins("[key_name_admin(usr)] has made [key_name_admin(H)] into a mutineer leader.")

	else if(href_list["makecultist"] || href_list["makecultistleader"])
		if(!check_rights(R_DEBUG|R_SPAWN))
			return

		var/mob/living/carbon/human/H = locate(href_list["makecultist"]) || locate(href_list["makecultistleader"])
		if(!istype(H))
			to_chat(usr, "此操作仅能对 /mob/living/carbon/human 类型的实例执行。")
			return

		var/list/hives = list()
		for(var/hivenumber in GLOB.hive_datum)
			var/datum/hive_status/hive = GLOB.hive_datum[hivenumber]
			LAZYSET(hives, hive.name, hive)
		LAZYSET(hives, "CANCEL", null)

		var/hive_name = tgui_input_list(usr, "他将属于哪个巢穴", "设为邪教徒", hives)
		if(!hive_name || hive_name == "CANCEL")
			to_chat(usr, SPAN_ALERT("巢穴选择错误。中止。"))

		var/datum/hive_status/hive = hives[hive_name]

		if(href_list["makecultist"])
			var/datum/equipment_preset/preset = GLOB.equipment_presets.gear_path_presets_list[/datum/equipment_preset/other/xeno_cultist]
			preset.load_race(H)
			preset.load_status(H, hive.hivenumber)
			message_admins("[key_name_admin(usr)] has made [key_name_admin(H)] into a cultist for [hive.name].")

		else if(href_list["makecultistleader"])
			var/datum/equipment_preset/preset = GLOB.equipment_presets.gear_path_presets_list[/datum/equipment_preset/other/xeno_cultist/leader]
			preset.load_race(H)
			preset.load_status(H, hive.hivenumber)
			message_admins("[key_name_admin(usr)] has made [key_name_admin(H)] into a cultist leader for [hive.name].")

		H.faction = hive.internal_faction

	else if(href_list["forceemote"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["forceemote"])
		if(!ismob(M))
			to_chat(usr, "这只能用于类型为 /mob 的实例。")

		var/speech = input("What will [key_name(M)] emote?.", "强制表情动作", "")// Don't need to sanitize, since it does that in say(), we also trust our admins.
		if(!speech)
			return
		M.manual_emote(speech)
		speech = sanitize(speech) // Nah, we don't trust them
		message_admins("[key_name_admin(usr)] forced [key_name_admin(M)] to emote: [speech]")

	else if(href_list["sendbacktolobby"])
		if(!check_rights(R_MOD))
			return

		var/mob/M = locate(href_list["sendbacktolobby"])

		if(!isobserver(M))
			to_chat(usr, SPAN_NOTICE("你只能将幽灵玩家送回大厅。"))
			return

		if(!M.client)
			to_chat(usr, SPAN_WARNING("[M] 似乎没有活动的客户端。"))
			return

		if(alert(usr, "将 [key_name(M)] 送回大厅？", "消息", "Yes", "No") != "Yes")
			return

		message_admins("[key_name(usr)] has sent [key_name(M)] back to the Lobby.")

		var/mob/new_player/NP = new()
		NP.ckey = M.ckey
		qdel(M)

	else if(href_list["tdome1"])
		if(!check_rights(R_ADMIN))
			return

		if(alert(usr, "确认？", "消息", "Yes", "No") != "Yes")
			return

		var/mob/M = locate(href_list["tdome1"])
		if(!ismob(M))
			to_chat(usr, "这只能用于类型为 /mob 的实例。")
			return

		for(var/obj/item/I in M)
			M.drop_inv_item_on_ground(I)

		M.apply_effect(5, PARALYZE)
		sleep(5)
		M.forceMove(get_turf(pick(GLOB.thunderdome_one)))
		spawn(50)
			to_chat(M, SPAN_NOTICE("你已被送往雷霆穹顶。"))
		message_admins("[key_name_admin(usr)] has sent [key_name_admin(M)] to the thunderdome. (Team 1)", 1)

	else if(href_list["tdome2"])
		if(!check_rights(R_ADMIN))
			return

		if(alert(usr, "确认？", "消息", "Yes", "No") != "Yes")
			return

		var/mob/M = locate(href_list["tdome2"])
		if(!ismob(M))
			to_chat(usr, "这只能用于类型为 /mob 的实例。")
			return

		for(var/obj/item/I in M)
			M.drop_inv_item_on_ground(I)

		M.apply_effect(5, PARALYZE)
		sleep(5)
		M.forceMove(get_turf(pick(GLOB.thunderdome_two)))
		spawn(50)
			to_chat(M, SPAN_NOTICE("你已被送往雷霆穹顶。"))
		message_admins("[key_name_admin(usr)] has sent [key_name_admin(M)] to the thunderdome. (Team 2)", 1)

	else if(href_list["tdomeadmin"])
		if(!check_rights(R_ADMIN))
			return

		if(alert(usr, "确认？", "消息", "Yes", "No") != "Yes")
			return

		var/mob/M = locate(href_list["tdomeadmin"])
		if(!ismob(M))
			to_chat(usr, "这只能用于类型为 /mob 的实例。")
			return

		M.apply_effect(5, PARALYZE)
		sleep(5)
		M.forceMove(get_turf(pick(GLOB.thunderdome_admin)))
		spawn(50)
			to_chat(M, SPAN_NOTICE("你已被送往雷霆穹顶。"))
		message_admins("[key_name_admin(usr)] has sent [key_name_admin(M)] to the thunderdome. (Admin.)", 1)

	else if(href_list["tdomeobserve"])
		if(!check_rights(R_ADMIN))
			return

		if(alert(usr, "确认？", "消息", "Yes", "No") != "Yes")
			return

		var/mob/M = locate(href_list["tdomeobserve"])
		if(!ismob(M))
			to_chat(usr, "这只能用于类型为 /mob 的实例。")
			return

		for(var/obj/item/I in M)
			M.drop_inv_item_on_ground(I)

		if(istype(M, /mob/living/carbon/human))
			var/mob/living/carbon/human/observer = M
			observer.equip_to_slot_or_del(new /obj/item/clothing/under/suit_jacket(observer), WEAR_BODY)
			observer.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(observer), WEAR_FEET)
		M.apply_effect(5, PARALYZE)
		sleep(5)
		M.forceMove(get_turf(pick(GLOB.thunderdome_observer)))
		spawn(50)
			to_chat(M, SPAN_NOTICE("你已被送往雷霆穹顶。"))
		message_admins("[key_name_admin(usr)] has sent [key_name_admin(M)] to the thunderdome. (Observer.)", 1)

	else if(href_list["revive"])
		if(!check_rights(R_MOD))
			return

		var/mob/living/L = locate(href_list["revive"])
		if(!istype(L))
			to_chat(usr, "此功能仅能用于 /mob/living 类型的实例。")
			return

		L.revive()
		message_admins(WRAP_STAFF_LOG(usr, "ahealed [key_name(L)] in [get_area(L)] ([L.x],[L.y],[L.z])."), L.x, L.y, L.z)

	else if(href_list["makealien"])
		if(!check_rights(R_SPAWN))
			return

		var/mob/living/carbon/human/H = locate(href_list["makealien"])
		if(!istype(H))
			to_chat(usr, "这只能用于 /mob/living/carbon/human 类型的实例。")
			return

		usr.client.cmd_admin_alienize(H)

	else if(href_list["changehivenumber"])
		if(!check_rights(R_DEBUG|R_ADMIN))
			return

		var/mob/living/carbon/H = locate(href_list["changehivenumber"])
		if(!istype(H))
			to_chat(usr, "此操作仅能对 /mob/living/carbon/ 类型的实例执行。")
			return
		if(usr.client)
			usr.client.cmd_admin_change_their_hivenumber(H)

	else if(href_list["makeyautja"])
		if(!check_rights(R_SPAWN))
			return

		if(alert("Are you sure you want to make this person into a yautja? It will delete their old character.","设为铁血战士","Yes","No") != "Yes")
			return

		var/mob/H = locate(href_list["makeyautja"])

		if(!istype(H))
			to_chat(usr, "此功能仅能用于单位。你是怎么做到的？")
			return

		if(!usr.loc || !isturf(usr.loc))
			to_chat(usr, "请仅对地块使用。")
			return

		var/y_name = input(usr, "你想给这个新铁血战士起什么名字？","姓名", "")
		if(!y_name)
			to_chat(usr, "这不是一个有效的名字。")
			return

		var/y_gend = input(usr, "性别？","Gender", "male")
		if(!y_gend || (y_gend != "male" && y_gend != "female"))
			to_chat(usr, "这不是一个有效的性别。")
			return

		var/mob/living/carbon/human/M = new(usr.loc)
		M.set_species("铁血战士")
		spawn(0)
			M.gender = y_gend
			M.regenerate_icons()
			message_admins("[key_name(usr)] made [H] into a Yautja, [M.real_name].")
			if(H.mind)
				H.mind.transfer_to(M)
			else
				M.key = H.key
				if(M.client)
					M.client.change_view(GLOB.world_view_size)

			if(M.skills)
				qdel(M.skills)
			M.skills = null //no skill restriction

			M.change_real_name(M, y_name)
			M.name = "未知" // Yautja names are not visible for oomans

			if(H)
				qdel(H) //May have to clear up round-end vars and such....

		return

	else if(href_list["makeanimal"])
		if(!check_rights(R_SPAWN))
			return

		var/mob/M = locate(href_list["makeanimal"])
		if(istype(M, /mob/new_player))
			to_chat(usr, "此功能不能用于 /mob/new_player 类型的实例。")
			return

		usr.client.cmd_admin_animalize(M)



// Now isn't that much better? IT IS NOW A PROC, i.e. kinda like a big panel like unstable
	else if(href_list["playerpanelextended"])
		player_panel_extended()

	else if(href_list["adminplayerobservejump"])
		if(!check_rights(R_MOD|R_ADMIN))
			return

		var/mob/M = locate(href_list["adminplayerobservejump"])

		var/client/C = usr.client
		if(!isobserver(usr))
			C.admin_ghost()
		sleep(2)
		C.jumptomob(M)

	else if(href_list["adminplayerfollow"])
		if(!check_rights(R_MOD|R_ADMIN))
			return

		var/mob/M = locate(href_list["adminplayerfollow"])

		var/client/C = usr.client
		if(!isobserver(usr))
			C.admin_ghost()
		sleep(2)
		if(isobserver(usr))
			var/mob/dead/observer/G = usr
			G.do_observe(M)

	else if(href_list["check_antagonist"])
		check_antagonists()

	else if(href_list["adminplayerobservecoodjump"])
		if(!check_rights(R_MOD))
			return

		var/x = text2num(href_list["X"])
		var/y = text2num(href_list["Y"])
		var/z = text2num(href_list["Z"])

		var/client/C = usr.client
		if(!isobserver(usr))
			C.admin_ghost()
		sleep(2)
		C.jumptocoord(x,y,z)

	else if(href_list["admincancelob"])
		if(!check_rights(R_MOD))
			return
		var/cancel_token = href_list["cancellation"]
		if(!cancel_token)
			return
		if(alert("Are you sure you want to cancel this OB?",,"Yes","No") != "Yes")
			return
		GLOB.orbital_cannon_cancellation["[cancel_token]"] = null
		message_admins("[src.owner] has cancelled the orbital strike.")

	else if(href_list["admincancelpredsd"])
		if (!check_rights(R_MOD)) return
		var/obj/item/clothing/gloves/yautja/hunter/bracer = locate(href_list["bracer"])
		var/mob/living/carbon/victim = locate(href_list["victim"])
		if (!istype(bracer))
			return
		if (alert("Are you sure you want to cancel this pred SD?",,"Yes","No") != "Yes")
			return
		bracer.exploding = FALSE
		message_admins("[src.owner] has cancelled the predator self-destruct sequence [victim ? "of [victim] ([victim.key])":""].")

	else if(href_list["adminspawncookie"])
		if(!check_rights(R_MOD))
			return

		var/mob/living/carbon/human/H = locate(href_list["adminspawncookie"])
		if(!ishuman(H))
			to_chat(usr, "这只能用于 /mob/living/carbon/human 类型的实例。")
			return

		var/cookie_type = tgui_input_list(usr, "选择饼干类型：", "Give Cookie", list("cookie", "random fortune cookie", "custom fortune cookie"))
		if(!cookie_type)
			return

		var/obj/item/reagent_container/food/snacks/snack
		switch(cookie_type)
			if("cookie")
				snack = new /obj/item/reagent_container/food/snacks/cookie(H.loc)
			if("random fortune cookie")
				snack = new /obj/item/reagent_container/food/snacks/fortunecookie/prefilled(H.loc)
			if("custom fortune cookie")
				var/fortune_text = tgui_input_list(usr, "选择运势：", "Cookie customisation", list("Random", "Custom", "无"))
				if(!fortune_text)
					return
				if(fortune_text == "Custom")
					fortune_text = input(usr, "输入运势文本：", "Cookie customisation", "")
					if(!fortune_text)
						return
				var/fortune_numbers = tgui_input_list(usr, "选择幸运数字：", "Cookie customisation", list("Random", "Custom", "无"))
				if(!fortune_numbers)
					return
				if(fortune_numbers == "Custom")
					fortune_numbers = input(usr, "输入幸运数字：", "Cookie customisation", "1, 2, 3, 4 and 5")
					if(!fortune_numbers)
						return
				if(fortune_text == "无" && fortune_numbers == "无")
					to_chat(usr, "未提供运势，饼干代码已失效！")
					return
				snack = new /obj/item/reagent_container/food/snacks/fortunecookie/prefilled(H.loc, fortune_text, fortune_numbers)

		if(!snack)
			error("Give Cookie code crumbled!")
		H.put_in_hands(snack)
		message_admins("[key_name(H)] got their [cookie_type], spawned by [key_name(src.owner)]")
		to_chat(H, SPAN_NOTICE("你的祈祷得到了回应！！你获得了<b>最佳饼干</b>！"))

	else if(href_list["adminalert"])
		if(!check_rights(R_MOD))
			return

		var/mob/M = locate(href_list["adminalert"])
		usr.client.cmd_admin_alert_message(M)

	else if(href_list["CentcommReply"])
		var/mob/living/carbon/human/H = locate(href_list["CentcommReply"])

		if(!istype(H))
			to_chat(usr, "这只能用于 /mob/living/carbon/human 类型的实例。")
			return

		//unanswered_distress -= H

		if(!H.get_type_in_ears(/obj/item/device/radio/headset))
			to_chat(usr, "你试图联系的对象未佩戴耳机。")
			return

		var/input = input(src.owner, "请输入消息，通过耳机回复[key_name(H)]。","Outgoing message from USCM", "")
		if(!input)
			return

		to_chat(src.owner, "你通过安全频道向[H]发送了[input]。")
		log_admin("[src.owner] replied to [key_name(H)]'s USCM message with the message [input].")
		for(var/client/X in GLOB.admins)
			if((R_ADMIN|R_MOD) & X.admin_holder.rights)
				to_chat(X, SPAN_STAFF_IC("<b>管理员/版主：\red [src.owner] 回复了[key_name(H)]的USCM消息：\blue \")[input]\"</b>"))
		to_chat(H, SPAN_DANGER("你听到耳机里传来一阵噼啪声，随后一个声音响起，请等待消息：\" \blue <b>\"[input]\"</b>"))

	else if(href_list["SyndicateReply"])
		var/mob/living/carbon/human/H = locate(href_list["SyndicateReply"])
		if(!istype(H))
			to_chat(usr, "这只能用于 /mob/living/carbon/human 类型的实例。")
			return
		if(!H.get_type_in_ears(/obj/item/device/radio/headset))
			to_chat(usr, "你试图联系的对象未佩戴耳机。")
			return

		var/input = input(src.owner, "请输入消息，通过耳机回复[key_name(H)]。","Outgoing message from The Syndicate", "")
		if(!input)
			return

		to_chat(src.owner, "你通过安全频道向[H]发送了[input]。")
		log_admin("[src.owner] replied to [key_name(H)]'s Syndicate message with the message [input].")
		to_chat(H, "你听到耳机里短暂地传来一阵噼啪声，随后一个声音响起。\"Please stand by for a message from your benefactor. Message as follows, agent. <b>\"[input]\"</b>  Message ends.\"")

	else if(href_list["UpdateFax"])
		var/obj/structure/machinery/faxmachine/origin_fax = locate(href_list["originfax"])
		origin_fax.update_departments()

	else if(href_list["PressFaxReply"])
		var/mob/user = usr
		if(!user.client || !CLIENT_IS_STAFF(user.client))
			to_chat(user, SPAN_WARNING("你无法发送传真回复！"))
			return FALSE

		var/mob/living/carbon/human/target_human = locate(href_list["PressFaxReply"])
		var/obj/structure/machinery/faxmachine/origin_fax = locate(href_list["originfax"])

		var/template_choice = tgui_input_list(usr, "使用模板还是自定义？", "Fax Templates", list("模板", "Custom"))
		if(!template_choice)
			return
		var/datum/fax/fax_message
		var/organization_type = ""
		switch(template_choice)
			if("Custom")
				var/input = input(src.owner, "请输入消息，通过安全连接回复[key_name(target_human)]。注意：BBCode无效，但HTML标签有效！使用<br>换行。", "Outgoing message from Press", "") as message|null
				if(!input)
					return
				fax_message = new(input)
			if("模板")
				var/subject = input(src.owner, "输入主题行", "Outgoing message from Press", "") as message|null
				if(!subject)
					return
				var/addressed_to = ""
				var/address_option = tgui_input_list(user, "地址写给发件人还是自定义？", "Fax Template", list("Sender", "Custom"))
				if(address_option == "Sender")
					addressed_to = "[target_human.real_name]"
				else if(address_option == "Custom")
					addressed_to = input(src.owner, "输入收件人行", "Outgoing message from Press", "") as message|null
					if(!addressed_to)
						return
				else
					return
				var/message_body = input(src.owner, "输入消息正文，使用<p></p>表示段落", "Outgoing message from Press", "") as message|null
				if(!message_body)
					return
				var/sent_by = input(src.owner, "输入你的姓名和军衔。", "Outgoing message from Press", "") as message|null
				if(!sent_by)
					return
				organization_type = input(src.owner, "输入你所属的组织。", "Outgoing message from Press", "") as message|null
				if(!organization_type)
					return

				fax_message = new(generate_templated_fax(0, organization_type, subject, addressed_to, message_body, sent_by, "Editor in Chief", organization_type))
		show_browser(user, "<body class='paper'>[fax_message.data]</body>", "pressfaxpreview", width = DEFAULT_PAPER_WIDTH, height = DEFAULT_PAPER_HEIGHT)
		var/send_choice = tgui_input_list(user, "发送此传真？", "Fax Template", list("Send", "Cancel"))
		if(send_choice != "Send")
			return
		var/is_priority_fax = tgui_alert(user, "这是加急传真吗？", "Priority Fax?", list("Yes", "No"))

		send_admin_fax("Press", fax_message, origin_fax, is_priority_fax, target_human, organization_type)

	else if(href_list["USCMFaxReply"])
		var/mob/user = usr
		if(!user.client || !CLIENT_IS_STAFF(user.client))
			to_chat(user, SPAN_WARNING("你无法发送传真回复！"))
			return FALSE

		var/mob/living/carbon/human/target_human = locate(href_list["USCMFaxReply"])
		var/obj/structure/machinery/faxmachine/origin_fax = locate(href_list["originfax"])

		var/template_choice = tgui_input_list(usr, "使用模板还是自定义？", "Fax Templates", list("USCM High Command", "USCM Provost General", "Custom"))
		if(!template_choice)
			return
		var/datum/fax/fax_message
		switch(template_choice)
			if("Custom")
				var/input = input(src.owner, "请输入消息，通过安全连接回复[key_name(target_human)]。注意：BBCode无效，但HTML标签有效！使用<br>换行。", "Outgoing message from USCM", "") as message|null
				if(!input)
					return
				fax_message = new(input)
			if("USCM High Command", "USCM Provost General")
				var/subject = input(src.owner, "输入主题行", "Outgoing message from USCM", "") as message|null
				if(!subject)
					return
				var/addressed_to = ""
				var/address_option = tgui_input_list(user, "地址写给发件人还是自定义？", "Fax Template", list("Sender", "Custom"))
				if(address_option == "Sender")
					addressed_to = "[target_human.real_name]"
				else if(address_option == "Custom")
					addressed_to = input(src.owner, "输入收件人行", "Outgoing message from USCM", "") as message|null
					if(!addressed_to)
						return
				else
					return
				var/message_body = input(src.owner, "输入消息正文，使用<p></p>表示段落", "Outgoing message from USCM", "") as message|null
				if(!message_body)
					return
				var/sent_by = input(src.owner, "输入你的姓名和军衔。", "Outgoing message from USCM", "") as message|null
				if(!sent_by)
					return
				var/sent_title = "Office of the Provost General"
				if(template_choice == "USCM High Command")
					sent_title = "USCM High Command"

				fax_message = new(generate_templated_fax(0, "USCM CENTRAL COMMAND", subject,addressed_to, message_body,sent_by, sent_title, "United States Colonial Marine Corps"))
		show_browser(user, "<body class='paper'>[fax_message.data]</body>", "uscmfaxpreview", width = DEFAULT_PAPER_WIDTH, height = DEFAULT_PAPER_HEIGHT)
		var/send_choice = tgui_input_list(user, "发送此传真？", "Fax Template", list("Send", "Cancel"))
		if(send_choice != "Send")
			return
		var/is_priority_fax = tgui_alert(user, "这是加急传真吗？", "Priority Fax?", list("Yes", "No"))

		send_admin_fax(FACTION_MARINE, fax_message, origin_fax, is_priority_fax, target_human)

	else if(href_list["WYFaxReply"])
		var/mob/user = usr
		if(!user.client || !CLIENT_IS_STAFF(user.client))
			to_chat(user, SPAN_WARNING("你无法发送传真回复！"))
			return FALSE

		var/mob/living/carbon/human/target_human = locate(href_list["WYFaxReply"])
		var/obj/structure/machinery/faxmachine/origin_fax = locate(href_list["originfax"])

		var/template_choice = tgui_input_list(usr, "使用模板还是自定义？", "Fax Template", list("模板", "Custom"))
		if(!template_choice)
			return
		var/datum/fax/fax_message
		switch(template_choice)
			if("Custom")
				var/input = input(src.owner, "请输入消息，通过安全连接回复[key_name(target_human)]。注意：BBCode无效，但HTML标签有效！使用<br>换行。", "Outgoing message from Weyland-Yutani", "") as message|null
				if(!input)
					return
				fax_message = new(input)
			if("模板")
				var/subject = input(src.owner, "输入主题行", "Outgoing message from Weyland-Yutani", "") as message|null
				if(!subject)
					return
				var/addressed_to = ""
				var/address_option = tgui_input_list(user, "地址写给发件人还是自定义？", "Fax Template", list("Sender", "Custom"))
				if(address_option == "Sender")
					addressed_to = "[target_human.real_name]"
				else if(address_option == "Custom")
					addressed_to = input(src.owner, "输入收件人行", "Outgoing message from Weyland-Yutani", "") as message|null
					if(!addressed_to)
						return
				else
					return
				var/message_body = input(src.owner, "输入消息正文，使用<p></p>表示段落", "Outgoing message from Weyland-Yutani", "") as message|null
				if(!message_body)
					return
				var/sent_by = input(src.owner, "仅输入你的姓名", "Outgoing message from Weyland-Yutani", "") as message|null
				if(!sent_by)
					return
				fax_message = new(generate_templated_fax(1, "WEYLAND-YUTANI CORPORATE AFFAIRS - [MAIN_SHIP_NAME]", subject, addressed_to, message_body, sent_by, "Corporate Affairs Director", "Weyland-Yutani"))
		show_browser(user, "<body class='paper'>[fax_message.data]</body>", "clfaxpreview", width = DEFAULT_PAPER_WIDTH, height = DEFAULT_PAPER_HEIGHT)
		var/send_choice = tgui_input_list(user, "发送此传真？", "Fax Confirmation", list("Send", "Cancel"))
		if(send_choice != "Send")
			return
		var/is_priority_fax = tgui_alert(user, "这是加急传真吗？", "Priority Fax?", list("Yes", "No"))

		send_admin_fax(FACTION_WY, fax_message, origin_fax, is_priority_fax, target_human)

	else if(href_list["TWEFaxReply"])
		var/mob/user = usr
		if(!user.client || !CLIENT_IS_STAFF(user.client))
			to_chat(user, SPAN_WARNING("你无法发送传真回复！"))
			return FALSE

		var/mob/living/carbon/human/target_human = locate(href_list["TWEFaxReply"])
		var/obj/structure/machinery/faxmachine/origin_fax = locate(href_list["originfax"])

		var/template_choice = tgui_input_list(usr, "使用模板还是自定义？", "Fax Template", list("模板", "Custom"))
		if(!template_choice)
			return
		var/datum/fax/fax_message
		switch(template_choice)
			if("Custom")
				var/input = input(src.owner, "请输入消息，通过安全连接回复[key_name(target_human)]。注意：BBCode无效，但HTML标签有效！使用<br>换行。", "Outgoing message from TWE", "") as message|null
				if(!input)
					return
				fax_message = new(input)
			if("模板")
				var/subject = input(src.owner, "输入主题行", "Outgoing message from TWE", "") as message|null
				if(!subject)
					return
				var/addressed_to = ""
				var/address_option = tgui_input_list(user, "地址写给发件人还是自定义？", "Fax Template", list("Sender", "Custom"))
				if(address_option == "Sender")
					addressed_to = "[target_human.real_name]"
				else if(address_option == "Custom")
					addressed_to = input(src.owner, "输入收件人行", "Outgoing message from TWE", "") as message|null
					if(!addressed_to)
						return
				else
					return
				var/message_body = input(src.owner, "输入消息正文，使用<p></p>表示段落", "Outgoing message from TWE", "") as message|null
				if(!message_body)
					return
				var/sent_by = input(src.owner, "仅输入你的姓名", "Outgoing message from TWE", "") as message|null
				if(!sent_by)
					return
				fax_message = new(generate_templated_fax(0, "THREE WORLD EMPIRE - ROYAL MILITARY COMMAND", subject, addressed_to, message_body, sent_by, "Office of Military Communications", "三世界帝国"))
		show_browser(user, "<body class='paper'>[fax_message.data]</body>", "PREVIEW OF TWE FAX", width = DEFAULT_PAPER_WIDTH, height = DEFAULT_PAPER_HEIGHT)
		var/send_choice = tgui_input_list(user, "发送此传真？", "Fax Confirmation", list("Send", "Cancel"))
		if(send_choice != "Send")
			return
		var/is_priority_fax = tgui_alert(user, "这是加急传真吗？", "Priority Fax?", list("Yes", "No"))

		send_admin_fax(FACTION_TWE, fax_message, origin_fax, is_priority_fax, target_human)

	else if(href_list["UPPFaxReply"])
		var/mob/user = usr
		if(!user.client || !CLIENT_IS_STAFF(user.client))
			to_chat(user, SPAN_WARNING("你无法发送传真回复！"))
			return FALSE

		var/mob/living/carbon/human/target_human = locate(href_list["UPPFaxReply"])
		var/obj/structure/machinery/faxmachine/origin_fax = locate(href_list["originfax"])

		var/template_choice = tgui_input_list(usr, "使用模板还是自定义？", "Fax Template", list("模板", "Custom"))
		if(!template_choice)
			return
		var/datum/fax/fax_message
		switch(template_choice)
			if("Custom")
				var/input = input(src.owner, "请输入消息，通过安全连接回复[key_name(target_human)]。注意：BBCode无效，但HTML标签有效！使用<br>换行。", "Outgoing message from UPP", "") as message|null
				if(!input)
					return
				fax_message = new(input)
			if("模板")
				var/subject = input(src.owner, "输入主题行", "Outgoing message from UPP", "") as message|null
				if(!subject)
					return
				var/addressed_to = ""
				var/address_option = tgui_input_list(user, "地址写给发件人还是自定义？", "Fax Template", list("Sender", "Custom"))
				if(address_option == "Sender")
					addressed_to = "[target_human.real_name]"
				else if(address_option == "Custom")
					addressed_to = input(src.owner, "输入收件人行", "Outgoing message from UPP", "") as message|null
					if(!addressed_to)
						return
				else
					return
				var/message_body = input(src.owner, "输入消息正文，使用<p></p>表示段落", "Outgoing message from UPP", "") as message|null
				if(!message_body)
					return
				var/sent_by = input(src.owner, "仅输入你的姓名", "Outgoing message from UPP", "") as message|null
				if(!sent_by)
					return
				fax_message = new(generate_templated_fax(0, "UNION OF PROGRESSIVE PEOPLES - MILITARY HIGH KOMMAND", subject, addressed_to, message_body, sent_by, "Military High Kommand", "进步人民联盟"))
		show_browser(user, "<body class='paper'>[fax_message.data]</body>", "PREVIEW OF UPP FAX", width = DEFAULT_PAPER_WIDTH, height = DEFAULT_PAPER_HEIGHT)
		var/send_choice = tgui_input_list(user, "发送此传真？", "Fax Confirmation", list("Send", "Cancel"))
		if(send_choice != "Send")
			return
		var/is_priority_fax = tgui_alert(user, "这是加急传真吗？", "Priority Fax?", list("Yes", "No"))

		send_admin_fax(FACTION_UPP, fax_message, origin_fax, is_priority_fax, target_human)

	else if(href_list["CLFFaxReply"])
		var/mob/user = usr
		if(!user.client || !CLIENT_IS_STAFF(user.client))
			to_chat(user, SPAN_WARNING("你无法发送传真回复！"))
			return FALSE

		var/mob/living/carbon/human/target_human = locate(href_list["CLFFaxReply"])
		var/obj/structure/machinery/faxmachine/origin_fax = locate(href_list["originfax"])

		var/template_choice = tgui_input_list(usr, "使用模板还是自定义？", "Fax Template", list("模板", "Custom"))
		if(!template_choice)
			return
		var/datum/fax/fax_message
		switch(template_choice)
			if("Custom")
				var/input = input(src.owner, "请输入消息，通过安全连接回复[key_name(target_human)]。注意：BBCode无效，但HTML标签有效！使用<br>换行。", "Outgoing message from CLF", "") as message|null
				if(!input)
					return
				fax_message = new(input)
			if("模板")
				var/subject = input(src.owner, "输入主题行", "Outgoing message from CLF", "") as message|null
				if(!subject)
					return
				var/addressed_to = ""
				var/address_option = tgui_input_list(user, "地址写给发件人还是自定义？", "Fax Template", list("Sender", "Custom"))
				if(address_option == "Sender")
					addressed_to = "[target_human.real_name]"
				else if(address_option == "Custom")
					addressed_to = input(src.owner, "输入收件人行", "Outgoing message from CLF", "") as message|null
					if(!addressed_to)
						return
				else
					return
				var/message_body = input(src.owner, "输入消息正文，使用<p></p>表示段落", "Outgoing message from CLF", "") as message|null
				if(!message_body)
					return
				var/sent_by = input(src.owner, "仅输入你的姓名", "Outgoing message from CLF", "") as message|null
				if(!sent_by)
					return
				fax_message = new(generate_templated_fax(0, "COLONIAL LIBERATION FRONT - COLONIAL COUNCIL OF LIBERATION", subject, addressed_to, message_body, sent_by, "Guerilla Forces Command", "殖民地解放阵线"))
		show_browser(user, "<body class='paper'>[fax_message.data]</body>", "PREVIEW OF CLF FAX", width = DEFAULT_PAPER_WIDTH, height = DEFAULT_PAPER_HEIGHT)
		var/send_choice = tgui_input_list(user, "发送此传真？", "Fax Confirmation", list("Send", "Cancel"))
		if(send_choice != "Send")
			return
		var/is_priority_fax = tgui_alert(user, "这是加急传真吗？", "Priority Fax?", list("Yes", "No"))

		send_admin_fax(FACTION_CLF, fax_message, origin_fax, is_priority_fax, target_human)

	else if(href_list["CMBFaxReply"])
		var/mob/user = usr
		if(!user.client || !CLIENT_IS_STAFF(user.client))
			to_chat(user, SPAN_WARNING("你无法发送传真回复！"))
			return FALSE

		var/mob/living/carbon/human/target_human = locate(href_list["CMBFaxReply"])
		var/obj/structure/machinery/faxmachine/origin_fax = locate(href_list["originfax"])

		var/template_choice = tgui_input_list(usr, "使用模板还是自定义？", "Fax Template", list("Anchorpoint", "Custom"))
		if(!template_choice)
			return
		var/datum/fax/fax_message
		switch(template_choice)
			if("Custom")
				var/input = input(src.owner, "请输入消息，通过安全连接回复[key_name(target_human)]。注意：BBCode无效，但HTML标签有效！使用<br>换行。", "Outgoing message from The Colonial Marshal Bureau", "") as message|null
				if(!input)
					return
				fax_message = new(input)
			if("Anchorpoint")
				var/subject = input(src.owner, "输入主题行", "Outgoing message from The Colonial Marshal Bureau, Anchorpoint Station", "") as message|null
				if(!subject)
					return
				var/addressed_to = ""
				var/address_option = tgui_input_list(user, "地址写给发件人还是自定义？", "Fax Template", list("Sender", "Custom"))
				if(address_option == "Sender")
					addressed_to = "[target_human.real_name]"
				else if(address_option == "Custom")
					addressed_to = input(src.owner, "输入收件人行", "Outgoing message from The Colonial Marshal Bureau", "") as message|null
					if(!addressed_to)
						return
				else
					return
				var/message_body = input(src.owner, "输入消息正文，使用<p></p>表示段落", "Outgoing message from The Colonial Marshal Bureau", "") as message|null
				if(!message_body)
					return
				var/sent_by = input(src.owner, "仅输入你的姓名", "Outgoing message from The Colonial Marshal Bureau", "") as message|null
				if(!sent_by)
					return
				fax_message = new(generate_templated_fax(0, "COLONIAL MARSHAL BUREAU INCIDENT COMMAND CENTER - ANCHORPOINT STATION", subject, addressed_to, message_body, sent_by, "Supervisory Deputy Marshal", "殖民地执法局"))
		show_browser(user, "<body class='paper'>[fax_message.data]</body>", "PREVIEW OF CMB FAX", width = DEFAULT_PAPER_WIDTH, height = DEFAULT_PAPER_HEIGHT)
		var/send_choice = tgui_input_list(user, "发送此传真？", "Fax Confirmation", list("Send", "Cancel"))
		if(send_choice != "Send")
			return
		var/is_priority_fax = tgui_alert(user, "这是加急传真吗？", "Priority Fax?", list("Yes", "No"))

		send_admin_fax(FACTION_MARSHAL, fax_message, origin_fax, is_priority_fax, target_human)

	else if(href_list["customise_paper"])
		if(!check_rights(R_MOD))
			return

		var/obj/item/paper/sheet = locate(href_list["customise_paper"])
		usr.client.customise_paper(sheet)

	else if(href_list["jumpto"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["jumpto"])
		usr.client.jumptomob(M)

	else if(href_list["getmob"])
		if(!check_rights(R_ADMIN))
			return

		if(alert(usr, "确认？", "消息", "Yes", "No") != "Yes")
			return
		var/mob/M = locate(href_list["getmob"])
		usr.client.Getmob(M)

	else if(href_list["sendmob"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["sendmob"])
		usr.client.sendmob(M)

	else if(href_list["narrateto"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["narrateto"])
		usr.client.cmd_admin_direct_narrate(M)

	else if(href_list["subtlemessage"])
		if(!check_rights(R_MOD,0) && !check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["subtlemessage"])
		usr.client.cmd_admin_subtle_message(M)

	else if(href_list["create_object"])
		if(!check_rights(R_SPAWN))
			return
		return create_object(usr)

	else if(href_list["quick_create_object"])
		if(!check_rights(R_SPAWN))
			return
		return quick_create_object(usr)

	else if(href_list["create_turf"])
		if(!check_rights(R_SPAWN))
			return
		return create_turf(usr)

	else if(href_list["create_mob"])
		if(!check_rights(R_SPAWN))
			return
		return create_mob(usr)

	else if(href_list["send_tip"])
		if(!check_rights(R_SPAWN))
			return
		return send_tip(usr)

	else if(href_list["object_list"]) //this is the laggiest thing ever
		if(!check_rights(R_SPAWN))
			return

		var/atom/loc = usr.loc

		var/dirty_paths
		if (istext(href_list["object_list"]))
			dirty_paths = list(href_list["object_list"])
		else if (istype(href_list["object_list"], /list))
			dirty_paths = href_list["object_list"]

		var/paths = list()
		var/removed_paths = list()

		for(var/dirty_path in dirty_paths)
			var/path = text2path(dirty_path)
			if(!path)
				removed_paths += dirty_path
				continue
			else if(!ispath(path, /obj) && !ispath(path, /turf) && !ispath(path, /mob))
				removed_paths += dirty_path
				continue
			paths += path

		if(!paths)
			alert("你发送的路径列表为空")
			return
		if(length(paths) > 5)
			alert("选择更少的对象类型（最多5个）。")
			return
		else if(length(removed_paths))
			alert("Removed:\n" + jointext(removed_paths, "\n"))

		var/list/offset = splittext(href_list["offset"],",")
		var/number = clamp(text2num(href_list["object_count"]), 1, 100)
		var/X = length(offset) > 0 ? text2num(offset[1]) : 0
		var/Y = length(offset) > 1 ? text2num(offset[2]) : 0
		var/Z = length(offset) > 2 ? text2num(offset[3]) : 0
		var/tmp_dir = href_list["object_dir"]
		var/obj_dir = tmp_dir ? text2num(tmp_dir) : 2
		if(!obj_dir || !(obj_dir in list(1,2,4,8,5,6,9,10)))
			obj_dir = 2
		var/obj_name = sanitize(href_list["object_name"])
		var/where = href_list["object_where"]
		if (!(where in list("onfloor","inhand","inmarked")))
			where = "onfloor"

		if( where == "inhand" )
			to_chat(usr, "手持生成功能暂不可用。将生成在地板上。")
			where = "onfloor"

		if (where == "inhand") //Can only give when human or monkey
			if (!(ishuman(usr)))
				to_chat(usr, "只有人类或猴子角色才能在手中生成物品。")
				where = "onfloor"
			else if (usr.get_active_hand())
				to_chat(usr, "你的当前手持位已满。将生成在地板上。")
				where = "onfloor"

		if (where == "inmarked" )
			if (!marked_datum)
				to_chat(usr, "你未标记任何数据对象。取消生成。")
				return
			else
				var/datum/D = marked_datum
				if(!D)
					return

				if (!istype(D,/atom))
					to_chat(usr, "你标记的数据对象不能作为目标。目标必须是 /atom 类型。取消生成。")
					return

		var/atom/target //Where the object will be spawned
		switch (where)
			if ("onfloor")
				switch (href_list["offset_type"])
					if ("absolute")
						target = locate(0 + X,0 + Y,0 + Z)
					if ("relative")
						target = locate(loc.x + X,loc.y + Y,loc.z + Z)
			if ("inmarked")
				var/datum/D = marked_datum
				if(!D)
					to_chat(usr, "标记的数据对象无效。取消。")
					return

				target = D

		if(target)
			for (var/path in paths)
				for (var/i = 0; i < number; i++)
					if(path in typesof(/turf))
						var/turf/O = target
						var/turf/N = O.ChangeTurf(path)
						if(N)
							if(obj_name)
								N.name = obj_name
					else
						var/atom/O = new path(target)
						if(O)
							O.setDir(obj_dir)
							if(obj_name)
								O.name = obj_name
								if(istype(O,/mob))
									var/mob/M = O
									M.change_real_name(M, obj_name)

		if (number == 1)
			log_admin("[key_name(usr)] created a [english_list(paths)]")
			for(var/path in paths)
				if(ispath(path, /mob))
					message_admins("[key_name_admin(usr)] created a [english_list(paths)]", 1)
					break
		else
			log_admin("[key_name(usr)] created [number]ea [english_list(paths)]")
			for(var/path in paths)
				if(ispath(path, /mob))
					message_admins("[key_name_admin(usr)] created [number]ea [english_list(paths)]", 1)
					break
		return

	else if(href_list["create_humans_list"])
		if(!check_rights(R_SPAWN))
			return

		create_humans_list(href_list)

	else if(href_list["create_xenos_list"])
		if(!check_rights(R_SPAWN))
			return

		create_xenos_list(href_list)

	else if(href_list["events"])
		if(!check_rights(R_ADMIN))
			return

		topic_events(href_list["events"])

	else if(href_list["teleport"])
		if(!check_rights(R_MOD))
			return

		topic_teleports(href_list["teleport"])

	else if(href_list["inviews"])
		if(!check_rights(R_MOD))
			return

		topic_inviews(href_list["inviews"])

	else if(href_list["vehicle"])
		if(!check_rights(R_MOD))
			return

		topic_vehicles(href_list["vehicle"])

	// player info stuff

	if(href_list["add_player_info"])
		var/key = href_list["add_player_info"]
		var/add = input("Add Player Info") as null|message
		if(!add)
			return

		var/datum/entity/player/P = get_player_from_key(key)
		P.add_note(add, FALSE)
		player_notes_show(key)

	if(href_list["add_player_info_confidential"])
		var/key = href_list["add_player_info_confidential"]
		var/add = input("Add Confidential Player Info") as null|message
		if(!add)
			return

		var/datum/entity/player/P = get_player_from_key(key)
		P.add_note(add, TRUE)
		player_notes_show(key)

	if(href_list["remove_player_info"])
		var/key = href_list["remove_player_info"]
		var/index = text2num(href_list["remove_index"])

		var/datum/entity/player/P = get_player_from_key(key)
		P.remove_note(index)
		player_notes_show(key)

	if(href_list["notes"])
		var/ckey = href_list["ckey"]
		if(!ckey)
			var/mob/M = locate(href_list["mob"])
			if(ismob(M))
				ckey = M.ckey

		switch(href_list["notes"])
			if("show")
				player_notes_show(ckey)
		return

	if(href_list["player_notes_all"])
		var/key = href_list["player_notes_all"]
		player_notes_all(key)
		return

	if(href_list["ccmark"]) // CentComm-mark. We want to let all Admins know that something is "Marked", but not let the player know because it's not very RP-friendly.
		var/mob/ref_person = locate(href_list["ccmark"])
		var/msg = SPAN_NOTICE("<b>NOTICE: <font color=red>[usr.key]</font> is responding to <font color=red>[key_name(ref_person)]</font>.</b>")

		//send this msg to all admins
		for(var/client/X in GLOB.admins)
			if((R_ADMIN|R_MOD) & X.admin_holder.rights)
				to_chat(X, msg)

		//unanswered_distress -= ref_person

	if(href_list["ccdeny"]) // CentComm-deny. The distress call is denied, without any further conditions
		var/mob/ref_person = locate(href_list["ccdeny"])
		marine_announcement("求救信号未收到回应，发射管正在重新校准。", "Distress Beacon", logging = ARES_LOG_SECURITY)
		log_game("[key_name_admin(usr)] has denied a distress beacon, requested by [key_name_admin(ref_person)]")
		message_admins("[key_name_admin(usr)] has denied a distress beacon, requested by [key_name_admin(ref_person)]", 1)

		//unanswered_distress -= ref_person

	if(href_list["distresscancel"])
		if(GLOB.distress_cancel)
			to_chat(usr, "求救信标已被取消，或者你已错过取消时机。")
			return
		log_game("[key_name_admin(usr)] has canceled the distress beacon.")
		message_admins("[key_name_admin(usr)] has canceled the distress beacon.")
		GLOB.distress_cancel = TRUE
		return

	if(href_list["distress"]) //Distress Beacon, sends a random distress beacon when pressed
		GLOB.distress_cancel = FALSE
		message_admins("[key_name_admin(usr)] has opted to SEND the distress beacon! Launching in 10 seconds... (<A href='byond://?_src_=admin_holder;[HrefToken(forceGlobal = TRUE)];distresscancel=\ref[usr]'>CANCEL</A>)")
		addtimer(CALLBACK(src, PROC_REF(accept_ert), usr, locate(href_list["distress"])), 10 SECONDS)
		//unanswered_distress -= ref_person

	if(href_list["distress_handheld"]) //Prepares to call and logs accepted handheld distress beacons
		var/mob/ref_person = href_list["distress_handheld"]
		var/ert_name = href_list["ert_name"]
		GLOB.distress_cancel = FALSE
		message_admins("[key_name_admin(usr)] has opted to SEND [ert_name]! Launching in 10 seconds... (<A href='byond://?_src_=admin_holder;[HrefToken(forceGlobal = TRUE)];distresscancel=\ref[usr]'>CANCEL</A>)")
		addtimer(CALLBACK(src, PROC_REF(accept_handheld_ert), usr, ref_person, ert_name), 10 SECONDS)

	if(href_list["deny_distress_handheld"]) //Logs denied handheld distress beacons
		var/mob/ref_person = href_list["deny_distress_handheld"]
		to_chat(ref_person, "求救信号未收到回应。")
		log_game("[key_name_admin(usr)] has denied a distress beacon, requested by [key_name_admin(ref_person)]")
		message_admins("[key_name_admin(usr)] has denied a distress beacon, requested by [key_name_admin(ref_person)]")

	if(href_list["destroyship"]) //Distress Beacon, sends a random distress beacon when pressed
		GLOB.destroy_cancel = FALSE
		message_admins("[key_name_admin(usr)] has opted to GRANT the self-destruct! Starting in 10 seconds... (<A href='byond://?_src_=admin_holder;[HrefToken(forceGlobal = TRUE)];sdcancel=\ref[usr]'>CANCEL</A>)")
		spawn(100)
			if(GLOB.distress_cancel)
				return
			var/mob/ref_person = locate(href_list["destroyship"])
			set_security_level(SEC_LEVEL_DELTA)
			log_game("[key_name_admin(usr)] has granted self-destruct, requested by [key_name_admin(ref_person)]")
			message_admins("[key_name_admin(usr)] has granted self-destruct, requested by [key_name_admin(ref_person)]", 1)

	if(href_list["nukeapprove"])
		var/mob/ref_person = locate(href_list["nukeapprove"])
		if(!istype(ref_person))
			return FALSE
		var/nukename = "加密的行动大片"
		var/prompt = tgui_alert(usr, "是否将核弹设置为加密状态？", "Nuke Type", list("Encrypted", "Decrypted"), 20 SECONDS)
		if(prompt == "Decrypted")
			nukename = "已解密的行动大片"
		prompt = tgui_alert(usr, "你确定要授权陆战队员使用‘[nukename]’吗？这将极大影响本轮战局！", "DEFCON 1", list("Yes", "No"))
		if(prompt != "Yes")
			return

		var/nuketype = GLOB.supply_packs_types[nukename]
		//make ASRS order for nuke
		var/datum/supply_order/new_order = new()
		new_order.ordernum = GLOB.supply_controller.ordernum++
		new_order.objects = list(GLOB.supply_packs_datums[nuketype])
		new_order.orderedby = ref_person
		new_order.approvedby = "USCM High Command"
		GLOB.supply_controller.shoppinglist += new_order

		//Can no longer request a nuke
		GLOB.ares_datacore.nuke_available = FALSE

		marine_announcement("一枚核装置已获最高指挥部授权，将通过ASRS系统运抵补给处。", "NUCLEAR ORDNANCE AUTHORIZED", 'sound/misc/notice2.ogg', logging = ARES_LOG_MAIN)
		log_game("[key_name_admin(usr)] has authorized \a [nuketype], requested by [key_name_admin(ref_person)]")
		message_admins("[key_name_admin(usr)] has authorized \a [nuketype], requested by [key_name_admin(ref_person)]")

	if(href_list["nukedeny"])
		var/mob/ref_person = locate(href_list["nukedeny"])
		if(!istype(ref_person))
			return FALSE
		marine_announcement("你方关于部署核武器的请求已由USCM最高指挥部审核，出于作战安全与殖民地保护原因，请求已被驳回。祝您愉快。", "NUCLEAR ORDNANCE DENIED", 'sound/misc/notice2.ogg', logging = ARES_LOG_MAIN)
		log_game("[key_name_admin(usr)] has denied nuclear ordnance, requested by [key_name_admin(ref_person)]")
		message_admins("[key_name_admin(usr)] has dnied nuclear ordnance, requested by [key_name_admin(ref_person)]")

	if(href_list["sddeny"]) // CentComm-deny. The self-destruct is denied, without any further conditions
		var/mob/ref_person = locate(href_list["sddeny"])
		marine_announcement("自毁请求未收到回应，ARES正在重新计算统计数据。", "Self-Destruct System", logging = ARES_LOG_SECURITY)
		log_game("[key_name_admin(usr)] has denied self-destruct, requested by [key_name_admin(ref_person)]")
		message_admins("[key_name_admin(usr)] has denied self-destruct, requested by [key_name_admin(ref_person)]", 1)

	if(href_list["sdcancel"])
		if(GLOB.destroy_cancel)
			to_chat(usr, "自毁程序已被取消。")
			return
		if(get_security_level() == "delta")
			to_chat(usr, "太迟了！自毁程序已启动。")
			return
		log_game("[key_name_admin(usr)] has canceled the self-destruct.")
		message_admins("[key_name_admin(usr)] has canceled the self-destruct.")
		GLOB.destroy_cancel = TRUE
		return

	if(href_list["tag_datum"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/datum_to_tag = locate(href_list["tag_datum"])
		if(!datum_to_tag)
			return
		return add_tagged_datum(datum_to_tag)

	if(href_list["del_tag"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/datum_to_remove = locate(href_list["del_tag"])
		if(!datum_to_remove)
			return
		return remove_tagged_datum(datum_to_remove)

	if(href_list["view_bug_report"])
		if(!check_rights(R_ADMIN|R_MOD))
			return

		var/datum/tgui_bug_report_form/bug_report = locate(href_list["view_bug_report"])
		if(!istype(bug_report) || QDELETED(bug_report))
			to_chat(usr, SPAN_WARNING("此错误报告已不可用。"))
			return

		if(!bug_report.assign_admin(usr))
			return

		bug_report.tgui_interact(usr)
		return

	if(href_list["show_tags"])
		if(!check_rights(R_ADMIN))
			return
		return display_tags()

	if(href_list["mark_datum"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/datum_to_mark = locate(href_list["mark_datum"])
		if(!datum_to_mark)
			return
		return usr.client?.mark_datum(datum_to_mark)

	if(href_list["force_event"])
		if(!check_rights(R_EVENT))
			return
		var/datum/round_event_control/E = locate(href_list["force_event"]) in SSevents.control
		if(!E)
			return
		E.admin_setup(usr)
		var/datum/round_event/event = E.run_event()
		if(event.cancel_event)
			return
		if(event.announce_when>0)
			event.processing = FALSE
			var/prompt = alert(usr, "是否要向全体人员发出警报？", "警报", "Yes", "No", "Cancel")
			switch(prompt)
				if("Yes")
					event.announce_chance = 100
				if("Cancel")
					event.kill()
					return
				if("No")
					event.announce_chance = 0
			event.processing = TRUE
		message_admins("[key_name_admin(usr)] has triggered an event. ([E.name])")
		log_admin("[key_name(usr)] has triggered an event. ([E.name])")
		return

	if(href_list["viewnotes"])
		if(!check_rights(R_MOD))
			return

		var/mob/checking = locate(href_list["viewnotes"])

		player_notes_all(checking.key)

	if(href_list["AresReply"])
		var/mob/living/carbon/human/speaker = locate(href_list["AresReply"])

		if(!istype(speaker))
			to_chat(usr, "这只能用于 /mob/living/carbon/human 类型的实例。")
			return FALSE

		if((!GLOB.ares_link.interface) || (GLOB.ares_link.interface.inoperable()))
			to_chat(usr, "ARES界面离线。")
			return FALSE

		var/input = input(src.owner, "请输入一条来自ARES的回复消息给 [key_name(speaker)]。","Outgoing message from ARES", "")
		if(!input)
			return FALSE

		to_chat(src.owner, "你已通过ARES界面向 [speaker] 发送了消息：[input]。")
		log_admin("[src.owner] replied to [key_name(speaker)]'s ARES message with the message [input].")
		for(var/client/staff in GLOB.admins)
			if((R_ADMIN|R_MOD) & staff.admin_holder.rights)
				to_chat(staff, SPAN_STAFF_IC("<b>管理员/模组：[SPAN_RED("[src.owner] replied to [key_name(speaker)]'s ARES message")] with: [SPAN_BLUE(input)] </b>"))
		GLOB.ares_link.interface.response_from_ares(input, href_list["AresRef"])

	if(href_list["AresMark"])
		var/mob/living/carbon/human/speaker = locate(href_list["AresMark"])

		if(!istype(speaker))
			to_chat(usr, "这只能用于 /mob/living/carbon/human 类型的实例。")
			return FALSE

		if((!GLOB.ares_link.interface) || (GLOB.ares_link.interface.inoperable()))
			to_chat(usr, "ARES界面离线。")
			return FALSE

		to_chat(src.owner, "你已标记 [speaker] 的ARES消息以待回复。")
		log_admin("[src.owner] marked [key_name(speaker)]'s ARES message. [src.owner] will be responding.")
		for(var/client/staff in GLOB.admins)
			if((R_ADMIN|R_MOD) & staff.admin_holder.rights)
				to_chat(staff, SPAN_STAFF_IC("<b>管理员/模组：[SPAN_RED("[src.owner] marked [key_name(speaker)]'s ARES message for response.")]</b>"))

	return

/datum/admins/proc/accept_ert(mob/approver, mob/ref_person)
	if(GLOB.distress_cancel)
		return
	GLOB.distress_cancel = TRUE
	SSticker.mode.activate_distress()
	log_game("[key_name_admin(approver)] has sent a randomized distress beacon, requested by [key_name_admin(ref_person)]")
	message_admins("[key_name_admin(approver)] has sent a randomized distress beacon, requested by [key_name_admin(ref_person)]")

///Handles calling the ERT sent by handheld distress beacons
/datum/admins/proc/accept_handheld_ert(mob/approver, mob/ref_person, ert_called)
	if(GLOB.distress_cancel)
		return
	GLOB.distress_cancel = TRUE
	SSticker.mode.get_specific_call("[ert_called]", TRUE, FALSE)
	log_game("[key_name_admin(approver)] has sent [ert_called], requested by [key_name_admin(ref_person)]")
	message_admins("[key_name_admin(approver)] has sent [ert_called], requested by [key_name_admin(ref_person)]")

/datum/admins/proc/generate_job_ban_list(mob/M, datum/entity/player/P, list/roles, department, color = "ccccff")
	var/counter = 0

	var/dat = ""
	dat += "<table cellpadding='1' cellspacing='0' width='100%'>"
	dat += "<tr align='center' bgcolor='[color]'><th colspan='[length(roles)]'><a href='byond://?src=\ref[src];[HrefToken(forceGlobal = TRUE)];jobban3=[department]dept;jobban4=\ref[M]'>[department]</a></th></tr><tr align='center'>"
	for(var/jobPos in roles)
		if(!jobPos)
			continue
		var/datum/job/job = GLOB.RoleAuthority.roles_by_name[jobPos]
		if(!job)
			continue

		if(jobban_isbanned(M, job.title, P))
			dat += "<td width='20%'><a href='byond://?src=\ref[src];[HrefToken(forceGlobal = TRUE)];jobban3=[job.title];jobban4=\ref[M]'><font color=red>[replacetext(job.title, " ", "&nbsp")]</font></a></td>"
			counter++
		else
			dat += "<td width='20%'><a href='byond://?src=\ref[src];[HrefToken(forceGlobal = TRUE)];jobban3=[job.title];jobban4=\ref[M]'>[replacetext(job.title, " ", "&nbsp")]</a></td>"
			counter++

		if(counter >= 5) //So things don't get squiiiiished!
			dat += "</tr><tr>"
			counter = 0
	dat += "</tr></table>"
	return dat

/datum/admins/proc/get_job_titles_from_list(list/roles)
	var/list/temp = list()
	for(var/jobPos in roles)
		if(!jobPos)
			continue
		var/datum/job/J = GLOB.RoleAuthority.roles_by_name[jobPos]
		if(!J)
			continue
		temp += J.title
	return temp




/datum/admins/proc/send_admin_fax(sending_faction, datum/fax/fax_message, obj/structure/machinery/faxmachine/origin_fax, sending_priority, mob/living/carbon/human/target_human, press_organization)
	GLOB.fax_contents += fax_message // save a copy

	var/customname = input(src.owner, "为报告选择一个标题", "Title") as text|null
	if(!customname)
		return

	var/reply_log = "<a href='byond://?FaxView=\ref[fax_message]'>\[view '[customname]' from [key_name(usr)] at [time2text(world.timeofday, "hh:mm:ss")]\]</a>" //Add replies so that mods know what the hell is goin on with the RP

	var/faction_ghost_header
	var/faction_prefix
	var/fax_stamp_icon
	var/fax_stamp_print
	switch(sending_faction)
		if(FACTION_MARSHAL)
			GLOB.CMBFaxes.Add(reply_log)
			faction_ghost_header = "<b><font color='#1B748C'>COLONIAL MARSHAL BUREAU FAX REPLY: </font></b> "
			faction_prefix = "殖民地执法局"
			fax_stamp_icon = "paper_stamp-cmb"
			fax_stamp_print = "<HR><i>This paper has been stamped by [FAX_NET_CMB].</i>"
		if(FACTION_MARINE)
			GLOB.USCMFaxes.Add(reply_log)
			faction_ghost_header = "<b><font color='#1F66A0'>USCM FAX REPLY: </font></b> "
			faction_prefix = "USCM High Command"
			fax_stamp_icon = "paper_stamp-uscm"
			fax_stamp_print = "<HR><i>This paper has been stamped by the [FAX_NET_USCM_HC].</i>"
		if(FACTION_CLF)
			GLOB.CLFFaxes.Add(reply_log)
			faction_ghost_header = "<b><font color='#426480'>COLONIAL LIBERATION FRONT FAX REPLY: </font></b> "
			faction_prefix = "殖民地解放阵线"
			fax_stamp_icon = "paper_stamp-clf"
			fax_stamp_print = "<HR><i>This paper has been stamped by the [FAX_NET_CLF_HC].</i>"
		if(FACTION_UPP)
			GLOB.UPPFaxes.Add(reply_log)
			faction_ghost_header = "<b><font color='#0c5020'>UNION OF PROGRESSIVE PEOPLES FAX REPLY: </font></b> "
			faction_prefix = "进步人民联盟"
			fax_stamp_icon = "paper_stamp-upp"
			fax_stamp_print = "<HR><i>This paper has been stamped by the [FAX_NET_UPP_HC].</i>"
		if(FACTION_TWE)
			GLOB.TWEFaxes.Add(reply_log)
			faction_ghost_header = "<b><font color='#2994eb'>THREE WORLD EMPIRE FAX REPLY: </font></b> "
			faction_prefix = "三世界帝国"
			fax_stamp_icon = "paper_stamp-twe"
			fax_stamp_print = "<HR><i>This paper has been stamped by the [FAX_NET_TWE_HC].</i>"
		if(FACTION_WY)
			GLOB.WYFaxes.Add(reply_log)
			faction_ghost_header = "<b><font color='#8babc5'>WEYLAND-YUTANI FAX REPLY: </font></b> "
			faction_prefix = "Weyland-Yutani"
			fax_stamp_icon = "paper_stamp-weyyu"
			fax_stamp_print = "<HR><i>This paper has been stamped by the [FAX_NET_WY_HC].</i>"
		if("Press")
			GLOB.PressFaxes.Add(reply_log)
			faction_ghost_header = "<b><font color='#1F66A0'>PRESS FAX REPLY: </font></b> "
			faction_prefix = press_organization ? press_organization : "Free Press"
			fax_stamp_icon = "paper_stamp-rd"
			fax_stamp_print = "<HR><i>This paper has been stamped by the [FAX_NET_PRESS_HC].</i>"

	var/msg_ghost = SPAN_NOTICE(faction_ghost_header)
	msg_ghost += "Transmitting '[customname]' via secure connection ..."
	msg_ghost += "<a href='byond://?FaxView=\ref[fax_message]'>view message</a>"
	announce_fax( ,msg_ghost)


	for(var/obj/structure/machinery/faxmachine/target_fax in GLOB.machines)
		if(target_fax == origin_fax)
			if(!(target_fax.inoperable()))

				// animate! it's alive!
				flick("faxreceive", target_fax)

				// give the sprite some time to flick

				sleep(2 SECONDS)
				var/obj/item/paper/P = new /obj/item/paper(target_fax.loc)
				P.name = "[faction_prefix] - [customname]"
				P.info = fax_message.data
				P.update_icon()

				playsound(target_fax.loc, "sound/machines/fax.ogg", 15)

				// Stamps
				var/image/stampoverlay = image('icons/obj/items/paper.dmi')
				stampoverlay.icon_state = fax_stamp_icon
				if(!P.stamped)
					P.stamped = new
				P.stamped += /obj/item/tool/stamp
				P.overlays += stampoverlay
				P.stamps += fax_stamp_print
				if(sending_priority == "Yes")
					playsound(target_fax.loc, "sound/machines/twobeep.ogg", 45)
					target_fax.langchat_speech("beeps with a priority message", get_mobs_in_view(GLOB.world_view_size, target_fax), GLOB.all_languages, skip_language_check = TRUE, animation_style = LANGCHAT_FAST_POP, additional_styles = list("langchat_small", "emote"))
					target_fax.visible_message("<b>[target_fax]</b>发出哔哔声，提示有一条优先消息。")
					if(target_fax.radio_alert_tag != null)
						ai_silent_announcement("COMMUNICATIONS REPORT: Fax Machine [target_fax.machine_id_tag], [target_fax.sub_name ? "[target_fax.sub_name]" : ""], now receiving priority fax.", "[target_fax.radio_alert_tag]")

			to_chat(src.owner, "消息回复已成功发送。")
			message_admins(SPAN_STAFF_IC("[key_name_admin(src.owner)] replied to a fax message from [key_name_admin(target_human)]"), 1)
			return
	to_chat(src.owner, SPAN_RED("无法定位传真机！"))
