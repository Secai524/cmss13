#define M2C_SETUP_TIME (0.2 SECONDS)
#define M2C_OVERHEAT_CRITICAL 25
#define M2C_OVERHEAT_BAD 14
#define M2C_OVERHEAT_OK 4
#define M2C_OVERHEAT_DAMAGE 30
#define M2C_LOW_COOLDOWN_ROLL 0.3
#define M2C_HIGH_COOLDOWN_ROLL 0.45
#define M2C_PASSIVE_COOLDOWN_AMOUNT 4
#define T37_PASSIVE_COOLDOWN_AMOUNT 4
#define M2C_OVERHEAT_OVERLAY 14
#define M2C_CRUSHER_STUN 3 //amount in ticks (roughly 3 seconds)

/*M2C HEAVY MACHINEGUN AND ITS COMPONENTS */
// AMMO
/obj/item/ammo_magazine/m2c
	name = "M2C弹药箱（10x28mm钨芯弹）"
	desc = "一箱125发、用于M2重机枪系统的10x28mm钨芯弹。当重机枪未装载弹药箱时，点击它以为M2C重新装弹。"
	caliber = "10x28mm"
	w_class = SIZE_LARGE
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/machineguns.dmi'
	icon_state = "m2c"
	item_state = "m2c"
	max_rounds = 125
	default_ammo = /datum/ammo/bullet/machinegun/auto
	gun_type = null

/obj/item/ammo_magazine/m2c/t37
	name = "T37弹药箱（7.62x54mmR子弹）"
	desc = "一箱125发、用于UPP T37中型机枪系统的7.62x54mmR子弹。当重机枪未装载弹药箱时，点击它以为T37重新装弹。"
	caliber = "7.62x54mmR"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/machineguns.dmi'
	icon_state = "t37"
	item_state = "t37"
	max_rounds = 150
	default_ammo = /datum/ammo/bullet/machinegun/medium

//STORAGE BOX FOR THE MACHINEGUN
/obj/item/storage/box/m56d/m2c
	name = "\improper M2C Assembly-Supply Crate"
	desc = "一个标有‘M2C，10x28mm口径重机枪’的大箱子，拿起来似乎相当沉重。内含一套致命的M2C重机枪系统及其弹药。"
	icon = 'icons/obj/structures/crates.dmi'
	icon_state = "M56D_case"
	w_class = SIZE_HUGE
	storage_slots = 5

/obj/item/storage/box/m56d/m2c/fill_preset_inventory()
	new /obj/item/device/m2c_gun(src)
	new /obj/item/ammo_magazine/m2c(src)
	new /obj/item/ammo_magazine/m2c(src)
	new /obj/item/ammo_magazine/m2c(src)
	new /obj/item/ammo_magazine/m2c(src)

// THE GUN ITSELF

/obj/item/device/m2c_gun
	name = "\improper M2C heavy machine gun"
	desc = "已拆卸的M2C重机枪，其伸缩式三脚架已折叠，无法开火。"
	w_class = SIZE_HUGE
	flags_equip_slot = SLOT_BACK
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/hmg.dmi'
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/guns_by_type/machineguns.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/machineguns_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/machineguns_righthand.dmi'
	)
	icon_state = "M2C_gun_mount"
	item_state = "M2C_gun_mount"
	var/rounds = 0
	var/overheat_value = 0
	var/anti_cadehugger_range = 1
	var/broken_gun = FALSE
	var/field_recovery = 130
	health = 230

/obj/item/device/m2c_gun/Initialize()
	. = ..()
	update_icon()

/obj/item/device/m2c_gun/update_icon() //Lets generate the icon based on how much ammo it has.
	var/icon_name = initial(icon_state)
	if(broken_gun)
		icon_name += "_broken"
		if(!rounds)
			icon_name += "_e"

	else if(!broken_gun && !rounds)
		icon_name += "_e"

	icon_state = icon_name

/obj/item/device/m2c_gun/proc/check_can_setup(mob/user, turf/rotate_check, turf/open/OT, list/ACR)
	if(!ishuman(user) && !HAS_TRAIT(user, TRAIT_OPPOSABLE_THUMBS))
		return FALSE
	if(broken_gun)
		to_chat(user, SPAN_WARNING("你无法架设\the [src]，它完全损坏了！"))
		return FALSE
	if(SSinterior.in_interior(user))
		to_chat(usr, SPAN_WARNING("这里空间太局促，无法部署\a [src]。"))
		return FALSE
	var/area/area = get_area(user)
	if(!area.allow_construction)
		to_chat(user, SPAN_WARNING("你无法在这里架设\the [src]。"))
		return
	if(OT.density || !isturf(OT) || !OT.allow_construction)
		to_chat(user, SPAN_WARNING("你无法在这里架设\the [src]。"))
		return FALSE
	if(rotate_check.density)
		to_chat(user, SPAN_WARNING("你无法那样架设\the [src]，你身后有墙！"))
		return FALSE
	for(var/obj/structure/potential_blocker in rotate_check)
		if(potential_blocker.density)
			to_chat(user, SPAN_WARNING("你无法那样架设\the [src]，你身后有\a [potential_blocker]！"))
			return FALSE
	if((locate(/obj/structure/barricade) in ACR) || (locate(/obj/structure/window_frame) in ACR) || (locate(/obj/structure/window) in ACR) || (locate(/obj/structure/windoor_assembly) in ACR))
		to_chat(user, SPAN_WARNING("附近有障碍物，你无法在这里架设\the [src]！"))
		return FALSE
	var/fail = FALSE
	for(var/obj/X in OT.contents - src)
		if(istype(X, /obj/structure/machinery/defenses))
			fail = TRUE
			break
		else if(istype(X, /obj/structure/machinery/door))
			fail = TRUE
			break
		else if(istype(X, /obj/structure/machinery/m56d_hmg))
			fail = TRUE
			break
	if(fail)
		to_chat(user, SPAN_WARNING("你无法在这里安装\the [src]，有东西挡路。"))
		return FALSE


	if(!(user.alpha > 60))
		to_chat(user, SPAN_WARNING("你无法在隐形状态下架设这个！"))
		return FALSE
	return TRUE


