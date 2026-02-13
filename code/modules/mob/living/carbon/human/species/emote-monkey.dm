/datum/emote/living/carbon/human/primate
	species_type_allowed_typecache = list(/datum/species/monkey)
	species_type_blacklist_typecache = list()
	keybind = FALSE

/datum/emote/living/carbon/human/primate/New()  //Monkey's are blacklisted from human emotes on emote.dm, we need to not block the new emotes below
	. = ..()

/datum/emote/living/carbon/human/primate/jump
	key = "jump"
	key_third_person = "jumps"
	message = "跳跃！"

/datum/emote/living/carbon/human/primate/scratch
	key = "scratch"
	key_third_person = "scratches"
	message = "抓挠。"

/datum/emote/living/carbon/human/primate/roll
	key = "roll"
	key_third_person = "rolls"
	message = "翻滚。"

/datum/emote/living/carbon/human/primate/tail
	key = "tail"
	message = "甩动尾巴。"

/datum/emote/living/carbon/human/primate/chimper
	key = "chimper"
	key_third_person = "chimpers"
	message = "吱吱叫。"

/datum/emote/living/carbon/human/primate/whimper
	key = "whimper"
	key_third_person = "whimpers"
	message = "呜咽。"
