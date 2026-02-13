
/datum/tech/repeatable/cryomarine
	name = "唤醒额外部队"
	desc = "唤醒额外部队以对抗任何威胁。"
	icon_state = "cryotroops"

	announce_message = "Additional troops are being taken out of cryo."

	required_points = 6
	increase_per_purchase = 6

	flags = TREE_FLAG_MARINE
	tier = /datum/tier/three

/datum/tech/repeatable/cryomarine/can_unlock(mob/M)
	. = ..()
	if(!.)
		return
	if(!SSticker.mode)
		to_chat(M, SPAN_WARNING("你现在无法执行此操作！"))
		return

/datum/tech/repeatable/cryomarine/on_unlock()
	. = ..()
	SSticker.mode.get_specific_call(/datum/emergency_call/cryo_squad/tech, TRUE, FALSE) // "陆战队员冷冻增援（技术）"
