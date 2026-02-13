// #################### Working Joe Ticket Console #####################
/obj/structure/machinery/computer/working_joe
	name = "APOLLO维护控制器"
	desc = "为便利工作乔及其操作而建造的控制台，允许简单的资源分配。"
	icon = 'icons/obj/structures/machinery/ares.dmi'
	icon_state = "console"
	explo_proof = TRUE

	/// The ID used to link all devices.
	var/datum/ares_link/link
	/// The datacore storing all the information.
	var/datum/ares_datacore/datacore

	var/current_menu = "login"
	var/last_menu = ""

	var/authentication = APOLLO_ACCESS_LOGOUT
	/// The last person to login.
	var/last_login

	/// Notification sound
	var/notify_sounds = TRUE


/obj/structure/machinery/computer/working_joe/proc/link_systems(datum/ares_link/new_link = GLOB.ares_link, override)
	if(link && !override)
		return FALSE
	if(new_link)
		new_link.ticket_computers += src
		link = new_link
		new_link.linked_systems += src
	if(!datacore)
		datacore = GLOB.ares_datacore
	return TRUE

/obj/structure/machinery/computer/working_joe/Initialize(mapload, ...)
	link_systems(override = FALSE)
	. = ..()

/obj/structure/machinery/computer/working_joe/proc/notify()
	if(notify_sounds)
		playsound(src, 'sound/machines/pda_ping.ogg', 25, 0)

/obj/structure/machinery/computer/working_joe/proc/send_notifcation()
	for(var/obj/structure/machinery/computer/working_joe/ticketer as anything in link.ticket_computers)
		if(ticketer == src)
			continue
		ticketer.notify()

/obj/structure/machinery/computer/working_joe/proc/delink()
	if(link)
		link.ticket_computers -= src
		link.linked_systems -= src
		link = null
	datacore = null

/obj/structure/machinery/computer/working_joe/Destroy()
	delink()
	return ..()

// ------ Maintenance Controller UI ------ //
/obj/structure/machinery/computer/working_joe/attack_hand(mob/user as mob)
	if(..() || !allowed(usr) || inoperable())
		return FALSE

	tgui_interact(user)
	return TRUE

/obj/structure/machinery/computer/working_joe/tgui_interact(mob/user, datum/tgui/ui, datum/ui_state/state)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "WorkingJoe", name)
		ui.open()

/obj/structure/machinery/computer/working_joe/ui_data(mob/user)
	var/list/data = datacore.get_interface_data()

	data["local_current_menu"] = current_menu
	data["local_last_page"] = last_menu
	data["local_logged_in"] = last_login
	data["local_access_text"] = "access level [authentication], [ares_auth_to_text(authentication)]."
	data["local_access_level"] = authentication
	data["local_notify_sounds"] = notify_sounds

	return data

/obj/structure/machinery/computer/working_joe/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	if(!allowed(user))
		return UI_UPDATE
	if(inoperable())
		return UI_DISABLED

