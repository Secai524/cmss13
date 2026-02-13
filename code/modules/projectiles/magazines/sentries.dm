// STANDARD Sentry
/obj/item/ammo_magazine/sentry
	name = "M30弹药鼓（10x28mm无壳弹）"
	desc = "一个装有500发10x28mm无壳弹的弹药鼓，用于UA 571-C哨戒炮。当哨戒炮弹药耗尽时，将其装入其弹药口即可。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/turrets.dmi'
	icon_state = "ua571c"
	w_class = SIZE_MEDIUM
	flags_magazine = NO_FLAGS //can't be refilled or emptied by hand
	caliber = "10x28mm"
	max_rounds = 500
	default_ammo = /datum/ammo/bullet/turret
	gun_type = null

/obj/item/ammo_magazine/sentry/dropped
	max_rounds = 100
	max_inherent_rounds = 500

/obj/item/ammo_magazine/sentry/premade
	max_rounds = 99999
	current_rounds = 99999

/obj/item/ammo_magazine/sentry/premade/lowammo
	max_rounds = 500
	current_rounds = 500

/obj/item/ammo_magazine/sentry/premade/dumb
	default_ammo = /datum/ammo/bullet/turret/dumb

/obj/item/ammo_magazine/sentry/premade/lowammo/dumb
	default_ammo = /datum/ammo/bullet/turret/dumb

/obj/item/ammo_magazine/sentry/shotgun
	name = "12号鹿弹弹药鼓"
	desc = "一个装有50发12号鹿弹的弹药鼓，用于UA 12-G霰弹枪哨戒炮。当哨戒炮弹药耗尽时，将其装入其弹药口即可。"
	caliber = "12g"
	max_rounds = 50
	default_ammo = /datum/ammo/bullet/shotgun/buckshot

/obj/item/ammo_magazine/sentry/wy
	name = "H20弹药鼓（10x42mm无壳弹）"
	desc = "一个装有200发10x42mm无壳弹的弹药鼓，用于WY 202-GMA1智能哨戒炮。当哨戒炮弹药耗尽时，将其装入其弹药口即可。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/WY/turrets.dmi'
	icon_state = "wy22e5"
	caliber = "10x42mm"
	max_rounds = 200

/obj/item/ammo_magazine/sentry/wy/mini
	name = "H16弹药鼓（10x12mm无壳弹）"
	desc = "一个装有1000发10x12mm无壳弹的弹药鼓，用于WY 14-GRA2迷你哨戒炮。当哨戒炮弹药耗尽时，将其装入其弹药口即可。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/WY/turrets.dmi'
	icon_state = "wy22e5"
	caliber = "10x12mm"
	max_rounds = 1000

/obj/item/ammo_magazine/sentry/upp
	name = "SR32弹药鼓（10x32mm无壳弹）"
	desc = "一个装有200发10x32mm无壳弹的弹药鼓，用于UPP SDS-R3哨戒炮。当哨戒炮弹药耗尽时，将其装入其弹药口即可。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/turrets.dmi'
	icon_state = "uppsds4"
	caliber = "10x42mm"
	max_rounds = 200

// FLAMER Sentry
/obj/item/ammo_magazine/sentry_flamer
	name = "哨戒炮焚烧器燃料罐"
	desc = "一个通常装有超稠萘燃料的燃料罐，这是一种粘性可燃液体化学品，用于UA 42-F。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/turrets.dmi'
	icon_state = "ua571c"
	w_class = SIZE_MEDIUM
	flags_magazine = NO_FLAGS
	caliber = "凝固汽油B型"
	max_rounds = 100
	default_ammo = /datum/ammo/flamethrower/sentry_flamer
	gun_type = null

/obj/item/ammo_magazine/sentry_flamer/glob
	name = "等离子哨戒炮焚烧器燃料罐"
	desc = "一个装有压缩超稠萘燃料的燃料罐，用于UA 60-FP。"
	default_ammo = /datum/ammo/flamethrower/sentry_flamer/glob

/obj/item/ammo_magazine/sentry_flamer/mini
	name = "迷你哨戒炮焚烧器燃料罐"
	desc = "一个装有超稠萘燃料的燃料罐，用于UA 45-FM。"
	default_ammo = /datum/ammo/flamethrower/sentry_flamer/mini

/obj/item/ammo_magazine/sentry_flamer/wy
	name = "维兰德哨戒炮焚烧器燃料罐"
	desc = "一个装有超稠粘性萘燃料的燃料罐，用于WY 406-FE2。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/WY/turrets.dmi'
	icon_state = "wy22e5"
	caliber = "Sticky Napalm"
	max_rounds = 200
	default_ammo = /datum/ammo/flamethrower/sentry_flamer/wy

/obj/item/ammo_magazine/sentry_flamer/upp
	name = "UPP哨戒炮焚烧器燃料罐"
	desc = "一个装有超稠凝胶萘燃料的燃料罐，用于UPP SDS-R5哨戒火焰喷射器。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/turrets.dmi'
	icon_state = "uppsds4"
	caliber = "Sticky Napalm"
	max_rounds = 200
	default_ammo = /datum/ammo/flamethrower/sentry_flamer/upp
