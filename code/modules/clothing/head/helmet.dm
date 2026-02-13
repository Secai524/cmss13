/obj/item/clothing/head/helmet
	name = "helmet"
	desc = "标准安保装备。保护头部免受冲击。"
	icon_state = "helmet"
	item_state = "helmet"
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_atom = FPRINT|CONDUCT
	flags_inventory = COVEREYES|BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEEYES
	flags_cold_protection = BODY_FLAG_HEAD
	flags_heat_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = HELMET_MIN_COLD_PROT
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROT
	siemens_coefficient = 0.7
	w_class = SIZE_MEDIUM
	pickup_sound = "armorequip"
	drop_sound = "armorequip"

/obj/item/clothing/head/helmet/verb/hidehair()
	set name = "Toggle Hair"
	set category = "Object"
	set src in usr
	if(!isliving(usr))
		return
	if(usr.stat)
		return

	if(flags_inv_hide & HIDETOPHAIR)
		flags_inv_hide &= ~HIDETOPHAIR
		to_chat(usr, "你将头发从[src]中散开。")
	else
		flags_inv_hide |= HIDETOPHAIR
		to_chat(usr, "你将头发塞进\the [src]里。")

	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		if(H.head == src)
			H.update_hair()

/obj/item/clothing/head/helmet/riot
	name = "防暴头盔"
	desc = "这是一种专门设计用于防护近距离攻击的头盔。它覆盖了你的耳朵。"
	icon_state = "riot"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	flags_inventory = COVEREYES|BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEEYES|HIDETOPHAIR

/obj/item/clothing/head/helmet/riot/vintage_riot
	desc = "一顶布满蛛网的带伤防暴头盔。它仍然保护着你的耳朵。"
	icon_state = "old_riot"
	icon = 'icons/obj/items/clothing/hats/hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats.dmi',
	)

/obj/item/clothing/head/helmet/augment
	name = "增强阵列"
	desc = "一顶连接了视觉与颅脑增强装置的头盔。"
	icon_state = "v62"
	item_state = "v62"
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_MEDIUM
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	siemens_coefficient = 0.5

/obj/item/clothing/head/helmet/warden
	name = "典狱长帽"
	desc = "这是颁发给安保部队典狱长的特殊头盔。保护头部免受冲击。"
	icon_state = "policehelm"
	flags_inventory = NO_FLAGS
	flags_inv_hide = NO_FLAGS
	flags_armor_protection = 0

/obj/item/clothing/head/helmet/hop
	name = "船员资源部帽子"
	desc = "一顶时髦的帽子，既能保护你免受愤怒的前船员伤害，又能给你一种虚假的权威感。"
	icon_state = "hopcap"
	flags_inventory = NO_FLAGS
	flags_inv_hide = NO_FLAGS
	flags_armor_protection = 0

/obj/item/clothing/head/helmet/swat
	name = "\improper SWAT helmet"
	desc = "它们常被训练有素的SWAT成员使用。"
	icon_state = "swat"
	item_state = "swat"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_MEDIUM
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_inventory = COVEREYES|BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEEYES
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROT
	siemens_coefficient = 0.5
	anti_hug = 1

/obj/item/clothing/head/helmet/gladiator
	name = "角斗士头盔"
	desc = "Ave, Imperator, morituri te salutant.（万岁，皇帝，赴死者向您致敬。）"
	icon_state = "gladiator"
	item_state = "gladiator"
	flags_inventory = COVEREYES|BLOCKSHARPOBJ
	flags_inv_hide = HIDEMASK|HIDEEARS|HIDEEYES|HIDEALLHAIR
	siemens_coefficient = 1
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM

/obj/item/clothing/head/helmet/roman
	name = "\improper imperial galea helmet"
	desc = "一顶极其古老的头盔，曾被罗马重型步兵单位——军团士兵使用。"
	icon_state = "legionary_helm"
	item_state = "legionary_helm"
	icon = 'icons/obj/items/clothing/hats/misc_ert_colony.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/misc_ert_colony.dmi'
	)
	flags_inventory = COVEREYES|BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEEYES
	siemens_coefficient = 1
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH

/obj/item/clothing/head/helmet/roman/centurion
	desc = "一顶极其古老的头盔，曾被罗马重型步兵单位——军团士兵使用。这顶头盔上的羽饰表明它曾被百夫长使用。"
	icon_state = "centurion_helm"
	item_state = "centurion_helm"
	worn_x_dimension = 64
	worn_y_dimension = 64
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/head_64.dmi'
	)


/obj/item/clothing/head/helmet/roman/eaglebearer
	name = "\improper Aquilifier's bear pelt mask"
	desc = "一张熊皮和面具，曾由罗马鹰帜手佩戴，这是一个旨在战斗中激励部队的显赫角色。"
	icon_state = "eaglebearer_hat"
	item_state = "eaglebearer_hat"
	worn_x_dimension = 64
	worn_y_dimension = 64
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/head_64.dmi'
	)
	flags_inv_hide = HIDEMASK|HIDEEARS|HIDEEYES
	anti_hug = 1

//===========================//MARINES HELMETS\\=================================\\
//=======================================================================\\

