/datum/job/antag
	selection_class = "job_antag"
	supervisors =   "反派角色"
	late_joinable = FALSE

/datum/timelock/xeno
	name = "异形"

/datum/timelock/xeno/can_play(client/C)
	return C.get_total_xeno_playtime() >= time_required

/datum/timelock/xeno/get_role_requirement(client/C)
	return time_required - C.get_total_xeno_playtime()

/// counts drone caste evo time as well
/datum/timelock/drone
	name = "工蜂及其进化体"

/datum/timelock/drone/can_play(client/C)
	return C.get_total_drone_playtime() >= time_required

/datum/timelock/drone/get_role_requirement(client/C)
	return time_required - C.get_total_drone_playtime()

/// t3 and queen time
/datum/timelock/tier3
	name = "三级种姓"

/datum/timelock/tier3/can_play(client/C)
	return C.get_total_t3_playtime() >= time_required

/datum/timelock/tier3/get_role_requirement(client/C)
	return time_required - C.get_total_t3_playtime()
