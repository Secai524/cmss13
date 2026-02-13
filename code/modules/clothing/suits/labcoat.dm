/obj/item/clothing/suit/storage/labcoat
	name = "实验服"
	desc = "一件能防护轻微化学品泼溅的服装。"
	icon_state = "labcoat"
	item_state = "labcoat" //Is this even used for anything?
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	blood_overlay_type = "coat"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS
	allowed = list(
		/obj/item/device/analyzer,
		/obj/item/stack/medical,
		/obj/item/reagent_container/dropper,
		/obj/item/reagent_container/syringe,
		/obj/item/reagent_container/hypospray,
		/obj/item/reagent_container/glass/bottle,
		/obj/item/reagent_container/glass/beaker,
		/obj/item/reagent_container/pill,
		/obj/item/storage/pill_bottle,
		/obj/item/paper,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/tool/surgery/synthgraft,
		/obj/item/tool/surgery/hemostat,
		/obj/item/tool/surgery/cautery,
		/obj/item/tool/surgery/retractor,
		/obj/item/tool/surgery/surgicaldrill,
		/obj/item/tool/surgery/circular_saw,
		/obj/item/tool/surgery/scalpel,
		/obj/item/tool/surgery/FixOVein,
		/obj/item/tool/surgery/bonesetter,
		/obj/item/roller,
		/obj/item/tool/surgery/bonegel,
		/obj/item/stack/nanopaste,
		/obj/item/reagent_container/blood,
		/obj/item/reagent_container/spray/cleaner,

		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,
		/obj/item/storage/backpack/general_belt,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/crew_monitor,
		/obj/item/tool/pen,
		/obj/item/storage/large_holster/machete,
		/obj/item/device/motiondetector,

	)
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	var/buttoned = TRUE
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi'
	)


/obj/item/clothing/suit/storage/labcoat/verb/toggle()
	set name = "Toggle Lab Coat Buttons"
	set category = "Object"
	set src in usr

	if(usr.is_mob_incapacitated())
		return 0

	if(src.buttoned == TRUE)
		src.icon_state = "[initial(icon_state)]_open"
		src.buttoned = FALSE
	else
		src.icon_state = initial(icon_state) //doesn't need to be a string
		src.buttoned = TRUE
	update_clothing_icon()

/obj/item/clothing/suit/storage/labcoat/red
	name = "红色实验服"
	desc = "一件能防护轻微化学品泼溅的服装。这件是红色的。"
	icon_state = "red_labcoat"
	item_state = "red_labcoat"

/obj/item/clothing/suit/storage/labcoat/blue
	name = "蓝色实验服"
	desc = "一件能防护轻微化学品泼溅的服装。这件是蓝色的。"
	icon_state = "blue_labcoat"
	item_state = "blue_labcoat"

/obj/item/clothing/suit/storage/labcoat/purple
	name = "紫色实验服"
	desc = "一件能防护轻微化学品泼溅的服装。这件是紫色的。"
	icon_state = "purple_labcoat"
	item_state = "purple_labcoat"

/obj/item/clothing/suit/storage/labcoat/orange
	name = "橙色实验服"
	desc = "一件能防护轻微化学品泼溅的服装。这件是橙色的。"
	icon_state = "orange_labcoat"
	item_state = "orange_labcoat"

/obj/item/clothing/suit/storage/labcoat/green
	name = "绿色实验服"
	desc = "一件能防护轻微化学品泼溅的服装。这件是绿色的。"
	icon_state = "green_labcoat"
	item_state = "green_labcoat"

/obj/item/clothing/suit/storage/labcoat/mad
	name = "狂人的实验服"
	desc = "它让你看起来像是能把人敲晕然后发射到太空里去。"
	icon_state = "labgreen"
	item_state = "labgreen"

/obj/item/clothing/suit/storage/labcoat/genetics
	name = "遗传学家实验服"
	desc = "一件能防护轻微化学品泼溅的服装。肩部有一条蓝色条纹。"
	icon_state = "labcoat_gen"

/obj/item/clothing/suit/storage/labcoat/pharmacist
	name = "药物医师实验服"
	desc = "一件能防护轻微化学品泼溅的服装。每个肩部都有一条橙色条纹。"
	icon_state = "labcoat_pharm"

/obj/item/clothing/suit/storage/labcoat/virologist
	name = "病毒学家实验服"
	desc = "一件能防护轻微化学品泼溅的服装。比标准型号提供稍好一些的生物危害防护。肩部有一条绿色条纹。"
	icon_state = "labcoat_vir"
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/storage/labcoat/science
	name = "科学家实验服"
	desc = "一件能防护轻微化学品泼溅的服装。肩部有一条紫色条纹。"
	icon_state = "labcoat_tox"

/obj/item/clothing/suit/storage/labcoat/cmo
	name = "首席医疗官实验服"
	desc = "一件长款、绿色、光滑且坚固的实验服，旨在区分高级医疗人员。其面料能提供额外的化学和生物危害防护。"
	icon_state = "labcoatg"
	item_state = "labcoatg"
	armor_bio = CLOTHING_ARMOR_MEDIUM

/obj/item/clothing/suit/storage/labcoat/researcher
	name = "研究员实验服"
	desc = "一件高品质的实验服，似乎是学者和研究员所穿。它有一种独特的皮革质感，并驱使你走向冒险。"
	icon_state = "sciencecoat"
	item_state = "sciencecoat"

