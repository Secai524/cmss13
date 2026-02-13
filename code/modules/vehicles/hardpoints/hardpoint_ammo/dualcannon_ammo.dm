/obj/item/ammo_magazine/hardpoint/boyars_dualcannon
	name = "PARS-159双联炮IFF弹箱"
	desc = "为PARS-159博亚尔斯双联炮准备的弹箱，内装20mm炮弹。命中时对目标造成轻微挫伤。支持IFF（敌我识别）。"
	caliber = "20mm"
	icon_state = "ace_autocannon"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/tank/dualcannon
	max_rounds = 60
	gun_type = /obj/item/hardpoint/primary/dualcannon

/obj/item/ammo_magazine/hardpoint/boyars_dualcannon/update_icon()
	if(current_rounds > 0)
		icon_state = "ace_autocannon"
	else
		icon_state = "ace_autocannon_empty"
