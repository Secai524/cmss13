/*
 * Job related
 */

//Botonist
/obj/item/clothing/suit/apron
	name = "apron"
	desc = "一件基本的蓝色围裙。"
	icon_state = "apron"
	item_state = "apron"
	icon = 'icons/obj/items/clothing/suits/vests_aprons.dmi'
	blood_overlay_type = "armor"
	flags_armor_protection = 0
	allowed = list (
		/obj/item/reagent_container/spray/plantbgone,
		/obj/item/device/analyzer/plant_analyzer,
		/obj/item/seeds,/obj/item/reagent_container/glass/fertilizer,
		/obj/item/tool/minihoe,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/pen,
	)
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/vests_aprons.dmi',
	)

//Cultist
/obj/item/clothing/suit/cultist_hoodie
	name = "黑色长袍"
	desc = "看起来诡异而古怪，几乎像是属于某个邪教。"
	icon_state = "chaplain_hoodie"
	item_state = "chaplain_hoodie"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_GROIN

	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_GROIN
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROT

	allowed = list(
		/obj/item/weapon/gun/,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/storage/bible,
		/obj/item/attachable/bayonet,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/large_holster/katana,
		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
		/obj/item/storage/belt/gun/smartpistol,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
	)

	armor_bio = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_HARDCORE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW

	slowdown = SLOWDOWN_ARMOR_LIGHT
	time_to_equip = 2 SECONDS

//Chaplain
/obj/item/clothing/suit/nun
	name = "修女长袍"
	desc = "本星系最虔诚的象征。"
	icon_state = "nun"
	item_state = "nun"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	flags_inv_hide = HIDESHOES|HIDEJUMPSUIT
	allowed = list(
		/obj/item/weapon/gun,
	)
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)

//Chef
/obj/item/clothing/suit/chef
	name = "厨师围裙"
	desc = "高级厨师使用的围裙。"
	icon_state = "chef"
	item_state = "chef"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	gas_transfer_coefficient = 0.90

	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS
	allowed = list (
		/obj/item/tool/kitchen/knife,
		/obj/item/tool/kitchen/knife/butcher,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/pen,
	)
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)

//Chef
/obj/item/clothing/suit/chef/classic
	name = "一件经典的厨师围裙"
	desc = "一件基本、单调的白色厨师围裙。"
	icon_state = "apronchef"
	item_state = "apronchef"
	icon = 'icons/obj/items/clothing/suits/vests_aprons.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/vests_aprons.dmi',
	)
	blood_overlay_type = "armor"
	flags_armor_protection = 0
	allowed = list (
		/obj/item/tool/kitchen/knife,
		/obj/item/tool/kitchen/knife/butcher,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/pen,
	)

/obj/item/clothing/suit/chef/classic/stain
	icon_state = "apronchef_stain"
	item_state = "apronchef_stain"

//Detective
/obj/item/clothing/suit/storage/CMB/trenchcoat
	name = "\improper tan trench-coat"
	desc = "一件破旧的、棕褐色的老式风衣。黑色电影风格服饰的经典之作。"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)
	icon_state = "trench_tan"
	item_state = "trench_tan"
	uniform_restricted = null

/obj/item/clothing/suit/storage/CMB/trenchcoat/brown

	name = "\improper brown trench-coat"
	desc = "一件破旧的、棕色的老式风衣。当流浪汉看到混蛋来了，他可不会久留。"
	icon_state = "trench_brown"
	item_state = "trench_brown"

/obj/item/clothing/suit/storage/CMB/trenchcoat/grey
	name = "\improper grey trench-coat"
	desc = "一件破旧的、棕色的老式风衣。当流浪汉看到混蛋来了，他可不会久留。"
	icon_state = "trench_grey"
	item_state = "trench_grey"

/obj/item/clothing/suit/storage/CMB/trenchcoat/police
	name = "\improper tan police trench-coat"
	desc = "一件带有徽章的浅褐色外套。通常由政府指派的犯罪现场调查员而非私家侦探穿着，这套服装能让看到它的人感受到权威。"
	icon_state = "detective"
	item_state = "detective"

