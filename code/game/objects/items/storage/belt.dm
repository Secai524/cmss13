/obj/item/storage/belt
	name = "belt"
	desc = "可容纳各种物品。"
	icon_state = "utilitybelt"
	icon = 'icons/obj/items/clothing/belts/belts.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_righthand.dmi',
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts.dmi'
	)
	item_state = "utility"
	flags_equip_slot = SLOT_WAIST
	attack_verb = list("whipped", "lashed", "disciplined")
	w_class = SIZE_LARGE
	storage_flags = STORAGE_FLAGS_POUCH
	cant_hold = list(/obj/item/weapon/throwing_knife)
	///TRUE Means that it closes a flap over its contents, and therefore update_icon should lift that flap when opened. If it doesn't have _half and _full iconstates, this doesn't matter either way.
	var/flap = TRUE
	/// Indiciates whether the _half and _full overlays should be applied in update_icon
	var/skip_fullness_overlays = FALSE

/obj/item/storage/belt/equipped(mob/user, slot)
	switch(slot)
		if(WEAR_WAIST, WEAR_J_STORE, WEAR_BACK)
			mouse_opacity = MOUSE_OPACITY_OPAQUE //so it's easier to click when properly equipped.
	..()

/obj/item/storage/belt/dropped(mob/user)
	mouse_opacity = initial(mouse_opacity)
	..()

/obj/item/storage/belt/update_icon()
	overlays.Cut()

	if(skip_fullness_overlays)
		return
	if(!length(contents))
		return
	if(content_watchers && flap) //If it has a flap and someone's looking inside it, don't close the flap.
		return

	if(length(contents) <= storage_slots * 0.5)
		overlays += "+[icon_state]_half"
	else
		overlays += "+[icon_state]_full"

/obj/item/storage/belt/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/ammo_magazine/shotgun))
		if(/obj/item/ammo_magazine/handful in src.can_hold)
			var/obj/item/ammo_magazine/shotgun/M = W
			dump_ammo_to(M,user, M.transfer_handful_amount)
			return
	. = ..()


/obj/item/storage/belt/champion
	name = "冠军腰带"
	desc = "向世界证明你是最强的！"
	icon_state = "championbelt"
	item_state = "champion"
	icon = 'icons/obj/items/clothing/belts/misc.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/misc.dmi'
	)
	storage_slots = 1
	can_hold = list(/obj/item/clothing/mask/luchador)
	skip_fullness_overlays = TRUE

//============================//MARINE BELTS\\==================================\\
//=======================================================================\\


/obj/item/storage/belt/utility
	name = "\improper M276 pattern toolbelt rig" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "M276是USCM的标准负重装备。它由一个带有各种弹夹的模块化腰带组成。此版本没有任何战斗功能，通常被工程师用来运输重要工具。"
	icon_state = "utilitybelt"
	item_state = "utility"
	can_hold = list(
		/obj/item/tool/crowbar,
		/obj/item/tool/screwdriver,
		/obj/item/tool/weldingtool,
		/obj/item/tool/wirecutters,
		/obj/item/tool/wrench,
		/obj/item/tool/extinguisher/mini,
		/obj/item/tool/shovel/etool,
		/obj/item/stack/cable_coil,
		/obj/item/weapon/gun/smg/nailgun/compact,
		/obj/item/cell,
		/obj/item/circuitboard,
		/obj/item/stock_parts,
		/obj/item/device/demo_scanner,
		/obj/item/device/reagent_scanner,
		/obj/item/device/assembly,
		/obj/item/device/multitool,
		/obj/item/device/flashlight,
		/obj/item/device/t_scanner,
		/obj/item/device/analyzer,
		/obj/item/explosive/plastic,
		/obj/item/device/lightreplacer,
		/obj/item/device/defibrillator/synthetic,
	)
	bypass_w_limit = list(
		/obj/item/tool/shovel/etool,
		/obj/item/device/lightreplacer,
	)
	storage_slots = 10

/obj/item/storage/belt/utility/full/fill_preset_inventory()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/stack/cable_coil(src,30,pick("red","yellow","orange"))
	new /obj/item/device/multitool(src)


/obj/item/storage/belt/utility/atmostech/fill_preset_inventory()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/device/t_scanner(src)

/obj/item/storage/belt/utility/construction
	name = "\improper M277 pattern construction rig"
	desc = "M277是战斗技术员常用的装备，用于携带材料和其他补给。它由一个带有各种弹夹的模块化腰带组成。此版本牺牲了存储空间，换来了专用的材料装载夹。"
	storage_slots = 6
	can_hold = list(
		/obj/item/tool/crowbar,
		/obj/item/tool/screwdriver,
		/obj/item/tool/weldingtool,
		/obj/item/tool/wirecutters,
		/obj/item/tool/wrench,
		/obj/item/tool/extinguisher/mini,
		/obj/item/tool/shovel/etool,
		/obj/item/stack/cable_coil,
		/obj/item/weapon/gun/smg/nailgun/compact,
		/obj/item/cell,
		/obj/item/circuitboard,
		/obj/item/stock_parts,
		/obj/item/device/demo_scanner,
		/obj/item/device/reagent_scanner,
		/obj/item/device/assembly,
		/obj/item/device/multitool,
		/obj/item/device/flashlight,
		/obj/item/device/t_scanner,
		/obj/item/device/analyzer,
		/obj/item/explosive/plastic,
		/obj/item/device/lightreplacer,
		/obj/item/stack/sheet,
		/obj/item/stack/sandbags_empty,
		/obj/item/stack/sandbags,
		/obj/item/stack/barbed_wire,
		/obj/item/defenses/handheld,
		/obj/item/stack/rods,
		/obj/item/stack/tile,
		/obj/item/device/defibrillator/synthetic,
	)

	bypass_w_limit = list(
		/obj/item/tool/shovel/etool,
		/obj/item/device/lightreplacer,
		/obj/item/stack/sheet,
		/obj/item/stack/sandbags_empty,
		/obj/item/stack/sandbags,
		/obj/item/defenses/handheld,
	)

/obj/item/storage/belt/medical
	name = "\improper M276 pattern medical storage rig"
	desc = "M276是USCM的标准负重装备。它由一个带有各种弹夹的模块化腰带组成。此版本是一种不太常见的配置，旨在运输体积较大的医疗用品。\n右键点击其图标并点击\"toggle belt mode\" to take pills out of bottles by simply clicking them."
	icon_state = "medicalbelt"
	item_state = "medical"
	storage_slots = 14
	max_w_class = SIZE_MEDIUM
	max_storage_space = 28
	instant_pill_grabbable = TRUE // If TRUE, pills can be taken directly from bottles while in hand/equipped.

	can_hold = list(
		/obj/item/device/healthanalyzer,
		/obj/item/reagent_container/dropper,
		/obj/item/reagent_container/glass/beaker,
		/obj/item/reagent_container/glass/bottle,
		/obj/item/reagent_container/pill,
		/obj/item/reagent_container/syringe,
		/obj/item/tool/lighter,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/device/flashlight/pen,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/gloves/latex,
		/obj/item/storage/syringe_case,
		/obj/item/device/flashlight/flare,
		/obj/item/reagent_container/hypospray,
		/obj/item/bodybag,
		/obj/item/device/defibrillator,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/device/reagent_scanner,
		/obj/item/device/analyzer/plant_analyzer,
		/obj/item/roller,
		/obj/item/tool/surgery/synthgraft,
		/obj/item/reagent_container/glass/minitank,
		/obj/item/storage/surgical_case,
		/obj/item/reagent_container/blood,
	)

/obj/item/storage/belt/medical/full/fill_preset_inventory()
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/storage/pill_bottle/antitox(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/oxycodone(src)
	new /obj/item/storage/pill_bottle/peridaxon(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)


/obj/item/storage/belt/medical/full/with_defib_and_analyzer/fill_preset_inventory()
	. = ..()
	new /obj/item/device/defibrillator(src)
	new /obj/item/device/healthanalyzer(src)

/obj/item/storage/belt/medical/full/with_suture_and_graft/fill_preset_inventory()
	. = ..()
	new /obj/item/tool/surgery/surgical_line(src)
	new /obj/item/tool/surgery/synthgraft(src)

/obj/item/storage/belt/medical/get_examine_text()
	. = ..()
	. += SPAN_NOTICE("The belt is currently set to [instant_pill_grab_mode ? "take pills directly from bottles": "NOT take pills directly from bottles"].")

/obj/item/storage/belt/medical/lifesaver
	name = "\improper M276 pattern lifesaver bag"
	desc = "M276是USCM的标准负重装备。此配置挂载了一个装满各种注射器和轻型医疗用品的行李袋，在医疗兵中很常见。\n右键点击其图标并点击\"toggle belt mode\" to take pills out of bottles by simply clicking them."
	icon_state = "medicbag"
	item_state = "medicbag"
	icon = 'icons/obj/items/clothing/belts/belts_by_map/jungle.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/jungle.dmi'
	)
	storage_slots = 21 //can hold 3 "rows" of very limited medical equipment, but it *should* give a decent boost to squad medics.
	max_storage_space = 42
	max_w_class = SIZE_SMALL
	can_hold = list(
		/obj/item/device/healthanalyzer,
		/obj/item/bodybag,
		/obj/item/reagent_container/glass/bottle,
		/obj/item/reagent_container/pill,
		/obj/item/reagent_container/syringe,
		/obj/item/storage/pill_bottle,
		/obj/item/clothing/gloves/latex,
		/obj/item/reagent_container/hypospray/autoinjector,
		/obj/item/stack/medical,
		/obj/item/device/defibrillator/compact,
		/obj/item/device/reagent_scanner,
		/obj/item/device/analyzer/plant_analyzer,
	)
	flags_atom = FPRINT // has gamemode skin

/obj/item/storage/belt/medical/lifesaver/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/jungle.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/jungle.dmi'
		if("classic")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/classic.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/classic.dmi'
		if("desert")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/desert.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/desert.dmi'
		if("snow")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/snow.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/snow.dmi'
		if("urban")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/urban.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/urban.dmi'

