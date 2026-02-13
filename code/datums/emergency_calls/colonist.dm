

//Blank colonist ERT for admin stuff.
/datum/emergency_call/colonist
	name = "殖民者"
	mob_max = 8
	mob_min = 1
	arrival_message = "'This is the *static*. We are *static*.'"
	objectives = "Follow the orders given to you."
	probability = 0
	var/preset = /datum/equipment_preset/colonist


/datum/emergency_call/colonist/create_member(datum/mind/M, turf/override_spawn_loc) //Blank ERT with only basic items.
	set waitfor = 0
	var/turf/T = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(T))
		return FALSE

	var/mob/living/carbon/human/H = new(T)
	M.transfer_to(H, TRUE)
	arm_equipment(H, preset, TRUE, TRUE)

	sleep(20)
	if(H && H.loc)
		to_chat(H, SPAN_ROLE_HEADER("你是一名殖民者！"))
		to_chat(H, SPAN_ROLE_BODY("你已被管理员加入游戏。请遵守所有管理员指示。"))

/datum/emergency_call/colonist/engineers
	name = "殖民者 - 工程师"
	preset = /datum/equipment_preset/colonist/engineer

/datum/emergency_call/colonist/security
	name = "殖民者 - 安保人员"
	preset = /datum/equipment_preset/colonist/security

/datum/emergency_call/colonist/doctors
	name = "殖民者 - 医生"
	preset = /datum/equipment_preset/colonist/doctor
