#define NUKE_UNLOCK_TIME (115 MINUTES)

/datum/tech/nuke
	name = "核装置"
	desc = "购买一个核装置。这是唯一能确保万无一失的方法。"
	icon_state = "nuke"

	required_points = 5

	tier = /datum/tier/four

	announce_name = "NUCLEAR ARSENAL ACQUIRED"
	announce_message = "The deployment of a Large Atomic Fission Demolition Device have been authorized and will be delivered to the Requisitions Department, via ASRS."

	flags = TREE_FLAG_MARINE

/datum/tech/nuke/New()
	SSticker.OnRoundstart(CALLBACK(src, PROC_REF(handle_description)))

/datum/tech/nuke/on_unlock()
	. = ..()

	var/datum/supply_order/new_order = new()
	new_order.ordernum = GLOB.supply_controller.ordernum++
	var/actual_type = GLOB.supply_packs_types["加密的行动大片"]
	new_order.objects = list(GLOB.supply_packs_datums[actual_type])
	new_order.orderedby = MAIN_AI_SYSTEM
	new_order.approvedby = MAIN_AI_SYSTEM

	GLOB.supply_controller.shoppinglist += new_order

/datum/tech/nuke/can_unlock(mob/unlocking_mob)
	. = ..()

	if(!.)
		return

	if(ROUND_TIME < NUKE_UNLOCK_TIME)
		to_chat(unlocking_mob, SPAN_WARNING("在行动开始后[ceil((NUKE_UNLOCK_TIME + SSticker.round_start_time) / (1 MINUTES))]分钟前，你无法购买此节点。"))
		return FALSE

	var/nuclear_lock = CONFIG_GET(number/nuclear_lock_marines_percentage)
	if(nuclear_lock > 0 && nuclear_lock != 100)
		var/marines_count = SSticker.mode.count_marines() // Counting marines on land and on the ship
		var/marines_peak = GLOB.peak_humans * nuclear_lock / 100
		if(marines_count >= marines_peak)
			to_chat(unlocking_mob, SPAN_WARNING("当本次行动中存活的陆战队员和USCM船员超过[nuclear_lock]%时，你无法购买此物品。"))
			return FALSE

	return TRUE

/datum/tech/nuke/proc/handle_description()
	desc = "购买一个核装置。仅在行动开始后[ceil((NUKE_UNLOCK_TIME + SSticker.round_start_time) / (1 MINUTES))]分钟可购买。这是唯一能确保万无一失的方法。"
