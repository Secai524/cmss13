

/obj/item/device/walkman
	name = "Synsound随身听"
	desc = "一款Synsound卡带播放器，首次上市已是200多年前。令人惊讶的是它从未过时。"
	icon = 'icons/obj/items/walkman.dmi'
	icon_state = "walkman"
	item_icons = list(
		WEAR_L_EAR = 'icons/mob/humans/onmob/clothing/ears.dmi',
		WEAR_R_EAR = 'icons/mob/humans/onmob/clothing/ears.dmi',
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/ears.dmi',
		WEAR_IN_J_STORE = 'icons/mob/humans/onmob/clothing/ears.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/walkman.dmi',
		)
	w_class = SIZE_SMALL
	flags_equip_slot = SLOT_WAIST | SLOT_EAR
	flags_obj = OBJ_IS_HELMET_GARB
	black_market_value = 15
	actions_types = list(/datum/action/item_action/walkman/play_pause,/datum/action/item_action/walkman/next_song,/datum/action/item_action/walkman/restart_song)
	var/obj/item/device/cassette_tape/tape
	var/paused = TRUE
	var/list/current_playlist = list()
	var/list/current_songnames = list()
	var/sound/current_song
	var/mob/current_listener
	var/pl_index = 1
	var/volume = 25
	var/design = 1 // What kind of walkman design style to use

/obj/item/device/walkman/Initialize()
	. = ..()
	design = rand(1, 5)
	update_icon()
	AddElement(/datum/element/corp_label/synsound)

/obj/item/device/walkman/Destroy()
	QDEL_NULL(tape)
	break_sound()
	current_song = null
	current_listener = null
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/device/walkman/attackby(obj/item/W, mob/user)
	if(istype(W,/obj/item/device/cassette_tape))
		if(W == user.get_active_hand() && (src in user))
			if(!tape)
				insert_tape(W)
				playsound(src,'sound/weapons/handcuffs.ogg',20,1)
				to_chat(user,SPAN_INFO("你将\the [W]插入\the [src]"))
			else
				to_chat(user,SPAN_WARNING("请先取出另一盘磁带！"))

/obj/item/device/walkman/attack_self(mob/user)
	..()

	if(!current_listener)
		current_listener = user
		START_PROCESSING(SSobj, src)
	if(istype(tape))
		if(paused)
			play()
			to_chat(user,SPAN_INFO("你按下了[src]的‘播放’按钮。"))
		else
			pause()
			to_chat(user,SPAN_INFO("你暂停了[src]"))
		update_icon()
	else
		to_chat(user,SPAN_INFO("没有磁带可播放。"))
	playsound(src,'sound/machines/click.ogg',20,1)

/obj/item/device/walkman/attack_hand(mob/user)
	if(tape && src == user.get_inactive_hand())
		eject_tape(user)
		return
	else
		..()


/obj/item/device/walkman/proc/break_sound()
	var/sound/break_sound = sound(null, 0, 0, SOUND_CHANNEL_WALKMAN)
	break_sound.priority = 255
	update_song(break_sound, current_listener, 0)

/obj/item/device/walkman/proc/update_song(sound/S, mob/M, flags = SOUND_UPDATE)
	if(!istype(M) || !istype(S))
		return
	if(M.ear_deaf > 0)
		flags |= SOUND_MUTE
	S.status = flags
	S.volume = src.volume
	S.channel = SOUND_CHANNEL_WALKMAN
	sound_to(M,S)

/obj/item/device/walkman/proc/pause(mob/user)
	if(!current_song)
		return
	paused = TRUE
	update_song(current_song,current_listener, SOUND_PAUSED | SOUND_UPDATE)

