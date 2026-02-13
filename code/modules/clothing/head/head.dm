/obj/item/clothing/head
	name = "head"
	icon = 'icons/obj/items/clothing/hats/hats.dmi'
	flags_armor_protection = BODY_FLAG_HEAD
	flags_bodypart_hidden = BODY_FLAG_HEAD
	flags_equip_slot = SLOT_HEAD
	w_class = SIZE_SMALL
	blood_overlay_type = "helmet"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_righthand.dmi',
	)
	var/anti_hug = 0
	/// List of images for overlays recreated every update_icon()
	var/list/helmet_overlays

/obj/item/clothing/head/Destroy()
	helmet_overlays = null
	return ..()

/obj/item/clothing/head/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_head()

/obj/item/clothing/head/proc/has_garb_overlay()
	return FALSE

/obj/item/clothing/head/cmbandana
	name = "bandana"
	desc = "通常由重武器操作员、雇佣兵和侦察兵佩戴，头巾是一种轻便舒适的帽子。有两种时尚颜色可选。"
	icon_state = "band"
	flags_inv_hide = HIDETOPHAIR
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/cmbandana/Initialize(mapload, ...)
	. = ..()
	if(!(flags_atom & NO_GAMEMODE_SKIN))
		select_gamemode_skin(/obj/item/clothing/head/cmbandana)

/obj/item/clothing/head/cmbandana/tan
	icon_state = "band2"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi'
	)
	flags_atom = null

/obj/item/clothing/head/cmbandana/tan/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
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


/obj/item/clothing/head/beanie
	name = "beanie"
	desc = "标准军用毛线帽，通常由非战斗军事人员和支持人员佩戴，不过也常见于那些不再关心自我保护的战斗人员。因其舒适贴身而广受欢迎。"
	icon = 'icons/obj/items/clothing/hats/hats.dmi'
	icon_state = "beanie_cargo"
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats.dmi'
	)

/obj/item/clothing/head/beanie/green
	icon_state = "beaniegreen"

/obj/item/clothing/head/beanie/gray
	icon_state = "beaniegray"

/obj/item/clothing/head/beanie/tan
	icon_state = "beanietan"

/obj/item/clothing/head/beret/cm
	name = "\improper USCM beret"
	desc = "通常由USCM的野战军官佩戴的帽子。偶尔也会流传到下级，被班长和受勋的普通士兵获得。"
	icon = 'icons/obj/items/clothing/hats/berets.dmi'
	icon_state = "beret"
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/berets.dmi'
	)

/obj/item/clothing/head/beret/cm/Initialize(mapload, ...)
	. = ..()
	if(!(flags_atom & NO_GAMEMODE_SKIN))
		select_gamemode_skin(/obj/item/clothing/head/beret/cm)

/obj/item/clothing/head/beret/cm/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
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

/obj/item/clothing/head/beret/cm/tan
	icon_state = "berettan"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi'
	)

/obj/item/clothing/head/beret/cm/tan/Initialize(mapload, ...)
	. = ..()
	select_gamemode_skin(/obj/item/clothing/head/beret/cm/tan)

/obj/item/clothing/head/beret/cm/red
	icon_state = "beretred"
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/beret/cm/white
	icon = 'icons/obj/items/clothing/hats/hats_by_map/snow.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/snow.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/beret/cm/black
	icon_state = "beret_black"
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/beret/cm/green
	icon_state = "beret_green"
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/beret/cm/squadberet
	icon_state = "beret_squad"
	name = "USCM班用贝雷帽"
	desc = "献给那些想要展示自豪感且（至少在脑袋上）没什么可失去的人。"
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/beret/cm/squadberet/equipped(mob/user, slot)
	. = ..()
	self_set()
	RegisterSignal(user, COMSIG_SET_SQUAD, PROC_REF(self_set), TRUE)

/obj/item/clothing/head/beret/cm/squadberet/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, COMSIG_SET_SQUAD)

