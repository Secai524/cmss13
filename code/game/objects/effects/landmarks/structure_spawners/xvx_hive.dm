/// XvX Hive Spawn Structures, spawning alongside a queen in the same area
/obj/effect/landmark/structure_spawner/xvx_hive
	name = "抽象异形对战巢穴生成器"
	mode_flags = MODE_XVX
	color = "#c9a9c2"

/obj/effect/landmark/structure_spawner/xvx_hive/xeno_wall
	name = "异形对战巢穴墙壁生成器"
	icon_state = "wall"
	path_to_spawn = /turf/closed/wall/resin
	is_turf = TRUE

/obj/effect/landmark/structure_spawner/xvx_hive/xeno_membrane
	name = "异形对战巢穴薄膜生成器"
	icon_state = "membrane"
	path_to_spawn = /turf/closed/wall/resin/membrane
	is_turf = TRUE

/obj/effect/landmark/structure_spawner/xvx_hive/xeno_door
	name = "异形对战巢穴门生成器"
	icon_state = "door"
	path_to_spawn = /obj/structure/mineral_door/resin

/obj/effect/landmark/structure_spawner/xvx_hive/xeno_nest
	name = "异形对战巢穴巢穴生成器"
	icon_state = "nest"
	path_to_spawn = /obj/structure/bed/nest

/obj/effect/landmark/structure_spawner/xvx_hive/xeno_core
	name = "异形对战巢穴核心生成器"
	icon_state = "core"
	path_to_spawn = /obj/effect/alien/resin/special/pylon/core
