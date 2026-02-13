GLOBAL_LIST_EMPTY(vox_types)

/proc/play_sound_vox(sentence, list/players, list/vox, client/user, volume = 100)
	if(!islist(players))
		players = list(players)

	// Need to separate these so that they can be distinguished
	sentence = replacetext(sentence, ".", " .")
	sentence = replacetext(sentence, ",", " ,")

	var/list/sounds = list()
	var/list/bad_words = list()
	for(var/word in splittext(lowertext(sentence), " "))
		if(!(word in vox))
			bad_words += word
			continue

		var/sound_file = vox[word]
		sounds += sound_file

	if(user && length(bad_words))
		var/missed_words = jointext(bad_words, ", ")
		to_chat(user, SPAN_WARNING("找不到以下声音文件：[missed_words]"))

	for(var/s in sounds)
		var/sound/S = sound(s, wait=TRUE, channel=SOUND_CHANNEL_VOX, volume=volume)
		S.status=SOUND_STREAM
		for(var/c in players)
			var/client/C = c
			if(C.prefs.hear_vox)
				sound_to(c, S)

/client/proc/cmd_admin_vox_panel()
	set name = "VOX: Panel"
	set category = "Admin.Panels"

	if(!admin_holder || !(admin_holder.rights & R_SOUNDS))
		to_chat(src, "只有管理员可以使用此命令。")
		return

	GLOB.vox_panel.tgui_interact(mob)
