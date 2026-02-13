/* Diffrent misc types of tiles
 * Contains:
 * Grass
 * Wood
 * Carpet
 */

/obj/item/stack/tile
	name = "抽象地砖"
	singular_name = "抽象地砖"
	desc = "如果你看到这个，说明开发者犯了个错误。请在Github上报告。"
	icon = 'icons/obj/items/floor_tiles.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/construction_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/construction_righthand.dmi',
	)
	item_state = "tile"
	w_class = SIZE_MEDIUM
	force = 1
	throwforce = 1
	throw_speed = SPEED_VERY_FAST
	throw_range = 20
	max_amount = 60
	stack_id = "抽象地砖"

	var/turf_type = /turf/open/floor/plating

/obj/item/stack/tile/Initialize(mapload, amount, new_turf_type)
	. = ..()
	if(new_turf_type)
		set_turf_type(new_turf_type)

/obj/item/stack/tile/proc/set_turf_type(new_turf_type)
	var/turf/open/floor/floor_type = new_turf_type
	name = "[initial(floor_type.name)]地砖"
	singular_name = name
	turf_type = new_turf_type
	stack_id = name

/obj/item/stack/tile/proc/build(turf/build_turf)
	build_turf.ChangeTurf(turf_type)

/obj/item/stack/tile/plasteel
	name = "地板砖"
	singular_name = "地板砖"
	desc = "这可以当作相当不错的投掷武器。"
	icon_state = "tile"
	w_class = SIZE_MEDIUM
	force = 6
	matter = list("metal" = 937.5)
	throwforce = 8
	throw_speed = SPEED_VERY_FAST
	throw_range = 6
	flags_atom = FPRINT|CONDUCT
	max_amount = 60
	stack_id = "地板砖"
	turf_type = null

/obj/item/stack/tile/plasteel/Initialize(mapload, amount)
	. = ..()
	src.pixel_x = rand(1, 14)
	src.pixel_y = rand(1, 14)

/obj/item/stack/tile/plasteel/build(turf/build_turf)
	build_turf.ChangeTurf(turf_type || /turf/open/floor)

/*
 * Grass
 */
/obj/item/stack/tile/grass
	name = "草皮地砖"
	desc = "一块草皮，就像高尔夫球场上常用的那种。"
	singular_name = "草皮地砖"
	icon_state = "tile_grass"
	stack_id = "草皮地砖"
	turf_type = /turf/open/floor/grass


/*
 * Wood
 */
/obj/item/stack/tile/wood
	name = "木地板砖"
	desc = "一种易于安装的木地板砖。"
	singular_name = "木地板砖"
	icon_state = "tile-wood"
	stack_id = "木地板砖"
	turf_type = /turf/open/floor/wood

/obj/item/stack/tile/wood/fake
	name = "仿木地板砖"
	desc = "看起来像木头。摸起来像金属。"
	singular_name = "仿木地板砖"
	stack_id = "仿木地板砖"
	turf_type = /turf/open/floor/wood/ship

/*
 * Carpets
 */
/obj/item/stack/tile/carpet
	name = "地毯砖"
	desc = "一块地毯。尺寸与标准地板砖相同！"
	singular_name = "地毯砖"
	icon_state = "tile-carpet"
	stack_id = "地毯砖"
	turf_type = /turf/open/floor/carpet
