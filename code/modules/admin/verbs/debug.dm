/client/proc/Cell()
	set category = "Debug"
	set name = "Cell"
	if(!mob)
		return
	var/turf/T = mob.loc

	if (!( istype(T, /turf) ))
		return

	var/list/air_info = T.return_air()

	var/t = SPAN_NOTICE("Coordinates: [T.x],[T.y],[T.z]\n")
	t += SPAN_DANGER("Temperature: [air_info[2]]\n")
	t += SPAN_DANGER("Pressure: [air_info[3]]kPa\n")
	t += SPAN_NOTICE("Gas Type: [air_info[1]]\n")

	usr.show_message(t, SHOW_MESSAGE_VISIBLE)


/client/proc/cmd_admin_animalize(mob/M in GLOB.mob_list)
	set category = null
	set name = "Make Simple Animal"

	if(!SSticker.mode)
		alert("请等待游戏开始")
		return

	if(!M)
		alert("该单位似乎不存在，请关闭面板重试。")
		return

	if(istype(M, /mob/new_player))
		alert("单位不能是新玩家。")
		return

	log_admin("[key_name(src)] has animalized [M.key].")
	spawn(10)
		M.Animalize()

/client/proc/cmd_admin_alienize(mob/M in GLOB.mob_list)
	set category = null
	set name = "Make Alien"

	if(!SSticker.mode)
		alert("请等待游戏开始")
		return
	if(ishuman(M))
		log_admin("[key_name(src)] has alienized [M.key].")
		spawn(10)
			M:Alienize()

		message_admins("[key_name_admin(usr)] made [key_name(M)] into an alien.")
	else
		alert("无效单位")

/client/proc/cmd_admin_change_hivenumber()
	set category = "Debug"
	set name = "更改巢穴编号"

	var/mob/living/carbon/X = tgui_input_list(src,"选择一个异形。", "更改巢穴编号", GLOB.living_xeno_list)
	if(!istype(X))
		to_chat(usr, "此操作仅能对 /mob/living/carbon 类型的实例执行。")
		return

	cmd_admin_change_their_hivenumber(X)

/client/proc/cmd_debug_toggle_should_check_for_win()
	set category = "Debug"
	set name = "Toggle Round End Checks"

	if(!SSticker.mode)
		to_chat(usr, "未找到模式？")
	GLOB.round_should_check_for_win = !GLOB.round_should_check_for_win
	if (GLOB.round_should_check_for_win)
		message_admins("[key_name(src)] enabled checking for round-end.")
	else
		message_admins("[key_name(src)] disabled checking for round-end.")

/client/proc/cmd_debug_mass_screenshot()
	set category = "Debug"
	set name = "Mass Screenshot"
	set background = TRUE
	set waitfor = FALSE

	if(!check_rights(R_MOD))
		return

	if(tgui_alert(usr, "你确定要对此Z层级进行批量截图吗？请先确保你的视觉设置正确（其他幽灵可见性、缩放等级等），并已清空你的BYOND/screenshots文件夹。", "Mass Screenshot", list("Yes", "No")) != "Yes")
		return

	var/sleep_duration = tgui_input_number(usr, "输入截图之间的延迟（以十分之一秒为单位），以便客户端渲染变化。", "Screenshot delay", 2, 10, 1, 0, TRUE)
	if(!sleep_duration)
		return

	if(!mob)
		return

	if(!isobserver(mob))
		admin_ghost()

	mob.alpha = 0
	if(mob.hud_used)
		mob.hud_used.show_hud(HUD_STYLE_NOHUD)
	mob.animate_movement = NO_STEPS

	message_admins(WRAP_STAFF_LOG(usr, "started a mass screenshot operation."))

	var/half_chunk_size = view + 1
	var/chunk_size = half_chunk_size * 2 - 1
	var/cur_x = half_chunk_size
	var/cur_y = half_chunk_size
	var/cur_z = mob.z
	var/width
	var/height
	var/offset_x = 0
	var/offset_y = 0
	if(istype(SSmapping.z_list[cur_z], /datum/space_level))
		var/datum/space_level/cur_level = SSmapping.z_list[cur_z]
		offset_x = cur_level.bounds[MAP_MINX] - 1
		cur_x += offset_x
		offset_y = cur_level.bounds[MAP_MINY] - 1
		cur_y += offset_y
		width = cur_level.bounds[MAP_MAXX] - cur_level.bounds[MAP_MINX] - half_chunk_size + 3
		height = cur_level.bounds[MAP_MAXY] - cur_level.bounds[MAP_MINY] - half_chunk_size + 3
	else
		width = world.maxx - half_chunk_size + 2
		height = world.maxy - half_chunk_size + 2
	var/width_inside = width - 1 + offset_x
	var/height_inside = height - 1 + offset_y

	while(cur_y < height + offset_y)
		while(cur_x < width + offset_x)
			mob.on_mob_jump()
			mob.forceMove(locate(cur_x, cur_y, cur_z))
			sleep(sleep_duration)
			winset(src, null, "command='.screenshot auto'")
			if(cur_x == width_inside)
				break
			cur_x += chunk_size
			cur_x = min(cur_x, width_inside)
		if(cur_y == height_inside)
			break
		cur_x = half_chunk_size
		cur_y += chunk_size
		cur_y = min(cur_y, height_inside)

	mob.alpha = initial(mob.alpha)
	if(mob.hud_used)
		mob.hud_used.show_hud(HUD_STYLE_STANDARD)
	mob.animate_movement = SLIDE_STEPS // Initial is incorrect

	to_chat(usr, "当被要求提供MapTileImageTool时，请提供这些值：[width] [height] [half_chunk_size] [world.icon_size]")

