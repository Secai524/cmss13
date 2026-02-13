//=============================//Marine Raiders\\==================================\\
//=======================================================================\\

/obj/item/clothing/suit/storage/marine/sof
	name = "\improper SOF Armor"
	desc = "一套高度定制的M3护甲。供陆战队突袭者使用。"
	icon_state = "marsoc"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UA.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UA.dmi'
	)
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_VERYHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	slowdown = SLOWDOWN_ARMOR_LIGHT
	unacidable = TRUE
	flags_atom = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE|NO_GAMEMODE_SKIN
	storage_slots = 4

/obj/item/clothing/suit/storage/marine/smartgunner/veteran/sof
	name = "\improper SOF elite combat harness"
	desc = "一套高度定制的智能枪手背带。供陆战队突袭者使用。"
	icon_state = "marsoc_harness"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UA.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UA.dmi'
	)
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_VERYHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	slowdown = SLOWDOWN_ARMOR_LIGHT
	unacidable = TRUE
	flags_atom = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE|NO_GAMEMODE_SKIN
	storage_slots = 4

//=============================//GENERIC FACTIONAL ARMOR ITEM\\==================================\\
//=======================================================================\\

/obj/item/clothing/suit/storage/marine/veteran
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	flags_marine_armor = ARMOR_LAMP_OVERLAY
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE //Let's make these keep their name and icon.

/obj/item/clothing/suit/storage/marine/veteran/Initialize()
	. = ..()
	RemoveElement(/datum/element/corp_label/armat)

//===========================//DISTRESS\\================================\\
//=======================================================================\\

/obj/item/clothing/suit/storage/marine/veteran/bear
	name = "\improper H1 Iron Bears vest"
	desc = "铁熊雇佣兵穿戴的防护背心。"
	icon_state = "bear_armor"
	icon = 'icons/obj/items/clothing/suits/misc_ert.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/misc_ert.dmi',
	)
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	storage_slots = 2
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/bear)

/obj/item/clothing/suit/storage/marine/veteran/dutch
	name = "\improper D2 armored vest"
	desc = "一些经验极其丰富的雇佣兵穿戴的防护背心。"
	icon_state = "dutch_armor"
	icon = 'icons/obj/items/clothing/suits/misc_ert.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/misc_ert.dmi',
	)
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS //Makes no sense but they need leg/arm armor too.
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_MEDIUM
	storage_slots = 2
	light_range = 7
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/dutch)

/obj/item/clothing/suit/storage/marine/veteran/van_bandolier
	name = "狩猎夹克"
	desc = "一件定制的狩猎夹克，巧妙地内衬分段式装甲板。有时猎物也会反击。"
	icon_state = "van_bandolier"
	item_state = "van_bandolier_jacket"
	icon = 'icons/obj/items/clothing/suits/jackets.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/jackets.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)
	blood_overlay_type = "coat"
	flags_marine_armor = NO_FLAGS //No shoulder light.
	actions_types = list()
	slowdown = SLOWDOWN_ARMOR_LIGHT
	storage_slots = 2
	movement_compensation = SLOWDOWN_ARMOR_LIGHT
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/van_bandolier)
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/storage/bible,
		/obj/item/attachable/bayonet,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
		/obj/item/storage/belt/gun/smartpistol,
		/obj/item/storage/belt/gun/flaregun,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
		/obj/item/storage/belt/shotgun/van_bandolier,
	)

//===========================//U.P.P\\================================\\
//=====================================================================\\

/obj/item/clothing/suit/storage/marine/faction
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	min_cold_protection_temperature = HELMET_MIN_COLD_PROT
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROT
	blood_overlay_type = "armor"
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	movement_compensation = SLOWDOWN_ARMOR_LIGHT

/obj/item/clothing/suit/storage/marine/faction/Initialize()
	. = ..()
	RemoveElement(/datum/element/corp_label/armat)

/obj/item/clothing/suit/storage/marine/faction/UPP
	name = "\improper UM5 personal armor"
	desc = "UPP军队的标准护甲，UM5（联盟中型MK5）是一种中型护甲，大致与USCM服役的M3型护甲相当，专精于弹道防护。然而，与M3不同，其护板带有更重的颈板。这导致许多UA成员称UPP士兵为“锡人”。"
	icon_state = "upp_armor"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UPP.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UPP.dmi'
	)
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	storage_slots = 1
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP, /obj/item/clothing/under/marine/veteran/UPP/medic, /obj/item/clothing/under/marine/veteran/UPP/engi, /obj/item/clothing/under/marine/veteran/UPP/SOF_uniform)

