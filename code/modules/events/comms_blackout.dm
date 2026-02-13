/proc/communications_blackout(silent = 1)
	if(!silent)
		marine_announcement("检测到来自附近恒星的离子辐射耀斑。即将发生电信故障*3mga;b4;'1v�-BZZZT", "Problem Detected", 'sound/misc/interference.ogg')
	else // AIs will always know if there's a comm blackout, rogue AIs could then lie about comm blackouts in the future while they shutdown comms
		for(var/mob/living/silicon/ai/A in GLOB.ai_mob_list)
			to_chat(A, "<br>")
			to_chat(A, SPAN_WARNING("<b>检测到来自附近恒星的离子辐射耀斑。即将发生电信故障*3mga;b4;'1v�-BZZZT<b>"))
			to_chat(A, "<br>")
	for(var/i in GLOB.telecomms_list)
		var/obj/structure/machinery/telecomms/T = i
		T.emp_act(1)
