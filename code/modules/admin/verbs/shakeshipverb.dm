/client/proc/shakeshipverb()
	set name = "Shake Shipmap"
	set category = "Admin.Ship"

	var/drop = FALSE
	var/delayt
	var/whattoannounce

	var/sstrength = tgui_input_number(src, "强度多大？", "Don't go overboard.", 0, 10)
	if(!sstrength)
		return
	var/stime = tgui_input_number(src, "震动间隔时间？", "Don't make it too long", 0, 30)
	if(!stime)
		return

	var/prompt = tgui_alert(src, "使人摔倒？", "确认", list("Yes", "No"), 20 SECONDS)
	if(prompt == "Yes")
		drop = TRUE

	var/delayed
	var/announce
	prompt = tgui_alert(src, "延迟触发？", "确认", list("Yes", "No"), 20 SECONDS)
	if(prompt == "Yes")
		delayed = TRUE
		delayt = tgui_input_number(src, "延迟多久？", "60 secs maximum", 0, 60, 0)
		if(!delayt)
			return
		prompt = tgui_alert(src, "警告人员？", "确认", list("Yes", "No"), 20 SECONDS)
		if(prompt == "Yes")
			announce = TRUE
			whattoannounce = tgui_input_text(src, "请输入公告文本。留空则使用默认文本。", "what?")
			if(!whattoannounce)
				if(sstrength <= 7)
					whattoannounce = "WARNING, IMPACT IMMINENT. ETA: [delayt] SECONDS. BRACE BRACE BRACE."
				if(sstrength > 7)
					whattoannounce = "DANGER, DANGER! HIGH ENERGY IMPACT IMMINENT. ETA: [delayt] SECONDS. BRACE BRACE BRACE."

	prompt = tgui_alert(src, "你确定要震动舰船地图吗？", "Rock the ship!", list("Yes", "No"), 20 SECONDS)
	if(prompt != "Yes")
		return
	else
		message_admins("[key_name_admin(src)] rocked the ship! with the strength of [sstrength], and duration of [stime]")
		if(delayed)
			if(announce)
				if(sstrength <= 5)
					shipwide_ai_announcement(whattoannounce, MAIN_AI_SYSTEM, 'sound/effects/alert.ogg')
				if(sstrength > 5)
					shipwide_ai_announcement(whattoannounce, MAIN_AI_SYSTEM, 'sound/effects/ob_alert.ogg')
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(shakeship), sstrength, stime, drop), delayt * 10)
		else
			shakeship(sstrength, stime, drop)