GLOBAL_LIST_INIT(allowed_helmet_items, list(
	// TOBACCO-RELATED
	/obj/item/tool/lighter/random = NO_GARB_OVERRIDE,
	/obj/item/tool/lighter/zippo = NO_GARB_OVERRIDE,
	/obj/item/storage/box/matches = NO_GARB_OVERRIDE,
	/obj/item/storage/fancy/cigarettes/emeraldgreen = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/storage/fancy/cigarettes/kpack = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/storage/fancy/cigarettes/lucky_strikes = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/storage/fancy/cigarettes/wypacket = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/storage/fancy/cigarettes/lady_finger = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/storage/fancy/cigarettes/blackpack = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/storage/fancy/cigarettes/arcturian_ace = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/storage/fancy/cigarettes/lucky_strikes_4 = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/storage/fancy/cigarettes/spirit = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/storage/fancy/cigarettes/spirit/yellow = PREFIX_HELMET_GARB_OVERRIDE, // helmet_

	/obj/item/storage/fancy/cigar/matchbook = NO_GARB_OVERRIDE,
	/obj/item/clothing/mask/cigarette/cigar = NO_GARB_OVERRIDE,
	/obj/item/clothing/mask/electronic_cigarette = NO_GARB_OVERRIDE,

	// CARDS
	/obj/item/toy/deck = NO_GARB_OVERRIDE,
	/obj/item/toy/deck/uno = NO_GARB_OVERRIDE,
	/obj/item/toy/handcard = NO_GARB_OVERRIDE,
	/obj/item/toy/handcard/aceofspades = NO_GARB_OVERRIDE,
	/obj/item/toy/handcard/uno_reverse_red = NO_GARB_OVERRIDE,
	/obj/item/toy/handcard/uno_reverse_blue = NO_GARB_OVERRIDE,
	/obj/item/toy/handcard/uno_reverse_yellow = NO_GARB_OVERRIDE,
	/obj/item/toy/handcard/uno_reverse_purple = NO_GARB_OVERRIDE,

	// FOOD AND SNACKS
	/obj/item/reagent_container/food/drinks/flask = NO_GARB_OVERRIDE,
	/obj/item/reagent_container/food/drinks/flask/marine = NO_GARB_OVERRIDE,
	/obj/item/reagent_container/food/snacks/eat_bar = NO_GARB_OVERRIDE,
	/obj/item/reagent_container/food/snacks/mushroompizzaslice = NO_GARB_OVERRIDE, // Fuck whoever put these under different paths for some REASON
	/obj/item/reagent_container/food/snacks/vegetablepizzaslice = NO_GARB_OVERRIDE,
	/obj/item/reagent_container/food/snacks/meatpizzaslice = NO_GARB_OVERRIDE,
	/obj/item/reagent_container/food/snacks/packaged_burrito = NO_GARB_OVERRIDE,
	/obj/item/reagent_container/food/snacks/packaged_hdogs = NO_GARB_OVERRIDE,
	/obj/item/reagent_container/food/snacks/wrapped/chunk = NO_GARB_OVERRIDE,
	/obj/item/reagent_container/food/snacks/donkpocket = NO_GARB_OVERRIDE,
	/obj/item/reagent_container/food/snacks/wrapped/booniebars = NO_GARB_OVERRIDE,
	/obj/item/reagent_container/food/snacks/wrapped/barcardine = NO_GARB_OVERRIDE,

	// EYEWEAR
	/obj/item/clothing/glasses/mgoggles = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/clothing/glasses/mgoggles/v2 = PREFIX_HELMET_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2/prescription = PREFIX_HELMET_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2/blue = PREFIX_HELMET_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2/blue/prescription = PREFIX_HELMET_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2/polarized_blue = PREFIX_HELMET_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2/polarized_blue/prescription = PREFIX_HELMET_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2/polarized_orange = PREFIX_HELMET_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2/polarized_orange/prescription = PREFIX_HELMET_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/prescription = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/clothing/glasses/mgoggles/black = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/clothing/glasses/mgoggles/black/prescription = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/clothing/glasses/mgoggles/orange = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/clothing/glasses/mgoggles/orange/prescription = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/clothing/glasses/mgoggles/blue = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/clothing/glasses/mgoggles/blue/prescription = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/clothing/glasses/mgoggles/purple = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/clothing/glasses/mgoggles/purple/prescription = PREFIX_HELMET_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/yellow = PREFIX_HELMET_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/yellow/prescription = PREFIX_HELMET_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/red = PREFIX_HELMET_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/red/prescription = PREFIX_HELMET_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/prescription = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/aviator = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/aviator/silver = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/big = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/big/new_bimex/black = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/big/new_bimex = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/big/new_bimex/bronze = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/big/fake = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/big/fake/red = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/big/fake/orange = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/big/fake/yellow = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/big/fake/green = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/big/fake/blue = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/sechud = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/sechud/blue = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/eyepatch = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/eyepatch/left = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/eyepatch/white = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/eyepatch/white/left = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/eyepatch/green = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/eyepatch/green/left = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/regular/hipster = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/regular/hippie = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/hippie = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/hippie/green = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/hippie/sunrise = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/hippie/sunset = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/hippie/nightblue = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/hippie/midnight = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/sunglasses/hippie/bloodred = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/regular = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mbcg = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/cmb_riot_shield = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/mp_riot_shield = NO_GARB_OVERRIDE,

	// WALKMAN AND CASSETTES
	/obj/item/device/walkman = NO_GARB_OVERRIDE,
	/obj/item/device/cassette_tape/pop1 = NO_GARB_OVERRIDE,
	/obj/item/device/cassette_tape/pop2 = NO_GARB_OVERRIDE,
	/obj/item/device/cassette_tape/pop3 = NO_GARB_OVERRIDE,
	/obj/item/device/cassette_tape/pop4 = NO_GARB_OVERRIDE,
	/obj/item/device/cassette_tape/heavymetal = NO_GARB_OVERRIDE,
	/obj/item/device/cassette_tape/hairmetal = NO_GARB_OVERRIDE,
	/obj/item/device/cassette_tape/indie = NO_GARB_OVERRIDE,
	/obj/item/device/cassette_tape/hiphop = NO_GARB_OVERRIDE,
	/obj/item/device/cassette_tape/nam = NO_GARB_OVERRIDE,
	/obj/item/device/cassette_tape/ocean = NO_GARB_OVERRIDE,
	/obj/item/storage/pouch/cassette = NO_GARB_OVERRIDE,

	// PREFERENCES GEAR
	/obj/item/prop/helmetgarb/gunoil = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/helmet/cover/netting = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/helmet/cover/netting/desert = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/helmet/cover/netting/jungle = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/helmet/cover/netting/urban = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/spent_buckshot = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/spent_slug = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/spent_flech = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/cartridge = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/prescription_bottle = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/helmet/cover/raincover = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/helmet/cover/raincover/jungle = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/helmet/cover/raincover/desert = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/helmet/cover/raincover/urban = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/rabbitsfoot = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/rosary = NO_GARB_OVERRIDE, // This one was already in the game for some reason, but never had an object
	/obj/item/prop/helmetgarb/lucky_feather = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/lucky_feather/blue = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/lucky_feather/purple = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/lucky_feather/yellow = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/trimmed_wire = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/helmet_nvg = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/prop/helmetgarb/helmet_nvg/cosmetic = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/prop/helmetgarb/helmet_nvg/marsoc = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/prop/helmetgarb/helmet_gasmask = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/flair_initech = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/flair_io = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/flair_peace = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/flair_uscm = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/bullet_pipe = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/spacejam_tickets = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/family_photo = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/compass = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/bug_spray = NO_GARB_OVERRIDE,

	// MISC
	/obj/item/tool/pen = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/tool/pen/blue = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/tool/pen/red = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/tool/pen/multicolor/fountain = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/welding = NO_GARB_OVERRIDE,
	/obj/item/clothing/head/headband = NO_GARB_OVERRIDE,
	/obj/item/clothing/head/headband/tan = NO_GARB_OVERRIDE,
	/obj/item/clothing/head/headband/red = NO_GARB_OVERRIDE,
	/obj/item/clothing/head/headband/brown = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/clothing/head/headband/gray = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/clothing/head/headband/squad = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/clothing/head/headband/rebel = PREFIX_HELMET_GARB_OVERRIDE, // helmet_
	/obj/item/tool/candle = NO_GARB_OVERRIDE,
	/obj/item/clothing/mask/facehugger = NO_GARB_OVERRIDE,
	/obj/item/clothing/mask/facehugger/lamarr = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/red = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/orange = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/yellow = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/green = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/blue = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/purple = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/rainbow = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/pride/trans = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/pride/gay = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/pride/lesbian = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/pride/bi = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/pride/pan = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/pride/ace = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/pride/trans = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/pride/enby = NO_GARB_OVERRIDE,
	/obj/item/toy/crayon/pride/fluid = NO_GARB_OVERRIDE,
	/obj/item/paper = NO_GARB_OVERRIDE,
	/obj/item/device/flashlight/flare = NO_GARB_OVERRIDE,
	/obj/item/clothing/head/headset = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/falcon = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/falcon/squad_main = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/cec_patch = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/freelancer_patch = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/merc_patch = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/devils = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/forecon = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/royal_marines = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/upp = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/upp/airborne = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/upp/naval = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/ua = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/uasquare = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/falconalt = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/twe = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/uscmlarge = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/wy = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/wysquare = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/wy_faction = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/wy_white = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/wyfury = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/upp/alt = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/medic_patch = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/clf_patch = NO_GARB_OVERRIDE,
	/obj/item/clothing/accessory/patch/hyperdyne_patch = NO_GARB_OVERRIDE,
	/obj/item/ammo_magazine/handful = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/riot_shield = NO_GARB_OVERRIDE,
	/obj/item/attachable/flashlight = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/chaplain_patch = NO_GARB_OVERRIDE,

	// MEDICAL
	/obj/item/stack/medical/bruise_pack = NO_GARB_OVERRIDE,
	/obj/item/stack/medical/ointment = NO_GARB_OVERRIDE,
	/obj/item/tool/surgery/scalpel = NO_GARB_OVERRIDE,
	/obj/item/reagent_container/hypospray/autoinjector = NO_GARB_OVERRIDE,
	/obj/item/storage/pill_bottle/packet = NO_GARB_OVERRIDE,
))

/obj/item/clothing/head/helmet/marine
	name = "\improper M10 pattern marine helmet"
	desc = "一顶标准的M10式头盔。内侧标签连同洗涤说明写着：‘开棺葬礼与闭棺葬礼的区别。戴在头上效果最佳。’右侧有一个内置摄像头。"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
	icon_state = "helmet"
	item_state = "helmet"
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi'
	)
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	light_system = DIRECTIONAL_LIGHT
	health = 5
	force = 15
	throwforce = 15
	attack_verb = list("whacked", "hit", "smacked", "beaten", "battered")
	var/obj/structure/machinery/camera/camera
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NONE
	var/flags_marine_helmet = HELMET_SQUAD_OVERLAY|HELMET_GARB_OVERLAY|HELMET_DAMAGE_OVERLAY
	var/helmet_bash_cooldown = 0

	//speciality does NOTHING if you have NO_NAME_OVERRIDE
	var/specialty = "M10 pattern marine" //Give them a specialty var so that they show up correctly in vendors. speciality does NOTHING if you have NO_NAME_OVERRIDE.
	valid_accessory_slots = list(ACCESSORY_SLOT_HELM_C)

	var/obj/item/storage/internal/headgear/pockets
	var/storage_slots = 2 // Small items like injectors, bandages, etc
	var/storage_slots_reserved_for_garb = 2 // Cosmetic items & now cigarettes and lighters for RP
	var/storage_max_w_class = SIZE_TINY // can hold tiny items only, EXCEPT for glasses & metal flask.
	var/storage_max_storage_space = 4

	/// The dmi where the grayscale squad overlays are contained for "std-helmet" and "sql-helmet"
	var/helmet_overlay_icon = 'icons/mob/humans/onmob/clothing/head/overlays.dmi'
	/// The dmi where the "helmet_band" is contained for garb
	var/helmet_band_icon = 'icons/mob/humans/onmob/clothing/helmet_garb/misc.dmi'

	///Any visors built into the helmet
	var/list/built_in_visors = list(new /obj/item/device/helmet_visor)
	///Any visors that have been added into the helmet
	var/list/inserted_visors = list()
	///Max amount of inserted visors
	var/max_inserted_visors = 1
	///The current active visor that is shown
	var/obj/item/device/helmet_visor/active_visor = null
	///Designates a visor type that should start down when initialized
	var/start_down_visor_type
	///Faction owners of the inbuilt camera
	var/list/camera_factions = FACTION_LIST_MARINE_WY


