/obj/item/clothing/shoes/syndigaloshes
	desc = "一双棕色鞋子。它们似乎有额外的抓地力。"
	name = "棕色鞋子"
	icon_state = "brown"
	item_state = "brown"

	flags_inventory = NOSLIPPING

	var/list/clothing_choices = list()
	siemens_coefficient = 0.8

/obj/item/clothing/shoes/mime
	name = "默剧鞋"
	icon_state = "mime"

/obj/item/clothing/shoes/swat
	name = "\improper SWAT shoes"
	desc = "当你想要点燃战火时。"
	icon_state = "swat"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_inventory = NOSLIPPING
	siemens_coefficient = 0.6

/obj/item/clothing/shoes/combat //Basically SWAT shoes combined with galoshes.
	name = "作战靴"
	desc = "当你真的想要点燃战火时。"
	icon_state = "swat"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_inventory = NOSLIPPING
	siemens_coefficient = 0.6

	flags_cold_protection = BODY_FLAG_FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	flags_heat_protection = BODY_FLAG_FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT

/obj/item/clothing/shoes/sandal
	desc = "一双相当朴素的木制凉鞋。"
	name = "sandals"
	icon_state = "sandals"
	flags_armor_protection = 0

/obj/item/clothing/shoes/sandal/marisa
	desc = "一双神奇的黑色鞋子。"
	name = "魔法鞋"
	icon_state = "black"
	flags_armor_protection = BODY_FLAG_FEET

/obj/item/clothing/shoes/galoshes
	desc = "橡胶靴。"
	name = "galoshes"
	icon_state = "galoshes"

	flags_inventory = NOSLIPPING

/obj/item/clothing/shoes/clown_shoes
	desc = "恶作剧者的标准制式小丑鞋。真他妈大！"
	name = "小丑鞋"
	icon_state = "clown"
	item_state = "clown_shoes"
	slowdown = SHOES_SLOWDOWN+1
	black_market_value = 25
	var/footstep = 1 //used for squeeks whilst walking

/obj/item/clothing/shoes/jackboots
	name = "jackboots"
	desc = "用于战斗场景或作战状况的安全战斗靴。全天候战斗。"
	icon_state = "jackboots"
	item_state = "jackboots"
	siemens_coefficient = 0.7

/obj/item/clothing/shoes/cult
	name = "boots"
	desc = "纳尔-赛信徒所穿的靴子。"
	icon_state = "cult"
	item_state = "cult"
	siemens_coefficient = 0.7

	flags_cold_protection = BODY_FLAG_FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	flags_heat_protection = BODY_FLAG_FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT

/obj/item/clothing/shoes/cyborg
	name = "赛博格靴子"
	desc = "赛博格服装的鞋子。"
	icon_state = "boots"

/obj/item/clothing/shoes/slippers
	name = "兔子拖鞋"
	desc = "毛茸茸的！"
	icon_state = "slippers"
	item_state = "slippers"
	w_class = SIZE_SMALL

/obj/item/clothing/shoes/slippers_worn
	name = "破旧的兔子拖鞋"
	desc = "毛茸茸的……"
	icon_state = "slippers_worn"
	item_state = "slippers_worn"
	w_class = SIZE_SMALL

/obj/item/clothing/shoes/laceup
	name = "系带鞋"
	desc = "时尚的巅峰，而且已经预先擦亮了！"
	icon_state = "laceups"

/obj/item/clothing/shoes/laceup/brown
	name = "棕色系带鞋"
	icon_state = "laceups_brown"

/obj/item/clothing/shoes/swimmingfins
	desc = "助你游得更快。"
	name = "游泳脚蹼"
	icon_state = "flippers"
	flags_inventory = NOSLIPPING
	slowdown = SHOES_SLOWDOWN+1


/obj/item/clothing/shoes/snow
	name = "雪地靴"
	desc = "当你的脚和你的心一样冰冷时。"
	icon_state = "swat"
	siemens_coefficient = 0.6
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT

/obj/item/clothing/shoes/souto
	name = "苏托人靴子"
	desc = "\improper Souto Man's boots. Harder than the kick of Souto Red."
	icon_state = "souto_man"
	item_state = "souto_man"
	flags_inventory = CANTSTRIP|NOSLIPPING
	armor_melee = CLOTHING_ARMOR_HARDCORE
	armor_bullet = CLOTHING_ARMOR_HARDCORE
	armor_laser = CLOTHING_ARMOR_HARDCORE
	armor_energy = CLOTHING_ARMOR_HARDCORE
	armor_bomb = CLOTHING_ARMOR_HARDCORE
	armor_bio = CLOTHING_ARMOR_HARDCORE
	armor_rad = CLOTHING_ARMOR_HARDCORE
	armor_internaldamage = CLOTHING_ARMOR_HARDCORE
	flags_inventory = CANTSTRIP|NOSLIPPING
	unacidable = TRUE

/obj/item/clothing/shoes/footwrap_sandals
	name = "裹足凉鞋"
	desc = "远古时代典型士兵所穿的鞋履。"
	icon_state = "footwrap_sandals"
	item_state = "footwrap_sandals"
	item_icons = list(
		WEAR_FEET = 'icons/mob/humans/onmob/clothing/feet.dmi'
	)
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_inventory = NOSLIPPING
