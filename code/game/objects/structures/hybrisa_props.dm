// Hybrisa props



/obj/structure/prop/hybrisa
	icon = 'icons/obj/structures/props/vehicles/small_truck_red.dmi'
	icon_state = "pimp"

// Vehicles

/obj/structure/prop/hybrisa/vehicles
	icon = 'icons/obj/structures/props/vehicles/meridian_red.dmi'
	icon_state = "meridian_red"
	health = 1500
	var/damage_state = 0
	var/brute_multiplier = 3

/obj/structure/prop/hybrisa/vehicles/attack_alien(mob/living/carbon/xenomorph/user)
	user.animation_attack_on(src)
	take_damage( rand(user.melee_damage_lower, user.melee_damage_upper) * brute_multiplier)
	playsound(src, 'sound/effects/metalscrape.ogg', 20, 1)
	if(health <= 0)
		user.visible_message(SPAN_DANGER("[user]将[src]切成了碎片！"),
		SPAN_DANGER("We slice [src] apart!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		user.visible_message(SPAN_DANGER("[user] [user.slashes_verb] [src]!"),
		SPAN_DANGER("We [user.slash_verb] [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_icon()
	return XENO_ATTACK_ACTION

/obj/structure/prop/hybrisa/vehicles/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	take_damage(xeno.melee_damage_upper * brute_multiplier)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	update_icon()
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/prop/hybrisa/vehicles/update_icon()
	switch(health)
		if(1250 to 1500)
			icon_state = initial(icon_state)
			return
		if(1000 to 1250)
			damage_state = 1
		if(750 to 1000)
			damage_state = 2
		if(500 to 750)
			damage_state = 3
		if(250 to 500)
			damage_state = 4
		if(0 to 250)
			damage_state = 5
	icon_state = "[initial(icon_state)]_damage_[damage_state]"

/obj/structure/prop/hybrisa/vehicles/get_examine_text(mob/user)
	. = ..()
	switch(health)
		if(1250 to 1500)
			. += SPAN_WARNING("It looks to be in good condition.")
		if(1000 to 1250)
			. += SPAN_WARNING("It looks slightly damaged.")
		if(750 to 1000)
			. += SPAN_WARNING("It looks moderately damaged.")
		if(500 to 750)
			. += SPAN_DANGER("It looks heavily damaged.")
		if(250 to 500)
			. += SPAN_DANGER("It looks very heavily damaged.")
		if(0 to 250)
			. += SPAN_DANGER("It looks like it's about break down into scrap.")

/obj/structure/prop/hybrisa/vehicles/proc/explode(dam, mob/M)
	visible_message(SPAN_DANGER("[src]炸成了碎片！"), max_distance = 1)
	playsound(loc, 'sound/effects/car_crush.ogg', 20)
	var/turf/Tsec = get_turf(src)
	new /obj/item/stack/rods(Tsec)
	new /obj/item/stack/rods(Tsec)
	new /obj/item/stack/sheet/metal(Tsec)
	new /obj/item/stack/sheet/metal(Tsec)
	new /obj/item/stack/cable_coil/cut(Tsec)

	new /obj/effect/spawner/gibspawner/robot(Tsec)
	new /obj/effect/decal/cleanable/blood/oil(src.loc)

	deconstruct(FALSE)
/obj/structure/prop/hybrisa/vehicles/proc/take_damage(dam, mob/M)
	if(health) //Prevents unbreakable objects from being destroyed
		health -= dam
		if(health <= 0)
			explode()
		else
			update_icon()

/obj/structure/prop/hybrisa/vehicles/bullet_act(obj/projectile/P)
	if(P.ammo.damage)
		take_damage(P.ammo.damage)
		playsound(src, 'sound/effects/metalping.ogg', 35, 1)
		update_icon()

// Armored Truck - Damage States

/obj/structure/prop/hybrisa/vehicles/Armored_Truck
	name = "重型装载卡车"
	desc = "它被锁住了，而且似乎已经抛锚，别想着开它了。"
	icon = 'icons/obj/structures/props/vehicles/armored_truck_wy_black.dmi'
	icon_state = "armored_truck_wy_black"
	bound_height = 64
	bound_width = 96
	density = TRUE
	layer = ABOVE_MOB_LAYER
	projectile_coverage = 85

/obj/structure/prop/hybrisa/vehicles/Armored_Truck/Blue
	icon = 'icons/obj/structures/props/vehicles/armored_truck_blue.dmi'
	icon_state = "armored_truck_blue"

/obj/structure/prop/hybrisa/vehicles/Armored_Truck/Teal
	icon = 'icons/obj/structures/props/vehicles/armored_truck_teal.dmi'
	icon_state = "armored_truck_teal"

/obj/structure/prop/hybrisa/vehicles/Armored_Truck/White
	icon = 'icons/obj/structures/props/vehicles/armored_truck_white.dmi'
	icon_state = "armored_truck_white"

/obj/structure/prop/hybrisa/vehicles/Armored_Truck/WY_Black
	name = "维兰德-汤谷安保卡车"
	icon = 'icons/obj/structures/props/vehicles/armored_truck_wy_black.dmi'
	icon_state = "armored_truck_wy_black"

/obj/structure/prop/hybrisa/vehicles/Armored_Truck/WY_White
	name = "维兰德-汤谷安保卡车"
	icon = 'icons/obj/structures/props/vehicles/armored_truck_wy_white.dmi'
	icon_state = "armored_truck_wy_white"

// Ambulance - Damage States
/obj/structure/prop/hybrisa/vehicles/Ambulance
	name = "ambulance"
	desc = "它被锁住了，而且似乎已经抛锚，别想着开它了。"
	icon = 'icons/obj/structures/props/vehicles/ambulance.dmi'
	icon_state = "ambulance"
	bound_height = 64
	bound_width = 96
	density = TRUE
	layer = ABOVE_MOB_LAYER

// Long Hauler Truck - Damage States
/obj/structure/prop/hybrisa/vehicles/Long_Truck
	name = "长途运输卡车"
	desc = "它被锁住了，而且似乎已经抛锚，别想着开它了。"
	icon = 'icons/obj/structures/props/vehicles/long_truck_wy_blue.dmi'
	icon_state = "longtruck_wy_blue"
	bound_height = 64
	bound_width = 128
	density = TRUE

/obj/structure/prop/hybrisa/vehicles/Long_Truck/Blue
	icon = 'icons/obj/structures/props/vehicles/long_truck_blue.dmi'
	icon_state = "longtruck_blue"

/obj/structure/prop/hybrisa/vehicles/Long_Truck/Red
	icon = 'icons/obj/structures/props/vehicles/long_truck_red.dmi'
	icon_state = "longtruck_red"

/obj/structure/prop/hybrisa/vehicles/Long_Truck/Brown
	icon = 'icons/obj/structures/props/vehicles/long_truck_brown.dmi'
	icon_state = "longtruck_brown"

/obj/structure/prop/hybrisa/vehicles/Long_Truck/Kelland_Mining
	icon = 'icons/obj/structures/props/vehicles/long_truck_kelland.dmi'
	icon_state = "longtruck_kelland"

/obj/structure/prop/hybrisa/vehicles/Long_Truck/Donk
	icon = 'icons/obj/structures/props/vehicles/long_truck_donk.dmi'
	icon_state = "longtruck_donk"

/obj/structure/prop/hybrisa/vehicles/Long_Truck/WY_Blue
	icon = 'icons/obj/structures/props/vehicles/long_truck_wy_blue.dmi'
	icon_state = "longtruck_wy_blue"

/obj/structure/prop/hybrisa/vehicles/Long_Truck/WY_Black
	icon = 'icons/obj/structures/props/vehicles/long_truck_wy_black.dmi'
	icon_state = "longtruck_wy_black"

// Small Truck - Damage States
/obj/structure/prop/hybrisa/vehicles/Small_Truck
	name = "小型卡车"
	desc = "它被锁住了，而且似乎已经抛锚，别想着开它了。"
	icon = 'icons/obj/structures/props/vehicles/small_truck_turquoise_cargo.dmi'
	icon_state = "small_truck_turquoise_cargo"
	bound_height = 32
	bound_width = 64
	density = TRUE
	layer = ABOVE_MOB_LAYER
	projectile_coverage = 60

/obj/structure/prop/hybrisa/vehicles/Small_Truck/Turquoise_Cargo
	icon = 'icons/obj/structures/props/vehicles/small_truck_turquoise_cargo.dmi'
	icon_state = "small_truck_turquoise_cargo"

/obj/structure/prop/hybrisa/vehicles/Small_Truck/White
	icon = 'icons/obj/structures/props/vehicles/small_truck_white.dmi'
	icon_state = "small_truck_white"

/obj/structure/prop/hybrisa/vehicles/Small_Truck/White_Cargo
	icon = 'icons/obj/structures/props/vehicles/small_truck_white_cargo.dmi'
	icon_state = "small_truck_white_cargo"

/obj/structure/prop/hybrisa/vehicles/Small_Truck/Mining
	icon = 'icons/obj/structures/props/vehicles/small_truck_mining.dmi'
	icon_state = "small_truck_mining"

/obj/structure/prop/hybrisa/vehicles/Small_Truck/Blue
	icon = 'icons/obj/structures/props/vehicles/small_truck_blue.dmi'
	icon_state = "small_truck_blue"

/obj/structure/prop/hybrisa/vehicles/Small_Truck/Red
	icon = 'icons/obj/structures/props/vehicles/small_truck_red.dmi'
	icon_state = "small_truck_red"

/obj/structure/prop/hybrisa/vehicles/Small_Truck/Brown
	icon = 'icons/obj/structures/props/vehicles/small_truck_brown.dmi'
	icon_state = "small_truck_brown"

/obj/structure/prop/hybrisa/vehicles/Small_Truck/Green
	icon = 'icons/obj/structures/props/vehicles/small_truck_green.dmi'
	icon_state = "small_truck_green"

/obj/structure/prop/hybrisa/vehicles/Small_Truck/Garbage
	icon = 'icons/obj/structures/props/vehicles/small_truck_garbage.dmi'
	icon_state = "small_truck_garbage"

/obj/structure/prop/hybrisa/vehicles/Small_Truck/Brown_Cargo
	icon = 'icons/obj/structures/props/vehicles/small_truck_brown_cargo.dmi'
	icon_state = "small_truck_brown_cargo"

/obj/structure/prop/hybrisa/vehicles/Small_Truck/Blue_Cargo
	icon = 'icons/obj/structures/props/vehicles/small_truck_blue_cargo.dmi'
	icon_state = "small_truck_blue_cargo"

/obj/structure/prop/hybrisa/vehicles/Small_Truck/Medical_Cargo
	icon = 'icons/obj/structures/props/vehicles/small_truck_medical.dmi'
	icon_state = "small_truck_medical"

/obj/structure/prop/hybrisa/vehicles/Small_Truck/Brown_Cargo_Barrels
	icon = 'icons/obj/structures/props/vehicles/small_truck_brown_cargobarrels.dmi'
	icon_state = "small_truck_brown_cargobarrels"

// Box Vans - Damage States
/obj/structure/prop/hybrisa/vehicles/Box_Vans
	name = "厢式货车"
	desc = "它被锁住了，而且似乎已经抛锚，别想着开它了。"
	icon = 'icons/obj/structures/props/vehicles/box_van_hyperdyne.dmi'
	icon_state = "box_van_hyperdyne"
	bound_height = 32
	bound_width = 64
	density = TRUE
	layer = ABOVE_MOB_LAYER
	projectile_coverage = 20

/obj/structure/prop/hybrisa/vehicles/Box_Vans/Hyperdyne
	icon = 'icons/obj/structures/props/vehicles/box_van_hyperdyne.dmi'
	icon_state = "box_van_hyperdyne"

/obj/structure/prop/hybrisa/vehicles/Box_Vans/White
	icon = 'icons/obj/structures/props/vehicles/box_van_white.dmi'
	icon_state = "box_van_white"

/obj/structure/prop/hybrisa/vehicles/Box_Vans/Blue_Grey
	icon = 'icons/obj/structures/props/vehicles/box_van_bluegrey.dmi'
	icon_state = "box_van_bluegrey"

/obj/structure/prop/hybrisa/vehicles/Box_Vans/Kelland_Mining
	icon = 'icons/obj/structures/props/vehicles/box_van_kellandmining.dmi'
	icon_state = "box_van_kellandmining"

/obj/structure/prop/hybrisa/vehicles/Box_Vans/Maintenance_Blue
	icon = 'icons/obj/structures/props/vehicles/box_van_maintenanceblue.dmi'
	icon_state = "box_van_maintenanceblue"

/obj/structure/prop/hybrisa/vehicles/Box_Vans/Pizza
	icon = 'icons/obj/structures/props/vehicles/box_van_pizza.dmi'
	icon_state = "box_van_pizza"

// Meridian Cars - Damage States
/obj/structure/prop/hybrisa/vehicles/Meridian
	name = "单谱"
	desc = "‘单谱’，一款面向美洲合众国境内外殖民地市场的大规模量产民用载具。由维兰德-汤谷公司旗下汽车品牌及关联运营部门‘子午线’生产。"
	icon = 'icons/obj/structures/props/vehicles/meridian_red.dmi'
	icon_state = "meridian_red"
	bound_height = 32
	bound_width = 64
	density = TRUE
	layer = ABOVE_MOB_LAYER
	projectile_coverage = PROJECTILE_COVERAGE_LOW
	throwpass = TRUE

/obj/structure/prop/hybrisa/vehicles/Meridian/Red
	icon = 'icons/obj/structures/props/vehicles/meridian_red.dmi'
	icon_state = "meridian_red"

/obj/structure/prop/hybrisa/vehicles/Meridian/Red/damage_1
	health = 1125

/obj/structure/prop/hybrisa/vehicles/Meridian/Red/damage_2
	health = 875

/obj/structure/prop/hybrisa/vehicles/Meridian/Red/damage_3
	health = 625

/obj/structure/prop/hybrisa/vehicles/Meridian/Red/damage_4
	health = 375

/obj/structure/prop/hybrisa/vehicles/Meridian/Red/damage_5
	health = 125

/obj/structure/prop/hybrisa/vehicles/Meridian/Black
	icon = 'icons/obj/structures/props/vehicles/meridian_black.dmi'
	icon_state = "meridian_black"

/obj/structure/prop/hybrisa/vehicles/Meridian/Black/damage_1
	health = 1125

/obj/structure/prop/hybrisa/vehicles/Meridian/Black/damage_2
	health = 875

/obj/structure/prop/hybrisa/vehicles/Meridian/Black/damage_3
	health = 625

/obj/structure/prop/hybrisa/vehicles/Meridian/Black/damage_4
	health = 375

/obj/structure/prop/hybrisa/vehicles/Meridian/Black/damage_5
	health = 125

/obj/structure/prop/hybrisa/vehicles/Meridian/Blue
	icon = 'icons/obj/structures/props/vehicles/meridian_blue.dmi'
	icon_state = "meridian_blue"

/obj/structure/prop/hybrisa/vehicles/Meridian/Blue/damage_1
	health = 1125

/obj/structure/prop/hybrisa/vehicles/Meridian/Blue/damage_2
	health = 875

/obj/structure/prop/hybrisa/vehicles/Meridian/Blue/damage_3
	health = 625

/obj/structure/prop/hybrisa/vehicles/Meridian/Blue/damage_4
	health = 375

/obj/structure/prop/hybrisa/vehicles/Meridian/Blue/damage_5
	health = 125

/obj/structure/prop/hybrisa/vehicles/Meridian/Brown
	icon = 'icons/obj/structures/props/vehicles/meridian_brown.dmi'
	icon_state = "meridian_brown"

/obj/structure/prop/hybrisa/vehicles/Meridian/Brown/damage_1
	health = 1125

/obj/structure/prop/hybrisa/vehicles/Meridian/Brown/damage_2
	health = 875

/obj/structure/prop/hybrisa/vehicles/Meridian/Brown/damage_3
	health = 625

/obj/structure/prop/hybrisa/vehicles/Meridian/Brown/damage_4
	health = 375

/obj/structure/prop/hybrisa/vehicles/Meridian/Brown/damage_5
	health = 125

/obj/structure/prop/hybrisa/vehicles/Meridian/Cop
	icon = 'icons/obj/structures/props/vehicles/meridian_cop.dmi'
	icon_state = "meridian_cop"

/obj/structure/prop/hybrisa/vehicles/Meridian/Cop/damage_1
	health = 1125

/obj/structure/prop/hybrisa/vehicles/Meridian/Cop/damage_2
	health = 875

/obj/structure/prop/hybrisa/vehicles/Meridian/Cop/damage_3
	health = 625

/obj/structure/prop/hybrisa/vehicles/Meridian/Cop/damage_4
	health = 375

/obj/structure/prop/hybrisa/vehicles/Meridian/Cop/damage_5
	health = 125

/obj/structure/prop/hybrisa/vehicles/Meridian/Desat_Blue
	icon = 'icons/obj/structures/props/vehicles/meridian_desatblue.dmi'
	icon_state = "meridian_desatblue"

/obj/structure/prop/hybrisa/vehicles/Meridian/Desat_Blue/damage_1
	health = 1125

/obj/structure/prop/hybrisa/vehicles/Meridian/Desat_Blue/damage_2
	health = 875

/obj/structure/prop/hybrisa/vehicles/Meridian/Desat_Blue/damage_3
	health = 625

/obj/structure/prop/hybrisa/vehicles/Meridian/Desat_Blue/damage_4
	health = 375

/obj/structure/prop/hybrisa/vehicles/Meridian/Desat_Blue/damage_5
	health = 125

/obj/structure/prop/hybrisa/vehicles/Meridian/Green
	icon = 'icons/obj/structures/props/vehicles/meridian_green.dmi'
	icon_state = "meridian_green"

/obj/structure/prop/hybrisa/vehicles/Meridian/Green/damage_1
	health = 1125

/obj/structure/prop/hybrisa/vehicles/Meridian/Green/damage_2
	health = 875

/obj/structure/prop/hybrisa/vehicles/Meridian/Green/damage_3
	health = 625

/obj/structure/prop/hybrisa/vehicles/Meridian/Green/damage_4
	health = 375

/obj/structure/prop/hybrisa/vehicles/Meridian/Green/damage_5
	health = 125

/obj/structure/prop/hybrisa/vehicles/Meridian/Light_Blue
	icon = 'icons/obj/structures/props/vehicles/meridian_lightblue.dmi'
	icon_state = "meridian_lightblue"

/obj/structure/prop/hybrisa/vehicles/Meridian/Light_Blue/damage_1
	health = 1125

/obj/structure/prop/hybrisa/vehicles/Meridian/Light_Blue/damage_2
	health = 875

/obj/structure/prop/hybrisa/vehicles/Meridian/Light_Blue/damage_3
	health = 625

/obj/structure/prop/hybrisa/vehicles/Meridian/Light_Blue/damage_4
	health = 375

/obj/structure/prop/hybrisa/vehicles/Meridian/Light_Blue/damage_5
	health = 125

/obj/structure/prop/hybrisa/vehicles/Meridian/Pink
	icon = 'icons/obj/structures/props/vehicles/meridian_pink.dmi'
	icon_state = "meridian_pink"

/obj/structure/prop/hybrisa/vehicles/Meridian/Pink/damage_1
	health = 1125

/obj/structure/prop/hybrisa/vehicles/Meridian/Pink/damage_2
	health = 875

/obj/structure/prop/hybrisa/vehicles/Meridian/Pink/damage_3
	health = 625

/obj/structure/prop/hybrisa/vehicles/Meridian/Pink/damage_4
	health = 375

/obj/structure/prop/hybrisa/vehicles/Meridian/Pink/damage_5
	health = 125

/obj/structure/prop/hybrisa/vehicles/Meridian/Purple
	icon = 'icons/obj/structures/props/vehicles/meridian_purple.dmi'
	icon_state = "meridian_purple"

/obj/structure/prop/hybrisa/vehicles/Meridian/Purple/damage_1
	health = 1125

/obj/structure/prop/hybrisa/vehicles/Meridian/Purple/damage_2
	health = 875

/obj/structure/prop/hybrisa/vehicles/Meridian/Purple/damage_3
	health = 625

/obj/structure/prop/hybrisa/vehicles/Meridian/Purple/damage_4
	health = 375

/obj/structure/prop/hybrisa/vehicles/Meridian/Purple/damage_5
	health = 125

/obj/structure/prop/hybrisa/vehicles/Meridian/Turquoise
	icon = 'icons/obj/structures/props/vehicles/meridian_turquoise.dmi'
	icon_state = "meridian_turquoise"

/obj/structure/prop/hybrisa/vehicles/Meridian/Turquoise/damage_1
	health = 1125

/obj/structure/prop/hybrisa/vehicles/Meridian/Turquoise/damage_2
	health = 875

/obj/structure/prop/hybrisa/vehicles/Meridian/Turquoise/damage_3
	health = 625

/obj/structure/prop/hybrisa/vehicles/Meridian/Turquoise/damage_4
	health = 375

/obj/structure/prop/hybrisa/vehicles/Meridian/Turquoise/damage_5
	health = 125

/obj/structure/prop/hybrisa/vehicles/Meridian/Orange
	icon = 'icons/obj/structures/props/vehicles/meridian_orange.dmi'
	icon_state = "meridian_orange"

/obj/structure/prop/hybrisa/vehicles/Meridian/Orange/damage_1
	health = 1125

/obj/structure/prop/hybrisa/vehicles/Meridian/Orange/damage_2
	health = 875

/obj/structure/prop/hybrisa/vehicles/Meridian/Orange/damage_3
	health = 625

/obj/structure/prop/hybrisa/vehicles/Meridian/Orange/damage_4
	health = 375

/obj/structure/prop/hybrisa/vehicles/Meridian/Orange/damage_5
	health = 125

/obj/structure/prop/hybrisa/vehicles/Meridian/WeylandYutani
	icon = 'icons/obj/structures/props/vehicles/meridian_wy.dmi'
	icon_state = "meridian_wy"

/obj/structure/prop/hybrisa/vehicles/Meridian/WeylandYutani/damage_1
	health = 1125

/obj/structure/prop/hybrisa/vehicles/Meridian/WeylandYutani/damage_2
	health = 875

/obj/structure/prop/hybrisa/vehicles/Meridian/WeylandYutani/damage_3
	health = 625

/obj/structure/prop/hybrisa/vehicles/Meridian/WeylandYutani/damage_4
	health = 375

/obj/structure/prop/hybrisa/vehicles/Meridian/WeylandYutani/damage_5
	health = 125

/obj/structure/prop/hybrisa/vehicles/Meridian/Taxi
	icon = 'icons/obj/structures/props/vehicles/meridian_taxi.dmi'
	icon_state = "meridian_taxi"

/obj/structure/prop/hybrisa/vehicles/Meridian/Taxi/damage_1
	health = 1125

/obj/structure/prop/hybrisa/vehicles/Meridian/Taxi/damage_2
	health = 875

/obj/structure/prop/hybrisa/vehicles/Meridian/Taxi/damage_3
	health = 625

/obj/structure/prop/hybrisa/vehicles/Meridian/Taxi/damage_4
	health = 375

/obj/structure/prop/hybrisa/vehicles/Meridian/Taxi/damage_5
	health = 125

/obj/structure/prop/hybrisa/vehicles/Meridian/Shell
	desc = "一个处于组装初期的单谱底盘。"
	icon = 'icons/obj/structures/props/vehicles/meridian_shell.dmi'
	icon_state = "meridian_shell"

// Colony Crawlers - Damage States
/obj/structure/prop/hybrisa/vehicles/Colony_Crawlers
	name = "殖民地履带车"
	desc = "它被锁住了，而且似乎已经抛锚，别想着开它了。"
	icon = 'icons/obj/structures/props/vehicles/crawler_wy_1.dmi'
	icon_state = "crawler_wy_1"
	bound_height = 32
	bound_width = 64
	density = TRUE
	layer = ABOVE_MOB_LAYER

/obj/structure/prop/hybrisa/vehicles/Colony_Crawlers/Science_1
	desc = "这是一款用于恶劣环境的履带式车辆。此型号专为人员运输设计。由轨道蓝国际公司提供；‘您在航空航天领域的朋友。’维兰德-汤谷的子公司。"
	icon = 'icons/obj/structures/props/vehicles/crawler_wy_1.dmi'
	icon_state = "crawler_wy_1"

/obj/structure/prop/hybrisa/vehicles/Colony_Crawlers/Science_2
	desc = "这是一款用于恶劣环境的履带式车辆。此型号专为人员运输设计。由轨道蓝国际公司提供；‘您在航空航天领域的朋友。’维兰德-汤谷的子公司。"
	icon = 'icons/obj/structures/props/vehicles/crawler_wy_2.dmi'
	icon_state = "crawler_wy_2"

/obj/structure/prop/hybrisa/vehicles/Colony_Crawlers/Crawler_Cargo
	icon = 'icons/obj/structures/props/vehicles/crawler_bed.dmi'
	icon_state = "crawler_bed"

// Mining Crawlers

/obj/structure/prop/hybrisa/vehicles/Mining_Crawlers
	name = "采矿履带车"
	desc = "这是一款用于恶劣环境的履带式车辆。由凯兰矿业公司提供；维兰德-汤谷的子公司。"
	icon = 'icons/obj/structures/props/vehicles/mining_crawler.dmi'
	icon_state = "mining_crawler_1"
	bound_height = 32
	bound_width = 64
	density = TRUE
	layer = ABOVE_MOB_LAYER

/obj/structure/prop/hybrisa/vehicles/Mining_Crawlers/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/kelland)

/obj/structure/prop/hybrisa/vehicles/Mining_Crawlers/Fuel
	icon = 'icons/obj/structures/props/vehicles/mining_crawler_fuel.dmi'
	icon_state = "mining_crawler_fuel"

// Car Pileup

/obj/structure/prop/hybrisa/vehicles/car_pileup
	name = "烧毁车辆残骸堆"
	desc = "烧毁的车辆挡住了你的去路，焦黑的车架和破碎的玻璃暗示着不久前发生的混乱。刺鼻的烟味仍在空气中弥漫。"
	icon = 'icons/obj/structures/props/vehicles/car_pileup.dmi'
	icon_state = "car_pileup"
	bound_height = 96
	bound_width = 128
	unslashable = TRUE
	unacidable = TRUE
	density = TRUE
	layer = 5

// Cave props

/obj/structure/prop/hybrisa/boulders
	icon = 'icons/obj/structures/props/natural/boulder_largedark.dmi'
	icon_state = "boulder_largedark1"

/obj/structure/prop/hybrisa/boulders/large_boulderdark
	name = "boulder"
	desc = "一块大石头。它没在烹饪任何东西。"
	icon = 'icons/obj/structures/props/natural/boulder_largedark.dmi'
	icon_state = "boulder_largedark1"
	density = TRUE
	bound_height = 64
	bound_width = 64

/obj/structure/prop/hybrisa/boulders/large_boulderdark/boulder_dark1
	icon_state = "boulder_largedark1"

/obj/structure/prop/hybrisa/boulders/large_boulderdark/boulder_dark2
	icon_state = "boulder_largedark2"

/obj/structure/prop/hybrisa/boulders/large_boulderdark/boulder_dark3
	icon_state = "boulder_largedark3"

/obj/structure/prop/hybrisa/boulders/wide_boulderdark
	name = "boulder"
	desc = "一块大石头。它没在烹饪任何东西。"
	icon = 'icons/obj/structures/props/natural/boulder_widedark.dmi'
	icon_state = "boulderwidedark"
	density = TRUE
	bound_height = 32
	bound_width = 64

/obj/structure/prop/hybrisa/boulders/wide_boulderdark/wide_boulder1
	icon_state = "boulderwidedark"

/obj/structure/prop/hybrisa/boulders/wide_boulderdark/wide_boulder2
	icon_state = "boulderwidedark2"

/obj/structure/prop/hybrisa/boulders/smallboulderdark
	name = "boulder"
	icon_state = "bouldersmalldark1"
	desc = "一块大石头。它没在烹饪任何东西。"
	icon = 'icons/obj/structures/props/natural/boulder_small.dmi'
	density = TRUE

/obj/structure/prop/hybrisa/boulders/smallboulderdark/boulder_dark1
	icon_state = "bouldersmalldark1"

/obj/structure/prop/hybrisa/boulders/smallboulderdark/boulder_dark2
	icon_state = "bouldersmalldark2"

/obj/structure/prop/hybrisa/boulders/smallboulderdark/boulder_dark3
	icon_state = "bouldersmalldark3"


/obj/structure/prop/hybrisa/cavedecor
	icon = 'icons/obj/structures/props/natural/rocks.dmi'
	name = "stalagmite"
	icon_state = "stalagmite"
	desc = "一根洞穴石笋。"
	layer = TURF_LAYER
	plane = FLOOR_PLANE

/obj/structure/prop/hybrisa/cavedecor/stalagmite0
	icon_state = "stalagmite"

/obj/structure/prop/hybrisa/cavedecor/stalagmite1
	icon_state = "stalagmite1"

/obj/structure/prop/hybrisa/cavedecor/stalagmite2
	icon_state = "stalagmite2"

/obj/structure/prop/hybrisa/cavedecor/stalagmite3
	icon_state = "stalagmite3"

/obj/structure/prop/hybrisa/cavedecor/stalagmite4
	icon_state = "stalagmite4"

/obj/structure/prop/hybrisa/cavedecor/stalagmite5
	icon_state = "stalagmite5"

// Supermart

/obj/structure/prop/hybrisa/supermart
	name = "长货架"
	icon_state = "longrack1"
	desc = "一个摆满各种食品的长架子。"
	icon = 'icons/obj/structures/props/supermart.dmi'
	density = TRUE
	projectile_coverage = 20
	throwpass = TRUE
	health = 15

/obj/structure/prop/hybrisa/supermart/bullet_act(obj/projectile/P)
	health -= P.damage
	..()
	healthcheck()
	return TRUE

/obj/structure/prop/hybrisa/supermart/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	deconstruct(FALSE)

/obj/structure/prop/hybrisa/supermart/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/prop/hybrisa/supermart/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/prop/hybrisa/supermart/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/prop/hybrisa/supermart/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/prop/hybrisa/supermart/rack
	health = 100

/obj/structure/prop/hybrisa/supermart/rack/longrackempty
	name = "shelf"
	desc = "一个空荡荡的长架子。"
	icon_state = "longrackempty"

/obj/structure/prop/hybrisa/supermart/rack/longrack1
	name = "shelf"
	desc = "一个摆满各种食品的长架子。"
	icon_state = "longrack1"

/obj/structure/prop/hybrisa/supermart/rack/longrack2
	name = "shelf"
	desc = "一个摆满各种食品的长架子。"
	icon_state = "longrack2"

/obj/structure/prop/hybrisa/supermart/rack/longrack3
	name = "shelf"
	desc = "一个摆满各种食品的长架子。"
	icon_state = "longrack3"

/obj/structure/prop/hybrisa/supermart/rack/longrack4
	name = "shelf"
	desc = "一个摆满各种食品的长架子。"
	icon_state = "longrack4"

/obj/structure/prop/hybrisa/supermart/rack/longrack5
	name = "shelf"
	desc = "一个摆满各种食品的长架子。"
	icon_state = "longrack5"

/obj/structure/prop/hybrisa/supermart/rack/longrack6
	name = "shelf"
	desc = "一个摆满各种食品的长架子。"
	icon_state = "longrack6"

/obj/structure/prop/hybrisa/supermart/rack/longrack7
	name = "shelf"
	desc = "一个摆满各种食品的长架子。"
	icon_state = "longrack7"

/obj/structure/prop/hybrisa/supermart/supermartbelt
	name = "传送带"
	desc = "一条传送带。"
	icon_state = "checkoutbelt"

/obj/structure/prop/hybrisa/supermart/freezer
	name = "商用冰柜"
	desc = "一个商用级冰柜。"
	icon_state = "freezerupper"
	density = TRUE
	health = 30

/obj/structure/prop/hybrisa/supermart/freezer/freezer1
	icon_state = "freezerupper"

/obj/structure/prop/hybrisa/supermart/freezer/freezer2
	icon_state = "freezerlower"

/obj/structure/prop/hybrisa/supermart/freezer/freezer3
	icon_state = "freezermid"

/obj/structure/prop/hybrisa/supermart/freezer/freezer4
	icon_state = "freezerupper1"

/obj/structure/prop/hybrisa/supermart/freezer/freezer5
	icon_state = "freezerlower1"

/obj/structure/prop/hybrisa/supermart/freezer/freezer6
	icon_state = "freezermid1"

/obj/structure/prop/hybrisa/supermart/supermartfruitbasket
	name = "basket"
	desc = "一个篮子。"
	icon_state = "supermarketbasketempty"
	health = 5

/obj/structure/prop/hybrisa/supermart/supermartfruitbasket/empty
	name = "basket"
	desc = "一个篮子。"
	icon_state = "supermarketbasketempty"

/obj/structure/prop/hybrisa/supermart/supermartfruitbasket/oranges
	name = "basket"
	desc = "一个装满橙子的篮子。"
	icon_state = "supermarketbasket1"

/obj/structure/prop/hybrisa/supermart/supermartfruitbasket/pears
	name = "basket"
	desc = "一个装满梨子的篮子。"
	icon_state = "supermarketbasket2"

/obj/structure/prop/hybrisa/supermart/supermartfruitbasket/carrots
	name = "basket"
	desc = "一个装满胡萝卜的篮子。"
	icon_state = "supermarketbasket3"

/obj/structure/prop/hybrisa/supermart/supermartfruitbasket/melons
	name = "basket"
	desc = "一个装满甜瓜的篮子。"
	icon_state = "supermarketbasket4"

/obj/structure/prop/hybrisa/supermart/supermartfruitbasket/apples
	name = "basket"
	desc = "一个装满苹果的篮子。"
	icon_state = "supermarketbasket5"

/obj/structure/prop/hybrisa/supermart/souto_man_prop
	name = "苏托人偶模型"
	icon = 'icons/obj/structures/props/hybrisa/souto.dmi'
	desc = "著名‘苏托人’的模特，像1999年那样狂欢！"
	icon_state = "souto_man_prop"
	density = TRUE
	health = 100

/obj/structure/prop/hybrisa/supermart/souto_man_prop/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/souta)

/obj/structure/prop/hybrisa/supermart/souto_rack
	name = "苏托汽水货架"
	icon = 'icons/obj/structures/props/hybrisa/souto.dmi'
	desc = "一个装满各种口味苏托汽水的货架。"
	icon_state = "souto_rack"
	density = TRUE
	health = 75

/obj/structure/prop/hybrisa/supermart/souto_can_stack
	name = "堆叠的苏托汽水罐"
	icon = 'icons/obj/structures/props/hybrisa/souto.dmi'
	desc = "一大摞‘经典苏托’汽水罐。"
	icon_state = "souto_can_stack"
	density = TRUE
	health = 75

// Furniture

/obj/structure/prop/hybrisa/furniture
	icon = 'icons/obj/structures/tables_64x64.dmi'
	icon_state = "blackmetaltable"
	health = 100
	projectile_coverage = 20
	throwpass = TRUE

/obj/structure/prop/hybrisa/furniture/tables
	icon = 'icons/obj/structures/tables_64x64.dmi'
	icon_state = "table_pool"
	health = 100
	projectile_coverage = 10

/obj/structure/prop/hybrisa/furniture/tables/bullet_act(obj/projectile/P)
	health -= P.damage
	..()
	healthcheck()
	return TRUE

/obj/structure/prop/hybrisa/furniture/tables/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	deconstruct(FALSE)

/obj/structure/prop/hybrisa/furniture/tables/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/prop/hybrisa/furniture/tables/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/prop/hybrisa/furniture/tables/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/prop/hybrisa/furniture/tables/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/prop/hybrisa/furniture/tables/tableblack
	name = "大型金属桌"
	desc = "一张大型黑色金属桌，看起来非常昂贵。"
	icon_state = "blackmetaltable"
	density = TRUE
	climbable = TRUE
	breakable = TRUE
	bound_height = 32
	bound_width = 64
	debris = list(/obj/item/stack/sheet/metal)
	health = 150

/obj/structure/prop/hybrisa/furniture/tables/tableblack/blacktablecomputer
	icon = 'icons/obj/structures/tables_64x64.dmi'
	icon_state = "blackmetaltable_computer"

/obj/structure/prop/hybrisa/furniture/tables/tablewood
	name = "大型木桌"
	desc = "一张大型木桌，看起来非常昂贵。"
	icon_state = "brownlargetable"
	density = TRUE
	climbable = TRUE
	breakable = TRUE
	bound_height = 32
	bound_width = 64
	debris = list(/obj/item/stack/sheet/wood)
	health = 100

/obj/structure/prop/hybrisa/furniture/tables/tablewood/woodtablecomputer
	icon = 'icons/obj/structures/tables_64x64.dmi'
	icon_state = "brownlargetable_computer"

/obj/structure/prop/hybrisa/furniture/tables/tablepool
	name = "台球桌"
	desc = "一张用于打台球的大桌子。"
	icon = 'icons/obj/structures/tables_64x64.dmi'
	icon_state = "table_pool"
	density = TRUE
	bound_height = 32
	bound_width = 64
	climbable = TRUE
	breakable = TRUE
	debris = list(/obj/item/stack/sheet/wood)

/obj/structure/prop/hybrisa/furniture/tables/tablegambling
	name = "赌桌"
	desc = "一张用于赌博的大桌子。"
	icon = 'icons/obj/structures/tables_64x64.dmi'
	icon_state = "table_cards"
	density = TRUE
	bound_height = 32
	bound_width = 64
	climbable = TRUE
	breakable = TRUE
	debris = list(/obj/item/stack/sheet/wood)

// Chairs

/obj/structure/bed/chair/comfy/hybrisa
	name = "昂贵椅子"
	desc = "一把看起来很昂贵的椅子。"

/obj/structure/bed/chair/comfy/hybrisa/black
	icon_state = "comfychair_hybrisablack"

/obj/structure/bed/chair/comfy/hybrisa/red
	icon_state = "comfychair_hybrisared"

/obj/structure/bed/chair/comfy/hybrisa/blue
	icon_state = "comfychair_hybrisablue"

/obj/structure/bed/chair/comfy/hybrisa/brown
	icon_state = "comfychair_hybrisabrown"

// Beds

/obj/structure/bed/hybrisa/dingy
	name = "肮脏的床"
	desc = "一张旧床垫放在矩形的金属框架上。用于以舒适的方式支撑躺卧的人，特别是用于常规睡眠。古老的技术，但依然有用。"
	icon_state = "bed_dingy"

/obj/structure/bed/hybrisa
	icon_state = ""
	buckling_y = 8

/obj/structure/bed/hybrisa/prisonbed
	name = "双层床"
	desc = "一张看起来寒酸的双层床。"
	icon_state = "prisonbed"

/obj/structure/bed/hybrisa/bunkbed1
	name = "双层床"
	desc = "一张看起来舒适的双层床。"
	icon_state = "zbunkbed"

/obj/structure/bed/hybrisa/bunkbed2
	name = "双层床"
	desc = "一张看起来舒适的双层床。"
	icon_state = "zbunkbed2"

/obj/structure/bed/hybrisa/bunkbed3
	name = "双层床"
	desc = "一张看起来舒适的双层床。"
	icon_state = "zbunkbed3"

/obj/structure/bed/hybrisa/bunkbed4
	name = "双层床"
	desc = "一张看起来舒适的双层床。"
	icon_state = "zbunkbed4"

// Cabinet

/obj/structure/closet/cabinet/hybrisa/metal
	name = "金属柜"
	desc = "一个大型金属柜，看起来很坚固。"
	icon_state = "cabinet_metal_closed"
	icon_closed = "cabinet_metal_closed"
	icon_opened = "cabinet_metal_open"

/obj/structure/closet/cabinet/hybrisa/metal/alt
	name = "金属柜"
	desc = "一个大型金属柜，看起来很坚固。"
	icon_state = "cabinet_metal_alt_closed"
	icon_closed = "cabinet_metal_alt_closed"
	icon_opened = "cabinet_metal_alt_open"

// Xenobiology

/obj/structure/prop/hybrisa/xenobiology
	icon = 'icons/obj/structures/props/hybrisa/hybrisaxenocryogenics.dmi'
	icon_state = "xenocellemptyon"
	layer = ABOVE_MOB_LAYER

/obj/structure/prop/hybrisa/xenobiology/small/empty
	name = "样本收容单元"
	desc = "它是空的。"
	icon_state = "xenocellemptyon"
	density = TRUE

/obj/structure/prop/hybrisa/xenobiology/small/offempty
	name = "样本收容单元"
	desc = "它已关闭且空无一物。"
	icon_state = "xenocellemptyoff"
	density = TRUE

/obj/structure/prop/hybrisa/xenobiology/small/larva
	name = "样本收容单元"
	desc = "里面有某种蠕虫状的东西..."
	icon_state = "xenocelllarva"
	density = TRUE

/obj/structure/prop/hybrisa/xenobiology/small/egg
	name = "样本收容单元"
	desc = "里面好像有某种卵状物..."
	icon_state = "xenocellegg"
	density = TRUE

/obj/structure/prop/hybrisa/xenobiology/small/hugger
	name = "样本收容单元"
	desc = "里面有某种蜘蛛状的东西..."
	icon_state = "xenocellhugger"
	density = TRUE

/obj/structure/prop/hybrisa/xenobiology/small/cracked1
	name = "样本收容单元"
	desc = "看起来有什么东西从内部把它弄破了。"
	icon_state = "xenocellcrackedempty"
	density = TRUE

/obj/structure/prop/hybrisa/xenobiology/small/cracked2
	name = "样本收容单元"
	desc = "看起来有什么东西从内部把它弄破了。"
	icon_state = "xenocellcrackedempty2"
	density = TRUE

/obj/structure/prop/hybrisa/xenobiology/small/crackedegg
	name = "样本收容单元"
	desc = "看起来有什么东西把它弄破了，里面有一个巨大的空卵。"
	icon_state = "xenocellcrackedegg"
	density = TRUE

/obj/structure/prop/hybrisa/xenobiology/giant_cryo
	icon = 'icons/obj/structures/props/xeno_cyro_giant.dmi'
	name = "巨型样本收容单元"
	desc = "一个巨大的、带有黄色玻璃的低温管耸立在你面前，里面容纳着一个庞大、怪异的实体。它是活的，还是处于深度沉睡？冰冷的雾气在底座周围盘旋，低沉的嗡鸣声弥漫在空气中。"
	icon_state = "giant_xeno_cryo"
	bound_height = 128
	bound_width = 64
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE
	density = FALSE
	layer = ABOVE_XENO_LAYER

/obj/structure/prop/hybrisa/xenobiology/misc
	icon = 'icons/obj/structures/props/hybrisa/misc_props.dmi'
	name = "奇怪的卵"
	desc = "一个看起来古老而奇怪的卵，它似乎是惰性的。"
	icon_state = "inertegg"
	unslashable = TRUE
	explo_proof = TRUE
	layer = TURF_LAYER

// Engineer

/obj/structure/prop/hybrisa/engineer
	icon = 'icons/obj/structures/props/engineers/engineerJockey.dmi'
	icon_state = "spacejockey"

/obj/structure/prop/hybrisa/engineer/spacejockey
	name = "巨型飞行员"
	desc = "一个巨大的谜团耸立在你面前——一个来自外星起源的泰坦，被冻结在时间和死亡之中。它庞大的身躯看起来已经石化，暗示着在废弃外星飞船的内部深处度过了漫长的岁月。这个生物似乎与它座椅的宏伟融为一体，仿佛是从飞船本身的本质中浮现出来。扭曲变形的骨头以一种令人毛骨悚然的方式向外突出，仿佛被某种难以想象的力量从内部猛烈地排出。这是一次与来自遥远过去的谜样存在的可怕遭遇——一个可能永远无法解开的秘密的无声见证者。"
	icon = 'icons/obj/structures/props/engineers/engineerJockey.dmi'
	icon_state = "spacejockey"
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE
	layer = ABOVE_MOB_LAYER

/obj/structure/prop/hybrisa/engineer/giantpod/broken
	name = "巨型超眠舱"
	desc = "你面前躺着一个庞然大物，看起来像是一个‘超眠舱’，使周围的一切都相形见绌。里面，一个石化的外星存在处于休眠状态。舱体本身带有暴力过去的伤痕，外壳上有熔化的洞，仿佛里面的东西曾以某种未知的力量向外爆发。居住者的干枯遗骸扭曲变形，暗示着很久以前发生的一场暴力死亡。"
	icon = 'icons/obj/structures/props/engineers/engineerPod.dmi'
	icon_state = "pod_broken"
	bound_height = 96
	density = TRUE

/obj/structure/prop/hybrisa/engineer/giantpod
	name = "巨型超眠舱"
	desc = "你面前矗立着一个令人印象深刻的结构，看起来像是一个外星设计的巨型‘超眠舱’，与你见过的任何东西都不同。它复杂的图案和陌生的符号暗示着远超人类理解能力的技术。然而，尽管它宏伟壮观，这个舱室却是空的，没有任何生命迹象。"
	icon = 'icons/obj/structures/props/engineers/engineerPod.dmi'
	icon_state = "pod"
	bound_height = 96
	bound_width = 64
	unslashable = TRUE
	unacidable = TRUE
	density = TRUE
	layer = ABOVE_MOB_LAYER
	health = 12000

/obj/structure/prop/hybrisa/engineer/giantpod/bullet_act(obj/projectile/P)
	health -= P.damage
	playsound(src, 'sound/effects/metalping.ogg', 35, 1)
	..()
	healthcheck()
	return TRUE

/obj/structure/prop/hybrisa/engineer/giantpod/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	playsound(loc, 'sound/effects/burrowoff.ogg', 25)

	deconstruct(FALSE)

/obj/structure/prop/hybrisa/engineer/giantpod/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/prop/hybrisa/engineer/giantpod/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/prop/hybrisa/engineer/giantpod/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metal_close.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/prop/hybrisa/engineer/giantpod/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metal_close.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/prop/hybrisa/engineer/giantconsole
	name = "巨型外星控制台"
	desc = "一个高耸的外星控制台矗立在你面前，其设计违背了所有的熟悉感和逻辑。这是一个未知技术的奇迹，装饰着复杂的图案和脉动的灯光，随着异世界的能量舞动。这个神秘装置有何用途？答案让你捉摸不透..."
	icon = 'icons/obj/structures/props/engineers/consoles.dmi'
	icon_state = "engineerconsole"
	bound_height = 32
	bound_width = 32
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE
	density = TRUE

/obj/structure/prop/hybrisa/engineer/engineerpillar
	icon = 'icons/obj/structures/props/engineers/hybrisaengineerpillarangled.dmi'
	icon_state = "engineerpillar_SW1fade"
	bound_height = 64
	bound_width = 128
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE
	layer = ABOVE_MOB_LAYER

/obj/structure/prop/hybrisa/engineer/engineerpillar/northwesttop
	name = "奇怪的柱子"
	icon_state = "engineerpillar_NW1"

/obj/structure/prop/hybrisa/engineer/engineerpillar/northwestbottom
	name = "奇怪的柱子"
	icon_state = "engineerpillar_NW2"

/obj/structure/prop/hybrisa/engineer/engineerpillar/southwesttop
	name = "奇怪的柱子"
	icon_state = "engineerpillar_SW1"

/obj/structure/prop/hybrisa/engineer/engineerpillar/southwestbottom
	name = "奇怪的柱子"
	icon_state = "engineerpillar_SW2"

/obj/structure/prop/hybrisa/engineer/engineerpillar/smallsouthwest1
	name = "奇怪的柱子"
	icon_state = "engineerpillar_SW1fade"

/obj/structure/prop/hybrisa/engineer/engineerpillar/smallsouthwest2
	name = "奇怪的柱子"
	icon_state = "engineerpillar_SW2fade"

/obj/structure/blackgoocontainer
	name = "奇怪的容器"
	icon_state = "blackgoocontainer1"
	desc = "一个奇怪的外星容器。它散发着异世界的神秘气息，光滑的表面没有留下任何先前内容的痕迹。它看起来完全是空的。"
	icon = 'icons/obj/items/black_goo_stuff.dmi'
	density = TRUE
	anchored = TRUE
	unslashable = FALSE
	health = 100
	projectile_coverage = 20
	throwpass = TRUE

/obj/structure/blackgoocontainer/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_HIGH_OVER_ONLY

/obj/structure/blackgoocontainer/bullet_act(obj/projectile/P)
	health -= P.damage
	playsound(src, 'sound/effects/thud.ogg', 35, 1)
	..()
	healthcheck()
	return TRUE

/obj/structure/blackgoocontainer/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	playsound(loc, 'sound/effects/burrowoff.ogg', 25)

	deconstruct(FALSE)

/obj/structure/blackgoocontainer/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/blackgoocontainer/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/blackgoocontainer/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metal_close.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/blackgoocontainer/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metal_close.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/item/hybrisa/engineer_helmet
	icon = 'icons/obj/structures/props/engineers/props.dmi'
	name = "奇怪的外星头盔"
	desc = "这个外星头盔呈现出一种怪异的形态，让人联想到拉长的大象鼻子，上面装饰着类似昆虫的眼睛，从它饱经风霜的表面向外凝视。它的用途和起源笼罩在神秘之中。当你凝视这件奇怪的遗物时，你不禁会思考那些曾经佩戴这种非传统头饰的生物，以及它可能隐藏的古老秘密..."
	icon_state = "alien_helmet"
	force = 15
	throwforce = 12
	w_class = SIZE_MEDIUM

// Airport

/obj/structure/prop/hybrisa/airport
	name = "鼻锥"
	icon = 'icons/obj/structures/props/dropship/dropship_parts.dmi'
	icon_state = "dropshipfrontwhite1"
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/prop/hybrisa/airport/dropshipnosecone
	name = "鼻锥"
	icon_state = "dropshipfrontwhite1"
	explo_proof = TRUE
	layer = ABOVE_MOB_LAYER
	density = TRUE

/obj/structure/prop/hybrisa/airport/dropshipwingleft
	name = "wing"
	icon_state = "dropshipwingtop1"
	explo_proof = TRUE
	layer = ABOVE_MOB_LAYER

/obj/structure/prop/hybrisa/airport/dropshipwingright
	name = "wing"
	icon_state = "dropshipwingtop2"
	explo_proof = TRUE
	layer = ABOVE_MOB_LAYER

/obj/structure/prop/hybrisa/airport/dropshipvent1left
	name = "vent"
	icon_state = "dropshipvent1"
	explo_proof = TRUE
	layer = ABOVE_MOB_LAYER

/obj/structure/prop/hybrisa/airport/dropshipvent2right
	name = "vent"
	icon_state = "dropshipvent2"
	explo_proof = TRUE
	layer = ABOVE_MOB_LAYER

/obj/structure/prop/hybrisa/airport/dropshipventleft
	name = "vent"
	icon_state = "dropshipvent3"
	explo_proof = TRUE
	layer = ABOVE_MOB_LAYER

/obj/structure/prop/hybrisa/airport/dropshipventright
	name = "vent"
	icon_state = "dropshipvent4"
	explo_proof = TRUE
	layer = ABOVE_MOB_LAYER

// Dropship damage

/obj/structure/prop/hybrisa/airport/dropshipenginedamage
	name = "运输机损伤"
	desc = "引擎似乎遭受了严重损坏。"
	icon = 'icons/obj/structures/props/dropship/dropshipdamage.dmi'
	icon_state = "dropship_engine_damage"
	bound_height = 64
	bound_width = 96
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE
	gender = PLURAL

/obj/structure/prop/hybrisa/airport/dropshipenginedamagenofire
	name = "运输机损伤"
	desc = "引擎似乎遭受了严重损坏。"
	icon = 'icons/obj/structures/props/dropship/dropshipdamage.dmi'
	icon_state = "dropship_engine_damage_nofire"
	bound_height = 64
	bound_width = 96
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE
	gender = PLURAL

/obj/structure/prop/hybrisa/airport/refuelinghose
	name = "加油软管"
	desc = "一根连接各类运输机的长加油软管。"
	icon = 'icons/obj/structures/props/dropship/dropshipdamage.dmi'
	icon_state = "fuelline1"
	bound_height = 64
	bound_width = 96
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/prop/hybrisa/airport/refuelinghose2
	name = "加油软管"
	desc = "一根连接各类运输机的长加油软管。"
	icon = 'icons/obj/structures/props/dropship/dropshipdamage.dmi'
	icon_state = "fuelline2"
	bound_height = 64
	bound_width = 96
	unslashable = TRUE
	unacidable = TRUE

// Pilot body

/obj/structure/prop/hybrisa/airport/deadpilot1
	name = "被斩首的维兰德-汤谷飞行员"
	desc = "一名维兰德-汤谷飞行员的残骸。他的整个头颅都不见了。滚到哪里去了？……"
	icon = 'icons/obj/structures/props/hybrisa/64x96-props.dmi'
	icon_state = "pilotbody_decap1"
	bound_height = 64
	bound_width = 96
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/prop/hybrisa/airport/deadpilot2
	name = "被斩首的维兰德-汤谷飞行员"
	desc = "一名维兰德-汤谷飞行员的残骸。他的整个头颅都不见了。滚到哪里去了？……"
	icon = 'icons/obj/structures/props/hybrisa/64x96-props.dmi'
	icon_state = "pilotbody_decap2"
	bound_height = 64
	bound_width = 96
	unslashable = TRUE
	unacidable = TRUE

// Misc

/obj/structure/prop/hybrisa/misc
	icon = 'icons/obj/structures/props/hybrisa/misc_props.dmi'
	icon_state = ""

// Floor props

/obj/structure/prop/hybrisa/misc/floorprops
	icon = 'icons/obj/structures/props/hybrisa/grates.dmi'
	icon_state = "solidgrate1"
	layer = HATCH_LAYER

/obj/structure/prop/hybrisa/misc/floorprops/grate
	name = "实心金属格栅"
	desc = "一个金属格栅。"
	icon_state = "solidgrate1"

/obj/structure/prop/hybrisa/misc/floorprops/grate2
	name = "实心金属格栅"
	desc = "一个金属格栅。"
	icon_state = "solidgrate5"

/obj/structure/prop/hybrisa/misc/floorprops/grate3
	name = "实心金属格栅"
	desc = "一个金属格栅。"
	icon_state = "zhalfgrate1"

/obj/structure/prop/hybrisa/misc/floorprops/floorglass
	name = "强化玻璃地板"
	desc = "一块经过重重强化的玻璃地板板，看起来几乎坚不可摧。"
	icon_state = "solidgrate2"
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE

/obj/structure/prop/hybrisa/misc/floorprops/floorglass2
	name = "强化玻璃地板"
	desc = "一块经过重重强化的玻璃地板板，看起来几乎坚不可摧。"
	icon_state = "solidgrate3"
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE
	layer = ABOVE_TURF_LAYER

/obj/structure/prop/hybrisa/misc/floorprops/floorglass3
	name = "强化玻璃地板"
	desc = "一块经过重重强化的玻璃地板板，看起来几乎坚不可摧。"
	icon_state = "solidgrate4"
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE

// Graffiti

/obj/structure/prop/hybrisa/misc/graffiti
	name = "graffiti"
	icon = 'icons/obj/structures/props/hybrisa/64x96-props.dmi'
	icon_state = "zgraffiti4"
	bound_height = 64
	bound_width = 96
	unslashable = TRUE
	unacidable = TRUE
	breakable = TRUE
	gender = PLURAL

/obj/structure/prop/hybrisa/misc/graffiti/graffiti1
	icon_state = "zgraffiti1"

/obj/structure/prop/hybrisa/misc/graffiti/graffiti2
	icon_state = "zgraffiti2"

/obj/structure/prop/hybrisa/misc/graffiti/graffiti3
	icon_state = "zgraffiti3"

/obj/structure/prop/hybrisa/misc/graffiti/graffiti4
	icon_state = "zgraffiti4"

/obj/structure/prop/hybrisa/misc/graffiti/graffiti5
	icon_state = "zgraffiti5"

/obj/structure/prop/hybrisa/misc/graffiti/graffiti6
	icon_state = "zgraffiti6"

/obj/structure/prop/hybrisa/misc/graffiti/graffiti7
	icon_state = "zgraffiti7"

// Wall Blood

/obj/structure/prop/hybrisa/misc/blood
	name = "blood"
	icon = 'icons/obj/structures/props/hybrisa/64x96-props.dmi'
	icon_state = "wallblood_floorblood"
	unslashable = TRUE
	unacidable = TRUE
	breakable = TRUE
	gender = PLURAL

/obj/structure/prop/hybrisa/misc/blood/blood1
	icon_state = "wallblood_floorblood"

/obj/structure/prop/hybrisa/misc/blood/blood2
	icon_state = "wall_blood_1"

/obj/structure/prop/hybrisa/misc/blood/blood3
	icon_state = "wall_blood_2"

// Fire

/obj/structure/prop/hybrisa/misc/fire
	name = "fire"
	icon = 'icons/obj/structures/props/dropship/dropshipdamage.dmi'
	icon_state = "zfire_smoke"
	layer = ABOVE_MOB_LAYER
	light_on = TRUE
	light_power = 2
	light_range = 3

/obj/structure/prop/hybrisa/misc/fire/fire1
	icon_state = "zfire_smoke"

/obj/structure/prop/hybrisa/misc/fire/fire2
	icon_state = "zfire_smoke2"

/obj/structure/prop/hybrisa/misc/fire/firebarrel
	name = "barrel"
	icon = 'icons/obj/structures/props/hybrisa/64x64_props.dmi'
	icon_state = "zbarrelfireon"
	bound_height = 32
	bound_width = 32
	density = TRUE

/obj/structure/prop/hybrisa/misc/firebarreloff
	name = "barrel"
	icon = 'icons/obj/structures/props/hybrisa/misc_props.dmi'
	icon_state = "zfirebarreloff"
	bound_height = 32
	bound_width = 32
	density = TRUE

// Misc

/obj/structure/prop/hybrisa/misc/commandosuitemptyprop
	name = "维兰德-汤谷‘M5X猿服’展示柜"
	desc = "维兰德-汤谷‘猿服’的展示模型，可惜只是个模型……"
	icon_state = "dogcatchersuitempty1"

/obj/structure/prop/hybrisa/misc/cabinet
	name = "cabinet"
	desc = "一个带抽屉的小柜子。"
	icon = 'icons/obj/structures/props/furniture/misc.dmi'
	icon_state = "sidecabinet"
	projectile_coverage = 20
	throwpass = TRUE

/obj/structure/prop/hybrisa/misc/elevator_door
	name = "损坏的电梯门"
	desc = "完全损坏，电梯无法工作了。"
	icon = 'icons/obj/structures/props/hybrisa/misc_props.dmi'
	icon_state = "elevator_left"
	opacity = FALSE
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE

/obj/structure/prop/hybrisa/misc/elevator_door/right
	icon_state = "elevator_right"

/obj/structure/prop/hybrisa/misc/trash
	name = "垃圾桶"
	desc = "一个维兰德-汤谷的垃圾桶，用于丢弃你不想要的物品，或者你也可以像其他混蛋一样直接把东西扔在地上。"
	icon = 'icons/obj/structures/props/hybrisa/trash_bins.dmi'
	icon_state = "trashblue"
	health = 100
	density = TRUE
	projectile_coverage = 10
	throwpass = TRUE

/obj/structure/prop/hybrisa/misc/trash/bullet_act(obj/projectile/P)
	health -= P.damage
	playsound(src, 'sound/effects/metalping.ogg', 35, 1)
	..()
	healthcheck()
	return TRUE

/obj/structure/prop/hybrisa/misc/trash/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	deconstruct(FALSE)

/obj/structure/prop/hybrisa/misc/trash/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/prop/hybrisa/misc/trash/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/prop/hybrisa/misc/trash/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/prop/hybrisa/misc/trash/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/prop/hybrisa/misc/trash/green
	icon_state = "trashgreen"

/obj/structure/prop/hybrisa/misc/trash/blue
	icon_state = "trashblue"

/obj/structure/prop/hybrisa/misc/redmeter
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	name = "meter"
	icon_state = "redmeter"

/obj/item/hybrisa/misc/trash_bag_full_prop
	name = "满的垃圾袋"
	desc = "这是那种厚重的黑色聚合物垃圾袋。里面装满了旧垃圾，你不想碰它。"
	icon = 'icons/obj/structures/props/hybrisa/misc_props.dmi'
	icon_state = "ztrashbag"
	force = 15
	throwforce = 3
	w_class = SIZE_MEDIUM

/obj/structure/prop/hybrisa/misc/slotmachine
	name = "老虎机"
	desc = "一台老虎机。"
	icon = 'icons/obj/structures/props/furniture/slot_machines.dmi'
	icon_state = "slotmachine"
	bound_width = 32
	bound_height = 32
	anchored = TRUE
	density = TRUE
	layer = WINDOW_LAYER
	health = 150

/obj/structure/prop/hybrisa/misc/slotmachine/broken
	name = "老虎机"
	desc = "一台损坏的老虎机。"
	icon_state = "slotmachine_broken"
	bound_width = 32
	bound_height = 32
	anchored = TRUE
	density = TRUE
	layer = WINDOW_LAYER

/obj/structure/prop/hybrisa/misc/slotmachine/bullet_act(obj/projectile/P)
	health -= P.damage
	playsound(src, 'sound/effects/metalping.ogg', 35, 1)
	..()
	healthcheck()
	return TRUE

/obj/structure/prop/hybrisa/misc/slotmachine/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	deconstruct(FALSE)

/obj/structure/prop/hybrisa/misc/slotmachine/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/prop/hybrisa/misc/slotmachine/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/prop/hybrisa/misc/slotmachine/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/prop/hybrisa/misc/slotmachine/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

// Coffee Machine (Works with Empty Coffee cups, Mugs ect.)

/obj/structure/machinery/hybrisa/coffee_machine
	icon = 'icons/obj/structures/machinery/coffee_machine.dmi'
	name = "咖啡机"
	desc = "一台咖啡机。"
	wrenchable = TRUE
	icon_state = "coffee"
	var/vends = "coffee"
	var/base_state = "coffee"
	var/fiting_cups = list(/obj/item/reagent_container/food/drinks/coffee, /obj/item/reagent_container/food/drinks/coffeecup)
	var/making_time = 10 SECONDS
	var/brewing = FALSE
	var/obj/item/reagent_container/food/drinks/cup = null

/obj/structure/machinery/hybrisa/coffee_machine/pull_response(mob/puller)
	. = ..()
	if(.)
		pixel_x = initial(pixel_x)
		pixel_y = initial(pixel_y)
	return .

/obj/structure/machinery/hybrisa/coffee_machine/inoperable(additional_flags)
	if(additional_flags & MAINT)
		return FALSE // Allow attack_hand usage
	if(!anchored)
		return TRUE
	return ..()

/obj/structure/machinery/hybrisa/coffee_machine/attack_hand(mob/living/user)
	if(..())
		return TRUE

	if(brewing)
		to_chat(user, SPAN_WARNING("[src]仍在冲泡[vends]。"))
		return FALSE

	if(cup && user.Adjacent(src) && user.put_in_hands(cup, FALSE))
		to_chat(user, SPAN_NOTICE("你将[cup]拿在手中。"))
		cup = null
		update_icon()
		return TRUE

/obj/structure/machinery/hybrisa/coffee_machine/attackby(obj/item/attacking_object, mob/user)
	if(is_type_in_list(attacking_object, fiting_cups))
		if(inoperable())
			to_chat(user, SPAN_WARNING("[src]似乎无法工作。"))
			return TRUE

		if(cup)
			to_chat(user, SPAN_WARNING("那里已经有一个[cup]了。"))
			return TRUE

		playsound(src, "sound/machines/coffee1.ogg", 40, TRUE)
		cup = attacking_object
		user.drop_inv_item_to_loc(attacking_object, src)
		update_icon()

		var/datum/reagents/current_reagent = cup.reagents
		var/space = current_reagent.maximum_volume - current_reagent.total_volume
		if(space < current_reagent.maximum_volume)
			to_chat(user, SPAN_WARNING("[capitalize_first_letters(vends)]溢出，因为它装不进[cup]，你应该先把它清空。"))

		brewing = TRUE
		addtimer(CALLBACK(src, PROC_REF(vend_coffee), user, space), making_time)
		return TRUE

	if(istype(attacking_object, /obj/item/reagent_container))
		to_chat(user, SPAN_WARNING("[attacking_object]不太合适。"))
		return TRUE

	return ..()

/obj/structure/machinery/hybrisa/coffee_machine/proc/vend_coffee(mob/user, amount)
	brewing = FALSE
	cup?.reagents?.add_reagent(vends, amount)
	if(user?.Adjacent(src) && user.put_in_hands(cup, FALSE))
		to_chat(user, SPAN_NOTICE("你将[cup]拿在手中。"))
		cup = null
	else
		to_chat(user, SPAN_WARNING("[cup]已就位，准备就绪。"))

	update_icon()

/obj/structure/machinery/hybrisa/coffee_machine/power_change(area/master_area)
	. = ..()
	update_icon()
	return .

/obj/structure/machinery/hybrisa/coffee_machine/toggle_anchored(obj/item/W, mob/user)
	. = ..()
	if(.)
		update_icon()
	return .

/obj/structure/machinery/hybrisa/coffee_machine/update_icon()
	if(!cup)
		if(!anchored)
			icon_state = ("[base_state]")
			return
		if(stat & NOPOWER)
			icon_state = ("[base_state]_empty_off")
			return
		icon_state = ("[base_state]_empty_on")
		return

	switch(cup.type)
		if(/obj/item/reagent_container/food/drinks/coffeecup)
			icon_state = ("[base_state]_mug")
		if(/obj/item/reagent_container/food/drinks/coffee/cuppa_joes)
			icon_state = ("[base_state]_cup")
		if(/obj/item/reagent_container/food/drinks/coffeecup/wy)
			icon_state = ("[base_state]_mug_wy")
		if(/obj/item/reagent_container/food/drinks/coffeecup/uscm)
			icon_state = ("[base_state]_mug_uscm")
		else
			icon_state = ("[base_state]_cup_generic")

/obj/structure/machinery/hybrisa/coffee_machine/get_examine_text(mob/user)
	. = ..()
	if(!anchored)
		. += "It does not appear to be plugged in."

// Big Computer Units 32x32

/obj/structure/machinery/big_computers
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	name = "computer"
	icon_state = "mapping_comp"
	bound_width = 32
	bound_height = 32
	anchored = TRUE
	density = TRUE
	health = 150
	opacity = FALSE

/obj/structure/machinery/big_computers/bullet_act(obj/projectile/P)
	health -= P.damage
	playsound(src, 'sound/effects/metalping.ogg', 35, 1)
	..()
	healthcheck()
	return TRUE

/obj/structure/machinery/big_computers/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	deconstruct(FALSE)

/obj/structure/machinery/big_computers/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/machinery/big_computers/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/machinery/big_computers/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/machinery/big_computers/computerwhite
	name = "computer"

/obj/structure/machinery/big_computers/computerblack
	name = "computer"

/obj/structure/machinery/big_computers/computerbrown
	icon = 'icons/obj/structures/props/almayer/almayer_props.dmi'
	name = "computer"

/obj/structure/machinery/big_computers/computerbrown/computer1
	icon_state = "mapping_comp"

/obj/structure/machinery/big_computers/computerbrown/computer2
	icon_state = "mps"

/obj/structure/machinery/big_computers/computerbrown/computer3
	icon_state = "sensor_comp1"

/obj/structure/machinery/big_computers/computerbrown/computer4
	icon_state = "sensor_comp2"

/obj/structure/machinery/big_computers/computerbrown/computer5
	icon_state = "sensor_comp3"
/obj/structure/machinery/big_computers/computerwhite/computer1
	icon_state = "mapping_comp"

/obj/structure/machinery/big_computers/computerwhite/computer2
	icon_state = "mps"

/obj/structure/machinery/big_computers/computerwhite/computer3
	icon_state = "sensor_comp1"

/obj/structure/machinery/big_computers/computerwhite/computer4
	icon_state = "sensor_comp2"

/obj/structure/machinery/big_computers/computerwhite/computer5
	icon_state = "sensor_comp3"

/obj/structure/machinery/big_computers/computerblack/computer1
	icon_state = "blackmapping_comp"

/obj/structure/machinery/big_computers/computerblack/computer2
	icon_state = "blackmps"

/obj/structure/machinery/big_computers/computerblack/computer3
	icon_state = "blacksensor_comp1"

/obj/structure/machinery/big_computers/computerblack/computer4
	icon_state = "blacksensor_comp2"

/obj/structure/machinery/big_computers/computerblack/computer5
	icon_state = "blacksensor_comp3"

/obj/structure/machinery/big_computers/messaging_server
	name = "通讯服务器"
	icon = 'icons/obj/structures/props/server_equipment.dmi'
	icon_state = "messageserver_black"

/obj/structure/machinery/big_computers/messaging_server/black
	icon_state = "messageserver_black"

/obj/structure/machinery/big_computers/messaging_server/white
	icon_state = "messageserver_white"

/obj/structure/machinery/big_computers/messaging_server/brown
	icon_state = "messageserver_brown"

// Science Computer Stuff

/obj/structure/machinery/big_computers/science_big
	icon = 'icons/obj/structures/machinery/science_machines_64x32.dmi'
	name = "合成模拟器"
	icon_state = "modifier"
	bound_width = 64
	bound_height = 32
	anchored = TRUE
	density = TRUE
	health = 150
	opacity = FALSE

/obj/structure/machinery/big_computers/science_big/synthesis_simulator
	name = "合成模拟器"
	desc = "这台计算机使用先进算法模拟试剂属性，旨在计算合成新变体所需的配方。"
	icon_state = "modifier"

/obj/structure/machinery/big_computers/science_big/protolathe
	name = "化学品存储系统"
	desc = "用于大量化学品存储的系统，可缓慢补充。"
	icon_state = "protolathe"

/obj/structure/machinery/big_computers/science_big/operator_machine
	name = "合成模拟器"
	desc = "这台计算机使用先进算法模拟试剂属性，旨在计算合成新变体所需的配方。"
	icon_state = "operator"

/obj/structure/machinery/big_computers/science_big/operator_machine_open
	name = "合成模拟器"
	desc = "这台计算机使用先进算法模拟试剂属性，旨在计算合成新变体所需的配方。"
	icon_state = "operator_open"

/obj/structure/machinery/big_computers/science_big/medilathe
	name = "medilathe"
	desc = "一台专门用于打印医疗物品的自动制造机。"
	icon_state = "medilathe"

// Monitors

/obj/structure/prop/hybrisa/misc/machinery/screens
	name = "monitor"
	health = 50

/obj/structure/prop/hybrisa/misc/machinery/screens/bullet_act(obj/projectile/P)
	health -= P.damage
	playsound(src, 'sound/effects/metalping.ogg', 35, 1)
	..()
	healthcheck()
	return TRUE

/obj/structure/prop/hybrisa/misc/machinery/screens/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	deconstruct(FALSE)

/obj/structure/prop/hybrisa/misc/machinery/screens/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/prop/hybrisa/misc/machinery/screens/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/prop/hybrisa/misc/machinery/screens/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/prop/hybrisa/misc/machinery/screens/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/prop/hybrisa/misc/machinery/screens/frame
	icon = 'icons/obj/structures/machinery/status_display.dmi'
	icon_state = "frame"

/obj/structure/prop/hybrisa/misc/machinery/screens/security
	icon = 'icons/obj/structures/machinery/status_display.dmi'
	icon_state = "security"

/obj/structure/prop/hybrisa/misc/machinery/screens/redalert
	icon = 'icons/obj/structures/machinery/status_display.dmi'
	icon_state = "redalert_framed"

/obj/structure/prop/hybrisa/misc/machinery/screens/redalertblank
	icon = 'icons/obj/structures/machinery/status_display.dmi'
	icon_state = "redalertblank"

/obj/structure/prop/hybrisa/misc/machinery/screens/entertainment
	icon = 'icons/obj/structures/machinery/status_display.dmi'
	icon_state = "entertainment_framed"

/obj/structure/prop/hybrisa/misc/machinery/screens/telescreen
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "telescreen"

/obj/structure/prop/hybrisa/misc/machinery/screens/telescreenbroke
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "telescreenb"

/obj/structure/prop/hybrisa/misc/machinery/screens/telescreenbrokespark
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "telescreenbspark"

/obj/structure/prop/hybrisa/misc/machinery/screens/wood_clock
	icon = 'icons/obj/structures/props/furniture/clock.dmi'
	name = "clock"
	icon_state = "wood_clock"

/obj/structure/prop/hybrisa/misc/machinery/screens/gold_clock
	icon = 'icons/obj/structures/props/furniture/clock.dmi'
	name = "clock"
	icon_state = "gold_clock"

// Multi-Monitor

//Green
/obj/structure/prop/hybrisa/misc/machinery/screens/multimonitorsmall_off
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "multimonitorsmall_off"

/obj/structure/prop/hybrisa/misc/machinery/screens/multimonitorsmall_on
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "multimonitorsmall_on"

/obj/structure/prop/hybrisa/misc/machinery/screens/multimonitormedium_off
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "multimonitormedium_off"

/obj/structure/prop/hybrisa/misc/machinery/screens/multimonitormedium_on
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "multimonitormedium_on"

/obj/structure/prop/hybrisa/misc/machinery/screens/multimonitorbig_off
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "multimonitorbig_off"

/obj/structure/prop/hybrisa/misc/machinery/screens/multimonitorbig_on
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "multimonitorbig_on"

// Blue

/obj/structure/prop/hybrisa/misc/machinery/screens/bluemultimonitorsmall_off
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "bluemultimonitorsmall_off"

/obj/structure/prop/hybrisa/misc/machinery/screens/bluemultimonitorsmall_on
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "bluemultimonitorsmall_on"

/obj/structure/prop/hybrisa/misc/machinery/screens/bluemultimonitormedium_off
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "bluemultimonitormedium_off"

/obj/structure/prop/hybrisa/misc/machinery/screens/bluemultimonitormedium_on
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "bluemultimonitormedium_on"

/obj/structure/prop/hybrisa/misc/machinery/screens/bluemultimonitorbig_off
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "bluemultimonitorbig_off"

/obj/structure/prop/hybrisa/misc/machinery/screens/bluemultimonitorbig_on
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "bluemultimonitorbig_on"

// Egg
/obj/structure/prop/hybrisa/misc/machinery/screens/wallegg_off
	icon = 'icons/obj/structures/props/hybrisa/wall_egg.dmi'
	icon_state = "wallegg_off"

/obj/structure/prop/hybrisa/misc/machinery/screens/wallegg_on
	icon = 'icons/obj/structures/props/hybrisa/wall_egg.dmi'
	icon_state = "wallegg_on"

// Fake Pipes
/obj/effect/hybrisa/misc/fake/pipes
	name = "垃圾处理管道"
	icon = 'icons/obj/structures/props/hybrisa/piping_wiring.dmi'
	icon_state = "pipe-s"
	layer = WIRE_LAYER

/obj/effect/hybrisa/misc/fake/pipes/pipe1
	icon_state = "pipe-s"

/obj/effect/hybrisa/misc/fake/pipes/pipe2
	icon_state = "pipe-c"

/obj/effect/hybrisa/misc/fake/pipes/pipe3
	icon_state = "pipe-j1"

/obj/effect/hybrisa/misc/fake/pipes/pipe4
	icon_state = "pipe-y"

/obj/effect/hybrisa/misc/fake/pipes/pipe5
	icon_state = "pipe-b"

// Fake Wire

/obj/effect/hybrisa/misc/fake/wire
	name = "电源线"
	icon = 'icons/obj/structures/props/hybrisa/piping_wiring.dmi'
	icon_state = "intactred"
	layer = UNDERFLOOR_OBJ_LAYER

/obj/effect/hybrisa/misc/fake/ex_act()
	qdel(src)

/obj/effect/hybrisa/misc/fake/wire/red
	icon_state = "intactred"

/obj/effect/hybrisa/misc/fake/wire/yellow
	icon_state = "intactyellow"

/obj/effect/hybrisa/misc/fake/wire/blue
	icon_state = "intactblue"

/obj/structure/prop/hybrisa/misc/fake/heavydutywire
	name = "重型线缆"
	icon = 'icons/obj/structures/props/hybrisa/piping_wiring.dmi'
	layer = TURF_LAYER

/obj/structure/prop/hybrisa/misc/fake/heavydutywire/heavy1
	icon_state = "0-1"

/obj/structure/prop/hybrisa/misc/fake/heavydutywire/heavy2
	icon_state = "1-2"

/obj/structure/prop/hybrisa/misc/fake/heavydutywire/heavy3
	icon_state = "1-4"

/obj/structure/prop/hybrisa/misc/fake/heavydutywire/heavy4
	icon_state = "1-2-4"

/obj/structure/prop/hybrisa/misc/fake/heavydutywire/heavy5
	icon_state = "1-2-4-8"

// Lattice & 'Effect' Lattice

/obj/structure/prop/hybrisa/misc/fake/lattice
	name = "结构框架"
	icon = 'icons/obj/structures/props/hybrisa/piping_wiring.dmi'
	layer = TURF_LAYER

/obj/structure/prop/hybrisa/misc/fake/lattice/full
	icon_state = "latticefull"

/obj/effect/decal/hybrisa/lattice
	name = "结构框架"
	icon = 'icons/obj/structures/props/hybrisa/piping_wiring.dmi'
	icon_state = "latticefull"
	layer = TURF_LAYER

/obj/effect/decal/hybrisa/lattice/full
	icon_state = "latticefull"

// Cargo Containers extended

/obj/structure/cargo_container/hybrisa/containersextended
	name = "货运集装箱"
	desc = "一个货运集装箱。"
	icon = 'icons/obj/structures/props/containers/containersextended.dmi'
	icon_state = "blackwyleft"
	bound_height = 32
	bound_width = 32
	layer = ABOVE_MOB_LAYER

/obj/structure/cargo_container/hybrisa/containersextended/blueleft
	name = "货运集装箱"
	icon_state = "blueleft"

/obj/structure/cargo_container/hybrisa/containersextended/blueright
	name = "货运集装箱"
	icon_state = "blueright"

/obj/structure/cargo_container/hybrisa/containersextended/greenleft
	name = "货运集装箱"
	icon_state = "greenleft"

/obj/structure/cargo_container/hybrisa/containersextended/greenright
	name = "货运集装箱"
	icon_state = "greenright"

/obj/structure/cargo_container/hybrisa/containersextended/tanleft
	name = "货运集装箱"
	icon_state = "tanleft"

/obj/structure/cargo_container/hybrisa/containersextended/tanright
	name = "货运集装箱"
	icon_state = "tanright"

/obj/structure/cargo_container/hybrisa/containersextended/redleft
	name = "货运集装箱"
	icon_state = "redleft"

/obj/structure/cargo_container/hybrisa/containersextended/redright
	name = "货运集装箱"
	icon_state = "redright"

/obj/structure/cargo_container/hybrisa/containersextended/greywyleft
	name = "维兰德-汤谷货运集装箱"
	icon_state = "greywyleft"

/obj/structure/cargo_container/hybrisa/containersextended/greywyright
	name = "维兰德-汤谷货运集装箱"
	icon_state = "greywyright"

/obj/structure/cargo_container/hybrisa/containersextended/lightgreywyleft
	name = "维兰德-汤谷货运集装箱"
	icon_state = "lightgreywyleft"

/obj/structure/cargo_container/hybrisa/containersextended/lightgreywyright
	name = "维兰德-汤谷货运集装箱"
	icon_state = "lightgreywyright"

/obj/structure/cargo_container/hybrisa/containersextended/blackwyleft
	name = "维兰德-汤谷货运集装箱"
	icon_state = "blackwyleft"

/obj/structure/cargo_container/hybrisa/containersextended/blackwyright
	name = "维兰德-汤谷货运集装箱"
	icon_state = "blackwyright"

/obj/structure/cargo_container/hybrisa/containersextended/whitewyleft
	name = "维兰德-汤谷货运集装箱"
	icon_state = "whitewyleft"

/obj/structure/cargo_container/hybrisa/containersextended/whitewyright
	name = "维兰德-汤谷货运集装箱"
	icon_state = "whitewyright"

/obj/structure/cargo_container/hybrisa/containersextended/tanwywingsleft
	name = "货运集装箱"
	icon_state = "tanwywingsleft"

/obj/structure/cargo_container/hybrisa/containersextended/tanwywingsright
	name = "货运集装箱"
	icon_state = "tanwywingsright"

/obj/structure/cargo_container/hybrisa/containersextended/greenwywingsleft
	name = "货运集装箱"
	icon_state = "greenwywingsleft"

/obj/structure/cargo_container/hybrisa/containersextended/greenwywingsright
	name = "货运集装箱"
	icon_state = "greenwywingsright"

/obj/structure/cargo_container/hybrisa/containersextended/bluewywingsleft
	name = "货运集装箱"
	icon_state = "bluewywingsleft"

/obj/structure/cargo_container/hybrisa/containersextended/bluewywingsright
	name = "货运集装箱"
	icon_state = "bluewywingsright"

/obj/structure/cargo_container/hybrisa/containersextended/redwywingsleft
	name = "货运集装箱"
	icon_state = "redwywingsleft"

/obj/structure/cargo_container/hybrisa/containersextended/redwywingsright
	name = "货运集装箱"
	icon_state = "redwywingsright"

/obj/structure/cargo_container/hybrisa/containersextended/medicalleft
	name = "医疗货运集装箱"
	icon_state = "medicalleft"

/obj/structure/cargo_container/hybrisa/containersextended/medicalright
	name = "医疗货运集装箱"
	icon_state = "medicalright"

/obj/structure/cargo_container/hybrisa/containersextended/emptymedicalleft
	name = "医疗货运集装箱"
	icon_state = "emptymedicalleft"

/obj/structure/cargo_container/hybrisa/containersextended/emptymedicalright
	name = "医疗货运集装箱"
	icon_state = "emptymedicalright"

/obj/structure/cargo_container/hybrisa/containersextended/kelland_left
	name = "凯兰矿业公司货运集装箱"
	desc = "一个小型工业运输货柜。\n除了LV-178采矿作业的事故外，你对凯兰矿业公司了解不多。"
	icon_state = "kelland_alt_l"

/obj/structure/cargo_container/hybrisa/containersextended/kelland_right
	name = "凯兰矿业公司货运集装箱"
	desc = "一个小型工业运输货柜。\n除了LV-178采矿作业的事故外，你对凯兰矿业公司了解不多。"
	icon_state = "kelland_alt_r"

/// Fake Platforms

/obj/structure/prop/hybrisa/fakeplatforms
	name = "platform"
	desc = "一个抬高的金属平台，通常用于将区域提升到其他区域之上。你或许可以爬上去。"
	icon = 'icons/obj/structures/props/hybrisa/platforms.dmi'
	icon_state = "platform"
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE

/obj/structure/prop/hybrisa/fakeplatforms/platform1
	icon_state = "engineer_platform"

/obj/structure/prop/hybrisa/fakeplatforms/platform2
	icon = 'icons/obj/structures/props/platforms.dmi'
	icon_state = "engineer_platform_platformcorners"

/obj/structure/prop/hybrisa/fakeplatforms/platform3
	icon_state = "platform"

/obj/structure/prop/hybrisa/fakeplatforms/platform4
	icon_state = "hybrisaplatform3"

/obj/structure/prop/hybrisa/fakeplatforms/platform4/deco
	icon = 'icons/obj/structures/props/platforms.dmi'
	icon_state = "hybrisaplatform_deco3"
	name = "金属转角平台"
	desc = "一个抬高的金属平台，通常用于将区域提升到其他区域之上。你或许可以爬上去。"

/obj/structure/prop/hybrisa/fakeplatforms/platform5
	icon = 'icons/obj/structures/props/platforms.dmi'
	icon_state = "hybrisaplatform"

/obj/structure/prop/hybrisa/fakeplatforms/platform5/deco
	name = "platform"
	icon = 'icons/obj/structures/props/platforms.dmi'
	icon_state = "hybrisaplatform_deco"

// Greeblies

/obj/structure/prop/hybrisa/misc/buildinggreeblies
	name = "\improper machinery"
	icon = 'icons/obj/structures/props/hybrisa/64x64_props.dmi'
	icon_state = "buildingventbig1"
	bound_width = 64
	bound_height = 32
	density = TRUE
	health = 200
	anchored = TRUE
	layer = ABOVE_XENO_LAYER
	gender = PLURAL

/obj/structure/prop/hybrisa/misc/buildinggreeblies/bullet_act(obj/projectile/P)
	health -= P.damage
	playsound(src, 'sound/effects/metalping.ogg', 35, 1)
	..()
	healthcheck()
	return TRUE

/obj/structure/prop/hybrisa/misc/buildinggreeblies/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	deconstruct(FALSE)

/obj/structure/prop/hybrisa/misc/buildinggreeblies/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/prop/hybrisa/misc/buildinggreeblies/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/prop/hybrisa/misc/buildinggreeblies/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/prop/hybrisa/misc/buildinggreeblies/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/prop/hybrisa/misc/buildinggreeblies/greeble1
	icon_state = "buildingventbig2"

/obj/structure/prop/hybrisa/misc/buildinggreeblies/greeble2
	icon_state = "buildingventbig3"

/obj/structure/prop/hybrisa/misc/buildinggreeblies/greeble3
	icon_state = "buildingventbig4"

/obj/structure/prop/hybrisa/misc/buildinggreeblies/greeble4
	icon_state = "buildingventbig5"

/obj/structure/prop/hybrisa/misc/buildinggreeblies/greeble5
	icon_state = "buildingventbig6"

/obj/structure/prop/hybrisa/misc/buildinggreeblies/greeble6
	icon_state = "buildingventbig7"

/obj/structure/prop/hybrisa/misc/buildinggreeblies/greeble7
	icon_state = "buildingventbig8"

/obj/structure/prop/hybrisa/misc/buildinggreeblies/greeble8
	icon_state = "buildingventbig9"

/obj/structure/prop/hybrisa/misc/buildinggreeblies/greeble9
	icon_state = "buildingventbig10"

/obj/structure/prop/hybrisa/misc/buildinggreeblies/greeble10
	density = FALSE
	icon_state = "buildingventbig11"

/obj/structure/prop/hybrisa/misc/buildinggreeblies/greeble11
	density = FALSE
	icon_state = "buildingventbig12"

/obj/structure/prop/hybrisa/misc/buildinggreeblies/greeble12
	density = FALSE
	icon_state = "buildingventbig13"

/obj/structure/prop/hybrisa/misc/buildinggreebliessmall
	name = "墙壁通风口"
	icon = 'icons/obj/structures/props/hybrisa/piping_wiring.dmi'
	icon_state = "smallwallvent1"
	density = FALSE
	health = 150

/obj/structure/prop/hybrisa/misc/buildinggreebliessmall/bullet_act(obj/projectile/P)
	health -= P.damage
	playsound(src, 'sound/effects/metalping.ogg', 35, 1)
	..()
	healthcheck()
	return TRUE

/obj/structure/prop/hybrisa/misc/buildinggreebliessmall/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	deconstruct(FALSE)

/obj/structure/prop/hybrisa/misc/buildinggreebliessmall/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/prop/hybrisa/misc/buildinggreebliessmall/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/prop/hybrisa/misc/buildinggreebliessmall/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/prop/hybrisa/misc/buildinggreebliessmall/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/prop/hybrisa/misc/buildinggreebliessmall/smallvent2
	name = "墙壁通风口"
	icon_state = "smallwallvent2"

/obj/structure/prop/hybrisa/misc/buildinggreebliessmall/smallvent3
	name = "墙壁通风口"
	icon_state = "smallwallvent3"

/obj/structure/prop/hybrisa/misc/buildinggreebliessmall/computer
	name = "computer"
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "zcomputermachine"
	density = TRUE

/obj/structure/prop/hybrisa/misc/metergreen
	name = "meter"
	icon = 'icons/obj/structures/props/hybrisa/computers.dmi'
	icon_state = "biggreenmeter1"

/obj/structure/prop/hybrisa/misc/elevator_button
	name = "损坏的电梯按钮"
	icon = 'icons/obj/structures/props/hybrisa/misc_props.dmi'
	icon_state = "broken_elevator_button"

// MISC

/obj/structure/prop/hybrisa/misc/stoneplanterseats
	name = "带座混凝土花坛"
	desc = "一个带座位的装饰性混凝土花坛，座椅配有合成皮革，但已随时间褪色。"
	icon = 'icons/obj/structures/props/hybrisa/64x64_props.dmi'
	icon_state = "planterseats"
	bound_width = 32
	bound_height = 64
	density = TRUE
	health = 1500
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	projectile_coverage = 10
	throwpass = TRUE

/obj/structure/prop/hybrisa/misc/stoneplanterseats/empty
	name = "混凝土花坛"
	desc = "一个装饰性混凝土花坛。"
	icon_state = "planterempty"

/obj/structure/prop/hybrisa/misc/concretestatue
	name = "混凝土雕像"
	desc = "一座装饰性雕像，饰有维兰德-汤谷的“翅膀”标志，是一件企业粗野主义风格的艺术品。"
	icon = 'icons/obj/structures/props/hybrisa/64x64_props.dmi'
	icon_state = "concretesculpture"
	bound_width = 64
	bound_height = 64
	density = TRUE
	anchored = TRUE
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE
	layer = ABOVE_MOB_LAYER

/obj/structure/prop/hybrisa/misc/detonator
	name = "detonator"
	desc = "一个用于炸药的起爆器，已武装并准备就绪。"
	icon_state = "detonator"
	density = FALSE
	anchored = TRUE
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE
	projectile_coverage = 20
	throwpass = TRUE
	var/id = 1
	var/range = 15

/obj/structure/prop/hybrisa/misc/detonator/attack_hand(mob/user)
	for(var/obj/item/explosive/plastic/hybrisa/mining/explosive in range(range))
		if(explosive.id == id)
			var/turf/target_turf
			target_turf = get_turf(explosive.loc)
			var/datum/cause_data/temp_cause = create_cause_data(src, user)
			explosive.handle_explosion(target_turf, explosive.dir, temp_cause)

/obj/structure/prop/hybrisa/misc/firehydrant
	name = "消防栓"
	desc = "一个消防栓公共出水口，设计用于快速取水。"
	icon = 'icons/obj/structures/props/hybrisa/misc_props.dmi'
	icon_state = "firehydrant"
	density = TRUE
	anchored = TRUE
	health = 15
	projectile_coverage = 10
	throwpass = TRUE

/obj/structure/prop/hybrisa/misc/firehydrant/Initialize(mapload, ...)
	. = ..()
	AddComponent(/datum/component/shimmy_around)

/obj/structure/prop/hybrisa/misc/firehydrant/initialize_pass_flags(datum/pass_flags_container/PF)
	if(PF)
		PF.flags_can_pass_all = PASS_AROUND|PASS_OVER_THROW_ITEM|PASS_OVER_ACID_SPRAY

/obj/structure/prop/hybrisa/misc/firehydrant/bullet_act(obj/projectile/P)
	health -= P.damage
	playsound(src, 'sound/effects/metalping.ogg', 35, 1)
	..()
	healthcheck()
	return TRUE

/obj/structure/prop/hybrisa/misc/firehydrant/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	deconstruct(FALSE)

/obj/structure/prop/hybrisa/misc/firehydrant/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/prop/hybrisa/misc/firehydrant/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/prop/hybrisa/misc/firehydrant/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/prop/hybrisa/misc/firehydrant/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/prop/hybrisa/misc/pole_stump
	name = "殖民地路灯桩"
	icon = 'icons/obj/structures/props/streetlights.dmi'
	icon_state = "street_stump"
	plane = FLOOR_PLANE
	explo_proof = TRUE
	health = null

/obj/structure/prop/hybrisa/misc/pole_stump/Crossed(atom/movable/crosser)
	. = ..()
	if(ishuman(crosser) && prob(10))
		var/mob/living/carbon/human/crossing_human = crosser
		crossing_human.visible_message(SPAN_DANGER("[crossing_human]被[src]绊倒，摔倒在地。"))
		playsound(loc, 'sound/weapons/alien_knockdown.ogg', 25, 1)
		crossing_human.KnockDown(0.5)

/obj/structure/prop/hybrisa/misc/pole_stump/traffic
	name = "殖民地路灯桩"
	icon = 'icons/obj/structures/props/streetlights.dmi'
	icon_state = "trafficlight_stump"

// Sofa Black

/obj/structure/bed/sofa/hybrisa/sofa/black
	name = "沙发"
	desc = "正如太空宜家所期望的那样。"
	icon_state = "sofa_black"
	anchored = TRUE
	can_buckle = FALSE

// Sofa Red

/obj/structure/bed/sofa/hybrisa/sofa/red
	name = "沙发"
	desc = "正如太空宜家所期望的那样。"
	icon_state = "sofa_red"
	anchored = TRUE
	can_buckle = FALSE

/obj/structure/prop/hybrisa/misc/pole
	name = "pole"
	desc = "满足你所有与“杆子”相关的活动需求。"
	icon = 'icons/obj/structures/props/hybrisa/64x64_props.dmi'
	icon_state = "pole"
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = TRUE
	density = TRUE
	anchored = TRUE
	projectile_coverage = 20
	throwpass = TRUE
	layer = BILLBOARD_LAYER

/obj/structure/prop/hybrisa/misc/pole/Initialize(mapload, ...)
	. = ..()
	AddComponent(/datum/component/shimmy_around)

/obj/structure/prop/hybrisa/misc/pole/initialize_pass_flags(datum/pass_flags_container/PF)
	if(PF)
		PF.flags_can_pass_all = PASS_HIGH_OVER_ONLY|PASS_AROUND|PASS_OVER_THROW_ITEM|PASS_OVER_ACID_SPRAY

/obj/structure/bed/sofa/hybrisa/misc/bench
	name = "bench"
	desc = "一个金属框架，配有合成皮革座椅，但皮革已经随时间褪色。"
	icon = 'icons/obj/structures/props/hybrisa/64x64_props.dmi'
	icon_state = "seatedbench"
	bound_width = 32
	bound_height = 64
	layer = BELOW_MOB_LAYER
	density = FALSE
	anchored = TRUE

// Phonebox Prop (Doesn't actually work as a locker)

/obj/structure/prop/hybrisa/misc/phonebox
	name = "损毁的电话亭"
	desc = "这是一个电话亭，技术过时但可靠。用于在整个殖民地及相连的殖民地之间进行无干扰通信。它似乎完全损毁了，玻璃被砸碎，躲在里面毫无意义。"
	icon = 'icons/obj/structures/props/phonebox.dmi'
	icon_state = "phonebox_off_broken"
	layer = ABOVE_MOB_LAYER
	bound_width = 32
	bound_height = 32
	density = TRUE
	anchored = TRUE

/obj/structure/prop/hybrisa/misc/phonebox/bloody
	name = "损毁的电话亭"
	desc = "这是一个电话亭，技术过时但可靠。用于在整个殖民地及相连的殖民地之间进行无干扰通信。它似乎完全损毁了，沾满血迹，玻璃也被砸碎。躲在里面毫无意义。"
	icon_state = "phonebox_bloody_off_broken"

/obj/structure/prop/hybrisa/misc/phonebox/bullet_act(obj/projectile/P)
	health -= P.damage
	playsound(src, 'sound/effects/metalping.ogg', 35, 1)
	..()
	healthcheck()
	return TRUE

/obj/structure/prop/hybrisa/misc/phonebox/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	deconstruct(FALSE)

/obj/structure/prop/hybrisa/misc/phonebox/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/prop/hybrisa/misc/phonebox/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/prop/hybrisa/misc/phonebox/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/Glasshit.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/prop/hybrisa/misc/phonebox/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/Glasshit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴猛击 [src]！"),
		SPAN_DANGER("We smash [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/prop/hybrisa/misc/urinal
	name = "urinal"
	desc = "一个小便池。"
	icon = 'icons/obj/structures/props/watercloset.dmi'
	icon_state = "small_urinal"
	density = FALSE
	anchored = TRUE

/obj/structure/prop/hybrisa/misc/urinal/dark
	icon_state = "small_urinal_dark"

/obj/effect/decal/hybrisa/deco_edging
	name = "装饰性混凝土边饰"
	desc = "用于装饰边界的边饰，非常别致。"
	icon = 'icons/obj/structures/props/hybrisa/platforms.dmi'
	icon_state = "stone_edging"
	density = FALSE
	anchored = TRUE
	layer = TURF_LAYER

/obj/effect/decal/hybrisa/deco_edging/corner
	icon = 'icons/obj/structures/props/hybrisa/platforms.dmi'
	icon_state = "stone_edging_deco"
	density = FALSE
	anchored = TRUE

// Signs

/obj/structure/roof/hybrisa/signs
	name = "霓虹灯招牌"
	icon = 'icons/obj/structures/props/wall_decorations/hybrisa64x64_signs.dmi'
	icon_state = "jacksopen_on"
	bound_height = 64
	bound_width = 64
	layer = BILLBOARD_LAYER
	health = 100

/obj/structure/roof/hybrisa/signs/bullet_act(obj/projectile/P)
	health -= P.damage
	playsound(src, 'sound/effects/metalping.ogg', 35, 1)
	..()
	healthcheck()
	return TRUE

/obj/structure/roof/hybrisa/signs/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	deconstruct(FALSE)

/obj/structure/roof/hybrisa/signs/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/roof/hybrisa/signs/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/roof/hybrisa/signs/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/roof/hybrisa/signs/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/roof/hybrisa/signs/casniosign
	name = "赌场招牌"
	icon_state = "nightgoldcasinoopen_on"

/obj/structure/roof/hybrisa/signs/jackssign
	name = "杰克军品店招牌"
	icon_state = "jacksopen_on"

/obj/structure/roof/hybrisa/signs/opensign
	name = "营业中招牌"
	icon_state = "open_on"

/obj/structure/roof/hybrisa/signs/opensign2
	name = "营业中招牌"
	icon_state = "open_on2"

/obj/structure/roof/hybrisa/signs/pizzasign
	name = "披萨店招牌"
	icon_state = "pizzaneon_on"

/obj/structure/roof/hybrisa/signs/weymartsign
	name = "维玛特超市招牌"
	icon_state = "weymartsign2"

/obj/structure/roof/hybrisa/signs/mechanicsign
	name = "修车厂招牌"
	icon_state = "mechanicopen_on2"

/obj/structure/roof/hybrisa/signs/cuppajoessign
	name = "乔氏咖啡招牌"
	icon_state = "cuppajoes"

/obj/structure/roof/hybrisa/signs/barsign
	name = "酒吧招牌"
	icon_state = "barsign_on"

/obj/structure/roof/hybrisa/signs/miscsign
	name = "sign"
	icon_state = "misc_on"

/obj/structure/roof/hybrisa/signs/miscvertsign
	name = "sign"
	icon_state = "miscvert_on"

/obj/structure/roof/hybrisa/signs/miscvert2sign
	name = "sign"
	icon_state = "miscvert2_on"

/obj/structure/roof/hybrisa/signs/miscvert3sign
	name = "sign"
	icon_state = "miscvert3_on"

/obj/structure/roof/hybrisa/signs/miscvert4sign
	name = "sign"
	icon_state = "miscvert4_on"

/obj/structure/roof/hybrisa/signs/miscvert5sign
	name = "sign"
	icon_state = "miscvert5_on"

/obj/structure/roof/hybrisa/signs/miscvert6sign
	name = "sign"
	icon_state = "miscvert6_on"

/obj/structure/roof/hybrisa/signs/miscvert7sign
	name = "sign"
	icon_state = "miscvert7_on"

/obj/structure/roof/hybrisa/signs/cafesign
	name = "咖啡馆招牌"
	icon_state = "cafe_on"

/obj/structure/roof/hybrisa/signs/cafealtsign
	name = "咖啡馆招牌"
	icon_state = "cafealt_on"

/obj/structure/roof/hybrisa/signs/coffeesign
	name = "咖啡店招牌"
	icon_state = "coffee_on"

/obj/structure/roof/hybrisa/signs/arcadesign
	name = "街机厅招牌"
	icon_state = "arcade_on"

/obj/structure/roof/hybrisa/signs/hotelsign
	name = "旅馆招牌"
	icon_state = "hotel_on"

/obj/structure/roof/hybrisa/signs/casinolights
	name = "霓虹灯招牌"
	icon_state = "casinolights_on"

/obj/structure/roof/hybrisa/signs/pharmacy_sign
	name = "药店招牌"
	icon_state = "pharmacy_on"

// Small Sign

/obj/structure/prop/hybrisa/signs/high_voltage
	name = "警告标志"
	desc = null
	icon = 'icons/obj/structures/props/wall_decorations/decals.dmi'
	icon_state = "shockyBig"
	layer = WALL_OBJ_LAYER

/obj/structure/prop/hybrisa/signs/high_voltage/small
	name = "警告标志"
	desc = null
	icon_state = "shockyTiny"
	layer = WALL_OBJ_LAYER

// Billboards, Signs and Posters

/// Alien Isolation - posters used as reference (direct downscale of the image for some) If anyone wants to name the billboards individually ///

/obj/structure/roof/hybrisa/billboardsandsigns
	name = "billboard"
	desc = "一块广告牌。"
	icon = 'icons/obj/structures/props/wall_decorations/32x64_hybrisabillboards.dmi'
	icon_state = "billboard_bigger"
	health = 150
	bound_width = 64
	bound_height = 32
	density = FALSE
	anchored = TRUE

/obj/structure/roof/hybrisa/billboardsandsigns/bullet_act(obj/projectile/P)
	health -= P.damage
	playsound(src, 'sound/effects/metalping.ogg', 35, 1)
	..()
	healthcheck()
	return TRUE

/obj/structure/roof/hybrisa/billboardsandsigns/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	deconstruct(FALSE)

/obj/structure/roof/hybrisa/billboardsandsigns/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/roof/hybrisa/billboardsandsigns/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/roof/hybrisa/billboardsandsigns/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/roof/hybrisa/billboardsandsigns/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/roof/hybrisa/billboardsandsigns/bigbillboards
	icon_state = "billboard_bigger"

/obj/structure/roof/hybrisa/billboardsandsigns/billboardsmedium/billboard1
	icon_state = "billboard1"

/obj/structure/roof/hybrisa/billboardsandsigns/billboardsmedium/billboard2
	icon_state = "billboard2"

/obj/structure/roof/hybrisa/billboardsandsigns/billboardsmedium/billboard3
	icon_state = "billboard3"

/obj/structure/roof/hybrisa/billboardsandsigns/billboardsmedium/billboard4
	icon_state = "billboard4"

/obj/structure/roof/hybrisa/billboardsandsigns/billboardsmedium/billboard5
	icon_state = "billboard5"

// Big Road Signs

/obj/structure/roof/hybrisa/billboardsandsigns/bigroadsigns
	name = "路标"
	desc = "一个路标。"
	icon = 'icons/obj/structures/props/hybrisa/64x64_props.dmi'
	icon_state = "roadsign_1"
	bound_width = 64
	bound_height = 32
	density = FALSE
	anchored = TRUE
	layer = BILLBOARD_LAYER

/obj/structure/roof/hybrisa/billboardsandsigns/bigroadsigns/road_sign_1
	icon_state = "roadsign_1"

/obj/structure/roof/hybrisa/billboardsandsigns/bigroadsigns/road_sign_2
	icon_state = "roadsign_2"

// Car Factory

/obj/structure/prop/hybrisa/factory
	icon = 'icons/obj/structures/props/industrial/factory.dmi'
	icon_state = "factory_roboticarm"

/obj/structure/prop/hybrisa/factory/robotic_arm
	name = "机械臂"
	desc = "一种坚固的机械臂，用于包括装配和包装在内的多种机械流程。"
	icon_state = "factory_roboticarm"
	bound_width = 32
	anchored = TRUE
	health = 100
	layer = BIG_XENO_LAYER
	density = TRUE

/obj/structure/prop/hybrisa/factory/robotic_arm/flipped
	icon_state = "factory_roboticarm2"
	layer = ABOVE_MOB_LAYER

/obj/structure/prop/hybrisa/factory/bullet_act(obj/projectile/P)
	health -= P.damage
	playsound(src, 'sound/effects/metalping.ogg', 35, 1)
	..()
	healthcheck()
	return TRUE

/obj/structure/prop/hybrisa/factory/proc/explode()
	visible_message(SPAN_DANGER("[src]碎裂了！"), max_distance = 1)
	deconstruct(FALSE)

/obj/structure/prop/hybrisa/factory/proc/healthcheck()
	if(health <= 0)
		explode()

/obj/structure/prop/hybrisa/factory/ex_act(severity)
	switch(severity)
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if(prob(50))
				deconstruct(FALSE)
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)

/obj/structure/prop/hybrisa/factory/attack_alien(mob/living/carbon/xenomorph/current_xenomorph)
	if(unslashable)
		return XENO_NO_DELAY_ACTION
	current_xenomorph.animation_attack_on(src)
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	current_xenomorph.visible_message(SPAN_DANGER("[current_xenomorph] 挥爪攻击 [src]！"),
	SPAN_DANGER("You slash at [src]!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	update_health(rand(current_xenomorph.melee_damage_lower, current_xenomorph.melee_damage_upper))
	return XENO_ATTACK_ACTION

/obj/structure/prop/hybrisa/factory/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/prop/hybrisa/factory/conveyor_belt
	name = "大型传送带"
	desc = "工业工厂中使用的大型传送带。"
	icon_state = "factory_conveyer"
	density = FALSE
	health = 25

// Hybrisa Lattice

/obj/structure/roof/hybrisa/lattice_prop
	name = "lattice"
	desc = "一个支撑框架。"
	icon = 'icons/obj/structures/props/industrial/hybrisa_lattice.dmi'
	icon_state = "lattice1"
	density = FALSE
	layer = ABOVE_XENO_LAYER
	health = 1000

/obj/structure/roof/hybrisa/lattice_prop/lattice_1
	icon_state = "lattice1"
/obj/structure/roof/hybrisa/lattice_prop/lattice_2
	icon_state = "lattice2"
/obj/structure/roof/hybrisa/lattice_prop/lattice_3
	icon_state = "lattice3"
/obj/structure/roof/hybrisa/lattice_prop/lattice_4
	icon_state = "lattice4"
/obj/structure/roof/hybrisa/lattice_prop/lattice_5
	icon_state = "lattice5"
/obj/structure/roof/hybrisa/lattice_prop/lattice_6
	icon_state = "lattice6"