/obj/item/clothing/suit/storage/marine/faction/UPP/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/norcomm)

/obj/item/clothing/suit/storage/marine/faction/UPP/support
	name = "\improper UL6 personal armor"
	desc = "UPP军队的标准护甲，UL6（联盟轻型MK6）是一种轻型护甲，略弱于USCM服役的M3型护甲，专精于弹道防护。这套个人护甲没有标志性的颈部和部分护甲，以换取使用者的机动性。"
	storage_slots = 3
	icon_state = "upp_armor_support"
	slowdown = SLOWDOWN_ARMOR_LIGHT
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_HIGH

/obj/item/clothing/suit/storage/marine/faction/UPP/support/synth
	name = "\improper UL6 Synthetic personal armor"
	desc = "UL6人员护甲系统的改进型，旨在供合成人单位使用。不提供防护，但对行动阻碍极小。"
	flags_marine_armor = ARMOR_LAMP_OVERLAY|SYNTH_ALLOWED
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_NONE
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	time_to_unequip = 0.5 SECONDS
	time_to_equip = 1 SECONDS

/obj/item/clothing/suit/storage/marine/faction/UPP/commando
	name = "\improper UM5CU personal armor"
	desc = "UM5的改进型号，专为隐秘行动设计。"
	icon_state = "upp_armor_commando"
	storage_slots = 2
	slowdown = SLOWDOWN_ARMOR_LIGHT

/obj/item/clothing/suit/storage/marine/faction/UPP/heavy
	name = "\improper UH7 heavy plated armor"
	desc = "UH7（联盟重型MK7）是UPP军队服役的一套极其重型的护甲，以其强大的弹道防护能力而闻名，并配有显著的颈护，经过加固以让穿戴者能够承受笨重头盔带来的压力。"
	icon_state = "upp_armor_heavy"
	storage_slots = 3
	slowdown = SLOWDOWN_ARMOR_HEAVY
	flags_inventory = BLOCKSHARPOBJ|BLOCK_KNOCKDOWN
	flags_armor_protection = BODY_FLAG_ALL_BUT_HEAD
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_HIGHPLUS

/obj/item/clothing/suit/storage/marine/faction/UPP/heavy/Initialize()
	. = ..()
	pockets.bypass_w_limit = list(
		/obj/item/ammo_magazine/minigun,
		/obj/item/ammo_magazine/pkp,
		)

/obj/item/clothing/suit/storage/marine/faction/UPP/officer
	name = "\improper UL4 officer jacket"
	desc = "一件轻便夹克，配发给UPP军队的军官。对来袭伤害略有防护，但最好还是穿上正规护甲。"
	icon_state = "upp_coat_officer"
	slowdown = SLOWDOWN_ARMOR_NONE
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_LOW //wear actual armor if you go into combat
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	storage_slots = 3
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP/officer)

/obj/item/clothing/suit/storage/marine/faction/UPP/kapitan
	name = "\improper UL4 senior officer jacket"
	desc = "一件轻便夹克，配发给UPP军队的高级军官。由优质材料制成，甚至将大尉及其连队的军衔和徽章装饰在夹克的肩部和前襟。对来袭伤害略有防护，但最好还是穿上正规护甲。"
	icon_state = "upp_coat_kapitan"
	slowdown = SLOWDOWN_ARMOR_NONE
	armor_melee = CLOTHING_ARMOR_LOW //wear actual armor if you go into combat
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_ARMS
	storage_slots = 4
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP/officer)

/obj/item/clothing/suit/storage/marine/faction/UPP/mp
	name = "\improper UL4 camouflaged jacket"
	desc = "一件轻便夹克，在部队不预期参与战斗时配发。虽然仍镶满了凯夫拉碎片，但合成纤维结构降低了其防护效果。"
	icon_state = "upp_coat_mp"
	slowdown = SLOWDOWN_ARMOR_NONE
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_LOW //wear actual armor if you go into combat
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	storage_slots = 4
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP)

/obj/item/clothing/suit/storage/marine/faction/UPP/jacket/ivan
	name = "\improper UH4 Camo Jacket"
	desc = "UL4的实验性重装甲变体，通常只配发给最精锐的单位。"
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS|BODY_FLAG_HANDS|BODY_FLAG_FEET
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	storage_slots = 2

// UPP Army

