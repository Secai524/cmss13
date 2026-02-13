/obj/item/clothing/suit/storage/marine/smartgunner
	name = "\improper M56 combat harness"
	desc = "一款设计用于与M56智能枪系统搭配穿戴的重型防护背心。\n它拥有专门设计的背带和加固结构，用于携带智能枪及其配件。"
	icon_state = "8"
	item_state = "armor"
	armor_laser = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_MEDIUM
	storage_slots = 2
	slowdown = SLOWDOWN_ARMOR_LIGHT
	flags_inventory = BLOCKSHARPOBJ|SMARTGUN_HARNESS
	unacidable = TRUE
	allowed = list(
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/explosive/mine,
		/obj/item/attachable/bayonet,
		/obj/item/weapon/gun/smartgun,
		/obj/item/storage/backpack/general_belt,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
	)

/obj/item/clothing/suit/storage/marine/smartgunner/Initialize()
	. = ..()
	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD] && name == "M56作战背带")
		name = "M56雪地作战背带"
	else
		name = "M56作战背带"

/obj/item/clothing/suit/storage/marine/smartgunner/mob_can_equip(mob/equipping_mob, slot, disable_warning = FALSE)
	. = ..()

	if(equipping_mob.back && !(equipping_mob.back.flags_item & SMARTGUNNER_BACKPACK_OVERRIDE))
		if(!disable_warning)
			to_chat(equipping_mob, SPAN_WARNING("穿戴背包时无法装备[src]。"))
		return FALSE

/obj/item/clothing/suit/storage/marine/smartgunner/equipped(mob/user, slot, silent)
	. = ..()

	if(slot == WEAR_JACKET)
		RegisterSignal(user, COMSIG_HUMAN_ATTEMPTING_EQUIP, PROC_REF(check_equipping))

/obj/item/clothing/suit/storage/marine/smartgunner/proc/check_equipping(mob/living/carbon/human/equipping_human, obj/item/equipping_item, slot)
	SIGNAL_HANDLER

	if(slot != WEAR_BACK)
		return

	if(equipping_item.flags_item & SMARTGUNNER_BACKPACK_OVERRIDE)
		return

	. = COMPONENT_HUMAN_CANCEL_ATTEMPT_EQUIP

	if(equipping_item.flags_equip_slot == SLOT_BACK)
		to_chat(equipping_human, SPAN_WARNING("穿戴[src]时无法在背部装备[equipping_item]。"))
		return

/obj/item/clothing/suit/storage/marine/smartgunner/unequipped(mob/user, slot)
	. = ..()

	UnregisterSignal(user, COMSIG_HUMAN_ATTEMPTING_EQUIP)

/obj/item/clothing/suit/storage/marine/smartgunner/reinforced
	name = "\improper M56 reinforced combat harness"
	desc = "一款设计用于与M56智能枪系统搭配穿戴的重型防护背心，此型号还附有一块笨重的加固板，牺牲了敏捷性但提供了更多护甲。\n它拥有专门设计的背带和加固结构，用于携带智能枪及其配件。"
	icon_state = "sg"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	slowdown = SLOWDOWN_ARMOR_MEDIUM

/obj/item/clothing/suit/storage/marine/smartgunner/reinforced/Initialize()
	. = ..()
	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD] && name == "M56强化作战背带")
		name = "M56强化雪地作战背带"
	else
		name = "M56强化作战背带"