/obj/item/storage/belt/medical/lifesaver/full/fill_preset_inventory()
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/reagent_container/hypospray/autoinjector/adrenaline(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dexalinp(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/storage/pill_bottle/antitox(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/oxycodone(src)
	new /obj/item/storage/pill_bottle/peridaxon(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/belt/medical/lifesaver/full/dutch/fill_preset_inventory()
	new /obj/item/stack/medical/advanced/bruise_pack/upgraded(src)
	new /obj/item/stack/medical/advanced/bruise_pack/upgraded(src)
	new /obj/item/stack/medical/advanced/ointment/upgraded(src)
	new /obj/item/stack/medical/advanced/ointment/upgraded(src)
	new /obj/item/reagent_container/hypospray/autoinjector/adrenaline(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dexalinp(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/storage/pill_bottle/antitox(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/oxycodone(src)
	new /obj/item/storage/pill_bottle/peridaxon(src)
	new /obj/item/stack/medical/splint/nano(src)
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/storage/pill_bottle/imidazoline(src)
	new /obj/item/storage/pill_bottle/alkysine(src)

/obj/item/storage/belt/medical/lifesaver/full/dutch/black
	icon = 'icons/obj/items/clothing/belts/belts_by_map/snow.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

/obj/item/storage/belt/medical/lifesaver/wy
	name = "\improper WY-TM625 pattern medical bag"
	desc = "WY-TM625是W-Y安全部队的标准负重装备。此配置挂载了一个装满各种注射器和轻型医疗用品的行李袋，在医疗兵中很常见。\n右键点击其图标并点击\"toggle belt mode\" to take pills out of bottles by simply clicking them."
	icon_state = "wy_medicbag"
	item_state = "wy_medicbag"
	icon = 'icons/obj/items/clothing/belts/belts_by_faction/WY.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_faction/WY.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_L_HAND = "medicbag",
		WEAR_R_HAND = "medicbag"
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

/obj/item/storage/belt/medical/lifesaver/wy/full/fill_preset_inventory()
	new /obj/item/stack/medical/advanced/bruise_pack/upgraded(src)
	new /obj/item/stack/medical/advanced/bruise_pack/upgraded(src)
	new /obj/item/stack/medical/advanced/ointment/upgraded(src)
	new /obj/item/stack/medical/advanced/ointment/upgraded(src)
	new /obj/item/reagent_container/hypospray/autoinjector/adrenaline(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dexalinp(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/storage/pill_bottle/antitox(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/oxycodone(src)
	new /obj/item/storage/pill_bottle/peridaxon(src)
	new /obj/item/stack/medical/splint/nano(src)
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/storage/pill_bottle/imidazoline(src)
	new /obj/item/storage/pill_bottle/alkysine(src)

/obj/item/storage/belt/medical/lifesaver/wy/partial/fill_preset_inventory()
	new /obj/item/stack/medical/advanced/bruise_pack/upgraded(src)
	new /obj/item/stack/medical/advanced/ointment/upgraded(src)
	new /obj/item/stack/medical/splint/nano(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/device/healthanalyzer(src)

/obj/item/storage/belt/medical/lifesaver/full/forecon/fill_preset_inventory()
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/oxycodone(src)
	new /obj/item/storage/pill_bottle/antitox(src)
	new /obj/item/storage/pill_bottle/alkysine(src)
	new /obj/item/storage/pill_bottle/imidazoline(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dexalinp(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/device/healthanalyzer(src)

/obj/item/storage/belt/medical/lifesaver/dutch/partial/fill_preset_inventory()
	new /obj/item/stack/medical/advanced/bruise_pack/upgraded(src)
	new /obj/item/stack/medical/advanced/ointment/upgraded(src)
	new /obj/item/stack/medical/splint/nano(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/device/healthanalyzer(src)

/obj/item/storage/belt/medical/lifesaver/upp
	name = "\improper Type 41 pattern lifesaver bag"
	desc = "41型负重装备是UPP军队的标准负重装备。此配置挂载了一个装满各种注射器和轻型医疗用品的行李袋，在医疗兵中很常见。"
	icon_state = "medicbag_u"
	item_state = "medicbag_u"
	icon = 'icons/obj/items/clothing/belts/belts_by_faction/UPP.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_faction/UPP.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_righthand.dmi'
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

/obj/item/storage/belt/medical/lifesaver/upp/full/fill_preset_inventory()
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/reagent_container/hypospray/autoinjector/adrenaline(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dexalinp(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/storage/pill_bottle/antitox(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/oxycodone(src)
	new /obj/item/storage/pill_bottle/peridaxon(src)

/obj/item/storage/belt/medical/lifesaver/upp/partial/fill_preset_inventory()
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/tramadol(src)

/obj/item/storage/belt/medical/lifesaver/upp/synth/fill_preset_inventory()
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/oxycodone(src)
	new /obj/item/storage/pill_bottle/antitox(src)
	new /obj/item/storage/pill_bottle/alkysine(src)
	new /obj/item/storage/pill_bottle/imidazoline(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dexalinp(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/device/healthanalyzer(src)

/obj/item/storage/belt/medical/lifesaver/upp/black
	icon_state = "medicbag_black_u"
	item_state = "medicbag_black_u"

/obj/item/storage/belt/medical/lifesaver/upp/black/full/fill_preset_inventory()
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/reagent_container/hypospray/autoinjector/adrenaline(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dexalinp(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/storage/pill_bottle/antitox(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/peridaxon(src)
	new /obj/item/storage/pill_bottle/oxycodone(src)

/obj/item/storage/belt/medical/lifesaver/upp/black/partial/fill_preset_inventory()
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/tramadol(src)

/obj/item/storage/belt/medical/lifesaver/upp/black/synth/fill_preset_inventory()
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/oxycodone(src)
	new /obj/item/storage/pill_bottle/antitox(src)
	new /obj/item/storage/pill_bottle/alkysine(src)
	new /obj/item/storage/pill_bottle/imidazoline(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dexalinp(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/device/healthanalyzer(src)

/obj/item/storage/belt/security
	name = "\improper M276 pattern security rig"
	desc = "M276是USCM的标准负重装备。它由一个带有各种弹夹的模块化腰带组成。此配置常见于USCM宪兵和维和人员，不过也能携带一些轻型弹药。"
	icon_state = "securitybelt"
	item_state = "security"//Could likely use a better one.
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_L_HAND = "marinebelt",
		WEAR_R_HAND = "marinebelt"
	)
	storage_slots = 7
	max_w_class = SIZE_MEDIUM
	max_storage_space = 21
	can_hold = list(
		/obj/item/explosive/grenade/flashbang,
		/obj/item/explosive/grenade/custom/teargas,
		/obj/item/reagent_container/spray/pepper,
		/obj/item/restraint/handcuffs,
		/obj/item/device/flash,
		/obj/item/clothing/glasses,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/handful,
		/obj/item/ammo_magazine/revolver,
		/obj/item/reagent_container/food/snacks/donut/normal,
		/obj/item/reagent_container/food/snacks/donut/jelly,
		/obj/item/weapon/baton,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/tool/lighter/zippo,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/clothing/glasses/hud/security,
		/obj/item/device/flashlight,
		/obj/item/device/radio/headset,
		/obj/item/weapon,
		/obj/item/device/clue_scanner,
	)

/obj/item/storage/belt/security/brown
	name = "\improper 6B80 pattern ammo rig"
	desc = "6B80是一款过时但可靠的弹药装备，曾是UPP陆军的标准装备。其模块化腰带可容纳各种弹药，因其坚固的设计仍被UPP安全部队和预备役使用。"
	icon_state = "securitybelt_brown"
	item_state = "security_brown"//Could likely use a better one.
	w_class = SIZE_LARGE
	storage_slots = 5
	max_w_class = SIZE_MEDIUM
	max_storage_space = 20
	can_hold = list(
		/obj/item/attachable/bayonet,
		/obj/item/device/flashlight/flare,
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/handful,
		/obj/item/explosive/grenade,
		/obj/item/explosive/mine,
		/obj/item/reagent_container/food/snacks,
	)
	bypass_w_limit = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg,
	)

/obj/item/storage/belt/security/brown/full/fill_preset_inventory()
	new /obj/item/ammo_magazine/rifle/ak4047(src)
	new /obj/item/ammo_magazine/rifle/ak4047(src)
	new /obj/item/ammo_magazine/rifle/ak4047(src)
	new /obj/item/ammo_magazine/rifle/ak4047(src)
	new /obj/item/ammo_magazine/rifle/ak4047(src)

/obj/item/storage/belt/security/brown/half_full/fill_preset_inventory()
	new /obj/item/ammo_magazine/rifle/ak4047(src)
	new /obj/item/ammo_magazine/rifle/ak4047(src)

/obj/item/storage/belt/security/MP
	name = "\improper M276 pattern military police rig"
	desc = "M276是USCM的标准负重装备。它由一个带有各种弹夹的模块化腰带组成。此版本装有一系列小袋，用于携带非致命性装备和约束装置。"
	storage_slots = 6
	max_w_class = SIZE_MEDIUM
	max_storage_space = 30


/obj/item/storage/belt/security/MP/full/fill_preset_inventory()
	new /obj/item/weapon/gun/energy/taser(src)
	new /obj/item/device/flash(src)
	new /obj/item/weapon/baton(src)
	new /obj/item/restraint/handcuffs(src)
	new /obj/item/reagent_container/spray/pepper(src)
	new /obj/item/device/clue_scanner(src)

/obj/item/storage/belt/security/MP/full/synth/fill_preset_inventory()
	new /obj/item/explosive/grenade/flashbang(src)
	new /obj/item/device/flash(src)
	new /obj/item/weapon/baton(src)
	new /obj/item/reagent_container/spray/pepper(src)
	new /obj/item/device/clue_scanner(src)
	new /obj/item/restraint/handcuffs(src)

/obj/item/storage/belt/security/MP/UPP
	name = "\improper Type 43 military police rig"
	desc = "43型是UPP的标准负重装备。它由一个带有各种弹夹的模块化腰带组成。此版本装有一系列小袋，用于携带非致命性装备和约束装置。"

/obj/item/storage/belt/security/MP/UPP/full/fill_preset_inventory()
	new /obj/item/weapon/gun/energy/taser(src)
	new /obj/item/device/flash(src)
	new /obj/item/weapon/baton(src)
	new /obj/item/restraint/handcuffs(src)
	new /obj/item/reagent_container/spray/pepper(src)
	new /obj/item/ammo_magazine/revolver/upp/shrapnel(src)

/obj/item/storage/belt/security/MP/CMB
	name = "\improper CMB duty belt"
	desc = "用于携带殖民地执法官工具的黑**务腰带。这是一条厚重的警用腰带，带有多个小袋，可容纳各种执法物品。"
	storage_slots = 8
	max_w_class = SIZE_MEDIUM
	max_storage_space = 30

/obj/item/storage/belt/security/MP/CMB/full/fill_preset_inventory()
	new /obj/item/weapon/gun/energy/taser(src)
	new /obj/item/device/flash(src)
	new /obj/item/weapon/baton(src)
	new /obj/item/reagent_container/spray/pepper(src)
	new /obj/item/device/clue_scanner(src)
	new /obj/item/restraint/handcuffs(src)
	new /obj/item/restraint/handcuffs(src)
	new /obj/item/explosive/grenade/flashbang(src)

/obj/item/storage/belt/security/MP/CMB/synth/fill_preset_inventory()
	new /obj/item/explosive/grenade/flashbang(src)
	new /obj/item/device/flash(src)
	new /obj/item/weapon/baton(src)
	new /obj/item/reagent_container/spray/pepper(src)
	new /obj/item/device/clue_scanner(src)
	new /obj/item/restraint/handcuffs(src)
	new /obj/item/restraint/handcuffs(src)
	new /obj/item/explosive/grenade/flashbang(src)

/obj/item/storage/belt/security/MP/WY
	name = "\improper M276-C corporate security rig"
	desc = "维兰德-汤谷对M276负重装备的改造版本，专为公司安全部队设计。这款模块化黑色装备带有多个小袋，用于携带约束装置、弹药以及维持秩序所需的致命与非致命性装备。"

/obj/item/storage/belt/security/MP/WY/full/fill_preset_inventory()
	new /obj/item/weapon/gun/energy/taser(src)
	new /obj/item/device/flash(src)
	new /obj/item/weapon/baton(src)
	new /obj/item/restraint/handcuffs(src)
	new /obj/item/reagent_container/spray/pepper(src)
	new /obj/item/device/clue_scanner(src)

/obj/item/storage/belt/security/MP/WY/full/synth/fill_preset_inventory()
	new /obj/item/explosive/grenade/flashbang(src)
	new /obj/item/device/flash(src)
	new /obj/item/weapon/baton(src)
	new /obj/item/reagent_container/spray/pepper(src)
	new /obj/item/device/clue_scanner(src)
	new /obj/item/restraint/handcuffs(src)

/obj/item/storage/belt/marine
	name = "\improper M276 pattern ammo load rig"
	desc = "M276是USCM的标准负重装备。它由一个带有各种弹夹的模块化腰带组成。这是标准型号，专为大量弹药携带行动设计。"
	icon_state = "marinebelt"
	item_state = "marinebelt"
	icon = 'icons/obj/items/clothing/belts/belts_by_map/jungle.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/jungle.dmi'
	)
	w_class = SIZE_LARGE
	storage_slots = 5
	max_w_class = SIZE_MEDIUM
	max_storage_space = 20
	can_hold = list(
		/obj/item/attachable/bayonet,
		/obj/item/device/flashlight/flare,
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/handful,
		/obj/item/explosive/grenade,
		/obj/item/explosive/mine,
		/obj/item/reagent_container/food/snacks,
	)
	bypass_w_limit = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg,
	)
	flags_atom = FPRINT // has gamemode skin

/obj/item/storage/belt/marine/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/jungle.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/jungle.dmi'
		if("classic")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/classic.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/classic.dmi'
		if("desert")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/desert.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/desert.dmi'
		if("snow")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/snow.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/snow.dmi'
		if("urban")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/urban.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/urban.dmi'

/obj/item/storage/belt/marine/m41a/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle (src)

/obj/item/storage/belt/marine/m41amk1/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/m41aMK1 (src)

/obj/item/storage/belt/marine/m39/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/smg/m39 (src)

/obj/item/storage/belt/marine/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/ammo_magazine/shotgun))
		var/obj/item/ammo_magazine/shotgun/M = W
		dump_ammo_to(M,user, M.transfer_handful_amount)
	else
		return ..()

/obj/item/storage/belt/marine/dutch
	name = "弹药负重装备"
	desc = "适合在丛林激战中携带额外弹药。由特殊的防霉烂织物制成。"

/obj/item/storage/belt/marine/dutch/m16/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/m16 (src)

/obj/item/storage/belt/marine/dutch/m16/ap/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/m16/ap (src)

/obj/item/storage/belt/marine/dutch/m60/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/m60 (src)

// Outer Rim Weapon Belts

/obj/item/storage/belt/marine/ar10/fill_preset_inventory() // AR-10
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/ar10 (src)
/obj/item/storage/belt/marine/m16/fill_preset_inventory() // M16
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/m16 (src)

/obj/item/storage/belt/marine/m16/ap/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/m16/ap (src)

/obj/item/storage/belt/marine/mar40/fill_preset_inventory() // Mar40
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/mar40 (src)

/obj/item/storage/belt/marine/mar40/drum/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/mar40/lmg (src)

/obj/item/storage/belt/marine/mar40/extended/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/mar40/extended (src)

/obj/item/storage/belt/marine/mp5/fill_preset_inventory() // MP5
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/smg/mp5 (src)
/obj/item/storage/belt/marine/uzi/fill_preset_inventory() // uzi
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/smg/uzi (src)
/obj/item/storage/belt/marine/boltaction/fill_preset_inventory() // Hunting Rifle
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/boltaction(src)

/obj/item/storage/belt/marine/fp9000/fill_preset_inventory() // FP9000
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/smg/fp9000(src)

/obj/item/storage/belt/marine/nsg23/fill_preset_inventory() // NSG23
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/nsg23(src)

/obj/item/storage/belt/marine/shotgun_ammo/fill_preset_inventory() // shotgun ammo for survs, cursed but we want non-optimal storage on purpose
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/buckshot(src)

/obj/item/storage/belt/marine/smartgunner
	name = "\improper M280 pattern smartgunner drum belt"
	desc = "尽管1. 弹鼓极其不符合人体工程学，且2. 需要极其精密的加工才能通用适配（剧透：它们做不到，这进一步加深了‘智能枪个性’的传说），USCM还是决定为M56A2系统的弹鼓弹药配发一款改进的陆战队员腰带（更正式的名称是M280），带有挂钩和防尘罩（对普通大头兵来说过于复杂）。当弹鼓的携带卡扣没有被油腻的魔术贴卡住时，这款装备确实能很好地携带大量弹鼓。但归根结底，与标准装备相比……它很烂，但这不正是当陆战队员的意义所在吗？"
	icon_state = "sgbelt_ammo"
	storage_slots = 6
	bypass_w_limit = list(
		/obj/item/ammo_magazine/smartgun,
	)
	max_w_class = SIZE_MEDIUM
	can_hold = list(
		/obj/item/attachable/bayonet,
		/obj/item/device/flashlight/flare,
		/obj/item/ammo_magazine/smartgun,
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/handful,
		/obj/item/explosive/grenade,
		/obj/item/explosive/mine,
		/obj/item/reagent_container/food/snacks,
	)

/obj/item/storage/belt/marine/smartgunner/fill_preset_inventory()
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)

/obj/item/storage/belt/marine/smartgunner/full/fill_preset_inventory()
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)

/obj/item/storage/belt/marine/sharp
	name = "\improper M103 pattern SHARP magazine belt"
	desc = "一款专门改装的M103型装备，设计用于容纳P9 SHARP步枪弹匣，而非坦克炮弹。"
	icon_state = "tankbelt"
	item_state = "tankbelt"
	icon = 'icons/obj/items/clothing/belts/belts.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_righthand.dmi',
	)
	item_state_slots = list(
		WEAR_L_HAND = "utility",
		WEAR_R_HAND = "utility")
	storage_slots = 8
	max_storage_space = 8
	can_hold = list(
		/obj/item/ammo_magazine/rifle/sharp/explosive,
		/obj/item/ammo_magazine/rifle/sharp/flechette,
		/obj/item/ammo_magazine/rifle/sharp/incendiary,
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN

/obj/item/storage/belt/marine/upp
	name = "\improper Type 41 pattern load rig"
	desc = "41型负重装备是UPP军队的标准配发负重装备。这条腰带的主要功能是在行动中为71型步枪提供便捷的弹匣取用。尽管专为71型武器系统设计，但其弹夹袋模块化程度高，足以适配其他类型的弹药和装备。"
	icon_state = "upp_belt"
	item_state = "upp_belt"
	icon = 'icons/obj/items/clothing/belts/belts_by_faction/UPP.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_faction/UPP.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_righthand.dmi'
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

//version full of type 71 mags
/obj/item/storage/belt/marine/upp/full/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/type71(src)

/obj/item/storage/belt/marine/upp/scarce/fill_preset_inventory()
	new /obj/item/ammo_magazine/rifle/type71(src)
	new /obj/item/ammo_magazine/rifle/type71(src)
	new /obj/item/ammo_magazine/rifle/type71(src)

/obj/item/storage/belt/marine/upp/sapper/fill_preset_inventory()
	new /obj/item/ammo_magazine/rifle/type71(src)
	new /obj/item/ammo_magazine/rifle/type71(src)
	new /obj/item/ammo_magazine/rifle/type71/ap(src)
	new /obj/item/ammo_magazine/rifle/type71/ap(src)
	new /obj/item/ammo_magazine/rifle/type71/ap(src)

/obj/item/storage/belt/marine/wy
	name = "\improper WY-TM402 pattern ammo load rig"
	desc = "WY-TM402是W-Y安全部队的标准负重装备。它由一个带有各种弹夹的模块化腰带组成。这是标准型号，专为大量弹药携带行动设计。"
	icon = 'icons/obj/items/clothing/belts/belts_by_faction/WY.dmi'
	icon_state = "wy_ammobelt"
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_faction/WY.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes
	item_state_slots = list(
		WEAR_WAIST = "wy_ammobelt",
		WEAR_L_HAND = "marinebelt",
		WEAR_R_HAND = "marinebelt"
	)

/obj/item/storage/belt/marine/wy/m39_pmc/fill_preset_inventory()
	new /obj/item/ammo_magazine/smg/m39/ap(src)
	new /obj/item/ammo_magazine/smg/m39/ap(src)
	new /obj/item/ammo_magazine/smg/m39/ap(src)
	new /obj/item/ammo_magazine/smg/m39/extended(src)
	new /obj/item/ammo_magazine/smg/m39/extended(src)

/obj/item/storage/belt/marine/wy/nsg23_pmc/fill_preset_inventory()
	new /obj/item/ammo_magazine/rifle/nsg23/extended(src)
	new /obj/item/ammo_magazine/rifle/nsg23/extended(src)
	new /obj/item/ammo_magazine/rifle/nsg23/ap(src)
	new /obj/item/ammo_magazine/rifle/nsg23/ap(src)
	new /obj/item/ammo_magazine/rifle/nsg23/ap(src)


// M2C HMG/M56D gunner belt
/obj/item/storage/belt/marine/m2c
	name = "\improper M804 heavygunner storage rig"
	desc = "M804重机枪手存储装备是一款M276型工具腰带装备，经过改装以携带重机枪系统弹药，并为机枪手配备工程工具。"
	icon_state = "m2c_ammo_rig"
	item_state = "m2c_ammo_rig"
	icon = 'icons/obj/items/clothing/belts/belts.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_L_HAND = "marinebelt",
		WEAR_R_HAND = "marinebelt"
	)
	storage_slots = 7
	max_w_class = SIZE_LARGE
	max_storage_space = 30
	can_hold = list(
		/obj/item/tool/weldingtool,
		/obj/item/tool/wrench,
		/obj/item/tool/screwdriver,
		/obj/item/tool/crowbar,
		/obj/item/tool/extinguisher/mini,
		/obj/item/explosive/plastic,
		/obj/item/explosive/mine,
		/obj/item/ammo_magazine/m2c,
		/obj/item/tool/wirecutters,
		/obj/item/ammo_magazine/m56d,
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

/obj/item/storage/belt/shotgun
	name = "\improper M276 pattern shotgun shell loading rig"
	desc = "一种设计用于容纳霰弹枪弹或单发子弹的弹药带。"
	icon_state = "shotgunbelt"
	item_state = "marinebelt"
	icon = 'icons/obj/items/clothing/belts/belts_by_map/jungle.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/jungle.dmi'
	)
	w_class = SIZE_LARGE
	storage_slots = 14 // Make it FLUSH with the UI. *scream
	max_w_class = SIZE_SMALL
	max_storage_space = 28
	can_hold = list(/obj/item/ammo_magazine/handful)
	flap = FALSE
	flags_atom = FPRINT // has gamemode skin

/obj/item/storage/belt/shotgun/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/jungle.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/jungle.dmi'
		if("classic")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/classic.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/classic.dmi'
		if("desert")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/desert.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/desert.dmi'
		if("snow")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/snow.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/snow.dmi'
		if("urban")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/urban.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/urban.dmi'

/obj/item/storage/belt/shotgun/full/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/slug(src)

/obj/item/storage/belt/shotgun/full/random/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		var/random_shell_type = pick(GLOB.shotgun_handfuls_12g)
		new random_shell_type(src)

/obj/item/storage/belt/shotgun/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/ammo_magazine/shotgun))
		var/obj/item/ammo_magazine/shotgun/M = W
		dump_ammo_to(M, user, M.transfer_handful_amount)
	else
		return ..()

/obj/item/storage/belt/shotgun/black
	icon = 'icons/obj/items/clothing/belts/belts_by_map/snow.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

/obj/item/storage/belt/shotgun/upp
	name = "\improper Type 42 pattern shotgun shell loading rig"
	desc = "一种设计用于容纳霰弹枪弹的弹药带，主要用于23型霰弹枪。"
	icon_state = "shotgunbelt" //placeholder
	item_state = "marinebelt"
	storage_slots = 10

/obj/item/storage/belt/shotgun/upp/heavybuck/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/heavy/buckshot(src)

/obj/item/storage/belt/shotgun/upp/heavyslug/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/heavy/slug(src)

/obj/item/storage/belt/shotgun/black/es7_mixed/fill_preset_inventory()
	for(var/i in 1 to (storage_slots/2))
		new /obj/item/ammo_magazine/handful/shotgun/slug/es7(src)
	for(var/i in 1 to (storage_slots/2))
		new /obj/item/ammo_magazine/handful/shotgun/beanbag/es7(src)

/obj/item/storage/belt/shotgun/black/es7_stun/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/beanbag/es7(src)

/obj/item/storage/belt/shotgun/black/es7_lethal/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/slug/es7(src)

/obj/item/storage/belt/shotgun/van_bandolier
	name = "双口径子弹带"
	desc = "一种设计用于容纳极重型弹药的皮革子弹带。可附着在护甲上、背在背后或挂在腰带环上。"
	icon_state = "van_bandolier_5"
	icon = 'icons/obj/items/clothing/belts/misc.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/misc.dmi',
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/misc.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/misc.dmi'
	)
	flags_equip_slot = SLOT_WAIST|SLOT_BACK
	storage_slots = null
	max_storage_space = 20
	can_hold = list(/obj/item/ammo_magazine/handful/shotgun/twobore)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes
	item_state_slots = list(
		WEAR_J_STORE = "van_bandolier_10",
		WEAR_BACK = "van_bandolier_10",
		WEAR_WAIST = "van_bandolier_10"
	)
	skip_fullness_overlays = TRUE

/obj/item/storage/belt/shotgun/van_bandolier/update_icon()
	var/mob/living/carbon/human/user = loc
	icon_state = "van_bandolier_[round(length(contents) * 0.5, 1)]"
	var/new_state = "van_bandolier_[length(contents)]"
	for(var/I in item_state_slots)
		LAZYSET(item_state_slots, I, new_state)

	if(!istype(user))
		return
	if(src == user.s_store)
		user.update_inv_s_store()
	else if(src == user.belt)
		user.update_inv_belt()
	else if(src == user.back)
		user.update_inv_back()

/obj/item/storage/belt/shotgun/van_bandolier/fill_preset_inventory()
	for(var/i in 1 to max_storage_space * 0.5)
		new /obj/item/ammo_magazine/handful/shotgun/twobore(src)


/obj/item/storage/belt/shotgun/lever_action
	name = "\improper M276 pattern 45-70 loading rig"
	desc = "一种弹药带，设计用于容纳R4T杠杆式步枪使用的大型.45-70 Govt.口径子弹。"
	icon_state = "r4t-ammobelt"
	item_state = "marinebelt"
	w_class = SIZE_LARGE
	storage_slots = 14
	max_w_class = SIZE_SMALL
	max_storage_space = 28
	can_hold = list(/obj/item/ammo_magazine/handful)

/obj/item/storage/belt/shotgun/lever_action/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/ammo_magazine/lever_action))
		var/obj/item/ammo_magazine/lever_action/M = W
		dump_ammo_to(M, user, M.transfer_handful_amount)

	if(istype(W, /obj/item/storage/belt/gun/m44/lever_action/attach_holster))
		if(length(contents) || length(W.contents))
			to_chat(user, SPAN_WARNING("枪套和腰带都必须是空的才能安装枪套！"))
			return
		to_chat(user, SPAN_NOTICE("你将枪套安装在腰带上，减少了总存储容量，但使其能容纳M44左轮手枪及其快速装弹器。"))
		var/obj/item/storage/belt/gun/m44/lever_action/new_belt = new /obj/item/storage/belt/gun/m44/lever_action
		qdel(W)
		qdel(src)
		user.put_in_hands(new_belt)
		update_icon(user)
	else
		return ..()

/obj/item/storage/belt/shotgun/xm88
	name = "\improper M300 pattern .458 SOCOM loading rig"
	desc = "一种弹药带，设计用于容纳XM88重型步枪使用的大型.458 SOCOM口径子弹。"
	icon_state = "boomslang-belt"
	item_state = "marinebelt"
	w_class = SIZE_LARGE
	storage_slots = 14
	max_w_class = SIZE_SMALL
	max_storage_space = 28
	can_hold = list(/obj/item/ammo_magazine/handful)

/obj/item/storage/belt/shotgun/xm88/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/ammo_magazine/lever_action/xm88))
		var/obj/item/ammo_magazine/lever_action/xm88/B = W
		dump_ammo_to(B, user, B.transfer_handful_amount)
	else
		return ..()

/obj/item/storage/belt/knifepouch
	name="\improper M276 pattern knife rig"
	desc="M276是USCM的标准负重装备。它由一个带有各种夹扣的模块化腰带组成。此版本专为存放刀具设计。不常配发，但仍在服役。"
	icon_state = "knifebelt"
	item_state = "marinebelt" // aslo temp, maybe somebody update these icons with better ones?
	icon = 'icons/obj/items/clothing/belts/belts_by_map/jungle.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/jungle.dmi'
	)
	w_class = SIZE_LARGE
	storage_slots = 12
	storage_flags = STORAGE_FLAGS_DEFAULT|STORAGE_USING_DRAWING_METHOD|STORAGE_ALLOW_QUICKDRAW
	flags_atom = FPRINT // has gamemode skin
	max_w_class = SIZE_SMALL
	max_storage_space = 48
	can_hold = list(
		/obj/item/weapon/throwing_knife,
		/obj/item/attachable/bayonet,
	)
	cant_hold = list()
	flap = FALSE

	COOLDOWN_DECLARE(draw_cooldown)

/obj/item/storage/belt/knifepouch/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/jungle.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/jungle.dmi'
		if("classic")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/classic.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/classic.dmi'
		if("desert")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/desert.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/desert.dmi'
		if("snow")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/snow.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/snow.dmi'
		if("urban")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/urban.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/urban.dmi'

/obj/item/storage/belt/knifepouch/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/weapon/throwing_knife(src)

/obj/item/storage/belt/knifepouch/_item_insertion(obj/item/new_item, prevent_warning = FALSE)
	..()
	playsound(src, 'sound/weapons/gun_shotgun_shell_insert.ogg', 15, TRUE)

/obj/item/storage/belt/knifepouch/_item_removal(obj/item/W, atom/new_location)
	..()
	playsound(src, 'sound/weapons/gun_shotgun_shell_insert.ogg', 15, TRUE)

/obj/item/storage/belt/knifepouch/attack_hand(mob/user, mods)
	if(COOLDOWN_FINISHED(src, draw_cooldown))
		..()
		COOLDOWN_START(src, draw_cooldown, BAYONET_DRAW_DELAY)
		playsound(src, 'sound/weapons/gun_shotgun_shell_insert.ogg', 15, TRUE)
	else
		to_chat(user, SPAN_WARNING("你需要等待片刻才能拔出另一把刀！"))
		return FALSE

/obj/item/storage/belt/grenade
	name= "\improper M276 pattern M40 Grenade rig"
	desc= "M276是USCM的标准负重装备。它由一个带有各种夹扣的模块化腰带组成。此版本设计用于携带大量M40型和AGM型手榴弹。"
	icon_state = "grenadebelt"
	item_state = "grenadebelt"
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_L_HAND = "marinebelt",
		WEAR_R_HAND = "marinebelt"
	)
	w_class = SIZE_LARGE
	storage_slots = 12
	max_w_class = SIZE_MEDIUM
	max_storage_space = 24
	can_hold = list(/obj/item/explosive/grenade)


/obj/item/storage/belt/grenade/full/fill_preset_inventory()
	new /obj/item/explosive/grenade/incendiary(src)
	new /obj/item/explosive/grenade/incendiary(src)
	new /obj/item/explosive/grenade/incendiary/airburst(src)
	new /obj/item/explosive/grenade/high_explosive(src)
	new /obj/item/explosive/grenade/high_explosive(src)
	new /obj/item/explosive/grenade/high_explosive(src)
	new /obj/item/explosive/grenade/high_explosive/airburst(src)
	new /obj/item/explosive/grenade/high_explosive/airburst(src)

/obj/item/storage/belt/grenade/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/storage/box/nade_box) || istype(W, /obj/item/storage/backpack/marine/grenadepack))
		dump_into(W,user)
	else
		return ..()

/obj/item/storage/belt/grenade/large
	name="\improper M276 pattern M40 Grenade rig Mk. II"
	desc="M276 Mk. II是M276手榴弹携行具的升级版，拥有更大的存储容量。"
	storage_slots = 18
	max_storage_space = 54

/obj/item/storage/belt/grenade/large/full/fill_preset_inventory()
	new /obj/item/explosive/grenade/incendiary(src)
	new /obj/item/explosive/grenade/incendiary(src)
	new /obj/item/explosive/grenade/incendiary(src)
	new /obj/item/explosive/grenade/incendiary/airburst(src)
	new /obj/item/explosive/grenade/incendiary/airburst(src)
	new /obj/item/explosive/grenade/incendiary/airburst(src)
	new /obj/item/explosive/grenade/high_explosive(src)
	new /obj/item/explosive/grenade/high_explosive(src)
	new /obj/item/explosive/grenade/high_explosive(src)
	new /obj/item/explosive/grenade/high_explosive(src)
	new /obj/item/explosive/grenade/high_explosive(src)
	new /obj/item/explosive/grenade/high_explosive(src)
	new /obj/item/explosive/grenade/high_explosive/airburst(src)
	new /obj/item/explosive/grenade/high_explosive/airburst(src)
	new /obj/item/explosive/grenade/high_explosive/airburst(src)
	new /obj/item/explosive/grenade/high_explosive/airburst(src)
	new /obj/item/explosive/grenade/high_explosive/airburst(src)
	new /obj/item/explosive/grenade/high_explosive/airburst(src)

/obj/item/storage/belt/grenade/large/dutch
	name = "\improper Dutch's Grenadier Rigging"
	desc = "一个高容量携行具，装满了你能想到的所有爆炸物，还有什么可求的？"

/obj/item/storage/belt/grenade/large/dutch/full/fill_preset_inventory()
	for(var/i in 1 to 6)
		new /obj/item/explosive/grenade/incendiary/impact(src)
		new /obj/item/explosive/grenade/high_explosive/impact(src)
		new /obj/item/explosive/grenade/high_explosive/airburst/buckshot(src)

/obj/item/storage/belt/grenade/upp
	name="\improper Type 46 pattern Type 6/8 Grenade rig"
	desc="46型是UPP的标准负重装备。它由一个带有各种夹扣的模块化腰带组成。此版本设计用于携带大量6型和8型手榴弹。"
	icon_state = "grenadebelt" // temp
	item_state = "grenadebelt"
	item_state_slots = list(
		WEAR_L_HAND = "s_marinebelt",
		WEAR_R_HAND = "s_marinebelt")
	w_class = SIZE_LARGE
	storage_slots = 12
	max_w_class = SIZE_MEDIUM
	max_storage_space = 24
	can_hold = list(/obj/item/explosive/grenade)

/obj/item/storage/belt/grenade/upp/full/fill_preset_inventory()
	new /obj/item/explosive/grenade/phosphorus/upp(src)
	new /obj/item/explosive/grenade/phosphorus/upp(src)
	new /obj/item/explosive/grenade/phosphorus/upp(src)
	new /obj/item/explosive/grenade/high_explosive/upp(src)
	new /obj/item/explosive/grenade/high_explosive/upp(src)
	new /obj/item/explosive/grenade/high_explosive/upp(src)
	new /obj/item/explosive/grenade/high_explosive/upp(src)
	new /obj/item/explosive/grenade/high_explosive/upp(src)

/obj/item/storage/belt/grenade/upp/attackby(obj/item/attacked_item, mob/user)
	if(istype(attacked_item, /obj/item/storage/box/nade_box) || istype(attacked_item, /obj/item/storage/backpack/marine/grenadepack))
		dump_into(attacked_item, user)
	else
		return ..()

////////////////////////////// GUN BELTS /////////////////////////////////////

/obj/item/storage/belt/gun
	name = "手枪腰带"
	desc = "一个腰带-枪套组合，可容纳一把手枪和两个弹匣。"
	icon_state = "m4a3_holster"
	item_state = "marinebelt" //see post_skin_selection() - this is used for inhand states, the belt sprites use the same filename as the icon state.
	icon = 'icons/obj/items/clothing/belts/belts_by_map/jungle.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/jungle.dmi'
	)
	use_sound = null
	w_class = SIZE_LARGE
	storage_slots = 5
	max_storage_space = 11
	max_w_class = SIZE_MEDIUM
	storage_flags = STORAGE_FLAGS_POUCH|STORAGE_ALLOW_QUICKDRAW
	///Array of holster slots and stats to use for them. First layer is "1", "2" etc. Guns are stored in both the slot and the holstered_guns list which keeps track of which was last inserted.
	var/list/list/obj/item/weapon/gun/holster_slots = list(
		"1" = list(
			"gun" = null,
			"underlay_sprite" = null,
			"underlay_transform" = null,
			"icon_x" = 0,
			"icon_y" = 0))

	var/list/holstered_guns = list()

	var/sheatheSound = 'sound/weapons/gun_pistol_sheathe.ogg'
	var/drawSound = 'sound/weapons/gun_pistol_draw.ogg'
	///Used to get flap overlay states as inserting a gun changes icon state.
	var/base_icon
	var/gun_has_gamemode_skin
	can_hold = list(
		/obj/item/weapon/gun/pistol,
		/obj/item/ammo_magazine/pistol,
	)
	cant_hold = list(
		/obj/item/weapon/gun/pistol/kt42, // HONKed currently
		/obj/item/weapon/gun/pistol/auto9, // HONKed currently
		/obj/item/weapon/gun/pistol/chimp, // HONKed currently
		/obj/item/weapon/gun/pistol/skorpion, // HONKed currently
	)

/obj/item/storage/belt/gun/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/jungle.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/jungle.dmi'
			item_icons[WEAR_J_STORE] = 'icons/mob/humans/onmob/clothing/suit_storage/suit_storage_by_map/jungle.dmi'
		if("classic")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/classic.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/classic.dmi'
			item_icons[WEAR_J_STORE] = 'icons/mob/humans/onmob/clothing/suit_storage/suit_storage_by_map/classic.dmi'
		if("desert")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/desert.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/desert.dmi'
			item_icons[WEAR_J_STORE] = 'icons/mob/humans/onmob/clothing/suit_storage/suit_storage_by_map/desert.dmi'
		if("snow")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/snow.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/snow.dmi'
			item_icons[WEAR_J_STORE] = 'icons/mob/humans/onmob/clothing/suit_storage/suit_storage_by_map/snow.dmi'
		if("urban")
			icon = 'icons/obj/items/clothing/belts/belts_by_map/urban.dmi'
			item_icons[WEAR_WAIST] = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/urban.dmi'
			item_icons[WEAR_J_STORE] = 'icons/mob/humans/onmob/clothing/suit_storage/suit_storage_by_map/urban.dmi'

/obj/item/storage/belt/gun/post_skin_selection()
	base_icon = icon_state
	//Saving current inhands, since we'll be switching item_state around for belt onmobs.
	LAZYSET(item_state_slots, WEAR_L_HAND, item_state)
	LAZYSET(item_state_slots, WEAR_R_HAND, item_state)
	//And switch to correct belt state in case we aren't spawning with a gun inserted.
	item_state = icon_state

/obj/item/storage/belt/gun/update_icon()
	overlays.Cut()

	if(skip_fullness_overlays)
		return
	if(content_watchers && flap)
		return
	var/magazines = length(contents) - length(holstered_guns)
	if(!magazines)
		return

	if(magazines <= (storage_slots - length(holster_slots)) * 0.5) //Don't count slots reserved for guns, even if they're empty.
		overlays += "+[base_icon]_half"
	else
		overlays += "+[base_icon]_full"

/obj/item/storage/belt/gun/on_stored_atom_del(atom/movable/AM)
	if(!isgun(AM))
		return
	holstered_guns -= AM
	for(var/slot in holster_slots)
		if(AM == holster_slots[slot]["gun"])
			holster_slots[slot]["gun"] = null

			update_gun_icon(slot)
			return

/obj/item/storage/belt/gun/attack_hand(mob/user, mods)
	if(length(holstered_guns) && ishuman(user) && loc == user)
		var/obj/item/I
		if(mods && mods[ALT_CLICK] && length(contents) > length(holstered_guns) && !HAS_TRAIT(user, TRAIT_HAULED)) //Withdraw the most recently inserted magazine, if possible.
			var/list/magazines = contents - holstered_guns
			I = magazines[length(magazines)]
		else //Otherwise find and draw the last-inserted gun.
			I = holstered_guns[length(holstered_guns)]
		I.attack_hand(user)
		return

	..()

/obj/item/storage/belt/gun/proc/update_gun_icon(slot) //We do not want to use regular update_icon as it's called for every item inserted. Not worth the icon math.
	var/mob/living/carbon/human/user = loc
	var/obj/item/weapon/gun/current_gun = holster_slots[slot]["gun"]
	if(current_gun)
		/*
		Have to use a workaround here, otherwise images won't display properly at all times.
		Reason being, transform is not displayed when right clicking/alt+clicking an object,
		so it's necessary to pre-load the potential states so the item actually shows up
		correctly without having to rotate anything. Preloading weapon icons also makes
		sure that we don't have to do any extra calculations.
		*/
		playsound(src, drawSound, 7, TRUE)
		var/image/gun_underlay = image('icons/obj/items/clothing/belts/holstered_guns.dmi', current_gun.base_gun_icon)
		if(gun_has_gamemode_skin && current_gun.map_specific_decoration)
			switch(SSmapping.configs[GROUND_MAP].camouflage_type)
				if("snow")
					gun_underlay = image('icons/obj/items/clothing/belts/holstered_guns.dmi', "s_" + current_gun.base_gun_icon)
				if("desert")
					gun_underlay = image('icons/obj/items/clothing/belts/holstered_guns.dmi', "d_" + current_gun.base_gun_icon)
				if("classic")
					gun_underlay = image('icons/obj/items/clothing/belts/holstered_guns.dmi', "c_" + current_gun.base_gun_icon)
				if("urban")
					gun_underlay = image('icons/obj/items/clothing/belts/holstered_guns.dmi', "u_" + current_gun.base_gun_icon)
		gun_underlay.pixel_x = holster_slots[slot]["icon_x"]
		gun_underlay.pixel_y = holster_slots[slot]["icon_y"]
		gun_underlay.color = current_gun.color
		gun_underlay.transform = holster_slots[slot]["underlay_transform"]
		holster_slots[slot]["underlay_sprite"] = gun_underlay
		underlays += gun_underlay

		icon_state += "_g"
		item_state = icon_state
	else
		playsound(src, sheatheSound, 7, TRUE)
		underlays -= holster_slots[slot]["underlay_sprite"]
		holster_slots[slot]["underlay_sprite"] = null

		icon_state = copytext(icon_state,1,-2)
		item_state = icon_state

	if(istype(user))
		if(src == user.belt)
			user.update_inv_belt()
		else if(src == user.s_store)
			user.update_inv_s_store()
		else if(src == user.back)
			user.update_inv_back()

//There are only two types here that can be inserted, and they are mutually exclusive. We only track the gun.
/obj/item/storage/belt/gun/can_be_inserted(obj/item/W, mob/user, stop_messages = FALSE) //We don't need to stop messages, but it can be left in.
	. = ..()
	if(!.)
		return

	if(isgun(W))
		for(var/slot in holster_slots)
			if(!holster_slots[slot]["gun"]) //Open holster.
				return

		if(!stop_messages) //No open holsters.
			if(length(holster_slots) == 1)
				to_chat(usr, SPAN_WARNING("[src]已经持有一把枪。"))
			else
				to_chat(usr, SPAN_WARNING("[src]没有任何空枪套。"))
		return FALSE

	else if(length(contents) - length(holstered_guns) >= storage_slots - length(holster_slots)) //Compare amount of nongun items in storage with usable ammo pockets.
		if(!stop_messages)
			to_chat(usr, SPAN_WARNING("[src]无法容纳更多弹药。"))
		return FALSE

/obj/item/storage/belt/gun/_item_insertion(obj/item/W, prevent_warning = FALSE)
	if(isgun(W))
		holstered_guns += W
		for(var/slot in holster_slots)
			if(holster_slots[slot]["gun"])
				continue
			holster_slots[slot]["gun"] = W
			update_gun_icon(slot)
			break
	..()

/obj/item/storage/belt/gun/_item_removal(obj/item/W, atom/new_location)
	if(isgun(W))
		holstered_guns -= W
		for(var/slot in holster_slots)
			if(holster_slots[slot]["gun"] != W)
				continue
			holster_slots[slot]["gun"] = null
			update_gun_icon(slot)
			break
	..()

/obj/item/storage/belt/gun/dump_ammo_to(obj/item/ammo_magazine/ammo_dumping, mob/user, amount_to_dump)
	if(user.action_busy)
		return

	if(ammo_dumping.flags_magazine & AMMUNITION_CANNOT_REMOVE_BULLETS)
		to_chat(user, SPAN_WARNING("你无法从\the [ammo_dumping]中取出弹药！"))
		return

	if(ammo_dumping.flags_magazine & AMMUNITION_HANDFUL_BOX)
		var/handfuls = round(ammo_dumping.current_rounds / amount_to_dump, 1) //The number of handfuls, we round up because we still want the last one that isn't full
		if(ammo_dumping.current_rounds != 0)
			if(length(contents) < storage_slots - 1) //this is because it's a gunbelt and the final slot is reserved for the gun
				to_chat(user, SPAN_NOTICE("你开始用[ammo_dumping]重新装填[src]。"))
				if(!do_after(user, 1.5 SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC))
					return
				for(var/i = 1 to handfuls)
					if(length(contents) < storage_slots - 1)
						var/obj/item/ammo_magazine/handful/new_handful = new /obj/item/ammo_magazine/handful
						var/transferred_handfuls = min(ammo_dumping.current_rounds, amount_to_dump)
						new_handful.generate_handful(ammo_dumping.default_ammo, ammo_dumping.caliber, amount_to_dump, transferred_handfuls, ammo_dumping.gun_type)
						ammo_dumping.current_rounds -= transferred_handfuls
						handle_item_insertion(new_handful, TRUE,user)
						update_icon(-transferred_handfuls)
					else
						break
				playsound(user.loc, "rustle", 15, TRUE, 6)
				ammo_dumping.update_icon()
			else
				to_chat(user, SPAN_WARNING("[src]已满。"))

/obj/item/storage/belt/gun/m4a3
	name = "\improper M276 pattern general pistol holster rig"
	desc = "M276是USCM的标准负重装备。它由一个带有各种夹扣的模块化腰带组成。此版本带有一个枪套组件，可携带最常见的手枪。它还包含侧袋，可存放大多数手枪弹匣。"
	storage_slots = 7
	can_hold = list(
		/obj/item/weapon/gun/pistol,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/pistol/heavy,
		/obj/item/ammo_magazine/pistol/heavy/super,
		/obj/item/ammo_magazine/pistol/heavy/super/highimpact,
	)
	cant_hold = list(
		/obj/item/weapon/gun/pistol/smart,
		/obj/item/ammo_magazine/pistol/smart,
		/obj/item/weapon/gun/pistol/kt42, // HONKed currently
		/obj/item/weapon/gun/pistol/auto9, // HONKed currently
		/obj/item/weapon/gun/pistol/chimp, // HONKed currently
		/obj/item/weapon/gun/pistol/skorpion, // HONKed currently
	)
	flags_atom = FPRINT // has gamemode skin

/obj/item/storage/belt/gun/m4a3/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/m4a3())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol(src)

/obj/item/storage/belt/gun/m4a3/commander/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/m4a3/custom())
	new /obj/item/ammo_magazine/pistol/ap(src)
	new /obj/item/ammo_magazine/pistol/ap(src)
	new /obj/item/ammo_magazine/pistol/hp(src)
	new /obj/item/ammo_magazine/pistol/hp(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)

/obj/item/storage/belt/gun/m4a3/mod88/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/mod88())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/mod88(src)

