

//Flame thrower.

/obj/item/ammo_magazine/flamer_tank
	name = "M240焚烧器燃料罐"
	desc = "用于M240焚烧器单元的燃料罐。小心处理。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/flamers.dmi'
	icon_state = "flametank_custom"
	item_state = "flametank"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_righthand.dmi'
		)
	max_rounds = 100
	default_ammo = /datum/ammo/flamethrower //doesn't actually need bullets. But we'll get null ammo error messages if we don't
	w_class = SIZE_MEDIUM //making sure you can't sneak this onto your belt.
	gun_type = /obj/item/weapon/gun/flamer/m240
	caliber = "UT-萘燃料" //Ultra Thick Napthal Fuel, from the lore book.
	var/custom = FALSE //accepts custom fuels if true
	var/specialist = FALSE //for specialist fuels

	var/flamer_chem = "utnapthal"
	flags_magazine = AMMUNITION_HIDE_AMMO

	var/max_intensity = 40
	var/max_range = 5
	var/max_duration = 30

	var/fuel_pressure = 1 //How much fuel is used per tile fired
	var/max_pressure = 10

	var/stripe_icon = TRUE

/obj/item/ammo_magazine/flamer_tank/empty
	flamer_chem = null

/obj/item/ammo_magazine/flamer_tank/Initialize(mapload, ...)
	. = ..()
	create_reagents(max_rounds)

	if(flamer_chem)
		reagents.add_reagent(flamer_chem, max_rounds)

	reagents.min_fire_dur = 1
	reagents.min_fire_int = 1
	reagents.min_fire_rad = 1

	reagents.max_fire_dur = max_duration
	reagents.max_fire_rad = max_range
	reagents.max_fire_int = max_intensity

	update_icon()

/obj/item/ammo_magazine/flamer_tank/verb/remove_reagents()
	set name = "Empty canister"
	set category = "Object"

	set src in usr

	if(usr.get_active_hand() != src)
		return

	if(alert(usr, "你确定要清空[src]吗？", "Empty canister", "Yes", "No") != "Yes")
		return

	reagents.clear_reagents()

	playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
	to_chat(usr, SPAN_NOTICE("你清空了[src]"))
	update_icon()

/obj/item/ammo_magazine/flamer_tank/on_reagent_change()
	. = ..()
	update_icon()

	if(isgun(loc))
		var/obj/item/weapon/gun/G = loc
		if(G.current_mag == src)
			G.update_icon()

/obj/item/ammo_magazine/flamer_tank/afterattack(obj/target, mob/user , flag) //refuel at fueltanks when we run out of ammo.
	if(get_dist(user,target) > 1)
		return ..()
	if(!istype(target, /obj/structure/reagent_dispensers/tank/fuel) && !istype(target, /obj/item/tool/weldpack) && !istype(target, /obj/item/storage/backpack/marine/engineerpack) && !istype(target, /obj/item/ammo_magazine/flamer_tank))
		return ..()

	if(!target.reagents || length(target.reagents.reagent_list) < 1)
		to_chat(user, SPAN_WARNING("[target]是空的！"))
		return

	if(!reagents)
		create_reagents(max_rounds)

	var/datum/reagent/to_add = target.reagents.reagent_list[1]

	if(!istype(to_add) || (length(reagents.reagent_list) && flamer_chem != to_add.id) || length(target.reagents.reagent_list) > 1)
		to_chat(user, SPAN_WARNING("你不能混合燃料！"))
		return

	if(istype(to_add, /datum/reagent/generated) && !custom)
		to_chat(user, SPAN_WARNING("[src]无法接受自定义燃料！"))
		return

	if(to_add.flags & REAGENT_TYPE_SPECIALIST && !specialist)
		to_chat(user, SPAN_WARNING("[src]无法接受特种燃料！"))
		return

	if(!to_add.intensityfire && to_add.id != "stablefoam" && !istype(src, /obj/item/ammo_magazine/flamer_tank/smoke))
		to_chat(user, SPAN_WARNING("这种化学物质效力不足，无法用于火焰喷射器！"))
		return

	var/fuel_amt_to_remove = clamp(to_add.volume, 0, max_rounds - reagents.get_reagent_amount(to_add.id))
	if(!fuel_amt_to_remove)
		if(!max_rounds)
			to_chat(user, SPAN_WARNING("[target]是空的！"))
		return

	target.reagents.remove_reagent(to_add.id, fuel_amt_to_remove)
	reagents.add_reagent(to_add.id, fuel_amt_to_remove)
	playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
	caliber = to_add.name
	flamer_chem = to_add.id

	to_chat(user, SPAN_NOTICE("你用[caliber]重新装填了[src]。"))
	update_icon()