/obj/item/clothing/suit/storage/marine/faction/UPP/army

	name = "\improper 6B80 personal body armor"
	desc = "一套较旧的UPP个人护甲系统，现已被UPP陆军标准6B90护甲取代。仍被某些UPP不预期会经历太多战斗的陆军单位使用。"
	storage_slots = 3
	icon_state = "upp_armor_army_brown"

	armor_melee = CLOTHING_ARMOR_MEDIUMLOW // Goon stats
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM

	flags_armor_protection = (BODY_FLAG_CHEST)
	flags_cold_protection = (BODY_FLAG_CHEST)
	flags_heat_protection = (BODY_FLAG_CHEST)

	slowdown = SLOWDOWN_ARMOR_LIGHT

/obj/item/clothing/suit/storage/marine/faction/UPP/army/simple
	name = "6B70个人护甲"
	icon_state = "upp_generic_ballistic_armor"

/obj/item/clothing/suit/storage/marine/faction/UPP/army/alt
	name = "6B75个人护甲"
	icon_state = "upp_ballistic_armor"

// People's Armed Police

/obj/item/clothing/suit/storage/CMB/pap
	name = "\improper PaP uniform jacket"
	desc = "一件人民武装警察勤务夹克，带有分散的小型对位芳纶插片，提供最基础的防御功能，并配有个人照明单元装备。"
	icon_state = "upp_coat_pap"
	uniform_restricted = FALSE
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UPP.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UPP.dmi'
	)

/obj/item/clothing/suit/storage/CMB/pap/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/norcomm)

// UPP SOF

/obj/item/clothing/suit/storage/marine/faction/UPP/SOF_armor
	name = "\improper CCC5-L tactical vest"
	desc = "一件UPP配发的轻型防弹背心，专为太空作战部队设计。采用聚合物-陶瓷复合板以提高防护，同时允许更大的机动性。配备模块化弹药和装备袋，确保快速取用必要补给。"
	icon_state = "sof_vest"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UPP.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UPP.dmi'
	)
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW // Goon stats & covers arms
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM

	flags_armor_protection = (BODY_FLAG_CHEST|BODY_FLAG_ARMS)
	flags_cold_protection = (BODY_FLAG_CHEST|BODY_FLAG_ARMS)
	flags_heat_protection = (BODY_FLAG_CHEST|BODY_FLAG_ARMS)

	storage_slots = 4
	slowdown = SLOWDOWN_ARMOR_LIGHT

/obj/item/clothing/suit/storage/marine/faction/UPP/SOF_armor/heavy
	name = "\improper CCC5-L Heavy Tactical Vest"
	desc = "一件UPP配发的重型加固战术背心，专为在高风险环境中行动的太空作战部队设计。CCC5-L重型板战术背心在胸部和躯干增加了额外的聚合物-陶瓷复合板，提供卓越的防弹和防爆保护。尽管厚重，该背心在防护和机动性之间保持了平衡，并配有模块化袋以快速取用必要装备。"
	icon_state = "sof_vest_plate_heavy"

	armor_melee = CLOTHING_ARMOR_MEDIUM // Slightly better then Goon armor & covers arms and groin
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	slowdown = SLOWDOWN_ARMOR_LIGHT
	flags_armor_protection = (BODY_FLAG_CHEST|BODY_FLAG_ARMS|BODY_FLAG_GROIN)

/obj/item/clothing/suit/storage/marine/faction/UPP/SOF_armor/medium
	name = "\improper CCC5-L plated tactical vest"
	desc = "一件UPP配发的轻型防弹背心，专为太空作战部队设计。采用聚合物-陶瓷复合板以提高防护，同时允许更大的机动性。配备模块化弹药和装备袋，确保快速取用必要补给。"
	icon_state = "sof_vest_plate"

	armor_melee = CLOTHING_ARMOR_MEDIUMLOW // Very slightly better then Goon armor & covers arms
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	slowdown = SLOWDOWN_ARMOR_LIGHT

/obj/item/clothing/suit/storage/marine/faction/UPP/SOF_armor/medium/alt
	icon_state = "sof_vest_alt"

/obj/item/clothing/suit/storage/marine/faction/UPP/SOF_armor/synth
	name = "\improper CCC5-L synthetic tactical vest"
	desc = "一件UPP配发的轻型防弹背心，专为太空作战部队设计。采用聚合物-陶瓷复合板以提高防护，同时允许更大的机动性。配备模块化弹药和装备袋，确保快速取用必要补给。"
	time_to_unequip = 0.5 SECONDS
	time_to_equip = 1 SECONDS
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_NONE
	storage_slots = 4
	slowdown = SLOWDOWN_ARMOR_SUPER_LIGHT

