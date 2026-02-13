/client/proc/cmd_admin_change_custom_event()
	set name = "Setup Event Info"
	set category = "Admin.Events"

	if(!admin_holder)
		to_chat(usr, "只有管理员可以使用此命令。")
		return

	if(!LAZYLEN(GLOB.custom_event_info_list))
		to_chat(usr, "自定义事件信息列表未初始化，请通知开发人员。")
		return

	var/list/temp_list = list()

	for(var/T in GLOB.custom_event_info_list)
		var/datum/custom_event_info/CEI = GLOB.custom_event_info_list[T]
		temp_list["[CEI.msg ? "(x) [CEI.faction]" : CEI.faction]"] = CEI.faction

	var/faction = tgui_input_list(usr, "选择阵营。幽灵将仅看到\"Global\" category message. Factions with event message set are marked with (x).", "Faction Choice", temp_list)
	if(!faction)
		return

	faction = temp_list[faction]

	if(!GLOB.custom_event_info_list[faction])
		to_chat(usr, "发生错误，未找到[faction]类别。")
		return

	var/datum/custom_event_info/CEI = GLOB.custom_event_info_list[faction]

	var/input = input(usr, "为输入自定义事件消息。\"[faction]\" category. Be descriptive. \nTo remove the event message, remove text and confirm.", "[faction] Event Message", CEI.msg) as message|null
	if(isnull(input))
		return

	if(input == "" || !input)
		CEI.msg = ""
		message_admins("[key_name_admin(usr)] has removed the event message for \"[faction]\" category.")
		return

	CEI.msg = html_encode(input)
	message_admins("[key_name_admin(usr)] has changed the event message for \"[faction]\" category.")

	CEI.handle_event_info_update(faction)

/client/proc/get_whitelisted_clients()
	set name = "Find Whitelisted Players"
	set category = "Admin.Events"
	if(!admin_holder)
		return

	var/flag = tgui_input_list(src, "哪个旗帜？", "Whitelist Flags", GLOB.bitfields["whitelist_status"])

	var/list/ckeys = list()
	for(var/client/test_client in GLOB.clients)
		if(test_client.check_whitelist_status(GLOB.bitfields["whitelist_status"][flag]))
			ckeys += test_client.ckey
	if(!length(ckeys))
		to_chat(src, SPAN_NOTICE("没有持有该白名单的玩家在线。"))
		return
	to_chat(src, SPAN_NOTICE("白名单持有者：[ckeys.Join(", ")]."))

/client/proc/change_security_level()
	if(!check_rights(R_ADMIN))
		return
	var sec_level = input(usr, "当前安全等级为[get_security_level()]。", "Select Security Level")  as null|anything in (list("green","blue","red","delta")-get_security_level())
	if(sec_level && alert("Switch from code [get_security_level()] to code [sec_level]?","更改安全等级？","Yes","No") == "Yes")
		set_security_level(seclevel2num(sec_level))
		log_admin("[key_name(usr)] changed the security level to code [sec_level].")

/client/proc/toggle_gun_restrictions()
	if(!admin_holder || !config)
		return

	if(CONFIG_GET(flag/remove_gun_restrictions))
		to_chat(src, "<b>已启用武器限制。</b>")
		message_admins("Admin [key_name_admin(usr)] has enabled WY gun restrictions.")
	else
		to_chat(src, "<b>已禁用武器限制。</b>")
		message_admins("Admin [key_name_admin(usr)] has disabled WY gun restrictions.")
	CONFIG_SET(flag/remove_gun_restrictions, !CONFIG_GET(flag/remove_gun_restrictions))

/client/proc/togglebuildmodeself()
	set name = "Buildmode"
	set category = "Admin.Events"
	if(!check_rights(R_ADMIN))
		return

	if(src.mob)
		togglebuildmode(src.mob)

/client/proc/drop_bomb()
	set name = "Drop Bomb"
	set desc = "Cause an explosion of varying strength at your location."
	set category = "Admin.Fun"

	var/turf/epicenter = mob.loc
	handle_bomb_drop(epicenter)

/client/proc/handle_bomb_drop(atom/epicenter)
	var/custom_limit = 5000
	var/power_warn_threshold = 500
	var/falloff_warn_threshold = 0.05
	var/list/choices = list("Small Bomb", "Medium Bomb", "Big Bomb", "Custom Bomb")
	var/list/falloff_shape_choices = list("CANCEL", "Linear", "Exponential")
	var/choice = tgui_input_list(usr, "您想制造多大威力的爆炸？", "Drop Bomb", choices)
	var/datum/cause_data/cause_data = create_cause_data("divine intervention")
	switch(choice)
		if(null)
			return 0
		if("Small Bomb")
			explosion(epicenter, 1, 2, 3, 3, , , , cause_data)
		if("Medium Bomb")
			explosion(epicenter, 2, 3, 4, 4, , , , cause_data)
		if("Big Bomb")
			explosion(epicenter, 3, 5, 7, 5, , , , cause_data)
		if("Custom Bomb")
			var/power = tgui_input_number(src, "威力？", "威力？")
			if(!power)
				return

			var/falloff = tgui_input_number(src, "衰减？", "衰减？")
			if(!falloff)
				return

			var/shape_choice = tgui_input_list(src, "选择衰减形状？", "Select falloff shape", falloff_shape_choices)
			var/explosion_shape = EXPLOSION_FALLOFF_SHAPE_LINEAR
			switch(shape_choice)
				if("CANCEL")
					return 0
				if("Exponential")
					explosion_shape = EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL

			if(power > custom_limit)
				return

			if((power >= power_warn_threshold) && ((1 / (power / falloff)) <= falloff_warn_threshold) && (explosion_shape == EXPLOSION_FALLOFF_SHAPE_LINEAR)) // The lag can be a bit situational, but a large-power explosion with minimal (linear) falloff can absolutely bring the server to a halt in certain cases.
				if(tgui_input_list(src, "此炸弹可能导致服务器延迟。您确定要投放吗？", "Drop confirm", list("Yes", "No")) != "Yes")
					return

			cell_explosion(epicenter, power, falloff, explosion_shape, null, cause_data)
			message_admins("[key_name(src, TRUE)] dropped a custom cell bomb with power [power], falloff [falloff] and falloff_shape [shape_choice]!")
	message_admins("[ckey] used 'Drop Bomb' at [epicenter.loc].")