/obj/item/ammo_magazine/flamer_tank/update_icon()
	if(!stripe_icon)
		return

	overlays.Cut()

	var/image/I = image(icon, icon_state="[icon_state]_strip")

	if(reagents)
		I.color = mix_color_from_reagents(reagents.reagent_list)

	overlays += I

/obj/item/ammo_magazine/flamer_tank/get_ammo_percent()
	if(!reagents)
		return 0

	return 100 * (reagents.total_volume / max_rounds)

/obj/item/ammo_magazine/flamer_tank/get_examine_text(mob/user)
	. = ..()
	. += SPAN_NOTICE("It contains:")
	if(reagents && length(reagents.reagent_list))
		for(var/datum/reagent/R in reagents.reagent_list)
			. += SPAN_NOTICE(" [R.volume] units of [R.name].")
	else
		. += SPAN_NOTICE(" Nothing.")

// This is gellie fuel. Green Flames.
/obj/item/ammo_magazine/flamer_tank/gellied
	name = "M240焚烧器燃料罐 (B凝胶)"
	desc = "一个装满特种超稠萘燃料B型凝胶的燃料罐，这是一种易于扑灭的凝固汽油凝胶变体，但射程更远，持续时间更长。请格外小心处理。"
	desc_lore = "Unlike its liquid contemporaries, this gelled variant of napalm is easily extinguished, but shoots far and lingers on the ground in a viscous mess. The gel reacts violently with inorganic materials to break them down, forming an extremely sticky crystallized goo."
	caliber = "Napalm Gel"
	flamer_chem = "napalmgel"
	max_rounds = 200

	max_range = 7
	max_duration = 50

/obj/item/ammo_magazine/flamer_tank/custom
	name = "M240定制焚烧器燃料罐"
	desc = "用于M240焚烧器单元的燃料罐。此罐经过改装，配备了压力调节器和内部推进剂罐。"
	matter = list("metal" = 3750)
	flamer_chem = null
	max_rounds = 100
	max_range = 5
	fuel_pressure = 1
	custom = TRUE

/obj/item/ammo_magazine/flamer_tank/custom/verb/set_fuel_pressure()
	set name = "Change Fuel Pressure"
	set category = "Object"

	set src in usr

	if(usr.get_active_hand() != src)
		return

	var/set_pressure = clamp(tgui_input_number(usr, "将燃料压力更改为：（最大：[max_pressure]）", "Fuel pressure", fuel_pressure, 10, 1), 1 ,max_pressure)
	if(!set_pressure)
		to_chat(usr, SPAN_WARNING("你在调节器上找不到那个设置！"))
	else
		to_chat(usr, SPAN_NOTICE("你将压力调节器设置为[set_pressure] U/t。"))
		fuel_pressure = set_pressure

/obj/item/ammo_magazine/flamer_tank/custom/get_examine_text(mob/user)
	. = ..()
	. += SPAN_NOTICE("The pressure regulator is set to: [src.fuel_pressure] U/t.")

// Pyro regular flamer tank just bigger than the base flamer tank.
/obj/item/ammo_magazine/flamer_tank/large
	name = "M240大型焚烧器燃料罐"
	desc = "用于M240-T焚烧器单元的大型燃料罐。请极其谨慎处理。"
	icon_state = "flametank_large_custom"
	item_state = "flametank_large"
	max_rounds = 250
	gun_type = /obj/item/weapon/gun/flamer/m240/spec
	specialist = TRUE

	max_intensity = 80
	max_range = 5
	max_duration = 50

/obj/item/ammo_magazine/flamer_tank/large/empty
	flamer_chem = null



// This is the green flamer fuel for the pyro.
/obj/item/ammo_magazine/flamer_tank/large/B
	name = "M240大型焚烧器燃料罐（B型）"
	desc = "一个装满超稠萘燃料B型的大型燃料罐，这是一种特殊的凝固汽油变体，易于扑灭，但能在大范围扩散并缓慢燃烧。"
	desc_lore = "Unlike its thinner contemporaries, this special ultra-thick variant of napalm is easily extinguished, but disperses over a wide area and lingers on the ground in a viscous mess. The composition reacts violently with inorganic materials to break them down, causing severe structural damage. Handle with extreme caution."
	caliber = "凝固汽油B型"
	flamer_chem = "napalmb"

	max_range = 6

