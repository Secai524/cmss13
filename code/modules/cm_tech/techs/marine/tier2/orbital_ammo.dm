/datum/tech/repeatable/ob
	name = "轨道轰炸弹药"
	desc = "购买轨道轰炸弹药。"

	required_points = 5
	increase_per_purchase = 2

	tier = /datum/tier/two

	var/type_to_give

/datum/tech/repeatable/ob/on_unlock()
	. = ..()
	if(!type_to_give)
		return

	var/datum/supply_order/O = new /datum/supply_order()
	O.ordernum = GLOB.supply_controller.ordernum++
	var/actual_type = GLOB.supply_packs_types[type_to_give]
	O.objects = list(GLOB.supply_packs_datums[actual_type])
	O.orderedby = MAIN_AI_SYSTEM

	GLOB.supply_controller.shoppinglist += O

/datum/tech/repeatable/ob/he
	name = "额外轨道轰炸弹头 - 高爆"
	desc = "高爆轰炸弹药，用于装填轨道炮。"
	icon_state = "ob_he"

	announce_message = "Additional Orbital Bombardment warheads (HE) have been delivered to Requisitions' ASRS."

	flags = TREE_FLAG_MARINE

	type_to_give = "轨道轰炸高爆弹箱"

/datum/tech/repeatable/ob/cluster
	name = "额外轨道轰炸弹头 - 集束"
	desc = "高爆分裂式轰炸弹药，用于装填轨道炮。"
	icon_state = "ob_cluster"

	announce_message = "Additional Orbital Bombardment warheads (Cluster) have been delivered to Requisitions' ASRS."

	flags = TREE_FLAG_MARINE

	type_to_give = "轨道轰炸集束弹箱"

/datum/tech/repeatable/ob/incend
	name = "额外轨道轰炸弹头 - 燃烧"
	desc = "高可燃性轰炸弹药，用于装填轨道炮。"
	icon_state = "ob_incend"

	announce_message = "Additional Orbital Bombardment warheads (Incendiary) have been delivered to Requisitions' ASRS."

	flags = TREE_FLAG_MARINE

	type_to_give = "轨道轰炸燃烧弹箱"
