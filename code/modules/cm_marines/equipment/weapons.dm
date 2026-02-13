
/obj/item/storage/box/m56a2_system
	name = "\improper M56 smartgun system case"
	desc = "一个大型箱子，内装M56A2智能枪、M56战斗背带、头戴式瞄准镜和电源包。\n将此图标拖拽到身上以打开！注意：你无法将物品放回此箱内。"
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "kit_case"
	w_class = SIZE_HUGE
	storage_slots = 7
	slowdown = 1
	can_hold = list() //Nada. Once you take the stuff out it doesn't fit back in.
	foldable = null

/obj/item/storage/box/m56a2_system/update_icon()
	LAZYCLEARLIST(overlays)
	if(length(contents))
		icon_state = "kit_case"
		overlays += image(icon, "smartgun")
	else
		icon_state = "kit_case_e"

/obj/item/storage/box/m56a2_system/full/Initialize()
	. = ..()
	new /obj/item/clothing/suit/storage/marine/smartgunner(src)
	new /obj/item/weapon/gun/smartgun(src)
	new /obj/item/clothing/glasses/night/m56_goggles(src)
	new /obj/item/smartgun_battery(src)
	for(var/i in 1 to 3)
		new /obj/item/ammo_magazine/smartgun(src)
	update_icon()

/obj/item/storage/box/m56a2_system/armorless/Initialize()
	. = ..()
	new /obj/item/weapon/gun/smartgun(src)
	new /obj/item/clothing/glasses/night/m56_goggles(src)
	new /obj/item/smartgun_battery(src)
	for(var/i in 1 to 3)
		new /obj/item/ammo_magazine/smartgun(src)
	update_icon()


/obj/item/storage/box/m56a2c_system
	name = "\improper M56A2C smartgun system case"
	desc = "一个大型箱子，内装M56A2C智能枪、M56战斗背带、头戴式瞄准镜、M280智能枪手弹鼓腰带和电源包。\n将此图标拖拽到身上以打开！注意：你无法将物品放回此箱内。"
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "kit_case"
	w_class = SIZE_HUGE
	storage_slots = 6
	slowdown = 1
	can_hold = list() //Nada. Once you take the stuff out it doesn't fit back in.
	foldable = null

/obj/item/storage/box/m56a2c_system/Initialize()
	. = ..()
	new /obj/item/clothing/glasses/night/m56_goggles(src)
	new /obj/item/weapon/gun/smartgun/co(src)
	new /obj/item/smartgun_battery(src)
	new /obj/item/pamphlet/skill/cosmartgun(src)
	new /obj/item/clothing/suit/storage/marine/smartgunner(src)
	new /obj/item/storage/belt/marine/smartgunner(src)
	update_icon()

/obj/item/storage/box/m56a2c_system/update_icon()
	LAZYCLEARLIST(overlays)
	if(length(contents))
		icon_state = "kit_case"
		overlays += image(icon, "smartgun")
	else
		icon_state = "kit_case_e"

/obj/item/storage/box/l56a2_dirty_system
	name = "\improper M56D 'Dirty' smartgun system case"
	desc = "一个大型箱子，内装M56D'肮脏'智能枪、M56D PMC战斗背带和头盔、头戴式瞄准镜、M280智能枪手弹鼓腰带和电源包。\n将此图标拖拽到身上以打开！注意：你无法将物品放回此箱内。"
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "kit_case"
	w_class = SIZE_HUGE
	storage_slots = 6
	slowdown = 1
	can_hold = list() //Nada. Once you take the stuff out it doesn't fit back in.
	foldable = null

/obj/item/storage/box/l56a2_dirty_system/Initialize()
	. = ..()
	new /obj/item/clothing/glasses/night/m56_goggles(src)
	new /obj/item/weapon/gun/smartgun/l56a2(src)
	new /obj/item/smartgun_battery(src)
	new /obj/item/clothing/suit/storage/marine/smartgunner/veteran/pmc(src)
	new /obj/item/clothing/head/helmet/marine/veteran/pmc/enclosed(src)
	new /obj/item/storage/belt/gun/smartgunner/pmc/full(src)
	update_icon()

/obj/item/storage/box/l56a2_dirty_system/update_icon()
	LAZYCLEARLIST(overlays)
	if(length(contents))
		icon_state = "kit_case"
		overlays += image(icon, "smartgun")
	else
		icon_state = "kit_case_e"
