/datum/admins/proc/topic_teleports(href)
	switch(href)
		if("jump_to_area")
			var/area/choice = tgui_input_list(owner, "选择一个区域进行传送：", "Jump", return_sorted_areas())
			if(QDELETED(choice))
				return

			owner.jump_to_area(choice)

		if("jump_to_turf")
			var/turf/choice = tgui_input_list(owner, "选择一个地块进行传送：", "Jump", GLOB.turfs)
			if(QDELETED(choice))
				return

			owner.jump_to_turf(choice)

		if("jump_to_mob")
			var/mob/choice = tgui_input_list(owner, "选择一个实体进行传送：", "Jump", GLOB.mob_list)
			if(QDELETED(choice))
				return

			owner.jumptomob(choice)

		if("jump_to_coord")
			var/targ_x = tgui_input_number(owner, "传送至x坐标，范围从0到[world.maxx]。", "Jump to X", 0, world.maxx, 0)
			if(!targ_x || targ_x < 0)
				return
			var/targ_y = tgui_input_number(owner, "传送至y坐标，范围从0到[world.maxy]。", "Jump to Y", 0, world.maxy, 0)
			if(!targ_y || targ_y < 0)
				return
			var/targ_z = tgui_input_number(owner, "传送至z坐标，范围从0到[world.maxz]。", "Jump to Z", 0, world.maxz, 0)
			if(!targ_z || targ_z < 0)
				return

			owner.jumptocoord(targ_x, targ_y, targ_z)

		if("jump_to_offset_coord")
			var/targ_x = tgui_input_real_number(owner, "Jump to X coordinate.")
			if(!targ_x)
				return
			var/targ_y = tgui_input_real_number(owner, "Jump to Y coordinate.")
			if(!targ_y)
				return

			owner.jumptooffsetcoord(targ_x, targ_y)

		if("jump_to_obj")
			var/list/obj/targets = list()
			for(var/obj/O in world)
				targets += O
			var/obj/choice = tgui_input_list(owner, "选择一个物体进行传送：", "Jump", targets)
			if(QDELETED(choice))
				return

			owner.jump_to_object(choice)

		if("jump_to_key")
			owner.jumptokey()

		if("get_mob")
			var/mob/choice = tgui_input_list(owner, "选择一个单位传送至此：","Get Mob", GLOB.mob_list)
			if(QDELETED(choice))
				return

			owner.Getmob(choice)

		if("get_key")
			owner.Getkey()

		if("teleport_mob_to_area")
			var/mob/choice = tgui_input_list(owner, "选择一个单位传送至区域：","Teleport Mob", sortmobs())
			if(QDELETED(choice))
				return

			owner.sendmob(choice)

		if("teleport_mobs_in_range")
			var/collect_range = tgui_input_number(owner, "输入0到7格的范围。所选范围内所有存活的单位将被标记传送。", "Mass-teleportation", 0, 7, 0)
			if(collect_range < 0 || collect_range > 7)
				to_chat(owner, SPAN_ALERT("范围错误。中止。"))
				return
			var/list/targets = list()
			for(var/mob/living/M in range(collect_range, owner.mob))
				if(M.stat != DEAD)
					targets.Add(M)
			if(length(targets) < 1)
				to_chat(owner, SPAN_ALERT("未找到存活单位。中止。"))
				return
			if(alert(owner, "[length(targets)]个单位被标记传送。按下\"TELEPORT\" will teleport them to your location at the moment of pressing button.", "确认", "Teleport", "Cancel") == "Cancel")
				return
			for(var/mob/M in targets)
				if(!M)
					continue
				M.on_mob_jump()
				M.forceMove(get_turf(owner.mob))

			message_admins(WRAP_STAFF_LOG(owner.mob, "mass-teleported [length(targets)] mobs in [collect_range] tiles range to themselves in [get_area(owner.mob)] ([owner.mob.x],[owner.mob.y],[owner.mob.z])."), owner.mob.x, owner.mob.y, owner.mob.z)

		if("teleport_mobs_by_faction")
			var/faction = tgui_input_list(owner, "选择类人生物或异形。", "Mobs Choice", list("Humanoids", "Xenomorphs"))
			if(faction == "Humanoids")
				faction = null
				faction = tgui_input_list(owner, "选择要传送至你位置的派系。雷霆穹顶/中央指挥部区域的单位不计入。", "Faction Choice", FACTION_LIST_HUMANOID)
				if(!faction)
					to_chat(owner, SPAN_ALERT("派系选择错误。中止。"))
					return
				var/list/targets = GLOB.alive_human_list.Copy()
				for(var/mob/living/carbon/human/H in targets)
					var/area/AR = get_area(H)
					if(H.faction != faction || AR.statistic_exempt)
						targets.Remove(H)
				if(length(targets) < 1)
					to_chat(owner, SPAN_ALERT("未找到[faction]派系的存活/人类单位。中止。"))
					return
				if(alert(owner, "[length(targets)]个[faction]派系的类人生物被标记传送。按下\"TELEPORT\" will teleport them to your location at the moment of pressing button.", "确认", "Teleport", "Cancel") == "Cancel")
					return

				for(var/mob/M in targets)
					if(!M)
						continue
					M.on_mob_jump()
					M.forceMove(get_turf(owner.mob))

				message_admins(WRAP_STAFF_LOG(owner.mob, "mass-teleported [length(targets)] human mobs of [faction] faction to themselves in [get_area(owner.mob)] ([owner.mob.x],[owner.mob.y],[owner.mob.z])."), owner.mob.x, owner.mob.y, owner.mob.z)

			else if(faction == "Xenomorphs")
				faction = null
				var/list/hives = list()
				var/datum/hive_status/hive
				for(var/hivenumber in GLOB.hive_datum)
					hive = GLOB.hive_datum[hivenumber]
					hives += list("[hive.name]" = hive.hivenumber)

				faction = tgui_input_list(owner, "选择要传送至你位置的巢穴。雷霆穹顶/中央指挥部区域的单位不计入。", "Hive Choice", hives)
				if(!faction)
					to_chat(owner, SPAN_ALERT("巢穴选择错误。中止。"))
					return
				var/datum/hive_status/Hive = GLOB.hive_datum[hives[faction]]
				var/list/targets = Hive.totalXenos
				for(var/mob/living/carbon/xenomorph/X in targets)
					var/area/AR = get_area(X)
					if(X.stat == DEAD || AR.statistic_exempt)
						targets.Remove(X)
				if(length(targets) < 1)
					to_chat(owner, SPAN_ALERT("未找到[faction]巢穴的存活异形。中止。"))
					return
				if(alert(owner, "[length(targets)]个[faction]巢穴的异形被标记传送。按下\"TELEPORT\" will teleport them to your location at the moment of pressing button.", "确认", "Teleport", "Cancel") == "Cancel")
					return

				for(var/mob/M in targets)
					if(!M)
						continue
					M.on_mob_jump()
					M.forceMove(get_turf(owner.mob))

				message_admins(WRAP_STAFF_LOG(owner.mob, "mass-teleported [length(targets)] xenomorph mobs of [faction] Hive to themselves in [get_area(owner.mob)] ([owner.mob.x],[owner.mob.y],[owner.mob.z])."), owner.mob.x, owner.mob.y, owner.mob.z)

			else
				to_chat(owner, SPAN_ALERT("单位选择错误。中止。"))
				return

		if("teleport_corpses")
			if(length(GLOB.dead_mob_list) < 0)
				to_chat(owner, SPAN_ALERT("未找到尸体。中止。"))
				return

			if(alert(owner, "[length(GLOB.dead_mob_list)]具尸体被标记传送。按下\"TELEPORT\" will teleport them to your location at the moment of pressing button.", "确认", "Teleport", "Cancel") == "Cancel")
				return
			for(var/mob/M in GLOB.dead_mob_list)
				if(!M)
					continue
				M.on_mob_jump()
				M.forceMove(get_turf(owner.mob))
			message_admins(WRAP_STAFF_LOG(owner.mob, "mass-teleported [length(GLOB.dead_mob_list)] corpses to themselves in [get_area(owner.mob)] ([owner.mob.x],[owner.mob.y],[owner.mob.z])."), owner.mob.x, owner.mob.y, owner.mob.z)

		if("teleport_items_by_type")
			var/item = input(owner,"什么物品？", "Item Fetcher","") as text|null
			if(!item)
				return

			var/list/types = typesof(/obj)
			var/list/matches = new()

			//Figure out which object they might be trying to fetch
			for(var/path in types)
				if(findtext("[path]", item))
					matches += path

			if(length(matches)==0)
				return

			var/chosen
			if(length(matches)==1)
				chosen = matches[1]
			else
				//If we have multiple options, let them select which one they meant
				chosen = tgui_input_list(usr, "选择对象类型", "Find Object", matches)

			if(!chosen)
				return

			//Find all items in the world
			var/list/targets = list()
			for(var/obj/item/M in world)
				if(istype(M, chosen))
					targets += M

			if(length(targets) < 1)
				to_chat(owner, SPAN_ALERT("未找到[chosen]类型的物品。中止。"))
				return

			if(alert(owner, "[length(targets)]件物品被标记传送。按下\"TELEPORT\" will teleport them to your location at the moment of pressing button.", "确认", "Teleport", "Cancel") == "Cancel")
				return

			//Fetch the items
			for(var/obj/item/M in targets)
				if(!M)
					continue
				M.forceMove(get_turf(owner.mob))

			message_admins(WRAP_STAFF_LOG(owner.mob, "mass-teleported [length(targets)] items of type [chosen] to themselves in [get_area(owner.mob)] ([owner.mob.x],[owner.mob.y],[owner.mob.z])."), owner.mob.x, owner.mob.y, owner.mob.z)
