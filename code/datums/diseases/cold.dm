/datum/disease/cold
	name = "风寒"
	max_stages = 3
	spread = "Airborne"
	cure = "Rest & Spaceacillin"
	cure_id = "spaceacillin"
	agent = "XY-rhinovirus"
	affected_species = list("人类", "猴子")
	permeability_mod = 0.5
	desc = "若不治疗，对象将感染流感。"
	severity = "Minor"

/datum/disease/cold/stage_act()
	..()
	switch(stage)
		if(2)
/*
			if(affected_mob.sleeping && prob(40))  //removed until sleeping is fixed
				to_chat(affected_mob, SPAN_NOTICE("你感觉好些了。"))
				cure()
				return
*/
			if(affected_mob.body_position == LYING_DOWN && prob(40))  //changed FROM prob(10) until sleeping is fixed
				to_chat(affected_mob, SPAN_NOTICE("你感觉好些了。"))
				cure()
				return
			if(prob(1) && prob(5))
				to_chat(affected_mob, SPAN_NOTICE("你感觉好些了。"))
				cure()
				return
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				to_chat(affected_mob, SPAN_DANGER("你喉咙痛。"))
			if(prob(1))
				to_chat(affected_mob, SPAN_DANGER("粘液顺着你的喉咙流下。"))
		if(3)
/*
			if(affected_mob.sleeping && prob(25))  //removed until sleeping is fixed
				to_chat(affected_mob, SPAN_NOTICE("你感觉好些了。"))
				cure()
				return
*/
			if(affected_mob.body_position == LYING_DOWN && prob(25))  //changed FROM prob(5) until sleeping is fixed
				to_chat(affected_mob, SPAN_NOTICE("你感觉好些了。"))
				cure()
				return
			if(prob(1) && prob(1))
				to_chat(affected_mob, SPAN_NOTICE("你感觉好些了。"))
				cure()
				return
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				to_chat(affected_mob, SPAN_DANGER("你喉咙痛。"))
			if(prob(1))
				to_chat(affected_mob, SPAN_DANGER("粘液顺着你的喉咙流下。"))
			if(prob(1) && prob(50))
				if(!affected_mob.resistances.Find(/datum/disease/flu))
					var/datum/disease/Flu = new /datum/disease/flu(0)
					affected_mob.contract_disease(Flu,1)
					cure()