/obj/item/clothing/suit/storage/marine/faction/UPP/SOF_armor/synth/Initialize()
	flags_atom |= NO_NAME_OVERRIDE
	flags_marine_armor |= SYNTH_ALLOWED
	return ..()

//===========================//FREELANCER\\================================\\
//=====================================================================\\

/obj/item/clothing/suit/storage/marine/faction/freelancer
	name = "自由佣兵胸甲"
	desc = "一件由各种护板拼凑而成的装甲防护胸甲。其性能保持得出奇地好，因为工艺扎实，设计模仿了UPP和USCM中的此类护甲。自由佣兵队伍中的许多熟练工匠以每月大约一件的速度生产这些背心。"
	icon_state = "freelancer_armor"
	icon = 'icons/obj/items/clothing/suits/misc_ert.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/misc_ert.dmi',
	)
	slowdown = SLOWDOWN_ARMOR_LIGHT
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	storage_slots = 2
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/freelancer)

//this one is for CLF
/obj/item/clothing/suit/storage/militia
	name = "殖民地民兵锁子甲"
	desc = "殖民地民兵成员的锁子甲，由煮制皮革和一些现代装甲板制成。虽然不是最强大的护甲形式，与大多数现代护甲相比也显得原始，但它赋予穿戴者近乎完美的机动性，这符合当地殖民者的需求。它穿戴快速，易于隐藏，并且可以在大型工坊中廉价生产。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/CLF.dmi'
	icon_state = "rebel_armor"
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/CLF.dmi'
	)
	sprite_sheets = list(SPECIES_MONKEY = 'icons/mob/humans/species/monkeys/onmob/suit_monkey_1.dmi')
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	movement_compensation = SLOWDOWN_ARMOR_MEDIUM
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	storage_slots = 2
	uniform_restricted = list(/obj/item/clothing/under/colonist)
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/explosive/grenade,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/large_holster/machete,
		/obj/item/weapon/baseballbat,
		/obj/item/weapon/baseballbat/metal,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
	)
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT

/obj/item/clothing/suit/storage/militia/Initialize()
	. = ..()
	pockets.max_w_class = SIZE_SMALL //Can contain small items AND rifle magazines.
	pockets.bypass_w_limit = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg,
		/obj/item/ammo_magazine/sniper,
	)
	pockets.max_storage_space = 8

/obj/item/clothing/suit/storage/militia/vest
	name = "殖民地民兵背心"
	desc = "殖民地民兵成员的锁子甲，由煮制皮革和一些现代装甲板制成。虽然不是最强大的护甲形式，与大多数现代护甲相比也显得原始，但它赋予穿戴者近乎完美的机动性，这符合当地殖民者的需求。它穿戴快速，易于隐藏，并且可以在大型工坊中廉价生产。这个极轻的变体仅保护胸部和腹部。"
	icon_state = "clf_2"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	slowdown = 0.2
	movement_compensation = SLOWDOWN_ARMOR_MEDIUM

/obj/item/clothing/suit/storage/militia/brace
	name = "殖民地民兵护臂"
	desc = "殖民地民兵成员的锁子甲，由煮制皮革和一些现代装甲板制成。虽然不是最强大的护甲形式，与大多数现代护甲相比也显得原始，但它赋予穿戴者近乎完美的机动性，这符合当地殖民者的需求。它穿戴快速，易于隐藏，并且可以在大型工坊中廉价生产。这个极轻的变体移除了部分胸部护板。"
	icon_state = "clf_3"
	flags_armor_protection = BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_cold_protection = BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	slowdown = 0.2
	movement_compensation = SLOWDOWN_ARMOR_MEDIUM

/obj/item/clothing/suit/storage/militia/partial
	name = "殖民地民兵部分锁子甲"
	desc = "殖民地民兵成员的锁子甲，由煮制皮革和一些现代装甲板制成。虽然不是最强大的护甲形式，与大多数现代护甲相比也显得原始，但它赋予穿戴者近乎完美的机动性，这符合当地殖民者的需求。它穿戴快速，易于隐藏，并且可以在大型工坊中廉价生产。这个更轻的变体移除了部分手臂护板。"
	icon_state = "clf_4"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	slowdown = 0.2

