/client/proc/debug_game_history()
	set name = "Debug Round Recorder"
	set category = "Debug"

	if (!admin_holder || !(usr.client.admin_holder.rights & R_DEBUG))
		return

	var/datum/round_recorder/recorder = SSround_recording.recorder
	if(isnull(recorder))
		to_chat(src, "回合记录数据要么尚未初始化，要么已被删除。")

	debug_variables(recorder)
