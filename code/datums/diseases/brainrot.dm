/datum/disease/brainrot
	name = "脑腐病"
	max_stages = 4
	spread = "On contact"
	spread_type = CONTACT_GENERAL
	cure = "阿尔基辛"
	cure_id = list("alkysine")
	agent = "Cryptococcus Cosmosis"
	affected_species = list("人类")
	curable = 0
	cure_chance = 15//higher chance to cure, since two reagents are required
	desc = "这种疾病会破坏脑细胞，导致脑热、脑坏死和全身中毒。"
	severity = "少校"

/datum/disease/brainrot/stage_act() //Removed toxloss because damaging diseases are pretty horrible. Last round it killed the entire station because the cure didn't work -- Urist
	..()
	switch(stage)
		if(2)
			if(prob(2))
				affected_mob.emote("blink")
			if(prob(2))
				affected_mob.emote("yawn")
			if(prob(2))
				to_chat(affected_mob, SPAN_DANGER("你感觉不像自己了。"))
			if(prob(5))
				affected_mob.adjustBrainLoss(1)
				affected_mob.updatehealth()
		if(3)
			if(prob(2))
				affected_mob.emote("stare")
			if(prob(2))
				affected_mob.emote("drool")
			if(prob(10) && affected_mob.getBrainLoss()<=98)//shouldn't brain damage you to death now
				affected_mob.adjustBrainLoss(2)
				affected_mob.updatehealth()
				if(prob(2))
					to_chat(affected_mob, SPAN_DANGER("你试图回忆某件重要的事...但想不起来。"))
/* if(prob(10))
				affected_mob.apply_damage(3, TOX)
				affected_mob.updatehealth()
				if(prob(2))
					to_chat(affected_mob, SPAN_DANGER("你头痛。")) */
		if(4)
			if(prob(2))
				affected_mob.emote("stare")
			if(prob(2))
				affected_mob.emote("drool")
/* if(prob(15))
				affected_mob.apply_damage(4, TOX)
				affected_mob.updatehealth()
				if(prob(2))
					to_chat(affected_mob, SPAN_DANGER("你头痛。")) */
			if(prob(15) && affected_mob.getBrainLoss()<=98) //shouldn't brain damage you to death now
				affected_mob.adjustBrainLoss(3)
				affected_mob.updatehealth()
				if(prob(2))
					to_chat(affected_mob, SPAN_DANGER("奇怪的嗡鸣声充斥你的脑海，驱散了所有思绪。"))
			if(prob(3))
				to_chat(affected_mob, SPAN_DANGER("你失去了意识..."))
				for(var/mob/O in viewers(affected_mob, null))
					O.show_message("[affected_mob]突然倒下", SHOW_MESSAGE_VISIBLE)
				affected_mob.apply_effect(rand(5,10), PARALYZE)
				if(prob(1))
					affected_mob.emote("snore")
			if(prob(15))
				affected_mob.stuttering += 3
	return
