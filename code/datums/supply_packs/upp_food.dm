/datum/supply_packs/upp/potato_crate
	name = "UPP剩余土豆箱 (x10箱) (x700个土豆)"
	contains = list(
		/obj/item/storage/box/potato,
		/obj/item/storage/box/potato,
		/obj/item/storage/box/potato,
		/obj/item/storage/box/potato,
		/obj/item/storage/box/potato,
		/obj/item/storage/box/potato,
		/obj/item/storage/box/potato,
		/obj/item/storage/box/potato,
		/obj/item/storage/box/potato,
		/obj/item/storage/box/potato,
		/obj/item/storage/box/potato,
	)
	cost = 5
	containertype = /obj/structure/closet/crate/freezer
	containername = "Potato crate"
	group = "UPP Food"

/datum/supply_packs/upp/ration_crate
	name = "UPP IRP箱 (x2)"
	contains = list(
		/obj/item/ammo_box/magazine/misc/mre/upp,
		/obj/item/ammo_box/magazine/misc/mre/upp,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/supply
	containername = "UPP ration crate(x20)"
	group = "UPP Food"