/obj/item/device/m2c_gun/attack_self(mob/user)
	..()
	var/turf/rotate_check = get_step(user.loc, turn(user.dir, 180))
	var/turf/open/OT = usr.loc
	var/list/ACR = range(anti_cadehugger_range, user.loc)

	if(!check_can_setup(user, rotate_check, OT, ACR))
		return

	if(!do_after(user, M2C_SETUP_TIME, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		return

	if(!check_can_setup(user, rotate_check, OT, ACR))
		return

	var/obj/structure/machinery/m56d_hmg/auto/HMG = new(user.loc)
	transfer_label_component(HMG)
	HMG.setDir(user.dir) // Make sure we face the right direction
	HMG.anchored = TRUE
	playsound(HMG, 'sound/items/m56dauto_setup.ogg', 75, TRUE)
	to_chat(user, SPAN_NOTICE("你部署了[HMG]。"))
	HMG.rounds = rounds
	HMG.overheat_value = overheat_value
	HMG.health = health
	HMG.update_damage_state()
	HMG.update_icon()
	qdel(src)

	if(HMG.rounds > 0)
		HMG.try_mount_gun(user)

/obj/item/device/m2c_gun/attackby(obj/item/object as obj, mob/user as mob)
	if(!ishuman(user) && !HAS_TRAIT(user, TRAIT_OPPOSABLE_THUMBS))
		return

	if(!iswelder(object) || user.action_busy)
		return

	if(!HAS_TRAIT(object, TRAIT_TOOL_BLOWTORCH))
		to_chat(user, SPAN_WARNING("你需要一把更强的喷枪！"))
		return

	if(!broken_gun)
		to_chat(user, SPAN_WARNING("[src]并未严重损坏，无需进行战场修复。"))
		return

	var/obj/item/tool/weldingtool/weldingtool = object

	if(weldingtool.remove_fuel(2, user))
		user.visible_message(SPAN_NOTICE("[user]开始对\the [src]进行战场修复。"),
			SPAN_NOTICE("You begin repairing the severe damages on \the [src] in an effort to restore its functions."))
		playsound(src.loc, 'sound/items/Welder2.ogg', 25, 1)
		if(!do_after(user, field_recovery * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL, BUSY_ICON_FRIENDLY, src))
			return
		user.visible_message(SPAN_NOTICE("[user]完成了\the [src]的战场修复，使其恢复原状。"),
			SPAN_NOTICE("You repair \the [src] back to a functional state."))
		broken_gun = FALSE
		health = 110
		update_icon()
		return
	else
		to_chat(user, SPAN_WARNING("你需要往\the [weldingtool]里加更多燃料才能对[src]进行战场修复。"))

// MACHINEGUN, AUTOMATIC
/obj/structure/machinery/m56d_hmg/auto
	name = "\improper M2C Heavy Machinegun"
	desc = "一款可部署的重机枪。M2C '黑猩猩' HB是M2 HB的改装型号，为USCM重新配置以发射10x28mm无壳钨芯弹。它能够进行无后坐力射击和快速旋转。然而，由于部件所用金属质量低劣，它存在严重的过热问题，迫使其只能作为班组支援武器用于决定性的、碾压式的交战。<B> 站在它后面，空手点击其图标即可操控。在非抓取意图下点击拖动可拆卸枪支，在抓取意图下可移除弹匣。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/hmg.dmi'
	icon_state = "M2C"
	icon_full = "M2C"
	icon_empty = "M2C_e"
	rounds_max = 125
	ammo = /datum/ammo/bullet/machinegun/auto
	fire_delay = 0.1 SECONDS
	var/grip_dir = null
	var/fold_time = 1.5 SECONDS
	var/repair_time = 5 SECONDS
	density = TRUE
	health = 230
	health_max = 230
	display_ammo = FALSE
	var/list/cadeblockers = list()
	var/cadeblockers_range = 1
	var/stationary = FALSE

	var/static/image/barrel_overheat_image
	var/has_barrel_overlay = FALSE

	gun_noise = 'sound/weapons/gun_m56d_auto.ogg'
	empty_alarm = 'sound/weapons/hmg_eject_mag.ogg'

	// OVERHEAT MECHANIC VARIABLES
	var/overheat_value = 0
	var/overheat_threshold = 40
	var/passive_cooldown = M2C_PASSIVE_COOLDOWN_AMOUNT
	var/emergency_cooling = FALSE
	var/overheat_text_cooldown = 0
	var/force_cooldown_timer = 10
	var/rotate_timer = 0
	var/fire_stopper = FALSE

	// Muzzle Flash Offsets
	north_x_offset = 0
	north_y_offset = 10
	east_x_offset = 0
	east_y_offset = 12
	south_x_offset = 0
	south_y_offset = 10
	west_x_offset = 0
	west_y_offset = 12

// ANTI-CADE EFFECT, CREDIT TO WALTERMELDRON

/obj/structure/machinery/m56d_hmg/auto/Initialize()
	. = ..()
	burst_scatter_mult = 0
	for(var/turf/T in range(cadeblockers_range, src))
		var/obj/structure/blocker/anti_cade/CB = new(T)
		CB.hmg = src

		cadeblockers.Add(CB)

	if(!barrel_overheat_image)
		barrel_overheat_image = image('icons/obj/items/weapons/guns/guns_by_faction/USCM/hmg.dmi', "+M2C_overheat")

/obj/structure/machinery/m56d_hmg/auto/Destroy()
	QDEL_NULL_LIST(cadeblockers)
	return ..()

/obj/structure/machinery/m56d_hmg/auto/process()

	var/mob/user = operator
	overheat_value -= passive_cooldown
	if(overheat_value <= 0)
		overheat_value = 0
		STOP_PROCESSING(SSobj, src)

	if(overheat_value >= M2C_OVERHEAT_CRITICAL)
		to_chat(user, SPAN_HIGHDANGER("[src]的枪管极度过热，照这样下去可能会开始熔化。"))
	else if(overheat_value >= M2C_OVERHEAT_BAD)
		to_chat(user, SPAN_DANGER("[src]的枪管非常烫，但仍能开火。"))
	else if(overheat_value  >= M2C_OVERHEAT_OK)
		to_chat(user, SPAN_DANGER("[src]的枪管相当热，不过还算稳定。"))
	else if (overheat_value > 0)
		to_chat(user, SPAN_WARNING("[src]的枪管微温。"))

	update_icon()

// ANTI-CADE EFFECT, CREDIT TO WALTERMELDRON
/obj/structure/blocker/anti_cade
	health = INFINITY
	anchored = TRUE
	density = FALSE
	unacidable = TRUE
	explo_proof = TRUE
	invisibility = 101 // no looking at it with alt click

	var/obj/structure/machinery/m56d_hmg/auto/hmg

	alpha = 0

/obj/structure/blocker/anti_cade/BlockedPassDirs(atom/movable/ammo_magazine, target_dir)
	if(istype(ammo_magazine, /obj/structure/barricade))
		return BLOCKED_MOVEMENT
	else if(istype(ammo_magazine, /obj/structure/window))
		return BLOCKED_MOVEMENT
	else if(istype(ammo_magazine, /obj/structure/windoor_assembly))
		return BLOCKED_MOVEMENT
	else if(istype(ammo_magazine, /obj/structure/machinery/door))
		return BLOCKED_MOVEMENT
	return ..()

/obj/structure/blocker/anti_cade/Destroy()
	if(hmg)
		hmg.cadeblockers.Remove(src)
		hmg = null

	return ..()

/obj/structure/machinery/m56d_hmg/auto/update_icon() //Lets generate the icon based on how much ammo it has.
	if(!rounds)
		icon_state = "[icon_empty]"
	else
		icon_state = "[icon_full]"

	if(overheat_value >= M2C_OVERHEAT_OVERLAY)
		if(has_barrel_overlay)
			return
		overlays += barrel_overheat_image
		has_barrel_overlay = TRUE
	else if(has_barrel_overlay)
		overlays -= barrel_overheat_image
		has_barrel_overlay = FALSE

// DED

/obj/structure/machinery/m56d_hmg/auto/update_health(amount) //Negative values restores health.
	health -= amount
	if(health <= 0)
		playsound(src.loc, 'sound/items/Welder2.ogg', 25, 1)
		visible_message(SPAN_WARNING("[src]完全损坏了！"))
		var/obj/item/device/m2c_gun/HMG = new(loc)
		HMG.rounds = rounds
		HMG.broken_gun = TRUE
		HMG.unacidable = FALSE
		HMG.health = 0
		HMG.update_icon()
		transfer_label_component(HMG)
		qdel(src)
		return

	if(health > health_max)
		health = health_max
	update_damage_state()
	update_icon()

/obj/structure/machinery/m56d_hmg/auto/attackby(obj/item/object as obj, mob/user as mob)
	if(!ishuman(user) && !HAS_TRAIT(user, TRAIT_OPPOSABLE_THUMBS))
		return
	// RELOADING
	if(istype(object, /obj/item/ammo_magazine/m2c))
		var/obj/item/ammo_magazine/m2c/magazine = object
		if(!ispath(magazine.default_ammo, ammo))
			to_chat(user, SPAN_WARNING("弹药口径不匹配！"))
			return
		if(rounds)
			to_chat(user, SPAN_WARNING("[src]里面已经有一个弹药箱了，先把它拿出来！"))
			return
		if(user.action_busy)
			return
		user.visible_message(SPAN_NOTICE("[user]给[src]装填了一个弹药箱！"), SPAN_NOTICE("You load [src] with an ammo box!"))
		playsound(src.loc, 'sound/items/m56dauto_load.ogg', 75, 1)
		rounds = min(rounds + magazine.current_rounds, rounds_max)
		update_icon()
		user.temp_drop_inv_item(object)
		qdel(object)
		return

	// WELDER REPAIR
	if(iswelder(object))
		if(!HAS_TRAIT(object, TRAIT_TOOL_BLOWTORCH))
			to_chat(user, SPAN_WARNING("你需要一把更强的喷枪！"))
			return
		if(user.action_busy)
			return

		var/obj/item/tool/weldingtool/weldingtool = object

		if(health == health_max)
			to_chat(user, SPAN_WARNING("[src]不需要修理，它保养得很好。"))
			return

		if(weldingtool.remove_fuel(2, user))
			user.visible_message(SPAN_NOTICE("[user]开始修复\the [src]的损伤。"),
				SPAN_NOTICE("You begin repairing the damage on \the [src]."))
			playsound(src.loc, 'sound/items/Welder2.ogg', 25, 1)
			if(!do_after(user, repair_time * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL, BUSY_ICON_FRIENDLY, src))
				return
			user.visible_message(SPAN_NOTICE("[user]修复了[src]上的一些损伤。"),
					SPAN_NOTICE("You repair [src]."))
			update_health(-floor(health_max*0.2))
			playsound(src.loc, 'sound/items/Welder2.ogg', 25, 1)
		else
			to_chat(user, SPAN_WARNING("你需要给[weldingtool]加更多燃料才能修复[src]的损伤。"))
		return
	return

// AUTOMATIC FIRING

/obj/structure/machinery/m56d_hmg/auto/try_fire()
	if(fire_stopper)
		return

	if(overheat_value >= overheat_threshold)
		if(world.time > overheat_text_cooldown)
			operator.visible_message(SPAN_HIGHDANGER("[src]过热并暂时失效了！"), SPAN_HIGHDANGER("[src] has overheated! You have to wait for it to cooldown!"))
			overheat_text_cooldown = world.time + 3 SECONDS

		if(!emergency_cooling)
			emergency_cooling = TRUE
			to_chat(operator, SPAN_DANGER("你等待[src]的枪管冷却以继续持续射击。"))
			fire_stopper = TRUE
			STOP_PROCESSING(SSobj, src)
			addtimer(CALLBACK(src, PROC_REF(force_cooldown)), force_cooldown_timer)
		return

	return ..()


/obj/structure/machinery/m56d_hmg/auto/fire_shot()
	. = ..()

	handle_rotating_gun(operator)
	if((. & AUTOFIRE_CONTINUE) && rounds)
		overheat_value += 1
		START_PROCESSING(SSobj, src)

/obj/structure/machinery/m56d_hmg/auto/handle_ammo_out(mob/user)
	visible_message(SPAN_NOTICE("[icon2html(src, viewers(src))] [src]的弹药箱掉在地上，现在已经完全空了。"))
	playsound(loc, empty_alarm, 70, 1)
	update_icon() //final safeguard.
	var/obj/item/ammo_magazine/m2c/ammo_magazine = new /obj/item/ammo_magazine/m2c(src.loc)
	ammo_magazine.current_rounds = 0
	ammo_magazine.update_icon()

// ACTIVE COOLING

/obj/structure/machinery/m56d_hmg/auto/proc/force_cooldown(mob/user)
	user = operator

	overheat_value = floor((rand(M2C_LOW_COOLDOWN_ROLL, M2C_HIGH_COOLDOWN_ROLL) * overheat_threshold))
	playsound(src.loc, 'sound/weapons/hmg_cooling.ogg', 75, 1)
	to_chat(user, SPAN_NOTICE("[src]的枪管已冷却到足以重新开始射击。"))
	emergency_cooling = FALSE
	fire_stopper = FALSE
	fire_delay = initial(fire_delay)
	update_health(M2C_OVERHEAT_DAMAGE)
	START_PROCESSING(SSobj, src)
	update_icon()

// TOGGLE MODE

/obj/structure/machinery/m56d_hmg/auto/clicked(mob/user, list/mods, atom/A)
	if (mods[CTRL_CLICK])
		if(operator != user)
			return ..()
		if(!CAN_PICKUP(user, src))
			return ..()
		to_chat(user, SPAN_NOTICE("你试图切换\the [src]的点射模式，却发现它根本没有这个功能。"))
		return TRUE

	return ..()

//ATTACK WITH BOTH HANDS COMBO

/obj/structure/machinery/m56d_hmg/auto/attack_hand(mob/living/user)
	if(..())
		return TRUE

	try_mount_gun(user)

// DISASSEMBLY

/obj/structure/machinery/m56d_hmg/auto/MouseDrop(over_object, src_location, over_location)
	var/mob/living/carbon/user = usr
	// If the user is unconscious or dead.
	if(user.stat)
		return
	if(!ishuman(user) && !HAS_TRAIT(user, TRAIT_OPPOSABLE_THUMBS))
		return

	if(over_object == user && in_range(src, user))
		if(stationary)
			to_chat(user, SPAN_WARNING("你无法拆卸[src]，它是固定式的！"))
			return
		if((rounds > 0) && (user.a_intent & (INTENT_GRAB)))
			playsound(src.loc, 'sound/items/m56dauto_load.ogg', 75, 1)
			user.visible_message(SPAN_NOTICE("[user]移除了[src]的弹药箱。"),SPAN_NOTICE("You remove [src]'s ammo box, preparing the gun for disassembly."))
			var/obj/item/ammo_magazine/m2c/used_ammo = new(user.loc)
			used_ammo.current_rounds = rounds
			user.put_in_active_hand(used_ammo)
			rounds = 0

		else
			if(!do_after(user, fold_time* user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL, BUSY_ICON_FRIENDLY, src)) // disassembly time reduced
				return
			user.visible_message(SPAN_NOTICE("[user]拆解了[src]。"),SPAN_NOTICE("You fold up the tripod for [src], disassembling it."))
			playsound(src.loc, 'sound/items/m56dauto_setup.ogg', 75, 1)
			var/obj/item/device/m2c_gun/HMG = new(loc)
			transfer_label_component(HMG)
			HMG.rounds = rounds
			HMG.overheat_value = floor(0.5 * overheat_value)
			if (HMG.overheat_value <= 10)
				HMG.overheat_value = 0
			HMG.update_icon()
			HMG.health = health
			user.put_in_active_hand(HMG)
			if(user.equip_to_slot_if_possible(HMG, WEAR_BACK, disable_warning = TRUE))
				to_chat(user, SPAN_NOTICE("你迅速将机枪扛到背上！"))
			qdel(src)

	update_icon()

// MOUNT THE MG

/obj/structure/machinery/m56d_hmg/auto/on_set_interaction(mob/user)
	..()
	ADD_TRAIT(user, TRAIT_OVERRIDE_CLICKDRAG, TRAIT_SOURCE_WEAPON)
	RegisterSignal(user, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(disable_interaction))

// DISMOUNT THE MG

/obj/structure/machinery/m56d_hmg/auto/on_unset_interaction(mob/user)
	REMOVE_TRAIT(user, TRAIT_OVERRIDE_CLICKDRAG, TRAIT_SOURCE_WEAPON)
	UnregisterSignal(user, COMSIG_MOVABLE_PRE_MOVE)
	..()

// GET ANIMATED

/obj/structure/machinery/m56d_hmg/auto/update_pixels(mob/user, mounting = TRUE)
	if(mounting)
		var/diff_x = 0
		var/diff_y = 0
		var/tilesize = 32
		var/viewoffset = tilesize * 1

		user.reset_view(src)
		if(dir == EAST)
			diff_x = -16 + user_old_x
			user.client.set_pixel_x(viewoffset)
			user.client.set_pixel_y(0)
		if(dir == WEST)
			diff_x = 16 + user_old_x
			user.client.set_pixel_x(-viewoffset)
			user.client.set_pixel_y(0)
		if(dir == NORTH)
			diff_y = -16 + user_old_y
			user.client.set_pixel_x(0)
			user.client.set_pixel_y(viewoffset)
		if(dir == SOUTH)
			diff_y = 16 + user_old_y
			user.client.set_pixel_x(0)
			user.client.set_pixel_y(-viewoffset)

		animate(user, pixel_x=diff_x, pixel_y=diff_y, 0.4 SECONDS)
	else
		if(user.client)
			user.client.change_view(GLOB.world_view_size)
			user.client.set_pixel_x(0)
			user.client.set_pixel_y(0)

		animate(user, pixel_x=user_old_x, pixel_y=user_old_y, 4, 1)


//ROTATE THE MACHINEGUN

/obj/structure/machinery/m56d_hmg/auto/proc/rotate_to(mob/user, atom/A)
	if(!A || !user.x || !user.y || !A.x || !A.y)
		return
	var/dx = A.x - user.x
	var/dy = A.y - user.y
	if(!dx && !dy)
		return

	var/direction
	if(abs(dx) < abs(dy))
		if(dy > 0)
			direction = NORTH
		else
			direction = SOUTH
	else
		if(dx > 0)
			direction = EAST
		else
			direction = WEST

	var/turf/rotate_check = get_step(src.loc, turn(direction,180))
	if(rotate_check.density)
		to_chat(user, SPAN_WARNING("你无法朝那个方向旋转它。"))
		return

	src.setDir(direction)
	user.setDir(direction)
	update_pixels(user)
	playsound(src.loc, 'sound/items/m56dauto_rotate.ogg', 25, 1)
	to_chat(user, SPAN_NOTICE("你旋转[src]，利用三脚架支撑你的转动动作。"))


/obj/structure/machinery/m56d_hmg/auto/proc/disable_interaction(mob/living/user, NewLoc, direction)
	SIGNAL_HANDLER

	if(user.body_position != STANDING_UP || get_dist(user,src) > 0 || user.is_mob_incapacitated() || !user.client)
		user.unset_interaction()

/obj/structure/machinery/m56d_hmg/auto/proc/handle_rotating_gun(mob/user)
	var/angle = get_dir(src, target)
	if(world.time > rotate_timer && !((dir & angle) && target.loc != src.loc && target.loc != operator.loc))
		rotate_timer = world.time + 0.4 SECONDS
		rotate_to(user, target)
		return TRUE

/obj/structure/machinery/m56d_hmg/auto/t37
	name = "\improper T37 Medium Machinegun"
	desc = "一款可部署的中型机枪。T37是UPP的机枪，发射7.62x64mmR弹药。与USCM的M2C型号不同，它的射速较慢，但更利于持续射击。由于设计质量原因，若承受过多伤害，它有爆炸的倾向。<B> 站在它后方，空手点击其图标即可操控。在非抓取意图下点击拖动可拆解枪支，在抓取意图下可移除弹匣。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/UPP/hmg.dmi'
	icon_state = "t37"
	icon_full = "t37"
	icon_empty = "t37_e"
	rounds_max = 150
	ammo = /datum/ammo/bullet/machinegun/medium
	fire_delay = 0.35 SECONDS
	grip_dir = null
	stationary = TRUE

	// OVERHEAT MECHANIC VARIABLES
	overheat_threshold = 20
	passive_cooldown = T37_PASSIVE_COOLDOWN_AMOUNT

	var/explosion_chance = 70
	var/explosion_power = 65
	var/explosion_falloff = 25
	var/falloff_mode = EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL

/obj/structure/machinery/m56d_hmg/auto/t37/update_health(amount)
	health -= amount
	if(health <= 0)
		if(prob(explosion_chance))
			var/cause_data = create_cause_data(src.name)
			visible_message(SPAN_HIGHDANGER("[src]炸成了碎片！"))
			cell_explosion(loc, explosion_power, explosion_falloff, falloff_mode, null, cause_data)
		playsound(src.loc, 'sound/items/Welder2.ogg', 25, 1)
		qdel(src)
		return
	return ..()

/obj/structure/machinery/m56d_hmg/auto/t37/handle_ammo_out(mob/user)
	visible_message(SPAN_NOTICE("[icon2html(src, viewers(src))] [src]的弹药箱掉在地上，现在已经完全空了。"))
	playsound(loc, empty_alarm, 70, 1)
	update_icon() //final safeguard.
	var/obj/item/ammo_magazine/m2c/t37/ammo_magazine = new(loc)
	ammo_magazine.current_rounds = 0
	ammo_magazine.update_icon()

#undef M2C_OVERHEAT_CRITICAL
#undef M2C_OVERHEAT_BAD
#undef M2C_OVERHEAT_OK
#undef M2C_SETUP_TIME
#undef M2C_OVERHEAT_DAMAGE
#undef M2C_LOW_COOLDOWN_ROLL
#undef M2C_HIGH_COOLDOWN_ROLL
#undef M2C_PASSIVE_COOLDOWN_AMOUNT
#undef M2C_OVERHEAT_OVERLAY
#undef M2C_CRUSHER_STUN
