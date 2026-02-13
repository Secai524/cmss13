/client/proc/usr_create_new_clan()
	set name = "Create New Clan"
	set category = "Debug"

	if(!clan_info)
		return

	if(!(clan_info.permissions & CLAN_PERMISSION_ADMIN_MANAGER))
		return

	var/input = input(src, "为氏族命名：", "Create a Clan") as text|null

	if(!input)
		return

	to_chat(src, SPAN_NOTICE("创建了新氏族：[input]"))

	create_new_clan(input)

CLIENT_VERB(view_clan_info)
	set name = "View Clan Info"
	set category = "OOC.Records"

	INVOKE_ASYNC(src, PROC_REF(usr_view_clan_info))

/client/proc/usr_view_clan_info(clan_id, force_clan_id = FALSE)
	var/clan_to_get

	if(!has_clan_permission(CLAN_PERMISSION_VIEW))
		return

	if(!clan_id && !force_clan_id)
		if(!clan_info)
			to_chat(src, SPAN_WARNING("你没有铁血战士白名单权限！"))
			return

		if(clan_info.permissions & CLAN_PERMISSION_ADMIN_VIEW)
			var/list/datum/view_record/clan_view/CPV = DB_VIEW(/datum/view_record/clan_view/)

			var/clans = list()
			for(var/datum/view_record/clan_view/CV in CPV)
				clans += list("[CV.name]" = CV.clan_id)

			clans += list("People without clans" = null)

			var/input = tgui_input_list(src, "选择要查看的氏族", "View clan", clans)

			if(!input)
				to_chat(src, SPAN_WARNING("找不到任何可供你查看的氏族！"))
				return

			clan_to_get = clans[input]
		else if(clan_info.clan_id)

			var/options = list(
				"Your clan" = clan_info.clan_id,
				"People without clans" = null
			)

			var/input = tgui_input_list(src, "选择要查看的氏族", "View clan", options)

			if(!input)
				return

			clan_to_get = options[input]
		else
			clan_to_get = null
	else
		clan_to_get = clan_id

	var/datum/entity/clan/C
	var/list/datum/view_record/clan_playerbase_view/CPV

	if(clan_to_get)
		C = GET_CLAN(clan_to_get)
		C.sync()
		CPV = DB_VIEW(/datum/view_record/clan_playerbase_view, DB_COMP("clan_id", DB_EQUALS, clan_to_get))
	else
		CPV = DB_VIEW(/datum/view_record/clan_playerbase_view, DB_COMP("clan_id", DB_IS, clan_to_get))

	var/list/data

	var/player_rank = clan_info.clan_rank

	if(clan_info.permissions & CLAN_PERMISSION_ADMIN_MANAGER)
		player_rank = 999 // Target anyone except other managers

	if(C)
		data = list(
			clan_id = C.id,
			clan_name = html_encode(C.name),
			clan_description = html_encode(C.description),
			clan_honor = C.honor,
			clan_keys = list(),

			player_rank_pos = player_rank,

			player_delete_clan = (clan_info.permissions & CLAN_PERMISSION_ADMIN_MANAGER),
			player_sethonor_clan = (clan_info.permissions & CLAN_PERMISSION_ADMIN_MANAGER),
			player_setcolor_clan = (clan_info.permissions & CLAN_PERMISSION_ADMIN_MODIFY),

			player_rename_clan = (clan_info.permissions & CLAN_PERMISSION_ADMIN_MODIFY),
			player_setdesc_clan = (clan_info.permissions & CLAN_PERMISSION_MODIFY),
			player_modify_ranks = (clan_info.permissions & CLAN_PERMISSION_MODIFY),

			player_purge = (clan_info.permissions & CLAN_PERMISSION_ADMIN_MANAGER),
			player_move_clans = (clan_info.permissions & CLAN_PERMISSION_ADMIN_MOVE)
		)
	else
		data = list(
			clan_id = null,
			clan_name = "Players without a clan",
			clan_description = "This is a list of players without a clan",
			clan_honor = null,
			clan_keys = list(),

			player_rank_pos = player_rank,

			player_delete_clan = FALSE,
			player_sethonor_clan = FALSE,
			player_rename_clan = FALSE,
			player_setdesc_clan = FALSE,
			player_modify_ranks = FALSE,

			player_purge = (clan_info.permissions & CLAN_PERMISSION_ADMIN_MANAGER),
			player_move_clans = (clan_info.permissions & CLAN_PERMISSION_ADMIN_MOVE)
		)

	var/list/clan_members[length(CPV)]

	var/index = 1
	for(var/datum/view_record/clan_playerbase_view/CP in CPV)
		var/rank_to_give = CP.clan_rank

		if(CP.permissions & CLAN_PERMISSION_ADMIN_MANAGER)
			rank_to_give = 999

		var/list/player = list(
			player_id = CP.player_id,
			name = CP.ckey,
			rank = GLOB.clan_ranks[CP.clan_rank], // rank_to_give not used here, because we need to get their visual rank, not their position
			rank_pos = rank_to_give,
			honor = (CP.honor? CP.honor : 0)
		)

		clan_members[index++] = player

	data["clan_keys"] = clan_members

	var/datum/nanoui/ui = SSnano.nanomanager.try_update_ui(mob, mob, "clan_status_ui", null, data)
	if(!ui)
		ui = new(mob, mob, "clan_status_ui", "clan_menu.tmpl", "Clan Menu", 550, 500)
		ui.set_initial_data(data)
		ui.set_auto_update(FALSE)
		ui.open()