/obj/item/clothing/head/beret/cm/squadberet/proc/self_set()
	var/mob/living/carbon/human/H = loc
	if(istype(H))
		if(H.assigned_squad)
			switch(H.assigned_squad.name)
				if(SQUAD_MARINE_1)
					icon_state = "beret_alpha"
					desc = "常见于头顶，在那些还连着的脑袋上则稍少见一些。"
				if(SQUAD_MARINE_2)
					icon_state = "beret_bravo"
					desc = "上面有不少碎屑，戴这帽子的人可能比墙动得还少。"
				if(SQUAD_MARINE_3)
					icon_state = "beret_charlie"
					desc = "上面还沾着些早餐吐司的碎屑。"
				if(SQUAD_MARINE_4)
					icon_state = "beret_delta"
					desc = "很难称之为防护，但这类人寻求的也不是防护。"
				if(SQUAD_MARINE_5)
					icon_state = "beret_echo"
					desc = "紧密编织，理应如此。"
				if(SQUAD_MARINE_CRYO)
					icon_state = "beret_foxtrot"
					desc = "看起来和摸起来都像浆过一样，触感冰冷。"
				if(SQUAD_MARINE_INTEL)
					icon_state = "beret_intel"
					desc = "看起来比戴着它的人更聪明。"
		else
			icon_state = "beret"
			desc = initial(desc)
		H.update_inv_head()

/obj/item/clothing/head/beret/civilian
	name = "棕褐色贝雷帽"
	desc = "一顶时尚漂亮的贝雷帽，深受高管喜爱。"
	icon_state = "berettan"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi'
	)

/obj/item/clothing/head/beret/civilian/brown
	name = "棕色贝雷帽"
	icon_state = "berettan"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/urban.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/urban.dmi'
	)

/obj/item/clothing/head/beret/civilian/black
	name = "黑色贝雷帽"
	icon_state = "beret_black"
	icon = 'icons/obj/items/clothing/hats/berets.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/berets.dmi'
	)

/obj/item/clothing/head/beret/civilian/white
	name = "白色贝雷帽"
	icon_state = "beret"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/snow.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/snow.dmi'
	)

/obj/item/clothing/head/headband
	name = "headband"
	desc = "通常由非正统武器操作员佩戴的头巾。虽然不提供任何防护，但相比标准头盔佩戴起来确实更舒适。提供两种时尚颜色。"
	icon_state = "headband"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
	flags_obj = OBJ_NO_HELMET_BAND|OBJ_IS_HELMET_GARB
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/headbands.dmi',
	)
	item_state_slots = list(WEAR_AS_GARB = "headband")

/obj/item/clothing/head/headband/Initialize(mapload, ...)
	. = ..()
	if(!(flags_atom & NO_GAMEMODE_SKIN))
		select_gamemode_skin(/obj/item/clothing/head/headband)

/obj/item/clothing/head/headband/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi'
			item_icons[WEAR_AS_GARB] = 'icons/mob/humans/onmob/clothing/helmet_garb/helmet_garb_by_map/jungle.dmi'
		if("classic")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/classic.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/classic.dmi'
			item_icons[WEAR_AS_GARB] = 'icons/mob/humans/onmob/clothing/helmet_garb/helmet_garb_by_map/classic.dmi'
		if("desert")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/desert.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/desert.dmi'
			item_icons[WEAR_AS_GARB] = 'icons/mob/humans/onmob/clothing/helmet_garb/helmet_garb_by_map/desert.dmi'
		if("snow")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/snow.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/snow.dmi'
			item_icons[WEAR_AS_GARB] = 'icons/mob/humans/onmob/clothing/helmet_garb/helmet_garb_by_map/snow.dmi'
		if("urban")
			icon = 'icons/obj/items/clothing/hats/hats_by_map/urban.dmi'
			item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/hats_by_map/urban.dmi'
			item_icons[WEAR_AS_GARB] = 'icons/mob/humans/onmob/clothing/helmet_garb/helmet_garb_by_map/urban.dmi'

/obj/item/clothing/head/headband/red
	icon_state = "headbandred"
	item_state_slots = list(WEAR_AS_GARB = "headbandred")

/obj/item/clothing/head/headband/tan
	icon_state = "headbandtan"
	item_state_slots = list(WEAR_AS_GARB = "headbandtan")

/obj/item/clothing/head/headband/brown
	icon_state = "headbandbrown"
	icon = 'icons/obj/items/clothing/hats/headbands.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/headbands.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/headbands.dmi',
	)
	item_state_slots = list(
		WEAR_AS_GARB = "headbandbrown", // will be prefixed with either hat_ or helmet_
	)
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/headband/gray
	icon_state = "headbandgray"
	icon = 'icons/obj/items/clothing/hats/headbands.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/headbands.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/headbands.dmi',
	)
	item_state_slots = list(
		WEAR_AS_GARB = "headbandgray", // will be prefixed with either hat_ or helmet_
	)
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/headband/rebel
	desc = "由简单布条制成的头带。上面写着\"DOWN WITH TYRANTS\" are emblazoned on the front."
	icon_state = "rebelband"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/CLF.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/CLF.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/headbands.dmi',
	)
	item_state_slots = list(
		WEAR_AS_GARB = "headbandrebel", // will be prefixed with either hat_ or helmet_
	)
	item_state_slots = null
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/headband/squad
	var/dummy_icon_state = "headband%SQUAD%" // will be prefixed with either hat_ or helmet_
	icon = 'icons/obj/items/clothing/hats/headbands.dmi'
	item_state = "headband%SQUAD%"
	icon_state = "headband_squad"
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/headbands.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/headbands.dmi',
	)
	item_state_slots = null

	var/static/list/valid_icon_states
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/headband/squad/Initialize(mapload, ...)
	. = ..()
	if(!valid_icon_states)
		valid_icon_states = icon_states(icon)
	adapt_to_squad()