/obj/item/device/walkman/proc/play()
	if(!current_song)
		if(length(current_playlist) > 0)
			current_song = sound(current_playlist[pl_index], 0, 0, SOUND_CHANNEL_WALKMAN, volume)
			current_song.status = SOUND_STREAM
		else
			return
	paused = FALSE
	if(current_song.status & SOUND_PAUSED)
		to_chat(current_listener,SPAN_INFO("恢复播放 [pl_index] / [length(current_playlist)]"))
		update_song(current_song,current_listener)
	else
		to_chat(current_listener,SPAN_INFO("正在播放 [pl_index] / [length(current_playlist)]"))
		update_song(current_song,current_listener,0)

	update_song(current_song,current_listener)

/obj/item/device/walkman/proc/insert_tape(obj/item/device/cassette_tape/CT)
	if(tape || !istype(CT))
		return

	tape = CT
	if(ishuman(CT.loc))
		var/mob/living/carbon/human/H = CT.loc
		H.drop_held_item(CT)
	CT.forceMove(src)

	update_icon()
	paused = TRUE
	pl_index = 1
	if(tape.songs["side1"] && tape.songs["side2"])
		var/list/L = tape.songs["[tape.flipped ? "side2" : "side1"]"]
		for(var/S in L)
			current_playlist += S
			current_songnames += L[S]


/obj/item/device/walkman/proc/eject_tape(mob/user)
	if(!tape)
		return

	break_sound()

	current_song = null
	current_playlist.Cut()
	current_songnames.Cut()
	user.put_in_hands(tape)
	paused = TRUE
	tape = null
	update_icon()
	playsound(src,'sound/weapons/handcuffs.ogg',20,1)
	to_chat(user,SPAN_INFO("你从[src]中弹出磁带。"))

/obj/item/device/walkman/proc/next_song(mob/user)

	if(user.is_mob_incapacitated() || length(current_playlist) == 0)
		return

	break_sound()

	if(pl_index + 1 <= length(current_playlist))
		pl_index++
	else
		pl_index = 1
	current_song = sound(current_playlist[pl_index], 0, 0, SOUND_CHANNEL_WALKMAN, volume)
	current_song.status = SOUND_STREAM
	play()
	to_chat(user,SPAN_INFO("你切换了歌曲。"))


/obj/item/device/walkman/update_icon()
	..()
	overlays.Cut()
	if(design)
		overlays += "+[design]"
	if(tape)
		if(!paused)
			overlays += "+playing"
	else
		overlays += "+empty"

	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.regenerate_icons()

/obj/item/device/walkman/get_mob_overlay(mob/user_mob, slot, default_bodytype = "默认")
	var/image/ret = ..()
	if((slot == WEAR_L_EAR || slot == WEAR_R_EAR) && !paused)
		var/image/I = overlay_image(ret.icon, "+music", color, RESET_COLOR)
		ret.overlays += I
	return ret

/obj/item/device/walkman/process()
	if(!(src in current_listener.GetAllContents(3)) || current_listener.stat & DEAD)
		if(current_song)
			current_song = null
		break_sound()
		paused = TRUE
		current_listener = null
		update_icon()
		STOP_PROCESSING(SSobj, src)
		return

	if(current_listener.ear_deaf > 0 && current_song && !(current_song.status & SOUND_MUTE))
		update_song(current_song, current_listener)
	if(current_listener.ear_deaf == 0 && current_song && current_song.status & SOUND_MUTE)
		update_song(current_song, current_listener)

/obj/item/device/walkman/verb/play_pause()
	set name = "播放/暂停"
	set category = "Object"
	set src in usr

	if(usr.is_mob_incapacitated())
		return

	attack_self(usr)

/obj/item/device/walkman/verb/eject_cassetetape()
	set name = "Eject tape"
	set category = "Object"
	set src in usr

	eject_tape(usr)

/obj/item/device/walkman/verb/next_pl_song()
	set name = "下一首"
	set category = "Object"
	set src in usr

	next_song(usr)

/obj/item/device/walkman/verb/change_volume()
	set name = "Change Walkman volume"
	set category = "Object"
	set src in usr

	if(usr.is_mob_incapacitated() || !current_song)
		return

	var/tmp = tgui_input_number(usr,"调整音量 (0 - 100)","Volume", volume, 100, 0)
	if(tmp == null)
		return
	if(tmp > 100)
		tmp = 100
	if(tmp < 0)
		tmp = 0
	volume = tmp
	update_song(current_song, current_listener)

