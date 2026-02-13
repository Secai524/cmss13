/datum/admins/proc/change_ground_map()
	set category = "Server"
	set name = "M: Change Ground Map"

	if(!check_rights(R_SERVER))
		return

	var/list/maprotatechoices = list()
	for(var/map in config.maplist[GROUND_MAP])
		var/datum/map_config/VM = config.maplist[GROUND_MAP][map]
		var/mapname = VM.map_name
		if(VM == config.defaultmaps[GROUND_MAP])
			mapname += " (Default)"

		if(VM.config_min_users > 0 || VM.config_max_users > 0)
			mapname += " \["
			if(VM.config_min_users > 0)
				mapname += "[VM.config_min_users]"
			else
				mapname += "0"
			mapname += "-"
			if(VM.config_max_users > 0)
				mapname += "[VM.config_max_users]"
			else
				mapname += "inf"
			mapname += "\]"

		maprotatechoices[mapname] = VM

	var/chosenmap = tgui_input_list(usr, "选择要切换的地面地图", "Change Ground Map", maprotatechoices)
	if(!chosenmap)
		return

	var/datum/map_config/VM = maprotatechoices[chosenmap]
	if(!SSmapping.changemap(VM, GROUND_MAP))
		to_chat(usr, SPAN_WARNING("更改地面地图失败。"))
		return

	log_admin("[key_name(usr)] changed the map to [VM.map_name].")
	message_admins("[key_name_admin(usr)] changed the map to [VM.map_name].")

/datum/admins/proc/vote_ground_map()
	set category = "Server"
	set name = "M: Start Ground Map Vote"

	if(!check_rights(R_SERVER))
		return

	SSvote.initiate_vote("groundmap", usr.ckey)
	log_admin("[key_name(usr)] started a groundmap vote.")
	message_admins("[key_name_admin(usr)] started a groundmap vote.")

/datum/admins/proc/override_ground_map()
	set category = "Server"
	set name = "M: Override Next Map"

	if(!check_rights(R_SERVER))
		return

	var/map_type = tgui_alert(usr, "覆盖舰船地图还是地面地图？", "Map selection", list(GROUND_MAP, SHIP_MAP, "Cancel"))
	if(map_type == "Cancel")
		return

	var/map = input(usr, "选择下一回合要运行的自定义地图","Upload Map") as null|file
	if(!map)
		return
	if(copytext("[map]", -4) != ".dmm")//4 == length(".dmm")
		to_chat(usr,  SPAN_WARNING("文件名必须以'.dmm'结尾：[map]"), confidential = TRUE)
		return

	message_admins(SPAN_ADMINNOTICE("[key_name_admin(usr)] is overriding the next '[map_type]' map with a custom one."))
	fcopy(map, "data/[OVERRIDE_MAPS_TO_FILENAME[map_type]]")
	if(tgui_alert(usr, "你想上传自定义地图配置还是使用默认配置？配置控制幸存者、猴子类型、伪装、背景信息、地图物品、噩梦模式、特殊环境特征等内容...", "Map Config Flavor", list("默认", "Override")) == "Override")
		tgui_alert(usr, "为下一回合选择自定义地图配置。请确保其有效。它必须包含\"override_map\":true !", "Warning", list("OK!"))
		var/map_config = input(usr, "选择要上传的自定义地图配置", "Upload Map Config") as null|file
		if(map_config)
			var/parse_check = json_decode(file2text(map_config))
			if(parse_check && parse_check["override_map"])
				fcopy(map_config, MAP_TO_FILENAME[map_type])
				tgui_alert(usr, "完成，正在使用上传的地图配置。使用此功能时，务必在回合开始时检查地图是否正确加载。通过地图投票或使用指令投票更改地图将撤销这些更改。祝你好运！", "One little thing...", list("OK"))
				message_admins(SPAN_ADMINNOTICE("[key_name_admin(usr)] overrode next '[map_type]' map with '[map]' and '[map_config]' for settings."))
				return
		to_chat(usr, SPAN_ADMINNOTICE("无法检索地图配置文件或文件无效，正在使用默认配置。"))

	fcopy(OVERRIDE_DEFAULT_MAP_CONFIG[map_type], MAP_TO_FILENAME[map_type])
	tgui_alert(usr, "完成，正在使用默认地图配置（'未知'地图）。使用此功能时，务必在回合开始时检查地图是否正确加载。通过地图投票或使用指令投票更改地图将撤销这些更改。祝你好运！", "One little thing...", list("OK"))
	message_admins(SPAN_ADMINNOTICE("[key_name_admin(usr)] overrode next '[map_type]' map with '[map]' and default settings."))

