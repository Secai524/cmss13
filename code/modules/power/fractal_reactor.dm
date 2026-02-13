// ###############################################################################
// # ITEM: FRACTAL ENERGY REACTOR #
// # FUNCTION: Generate infinite electricity. Used for map testing.   #
// ###############################################################################

/obj/structure/machinery/power/fractal_reactor
	name = "分形能量反应堆"
	desc = "这东西从分形子空间汲取能量。（调试物品：用于地图测试的无限电源。如果发现请联系开发者。）"
	icon = 'icons/obj/structures/machinery/power.dmi'
	icon_state = "bbox_on"
	anchored = TRUE
	density = TRUE
	directwired = 1
	var/power_generation_rate = 2000000 //Defaults to 2MW of power. Should be enough to run SMES charging on full 2 times.
	var/powernet_connection_failed = 0
	power_machine = TRUE

	// This should be only used on Dev for testing purposes.
/obj/structure/machinery/power/fractal_reactor/New()
	..()
	to_world("<b>\red WARNING: \black Map testing power source activated at: X:[src.loc.x] Y:[src.loc.y] Z:[src.loc.z]</b>")
	start_processing()

/obj/structure/machinery/power/fractal_reactor/power_change()
	return

/obj/structure/machinery/power/fractal_reactor/process()
	if(!powernet && !powernet_connection_failed)
		if(!connect_to_network())
			powernet_connection_failed = 1
			spawn(150) // Error! Check again in 15 seconds.
				powernet_connection_failed = 0
	add_avail(power_generation_rate)
