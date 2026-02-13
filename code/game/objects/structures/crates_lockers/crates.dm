//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/obj/structure/closet/crate
	name = "crate"
	desc = "一个长方形的钢制板条箱。"
	icon = 'icons/obj/structures/crates.dmi'
	icon_state = "closed_basic"
	icon_opened = "open_basic"
	icon_closed = "closed_basic"
	climbable = 1
	anchored = FALSE
	throwpass = 1 //prevents moving crates by hurling things at them
	store_mobs = FALSE
	var/rigged = FALSE
	/// Types this crate can be made into
	var/list/crate_customizing_types = list(
		"Plain" = /obj/structure/closet/crate,
		"Plain (Green)" = /obj/structure/closet/crate/green,
		"Weapons" = /obj/structure/closet/crate/weapon,
		"Supply" = /obj/structure/closet/crate/supply,
		"Ammo" = /obj/structure/closet/crate/ammo,
		"Ammo (Black)" = /obj/structure/closet/crate/ammo/alt,
		"Ammo (Flame)" = /obj/structure/closet/crate/ammo/alt/flame,
		"Construction" = /obj/structure/closet/crate/construction,
		"Science" = /obj/structure/closet/crate/science,
		"水培区" = /obj/structure/closet/crate/hydroponics,
		"医疗区" = /obj/structure/closet/crate/medical,
		"Internals" = /obj/structure/closet/crate/internals,
		"Explosives" = /obj/structure/closet/crate/explosives,
		"Alpha" = /obj/structure/closet/crate/alpha,
		"Bravo" = /obj/structure/closet/crate/bravo,
		"Charlie" = /obj/structure/closet/crate/charlie,
		"Delta" = /obj/structure/closet/crate/delta,
	)
	COOLDOWN_DECLARE(rigged_activation_cooldown)

/obj/structure/closet/crate/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_OVER|PASS_AROUND

/obj/structure/closet/crate/can_open()
	return 1

/obj/structure/closet/crate/can_close()
	for(var/mob/living/L in get_turf(src)) //Can't close if someone is standing inside it. This is to prevent "crate traps" (let someone step in, close, open for 30 damage)
		return 0
	return 1

/obj/structure/closet/crate/BlockedPassDirs(atom/movable/mover, target_dir)
	for(var/obj/structure/S in get_turf(mover))
		if(S && S.climbable && !(S.flags_atom & ON_BORDER) && climbable && isliving(mover)) //Climbable non-border objects allow you to universally climb over others
			return NO_BLOCKED_MOVEMENT
	if(opened) //Open crate, you can cross over it
		return NO_BLOCKED_MOVEMENT

	return ..()

/obj/structure/closet/crate/open(mob/user, force)
	if(opened)
		return FALSE
	if(!force && !can_open())
		return FALSE

	if(rigged && locate(/obj/item/device/radio/electropack) in src)
		if(isliving(user) && COOLDOWN_FINISHED(src, rigged_activation_cooldown))
			var/mob/living/living_user = user
			if(living_user.electrocute_act(17, src))
				COOLDOWN_START(src, rigged_activation_cooldown, 3 SECONDS)
				var/datum/effect_system/spark_spread/sparker = new /datum/effect_system/spark_spread
				sparker.set_up(5, 1, src)
				sparker.start()
				if(!force)
					return 2

	playsound(src.loc, 'sound/machines/click.ogg', 15, 1)
	for(var/obj/thing in src)
		thing.forceMove(get_turf(src))
	opened = TRUE
	update_icon()
	if(climbable)
		structure_shaken()
		climbable = FALSE //Open crate is not a surface that works when climbing around
	return TRUE

/obj/structure/closet/crate/close(mob/user)
	if(!opened)
		return 0
	if(!can_close())
		return 0

	playsound(src.loc, 'sound/machines/click.ogg', 15, 1)
	var/itemcount = 0
	for(var/obj/O in get_turf(src))
		if(itemcount >= storage_capacity)
			break
		if(O.density || O.anchored || istype(O, /obj/structure/closet) || istype(O, /obj/effect))
			continue
		if(istype(O, /obj/structure/bed)) //This is only necessary because of rollerbeds and swivel chairs.
			var/obj/structure/bed/B = O
			if(B.buckled_mob)
				continue
		if(istype(O, /obj/item/phone))
			continue
		O.forceMove(src)
		itemcount++

	opened = 0
	climbable = 1
	update_icon()
	return 1

/obj/structure/closet/crate/attackby(obj/item/object, mob/user)
	if(object.flags_item & ITEM_ABSTRACT)
		return
	if(opened)
		user.drop_inv_item_to_loc(object, loc)
		return
	if(istype(object, /obj/item/packageWrap) || istype(object, /obj/item/stack/fulton) || istype(object, /obj/item/tool/hand_labeler)) //If it does something to the crate, don't open it.
		return
	if(attempt_rigging(object, user))
		return
	return attack_hand(user)

