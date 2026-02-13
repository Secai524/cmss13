/obj/item/ammo_magazine/hardpoint/flare_launcher
	name = "M-87F照明弹发射器弹箱"
	desc = "一种支援武器榴弹弹箱。此弹箱装填了封装在一次性弹壳内的照明弹。"
	caliber = "flare"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	icon_state = "slauncher_1"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/flare
	max_rounds = 10
	gun_type = /obj/item/hardpoint/support/flare_launcher

/obj/item/ammo_magazine/hardpoint/flare_launcher/update_icon()
	icon_state = "slauncher_[current_rounds <= 0 ? "0" : "1"]"