/obj/item/storage/belt/gun/m4a3/mod88_near_empty/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/mod88())
	for(var/i = 1 to 3)
		new /obj/item/ammo_magazine/pistol/mod88(src)

/obj/item/storage/belt/gun/m4a3/vp78/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/vp78())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/vp78(src)

/obj/item/storage/belt/gun/m4a3/wy
	name = "\improper WY-TM892 pattern general pistol holster rig"
	desc = "WY-TM892是W-Y安全部队的标准负重装备。它由一个带有各种夹扣的模块化腰带组成。此版本带有一个枪套组件，可携带最常见的手枪。它还包含侧袋，可存放大多数手枪弹匣。"
	icon = 'icons/obj/items/clothing/belts/belts_by_faction/WY.dmi'
	icon_state = "wy_holster"
	item_state = "marinebelt"
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_faction/WY.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes
	holster_slots = list(
		"1" = list(
			"icon_x" = -3,
			"icon_y" = 0))

/obj/item/storage/belt/gun/m4a3/wy/mod88/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/mod88())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/mod88(src)

/obj/item/storage/belt/gun/m4a3/wy/mod88_near_empty/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/mod88())
	for(var/i = 1 to 3)
		new /obj/item/ammo_magazine/pistol/mod88(src)

/obj/item/storage/belt/gun/m4a3/wy/es4/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/es4())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/es4(src)