/obj/item/clothing/suit/storage/CMB/trenchcoat/police/black
	name = "\improper black police trench-coat"
	desc = "一件带有徽章的浅黑色外套。通常由政府指派的犯罪现场调查员而非私家侦探穿着，这套服装能让看到它的人感受到权威。"
	icon_state = "detective2"
	item_state = "detective2"

//Forensics
/obj/item/clothing/suit/storage/forensics
	name = "jacket"
	desc = "一件法医技术员夹克。"
	item_state = "det_suit"
	icon = 'icons/obj/items/clothing/suits/jackets.dmi'
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS
	allowed = list(
		/obj/item/device/analyzer,
		/obj/item/device/multitool,
		/obj/item/device/pipe_painter,
		/obj/item/device/radio,
		/obj/item/device/t_scanner,
		/obj/item/tool/crowbar,
		/obj/item/tool/screwdriver,
		/obj/item/tool/weldingtool,
		/obj/item/tool/wirecutters,
		/obj/item/tool/wrench,
		/obj/item/clothing/mask/gas,

		/obj/item/weapon/gun,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/weapon/baton,
		/obj/item/ammo_magazine,
		/obj/item/ammo_casing,
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
		/obj/item/device/taperecorder,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/crew_monitor,
		/obj/item/tool/pen,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/large_holster/katana,
		/obj/item/device/motiondetector,
	)
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/jackets.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)

/obj/item/clothing/suit/storage/forensics/red
	name = "红色夹克"
	desc = "一件红色的法医技术员夹克。"
	icon_state = "forensics_red"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)

/obj/item/clothing/suit/storage/forensics/blue
	name = "蓝色夹克"
	desc = "一件蓝色的法医技术员夹克。"
	icon_state = "forensics_blue"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)

//Engineering
/obj/item/clothing/suit/storage/hazardvest
	name = "橙色危险背心"
	desc = "一件用于工作区域的橙色高能见度背心。"
	icon_state = "hazard"
	item_state = "hazard"
	icon = 'icons/obj/items/clothing/suits/vests_aprons.dmi'
	blood_overlay_type = "armor"
	allowed = list (
		/obj/item/device/analyzer,
		/obj/item/device/multitool,
		/obj/item/device/pipe_painter,
		/obj/item/device/radio,
		/obj/item/device/t_scanner,
		/obj/item/tool/crowbar,
		/obj/item/tool/screwdriver,
		/obj/item/tool/weldingtool,
		/obj/item/tool/wirecutters,
		/obj/item/tool/wrench,
		/obj/item/clothing/mask/gas,

		/obj/item/weapon/gun,
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
		/obj/item/storage/large_holster/katana,
		/obj/item/device/motiondetector,
	)
	flags_armor_protection = BODY_FLAG_CHEST
	flags_bodypart_hidden = BODY_FLAG_CHEST
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/vests_aprons.dmi',
	)

/obj/item/clothing/suit/storage/hazardvest/blue
	name = "蓝色危险背心"
	desc = "一种在工作区域使用的蓝色高可见度背心。"
	icon_state = "hazard_blue"
	item_state = "hazard_blue"

/obj/item/clothing/suit/storage/hazardvest/yellow
	name = "黄色警示背心"
	desc = "一种在工作区域使用的黄色高可见度背心。"
	icon_state = "hazard_yellow"
	item_state = "hazard_yellow"

/obj/item/clothing/suit/storage/hazardvest/black
	name = "黑色警示背心"
	desc = "一款小众市场、黑色、据称是高可见度的背心，据称用于工作区域。配有额外反光条。背心上的标签坚称其完全符合所有美利坚合众国工作场所安全标准。"
	icon_state = "hazard_black"
	item_state = "hazard_black"

//Lawyer
/obj/item/clothing/suit/storage/jacket/marine/lawyer
	desc = "一件时髦的正装外套。"
	icon = 'icons/obj/items/clothing/suits/jackets.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/jackets.dmi',
	)
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS

	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	valid_accessory_slots = list(ACCESSORY_SLOT_ARMBAND, ACCESSORY_SLOT_DECOR, ACCESSORY_SLOT_MEDAL)
	has_buttons = TRUE
	blood_overlay_type = "coat"

/obj/item/clothing/suit/storage/jacket/marine/lawyer/bluejacket
	name = "蓝色正装外套"
	icon_state = "suitjacket_blue"
	initial_icon_state = "suitjacket_blue"

