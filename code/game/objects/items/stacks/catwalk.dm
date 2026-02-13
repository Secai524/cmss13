/obj/item/stack/catwalk
	name = "步道网格"
	singular_name = "步道网格"
	desc = "这可以当作相当不错的投掷武器。"
	icon = 'icons/turf/almayer.dmi'
	icon_state = "catwalk_tile"
	w_class = SIZE_MEDIUM
	force = 6
	throwforce = 8
	throw_speed = SPEED_VERY_FAST
	throw_range = 6
	flags_atom = FPRINT|CONDUCT
	max_amount = 60
	stack_id = "catwalk"

	var/turf_type = /turf/open/floor/plating/plating_catwalk

/obj/item/stack/catwalk/Initialize(mapload, amount, new_turf_type)
	. = ..()
	if(new_turf_type)
		set_turf_type(new_turf_type)

/obj/item/stack/catwalk/proc/set_turf_type(new_turf_type)
	var/turf/open/floor/floor_type = new_turf_type
	name = "[initial(floor_type.name)]地砖"
	singular_name = name
	turf_type = new_turf_type
	stack_id = name

/obj/item/stack/catwalk/proc/build(turf/build_turf)
	build_turf.ChangeTurf(turf_type)