/obj/item/clothing/suit/storage/militia/smartgun
	name = "殖民地民兵携行具"
	icon_state = "clf_harness"
	desc = "殖民地民兵成员的锁子甲，由煮制皮革和一些现代装甲板制成。虽然不是最强大的护甲形式，与大多数现代护甲相比也显得原始，但它赋予穿戴者近乎完美的机动性，这符合当地殖民者的需求。它穿戴快速，易于隐藏，并且可以在大型工坊中廉价生产。这一件将护板与智能枪手携行具套件的部件用带子交织在一起，允许使用者发射缴获的智能枪，尽管可能有点不舒服。"
	storage_slots = 3
	flags_inventory = BLOCKSHARPOBJ|SMARTGUN_HARNESS

/obj/item/clothing/suit/storage/militia/full
	name = "殖民地民兵全套护甲"
	desc = "在组织松散的游击队中，这是一套难得的装备。这套近乎完整的护甲由煮制皮革和更现代的护甲部件制成，包含四肢和躯干的全面防护。"
	icon_state = "rebel_armor_full"
	storage_slots = 3

/obj/item/clothing/suit/storage/militia/full/smartgun
	name = "殖民地民兵全身护甲"
	desc = "在组织松散的游击队中，这是一套难得的装备。这套近乎完整的护甲由煮制皮革和更现代的护甲部件制成，包含四肢和躯干的全面防护。它甚至进一步改装了M56智能枪手背带的部件，使其能够使用智能枪系统电子设备。"
	flags_inventory = BLOCKSHARPOBJ|SMARTGUN_HARNESS

//===========================//CMB\\================================\\
//=====================================================================\\

/obj/item/clothing/suit/storage/CMB
	name = "\improper CMB Deputy jacket"
	desc = "一件厚实时尚的黑色皮夹克，上面别着副警长的徽章。背面绣着醒目的“DEPUTY”字样，代表着外缘地带的正义、权威与保护。地球的法律延伸至太阳系之外。"
	icon_state = "CMB_jacket"
	item_state = "CMB_jacket"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/CMB.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/CMB.dmi'
	)
	blood_overlay_type = "coat"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,
		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/crew_monitor,
		/obj/item/tool/pen,
		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
		/obj/item/storage/belt/gun/mateba,
		/obj/item/storage/belt/gun/smartpistol,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/large_holster/katana,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
	)

/obj/item/clothing/suit/storage/CMB/Initialize()
	. = ..()
	pockets.max_w_class = SIZE_SMALL //Can contain small items AND rifle magazines.
	pockets.bypass_w_limit = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg,
		/obj/item/ammo_magazine/sniper,
	)
	pockets.max_storage_space = 8

/obj/item/clothing/suit/storage/CMB/marshal
	name = "\improper CMB Marshal jacket"
	desc = "一件厚实时尚的黑色皮夹克，上面别着警长的徽章。背面绣着醒目的“MARSHAL”字样，代表着外缘地带的正义、权威与保护。地球的法律延伸至太阳系之外。"
	icon_state = "CMB_jacket_marshal"
	item_state = "CMB_jacket_marshal"

/obj/item/clothing/suit/storage/marine/veteran/cmb
	name = "\improper M4R pattern CMB armor"
	desc = "一套深色护甲，是阿玛特系统M3护甲安保型号的改型。专为防暴和镇压抗议活动设计。侧面有一块金属徽章，上面写着“CMB RIOT CONTROL”。地球的法律延伸至太阳系之外。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/CMB.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/CMB.dmi'
	)
	icon_state = "cmb_heavy_armor"
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_energy = CLOTHING_ARMOR_HIGH
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	storage_slots = 3


	slowdown = SLOWDOWN_ARMOR_MEDIUM
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,
		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/crew_monitor,
		/obj/item/tool/pen,
		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
		/obj/item/storage/belt/gun/mateba,
		/obj/item/storage/belt/gun/smartpistol,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/large_holster/katana,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
	)
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/cmb, /obj/item/clothing/under/CM_uniform)
	item_state_slots = list(WEAR_JACKET = "cmb_heavy_armor")

/obj/item/clothing/suit/storage/marine/veteran/cmb/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/clothing/suit/storage/marine/veteran/cmb/light
	name = "\improper M4R pattern CMB light armor"
	icon_state = "cmb_light_armor"
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_MEDIUM

	slowdown = SLOWDOWN_ARMOR_LIGHT
	item_state_slots = list(WEAR_JACKET = "cmb_light_armor")

