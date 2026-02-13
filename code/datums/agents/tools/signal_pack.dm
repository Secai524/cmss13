/obj/item/storage/box/antag_signaller
	name = "可疑的盒子"
	desc = "一个紧凑且看起来可疑的盒子。这个盒子小到可以放进背包。"

	w_class = SIZE_MEDIUM

	storage_slots = 8

/obj/item/storage/box/antag_signaller/Initialize(mapload, ...)
	. = ..()
	new /obj/item/device/assembly/signaller(src)
	new /obj/item/device/assembly/signaller(src)
	new /obj/item/device/assembly/signaller(src)
	new /obj/item/device/assembly/signaller(src)
	new /obj/item/device/assembly/signaller(src)
	new /obj/item/tool/screwdriver(src)
	new /obj/item/device/multitool(src)
	new /obj/item/pamphlet/engineer/antag(src)