/datum/admins/proc/change_ship_map()
	set category = "Server"
	set name = "M: Change Ship Map"

	if(!check_rights(R_SERVER))
		return

	var/list/maprotatechoices = list()
	for(var/map in config.maplist[SHIP_MAP])
		var/datum/map_config/VM = config.maplist[SHIP_MAP][map]
		var/mapname = VM.map_name
		if(VM == config.defaultmaps[SHIP_MAP])
			mapname += " (Default)"

		if(VM.config_min_users > 0 || VM.config_max_users > 0)
			mapname += " \["
			if(VM.config_min_users > 0)
				mapname += "[VM.config_min_users]"
			else
				mapname += "0"
			mapname += "-"
			if(VM.config_max_users > 0)
				mapname += "[VM.config_max_users]"
			else
				mapname += "inf"
			mapname += "\]"

		maprotatechoices[mapname] = VM

	var/chosenmap = tgui_input_list(usr, "选择要切换的舰船地图", "Change Ship Map", maprotatechoices)
	if(!chosenmap)
		return

	var/datum/map_config/VM = maprotatechoices[chosenmap]
	if(!SSmapping.changemap(VM, SHIP_MAP))
		to_chat(usr, SPAN_WARNING("更改舰船地图失败。"))
		return

	log_admin("[key_name(usr)] changed the ship map to [VM.map_name].")
	message_admins("[key_name_admin(usr)] changed the ship map to [VM.map_name].")

/datum/admins/proc/prep_events()
	set category = "Server"
	set name = "M: Prepare Events"

	var/list/maprotatechoices = list()
	var/datum/map_config/VM
	var/chosenmap
	var/list/mode_list

	if(!check_rights(R_SERVER))
		return

	message_admins("[key_name_admin(usr)] has run the prep_events verb.")
//
	var/accept = tgui_alert(usr, "你确定要准备事件吗？这将重启服务器！！！！同时会改变当前的主模式！！！！", "Prepare Events", list("Yes", "No"))
	if(accept != "Yes")
		return
//
	mode_list = config.modes
	mode_list += "Cancel"
	var/modeset = tgui_input_list(usr, "当前模式：[GLOB.master_mode]", "Mode Selection", mode_list)

// Override ground map
	var/accept_mapchange = tgui_alert(usr, "你希望更改下一个地面地图吗？", "Prepare Events", list("Yes", "No"))
	if(accept_mapchange == "Yes")
		for(var/map in config.maplist[GROUND_MAP])
			VM = config.maplist[GROUND_MAP][map]
			var/mapname = VM.map_name
			if(VM == config.defaultmaps[GROUND_MAP])
				mapname += " (Default)"

			if(VM.config_min_users > 0 || VM.config_max_users > 0)
				mapname += " \["
				if(VM.config_min_users > 0)
					mapname += "[VM.config_min_users]"
				else
					mapname += "0"
				mapname += "-"
				if(VM.config_max_users > 0)
					mapname += "[VM.config_max_users]"
				else
					mapname += "inf"
				mapname += "\]"

			maprotatechoices[mapname] = VM

		chosenmap = tgui_input_list(usr, "选择要切换的地面地图", "Change Ground Map", maprotatechoices)

		if(!chosenmap)
			to_chat(usr, SPAN_WARNING("选择地面地图失败，中止更改并重启。"))
			return

// All changes should happen here incase of failure
	//Change gamemode
	if(modeset != "Cancel" && !!modeset)
		GLOB.master_mode = modeset
		message_admins("[key_name_admin(usr)] set the mode as [GLOB.master_mode] via event prep.")
		to_world(SPAN_NOTICE("<b><i>The mode for next round is: [GLOB.master_mode]!</i></b>"))
		SSticker.save_mode(GLOB.master_mode)

	//Change map
	if(chosenmap)
		VM = maprotatechoices[chosenmap]
		log_admin("[key_name(usr)] changed the map to [VM.map_name].")
		message_admins("[key_name_admin(usr)] changed the map to [VM.map_name].")

		if(!SSmapping.changemap(VM, GROUND_MAP))
			to_chat(usr, SPAN_WARNING("更改地面地图失败，中止更改并重启。"))
			return

//	Restarts the world provided no issues occur above.
	log_admin("[key_name(usr)] initiated a reboot.")
	sleep(100)
	world.Reboot()