/obj/item/clothing/head/headband/squad/proc/update_clothing_wrapper(mob/living/carbon/human/wearer)
	SIGNAL_HANDLER

	var/is_worn_by_wearer = recursive_holder_check(src) == wearer
	if(is_worn_by_wearer)
		update_clothing_icon()
	else
		UnregisterSignal(wearer, COMSIG_SET_SQUAD) // we can't set this in dropped, because dropping into a helmet unsets it and then it never updates

/obj/item/clothing/head/headband/squad/update_clothing_icon()
	adapt_to_squad()
	if(istype(loc, /obj/item/storage/internal) && istype(loc.loc, /obj/item/clothing/head/helmet))
		var/obj/item/clothing/head/helmet/headwear = loc.loc
		headwear.update_icon()
	return ..()

/obj/item/clothing/head/headband/squad/pickup(mob/user, silent)
	. = ..()
	adapt_to_squad()

/obj/item/clothing/head/headband/squad/equipped(mob/user, slot, silent)
	RegisterSignal(user, COMSIG_SET_SQUAD, PROC_REF(update_clothing_wrapper), TRUE)
	adapt_to_squad()
	return ..()

/obj/item/clothing/head/headband/squad/proc/adapt_to_squad()
	var/squad_color = "gray"
	var/mob/living/carbon/human/wearer = recursive_holder_check(src)
	if(istype(wearer) && wearer.assigned_squad)
		var/squad_name = lowertext(wearer.assigned_squad.name)
		if("headband[squad_name]" in valid_icon_states)
			squad_color = squad_name
	icon_state = replacetext(initial(dummy_icon_state), "%SQUAD%", squad_color)

/obj/item/clothing/head/headband/rambo
	desc = "它在风中飘扬，桀骜不驯，就像佩戴它的那个人一样。"
	icon = 'icons/obj/items/clothing/halloween_clothes.dmi'
	icon_state = "headband_rambo"
	item_icons = list(
		WEAR_HEAD = 'icons/obj/items/clothing/halloween_clothes.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/headset
	name = "\improper USCM headset"
	desc = "通常由无线电操作员和军官使用的耳机。这个看起来出了故障。"
	icon_state = "headset"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/misc.dmi',
	)
	flags_obj = OBJ_IS_HELMET_GARB

GLOBAL_LIST_INIT(allowed_hat_items, list(
	/obj/item/storage/fancy/cigarettes/emeraldgreen = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/storage/fancy/cigarettes/kpack = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/storage/fancy/cigarettes/lucky_strikes = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/storage/fancy/cigarettes/wypacket = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/storage/fancy/cigarettes/lady_finger = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/storage/fancy/cigarettes/blackpack = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/storage/fancy/cigarettes/arcturian_ace = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/storage/fancy/cigarettes/spirit = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/storage/fancy/cigarettes/spirit/yellow = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/tool/pen = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/tool/pen/blue = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/tool/pen/red = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/tool/pen/multicolor/fountain = NO_GARB_OVERRIDE,
	/obj/item/clothing/glasses/welding = "welding-c",
	/obj/item/clothing/glasses/mgoggles = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/prescription = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/black = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/black/prescription = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/orange = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/orange/prescription = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2 = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2/prescription = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2/blue = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2/blue/prescription = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2/polarized_blue = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2/polarized_blue/prescription = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2/polarized_orange = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/clothing/glasses/mgoggles/v2/polarized_orange/prescription = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/helmet_nvg = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/helmet_nvg/cosmetic = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/helmet_nvg/marsoc = PREFIX_HAT_GARB_OVERRIDE,
	/obj/item/clothing/head/headband = PREFIX_HAT_GARB_OVERRIDE, // _hat
	/obj/item/clothing/head/headband/tan = PREFIX_HAT_GARB_OVERRIDE, // _hat
	/obj/item/clothing/head/headband/red = PREFIX_HAT_GARB_OVERRIDE, // _hat
	/obj/item/clothing/head/headband/brown = PREFIX_HAT_GARB_OVERRIDE, // _hat
	/obj/item/clothing/head/headband/gray = PREFIX_HAT_GARB_OVERRIDE, // _hat
	/obj/item/clothing/head/headband/squad = PREFIX_HAT_GARB_OVERRIDE, // _hat
	/obj/item/prop/helmetgarb/lucky_feather = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/lucky_feather/blue = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/lucky_feather/purple = NO_GARB_OVERRIDE,
	/obj/item/prop/helmetgarb/lucky_feather/yellow = NO_GARB_OVERRIDE,
))

