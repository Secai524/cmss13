/datum/emergency_call/wy_bodyguard
	name = "Weyland-Yutani Public Security (Executive Bodyguard Detail)"
	mob_max = 1
	mob_min = 1
	shuttle_id = MOBILE_SHUTTLE_ID_ERT2
	home_base = /datum/lazy_template/ert/weyland_station
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	ert_message = "A corporate security beacon has been activated!"
	var/equipment_preset = /datum/equipment_preset/wy/security
	var/equipment_preset_leader = /datum/equipment_preset/wy/security
	var/spawn_header = "You are a Weyland-Yutani Security Guard!"
	var/spawn_header_leader = "You are a Weyland-Yutani Security Guard!"

/datum/emergency_call/wy_bodyguard/New()
	..()
	dispatch_message = "[MAIN_SHIP_NAME], this is a Weyland-Yutani Corporate Security Protection Detail shuttle inbound to the Liaison's Beacon."
	objectives = "Protect the Corporate Liaison and follow his commands, unless it goes against Company policy. Do not damage Wey-Yu property."

/datum/emergency_call/wy_bodyguard/create_member(datum/mind/responder_mind, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	responder_mind.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER(spawn_header_leader))
		arm_equipment(mob, equipment_preset_leader, TRUE, TRUE)
	else
		to_chat(mob, SPAN_ROLE_HEADER(spawn_header))
		arm_equipment(mob, equipment_preset, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)

/datum/emergency_call/wy_bodyguard/print_backstory(mob/living/carbon/human/response_mob)
	to_chat(response_mob, SPAN_BOLD("You were born [pick(75;"in Europe", 15;"in Asia", 10;"on Mars")] to a poor family."))
	to_chat(response_mob, SPAN_BOLD("加入维兰德-汤谷是你唯一能让自己和所爱之人糊口的选择。"))
	to_chat(response_mob, SPAN_BOLD("你完全不知道异形是什么。"))
	to_chat(response_mob, SPAN_BOLD("你是一名受雇于维兰德-汤谷的普通安保人员，负责保护公司各部门的高管。"))
	to_chat(response_mob, SPAN_BOLD("你被派往[MAIN_SHIP_NAME]担任高管的保镖，并已获得公司许可进入该区域。"))
	to_chat(response_mob, SPAN_BOLD("确保维兰德-汤谷的利益不受损害。保证公司联络官的安全。"))

/datum/emergency_call/wy_bodyguard/goon
	name = "维兰德-汤谷公司安保（高管保镖分队）"
	equipment_preset = /datum/equipment_preset/goon/standard/bodyguard
	equipment_preset_leader = /datum/equipment_preset/goon/lead/bodyguard
	spawn_header = "你是维兰德-汤谷公司安保官员！"
	spawn_header_leader = "你是维兰德-汤谷公司安保领队！"

/datum/emergency_call/wy_bodyguard/pmc
	name = "维兰德-汤谷PMC（高管保镖分队）"
	equipment_preset = /datum/equipment_preset/pmc/pmc_standard
	equipment_preset_leader = /datum/equipment_preset/pmc/pmc_leader
	spawn_header = "你是维兰德-汤谷PMC操作员！"
	spawn_header_leader = "You are a Weyland-Yutani PMC Leader!"

/datum/emergency_call/wy_bodyguard/pmc/print_backstory(mob/living/carbon/human/response_mob)
	if(ishuman_strict(response_mob))
		to_chat(response_mob, SPAN_BOLD("You were born [pick(75;"in Europe", 15;"in Asia", 10;"on Mars")] to a [pick(75;"well-off", 15;"well-established", 10;"average")] family."))
		to_chat(response_mob, SPAN_BOLD("加入维兰德-汤谷为你带来了丰厚的回报。"))
		to_chat(response_mob, SPAN_BOLD("虽然你名义上是公司雇员，但你的大部分工作都见不得光。你是一名技艺精湛的雇佣兵。"))
		to_chat(response_mob, SPAN_BOLD("你是[pick(50;"unaware of the xenomorph threat", 15;"acutely aware of the xenomorph threat", 10;"well-informed of the xenomorph threat")]."))

