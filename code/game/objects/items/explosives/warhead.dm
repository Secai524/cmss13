/obj/item/explosive/warhead
	icon = 'icons/obj/items/weapons/grenade.dmi'
	customizable = TRUE
	allowed_sensors = list() //We only need a detonator
	ground_offset_x = 7
	ground_offset_y = 6

/obj/item/explosive/warhead/rocket
	name = "84毫米火箭弹头"
	desc = "一种为84毫米火箭弹定制的弹头。"
	icon_state = "warhead_rocket"
	max_container_volume = 210
	allow_star_shape = FALSE
	shrapnel_spread = 90
	matter = list("metal" = 11250) //3 sheets
	reaction_limits = list( "max_ex_power" = 220, "base_ex_falloff" = 160,"max_ex_shards" = 80,
							"max_fire_rad" = 4, "max_fire_int" = 45, "max_fire_dur" = 48,
							"min_fire_rad" = 2, "min_fire_int" = 4, "min_fire_dur" = 5
	)
	has_blast_wave_dampener = TRUE

/obj/item/explosive/warhead/mortar
	name = "80毫米迫击炮弹头"
	desc = "一种为80毫米迫击炮弹定制的弹头。"
	icon_state = "warhead_mortar"
	max_container_volume = 240
	matter = list("metal" = 11250) //3 sheets
	reaction_limits = list( "max_ex_power" = 360, "base_ex_falloff" = 130, "max_ex_shards" = 200,
							"max_fire_rad" = 8, "max_fire_int" = 45, "max_fire_dur" = 48,
							"min_fire_rad" = 3, "min_fire_int" = 5, "min_fire_dur" = 5
	)
	has_blast_wave_dampener = TRUE
	var/has_camera = FALSE

/obj/item/explosive/warhead/mortar/camera
	name = "80毫米迫击炮摄像弹头"
	desc = "为80毫米迫击炮弹设计的定制弹头。包含摄像无人机。"
	max_container_volume = 180
	matter = list("metal" = 15000) //4 sheets
	has_camera = TRUE
