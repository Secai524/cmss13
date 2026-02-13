
//Weyland-Yutani commandos. Friendly to USCM, hostile to xenos.
/datum/emergency_call/wy_commando
	name = "维兰德-汤谷突击队（班级）"
	mob_max = 6
	probability = 5
	shuttle_id = MOBILE_SHUTTLE_ID_ERT2
	home_base = /datum/lazy_template/ert/weyland_station
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	item_spawn = /obj/effect/landmark/ert_spawns/distress_pmc/item

	max_smartgunners = 1


/datum/emergency_call/wy_commando/New()
	..()
	arrival_message = "[MAIN_SHIP_NAME], this is USCSS Nisshoku responding to your distress call. We are boarding. Any hostile actions will be met with lethal force."
	objectives = "Secure the Corporate Liaison and the [MAIN_SHIP_NAME]'s Commanding Officer, and eliminate any hostile threats. Do not damage Wey-Yu property."


/datum/emergency_call/wy_commando/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷突击队班长！"))
		arm_equipment(mob, /datum/equipment_preset/pmc/commando/leader/low_threat, TRUE, TRUE)
	else if(smartgunners < max_smartgunners && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_SMARTGUNNER) && check_timelock(mob.client, JOB_SQUAD_SMARTGUN))
		smartgunners++
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷突击队重火力手！"))
		arm_equipment(mob, /datum/equipment_preset/pmc/commando/gunner/low_threat, TRUE, TRUE)
	else
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷突击队员！"))
		arm_equipment(mob, /datum/equipment_preset/pmc/commando/standard/low_threat, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)

/datum/emergency_call/wy_commando/print_backstory(mob/living/carbon/human/M)
	to_chat(M, SPAN_BOLD("You were born [pick(75;"in Europe", 15;"in Asia", 10;"on Mars")] to a [pick(75;"well-off", 15;"well-established", 10;"average")] family."))
	to_chat(M, SPAN_BOLD("加入维兰德-汤谷为你带来了丰厚的回报。"))
	to_chat(M, SPAN_BOLD("虽然你名义上是公司雇员，但你的大部分工作都见不得光。你是一名技艺精湛的雇佣兵。"))
	to_chat(M, SPAN_BOLD("你对异形威胁了如指掌。"))
	to_chat(M, SPAN_BOLD("你是维兰德-汤谷奥伯伦特遣队的一员，该部队于2182年美军撤离内罗伊德扇区后抵达。"))
	to_chat(M, SPAN_BOLD("泰坦特遣队驻扎在USCSS Nisshoku号上，这是一艘维兰德-汤谷的武装科研船，停泊在内罗伊德扇区边缘。"))
	to_chat(M, SPAN_BOLD("根据维兰德-汤谷董事会成员约翰·阿尔姆里克的指示，你作为维兰德-汤谷科学团队的私人安保力量。"))
	to_chat(M, SPAN_BOLD("USCSS Nisshoku号上约有五十名突击队员，以及三十名科学家和后勤人员。"))
	to_chat(M, SPAN_BOLD("确保维兰德-汤谷的利益不受损害。保证公司联络官的安全。"))
	to_chat(M, SPAN_BOLD("否认维兰德-汤谷的参与，不要信任美军/USCM部队。"))

/datum/emergency_call/wy_commando/platoon
	name = "维兰德-汤谷突击队（排级）"
	mob_min = 8
	mob_max = 25
	probability = 0
	max_smartgunners = 4

/datum/emergency_call/wy_commando/deathsquad
	name = "维兰德-汤谷突击队（班级）（！死亡小队！）"
	mob_max = 8
	probability = 0
	shuttle_id = MOBILE_SHUTTLE_ID_ERT2
	home_base = /datum/lazy_template/ert/weyland_station
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	item_spawn = /obj/effect/landmark/ert_spawns/distress_pmc/item

	max_smartgunners = 2

/datum/emergency_call/wy_commando/deathsquad/New()
	..()
	objectives = "Eliminate everyone, then detonate the ship. Damage to Wey-Yu property is tolerable."

/datum/emergency_call/wy_commando/deathsquad/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷突击队班长！"))
		arm_equipment(mob, /datum/equipment_preset/pmc/commando/leader, TRUE, TRUE)
	else if(smartgunners < max_smartgunners && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_SMARTGUNNER) && check_timelock(mob.client, JOB_SQUAD_SMARTGUN))
		smartgunners++
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷突击队重火力手！"))
		arm_equipment(mob, /datum/equipment_preset/pmc/commando/gunner, TRUE, TRUE)
	else
		to_chat(mob, SPAN_ROLE_HEADER("你是维兰德-汤谷突击队员！"))
		arm_equipment(mob, /datum/equipment_preset/pmc/commando/standard, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)
