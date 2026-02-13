/obj/item/ammo_magazine/hardpoint/ltaaap_minigun
	name = "LTAA-AP转轮机枪弹箱"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	desc = "为重机枪准备的7.62x51mm穿甲弹弹箱。装满了高精度的穿甲弹。"
	caliber = "7.62x51mm" //Correlates to miniguns
	icon_state = "ltaa"
	w_class = SIZE_LARGE //Primary weapon ammo should probably all be the same w_class
	default_ammo = /datum/ammo/bullet/tank/minigun
	max_rounds = 500
	gun_type = /obj/item/hardpoint/primary/minigun
