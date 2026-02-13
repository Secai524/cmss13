/obj/item/pamphlet/skill/vc
	name = "载具训练手册"
	desc = "一本用于快速传授驾驶载具关键知识的手册。"
	icon_state = "pamphlet_vehicle"
	trait = /datum/character_trait/skills/vc
	bypass_pamphlet_limit = TRUE

/obj/item/vehicle_coupon
	name = "载具兑换券"
	desc = "一张用于ASRS载具控制台的兑换券，可为持有者兑换一辆真正的装甲运兵车！没错伙计，我们不用再走路了！仅限使用一次。ASRS电梯必须手动发送至下层。可能有特殊限制。无保修。"
	icon = 'icons/obj/items/pamphlets.dmi'
	icon_state = "pamphlet_written"
	item_state = "pamphlet_written"
	var/vehicle_type = /datum/vehicle_order/apc/empty
	var/vehicle_category = "APC"

/obj/item/vehicle_coupon/tank
	name = "坦克兑换券"
	desc = "我们不玩了！此兑换券允许舰组人员从载具ASRS中提取一辆完整的朗斯特里特坦克。请确保将ASRS升降梯降下以便提取。仅限使用一次。不含LTB。附带免费友军火力。"
	vehicle_type = /datum/vehicle_order/tank/broken
	vehicle_category = "LONGSTREET"

/obj/item/vehicle_coupon/attack_self(mob/user)
	if(QDELETED(src))
		return
	if(redeem_vehicle())
		to_chat(user, SPAN_WARNING("\The [src] catches fire as it is read and resets the ASRS Vehicle system! Send the lift down and haul your prize up."))
		qdel(src)
	return ..()

/obj/item/vehicle_coupon/proc/redeem_vehicle(mob/user)
	SHOULD_NOT_SLEEP(TRUE)
	. = FALSE
	var/obj/structure/machinery/computer/supply/asrs/vehicle/comp = GLOB.VehicleElevatorConsole
	var/obj/structure/machinery/cm_vending/gear/vehicle_crew/gearcomp = GLOB.VehicleGearConsole

	if(!comp || !gearcomp)
		return

	. = TRUE
	comp.spent = FALSE
	QDEL_NULL_LIST(comp.vehicles)
	comp.vehicles = list(
		new vehicle_type(),
	)
	comp.allowed_roles = null
	comp.req_access = list()
	comp.req_one_access = list()
	comp.spent = FALSE

	gearcomp.req_access = list()
	gearcomp.req_one_access = list()
	gearcomp.vendor_role = list()
	gearcomp.selected_vehicle = vehicle_category
	gearcomp.available_categories = VEHICLE_ALL_AVAILABLE

	return TRUE
