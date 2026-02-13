/* Types of tanks!
 * Contains:
 * Oxygen
 * Anesthetic
 * Air
 * Phoron
 * Emergency Oxygen
 */

/*
 * Oxygen
 */
/obj/item/tank/oxygen
	name = "氧气罐"
	desc = "一个氧气罐。"
	icon_state = "oxygen"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	gas_type = GAS_TYPE_OXYGEN



/obj/item/tank/oxygen/yellow
	desc = "一个氧气罐，这个是黄色的。"
	icon_state = "oxygen_f"

/obj/item/tank/oxygen/red
	desc = "一个氧气罐，这个是红色的。"
	icon_state = "oxygen_fr"


/*
 * Anesthetic
 */
/obj/item/tank/anesthetic
	name = "麻醉气罐"
	desc = "一个装有N2O/O2混合气体的气罐。"
	icon_state = "anesthetic"
	item_state = "anesthetic"
	gas_type = GAS_TYPE_N2O


/*
 * Air
 */
/obj/item/tank/air
	name = "空气罐"
	desc = "混合气体？"
	icon_state = "oxygen"

/*
 * Emergency Oxygen
 */
/obj/item/tank/emergency_oxygen
	name = "应急氧气罐"
	desc = "用于紧急情况。内含氧气极少，请尽量节省使用，直到真正需要时。"
	icon_state = "emergency"
	flags_atom = FPRINT|CONDUCT
	flags_equip_slot = SLOT_WAIST
	w_class = SIZE_TINY
	force = 4
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	volume = 2 //Tiny. Real life equivalents only have 21 breaths of oxygen in them. They're EMERGENCY tanks anyway -errorage (dangercon 2011)
	gas_type = GAS_TYPE_OXYGEN
	pressure = 3*ONE_ATMOSPHERE
	pressure_full = 3*ONE_ATMOSPHERE

/obj/item/tank/emergency_oxygen/get_examine_text(mob/user)
	. = ..()
	if(pressure < 50 && loc==user)
		. += SPAN_DANGER("The meter on \the [src] indicates you are almost out of air!")

/obj/item/tank/emergency_oxygen/engi
	name = "大容量应急氧气罐"
	icon_state = "emergency_engi"
	volume = 6
	pressure = 5*ONE_ATMOSPHERE
	pressure_full = 5*ONE_ATMOSPHERE

/obj/item/tank/emergency_oxygen/double
	name = "双联应急氧气罐"
	icon_state = "emergency_double"
	volume = 10
	pressure = 5*ONE_ATMOSPHERE
	pressure_full = 5*ONE_ATMOSPHERE

/*
 * Nitrogen
 */
/obj/item/tank/nitrogen
	name = "氮气罐"
	desc = "一个氮气罐。"
	icon_state = "oxygen_fr"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	gas_type = GAS_TYPE_NITROGEN

// Phoron, used for generators.
/obj/item/tank/phoron
	name = "佛隆气罐"
	desc = "一个液态佛隆气罐。警告：佛隆气体极其危险。"
	icon_state = "phoron"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	gas_type = GAS_TYPE_PHORON

/obj/item/tank/phoron/update_icon()
	. = ..()

	if(volume <= 0)
		icon_state = "phoron_empty"
	else
		icon_state = "phoron"
