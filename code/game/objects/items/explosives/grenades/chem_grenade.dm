/obj/item/explosive/grenade/custom
	name = "定制手榴弹"
	icon_state = "grenade_custom"
	desc = "一枚采用M40外壳的定制化学手榴弹。这款设计用于适配下挂式榴弹发射器，但也可手投。"
	w_class = SIZE_SMALL
	force = 2
	dangerous = TRUE
	customizable = TRUE
	underslug_launchable = TRUE
	allowed_sensors = list(/obj/item/device/assembly/timer)
	max_container_volume = 120
	matter = list("metal" = 4250)
	has_blast_wave_dampener = TRUE

/obj/item/explosive/grenade/custom/prime()
	overlays.Cut()
	..()

/obj/item/explosive/grenade/custom/large
	name = "大型定制手榴弹"
	desc = "一枚采用M15外壳的定制化学手榴弹。该外壳比M40型号具有更高的爆炸容量。"
	icon_state = "large_grenade_custom"
	allowed_containers = list(/obj/item/reagent_container/glass)
	max_container_volume = 180
	reaction_limits = list( "max_ex_power" = 220, "base_ex_falloff" = 120, "max_ex_shards" = 80,
							"max_fire_rad" = 6, "max_fire_int" = 30, "max_fire_dur" = 32,
							"min_fire_rad" = 1, "min_fire_int" = 3, "min_fire_dur" = 3
	)
	underslug_launchable = FALSE
	has_blast_wave_dampener = TRUE
	w_class = SIZE_MEDIUM
	matter = list("metal" = 7000)


/obj/item/explosive/grenade/custom/metal_foam
	name = "金属泡沫手榴弹"
	desc = "用于紧急封堵空气泄漏。"
	assembly_stage = ASSEMBLY_LOCKED
	harmful = FALSE
	has_blast_wave_dampener = FALSE
	antigrief_protection = FALSE

/obj/item/explosive/grenade/custom/metal_foam/Initialize()
	. = ..()
	var/obj/item/reagent_container/glass/beaker/B1 = new(src)
	var/obj/item/reagent_container/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent("aluminum", 30)
	B2.reagents.add_reagent("foaming_agent", 10)
	B2.reagents.add_reagent("pacid", 10)

	detonator = new/obj/item/device/assembly_holder/timer_igniter(src)

	containers += B1
	containers += B2
	update_icon()

/obj/item/explosive/grenade/custom/incendiary
	name = "燃烧手榴弹"
	desc = "用于清除房间内的生物。"
	assembly_stage = ASSEMBLY_LOCKED
	has_blast_wave_dampener = FALSE

/obj/item/explosive/grenade/custom/incendiary/Initialize()
	. = ..()
	var/obj/item/reagent_container/glass/beaker/B1 = new(src)
	var/obj/item/reagent_container/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent("aluminum", 15)
	B1.reagents.add_reagent("fuel",20)
	B2.reagents.add_reagent("phoron", 15)
	B2.reagents.add_reagent("sulphuric acid", 15)
	B1.reagents.add_reagent("fuel",20)

	detonator = new/obj/item/device/assembly_holder/timer_igniter(src)

	containers += B1
	containers += B2
	update_icon()

/obj/item/explosive/grenade/custom/flare
	name = "\improper M40-F flare grenade"
	desc = "手榴弹形式的化学照明弹，设计用于兼容大多数标准配发发射器。"
	assembly_stage = ASSEMBLY_LOCKED
	has_blast_wave_dampener = FALSE
	antigrief_protection = FALSE

/obj/item/explosive/grenade/custom/flare/Initialize()
	. = ..()
	var/obj/item/reagent_container/glass/beaker/vial/V1 = new(src)
	var/obj/item/reagent_container/glass/beaker/vial/V2 = new(src)
	var/obj/item/reagent_container/glass/beaker/vial/V3 = new(src)

	V1.reagents.add_reagent("aluminum", 30)
	V2.reagents.add_reagent("potassium", 30)
	V3.reagents.add_reagent("sulfur", 30)

	detonator = new/obj/item/device/assembly_holder/timer_igniter(src)

	containers += V1
	containers += V2
	containers += V3
	update_icon()

/obj/item/explosive/grenade/custom/large/flare
	name = "\improper M15-F flare grenade"
	desc = "手榴弹形式的化学照明弹，扩展型号。外壳过大，无法适配大多数发射器。"
	assembly_stage = ASSEMBLY_LOCKED
	has_blast_wave_dampener = FALSE
	antigrief_protection = FALSE

/obj/item/explosive/grenade/custom/large/flare/Initialize()
	. = ..()
	var/obj/item/reagent_container/glass/beaker/B1 = new(src)
	var/obj/item/reagent_container/glass/beaker/B2 = new(src)
	var/obj/item/reagent_container/glass/beaker/B3 = new(src)

	B1.reagents.add_reagent("aluminum", 60)
	B2.reagents.add_reagent("potassium", 60)
	B3.reagents.add_reagent("sulfur", 60)

	detonator = new/obj/item/device/assembly_holder/timer_igniter(src)

	containers += B1
	containers += B2
	containers += B3
	update_icon()


