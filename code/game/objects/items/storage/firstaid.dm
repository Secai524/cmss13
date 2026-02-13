/* First aid storage
 * Contains:
 * First Aid Kits
 * Pill Bottles
 * Pill Packets
 */

//---------FIRST AID KITS---------
/obj/item/storage/firstaid
	name = "急救包"
	desc = "这是一个用于处理严重伤口的紧急医疗包。经过医疗训练后，你可以把它放进背包。"
	icon = 'icons/obj/items/storage/medical.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
	)
	icon_state = "firstaid"
	var/empty_icon = "kit_empty"
	throw_speed = SPEED_FAST
	throw_range = 8
	use_sound = "toolbox"
	matter = list("plastic" = 2000)
	can_hold = list(
		/obj/item/device/healthanalyzer,
		/obj/item/reagent_container/dropper,
		/obj/item/reagent_container/pill,
		/obj/item/reagent_container/glass/bottle,
		/obj/item/reagent_container/syringe,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/reagent_container/hypospray,
		/obj/item/storage/syringe_case,
		/obj/item/storage/surgical_case,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/tool/surgery/synthgraft,
		/obj/item/roller,
		/obj/item/bodybag,
		/obj/item/reagent_container/blood,
		/obj/item/tool/surgery/FixOVein,
	)
	storage_flags = STORAGE_FLAGS_BOX
	required_skill_for_nest_opening = SKILL_MEDICAL
	required_skill_level_for_nest_opening = SKILL_MEDICAL_MEDIC

	var/icon_full //icon state to use when kit is full
	var/possible_icons_full
	/// List of types and their corresponding overlay icon state for appearing inside the item.
	var/list/types_and_overlays = list(
		/obj/item/reagent_container/hypospray/autoinjector/tricord = "tricord_injector_overlay",
		/obj/item/stack/medical/advanced/bruise_pack = "brute_kit_overlay",
		/obj/item/stack/medical/advanced/ointment = "burn_kit_overlay",
		/obj/item/stack/medical/splint = "splints_overlay",
		/obj/item/storage/syringe_case = "syringe_case_overlay",
		/obj/item/tool/surgery/synthgraft = "synthgraft_overlay",
		/obj/item/tool/surgery/surgical_line = "surgical_line_overlay",
		/obj/item/tool/surgery/FixOVein = "fixovein_overlay",
		/obj/item/reagent_container/blood = "bloodpack_overlay",
		/obj/item/storage/surgical_case = "surgical_case_overlay",
	)
	/// Whether this kit has content overlays or not
	var/has_overlays = TRUE

/obj/item/storage/firstaid/Initialize()
	. = ..()

	if(possible_icons_full)
		icon_full = pick(possible_icons_full)
	else
		icon_full = initial(icon_state)

	update_icon()

/obj/item/storage/firstaid/update_icon()
	overlays.Cut()
	if(content_watchers)
		icon_state = empty_icon
		if(!has_overlays)
			return
		for(var/obj/item/overlayed_item in contents)
			if(types_and_overlays[overlayed_item.type])
				overlays += types_and_overlays[overlayed_item.type]
	else if(!length(contents))
		icon_state = empty_icon
		return
	else
		icon_state = icon_full

/obj/item/storage/firstaid/attack_self(mob/living/user)
	..()

	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.swap_hand()
		open(user)

/obj/item/storage/firstaid/fire
	name = "消防急救包"
	desc = "这是一个紧急医疗包，用于应对运输机弹药库<i>-自发-</i>起火的情况。经过医疗训练后，你可以把它放进背包。"
	icon_state = "ointment"
	item_state = "firstaid-ointment"
	possible_icons_full = list("ointment","firefirstaid")


/obj/item/storage/firstaid/fire/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/reagent_container/hypospray/autoinjector/kelotane(src)
	new /obj/item/reagent_container/hypospray/autoinjector/kelotane(src)
	new /obj/item/reagent_container/hypospray/autoinjector/kelotane(src)
	new /obj/item/reagent_container/hypospray/autoinjector/skillless/tramadol(src)

/obj/item/storage/firstaid/fire/empty/fill_preset_inventory()
	return

/obj/item/storage/firstaid/regular
	icon_state = "firstaid"
	item_state = "firstaid"
	desc = "这是一个包含基本药品和设备的紧急医疗包。无需训练即可使用。经过医疗训练后，你可以把它放进背包。"

/obj/item/storage/firstaid/regular/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/reagent_container/hypospray/autoinjector/skillless(src)
	new /obj/item/reagent_container/hypospray/autoinjector/skillless/tramadol(src)
	new /obj/item/reagent_container/hypospray/autoinjector/inaprovaline(src)
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/firstaid/regular/empty/fill_preset_inventory()
	return

/obj/item/storage/firstaid/regular/response
	desc = "这是一个包含基本药品和设备的紧急医疗包。无需训练即可使用。这个型号更简单，存放也无需训练。"
	required_skill_for_nest_opening = SKILL_MEDICAL
	required_skill_level_for_nest_opening = SKILL_MEDICAL_DEFAULT

/obj/item/storage/firstaid/robust
	icon_state = "firstaid"

/obj/item/storage/firstaid/robust/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/firstaid/robust/empty/fill_preset_inventory()
	return

/obj/item/storage/firstaid/toxin
	name = "毒素急救包"
	desc = "这是一个包含救命抗毒药物的紧急医疗包。经过医疗训练后，你可以把它放进背包。"
	icon_state = "antitoxin"
	item_state = "firstaid-toxin"

/obj/item/storage/firstaid/toxin/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/storage/pill_bottle/antitox(src)
	new /obj/item/storage/pill_bottle/antitox(src)
	new /obj/item/reagent_container/hypospray/autoinjector/antitoxin(src)
	new /obj/item/reagent_container/hypospray/autoinjector/antitoxin(src)
	new /obj/item/reagent_container/hypospray/autoinjector/antitoxin(src)
	new /obj/item/reagent_container/hypospray/autoinjector/inaprovaline(src)

