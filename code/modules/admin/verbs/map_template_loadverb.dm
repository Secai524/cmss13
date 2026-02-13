/client/proc/map_template_load()
	set category = "Admin.Events"
	set name = "Map Template - Place"

	var/datum/map_template/template

	var/map = tgui_input_list(src, "选择要放置在你当前位置的地图模板","Place Map Template", sortList(SSmapping.map_templates))
	if(!map)
		return
	template = SSmapping.map_templates[map]

	var/turf/T = get_turf(mob)
	if(!T)
		return

	var/centered = alert(src, "你希望从地图中心创建，还是从左下角创建？", "Spawn Position", "Center", "Bottom Left") == "Center" ? TRUE : FALSE
	var/delete = alert(src, "是否删除加载区域内的原子？", "Atom Deletion", "Yes", "No") == "Yes" ? TRUE : FALSE

	var/list/preview = list()
	for(var/S in template.get_affected_turfs(T, centered))
		var/image/item = image('icons/turf/overlays.dmi',S,"greenOverlay")
		item.plane = ABOVE_LIGHTING_PLANE
		preview += item
	images += preview
	if(alert(src,"确认位置。","Template Confirm","Yes","No") == "Yes")
		if(template.load(T, centered, delete))
			/*var/affected = template.get_affected_turfs(T, centered=TRUE)
			for(var/AT in affected)
				for(var/obj/docking_port/mobile/P in AT)
					if(istype(P, /obj/docking_port/mobile))
						template.post_load(P)
						break*/
			message_admins(SPAN_ADMINNOTICE("[key_name_admin(src)] has placed a map template ([template.name]) at [key_name_admin(T)]"))
		else
			to_chat(src, "放置地图失败", confidential = TRUE)
	images -= preview

/client/proc/map_template_upload()
	set category = "Admin.Events"
	set name = "Map Template - Upload"

	var/map = input(src, "选择要上传到模板存储库的地图模板","Upload Map Template") as null|file
	if(!map)
		return
	if(copytext("[map]", -4) != ".dmm")//4 == length(".dmm")
		to_chat(src, SPAN_WARNING("文件名必须以'.dmm'结尾：[map]"), confidential = TRUE)
		return
	var/datum/map_template/M
	switch(alert(src, "这是什么类型的地图？", "Map type", "Normal", "Cancel")) // TODO: shuttle
		if("Normal")
			M = new /datum/map_template(map, "[map]", TRUE)
		if("穿梭机")
			M = new /datum/map_template/shuttle(map, "[map]", TRUE)
		else
			return
	if(!M.cached_map)
		to_chat(src, SPAN_WARNING("地图模板'[map]'解析失败。"), confidential = TRUE)
		return

	var/datum/map_report/report = M.cached_map.check_for_errors()
	var/report_link
	if(report)
		report.show_to(src)
		report_link = " - <a href='byond://?src=[REF(report)];show=1'>validation report</a>" // TODO: hreftoken
		to_chat(src, SPAN_WARNING("地图模板'[map]' <a href='byond://?src=[REF(report)];show=1'>验证失败</a>。"), confidential = TRUE) // TODO: hreftoken
		if(report.loadable)
			var/response = alert(src, "地图验证失败，是否仍要加载？", "Map Errors", "Cancel", "Upload Anyways")
			if(response != "Upload Anyways")
				return
		else
			alert(src, "地图验证失败，无法加载。", "Map Errors", "Oh Darn")
			return

	SSmapping.map_templates[M.name] = M
	message_admins(SPAN_ADMINNOTICE("[key_name_admin(src)] has uploaded a map template '[map]' ([M.width]x[M.height])[report_link]."))
	to_chat(src, SPAN_NOTICE("地图模板'[map]'准备就绪，可放置 ([M.width]x[M.height])"), confidential = TRUE)

/client/proc/force_load_lazy_template()
	set name = "Map Template - Lazy Load/Jump"
	set category = "Admin.Events"
	if(!check_rights(R_EVENT))
		return

	var/choice = tgui_input_list(usr, "密钥？", "Lazy Loader", GLOB.lazy_templates)
	if(!choice)
		return

	var/already_loaded = LAZYACCESS(SSmapping.loaded_lazy_templates, choice)
	var/force_load = FALSE
	if(already_loaded && (tgui_alert(usr, "模板已加载。", "", list("Jump", "Load Again")) == "Load Again"))
		force_load = TRUE

	var/datum/turf_reservation/reservation = SSmapping.lazy_load_template(choice, force = force_load)
	if(!reservation)
		to_chat(usr, SPAN_BOLDWARNING("加载模板失败！"))
		return

	if(!isobserver(usr))
		admin_ghost()
	usr.forceMove(reservation.bottom_left_turfs[1])

	message_admins("[key_name_admin(usr)] has loaded lazy template '[choice]'")
	to_chat(usr, SPAN_BOLD("模板已加载，你已被移至预定区域的左下角。"))
