//toggles
/client/proc/toggle_hear_radio()
	set name = "Show/Hide Radio Chatter"
	set category = "Preferences.Chat"
	set desc = "Toggle seeing radio chatter from radios and speakers."
	if(!admin_holder)
		return
	prefs.toggles_chat ^= CHAT_RADIO
	prefs.save_preferences()
	to_chat(usr, SPAN_BOLDNOTICE("您将[(prefs.toggles_chat & CHAT_RADIO) ? "now" : "no longer"] see radio chatter from radios or speakers."))

/client/proc/toggleadminhelpsound()
	set name = "Hear/Silence Adminhelps"
	set category = "Preferences.Sound"
	set desc = "Toggle hearing a notification when admin PMs are received."
	if(!admin_holder)
		return
	prefs.toggles_sound ^= SOUND_ADMINHELP
	prefs.save_preferences()
	to_chat(usr, SPAN_BOLDNOTICE("你将[(prefs.toggles_sound & SOUND_ADMINHELP) ? "now" : "no longer"] hear a sound when adminhelps arrive."))

/client/proc/toggleprayers()
	set name = "Show/Hide Prayers"
	set category = "Preferences.Chat"
	set desc = "Toggles seeing prayers."
	prefs.toggles_chat ^= CHAT_PRAYER
	prefs.save_preferences()
	to_chat(src, SPAN_BOLDNOTICE("你将[(prefs.toggles_chat & CHAT_PRAYER) ? "now" : "no longer"] see prayerchat."))

CLIENT_VERB(toggle_observer_announcement_sounds)
	set name = "Hear/Silence Ghost Announcements"
	set category = "Preferences.Sound"
	set desc = "Toggle hearing a notification of announcements while being an observer."
	prefs.toggles_sound ^= SOUND_OBSERVER_ANNOUNCEMENTS
	prefs.save_preferences()
	to_chat(usr, SPAN_BOLDNOTICE("你将[(prefs.toggles_sound & SOUND_OBSERVER_ANNOUNCEMENTS) ? "now" : "no longer"] hear announcement sounds as an observer."))

CLIENT_VERB(toggle_fax_machine_sounds)
	set name = "Hear/Silence Ghost Fax Machines"
	set category = "Preferences.Sound"
	set desc = "Toggle hearing a notification of faxes while being an observer."
	prefs.toggles_sound ^= SOUND_FAX_MACHINE
	prefs.save_preferences()
	to_chat(usr, SPAN_BOLDNOTICE("你将[(prefs.toggles_sound & SOUND_FAX_MACHINE) ? "now" : "no longer"] hear a fax sounds as an observer."))

CLIENT_VERB(toggletitlemusic)
	set name = "Hear/Silence LobbyMusic"
	set category = "Preferences.Sound"
	set desc = "Toggles hearing the GameLobby music."
	prefs.toggles_sound ^= SOUND_LOBBY
	prefs.save_preferences()
	if(prefs.toggles_sound & SOUND_LOBBY)
		to_chat(src, SPAN_BOLDNOTICE("你现在将在游戏大厅听到音乐。"))
		if(istype(mob, /mob/new_player))
			playtitlemusic()
	else
		to_chat(src, SPAN_BOLDNOTICE("你将不再在游戏大厅听到音乐。"))
		src << sound(null, repeat = 0, wait = 0, volume = 85, channel = SOUND_CHANNEL_LOBBY) // stop the jamsz

CLIENT_VERB(togglerebootsound)
	set name = "Hear/Silence Reboot Sound"
	set category = "Preferences.Sound"
	set desc = "Toggles hearing the server reboot sound effect."
	prefs.toggles_sound ^= SOUND_REBOOT
	prefs.save_preferences()
	to_chat(src, "你将[(prefs.toggles_sound & SOUND_REBOOT) ? "now" : "no longer"] hear server reboot sounds.")

CLIENT_VERB(togglemidis)
	set name = "Silence Current Admin Sound"
	set category = "Preferences.Sound"
	set desc = "Stops the current admin sound. You can also use the STOP icon in the player above tgchat."
	tgui_panel?.stop_music()

CLIENT_VERB(togglechat)
	set name = "Toggle Abovehead Chat"
	set category = "Preferences.Chat"
	set desc = "Toggles abovehead chat until you change body."

	prefs.lang_chat_disabled = ~prefs.lang_chat_disabled
	prefs.save_preferences()
	to_chat(src,SPAN_BOLDNOTICE( "你将[(!prefs.lang_chat_disabled) ? "now" : "no longer"] see messages above head."))

CLIENT_VERB(togglechatemotes)
	set name = "Toggle Abovehead Chat Emotes"
	set category = "Preferences.Chat"
	set desc = "Toggles seeing emotes in abovehead chat."

	prefs.toggles_langchat ^= LANGCHAT_SEE_EMOTES
	prefs.save_preferences()
	to_chat(src,SPAN_BOLDNOTICE( "你将[(prefs.toggles_langchat & LANGCHAT_SEE_EMOTES) ? "now" : "no longer"] see emotes in abovehead chat."))

CLIENT_VERB(toggle_permission_errors)
	set name = "Toggle Permission Errors"
	set category = "Preferences.Chat"
	set desc = "Toggles error messages due to missing permissions."

	prefs.show_permission_errors = !prefs.show_permission_errors
	prefs.save_preferences()
	to_chat(src, SPAN_BOLDNOTICE("你将[(prefs.show_permission_errors) ? "now" : "no longer"] see permission error messages."))

CLIENT_VERB(listen_ooc)
	set name = "Show/Hide OOC"
	set category = "Preferences.Chat"
	set desc = "Toggles seeing OutOfCharacter chat."
	prefs.toggles_chat ^= CHAT_OOC
	prefs.save_preferences()
	to_chat(src, SPAN_BOLDNOTICE("你将[(prefs.toggles_chat & CHAT_OOC) ? "now" : "no longer"] see messages on the OOC channel."))

CLIENT_VERB(listen_looc)
	set name = "Show/Hide LOOC"
	set category = "Preferences.Chat"
	set desc = "Toggles seeing Local OutOfCharacter chat."
	prefs.toggles_chat ^= CHAT_LOOC
	prefs.save_preferences()

	to_chat(src, SPAN_BOLDNOTICE("你将[(prefs.toggles_chat & CHAT_LOOC) ? "now" : "no longer"] see messages on the LOOC channel."))