/obj/item/clothing/head/helmet/marine/Initialize(mapload, new_protection[] = list(MAP_ICE_COLONY = ICE_PLANET_MIN_COLD_PROT))
	. = ..()
	AddComponent(/datum/component/overwatch_console_control)
	AddElement(/datum/element/corp_label/armat)
	if(!(flags_atom & NO_NAME_OVERRIDE))
		name = "[specialty]"
		if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
			name += " snow helmet"
		else
			name += " helmet"

	if(!(flags_atom & NO_GAMEMODE_SKIN))
		select_gamemode_skin(type, null, new_protection)

	helmet_overlays = list() //To make things simple.

	pockets = new(src)
	pockets.storage_slots = HAS_FLAG(flags_marine_helmet, HELMET_GARB_OVERLAY) ? storage_slots + storage_slots_reserved_for_garb : storage_slots
	pockets.slots_reserved_for_garb = HAS_FLAG(flags_marine_helmet, HELMET_GARB_OVERLAY) ? storage_slots_reserved_for_garb : 0
	pockets.max_w_class = storage_max_w_class
	pockets.bypass_w_limit = GLOB.allowed_helmet_items
	pockets.max_storage_space = storage_max_storage_space

	camera = new /obj/structure/machinery/camera/overwatch(src)
	camera.owner_factions = camera_factions

	for(var/obj/visor as anything in built_in_visors)
		visor.forceMove(src)

	if(length(inserted_visors) || length(built_in_visors))
		var/datum/action/item_action/cycle_helmet_huds/new_action = new(src)
		if(ishuman(loc))
			var/mob/living/carbon/human/holding_human = loc
			if(holding_human.head == src)
				new_action.give_to(holding_human)

	if(start_down_visor_type)
		for(var/obj/item/device/helmet_visor/cycled_visor in (built_in_visors + inserted_visors))
			if(cycled_visor.type == start_down_visor_type)
				active_visor = cycled_visor
				break

		if(active_visor)
			var/datum/action/item_action/cycle_helmet_huds/cycle_action = locate() in actions
			if(cycle_action)
				cycle_action.set_action_overlay(active_visor)

/obj/item/clothing/head/helmet/marine/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	if(flags_atom & MAP_COLOR_INDEX)
		return
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi'
		if("classic")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/classic.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/classic.dmi'
		if("desert")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/desert.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/desert.dmi'
		if("snow")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/snow.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/snow.dmi'
		if("urban")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/urban.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/urban.dmi'

/obj/item/clothing/head/helmet/marine/Destroy(force)
	QDEL_NULL(camera)
	QDEL_NULL(pockets)
	if(active_visor && istype(loc, /mob/living/carbon/human))
		var/mob/living/carbon/human/potential_user = loc
		if(potential_user.head == src)
			var/obj/item/device/helmet_visor/temp_visor_holder = active_visor
			active_visor = null
			toggle_visor(potential_user, temp_visor_holder, TRUE)
	QDEL_NULL_LIST(built_in_visors)
	return ..()

/obj/item/clothing/head/helmet/marine/attack_hand(mob/user)
	if(loc != user)
		..(user) // If it's in a satchel or something don't open the pockets
		return

	if(pockets.handle_attack_hand(user))
		..(user)


/obj/item/clothing/head/helmet/marine/MouseDrop(over_object, src_location, over_location)
	SEND_SIGNAL(usr, COMSIG_ITEM_DROPPED, usr)
	if(pockets.handle_mousedrop(usr, over_object))
		..()

/obj/item/clothing/head/helmet/marine/attackby(obj/item/attacking_item, mob/user)
	. = ..()
	if(.)
		return

	if(istype(attacking_item, /obj/item/ammo_magazine) && world.time > helmet_bash_cooldown && user)
		var/obj/item/ammo_magazine/M = attacking_item
		var/ammo_level = "more than half full."
		playsound(user, 'sound/items/trayhit1.ogg', 15, FALSE)
		if(M.current_rounds == (M.max_rounds/2))
			ammo_level = "half full."
		if(M.current_rounds < (M.max_rounds/2))
			ammo_level = "less than half full."
		if(M.current_rounds < (M.max_rounds/6))
			ammo_level = "almost empty."
		if(M.current_rounds == 0)
			ammo_level = "empty. Uh oh."
		user.visible_message("[user]用[M]猛击自己的头盔。", "You bash [M] against your helmet. It is [ammo_level]")
		helmet_bash_cooldown = world.time + 20 SECONDS
		return

	if(istype(attacking_item, /obj/item/device/helmet_visor))
		var/obj/item/device/helmet_visor/new_visor = attacking_item

		if(!new_visor.can_attach_to(src))
			to_chat(user, SPAN_NOTICE("这个[new_visor]无法安装在[src]上。"))
			return

		if(length(inserted_visors) >= max_inserted_visors)
			to_chat(user, SPAN_NOTICE("[src]的护目镜插槽已全部占用。"))
			return

		for(var/obj/item/device/helmet_visor/cycled_visor as anything in (built_in_visors + inserted_visors))
			if(cycled_visor.type == new_visor.type)
				to_chat(user, SPAN_NOTICE("[src]已连接同类型的抬头显示器。"))
				return
		if(!user.drop_held_item())
			return

		inserted_visors += new_visor
		to_chat(user, SPAN_NOTICE("你将[new_visor]连接到[src]。"))
		new_visor.forceMove(src)
		if(!(locate(/datum/action/item_action/cycle_helmet_huds) in actions))
			var/datum/action/item_action/cycle_helmet_huds/new_action = new(src)
			new_action.give_to(user)
		return

	if(HAS_TRAIT(attacking_item, TRAIT_TOOL_SCREWDRIVER))
		// If there isn't anything to remove, return.
		if(!length(inserted_visors))
			// If the user is trying to remove a built-in visor, give them a more helpful failure message.
			switch(length(built_in_visors))
				if(1) // Messy plural handling
					to_chat(user, SPAN_WARNING("[src]的护目镜是内置的！"))
				if(2 to INFINITY)
					to_chat(user, SPAN_WARNING("[src]的护目镜是内置的！"))
			return

		if(active_visor)
			var/obj/item/device/helmet_visor/temp_visor_holder = active_visor
			active_visor = null
			toggle_visor(user, temp_visor_holder, TRUE)

		for(var/obj/item/device/helmet_visor/visor as anything in inserted_visors)
			visor.forceMove(get_turf(src))

		inserted_visors = list()
		to_chat(user, SPAN_NOTICE("你移除了已安装的护目镜。"))

		var/datum/action/item_action/cycle_helmet_huds/cycle_action = locate() in actions
		cycle_action.set_default_overlay()
		if(!length(built_in_visors))
			cycle_action.remove_from(user)

		return

	..()
	return pockets.attackby(attacking_item, user)

/obj/item/clothing/head/helmet/marine/on_pocket_insertion()
	update_icon()

/obj/item/clothing/head/helmet/marine/on_pocket_removal()
	update_icon()

/obj/item/clothing/head/helmet/marine/update_icon()
	// Currently done by delegating to the human onmob head inventory updater
	// not the best *possible* solution, but this is complicated by the fact that
	// adding an image to src or trying to render it in overlays does nothing because
	// the "primary" icon of src is the holdable object, not the onmob.
	// the human sprite is the only thing that reliably renders things, so
	// we have to add overlays to that.
	helmet_overlays = list() // Rebuild our list every time
	if(length(pockets?.contents) && (flags_marine_helmet & HELMET_GARB_OVERLAY))
		var/list/above_band_layer = list()
		var/list/below_band_layer = list()
		var/has_helmet_band = FALSE
		for(var/obj/item/garb_object in pockets.contents)
			if(garb_object.type in GLOB.allowed_helmet_items)
				var/has_band = !HAS_FLAG(garb_object.flags_obj, OBJ_NO_HELMET_BAND)
				if(has_band)
					has_helmet_band = TRUE
				var/image/new_overlay = garb_object.get_garb_overlay(GLOB.allowed_helmet_items[garb_object.type])
				if(has_band)
					above_band_layer += new_overlay
				else
					below_band_layer += new_overlay

		if(has_helmet_band)
			var/image/band_overlay = overlay_image(helmet_band_icon, "helmet_band", color, RESET_COLOR)
			helmet_overlays = above_band_layer + band_overlay + below_band_layer
		else
			helmet_overlays = above_band_layer + below_band_layer

	if(active_visor)
		helmet_overlays += overlay_image(active_visor.helmet_overlay_icon, active_visor.helmet_overlay, color, RESET_COLOR)

	if(ismob(loc))
		var/mob/moob = loc
		moob.update_inv_head()

/obj/item/clothing/head/helmet/marine/equipped(mob/living/carbon/human/mob, slot)
	if(camera)
		camera.c_tag = mob.name
		camera.status = TRUE
	if(active_visor)
		recalculate_visors(mob)
	..()

/obj/item/clothing/head/helmet/marine/unequipped(mob/user, slot)
	. = ..()
	if(camera)
		camera.status = FALSE
	if(pockets)
		for(var/obj/item/attachable/flashlight/F in pockets)
			if(F.light_on)
				F.activate_attachment(src, user, TRUE)
	if(active_visor)
		recalculate_visors(user)

/obj/item/clothing/head/helmet/marine/dropped(mob/living/carbon/human/mob)
	if(camera)
		camera.c_tag = "未知"
	if(pockets)
		for(var/obj/item/attachable/flashlight/F in pockets)
			if(F.light_on)
				F.activate_attachment(src, mob, TRUE)
	if(active_visor)
		recalculate_visors(mob)
	..()

/obj/item/clothing/head/helmet/marine/has_garb_overlay()
	return flags_marine_helmet & HELMET_GARB_OVERLAY

