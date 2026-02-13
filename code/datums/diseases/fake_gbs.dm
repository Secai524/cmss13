/datum/disease/fake_gbs
	name = "GBS"
	max_stages = 5
	spread = "On contact"
	spread_type = CONTACT_GENERAL
	cure = "硫磺"
	cure_id = list("sulfur")
	agent = "Gravitokinetic Bipotential SADS-"
	affected_species = list("人类", "猴子")
	desc = "若不治疗，将导致死亡。"
	severity = "少校"

/datum/disease/fake_gbs/stage_act()
	..()
	switch(stage)
		if(2)
			if(prob(1))
				affected_mob.emote("sneeze")
		if(3)
			if(prob(5))
				affected_mob.emote("cough")
			else if(prob(5))
				affected_mob.emote("gasp")
			if(prob(10))
				to_chat(affected_mob, SPAN_DANGER("你开始感到非常虚弱..."))
		if(4)
			if(prob(10))
				affected_mob.emote("cough")

		if(5)
			if(prob(10))
				affected_mob.emote("cough")