/obj/item/device/walkman/proc/restart_song(mob/user)
	if(user.is_mob_incapacitated() || !current_song)
		return

	update_song(current_song, current_listener, 0)
	to_chat(user,SPAN_INFO("你重新播放了歌曲。"))

/obj/item/device/walkman/verb/restart_current_song()
	set name = "Restart Song"
	set category = "Object"
	set src in usr

	restart_song(usr)

/*

	ACTION BUTTONS

*/

/datum/action/item_action/walkman

/datum/action/item_action/walkman/New()
	..()
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/walkman/update_button_icon()
	return

/datum/action/item_action/walkman/play_pause
	action_icon_state = "walkman_playpause"

/datum/action/item_action/walkman/play_pause/New()
	..()
	name = "播放/暂停"
	button.name = name

/datum/action/item_action/walkman/play_pause/action_activate()
	. = ..()
	if(target)
		var/obj/item/device/walkman/WM = target
		WM.attack_self(owner)

/datum/action/item_action/walkman/next_song
	action_icon_state = "walkman_next"

/datum/action/item_action/walkman/next_song/New()
	..()
	name = "下一首"
	button.name = name

/datum/action/item_action/walkman/next_song/action_activate()
	. = ..()
	if(target)
		var/obj/item/device/walkman/WM = target
		WM.next_song(owner)

/datum/action/item_action/walkman/restart_song
	action_icon_state = "walkman_restart"

/datum/action/item_action/walkman/restart_song/New()
	..()
	name = "重新播放"
	button.name = name

/datum/action/item_action/walkman/restart_song/action_activate()
	. = ..()
	if(target)
		var/obj/item/device/walkman/WM = target
		WM.restart_song(owner)

/*
	TAPES
*/
/obj/item/device/cassette_tape
	name = "盒式磁带"
	desc = "一盒盒式磁带。"
	icon = 'icons/obj/items/walkman.dmi'
	icon_state = "cassette_flip"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/walkman.dmi',
		)
	w_class = SIZE_SMALL
	flags_obj = OBJ_IS_HELMET_GARB
	black_market_value = 15
	var/side1_icon = "cassette"
	var/flipped = FALSE //Tape side
	var/list/songs = list()
	var/id = 1

/obj/item/device/cassette_tape/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/synsound)

/obj/item/device/cassette_tape/attack_self(mob/user)
	..()

	if(flipped == TRUE)
		flipped = FALSE
		icon_state = side1_icon
	else
		flipped = TRUE
		icon_state = "cassette_flip"
	to_chat(user,"你翻转了[src]")

/obj/item/device/cassette_tape/verb/flip()
	set name = "Flip tape"
	set category = "Object"
	set src in usr

	attack_self()

/obj/item/device/cassette_tape/pop1
	name = "蓝色磁带"
	id = 2
	desc = "一盒贴有蓝色标签的塑料盒式磁带。"
	icon_state = "cassette_blue"
	side1_icon = "cassette_blue"
	songs = list("side1" = list("sound/music/walkman/pop1/1-1-1.ogg",\
								"sound/music/walkman/pop1/1-1-2.ogg",\
								"sound/music/walkman/pop1/1-1-3.ogg"),\
				"side2" = list("sound/music/walkman/pop1/1-2-1.ogg",\
								"sound/music/walkman/pop1/1-2-2.ogg",\
								"sound/music/walkman/pop1/1-2-3.ogg"))

/obj/item/device/cassette_tape/pop2
	name = "彩虹磁带"
	id = 3
	desc = "一盒贴有彩虹色标签的塑料盒式磁带。"
	icon_state = "cassette_rainbow"
	side1_icon = "cassette_rainbow"
	songs = list("side1" = list("sound/music/walkman/pop2/2-1-1.ogg",\
								"sound/music/walkman/pop2/2-1-2.ogg",\
								"sound/music/walkman/pop2/2-1-3.ogg"),\
				"side2" = list("sound/music/walkman/pop2/2-2-1.ogg",\
								"sound/music/walkman/pop2/2-2-2.ogg",\
								"sound/music/walkman/pop2/2-2-3.ogg"))

