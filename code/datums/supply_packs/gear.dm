// add all the gear in this group.

/datum/supply_packs/binocs
	name = "混合望远镜箱 (每箱x2，共x6)"
	cost = 20
	containertype = /obj/structure/closet/crate/green
	containername = "Mixed Binoculars Crate"
	group = "Gear"
	contains = list(
		/obj/item/device/binoculars/range/designator,
		/obj/item/device/binoculars/range/designator,
		/obj/item/device/binoculars/range,
		/obj/item/device/binoculars/range,
		/obj/item/device/binoculars,
		/obj/item/device/binoculars,
	)

/datum/supply_packs/flares
	name = "照明弹包箱 (x20)"
	contains = list(
		/obj/item/ammo_box/magazine/misc/flares,
		/obj/item/ammo_box/magazine/misc/flares,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "flare pack crate"
	group = "Gear"


/datum/supply_packs/motiondetector
	name = "动态探测器 (x2)"
	contains = list(
		/obj/item/device/motiondetector,
		/obj/item/device/motiondetector,
					)
	cost = 40
	containertype = /obj/structure/closet/crate/supply
	containername = "Motion Detector crate"
	group = "Gear"

/datum/supply_packs/signal_flares
	name = "信号弹包箱 (x4)"
	contains = list(
		/obj/item/storage/box/m94/signal,
		/obj/item/storage/box/m94/signal,
		/obj/item/storage/box/m94/signal,
		/obj/item/storage/box/m94/signal,
	)
	cost = 60
	containertype = /obj/structure/closet/crate/ammo
	containername = "signal flare pack crate"
	group = "Gear"

/datum/supply_packs/fulton
	name = "富尔顿回收装置箱 (x4)"
	contains = list(
		/obj/item/stack/fulton,
		/obj/item/stack/fulton,
		/obj/item/stack/fulton,
		/obj/item/stack/fulton,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/ammo
	containername = "fulton recovery device crate"
	group = "Gear"

/datum/supply_packs/parachute
	name = "降落伞箱 (x20)"
	contains = list(
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
		/obj/item/parachute,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/supply
	containername = "parachute crate"
	group = "Gear"