/client/proc/cmd_admin_emp(atom/O as obj|mob|turf in world)
	set name = "EM Pulse"
	set category = "Admin.Fun"

	if(!check_rights(R_DEBUG|R_ADMIN))
		return

	var/heavy = input("Range of heavy pulse.", text("输入"))  as num|null
	if(heavy == null)
		return
	var/light = input("Range of light pulse.", text("输入"))  as num|null
	if(light == null)
		return

	if(!heavy && !light)
		return

	empulse(O, heavy, light)
	message_admins("[key_name_admin(usr)] created an EM PUlse ([heavy],[light]) at ([O.x],[O.y],[O.z])")
	return

/datum/admins/proc/admin_force_ERT_shuttle()
	set name = "Force ERT Shuttle"
	set desc = "Force Launch the ERT Shuttle."
	set category = "Admin.Shuttles"

	if (!SSticker.mode)
		return
	if(!check_rights(R_EVENT))
		return

	var/list/shuttle_map = list()
	for(var/obj/docking_port/mobile/emergency_response/ert_shuttles in SSshuttle.mobile)
		shuttle_map[ert_shuttles.name] = ert_shuttles.id
	var/tag = tgui_input_list(usr, "应强制发射哪艘紧急响应小组运输机？", "Select an ERT Shuttle:", shuttle_map)
	if(!tag)
		return

	var/shuttleId = shuttle_map[tag]
	var/list/docks = SSshuttle.stationary
	var/list/targets = list()
	var/list/target_names = list()
	var/obj/docking_port/mobile/emergency_response/ert = SSshuttle.getShuttle(shuttleId)
	for(var/obj/docking_port/stationary/emergency_response/dock in docks)
		var/can_dock = ert.canDock(dock)
		if(can_dock == SHUTTLE_CAN_DOCK)
			targets += list(dock)
			target_names +=  list(dock.name)
	var/dock_name = tgui_input_list(usr, "运输机应在[MAIN_SHIP_NAME]的何处停靠？", "Select a docking zone:", target_names)
	var/launched = FALSE
	if(!dock_name)
		return
	for(var/obj/docking_port/stationary/emergency_response/dock as anything in targets)
		if(dock.name == dock_name)
			var/obj/docking_port/stationary/target = SSshuttle.getDock(dock.id)
			ert.request(target)
			launched=TRUE
	if(!launched)
		to_chat(usr, SPAN_WARNING("目前无法发射此求救运输机。中止。"))
		return

	message_admins("[key_name_admin(usr)] force launched a distress shuttle ([tag])")

/datum/admins/proc/admin_force_distress()
	set name = "Distress Beacon"
	set desc = "Call a distress beacon. This should not be done if the shuttle's already been called."
	set category = "Admin.Shuttles"

	if (!SSticker.mode)
		return

	if(!check_rights(R_EVENT)) // Seems more like an event thing than an admin thing
		return

	var/list/list_of_calls = list()
	var/list/assoc_list = list()

	for(var/datum/emergency_call/L in SSticker.mode.all_calls)
		if(L && L.name != "name")
			list_of_calls += L.name
			assoc_list += list(L.name = L)
	list_of_calls = sortList(list_of_calls)

	list_of_calls += "Randomize"

	var/choice = tgui_input_list(usr, "哪个求救信号？", "求救信号", list_of_calls)

	if(!choice)
		return

	var/datum/emergency_call/chosen_ert
	if(choice == "Randomize")
		chosen_ert = SSticker.mode.get_random_call()
	else
		var/datum/emergency_call/em_call = assoc_list[choice]
		chosen_ert = new em_call.type()

	if(!istype(chosen_ert))
		return
	var/quiet_launch = TRUE
	var/ql_prompt = tgui_alert(usr, "您要广播信标发射吗？这将向所有玩家公开求救信标。", "Announce distress beacon?", list("Yes", "No"), 20 SECONDS)
	if(ql_prompt == "Yes")
		quiet_launch = FALSE

	var/announce_receipt = FALSE
	var/ar_prompt = tgui_alert(usr, "您要宣布收到信标的消息吗？这将向所有玩家公开求救信标。", "Announce beacon received?", list("Yes", "No"), 20 SECONDS)
	if(ar_prompt == "Yes")
		announce_receipt = TRUE

	var/turf/override_spawn_loc
	var/prompt = tgui_alert(usr, "在其指定出生点生成，还是在您的位置生成？", "Spawnpoint Selection", list("Spawn", "Current Location"), 0)
	if(!prompt)
		qdel(chosen_ert)
		return
	if(prompt == "Current Location")
		override_spawn_loc = get_turf(usr)

	chosen_ert.activate(quiet_launch, announce_receipt, override_spawn_loc)

	message_admins("[key_name_admin(usr)] admin-called a [choice == "Randomize" ? "randomized ":""]distress beacon: [chosen_ert.name]")

/datum/admins/proc/admin_force_evacuation()
	set name = "Trigger Evacuation"
	set desc = "Triggers emergency evacuation."
	set category = "Admin.Events"

	if(!SSticker.mode || !check_rights(R_ADMIN))
		return
	set_security_level(SEC_LEVEL_RED)
	SShijack.initiate_evacuation()

	message_admins("[key_name_admin(usr)] forced an emergency evacuation.")

/datum/admins/proc/admin_cancel_evacuation()
	set name = "Cancel Evacuation"
	set desc = "Cancels emergency evacuation."
	set category = "Admin.Events"

	if(!SSticker.mode || !check_rights(R_ADMIN))
		return
	SShijack.cancel_evacuation()

	message_admins("[key_name_admin(usr)] canceled an emergency evacuation.")

/datum/admins/proc/add_req_points()
	set name = "Add Requisitions Points"
	set desc = "Add points to the ship requisitions department."
	set category = "Admin.Events"
	if(!SSticker.mode || !check_rights(R_ADMIN))
		return

	var/points_to_add = tgui_input_real_number(usr, "Enter the amount of points to give, or a negative number to subtract. 1 point = $100.", "Points", 0)
	if(!points_to_add)
		return
	else if((GLOB.supply_controller.points + points_to_add) < 0)
		GLOB.supply_controller.points = 0
	else if((GLOB.supply_controller.points + points_to_add) > 99999)
		GLOB.supply_controller.points = 99999
	else
		GLOB.supply_controller.points += points_to_add


	message_admins("[key_name_admin(usr)] granted requisitions [points_to_add] points.")
	if(points_to_add >= 0)
		shipwide_ai_announcement("本次行动已获授权额外补给预算。")
	message_admins("[key_name_admin(usr)] granted UPP requisitions [points_to_add] points.")