/obj/item/clothing/suit/storage/marine/veteran/cmb/spec
	name = "\improper M4R-S pattern CMB SWAT armor"
	icon_state = "cmb_elite_armor"
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_HIGH

	slowdown = SLOWDOWN_ARMOR_LIGHT
	item_state_slots = list(WEAR_JACKET = "cmb_elite_armor")

/obj/item/clothing/suit/storage/marine/veteran/cmb/leader
	name = "\improper M4R pattern CMB Marshal armor"
	icon_state = "cmb_sheriff_armor"
	desc = "一套为警长本人定制的CMB防暴护甲改型，带有金色镶边和军衔徽章。额外增加了一层轻质防护材料。"
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_HIGH

	item_state_slots = list(WEAR_JACKET = "cmb_sheriff_armor")

//===========================//HELGHAST - MERCENARY\\================================\\
//=====================================================================\\

/obj/item/clothing/suit/storage/marine/veteran/mercenary
	name = "\improper K12 ceramic plated armor"
	desc = "一套灰色重型陶瓷护甲，带有深蓝色点缀。这是在该星区活动的某未知雇佣兵集团的标准制服。"
	icon_state = "mercenary_heavy_armor"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/CLF.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/CLF.dmi'
	)
	flags_inventory = BLOCKSHARPOBJ|BLOCK_KNOCKDOWN
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_HIGHPLUS
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_HIGHPLUS
	storage_slots = 2
	slowdown = SLOWDOWN_ARMOR_LIGHT
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/ammo_magazine/,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/explosive/grenade,
		/obj/item/storage/bible,
		/obj/item/weapon/sword/machete,
		/obj/item/attachable/bayonet,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
	)
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/mercenary)
	item_state_slots = list(WEAR_JACKET = "mercenary_heavy_armor")

/obj/item/clothing/suit/storage/marine/veteran/mercenary/heavy
	name = "\improper Modified K12 ceramic plated armor"
	desc = "一套灰色重型陶瓷护甲，带有深蓝色点缀。它经过改装，在储物袋中额外放置了陶瓷板，似乎旨在支持使用极其沉重的武器。"
	armor_melee = CLOTHING_ARMOR_ULTRAHIGH
	armor_bullet = CLOTHING_ARMOR_ULTRAHIGHPLUS
	armor_bomb = CLOTHING_ARMOR_HIGHPLUS
	armor_bio = CLOTHING_ARMOR_HIGHPLUS
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_VERYHIGHPLUS
	storage_slots = 1

/obj/item/clothing/suit/storage/marine/veteran/mercenary/miner
	name = "\improper Y8 armored miner vest"
	desc = "一套米色轻型护甲，为采矿时的防护而打造。这是在该星区活动的某未知雇佣兵集团的专业制服。"
	icon_state = "mercenary_miner_armor"
	storage_slots = 3
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/ammo_magazine/,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/explosive/grenade,
		/obj/item/storage/bible,
		/obj/item/weapon/sword/machete,
		/obj/item/attachable/bayonet,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
	)
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/mercenary)
	item_state_slots = list(WEAR_JACKET = "mercenary_miner_armor")

/obj/item/clothing/suit/storage/marine/veteran/mercenary/support
	name = "\improper Z7 armored vest"
	desc = "一套蓝色护甲，带有黄色点缀，为在高度危险环境中进行建造或医疗作业时的防护而打造。这是在该星区活动的某未知雇佣兵集团的专业制服。"
	icon_state = "mercenary_engineer_armor"
	item_state_slots = list(WEAR_JACKET = "mercenary_engineer_armor")

/obj/item/clothing/suit/storage/marine/M3G/hefa
	name = "\improper HEFA Knight armor"
	desc = "一块厚重的护甲，装饰着一件HEFA。通常见于HEFA骑士身上。"
	icon_state = "hefadier"
	icon = 'icons/obj/items/clothing/suits/misc_ert.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/misc_ert.dmi',
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	flags_item = NO_CRYO_STORE
	flags_marine_armor = ARMOR_LAMP_OVERLAY
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bomb = CLOTHING_ARMOR_GIGAHIGH


//=========================//PROVOST\\================================\\
//=======================================================================\\

/obj/item/clothing/suit/storage/marine/MP/provost
	name = "\improper M3 pattern MP urban armor"
	desc = "标准M3型胸甲。保护胸部免受子弹、利器和意外伤害。附带一个小皮袋，提供有限的储物空间。"
	icon_state = "pvmedium"
	item_state_slots = list(WEAR_JACKET = "pvmedium")
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UA.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UA.dmi'
	)
	slowdown = SLOWDOWN_ARMOR_LIGHT
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	storage_slots = 3