//TODO: merge the vievars version into this or something maybe mayhaps
/client/proc/cmd_debug_del_all()
	set category = "Debug"
	set name = "Delete Instance"

	// to prevent REALLY stupid deletions
	var/blocked = list(/obj, /obj/item, /obj/effect, /obj/structure/machinery, /mob, /mob/living, /mob/living/carbon, /mob/living/carbon/xenomorph, /mob/living/carbon/human, /mob/dead, /mob/dead/observer, /mob/living/silicon, /mob/living/silicon/ai)
	var/chosen_deletion = input(usr, "输入你想删除的对象的路径", "Delete:") as null|text
	if(chosen_deletion)
		chosen_deletion = text2path(chosen_deletion)
		if(ispath(chosen_deletion))
			var/hsbitem = tgui_input_list(usr, "选择要删除的对象。", "Delete:", typesof(chosen_deletion))
			if(hsbitem)
				var/do_delete = 1
				if(hsbitem in blocked)
					if(alert("Are you REALLY sure you wish to delete all instances of [hsbitem]? This will lead to catastrophic results!",,"Yes","No") != "Yes")
						do_delete = 0
				var/del_amt = 0
				if(do_delete)
					var/is_turf = ispath(hsbitem, /turf)
					for(var/atom/O in world)
						if(istype(O, hsbitem))
							if(is_turf)
								var/turf/T = O
								T.ScrapeAway()
							else
								qdel(O)
							del_amt++
					message_admins("[key_name_admin(src)] has deleted all instances of [hsbitem] ([del_amt]).", 0)
		else
			to_chat(usr, SPAN_WARNING("不是有效的类型路径。"))

/client/proc/cmd_debug_make_powernets()
	set category = "Debug"
	set name = "Generate Powernets"
	if(alert("你确定要执行此操作吗？",, "Yes", "No") != "Yes")
		return
	makepowernets()
	message_admins("[key_name_admin(src)] has remade the powernets. makepowernets() called.", 0)


