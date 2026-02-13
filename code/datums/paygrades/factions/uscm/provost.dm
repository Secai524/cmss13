/datum/paygrade/provost
	name = "宪兵军衔"
	pay_multiplier = 2
	default_faction = FACTION_MARINE

/datum/paygrade/provost/inspector
	paygrade = PAY_SHORT_PVI
	name = "宪兵督察"
	prefix = "Insp."
	rank_pin = /obj/item/clothing/accessory/ranks/special/insp
	officer_grade = GRADE_FLAG //Not really a flag officer, but they have special access to things for their job.

/datum/paygrade/provost/inspector/chief
	paygrade = PAY_SHORT_PVCI
	name = "宪兵总督察"
	prefix = "Chief Insp."
	rank_pin = /obj/item/clothing/accessory/ranks/special/insp
	officer_grade = GRADE_FLAG //Not really a flag officer, but they have special access to things for their job.

/datum/paygrade/provost/marshal/deputy
	paygrade = PAY_SHORT_PVDM
	name = "宪兵副警长"
	prefix = "Dep. Marshal"
	officer_grade = GRADE_FLAG

/datum/paygrade/provost/marshal
	paygrade = PAY_SHORT_PVM
	name = "宪兵警长"
	prefix = "Marshal"
	officer_grade = GRADE_FLAG

/datum/paygrade/provost/sectormarshal
	paygrade = PAY_SHORT_PVSM
	name = "宪兵区警长"
	prefix = "S. Marshal"
	officer_grade = GRADE_FLAG

/datum/paygrade/provost/chiefmarshal
	paygrade = PAY_SHORT_PVCM
	name = "宪兵总警长"
	prefix = "Chief Marshal"
	officer_grade = GRADE_FLAG