/obj/item/clothing/suit/storage/jacket/marine/lawyer/purpjacket
	name = "紫色正装外套"
	icon_state = "suitjacket_purp"
	initial_icon_state = "suitjacket_purp"

/obj/item/clothing/suit/storage/jacket/marine/lawyer/redjacket
	name = "红色正装外套"
	icon_state = "suitjacket_red"
	initial_icon_state = "suitjacket_red"

/obj/item/clothing/suit/storage/jacket/marine/lawyer/blackjacket
	name = "黑色正装外套"
	icon_state = "suitjacket_black"
	initial_icon_state = "suitjacket_black"

/obj/item/clothing/suit/storage/jacket/marine/lawyer/comedian
	name = "亮红色正装外套"
	icon_state = "suitjacket_comedian"
	initial_icon_state = "suitjacket_comedian"

/obj/item/clothing/suit/storage/jacket/marine/lawyer/brown
	name = "棕色正装外套"
	icon_state = "suitjacket_brown"
	initial_icon_state = "suitjacket_brown"

/obj/item/clothing/suit/storage/jacket/marine/lawyer/light_brown
	name = "浅棕色正装外套"
	icon_state = "suitjacket_lightbrown"
	initial_icon_state = "suitjacket_lightbrown"

//Windbreakers
/obj/item/clothing/suit/storage/windbreaker
	name = "防风夹克父对象"
	desc = "这东西不该出现在这里..."
	icon = 'icons/obj/items/clothing/suits/windbreakers.dmi'
	blood_overlay_type = "armor"
	allowed = list(
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
		/obj/item/weapon/gun,

		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/crew_monitor,
		/obj/item/tool/pen,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/large_holster/katana,
		/obj/item/device/motiondetector,
	)
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_ARMS
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_ARMS
	var/zip_unzip = FALSE
	actions_types = list(/datum/action/item_action/toggle)
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/windbreakers.dmi',
	)

/obj/item/clothing/suit/storage/windbreaker/attack_self(mob/user) //Adds UI button
	..()

	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user
	if(H.wear_suit != src)
		return

	playsound(user, "sound/items/zip.ogg", 10, TRUE)
	zip_unzip(user)

/obj/item/clothing/suit/storage/windbreaker/proc/zip_unzip(mob/user)

	if(zip_unzip)
		icon_state = initial(icon_state)
		to_chat(user, SPAN_NOTICE("你拉上了\the [src]的拉链。"))

	else
		icon_state = "[initial(icon_state)]_o"
		to_chat(user, SPAN_NOTICE("你拉开了\the [src]的拉链。"))
	zip_unzip = !zip_unzip

	update_clothing_icon()

/obj/item/clothing/suit/storage/windbreaker/windbreaker_brown
	name = "棕色防风夹克"
	desc = "一件棕色防风夹克。"
	icon_state = "windbreaker_brown"

/obj/item/clothing/suit/storage/windbreaker/windbreaker_gray
	name = "灰色防风夹克"
	desc = "一件灰色防风夹克。"
	icon_state = "windbreaker_gray"

/obj/item/clothing/suit/storage/windbreaker/windbreaker_green
	name = "绿色防风夹克"
	desc = "一件绿色防风夹克。"
	icon_state = "windbreaker_green"

/obj/item/clothing/suit/storage/windbreaker/windbreaker_fr
	name = "急救员防风夹克"
	desc = "一件带有反光条的棕色防风夹克，通常由急救员穿着。"
	icon_state = "windbreaker_fr"

/obj/item/clothing/suit/storage/windbreaker/windbreaker_covenant
	name = "探险者风衣"
	desc = "一件棕色的风衣，上面缝满了各种徽章，表明它与对该星区的首次探索有关。"
	icon_state = "windbreaker_covenant"

//Suspenders
/obj/item/clothing/suit/suspenders
	name = "suspenders"
	gender = PLURAL
	desc = "它们能挂住裤子。"
	icon = 'icons/obj/items/clothing/belts/misc.dmi'
	icon_state = "suspenders"
	blood_overlay_type = "armor"
	flags_armor_protection = 0
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/belts/misc.dmi',
	)
