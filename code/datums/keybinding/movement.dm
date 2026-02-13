/datum/keybinding/movement
	category = CATEGORY_MOVEMENT
	weight = WEIGHT_HIGHEST

/datum/keybinding/movement/north
	hotkey_keys = list("W", "北")
	classic_keys = list("W", "北")
	name = "北"
	full_name = "向北移动"
	description = "Moves your character north"
	keybind_signal = COMSIG_KB_MOVEMENT_NORTH_DOWN

/datum/keybinding/movement/northface
	hotkey_keys = list("Alt+North", "Alt+W")
	classic_keys = list("Alt+North", "Alt+W")
	name = "face_north"
	full_name = "锁定朝向北方"
	description = "Face north"
	keybind_signal = COMSIG_KB_MOVEMENT_FACE_NORTH_DOWN

/datum/keybinding/movement/northface/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.northfaceperm()
	return TRUE

/datum/keybinding/movement/south
	hotkey_keys = list("S", "南")
	classic_keys = list("S", "南")
	name = "南"
	full_name = "向南移动"
	description = "Moves your character south"
	keybind_signal = COMSIG_KB_MOVEMENT_SOUTH_DOWN

/datum/keybinding/movement/southface
	hotkey_keys = list("Alt+South", "Alt+S")
	classic_keys = list("Alt+South", "Alt+S")
	name = "face_south"
	full_name = "锁定朝向南方"
	description = "Face south"
	keybind_signal = COMSIG_KB_MOVEMENT_FACE_SOUTH_DOWN

/datum/keybinding/movement/southface/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.southfaceperm()
	return TRUE
/datum/keybinding/movement/west
	hotkey_keys = list("A", "西")
	classic_keys = list("A", "西")
	name = "西"
	full_name = "向西移动"
	description = "Moves your character left"
	keybind_signal = COMSIG_KB_MOVEMENT_WEST_DOWN

/datum/keybinding/movement/westface
	hotkey_keys = list("Alt+West", "Alt+A")
	classic_keys = list("Alt+West", "Alt+A")
	name = "face_west"
	full_name = "锁定朝向西方"
	description = "Face west"
	keybind_signal = COMSIG_KB_MOVEMENT_FACE_WEST_DOWN

/datum/keybinding/movement/westface/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.westfaceperm()
	return TRUE

/datum/keybinding/movement/east
	hotkey_keys = list("D", "东")
	classic_keys = list("D", "东")
	name = "东"
	full_name = "向东移动"
	description = "Moves your character east"
	keybind_signal = COMSIG_KB_MOVEMENT_EAST_DOWN

/datum/keybinding/movement/eastface
	hotkey_keys = list("Alt+East", "Alt+D")
	classic_keys = list("Alt+East", "Alt+D")
	name = "face_east"
	full_name = "锁定朝向东方"
	description = "Face east"
	keybind_signal = COMSIG_KB_MOVEMENT_FACE_EAST_DOWN

/datum/keybinding/movement/eastface/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.eastfaceperm()
	return TRUE
