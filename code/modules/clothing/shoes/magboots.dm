/obj/item/clothing/shoes/magboots
	desc = "磁力靴，常用于舱外活动，确保使用者安全附着在载具上。"
	name = "magboots"
	icon_state = "magboots0"
	var/magpulse = 0
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/shoes/magboots/attack_self(mob/user)
	..()

	if(magpulse)
		flags_inventory &= ~NOSLIPPING
		slowdown = SHOES_SLOWDOWN
		magpulse = 0
		icon_state = "magboots0"
		to_chat(user, "你关闭了磁脉冲牵引系统。")
	else
		flags_inventory |= NOSLIPPING
		slowdown = 2
		magpulse = 1
		icon_state = "magboots1"
		to_chat(user, "你开启了磁脉冲牵引系统。")
	user.update_inv_shoes() //so our mob-overlays update

	for(var/X in actions)
		var/datum/action/A = X
		A.update_button_icon()


/obj/item/clothing/shoes/magboots/get_examine_text(mob/user)
	. = ..()
	var/state = "disabled"
	if(flags_inventory&NOSLIPPING)
		state = "enabled"
	. += "Its mag-pulse traction system appears to be [state]."
