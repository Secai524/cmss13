// Tank interior stuff

// Wall
/obj/structure/interior_wall/tank
	name = "\improper tank interior wall"
	icon = 'icons/obj/vehicles/interiors/tank.dmi'
	icon_state = "wall"

// Props
/obj/structure/prop/tank
	name = "坦克机械装置"
	mouse_opacity = FALSE
	density = TRUE

	unacidable = TRUE
	unslashable = TRUE
	explo_proof = TRUE

	icon = 'icons/obj/vehicles/interiors/tank.dmi'
	icon_state = "prop0"

// Hatch
/obj/structure/interior_exit/vehicle/tank
	name = "坦克舱盖"
	icon = 'icons/obj/vehicles/interiors/tank.dmi'
	icon_state = "hatch"