/obj/item/storage/belt/gun/m4a3/wy/vp78/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/vp78())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/vp78(src)

/obj/item/storage/belt/gun/m4a3/wy/vp78_near_empty/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/vp78())
	for(var/i = 1 to 3)
		new /obj/item/ammo_magazine/pistol/vp78(src)

/obj/item/storage/belt/gun/m4a3/wy/vp78_whiteout/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/vp78/whiteout())
	new /obj/item/ammo_magazine/pistol/vp78/incendiary(src)
	new /obj/item/ammo_magazine/pistol/vp78/incendiary(src)
	new /obj/item/ammo_magazine/pistol/vp78/rubber(src)
	new /obj/item/ammo_magazine/pistol/vp78/rubber(src)
	new /obj/item/ammo_magazine/pistol/vp78/rubber(src)
	new /obj/item/ammo_magazine/pistol/vp78/rubber(src)

/obj/item/storage/belt/gun/m4a3/m1911/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/m1911())
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)

/obj/item/storage/belt/gun/m4a3/m1911/socom/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/m1911/socom/equipped())
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/pistol/m1911(src)

/obj/item/storage/belt/gun/m4a3/m1911/commander/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/m1911/custom())
	new /obj/item/ammo_magazine/pistol/m1911/highimpact(src)
	new /obj/item/ammo_magazine/pistol/m1911/highimpact(src)
	new /obj/item/ammo_magazine/pistol/m1911/highimpact(src)
	new /obj/item/ammo_magazine/pistol/m1911/highimpact(src)
	new /obj/item/ammo_magazine/pistol/m1911/highimpact/ap(src)
	new /obj/item/ammo_magazine/pistol/m1911/highimpact/ap(src)

