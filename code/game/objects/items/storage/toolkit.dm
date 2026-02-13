/obj/item/storage/toolkit
	name = "工程师套件"
	desc = "一个旨在将电气和机械补给品带入战场的战斗工程工具包。经过工程训练后，你可以将其放入背包。"
	icon = 'icons/obj/items/storage/kits.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/tools_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/tools_righthand.dmi',
	)
	icon_state = "toolkit"
	item_state = "toolkit"
	throw_speed = SPEED_FAST
	throw_range = 8
	use_sound = "toolbox"
	matter = list("plastic" = 2000)
	can_hold = list(
		/obj/item/circuitboard,
		/obj/item/device/flashlight,
		/obj/item/clothing/glasses/welding,
		/obj/item/device/analyzer,
		/obj/item/device/demo_scanner,
		/obj/item/device/reagent_scanner,
		/obj/item/device/t_scanner,
		/obj/item/stack/cable_coil,
		/obj/item/cell,
		/obj/item/device/assembly,
		/obj/item/stock_parts,
		/obj/item/explosive/plastic,
		/obj/item/device/defibrillator/synthetic,
	)
	storage_flags = STORAGE_FLAGS_BOX
	required_skill_for_nest_opening = SKILL_ENGINEER
	required_skill_level_for_nest_opening = SKILL_ENGINEER_TRAINED

	///icon state to use when kit is full
	var/icon_full

/obj/item/storage/toolkit/Initialize()
	. = ..()

	icon_full = initial(icon_state)

	update_icon()

/obj/item/storage/toolkit/update_icon()
	if(content_watchers || !length(contents))
		icon_state = "toolkit_empty"
	else
		icon_state = icon_full

/obj/item/storage/toolkit/full/fill_preset_inventory()
	new /obj/item/stack/cable_coil/random(src)
	new /obj/item/circuitboard/apc(src)
	new /obj/item/circuitboard/apc(src)
	new /obj/item/circuitboard/apc(src)
	new /obj/item/cell/high(src)
	new /obj/item/explosive/plastic/breaching_charge(src)
	new /obj/item/explosive/plastic/breaching_charge(src)


/obj/item/storage/toolkit/empty/fill_preset_inventory()
	return


/obj/item/storage/toolkit/tactical
	name = "破门工程师套件"

/obj/item/storage/toolkit/tactical/fill_preset_inventory()
	new /obj/item/explosive/plastic/breaching_charge/rubber(src)
	new /obj/item/explosive/plastic/breaching_charge/rubber(src)
	new /obj/item/explosive/plastic/breaching_charge/rubber(src)
	new /obj/item/explosive/plastic/breaching_charge/rubber(src)
	new /obj/item/explosive/plastic(src)
	new /obj/item/circuitboard/apc(src)
	new /obj/item/cell/high(src)


/obj/item/storage/toolkit/rmc

/obj/item/storage/toolkit/rmc/fill_preset_inventory()
	new /obj/item/stack/cable_coil/random(src)
	new /obj/item/circuitboard/apc(src)
	new /obj/item/circuitboard/apc(src)
	new /obj/item/circuitboard/apc(src)
	new /obj/item/cell/high(src)
	new /obj/item/cell/high(src)
	new /obj/item/cell/high(src)