// This is the blue flamer fuel for the pyro.
/obj/item/ammo_magazine/flamer_tank/large/X
	name = "M240大型焚烧器燃料罐（X型）"
	desc = "一个装满超稠萘燃料X型的大型燃料罐，这是一种粘性可燃液体化学品，燃烧温度极高，用于M240-T焚烧器单元。请极其谨慎处理。"
	caliber = "凝固汽油X型"
	flamer_chem = "napalmx"

	max_range = 6

/obj/item/ammo_magazine/flamer_tank/large/EX
	name = "M240大型焚烧器燃料罐（EX型）"
	desc = "一个装满超稠萘燃料EX型的大型燃料罐，这是一种粘性可燃液体化学品，燃烧温度极高，能直接熔穿大多数阻燃材料，用于M240-T焚烧器单元。请极其谨慎处理。"
	caliber = "凝固汽油EX型"
	flamer_chem = "napalmex"

	max_range = 7

//Custom pyro tanks
/obj/item/ammo_magazine/flamer_tank/custom/large
	name = "M240大型定制焚烧器燃料罐"
	desc = "用于M240-T焚烧器单元的大型燃料罐。此罐经过改装，配备了压力调节器和大型内部推进剂罐。必须手动安装。"
	gun_type = /obj/item/weapon/gun/flamer/m240/spec
	max_rounds = 250

	max_intensity = 60
	max_range = 8
	max_duration = 50

/obj/item/ammo_magazine/flamer_tank/smoke
	name = "M240定制焚烧器烟雾罐"
	desc = "一个装有粉末状烟雾的罐体，暴露于明火时会膨胀，并携带任何化学物质一同扩散。"
	matter = list("metal" = 3750)
	flamer_chem = null
	custom = TRUE

//tanks printable by the research biomass machine
/obj/item/ammo_magazine/flamer_tank/custom/upgraded
	name = "M240升级版定制焚烧器燃料罐"
	desc = "用于M240焚烧器单元的燃料罐。此罐经过改装，配备了更大、更精密的内部推进剂罐，允许更大的容量和更强的燃料。"
	matter = list("metal" = 50) // no free metal
	flamer_chem = null
	max_rounds = 200
	max_range = 7
	fuel_pressure = 1
	max_duration = 50
	max_intensity = 60
	custom = TRUE

/obj/item/ammo_magazine/flamer_tank/smoke/upgraded
	name = "M240大型定制焚烧器烟雾罐"
	desc = "一个装有粉末状烟雾的罐体，暴露于明火时会膨胀，并携带任何化学物质一同扩散。此罐配备了升级的内部压缩机，允许更大的容量。"
	matter = list("metal" = 50) //no free metal
	flamer_chem = null
	custom = TRUE
	max_rounds = 150

/obj/item/ammo_magazine/flamer_tank/survivor
	name = "简易火焰喷射器燃料罐"
	desc = "一个从重型焊接设备中改装的罐体，装有类似凝固汽油的可燃混合物。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/flamers.dmi'
	icon_state = "flamer_fuel"
	gun_type = /obj/item/weapon/gun/flamer/survivor
	stripe_icon = FALSE

/obj/item/ammo_magazine/flamer_tank/survivor/empty
	flamer_chem = null

/obj/item/ammo_magazine/flamer_tank/flammenwerfer
	name = "FW3重型焚烧器燃料罐"
	desc = "FW3重型焚烧装置使用的一款重型、高容量燃料罐。罐体上印有蓝色的耐高温维兰德-汤谷标志。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/WY/flamers.dmi'
	icon_state = "fl3"
	item_state = "fl3"
	gun_type = /obj/item/weapon/gun/flamer/flammenwerfer3
	max_rounds = 300
	max_range = 8
	max_intensity = 70
	stripe_icon = FALSE

/obj/item/ammo_magazine/flamer_tank/flammenwerfer/whiteout
	name = "FW3重型焚烧器燃料罐（EX型）"
	desc = "FW3重型焚烧装置使用的EX型超稠萘燃料重型燃料罐，这是一种粘性可燃液态化学品，燃烧温度极高，足以熔化大多数防火材料。罐体上印有蓝色的耐高温维兰德-汤谷标志。小心处理。"
	caliber = "凝固汽油EX型"
	flamer_chem = "napalmex"
	stripe_icon = TRUE