/obj/item/clothing/head/cmcap
	name = "巡逻帽"
	desc = "作为非战斗制服一部分配发的便帽。虽然只能防晒，但比头盔舒适得多。"
	icon_state = "cap"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)
	var/flipped_cap = FALSE
	var/list/flipping_message = list(
		"flipped" = "You spin the hat backwards! You look like a tool.",
		"unflipped" = "You spin the hat back forwards. That's better."
		)
	var/base_cap_icon
	var/flags_marine_hat = HAT_GARB_OVERLAY|HAT_CAN_FLIP
	var/obj/item/storage/internal/headgear/pockets
	var/storage_slots = 1
	var/storage_slots_reserved_for_garb = 1
	var/storage_max_w_class = SIZE_TINY
	var/storage_max_storage_space = 4

/obj/item/clothing/head/cmcap/Initialize(mapload, ...)
	. = ..()
	if(!(flags_atom & NO_GAMEMODE_SKIN))
		select_gamemode_skin(type)
	base_cap_icon = icon_state

	helmet_overlays = list() //To make things simple.

	pockets = new(src)
	pockets.storage_slots = storage_slots + storage_slots_reserved_for_garb
	pockets.slots_reserved_for_garb = storage_slots_reserved_for_garb
	pockets.max_w_class = storage_max_w_class
	pockets.bypass_w_limit = GLOB.allowed_hat_items
	pockets.max_storage_space = storage_max_storage_space

/obj/item/clothing/head/cmcap/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
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

/obj/item/clothing/head/cmcap/Destroy()
	QDEL_NULL(pockets)
	return ..()

/obj/item/clothing/head/cmcap/attack_hand(mob/user)
	if(loc != user)
		..(user)
		return
	if(pockets.handle_attack_hand(user))
		..()

/obj/item/clothing/head/cmcap/MouseDrop(over_object, src_location, over_location)
	if(pockets.handle_mousedrop(usr, over_object))
		..()

/obj/item/clothing/head/cmcap/attackby(obj/item/W, mob/user)
	..()
	return pockets.attackby(W, user)

/obj/item/clothing/head/cmcap/on_pocket_insertion()
	update_icon()

/obj/item/clothing/head/cmcap/on_pocket_removal()
	update_icon()

/obj/item/clothing/head/cmcap/update_icon()
	helmet_overlays = list() // Rebuild our list every time
	if(length(pockets?.contents) && (flags_marine_hat & HAT_GARB_OVERLAY))
		for(var/obj/item/garb_object in pockets.contents)
			if(garb_object.type in GLOB.allowed_hat_items)
				var/image/new_overlay = garb_object.get_garb_overlay(GLOB.allowed_hat_items[garb_object.type])
				helmet_overlays += new_overlay

	if(ismob(loc))
		var/mob/moob = loc
		moob.update_inv_head()

/obj/item/clothing/head/cmcap/has_garb_overlay()
	return flags_marine_hat & HAT_GARB_OVERLAY

/obj/item/clothing/head/cmcap/verb/fliphat()
	set name = "Flip hat"
	set category = "Object"
	set src in usr
	if(!isliving(usr))
		return
	if(usr.is_mob_incapacitated())
		return
	if(!(flags_marine_hat & HAT_CAN_FLIP))
		to_chat(usr, SPAN_WARNING("[src]无法翻转！"))
		return

	flags_marine_hat ^= HAT_FLIPPED

	if(flags_marine_hat & HAT_FLIPPED)
		to_chat(usr, flipping_message["flipped"])
		icon_state = base_cap_icon + "_b"
	else
		to_chat(usr, flipping_message["unflipped"])
		icon_state = base_cap_icon

	update_clothing_icon()

/obj/item/clothing/head/cmcap/boonie
	name = "\improper USCM boonie hat"
	desc = "一顶软塌塌的丛林帽。仅能防晒防雨，但非常舒适。"
	icon_state = "booniehat"
	flipping_message = list(
		"flipped" = "You tuck the hat's chinstrap away. Hopefully the wind doesn't nick it...",
		"unflipped" = "You hook the hat's chinstrap under your chin. Peace of mind is worth a little embarassment."
		)

/obj/item/clothing/head/cmcap/boonie/tan
	icon_state = "booniehattan"
	flags_atom = FPRINT|NO_GAMEMODE_SKIN

/obj/item/clothing/head/cmcap/boonie/fisherman
	name = "\improper fisherman's boonie hat"
	desc = "一顶软塌塌的宽边帽，帽圈上塞着鱼钩、鱼线和铅坠——显然是经验丰富的垂钓者的选择。提供遮阳和一定的防雨功能。"
	icon_state = "booniehat_fisher"
	flags_atom = FPRINT|NO_GAMEMODE_SKIN
	icon = 'icons/obj/items/clothing/hats/hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats.dmi'
	)

/obj/item/clothing/head/cmcap/co
	name = "\improper USCM Commanding officer cap"
	icon_state = "cocap"
	desc = "通常由USCM高级军官佩戴的帽子。虽然不提供防护，但一些军官在战场上佩戴它以使自己更易辨认。"

/obj/item/clothing/head/cmcap/co/formal
	name = "\improper USCM formal Commanding Officer's white cap"
	desc = "USCM高级军官佩戴的正式军帽。"
	icon_state = "co_formalhat_white"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)
	flags_marine_hat = HAT_GARB_OVERLAY
	flags_atom = FPRINT|NO_GAMEMODE_SKIN

/obj/item/clothing/head/cmcap/co/formal/black
	name = "\improper USCM formal Commanding Officer's black cap"
	icon_state = "co_formalhat_black"

/obj/item/clothing/head/cmcap/req
	name = "\improper USCM requisition cap"
	desc = "这是一顶不那么花哨的帽子，配给不那么花哨的军事补给文员。"
	icon_state = "cargocap"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN

/obj/item/clothing/head/cmcap/req/ro
	name = "\improper USCM quartermaster cap"
	desc = "这是一顶花哨的帽子，配给不那么花哨的军事补给文员。"
	icon_state = "rocap"

/obj/item/clothing/head/cmcap/bridge
	name = "\improper USCM officer cap"
	desc = "通常由USCM军官佩戴的帽子。虽然不提供防护，但一些军官在战场上佩戴它以使自己更易辨认。"
	icon_state = "cap_officer"

/obj/item/clothing/head/cmcap/flap
	name = "\improper USCM expedition cap"
	desc = "这是一顶带护耳的帽子。前面缝着一块补丁，上面写着\"<b>USS ALMAYER</b>\"."
	icon_state = "flapcap"
	flags_marine_hat = HAT_GARB_OVERLAY

/obj/item/clothing/head/cmcap/reporter
	name = "战地记者帽"
	desc = "一顶可靠的帽子，适合战地记者可能遇到的任何地形。"
	icon_state = "cc_flagcap"
	item_state = "cc_flagcap"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	flags_marine_hat = HAT_GARB_OVERLAY

/obj/item/clothing/head/cmo
	name = "\improper Chief Medical Officer's Peaked Cap"
	desc = "配发给高级文职医疗官的平顶帽。看起来有点傻气。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	icon_state = "cmohat"
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)

//============================//BERETS\\=================================\\
//=======================================================================\\
//Berets DO NOT have armor, so they have their own category. PMC caps are helmets, so they're in helmets.dm.
/obj/item/clothing/head/beret/marine
	name = "陆战队军官贝雷帽"
	desc = "一顶印有USCM徽章的贝雷帽。它散发着敬意与权威。"
	icon_state = "beret_badge"

/obj/item/clothing/head/beret/marine/mp
	name = "\improper USCM MP beret"
	icon_state = "beretred"
	desc = "一顶印有USCM宪兵徽章的贝雷帽。"
	icon = 'icons/obj/items/clothing/hats/berets.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/berets.dmi'
	)
	black_market_value = 25

/obj/item/clothing/head/beret/marine/mp/warden
	name = "\improper USCM MP warden peaked cap"
	icon_state = "warden"
	desc = "一顶印有USCM宪兵中尉徽章的平顶帽。通常由USCM舰船上的典狱长佩戴。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)

/obj/item/clothing/head/beret/marine/mp/cmp
	name = "\improper USCM chief MP beret"
	desc = "一顶印有USCM宪兵上尉徽章的贝雷帽。它闪烁着腐败权威的光芒，还沾着一点甜甜圈的污渍。"
	icon_state = "beretwo"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)
	black_market_value = 30

