/client/proc/toggle_noclip()
	set name = "Toggle Noclip"
	set category = "Admin.Fun"

	if(!src.admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "只有管理员可以使用此命令。")
		return

	if(!mob)
		return

	mob.noclip = !mob.noclip
	var/msg = "[key_name(src)] has toggled noclip [mob.noclip? "on" : "off"]."
	message_admins(msg)
	log_admin(msg)