/obj/item/storage/firstaid/toxin/empty/fill_preset_inventory()
	return

/obj/item/storage/firstaid/o2
	name = "缺氧急救包"
	desc = "一个装满再充氧好物的箱子。经过医疗训练，你可以将其放入背包。"
	icon_state = "o2"
	item_state = "firstaid-o2"

/obj/item/storage/firstaid/o2/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/reagent_container/pill/dexalin(src)
	new /obj/item/reagent_container/pill/dexalin(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dexalinp(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dexalinp(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dexalinp(src)
	new /obj/item/reagent_container/hypospray/autoinjector/inaprovaline(src)

/obj/item/storage/firstaid/o2/empty/fill_preset_inventory()
	return

/obj/item/storage/firstaid/adv
	name = "高级急救包"
	desc = "包含比基础急救包更有效的医疗手段，例如烧伤包和创伤包。经过医疗训练，你可以将其放入背包。"
	icon_state = "advfirstaid"
	item_state = "firstaid-advanced"

/obj/item/storage/firstaid/adv/fill_preset_inventory()
	new /obj/item/reagent_container/hypospray/autoinjector/tricord(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/firstaid/adv/empty/fill_preset_inventory()
	return

/obj/item/storage/firstaid/synth
	name = "合成人维修包"
	desc = "包含修复受损合成人的设备。背面标签写着：'不包含修复失能合成人的电击工具，也不包含检测特定损伤的扫描设备；请另行准备。' 经过医疗训练，你可以将其放入背包。"
	icon_state = "bezerk"
	item_state = "firstaid-advanced"
	can_hold = list(
		/obj/item/device/healthanalyzer,
		/obj/item/reagent_container/dropper,
		/obj/item/reagent_container/pill,
		/obj/item/reagent_container/glass/bottle,
		/obj/item/reagent_container/syringe,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/reagent_container/hypospray,
		/obj/item/storage/syringe_case,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/tool/surgery/synthgraft,
		/obj/item/stack/nanopaste,
		/obj/item/stack/cable_coil,
		/obj/item/tool/weldingtool,
	)

/obj/item/storage/firstaid/synth/fill_preset_inventory()
	new /obj/item/stack/nanopaste(src)
	new /obj/item/stack/nanopaste(src)
	new /obj/item/stack/nanopaste(src)
	new /obj/item/stack/nanopaste(src)
	new /obj/item/stack/cable_coil/white(src)
	new /obj/item/stack/cable_coil/white(src)
	new /obj/item/tool/weldingtool(src)

/obj/item/storage/firstaid/synth/empty/fill_preset_inventory()
	return

/obj/item/storage/firstaid/whiteout
	name = "精英维修包"
	desc = "一个外观昂贵、采用碳纤维饰面的工具盒，正面印有巨大的W-Y标志。包含用于修复受损合成人的先进设备，包括重置钥匙。"
	icon_state = "whiteout"
	empty_icon = "whiteout_empty"
	item_state = "whiteout"
	has_overlays = FALSE //different formfactor
	can_hold = list(
		/obj/item/device/healthanalyzer,
		/obj/item/reagent_container/dropper,
		/obj/item/reagent_container/pill,
		/obj/item/reagent_container/glass/bottle,
		/obj/item/reagent_container/syringe,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/reagent_container/hypospray,
		/obj/item/storage/syringe_case,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/tool/surgery/synthgraft,
		/obj/item/stack/nanopaste,
		/obj/item/stack/cable_coil,
		/obj/item/tool/weldingtool,
		/obj/item/device/defibrillator/synthetic,
	)

/obj/item/storage/firstaid/whiteout/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/storage/firstaid/whiteout/fill_preset_inventory()
	new /obj/item/stack/nanopaste(src)
	new /obj/item/stack/nanopaste(src)
	new /obj/item/stack/nanopaste(src)
	new /obj/item/stack/nanopaste(src)
	new /obj/item/stack/cable_coil/white(src)
	new /obj/item/device/defibrillator/synthetic/noskill(src)
	new /obj/item/tool/weldingtool/largetank(src)

/obj/item/storage/firstaid/whiteout/empty/fill_preset_inventory()
	return

/obj/item/storage/firstaid/whiteout/medical
	name = "精英战场复苏包"
	desc = "一个外观昂贵、采用碳纤维饰面的工具盒，正面印有巨大的W-Y标志。包含为高优先级人物提供医疗援助的先进医疗工具。"
	icon_state = "whiteout_medical"
	empty_icon = "whiteout_empty"
	item_state = "whiteout"
	can_hold = list(
		/obj/item/device/healthanalyzer,
		/obj/item/reagent_container/dropper,
		/obj/item/reagent_container/pill,
		/obj/item/reagent_container/glass/bottle,
		/obj/item/reagent_container/syringe,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/reagent_container/hypospray,
		/obj/item/storage/syringe_case,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/tool/surgery/synthgraft,
		/obj/item/stack/nanopaste,
		/obj/item/stack/cable_coil,
		/obj/item/tool/weldingtool,
		/obj/item/device/defibrillator,
		/obj/item/tool/surgery/scalpel/manager,
		/obj/item/storage/box/czsp/medic_upgraded_kits/full,
		/obj/item/storage/surgical_case,
		/obj/item/roller,
	)

/obj/item/storage/firstaid/whiteout/medical/fill_preset_inventory()
	new /obj/item/storage/box/czsp/medic_upgraded_kits/full(src)
	new /obj/item/storage/box/czsp/medic_upgraded_kits/full(src)
	new /obj/item/stack/medical/splint/nano(src)
	new /obj/item/storage/surgical_case/elite/whiteout(src)
	new /obj/item/storage/syringe_case/whiteout(src)
	new /obj/item/device/defibrillator/compact(src)
	new /obj/item/roller/surgical(src)

/obj/item/storage/firstaid/whiteout/medical/commando/fill_preset_inventory()
	new /obj/item/storage/box/czsp/medic_upgraded_kits/full(src)
	new /obj/item/storage/box/czsp/medic_upgraded_kits/full(src)
	new /obj/item/stack/medical/splint/nano(src)
	new /obj/item/reagent_container/blood/OMinus(src)
	new /obj/item/storage/syringe_case/commando(src)
	new /obj/item/storage/surgical_case/elite/commando(src)
	new /obj/item/roller/surgical(src)

/obj/item/storage/firstaid/whiteout/medical/commando/looted/fill_preset_inventory() //for commando insert
	new /obj/item/storage/box/czsp/medic_upgraded_kits/looted(src)
	new /obj/item/storage/box/czsp/medic_upgraded_kits/looted(src)
	new /obj/item/stack/medical/splint/nano(src, rand(1,2))
	new /obj/item/storage/syringe_case/commando/looted(src)
	new /obj/item/storage/surgical_case/elite/commando/looted(src)
	new /obj/item/roller(src)

/obj/item/storage/firstaid/rad
	name = "辐射急救包"
	desc = "包含针对辐射暴露的治疗物品。经过医疗训练，你可以将其放入背包。"
	icon_state = "purplefirstaid"

/obj/item/storage/firstaid/rad/fill_preset_inventory()
	new /obj/item/reagent_container/pill/russianRed(src)
	new /obj/item/reagent_container/pill/russianRed(src)
	new /obj/item/reagent_container/pill/russianRed(src)
	new /obj/item/reagent_container/pill/russianRed(src)
	new /obj/item/reagent_container/hypospray/autoinjector/bicaridine(src)
	new /obj/item/reagent_container/hypospray/autoinjector/bicaridine(src)

/obj/item/storage/firstaid/rad/empty/fill_preset_inventory()
	return

/obj/item/storage/firstaid/surgical
	name = "基础野战手术包"
	desc = "包含手术缝合线、烧灼器、手术刀、止血钳、牵开器、手术巾以及用于手术处理伤口的羟考酮注射器。经过医疗训练，你可以将其放入背包。"
	icon_state = "bezerk"
	can_hold = list(
		/obj/item/device/healthanalyzer,
		/obj/item/reagent_container/dropper,
		/obj/item/reagent_container/pill,
		/obj/item/reagent_container/glass/bottle,
		/obj/item/reagent_container/syringe,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/reagent_container/hypospray,
		/obj/item/storage/syringe_case,
		/obj/item/tool/surgery,
	)

/obj/item/storage/firstaid/surgical/fill_preset_inventory()
	new /obj/item/tool/surgery/surgical_line(src)
	new /obj/item/tool/surgery/cautery(src)
	new /obj/item/tool/surgery/scalpel(src)
	new /obj/item/tool/surgery/hemostat(src)
	new /obj/item/tool/surgery/retractor(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)

/obj/item/storage/firstaid/surgical/empty/fill_preset_inventory()
	return

//---------SYRINGE CASE---------

/obj/item/storage/syringe_case
	name = "注射器盒"
	desc = "这是一个用于存放注射器和药瓶的医疗箱。"
	icon = 'icons/obj/items/storage/medical.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
	)
	icon_state = "syringe_case"
	throw_speed = SPEED_FAST
	throw_range = 8
	storage_slots = 3
	w_class = SIZE_SMALL
	matter = list("plastic" = 1000)
	can_hold = list(
		/obj/item/reagent_container/pill,
		/obj/item/reagent_container/glass/bottle,
		/obj/item/paper,
		/obj/item/reagent_container/syringe,
		/obj/item/reagent_container/hypospray/autoinjector,
	)

/obj/item/storage/syringe_case/regular

/obj/item/storage/syringe_case/regular/fill_preset_inventory()
	new /obj/item/reagent_container/syringe( src )
	new /obj/item/reagent_container/glass/bottle/inaprovaline( src )
	new /obj/item/reagent_container/glass/bottle/tricordrazine( src )

/obj/item/storage/syringe_case/burn

/obj/item/storage/syringe_case/burn/fill_preset_inventory()
	new /obj/item/reagent_container/syringe( src )
	new /obj/item/reagent_container/glass/bottle/kelotane( src )
	new /obj/item/reagent_container/glass/bottle/tricordrazine( src )

/obj/item/storage/syringe_case/tox

/obj/item/storage/syringe_case/tox/fill_preset_inventory()
	new /obj/item/reagent_container/syringe( src )
	new /obj/item/reagent_container/glass/bottle/antitoxin( src )
	new /obj/item/reagent_container/glass/bottle/antitoxin( src )

/obj/item/storage/syringe_case/oxy

/obj/item/storage/syringe_case/oxy/fill_preset_inventory()
	new /obj/item/reagent_container/syringe( src )
	new /obj/item/reagent_container/glass/bottle/inaprovaline( src )
	new /obj/item/reagent_container/glass/bottle/dexalin( src )

/obj/item/storage/syringe_case/rmc

/obj/item/storage/syringe_case/rmc/fill_preset_inventory()
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone( src )
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone( src )
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone( src )

/obj/item/storage/syringe_case/whiteout

/obj/item/storage/syringe_case/whiteout/fill_preset_inventory()
	new /obj/item/reagent_container/hypospray/autoinjector/stimulant/redemption_stimulant( src )
	new /obj/item/reagent_container/hypospray/autoinjector/emergency( src )
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone( src )

/obj/item/storage/syringe_case/commando

/obj/item/storage/syringe_case/commando/fill_preset_inventory()
	new /obj/item/reagent_container/hypospray/autoinjector/emergency( src )
	new /obj/item/reagent_container/hypospray/autoinjector/inaprovaline( src )
	new /obj/item/reagent_container/hypospray/autoinjector/adrenaline( src )

/obj/item/storage/syringe_case/commando/looted //for surv insert

/obj/item/storage/syringe_case/commando/looted/fill_preset_inventory()
	new /obj/item/reagent_container/hypospray/autoinjector/ultrazine/empty( src )
	new /obj/item/reagent_container/hypospray/autoinjector/inaprovaline( src )
	new /obj/item/reagent_container/hypospray/autoinjector/adrenaline( src )

/obj/item/storage/box/czsp/first_aid
	name = "急救战斗支援包"
	desc = "包含升级版医疗包、纳米夹板和升级版除颤器。"
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "medicbox"
	storage_slots = 3

/obj/item/storage/box/czsp/first_aid/Initialize()
	. = ..()
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/ointment(src)
	if(prob(5))
		new /obj/item/device/healthanalyzer(src)

/obj/item/storage/box/czsp/medical
	name = "医疗战斗支援包"
	desc = "包含升级版医疗包、纳米夹板和升级版除颤器。"
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "medicbox"
	storage_slots = 4

/obj/item/storage/box/czsp/medical/Initialize()
	. = ..()
	new /obj/item/stack/medical/advanced/bruise_pack/upgraded(src)
	new /obj/item/stack/medical/advanced/ointment/upgraded(src)
	new /obj/item/stack/medical/splint/nano(src)
	new /obj/item/device/defibrillator/upgraded(src)

/obj/item/storage/box/czsp/medic_upgraded_kits
	name = "医疗升级包"
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "upgradedkitbox"
	desc = "此工具包包含用于处理危重伤势的升级版创伤包和烧伤包。"
	w_class = SIZE_SMALL
	max_w_class = SIZE_MEDIUM
	storage_slots = 2

/obj/item/storage/box/czsp/medic_upgraded_kits/full/Initialize()
	. = ..()
	new /obj/item/stack/medical/advanced/bruise_pack/upgraded(src)
	new /obj/item/stack/medical/advanced/ointment/upgraded(src)

/obj/item/storage/box/czsp/medic_upgraded_kits/looted/Initialize()
	. = ..()
	if(prob(35))
		new /obj/item/stack/medical/advanced/bruise_pack/upgraded(src, rand(1,4))
	if(prob(35))
		new /obj/item/stack/medical/advanced/ointment/upgraded(src, rand(1,4))


//---------SURGICAL CASE---------


/obj/item/storage/surgical_case
	name = "手术箱"
	desc = "It's a medical case for storing basic surgical tools. It comes with a brief description for treating common internal bleeds and eschar wounds.\
		\nBefore surgery: Verify correct location and patient is adequately numb to pain.\
		\nStep one: Open an incision at the site with the scalpel.\
		\nStep two: Clamp bleeders with the hemostat.\
		\nStep three: Draw back the skin with the retracter.\
		\nStep four: Patch the damaged vein with a surgical line.\
		\nStep five: Close the incision with a surgical line.\
		\nTo treat eschar, follow the same procedure as above, but use a scalpel and then SynthGraft or an ointment in step four."
	icon = 'icons/obj/items/storage/medical.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
	)
	icon_state = "surgical_case"
	throw_speed = SPEED_FAST
	throw_range = 8
	storage_slots = 3
	w_class = SIZE_SMALL
	matter = list("plastic" = 1000)
	can_hold = list(
		/obj/item/tool/surgery/scalpel,
		/obj/item/tool/surgery/hemostat,
		/obj/item/tool/surgery/retractor,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/tool/surgery/synthgraft,
		/obj/item/tool/surgery/FixOVein,
	)

/obj/item/storage/surgical_case/regular

/obj/item/storage/surgical_case/regular/fill_preset_inventory()
	new /obj/item/tool/surgery/scalpel(src)
	new /obj/item/tool/surgery/hemostat(src)
	new /obj/item/tool/surgery/retractor(src)

/obj/item/storage/surgical_case/elite
	name = "精英手术箱"
	desc = "It's an expensive looking medical case for storing compactly placed field surgical tools. Has a bright reflective W-Y logo on it.\
		\nBefore surgery: Verify correct location and patient is adequately numb to pain.\
		\nStep one: Open an incision at the site with the scalpel.\
		\nStep two: Clamp bleeders with the hemostat.\
		\nStep three: Draw back the skin with the retracter.\
		\nStep four: Patch the damaged vein with a surgical line.\
		\nStep five: Close the incision with a surgical line."
	icon_state = "surgical_case_elite"
	storage_slots = 5

/obj/item/storage/surgical_case/elite/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/storage/surgical_case/elite/commando/fill_preset_inventory()
	new /obj/item/tool/surgery/scalpel(src)
	new /obj/item/tool/surgery/hemostat(src)
	new /obj/item/tool/surgery/retractor(src)
	new /obj/item/tool/surgery/surgical_line(src)
	new /obj/item/tool/surgery/synthgraft(src)

/obj/item/storage/surgical_case/elite/commando/looted/fill_preset_inventory()
	if(prob(65))
		new /obj/item/tool/surgery/scalpel(src)
	if(prob(65))
		new /obj/item/tool/surgery/hemostat(src)
	if(prob(65))
		new /obj/item/tool/surgery/retractor(src)
	new /obj/item/tool/surgery/surgical_line(src)
	new /obj/item/tool/surgery/synthgraft(src)

/obj/item/storage/surgical_case/elite/whiteout
	storage_slots = 3

/obj/item/storage/surgical_case/elite/whiteout/fill_preset_inventory()
	new /obj/item/tool/surgery/scalpel/manager(src)
	new /obj/item/tool/surgery/surgical_line(src)
	new /obj/item/tool/surgery/synthgraft(src)

/obj/item/storage/surgical_case/rmc_surgical_case
	name = "\improper RMC surgical case"
	desc = "It's a medical case for storing basic surgical tools. It comes with a brief description for treating common internal bleeds. This one was made specifically for Royal Marine Commandos, allowing them to suture their wounds during prolonged operations.\
		\nBefore surgery: Verify correct location and patient is adequately numb to pain.\
		\nStep one: Open an incision at the site with the scalpel.\
		\nStep two: Clamp bleeders with the hemostat.\
		\nStep three: Draw back the skin with the retracter.\
		\nStep four: Patch the damaged vein with a surgical line.\
		\nStep five: Close the incision with a surgical line."
	storage_slots = 5
	can_hold = list(
		/obj/item/tool/surgery/scalpel,
		/obj/item/tool/surgery/hemostat,
		/obj/item/tool/surgery/retractor,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/tool/surgery/synthgraft,
		/obj/item/tool/surgery/FixOVein,
	)

/obj/item/storage/surgical_case/rmc_surgical_case/full/fill_preset_inventory()
	new /obj/item/tool/surgery/scalpel(src)
	new /obj/item/tool/surgery/hemostat(src)
	new /obj/item/tool/surgery/retractor(src)
	new /obj/item/tool/surgery/surgical_line(src)
	new /obj/item/tool/surgery/synthgraft(src)


//---------PILL BOTTLES---------

/obj/item/storage/pill_bottle
	name = "药瓶"
	desc = "这是一个用于存放药物的密封容器。"
	icon_state = "pill_canister"
	icon = 'icons/obj/items/chemistry.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi'
	)
	item_state = "pill_canister"
	w_class = SIZE_SMALL
	matter = list("plastic" = 500)
	can_hold = list(
		/obj/item/reagent_container/pill,
		/obj/item/toy/dice,
		/obj/item/paper,
	)
	storage_flags = STORAGE_FLAGS_BOX|STORAGE_CLICK_GATHER|STORAGE_QUICK_GATHER|STORAGE_DISABLE_USE_EMPTY
	storage_slots = null
	use_sound = "pillbottle"
	max_storage_space = 16
	var/skilllock = SKILL_MEDICAL_MEDIC
	var/pill_type_to_fill //type of pill to use to fill in the bottle in /Initialize()
	var/bottle_lid = TRUE //Whether it shows a visual lid when opened or closed.
	var/display_maptext = TRUE
	var/maptext_label
	maptext_height = 16
	maptext_width = 24
	maptext_x = 4
	maptext_y = 2

	var/base_icon = "pill_canister"
	var/static/list/possible_colors = list(
		"橙子" = "",
		"Blue" = "1",
		"Yellow" = "2",
		"Light Purple" = "3",
		"Light Grey" = "4",
		"White" = "5",
		"Light Green" = "6",
		"Cyan" = "7",
		"Bordeaux" = "8",
		"Aquamarine" = "9",
		"Grey" = "10",
		"Red" = "11",
		"Black" = "12",
	)

/obj/item/storage/pill_bottle/Initialize()
	. = ..()
	if(!display_maptext)
		verbs -= /obj/item/storage/pill_bottle/verb/set_maptext

/obj/item/storage/pill_bottle/fill_preset_inventory()
	if(pill_type_to_fill)
		for(var/i in 1 to max_storage_space)
			new pill_type_to_fill(src)

/obj/item/storage/pill_bottle/update_icon()
	if(!bottle_lid)
		return
	overlays.Cut()
	if(content_watchers || !length(contents))
		overlays += "pills_open"
	else
		overlays += "pills_closed"

	if((isstorage(loc) || ismob(loc)) && display_maptext)
		maptext = SPAN_LANGCHAT("[maptext_label]")
	else
		maptext = ""

/obj/item/storage/pill_bottle/get_examine_text(mob/user)
	. = ..()
	var/pills_amount = length(contents)
	if(pills_amount)
		var/percentage_filled = floor(pills_amount/max_storage_space * 100)
		switch(percentage_filled)
			if(80 to 101)
				. += SPAN_INFO("The [name] seems fairly full.")
			if(60 to 79)
				. += SPAN_INFO("The [name] feels more than half full.")
			if(40 to 59)
				. += SPAN_INFO("The [name] seems to be around half full.")
			if(20 to 39)
				. += SPAN_INFO("The [name] feels less than half full.")
			if(0 to 19)
				. += SPAN_INFO("The [name] feels like it's nearly empty!")
	else
		. += SPAN_INFO("[name]是空的。")

/obj/item/storage/pill_bottle/attack_self(mob/living/user)
	..()

	if(user.get_inactive_hand())
		to_chat(user, SPAN_WARNING("你需要空出一只手来取药片。"))
		return
	if(!can_storage_interact(user))
		error_idlock(user)
		return
	if(length(contents))
		var/obj/item/I = contents[1]
		if(user.put_in_inactive_hand(I))
			playsound(loc, use_sound, 10, TRUE, 3)
			remove_from_storage(I,user)
			to_chat(user, SPAN_NOTICE("你从[name]中取出一片药。"))
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.swap_hand()
			return
	else
		to_chat(user, SPAN_WARNING("[name]是空的。"))
		return

/obj/item/storage/pill_bottle/shake(mob/user, turf/tile)
	if(!can_storage_interact(user))
		error_idlock(user)
		return
	return ..()

/obj/item/storage/pill_bottle/attackby(obj/item/storage/pill_bottle/W, mob/user)
	if(istype(W))
		if((skilllock || W.skilllock) && !skillcheck(user, SKILL_MEDICAL, SKILL_MEDICAL_MEDIC))
			error_idlock(user)
			return
		dump_into(W,user)
	else
		return ..()


/obj/item/storage/pill_bottle/open(mob/user)
	if(!can_storage_interact(user))
		error_idlock(user)
		return
	..()

/obj/item/storage/pill_bottle/can_be_inserted(obj/item/W, mob/user, stop_messages = FALSE)
	. = ..()
	if(.)
		if(!can_storage_interact(user))
			error_idlock(usr)
			return



/obj/item/storage/pill_bottle/clicked(mob/user, list/mods)
	if(..())
		return TRUE
	// Only proceed with instant pill grab if we're in a storage container
	if(!isstorage(loc))
		return FALSE
	var/obj/item/storage/container_holding_pill = loc
	if(!container_holding_pill.instant_pill_grabbable)
		return FALSE
	if(!container_holding_pill.instant_pill_grab_mode)
		return FALSE
	if(!can_storage_interact(user))
		error_idlock(user)
		return FALSE
	if(user.get_active_hand())
		return FALSE
	var/mob/living/carbon/C = user
	if(C.is_mob_restrained())
		to_chat(user, SPAN_WARNING("你被束缚了！"))
		return FALSE
	if(!length(contents))
		to_chat(user, SPAN_WARNING("[name]是空的。"))
		return FALSE
	var/obj/item/I = contents[1]
	if(user.put_in_active_hand(I))
		remove_from_storage(I,user)
		to_chat(user, SPAN_NOTICE("你从[name]中取出[I]。"))
		return TRUE

/obj/item/storage/pill_bottle/empty(mob/user, turf/T)
	if(skilllock && !skillcheck(user, SKILL_MEDICAL, SKILL_MEDICAL_MEDIC))
		error_idlock(user)
		return
	..()

/obj/item/storage/pill_bottle/equipped()
	..()
	update_icon()

/obj/item/storage/pill_bottle/on_exit_storage()
	..()
	update_icon()

/obj/item/storage/pill_bottle/dropped()
	..()
	update_icon()

/obj/item/storage/pill_bottle/attack_hand(mob/user, mods)
	if(loc != user)
		return ..()

	if(!mods || !mods[ALT_CLICK])
		return ..()

	if(!ishuman(user))
		return ..()

	if(!can_storage_interact(user))
		error_idlock(user)
		return FALSE

	return ..()

/obj/item/storage/pill_bottle/proc/error_idlock(mob/user)
	to_chat(user, SPAN_WARNING("它一定有某种身份锁..."))

/obj/item/storage/pill_bottle/proc/choose_color(mob/user)
	if(!user)
		user = usr

	var/selected_color = tgui_input_list(user, "选择颜色。", "Color choice", possible_colors)
	if(!selected_color)
		return

	selected_color = possible_colors[selected_color]

	icon_state = base_icon + selected_color
	to_chat(user, SPAN_NOTICE("你给[src]上了色。"))
	update_icon()

/obj/item/storage/pill_bottle/verb/set_maptext()
	set category = "Object"
	set name = "Set short label (on-sprite)"
	set src in usr

	if(src && ishuman(usr))
		var/str = copytext(reject_bad_text(input(usr,"标签文本？（最多3个字符）", "Set [src]'s on-sprite label", "")), 1, 4)
		if(!str || !length(str))
			to_chat(usr, SPAN_NOTICE("你清除了[src]上的标签。"))
			maptext_label = null
			update_icon()
			return
		maptext_label = str
		to_chat(usr, SPAN_NOTICE("你用粗大的方块字母在[src]上贴上了'[str]'标签。"))
		update_icon()

/obj/item/storage/pill_bottle/can_storage_interact(mob/user)
	if(skilllock && !skillcheck(user, SKILL_MEDICAL, SKILL_MEDICAL_MEDIC))
		return FALSE
	return ..()

/obj/item/storage/pill_bottle/kelotane
	name = "\improper Kelotane pill bottle"
	desc = "一个装满用于治疗烧伤的凯洛坦药片的药瓶。短时间内不要服用超过两片。"
	icon_state = "pill_canister2"
	item_state = "pill_canister2"
	pill_type_to_fill = /obj/item/reagent_container/pill/kelotane
	maptext_label = "Kl"

/obj/item/storage/pill_bottle/kelotane/skillless
	skilllock = SKILL_MEDICAL_DEFAULT

/obj/item/storage/pill_bottle/antitox
	name = "\improper Dylovene pill bottle"
	desc = "一个装满用于治疗毒素伤害的迪洛文药片的药瓶。短时间内不要服用超过两片。"
	icon_state = "pill_canister6"
	item_state = "pill_canister6"
	pill_type_to_fill = /obj/item/reagent_container/pill/antitox
	maptext_label = "Dy"


/obj/item/storage/pill_bottle/antitox/skillless
	skilllock = SKILL_MEDICAL_DEFAULT

/obj/item/storage/pill_bottle/inaprovaline
	name = "\improper Inaprovaline pill bottle"
	desc = "一个装满用于稳定危急病人的伊纳普罗瓦林药片的药瓶。短时间内不要服用超过两片。"
	icon_state = "pill_canister3"
	item_state = "pill_canister3"
	pill_type_to_fill = /obj/item/reagent_container/pill/inaprovaline
	maptext_label = "In"

/obj/item/storage/pill_bottle/inaprovaline/skillless
	skilllock = SKILL_MEDICAL_DEFAULT

/obj/item/storage/pill_bottle/tramadol
	name = "\improper Tramadol pill bottle"
	desc = "一个装满曲马多的药瓶。用于治疗疼痛。"
	icon_state = "pill_canister5"
	item_state = "pill_canister5"
	pill_type_to_fill = /obj/item/reagent_container/pill/tramadol
	maptext_label = "Tr"

/obj/item/storage/pill_bottle/tramadol/skillless
	skilllock = SKILL_MEDICAL_DEFAULT

/obj/item/storage/pill_bottle/oxycodone
	name = "\improper Oxycodone pill bottle"
	desc = "这里面装的药片可以治疗剧痛，即使在活体手术期间也有效。短时间内不要服用超过两片。"
	icon_state = "pill_canister9"
	item_state = "pill_canister9"
	pill_type_to_fill = /obj/item/reagent_container/pill/oxycodone
	maptext_label = "Ox"

/obj/item/storage/pill_bottle/oxycodone/skillless
	skilllock = SKILL_MEDICAL_DEFAULT

/obj/item/storage/pill_bottle/spaceacillin
	name = "\improper Spaceacillin pill bottle"
	desc = "一个装满用于治疗太空疾病的太空青霉素药片的药瓶。短时间内不要服用超过两片。"
	icon_state = "pill_canister4"
	item_state = "pill_canister4"
	pill_type_to_fill = /obj/item/reagent_container/pill/spaceacillin
	maptext_label = "Sp"

/obj/item/storage/pill_bottle/spaceacillin/skillless
	skilllock = SKILL_MEDICAL_DEFAULT

/obj/item/storage/pill_bottle/bicaridine
	name = "\improper Bicaridine pill bottle"
	desc = "一个装满用于治疗钝器伤害的碧卡利定药片的药瓶。短时间内不要服用超过两片。"
	icon_state = "pill_canister11"
	item_state = "pill_canister11"
	pill_type_to_fill = /obj/item/reagent_container/pill/bicaridine
	maptext_label = "Bi"

/obj/item/storage/pill_bottle/bicaridine/skillless
	skilllock = SKILL_MEDICAL_DEFAULT

/obj/item/storage/pill_bottle/dexalin
	name = "\improper Dexalin pill bottle"
	desc = "一个装满用于给病人重新供氧的德克萨林药片的药瓶。短时间内不要服用超过两片。"
	icon_state = "pill_canister1"
	item_state = "pill_canister1"
	pill_type_to_fill = /obj/item/reagent_container/pill/dexalin
	maptext_label = "Dx"

/obj/item/storage/pill_bottle/dexalin/skillless
	skilllock = SKILL_MEDICAL_DEFAULT

//Alkysine
/obj/item/storage/pill_bottle/alkysine
	name = "\improper Alkysine pill bottle"
	desc = "一个装满用于治疗脑损伤的阿尔基辛药片的药瓶。短时间内不要服用超过两片。"
	icon_state = "pill_canister7"
	item_state = "pill_canister7"
	pill_type_to_fill = /obj/item/reagent_container/pill/alkysine
	maptext_label = "Al"

/obj/item/storage/pill_bottle/alkysine/skillless
	skilllock = SKILL_MEDICAL_DEFAULT

//imidazoline
/obj/item/storage/pill_bottle/imidazoline
	name = "\improper Imidazoline pill bottle"
	desc = "一个装满用于治疗眼部损伤的咪达唑啉药片的药瓶。短时间内不要服用超过两片。"
	icon_state = "pill_canister9"
	item_state = "pill_canister9"
	pill_type_to_fill = /obj/item/reagent_container/pill/imidazoline
	maptext_label = "Im"

/obj/item/storage/pill_bottle/imidazoline/skillless
	skilllock = SKILL_MEDICAL_DEFAULT

/obj/item/storage/pill_bottle/imialky
	name = "\improper Imidazoline-Alkysine pill bottle"
	desc = "一个装满咪达唑啉-阿尔基辛复合药片的药瓶，可同时治疗脑部和眼部损伤。短时间内不要服用超过两片。"
	icon_state = "pill_canister9"
	pill_type_to_fill = /obj/item/reagent_container/pill/imialky
	maptext_label = "IA"

//PERIDAXON
/obj/item/storage/pill_bottle/peridaxon
	name = "\improper Peridaxon pill bottle"
	desc = "一个装满用于阻止大多数器官损伤影响的培利达松药片的药瓶。短时间内不要服用超过两片。"
	icon_state = "pill_canister10"
	item_state = "pill_canister10"
	pill_type_to_fill = /obj/item/reagent_container/pill/peridaxon
	maptext_label = "Pr"

/obj/item/storage/pill_bottle/peridaxon/skillless
	skilllock = SKILL_MEDICAL_DEFAULT

//RUSSIAN RED ANTI-RAD
/obj/item/storage/pill_bottle/russianRed
	name = "\improper Russian red pill bottle"
	desc = "一个装满可减少辐射伤害的药片的药瓶。"
	icon_state = "pill_canister"
	item_state = "pill_canister"
	pill_type_to_fill = /obj/item/reagent_container/pill/russianRed
	maptext_label = "Rr"

/obj/item/storage/pill_bottle/russianRed/skillless
	skilllock = SKILL_MEDICAL_DEFAULT

//Ultrazine
/obj/item/storage/pill_bottle/ultrazine
	name = "药瓶"
	icon_state = "pill_canister11"
	item_state = "pill_canister11"
	max_storage_space = 5
	skilllock = SKILL_MEDICAL_DEFAULT //CL can open it
	var/idlock = TRUE
	pill_type_to_fill = /obj/item/reagent_container/pill/ultrazine/unmarked
	display_maptext = FALSE //for muh corporate secrets - Stan_Albatross

	req_one_access = list(ACCESS_WY_EXEC, ACCESS_WY_RESEARCH)
	black_market_value = 35


/obj/item/storage/pill_bottle/ultrazine/proc/id_check(mob/user)

	if(!idlock)
		return TRUE

	var/mob/living/carbon/human/human_user = user

	if(!allowed(human_user))
		to_chat(user, SPAN_NOTICE("它一定有某种身份锁..."))
		return FALSE

	var/obj/item/card/id/idcard = human_user.get_idcard()
	if(!idcard) //not wearing an ID
		to_chat(human_user, SPAN_NOTICE("它一定有某种身份锁..."))
		return FALSE

	if(!idcard.check_biometrics(human_user))
		to_chat(human_user, SPAN_WARNING("检测到错误的身份卡所有者。"))
		return FALSE

	return TRUE

/obj/item/storage/pill_bottle/ultrazine/attack_self(mob/living/user)
	if(!id_check(user))
		return
	..()

/obj/item/storage/pill_bottle/ultrazine/open(mob/user)
	if(!id_check(user))
		return
	..()

/obj/item/storage/pill_bottle/ultrazine/skillless
	name = "\improper Ultrazine pill bottle"
	desc = "这里面装的药片就像打了兴奋剂的阿德拉。让你跑得飞快，伙计。极易上瘾。"
	idlock = FALSE
	display_maptext = TRUE
	maptext_label = "Uz"

/obj/item/storage/pill_bottle/mystery
	name = "\improper Weird-looking pill bottle"
	desc = "你似乎无法识别此物。"

/obj/item/storage/pill_bottle/mystery/Initialize()
	icon_state = "pill_canister[rand(1, 12)]"
	maptext_label = "??"
	. = ..()

/obj/item/storage/pill_bottle/mystery/fill_preset_inventory()
	var/list/cool_pills = subtypesof(/obj/item/reagent_container/pill)
	for(var/i=1 to max_storage_space)
		var/pill_to_fill = pick(cool_pills)
		var/obj/item/reagent_container/pill/P = new pill_to_fill(src)
		P.identificable = FALSE

/obj/item/storage/pill_bottle/mystery/skillless
	skilllock = SKILL_MEDICAL_DEFAULT

/obj/item/storage/pill_bottle/stimulant
	name = "\improper Stimulant pill bottle"
	desc = "这里面装的药片能让神经和肌肉系统超负荷运转。让你更快更猛地冲锋。"
	icon_state = "pill_canister12"
	item_state = "pill_canister12"
	pill_type_to_fill = /obj/item/reagent_container/pill/stimulant
	maptext_label = "St"

/obj/item/storage/pill_bottle/stimulant/skillless
	skilllock = SKILL_MEDICAL_DEFAULT

//NOT FOR USCM USE!!!!
/obj/item/storage/pill_bottle/paracetamol
	name = "\improper Paracetamol pill bottle"
	desc = "这大概是某人的处方止痛药瓶。"
	icon_state = "pill_canister7"
	pill_type_to_fill = /obj/item/reagent_container/pill/paracetamol
	skilllock = SKILL_MEDICAL_DEFAULT
	maptext_label = "Pc"

//---------PILL PACKETS---------
/obj/item/storage/pill_bottle/packet
	name = "\improper pill packet"
	desc = "装有药片。一旦取出，就无法放回。"
	icon_state = "pill_packet"
	item_state_slots = list(WEAR_AS_GARB = "brutepack (bandages)")
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/medical.dmi',
	)
	bottle_lid = FALSE
	storage_slots = 4
	max_w_class = 0
	max_storage_space = 4
	skilllock = SKILL_MEDICAL_DEFAULT
	storage_flags = STORAGE_FLAGS_BOX|STORAGE_DISABLE_USE_EMPTY
	display_maptext = FALSE