CLIENT_VERB(Toggle_Soundscape) //All new ambience should be added here so it works with this verb until someone better at things comes up with a fix that isn't awful
	set name = "Hear/Silence Ambience"
	set category = "Preferences.Sound"
	set desc = "Toggles hearing ambient sound effects."
	prefs.toggles_sound ^= SOUND_AMBIENCE
	prefs.save_preferences()
	if(prefs.toggles_sound & SOUND_AMBIENCE)
		to_chat(src,SPAN_BOLDNOTICE( "你现在将听到环境音效。"))
		if(soundOutput)
			soundOutput.update_ambience(null, null, TRUE)
	else
		to_chat(src,SPAN_BOLDNOTICE( "你将不再听到环境音效。"))
		src << sound(null, repeat = 0, wait = 0, volume = 0, channel = SOUND_CHANNEL_AMBIENCE)
		src << sound(null, repeat = 0, wait = 0, volume = 0, channel = SOUND_CHANNEL_SOUNDSCAPE)

CLIENT_VERB(toggle_roundstart_flash)
	set name = "Toggle Roundstart Flash"
	set category = "Preferences.TaskbarFlashing"
	set desc = "Toggles the taskbar flashing when the round starts."

	prefs.toggles_flashing ^= FLASH_ROUNDSTART
	prefs.save_preferences()
	if(prefs.toggles_flashing & FLASH_ROUNDSTART)
		to_chat(src,  SPAN_BOLDNOTICE("当回合开始前的回合提示播放时，你任务栏上的图标现在将会闪烁。"))
	else
		to_chat(src,  SPAN_BOLDNOTICE("当回合开始前的回合提示播放时，你任务栏上的图标将不再闪烁。"))

CLIENT_VERB(toggle_roundend_flash)
	set name = "Toggle Roundend Flash"
	set category = "Preferences.TaskbarFlashing"
	set desc = "Toggles the taskbar flashing when the round ends."

	prefs.toggles_flashing ^= FLASH_ROUNDEND
	prefs.save_preferences()
	if(prefs.toggles_flashing & FLASH_ROUNDEND)
		to_chat(src,  SPAN_BOLDNOTICE("当回合结束时，你任务栏上的图标现在将会闪烁。"))
	else
		to_chat(src, SPAN_BOLDNOTICE( "当回合结束时，你任务栏上的图标将不再闪烁。"))

CLIENT_VERB(toggle_corpserevive_flash)
	set name = "Toggle Revival Flash"
	set category = "Preferences.TaskbarFlashing"
	set desc = "Toggles the taskbar flashing when your corpse gets revived."

	prefs.toggles_flashing ^= FLASH_CORPSEREVIVE
	prefs.save_preferences()
	if(prefs.toggles_flashing & FLASH_CORPSEREVIVE)
		to_chat(src,  SPAN_BOLDNOTICE("当你的尸体被复活时，你任务栏上的图标现在将会闪烁。"))
	else
		to_chat(src, SPAN_BOLDNOTICE( "当你的尸体被复活时，你任务栏上的图标将不再闪烁。"))

CLIENT_VERB(toggle_unnest_flash)
	set name = "Toggle Unnest Flash"
	set category = "Preferences.TaskbarFlashing"
	set desc = "Toggles the taskbar flashing when you get unnested and can reenter your body."

	prefs.toggles_flashing ^= FLASH_UNNEST
	prefs.save_preferences()
	if(prefs.toggles_flashing & FLASH_UNNEST)
		to_chat(src,  SPAN_BOLDNOTICE("当你被解除筑巢状态并可以重新进入身体时，你任务栏上的图标现在将会闪烁。"))
	else
		to_chat(src, SPAN_BOLDNOTICE( "当你被解除筑巢状态并可以重新进入身体时，你任务栏上的图标将不再闪烁。"))

CLIENT_VERB(toggle_newlarva_flash)
	set name = "Toggle Larva Unpool Flash"
	set category = "Preferences.TaskbarFlashing"
	set desc = "Toggles the taskbar flashing when you get spawned in as a xeno larva from the spawn pool."

	prefs.toggles_flashing ^= FLASH_POOLSPAWN
	prefs.save_preferences()
	if(prefs.toggles_flashing & FLASH_POOLSPAWN)
		to_chat(src,  SPAN_BOLDNOTICE("当你以潜藏幼虫形态生成时，你任务栏上的图标现在将会闪烁。"))
	else
		to_chat(src, SPAN_BOLDNOTICE( "当你以潜藏幼虫形态生成时，你任务栏上的图标将不再闪烁。"))


CLIENT_VERB(toggle_adminpm_flash)
	set name = "Toggle Admin PM Flash"
	set category = "Preferences.TaskbarFlashing"
	set desc = "Toggles the taskbar flashing when you an admin messages you."

	prefs.toggles_flashing ^= FLASH_ADMINPM
	prefs.save_preferences()
	if(prefs.toggles_flashing & FLASH_ADMINPM)
		to_chat(src, SPAN_BOLDNOTICE("当管理员向你发送消息时，你任务栏上的图标现在将会闪烁。"))
	else
		to_chat(src, SPAN_BOLDNOTICE("The icon on your taskbar will no longer flash when an admin messages you. Warning, use at own risk."))

//be special
CLIENT_VERB(toggle_be_special)
	set name = "Toggle SpecialRole Candidacy"
	set category = "Preferences"
	set desc = "Toggles which special roles you would like to be a candidate for."

	var/role = tgui_input_list(usr, "Toggle which candidacy?", "Select role", GLOB.be_special_flags)
	if(!role)
		return
	var/role_flag = GLOB.be_special_flags[role]
	prefs.be_special ^= role_flag
	prefs.save_preferences()
	to_chat(src, SPAN_BOLDNOTICE("You will [(prefs.be_special & role_flag) ? "now" : "no longer"] be considered for [role] events (where possible)."))

CLIENT_VERB(toggle_fullscreen_preference)
	set name = "Toggle Fullscreen Preference"
	set category = "Preferences"
	set desc = "Toggles whether the game window will be true fullscreen or normal."

	prefs.toggle_prefs ^= TOGGLE_FULLSCREEN
	prefs.save_preferences()
	update_fullscreen()

CLIENT_VERB(toggle_ambient_occlusion)
	set name = "Toggle Ambient Occlusion"
	set category = "Preferences"
	set desc = "Toggles whether the game will have ambient occlusion on."

	prefs.toggle_prefs ^= TOGGLE_AMBIENT_OCCLUSION
	prefs.save_preferences()
	var/atom/movable/screen/plane_master/game_world/plane_master = locate() in src.screen
	if (!plane_master)
		return
	plane_master.backdrop(src.mob)

