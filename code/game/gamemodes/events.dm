//this file left in for legacy support

/proc/carp_migration() // -- Darem
	//sleep(100)
	spawn(rand(300, 600)) //Delayed announcements to keep the crew on their toes.
		marine_announcement("在[MAIN_SHIP_NAME]附近侦测到未知生物实体，请待命。", "Lifesign Alert", 'sound/AI/commandreport.ogg')

/proc/lightsout(isEvent = 0, lightsoutAmount = 1,lightsoutRange = 25) //leave lightsoutAmount as 0 to break ALL lights
	if(isEvent)
		marine_announcement("侦测到你所在区域出现雷暴，请修复潜在的电子设备过载。", "Electrical Storm Alert")

	if(lightsoutAmount)
		return

	else
		for(var/obj/structure/machinery/power/apc/apc in GLOB.machines)
			apc.overload_lighting()

	return
