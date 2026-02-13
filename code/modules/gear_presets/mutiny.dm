/datum/equipment_preset/other/mutiny/mutineer
	name = "叛变者"
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/other/mutiny/mutineer/load_status(mob/living/carbon/human/new_human)
	. = ..()
	new_human.mob_flags |= MUTINY_MUTINEER
	new_human.hud_set_squad()

	to_chat(new_human, SPAN_HIGHDANGER("<hr>你现在是一名叛变者！"))
	to_chat(new_human, SPAN_DANGER("请查看规则，了解作为叛变者能做和不能做的事。<hr>"))
	log_game("MUTINY - [key_name(new_human)] became a [name]")

/datum/equipment_preset/other/mutiny/mutineer/leader
	name = "叛变者领袖"
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/other/mutiny/mutineer/leader/load_status(mob/living/carbon/human/new_human)
	for(var/datum/action/human_action/activable/mutineer/A in new_human.actions)
		A.remove_from(new_human)

	var/list/abilities = subtypesof(/datum/action/human_action/activable/mutineer)
	for(var/type in abilities)
		give_action(new_human, type)

/datum/equipment_preset/other/mutiny/loyalist
	name = "忠诚派"
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/other/mutiny/loyalist/load_status(mob/living/carbon/human/new_human)
	. = ..()
	new_human.mob_flags |= MUTINY_LOYALIST
	new_human.hud_set_squad()

	to_chat(new_human, SPAN_HIGHDANGER("<hr>你现在是一名忠诚派！"))
	to_chat(new_human, SPAN_DANGER("请查看规则，了解作为忠诚派能做和不能做的事。<hr>"))
	log_game("MUTINY - [key_name(new_human)] became a [name]")

/datum/equipment_preset/other/mutiny/noncombat
	name = "非战斗人员"
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/other/mutiny/noncombat/load_status(mob/living/carbon/human/new_human)
	. = ..()
	new_human.mob_flags |= MUTINY_NONCOMBAT
	new_human.hud_set_squad()

	to_chat(new_human, SPAN_HIGHDANGER("<hr>你现在是一名非战斗人员！"))
	to_chat(new_human, SPAN_DANGER("你不得介入兵变。你可以治疗任何一方，但不得参与或卷入战斗。<hr>"))
	log_game("MUTINY - [key_name(new_human)] became a [name]")
