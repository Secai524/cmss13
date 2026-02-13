/datum/job/antag/xenos/queen
	title = JOB_XENOMORPH_QUEEN
	role_ban_alternative = "Queen"
	supervisors = "女王"
	selection_class = "job_xeno_queen"
	total_positions = 1
	spawn_positions = 1

/datum/job/antag/xenos/queen/set_spawn_positions(count)
	return spawn_positions

/datum/job/antag/xenos/queen/transform_to_xeno(mob/living/carbon/human/human_to_transform, hive_index)
	SSticker.mode.pick_queen_spawn(human_to_transform, hive_index)

/datum/job/antag/xenos/queen/announce_entry_message(mob/new_queen, account, whitelist_status)
	if(Check_WO())
		to_chat(new_queen, "<B>你现在是异形女王！</B>")
		to_chat(new_queen, "<B>你的任务是协助巢穴攻击人类前哨站！</B>")
		to_chat(new_queen, "<B>你应该从种植菌毯和生长产卵器开始，你的孩子们将在回合时间0:20左右出现。回合时间达到1:00后，你将能够离开你的洞穴。</B>")
		to_chat(new_queen, "使用<strong>;</strong>在蜂巢思维中交谈（例如‘;你好，我的孩子们！’）")
	else
		to_chat(new_queen, "<B>你现在是异形女王！</B>")
		to_chat(new_queen, "<B>你的任务是扩张巢穴。</B>")
		to_chat(new_queen, "<B>你应该从建造一个巢穴核心开始。</B>")
		to_chat(new_queen, "使用<strong>;</strong>在蜂巢思维中交谈（例如‘;你好，我的孩子们！’）")

AddTimelock(/datum/job/antag/xenos/queen, list(
	JOB_XENO_ROLES = 10 HOURS,
	JOB_DRONE_ROLES = 5 HOURS,
	JOB_T3_ROLES = 3 HOURS,
))
