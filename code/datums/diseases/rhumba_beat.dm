/datum/disease/rhumba_beat
	name = "伦巴节奏"
	max_stages = 5
	spread = "On contact"
	spread_type = CONTACT_GENERAL
	cure = "Chick Chicky Boom!"
	cure_id = list("phoron")
	agent = "未知"
	affected_species = list("人类")
	permeability_mod = 1

/datum/disease/rhumba_beat/stage_act()
	..()
	switch(stage)
		if(1)
			if(affected_mob.ckey == "rosham")
				src.cure()
		if(2)
			if(affected_mob.ckey == "rosham")
				src.cure()
			if(prob(45))
				affected_mob.apply_damage(5, TOX)
				affected_mob.updatehealth()
			if(prob(1))
				to_chat(affected_mob, SPAN_DANGER("你觉得有点不对劲……"))
		if(3)
			if(affected_mob.ckey == "rosham")
				src.cure()
			if(prob(5))
				to_chat(affected_mob, SPAN_DANGER("你感到一股跳舞的冲动……"))
			else if(prob(5))
				affected_mob.emote("gasp")
			else if(prob(10))
				to_chat(affected_mob, SPAN_DANGER("你觉得需要来点“恰恰恰”……"))
		if(4)
			if(affected_mob.ckey == "rosham")
				src.cure()
			if(prob(10))
				affected_mob.emote("gasp")
				to_chat(affected_mob, SPAN_DANGER("你感到体内有一股燃烧的节奏……"))
			if(prob(20))
				affected_mob.apply_damage(5, TOX)
				affected_mob.updatehealth()
		if(5)
			if(affected_mob.ckey == "rosham")
				src.cure()
			to_chat(affected_mob, SPAN_DANGER("你的身体无法承受这伦巴节奏……"))
			if(prob(50))
				affected_mob.gib()
		else
			return
