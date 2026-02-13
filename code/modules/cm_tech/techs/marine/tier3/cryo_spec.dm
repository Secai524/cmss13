/datum/tech/cryomarine
	name = "唤醒额外专家"
	desc = "唤醒一名额外专家以对抗任何威胁。"
	icon_state = "overshield"

	announce_message = "An additional specialist is being taken out of cryo."

	required_points = 8

	flags = TREE_FLAG_MARINE
	tier = /datum/tier/three

/datum/tech/cryomarine/can_unlock(mob/user)
	. = ..()
	if(!.)
		return
	if(!SSticker.mode)
		to_chat(user, SPAN_WARNING("你现在无法执行此操作！"))
		return

/datum/tech/cryomarine/on_unlock()
	. = ..()
	SSticker.mode.get_specific_call(/datum/emergency_call/cryo_spec, TRUE, FALSE) // "陆战队员冷冻增援（专家）"
