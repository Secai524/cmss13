/datum/job/marine
	supervisors = "代理班长"
	selection_class = "job_marine"
	total_positions = 8
	spawn_positions = 8
	allow_additional = 1

/datum/job/marine/generate_entry_message(mob/living/carbon/human/current_human)
	if(current_human.assigned_squad)
		entry_message_intro = "你是一名[title]！<br>你已被分配至：<b><font size=3 color=[current_human.assigned_squad.equipment_color]>[lowertext(current_human.assigned_squad.name)]小队</font></b>。[Check_WO() ?"" : " 前往食堂享用一些冷冻睡眠后的食物，然后到你小队的准备室装备自己。" ]"
	return ..()

/datum/job/marine/generate_entry_conditions(mob/living/carbon/human/current_human)
	..()
	if(!Check_WO())
		current_human.nutrition = rand(NUTRITION_VERYLOW, NUTRITION_LOW) //Start hungry for the default marine.

/datum/timelock/squad
	name = "班组成员职位"

/datum/timelock/squad/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_SQUAD_ROLES_LIST
