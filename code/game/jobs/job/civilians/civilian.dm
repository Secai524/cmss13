/datum/job/civilian
	gear_preset = /datum/equipment_preset/colonist

/datum/timelock/medic
	name = "医疗职位"

/datum/timelock/medic/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_MEDIC_ROLES_LIST

/datum/timelock/doctor
	name = "医生职位"

/datum/timelock/doctor/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_DOCTOR_ROLES_LIST

/datum/timelock/research
	name = "研究职位"

/datum/timelock/research/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_RESEARCH_ROLES_LIST

/datum/timelock/corporate
	name = "公司职位"

/datum/timelock/corporate/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_CORPORATE_ROLES_LIST


/datum/timelock/civil
	name = "文职职位"

/datum/timelock/civil/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_CIVIL_ROLES_LIST
