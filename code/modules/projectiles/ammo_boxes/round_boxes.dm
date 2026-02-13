//-----------------------AMMUNITION BOXES (LOOSE AMMO)-----------------------

//----------------10x24mm Ammunition Boxes (for M41 family, M4RA, and L42)------------------

/obj/item/ammo_box/rounds/ap
	name = "\improper rifle ammunition box (10x24mm AP)"
	desc = "一个10x24毫米穿甲弹药箱。用于补充M41A MK2和M4RA的穿甲弹匣。配有皮带，可背在背上。"
	overlay_content = "_ap"
	default_ammo = /datum/ammo/bullet/rifle/ap

/obj/item/ammo_box/rounds/ap/empty
	empty = TRUE

/obj/item/ammo_box/rounds/le
	name = "\improper rifle ammunition box (10x24mm LE)"
	desc = "一个10x24毫米碎甲弹药箱。用于补充M41A MK2 LE弹匣。配有皮带，可背在背上。"
	overlay_content = "_le"
	default_ammo = /datum/ammo/bullet/rifle/le

/obj/item/ammo_box/rounds/le/empty
	empty = TRUE

/obj/item/ammo_box/rounds/incen
	name = "\improper rifle ammunition box (10x24mm Incen)"
	desc = "一个10x24毫米燃烧弹药箱。用于补充M41A MK2和M4RA的燃烧弹匣。配有皮带，可背在背上。"
	overlay_content = "_incen"
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	bullet_amount = 400 //Incen is OP
	max_bullet_amount = 400

/obj/item/ammo_box/rounds/incen/empty
	empty = TRUE

/obj/item/ammo_box/rounds/heap
	name = "步枪弹药箱 (10x24毫米高爆穿甲)"
	desc = "一个10x24毫米高爆穿甲弹药箱。用于补充弹匣。配有皮带，可背在背上。"
	overlay_content = "_heap"
	default_ammo = /datum/ammo/bullet/rifle/heap

/obj/item/ammo_box/rounds/heap/empty
	empty = TRUE

//----------------10x20mm Ammunition Boxes (for M39 SMG)------------------

/obj/item/ammo_box/rounds/smg
	name = "\improper SMG HV ammunition box (10x20mm)"
	desc = "一个10x20毫米弹药箱。用于补充M39高速弹和加长弹匣。配有皮带，可背在背上。"
	caliber = "10x20mm"
	icon_state = "base_m39"
	overlay_content = "_hv"
	default_ammo = /datum/ammo/bullet/smg/m39

/obj/item/ammo_box/rounds/smg/empty
	empty = TRUE

/obj/item/ammo_box/rounds/smg/ap
	name = "\improper SMG ammunition box (10x20mm AP)"
	desc = "一个10x20毫米穿甲弹药箱。用于补充M39穿甲弹匣。配有皮带，可背在背上。"
	caliber = "10x20mm"
	overlay_content = "_ap"
	default_ammo = /datum/ammo/bullet/smg/ap

/obj/item/ammo_box/rounds/smg/ap/empty
	empty = TRUE

/obj/item/ammo_box/rounds/smg/le
	name = "\improper SMG ammunition box (10x20mm LE)"
	desc = "一个10x20毫米碎甲弹药箱。用于补充M39 LE弹匣。配有皮带，可背在背上。"
	caliber = "10x20mm"
	overlay_content = "_le"
	default_ammo = /datum/ammo/bullet/smg/le

/obj/item/ammo_box/rounds/smg/le/empty
	empty = TRUE

/obj/item/ammo_box/rounds/smg/incen
	name = "\improper SMG ammunition box (10x20mm Incen)"
	desc = "一个10x20毫米燃烧弹药箱。用于补充M39燃烧弹匣。配有皮带，可背在背上。"
	caliber = "10x20mm"
	overlay_content = "_incen"
	default_ammo = /datum/ammo/bullet/smg/incendiary
	bullet_amount = 400 //Incen is OP
	max_bullet_amount = 400

/obj/item/ammo_box/rounds/smg/incen/empty
	empty = TRUE

/obj/item/ammo_box/rounds/smg/heap
	name = "冲锋枪弹药箱 (10x20毫米高爆穿甲)"
	desc = "一个10x20毫米高爆穿甲弹药箱。用于补充M39高爆穿甲弹匣。配有皮带，可背在背上。"
	caliber = "10x20mm"
	overlay_content = "_heap"
	default_ammo = /datum/ammo/bullet/smg/heap

/obj/item/ammo_box/rounds/smg/heap/empty
	empty = TRUE

//----------------5.45x39mm Ammunition Boxes (for UPP Type71 family)------------------

/obj/item/ammo_box/rounds/type71
	name = "\improper rifle ammunition box (5.45x39mm)"
	desc = "一个5.45x39mm弹药箱。用于补充Type71弹匣。配有可背在背上的皮质背带。"
	icon_state = "base_type71"
	overlay_gun_type = "_rounds_type71"
	overlay_content = "_type71_reg"
	caliber = "5.45x39mm"
	default_ammo = /datum/ammo/bullet/rifle/type71

/obj/item/ammo_box/rounds/type71/empty
	empty = TRUE

/obj/item/ammo_box/rounds/type71/ap
	name = "\improper rifle ammunition box (5.45x39mm AP)"
	desc = "一个5.45x39mm穿甲弹药箱。用于补充Type71 AP弹匣。配有可背在背上的皮质背带。"
	icon_state = "base_type71"
	overlay_gun_type = "_rounds_type71"
	overlay_content = "_type71_ap"
	default_ammo = /datum/ammo/bullet/rifle/type71/ap

/obj/item/ammo_box/rounds/type71/ap/empty
	empty = TRUE

