GLOBAL_LIST_INIT_TYPED(underwear_m, /datum/sprite_accessory/underwear, setup_underwear(MALE))
GLOBAL_LIST_INIT_TYPED(underwear_f, /datum/sprite_accessory/underwear, setup_underwear(FEMALE))

/proc/setup_underwear(restricted_gender)
	var/list/underwear_list = list()
	for(var/underwear_type in subtypesof(/datum/sprite_accessory/underwear))
		var/datum/sprite_accessory/underwear/underwear_datum = new underwear_type
		if(restricted_gender && underwear_datum.gender != restricted_gender && (underwear_datum.gender == MALE || underwear_datum.gender == FEMALE))
			continue
		if(underwear_datum.camo_conforming)
			underwear_list["[underwear_datum.name] (Camo Conforming)"] = underwear_datum
		else
			underwear_list[underwear_datum.name] = underwear_datum
	return underwear_list

/datum/sprite_accessory/underwear
	icon = 'icons/mob/humans/underwear.dmi'
	var/camo_conforming = FALSE

/datum/sprite_accessory/underwear/proc/get_image(mob_gender)
	var/selected_icon_state = icon_state
	if(camo_conforming)
		switch(SSmapping.configs[GROUND_MAP].camouflage_type)
			if("classic")
				selected_icon_state = "classic_" + selected_icon_state
			if("jungle")
				selected_icon_state = "jungle_" + selected_icon_state
			if("desert")
				selected_icon_state = "desert_" + selected_icon_state
			if("snow")
				selected_icon_state = "snow_" + selected_icon_state
			if("urban")
				selected_icon_state = "urban_" + selected_icon_state
	if(gender == PLURAL)
		selected_icon_state += mob_gender == MALE ? "_m" : "_f"
	return image(icon, selected_icon_state)

/datum/sprite_accessory/underwear/proc/generate_non_conforming(camo_key)
	camo_conforming = FALSE
	icon_state = "[camo_key]_[icon_state]"
	switch(camo_key)
		if("classic")
			name += " (Classic)"
		if("jungle")
			name += " (Jungle)"
		if("desert")
			name += " (Desert)"
		if("snow")
			name += " (Snow)"
		if("urban")
			name += " (Urban)"

// Both
/datum/sprite_accessory/underwear/boxers
	name = "平角裤"
	icon_state = "boxers"
	gender = NEUTER
	camo_conforming = TRUE

/datum/sprite_accessory/underwear/briefs
	name = "三角裤"
	icon_state = "briefs"
	gender = NEUTER
	camo_conforming = TRUE

/datum/sprite_accessory/underwear/lowriders
	name = "低腰裤"
	icon_state = "lowriders"
	gender = NEUTER
	camo_conforming = TRUE

/datum/sprite_accessory/underwear/satin
	name = "缎面"
	icon_state = "satin"
	gender = NEUTER
	camo_conforming = TRUE

/datum/sprite_accessory/underwear/tanga
	name = "丁字裤"
	icon_state = "tanga"
	gender = NEUTER
	camo_conforming = TRUE


/datum/sprite_accessory/underwear/boxers/black
	name = "平角裤（黑色）"
	icon_state = "b_boxers"
	gender = NEUTER
	camo_conforming = FALSE

/datum/sprite_accessory/underwear/briefs/black
	name = "三角裤（黑色）"
	icon_state = "b_briefs"
	gender = NEUTER
	camo_conforming = FALSE

/datum/sprite_accessory/underwear/lowriders/black
	name = "低腰裤（黑色）"
	icon_state = "b_lowriders"
	gender = NEUTER
	camo_conforming = FALSE

/datum/sprite_accessory/underwear/satin/black
	name = "缎面（黑色）"
	icon_state = "b_satin"
	gender = NEUTER
	camo_conforming = FALSE

/datum/sprite_accessory/underwear/tanga/black
	name = "丁字裤（黑色）"
	icon_state = "b_tanga"
	gender = NEUTER
	camo_conforming = FALSE

