/obj/item/ammo_magazine/hardpoint/m56_cupola
	name = "M56炮塔弹箱"
	desc = "一个装有500发M56D重机枪系统使用的10x28mm无壳钨芯弹的弹箱。"
	caliber = "10x28mm" //Correlates to smartguns
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	icon_state = "cupola_1"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/machinegun
	max_rounds = 500
	gun_type = /obj/item/hardpoint/secondary/m56cupola

/obj/item/ammo_magazine/hardpoint/m56_cupola/update_icon()
	icon_state = "cupola_[current_rounds <= 0 ? "0" : "1"]"

/obj/item/ammo_magazine/hardpoint/m56_cupola/frontal_cannon
	name = "RE-RE700前装炮弹箱"
	desc = "一大箱子弹，看起来可疑地像给M56炮塔补充弹药用的箱子。布莱哈格尔的商标贴纸微微翘起，底下似乎还有另一个商标……"
	gun_type = /obj/item/hardpoint/secondary/frontalcannon
	icon_state = "frontal_1"

/obj/item/ammo_magazine/hardpoint/m56_cupola/frontal_cannon/update_icon()
	icon_state = "frontal_[current_rounds <= 0 ? "0" : "1"]"
