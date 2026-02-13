GLOBAL_LIST_INIT_TYPED(undershirt_m, /datum/sprite_accessory/undershirt, setup_undershirt(MALE))
GLOBAL_LIST_INIT_TYPED(undershirt_f, /datum/sprite_accessory/undershirt, setup_undershirt(FEMALE))

/proc/setup_undershirt(restricted_gender)
	var/list/undershirt_list = list()
	for(var/undershirt_type in subtypesof(/datum/sprite_accessory/undershirt))
		var/datum/sprite_accessory/undershirt/undershirt_datum = new undershirt_type
		if(restricted_gender && undershirt_datum.gender != restricted_gender && (undershirt_datum.gender == MALE || undershirt_datum.gender == FEMALE))
			continue
		if(undershirt_datum.camo_conforming)
			undershirt_list["[undershirt_datum.name] (Camo Conforming)"] = undershirt_datum
		else
			undershirt_list[undershirt_datum.name] = undershirt_datum
	return undershirt_list

/datum/sprite_accessory/undershirt
	icon = 'icons/mob/humans/undershirt.dmi'
	var/camo_conforming = FALSE

	/// If this undershirt should be displayed while a uniform is worn
	var/shown_under_uniform = FALSE

/datum/sprite_accessory/undershirt/proc/get_image(mob_gender)
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

/datum/sprite_accessory/undershirt/proc/generate_non_conforming(camo_key)
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

// Plural
/datum/sprite_accessory/undershirt/undershirt
	name = "汗衫（棕褐色）"
	icon_state = "t_undershirt"
	gender = NEUTER

	shown_under_uniform = TRUE
	camo_conforming = TRUE

/datum/sprite_accessory/undershirt/undershirt/black
	name = "汗衫（黑色）"
	icon_state = "b_undershirt"
	camo_conforming = FALSE

/datum/sprite_accessory/undershirt/undershirt/sleeveless
	name = "汗衫（棕褐色，无袖）"
	icon_state = "t_undershirt_sleeveless"
	camo_conforming = TRUE

/datum/sprite_accessory/undershirt/undershirt/sleeveless/black
	name = "汗衫（黑色，无袖）"
	icon_state = "b_undershirt_sleeveless"
	camo_conforming = FALSE

/datum/sprite_accessory/undershirt/undershirt/rolled
	name = "汗衫（棕褐色，卷袖）"
	icon_state = "t_rolled_undershirt"
	camo_conforming = TRUE

/datum/sprite_accessory/undershirt/undershirt/rolled/black
	name = "汗衫（黑色，卷袖）"
	icon_state = "b_rolled_undershirt"
	camo_conforming = FALSE

/datum/sprite_accessory/undershirt/undershirt/rolled_sleeveless
	name = "汗衫（棕褐色，卷袖，无袖）"
	icon_state = "t_rolled_undershirt_sleeveless"
	camo_conforming = TRUE

/datum/sprite_accessory/undershirt/undershirt/rolled_sleeveless/black
	name = "汗衫（黑色，卷袖，无袖）"
	icon_state = "b_rolled_undershirt_sleeveless"
	camo_conforming = FALSE

/datum/sprite_accessory/undershirt/undershirt/long
	name = "汗衫（棕褐色，长袖）"
	icon_state = "t_long_undershirt"
	camo_conforming = TRUE

/datum/sprite_accessory/undershirt/undershirt/long/black
	name = "汗衫（黑色，长袖）"
	icon_state = "b_long_undershirt"
	camo_conforming = FALSE

// Male
/datum/sprite_accessory/undershirt/none
	name = "无"
	icon_state = "none"
	gender = MALE

// Female
/datum/sprite_accessory/undershirt/bra
	name = "文胸"
	icon_state = "bra"
	gender = FEMALE
	camo_conforming = TRUE

/datum/sprite_accessory/undershirt/bra/black
	name = "文胸（黑色）"
	icon_state = "b_bra"
	gender = FEMALE
	camo_conforming = FALSE

/datum/sprite_accessory/undershirt/sports_bra
	name = "运动文胸"
	icon_state = "sports"
	gender = FEMALE
	camo_conforming = TRUE

/datum/sprite_accessory/undershirt/sports_bra/black
	name = "运动文胸（黑色）"
	icon_state = "b_sports"
	gender = FEMALE
	camo_conforming = FALSE

/datum/sprite_accessory/undershirt/strapless_bra
	name = "无肩带文胸"
	icon_state = "strapless"
	gender = FEMALE
	camo_conforming = TRUE

/datum/sprite_accessory/undershirt/strapless_bra/black
	name = "无肩带文胸（黑色）"
	icon_state = "b_strapless"
	gender = FEMALE
	camo_conforming = FALSE
