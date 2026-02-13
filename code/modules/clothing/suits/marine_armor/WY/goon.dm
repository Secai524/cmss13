/obj/item/clothing/suit/storage/marine/veteran/pmc/light/corporate
	name = "\improper M1 pattern corporate security armor"
	desc = "一件基础背心，右胸有维兰德-汤谷徽章。这通常由保护维兰德-汤谷设施的低级警卫穿着。"
	icon_state = "armor"
	item_state = "armor"
	slowdown = SLOWDOWN_ARMOR_LIGHT

	flags_armor_protection = BODY_FLAG_CHEST
	flags_cold_protection = BODY_FLAG_CHEST
	flags_heat_protection = BODY_FLAG_CHEST
	item_state_slots = list(WEAR_JACKET = "armor")
	lamp_icon = "lamp"
	lamp_light_color = LIGHT_COLOR_TUNGSTEN
	light_color = LIGHT_COLOR_TUNGSTEN

/obj/item/clothing/suit/storage/marine/veteran/pmc/light/corporate/medic
	desc = "一件基础背心，右胸有维兰德-汤谷徽章。此变体带有红色徽章，表明穿戴者的医疗用途。至少理论上是这样。"
	icon_state = "med_armor"
	item_state = "med_armor"
	item_state_slots = list(WEAR_JACKET = "med_armor")

/obj/item/clothing/suit/storage/marine/veteran/pmc/light/corporate/lead
	desc = "一件基础背心，右胸有维兰德-汤谷徽章。这种款式由因‘战场表现良好’——也就是公司马屁精——而晋升的低级守卫穿着。"
	icon_state = "lead_armor"
	item_state = "lead_armor"
	item_state_slots = list(WEAR_JACKET = "lead_armor")

/obj/item/clothing/suit/storage/marine/veteran/pmc/light/synth/corporate
	name = "\improper M1 pattern corporate synthetic armor"
	desc = "一件基础的合成人员背心，右胸有维兰德-汤谷徽章。这很罕见，因为低级安保单位通常没有配备合成人的待遇。其所有护甲插板均已移除。"
	icon_state = "armor"
	item_state = "armor"
	storage_slots = 2
	item_state_slots = list(WEAR_JACKET = "armor")

/obj/item/clothing/suit/storage/marine/veteran/pmc/light/corporate/ppo
	desc = "一件基础背心，右胸有维兰德-汤谷徽章。这种款式由保护维兰德-汤谷雇员的个人保护官穿着，以蓝色徽章为标识。"
	icon_state = "ppo_armor"
	item_state = "ppo_armor"
	item_state_slots = list(WEAR_JACKET = "ppo_armor")
	uniform_restricted = null
	storage_slots = 1

	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	slowdown = SLOWDOWN_ARMOR_SUPER_LIGHT

/obj/item/clothing/suit/storage/marine/veteran/pmc/light/corporate/ppo/strong
	name = "\improper M4 pattern PPO armor"
	desc = "标准阿玛特系统M3护甲的改型。这种款式由保护维兰德-汤谷雇员的个人保护官穿着，以蓝色细节为标识。移除了部分护甲板以增强机动性。"
	icon_state = "ppo_armor_strong"
	item_state_slots = list(WEAR_JACKET = "ppo_armor_strong")
	storage_slots = 2

	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT

