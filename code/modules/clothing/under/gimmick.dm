
/obj/item/clothing/under/gimmick
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_LOW
	has_sensor = UNIFORM_NO_SENSORS
	displays_id = 0
	icon = 'icons/obj/items/clothing/halloween_clothes.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/obj/items/clothing/halloween_clothes.dmi',
	)

/obj/item/clothing/suit/gimmick
	icon = 'icons/obj/items/clothing/halloween_clothes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/obj/items/clothing/halloween_clothes.dmi',
	)

/obj/item/clothing/shoes/gimmick
	icon = 'icons/obj/items/clothing/halloween_clothes.dmi'
	item_icons = list(
		WEAR_FEET = 'icons/obj/items/clothing/halloween_clothes.dmi',
	)

/obj/item/clothing/mask/gimmick
	icon = 'icons/obj/items/clothing/halloween_clothes.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/obj/items/clothing/halloween_clothes.dmi',
	)

/obj/item/clothing/gloves/gimmick
	icon = 'icons/obj/items/clothing/halloween_clothes.dmi'
	item_icons = list(
		WEAR_HANDS = 'icons/obj/items/clothing/halloween_clothes.dmi',
	)

//JASON
/obj/item/clothing/under/gimmick/jason
	name = "肮脏的工作服"
	desc = "挖坟时的完美着装。"
	icon_state = "jason_suit"

/obj/item/clothing/mask/gimmick/jason
	name = "曲棍球面具"
	desc = "闻起来有股少年心气。"
	icon_state = "jason_mask"
	anti_hug = 100

/obj/item/clothing/suit/gimmick/jason
	name = "发霉的夹克"
	desc = "一个杀手级的时尚宣言。"
	icon_state = "jason_jacket"
	item_state = "jason_jacket"

//RAMBO
/obj/item/clothing/under/gimmick/rambo
	name = "作战裤"
	desc = "当一个人对抗全世界时，他唯一需要的东西。"
	icon_state = "rambo_suit"
	flags_armor_protection = BODY_FLAG_LEGS|BODY_FLAG_GROIN
	flags_cold_protection = BODY_FLAG_LEGS|BODY_FLAG_GROIN
	flags_heat_protection = BODY_FLAG_LEGS|BODY_FLAG_GROIN

/obj/item/clothing/suit/gimmick/rambo
	name = "pendant"
	desc = "这是一块珍贵的石头，也是某种护身符。"
	flags_armor_protection = BODY_FLAG_CHEST
	flags_cold_protection = BODY_FLAG_CHEST
	flags_heat_protection = BODY_FLAG_CHEST
	icon_state = "rambo_pendant"

//MCCLANE
/obj/item/clothing/under/gimmick/mcclane
	name = "节日服装"
	desc = "与家人共度圣诞假期的完美装束。鞋子不包括在内。"
	icon_state = "mcclane_suit"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS

//DUTCH
/obj/item/clothing/under/gimmick/dutch
	name = "作战迷彩服"
	desc = "只是在丛林中进行艰苦巡防的另一套军服。"
	icon_state = "dutch_suit"
	flags_armor_protection = BODY_FLAG_LEGS|BODY_FLAG_GROIN
	flags_cold_protection = BODY_FLAG_LEGS|BODY_FLAG_GROIN
	flags_heat_protection = BODY_FLAG_LEGS|BODY_FLAG_GROIN

/obj/item/clothing/suit/armor/gimmick/dutch
	name = "装甲夹克"
	desc = "丛林里很热。有时是闷热沉重，有时则是人间地狱。"
	icon_state = "dutch_armor"
	flags_armor_protection = BODY_FLAG_CHEST
	flags_cold_protection = BODY_FLAG_CHEST
	flags_heat_protection = BODY_FLAG_CHEST
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/device/flashlight,
		/obj/item/ammo_magazine/,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/explosive/grenade,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/large_holster/machete,
	)

//ROBOCOP
/obj/item/clothing/under/gimmick/robocop
	name = "金属躯体"
	desc = "它或许是金属的，但里面装着亚历克斯·J·墨菲的心与魂。"
	icon_state = "robocop_suit"
	flags_atom = FPRINT|CONDUCT

/obj/item/clothing/shoes/gimmick/robocop
	name = "抛光金属靴"
	desc = "踩踏底特律渣滓的完美尺寸。"
	icon_state = "robocop_shoes"
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_laser = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_HARDCORE
	flags_inventory = FPRINT|CONDUCT|NOSLIPPING

/obj/item/clothing/gloves/gimmick/robocop
	name = "金属双手"
	desc = "法律冰冷无情的双手。"
	icon_state = "robocop_gloves"
	flags_atom = FPRINT|CONDUCT
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_laser = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_HARDCORE

/obj/item/clothing/head/helmet/gimmick/robocop
	name = "抛光金属头盔"
	desc = "法律非人化的面孔。由钛合金制成，外层覆有凯夫拉。"
	icon_state = "robocop_helmet"
	item_state = "robocop_helmet"
	icon = 'icons/obj/items/clothing/halloween_clothes.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/obj/items/clothing/halloween_clothes.dmi',
	)
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_laser = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_HARDCORE
	flags_inventory = COVEREYES|BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEEYES|HIDETOPHAIR
	anti_hug = 100

/obj/item/clothing/suit/armor/gimmick
	icon = 'icons/obj/items/clothing/halloween_clothes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/obj/items/clothing/halloween_clothes.dmi',
	)

/obj/item/clothing/suit/armor/gimmick/robocop
	name = "抛光金属护甲"
	desc = "干净且保养良好，不像底特律丑陋的街道。由钛合金制成，外层覆有凯夫拉。"
	icon_state = "robocop_armor"
	item_state = "robocop_armor"
	slowdown = 1
	flags_atom = FPRINT|CONDUCT
	flags_inventory = BLOCKSHARPOBJ
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	allowed = list(/obj/item/weapon/gun/pistol/auto9)
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_laser = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_HARDCORE

//LUKE
/obj/item/clothing/under/gimmick/skywalker
	name = "黑色连体服"
	desc = "一件简单实用的连体服，由一位精通原力的大师穿着。"
	icon_state = "skywalker_suit"

/obj/item/clothing/shoes/gimmick/skywalker
	name = "黑色靴子"
	desc = "功能完好，这双靴子踏足过许多星球和星舰。"
	icon_state = "skywalker_shoes"
	flags_inventory = FPRINT|NOSLIPPING

/obj/item/clothing/gloves/gimmick/skywalker
	name = "黑色手套"
	desc = "用来遮住那只人造手的东西……谁说英雄就不能在意形象？"
	icon_state = "skywalker_gloves"