/obj/item/device/cassette_tape/pop3
	name = "橙色磁带"
	id = 4
	desc = "一盒贴有橙色标签的塑料盒式磁带。"
	icon_state = "cassette_orange"
	side1_icon = "cassette_orange"
	songs = list("side1" = list("sound/music/walkman/pop3/3-1-1.ogg",\
								"sound/music/walkman/pop3/3-1-2.ogg",\
								"sound/music/walkman/pop3/3-1-3.ogg"),\
				"side2" = list("sound/music/walkman/pop3/3-2-1.ogg",\
								"sound/music/walkman/pop3/3-2-2.ogg",\
								"sound/music/walkman/pop3/3-2-3.ogg"))

/obj/item/device/cassette_tape/pop4
	name = "粉色磁带"
	id = 5
	desc = "一盒贴有粉色条纹标签的塑料盒式磁带。"
	icon_state = "cassette_pink_stripe"
	side1_icon = "cassette_pink_stripe"
	songs = list("side1" = list("sound/music/walkman/pop4/4-1-1.ogg",\
								"sound/music/walkman/pop4/4-1-2.ogg",\
								"sound/music/walkman/pop4/4-1-3.ogg"),\
				"side2" = list("sound/music/walkman/pop4/4-2-1.ogg",\
								"sound/music/walkman/pop4/4-2-2.ogg",\
								"sound/music/walkman/pop4/4-2-3.ogg"))

/obj/item/device/cassette_tape/heavymetal
	name = "红黑磁带"
	id = 6
	desc = "一盒贴有红黑标签的塑料盒式磁带。"
	icon_state = "cassette_red_black"
	side1_icon = "cassette_red_black"
	songs = list("side1" = list("sound/music/walkman/heavymetal/5-1-1.ogg",\
								"sound/music/walkman/heavymetal/5-1-2.ogg",\
								"sound/music/walkman/heavymetal/5-1-3.ogg"),\
				"side2" = list("sound/music/walkman/heavymetal/5-2-1.ogg",\
								"sound/music/walkman/heavymetal/5-2-2.ogg",\
								"sound/music/walkman/heavymetal/5-2-3.ogg"))

/obj/item/device/cassette_tape/hairmetal
	name = "红色条纹磁带"
	id = 7
	desc = "一盘塑料磁带，上面贴着一张带有红色条纹的灰色贴纸。"
	icon_state = "cassette_red_stripe"
	side1_icon = "cassette_red_stripe"
	songs = list("side1" = list("sound/music/walkman/hairmetal/6-1-1.ogg",\
								"sound/music/walkman/hairmetal/6-1-2.ogg",\
								"sound/music/walkman/hairmetal/6-1-3.ogg"),\
				"side2" = list("sound/music/walkman/hairmetal/6-2-1.ogg",\
								"sound/music/walkman/hairmetal/6-2-2.ogg",\
								"sound/music/walkman/hairmetal/6-2-3.ogg"))

/obj/item/device/cassette_tape/indie
	name = "旭日磁带"
	id = 8
	desc = "一盘印有日本旭日图案的塑料磁带。"
	icon_state = "cassette_rising_sun"
	side1_icon = "cassette_rising_sun"
	songs = list("side1" = list("sound/music/walkman/indie/7-1-1.ogg",\
								"sound/music/walkman/indie/7-1-2.ogg",\
								"sound/music/walkman/indie/7-1-3.ogg"),\
				"side2" = list("sound/music/walkman/indie/7-2-1.ogg",\
								"sound/music/walkman/indie/7-2-2.ogg",\
								"sound/music/walkman/indie/7-2-3.ogg"))