/obj/item/clothing/head/helmet/marine/get_examine_text(mob/user)
	. = ..()
	if(active_visor)
		. += active_visor.get_helmet_examine_text()

/obj/item/clothing/head/helmet/marine/proc/add_hugger_damage() //This is called in XenoFacehuggers.dm to first add the desc and set the var.
	if(flags_marine_helmet & HELMET_DAMAGE_OVERLAY && !(flags_marine_helmet & HELMET_IS_DAMAGED))
		flags_marine_helmet |= HELMET_IS_DAMAGED
		desc += "\n<b>This helmet seems to be scratched up and damaged, particularly around the face area...</b>"

/obj/item/clothing/head/helmet/marine/get_pockets()
	if(pockets)
		return pockets
	return ..()

/// Recalculates and sets the proper visor effects
/obj/item/clothing/head/helmet/marine/proc/recalculate_visors(mob/user)
	turn_off_visors(user)

	if(!active_visor)
		return

	if(user != loc)
		return

	var/mob/living/carbon/human/human_user = user
	if(!human_user || human_user.head != src)
		return

	toggle_visor(user, silent = TRUE)

/// Toggles the specified visor, if nothing specified then the active visor, if the visor is the active visor and the helmet is on the user's head it will turn on, if it is not the active visor it will turn off
/obj/item/clothing/head/helmet/marine/proc/toggle_visor(mob/user, obj/item/device/helmet_visor/current_visor, silent = FALSE)
	current_visor = current_visor || active_visor

	if(!current_visor)
		return

	current_visor.toggle_visor(src, user, silent)

	update_icon()

/// Attempts to turn off all visors
/obj/item/clothing/head/helmet/marine/proc/turn_off_visors(mob/user)
	var/list/total_visors = built_in_visors + inserted_visors

	for(var/obj/item/device/helmet_visor/cycled_helmet_visor in total_visors)
		cycled_helmet_visor.deactivate_visor(src, user)

	update_icon()

///Cycles the active HUD to the next between built_in_visors and inserted_visors, nullifies if at end and removes all HUDs
/obj/item/clothing/head/helmet/marine/proc/cycle_huds(mob/user)
	var/list/total_visors = built_in_visors + inserted_visors

	if(!length(total_visors))
		to_chat(user, SPAN_WARNING("没有可切换的护目镜。"))
		return FALSE

	if(active_visor)
		var/visor_to_deactivate = active_visor
		var/skipped_hud = FALSE
		var/iterator = 1
		for(var/obj/item/device/helmet_visor/current_visor as anything in total_visors)
			if(current_visor == active_visor || skipped_hud)
				if(length(total_visors) > iterator)
					var/obj/item/device/helmet_visor/next_visor = total_visors[iterator + 1]

					if(!isnull(GLOB.huds[next_visor.hud_type]?.hudusers[user]))
						iterator++
						skipped_hud = TRUE
						continue

					if(!next_visor.can_toggle(user))
						iterator++
						skipped_hud = TRUE
						continue

					active_visor = next_visor
					toggle_visor(user, visor_to_deactivate, silent = TRUE) // disables the old visor
					toggle_visor(user)
					return active_visor
				else
					active_visor = null
					toggle_visor(user, visor_to_deactivate, FALSE)
					return FALSE
			iterator++

	for(var/obj/item/device/helmet_visor/new_visor in total_visors)
		if(!isnull(GLOB.huds[new_visor.hud_type]?.hudusers[user]))
			continue

		if(!new_visor.can_toggle(user))
			continue

		active_visor = new_visor
		toggle_visor(user)
		return active_visor

	to_chat(user, SPAN_WARNING("当前没有可切换的护目镜。"))
	return FALSE


/obj/item/clothing/head/helmet/marine/hear_talk(mob/living/sourcemob, message, verb, datum/language/language, italics)
	SEND_SIGNAL(src, COMSIG_BROADCAST_HEAR_TALK, sourcemob, message, verb, language, italics, loc == sourcemob)

/obj/item/clothing/head/helmet/marine/see_emote(mob/living/sourcemob, emote, audible)
	SEND_SIGNAL(src, COMSIG_BROADCAST_SEE_EMOTE, sourcemob, emote, audible, loc == sourcemob && audible)

/datum/action/item_action/cycle_helmet_huds
	var/supported_custom_icons = list(
		"hud_marine",
		"nvg_sight_down",
		"med_sight_down",
		"sec_sight_down",
		"blank_hud_sight_down"
	)

/datum/action/item_action/cycle_helmet_huds/New(Target, obj/item/holder)
	. = ..()
	name = "切换头盔抬头显示器"
	button.name = name
	set_default_overlay()

/datum/action/item_action/cycle_helmet_huds/action_activate()
	. = ..()
	var/obj/item/clothing/head/helmet/marine/holder_helmet = holder_item
	var/cycled_hud = holder_helmet.cycle_huds(usr)

	set_action_overlay(cycled_hud)

/// Sets the action overlay based on the visor type
/datum/action/item_action/cycle_helmet_huds/proc/set_action_overlay(obj/item/device/helmet_visor/new_visor)
	if(!new_visor)
		set_default_overlay()
		return

	action_icon_state = new_visor.action_icon_string
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/cycle_helmet_huds/update_button_icon()
	return

/// Sets the action overlay to default hud sight up
/datum/action/item_action/cycle_helmet_huds/proc/set_default_overlay()
	action_icon_state = "hud_deploy"
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/obj/item/clothing/head/helmet/marine/tech
	name = "\improper M10 technician helmet"
	desc = "为战斗技术员改装的M10陆战队员头盔。配备可切换的焊接面罩以保护眼睛。"
	icon_state = "tech_helmet"
	specialty = "M10 technician"
	built_in_visors = list(new /obj/item/device/helmet_visor, new /obj/item/device/helmet_visor/welding_visor)
	clothing_traits = list(TRAIT_EAR_PROTECTION)

/obj/item/clothing/head/helmet/marine/welding
	name = "\improper M10 welding helmet"
	desc = "一款改装的M10陆战队员头盔，配备可切换的焊接面罩以保护眼睛。关闭时完全隐形，与技师头盔不同。"
	specialty = "M10 welding"
	built_in_visors = list(new /obj/item/device/helmet_visor, new /obj/item/device/helmet_visor/welding_visor)
	clothing_traits = list(TRAIT_EAR_PROTECTION)


/obj/item/clothing/head/helmet/marine/grey
	desc = "一款标准的M10型头盔。此头盔尚未涂装迷彩。右侧有一个内置摄像头。"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/jungle
	icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/snow
	name = "\improper M10 marine snow helmet"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/desert
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	icon = 'icons/obj/items/clothing/hats/hats_by_map/desert.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/urban
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	icon = 'icons/obj/items/clothing/hats/hats_by_map/urban.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/tech/tanker
	name = "\improper M50 tanker helmet"
	desc = "轻量化的M50坦克兵头盔专为USCM装甲车组成员设计。它提供轻量防护，并允许在装甲车辆内部灵活移动。配备可切换的焊接面罩以保护眼睛。"
	icon_state = "tanker_helmet"
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDETOPHAIR
	specialty = "M50 tanker"
	built_in_visors = list(new /obj/item/device/helmet_visor, new /obj/item/device/helmet_visor/welding_visor/tanker)

/obj/item/clothing/head/helmet/marine/medic
	name = "\improper M10 corpsman helmet"
	desc = "陆战队医疗兵佩戴的M10陆战队员头盔版本。正面绘有红十字。"
	icon_state = "med_helmet"
	specialty = "M10 pattern medic"
	built_in_visors = list(new /obj/item/device/helmet_visor, new /obj/item/device/helmet_visor/medical/advanced)
	start_down_visor_type = /obj/item/device/helmet_visor/medical/advanced

/obj/item/clothing/head/helmet/marine/medic/white
	name = "\improper M10 white corpsman helmet"
	desc = "陆战队医疗兵佩戴的M10陆战队员头盔版本。涂装医疗白色，正面绘有红底白十字。"
	icon_state = "med_helmet_white"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	flags_marine_helmet = HELMET_GARB_OVERLAY|HELMET_DAMAGE_OVERLAY

/obj/item/clothing/head/helmet/marine/medic/grey
	desc = "陆战队医疗兵佩戴的M10陆战队员头盔版本。正面绘有红十字。此头盔尚未涂装迷彩。右侧有一个内置摄像头。"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/medic/jungle
	icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/medic/snow
	name = "\improper M10 pattern medic snow helmet"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/medic/desert
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	icon = 'icons/obj/items/clothing/hats/hats_by_map/desert.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/medic/urban
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	icon = 'icons/obj/items/clothing/hats/hats_by_map/urban.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/covert
	name = "\improper M10 covert helmet"
	desc = "专为黑暗环境使用而设计的M10陆战队员头盔版本。涂有特殊的防反光涂料。"
	icon_state = "marsoc_helmet"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	specialty = "M10 pattern covert"
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/head/helmet/marine/leader
	name = "\improper M11 pattern helmet"
	desc = "标准M10型的变体。前板得到加固。此头盔包含一个小型内置摄像头，并配有衬垫以保护你脆弱的大脑。"
	icon_state = "sl_helmet"
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	specialty = "M11 pattern marine"

