/datum/action/xeno_action/verb/verb_gut()
	set category = "Alien"
	set name = "Gut"
	set hidden = TRUE
	var/action_name = "开膛（200）"
	handle_xeno_macro(src, action_name)

/datum/action/xeno_action/verb/verb_projected_resin()
	set category = "Alien"
	set name = "Projected Resin"
	set hidden = TRUE
	var/action_name = "投射树脂 (100)"
	handle_xeno_macro(src, action_name)