/client/proc/has_clan_permission(permission_flag, clan_id, warn)
	if(!clan_info)
		if(warn)
			to_chat(src, "你没有铁血战士白名单权限！")
		return FALSE

	if(clan_id)
		if(clan_id != clan_info.clan_id)
			if(warn)
				to_chat(src, "你无权对此氏族执行操作！")
			return FALSE


	if(!(clan_info.permissions & permission_flag))
		if(warn)
			to_chat(src, "你没有执行此操作的必要权限！")
		return FALSE

	return TRUE

/client/proc/add_honor(number)
	if(!clan_info)
		return FALSE
	clan_info.sync()

	clan_info.honor = max(number + clan_info.honor, 0)
	clan_info.save()

	if(clan_info.clan_id)
		var/datum/entity/clan/target_clan = GET_CLAN(clan_info.clan_id)
		target_clan.sync()

		target_clan.honor = max(number + target_clan.honor, 0)

		target_clan.save()

	return TRUE

/client/proc/clan_topic(href, href_list)
	set waitfor = FALSE

	if(usr.client != src)
		return

	if(!clan_info)
		return

	clan_info.sync() // Make sure permissions/clan is accurate

	if(href_list[CLAN_HREF])
		var/datum/entity/clan/target_clan = GET_CLAN(href_list[CLAN_HREF])
		target_clan.sync()

		switch(href_list[CLAN_ACTION])
			if(CLAN_ACTION_CLAN_RENAME)
				if(!has_clan_permission(CLAN_PERMISSION_ADMIN_MODIFY))
					return

				var/input = input(src, "输入新名称", "设置名称", target_clan.name) as text|null

				if(!input || input == target_clan.name)
					return


				message_admins("[key_name_admin(src)] has set the name of [target_clan.name] to [input].")
				to_chat(src, SPAN_NOTICE("已将[target_clan.name]的名称设置为[input]。"))
				target_clan.name = trim(input)

			if(CLAN_ACTION_CLAN_SETDESC)
				if(!has_clan_permission(CLAN_PERMISSION_USER_MODIFY))
					return

				var/input = input(usr, "输入新描述", "Set Description", target_clan.description) as message|null

				if(!input || input == target_clan.description)
					return

				message_admins("[key_name_admin(src)] has set the description of [target_clan.name].")
				to_chat(src, SPAN_NOTICE("已设置[target_clan.name]的描述。"))
				target_clan.description = trim(input)

			if(CLAN_ACTION_CLAN_SETCOLOR)
				if(!has_clan_permission(CLAN_PERMISSION_ADMIN_MODIFY))
					return

				var/color = input(usr, "输入新颜色", "Set Color", target_clan.color) as color|null

				if(!color)
					return

				target_clan.color = color
				message_admins("[key_name_admin(src)] has set the color of [target_clan.name] to [color].")
				to_chat(src, SPAN_NOTICE("已将[target_clan.name]的名称设置为[color]。"))
			if(CLAN_ACTION_CLAN_SETHONOR)
				if(!has_clan_permission(CLAN_PERMISSION_ADMIN_MANAGER))
					return

				var/input = tgui_input_number(src, "输入新的荣誉值", "Set Honor", target_clan.honor)

				if((!input && input != 0) || input == target_clan.honor)
					return

				message_admins("[key_name_admin(src)] has set the honor of clan [target_clan.name] from [target_clan.honor] to [input].")
				to_chat(src, SPAN_NOTICE("已将[target_clan.name]的荣誉值从[target_clan.honor]更改为[input]。"))
				target_clan.honor = input

			if(CLAN_ACTION_CLAN_DELETE)
				if(!has_clan_permission(CLAN_PERMISSION_ADMIN_MANAGER))
					return

				var/input = input(src, "请输入氏族名称以继续。", "Delete Clan") as text|null

				if(input != target_clan.name)
					to_chat(src, "你已决定不删除[target_clan.name]。")
					return

				message_admins("[key_name_admin(src)] has deleted the clan [target_clan.name].")
				to_chat(src, SPAN_NOTICE("你已删除[target_clan.name]。"))
				var/list/datum/view_record/clan_playerbase_view/CPV = DB_VIEW(/datum/view_record/clan_playerbase_view, DB_COMP("clan_id", DB_EQUALS, target_clan.id))

				for(var/datum/view_record/clan_playerbase_view/CP in CPV)
					var/datum/entity/clan_player/pl = DB_EKEY(/datum/entity/clan_player/, CP.player_id)
					pl.sync()

					pl.clan_id = null
					pl.permissions = GLOB.clan_ranks[CLAN_RANK_UNBLOODED].permissions
					pl.clan_rank = GLOB.clan_ranks_ordered[CLAN_RANK_UNBLOODED]

					pl.save()

				target_clan.delete()
				usr_view_clan_info(null, TRUE)
				return // We delete here. We don't need to save the clan after it deletes

		target_clan.save()
		target_clan.sync()

		if(target_clan.id)
			usr_view_clan_info(target_clan.id)

	else if(href_list[CLAN_TARGET_HREF])
		var/datum/entity/clan_player/target = GET_CLAN_PLAYER(href_list[CLAN_TARGET_HREF])
		target.sync()

		var/datum/entity/player/P = DB_ENTITY(/datum/entity/player, target.player_id)
		P.sync()

		var/player_name = P.ckey

		var/player_rank = clan_info.clan_rank

		if(has_clan_permission(CLAN_PERMISSION_ADMIN_MANAGER, warn = FALSE))
			player_rank = 999

		if((target.permissions & CLAN_PERMISSION_ADMIN_MANAGER) || player_rank <= target.clan_rank)
			to_chat(src, SPAN_DANGER("你无法将此人员设为目标！"))
			return

		switch(href_list[CLAN_ACTION])
			if(CLAN_ACTION_PLAYER_PURGE)
				if(!has_clan_permission(CLAN_PERMISSION_ADMIN_MANAGER))
					return

				var/input = input(src, "你确定要清除此人吗？输入‘[player_name]’以清除", "Confirm Purge") as text|null

				if(!input || input != player_name)
					return

				var/target_clan = target.clan_id
				message_admins("[key_name_admin(src)] has purged [player_name]'s clan profile.")
				to_chat(src, SPAN_NOTICE("你已清除[player_name]的氏族档案。"))

				target.delete()

				if(P.owning_client)
					P.owning_client.clan_info = null

				usr_view_clan_info(target_clan, TRUE)
				return // Return because we don't want to save them. They've been deleted

			if(CLAN_ACTION_PLAYER_MOVECLAN)
				if(!has_clan_permission(CLAN_PERMISSION_ADMIN_MOVE))
					return

				var/is_clan_manager = has_clan_permission(CLAN_PERMISSION_ADMIN_MANAGER, warn = FALSE)
				var/list/datum/view_record/clan_view/CPV = DB_VIEW(/datum/view_record/clan_view/)

				var/list/clans = list()
				for(var/datum/view_record/clan_view/CV in CPV)
					clans += list("[CV.name]" = CV.clan_id)

				if(is_clan_manager && length(clans) >= 1)
					if(target.permissions & CLAN_PERMISSION_ADMIN_ANCIENT)
						clans += list("Remove from Ancient")
					else
						clans += list("Make Ancient")

				if(target.clan_id)
					clans += list("Remove from clan")

				var/input = tgui_input_list(src, "选择要将其加入的氏族", "Change player's clan", clans)

				if(!input)
					return

				if(input == "Remove from clan" && target.clan_id)
					target.clan_id = null
					target.clan_rank = GLOB.clan_ranks_ordered[CLAN_RANK_BLOODED]
					to_chat(src, SPAN_NOTICE("已将[player_name]从其氏族中移除。"))
					message_admins("[key_name_admin(src)] has removed [player_name] from their current clan.")
				else if(input == "Remove from Ancient")
					target.clan_rank = GLOB.clan_ranks_ordered[CLAN_RANK_BLOODED]
					target.permissions = GLOB.clan_ranks[CLAN_RANK_BLOODED].permissions
					to_chat(src, SPAN_NOTICE("已将[player_name]从远古者中移除。"))
					message_admins("[key_name_admin(src)] has removed [player_name] from ancient.")
				else if(input == "Make Ancient" && is_clan_manager)
					target.clan_rank = GLOB.clan_ranks_ordered[CLAN_RANK_ADMIN]
					target.permissions = CLAN_PERMISSION_ADMIN_ANCIENT
					to_chat(src, SPAN_NOTICE("已将[player_name]设为远古者。"))
					message_admins("[key_name_admin(src)] has made [player_name] an ancient.")
				else
					to_chat(src, SPAN_NOTICE("已将[player_name]移至[input]。"))
					message_admins("[key_name_admin(src)] has moved [player_name] to clan [input].")

					target.clan_id = clans[input]

					if(!(target.permissions & CLAN_PERMISSION_ADMIN_ANCIENT))
						target.permissions = GLOB.clan_ranks[CLAN_RANK_BLOODED].permissions
						target.clan_rank = GLOB.clan_ranks_ordered[CLAN_RANK_BLOODED]

			if(CLAN_ACTION_PLAYER_MODIFYRANK)
				if(!target.clan_id)
					to_chat(src, SPAN_WARNING("该玩家不属于任何氏族！"))
					return

				var/list/datum/yautja_rank/ranks = GLOB.clan_ranks.Copy()
				ranks -= list(CLAN_RANK_ADMIN, CLAN_RANK_YOUNG)// Admin rank should not and cannot be obtained from here, Youngblood should only be used for non-WL players

				var/datum/yautja_rank/chosen_rank
				if(has_clan_permission(CLAN_PERMISSION_ADMIN_MODIFY, warn = FALSE))
					var/input = tgui_input_list(src, "选择要更改为此用户的军衔。", "Select Rank", ranks)

					if(!input)
						return

					chosen_rank = ranks[input]

				else if(has_clan_permission(CLAN_PERMISSION_USER_MODIFY, target.clan_id))
					for(var/rank in ranks)
						if(!has_clan_permission(ranks[rank].permission_required, warn = FALSE))
							ranks -= rank

					var/input = tgui_input_list(src, "选择要更改为此用户的军衔。", "Select Rank", ranks)

					if(!input)
						return

					chosen_rank = ranks[input]

					if(chosen_rank.limit_type)
						var/list/datum/view_record/clan_playerbase_view/CPV = DB_VIEW(/datum/view_record/clan_playerbase_view/, DB_AND(DB_COMP("clan_id", DB_EQUALS, target.clan_id), DB_COMP("rank", DB_EQUALS, GLOB.clan_ranks_ordered[input])))
						var/players_in_rank = length(CPV)

						switch(chosen_rank.limit_type)
							if(CLAN_LIMIT_NUMBER)
								if(players_in_rank >= chosen_rank.limit)
									to_chat(src, SPAN_DANGER("该槽位已满！（最多[chosen_rank.limit]个槽位）"))
									return
							if(CLAN_LIMIT_SIZE)
								var/list/datum/view_record/clan_playerbase_view/clan_players = DB_VIEW(/datum/view_record/clan_playerbase_view/, DB_COMP("clan_id", DB_EQUALS, target.clan_id))
								var/available_slots = ceil(length(clan_players) / chosen_rank.limit)

								if(players_in_rank >= available_slots)
									to_chat(src, SPAN_DANGER("该槽位已满！（氏族内每名玩家最多[chosen_rank.limit]个，当前为[available_slots]个）"))
									return


				else
					return // Doesn't have permission to do this

				if(!has_clan_permission(chosen_rank.permission_required)) // Double check
					return

				target.clan_rank = GLOB.clan_ranks_ordered[chosen_rank.name]
				target.permissions = chosen_rank.permissions
				message_admins("[key_name_admin(src)] has set the rank of [player_name] to [chosen_rank.name] for their clan.")
				to_chat(src, SPAN_NOTICE("已将[player_name]的军衔设为[chosen_rank.name]"))

		target.save()
		target.sync()
		usr_view_clan_info(target.clan_id, TRUE)
