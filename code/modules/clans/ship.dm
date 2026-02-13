/obj/effect/landmark/clan_spawn
	name = "氏族出生点"
	icon_state = "clan_spawn"

/obj/effect/landmark/clan_spawn/New()
	. = ..()
	SSpredships.init_spawnpoint(src)
	qdel(src)