/obj/item/clothing/head/beret/marine/mp/mppeaked
	name = "\improper USCM MP peaked cap"
	desc = "USCM宪兵佩戴的平顶帽。它让你想起了曾在历史书上读到过的某个事件。"
	icon_state = "mppeaked"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)

/obj/item/clothing/head/beret/marine/mp/mpcap
	name = "\improper USCM MP ball-cap"
	desc = "一顶棒球帽，通常由USCM宪兵中较为随性的人员佩戴。"
	icon_state = "mpcap"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)

/obj/item/clothing/head/beret/marine/mp/provost
	name = "\improper USCM provost beret"
	desc = "一顶印有USCM宪兵徽章的贝雷帽。"
	icon_state = "beretwo"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)


/obj/item/clothing/head/beret/marine/mp/provost/senior
	name = "\improper USCM senior provost beret"
	desc = "一顶印有USCM宪兵徽章的贝雷帽。"
	icon_state = "coblackberet"

/obj/item/clothing/head/beret/marine/mp/provost/chief
	name = "\improper USCM provost command beret"
	icon_state = "pvciberet"

/obj/item/clothing/head/beret/marine/commander
	name = "陆战队员指挥官贝雷帽"
	desc = "一顶绣有指挥官徽章的贝雷帽。佩戴者可能会感到责任的重担压在头上和肩上。"
	icon_state = "coberet"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi'
	)
	black_market_value = 30

/obj/item/clothing/head/beret/marine/commander/Initialize(mapload, ...)
	. = ..()
	if(!(flags_atom & NO_GAMEMODE_SKIN))
		select_gamemode_skin(/obj/item/clothing/head/beret/marine/commander)

/obj/item/clothing/head/beret/marine/commander/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
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

/obj/item/clothing/head/beret/marine/commander/dress
	name = "陆战队员少校白色贝雷帽"
	desc = "一顶绣有少校徽章的白色贝雷帽。其耀眼的白色彰显权力与格调。"
	icon_state = "codressberet"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/beret/marine/commander/black
	name = "陆战队员少校黑色贝雷帽"
	desc = "一顶绣有少校徽章的黑色贝雷帽。其光滑的黑色彰显权力与格调。"
	icon_state = "coblackberet"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/beret/marine/commander/council
	name = "陆战队员上校贝雷帽"
	desc = "一顶绣有中校徽章的蓝色贝雷帽。其蓝色象征着忠诚、自信与政治手腕——一名真正上校的核心特质。"
	icon_state = "cdreberet"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/beret/marine/commander/councilchief
	name = "陆战队员上校贝雷帽"
	desc = "一顶深蓝色、定制裁剪的贝雷帽，象征着上校。这绝对不是将军的化名。"
	icon_state = "cdrechiefberet"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/marine/peaked
	name = "陆战队员大檐帽"
	desc = "一顶大檐帽。佩戴者可能会感到责任的重担压在头上和肩上。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	icon_state = "marine_formal"
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)

/obj/item/clothing/head/marine/peaked/service
	name = "陆战队员常服大檐帽"
	desc = "一顶大檐帽。佩戴者可能会感到责任的重担压在头上和肩上。"
	icon_state = "marine_service"

/obj/item/clothing/head/marine/peaked/captain
	name = "陆战队员指挥官大檐帽"
	desc = "一顶绣有指挥官徽章的大檐帽。佩戴者可能会感到责任的重担压在头上和肩上。"
	icon_state = "copeaked"
	black_market_value = 30

/obj/item/clothing/head/marine/peaked/captain/white
	name = "指挥官白色礼服大檐帽"
	desc = "一顶为指挥官准备的白色海军风格大檐帽。佩戴者可能会感到责任的重担压在头上。"
	icon_state = "co_peakedcap_white"

/obj/item/clothing/head/marine/peaked/captain/black
	name = "指挥官黑色礼服大檐帽"
	desc = "一顶为指挥官准备的黑色海军风格大檐帽。佩戴者可能会感到责任的重担压在头上。"
	icon_state = "co_peakedcap_black"

/obj/item/clothing/head/beret/marine/chiefofficer
	name = "首席军官贝雷帽"
	desc = "一顶绣有少校徽章的贝雷帽。它散发着黑暗的气息，可能会腐蚀灵魂。"
	icon_state = "hosberet"

/obj/item/clothing/head/beret/marine/techofficer
	name = "技术军官贝雷帽"
	desc = "一顶绣有中尉徽章的贝雷帽。它有种难以言喻的高效感……"
	icon_state = "e_beret_badge"