/obj/item/clothing/head/helmet/marine/rto
	name = "\improper M12 pattern dust helmet"
	desc = "一款实验性的“脑壳桶”。后部悬挂着防尘褶边，而非标准的龙虾壳设计。在承受羞辱的代价下，能更好地偏转钝器攻击，还可容纳第二个护目镜光学器件。但在追悼会上谁会笑呢？不是你，你将忙于为你卓越的领导才能领取勋章。"
	icon_state = "io"
	item_state = "io"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	specialty = "M12 pattern"
	max_inserted_visors = 2
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)

/obj/item/clothing/head/helmet/marine/rto/intel
	name = "\improper XM12 pattern intelligence helmet"
	desc = "一款实验性的“脑壳桶”。后部悬挂着防尘褶边。在承受羞辱的代价下，能更好地偏转钝器攻击，还可容纳第二个护目镜光学器件。但在追悼会上谁会笑呢？不是你，你将忙于为你出色的情报工作领取勋章。"
	specialty = "XM12 pattern intel"

/obj/item/clothing/head/helmet/marine/rto/intel/grey
	desc = "一款实验性的“脑壳桶”。后部悬挂着防尘褶边。在承受羞辱的代价下，能更好地偏转钝器攻击，还可容纳第二个护目镜光学器件。但在追悼会上谁会笑呢？不是你，你将忙于为你出色的情报工作领取勋章。此头盔尚未涂装迷彩。"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/rto/intel/jungle
	icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/rto/intel/snow
	name = "\improper XM12 pattern intel snow helmet"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/rto/intel/desert
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	icon = 'icons/obj/items/clothing/hats/hats_by_map/desert.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/rto/intel/urban
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	icon = 'icons/obj/items/clothing/hats/hats_by_map/urban.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/specialist
	name = "\improper B18 helmet"
	desc = "与B18防御护甲配套的B18头盔。它厚重、加固，能保护更多面部区域。"
	icon_state = "grenadier_helmet"
	item_state = "grenadier_helmet"
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_ULTRAHIGH
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	unacidable = TRUE
	anti_hug = 6
	force = 20
	specialty = "B18"

/obj/item/clothing/head/helmet/marine/grenadier
	name = "\improper M3-G4 grenadier helmet"
	desc = "与M3-G4重型掷弹兵护甲配套。是实验性B18防御头盔的远亲。配备内置的耳部爆炸防护。"
	icon_state = "grenadier_helmet"
	item_state = "grenadier_helmet"
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_ULTRAHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	clothing_traits = list(TRAIT_EAR_PROTECTION)
	unacidable = TRUE
	anti_hug = 6
	specialty = "M3-G4 grenadier"
	flags_item = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE


/obj/item/clothing/head/helmet/marine/radio_helmet

	name = "M3天线头盔"
	desc = "你不应该看到这个！"
	icon_state = "scout_helmet"
	item_state = "scout_helmet"

	actions_types = list(/datum/action/item_action/radio_helmet/use_phone)

	flags_item = ITEM_OVERRIDE_NORTHFACE

	var/obj/structure/transmitter/internal/internal_transmitter

	var/phone_category = PHONE_MARINE
	var/list/networks_receive = list(FACTION_MARINE)
	var/list/networks_transmit = list(FACTION_MARINE)
	var/base_icon


/datum/action/item_action/radio_helmet/use_phone/New(mob/living/user, obj/item/holder)
	..()
	name = "使用电话"
	button.name = name
	button.overlays.Cut()
	var/image/IMG = image('icons/mob/hud/actions.dmi', button, "microphone")
	button.overlays += IMG

/datum/action/item_action/radio_helmet/use_phone/action_activate()
	. = ..()
	for(var/obj/item/clothing/head/helmet/marine/radio_helmet/radio_backpack in owner)
		radio_backpack.use_phone(owner)
		return

/obj/item/clothing/head/helmet/marine/radio_helmet/Initialize()
	. = ..()
	internal_transmitter = new(src)
	internal_transmitter.relay_obj = src
	internal_transmitter.phone_category = phone_category
	internal_transmitter.enabled = FALSE
	internal_transmitter.networks_receive = networks_receive
	internal_transmitter.networks_transmit = networks_transmit
	internal_transmitter.outring_loop.start_length = 0 SECONDS
	internal_transmitter.outring_loop.start_sound = null
	internal_transmitter.outring_loop.mid_sounds = 'sound/machines/telephone/scout_ring_outgoing.ogg'
	internal_transmitter.outring_loop.mid_length = 3 SECONDS
	internal_transmitter.hangup_loop.start_sound = 'sound/machines/telephone/scout_hang_up.ogg'
	internal_transmitter.hangup_loop.mid_sounds = null
	internal_transmitter.busy_loop.start_sound = 'sound/machines/telephone/scout_remote_hangup.ogg'
	internal_transmitter.busy_loop.mid_sounds = null
	internal_transmitter.call_sound = 'sound/machines/telephone/scout_ring.ogg'
	internal_transmitter.attached_to.icon_state = "scout_microphone"
	internal_transmitter.attached_to.item_state = ""
	internal_transmitter.attached_to.name = "helmet microphone"
	internal_transmitter.attached_to.desc = "A small microphone attached to the helmet, used to communicate with the internal radio transmitter."
	internal_transmitter.pickup_sound = 'sound/machines/telephone/scout_pick_up.ogg'
	internal_transmitter.attached_to.can_be_raised = FALSE
	RegisterSignal(internal_transmitter, COMSIG_TRANSMITTER_UPDATE_ICON, PROC_REF(check_for_ringing))
	GLOB.radio_packs += src

/obj/item/clothing/head/helmet/marine/radio_helmet/proc/check_for_ringing()
	SIGNAL_HANDLER
	update_icon()

/obj/item/clothing/head/helmet/marine/radio_helmet/update_icon()
	. = ..()

	if(internal_transmitter.inbound_call)
		overlays += image('icons/obj/items/clothing/hats/overlays.dmi', "scout_helmet_beep")
	else
		overlays -= image('icons/obj/items/clothing/hats/overlays.dmi', "scout_helmet_beep")
/obj/item/clothing/head/helmet/marine/radio_helmet/forceMove(atom/dest)
	. = ..()
	if(isturf(dest))
		internal_transmitter.set_tether_holder(src)
	else
		internal_transmitter.set_tether_holder(loc)

/obj/item/clothing/head/helmet/marine/radio_helmet/Destroy()
	GLOB.radio_packs -= src
	qdel(internal_transmitter)
	return ..()

/obj/item/clothing/head/helmet/marine/radio_helmet/pickup(mob/user)
	. = ..()
	autoset_phone_id(user)

/obj/item/clothing/head/helmet/marine/radio_helmet/equipped(mob/user, slot)
	. = ..()
	autoset_phone_id(user)

/// Automatically sets the phone_id based on the current or updated user
/obj/item/clothing/head/helmet/marine/radio_helmet/proc/autoset_phone_id(mob/user)
	if(!user)
		internal_transmitter.phone_id = "[src]"
		internal_transmitter.enabled = FALSE
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.comm_title)
			internal_transmitter.phone_id = "[H.comm_title] [H]"
		else if(H.job)
			internal_transmitter.phone_id = "[H.job] [H]"
		else
			internal_transmitter.phone_id = "[H]"

		if(H.assigned_squad)
			internal_transmitter.phone_id += " ([H.assigned_squad.name])"
	else
		internal_transmitter.phone_id = "[user]"
	internal_transmitter.enabled = TRUE

/obj/item/clothing/head/helmet/marine/radio_helmet/dropped(mob/user)
	. = ..()
	autoset_phone_id(null) // Disable phone when dropped

/obj/item/clothing/head/helmet/marine/radio_helmet/proc/use_phone(mob/user)
	internal_transmitter.attack_hand(user)


/obj/item/clothing/head/helmet/marine/radio_helmet/attackby(obj/item/scout_phone, mob/user)
	if(internal_transmitter && internal_transmitter.attached_to == scout_phone)
		internal_transmitter.attackby(scout_phone, user)
	else
		. = ..()


/obj/item/clothing/head/helmet/marine/radio_helmet/scout
	name = "\improper M3-S light helmet"
	icon_state = "scout_helmet"
	desc = "为USCM侦察兵设计的定制头盔。内置小型麦克风，用于远距离通信。"
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	specialty = "M3-S light"
	flags_item = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE

	phone_category = PHONE_MARINE

/obj/item/clothing/head/helmet/marine/pyro
	name = "\improper M35 pyrotechnician helmet"
	icon_state = "pyro_helmet"
	desc = "为USCM爆破技术员设计的头盔。"
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROT
	specialty = "M35 pyrotechnician"
	flags_item = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE

/obj/item/clothing/head/helmet/marine/M3T
	name = "\improper M3-T bombardier helmet"
	icon_state = "sadar_helmet"
	desc = "为爆炸性武器使用者定制的头盔。内置防爆耳罩，不建议在没有此头盔的情况下发射火箭筒。"
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	armor_bomb = CLOTHING_ARMOR_HIGH
	specialty = "M3-T bombardier"
	flags_inventory = BLOCKSHARPOBJ
	clothing_traits = list(TRAIT_EAR_PROTECTION)
	unacidable = TRUE

