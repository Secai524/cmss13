/datum/disease/fluspanish
	name = "西班牙宗教裁判所流感"
	max_stages = 3
	spread = "Airborne"
	cure = "Spaceacillin & Anti-bodies to the common flu"
	cure_id = "spaceacillin"
	cure_chance = 10
	agent = "1nqu1s1t10n flu virion"
	affected_species = list("人类")
	permeability_mod = 0.75
	desc = "若不治疗，对象将因身为异端而被烧死。"
	severity = "Serious"

/datum/disease/inquisition/stage_act()
	..()
	switch(stage)
		if(2)
			affected_mob.bodytemperature += 10
			affected_mob.recalculate_move_delay = TRUE
			if(prob(5))
				affected_mob.emote("sneeze")
			if(prob(5))
				affected_mob.emote("cough")
			if(prob(1))
				to_chat(affected_mob, SPAN_DANGER("你在自己的皮肤里燃烧！"))
				affected_mob.take_limb_damage(0,5)

		if(3)
			affected_mob.bodytemperature += 20
			affected_mob.recalculate_move_delay = TRUE
			if(prob(5))
				affected_mob.emote("sneeze")
			if(prob(5))
				affected_mob.emote("cough")
			if(prob(5))
				to_chat(affected_mob, SPAN_DANGER("你在自己的皮肤里燃烧！"))
				affected_mob.take_limb_damage(0,5)
	return