/obj/item/storage/pill_bottle/packet/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(try_forced_folding))

/obj/item/storage/pill_bottle/packet/proc/try_forced_folding(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!isturf(loc))
		return

	if(locate(/obj/item/reagent_container/pill) in src)
		return

	UnregisterSignal(src, COMSIG_ITEM_DROPPED)
	storage_close(user)
	to_chat(user, SPAN_NOTICE("你扔掉了[src]。"))
	qdel(src)

/obj/item/storage/pill_bottle/packet/fill_preset_inventory()
	. = ..()
	update_icon()

/obj/item/storage/pill_bottle/packet/attack_hand(mob/user, mods)
	. = ..()
	update_icon()

/obj/item/storage/pill_bottle/packet/empty(mob/user, turf/T)
	. = ..()
	update_icon()

/obj/item/storage/pill_bottle/packet/update_icon()
	overlays.Cut()
	var/obj/item/reagent_container/pill/current = locate() in contents //access the pills inside the packet
	if(current)
		var/datum/reagents/current_reagents = current.reagents
		var/datum/reagent/current_reagent = locate() in current_reagents.reagent_list //reagent color is in here
		if(current_reagent)
			var/image/filling = image('icons/obj/items/chemistry.dmi', src, "[icon_state]_[length(contents)]")
			filling.color = current_reagent.color
			overlays += filling
			return