/obj/item/clothing/head/helmet/marine/pilot
	name = "\improper MK30 tactical helmet"
	desc = "MK30战术头盔配有目镜过滤器，用于筛选战术数据。手动安全驾驶运输机需要此装备。"
	icon_state = "helmetp"
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDETOPHAIR
	specialty = "MK30 tactical"
	built_in_visors = list(new /obj/item/device/helmet_visor, new /obj/item/device/helmet_visor/medical/advanced)
	inserted_visors = list(new /obj/item/device/helmet_visor/po_visor)
	max_inserted_visors = 1

/obj/item/clothing/head/helmet/marine/pilot/novisor //For vendors that give sepreate visor options
	inserted_visors = list()

/obj/item/clothing/head/helmet/marine/pilot/tex
	name = "\improper Tex's MK30 tactical helmet"
	desc = "MK30战术头盔配有目镜过滤器，用于筛选战术数据。手动安全驾驶运输机需要此装备。这个头盔属于泰克斯：阿尔迈耶号有史以来最疯狂的混蛋飞行员。他没死，但去年在岸上休假时被车撞了，之后被医疗退役。"
	icon_state = "helmetp_tex"
	item_state = "helmetp_tex"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi',
	)
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/head/helmet/marine/ghillie
	name = "\improper M45 ghillie helmet"
	desc = "USCM狙击手在侦察任务中使用的轻量化M45头盔，配有吉利兜帽。"
	icon_state = "ghillie_coif"
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDETOPHAIR
	flags_marine_helmet = HELMET_GARB_OVERLAY
	flags_item = MOB_LOCK_ON_EQUIP
	specialty = "M45 ghillie"

/obj/item/clothing/head/helmet/marine/ghillie/select_gamemode_skin()
	. = ..()
	if(SSmapping.configs[GROUND_MAP].camouflage_type == "urban"	|| "classic")
		name = "\improper M10-LS pattern sniper helmet"
		desc = "USCM狙击手在城市侦察任务中使用的M10头盔轻量化版本，具有热信号抑制功能。"

/obj/item/clothing/head/helmet/marine/leader/CO
	name = "\improper M11C pattern commanding officer helmet"
	desc = "USCM指挥官佩戴的特殊M11式头盔。标签上写着：‘开棺葬礼和闭棺葬礼的区别。戴在头上效果最佳。’"
	icon_state = "co"
	item_state = "co"
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	specialty = "M11 pattern commanding officer"
	flags_atom = NO_NAME_OVERRIDE
	built_in_visors = list(new /obj/item/device/helmet_visor, new /obj/item/device/helmet_visor/medical/advanced, new /obj/item/device/helmet_visor/security)

/obj/item/clothing/head/helmet/marine/leader/CO/general
	name = "\improper M11 pattern ceremonial helmet"
	desc = "USCM将官偶尔佩戴的特殊M11式礼仪头盔。"
	icon_state = "golden"
	item_state = "golden"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)
	specialty = "M11 pattern ceremonial"
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/head/helmet/marine/MP
	name = "\improper M10 pattern MP helmet"
	desc = "USCM宪兵佩戴的M10式头盔特殊变体。无论你面对的是犯罪集团还是兵变，这个头盔都能保住你的脑子。"
	icon_state = "mp_helmet"
	item_state = "mp_helmet"
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	specialty = "M10 pattern military police"
	built_in_visors = list(new /obj/item/device/helmet_visor/security)

/obj/item/clothing/head/helmet/marine/MP/grey
	desc = "USCM宪兵佩戴的M10式头盔特殊变体。无论你面对的是犯罪集团还是兵变，这个头盔都能保住你的脑子。这个头盔尚未涂装迷彩图案。"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/MP/jungle
	icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/MP/snow
	name = "\improper M10 pattern military police snow helmet"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/MP/desert
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	icon = 'icons/obj/items/clothing/hats/hats_by_map/desert.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/MP/urban
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	icon = 'icons/obj/items/clothing/hats/hats_by_map/urban.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/head/helmet/marine/MP/WO
	name = "\improper M3 pattern chief MP helmet"
	desc = "M10头盔的精良变体，通常配发给宪兵长。有助于让你的手下知道谁在负责。"
	icon_state = "cmp_helmet"
	item_state = "cmp_helmet"
	specialty = "M10 pattern chief MP"

/obj/item/clothing/head/helmet/marine/MP/SO
	name = "\improper M10 pattern Officer Helmet"
	desc = "USCM军官佩戴的M10式头盔特殊变体，能吸引大头兵和狙击火力的同等关注。"
	icon_state = "officer"
	item_state = "officer"
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)
	specialty = "M10 pattern officer"
	built_in_visors = list(new /obj/item/device/helmet_visor, new /obj/item/device/helmet_visor/medical/advanced)

/obj/item/clothing/head/helmet/marine/MP/SO/basic
	built_in_visors = list(new /obj/item/device/helmet_visor, new /obj/item/device/helmet_visor/medical)

/obj/item/clothing/head/helmet/marine/MP/provost/marshal
	name = "\improper M10 pattern MP riot helmet"
	desc = "为处理骚乱部署的宪兵准备的M10变体，通常由宪兵司令部的宪兵佩戴。"
	icon_state = "pvmarshalhat"
	item_state = "pvmarshalhat"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi',
	)
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	flags_inventory = BLOCKSHARPOBJ|FULL_DECAP_PROTECTION

/obj/item/clothing/head/helmet/marine/sof
	name = "\improper SOF Operator Helmet"
	desc = "USCM特种作战部队佩戴的M10式头盔特殊变体。"
	icon_state = "marsoc_helmet"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	specialty = "M10 pattern SOF"
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	built_in_visors = list(new /obj/item/device/helmet_visor/night_vision/marine_raider, new /obj/item/device/helmet_visor/security)
	start_down_visor_type = /obj/item/device/helmet_visor/night_vision/marine_raider

//FIORINA / UA RIOT CONTROL HELMET//

/obj/item/clothing/head/helmet/marine/veteran/ua_riot
	name = "\improper RC6 helmet"
	desc = "标准UA防暴6型头盔设计奇特，默认没有面罩（但留有安装点）。独特的白色图案和红色徽章在整个边缘世界都是压迫的代名词。"
	icon_state = "ua_riot"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	specialty = "RC6"
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

// KUTJEVO HELMET

/obj/item/clothing/head/helmet/marine/veteran/kutjevo
	name = "库特耶沃头盔"
	desc = "库特耶沃工人的标准配发头盔。包含一个小网兜，可放置笔、油甚至爱人照片等小物品。"
	icon_state = "kutjevo_helmet"
	item_state = "kutjevo_helmet"
	icon = 'icons/obj/items/clothing/hats/misc_ert_colony.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/misc_ert_colony.dmi',
	)
	camera_factions = FACTION_LIST_COLONY

//=============================//CMB\\==================================\\
//=======================================================================\\

/obj/item/clothing/head/helmet/marine/veteran/cmb
	name = "M11R式CMB防暴头盔"
	desc = "标准M10式的CMB变体。前板得到加固。这款头盔更贴合头部，也能防护闪光弹。"
	icon_state = "cmb_helmet"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/CMB.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/CMB.dmi',
	)
	armor_energy = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bio = CLOTHING_ARMOR_LOW
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_marine_helmet = HELMET_GARB_OVERLAY|HELMET_DAMAGE_OVERLAY
	clothing_traits = list(TRAIT_EAR_PROTECTION)
	built_in_visors = list(new /obj/item/device/helmet_visor/security)

/obj/item/clothing/head/helmet/marine/veteran/cmb/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/clothing/head/helmet/marine/veteran/cmb/engi
	built_in_visors = list(new /obj/item/device/helmet_visor/security, new /obj/item/device/helmet_visor/welding_visor)

/obj/item/clothing/head/helmet/marine/veteran/cmb/spec
	name = "M11R-S式CMB特警头盔"
	icon_state = "cmb_elite_helmet"
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	built_in_visors = list(new /obj/item/device/helmet_visor/security, new /obj/item/device/helmet_visor/night_vision)


//==========================//DISTRESS\\=================================\\
//=======================================================================\\

/obj/item/clothing/head/helmet/marine/veteran/dutch
	name = "\improper Dutch's Dozen helmet"
	desc = "一些经验极其丰富的雇佣兵佩戴的防护头盔。"
	icon_state = "dutch_helmet"
	icon = 'icons/obj/items/clothing/hats/misc_ert_colony.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/misc_ert_colony.dmi',
	)
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	flags_marine_helmet = HELMET_GARB_OVERLAY|HELMET_DAMAGE_OVERLAY
	camera_factions = list(FACTION_DUTCH)

/obj/item/clothing/head/helmet/marine/veteran/dutch/vietnam
	name = "\improper M1 pattern army helmet"
	desc = "越南战争高峰期美国陆军步枪兵佩戴的防护头盔。"

/obj/item/clothing/head/helmet/marine/veteran/dutch/cap
	name = "\improper Dutch's Dozen cap"
	desc = "一些经验极其丰富的雇佣兵佩戴的防护帽。"
	icon_state = "dutch_cap"
	flags_inventory = NO_FLAGS
	flags_inv_hide = NO_FLAGS
	flags_marine_helmet = NO_FLAGS