CLIENT_VERB(toggle_member_publicity)
	set name = "Toggle Membership Publicity"
	set category = "Preferences"
	set desc = "Toggles if other players can see that you are a BYOND member (OOC logo)."

	prefs.toggle_prefs ^= TOGGLE_MEMBER_PUBLIC
	prefs.save_preferences()
	to_chat(src, SPAN_BOLDNOTICE("Others can[(prefs.toggle_prefs & TOGGLE_MEMBER_PUBLIC) ? "" : "'t"] now see if you are a BYOND member."))

CLIENT_VERB(toggle_ooc_country_flag)
	set name = "Toggle Country Flag"
	set category = "Preferences"
	set desc = "Toggles if your country flag (based on what country your IP is connecting from) is displayed in OOC chat."

	if(!(CONFIG_GET(flag/ooc_country_flags)))
		to_chat(src, SPAN_WARNING("当前服务器配置已禁用OOC中的国家旗帜！"))
		return

	prefs.toggle_prefs ^= TOGGLE_OOC_FLAG
	prefs.save_preferences()
	to_chat(src, SPAN_BOLDNOTICE("Your country flag [(prefs.toggle_prefs & TOGGLE_OOC_FLAG) ? "will now" : "will now not"] appear before your name in OOC chat."))

CLIENT_VERB(toggle_prefs) // Toggle whether anything will happen when you click yourself in non-help intent
	set name = "Toggle Preferences"
	set category = "Preferences"
	set desc = "Toggles a specific toggleable preference."

	var/list/pref_buttons = list(
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_ignore_self'>Toggle the Ability to Hurt Yourself</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_help_intent_safety'>Toggle Help Intent Safety</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_auto_eject'>Toggle Guns Auto-Ejecting Magazines</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_auto_eject_to_hand'>Toggle Guns Auto-Ejecting Magazines to Your Hands</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_ammo_display_type'>Toggle Semi-Auto Ammo Counter</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_eject_to_hand'>Toggle '卸下武器弹药' Ejecting Magazines to Your Hands</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_automatic_punctuation'>Toggle Automatic Punctuation</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_ability_deactivation'>Toggle Ability Deactivation</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_clickdrag_override'>Toggle Combat Click-Drag Override</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_dualwield'>Toggle Alternate-Fire Dual Wielding</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_auto_shove'>Toggle Auto Shove</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_middle_mouse_swap_hands'>Toggle Middle Mouse Swapping Hands</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_vend_item_to_hand'>Toggle Vendors Vending to Hands</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/switch_item_animations'>Toggle Item Animations</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_admin_sound_types'>Toggle Admin Sound Types</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/set_eye_blur_type'>Set Eye Blur Type</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/set_flash_type'>Set Flash Type</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/set_crit_type'>Set Crit Type</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/set_flashing_lights_pref'>Set Flashing Lights</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_leadership_spoken_orders'>Toggle Leadership Spoken Orders</a><br>",
		"<a href='byond://?src=\ref[src];action=proccall;procpath=/client/proc/toggle_cocking_to_hand'>Toggle Bullet Cocking to hand</a><br>",
	)

	var/dat = ""
	for (var/pref_button in pref_buttons)
		dat += "[pref_button]\n"

	var/height = 50+24*length(pref_buttons)

	show_browser(src, dat, "Toggle Preferences", "togglepreferences", width = 475, height = height)

/client/proc/toggle_ignore_self() // Toggle whether anything will happen when you click yourself in non-help intent
	prefs.toggle_prefs ^= TOGGLE_IGNORE_SELF
	if(prefs.toggle_prefs & TOGGLE_IGNORE_SELF)
		to_chat(src,SPAN_BOLDNOTICE( "Clicking on yourself in non-help intent will no longer do anything."))
	else
		to_chat(src, SPAN_BOLDNOTICE("Clicking on yourself in non-help intent can harm you again."))
	prefs.save_preferences()

/client/proc/toggle_help_intent_safety() // Toggle whether anything will happen when you click on someone with help intent
	prefs.toggle_prefs ^= TOGGLE_HELP_INTENT_SAFETY
	if(prefs.toggle_prefs & TOGGLE_HELP_INTENT_SAFETY)
		to_chat(src, SPAN_BOLDNOTICE("Help intent will now be completely harmless."))
	else
		to_chat(src, SPAN_BOLDNOTICE("Help intent can perform harmful actions again."))
	prefs.save_preferences()

/client/proc/toggle_auto_eject() // Toggle whether guns with auto-ejectors will automatically eject magazines
	prefs.toggle_prefs ^= TOGGLE_AUTO_EJECT_MAGAZINE_OFF
	if(prefs.toggle_prefs & TOGGLE_AUTO_EJECT_MAGAZINE_OFF)
		var/msg = "Guns with auto-ejectors will no longer automatically eject their magazines."
		if (prefs.toggle_prefs & TOGGLE_AUTO_EJECT_MAGAZINE_TO_HAND)
			prefs.toggle_prefs ^= TOGGLE_AUTO_EJECT_MAGAZINE_TO_HAND
			msg += " The preference for auto-ejecting magazines to your hand has been toggled off."
		to_chat(src, msg)
	else
		to_chat(src, SPAN_BOLDNOTICE("Guns with auto-ejectors will automatically eject their magazines."))
	prefs.save_preferences()


/client/proc/toggle_ammo_display_type()
	prefs.toggle_prefs ^= TOGGLE_AMMO_DISPLAY_TYPE
	to_chat(usr, SPAN_NOTICE("Guns in semi-automatic mode will now display the ammo on every [SPAN_BOLD(prefs.toggle_prefs & TOGGLE_AMMO_DISPLAY_TYPE ? "fifth bullet and when the mag has less than 15 rounds left" : "single bullet")]."))
	prefs.save_preferences()

/client/proc/toggle_auto_eject_to_hand() // Toggle whether guns with auto-ejectors will eject their magazines to your offhand
	prefs.toggle_prefs ^= TOGGLE_AUTO_EJECT_MAGAZINE_TO_HAND
	if(prefs.toggle_prefs & TOGGLE_AUTO_EJECT_MAGAZINE_TO_HAND)
		var/msg = "Guns with auto-ejectors will eject their magazines to your offhand."
		if (prefs.toggle_prefs & TOGGLE_AUTO_EJECT_MAGAZINE_OFF)
			prefs.toggle_prefs ^= TOGGLE_AUTO_EJECT_MAGAZINE_OFF
			msg += " The preference for removing magazine auto-ejecting has been toggled off."
		to_chat(src, SPAN_BOLDNOTICE(msg))
	else
		to_chat(src, SPAN_BOLDNOTICE("Guns with auto-ejectors will no longer eject their magazines to your offhand."))
	prefs.save_preferences()

/client/proc/toggle_eject_to_hand() // Toggle whether unloading a magazine with the '卸下武器弹药' verb will put the magazine in your offhand
	prefs.toggle_prefs ^= TOGGLE_EJECT_MAGAZINE_TO_HAND
	if(prefs.toggle_prefs & TOGGLE_EJECT_MAGAZINE_TO_HAND)
		to_chat(src, SPAN_BOLDNOTICE("The '卸下武器弹药' verb will put magazines in your offhand."))
	else
		to_chat(src, SPAN_BOLDNOTICE("The '卸下武器弹药' verb will no longer put magazines in your offhand."))
	prefs.save_preferences()

/client/proc/toggle_automatic_punctuation() // Toggle whether your sentences are automatically punctuated
	prefs.toggle_prefs ^= TOGGLE_AUTOMATIC_PUNCTUATION
	if(prefs.toggle_prefs & TOGGLE_AUTOMATIC_PUNCTUATION)
		to_chat(src, SPAN_BOLDNOTICE("Your messages will automatically be punctuated if they are not punctuated already."))
	else
		to_chat(src, SPAN_BOLDNOTICE("Your messages will no longer be automatically punctuated if they are not punctuated already."))
	prefs.save_preferences()

/client/proc/toggle_auto_shove()
	prefs.toggle_prefs ^= TOGGLE_AUTO_SHOVE_OFF
	if (prefs.toggle_prefs & TOGGLE_AUTO_SHOVE_OFF)
		to_chat(src, SPAN_NOTICE("You will no longer automatically shove people in the way as the Queen or King."))
	else
		to_chat(src, SPAN_NOTICE("You will now automatically shove people in the way as the Queen or King."))
	prefs.save_preferences()

/client/proc/toggle_ability_deactivation() // Toggle whether the current ability can be deactivated when re-selected
	prefs.toggle_prefs ^= TOGGLE_ABILITY_DEACTIVATION_OFF
	if (prefs.toggle_prefs & TOGGLE_ABILITY_DEACTIVATION_OFF)
		to_chat(src, SPAN_NOTICE("Your current ability can no longer be toggled off when re-selected."))
	else
		to_chat(src, SPAN_NOTICE("Your current ability can be toggled off when re-selected."))
	prefs.save_preferences()

/client/proc/toggle_clickdrag_override() //Toggle whether mousedown clicks immediately when on disarm or harm intent to prevent click-dragging from 'eating' attacks.
	prefs.toggle_prefs ^= TOGGLE_COMBAT_CLICKDRAG_OVERRIDE
	if(prefs.toggle_prefs & TOGGLE_COMBAT_CLICKDRAG_OVERRIDE)
		to_chat(src,SPAN_BOLDNOTICE( "Depressing the mouse button on disarm or harm intent will now click the target immediately, even if you hold it down -- unless you're click-dragging yourself, an ally, or an object in your inventory."))
	else
		to_chat(src,SPAN_BOLDNOTICE( "Click-dragging now blocks clicks from going through."))
	prefs.save_preferences()

/// Toggles whether activating marine leader orders will be spoken or not, on by default
/client/proc/toggle_leadership_spoken_orders()
	prefs.toggle_prefs ^= TOGGLE_LEADERSHIP_SPOKEN_ORDERS
	if(prefs.toggle_prefs & TOGGLE_LEADERSHIP_SPOKEN_ORDERS)
		to_chat(src, SPAN_BOLDNOTICE("Your leadership orders will no longer be verbally spoken."))
	else
		to_chat(src, SPAN_BOLDNOTICE("Your leadership orders will now be verbally spoken."))
	prefs.save_preferences()

/// Toggles whether cocking a gun should drop its bullet or moves it to your empty hand
/client/proc/toggle_cocking_to_hand()
	prefs.toggle_prefs ^= TOGGLE_COCKING_TO_HAND
	if(prefs.toggle_prefs & TOGGLE_COCKING_TO_HAND)
		to_chat(src, SPAN_BOLDNOTICE("You will attempt to catch the ejected bullet when cocking a gun."))
	else
		to_chat(src, SPAN_BOLDNOTICE("现在，当你为枪械上膛时，退出的弹壳会掉落在地。"))
	prefs.save_preferences()

///Toggle whether dual-wielding fires both guns at once or swaps between them.
/client/proc/toggle_dualwield()
	if(prefs.dual_wield_pref < DUAL_WIELD_NONE)
		prefs.dual_wield_pref++
	else
		prefs.dual_wield_pref = DUAL_WIELD_FIRE

	switch(prefs.dual_wield_pref)
		if(DUAL_WIELD_FIRE)
			to_chat(src, SPAN_BOLDNOTICE("双持现在会同时开火两把枪。"))
		if(DUAL_WIELD_SWAP)
			to_chat(src, SPAN_BOLDNOTICE("双持现在会在两把枪之间切换射击，前提是另一把枪已装弹。"))
		if(DUAL_WIELD_NONE)
			to_chat(src, SPAN_BOLDNOTICE("双持现在对你的开火方式没有影响。"))

	prefs.save_preferences()

/client/proc/toggle_middle_mouse_swap_hands() //Toggle whether middle click swaps your hands
	prefs.toggle_prefs ^= TOGGLE_MIDDLE_MOUSE_SWAP_HANDS
	to_chat(src, SPAN_BOLDNOTICE("中键点击 [(prefs.toggle_prefs & TOGGLE_MIDDLE_MOUSE_SWAP_HANDS) ? "will" : "will no longer"] swap your hands."))
	prefs.save_preferences()

/client/proc/toggle_vend_item_to_hand() //Toggle whether vendors automatically vend to your hands
	prefs.toggle_prefs ^= TOGGLE_VEND_ITEM_TO_HAND
	if(prefs.toggle_prefs & TOGGLE_VEND_ITEM_TO_HAND)
		to_chat(src, SPAN_BOLDNOTICE("大多数自动售货机现在会直接将物品售出到你手中。"))
	else
		to_chat(src, SPAN_BOLDNOTICE("自动售货机将不再将物品售出到你手中。"))
	prefs.save_preferences()

/client/proc/switch_item_animations() //Switches tg-style item animations on, not-on-same-tile, and off
	switch(prefs.item_animation_pref_level)
		if(SHOW_ITEM_ANIMATIONS_NONE)
			prefs.item_animation_pref_level = SHOW_ITEM_ANIMATIONS_HALF
			to_chat(src, SPAN_BOLDNOTICE("你现在将看到所有物品动画，除了那些发生在自身格子内的动画。"))
			prefs.save_preferences()
			return "On"

		if(SHOW_ITEM_ANIMATIONS_HALF)
			prefs.item_animation_pref_level = SHOW_ITEM_ANIMATIONS_ALL
			to_chat(src, SPAN_BOLDNOTICE("你现在将看到所有物品动画。"))
			prefs.save_preferences()
			return "Not Same Tile"

		if(SHOW_ITEM_ANIMATIONS_ALL)
			prefs.item_animation_pref_level = SHOW_ITEM_ANIMATIONS_NONE
			to_chat(src, SPAN_BOLDNOTICE("你将不再看到物品动画。"))
			prefs.save_preferences()
			return "Off"

/client/proc/toggle_admin_sound_types()
	//Entirely for code readability.
	var/meme_toggle = prefs.toggles_sound & SOUND_ADMIN_MEME ? TRUE : FALSE
	var/atmospheric_toggle = prefs.toggles_sound & SOUND_ADMIN_ATMOSPHERIC ? TRUE : FALSE
	var/result = tgui_alert(src, "你想切换哪种声音类型？梗音效当前为 [meme_toggle ? "enabled" : "disabled"], Atmospheric sounds are currently [atmospheric_toggle ? "enabled" : "disabled"].", "Toggle MIDI/Internet sound type to play", list("Meme", "Atmospheric"))
	if(result == "Meme")
		prefs.toggles_sound ^= SOUND_ADMIN_MEME
		//Update the variables so it doesn't output the outdated toggle.
		meme_toggle = prefs.toggles_sound & SOUND_ADMIN_MEME ? TRUE : FALSE
		to_chat(src, SPAN_NOTICE("你将 [meme_toggle ? "now" : "no longer"] hear meme admin sounds."))
	if(result == "Atmospheric")
		prefs.toggles_sound ^= SOUND_ADMIN_ATMOSPHERIC
		//Ditto.
		atmospheric_toggle = prefs.toggles_sound & SOUND_ADMIN_ATMOSPHERIC ? TRUE : FALSE
		to_chat(src, SPAN_NOTICE("你将 [atmospheric_toggle ? "now" : "no longer"] hear atmospheric admin sounds."))

/client/proc/receive_random_tip()
	var/picked_type = tgui_alert(src, "哪种提示？", "Tip Type", list("陆战队员", "异形", "Meta")) //no memetips for them joker imp
	var/message
	var/static/list/types_to_pick = list(
		"陆战队员" = "strings/marinetips.txt",
		"异形" = "strings/xenotips.txt",
		"Meta" = "strings/metatips.txt"
	)
	var/list/tip_list = file2list(types_to_pick[picked_type])
	if(length(types_to_pick[picked_type]))
		message = SAFEPICK(tip_list)
	else
		CRASH("receive_random_tip() failed: empty list")

	if(message)
		to_chat(src, SPAN_PURPLE("<b>随机提示：</b>[html_encode(message)]"))
		return TRUE
	else
		CRASH("receive_random_tip() failed: null message")

/// Toggle in character preferences and toggle preferences to configure what kind of blur overlay is used in game; Either blurry, impaired, or legacy.
/client/proc/set_eye_blur_type()
	var/result = tgui_alert(src, "你想要哪种视觉模糊效果？", "你想要哪种视觉模糊效果？", list("Blurry", "Impair", "Legacy"))
	if(result == "Blurry")
		prefs.pain_overlay_pref_level = PAIN_OVERLAY_BLURRY
		to_chat(src, SPAN_NOTICE("你的视觉现在将直接变得模糊。"))
	if(result == "Impair")
		prefs.pain_overlay_pref_level = PAIN_OVERLAY_IMPAIR
		to_chat(src, SPAN_NOTICE("你的视觉现在将在模糊时受损。"))
	if(result == "Legacy")
		prefs.pain_overlay_pref_level = PAIN_OVERLAY_LEGACY
		to_chat(src, SPAN_NOTICE("你的视觉现在将采用旧版模糊效果。不推荐！"))
	prefs.save_preferences()

/// Toggle in character preferences and toggle preferences to configure what kind of flash overlay is used in game; Either white or black.
/client/proc/set_flash_type()
	var/result = tgui_alert(src, "你想要哪种闪光覆盖效果？", "你想要哪种闪光覆盖效果？", list("White", "Dark"))
	if(result == "White")
		prefs.flash_overlay_pref = FLASH_OVERLAY_WHITE
		to_chat(src, SPAN_NOTICE("如果被闪，你的视觉现在将变成白色。"))
	else if(result == "Dark")
		prefs.flash_overlay_pref = FLASH_OVERLAY_DARK
		to_chat(src, SPAN_NOTICE("如果被闪，你的视觉现在将变成黑色。"))
	prefs.save_preferences()

/// Toggle in character preferences and toggle preferences to configure what kind of crit overlay is used in game; Either white or grey.
/client/proc/set_crit_type()
	var/result = tgui_alert(src, "你想要哪种濒危状态覆盖效果？", "你想要哪种濒危状态覆盖效果？", list("White", "Dark"))
	if(result == "White")
		prefs.crit_overlay_pref = CRIT_OVERLAY_WHITE
		to_chat(src, SPAN_NOTICE("如果处于危急状态，你的视觉现在将变成白色。"))
	else if(result == "Dark")
		prefs.crit_overlay_pref = CRIT_OVERLAY_DARK
		to_chat(src, SPAN_NOTICE("如果处于危急状态，你的视觉现在将变成黑色。"))
	prefs.save_preferences()

/// Toggle in character preferences and toggle preferences to allow or disable flashing lights e.g. /obj/item/clothing/glasses/disco_fever and druggy status
/client/proc/set_flashing_lights_pref()
	var/result = tgui_alert(src, "是否允许可能引发癫痫的效果？", "Allow flashing lights?", list("Allow", "Disable"))
	if(!result)
		return
	prefs.allow_flashing_lights_pref = result == "Allow"
	to_chat(src, SPAN_NOTICE("闪烁灯光（例如AR护目镜和快乐丸）现在[prefs.allow_flashing_lights_pref ? "allowed" : "disabled"]."))
	if(!prefs.allow_flashing_lights_pref)
		mob?.update_client_color_matrices() // Update immediately
	prefs.save_preferences()

CLIENT_VERB(toggle_tgui_say)
	set name = "Toggle Say Input Style"
	set category = "Preferences.UI"
	set desc = "Toggle your Input Style."

	var/result = tgui_alert(src, "你想要哪种输入风格？", "Input Style", list("Modern", "Legacy"))
	if(!result)
		return

	if(result == "Legacy")
		prefs.tgui_say = FALSE
		to_chat(src, SPAN_NOTICE("你正在使用旧版界面。"))
	else
		prefs.tgui_say = TRUE
		to_chat(src, SPAN_NOTICE("你正在使用新版界面。"))
	prefs.save_preferences()
	update_special_keybinds()

CLIENT_VERB(toggle_tgui_say_light_mode)
	set name = "Toggle Say Input Color"
	set category = "Preferences.UI"
	set desc = "Toggle your Input Color."

	var/result = tgui_alert(src, "你想要哪种输入颜色？", "Input Style", list("Darkmode", "Lightmode"))
	if(!result)
		return
	if(result == "Lightmode")
		prefs.tgui_say_light_mode = TRUE
		to_chat(src, SPAN_NOTICE("你正在使用白色模式发言界面。"))
	else
		prefs.tgui_say_light_mode = FALSE
		to_chat(src, SPAN_NOTICE("你正在使用白色模式发言界面。"))
	tgui_say?.load()
	prefs.save_preferences()

CLIENT_VERB(toggle_custom_cursors)
	set name = "Toggle Custom Cursors"
	set category = "Preferences.UI"
	set desc = "Toggle Custom Cursors."

	do_toggle_custom_cursors()

/client/proc/do_toggle_custom_cursors(mob/user)
	var/result = tgui_alert(user, "是否启用自定义光标？", "Custom Cursors", list("Yes", "No", "Enable Main Cursor", "Disable Main Cursor"))
	if(!result)
		return
	switch(result)
		if("Yes")
			prefs.custom_cursors = TRUE
			to_chat(src, SPAN_NOTICE("你正在使用自定义光标。"))
			if(result == "Yes")
				var/chosen_cursor = tgui_alert(user, "选择哪种自定义光标类型？", "Custom Cursors", list("USCM", "异形", "UPP", "PMC", "TWE"))
				if(!chosen_cursor)
					return
				switch(chosen_cursor)
					if("USCM")// For anyone in the future who might add anything, all of the cursors need to be their own file. and the only icon inside it needs to be renamed to "all" for byond to work with it
						prefs.chosen_pointer = 'icons/effects/mouse_pointer/uscm.dmi'
					if("异形")
						prefs.chosen_pointer = 'icons/effects/mouse_pointer/xeno.dmi'
					if("UPP")
						prefs.chosen_pointer = 'icons/effects/mouse_pointer/upp.dmi'
					if("PMC")
						prefs.chosen_pointer = 'icons/effects/mouse_pointer/wy.dmi'
					if("TWE")
						prefs.chosen_pointer = 'icons/effects/mouse_pointer/twe.dmi'
				prefs.save_preferences()
				user.update_cursor()
		if("No")
			prefs.custom_cursors = FALSE
			to_chat(src, SPAN_NOTICE("你不再使用自定义光标。"))
			mouse_pointer_icon = initial(mouse_pointer_icon)
			prefs.save_preferences()
		if("Enable Main Cursor")
			prefs.main_cursor = TRUE
			to_chat(src, SPAN_NOTICE("你的主光标现在将被自定义。"))
			prefs.save_preferences()
		if("Disable Main Cursor")
			to_chat(src, SPAN_NOTICE("你的主光标将不再被自定义。"))
			prefs.main_cursor = FALSE
			prefs.save_preferences()


	prefs.save_preferences()

CLIENT_VERB(toggle_auto_viewport_fit)
	set name = "Toggle Auto Viewport Fit"
	set category = "Preferences.UI"

	prefs.auto_fit_viewport = !prefs.auto_fit_viewport
	if(prefs.auto_fit_viewport)
		to_chat(src, SPAN_NOTICE("现在自动适配视口。"))
		fit_viewport()
	else
		to_chat(src, SPAN_NOTICE("不再自动适配视口。"))
	prefs.save_preferences()

CLIENT_VERB(toggle_adaptive_zooming)
	set name = "Toggle Adaptive Zooming"
	set category = "Preferences.UI"

	switch(prefs.adaptive_zoom)
		if(0)
			prefs.adaptive_zoom = 1
			to_chat(src, SPAN_BOLDNOTICE("自适应缩放现已启用，将在x1和x2缩放之间切换。建议1080p显示器使用。"))
			adaptive_zoom()
		if(1)
			prefs.adaptive_zoom = 2
			to_chat(src, SPAN_BOLDNOTICE("自适应缩放现已启用，将在x2和x4缩放之间切换。"))
			adaptive_zoom()
		if(2)
			prefs.adaptive_zoom = 0
			to_chat(src, SPAN_BOLDNOTICE("自适应缩放现已禁用。"))
			adaptive_zoom()
	prefs.save_preferences()

//------------ GHOST PREFERENCES ---------------------------------

/client/proc/show_ghost_preferences() // Shows ghost-related preferences.
	set name = "Show Ghost Prefs"
	set category = "Preferences"
	set desc = "Shows ghost-related preferences."

	add_verb(src, GLOB.ghost_prefs_verbs)
	remove_verb(src, /client/proc/show_ghost_preferences)

/client/proc/hide_ghost_preferences() // Hides ghost-related preferences.
	set name = "Hide Ghost Prefs"
	set category = "Preferences"
	set desc = "Hides ghost-related preferences."

	remove_verb(src, GLOB.ghost_prefs_verbs)
	add_verb(src, /client/proc/show_ghost_preferences)

/client/proc/toggle_ghost_hivemind()
	set name = "Toggle GhostHivemind"
	set category = "Preferences.Ghost"
	set desc = "Toggle seeing all chatter from the Xenomorph Hivemind."
	prefs.toggles_chat ^= CHAT_GHOSTHIVEMIND
	to_chat(src,SPAN_BOLDNOTICE( "作为幽灵，你将[(prefs.toggles_chat & CHAT_GHOSTHIVEMIND) ? "now see chatter from the Xenomorph Hivemind" : "no longer see chatter from the Xenomorph Hivemind"]."))
	prefs.save_preferences()

/client/proc/deadchat() // Deadchat toggle is usable by anyone.
	set name = "Toggle Deadchat"
	set category = "Preferences.Ghost"
	set desc ="Toggles seeing DeadChat"
	prefs.toggles_chat ^= CHAT_DEAD
	prefs.save_preferences()

	if(src.admin_holder && (admin_holder.rights & R_MOD))
		to_chat(src,SPAN_DANGER( "你将[(prefs.toggles_chat & CHAT_DEAD) ? "now" : "no longer"] see deadchat."))
	else
		to_chat(src,SPAN_BOLDNOTICE( "作为幽灵，你将[(prefs.toggles_chat & CHAT_DEAD) ? "now" : "no longer"] see deadchat."))

/client/proc/toggle_ghost_ears()
	set name = "Toggle GhostEars"
	set category = "Preferences.Ghost"
	set desc = "Toggle between seeing all mob speech, and only speech of nearby mobs."
	prefs.toggles_chat ^= CHAT_GHOSTEARS
	to_chat(src, SPAN_BOLDNOTICE("作为幽灵，你现在将[(prefs.toggles_chat & CHAT_GHOSTEARS) ? "see all speech in the world" : "only see speech from nearby mobs"]."))
	prefs.save_preferences()

/client/proc/toggle_ghost_sight()
	set name = "Toggle GhostSight"
	set category = "Preferences.Ghost"
	set desc = "Toggle between seeing all mob emotes, and only emotes of nearby mobs."
	prefs.toggles_chat ^= CHAT_GHOSTSIGHT
	to_chat(src, SPAN_BOLDNOTICE("作为幽灵，你现在将[(prefs.toggles_chat & CHAT_GHOSTSIGHT) ? "see all emotes in the world" : "only see emotes from nearby mobs"]."))
	prefs.save_preferences()

/client/proc/toggle_ghost_radio()
	set name = "Toggle GhostRadio"
	set category = "Preferences.Ghost"
	set desc = "Toggle between hearing all radio chatter, or only from nearby speakers."
	prefs.toggles_chat ^= CHAT_GHOSTRADIO
	to_chat(src,SPAN_BOLDNOTICE( "作为幽灵，你现在将[(prefs.toggles_chat & CHAT_GHOSTRADIO) ? "hear all radio chat in the world" : "only hear from nearby speakers"]."))
	prefs.save_preferences()

/client/proc/toggle_ghost_spyradio()
	set name = "Toggle GhostSpyRadio"
	set category = "Preferences.Ghost"
	set desc = "Toggle between hearing listening devices or not."
	prefs.toggles_chat ^= CHAT_LISTENINGBUG
	to_chat(src,SPAN_BOLDNOTICE( "作为幽灵，你将[(prefs.toggles_chat & CHAT_LISTENINGBUG) ? "now" : "no longer"] hear listening devices as a ghost."))
	prefs.save_preferences()

/client/proc/toggle_ghost_announce_clarity()
	set name = "Toggle Ghost Announce Clarity"
	set category = "Preferences.Ghost"
	set desc = "Toggle between seeing announcements always in full clarity, or with the current clarity for the observed z-level."
	prefs.toggles_chat ^= CHAT_GHOSTANNOUNCECLARITY
	to_chat(src, SPAN_BOLDNOTICE("作为幽灵，你现在将在[(prefs.toggles_chat & CHAT_GHOSTANNOUNCECLARITY) ? "full clarity always" : "partial clarity if applicable"]."))
	prefs.save_preferences()

/client/proc/toggle_ghost_hud()
	set name = "Toggle Ghost HUDs"
	set category = "Preferences.Ghost"
	set desc = "Use to change which HUDs you want to have by default when you become an observer."

	var/list/hud_options = list(
		"Medical HUD" = MOB_HUD_MEDICAL_OBSERVER,
		"Security HUD" = MOB_HUD_SECURITY_ADVANCED,
		"Squad HUD" = MOB_HUD_FACTION_OBSERVER,
		"Xeno Status HUD" = MOB_HUD_XENO_STATUS,
		"Faction UPP HUD" = MOB_HUD_FACTION_UPP,
		"Faction Wey-Yu HUD" = MOB_HUD_FACTION_WY,
		"Faction TWE HUD" = MOB_HUD_FACTION_TWE,
		"Faction CLF HUD" = MOB_HUD_FACTION_CLF,
		"Faction WO HUD" = MOB_HUD_FACTION_WO,
		"Faction Hyperdyne HUD" = MOB_HUD_FACTION_HC,
	)

	var/hud_choice = tgui_input_list(usr, "选择要切换的HUD", "Toggle HUD prefs", hud_options)
	if(!hud_choice)
		return
	prefs.observer_huds[hud_choice] = !prefs.observer_huds[hud_choice]
	prefs.save_preferences()

	to_chat(src, SPAN_BOLDNOTICE("你将[hud_choice]切换为[prefs.observer_huds[hud_choice] ? "ON" : "OFF"] by default when you are observer."))

	if(!isobserver(usr))
		return
	var/mob/dead/observer/observer_user = usr
	var/datum/mob_hud/hud = GLOB.huds[hud_options[hud_choice]]

	observer_user.HUD_toggled[hud_choice] = prefs.observer_huds[hud_choice]
	if(observer_user.HUD_toggled[hud_choice])
		hud.add_hud_to(observer_user, observer_user)
	else
		hud.remove_hud_from(observer_user, observer_user)

/client/proc/toggle_ghost_health_scan()
	set name = "Toggle Health Scan"
	set category = "Preferences.Ghost"

	prefs.toggles_ghost ^= GHOST_HEALTH_SCAN
	prefs.save_preferences()
	to_chat(usr, "作为幽灵，你将[prefs.toggles_ghost & GHOST_HEALTH_SCAN ? "now" : "no longer"] be able to scan health of living mobs via right click menu.")
	if(isobserver(usr))
		if(prefs.toggles_ghost & GHOST_HEALTH_SCAN)
			add_verb(usr, /mob/dead/observer/proc/scan_health)
		else
			remove_verb(usr, /mob/dead/observer/proc/scan_health)

GLOBAL_LIST_INIT(ghost_orbits, list(GHOST_ORBIT_CIRCLE, GHOST_ORBIT_TRIANGLE, GHOST_ORBIT_SQUARE, GHOST_ORBIT_HEXAGON, GHOST_ORBIT_PENTAGON))

/client/proc/pick_ghost_orbit()
	set name = "Pick Ghost Orbit Shape"
	set category = "Preferences.Ghost"
	set desc = "Toggle in what manner you orbit mobs while a ghost."
	var/new_orbit = tgui_input_list(src, "选择你的幽灵环绕模式：", "Ghost Customization", GLOB.ghost_orbits)
	if(!new_orbit)
		return

	prefs.ghost_orbit = new_orbit
	prefs.save_preferences()

	to_chat(src, SPAN_NOTICE("你的鬼魂现在将以[new_orbit]形状轨道运行。"))

	if(!isobserver(mob))
		return

	var/mob/dead/observer/O = mob
	O.ghost_orbit = new_orbit

//------------ COMBAT CHAT MESSAGES PREFERENCES ---------------------

//Made all chat combat-related logs added by Neth and several others to be hidden by default and shown when clicked respected verb. Reason: too cluttered preferences.
/client/proc/show_combat_chat_preferences() // Shows additional chat logs preferences.
	set category = "Preferences"
	set name = "Show Combat Chat Prefs"
	set desc = "Shows additional chat preferences for combat and ghost messages."

	add_verb(src, GLOB.combat_chat_prefs_verbs)
	remove_verb(src, /client/proc/show_combat_chat_preferences)

/client/proc/hide_combat_chat_preferences() // Hides additional chat logs preferences.
	set category = "Preferences"
	set name = "Hide Combat Chat Prefs"
	set desc = "Hides additional chat preferences for combat and ghost messages."

	remove_verb(src, GLOB.combat_chat_prefs_verbs)
	add_verb(src, /client/proc/show_combat_chat_preferences)

/client/proc/toggle_chat_shooting()
	set name = "Toggle Firing Messages"
	set category = "Preferences.Combat"
	set desc = ".Enable or Disable messages informing about weapon fire."
	prefs.chat_display_preferences ^= CHAT_TYPE_WEAPON_USE
	to_chat(src,SPAN_BOLDNOTICE( "作为玩家，你现在将[(prefs.chat_display_preferences & CHAT_TYPE_WEAPON_USE) ? "see all weapon fire messages" : "never see weapon fire messages"]."))
	prefs.save_preferences()

/client/proc/toggle_chat_xeno_attack()
	set name = "Toggle Xeno Attack Messages"
	set category = "Preferences.Combat"
	set desc = ".Enable or Disable messages informing about xeno attacks."
	prefs.chat_display_preferences ^= CHAT_TYPE_XENO_COMBAT
	to_chat(src, SPAN_BOLDNOTICE("作为玩家，你现在将[(prefs.chat_display_preferences & CHAT_TYPE_XENO_COMBAT) ? "see all xeno attack messages" : "never see xeno attack messages"]."))
	prefs.save_preferences()

/client/proc/toggle_chat_xeno_armor()
	set name = "Toggle Xeno Armor Messages"
	set category = "Preferences.Combat"
	set desc = ".Enable or Disable messages informing about xeno armor."
	prefs.chat_display_preferences ^= CHAT_TYPE_ARMOR_DAMAGE
	to_chat(src, SPAN_BOLDNOTICE("作为玩家，你现在将[(prefs.chat_display_preferences & CHAT_TYPE_ARMOR_DAMAGE) ? "see all xeno armor messages" : "never see xeno armor messages"]."))
	prefs.save_preferences()

/client/proc/toggle_chat_someone_hit()
	set name = "Toggle Someone Hit Messages"
	set category = "Preferences.Combat"
	set desc = ".Enable or Disable messages informing about someone being hit."
	prefs.chat_display_preferences ^= CHAT_TYPE_TAKING_HIT
	to_chat(src,SPAN_BOLDNOTICE( "作为玩家，你现在将[(prefs.chat_display_preferences & CHAT_TYPE_TAKING_HIT) ? "see all player hit messages" : "never see player hit messages"]."))
	prefs.save_preferences()

/client/proc/toggle_chat_you_hit()
	set name = "Toggle You Hit Messages"
	set category = "Preferences.Combat"
	set desc = ".Enable or Disable messages informing about you being hit."
	prefs.chat_display_preferences ^= CHAT_TYPE_BEING_HIT
	to_chat(src,SPAN_BOLDNOTICE( "作为玩家，你现在将[(prefs.chat_display_preferences & CHAT_TYPE_BEING_HIT) ? "see you being hit messages" : "never see you being hit messages"]."))
	prefs.save_preferences()

/client/proc/toggle_chat_you_pain()
	set name = "Toggle Pain Messages"
	set category = "Preferences.Combat"
	set desc = ".Enable or Disable messages informing about you being in pain."
	prefs.chat_display_preferences ^= CHAT_TYPE_PAIN
	to_chat(src, SPAN_BOLDNOTICE("作为玩家，你现在将[(prefs.chat_display_preferences & CHAT_TYPE_PAIN) ? "see you being in pain messages" : "never see you being in pain messages"]."))
	prefs.save_preferences()

GLOBAL_LIST_INIT(combat_chat_prefs_verbs, list(
	/client/proc/toggle_chat_shooting,
	/client/proc/toggle_chat_xeno_attack,
	/client/proc/toggle_chat_xeno_armor,
	/client/proc/toggle_chat_someone_hit,
	/client/proc/toggle_chat_you_hit,
	/client/proc/toggle_chat_you_pain,
	/client/proc/hide_combat_chat_preferences))

GLOBAL_LIST_INIT(ghost_prefs_verbs, list(
	/client/proc/toggle_ghost_ears,
	/client/proc/toggle_ghost_sight,
	/client/proc/toggle_ghost_radio,
	/client/proc/toggle_ghost_spyradio,
	/client/proc/toggle_ghost_announce_clarity,
	/client/proc/toggle_ghost_hivemind,
	/client/proc/deadchat,
	/client/proc/toggle_ghost_hud,
	/client/proc/toggle_ghost_health_scan,
	/client/proc/pick_ghost_orbit,
	/client/proc/hide_ghost_preferences))