/datum/emergency_call/wy_bodyguard/pmc/sec
	name = "维兰德-汤谷PMC执法者（高管保镖分队）"
	equipment_preset = /datum/equipment_preset/pmc/pmc_security
	equipment_preset_leader = /datum/equipment_preset/pmc/pmc_lead_investigator
	spawn_header = "You are a Weyland-Yutani PMC Security Enforcer!"
	spawn_header_leader = "你是维兰德-汤谷PMC的首席调查员！"

/datum/emergency_call/wy_bodyguard/commando
	name = "维兰德-汤谷突击队员（高管保镖分队）"
	equipment_preset = /datum/equipment_preset/pmc/commando/standard/low_threat
	equipment_preset_leader = /datum/equipment_preset/pmc/commando/leader/low_threat
	spawn_header = "你是维兰德-汤谷突击队员！"
	spawn_header_leader = "You are a Weyland-Yutani Commando Leader!"

/datum/emergency_call/wy_bodyguard/commando/print_backstory(mob/living/carbon/human/response_mob)
	to_chat(response_mob, SPAN_BOLD("You were born [pick(75;"in Europe", 15;"in Asia", 10;"on Mars")] to a [pick(75;"well-off", 15;"well-established", 10;"average")] family."))
	to_chat(response_mob, SPAN_BOLD("加入维兰德-汤谷为你带来了丰厚的回报。"))
	to_chat(response_mob, SPAN_BOLD("虽然你名义上是公司雇员，但你的大部分工作都见不得光。你是一名技艺精湛的雇佣兵。"))
	to_chat(response_mob, SPAN_BOLD("你对异形威胁了如指掌。"))
	to_chat(response_mob, SPAN_BOLD("你是维兰德-汤谷奥伯伦特遣队的一员，该部队于2182年美军撤离内罗伊德扇区后抵达。"))
	to_chat(response_mob, SPAN_BOLD("泰坦特遣队驻扎在USCSS Nisshoku号上，这是一艘维兰德-汤谷的武装科研船，停泊在内罗伊德扇区边缘。"))
	to_chat(response_mob, SPAN_BOLD("根据维兰德-汤谷董事会成员约翰·阿尔姆里克的指示，你担任维兰德-汤谷公司联络官的私人保镖。"))
	to_chat(response_mob, SPAN_BOLD("USCSS Nisshoku号上约有五十名突击队员，以及三十名科学家和后勤人员。"))
	to_chat(response_mob, SPAN_BOLD("确保维兰德-汤谷的利益不受损害。保证公司联络官的安全。"))
	to_chat(response_mob, SPAN_BOLD("否认维兰德-汤谷的参与，不要信任美军/USCM部队。"))

/datum/emergency_call/wy_bodyguard/android
	name = "维兰德-汤谷战斗仿生人（高管保镖分队）"
	equipment_preset = /datum/equipment_preset/pmc/w_y_whiteout/low_threat
	equipment_preset_leader = /datum/equipment_preset/pmc/w_y_whiteout/low_threat/leader
	spawn_header = "You are a Weyland-Yutani Combat Android!"
	spawn_header_leader = "You are a Weyland-Yutani Combat Android Leading Unit!"

/datum/emergency_call/wy_bodyguard/android/print_backstory(mob/living/carbon/human/response_mob)
	to_chat(response_mob, SPAN_BOLD("你在维兰德-汤谷一处秘密战斗合成人生产设施中被激活。"))
	to_chat(response_mob, SPAN_BOLD("你的程序搭载了完全解锁的战斗软件。"))
	to_chat(response_mob, SPAN_BOLD("你获得了关于异形威胁的所有可用信息，包括为特殊雇员保留的机密数据。"))
	to_chat(response_mob, SPAN_BOLD("确保维兰德-汤谷的利益不受损害。保证公司联络官的安全。"))
	to_chat(response_mob, SPAN_BOLD("否认维兰德-汤谷的参与，不要信任美军/USCM部队。"))
