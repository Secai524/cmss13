
//Terrified pizza delivery
/datum/emergency_call/pizza
	name = "披萨配送"
	mob_max = 1
	mob_min = 1
	arrival_message = "'That'll be... sixteen orders of cheesy fries, eight large double topping pizzas, nine bottles of Four Loko... hello? Is anyone on this ship? Your pizzas are getting cold.'"
	shuttle_id = MOBILE_SHUTTLE_ID_ERT_SMALL
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pizza
	home_base = /datum/lazy_template/ert/pizza_station
	probability = 2

/datum/emergency_call/pizza/New()
	. = ..()
	objectives = "Make sure you get a tip!"

/datum/emergency_call/pizza/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/H = new(spawn_loc)
	M.transfer_to(H, TRUE)

	arm_equipment(H, /datum/equipment_preset/other/pizza, TRUE, TRUE)

	var/pizzatxt = pick("Discount Pizza","Pizza Kingdom","Papa Pizza", "披萨银河")
	to_chat(H, SPAN_ROLE_HEADER("你是一名披萨配送员！你的雇主是[pizzatxt]公司。"))
	to_chat(H, SPAN_ROLE_BODY("你的工作是配送披萨。你相当确定就是这个地方……"))

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("任务目标：[objectives]")), 1 SECONDS)


/datum/emergency_call/pizza/cryo
	name = "披萨配送（冷冻舱）"
	probability = 0
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_cryo
	shuttle_id = MOBILE_SHUTTLE_ID_ERT_SMALL

/obj/effect/landmark/ert_spawns/distress_pizza
	name = "求救信号_披萨"
	icon_state = "spawn_distress_pizza"
