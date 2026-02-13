/datum/disease/cold9
	name = "风寒"
	max_stages = 3
	spread = "On contact"
	spread_type = CONTACT_GENERAL
	cure = "Common Cold Anti-bodies & Spaceacillin"
	cure_id = "spaceacillin"
	agent = "ICE9-rhinovirus"
	affected_species = list("人类")
	desc = "若不治疗，对象行动会变慢，仿佛部分冻结。"
	severity = "Moderate"

/datum/disease/cold9/stage_act()
	..()
	switch(stage)
		if(2)
			affected_mob.bodytemperature -= 10
			affected_mob.recalculate_move_delay = TRUE
			if(prob(1) && prob(10))
				to_chat(affected_mob, SPAN_NOTICE("你感觉好些了。"))
				cure()
				return
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				to_chat(affected_mob, SPAN_DANGER("你喉咙痛。"))
			if(prob(5))
				to_chat(affected_mob, SPAN_DANGER("你感觉身体僵硬。"))
		if(3)
			affected_mob.bodytemperature -= 20
			affected_mob.recalculate_move_delay = TRUE
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				to_chat(affected_mob, SPAN_DANGER("你喉咙痛。"))
			if(prob(10))
				to_chat(affected_mob, SPAN_DANGER("你感觉身体僵硬。"))
