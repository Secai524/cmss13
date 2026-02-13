/obj/structure/closet/secure_closet/emergency/surgery
	name = "紧急手术设备柜"
	desc = "一个高度安全、可自消毒的壁挂式柜子，内含额外的手术床、手术用战术背心和便携式透析机。当舰船受到敌对势力威胁时，它会自动解锁并打开。"
	icon_state = "e-surgical_wall_locked"
	icon_closed = "e-surgical_wall_unlocked"
	icon_locked = "e-surgical_wall_locked"
	icon_opened = "e-surgical_wall_open"
	icon_broken = "e-surgical_wall_spark"
	health = null	// Unbreakable
	unacidable = TRUE
	unslashable = TRUE
	wall_mounted = TRUE
	store_mobs = FALSE
	req_access = list(ACCESS_MARINE_MEDBAY)

/obj/structure/closet/secure_closet/emergency/surgery/Initialize()
	. = ..()
	new /obj/item/clothing/accessory/storage/surg_vest/equipped(src) //one for each doctor slot
	new /obj/item/clothing/accessory/storage/surg_vest/equipped(src)
	new /obj/item/clothing/accessory/storage/surg_vest/equipped(src)
	new /obj/item/clothing/accessory/storage/surg_vest/equipped(src)
	new /obj/item/roller/surgical(src)
	new /obj/item/roller/surgical(src)
	new /obj/item/roller/surgical(src)
	new /obj/item/roller/surgical(src)
	new /obj/item/tool/portadialysis(src) //one for each doctor slot
	new /obj/item/tool/portadialysis(src)
	new /obj/item/tool/portadialysis(src)
	new /obj/item/tool/portadialysis(src)