/obj/item/storage/belt/gun/m4a3/m1911/socom/black
	icon = 'icons/obj/items/clothing/belts/belts_by_map/snow.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

/obj/item/storage/belt/gun/m4a3/heavy/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/heavy())
	new /obj/item/ammo_magazine/pistol/heavy(src)
	new /obj/item/ammo_magazine/pistol/heavy(src)
	new /obj/item/ammo_magazine/pistol/heavy(src)
	new /obj/item/ammo_magazine/pistol/heavy(src)
	new /obj/item/ammo_magazine/pistol/heavy(src)
	new /obj/item/ammo_magazine/pistol/heavy(src)

/obj/item/storage/belt/gun/m4a3/heavy/co/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/heavy/co())
	new /obj/item/ammo_magazine/pistol/heavy/super/highimpact(src)
	new /obj/item/ammo_magazine/pistol/heavy/super/highimpact(src)
	new /obj/item/ammo_magazine/pistol/heavy/super/highimpact(src)
	new /obj/item/ammo_magazine/pistol/heavy/super/highimpact(src)
	new /obj/item/ammo_magazine/pistol/heavy/super/highimpact/ap(src)
	new /obj/item/ammo_magazine/pistol/heavy/super/highimpact/ap(src)

/obj/item/storage/belt/gun/m4a3/heavy/co_golden
	icon = 'icons/obj/items/clothing/belts/belts_by_map/snow.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

/obj/item/storage/belt/gun/m4a3/heavy/co_golden/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/heavy/co/gold())
	new /obj/item/ammo_magazine/pistol/heavy/super/highimpact(src)
	new /obj/item/ammo_magazine/pistol/heavy/super/highimpact(src)
	new /obj/item/ammo_magazine/pistol/heavy/super/highimpact(src)
	new /obj/item/ammo_magazine/pistol/heavy/super/highimpact(src)
	new /obj/item/ammo_magazine/pistol/heavy/super/highimpact/ap(src)
	new /obj/item/ammo_magazine/pistol/heavy/super/highimpact/ap(src)

/obj/item/storage/belt/gun/m4a3/highpower/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/highpower())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/highpower(src)

/obj/item/storage/belt/gun/m4a3/highpower/black/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/highpower/black())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/highpower/black(src)

/obj/item/storage/belt/gun/m4a3/highpower/tactical/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/highpower/tactical())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/highpower/black(src)

/obj/item/storage/belt/gun/m4a3/black
	icon = 'icons/obj/items/clothing/belts/belts_by_map/snow.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

/obj/item/storage/belt/gun/m4a3/nailgun
	name = "定制射钉枪枪套"
	desc = "由M276手枪枪套和工程工具带组合而成，改装成一条独特的腰带，可容纳一把紧凑型射钉枪和两个备用射钉枪弹匣。"
	icon_state = "nailgun_holster"
	icon = 'icons/obj/items/clothing/belts/belts.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_WAIST = "combatutility",
		WEAR_L_HAND = "utility",
		WEAR_R_HAND = "utility"
	)
	storage_slots = 3
	can_hold = list(
		/obj/item/weapon/gun/smg/nailgun/compact,
		/obj/item/ammo_magazine/smg/nailgun,
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

/obj/item/storage/belt/gun/m4a3/nailgun/prefilled/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/smg/nailgun/compact())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/smg/nailgun(src)

/obj/item/storage/belt/gun/m39
	name = "\improper M276 pattern M39 holster rig"
	desc = "M276的特供变体，设计用于容纳一把M39冲锋枪和两个备用弹匣。不常配发给USCM的支援和专家人员。"
	icon_state = "m39_armor"
	item_state = "marinebelt"
	icon = 'icons/obj/items/clothing/belts/belts.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	storage_slots = 3
	max_w_class = 5
	gun_has_gamemode_skin = TRUE
	can_hold = list(
		/obj/item/weapon/gun/smg/m39,
		/obj/item/ammo_magazine/smg,
	)
	holster_slots = list(
		"1" = list(
			"icon_x" = -11,
			"icon_y" = -5))

/obj/item/storage/belt/gun/m39/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/smg/m39(src))
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/smg/m39(src)

/obj/item/storage/belt/gun/m39/full/extended/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/smg/m39(src))
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/smg/m39/extended(src)

/obj/item/storage/belt/gun/m39/corporate/no_lock/full/extended/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/smg/m39/corporate/no_lock(src))
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/smg/m39/extended(src)

/obj/item/storage/belt/gun/m39/full/whiteout/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/smg/m39/elite/compact/heap(src))
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/smg/m39/heap(src)

/obj/item/storage/belt/gun/m39/full/whiteout_low_threat/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/smg/m39/elite/compact(src))
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/smg/m39/ap(src)

#define MAXIMUM_MAGAZINE_COUNT 2

/obj/item/storage/belt/gun/m10
	name = "\improper M276 pattern M10 holster rig"
	desc = "M276的特供变体——专为安全容纳一把M10自动手枪和七个备用弹匣而设计，便于在近距离情况下快速取用。此腰带非常适合防御登船威胁，支持快速部署高射速副武器，同时在零重力环境中保持稳定。"
	icon_state = "m10_armor"
	flags_atom = FPRINT // has gamemode skin
	storage_slots = 8
	max_w_class = 5
	gun_has_gamemode_skin = TRUE
	can_hold = list(
		/obj/item/weapon/gun/pistol/m10,
		/obj/item/ammo_magazine/pistol,
	)
	holster_slots = list(
		"1" = list(
			"icon_x" = -11,
			"icon_y" = -4))

