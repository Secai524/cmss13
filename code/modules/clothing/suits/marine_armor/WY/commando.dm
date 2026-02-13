/obj/item/clothing/suit/storage/marine/veteran/pmc/commando
	name = "\improper MY7 pattern Commando armor"
	desc = "对W-Y PMC护甲款式的改良。专为精英企业佣兵设计。"
	icon_state = "commando_armor"
	item_state_slots = list(WEAR_JACKET = "commando_armor")
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_energy = CLOTHING_ARMOR_HIGHPLUS
	armor_bomb = CLOTHING_ARMOR_HIGHPLUS
	armor_internaldamage = CLOTHING_ARMOR_HIGHPLUS
	storage_slots = 4
	flags_marine_armor = null
	actions_types = null

/obj/item/clothing/suit/storage/marine/veteran/pmc/commando/damaged //survivor variant
	name = "受损的MY7型突击队护甲"
	desc = "对W-Y PMC护甲款式的改良。专为精英企业佣兵设计。这件上面有很多划痕和酸蚀损伤。"
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	storage_slots = 3

/obj/item/clothing/suit/storage/marine/veteran/pmc/commando/leader
	name = "\improper MY7 pattern Commando leader armor"
	desc = "对W-Y PMC护甲款式的改良。专为精英企业佣兵设计。这套特别的护甲看起来属于一名高级军官。"
	icon_state = "commando_armor_leader"
	item_state_slots = list(WEAR_JACKET = "commando_armor_leader")

/obj/item/clothing/suit/storage/marine/smartgunner/veteran/pmc/commando
	name = "\improper MY7 pattern Commando gunner armor"
	desc = "对标准阿玛特系统M3护甲的改良。配有背带和固定带，允许使用者携带M56智能枪。"
	icon_state = "commando_armor_sg"
	flags_inventory = BLOCKSHARPOBJ|BLOCK_KNOCKDOWN|SMARTGUN_HARNESS
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_energy = CLOTHING_ARMOR_HIGHPLUS
	armor_bomb = CLOTHING_ARMOR_HIGHPLUS
	armor_internaldamage = CLOTHING_ARMOR_HIGHPLUS
	storage_slots = 4
	item_state_slots = list(WEAR_JACKET = "commando_armor_sg")

/obj/item/clothing/suit/storage/marine/veteran/pmc/apesuit
	name = "\improper M5X Apesuit"
	desc = "一套复杂的重叠板甲系统，旨在使穿戴者几乎不受轻武器火力伤害。一套被动外骨骼支撑着护甲的重量，使人类能够承载其巨大的体积。"
	icon_state = "ape_suit"
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	movement_compensation = SLOWDOWN_ARMOR_VERY_HEAVY
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bio = CLOTHING_ARMOR_VERYHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_ARMS|BODY_FLAG_FEET
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/pmc/apesuit)
	item_state_slots = list(WEAR_JACKET = "ape_suit")
	unacidable = TRUE
	flags_marine_armor = null
	actions_types = null