/datum/admins/proc/add_upp_req_points()
	set name = "Add UPP Requisitions Points"
	set desc = "Add points to the UPP ship requisitions department."
	set category = "Admin.Events"
	if(!SSticker.mode || !check_rights(R_ADMIN))
		return

	var/points_to_add = tgui_input_real_number(usr, "Enter the amount of points to give, or a negative number to subtract. 1 point = $100.", "Points", 0)
	if(!points_to_add)
		return
	else if((GLOB.supply_controller_upp.points + points_to_add) < 0)
		GLOB.supply_controller_upp.points = 0
	else if((GLOB.supply_controller_upp.points + points_to_add) > 99999)
		GLOB.supply_controller_upp.points = 99999
	else
		GLOB.supply_controller.points += points_to_add
	message_admins("[key_name_admin(usr)] granted UPP requisitions [points_to_add] points.")


/datum/admins/proc/check_req_heat()
	set name = "Check Requisitions Heat"
	set desc = "Check how close the CMB is to arriving to search Requisitions."
	set category = "Admin.Events"
	if(!SSticker.mode || !check_rights(R_ADMIN))
		return

	var/req_heat_change = tgui_input_real_number(usr, "Set the new requisitions black market heat. ERT is called at 100, disabled at -1. Current Heat: [GLOB.supply_controller.black_market_heat]", "Modify Req Heat", 0, 100, -1)
	if(!req_heat_change)
		return

	GLOB.supply_controller.black_market_heat = req_heat_change
	message_admins("[key_name_admin(usr)] set requisitions heat to [req_heat_change].")


/datum/admins/proc/admin_force_selfdestruct()
	set name = "Self-Destruct"
	set desc = "Trigger self-destruct countdown. This should not be done if the self-destruct has already been called."
	set category = "Admin.Events"

	if(!SSticker.mode || !check_rights(R_ADMIN) || get_security_level() == "delta")
		return

	if(alert(src, "你确定要执行此操作吗？", "确认", "Yes", "No") != "Yes")
		return

	set_security_level(SEC_LEVEL_DELTA)

	message_admins("[key_name_admin(usr)] admin-started self-destruct system.")

/client/proc/view_faxes()
	set name = "Reply to Faxes"
	set desc = "View faxes from this round."
	set category = "Admin.Events"

	if(!admin_holder)
		return

	var/list/options = list(
		"Weyland-Yutani", "High Command", "宪兵总监", "Press",
		"殖民地执法局", "进步人民联盟",
		"三世界帝国", "殖民地解放阵线",
		"其他", "Cancel")
	var/answer = tgui_input_list(src, "你想查看哪种传真？", "Faxes", options)
	switch(answer)
		if("Weyland-Yutani")
			var/body = "<body>"

			for(var/text in GLOB.WYFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to Weyland-Yutani", "wyfaxviewer", width = 300, height = 600)

		if("High Command")
			var/body = "<body>"

			for(var/text in GLOB.USCMFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to High Command", "uscmfaxviewer", width = 300, height = 600)

		if("宪兵总监")
			var/body = "<body>"

			for(var/text in GLOB.ProvostFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to the Provost Office", "provostfaxviewer", width = 300, height = 600)

		if("Press")
			var/body = "<body>"

			for(var/text in GLOB.PressFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to Press organizations", "pressfaxviewer", width = 300, height = 600)

		if("殖民地执法局")
			var/body = "<body>"

			for(var/text in GLOB.CMBFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to the Colonial Marshal Bureau", "cmbfaxviewer", width = 300, height = 600)

		if("进步人民联盟")
			var/body = "<body>"

			for(var/text in GLOB.UPPFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to the Union of Progressive Peoples", "uppfaxviewer", width = 300, height = 600)

		if("三世界帝国")
			var/body = "<body>"

			for(var/text in GLOB.TWEFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to the Three World Empire", "twefaxviewer", width = 300, height = 600)

		if("殖民地解放阵线")
			var/body = "<body>"

			for(var/text in GLOB.CLFFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Faxes to the Colonial Liberation Front", "clffaxviewer", width = 300, height = 600)

		if("其他")
			var/body = "<body>"

			for(var/text in GLOB.GeneralFaxes)
				body += text
				body += "<br><br>"

			body += "<br><br></body>"
			show_browser(src, body, "Inter-machine Faxes", "otherfaxviewer", width = 300, height = 600)
		if("Cancel")
			return

/client/proc/award_medal()
	if(!check_rights(R_ADMIN))
		return

	give_medal_award(as_admin=TRUE)

/client/proc/award_jelly()
	if(!check_rights(R_ADMIN))
		return

	// Mostly replicated code from observer.dm.hive_status()
	var/list/hives = list()
	var/datum/hive_status/last_hive_checked

	var/datum/hive_status/hive
	for(var/hivenumber in GLOB.hive_datum)
		hive = GLOB.hive_datum[hivenumber]
		if(length(hive.totalXenos) > 0 || length(hive.total_dead_xenos) > 0)
			hives += list("[hive.name]" = hive.hivenumber)
			last_hive_checked = hive

	if(!length(hives))
		to_chat(src, SPAN_ALERT("目前似乎没有巢穴。"))
		return
	else if(length(hives) > 1) // More than one hive, display an input menu for that
		var/faction = tgui_input_list(src, "选择要奖励的巢穴", "Hive Choice", hives, theme="hive_status")
		if(!faction)
			to_chat(src, SPAN_ALERT("巢穴选择错误。中止。"))
			return
		last_hive_checked = GLOB.hive_datum[hives[faction]]

	give_jelly_award(last_hive_checked, as_admin=TRUE)

/client/proc/give_nuke()
	if(!check_rights(R_ADMIN))
		return
	var/nukename = "已解密的行动大片"
	var/encrypt = tgui_alert(src, "是否希望核弹已处于解密状态？", "Nuke Type", list("Encrypted", "Decrypted"), 20 SECONDS)
	if(encrypt == "Encrypted")
		nukename = "加密的行动大片"
	var/prompt = tgui_alert(src, "此操作可用于结束回合。你确定要生成一枚核弹吗？核弹将被放置在ASRS升降机上。", "DEFCON 1", list("Yes", "No"), 30 SECONDS)
	if(prompt != "Yes")
		return

	var/nuketype = GLOB.supply_packs_types[nukename]

	var/datum/supply_order/new_order = new()
	new_order.ordernum = GLOB.supply_controller.ordernum++
	new_order.objects = list(GLOB.supply_packs_datums[nuketype])
	new_order.orderedby = MAIN_AI_SYSTEM
	new_order.approvedby = MAIN_AI_SYSTEM
	GLOB.supply_controller.shoppinglist += new_order

	marine_announcement("一枚核装置已供应，将通过ASRS运送至补给处。", "NUCLEAR ARSENAL ACQUIRED", 'sound/misc/notice2.ogg')
	message_admins("[key_name_admin(usr)] admin-spawned \a [encrypt] nuke.")
	log_game("[key_name_admin(usr)] admin-spawned \a [encrypt] nuke.")

/client/proc/turn_everyone_into_primitives()
	var/random_names = FALSE
	if (alert(src, "是否要为所有人赋予随机编号名称？", "确认", "Yes", "No") == "Yes")
		random_names = TRUE
	if (alert(src, "你确定要执行此操作吗？这会造成卡顿。", "确认", "Yes", "No") != "Yes")
		return
	for(var/mob/living/carbon/human/H in GLOB.human_mob_list)
		if(ismonkey(H))
			continue
		H.set_species(pick("猴子", "伊伦", "斯托克", "法瓦", "尼艾拉"))
		H.is_important = TRUE
		if(random_names)
			var/random_name = "[lowertext(H.species.name)] ([rand(1, 999)])"
			H.change_real_name(H, random_name)
			var/obj/item/card/id/card = H.get_idcard()
			if(card)
				card.registered_name = H.real_name
				card.name = "[card.registered_name]'s [card.id_type] ([card.assignment])"

	message_admins("Admin [key_name(usr)] has turned everyone into a primitive")

/client/proc/force_hijack()
	set name = "Force Hijack"
	set desc = "Force a dropship to be hijacked."
	set category = "Admin.Shuttles"

	var/list/shuttles = list(DROPSHIP_ALAMO, DROPSHIP_NORMANDY)
	var/tag = tgui_input_list(usr, "强制劫持哪架运输机？", "Select a dropship:", shuttles)
	if(!tag)
		return

	var/obj/docking_port/mobile/marine_dropship/dropship = SSshuttle.getShuttle(tag)

	if(!dropship)
		to_chat(src, SPAN_DANGER("错误：尝试强制劫持运输机，但穿梭机数据为空。代码：MSD_FSV_DIN"))
		log_admin("错误：尝试强制劫持运输机，但穿梭机数据为空。代码：MSD_FSV_DIN")
		return

	var/confirm = tgui_alert(usr, "你确定要劫持[dropship]吗？", "Force hijack", list("Yes", "No")) == "Yes"
	if(!confirm)
		return

	var/obj/structure/machinery/computer/shuttle/dropship/flight/computer = dropship.getControlConsole()
	computer.hijack(usr, force = TRUE)

/client/proc/cmd_admin_create_centcom_report()
	set name = "Report: Faction"
	set category = "Admin.Factions"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "只有管理员可以使用此命令。")
		return
	var/faction = tgui_input_list(usr, "请选择你的公告将显示给哪个阵营。", "Faction Selection", (FACTION_LIST_HUMANOID - list(FACTION_YAUTJA) + list("Everyone (-Yautja)")))
	if(!faction)
		return
	var/input = input(usr, "请输入公告文本。请注意，此公告将被阿尔迈耶号及行星地表上所选阵营意识清醒的人类听到。", "什么？", "") as message|null
	if(!input)
		return
	var/customname = input(usr, "为公告选择一个标题。确认输入空文本以使用\"[faction] Update\" title.", "Title") as text|null
	if(isnull(customname))
		return
	if(!customname)
		customname = "[faction] Update"
	if(faction == FACTION_MARINE)
		for(var/obj/structure/machinery/computer/almayer_control/C in GLOB.machines)
			if(!(C.inoperable()))
				var/obj/item/paper/P = new /obj/item/paper( C.loc )
				P.name = "'[customname].'"
				P.info = input
				P.update_icon()
				C.messagetitle.Add("[customname]")
				C.messagetext.Add(P.info)

		if(alert("Press \"Yes\" if you want to announce it to ship crew and marines. Press \"No\" to keep it only as printed report on communication console.",,"Yes","No") == "Yes")
			if(alert("Do you want PMCs (not Death Squad) to see this announcement?",,"Yes","No") == "Yes")
				marine_announcement(input, customname, 'sound/AI/commandreport.ogg', faction, TRUE)
			else
				marine_announcement(input, customname, 'sound/AI/commandreport.ogg', faction, FALSE)
	else
		marine_announcement(input, customname, 'sound/AI/commandreport.ogg', faction)

	message_admins("[key_name_admin(src)] has created \a [faction] command report")
	log_admin("[key_name_admin(src)] [faction] command report: [input]")

/client/proc/cmd_admin_xeno_report()
	set name = "Report: Queen Mother"
	set desc = "Basically a command announcement, but only for selected Xeno's Hive."
	set category = "Admin.Factions"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "只有管理员可以使用此命令。")
		return

	var/list/hives = list()
	for(var/hivenumber in GLOB.hive_datum)
		var/datum/hive_status/hive = GLOB.hive_datum[hivenumber]
		hives += list("[hive.name]" = hive.hivenumber)

	hives += list("All Hives" = "everything")
	var/hive_choice = tgui_input_list(usr, "请选择你希望看到公告的巢穴。选择\"All hives\" option will change title to \"Unknown Higher Force\"", "Hive Selection", hives)
	if(!hive_choice)
		return FALSE

	var/hivenumber = hives[hive_choice]


	var/input = input(usr, "这应该是来自异形种族统治者的信息。", "什么？", "") as message|null
	if(!input)
		return FALSE

	var/hive_prefix = ""
	if(GLOB.hive_datum[hivenumber])
		var/datum/hive_status/hive = GLOB.hive_datum[hivenumber]
		hive_prefix = "[hive.prefix] "

	if(hivenumber == "everything")
		xeno_announcement(input, hivenumber, HIGHER_FORCE_ANNOUNCE)
	else
		xeno_announcement(input, hivenumber, SPAN_ANNOUNCEMENT_HEADER_BLUE("[hive_prefix][QUEEN_MOTHER_ANNOUNCE]"))

	message_admins("[key_name_admin(src)] has created a [hive_choice] Queen Mother report")
	log_admin("[key_name_admin(src)] Queen Mother ([hive_choice]): [input]")

/client/proc/cmd_admin_create_AI_report()
	set name = "Report: ARES Comms"
	set category = "Admin.Factions"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "只有管理员可以使用此命令。")
		return FALSE

	if(!ares_is_active())
		to_chat(usr, SPAN_WARNING("[MAIN_AI_SYSTEM]已被摧毁，无法通话！"))
		return FALSE

	var/input = input(usr, "这是来自舰船AI的标准信息。它使用阿尔迈耶号通用频道，没有阿尔迈耶号通用频道权限（耳机或对讲机）的人类将无法听到。发送前请与在线工作人员确认。不要使用html。", "什么？", "") as message|null
	if(!input)
		return FALSE

	if(!ares_can_interface())
		var/prompt = tgui_alert(src, "ARES接口处理器离线或已摧毁，是否仍要发送信息？", "Choose.", list("Yes", "No"), 20 SECONDS)
		if(prompt == "No")
			to_chat(usr, SPAN_WARNING("[MAIN_AI_SYSTEM]无响应。其接口处理器可能离线或已摧毁。"))
			return FALSE

	ai_announcement(input)
	message_admins("[key_name_admin(src)] has created an AI comms report")
	log_admin("AI comms report: [input]")


/client/proc/cmd_admin_create_AI_apollo_report()
	set name = "Report: ARES Apollo"
	set category = "Admin.Factions"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "只有管理员可以使用此命令。")
		return FALSE

	if(!ares_is_active())
		to_chat(usr, SPAN_WARNING("[MAIN_AI_SYSTEM]已被摧毁，无法通话！"))
		return FALSE

	var/input = tgui_input_text(usr, "这是来自舰船AI对工作乔和维护无人机的广播。不要使用html。", "什么？", "")
	if(!input)
		return FALSE

	if(!ares_can_apollo())
		var/prompt = tgui_alert(src, "ARES APOLLO处理器离线或已摧毁，是否仍要发送信息？", "Choose.", list("Yes", "No"), 20 SECONDS)
		if(prompt != "Yes")
			to_chat(usr, SPAN_WARNING("[MAIN_AI_SYSTEM]无响应。其APOLLO处理器可能离线或已摧毁。"))
			return FALSE

	ares_apollo_talk(input)
	message_admins("[key_name_admin(src)] has created an AI APOLLO report")
	log_admin("AI APOLLO report: [input]")

/client/proc/cmd_admin_create_AI_shipwide_report()
	set name = "Report: ARES Shipwide"
	set category = "Admin.Factions"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "只有管理员可以使用此命令。")
		return
	var/input = input(usr, "这是来自舰船AI的公告类信息。这将向阿尔迈耶号Z层级所有意识清醒的人类广播。请注意，即使ARES断电/被摧毁，此功能仍有效。发送前请与在线工作人员确认。", "什么？", "") as message|null
	if(!input)
		return FALSE
	if(!ares_can_interface())
		var/prompt = tgui_alert(src, "ARES接口处理器离线或已摧毁，是否仍要发送信息？", "Choose.", list("Yes", "No"), 20 SECONDS)
		if(prompt == "No")
			to_chat(usr, SPAN_WARNING("[MAIN_AI_SYSTEM]无响应。其接口处理器可能离线或已摧毁。"))
			return

	shipwide_ai_announcement(input)
	message_admins("[key_name_admin(src)] has created an AI shipwide report")
	log_admin("[key_name_admin(src)] AI shipwide report: [input]")

/client/proc/cmd_admin_create_predator_report()
	set name = "Report: Yautja Overseer"
	set category = "Admin.Factions"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "只有管理员可以使用此命令。")
		return
	var/input = tgui_input_text(usr, "这是来自铁血战士长老监督者的信息。他们并非AI，但他们已通过所有铁血战士（无论生死）的眼睛目睹了本回合发生的一切。此信息将显示在所有存活的铁血战士实体屏幕上。发送前请与在线工作人员确认。", "What Will The Elder Say?")
	if(!input)
		return FALSE
	elder_overseer_message(input, elder_user = "[key_name(src)]")

/client/proc/cmd_admin_world_narrate() // Allows administrators to fluff events a little easier -- TLE
	set name = "Narrate to Everyone"
	set category = "Admin.Events"

	if (!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "只有管理员可以使用此命令。")
		return

	var/msg = input("信息：", text("Enter the text you wish to appear to everyone:")) as text

	if(!msg)
		return

	to_chat_spaced(world, html = SPAN_ANNOUNCEMENT_HEADER_BLUE(msg))
	message_admins("\bold GlobalNarrate: [key_name_admin(usr)] : [msg]")


/client
	var/remote_control = FALSE

/client/proc/toogle_door_control()
	set name = "Toggle Remote Control"
	set category = "Admin.Events"

	if(!check_rights(R_MOD|R_DEBUG))
		return

	remote_control = !remote_control
	message_admins("[key_name_admin(src)] has toggled remote control [remote_control? "on" : "off"] for themselves")

/client/proc/enable_event_mob_verbs()
	set name = "Mob Event Verbs - Show"
	set category = "Admin.Events"

	add_verb(src, GLOB.admin_mob_event_verbs_hideable)
	remove_verb(src, /client/proc/enable_event_mob_verbs)

/client/proc/hide_event_mob_verbs()
	set name = "Mob Event Verbs - Hide"
	set category = "Admin.Events"

	remove_verb(src, GLOB.admin_mob_event_verbs_hideable)
	add_verb(src, /client/proc/enable_event_mob_verbs)

// ----------------------------
// PANELS
// ----------------------------

/datum/admins/proc/event_panel()
	if(!check_rights(R_ADMIN,0))
		return

	var/dat = {"
		<B>Ship</B><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=securitylevel'>Set Security Level</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=distress'>Send a Distress Beacon</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=selfdestruct'>Activate Self-Destruct</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=evacuation_start'>Trigger Evacuation</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=evacuation_cancel'>Cancel Evacuation</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=disable_shuttle_console'>Disable Shuttle Control</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=add_req_points'>Add Requisitions Points</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=add_upp_req_points'>Add UPP Requisitions Points</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=check_req_heat'>Modify Requisitions Heat</A><BR>
		<BR>
		<B>Research</B><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=change_clearance'>Change Research Clearance</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=give_research_credits'>Give Research Credits</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=reroll_contracts'>Reroll Contract Chemicals</A><BR>
		<BR>
		<B>Power</B><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=unpower'>Unpower ship SMESs and APCs</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=power'>Power ship SMESs and APCs</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=quickpower'>Power ship SMESs</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=powereverything'>Power ALL SMESs and APCs everywhere</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=powershipreactors'>Repair and power all ship reactors</A><BR>
		<BR>
		<B>Events</B><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=blackout'>Break all lights</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=whiteout'>Repair all lights</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=comms_blackout'>Trigger a Communication Blackout</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=destructible_terrain'>Toggle destructible terrain</A><BR>
		<BR>
		<B>Misc</B><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=medal'>Award a medal</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=jelly'>Award a royal jelly</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=nuke'>Spawn a nuke</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=pmcguns'>Toggle PMC gun restrictions</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=monkify'>Turn everyone into monkies</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=xenothumbs'>Give or take opposable thumbs and gun permits from xenos</A><BR>
		<A href='byond://?src=\ref[src];[HrefToken()];events=xenocards'>Give or take card playing abilities from xenos</A><BR>
		<BR>
		"}

	show_browser(usr, dat, "Events Panel", "events")
	return

/client/proc/event_panel()
	set name = "Event Panel"
	set category = "Admin.Panels"
	if (admin_holder)
		admin_holder.event_panel()
	return


/datum/admins/proc/chempanel()
	if(!check_rights(R_MOD))
		return

	var/dat
	if(check_rights(R_MOD,0))
		dat += {"<A href='byond://?src=\ref[src];[HrefToken()];chem_panel=view_reagent'>View Reagent</A><br>
				"}
	if(check_rights(R_VAREDIT,0))
		dat += {"<A href='byond://?src=\ref[src];[HrefToken()];chem_panel=view_reaction'>View Reaction</A><br>"}
		dat += {"<A href='byond://?src=\ref[src];[HrefToken()];chem_panel=sync_filter'>Sync Reaction</A><br>
				<br>"}
	if(check_rights(R_SPAWN,0))
		dat += {"<A href='byond://?src=\ref[src];[HrefToken()];chem_panel=spawn_reagent'>Spawn Reagent in Container</A><br>
				<A href='byond://?src=\ref[src];[HrefToken()];chem_panel=make_report'>Make Chem Report</A><br>
				<br>"}
	if(check_rights(R_ADMIN,0))
		dat += {"<A href='byond://?src=\ref[src];[HrefToken()];chem_panel=create_random_reagent'>Generate Reagent</A><br>
				<br>
				<A href='byond://?src=\ref[src];[HrefToken()];chem_panel=create_custom_reagent'>Create Custom Reagent</A><br>
				<A href='byond://?src=\ref[src];[HrefToken()];chem_panel=create_custom_reaction'>Create Custom Reaction</A><br>
				"}

	show_browser(usr, dat, "Chem Panel", "chempanel", width = 210, height = 300)
	return

/client/proc/chem_panel()
	set name = "Chem Panel"
	set category = "Admin.Panels"
	if(admin_holder)
		admin_holder.chempanel()
	return

/datum/admins/var/create_humans_html = null
/datum/admins/proc/create_humans(mob/user)
	if(!GLOB.equipment_presets.categories["All"])
		return

	if(!create_humans_html)
		var/equipment_presets = jointext(GLOB.equipment_presets.categories["All"], ";")
		create_humans_html = file2text('html/create_humans.html')
		create_humans_html = replacetext(create_humans_html, "null /* object types */", "\"[equipment_presets]\"")
		create_humans_html = replacetext(create_humans_html, "/* href token */", RawHrefToken(forceGlobal = TRUE))

	show_browser(user, replacetext(create_humans_html, "/* ref src */", "\ref[src]"), "Create Humans", "create_humans", width = 450, height = 720)

/client/proc/create_humans()
	set name = "Create Humans"
	set category = "Admin.Events"
	if(admin_holder)
		admin_holder.create_humans(usr)

/datum/admins/var/create_xenos_html = null
/datum/admins/proc/create_xenos(mob/user)
	if(!create_xenos_html)
		var/hive_types = jointext(ALL_XENO_HIVES, ";")
		var/xeno_types = jointext(ALL_XENO_CASTES, ";")
		create_xenos_html = file2text('html/create_xenos.html')
		create_xenos_html = replacetext(create_xenos_html, "null /* hive paths */", "\"[hive_types]\"")
		create_xenos_html = replacetext(create_xenos_html, "null /* xeno paths */", "\"[xeno_types]\"")
		create_xenos_html = replacetext(create_xenos_html, "/* href token */", RawHrefToken(forceGlobal = TRUE))

	show_browser(user, replacetext(create_xenos_html, "/* ref src */", "\ref[src]"), "Create Xenos", "create_xenos", width = 450, height = 630)

/client/proc/create_xenos()
	set name = "Create Xenos"
	set category = "Admin.Events"
	if(admin_holder)
		admin_holder.create_xenos(usr)

/client/proc/clear_mutineers()
	set name = "Clear All Mutineers"
	set category = "Admin.Events"
	if(admin_holder)
		admin_holder.clear_mutineers()
	return

/datum/admins/proc/clear_mutineers()
	if(!check_rights(R_MOD))
		return

	if(alert(usr, "你确定要将所有叛变者恢复为正常状态吗？", "确认", "Yes", "No") != "Yes")
		return

	for(var/mob/living/carbon/human/H in GLOB.human_mob_list)
		if(H.mob_flags & MUTINY_MUTINEER)
			H.mob_flags &= ~MUTINY_MUTINEER

			for(var/datum/action/human_action/activable/mutineer/A in H.actions)
				A.remove_from(H)

		H.mob_flags &= ~MUTINY_LOYALIST
		H.mob_flags &= ~MUTINY_NONCOMBAT
		H.hud_set_squad()

/client/proc/cmd_fun_fire_ob()
	set category = "Admin.Fun"
	set desc = "Fire an OB warhead at your current location."
	set name = "Fire OB"

	if(!check_rights(R_ADMIN))
		return

	var/list/firemodes = list("Standard Warhead", "Custom HE", "Custom Cluster", "Custom Incendiary")
	var/mode = tgui_input_list(usr, "选择开火模式：", "Fire mode", firemodes)
	// Select the warhead.
	var/obj/structure/ob_ammo/warhead/warhead
	var/statsmessage
	var/custom = TRUE
	switch(mode)
		if("Standard Warhead")
			custom = FALSE
			var/list/warheads = subtypesof(/obj/structure/ob_ammo/warhead/)
			var/choice = tgui_input_list(usr, "选择弹头类型：", "Warhead to use", warheads)
			if(!choice)
				return
			warhead = new choice
		if("Custom HE")
			var/obj/structure/ob_ammo/warhead/explosive/OBShell = new
			OBShell.name = input("What name should the warhead have?", "设定名称", "HE orbital warhead")
			if(!OBShell.name)
				return//null check to cancel
			OBShell.clear_power = tgui_input_number(src, "清障爆炸的威力应设为多少？", "Set clear power", 1200, 3000)
			if(isnull(OBShell.clear_power))
				return
			OBShell.clear_falloff = tgui_input_number(src, "清障爆炸的威力衰减应设为多少？", "Set clear falloff", 400)
			if(isnull(OBShell.clear_falloff))
				return
			OBShell.standard_power = tgui_input_number(src, "主爆炸的威力应设为多少？", "Set blast power", 600, 3000)
			if(isnull(OBShell.standard_power))
				return
			OBShell.standard_falloff = tgui_input_number(src, "主爆炸的威力衰减应设为多少？", "Set blast falloff", 30)
			if(isnull(OBShell.standard_falloff))
				return
			OBShell.clear_delay = tgui_input_number(src, "清障爆炸的延迟应设为多少？", "Set clear delay", 3)
			if(isnull(OBShell.clear_delay))
				return
			OBShell.double_explosion_delay = tgui_input_number(src, "清障爆炸的延迟应设为多少？", "Set clear delay", 6)
			if(isnull(OBShell.double_explosion_delay))
				return
			statsmessage = "Custom HE OB ([OBShell.name]) Stats from [key_name(usr)]: Clear Power: [OBShell.clear_power], Clear Falloff: [OBShell.clear_falloff], Clear Delay: [OBShell.clear_delay], Blast Power: [OBShell.standard_power], Blast Falloff: [OBShell.standard_falloff], Blast Delay: [OBShell.double_explosion_delay]."
			warhead = OBShell
		if("Custom Cluster")
			var/obj/structure/ob_ammo/warhead/cluster/OBShell = new
			OBShell.name = input("What name should the warhead have?", "设定名称", "Cluster orbital warhead")
			if(!OBShell.name)
				return//null check to cancel
			OBShell.total_amount = tgui_input_number(src, "应发射多少轮齐射？", "Set cluster number", 60)
			if(isnull(OBShell.total_amount))
				return
			OBShell.instant_amount = tgui_input_number(src, "每轮齐射多少发？（最多10发）", "Set shot count", 3)
			if(isnull(OBShell.instant_amount))
				return
			if(OBShell.instant_amount > 10)
				OBShell.instant_amount = 10
			OBShell.explosion_power = tgui_input_number(src, "爆炸的威力应设为多少？", "Set blast power", 300, 1500)
			if(isnull(OBShell.explosion_power))
				return
			OBShell.explosion_falloff = tgui_input_number(src, "爆炸的威力衰减应设为多少？", "Set blast falloff", 150)
			if(isnull(OBShell.explosion_falloff))
				return
			statsmessage = "Custom Cluster OB ([OBShell.name]) Stats from [key_name(usr)]: Salvos: [OBShell.total_amount], Shot per Salvo: [OBShell.instant_amount], Explosion Power: [OBShell.explosion_power], Explosion Falloff: [OBShell.explosion_falloff]."
			warhead = OBShell
		if("Custom Incendiary")
			var/obj/structure/ob_ammo/warhead/incendiary/OBShell = new
			OBShell.name = input("What name should the warhead have?", "设定名称", "Incendiary orbital warhead")
			if(!OBShell.name)
				return//null check to cancel
			OBShell.clear_power = tgui_input_number(src, "清障爆炸的威力应设为多少？", "Set clear power", 1200, 3000)
			if(isnull(OBShell.clear_power))
				return
			OBShell.clear_falloff = tgui_input_number(src, "清障爆炸的威力衰减应设为多少？", "Set clear falloff", 400)
			if(isnull(OBShell.clear_falloff))
				return
			OBShell.clear_delay = tgui_input_number(src, "清障爆炸的延迟应设为多少？", "Set clear delay", 3)
			if(isnull(OBShell.clear_delay))
				return
			OBShell.distance = tgui_input_number(src, "火焰半径应为多少格？（最多30格）", "Set fire radius", 18, 30)
			if(isnull(OBShell.distance))
				return
			if(OBShell.distance > 30)
				OBShell.distance = 30
			OBShell.fire_level = tgui_input_number(src, "火焰应持续多久？", "Set fire duration", 70)
			if(isnull(OBShell.fire_level))
				return
			OBShell.burn_level = tgui_input_number(src, "火焰的伤害应设为多少？", "Set fire strength", 80)
			if(isnull(OBShell.burn_level))
				return
			var/list/firetypes = list("white","blue","red","green","custom")
			OBShell.fire_type = tgui_input_list(usr, "选择火焰颜色：", "Fire color", firetypes)
			if(isnull(OBShell.fire_type))
				return
			OBShell.fire_color = null
			if(OBShell.fire_type == "custom")
				OBShell.fire_type = "dynamic"
				OBShell.fire_color = input(src, "请选择火焰颜色。", "Fire color") as color|null
				if(isnull(OBShell.fire_color))
					return
			statsmessage = "Custom Incendiary OB ([OBShell.name]) Stats from [key_name(usr)]: Clear Power: [OBShell.clear_power], Clear Falloff: [OBShell.clear_falloff], Clear Delay: [OBShell.clear_delay], Fire Distance: [OBShell.distance], Fire Duration: [OBShell.fire_level], Fire Strength: [OBShell.burn_level]."
			warhead = OBShell

	if(custom)
		if(!warhead)
			return
		if(alert(usr, statsmessage, "Confirm Stats", "Yes", "No") != "Yes")
			qdel(warhead)
			return
		message_admins(statsmessage)

	var/turf/target = get_turf(usr.loc)

	if(alert(usr, "发射还是生成弹头？", "Mode", "Fire", "Spawn") == "Fire")
		if(alert("Are you SURE you want to do this? It will create an OB explosion!",, "Yes", "No") != "Yes")
			qdel(warhead)
			return

		message_admins("[key_name(usr)] has fired \an [warhead.name] at ([target.x],[target.y],[target.z]).")
		warhead.warhead_impact(target, warhead)

	else
		warhead.forceMove(target)

/client/proc/change_taskbar_icon()
	set name = "Set Taskbar Icon"
	set desc = "Change the taskbar icon to a preset list of selectable icons."
	set category = "Admin.Events"

	if(!check_rights(R_ADMIN))
		return

	var/taskbar_icon = tgui_input_list(usr, "选择你想显示在玩家任务栏上的图标。", "Taskbar Icon", GLOB.available_taskbar_icons)
	if(!taskbar_icon)
		return

	SSticker.mode.taskbar_icon = taskbar_icon
	SSticker.set_clients_taskbar_icon(taskbar_icon)
	message_admins("[key_name_admin(usr)] has changed the taskbar icon to [taskbar_icon].")

/client/proc/change_weather()
	set name = "Change Weather"
	set category = "Admin.Events"

	if(!check_rights(R_EVENT))
		return

	if(!SSweather.map_holder)
		to_chat(src, SPAN_WARNING("此地图无天气数据。"))
		return

	if(SSweather.is_weather_event_starting)
		to_chat(src, SPAN_WARNING("天气事件已在启动中，请稍候。"))
		return

	if(SSweather.is_weather_event)
		if(tgui_alert(src, "天气事件正在进行中！是否结束？", "确认", list("End", "Continue"), 10 SECONDS) == "Continue")
			return
		if(SSweather.is_weather_event)
			SSweather.end_weather_event()

	var/list/mappings = list()
	for(var/datum/weather_event/typepath as anything in subtypesof(/datum/weather_event))
		mappings[initial(typepath.name)] = typepath
	var/chosen_name = tgui_input_list(src, "选择要启动的天气事件", "Weather Selector", mappings)
	var/chosen_typepath = mappings[chosen_name]
	if(!chosen_typepath)
		return

	var/retval = SSweather.setup_weather_event(chosen_typepath)
	if(!retval)
		to_chat(src, SPAN_WARNING("当前无法启动天气事件！"))
		return
	to_chat(src, SPAN_BOLDNOTICE("成功！天气事件将很快开始。"))


/client/proc/cmd_admin_create_bioscan()
	set name = "Report: Bioscan"
	set category = "Admin.Factions"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "只有管理员可以使用此命令。")
		return

	var/choice = tgui_alert(usr, "你确定要触发生物扫描吗？", "Bioscan?", list("Yes", "No"))
	if(choice != "Yes")
		return
	else
		var/faction = tgui_input_list(usr, "你希望为哪个阵营提供生物扫描？", "Bioscan Faction", list("Xeno","陆战队员","铁血战士"), 20 SECONDS)
		var/variance = tgui_input_number(usr, "你希望扫描结果的误差范围是多少？（在真实值基础上增减）", "Variance", 2, 10, 0, 20 SECONDS)
		message_admins("BIOSCAN: [key_name(usr)] admin-triggered a bioscan for [faction].")
		GLOB.bioscan_data.get_scan_data()
		switch(faction)
			if("Xeno")
				GLOB.bioscan_data.qm_bioscan(variance)
			if("陆战队员")
				var/force_status = FALSE
				if(!ares_can_interface()) //proc checks if ARES is dead or if ARES cannot do announcements
					var/force_check = tgui_alert(usr, "ARES目前无法正常显示和/或执行生物扫描，你是否要强制ARES显示生物扫描？", "Display force", list("Yes", "No"), 20 SECONDS)
					if(force_check == "Yes")
						force_status = TRUE
				GLOB.bioscan_data.ares_bioscan(force_status, variance)
			if("铁血战士")
				GLOB.bioscan_data.yautja_bioscan()

/client/proc/admin_blurb()
	set name = "Global Blurb Message"
	set category = "Admin.Events"

	if(!check_rights(R_ADMIN|R_DEBUG))
		return FALSE
	var/duration = 5 SECONDS
	var/message = "ADMIN TEST"
	var/text_input = tgui_input_text(usr, "通告信息", "Message Contents", message, timeout = 5 MINUTES)
	if(!text_input)
		return // Early return here so people don't have to go through the whole process just to cancel it.
	message = text_input
	duration = tgui_input_number(usr, "设置警报持续时间（十分之一秒）。", "Duration", 5 SECONDS, 5 MINUTES, 5 SECONDS, 20 SECONDS)
	var/confirm = tgui_alert(usr, "你确定要向所有玩家发送‘[message]’信息，持续[(duration / 10)]秒吗？", "确认", list("Yes", "No"), 20 SECONDS)
	if(confirm != "Yes")
		return FALSE
	show_blurb(GLOB.player_list, duration, message, TRUE, "center", "center", "#bd2020", "ADMIN")
	message_admins("[key_name(usr)] sent an admin blurb alert to all players. Alert reads: '[message]' and lasts [(duration / 10)] seconds.")

/client/proc/setup_delayed_event_spawns()
	set name = "Setup Delayed Event Spawns"
	set desc = "Trigger setup for any midround placed event mob spawners."
	set category = "Admin.Events"

	if(!admin_holder)
		return FALSE

	if(!SSticker?.mode)
		to_chat(src, SPAN_WARNING("游戏尚未开始！"))
		return FALSE

	if(!length(GLOB.event_mob_landmarks_delayed))
		return FALSE

	var/count = 0
	for(var/obj/effect/landmark/event_mob_spawn/spawner in GLOB.event_mob_landmarks_delayed)
		spawner.handle_setup()
		count++

	to_chat(src, SPAN_NOTICE("设置[count]个地标。"))
	return TRUE