/obj/structure/machinery/computer/working_joe/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/playsound = TRUE
	var/mob/living/carbon/human/user = ui.user

	switch (action)
		if("go_back")
			if(!last_menu)
				return to_chat(user, SPAN_WARNING("错误，未检测到上一页。"))
			var/temp_holder = current_menu
			current_menu = last_menu
			last_menu = temp_holder

		if("login")

			var/obj/item/card/id/idcard = user.get_active_hand()
			if(istype(idcard))
				authentication = get_ares_access(idcard)
				last_login = idcard.registered_name
			else if(user.wear_id)
				idcard = user.get_idcard()
				if(idcard)
					authentication = get_ares_access(idcard)
					last_login = idcard.registered_name
			else
				to_chat(user, SPAN_WARNING("你需要身份卡才能访问此终端！"))
				playsound(src, 'sound/machines/buzz-two.ogg', 15, 1)
				return FALSE
			if(authentication)
				datacore.apollo_login_list += "[last_login] at [worldtime2text()], Access Level [authentication] - [ares_auth_to_text(authentication)]."
			current_menu = "main"

		if("logout")
			last_menu = current_menu
			current_menu = "login"
			datacore.apollo_login_list += "[last_login] logged out at [worldtime2text()]."

		if("home")
			last_menu = current_menu
			current_menu = "main"
		if("page_logins")
			last_menu = current_menu
			current_menu = "login_records"
		if("page_apollo")
			last_menu = current_menu
			current_menu = "apollo"
		if("page_request")
			last_menu = current_menu
			current_menu = "access_requests"
		if("page_report")
			last_menu = current_menu
			current_menu = "maint_reports"
		if("page_tickets")
			last_menu = current_menu
			current_menu = "access_tickets"
		if("page_maintenance")
			last_menu = current_menu
			current_menu = "maint_claim"
		if("page_core_gas")
			last_menu = current_menu
			current_menu = "core_security_gas"

		if("toggle_sound")
			notify_sounds = !notify_sounds

		if("new_report")
			var/priority_report = FALSE
			var/maint_type = tgui_input_list(user, "你要报告哪种类型的维护项目？", "Report Category", GLOB.maintenance_categories, 30 SECONDS)
			switch(maint_type)
				if("Major Structural Damage", "Fire", "Communications Failure",	"Power Generation Failure")
					priority_report = TRUE

			if(!maint_type)
				return FALSE
			var/details = tgui_input_text(user, "此报告的详细内容是什么？", "Ticket Details", encode = FALSE)
			if(!details)
				return FALSE

			if((authentication >= APOLLO_ACCESS_REPORTER) && !priority_report)
				var/is_priority = tgui_alert(user, "这是优先报告吗？", "Priority designation", list("Yes", "No"))
				if(is_priority == "Yes")
					priority_report = TRUE

			var/confirm = alert(user, "请确认提交你的维护报告。\n\n 优先级：[priority_report ? "Yes" : "No"]\n Category: '[maint_type]'\n Details: '[details]'\n\n Is this correct?", "确认", "Yes", "No")
			if(confirm == "Yes")
				if(link)
					var/datum/ares_ticket/maintenance/maint_ticket = new(last_login, maint_type, details, priority_report)
					link.tickets_maintenance += maint_ticket
					if(priority_report)
						ares_apollo_talk("Priority Maintenance Report: [maint_type] - ID [maint_ticket.ticket_id]. Seek and resolve.")
					else
						send_notifcation()
					log_game("ARES: Maintenance Ticket '\ref[maint_ticket]' created by [key_name(user)] as [last_login] with Category '[maint_type]' and Details of '[details]'.")
					return TRUE
			return FALSE

		if("claim_ticket")
			var/datum/ares_ticket/ticket = locate(params["ticket"])
			if(!istype(ticket))
				return FALSE
			var/claim = TRUE
			var/assigned = ticket.ticket_assignee
			if(assigned)
				if(assigned == last_login)
					var/prompt = tgui_alert(user, "你已认领此工单！是否要放弃认领？", "Unclaim ticket", list("Yes", "No"))
					if(prompt != "Yes")
						return FALSE
					/// set ticket back to pending
					ticket.ticket_assignee = null
					ticket.ticket_status = TICKET_PENDING
					return claim
				var/choice = tgui_alert(user, "此工单已被[assigned]认领！是否要覆盖其认领？", "Claim Override", list("Yes", "No"))
				if(choice != "Yes")
					claim = FALSE
			if(claim)
				ticket.ticket_assignee = last_login
				ticket.ticket_status = TICKET_ASSIGNED
			return claim

		if("cancel_ticket")
			var/datum/ares_ticket/ticket = locate(params["ticket"])
			if(!istype(ticket))
				return FALSE
			if(ticket.ticket_submitter != last_login)
				to_chat(user, SPAN_WARNING("你无法取消不属于你的工单！"))
				return FALSE
			to_chat(user, SPAN_WARNING("[ticket.ticket_type] [ticket.ticket_id] 已被取消。"))
			ticket.ticket_status = TICKET_CANCELLED
			if(ticket.ticket_priority)
				ares_apollo_talk("Priority [ticket.ticket_type] [ticket.ticket_id] has been cancelled.")
			else
				send_notifcation()
			return TRUE

		if("mark_ticket")
			var/datum/ares_ticket/ticket = locate(params["ticket"])
			if(!istype(ticket))
				return FALSE
			if(ticket.ticket_assignee != last_login && ticket.ticket_assignee) //must be claimed by you or unclaimed.)
				to_chat(user, SPAN_WARNING("你无法更新未分配给你的工单！"))
				return FALSE
			var/choice = tgui_alert(user, "你希望将工单标记为什么状态？", "Mark", list(TICKET_COMPLETED, TICKET_REJECTED), 20 SECONDS)
			switch(choice)
				if(TICKET_COMPLETED)
					ticket.ticket_status = TICKET_COMPLETED
				if(TICKET_REJECTED)
					ticket.ticket_status = TICKET_REJECTED
				else
					return FALSE
			if(ticket.ticket_priority)
				ares_apollo_talk("Priority [ticket.ticket_type] [ticket.ticket_id] has been [choice] by [last_login].")
			else
				send_notifcation()
			to_chat(user, SPAN_NOTICE("[ticket.ticket_type] [ticket.ticket_id] 标记为[choice]。"))
			return TRUE

		if("new_access")
			var/obj/item/card/id/idcard = user.get_active_hand()
			var/has_id = FALSE
			if(istype(idcard))
				has_id = TRUE
			else if(user.wear_id)
				idcard = user.get_idcard()
				if(idcard)
					has_id = TRUE
			if(!has_id)
				to_chat(user, SPAN_WARNING("你需要身份卡才能申请权限工单！"))
				playsound(src, 'sound/machines/buzz-two.ogg', 15, 1)
				return FALSE
			if(idcard.registered_name != last_login)
				to_chat(user, SPAN_WARNING("此身份卡与当前登录不匹配！"))
				playsound(src, 'sound/machines/buzz-two.ogg', 15, 1)
				return FALSE

			var/details = tgui_input_text(user, "此权限工单的目的是什么？", "Ticket Details", encode = FALSE)
			if(!details)
				return FALSE

			var/confirm = alert(user, "请确认提交你的权限工单请求。\n\n持有者：'[last_login]'\n详情：'[details]'\n\n是否正确？", "确认", "Yes", "No")
			if(confirm != "Yes" || !link)
				return FALSE
			var/datum/ares_ticket/access/access_ticket = new(last_login, details, FALSE, idcard.registered_gid)
			link.waiting_ids += idcard
			link.tickets_access += access_ticket
			log_game("ARES: Access Ticket '\ref[access_ticket]' created by [key_name(user)] as [last_login] with Details of '[details]'.")
			message_admins(SPAN_STAFF_IC("[key_name_admin(user)] created a new ARES Access Ticket."), 1)
			ares_apollo_talk("Access Ticket [access_ticket.ticket_id]: [access_ticket.ticket_submitter] requesting access for '[details].")
			return TRUE

		if("return_access")
			playsound = FALSE
			var/datum/ares_ticket/access/access_ticket
			for(var/datum/ares_ticket/access/possible_ticket in link.tickets_access)
				if(possible_ticket.ticket_status != TICKET_GRANTED)
					continue
				if(possible_ticket.ticket_name != last_login)
					continue
				access_ticket = possible_ticket
				break

			for(var/obj/item/card/id/identification in link.active_ids)
				if(identification.registered_gid != access_ticket.user_id_num)
					continue

				access_ticket.ticket_status = TICKET_RETURNED
				identification.access -= ACCESS_MARINE_AI_TEMP
				identification.modification_log += "Temporary AI Access self-returned by [key_name(user)]."

				to_chat(user, SPAN_NOTICE("临时权限工单已上交。"))
				playsound(src, 'sound/machines/chime.ogg', 15, 1)
				ares_apollo_talk("Access Ticket [access_ticket.ticket_id]: [access_ticket.ticket_submitter] surrendered their access.")

				authentication = get_ares_access(identification)
				if(authentication)
					datacore.apollo_login_list += "[last_login] at [worldtime2text()], Surrendered Temporary Access Ticket."
				return TRUE

			to_chat(user, SPAN_WARNING("此身份卡没有权限工单！"))
			playsound(src, 'sound/machines/buzz-two.ogg', 15, 1)
			return FALSE

		if("auth_access")
			playsound = FALSE
			var/datum/ares_ticket/access/access_ticket = locate(params["ticket"])
			if(!istype(access_ticket))
				return FALSE
			for(var/obj/item/card/id/identification in link.waiting_ids)
				if(identification.registered_gid != access_ticket.user_id_num)
					continue
				identification.handle_ares_access(last_login, user)
				access_ticket.ticket_status = TICKET_GRANTED
				playsound(src, 'sound/machines/chime.ogg', 15, 1)
				ares_apollo_talk("Access Ticket [access_ticket.ticket_id]: [access_ticket.ticket_submitter] was granted access by [last_login].")
				return TRUE
			for(var/obj/item/card/id/identification in link.active_ids)
				if(identification.registered_gid != access_ticket.user_id_num)
					continue
				identification.handle_ares_access(last_login, user)
				access_ticket.ticket_status = TICKET_REVOKED
				playsound(src, 'sound/machines/chime.ogg', 15, 1)
				ares_apollo_talk("Access Ticket [access_ticket.ticket_id]: [access_ticket.ticket_submitter] had access revoked by [last_login].")
				return TRUE
			return FALSE

		if("reject_access")
			var/datum/ares_ticket/access/access_ticket = locate(params["ticket"])
			if(!istype(access_ticket))
				return FALSE
			if(access_ticket.ticket_assignee != last_login && access_ticket.ticket_assignee) //must be claimed by you or unclaimed.)
				to_chat(user, SPAN_WARNING("你无法更新未分配给你的工单！"))
				return FALSE
			access_ticket.ticket_status = TICKET_REJECTED
			to_chat(user, SPAN_NOTICE("[access_ticket.ticket_type] [access_ticket.ticket_id] 标记为已拒绝。"))
			ares_apollo_talk("Access Ticket [access_ticket.ticket_id]: [access_ticket.ticket_submitter] was rejected access by [last_login].")
			for(var/obj/item/card/id/identification in link.waiting_ids)
				if(identification.registered_gid != access_ticket.user_id_num)
					continue
				var/mob/living/carbon/human/id_owner = identification.registered_ref?.resolve()
				if(id_owner)
					to_chat(id_owner, SPAN_WARNING("AI访问权限请求被拒绝。"))
					playsound_client(id_owner?.client, 'sound/machines/pda_ping.ogg', src, 25, 0)
			return TRUE

		if("trigger_vent")
			playsound = FALSE
			var/obj/structure/pipes/vents/pump/no_boom/gas/ares/sec_vent = locate(params["vent"])
			if(!istype(sec_vent) || sec_vent.welded)
				to_chat(user, SPAN_WARNING("错误：气体释放失败。"))
				playsound(src, 'sound/machines/buzz-two.ogg', 15, 1)
				return FALSE
			if(!COOLDOWN_FINISHED(sec_vent, vent_trigger_cooldown))
				to_chat(user, SPAN_WARNING("错误：此通风口气体储备不足。"))
				playsound(src, 'sound/machines/buzz-two.ogg', 15, 1)
				return FALSE
			to_chat(user, SPAN_WARNING("正在从[sec_vent.vent_tag]启动气体释放。"))
			playsound(src, 'sound/machines/chime.ogg', 15, 1)
			COOLDOWN_START(sec_vent, vent_trigger_cooldown, COOLDOWN_ARES_VENT)
			ares_apollo_talk("Nerve Gas release imminent from [sec_vent.vent_tag].")
			log_ares_security("Nerve Gas Release", "Released Nerve Gas from Vent '[sec_vent.vent_tag]'.", last_login)
			sec_vent.create_gas(VENT_GAS_CN20_XENO, 6, 5 SECONDS)
			log_admin("[key_name(user)] released nerve gas from Vent '[sec_vent.vent_tag]' via ARES.")

		if("security_lockdown")
			if(!COOLDOWN_FINISHED(datacore, aicore_lockdown))
				to_chat(user, SPAN_BOLDWARNING("AI核心封锁程序正在冷却中！将在[COOLDOWN_SECONDSLEFT(datacore, aicore_lockdown)]秒后准备就绪！"))
				return FALSE
			aicore_lockdown(user)
			return TRUE

		if("update_sentries")
			var/new_iff = params["chosen_iff"]
			if(!new_iff)
				to_chat(user, SPAN_WARNING("错误：未知设置。"))
				return FALSE
			if(new_iff == link.faction_label)
				return FALSE
			link.change_iff(new_iff)
			message_admins("ARES: [key_name(user)] updated ARES Sentry IFF to [new_iff].")
			to_chat(user, SPAN_WARNING("哨戒炮敌我识别设置已更新！"))
			return TRUE

	if(playsound)
		playsound(src, "keyboard_alt", 15, 1)