/// Returns TRUE if any rigging handling was performed (even if nothing changed)
/obj/structure/closet/crate/proc/attempt_rigging(obj/item/object, mob/user)
	if(istype(object, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/cable = object
		if(rigged)
			to_chat(user, SPAN_NOTICE("[src]已经接好引爆线了！"))
			return TRUE
		if(cable.use(1))
			var/pack = locate(/obj/item/device/radio/electropack) in src
			if(pack)
				to_chat(user, SPAN_NOTICE("你为[src]接上引爆线，并用[pack]将其设置完毕。"))
			else
				to_chat(user, SPAN_NOTICE("你为[src]接上引爆线。"))
			rigged = TRUE
			update_icon()
		return TRUE
	if(istype(object, /obj/item/device/radio/electropack))
		if(rigged && !(locate(/obj/item/device/radio/electropack) in src))
			to_chat(user, SPAN_NOTICE("你将[object]连接到[src]并设置完毕。"))
			user.drop_held_item()
			object.forceMove(src)
		return TRUE
	if(HAS_TRAIT(object, TRAIT_TOOL_WIRECUTTERS))
		if(rigged)
			to_chat(user, SPAN_NOTICE("你剪断了引爆线。"))
			playsound(loc, 'sound/items/Wirecutter.ogg', 25, 1)
			rigged = FALSE
			update_icon()
		return TRUE
	return FALSE

/obj/structure/closet/crate/foodcart/attempt_rigging(obj/item/object, mob/user)
	return FALSE // No rigging

/obj/structure/closet/crate/miningcar/attempt_rigging(obj/item/object, mob/user)
	return FALSE // No rigging

/obj/structure/closet/crate/trashcart/attempt_rigging(obj/item/object, mob/user)
	return FALSE // No rigging

/obj/structure/closet/crate/freezer/cooler/attempt_rigging(obj/item/object, mob/user)
	return FALSE // No rigging

/obj/structure/closet/crate/supply/attempt_rigging(obj/item/object, mob/user)
	return FALSE // No rigging because its wooden I guess

/obj/structure/closet/crate/update_icon()
	. = ..()
	if(rigged)
		overlays += "securecrate_tampered"

/obj/structure/closet/crate/ex_act(severity)
	switch(severity)
		if(0 to EXPLOSION_THRESHOLD_LOW)
			if(prob(50))
				deconstruct(FALSE)
			return
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			contents_explosion(severity)
			deconstruct(FALSE)
			return
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			contents_explosion(severity)
			deconstruct(FALSE)
			return

/obj/structure/closet/crate/alpha
	name = "阿尔法班板条箱"
	desc = "一个印有阿尔法班标志的板条箱。"
	icon_state = "closed_alpha"
	icon_opened = "open_alpha"
	icon_closed = "closed_alpha"

/obj/structure/closet/crate/ammo
	name = "弹药箱"
	desc = "一个弹药箱。"
	icon_state = "closed_ammo"
	icon_opened = "open_ammo"
	icon_closed = "closed_ammo"

/obj/structure/closet/crate/ammo/alt
	name = "弹药箱"
	desc = "一个装有弹药的板条箱，这个是黑色的。"
	icon_state = "closed_ammo_alt"
	icon_opened = "open_ammo_alt"
	icon_closed = "closed_ammo_alt"

/obj/structure/closet/crate/ammo/alt/flame
	name = "弹药箱"
	desc = "一个黑色板条箱。警告，内含易燃物！"
	icon_state = "closed_ammo_alt2"
	icon_opened = "open_ammo_alt"//does not have its own unique icon
	icon_closed = "closed_ammo_alt2"

/obj/structure/closet/crate/green
	name = "绿色板条箱"
	desc = "USCM使用的标准绿色储物箱。这东西太常见了，里面可能装着任何东西。"
	icon_state = "closed_green"
	icon_opened = "open_green"
	icon_closed = "closed_green"

/obj/structure/closet/crate/bravo
	name = "布拉沃班板条箱"
	desc = "一个印有布拉沃班标志的板条箱。"
	icon_state = "closed_bravo"
	icon_opened = "open_bravo"
	icon_closed = "closed_bravo"

/obj/structure/closet/crate/charlie
	name = "查理班板条箱"
	desc = "一个印有查理班标志的板条箱。"
	icon_state = "closed_charlie"
	icon_opened = "open_charlie"
	icon_closed = "closed_charlie"

/obj/structure/closet/crate/construction
	name = "工程建材箱"
	desc = "一个工程建材箱。"
	icon_state = "closed_construction"
	icon_opened = "open_construction"
	icon_closed = "closed_construction"

/obj/structure/closet/crate/delta
	name = "德尔塔班板条箱"
	desc = "一个印有德尔塔班标志的板条箱。"
	icon_state = "closed_delta"
	icon_opened = "open_delta"
	icon_closed = "closed_delta"

/obj/structure/closet/crate/explosives
	name = "爆炸物箱"
	desc = "一个爆炸物箱。"
	icon_state = "closed_explosives"
	icon_opened = "open_explosives"
	icon_closed = "closed_explosives"

/obj/structure/closet/crate/freezer
	name = "冷冻箱"
	desc = "一个冷冻箱。"
	icon_state = "closed_freezer"
	icon_opened = "open_freezer"
	icon_closed = "closed_freezer"
	crate_customizing_types = null
	var/target_temp = T0C - 40
	var/cooling_power = 40

/obj/structure/closet/crate/freezer/cooler
	icon = 'icons/obj/structures/souto_land.dmi'
	desc = "一个存放啤酒和其他饮料的舒适冷藏箱。"
	icon_state = "cooler_closed"
	icon_opened = "cooler_open"
	icon_closed = "cooler_closed"
	cooling_power = 10//not nearly as good as the actual freezer crate

/obj/structure/closet/crate/freezer/cooler/oj
	icon_state = "cooler-oj_closed"
	icon_opened = "cooler-oj_open"
	icon_closed = "cooler-oj_closed"


/obj/structure/closet/crate/hydroponics
	name = "水培箱"
	desc = "消灭那些恼人菌毯和害虫所需的一切。"
	icon_state = "closed_hydro"
	icon_opened = "open_hydro"
	icon_closed = "closed_hydro"

/obj/structure/closet/crate/hydroponics/prespawned
	//This exists so the prespawned hydro crates spawn with their contents.

/obj/structure/closet/crate/hydroponics/prespawned/Initialize()
	. = ..()
	new /obj/item/reagent_container/spray/plantbgone(src)
	new /obj/item/reagent_container/spray/plantbgone(src)
	new /obj/item/tool/minihoe(src)

/obj/structure/closet/crate/internals
	name = "维生设备箱"
	desc = "一个维生设备箱。"
	icon_state = "closed_oxygen"
	icon_opened = "open_oxygen"
	icon_closed = "closed_oxygen"

/obj/structure/closet/crate/medical
	name = "医疗箱"
	desc = "一个医疗箱。"
	icon_state = "closed_medical"
	icon_opened = "open_medical"
	icon_closed = "closed_medical"

/obj/structure/closet/crate/plastic
	name = "塑料箱"
	desc = "一个长方形的塑料箱。"
	icon_state = "closed_plastic"
	icon_opened = "open_plastic"
	icon_closed = "closed_plastic"

/obj/structure/closet/crate/rcd
	name = "快速建造装置箱"
	desc = "一个用于存放快速建造装置的箱子。"

/obj/structure/closet/crate/freezer/rations //Fpr use in the escape shuttle
	desc = "一箱应急口粮。"
	name = "应急口粮"

/obj/structure/closet/crate/freezer/rations/Initialize()
	. = ..()
	new /obj/item/storage/box/donkpockets(src)
	new /obj/item/storage/box/donkpockets(src)

/obj/structure/closet/crate/radiation
	name = "放射性装备箱"
	desc = "一个带有辐射标志的箱子。"
	icon_state = "closed_radioactive"
	icon_opened = "open_radioactive"
	icon_closed = "closed_radioactive"

/obj/structure/closet/crate/radiation/Initialize()
	. = ..()
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)

/obj/structure/closet/crate/science
	name = "科研箱"
	desc = "一个科研箱。"
	icon_state = "closed_science"
	icon_opened = "open_science"
	icon_closed = "closed_science"

/obj/structure/closet/crate/supply
	name = "补给箱"
	desc = "一个补给箱。"
	icon_state = "closed_supply"
	icon_opened = "open_supply"
	icon_closed = "closed_supply"

/obj/structure/closet/crate/trashcart
	name = "垃圾车"
	desc = "一个沉重的带轮金属垃圾车。"
	icon_state = "closed_trashcart"
	icon_opened = "open_trashcart"
	icon_closed = "closed_trashcart"

/obj/structure/closet/crate/foodcart
	name = "餐车"
	desc = "一个沉重的带轮金属餐车。"
	icon_state = "foodcart2"
	icon_opened = "foodcart2_open"
	icon_closed = "foodcart2"

/obj/structure/closet/crate/foodcart/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/structure/closet/crate/foodcart/alt
	icon_state = "foodcart1"
	icon_opened = "foodcart1_open"
	icon_closed = "foodcart1"

/obj/structure/closet/crate/weapon
	name = "武器箱"
	desc = "一个武器箱。"
	icon_state = "closed_weapons"
	icon_opened = "open_weapons"
	icon_closed = "closed_weapons"
	var/obj/item/weapon_type
	var/obj/item/ammo_type
	var/ammo_count = 5

/obj/structure/closet/crate/weapon/Initialize()
	. = ..()
	if(ammo_type)
		for(var/t=0,t<ammo_count,t++)
			new ammo_type(src)
	if(weapon_type)
		new weapon_type(src)

/obj/structure/closet/crate/empexplosives
	name = "电磁炸药箱"
	desc = "一个装有EMP手榴弹的炸药箱。"
	icon_state = "closed_explosives"
	icon_opened = "open_explosives"
	icon_closed = "closed_explosives"

/obj/structure/closet/crate/empexplosives/Initialize()
	. = ..()
	new /obj/item/explosive/grenade/empgrenade(src)
	new /obj/item/explosive/grenade/empgrenade(src)
	new /obj/item/explosive/grenade/empgrenade(src)
	new /obj/item/explosive/grenade/empgrenade(src)
	new /obj/item/explosive/grenade/empgrenade(src)
	new /obj/item/explosive/grenade/empgrenade(src)

	/* * * * * * * * * * * * * *
	 * Training weapon crates. *
	 * * * * * * * * * * * * * */

/obj/structure/closet/crate/weapon/training/m41a
	name = "训练用M41A MK2步枪箱"
	desc = "一个装有M41A MK2步枪及其非致命弹药的箱子。用于战斗训练。"
	weapon_type = /obj/item/weapon/gun/rifle/m41a/training
	ammo_type = /obj/item/ammo_magazine/rifle/rubber

/obj/structure/closet/crate/weapon/training/m4ra
	name = "训练用M4RA步枪箱"
	desc = "一个装有M4RA战斗步枪及其非致命弹药的箱子。用于战斗训练。"
	weapon_type = /obj/item/weapon/gun/rifle/m4ra/training
	ammo_type = /obj/item/ammo_magazine/rifle/m4ra/rubber

/obj/structure/closet/crate/weapon/training/l42a
	name = "训练用L42A步枪箱"
	desc = "一个装有L42A战斗步枪及其非致命弹药的箱子。用于战斗训练。"
	weapon_type = /obj/item/weapon/gun/rifle/l42a/training
	ammo_type = /obj/item/ammo_magazine/rifle/l42a/rubber

/obj/structure/closet/crate/weapon/training/m39
	name = "训练用M39冲锋枪箱"
	desc = "一个装有M39冲锋枪及其非致命弹药的箱子。用于战斗训练。"
	weapon_type = /obj/item/weapon/gun/smg/m39/training
	ammo_type = /obj/item/ammo_magazine/smg/m39/rubber

/obj/structure/closet/crate/weapon/training/m4a3
	name = "训练用M4A3手枪箱"
	desc = "一个装有M4A3手枪及其非致命弹药的箱子。用于战斗训练。"
	weapon_type = /obj/item/weapon/gun/pistol/m4a3/training
	ammo_type = /obj/item/ammo_magazine/pistol/rubber

/obj/structure/closet/crate/weapon/training/mod88
	name = "训练用88 mod 4手枪箱"
	desc = "一个装有88 mod 4手枪及其非致命弹药的箱子。用于战斗训练。"
	weapon_type = /obj/item/weapon/gun/pistol/mod88/training
	ammo_type = /obj/item/ammo_magazine/pistol/mod88/rubber

/obj/structure/closet/crate/weapon/training/grenade
	name = "橡胶弹M15手榴弹箱"
	desc = "一个装有多枚非致命M15手榴弹的箱子。用于战斗训练和防暴控制。"
	ammo_type = /obj/item/explosive/grenade/high_explosive/m15/rubber
	ammo_count = 6


/obj/structure/closet/crate/miningcar
	name = "\improper minecart"
	desc = "本质上是一个带轮子的大金属桶。这个有一个现代塑料外壳。"
	icon_state = "closed_mcart"
	density = TRUE
	icon_opened = "open_mcart"
	icon_closed = "closed_mcart"

/obj/structure/closet/crate/miningcar/yellow
	name = "\improper minecart"
	desc = "本质上是一个带轮子的大金属桶。这个有一个现代塑料外壳。"
	icon_state = "closed_mcart_y"
	density = TRUE
	icon_opened = "open_mcart_y"
	icon_closed = "closed_mcart_y"
