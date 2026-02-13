/obj/item/ammo_magazine/hardpoint/turret_smoke
	name = "炮塔烟雾弹弹匣"
	desc = "坦克炮塔使用的烟雾弹弹匣。"
	caliber = "grenade"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	icon_state = "slauncher_1"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/grenade_container/smoke
	max_rounds = 10
	gun_type = /obj/item/hardpoint/holder/tank_turret

/obj/item/ammo_magazine/hardpoint/turret_smoke/update_icon()
	icon_state = "slauncher_[current_rounds <= 0 ? "0" : "1"]"
