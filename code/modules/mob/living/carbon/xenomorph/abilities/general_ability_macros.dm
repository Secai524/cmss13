// All xeno ability macros are handled here
// If you want to add a new one:
// Copy the plant weeds macro, change only the 'set name =', and add a macro_path var to the corresponding ability in Abilities.dm

/datum/action/xeno_action/verb/verb_pounce()
	set category = "Alien"
	set name = "猛扑"
	set hidden = TRUE
	var/action_name = "猛扑"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_plant_weeds()
	set category = "Alien"
	set name = "Plant Weeds"
	set hidden = TRUE
	var/action_name = "铺设菌毯 (75)"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_mark_resin()
	set category = "Alien"
	set name = "标记树脂"
	set hidden = TRUE
	var/action_name = "标记树脂"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_toggle_spit_type()
	set category = "Alien"
	set name = "切换喷吐类型"
	set hidden = TRUE
	var/action_name = "切换喷吐类型"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_release_haul()
	set category = "Alien"
	set name = "释放"
	set hidden = TRUE
	var/action_name = "释放"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_choose_resin_structure()
	set category = "Alien"
	set name = "选择树脂结构"
	set hidden = TRUE
	var/action_name = "选择树脂结构"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_secrete_resin()
	set category = "Alien"
	set name = "分泌树脂"
	set hidden = TRUE
	var/action_name = "Secrete Resin (150)"
	if(ishivelord(src)) // >:( special snowflake caste
		action_name = "分泌树脂 (200)"
	handle_xeno_macro(src, action_name)

/* Resolve this line once structures are resolved.
/datum/action/xeno_action/verb/verb_morph_resin()
	set category = "Alien"
	set name = "Resin Morph"
	set hidden = TRUE
	var/action_name = "Resin Morph (125)"
	handle_xeno_macro(src, action_name)
*/

/datum/action/xeno_action/verb/verb_corrosive_acid()
	set category = "Alien"
	set name = "腐蚀酸液"
	set hidden = TRUE
	var/action_name = "腐蚀酸液 (100)"

	var/mob/living/carbon/xenomorph/X = src // different levels of have different names
	switch(X.acid_level)
		if(1)
			action_name = "腐蚀酸液 (75)"
		if(2)
			action_name = "腐蚀酸液 (100)"
		if(3)
			action_name = "腐蚀酸液 (125)"

	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_spray_acid()
	set category = "Alien"
	set name = "喷洒酸液"
	set hidden = TRUE
	var/action_name = "喷洒酸液"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_burrow()
	set category = "Alien"
	set name = "掘地"
	set hidden = TRUE
	var/action_name = "掘地"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_xeno_spit()
	set category = "Alien"
	set name = "异形吐息"
	set hidden = TRUE
	var/action_name = "异形吐息"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_hide()
	set category = "Alien"
	set name = "隐藏"
	set hidden = TRUE
	var/action_name = "隐藏"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_pheremones()
	set category = "Alien"
	set name = "释放信息素"
	set hidden = TRUE
	var/action_name = "释放信息素 (30)"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_transfer_plasma()
	set category = "Alien"
	set name = "转移等离子体"
	set hidden = TRUE
	var/action_name = "转移等离子体"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_toggle_long_range()
	set category = "Alien"
	set name = "切换远程瞄准"
	set hidden = TRUE
	var/action_name = "切换远程瞄准"
	if(isrunner(src))
		action_name = "切换远程视野 (10)"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_resin_hole()
	set category = "Alien"
	set name = "Place resin hole"
	set hidden = TRUE
	var/action_name = "放置树脂孔 (200)"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_stomp()
	set category = "Alien"
	set name = "践踏"
	set hidden = TRUE
	var/action_name = "Stomp (50)"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_toggle_charge()
	set category = "Alien"
	set name = "切换冲锋状态"
	set hidden = TRUE
	var/action_name = "切换冲锋状态"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_resin_walker()
	set category = "Alien"
	set name = "Resin Walker"
	set hidden = TRUE
	var/action_name = "树脂行者 (50)"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_dig_tunnel()
	set category = "Alien"
	set name = "Dig Tunnel"
	set hidden = TRUE
	var/action_name = "挖掘隧道 (200)"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_screech()
	set category = "Alien"
	set name = "尖啸"
	set hidden = TRUE
	var/action_name = "尖啸（250）"
	handle_xeno_macro(src, action_name)


/datum/action/xeno_action/verb/verb_watch_xeno()
	set category = "Alien"
	set name = "观察异形"
	set hidden = TRUE
	var/action_name = "观察异形"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_heal_xeno()
	set category = "Alien"
	set name = "Heal Xenomorph"
	set hidden = TRUE
	var/action_name = "治疗异形（600）"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_plasma_xeno()
	set category = "Alien"
	set name = "Give Plasma"
	set hidden = TRUE
	var/action_name = "Give Plasma (600)"
	handle_xeno_macro(src, action_name)

// night vision is special
/datum/action/xeno_action/verb/verb_night_vision()
	set category = "Alien"
	set name = "Toggle Nightvision"
	set hidden = TRUE
	var/mob/living/carbon/C = src
	for(var/atom/movable/screen/xenonightvision/B in C.client.screen)
		B.clicked(src)

/datum/action/xeno_action/verb/place_construction()
	set category = "Alien"
	set name = "Order Construction"
	set hidden = TRUE
	var/action_name = "下令建造 (400)"
	handle_xeno_macro(src, action_name)