/obj/item/clothing/head/beret/marine/logisticsofficer
	name = "后勤军官贝雷帽"
	desc = "一顶绣有中尉徽章的贝雷帽。它能激发一种受尊敬的感觉。"
	icon_state = "beret_badge"

/obj/item/clothing/head/beret/marine/ro
	name = "\improper USCM quartermaster beret"
	desc = "一顶绣有中士徽章的贝雷帽。它象征着辛勤工作和见不得光的勾当。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)
	icon_state = "ro_beret"


//==========================//PROTECTIVE\\===============================\\
//=======================================================================\\

/obj/item/clothing/head/ushanka
	name = "ushanka"
	desc = "西伯利亚冬天的完美选择，对吧？"
	icon_state = "ushankadown"
	item_state = "ushankadown"
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS

/obj/item/clothing/head/ushanka/attack_self(mob/user)
	..()

	if(src.icon_state == "ushankadown")
		src.icon_state = "ushankaup"
		src.item_state = "ushankaup"
		to_chat(user, "你掀起了乌沙帽的护耳。")
	else
		src.icon_state = "ushankadown"
		src.item_state = "ushankadown"
		to_chat(user, "你放下了乌沙帽的护耳。")


/obj/item/clothing/head/bearpelt
	name = "熊皮帽"
	desc = "毛茸茸的。"
	icon_state = "bearpelt"
	siemens_coefficient = 2
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_CHEST|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD|BODY_FLAG_CHEST|BODY_FLAG_ARMS
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDETOPHAIR

/obj/item/clothing/head/ivanberet
	name = "\improper Black Beret"
	desc = "由特种部队军官佩戴。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UPP.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UPP.dmi'
	)
	icon_state = "ivan_beret"
	item_state = "ivan_beret"
	siemens_coefficient = 2
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = COVEREYES|COVERMOUTH|BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS

/obj/item/clothing/head/beret/SOF_beret
	name = "\improper SOF beret"
	desc = "一顶由UPP太空作战部队成员佩戴的精制贝雷帽。它象征着在深空任务和行星行动中的服役，是其佩戴者纪律与战友情谊的标志。"
	icon_state = "SOF_beret"
	item_state = "SOF_beret"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UPP.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UPP.dmi'
	)

/obj/item/clothing/head/beret/army_beret
	name = "\improper UPP reservist beret"
	desc = "一顶由UPP武装力量预备役人员佩戴的精良贝雷帽。它象征着他们即使不在现役也持续对事业的奉献，是团结与服务的象征。"
	icon_state = "army_beret"
	item_state = "army_beret"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UPP.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UPP.dmi'
	)

/obj/item/clothing/head/CMB
	name = "\improper Colonial Marshal Bureau cap"
	desc = "一项深色帽子，上面印有代表外缘星域正义、权威与保护的强大字母‘MARSHAL’。地球的法律延伸至太阳系之外。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/CMB.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/CMB.dmi'
	)
	icon_state = "cmbcap"
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS

/obj/item/clothing/head/CMB/beret
	name = "\improper CMB Riot Control Unit beret"
	desc = "一顶带有“MARSHAL”字样徽章的深色贝雷帽，代表着外缘地带的正义、权威与保护。地球的法律延伸至太阳系之外。"
	icon_state = "cmb_beret"

/obj/item/clothing/head/CMB/beret/marshal
	name = "\improper CMB Riot Control Unit Marshal beret"
	icon_state = "cmb_sheriff_beret"

/obj/item/clothing/head/freelancer
	name = "\improper armored Freelancer cap"
	desc = "一顶结实的自由职业者帽。比看起来更具防护性。"
	icon = 'icons/obj/items/clothing/hats/misc_ert_colony.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/misc_ert_colony.dmi'
	)
	icon_state = "freelancer_cap"
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

/obj/item/clothing/head/freelancer/beret
	name = "\improper armored Freelancer beret"
	icon_state = "freelancer_beret"

/obj/item/clothing/head/militia
	name = "\improper armored militia cowl"
	desc = "一些民兵使用的大号兜帽，旨在边疆地区隐匿行踪。由于生产中使用的高强度纤维，提供了一定的头部防护。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/CLF.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/CLF.dmi'
	)
	icon_state = "rebel_hood"
	siemens_coefficient = 2
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_CHEST
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDETOPHAIR

/obj/item/clothing/head/militia/bucket
	name = "bucket"
	desc = "这个金属桶似乎经过了改造，加装了衬垫和下巴绑带，还在\"front\". Presumably, it is intended to be worn on the head, possibly for protection."
	icon_state = "bucket"