/obj/item/explosive/grenade/custom/cleaner
	name = "清洁手榴弹"
	desc = "BLAM!牌泡沫太空清洁剂。采用特殊施放器，用于快速清洁大面积区域。"
	assembly_stage = ASSEMBLY_LOCKED
	harmful = FALSE
	has_blast_wave_dampener = FALSE
	antigrief_protection = FALSE

/obj/item/explosive/grenade/custom/cleaner/Initialize()
	. = ..()
	var/obj/item/reagent_container/glass/beaker/B1 = new(src)
	var/obj/item/reagent_container/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent("fluorosurfactant", 40)
	B2.reagents.add_reagent("water", 40)
	B2.reagents.add_reagent("cleaner", 10)

	detonator = new/obj/item/device/assembly_holder/timer_igniter(src)

	containers += B1
	containers += B2
	update_icon()




/obj/item/explosive/grenade/custom/teargas
	name = "\improper M66 teargas grenade"
	desc = "用于非致命性防暴的催泪瓦斯手榴弹。请穿戴足够的防毒装备。"
	assembly_stage = ASSEMBLY_LOCKED
	harmful = FALSE
	has_blast_wave_dampener = FALSE
	antigrief_protection = FALSE

/obj/item/explosive/grenade/custom/teargas/Initialize()
	if(type == /obj/item/explosive/grenade/custom/teargas) // ugly but we only want to change base level teargas
		if(SSticker.mode && MODE_HAS_FLAG(MODE_FACTION_CLASH))
			new /obj/item/explosive/grenade/flashbang/noskill(loc)
			return INITIALIZE_HINT_QDEL
		else if(SSticker.current_state < GAME_STATE_PLAYING)
			RegisterSignal(SSdcs, COMSIG_GLOB_MODE_PRESETUP, PROC_REF(replace_teargas))
	. = ..()
	var/obj/item/reagent_container/glass/beaker/B1 = new(src)
	var/obj/item/reagent_container/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent("condensedcapsaicin", 25)
	B1.reagents.add_reagent("potassium", 25)
	B2.reagents.add_reagent("phosphorus", 25)
	B2.reagents.add_reagent("sugar", 25)

	detonator = new/obj/item/device/assembly_holder/timer_igniter(src, 4 SECONDS) //~4 second timer

	containers += B1
	containers += B2

	update_icon()

/obj/item/explosive/grenade/custom/teargas/proc/replace_teargas()
	if(MODE_HAS_FLAG(MODE_FACTION_CLASH))
		new /obj/item/explosive/grenade/flashbang/noskill(loc)
		qdel(src)
	UnregisterSignal(SSdcs, COMSIG_GLOB_MODE_PRESETUP)


/obj/item/explosive/grenade/custom/teargas/attack_self(mob/user)
	if(!skillcheck(user, SKILL_POLICE, SKILL_POLICE_SKILLED))
		to_chat(user, SPAN_WARNING("你似乎不知道如何使用 [src]..."))
		return
	..()


/obj/item/explosive/grenade/custom/ied
	name = "简易爆炸装置"
	desc = "一种简易化学爆炸手榴弹。设计通过破片杀伤。"
	assembly_stage = ASSEMBLY_LOCKED
	has_blast_wave_dampener = FALSE

/obj/item/explosive/grenade/custom/ied/Initialize()
	. = ..()
	var/obj/item/reagent_container/glass/beaker/B1 = new(src)
	var/obj/item/reagent_container/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent("potassium", 20)
	B1.reagents.add_reagent("iron", 40)
	B2.reagents.add_reagent("water", 20)
	B2.reagents.add_reagent("iron", 40)

	detonator = new/obj/item/device/assembly_holder/timer_igniter(src, 2) //~4 second timer

	containers += B1
	containers += B2

	update_icon()


/obj/item/explosive/grenade/custom/ied_incendiary
	name = "简易爆炸装置（燃烧型）"
	desc = "一种简易化学爆炸手榴弹。设计用于在大片区域喷洒燃烧破片。"
	assembly_stage = ASSEMBLY_LOCKED
	has_blast_wave_dampener = FALSE

/obj/item/explosive/grenade/custom/ied_incendiary/Initialize()
	. = ..()
	var/obj/item/reagent_container/glass/beaker/B1 = new(src)
	var/obj/item/reagent_container/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent("potassium", 20)
	B1.reagents.add_reagent("iron", 40)
	B2.reagents.add_reagent("water", 20)
	B2.reagents.add_reagent("iron", 30)
	B2.reagents.add_reagent("phoron", 10)

	detonator = new/obj/item/device/assembly_holder/timer_igniter(src, 2) //~4 second timer

	containers += B1
	containers += B2

	update_icon()