/obj/item/clothing/suit/storage/marine/MP/provost/tml
	name = "\improper M3 pattern Senior MP armor"
	desc = "为高级军官准备的更精良的M3型胸甲。保护胸部免受子弹、利器和意外伤害。附带一个小皮袋，提供有限的储物空间。"
	icon_state = "pvleader"
	item_state_slots = list(WEAR_JACKET = "pvleader")

/obj/item/clothing/suit/storage/marine/MP/provost/marshal
	name = "\improper M3 Pattern Marshal Chestplate"
	desc = "一款颜色更深、带有金色点缀的M3型胸甲，便于清晰识别。有助于让你的部下在战场上知道谁是指挥官。"
	icon_state = "pvmarshal"
	item_state_slots = list(WEAR_JACKET = "pvmarshal")
	w_class = SIZE_MEDIUM
	storage_slots = 4

/obj/item/clothing/suit/storage/marine/MP/provost/light
	name = "\improper M3 pattern MP chestplate"
	desc = "采用城市迷彩图案的宪兵M3型胸甲。保护胸部免受子弹、利器和意外伤害。附带一个小皮袋，提供有限的储物空间。"
	icon_state = "pvlight"
	item_state_slots = list(WEAR_JACKET = "pvlight")
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT

/obj/item/clothing/suit/storage/marine/MP/provost/light/flexi
	name = "\improper M3 pattern light armor"
	desc = "一套标准的城市迷彩宪兵M3护甲。保护胸部免受子弹、利器和意外伤害。附带一个小皮袋，提供有限的储物空间。"
	w_class = SIZE_MEDIUM
	icon_state = "pvlight_2"
	item_state_slots = list(WEAR_JACKET = "pvlight_2")
	storage_slots = 2

//================//UNITED AMERICAS RIOT CONTROL\\=====================\\
//=======================================================================\\

/obj/item/clothing/suit/storage/marine/veteran/ua_riot
	name = "\improper UA-M1 body armor"
	desc = "UA-M1防弹衣基于USCM采用的M-3型设计，供UA安保、防暴和破坏工会的团队使用。虽然对近战和子弹攻击有较强防护，但其致命缺陷是缺乏对腿部和手臂的覆盖。"
	icon_state = "ua_riot"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UA.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UA.dmi'
	)
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT  // it's lighter
	uniform_restricted = list(/obj/item/clothing/under/marine/ua_riot)
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/suit/storage/marine/veteran/ua_riot/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/clothing/suit/storage/marine/veteran/ua_riot/synth
	name = "\improper UA-M1S Synthetic body armor"
	desc = "UA-M1防弹衣基于USCM采用的M-3型设计，供UA安保、防暴和破坏工会的团队使用。UA-1MS改型符合合成人程序规范，牺牲了防护以换取速度和携行能力。"
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_NONE
	slowdown = SLOWDOWN_ARMOR_SUPER_LIGHT
	storage_slots = 3
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	flags_marine_armor = ARMOR_SQUAD_OVERLAY|ARMOR_LAMP_OVERLAY|SYNTH_ALLOWED

//================//=ROYAL MARINES=\\====================================\\
//=======================================================================\\

/obj/item/clothing/suit/storage/marine/veteran/royal_marine
	name = "红隼装甲背心"
	desc = "三世界帝国皇家海军陆战队突击队使用的可定制个人护甲系统。维兰德-汤谷子公司林登塔尔-埃伦费尔德军事工业的设计师们在其德科尼加拉实验室，基于USCMC的M3型个人护甲进行迭代，打造出这套旨在满足三世界帝国规模更小但装备更精良的皇家海军陆战队独特需求的护甲系统。"
	icon_state = "rmc_light"
	item_state = "rmc_light"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/TWE.dmi'
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/ammo_magazine/,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/explosive/grenade,
		/obj/item/storage/bible,
		/obj/item/weapon/sword/machete,
		/obj/item/attachable/bayonet,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
	)

/obj/item/clothing/suit/storage/marine/veteran/royal_marine/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/suit/storage/marine/veteran/royal_marine/light //RMC Rifleman Armor
	icon_state = "rmc_light"
	item_state = "rmc_light"
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	slowdown = SLOWDOWN_ARMOR_LIGHT

/obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/team_leader //RMC TL & LT Armor
	name = "红隼装甲携行背心"
	icon_state = "rmc_light_padded"
	item_state = "rmc_light_padded"
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_LEGS
	storage_slots = 7