/obj/item/clothing/head/helmet/marine/veteran/dutch/band
	name = "\improper Dutch's Dozen band"
	desc = "一些经验极其丰富的雇佣兵佩戴的防护头带。"
	icon_state = "dutch_band"
	flags_inventory = NO_FLAGS
	flags_inv_hide = NO_FLAGS
	flags_marine_helmet = NO_FLAGS

// UPP Are very powerful against bullets (marines) but middling against melee (xenos)
/obj/item/clothing/head/helmet/marine/veteran/UPP
	name = "\improper UM4 helmet"
	desc = "采用高超制造工艺，这款UM4头盔对弹道伤害有极强抵抗力，但其巨大重量会给佩戴者的头部带来极大压力，很可能导致颈部问题。"
	icon_state = "upp_helmet"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UPP.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UPP.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	clothing_traits = list(TRAIT_EAR_PROTECTION) //the sprites clearly fully cover the ears and most of the head
	camera_factions = FACTION_LIST_UPP

/obj/item/clothing/head/helmet/marine/veteran/UPP/engi
	name = "\improper UM4-V helmet"
	desc = "这款UM4头盔版本配有防弹玻璃面罩，使UPP工程师能安全焊接，但据报告会在此过程中妨碍视线。"
	icon_state = "upp_helmet_engi"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_HIGH
	var/protection_on = TRUE

/obj/item/clothing/head/helmet/marine/veteran/UPP/heavy
	name = "\improper UH7 helmet"
	desc = "与UM4类似，这款头盔对弹道伤害抵抗力极强，但其优缺点都被放大了。少数活过30岁的UPP中士都因佩戴此头盔的压力导致严重颈部问题而被迫退役。"
	icon_state = "upp_helmet_heavy"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_HIGHPLUS

/obj/item/clothing/head/helmet/marine/veteran/UPP/army
	name = "\improper 6B82 combat helmet"
	desc = "UPP陆军6B92战斗头盔的旧型号，仍在UPP认为不太重要的星球上由某些部队使用。"
	icon_state = "upp_army_helmet"

/obj/item/clothing/head/helmet/marine/veteran/UPP/heavy/SOF_helmet
	name = "\improper CCC5-L composite helmet"
	desc = "UPP制造的球形设计战斗头盔。由强化聚合物复合材料制成，提供弹道防护，并集成了平视显示器、加密通讯和呼吸循环系统。有限的视野可视范围是其增强耐久性的代价。"
	icon_state = "sof_helmet"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	flags_inv_hide = HIDEEARS|HIDEALLHAIR

/obj/item/clothing/head/uppcap/peaked/police
	name = "\improper UL3 PaP peaked cap"
	desc = "人民武装警察的标准制式大檐帽。"
	icon_state = "upp_peaked_police"

/obj/item/clothing/head/uppcap
	name = "\improper UL2 UPP cap"
	desc = "UPP配发给预计不会遭遇战斗的士兵的头饰，军官及以上级别也可申请。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UPP.dmi'
	icon_state = "upp_cap"
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UPP.dmi'
	)
	siemens_coefficient = 2
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS

/obj/item/clothing/head/helmet/marine/veteran/UPP/firefighter
	name = "T-20消防头盔"
	desc = "配发给UPP应急人员的强化耐热头盔。其耐用的复合外壳可抵御坠物和极端高温，附着的防火罩保护佩戴者的颈部和肩部。正面的红星标志着其在联盟内的服役。"
	icon_state = "firefighter"
	flags_heat_protection = BODY_FLAG_HEAD
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROT

/obj/item/clothing/head/uppcap/civi
	name = "\improper UL2C UPP cap"
	desc = "UPP民用头饰。质量低劣，预计使用寿命不长，但只要完好，看起来相当时尚。"
	icon_state = "upp_cap_civi"

/obj/item/clothing/head/uppcap/civi/plant_worker
	name = "白色工人帽"
	desc = "简单的白色织物帽，UPP各类工人常用以束发和保持清洁。轻便实用，但不太耐用。"
	icon_state = "plant_work_cap"

/obj/item/clothing/head/uppcap/beret
	name = "\improper UL3 UPP beret"
	icon_state = "upp_beret"

/obj/item/clothing/head/uppcap/peaked
	name = "\improper UL3 UPP peaked cap"
	desc = "配发给UPP上尉及以上军官的头饰。由优质材料制成，帽前饰有军官的金色军衔。"
	icon_state = "upp_peaked"

/obj/item/clothing/head/uppcap/ushanka
	name = "\improper UL8 UPP ushanka"
	icon_state = "upp_ushanka"
	item_state = "upp_ushanka"
	var/tied = FALSE
	var/original_state = "upp_ushanka"

/obj/item/clothing/head/uppcap/ushanka/verb/flaps_up()
	set name = "Tie Up/Down"
	set category = "Object"
	set src in usr
	if(usr.is_mob_incapacitated())
		return

	tied = !tied
	if(tied)
		to_chat(usr, SPAN_NOTICE("你将\the [src]绑了起来。"))
		icon_state += "_up"
	else
		to_chat(usr, SPAN_NOTICE("你解开了\the [src]。"))
		icon_state = original_state



	update_clothing_icon(src) //Update the on-mob icon.



/obj/item/clothing/head/uppcap/ushanka/civi
	name = "\improper UL8C UPP ushanka"
	icon_state = "upp_ushanka_civi"
	item_state = "upp_ushanka_civi"
	original_state = "upp_ushanka_civi"

/obj/item/clothing/head/helmet/marine/veteran/van_bandolier
	name = "软木盔"
	desc = "时尚的软木盔，由太空时代材料制成。轻便、透气、凉爽且具有防护性。"
	icon_state = "van_bandolier"
	item_state = "s_helmet"
	icon = 'icons/obj/items/clothing/hats/misc_ert_colony.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/misc_ert_colony.dmi',
	)
	flags_marine_helmet = NO_FLAGS
	camera_factions = FACTION_LIST_COLONY


//head rag

/obj/item/clothing/head/helmet/specrag
	name = "武器专家头巾"
	desc = "重型武器操作员佩戴的帽子，用于阻挡汗水。"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
	icon_state = "spec"
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_inventory = NO_FLAGS
	flags_inv_hide = HIDEEARS|HIDETOPHAIR
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)

/obj/item/clothing/head/helmet/specrag/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi'
		if("classic")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/classic.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/classic.dmi'
		if("desert")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/desert.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/desert.dmi'
		if("snow")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/snow.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/snow.dmi'
		if("urban")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/urban.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/urban.dmi'


/obj/item/clothing/head/helmet/specrag/Initialize(mapload, ...)
	. = ..()
	select_gamemode_skin(type)

/obj/item/clothing/head/helmet/skullcap
	name = "skullcap"
	desc = "能有效防止汗水流入眼睛。"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
	icon_state = "skullcap"
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_inventory = NO_FLAGS
	flags_inv_hide = HIDEEARS|HIDETOPHAIR
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)

/obj/item/clothing/head/helmet/skullcap/Initialize(mapload, ...)
	. = ..()
	select_gamemode_skin(type)

/obj/item/clothing/head/helmet/skullcap/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi'
		if("classic")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/classic.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/classic.dmi'
		if("desert")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/desert.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/desert.dmi'
		if("snow")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/snow.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/snow.dmi'
		if("urban")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/urban.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/urban.dmi'


/obj/item/clothing/head/helmet/skullcap/jungle
	name = "\improper M8 marksman cowl"
	desc = "狙击手在丛林中用于隐藏面部的兜帽。"
	icon_state = "skullcapm"

/obj/item/clothing/head/helmet/skullcap/jungle/New(loc, type,
	new_protection[] = list(MAP_ICE_COLONY = ICE_PLANET_MIN_COLD_PROT))
	select_gamemode_skin(type, override_protection = new_protection)
	..()
	switch(icon_state)
		if("s_skullcapm")
			desc = "旨在保护佩戴者免受冻原寒冷和敌人窥视的兜帽。"
			flags_inv_hide = HIDEEARS|HIDEALLHAIR

//===========================//HELGHAST - MERCENARY\\================================\\
//=====================================================================\\

/obj/item/clothing/head/helmet/marine/veteran/mercenary
	name = "\improper K12 ceramic helmet"
	desc = "一顶由未知雇佣兵团体佩戴的坚固头盔。"
	icon_state = "mercenary_heavy_helmet"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/CLF.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/CLF.dmi'
	)
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE|BODY_FLAG_EYES
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_HIGHPLUS
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_HIGHPLUS
	flags_inventory = COVEREYES|COVERMOUTH|BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEEYES|HIDEFACE|HIDEMASK|HIDEALLHAIR
	flags_marine_helmet = HELMET_DAMAGE_OVERLAY
	camera_factions = FACTION_LIST_MERCENARY

/obj/item/clothing/head/helmet/marine/veteran/mercenary/heavy
	name = "\improper Modified K12 ceramic helmet"
	desc = "一顶由未知雇佣兵团体佩戴的坚固头盔。额外加装了防护板。"
	armor_melee = CLOTHING_ARMOR_ULTRAHIGH
	armor_bullet = CLOTHING_ARMOR_ULTRAHIGHPLUS
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_HIGHPLUS
	armor_bio = CLOTHING_ARMOR_HIGHPLUS
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_VERYHIGHPLUS

