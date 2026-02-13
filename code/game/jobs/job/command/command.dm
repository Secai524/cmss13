/datum/job/command
	selection_class = "job_command"
	supervisors = "代理指挥官"
	total_positions = 1
	spawn_positions = 1

/datum/timelock/command
	name = "指挥职位"

/datum/timelock/command/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_COMMAND_ROLES_LIST

/datum/timelock/mp
	name = "宪兵职位"

/datum/timelock/mp/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_POLICE_ROLES_LIST

/datum/timelock/human
	name = "人类职位"

/datum/timelock/human/can_play(client/C)
	return C.get_total_human_playtime() >= time_required
	
/datum/timelock/human/get_role_requirement(client/C)
	return time_required - C.get_total_human_playtime()

/datum/timelock/dropship
	name = "运输机职位"

/datum/timelock/dropship/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_DROPSHIP_ROLES_LIST
	
