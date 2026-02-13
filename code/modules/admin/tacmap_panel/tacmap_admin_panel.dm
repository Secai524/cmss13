/client/proc/cmd_admin_tacmaps_panel()
	set name = "Tacmaps Panel"
	set category = "Admin.Panels"

	if(!check_rights(R_ADMIN|R_MOD))
		to_chat(src, "只有管理员可以使用此命令。")
		return

	GLOB.tacmap_admin_panel.tgui_interact(mob)
