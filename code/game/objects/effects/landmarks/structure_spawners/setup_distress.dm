/// Distress Signal Global Setup Structure spawners
/obj/effect/landmark/structure_spawner/setup/distress
	name = "抽象求救信号生成器"
	mode_flags = MODE_INFESTATION

/obj/effect/landmark/structure_spawner/setup/distress/xeno_wall
	name = "求救信号异形墙壁生成器"
	icon_state = "wall"
	path_to_spawn = /turf/closed/wall/resin
	is_turf = TRUE

/obj/effect/landmark/structure_spawner/setup/distress/xeno_membrane
	name = "求救信号异形薄膜生成器"
	icon_state = "membrane"
	path_to_spawn = /turf/closed/wall/resin/membrane
	is_turf = TRUE

/obj/effect/landmark/structure_spawner/setup/distress/xeno_door
	name = "求救信号异形门生成器"
	icon_state = "door"
	path_to_spawn = /obj/structure/mineral_door/resin

/obj/effect/landmark/structure_spawner/setup/distress/xeno_nest
	name = "求救信号异形巢穴生成器"
	icon_state = "nest"
	path_to_spawn = /obj/structure/bed/nest

/obj/effect/landmark/structure_spawner/setup/distress/xeno_weed_node
	name = "求救信号异形菌毯节点生成器"
	icon_state = "weednode"
	path_to_spawn = /obj/effect/alien/weeds/node
