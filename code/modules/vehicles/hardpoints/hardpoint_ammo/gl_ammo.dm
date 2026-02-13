/obj/item/ammo_magazine/hardpoint/tank_glauncher
	name = "M92T榴弹发射器弹箱"
	desc = "一个装填了M40榴弹的弹箱。用于为弹箱供弹的M92T榴弹发射器重新装填。"
	caliber = "grenade"
	icon_state = "glauncher_2"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/grenade_container/tank_glauncher
	max_rounds = 10
	gun_type = /obj/item/hardpoint/secondary/grenade_launcher

/obj/item/ammo_magazine/hardpoint/tank_glauncher/update_icon()
	if(current_rounds >= max_rounds)
		icon_state = "glauncher_2"
	else if(current_rounds <= 0)
		icon_state = "glauncher_0"
	else
		icon_state = "glauncher_1"
