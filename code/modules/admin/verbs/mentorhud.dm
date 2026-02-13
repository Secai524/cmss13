/client/proc/toggle_newplayer_ghost_hud()
	set name = "Toggle Markers (Ghost)"
	set category = "Admin.Mentor"
	set desc = "Toggles observer pref for mentor markers."

	if(!admin_holder || !(admin_holder.rights & R_MENTOR))
		to_chat(src, "只有导师可以使用此HUD！")
		return FALSE

	prefs.observer_huds[HUD_MENTOR_SIGHT] = !prefs.observer_huds[HUD_MENTOR_SIGHT]
	prefs.save_preferences()

	to_chat(src, SPAN_BOLDNOTICE("你将[HUD_MENTOR_SIGHT]切换为[prefs.observer_huds[HUD_MENTOR_SIGHT] ? "ON" : "OFF"] by default when you are observer."))

	if(!isobserver(usr))
		return
	var/mob/dead/observer/observer_user = usr
	var/datum/mob_hud/the_hud
	the_hud = GLOB.huds[MOB_HUD_NEW_PLAYER]

	observer_user.HUD_toggled[HUD_MENTOR_SIGHT] = prefs.observer_huds[HUD_MENTOR_SIGHT]
	if(observer_user.HUD_toggled[HUD_MENTOR_SIGHT])
		the_hud.add_hud_to(observer_user, observer_user)
	else
		the_hud.remove_hud_from(observer_user, observer_user)

/client/proc/toggle_newplayer_ic_hud(sea_forced = FALSE)
	set category = "Admin.Mentor"
	set name = "Toggle Markers (IC)"
	set desc = "Toggles new player HUD while IC."

	if(!admin_holder || !(admin_holder.rights & R_MENTOR))
		if(!sea_forced)
			to_chat(src, "只有导师可以使用此HUD！")
		return FALSE

	var/mob/living/carbon/human/mentor = mob
	if(!ishuman(mentor))
		to_chat(src, SPAN_WARNING("作为非人类，你无法使用此能力！"))
		return FALSE

	if(!mentor.looc_overhead && !(mentor.inherent_huds_toggled[INHERENT_HUD_NEW_PLAYER]))
		to_chat(src, SPAN_WARNING("你不在导师职位中！（头顶LOOC已禁用！）"))
		return FALSE

	var/datum/mob_hud/the_hud
	the_hud = GLOB.huds[MOB_HUD_NEW_PLAYER]

	if(mentor.inherent_huds_toggled[INHERENT_HUD_NEW_PLAYER])
		mentor.inherent_huds_toggled[INHERENT_HUD_NEW_PLAYER] = FALSE
		the_hud.remove_hud_from(mentor, mentor)
		to_chat(mentor, SPAN_INFO("<B>新玩家标记已禁用</B>"))
	else
		mentor.inherent_huds_toggled[INHERENT_HUD_NEW_PLAYER] = TRUE
		the_hud.add_hud_to(mentor, mentor)
		to_chat(mentor, SPAN_INFO("<B>新玩家标记已启用</B>"))
	return TRUE
