/datum/paygrade/civilian
	name = "平民职级"
	pay_multiplier = 0.5 // civvies are poor

/datum/paygrade/civilian/civilian
	paygrade = PAY_SHORT_CIV
	name = "平民"
	prefix = "C"

/datum/paygrade/civilian/nurse
	paygrade = PAY_SHORT_CNUR
	name = "护士"
	prefix = "Nrs."

/datum/paygrade/civilian/paramedic
	paygrade = PAY_SHORT_CPARA
	name = "医护兵"
	prefix = "EMT-P"
	pay_multiplier = 0.6

/datum/paygrade/civilian/doctor
	paygrade = PAY_SHORT_CDOC
	name = "医生"
	prefix = "Dr."
	pay_multiplier = 2.5

/datum/paygrade/civilian/assistantprofessor
	paygrade = PAY_SHORT_CCMOA
	name = "助理教授"
	prefix = "Asst. Prof."
	pay_multiplier = 3

/datum/paygrade/civilian/associateprofessor
	paygrade = PAY_SHORT_CCMOB
	name = "副教授"
	prefix = "Assoc. Prof."
	pay_multiplier = 3.5

/datum/paygrade/civilian/professor
	paygrade = PAY_SHORT_CCMOC
	name = "教授"
	prefix = "Prof."
	pay_multiplier = 3.75
	officer_grade = GRADE_OFFICER

/datum/paygrade/civilian/regentsprofessor
	paygrade = PAY_SHORT_CCMOD
	name = "校董教授"
	prefix = "Regents Prof."
	pay_multiplier = 4
	officer_grade = GRADE_OFFICER

/datum/paygrade/civilian/representative
	paygrade = PAY_SHORT_CREP
	name = "代表"
	prefix = "Rep."
	pay_multiplier = 1

/datum/paygrade/civilian/officer
	paygrade = PAY_SHORT_CPO
	name = "警官"
	prefix = "Off."
	pay_multiplier = 0.66

/datum/paygrade/civilian/officer/senior
	paygrade = PAY_SHORT_CSPO
	name = "高级军官"
	prefix = "Sr. Off."
	pay_multiplier = 0.8
	officer_grade = GRADE_OFFICER

/datum/paygrade/civilian/rebel
	paygrade = PAY_SHORT_REB
	name = "反抗军"

/datum/paygrade/civilian/rebel/leader
	paygrade = PAY_SHORT_REBC
	name = "反抗军指挥官"
	prefix = "CMDR."
	officer_grade = GRADE_OFFICER

/datum/paygrade/civilian/administrator
	paygrade = PAY_SHORT_CADMIN
	name = "行政官"
	prefix = "Admn."
	pay_multiplier = 1