/obj/item/clothing/suit/storage/labcoat/wy
	name = "维兰德研究员实验服"
	desc = "一件高品质的公司实验服，似乎是科学顾问和研究员所穿。采用坚固材料制成，用于进行危险实验。"
	icon_state = "wy_rc_labcoat"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/WY.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/WY.dmi'
	)
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/storage/labcoat/wy/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/suit/chef/classic/medical
	name = "医疗围裙"
	desc = "一件基本且无菌的白色围裙，适用于外科手术，当然也适用于其他医疗操作。"

/obj/item/clothing/suit/storage/snow_suit
	name = "雪地服"
	desc = "一套标准雪地服。它可以保护穿戴者免受极寒侵袭。"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)
	icon_state = "snowsuit"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	blood_overlay_type = "armor"
	siemens_coefficient = 0.7

/obj/item/clothing/suit/storage/snow_suit/doctor
	name = "医生雪地服"

/obj/item/clothing/suit/storage/snow_suit/synth
	name = "合成人雪地服"
	desc = "一种为合成人单位设计的雪地服，用于在极寒环境中将其温度保持在可接受范围内，以防止电源效率降低。由于合成人隔热技术的进步，在大多数寒冷环境中并不需要它。"
	armor_melee = CLOTHING_ARMOR_NONE //no free armor for synths
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_NONE
	allowed = list(
		/obj/item/weapon/gun/,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,
		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
		/obj/item/storage/belt/gun/mateba,
		/obj/item/storage/belt/gun/smartpistol,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/crew_monitor,
		/obj/item/tool/pen,
		/obj/item/storage/large_holster/machete,
		/obj/item/device/motiondetector,
	)

/obj/item/clothing/suit/storage/snow_suit/survivor
	name = "强化雪地服"
	icon_state = "snowsuit" //needs new cool sprite
	desc = "一套雪地服。它可以保护穿戴者免受极寒侵袭。这套似乎经过了一些改装，既可以挂载枪械，也能容纳弹匣。"
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/explosive/grenade,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,
		/obj/item/storage/large_holster/machete,
		/obj/item/weapon/baseballbat,
		/obj/item/weapon/baseballbat/metal,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
	)

/obj/item/clothing/suit/storage/snow_suit/survivor/Initialize()
	. = ..()
	pockets.max_w_class = SIZE_SMALL //Can contain small items AND rifle magazines.
	pockets.bypass_w_limit = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg,
		/obj/item/ammo_magazine/sniper,
	)
	pockets.max_storage_space = 8

/obj/item/clothing/suit/storage/snow_suit/survivor/parka
	name = "派克大衣"
	desc = "一件为抵御北极荒漠严寒天气而制的冬季外套。维兰德品牌派克大衣。"

/obj/item/clothing/suit/storage/snow_suit/survivor/parka/red
	name = "安保派克大衣"
	icon_state = "redpark"

/obj/item/clothing/suit/storage/snow_suit/survivor/parka/navy
	name = "海军派克大衣"
	icon_state = "navypark"

/obj/item/clothing/suit/storage/snow_suit/survivor/parka/yellow
	name = "黄色派克大衣"
	icon_state = "yellowpark"

/obj/item/clothing/suit/storage/snow_suit/survivor/parka/green
	name = "绿色派克大衣"
	icon_state = "greenpark"

/obj/item/clothing/suit/storage/snow_suit/survivor/parka/purple
	name = "紫色派克大衣"
	icon_state = "purplepark"

/obj/item/clothing/suit/storage/snow_suit/soviet
	name = "苏维埃雪地大衣"
	desc = "一件在某个荒凉雪原星球制造的冬季大衣。这件冬衣由当地野生动物的皮毛制成，它们为UPP的伟大事业贡献了自己的皮毛！"
	icon_state = "sovietcoat"
	item_state = "sovietcoat"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/UPP.dmi'
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	blood_overlay_type = "armor"
	siemens_coefficient = 0.7
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/explosive/grenade,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,
		/obj/item/storage/large_holster/machete,
		/obj/item/weapon/baseballbat,
		/obj/item/weapon/baseballbat/metal,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
	)
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/UPP.dmi'
	)


/obj/item/clothing/suit/storage/snow_suit/liaison
	name = "联络官冬季大衣"
	desc = "一件维兰德-汤谷的冬季大衣。只为联络官在寒冷环境中提供最佳舒适度。"
	icon_state = "snowsuit_liaison"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/WY.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/WY.dmi'
	)

/obj/item/clothing/suit/storage/snow_suit/liaison/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/suit/storage/snow_suit/liaison/modified
	name = "改装型联络官冬季大衣"
	desc = "一件维兰德-汤谷的冬季大衣。这件经过改装，可以携带枪支和其他物品。只为在寒冷、敌对环境中求生的联络官提供最佳的舒适度和实用性。"
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/explosive/grenade,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,
		/obj/item/storage/large_holster/machete,
		/obj/item/weapon/baseballbat,
		/obj/item/weapon/baseballbat/metal,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
	)

/obj/item/clothing/suit/storage/labcoat/brown
	name = "棕色实验服"
	desc = "一套能防护轻微化学泄漏的服装。这件是棕色的。"
	icon_state = "labcoat_brown"
	item_state = "labcoat_brown"

/obj/item/clothing/suit/storage/labcoat/short
	name = "高开衩实验服"
	desc = "一套能防护轻微化学泄漏的服装。这件腿部暴露得更多一些。"
	icon_state = "labcoat_short"
	item_state = "labcoat_short"

/obj/item/clothing/suit/storage/labcoat/long
	name = "低开衩实验服"
	desc = "一套能防护轻微化学泄漏的服装。这件下摆垂得很低。"
	icon_state = "labcoat_long"
	item_state = "labcoat_long"