/obj/item/card/id/proc/handle_ares_access(logged_in = MAIN_AI_SYSTEM, mob/user)
	var/changer = logged_in
	if(user)
		changer = key_name(user)
	var/datum/ares_link/link = GLOB.ares_link

	if(ACCESS_MARINE_AI_TEMP in access)
		access -= ACCESS_MARINE_AI_TEMP
		link.active_ids -= src
		log_idmod(src, "Temporary AI access revoked by [logged_in]", changer)
		to_chat(user, SPAN_NOTICE("已撤销[registered_name]的权限。"))
		var/mob/living/carbon/human/id_owner = registered_ref?.resolve()
		if(id_owner)
			to_chat(id_owner, SPAN_WARNING("AI访问权限已撤销。"))
			playsound_client(id_owner?.client, 'sound/machines/pda_ping.ogg', src, 25, 0)
	else
		access += ACCESS_MARINE_AI_TEMP
		log_idmod(src, "Temporary AI access granted by [logged_in]", changer)
		to_chat(user, SPAN_NOTICE("已授予[registered_name]权限。"))
		link.waiting_ids -= src
		link.active_ids += src
		var/mob/living/carbon/human/id_owner = registered_ref?.resolve()
		if(id_owner)
			to_chat(id_owner, SPAN_HELPFUL("AI访问权限已授予。"))
			playsound_client(id_owner?.client, 'sound/machines/pda_ping.ogg', src, 25, 0)
	return TRUE
