/datum/job/logistics
	supervisors = "辅助支援官"
	total_positions = 1
	spawn_positions = 1

/datum/timelock/engineer
	name = "工程职位"

/datum/timelock/engineer/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_ENGINEER_ROLES_LIST

/datum/timelock/requisition
	name = "补给职位"

/datum/timelock/requisition/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_REQUISITION_ROLES_LIST
