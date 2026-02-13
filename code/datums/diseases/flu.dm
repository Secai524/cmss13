/datum/disease/flu
	name = "流感"
	max_stages = 3
	spread = "Airborne"
	cure = "太空青霉素"
	cure_id = "spaceacillin"
	cure_chance = 10
	agent = "H13N1 flu virion"
	affected_species = list("人类", "猴子")
	permeability_mod = 0.75
	desc = "若不治疗，对象会感到非常不适。"
	severity = "Medium"

/datum/disease/flu/stage_act()
	..()
	switch(stage)
		if(2)
/*
			if(affected_mob.sleeping && prob(20))  //removed until sleeping is fixed --Blaank
				to_chat(affected_mob, SPAN_NOTICE("你感觉好些了。"))
				stage--
				return
*/
			if(affected_mob.body_position == LYING_DOWN && prob(20))  //added until sleeping is fixed --Blaank
				to_chat(affected_mob, SPAN_NOTICE("你感觉好些了。"))
				stage--
				return
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				to_chat(affected_mob, SPAN_DANGER("你的肌肉酸痛。"))
				if(prob(20))
					affected_mob.take_limb_damage(1)
			if(prob(1))
				to_chat(affected_mob, SPAN_DANGER("你胃痛。"))
				if(prob(20))
					affected_mob.apply_damage(1, TOX)
					affected_mob.updatehealth()

		if(3)
/*
			if(affected_mob.sleeping && prob(15))  //removed until sleeping is fixed
				to_chat(affected_mob, SPAN_NOTICE("你感觉好些了。"))
				stage--
				return
*/
			if(affected_mob.body_position == LYING_DOWN && prob(15))  //added until sleeping is fixed
				to_chat(affected_mob, SPAN_NOTICE("你感觉好些了。"))
				stage--
				return
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				to_chat(affected_mob, SPAN_DANGER("你的肌肉酸痛。"))
				if(prob(20))
					affected_mob.take_limb_damage(1)
			if(prob(1))
				to_chat(affected_mob, SPAN_DANGER("你胃痛。"))
				if(prob(20))
					affected_mob.apply_damage(1, TOX)
					affected_mob.updatehealth()
	return
