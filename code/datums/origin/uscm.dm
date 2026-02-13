/datum/origin/uscm
	name = ORIGIN_USCM
	desc = "你出生在美利坚合众国，这整个宇宙里最他妈棒的国家。"


/datum/origin/uscm/luna
	name = ORIGIN_USCM_LUNA
	desc = "你出生在一个环绕地球的月球基地上。要我说，这他妈酷毙了。"


/datum/origin/uscm/other
	name = ORIGIN_USCM_OTHER
	desc = "你出生在美洲合众国一个不起眼的国家。"


/datum/origin/uscm/colony
	name = ORIGIN_USCM_COLONY
	desc = "你出生在一个维兰德-汤谷殖民地，加入陆战队是你逃离那个地狱的唯一出路。"


/datum/origin/uscm/foreign
	name = ORIGIN_USCM_FOREIGN
	desc = "你出生在美洲合众国之外，从出生起就被视为无关紧要。"


/datum/origin/uscm/aw
	name = ORIGIN_USCM_AW
	desc = "你是一项旨在培育完美超级士兵的实验性军事计划的产物。在某些方面，他们成功了。"

/datum/origin/uscm/aw/generate_human_name(gender = MALE)
	switch(gender)
		if(FEMALE)
			return "[capitalize(pick(GLOB.first_names_female))] A.W. [capitalize(pick(GLOB.weapon_surnames))]"
		if(PLURAL, NEUTER)
			return "[capitalize(pick(MALE, FEMALE) == MALE ? pick(GLOB.first_names_male) : pick(GLOB.first_names_female))] A.W. [capitalize(pick(GLOB.weapon_surnames))]"
		else // MALE
			return "[capitalize(pick(GLOB.first_names_male))] A.W. [capitalize(pick(GLOB.weapon_surnames))]"

/datum/origin/uscm/aw/validate_name(name_to_check)
	if(!findtext(name_to_check, "A.W. "))
		return "Sorry, as a Artificial-Womb soldier, your character's 'middle-name' must be 'A.W.'."
	return null

/datum/origin/uscm/aw/correct_name(name_to_check, gender = MALE)
	if(!findtext(name_to_check, "A.W. "))
		name_to_check = generate_human_name(gender)
	return name_to_check

/datum/origin/uscm/convict
	name = null // Abstract type

/datum/origin/uscm/convict/minor
	name = ORIGIN_USCM_CONVICT_MINOR
	desc = "你的出生地无关紧要，在所有人看来，你因多项轻微罪行被定罪，并被提供了一个出路：USCM。"

/datum/origin/uscm/convict/gang
	name = ORIGIN_USCM_CONVICT_GANG
	desc = "你的出生地无关紧要，在所有人看来，你因涉黑帮罪行被定罪，并被提供了一个出路：USCM。"

/datum/origin/uscm/convict/smuggling
	name = ORIGIN_USCM_CONVICT_SMUGGLING
	desc = "你的出生地无关紧要，在所有人看来，你因走私（可能还有些海盗行为）被定罪，并被提供了一个出路：USCM。"
