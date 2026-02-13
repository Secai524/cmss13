/client/proc/admin_general_quarters()
	set name = "Call General Quarters"
	set category = "Admin.Ship"

	if(GLOB.security_level == SEC_LEVEL_RED || GLOB.security_level == SEC_LEVEL_DELTA)
		tgui_alert(src, "安全等级已达红色或更高，无法发出全员战备警报。", "Acknowledge!", list("ok."), 10 SECONDS)
		return FALSE

	var/prompt = tgui_alert(src, "确认要发出全员战备警报吗？这将强制提升至红色警报。", "Choose.", list("Yes", "No"), 20 SECONDS)
	if(prompt != "Yes")
		return FALSE

	var/whattoannounce = "注意！全员战斗警报。所有人员，进入战斗岗位。"
	var/log = "[key_name_admin(src)] Sent General Quarters!"

	prompt = tgui_alert(src, "要使用自定义广播吗？", "Choose.", list("Yes", "No"), 20 SECONDS)
	if(prompt == "Yes")
		whattoannounce = tgui_input_text(src, "请输入广播文本。", "what?")
		log = "[key_name_admin(src)] Sent General Quarters! (Using a custom announcement)"

	set_security_level(SEC_LEVEL_RED, TRUE, FALSE)
	shipwide_ai_announcement(whattoannounce, MAIN_AI_SYSTEM, 'sound/effects/GQfullcall.ogg')
	message_admins(log)
	return TRUE