/obj/item/storage/belt/gun/m10/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/m10(src))
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/m10(src)

/obj/item/storage/belt/gun/m10/full/extended/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/m10(src))
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/m10/extended(src)

/obj/item/storage/belt/gun/m10/full/drum/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/m10(src))
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/m10/drum(src)


/obj/item/storage/belt/gun/xm51
	name = "\improper M276 pattern XM51 holster rig"
	desc = "M276是USCM的标准负重装备。它由一个带有各种夹扣的模块化腰带组成。此版本适用于XM51破门霰弹枪，便于存放该武器。它配有可存放两个弹匣以及额外霰弹的袋子。"
	icon_state = "xm51_holster"
	flags_atom = FPRINT // has gamemode skin
	gun_has_gamemode_skin = TRUE
	storage_slots = 8
	max_w_class = 5
	can_hold = list(
		/obj/item/weapon/gun/rifle/xm51,
		/obj/item/ammo_magazine/rifle/xm51,
		/obj/item/ammo_magazine/handful,
	)
	holster_slots = list(
		"1" = list(
			"icon_x" = 10,
			"icon_y" = -1))

	//Keep a track of how many magazines are inside the belt.
	var/magazines = 0

/obj/item/storage/belt/gun/xm51/attackby(obj/item/item, mob/user)
	if(istype(item, /obj/item/ammo_magazine/shotgun/light/breaching))
		var/obj/item/ammo_magazine/shotgun/light/breaching/ammo_box = item
		dump_ammo_to(ammo_box, user, ammo_box.transfer_handful_amount)
	else
		return ..()

/obj/item/storage/belt/gun/xm51/can_be_inserted(obj/item/item, mob/user, stop_messages = FALSE)
	. = ..()
	if(magazines >= MAXIMUM_MAGAZINE_COUNT && istype(item, /obj/item/ammo_magazine/rifle/xm51))
		if(!stop_messages)
			to_chat(usr, SPAN_WARNING("[src]无法容纳更多弹匣了。"))
		return FALSE

/obj/item/storage/belt/gun/xm51/handle_item_insertion(obj/item/item, prevent_warning = FALSE, mob/user)
	. = ..()
	if(istype(item, /obj/item/ammo_magazine/rifle/xm51))
		magazines++

/obj/item/storage/belt/gun/xm51/remove_from_storage(obj/item/item as obj, atom/new_location)
	. = ..()
	if(istype(item, /obj/item/ammo_magazine/rifle/xm51))
		magazines--

//If a magazine disintegrates due to acid or something else while in the belt, remove it from the count.
/obj/item/storage/belt/gun/xm51/on_stored_atom_del(atom/movable/item)
	if(istype(item, /obj/item/ammo_magazine/rifle/xm51))
		magazines--

/obj/item/storage/belt/gun/xm51/black
	icon = 'icons/obj/items/clothing/belts/belts_by_map/snow.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

/obj/item/storage/belt/gun/xm51/black/cmb
	name = "\improper M276 pattern Model 1771 holster rig"
	desc = "M276是殖民地治安官办公室的标准负重装备。它由一个带有各种夹扣的模块化腰带组成。此版本适用于1771型破门霰弹枪，便于存放该武器。它配有可存放两个弹匣以及额外霰弹的袋子。"
	gun_has_gamemode_skin = FALSE


#undef MAXIMUM_MAGAZINE_COUNT

/obj/item/storage/belt/gun/m44
	name = "\improper M276 pattern general revoler holster rig"
	desc = "M276是USCM的标准负重装备。它由一个带有各种卡扣的模块化腰带组成。此版本为通用型，可适配不同左轮手枪，并配有六个用于快速装弹器的小袋。它散发着淡淡的干草味。"
	icon_state = "m44r_holster"
	storage_slots = 7
	can_hold = list(
		/obj/item/weapon/gun/revolver,
		/obj/item/ammo_magazine/revolver,
	)
	flags_atom = FPRINT // has gamemode skin
	holster_slots = list(
		"1" = list(
			"icon_x" = -1,
			"icon_y" = -3))

/obj/item/storage/belt/gun/m44/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/m44())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/revolver/marksman(src)

/obj/item/storage/belt/gun/m44/custom/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/m44/custom())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/revolver/marksman(src)

/obj/item/storage/belt/gun/m44/mp/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/m44/mp())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/revolver/marksman(src)

/obj/item/storage/belt/gun/m44/m2049/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/m44/custom/pkd_special/k2049())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/revolver/pkd(src)

/obj/item/storage/belt/gun/m44/m2049/nogun/fill_preset_inventory()
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/revolver/pkd(src)

/obj/item/storage/belt/gun/m44/gunslinger
	name = "定制枪手腰带"
	desc = "某个地方<i>总是</i>正午时分。"
	icon_state = "gunslinger_holster"
	icon = 'icons/obj/items/clothing/belts/belts.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	storage_slots = 6
	can_hold = list(
		/obj/item/weapon/gun/revolver,
		/obj/item/ammo_magazine/revolver,
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes
	holster_slots = list(
		"1" = list("icon_x" = -9, "icon_y" = -3),
		"2" = list("icon_x" = 9, "icon_y" = -3))
	skip_fullness_overlays = TRUE

/obj/item/storage/belt/gun/m44/gunslinger/Initialize()
	var/matrix/M = matrix()
	M.Scale(-1, 1) //Flip the sprite of the second gun.
	holster_slots["2"]["underlay_transform"] = M
	. = ..()

/obj/item/storage/belt/gun/m44/gunslinger/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/m44())
	handle_item_insertion(new /obj/item/weapon/gun/revolver/m44())
	for(var/i = 1 to storage_slots - 2)
		new /obj/item/ammo_magazine/revolver/marksman(src)

/obj/item/storage/belt/gun/m44/lever_action
	name = "\improper M276 pattern 45-70 revolver rig"
	desc = "一种为R4T杠杆式步枪容纳大型.45-70 Govt.口径子弹设计的弹药腰带。此版本牺牲了部分容量，换来了一个完整的左轮手枪枪套。"
	icon_state = "r4t-cowboybelt"
	item_state = "r4t-cowboybelt"
	w_class = SIZE_LARGE
	storage_slots = 11
	max_storage_space = 28
	can_hold = list(
		/obj/item/ammo_magazine/handful,
		/obj/item/weapon/gun/revolver,
		/obj/item/ammo_magazine/revolver,
	)
	flap = FALSE
	holster_slots = list(
		"1" = list(
			"icon_x" = 10,
			"icon_y" = 3))

/obj/item/storage/belt/gun/m44/lever_action/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/ammo_magazine/lever_action))
		var/obj/item/ammo_magazine/lever_action/M = W
		dump_ammo_to(M,user, M.transfer_handful_amount)
	else
		return ..()


/obj/item/storage/belt/gun/m44/lever_action/verb/detach_holster()
	set category = "Object"
	set name = "Detach revolver holster"
	set src in usr
	if(ishuman(usr))
		if(length(contents))
			to_chat(usr, SPAN_WARNING("腰带必须完全清空才能取下枪套！"))
			return
		to_chat(usr, SPAN_NOTICE("你将枪套从腰带上卸下。"))
		var/obj/item/storage/belt/shotgun/lever_action/new_belt = new /obj/item/storage/belt/shotgun/lever_action
		var/obj/item/storage/belt/gun/m44/lever_action/attach_holster/new_holster = new /obj/item/storage/belt/gun/m44/lever_action/attach_holster
		qdel(src)
		usr.put_in_hands(new_belt)
		usr.put_in_hands(new_holster)
		update_icon(usr)
	else
		return

/obj/item/storage/belt/gun/m44/lever_action/attach_holster
	name = "\improper M276 revolver holster attachment"
	desc = "这个枪套可以瞬间安装到空的M276 .45-70装备带上，牺牲一些储物空间来携带副武器。如果你真想的话，也可以单独把它别在腰带上。"
	icon_state = "r4t-attach-holster"
	item_state = "r4t-attach-holster"
	w_class = SIZE_LARGE
	storage_slots = 1
	max_storage_space = 1
	can_hold = list(
		/obj/item/weapon/gun/revolver,
	)
	skip_fullness_overlays = TRUE

/obj/item/storage/belt/gun/mateba
	name = "\improper M276 pattern Unica holster rig"
	desc = "M276是USCM的标准负重装备。它由一个带有各种卡扣的模块化腰带组成。此版本适配强大的独角兽自动左轮手枪，并配有五个用于快速装弹器的小袋。它曾随2170年代初邮购的USCM版独角兽自动左轮手枪一同附送。"
	icon_state = "cmateba_holster"
	item_state = "marinebelt"
	icon = 'icons/obj/items/clothing/belts/belts_by_map/snow.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	storage_slots = 7
	max_w_class = SIZE_MEDIUM
	can_hold = list(
		/obj/item/weapon/gun/revolver/mateba,
		/obj/item/ammo_magazine/revolver/mateba/highimpact,
		/obj/item/ammo_magazine/revolver/mateba,
	)
	holster_slots = list(
		"1" = list(
			"icon_x" = -1,
			"icon_y" = -3))

/obj/item/storage/belt/gun/mateba/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/impact())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)

/obj/item/storage/belt/gun/mateba/cmateba
	icon_state = "cmateba_holster"
	item_state = "marinebelt"
	flags_atom = FPRINT // has gamemode skin

/obj/item/storage/belt/gun/mateba/cmateba/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/cmateba())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)

/obj/item/storage/belt/gun/mateba/cmateba/special/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/special())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)

/obj/item/storage/belt/gun/mateba/mtr6m
	name = "\improper M276 pattern 2006M holster rig"
	desc = "M276是USCM的标准负重装备。它由一个带有各种卡扣的模块化腰带组成。此版本适配强大的独角兽自动左轮手枪，并配有五个用于快速装弹器的小袋。它曾随2170年代初邮购的USCM版矛头2006m自动左轮手枪一同附送。"
	icon_state = "cmateba_holster"
	item_state = "marinebelt"
	flags_atom = FPRINT // has gamemode skin

/obj/item/storage/belt/gun/mateba/mtr6m/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/mtr6m())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)

/obj/item/storage/belt/gun/mateba/council
	name = "上校款M276型独角兽枪套装备带"
	desc = "The M276 is the standard load-bearing equipment of the USCM. \
	It consists of a modular belt with various clips. This version is for the powerful Unica autorevolver, \
	along with five small pouches for speedloaders. This specific one is tinted black and engraved with gold, heavily customized for a high-ranking official."
	icon_state = "amateba_holster"
	item_state = "marinebelt"
	icon = 'icons/obj/items/clothing/belts/belts.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN

/obj/item/storage/belt/gun/mateba/council/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/silver())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)

/obj/item/storage/belt/gun/mateba/council/full_golden/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/golden())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)

/obj/item/storage/belt/gun/mateba/council/mtr6m
	name = "上校款M276型2006M枪套装备带"
	desc = "The M276 is the standard load-bearing equipment of the USCM. \
	It consists of a modular belt with various clips. This version is for the powerful 2006M autorevolver, \
	along with five small pouches for speedloaders. This specific one is tinted black and engraved with gold, heavily customized for a high-ranking official."

/obj/item/storage/belt/gun/mateba/council/mtr6m/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/mtr6m/golden())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)

/obj/item/storage/belt/gun/mateba/council/mtr6m/full_silver/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/mtr6m/silver())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)

/obj/item/storage/belt/gun/mateba/council/mtr6m/full_black/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/mtr6m/golden/black_handle())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)

/obj/item/storage/belt/gun/mateba/commando
	name = "突击队员款WY-T190型独角兽枪套装备带"
	desc = "The M276 is the standard load-bearing equipment of the Weyland Yutani. \
	It consists of a modular belt with various clips. This version is for the powerful Unica autorevolver, \
	along with five small pouches for speedloaders. This specific one is tinted black and engraved with gold, heavily customized for a high-ranking official."
	icon_state = "amateba_holster"
	item_state = "marinebelt"
	icon = 'icons/obj/items/clothing/belts/belts.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN

/obj/item/storage/belt/gun/mateba/commando/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/engraved/tactical())
	new /obj/item/ammo_magazine/revolver/mateba(src)
	new /obj/item/ammo_magazine/revolver/mateba(src)
	new /obj/item/ammo_magazine/revolver/mateba(src)
	new /obj/item/ammo_magazine/revolver/mateba(src)
	new /obj/item/ammo_magazine/revolver/mateba(src)
	new /obj/item/ammo_magazine/revolver/mateba(src)

/obj/item/storage/belt/gun/mateba/commando/full/deathsquad/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/engraved/tactical())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)

/obj/item/storage/belt/gun/mateba/general
	name = "豪华款M276型独角兽枪套装备带"
	desc = "The M276 is the standard load-bearing equipment of the USCM. \
	It consists of a modular belt with various clips. This version is for the powerful Unica autorevolver, \
	along with five small pouches for speedloaders. This specific one is tinted black and engraved with gold, heavily customized for a high-ranking official."
	icon_state = "amateba_holster"
	item_state = "marinebelt"
	icon = 'icons/obj/items/clothing/belts/belts.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN

