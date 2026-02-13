/datum/job/logistics/requisition
	title = JOB_CHIEF_REQUISITION
	selection_class = "job_qm"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/qm
	entry_message_body = "<a href='"+WIKI_PLACEHOLDER+"'>你的工作</a>是向海军陆战队员分发物资，包括武器配件。你的货运技术员可以帮助你，但你在部门内有最终决定权。确保他们不偷懒。虽然你可以要求物资的文书工作，但不要故意刁难陆战队员，除非你想被罢免。一艘快乐的船是一艘运转良好的船。"
	var/mob/living/carbon/human/active_chief_requisition

/datum/job/logistics/requisition/generate_entry_conditions(mob/living/chief_requisition, whitelist_status)
	. = ..()
	active_chief_requisition = chief_requisition
	RegisterSignal(chief_requisition, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_active_chief_requisition))

/datum/job/logistics/requisition/proc/cleanup_active_chief_requisition(mob/chief_requisition)
	SIGNAL_HANDLER
	active_chief_requisition = null

/datum/job/logistics/requisition/get_active_player_on_job()
	return active_chief_requisition

AddTimelock(/datum/job/logistics/requisition, list(
	JOB_REQUISITION_ROLES = 10 HOURS,
))

/obj/effect/landmark/start/requisition
	name = JOB_CHIEF_REQUISITION
	icon_state = "ro_spawn"
	job = /datum/job/logistics/requisition
