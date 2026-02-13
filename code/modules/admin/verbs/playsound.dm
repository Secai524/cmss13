/client/proc/play_admin_sound()
	set category = "Admin.Fun"
	set name = "Play Admin Sound"
	if(!check_rights(R_SOUNDS))
		return

	var/sound_mode = tgui_input_list(src, "播放哪个来源的声音？", "Select Source", list("Web", "Upload"))
	if(!sound_mode)
		return

	var/list/data = list()
	var/log_title = TRUE
	var/web_sound_input
	var/asset_name
	var/must_send_assets = FALSE
	var/announce_title = TRUE

	if(sound_mode == "Web")
		var/list/datum/internet_media/media_players = list()

		if(CONFIG_GET(string/invoke_youtubedl))
			media_players += new /datum/internet_media/yt_dlp

		if(CONFIG_GET(string/cobalt_base_api))
			media_players += new /datum/internet_media/cobalt

		if(!length(media_players))
			to_chat(src, SPAN_BOLDWARNING("你的服务器主机未设置任何网络媒体播放器。"))
			return

		web_sound_input = input("Enter content URL (supported sites only)", "播放网络声音") as text|null
		if(!istext(web_sound_input) || !length(web_sound_input))
			return

		web_sound_input = trim(web_sound_input)

		var/datum/media_response/response
		for(var/datum/internet_media/player as anything in media_players)
			response = player.get_media(web_sound_input)

			if(istype(response))
				break

		if(!istype(response))
			to_chat(src, SPAN_BOLDWARNING("所有配置的网络媒体播放器均未能提供有效响应："))
			for(var/datum/internet_media/player as anything in media_players)
				to_chat(src, SPAN_WARNING("[player.type] 错误：[player.error]"))
			return

		data = response.get_list()

	else if(sound_mode == "Upload")
		var/current_transport = CONFIG_GET(string/asset_transport)
		if(!current_transport || current_transport == "simple")
			if(tgui_alert(usr, "警告：你的服务器正在使用简单资源传输。声音将必须直接发送给玩家，这可能导致游戏长时间卡顿。你确定吗？", "Really play direct sound?", list("Yes", "No")) != "Yes")
				return
			must_send_assets = TRUE

		var/soundfile = input(usr, "选择要播放的音频文件", "Upload Sound") as null|file
		if(!soundfile)
			return

		var/static/regex/only_extension = regex(@{"^.*\.([a-z0-9]{1,5})$"}, "gi")
		var/extension = only_extension.Replace("[soundfile]", "$1")
		if(!length(extension))
			to_chat(src, SPAN_WARNING("无效的文件扩展名。"))
			return

		var/static/playsound_notch = 1
		asset_name = "admin_sound_[playsound_notch++].[extension]"
		SSassets.transport.register_asset(asset_name, soundfile)
		message_admins("[key_name_admin(src)] uploaded admin sound '[soundfile]' to asset transport.")

		var/static/regex/remove_extension = regex(@{"\.[a-z0-9]+$"}, "gi")
		data["title"] = remove_extension.Replace("[soundfile]", "")
		data["url"] = SSassets.transport.get_asset_url(asset_name)
		web_sound_input = "[soundfile]"
		log_title = FALSE

	var/title
	var/web_sound_url = ""
	var/list/music_extra_data = list()
	if(data["url"])
		music_extra_data["link"] = data["url"]
		web_sound_url = data["url"]
		music_extra_data["start"] = data["start_time"]
		music_extra_data["end"] = data["end_time"]

		if(isnull(data["title"]))
			data["title"] = tgui_input_text(src, "此媒体的标题是什么？", "Media Title")
		title = data["title"]
		music_extra_data["title"] = data["title"]

	if(!must_send_assets && web_sound_url && !findtext(web_sound_url, GLOB.is_http_protocol))
		to_chat(src, SPAN_BOLDWARNING("已阻止：内容URL未使用HTTP(S)协议。"), confidential = TRUE)
		to_chat(src, SPAN_WARNING("媒体提供商返回的内容URL未使用HTTP或HTTPS协议。"), confidential = TRUE)
		return


	switch(tgui_alert(src, "向玩家显示此音频的名称？", "Sound Name", list("Yes","No","Cancel")))
		if("No")
			music_extra_data["title"] = "Admin sound"
			announce_title = FALSE
		if("Cancel")
			return

	var/list/targets = list()
	var/list/sound_type_list = list(
		"Meme" = SOUND_ADMIN_MEME,
		"Atmospheric" = SOUND_ADMIN_ATMOSPHERIC
	)

	var/style = tgui_input_list(src, "你想向谁播放？", "Select Listeners", list("Globally", "Xenos", "Marines", "Ghosts", "All In View Range", "Single Mob"))
	var/sound_type = tgui_input_list(src, "这是什么类型的音频？", "Select Sound Type", sound_type_list)
	sound_type = sound_type_list[sound_type]

	switch(style)
		if("Globally")
			targets = GLOB.mob_list
		if("Xenos")
			targets = GLOB.xeno_mob_list + GLOB.dead_mob_list
		if("Marines")
			targets = GLOB.human_mob_list + GLOB.dead_mob_list
		if("Ghosts")
			targets = GLOB.observer_list + GLOB.dead_mob_list
		if("All In View Range")
			var/list/atom/ranged_atoms = long_range(usr.client.view, get_turf(usr))
			for(var/mob/receiver in ranged_atoms)
				targets += receiver
		if("Single Mob")
			var/list/mob/all_mobs = sortmobs()
			var/list/mob/all_client_mobs = list()
			for(var/mob/mob in all_mobs)
				if(mob.client)
					all_client_mobs += mob
			var/mob/choice = tgui_input_list(src, "选择播放目标：","Select Mob", all_client_mobs)
			if(QDELETED(choice))
				return
			targets.Add(choice)
		else
			return

	for(var/mob/mob as anything in targets)
		var/client/client = mob?.client
		if((client?.prefs?.toggles_sound & SOUND_MIDI) && (client?.prefs?.toggles_sound & sound_type))
			if(must_send_assets)
				SSassets.transport.send_assets(client, asset_name)
			client?.tgui_panel?.play_music(web_sound_url, music_extra_data)
			if(announce_title)
				to_chat(client, SPAN_BOLDANNOUNCE("管理员播放了：[music_extra_data["title"]]"), confidential = TRUE)
		else
			client?.tgui_panel?.stop_music()

	log_admin("[key_name(src)] played admin sound: [web_sound_input] -[log_title ? " [title] -" : ""] [style]")
	message_admins("[key_name_admin(src)] played admin sound: [web_sound_input] -[log_title ? " [title] -" : ""] [style]")

/client/proc/stop_admin_sound()
	set category = "Admin.Fun"
	set name = "Stop Admin Sounds"

	if(!check_rights(R_SOUNDS))
		return

	for(var/i in GLOB.clients)
		var/client/C = i
		C.tgui_panel.stop_music()

	log_admin("[key_name(src)] stopped the currently playing web sounds.")
	message_admins("[key_name_admin(src)] stopped the currently playing web sounds.")