/obj/item/storage/belt/gun/mateba/general/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/general())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/explosive(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/explosive(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)

/obj/item/storage/belt/gun/mateba/general/impact/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/general())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)

/obj/item/storage/belt/gun/mateba/general/santa/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/general/santa())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/explosive(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/explosive(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/explosive(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/explosive(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/explosive(src)

/obj/item/storage/belt/gun/mateba/pmc
	name = "PMC款M276型独角兽枪套装备带"
	desc = "The M276 is the standard load-bearing equipment of the USCM. \
	It consists of a modular belt with various clips. This version is for the powerful Unica autorevolver, \
	along with five small pouches for speedloaders. This specific one is tinted black and engraved with gold, heavily customized for a high-ranking official."
	icon_state = "amateba_holster"
	item_state = "marinebelt"
	icon = 'icons/obj/items/clothing/belts/belts.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN

/obj/item/storage/belt/gun/mateba/pmc/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba/general())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/explosive(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact/explosive(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)

/obj/item/storage/belt/gun/type47
	name = "\improper Type 47 pistol holster rig"
	desc = "这款UPP设计的副武器装备带可以非常贴合且牢固地容纳73式、NP92或ZHNK-72手枪，以及它们的弹匣或快速装弹器。然而，它在存储武器的多样性上有所欠缺。"
	icon_state = "korovin_holster"
	item_state = "upp_belt"
	icon = 'icons/obj/items/clothing/belts/belts_by_faction/UPP.dmi'
	item_icons = list(
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/belts/belts_by_faction/UPP.dmi',
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_faction/UPP.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_righthand.dmi'
	)
	storage_slots = 7
	can_hold = list(
		/obj/item/weapon/gun/pistol/t73,
		/obj/item/ammo_magazine/pistol/t73,
		/obj/item/ammo_magazine/pistol/t73_impact,
		/obj/item/weapon/gun/pistol/np92,
		/obj/item/ammo_magazine/pistol/np92,
		/obj/item/ammo_magazine/pistol/np92/tranq,
		/obj/item/weapon/gun/revolver/upp,
		/obj/item/ammo_magazine/revolver/upp,
		/obj/item/ammo_magazine/revolver/upp/shrapnel,
	)
	holster_slots = list("1" = list("icon_x" = -1))

/obj/item/storage/belt/gun/type47/np92/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/np92())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/np92(src)

/obj/item/storage/belt/gun/type47/np92/suppressed/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/np92/suppressed())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/np92/suppressed(src)

/obj/item/storage/belt/gun/type47/t73/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/t73())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/t73(src)

/obj/item/storage/belt/gun/type47/t73/leader/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/t73/leader())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/t73_impact(src)

/obj/item/storage/belt/gun/type47/revolver/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/upp())
	for(var/total_storage_slots in 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/revolver/upp(src)

/obj/item/storage/belt/gun/type47/revolver/shrapnel/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/upp/shrapnel())
	for(var/total_storage_slots in 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/revolver/upp/shrapnel(src)

//Crazy Ivan's belt reskin
/obj/item/storage/belt/gun/type47/ivan
	name = "枪架"
	desc = "从无形的虚空中，涌现出一个比元素本身更原始的存在。紧随其后的，将是一场风暴。"
	icon_state = "ivan_belt"
	storage_slots = 56
	max_storage_space = 56
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes
	max_w_class = SIZE_MASSIVE
	can_hold = list(
		/obj/item/weapon/gun/pistol,
		/obj/item/weapon/gun/revolver,
		/obj/item/ammo_magazine,
	)

/obj/item/storage/belt/gun/type47/ivan/Initialize()
	. = ..()
	var/list/bad_mags = typesof(/obj/item/ammo_magazine/hardpoint) + /obj/item/ammo_magazine/handful + /obj/item/ammo_magazine/handful/shotgun/custom_color + /obj/item/ammo_magazine/flamer_tank/empty + /obj/item/ammo_magazine/flamer_tank/large/empty + /obj/item/ammo_magazine/flamer_tank/custom + /obj/item/ammo_magazine/rocket/custom + /obj/item/ammo_magazine/smg
	var/list/sentry_mags = typesof(/obj/item/ammo_magazine/sentry) + typesof(/obj/item/ammo_magazine/sentry_flamer) + /obj/item/ammo_magazine/m56d + /obj/item/ammo_magazine/m2c
	var/list/internal_mags = (typesof(/obj/item/ammo_magazine/internal) + /obj/item/ammo_magazine/handful)
	var/list/training_mags = list(
		/obj/item/ammo_magazine/rifle/rubber,
		/obj/item/ammo_magazine/rifle/m4ra/rubber,
		/obj/item/ammo_magazine/smg/m39/rubber,
		/obj/item/ammo_magazine/pistol/rubber,
		/obj/item/ammo_magazine/pistol/mod88/rubber) //Ivan doesn't bring children's ammo.

	var/list/bad_guns = list(
		/obj/item/weapon/gun/pistol/m4a3/training,
		/obj/item/weapon/gun/pistol/mod88/training,
		/obj/item/weapon/gun/pistol/kt42, // HONKed currently
		/obj/item/weapon/gun/pistol/auto9, // HONKed currently
		/obj/item/weapon/gun/pistol/chimp, // HONKed currently
		/obj/item/weapon/gun/pistol/skorpion, // HONKed currently
	)

	var/list/picklist = subtypesof(/obj/item/ammo_magazine) - (internal_mags + bad_mags + sentry_mags + training_mags)
	var/random_mag = pick(picklist)
	var/guntype = pick(subtypesof(/obj/item/weapon/gun/revolver) + subtypesof(/obj/item/weapon/gun/pistol) - bad_guns)
	handle_item_insertion(new guntype())
	for(var/total_storage_slots in 2 to storage_slots) //minus templates
		new random_mag(src)
		random_mag = pick(picklist)

/obj/item/storage/belt/gun/smartpistol
	name = "\improper M276 pattern SU-6 Smartpistol holster rig"
	desc = "M276是USCM的标准负重装备。它由一个带有各种卡扣的模块化腰带组成。此版本适配SU-6智能手枪。"
	icon_state = "smartpistol_holster"
	storage_slots = 7
	holster_slots = list(
		"1" = list(
			"icon_x" = -5,
			"icon_y" = -2))
	can_hold = list(
		/obj/item/weapon/gun/pistol/smart,
		/obj/item/ammo_magazine/pistol/smart,
	)
	flags_atom = FPRINT // has gamemode skin

/obj/item/storage/belt/gun/smartpistol/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/smart())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/smart(src)

/obj/item/storage/belt/gun/smartpistol/full_nogun/fill_preset_inventory()
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/smart(src)

/obj/item/storage/belt/gun/flaregun
	name = "\improper M276 pattern M82F flare gun holster rig"
	desc = "M276是USCM的标准负重装备。它由一个带有各种卡扣的模块化腰带组成。此版本适配M82F信号枪。"
	storage_slots = 17
	max_storage_space = 20
	icon_state = "m82f_holster"
	item_state = "marinebelt"
	icon = 'icons/obj/items/clothing/belts/belts.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	can_hold = list(
		/obj/item/weapon/gun/flare,
		/obj/item/device/flashlight/flare,
	)
	holster_slots = list(
		"1" = list(
			"icon_x" = -1,
			"icon_y" = -3))

/obj/item/storage/belt/gun/flaregun/dump_into(obj/item/storage/origin_storage, mob/user)

	if(length(holstered_guns) < 1 && length(contents) >= (storage_slots-1))

		to_chat(user, SPAN_WARNING("[src]已满。"))
		return FALSE
	return ..()

/obj/item/storage/belt/gun/flaregun/handle_item_insertion(obj/item/new_item, prevent_warning = FALSE, mob/user)

	if(istype(new_item, /obj/item/device/flashlight/flare) && length(holstered_guns) < 1 && length(contents) >= (storage_slots-1))
		return FALSE
	return ..()

/obj/item/storage/belt/gun/flaregun/has_room(obj/item/new_item, W_class_override = null)

	if(istype(new_item, /obj/item/device/flashlight/flare) && length(holstered_guns) < 1 && length(contents) >= (storage_slots-1))
		return FALSE //No slot open because gun in holster.
	return ..()

/obj/item/storage/belt/gun/flaregun/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/flare())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/device/flashlight/flare(src)

/obj/item/storage/belt/gun/flaregun/full_nogun/fill_preset_inventory()
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/device/flashlight/flare(src)

/obj/item/storage/belt/gun/flaregun/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/storage/box/m94))
		var/obj/item/storage/box/m94/M = W
		dump_into(M,user)
	else
		return ..()

/obj/item/storage/belt/gun/webley
	name = "\improper Webley Mk VI gunbelt"
	desc = "精工细作的英国皮革，一把韦伯利手枪，以及六个.455口径的快速装弹器。足以干掉任何有腿的东西。"
	icon_state = "m44r_holster"
	icon = 'icons/obj/items/clothing/belts/belts_by_map/jungle.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/jungle.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)
	storage_slots = 7
	can_hold = list(
		/obj/item/weapon/gun/revolver/m44/custom/webley,
		/obj/item/ammo_magazine/revolver,
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes
	holster_slots = list(
		"1" = list(
			"icon_x" = -1,
			"icon_y" = -3))

/obj/item/storage/belt/gun/webley/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/m44/custom/webley())
	for(var/i in 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/revolver/webley(src)

/obj/item/storage/belt/gun/iasf_para_belt
	name = "\improper IASF paratrooper belt"
	desc = "一条坚固的腰带，配有为IASF空降兵设计的黑色皮革枪套。一个大型工具袋和几个较小的隔层为额外弹药和战场必需品提供了充足空间——这是IASF空降部队投入敌对领土的标准装备。"
	icon_state = "iasf_pistol_para"
	item_state = "iasf_pistol_para"
	icon = 'icons/obj/items/clothing/belts/belts_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_faction/TWE.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_righthand.dmi'
	)
	storage_slots = 8
	can_hold = list(
		/obj/item/weapon/gun/revolver,
		/obj/item/ammo_magazine/revolver,
		/obj/item/weapon/gun/pistol,
		/obj/item/ammo_magazine/pistol,
	)
	flags_atom = FPRINT|NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	holster_slots = list(
		"1" = list(
			"icon_x" = -1,
			"icon_y" = -3))

/obj/item/storage/belt/gun/iasf_para_belt/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/m44/custom/webley/IASF_webley())
	for(var/i in 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/revolver/webley(src)

/obj/item/storage/belt/gun/iasf_para_belt/webley_near_empty/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/m44/custom/webley/IASF_webley())
	for(var/i = 1 to 3)
		new /obj/item/ammo_magazine/revolver/webley(src)

/obj/item/storage/belt/gun/iasf_para_belt/custom
	name = "\improper IASF custom paratrooper belt"
	desc = "一条经过改装的IASF空降兵腰带，配有金色镶嵌的黑色皮革枪套，一个大型工具袋和几个较小的隔层为额外弹药和战场必需品提供了充足空间——这是IASF空降部队投入敌对领土的标准装备。"
	icon_state = "iasf_pistol_para_custom"
	item_state = "iasf_pistol_para_custom"

/obj/item/storage/belt/gun/iasf_para_belt/custom/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/l54_custom())
	for(var/i in 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/l54_custom(src)

/obj/item/storage/belt/gun/smartgunner
	name = "\improper M802 pattern smartgunner sidearm rig"
	desc = "M802是USCM限量配发的负重装备型号，设计用于携带智能枪弹药和一把副武器。"
	icon_state = "sgbelt"
	holster_slots = list(
		"1" = list(
			"icon_x" = 5,
			"icon_y" = -2))
	can_hold = list(
		/obj/item/device/flashlight/flare,
		/obj/item/weapon/gun/flare,
		/obj/item/weapon/gun/pistol,
		/obj/item/weapon/gun/revolver,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/smartgun,
	)
	flags_atom = FPRINT // has gamemode skin

/obj/item/storage/belt/gun/smartgunner/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/m4a3())
	new /obj/item/ammo_magazine/pistol/hp(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)

/obj/item/storage/belt/gun/smartgunner/marsoc
	icon = 'icons/obj/items/clothing/belts/belts_by_map/snow.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

/obj/item/storage/belt/gun/smartgunner/marsoc/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/m1911/socom/equipped())
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/smartgun/heap(src)
	new /obj/item/ammo_magazine/smartgun/heap(src)
	new /obj/item/ammo_magazine/smartgun/heap(src)

/obj/item/storage/belt/gun/smartgunner/marsoc/full_low_threat/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/m1911/socom/equipped())
	new /obj/item/ammo_magazine/pistol/m1911(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)

/obj/item/storage/belt/gun/smartgunner/pmc
	name = "\improper WY-TM410 pattern smartgunner sidearm rig"
	desc = "一款维兰德制造的特殊型号战斗腰带，设计用于携带智能枪弹药和一把副武器。"
	icon = 'icons/obj/items/clothing/belts/belts_by_faction/WY.dmi'
	icon_state = "wy_sgbelt"
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_faction/WY.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	can_hold = list(
		/obj/item/device/flashlight/flare,
		/obj/item/weapon/gun/flare,
		/obj/item/weapon/gun/pistol,
		/obj/item/weapon/gun/revolver,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/revolver/mateba,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/smartgun,
	)

