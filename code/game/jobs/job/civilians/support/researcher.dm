
//Researcher
/datum/job/civilian/researcher
	title = JOB_RESEARCHER
	total_positions = 2
	spawn_positions = 2
	allow_additional = 1
	scaled = 1
	supervisors = "首席医疗官与维兰德-汤谷公司总部"
	selection_class = "job_researcher"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/uscm_medical/researcher
	entry_message_body = "你是一名由维兰德-汤谷公司借调至美国殖民地海军陆战队的医学研究员。你的任务是<a href='"+WIKI_PLACEHOLDER+"'>researching</a> and developing new medical treatments, helping the USCM medical team, and generally learning new things. Your role involves a lot of roleplaying, but you can perform the function of a regular doctor. Do not hand out things to Marines without getting permission from your supervisor. You do not answer to the Corporate Liaison."

/datum/job/civilian/researcher/set_spawn_positions(count)
	spawn_positions = rsc_slot_formula(count)

/datum/job/civilian/researcher/get_total_positions(latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = rsc_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	else
		total_positions_so_far = positions
	return positions

AddTimelock(/datum/job/civilian/researcher, list(
	JOB_MEDIC_ROLES = 5 HOURS
))

/obj/effect/landmark/start/researcher
	name = JOB_RESEARCHER
	icon_state = "res_spawn"
	job = /datum/job/civilian/researcher
