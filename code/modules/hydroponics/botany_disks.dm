/obj/item/disk/botany
	name = "植物数据盘"
	desc = "一种用于携带植物遗传数据的小型磁盘。"
	icon = 'icons/obj/items/disk.dmi'
	icon_state = "botanydisk"
	item_state = "botanydisk"
	w_class = SIZE_TINY
	ground_offset_x = 5
	ground_offset_y = 5

	var/list/genes = list()
	var/genesource = "unknown"


/obj/item/disk/botany/attack_self(mob/user)
	..()

	if(!length(genes))
		return

	var/choice = alert(user, "确定要擦除磁盘数据吗？", "Xenobotany Data", "No", "Yes")
	if(src && user && genes && choice == "Yes")
		to_chat(user, "你擦除了磁盘数据。")
		name = initial(name)
		desc = initial(name)
		genes = list()
		genesource = "unknown"

/obj/item/storage/box/botanydisk
	name = "植物数据盘盒"
	desc = "一盒植物数据盘，看起来是。"

/obj/item/storage/box/botanydisk/Initialize()
	. = ..()
	for(var/i = 0;i<14;i++)
		new /obj/item/disk/botany(src)
