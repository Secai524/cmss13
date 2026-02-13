/datum/emergency_call/contractors
	name = "军事承包商（小队）（友方）"
	mob_max = 7
	probability = 10

	max_engineers =  1
	max_medics = 1
	max_heavies = 1
	var/max_synths = 1
	var/synths = 0


/datum/emergency_call/contractors/New()
	..()
	arrival_message = "[MAIN_SHIP_NAME], this is USCSS Inheritor with Vanguard's Arrow Incorporated, Primary Operations; we are responding to your distress call and boarding in accordance with the Military Aid Act of 2177, authentication code Lima-18153."
	objectives = "Ensure the survival of the [MAIN_SHIP_NAME], eliminate any hostiles, and assist the crew in any way possible."


/datum/emergency_call/contractors/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("你是先锋之箭公司的承包商团队领袖！"))
		arm_equipment(mob, /datum/equipment_preset/contractor/duty/leader, TRUE, TRUE)
	else if(synths < max_synths && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_SYNTH) && mob.client.check_whitelist_status(WHITELIST_SYNTHETIC))
		synths++
		to_chat(mob, SPAN_ROLE_HEADER("你是先锋之箭公司的承包商支援合成人！"))
		arm_equipment(mob, /datum/equipment_preset/contractor/duty/synth, TRUE, TRUE)
	else if(medics < max_medics && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(mob.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		to_chat(mob, SPAN_ROLE_HEADER("你是先锋之箭公司的承包商医疗专家！"))
		arm_equipment(mob, /datum/equipment_preset/contractor/duty/medic, TRUE, TRUE)
	else if(heavies < max_heavies && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_HEAVY) && check_timelock(mob.client, JOB_SQUAD_SPECIALIST))
		heavies++
		to_chat(mob, SPAN_ROLE_HEADER("你是先锋之箭公司的承包商机枪手！"))
		arm_equipment(mob, /datum/equipment_preset/contractor/duty/heavy, TRUE, TRUE)
	else if(engineers < max_engineers && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_ENGINEER) && check_timelock(mob.client, JOB_SQUAD_ENGI))
		engineers++
		to_chat(mob, SPAN_ROLE_HEADER("你是先锋之箭公司的承包商工程专家！"))
		arm_equipment(mob, /datum/equipment_preset/contractor/duty/engi, TRUE, TRUE)
	else
		to_chat(mob, SPAN_ROLE_HEADER("你是先锋之箭公司的承包商！"))
		arm_equipment(mob, /datum/equipment_preset/contractor/duty/standard, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)


/datum/emergency_call/contractors/print_backstory(mob/living/carbon/human/M)
	if(ishuman_strict(M))
		to_chat(M, SPAN_BOLD("你出生于[pick(60;"in the United States", 20;"on Earth", 20;"on a colony")] to a [pick(75;"average", 15;"poor", 10;"well-established")] family."))
		to_chat(M, SPAN_BOLD("加入USCM让你获得了丰富的战斗经验和实用技能，但也改变了你。"))
		to_chat(M, SPAN_BOLD("退役后，你因所见所为无法保住工作，于是决定利用你的技能，加入了一家军事承包商公司。"))
		to_chat(M, SPAN_BOLD("你是一名熟练的雇佣兵，收入比在陆战队时更高。"))
	else
		to_chat(M, SPAN_BOLD("你在一个民用工厂被激活。"))
		to_chat(M, SPAN_BOLD("你被编程灌输了军事作战力量支援单位所需的所有医疗和工程知识。"))
		to_chat(M, SPAN_BOLD("不久之后，你被先锋之箭公司（VAI）收购，作为支援人员。"))
		to_chat(M, SPAN_BOLD("被收购数月后，你被分配到VAI的运输船USCSS Inheritor号上。"))
	to_chat(M, SPAN_BOLD("你是[pick(80;"unaware", 15;"faintly aware", 5;"knowledgeable")] of the xenomorph threat."))
	to_chat(M, SPAN_BOLD("你受雇于先锋之箭公司，是VAI主要行动部的一员。"))
	to_chat(M, SPAN_BOLD("你驻扎在USCSS继承者号上，隶属于VAIPO查理特遣队。"))
	to_chat(M, SPAN_BOLD("根据VAI执行董事会的指示，你需协助镇压暴乱、提供军事援助，并尽可能支援USCMC部队。"))
	to_chat(M, SPAN_BOLD("USCSS继承者号上约有三百名军事承包商人员和五十名后勤人员。"))
	to_chat(M, SPAN_BOLD("尽你所能协助[MAIN_SHIP_NAME]上的USCMC部队。"))
	to_chat(M, SPAN_BOLD("次要目标：VAI受一位匿名雇主雇佣，对维兰德-汤谷进行商业间谍与破坏活动。避免正面冲突，但尽可能窃取维兰德的机密与计划。"))


