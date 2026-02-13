/datum/paygrade/freelancer
	name = "自由佣兵薪级"
	fprefix = "Frl."
	pay_multiplier = 0.75 //these are shitty mercs.

/datum/paygrade/freelancer/standard
	name = "自由佣兵"
	paygrade = PAY_SHORT_FL_S
	prefix = "Merc."

/datum/paygrade/freelancer/medic
	name = "自由佣兵医疗兵"
	paygrade = PAY_SHORT_FL_M
	prefix = "Med."

/datum/paygrade/freelancer/leader
	name = "自由佣兵队长"
	paygrade = PAY_SHORT_FL_WL
	prefix = "Warlord"
	pay_multiplier = 1
	officer_grade = GRADE_OFFICER

/datum/paygrade/freelancer/elite
	name = "精英自由佣兵薪级"
	fprefix = "Elt."
	pay_multiplier = 1.25

/datum/paygrade/freelancer/elite/standard
	name = "精英自由佣兵"
	paygrade = PAY_SHORT_EFL_S
	prefix = "Merc."

/datum/paygrade/freelancer/elite/heavy
	name = "精英自由佣兵重装兵"
	paygrade = PAY_SHORT_EFL_H
	prefix = "Hvy."

/datum/paygrade/freelancer/elite/engineer
	name = "精英自由工程师"
	paygrade = PAY_SHORT_EFL_E
	prefix = "Eng."

/datum/paygrade/freelancer/elite/medic
	name = "精英自由医疗兵"
	paygrade = PAY_SHORT_EFL_M
	prefix = "Med."

/datum/paygrade/freelancer/elite/leader
	name = "精英自由队长"
	paygrade = PAY_SHORT_EFL_TL
	prefix = "Warlord"
	pay_multiplier = 1.5
	officer_grade = GRADE_OFFICER