/obj/item/clothing/head/militia/brown
	name = "\improper armored militia hood"
	desc = "一些民兵使用的大号兜帽，为在边疆地区完全隐匿而改装。由于生产中使用的高强度纤维，提供了一定的头部防护。"
	icon_state = "coordinator_hood"

/obj/item/clothing/head/beret/clf
	name = "\improper Colonial Liberation Front beret"
	desc = "一顶重新利用的缴获警用贝雷帽，原本佩戴警徽的位置换上了CLF的徽章。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/CLF.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/CLF.dmi'
	)
	icon_state = "CLF_beret"
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS

/obj/item/clothing/head/general
	name = "\improper USCM officer peaked service cap"
	desc = "标准配发的军官常服帽，由USCM委任军官在正式访问时佩戴。"
	icon_state = "general_helmet"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi',
	)
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ


/obj/item/clothing/head/durag
	name = "durag"
	desc = "用标准配发的围巾临时制作的头巾。能有效防止汗水流入眼睛并保护头发。"
	icon_state = "durag"
	icon = 'icons/obj/items/clothing/hats/hats_by_map/jungle.dmi'
	flags_inv_hide = HIDETOPHAIR
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_map/jungle.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)

/obj/item/clothing/head/durag/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
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


/obj/item/clothing/head/durag/Initialize(mapload, ...)
	. = ..()
	select_gamemode_skin(/obj/item/clothing/head/durag)

/obj/item/clothing/head/durag/black
	icon_state = "duragblack"
	desc = "用黑色围巾临时制作的头巾。能有效防止汗水流入眼睛并保护头发。"
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/head/drillhat
	name = "\improper USCM drill hat"
	desc = "训练教官佩戴的正式帽子。管好你的胡子。"
	icon_state = "drillhat"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)

//==========================//DRESS BLUES\\===============================\\
//=======================================================================\\

/obj/item/clothing/head/marine/dress_cover
	name = "陆战队蓝色礼服帽"
	desc = "传奇的陆战队蓝色礼服组合帽，自19世纪以来几乎未变。抛光的徽章骄傲地置于白色布料之上。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/UA.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/UA.dmi'
	)
	icon_state = "e_cap"
	item_state = "e_cap"

/obj/item/clothing/head/marine/dress_cover/officer
	name = "陆战队蓝色礼服军官帽"
	desc = "传奇的陆战队蓝色礼服组合帽，自19世纪以来几乎未变。带有金色条纹和银色徽章，是军官的象征。"
	icon_state = "o_cap"
	item_state = "o_cap"

/obj/item/clothing/head/owlf_hood
	name = "\improper OWLF thermal hood"
	desc = "这个兜帽连接着一套内置热光学隐形技术的高科技套装。"
	icon = 'icons/obj/items/clothing/hats/misc_ert_colony.dmi'
	icon_state = "owlf_hood"
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/misc_ert_colony.dmi'
	)
	item_state = "owlf_hood"


//=ROYAL MARINES=\\

/obj/item/clothing/head/beanie/royal_marine
	name = "皇家陆战队无檐帽"
	desc = "一顶标准的军用无檐帽。"
	icon_state = "rmc_beanie"
	item_state = "rmc_beanie"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/TWE.dmi'
	)

/obj/item/clothing/head/beanie/royal_marine/turban
	name = "皇家陆战队头巾"
	desc = "皇家陆战队中的标准军用头巾。这类头巾被认为是稀有物品，在UA备受收藏家珍视。"
	icon_state = "rmc_turban"
	item_state = "rmc_turban"

/obj/item/clothing/head/beret/royal_marine
	name = "皇家陆战队贝雷帽"
	desc = "属于皇家陆战队突击队的绿色贝雷帽。这顶贝雷帽象征着皇家陆战队在任何环境下作战的能力——沙漠、海洋、极地或太空，皇家陆战队员时刻准备着。"
	icon_state = "rmc_beret"
	item_state = "rmc_beret"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/TWE.dmi'
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/TWE.dmi'
	)

/obj/item/clothing/head/beret/royal_marine/team_leader
	icon_state = "rmc_beret_tl"
	item_state = "rmc_beret_tl"

/obj/item/clothing/head/beret/iasf_commander_cap
	name = "IASF军官常服帽"
	desc = "帝国武装太空部队军官佩戴的杰出常服帽。配有深红色帽带、金色IASF徽章和黑色漆皮帽檐，体现了帝国空中指挥部的纪律与权威。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/TWE.dmi'
	)
	icon_state = "iasf_co_cap"
	item_state = "iasf_co_cap"