/client/proc/cmd_admin_grantfullaccess(mob/M in GLOB.mob_list)
	set category = null
	set name = "Grant Global Access"

	if(!check_rights(R_DEBUG|R_ADMIN))
		return

	if (!SSticker.mode)
		alert("请等待游戏开始")
		return
	if (istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		var/obj/item/card/id/id = H.get_idcard()
		if(id)
			id.icon_state = "gold"
			id.access = get_access(ACCESS_LIST_GLOBAL)
		else
			id = new(M)
			id.icon_state = "gold"
			id.access = get_access(ACCESS_LIST_GLOBAL)
			id.registered_name = H.real_name
			id.registered_ref = WEAKREF(H)
			id.assignment = "上尉"
			id.name = "[id.registered_name]'s [id.id_type] ([id.assignment])"
			H.equip_to_slot_or_del(id, WEAR_ID)
			H.update_inv_wear_id()
	else
		alert("无效单位")

	message_admins("[key_name_admin(usr)] has granted [M.key] global access.")

/client/proc/cmd_admin_grantallskills(mob/M in GLOB.mob_list)
	set category = null
	set name = "Give Null Skills"

	if(!check_rights(R_DEBUG|R_ADMIN))
		return

	if(!SSticker.mode)
		alert("请等待游戏开始")
		return
	if(M)
		M.skills = null // No restrictions
	else
		alert("无效单位")

	message_admins("[key_name_admin(usr)] has given [M.key] null skills.")

/client/proc/admin_create_account(mob/target in GLOB.mob_list)
	set category = null
	set name = "Create Bank Account"

	if(!ishuman(target))
		to_chat(src, SPAN_WARNING("This only works on humans."))
		return

	var/mob/living/carbon/human/account_user = target

	if(account_user.mind?.initial_account)
		var/warning = tgui_alert(src, "他们已有一个账户，继续操作将删除该账户。你确定要继续吗？", "确认", list("Proceed", "Cancel"))
		if(warning != "Proceed")
			return
		else
			QDEL_NULL(account_user.mind.initial_account)

	var/datum/money_account/generated_account

	var/starting_amount = tgui_input_number(src, "他们应以多少资金开始？", "Pick starting amount", 30, 100000, 0)
	if(!starting_amount)
		starting_amount = 0

	var/custom_paygrade = tgui_input_list(src, "选择账户的军衔等级", "Account paygrade", GLOB.paygrades)
	if(!custom_paygrade)
		to_chat(src, SPAN_WARNING("他们必须有一个军衔等级！"))
		return


	var/datum/paygrade/account_paygrade = GLOB.paygrades[custom_paygrade]
	var/obj/item/card/id/card = account_user.get_idcard()
	generated_account = create_account(account_user.real_name, starting_amount, account_paygrade)
	if(card)
		card.associated_account_number = generated_account.account_number
		card.paygrade = account_paygrade.paygrade
	if(account_user.mind)
		var/remembered_info = ""
		remembered_info += "<b>Your account number is:</b> #[generated_account.account_number]<br>"
		remembered_info += "<b>Your account pin is:</b> [generated_account.remote_access_pin]<br>"
		remembered_info += "<b>Your account funds are:</b> $[generated_account.money]<br>"

		if(length(generated_account.transaction_log))
			var/datum/transaction/T = generated_account.transaction_log[1]
			remembered_info += "<b>Your account was created:</b> [T.time], [T.date] at [T.source_terminal]<br>"
		account_user.mind.store_memory(remembered_info)
		account_user.mind.initial_account = generated_account

	log_admin("[key_name(usr)] has created a new bank account for [key_name(account_user)].")

/client/proc/cmd_assume_direct_control(mob/M in GLOB.mob_list)
	set name = "Control Mob"
	set desc = "Assume control of the mob."
	set category = null

	if(!check_rights(R_DEBUG|R_ADMIN))
		return

	if(QDELETED(M))
		return //mob is garbage collected

	if(M.ckey)
		if(alert("This mob is being controlled by [M.ckey]. Are you sure you wish to assume control of it? [M.ckey] will be made a ghost.",,"Yes","No") != "Yes")
			return

		M.ghostize()

	if(M.mind)
		if(M.mind.player_entity)
			M.track_death_calculations()
		M.mind.player_entity = setup_player_entity(src.ckey)
		M.statistic_tracked = FALSE

	usr.mind.transfer_to(M, TRUE)

	message_admins("[key_name_admin(usr)] assumed direct control of [M].")

/client/proc/cmd_debug_list_processing_items()
	set category = "Debug.Controllers"
	set name = "List Processing Items"
	set desc = "For scheduler debugging."

	var/list/individual_counts = list()
	for(var/datum/disease/M in SSdisease.all_diseases)
		individual_counts["[M.type]"]++
	for(var/mob/M in SShuman.processable_human_list)
		individual_counts["[M.type]"]++
	for(var/obj/structure/machinery/M in GLOB.processing_machines)
		individual_counts["[M.type]"]++
	for(var/datum/powernet/M in GLOB.powernets)
		individual_counts["[M.type]"]++
	for(var/mob/M in SSmob.living_misc_mobs)
		individual_counts["[M.type]"]++
	for(var/datum/nanoui/M in SSnano.nanomanager.processing_uis)
		individual_counts["[M.type]"]++
	for(var/datum/powernet/M in GLOB.powernets)
		individual_counts["[M.type]"]++
	for(var/datum/M in GLOB.power_machines)
		individual_counts["[M.type]"]++
	for(var/mob/M in GLOB.xeno_mob_list)
		individual_counts["[M.type]"]++

	var/str = ""
	for(var/tmp in individual_counts)
		str += "[tmp],[individual_counts[tmp]]<BR>"


	show_browser(usr, "<TT>[str]</TT>", "Ticker Count", "tickercount")

/client/proc/allow_browser_inspect()
	set category = "Debug"
	set name = "Allow Browser Inspect"
	set desc = "Allow browser debugging via inspect."

	if(!check_rights(R_DEBUG) || !isclient(src))
		return

	if(byond_version < 516)
		to_chat(src, SPAN_WARNING("你只能在516上使用此功能！"))
		return

	to_chat(src, SPAN_INFO("你现在可以在浏览器上右键使用检查功能。"))
	winset(src, null, list("browser-options" = "+devtools"))
	winset(src, null, list("browser-options" = "+find"))
	winset(src, null, list("browser-options" = "+refresh"))

#ifdef TESTING
GLOBAL_LIST_EMPTY(dirty_vars)

/client/proc/see_dirty_varedits()
	set category = "Debug.Mapping"
	set name = "Dirty Varedits"

	var/list/dat = list()
	dat += "<h3>Abandon all hope ye who enter here</h3><br><br>"
	for(var/thing in GLOB.dirty_vars)
		dat += "[thing]<br>"
		CHECK_TICK
	var/datum/browser/popup = new(usr, "dirty_vars", "Dirty Varedits", nwidth = 900, nheight = 750)
	popup.set_content(dat.Join())
	popup.open()
#endif
