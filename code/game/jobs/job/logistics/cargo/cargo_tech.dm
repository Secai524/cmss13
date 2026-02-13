/datum/job/logistics/cargo
	title = JOB_CARGO_TECH
	total_positions = 2
	spawn_positions = 2
	allow_additional = 1
	scaled = 1
	supervisors = "军需官"
	selection_class = "job_ct"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/cargo
	entry_message_body = "<a href='"+WIKI_PLACEHOLDER+"'>你的工作</a>是向海军陆战队员分发物资，包括武器配件。尽可能待在部门内，确保陆战队员能够充分获取他们可能需要的物资。注意无线电通讯，以防有人通过监视系统请求补给空投。"

AddTimelock(/datum/job/logistics/cargo, list(
	JOB_HUMAN_ROLES = 10 HOURS,
))

/datum/job/logistics/cargo/set_spawn_positions(count)
	spawn_positions = ct_slot_formula(count)

/datum/job/logistics/cargo/get_total_positions(latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = ct_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	else
		total_positions_so_far = positions
	return positions

/obj/effect/landmark/start/cargo
	name = JOB_CARGO_TECH
	icon_state = "ct_spawn"
	job = /datum/job/logistics/cargo