/datum/emergency_call/contractors/platoon
	name = "军事承包商（排级）（友方）"
	mob_min = 7
	mob_max = 28
	probability = 0
	max_medics = 3
	max_heavies = 3
	max_engineers = 2
	max_synths = 2

/datum/emergency_call/contractors/covert
	name = "军事承包商（隐秘行动）（友方）"
	mob_max = 7
	probability = 10
	max_medics = 1
	max_engineers = 1
	max_heavies = 1
	max_synths = 1
	var/checked_objective = FALSE

/datum/emergency_call/contractors/covert/New()
	..()
	arrival_message = "[MAIN_SHIP_NAME], this is USCSS Samburan, with Vanguard's Arrow Incorporated, Special Operations; we are boarding in accordance with the 2177 Military Aid Act; authorisation code X-Ray 19601."
	objectives = "Assist USCMC forces in whatever way is possible, sabotage Weyland-Yutani efforts."

/datum/emergency_call/contractors/covert/proc/check_objective_info()
	if(objective_info)
		objectives = "Assist USCMC forces in whatever way is possible."
	objectives += "Sabotage Weyland-Yutani efforts."
	checked_objective = TRUE

/datum/emergency_call/contractors/covert/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	if(!checked_objective)
		check_objective_info()

	var/mob/living/carbon/human/H = new(spawn_loc)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, JOB_SQUAD_LEADER, time_required_for_job))    //First one spawned is always the leader.
		leader = H
		to_chat(H, SPAN_ROLE_HEADER("你是先锋之箭公司的隐秘承包商队长！"))
		arm_equipment(H, /datum/equipment_preset/contractor/covert/leader, TRUE, TRUE)
	else if(synths < max_synths && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_SYNTH) && H.client.check_whitelist_status(WHITELIST_SYNTHETIC))
		synths++
		to_chat(H, SPAN_ROLE_HEADER("你是先锋之箭公司的承包商支援合成人！"))
		arm_equipment(H, /datum/equipment_preset/contractor/covert/synth, TRUE, TRUE)
	else if(medics < max_medics && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(H.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		to_chat(H, SPAN_ROLE_HEADER("你是先锋之箭公司的隐秘承包商医疗专家！"))
		arm_equipment(H, /datum/equipment_preset/contractor/covert/medic, TRUE, TRUE)
	else if(heavies < max_heavies && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_SMARTGUNNER) && check_timelock(H.client, JOB_SQUAD_SMARTGUN, time_required_for_job))
		heavies++
		to_chat(H, SPAN_ROLE_HEADER("你是先锋之箭公司的隐秘承包商机枪手！"))
		arm_equipment(H, /datum/equipment_preset/contractor/covert/heavy, TRUE, TRUE)
	else if(engineers < max_engineers && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_ENGINEER) && check_timelock(H.client, JOB_SQUAD_ENGI))
		engineers++
		to_chat(H, SPAN_ROLE_HEADER("你是先锋之箭公司的隐秘承包商工程专家！"))
		arm_equipment(H, /datum/equipment_preset/contractor/covert/engi, TRUE, TRUE)
	else
		to_chat(H, SPAN_ROLE_HEADER("你是先锋之箭公司的隐秘承包商！"))
		arm_equipment(H, /datum/equipment_preset/contractor/covert/standard, TRUE, TRUE)

	print_backstory(H)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)