/obj/item/ammo_box/rounds/type71/heap
	name = "步枪弹药箱（5.45x39mm HEAP）"
	desc = "一个5.45x39mm高爆穿甲弹药箱。用于补充Type71 HEAP弹匣。配有可背在背上的皮质背带。"
	icon_state = "base_type71"
	overlay_gun_type = "_rounds_type71"
	overlay_content = "_type71_heap"
	default_ammo = /datum/ammo/bullet/rifle/type71/heap

/obj/item/ammo_box/rounds/type71/heap/empty
	empty = TRUE

//----------------9mm Pistol Ammunition Boxes (for mod88, M4A3 pistols)------------------

/obj/item/ammo_box/rounds/pistol
	name = "\improper pistol ammunition box (9mm)"
	desc = "一个9mm弹药箱。用于补充M4A3弹匣。配有可背在背上的皮质背带。"
	caliber = "9mm"
	icon_state = "base_m4a3"
	overlay_content = "_reg"
	default_ammo = /datum/ammo/bullet/pistol

/obj/item/ammo_box/rounds/pistol/empty
	empty = TRUE

/obj/item/ammo_box/rounds/pistol/ap
	name = "\improper pistol ammunition box (9mm AP)"
	desc = "一个9mm穿甲弹药箱。用于补充mod88和M4A3弹匣。配有可背在背上的皮质背带。"
	overlay_content = "_ap"
	default_ammo = /datum/ammo/bullet/pistol/ap

/obj/item/ammo_box/rounds/pistol/ap/empty
	empty = TRUE

/obj/item/ammo_box/rounds/pistol/hp
	name = "\improper pistol ammunition box (9mm HP)"
	desc = "一个9mm空尖弹药箱。用于补充M4A3弹匣。配有可背在背上的皮质背带。"
	overlay_content = "_hp"
	default_ammo = /datum/ammo/bullet/pistol/hollow

/obj/item/ammo_box/rounds/pistol/hp/empty
	empty = TRUE

/obj/item/ammo_box/rounds/pistol/incen
	name = "\improper pistol ammunition box (9mm Incendiary)"
	desc = "一个9mm燃烧弹药箱。用于补充M4A3弹匣。配有可背在背上的皮质背带。"
	overlay_content = "_incen"
	default_ammo = /datum/ammo/bullet/pistol/incendiary

/obj/item/ammo_box/rounds/pistol/incen/empty
	empty = TRUE

//----------------8.88x51mm round boxes for L23 battle rifles------------------

/obj/item/ammo_box/rounds/l23
	name = "\improper rifle ammunition box (8.88x51mm)"
	desc = "一个8.88x51mm弹药箱。用于补充L23标准及加长弹匣。配有可背在背上的皮质背带。"
	icon_state = "base_l23"
	overlay_content = "_l23_reg"
	caliber = "8.88x51mm"
	default_ammo = /datum/ammo/bullet/rifle/l23

/obj/item/ammo_box/rounds/l23/empty
	empty = TRUE

/obj/item/ammo_box/rounds/l23/ap
	name = "\improper rifle ammunition box (8.88x51mm AP)"
	desc = "一个8.88x51mm弹药箱。用于补充L23 AP弹匣。配有可背在背上的皮质背带。"
	overlay_content = "_l23_ap"
	default_ammo = /datum/ammo/bullet/rifle/l23/ap

/obj/item/ammo_box/rounds/l23/ap/empty
	empty = TRUE

/obj/item/ammo_box/rounds/l23/heap
	name = "\improper rifle ammunition box (8.88x51mm HEAP)"
	desc = "一个8.88x51mm弹药箱。用于补充L23 HEAP弹匣。配有可背在背上的皮质背带。"
	overlay_content = "_l23_heap"
	default_ammo = /datum/ammo/bullet/rifle/l23/heap

/obj/item/ammo_box/rounds/l23/heap/empty
	empty = TRUE

/obj/item/ammo_box/rounds/l23/incendiary
	name = "\improper rifle ammunition box (8.88x51mm Incendiary)"
	desc = "一个8.88x51mm弹药箱。用于补充L23燃烧弹匣。配有可背在背上的皮质背带。"
	overlay_content = "_l23_incen"
	default_ammo = /datum/ammo/bullet/rifle/l23/incendiary
	bullet_amount = 420 //Incen is OP
	max_bullet_amount = 420

/obj/item/ammo_box/rounds/l23/incendiary/empty
	empty = TRUE

//----------------10x20mm (APC) Ammunition Boxes (for M10 Auto-Pistol)------------------

/obj/item/ammo_box/rounds/pistol/m10
	name = "\improper pistol ammunition box (10x20mm-APC)"
	desc = "一个10x20mm-APC弹药箱。用于补充M10标准、加长及弹鼓弹匣。配有可背在背上的皮质背带。"
	caliber = "10x20mm-APC"
	icon_state = "base_m10"
	overlay_content = "_apc"
	default_ammo = /datum/ammo/bullet/pistol/m10
	bullet_amount = 984 // M10 mags can hold a LOT, regular size is not enough.
	max_bullet_amount = 984

/obj/item/ammo_box/rounds/pistol/m10/empty
	empty = TRUE

/obj/item/ammo_box/rounds/pistol/m10/ap
	name = "\improper pistol ammunition box (10x20mm-APC (AP))"
	desc = "一个10x20mm-APC穿甲弹药箱。用于补充M10标准、加长及弹鼓AP弹匣。配有可背在背上的皮质背带。"
	caliber = "10x20mm-APC"
	overlay_content = "_apc_ap"
	default_ammo = /datum/ammo/bullet/pistol/m10/ap

/obj/item/ammo_box/rounds/pistol/m10/ap/empty
	empty = TRUE