/obj/item/clothing/head/helmet/marine/veteran/mercenary/miner
	name = "\improper Y8 miner helmet"
	desc = "一顶坚固的头盔，专为采矿设计，由未知雇佣兵团体佩戴。"
	icon_state = "mercenary_miner_helmet"
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE|BODY_FLAG_EYES
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_HIGHPLUS

/obj/item/clothing/head/helmet/marine/veteran/mercenary/miner/clf
	camera_factions = FACTION_LIST_CLF

/obj/item/clothing/head/helmet/marine/veteran/mercenary/support
	name = "\improper Z7 helmet"
	desc = "一顶由未知雇佣兵团体佩戴的坚固头盔。"
	icon_state = "mercenary_engineer_helmet"
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE|BODY_FLAG_EYES
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_HIGHPLUS

/obj/item/clothing/head/helmet/marine/veteran/mercenary/support/engineer
	desc = "一顶由未知雇佣兵团体佩戴的坚固头盔。配有可切换的焊接面罩以保护眼睛。"
	built_in_visors = list(new /obj/item/device/helmet_visor/welding_visor/mercenary)

//=============================//MEME\\==================================\\
//=======================================================================\\

/obj/item/clothing/head/helmet/marine/specialist/hefa
	name = "\improper HEFA helmet"
	specialty = "HEFA"
	desc = "不知为何，看到这顶头盔让你感到极度不安。"
	icon_state = "hefa_helmet"
	item_state = "hefa_helmet"
	icon = 'icons/obj/items/clothing/hats/misc_ert_colony.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/misc_ert_colony.dmi',
	)
	armor_bomb = CLOTHING_ARMOR_HARDCORE // the hefa knight stands
	flags_inv_hide = HIDEEARS|HIDEALLHAIR|HIDEEYES
	flags_marine_helmet = NO_FLAGS
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bomb = CLOTHING_ARMOR_GIGAHIGH

	built_in_visors = list()

	var/mob/activator = null
	var/active = FALSE
	var/det_time = 40
	camera_factions = list(FACTION_HEFA)

/obj/item/clothing/head/helmet/marine/specialist/hefa/Initialize(mapload, list/new_protection)
	. = ..()
	pockets.bypass_w_limit = list(/obj/item/explosive/grenade/high_explosive/frag)

/obj/item/clothing/head/helmet/marine/specialist/hefa/proc/apply_explosion_overlay()
	var/obj/effect/overlay/O = new /obj/effect/overlay(loc)
	O.name = "grenade"
	O.icon = 'icons/effects/explosion.dmi'
	flick("grenade", O)
	QDEL_IN(O, 7)

/obj/item/clothing/head/helmet/marine/specialist/hefa/attack_self(mob/user)
	..()
	activator = user
	activate()

/obj/item/clothing/head/helmet/marine/specialist/hefa/proc/activate()
	if(active)
		return
	active = TRUE

	icon_state = initial(icon_state) + "_active"
	item_state = initial(item_state) + "_active"
	overlays += /obj/effect/overlay/danger
	playsound(loc, 'sound/weapons/armbomb.ogg', 25, 1, 6)

	addtimer(CALLBACK(src, PROC_REF(prime)), det_time)

/obj/item/clothing/head/helmet/marine/specialist/hefa/proc/prime()
	INVOKE_ASYNC(src, PROC_REF(boom))

// Values nabbed from the HEFA nade
/obj/item/clothing/head/helmet/marine/specialist/hefa/proc/boom()
	// TODO: knock down user so the shrapnel isn't all taken by the user
	var/datum/cause_data/cause_data = create_cause_data(initial(name), activator)
	create_shrapnel(loc, 48, , ,/datum/ammo/bullet/shrapnel, cause_data)
	sleep(2) //so that mobs are not knocked down before being hit by shrapnel. shrapnel might also be getting deleted by explosions?
	apply_explosion_overlay()
	cell_explosion(loc, 40, 18, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, cause_data)
	qdel(src)

/obj/item/clothing/head/helmet/marine/reporter
	name = "记者头盔"
	desc = "一项旨在明确表明佩戴者注重安全且无意挑起争斗的头盔。"
	icon_state = "cc_helmet"
	item_state = "cc_helmet"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

	built_in_visors = list()

/obj/item/clothing/head/helmet/marine/cbrn_hood
	name = "\improper M3 MOPP mask"
	desc = "M3 MOPP防毒面具包含一个全覆盖式头罩，可牢固连接到MOPP防护服上。该面具能过滤空气中的有害颗粒，使佩戴者能在污染区域安全呼吸。根据污染区域的危害程度，面具滤芯平均可持续使用12小时或更短。"
	icon_state = "cbrn_hood"
	item_state = "cbrn_hood"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi',
	)
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROT
	flags_cold_protection = BODY_FLAG_HEAD
	flags_heat_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_HARDCORE
	armor_rad = CLOTHING_ARMOR_ULTRAHIGHPLUS
	force = 0 //"The M3 MOPP mask would be a normal weapon if you were to hit someone with it."
	throwforce = 0
	flags_inventory = BLOCKSHARPOBJ|BLOCKGASEFFECT
	flags_marine_helmet = NO_FLAGS
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	flags_inv_hide = HIDEEARS|HIDEALLHAIR
	built_in_visors = list()

/obj/item/clothing/head/helmet/marine/cbrn_hood/advanced
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_ULTRAHIGH
	armor_bio = CLOTHING_ARMOR_HARDCORE
	armor_rad = CLOTHING_ARMOR_GIGAHIGHPLUS

//=ROYAL MARINES=\\

/obj/item/clothing/head/helmet/marine/veteran/royal_marine
	name = "\improper L5A2 ballistic helmet"
	desc = "一款高切防弹头盔。由Lindenthal-Ehrenfeld Militärindustrie设计，旨在供皇家海军陆战队突击队使用，作为雀鹰护甲系统的一部分。"
	icon_state = "rmc_helm1"
	item_state = "rmc_helm1"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/TWE.dmi'
	)
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS
	flags_marine_helmet = NO_FLAGS
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	built_in_visors = list(new /obj/item/device/helmet_visor/medical)
	start_down_visor_type = /obj/item/device/helmet_visor/medical
	camera_factions = FACTION_LIST_TWE

/obj/item/clothing/head/helmet/marine/veteran/royal_marine/generic
	name = "\improper L1 ballistic helmet"
	desc = "一款由Alphatech设计的多用途防弹头盔，适用于三世界帝国军队各分支及相关机构的通用需求。借鉴了USCM M10型头盔的部分设计灵感，L1型头盔能可靠防护破片和弹道威胁。"
	icon_state = "generic_helm"
	item_state = "generic_helm"
	flags_marine_helmet = HELMET_GARB_OVERLAY

/obj/item/clothing/head/helmet/marine/veteran/royal_marine/generic/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/alphatech)

/obj/item/clothing/head/helmet/marine/veteran/royal_marine/pilot
	name = "\improper PH-4 'Spitfire' flight helmet"
	desc = "三世界帝国航空航天部队的标准飞行头盔，从战斗机飞行员到大气层机组人员均有使用。这款PH-4变体专为太空运输机行动设计，具备强化护板、平视显示器光学系统和加密通讯功能。是高危突入、着陆和撤离任务的必备装备。因其在火力下的可靠性，绰号“喷火”。"
	icon_state = "pilot_helm"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/veteran/royal_marine/pilot/alt
	icon_state = "pilot_helm_alt"

/obj/item/clothing/head/helmet/marine/veteran/iasf_beret
	name = "\improper IASF beret"
	desc = "帝国武装太空部队佩戴的独特深红色贝雷帽。采用柔性凯夫拉材料加固，在保持传统且受人尊敬外观的同时提供最低限度的防护。"
	icon_state = "beret_iasf"
	item_state = "beret_iasf"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/TWE.dmi',
	)
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS
	flags_marine_helmet = NO_FLAGS

/obj/item/clothing/head/helmet/marine/veteran/iasf_beret/tl
	icon_state = "beret_iasf_tl"
	item_state = "beret_iasf_tl"

/obj/item/clothing/head/helmet/marine/veteran/royal_marine/breacher
	name = "\improper L5A3 ballistic helmet"
	desc = "一款配有下颌护板的高切防弹头盔。由Lindenthal-Ehrenfeld Militärindustrie设计，旨在供皇家海军陆战队突击队使用，作为雀鹰护甲系统的一部分。"
	icon_state = "rmc_helm_br"
	item_state = "rmc_helm_br"
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_energy = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/head/helmet/marine/veteran/royal_marine/medic
	name = "\improper L5A2 ballistic medic helmet"
	desc = "一款高切防弹头盔。由Lindenthal-Ehrenfeld Militärindustrie设计，旨在供皇家海军陆战队突击队使用，作为雀鹰护甲系统的一部分。此款配有先进的医疗平视显示器，背面有一个深绿色徽章，表明佩戴者是医疗兵。"
	icon_state = "rmc_helm_medic"
	item_state = "rmc_helm_medic"
	built_in_visors = list(new /obj/item/device/helmet_visor/medical/advanced)
	start_down_visor_type = /obj/item/device/helmet_visor/medical/advanced
