/client/proc/cmd_admin_medals_panel()
	set name = "Medals Panel"
	set category = "Admin.Panels"

	if(!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "只有管理员可以使用此命令。")
		return

	GLOB.medals_panel.tgui_interact(mob)
