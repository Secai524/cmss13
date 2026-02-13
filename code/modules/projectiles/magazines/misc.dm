

//Minigun

/obj/item/ammo_magazine/minigun
	name = "旋转弹鼓 (7.62x51mm)"
	desc = "一个用于大型旋转机枪的巨大7.62x51mm弹鼓。"
	caliber = "7.62x51mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/event.dmi'
	icon_state = "painless" //PLACEHOLDER

	matter = list("metal" = 10000)
	default_ammo = /datum/ammo/bullet/minigun
	max_rounds = 300
	reload_delay = 24 //Hard to reload.
	gun_type = /obj/item/weapon/gun/minigun
	w_class = SIZE_MEDIUM

//M60

/obj/item/ammo_magazine/m60
	name = "M60弹药箱 (7.62x51mm)"
	desc = "来自过去的冲击，使用7.62x51mm NATO弹药。"
	caliber = "7.62x51mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/machineguns.dmi'
	icon_state = "m60" //PLACEHOLDER

	matter = list("metal" = 10000)
	default_ammo = /datum/ammo/bullet/m60
	max_rounds = 100
	reload_delay = 8
	gun_type = /obj/item/weapon/gun/m60

/obj/item/ammo_magazine/pkp
	name = "QYJ-72弹药箱 (7.62x54mmR)"
	desc = "一个用于UPP标准通用机枪QYJ-72的7.62x54mmR 250发弹箱。"
	caliber = "7.62x54mmR"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/machineguns.dmi'
	icon_state = "qjy72"

	matter = list("metal" = 10000)
	default_ammo = /datum/ammo/bullet/pkp
	max_rounds = 250
	reload_delay = 12
	gun_type = /obj/item/weapon/gun/pkp

//rocket launchers

/obj/item/ammo_magazine/rifle/grenadespawner
	AUTOWIKI_SKIP(TRUE)

	name = "\improper GRENADE SPAWNER AMMO"
	desc = "哦天哪 哦该死"
	default_ammo = /datum/ammo/grenade_container/rifle
	ammo_band_color = AMMO_BAND_COLOR_LIGHT_EXPLOSIVE

/obj/item/ammo_magazine/rifle/huggerspawner
	AUTOWIKI_SKIP(TRUE)

	name = "\improper HUGGER SPAWNER AMMO"
	desc = "哦天哪 哦该死"
	default_ammo = /datum/ammo/hugger_container
	ammo_band_color = AMMO_BAND_COLOR_SUPER

//pill gun

/obj/item/ammo_magazine/internal/pillgun
	name = "药丸管"
	desc = "一个内置弹仓。它本不应被看到或移除。"
	default_ammo = /datum/ammo/pill
	caliber = "pill"
	max_rounds = 1
	chamber_closed = FALSE

	var/list/pills

/obj/item/ammo_magazine/internal/pillgun/Initialize(mapload, spawn_empty)
	. = ..()
	current_rounds = LAZYLEN(pills)

/obj/item/ammo_magazine/internal/pillgun/Entered(Obj, OldLoc)
	. = ..()
	if(!istype(Obj, /obj/item/reagent_container/pill))
		return

	LAZYADD(pills, Obj)
	current_rounds = LAZYLEN(pills)

/obj/item/ammo_magazine/internal/pillgun/Exited(Obj, newloc)
	. = ..()
	if(!istype(Obj, /obj/item/reagent_container/pill))
		return

	LAZYREMOVE(pills, Obj)
	current_rounds = LAZYLEN(pills)

/obj/item/ammo_magazine/internal/pillgun/super
	max_rounds = 5