/obj/item/clothing/suit/storage/marine/veteran/royal_marine/smartgun //Smartgun Spec Armor
	name = "红隼装甲智能枪背带"
	icon_state = "rmc_smartgun"
	item_state = "rmc_smartgun"
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_LEGS
	flags_inventory = BLOCKSHARPOBJ|BLOCK_KNOCKDOWN|SMARTGUN_HARNESS

/obj/item/clothing/suit/storage/marine/veteran/royal_marine/pointman //Pointman Spec Armor
	name = "红隼尖兵护甲"
	desc = "三世界帝国皇家海军陆战队突击队所用护甲系统的重型版本。维兰德-汤谷子公司林登塔尔-埃伦费尔德军事工业的设计师们在其德科尼加拉实验室，基于USCMC的M3型个人护甲进行迭代，打造出这套旨在满足三世界帝国规模更小但装备更精良的皇家海军陆战队独特需求的护甲系统。"
	icon_state = "rmc_pointman"
	item_state = "rmc_pointman"
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_bomb = CLOTHING_ARMOR_HIGHPLUS
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	storage_slots = 7
	slowdown = SLOWDOWN_ARMOR_LOWHEAVY
	movement_compensation = SLOWDOWN_ARMOR_MEDIUM

/atom/movable/marine_light
	light_system = DIRECTIONAL_LIGHT

//======================//=IASF=\\==============================\\
//===============================================================\\

/obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/iasf

	name = "苍鹰空降背心"
	desc = "一款为帝国武装太空部队空降兵设计的轻量化高机动防弹背心。由阿尔法科技开发的苍鹰背心在确保伞兵高风险空降时拥有完全行动自由的同时，提供关键防护。先进的复合装甲板和强化织带使其能有效抵御破片和小口径武器火力，为那些快速、强力突击的士兵在防御与敏捷性之间取得了完美平衡。"
	icon_state = "iasf_light"
	item_state = "iasf_light"
	storage_slots = 3

	armor_melee = CLOTHING_ARMOR_MEDIUMLOW // Goon stats
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM

	flags_armor_protection = (BODY_FLAG_CHEST)
	flags_cold_protection = (BODY_FLAG_CHEST)
	flags_heat_protection = (BODY_FLAG_CHEST)

	slowdown = SLOWDOWN_ARMOR_SUPER_LIGHT // Gotta go fast

/obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/iasf/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/alphatech)

/obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/iasf/synth

	name = "苍鹰空降合成人背心"
	desc = "一款为帝国武装太空部队空降兵设计的轻量化高机动防弹背心。由阿尔法科技开发的苍鹰背心在确保伞兵高风险空降时拥有完全行动自由的同时，提供关键防护。先进的复合装甲板和强化织带使其能有效抵御破片和小口径武器火力，为那些快速、强力突击的士兵在防御与敏捷性之间取得了完美平衡。"
	icon_state = "iasf_light"
	item_state = "iasf_light"
	time_to_unequip = 0.5 SECONDS
	time_to_equip = 1 SECONDS
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_NONE
	storage_slots = 4
	slowdown = SLOWDOWN_ARMOR_SUPER_LIGHT
	flags_marine_armor = parent_type::flags_marine_armor|SYNTH_ALLOWED

//CBRN

/obj/item/clothing/suit/storage/marine/cbrn
	name = "\improper M3-M armor"
	desc = "虽然缺乏常规服役的M3型护甲的外观，但这件护甲仍是其衍生产品。它经过大幅改装以适应MOPP防护服，移除了额外的衬垫和维纳拉复合层，以免限制穿戴者的行动。然而，随着复合层的减少，其提供的个人防护效果不尽如人意，自2165年以来便一直有相关投诉。"
	icon_state = "cbrn"
	item_state = "cbrn"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UA.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UA.dmi'
	)
	slowdown = SLOWDOWN_ARMOR_HEAVY
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad =CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_marine_armor = NO_FLAGS
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	flags_inventory = BLOCKSHARPOBJ
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	uniform_restricted = list(/obj/item/clothing/under/marine/cbrn)

/obj/item/clothing/suit/storage/marine/cbrn/advanced
	slowdown = SLOWDOWN_ARMOR_LOWHEAVY
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_ULTRAHIGH
	armor_bio = CLOTHING_ARMOR_GIGAHIGHPLUS
	armor_rad = CLOTHING_ARMOR_GIGAHIGHPLUS
	armor_internaldamage = CLOTHING_ARMOR_HIGHPLUS