/obj/item/device/cassette_tape/hiphop
	name = "蓝色条纹磁带"
	id = 9
	desc = "一盘带有蓝色条纹的橙色塑料磁带。"
	icon_state = "cassette_orange_blue"
	side1_icon = "cassette_orange_blue"
	songs = list("side1" = list("sound/music/walkman/hiphop/8-1-1.ogg",\
								"sound/music/walkman/hiphop/8-1-2.ogg",\
								"sound/music/walkman/hiphop/8-1-3.ogg"),\
				"side2" = list("sound/music/walkman/hiphop/8-2-1.ogg",\
								"sound/music/walkman/hiphop/8-2-2.ogg",\
								"sound/music/walkman/hiphop/8-2-3.ogg"))

/obj/item/device/cassette_tape/nam
	name = "绿色磁带"
	id = 10
	desc = "一盘绿色塑料磁带。"
	icon_state = "cassette_green"
	side1_icon = "cassette_green"
	songs = list("side1" = list("sound/music/walkman/nam/9-1-1.ogg",\
								"sound/music/walkman/nam/9-1-2.ogg",\
								"sound/music/walkman/nam/9-1-3.ogg"),\
				"side2" = list("sound/music/walkman/nam/9-2-1.ogg",\
								"sound/music/walkman/nam/9-2-2.ogg",\
								"sound/music/walkman/nam/9-2-3.ogg"))

/obj/item/device/cassette_tape/ocean
	name = "海洋磁带"
	id = 11
	desc = "一盘蓝白相间的塑料磁带。"
	icon_state = "cassette_ocean"
	side1_icon = "cassette_ocean"
	songs = list("side1" = list("sound/music/walkman/surf/10-1-1.ogg",\
								"sound/music/walkman/surf/10-1-2.ogg",\
								"sound/music/walkman/surf/10-1-3.ogg",\
								"sound/music/walkman/surf/10-1-4.ogg"),\
				"side2" = list("sound/music/walkman/surf/10-2-1.ogg",\
								"sound/music/walkman/surf/10-2-2.ogg",\
								"sound/music/walkman/surf/10-2-3.ogg",\
								"sound/music/walkman/surf/10-2-4.ogg"))

// hotline reference
/obj/item/device/cassette_tape/aesthetic
	name = "美学磁带"
	id = 12
	desc = "一盘外观颇具美感的磁带。正面写着'夹克'。"
	icon_state = "cassette_aesthetic"
	side1_icon = "cassette_aesthetic"

//cassette tape that I thought was a good idea but doesnt fit for new maps.
/obj/item/device/cassette_tape/cargocrate
	name = "维兰德-汤谷磁带"
	id = 13
	desc = "一盘带有维兰德-汤谷标志的蓝色金属磁带。"
	icon_state = "cassette_wy"
	side1_icon = "cassette_wy"

// cassette tapes for map lore
/obj/item/device/cassette_tape/solaris
	name = "红色UCP磁带"
	id = 14
	desc = "一盘带有红色UCP迷彩图案的磁带。"
	icon_state = "cassette_solaris"
	side1_icon = "cassette_solaris"


/obj/item/device/cassette_tape/icecolony
	name = "冰冻磁带"
	id = 15
	desc = "一盘磁带。上面覆盖着冰雪。"
	icon_state = "cassette_ice"
	side1_icon = "cassette_ice"

/obj/item/device/cassette_tape/lz
	name = "怀旧磁带"
	id = 16
	desc = "这盘磁带上用胶带贴着一张剪开的明信片。你知道这个地方。"
	icon_state = "cassette_lz"
	side1_icon = "cassette_lz"

/obj/item/device/cassette_tape/desertdam
	name = "大坝磁带"
	id = 17
	desc = "这盘磁带上附着一张水坝的照片。"
	icon_state = "cassette_dam"
	side1_icon = "cassette_dam"

/obj/item/device/cassette_tape/prison
	name = "破损磁带"
	id = 18
	desc = "这盘磁带的外壳破损了，不过看起来还能用！"
	icon_state = "cassette_worstmap"
	side1_icon = "cassette_worstmap"