/obj/item/storage/belt/gun/smartgunner/pmc/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/vp78())
	new /obj/item/ammo_magazine/pistol/vp78(src)
	new /obj/item/ammo_magazine/pistol/vp78(src)
	new /obj/item/ammo_magazine/smartgun(src)
	new /obj/item/ammo_magazine/smartgun(src)

/obj/item/storage/belt/gun/smartgunner/commando
	name = "\improper WY-TM410 pattern 'Terminator' smartgunner sidearm rig"
	desc = "一款维兰德制造的特殊型号战斗腰带，设计用于携带智能枪弹药和一把副武器。"
	icon = 'icons/obj/items/clothing/belts/belts_by_faction/WY.dmi'
	icon_state = "wy_sgbelt"
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_faction/WY.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	can_hold = list(
		/obj/item/device/flashlight/flare,
		/obj/item/weapon/gun/flare,
		/obj/item/weapon/gun/pistol,
		/obj/item/weapon/gun/revolver,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/revolver/mateba,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/smartgun,
	)

/obj/item/storage/belt/gun/smartgunner/commando/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/vp78/whiteout())
	new /obj/item/ammo_magazine/smartgun/dirty(src)
	new /obj/item/ammo_magazine/smartgun/dirty(src)
	new /obj/item/ammo_magazine/smartgun/dirty(src)
	new /obj/item/ammo_magazine/smartgun/dirty(src)

/obj/item/storage/belt/gun/smartgunner/clf
	name = "\improper M802 pattern 'Freedom' smartgunner sidearm rig"
	desc = "对标准M802负重装备的改装，设计用于携带智能枪弹药和一把独角兽自动左轮手枪。这条腰带的制造印记上刻有CLF的标识。"
	icon = 'icons/obj/items/clothing/belts/belts_by_map/jungle.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_map/jungle.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	can_hold = list(
		/obj/item/device/flashlight/flare,
		/obj/item/weapon/gun/flare,
		/obj/item/weapon/gun/pistol,
		/obj/item/weapon/gun/revolver,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/revolver/mateba,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/smartgun,
	)

/obj/item/storage/belt/gun/smartgunner/clf/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/mateba())
	new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)
	new /obj/item/ammo_magazine/smartgun/rusty(src)
	new /obj/item/ammo_magazine/smartgun/rusty(src)
	new /obj/item/ammo_magazine/smartgun/rusty(src)

/obj/item/storage/belt/gun/smartgunner/clf/full_alt/fill_preset_inventory()
	switch(rand(1, 5))
		if(1)
			handle_item_insertion(new /obj/item/weapon/gun/revolver/upp())
			new /obj/item/ammo_magazine/revolver/upp(src)
			new /obj/item/ammo_magazine/revolver/upp(src)
		if(2)
			handle_item_insertion(new /obj/item/weapon/gun/revolver/cmb())
			new /obj/item/ammo_magazine/revolver/cmb(src)
			new /obj/item/ammo_magazine/revolver/cmb(src)
		if(3)
			handle_item_insertion(new /obj/item/weapon/gun/pistol/m1911())
			new /obj/item/ammo_magazine/pistol/m1911(src)
			new /obj/item/ammo_magazine/pistol/m1911(src)
		if(4)
			handle_item_insertion(new /obj/item/weapon/gun/pistol/t73())
			new /obj/item/ammo_magazine/pistol/t73(src)
			new /obj/item/ammo_magazine/pistol/t73(src)
		if(5)
			handle_item_insertion(new /obj/item/weapon/gun/pistol/heavy())
			new /obj/item/ammo_magazine/pistol/heavy(src)
			new /obj/item/ammo_magazine/pistol/heavy(src)
	new /obj/item/ammo_magazine/smartgun/rusty(src)
	new /obj/item/ammo_magazine/smartgun/rusty(src)

/obj/item/storage/belt/gun/mortarbelt
	name="\improper M276 pattern mortar operator belt"
	desc="一种配置用于携带M402迫击炮弹药以及一把副武器的M276负重装备带。"
	icon_state="mortarbelt"
	storage_slots = 9
	holster_slots = list("1" = list("icon_x" = 11))
	can_hold = list(
		/obj/item/weapon/gun/pistol,
		/obj/item/weapon/gun/revolver/m44,
		/obj/item/weapon/gun/flare,
		/obj/item/mortar_shell,
	)
	bypass_w_limit = list(/obj/item/mortar_shell)
	flags_atom = FPRINT // has gamemode skin

/obj/item/storage/belt/gun/utility
	name = "\improper M276 pattern combat toolbelt rig"
	desc = "M276型战斗工具腰带是USCM为在战区执行维修任务的工程师提供的替代性负重装备。它由一个模块化腰带组成，带有用于存放工具的各种夹子和口袋，以及一个手枪套。由于手枪体积较大，它无法像标准型号那样容纳同样多的工具。"
	storage_slots = 9
	icon_state = "combatutility"
	item_state= "utility"
	icon = 'icons/obj/items/clothing/belts/belts.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_WAIST = "combatutility",
		WEAR_L_HAND = "utility",
		WEAR_R_HAND = "utility"
	)
	can_hold = list(
		/obj/item/weapon/gun/pistol,
		/obj/item/weapon/gun/revolver,
		/obj/item/weapon/gun/flare,
		/obj/item/tool/crowbar,
		/obj/item/tool/screwdriver,
		/obj/item/tool/weldingtool,
		/obj/item/tool/wirecutters,
		/obj/item/tool/wrench,
		/obj/item/tool/extinguisher/mini,
		/obj/item/tool/shovel/etool,
		/obj/item/stack/cable_coil,
		/obj/item/weapon/gun/smg/nailgun/compact,
		/obj/item/cell,
		/obj/item/circuitboard,
		/obj/item/stock_parts,
		/obj/item/device/demo_scanner,
		/obj/item/device/reagent_scanner,
		/obj/item/device/assembly,
		/obj/item/device/multitool,
		/obj/item/device/flashlight,
		/obj/item/device/t_scanner,
		/obj/item/device/analyzer,
		/obj/item/explosive/plastic,
		/obj/item/device/lightreplacer,
		/obj/item/device/defibrillator/synthetic,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/handful,
	)
	bypass_w_limit = list(
		/obj/item/tool/shovel/etool,
		/obj/item/device/lightreplacer,
	)
	holster_slots = list(
		"1" = list(
			"icon_x" = -9,
			"icon_y" = -6))


/obj/item/storage/belt/gun/utility/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/mod88())
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/device/multitool(src)

////////////OTHER BELTS//////////////

/obj/item/storage/belt/tank
	name = "\improper M103 pattern vehicle ammo rig"
	desc = "M103是USCM限量配发的负重装备型号，专为载具乘员携带其载具弹药而设计。"
	icon_state = "tankbelt"
	item_state = "tankbelt"
	item_state_slots = list(
		WEAR_L_HAND = "utility",
		WEAR_R_HAND = "utility"
	)
	storage_slots = 2 //can hold 2 only two large items such as Tank Ammo.
	max_w_class = SIZE_LARGE
	max_storage_space = 2
	can_hold = list(
		/obj/item/ammo_magazine/hardpoint/ltb_cannon,
		/obj/item/ammo_magazine/hardpoint/ltaaap_minigun,
		/obj/item/ammo_magazine/hardpoint/primary_flamer,
		/obj/item/ammo_magazine/hardpoint/secondary_flamer,
		/obj/item/ammo_magazine/hardpoint/ace_autocannon,
		/obj/item/ammo_magazine/hardpoint/towlauncher,
		/obj/item/ammo_magazine/hardpoint/m56_cupola,
		/obj/item/ammo_magazine/hardpoint/tank_glauncher,
		/obj/item/ammo_magazine/hardpoint/turret_smoke,
		/obj/item/ammo_magazine/hardpoint/boyars_dualcannon,
		/obj/item/ammo_magazine/hardpoint/flare_launcher,
	)

/obj/item/storage/belt/souto
	name = "\improper Souto belt"
	desc = "Souto Man可靠的实用腰带，带有可分离的Souto饮料罐。它们无法被装回去。"
	icon_state = "souto_man"
	item_state = "marinebelt"
	icon = 'icons/obj/items/clothing/belts/misc.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/misc.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	flags_equip_slot = SLOT_WAIST
	storage_flags = STORAGE_FLAGS_DEFAULT|STORAGE_USING_DRAWING_METHOD
	storage_slots = 8
	flags_inventory = CANTSTRIP
	max_w_class = 0 //this belt cannot hold anything
	skip_fullness_overlays = TRUE

/obj/item/storage/belt/souto/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/souta)

/obj/item/storage/belt/souto/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/reagent_container/food/drinks/cans/souto/classic(src)

/obj/item/storage/belt/souto/update_icon()
	var/mob/living/carbon/human/user = loc
	item_state = "souto_man[length(contents)]"
	if(istype(user))
		user.update_inv_belt() //Makes sure the onmob updates.



//ROYAL MARINES COMMNADO

/obj/item/storage/belt/marine/rmc
	name = "\improper L70 pattern ammo load rig"
	desc = "适合在丛林激战中携带额外弹药。由特殊的防霉烂织物制成。"
	icon_state = "rmc_ammo"
	item_state = "rmc_ammo"
	icon = 'icons/obj/items/clothing/belts/belts_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_faction/TWE.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_L_HAND = "upp_belt",
		WEAR_R_HAND = "upp_belt"
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN

/obj/item/storage/belt/marine/rmc/rmc_f90_ammo/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/rmc_f90(src)

/obj/item/storage/belt/marine/rmc/rmc_f90_ammo/marksman/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/rmc_f90/marksman(src)

/obj/item/storage/belt/marine/rmc/l64a3/marksman/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/l64/ap(src)

/obj/item/storage/belt/marine/rmc/rmc_l23_ammo/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/l23(src)

/obj/item/storage/belt/medical/rmc
	name = "\improper L75 pattern medical storage rig"
	desc = "L75是RMC的标准负重装备。它由一个带有各种夹子的模块化腰带组成。此版本设计用于运输医疗物资和手枪弹药。\n右键点击其图标并点击\"toggle belt mode\" to take pills out of bottles by simply clicking them."
	icon = 'icons/obj/items/clothing/belts/belts_by_faction/TWE.dmi'
	icon_state ="rmc_medical"
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_faction/TWE.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_righthand.dmi'
	)
	item_state_slots = list(
		WEAR_L_HAND = "upp_belt",
		WEAR_R_HAND = "upp_belt"
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN

	storage_slots = 21

/obj/item/storage/belt/medical/rmc/full/fill_preset_inventory()
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/oxycodone(src)
	new /obj/item/storage/pill_bottle/antitox(src)
	new /obj/item/storage/pill_bottle/peridaxon(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/storage/pill_bottle/alkysine(src)
	new /obj/item/storage/pill_bottle/imidazoline(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dexalinp(src)
	new /obj/item/device/healthanalyzer(src)

/obj/item/storage/belt/medical/rmc/survivor/fill_preset_inventory()
	new /obj/item/storage/pill_bottle/packet/bicaridine(src)
	new /obj/item/storage/pill_bottle/packet/kelotane(src)
	new /obj/item/storage/pill_bottle/packet/tramadol(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/storage/pill_bottle/packet/tricordrazine(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/device/healthanalyzer(src)

/obj/item/storage/belt/gun/l905
	name = "\improper L905 gunbelt"
	desc = "精工皮革、一把L905和六个弹匣。对于标准的RMC突击队员来说绰绰有余。"
	icon_state = "rmc_pistol"
	item_state = "upp_belt"
	icon = 'icons/obj/items/clothing/belts/belts_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_faction/TWE.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_righthand.dmi'
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	storage_slots = 7
	can_hold = list(
		/obj/item/weapon/gun/pistol/vp78,
		/obj/item/ammo_magazine/pistol/vp78,
	)
	holster_slots = list(
		"1" = list(
			"icon_x" = -1,
			"icon_y" = -3))

/obj/item/storage/belt/gun/l905/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/vp78())
	for(var/i in 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/vp78(src)

/obj/item/storage/belt/gun/type47/SOF_belt
	name = "\improper Type 47-S pistol holster rig"
	icon_state = "korovin_black_holster"
	item_state = "upp_belt"

/obj/item/storage/belt/gun/type47/SOF_belt/t73/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/t73())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/t73(src)

/obj/item/storage/belt/gun/type47/SOF_belt/revolver/upp/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/revolver/upp())
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/revolver/upp(src)

/obj/item/storage/belt/gun/l54
	name = "\improper pistol belt"
	desc = "一种深棕色皮革手枪腰带，通常配发给NSPA军官。虽然专为L54制式手枪设计，但它也能容纳大多数手枪及备用弹匣。是TWE执法、军事和安全部队的标准装备。"
	icon_state = "l54_holster"
	item_state = "l54_holster"
	icon = 'icons/obj/items/clothing/belts/belts_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/belts_by_faction/TWE.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_righthand.dmi'
	)
	flags_atom = FPRINT|NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	storage_slots = 7
	can_hold = list(
		/obj/item/weapon/gun/pistol,
		/obj/item/ammo_magazine/pistol,
	)

/obj/item/storage/belt/gun/l54/full/fill_preset_inventory()
	handle_item_insertion(new /obj/item/weapon/gun/pistol/l54())
	for(var/i in 1 to storage_slots - 1)
		new /obj/item/ammo_magazine/pistol/l54(src)
