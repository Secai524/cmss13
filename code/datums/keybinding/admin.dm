/datum/keybinding/admin
	category = CATEGORY_ADMIN
	weight = WEIGHT_ADMIN

/datum/keybinding/admin/can_use(client/user)
	return user.admin_holder ? TRUE : FALSE

/datum/keybinding/admin/admin_ghost
	hotkey_keys = list("F5")
	classic_keys = list("Unbound")
	name = "admin_ghost"
	full_name = "幽灵模式"
	description = "Go ghost"
	keybind_signal = COMSIG_KB_ADMIN_AGHOST_DOWN

/datum/keybinding/admin/admin_ghost/down(client/user)
	. = ..()
	if(.)
		return
	user.admin_ghost()
	return TRUE

/datum/keybinding/admin/player_panel_new
	hotkey_keys = list("F6")
	classic_keys = list("F6")
	name = "player_panel_new"
	full_name = "玩家面板（新）"
	description = "Opens up the new player panel"
	keybind_signal = COMSIG_KB_ADMIN_PLAYERPANELNEW_DOWN

/datum/keybinding/admin/player_panel_new/down(client/user)
	. = ..()
	if(.)
		return
	user.admin_holder.player_panel_new()
	return TRUE

/datum/keybinding/admin/toggle_buildmode_self
	hotkey_keys = list("F7")
	classic_keys = list("Unbound")
	name = "toggle_buildmode_self"
	full_name = "切换自身建造模式"
	description = "Toggles buildmode"
	keybind_signal = COMSIG_KB_ADMIN_TOGGLEBUILDMODE_DOWN

/datum/keybinding/admin/toggle_buildmode_self/down(client/user)
	. = ..()
	if(.)
		return
	user.togglebuildmodeself()
	return TRUE

/datum/keybinding/admin/stealthmode
	hotkey_keys = list("F8")
	classic_keys = list("F8")
	name = "stealth_mode"
	full_name = "潜行模式"
	description = "Enters stealth mode"
	keybind_signal = COMSIG_KB_ADMIN_STEALTHMODETOGGLE_DOWN

/datum/keybinding/admin/stealthmode/down(client/user)
	. = ..()
	if(.)
		return
	user.invismin()
	return TRUE

/datum/keybinding/admin/deadsay
	hotkey_keys = list("F10")
	classic_keys = list("Unbound")
	name = "dsay"
	full_name = "deadsay"
	description = "Allows you to send a message to dead chat"
	keybind_signal = COMSIG_KB_ADMIN_DSAY_DOWN

/datum/keybinding/admin/deadsay/down(client/user)
	. = ..()
	if(.)
		return
	user.get_dead_say()
	return TRUE

/datum/keybinding/admin/deadmin
	hotkey_keys = list("Unbound")
	classic_keys = list("Unbound")
	name = "deadmin"
	full_name = "退出管理员"
	description = "Shed your admin powers"
	keybind_signal = COMSIG_KB_ADMIN_DEADMIN_DOWN

/datum/keybinding/admin/deadmin/down(client/user)
	. = ..()
	if(.)
		return
	user.deadmin()
	return TRUE

/datum/keybinding/admin/readmin
	hotkey_keys = list("Unbound")
	classic_keys = list("Unbound")
	name = "readmin"
	full_name = "恢复管理员"
	description = "Regain your admin powers"
	keybind_signal = COMSIG_KB_ADMIN_READMIN_DOWN

/datum/keybinding/admin/readmin/down(client/user)
	. = ..()
	if(.)
		return
	user.readmin()
	return TRUE
