/obj/structure/closet/crate/critter
	name = "生物板条箱"
	desc = "一个可以维持生命一段时间的板条箱。"
	icon_state = "critter"
	icon_opened = "critteropen"
	icon_closed = "critter"

/obj/structure/closet/crate/critter/attempt_rigging(obj/item/object, mob/user)
	return FALSE // No rigging
