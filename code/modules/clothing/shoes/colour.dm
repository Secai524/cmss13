/obj/item/clothing/shoes/black
	name = "黑色鞋子"
	icon_state = "black"
	desc = "一双黑色鞋子。"

	flags_cold_protection = BODY_FLAG_FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	flags_heat_protection = BODY_FLAG_FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT

/obj/item/clothing/shoes/morgue
	name = "停尸房鞋子"
	icon_state = "morgue"
	desc = "一双在停尸房穿的全黑鞋子。"

/obj/item/clothing/shoes/brown
	name = "棕色鞋子"
	desc = "一双棕色鞋子。"
	icon_state = "brown"

/obj/item/clothing/shoes/blue
	name = "蓝色鞋子"
	icon_state = "blue"

/obj/item/clothing/shoes/green
	name = "绿色鞋子"
	icon_state = "green"

/obj/item/clothing/shoes/yellow
	name = "黄色鞋子"
	icon_state = "yellow"

/obj/item/clothing/shoes/purple
	name = "紫色鞋子"
	icon_state = "purple"

/obj/item/clothing/shoes/red
	name = "红色鞋子"
	desc = "时尚的红色鞋子。"
	icon_state = "red"

/obj/item/clothing/shoes/red/knife
	name = "肮脏的红色鞋子"
	desc = "时尚的红色鞋子，带有一个可存放小刀的空间。"
	allowed_items_typecache = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
		/obj/item/weapon/gun/pistol/action,
		/obj/item/weapon/gun/pistol/clfpistol,
		/obj/item/tool/screwdriver,
		/obj/item/weapon/straight_razor,
	)

/obj/item/clothing/shoes/white
	name = "白色鞋子"
	desc = "一双白色鞋子。并非无菌。"
	icon_state = "white"


/obj/item/clothing/shoes/leather
	name = "皮鞋"
	desc = "一双结实的皮鞋。"
	icon_state = "leather"

/obj/item/clothing/shoes/leather/fancy
	name = "高档皮鞋"
	desc = "一双高档皮鞋。"
	icon_state = "fancy"

/obj/item/clothing/shoes/rainbow
	name = "彩虹鞋子"
	desc = "非常花哨的鞋子。"
	icon_state = "rain_bow"

/obj/item/clothing/shoes/orange
	name = "橙色鞋子"
	icon_state = "orange"
	var/obj/item/restraint/handcuffs/chained = null

/obj/item/clothing/shoes/orange/proc/attach_cuffs(obj/item/restraint/cuffs, mob/user as mob)
	if(chained)
		return FALSE

	user.drop_held_item()
	cuffs.forceMove(src)
	chained = cuffs
	slowdown = 15
	icon_state = "orange1"
	time_to_equip = (cuffs.breakouttime / 4)
	time_to_unequip = cuffs.breakouttime
	return TRUE

/obj/item/clothing/shoes/orange/proc/remove_cuffs(mob/user as mob)
	if(!chained)
		return FALSE

	user.put_in_hands(chained)
	chained.add_fingerprint(user)

	slowdown = initial(slowdown)
	icon_state = "orange"
	chained = null
	time_to_equip = initial(time_to_equip)
	time_to_unequip = initial(time_to_unequip)
	return TRUE

/obj/item/clothing/shoes/orange/attack_self(mob/user as mob)
	..()
	remove_cuffs(user)

/obj/item/clothing/shoes/orange/attackby(attacking_object as obj, mob/user as mob)
	..()
	if(istype(attacking_object, /obj/item/restraint))
		var/obj/item/restraint/cuffs = attacking_object
		if(cuffs.target_zone == SLOT_LEGS)
			attach_cuffs(cuffs, user)

/obj/item/clothing/shoes/orange/get_examine_text(mob/user)
	. = ..()
	if(chained)
		. += SPAN_RED("They are chained with [chained].")
