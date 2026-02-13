/obj/item/ammo_magazine/hardpoint/ace_autocannon
	name = "AC3-E自动机炮弹匣"
	desc = "AC3-E自动机炮的40发弹匣，内装20毫米炮弹。"
	caliber = "20mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	icon_state = "ace_autocannon"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/tank/flak
	max_rounds = 40
	gun_type = /obj/item/hardpoint/primary/autocannon

/obj/item/ammo_magazine/hardpoint/ace_autocannon/update_icon()
	if(current_rounds > 0)
		icon_state = "ace_autocannon"
	else
		icon_state = "ace_autocannon_empty"
