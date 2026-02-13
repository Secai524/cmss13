/client/proc/force_teleporter()
	set name = "Force Teleporter"
	set desc = "Force a teleporter to teleport."
	set category = "Admin.Game"

	var/list/datum/teleporter/available_teleporters = GLOB.teleporters

	var/datum/teleporter/teleporter = tgui_input_list(usr, "你想使用哪个传送器？", "Select a teleporter:", available_teleporters)
	if(!teleporter)
		return

	var/available_locations = teleporter.locations.Copy()

	var/source_location = tgui_input_list(usr, "你想从哪个位置传送？", "Select a location:", available_locations)
	if(!source_location)
		return

	available_locations -= source_location

	var/dest_location = tgui_input_list(usr, "你想传送到哪个位置？", "Select a location:", available_locations)

	if(!teleporter.check_teleport_cooldown() && alert("Error: Teleporter is on cooldown. Proceed anyways?", , "Yes", "No") != "Yes")
		return

	if((!teleporter.safety_check_source(source_location) || !teleporter.safety_check_destination(dest_location)) && alert("Error: Destination or source is unsafe. Proceed anyways?", , "Yes", "No") != "Yes")
		return

	teleporter.teleport(source_location, dest_location)