//icon states are handled by update_icon
/obj/item/storage/pill_bottle/packet/tricordrazine
	name = "三合剂药片包"
	desc = "此包装内含三合剂药片。可轻微治愈所有类型的伤害。一旦取出，无法放回。短时间内不要服用超过2片。"
	pill_type_to_fill = /obj/item/reagent_container/pill/tricordrazine

/obj/item/storage/pill_bottle/packet/tramadol
	name = "曲马多药片包装"
	desc = "此包装内含曲马多药片，一种温和的止痛药。一旦取出，无法放回。短时间内不要服用超过2片。"
	pill_type_to_fill = /obj/item/reagent_container/pill/tramadol

/obj/item/storage/pill_bottle/packet/bicaridine
	name = "碧卡利定药片包装"
	desc = "此包装内含碧卡利定药片。可有效治愈钝器伤害。一旦取出，无法放回。短时间内不要服用超过2片。"
	pill_type_to_fill = /obj/item/reagent_container/pill/bicaridine

/obj/item/storage/pill_bottle/packet/kelotane
	name = "凯洛坦药片包装"
	desc = "此包装内含凯洛坦药片。可有效治愈烧伤伤害。一旦取出，无法放回。短时间内不要服用超过2片。"
	pill_type_to_fill = /obj/item/reagent_container/pill/kelotane

/obj/item/storage/pill_bottle/packet/oxycodone
	name = "羟考酮药片包装"
	desc = "此包装内含羟考酮药片，一种高效止痛药。一旦取出，无法放回。短时间内不要服用超过2片。"
	pill_type_to_fill = /obj/item/reagent_container/pill/oxycodone
