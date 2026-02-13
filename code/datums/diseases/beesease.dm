/*
/datum/disease/beesease
	name = "蜂毒"
	max_stages = 5
	spread = "Contact" //ie shot bees
	cure = "???"
	cure_id = "???"
	agent = "Bees"
	affected_species = list("人类","猴子")
	curable = 0

/datum/disease/beesease/stage_act()
	..()
	switch(stage)
		if(1)
			if(prob(2))
				to_chat(affected_mob, SPAN_DANGER("你感觉体内有东西在动。"))
		if(2) //also changes say, see say.dm
			if(prob(2))
				to_chat(affected_mob, SPAN_DANGER("你感觉体内有东西在动。"))
			if(prob(2))
				to_chat(affected_mob, SPAN_DANGER("BZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"))
		if(3)
		//Should give the bee spit verb
		if(4)
		//Plus bees now spit randomly
		if(5)
		//Plus if you die, you explode into bees
	return
*/
//Started working on it, but am too lazy to finish it today -- Urist
