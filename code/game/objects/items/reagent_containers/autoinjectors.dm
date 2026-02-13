/obj/item/reagent_container/hypospray/autoinjector
	name = "伊纳普罗瓦林自动注射器"
	var/chemname = "inaprovaline"
	var/autoinjector_type = "autoinjector" //referencing the icon state name in syringe.dmi
	//desc = "A rapid and safe way to administer small amounts of drugs by untrained or trained personnel."
	desc = "一支装有伊纳普罗瓦林的自动注射器。可用于挽救生命。"
	icon_state = "empty"
	item_state = "autoinjector"
	item_state_slots = list(WEAR_AS_GARB = "injector")
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/medical.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
	)
	flags_atom = FPRINT
	matter = list("plastic" = 300)
	amount_per_transfer_from_this = HIGH_REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD
	possible_transfer_amounts = null
	volume = (HIGH_REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD) * INJECTOR_USES
	magfed = FALSE
	starting_vial = null
	transparent = FALSE
	var/uses_left = 3
	var/mixed_chem = FALSE
	var/display_maptext = FALSE
	var/maptext_label
	maptext_height = 16
	maptext_width = 24
	maptext_x = 4
	maptext_y = 2

/obj/item/reagent_container/hypospray/autoinjector/Initialize()
	. = ..()
	if(mixed_chem)
		return
	reagents.add_reagent(chemname, volume)
	if(display_maptext == TRUE)
		verbs += /obj/item/storage/pill_bottle/verb/set_maptext
	update_icon()

/obj/item/reagent_container/hypospray/autoinjector/proc/update_uses_left()
	var/UL = reagents.total_volume / amount_per_transfer_from_this
	UL = floor(UL) == UL ? UL : floor(UL) + 1
	uses_left = UL

/obj/item/reagent_container/hypospray/autoinjector/attack(mob/M, mob/user)
	if(uses_left <= 0)
		return
	. = ..()
	if(!.)
		return
	uses_left--
	update_icon()

/obj/item/reagent_container/hypospray/autoinjector/update_icon()
	overlays.Cut()
	if((isstorage(loc) || ismob(loc)) && display_maptext)
		maptext = SPAN_LANGCHAT("[maptext_label]")
	else
		maptext = ""

	if(uses_left && autoinjector_type)
		var/image/filling = image('icons/obj/items/syringe.dmi', src, "[autoinjector_type]_[uses_left]")
		filling.color = mix_color_from_reagents(reagents.reagent_list)
		overlays += filling
		return

/obj/item/reagent_container/hypospray/autoinjector/get_examine_text(mob/user)
	. = ..()
	if(uses_left)
		. += SPAN_NOTICE("It is currently loaded with [uses_left].")
	else
		. += SPAN_NOTICE("它是空的。")

/obj/item/reagent_container/hypospray/autoinjector/equipped()
	..()
	update_icon()

/obj/item/reagent_container/hypospray/autoinjector/on_exit_storage()
	..()
	update_icon()

/obj/item/reagent_container/hypospray/autoinjector/dropped()
	..()
	update_icon()


/obj/item/reagent_container/hypospray/autoinjector/tricord
	name = "三合剂自动注射器"
	chemname = "tricordrazine"
	desc = "一支装有3剂15单位三合剂的自动注射器，这是一种用于治疗损伤的弱效通用药物。"
	amount_per_transfer_from_this = REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD
	volume = (REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD) * INJECTOR_USES
	display_maptext = TRUE
	maptext_label = "Tc"

/obj/item/reagent_container/hypospray/autoinjector/tricord/skillless
	name = "三合剂EZ自动注射器"
	desc = "一支EZ自动注射器，装有3剂15单位三合剂，这是一种用于治疗损伤的弱效通用药物。可在维兰德医疗售货机补充，且无需任何训练即可使用。"
	icon_state = "emptyskill"
	skilllock = SKILL_MEDICAL_DEFAULT
	maptext_label = "EzTc"

/obj/item/reagent_container/hypospray/autoinjector/adrenaline
	name = "肾上腺素自动注射器"
	chemname = "adrenaline"
	desc = "一支装有3剂5.25单位肾上腺素的自动注射器，肾上腺素是一种神经兴奋剂，可用于心脏复苏。可在维兰德医疗售货机补充。"
	amount_per_transfer_from_this = LOWM_REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD
	volume = (LOWM_REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD) * INJECTOR_USES
	display_maptext = TRUE
	maptext_label = "Ep"

/obj/item/reagent_container/hypospray/autoinjector/dexalinp
	name = "地克沙林+自动注射器"
	chemname = "dexalinp"
	desc = "一支装有3剂1单位地克沙林+的自动注射器，设计用于立即为全身供氧。可在维兰德医疗售货机补充。"
	amount_per_transfer_from_this = 1
	volume = 3
	display_maptext = TRUE
	maptext_label = "D+"

/obj/item/reagent_container/hypospray/autoinjector/chloralhydrate
	name = "麻醉剂自动注射器"
	chemname = "anesthetic"
	desc = "一支装有3剂1单位水合氯醛和9单位催眠剂的自动注射器。可快速使人镇静，当然，也用于手术。"
	amount_per_transfer_from_this = 10
	volume = 30
	mixed_chem = TRUE
	display_maptext = TRUE
	maptext_label = "ChSa"

/obj/item/reagent_container/hypospray/autoinjector/chloralhydrate/Initialize()
	. = ..()
	reagents.add_reagent("chloralhydrate", 1*3)
	reagents.add_reagent("stoxin", 9*3)
	update_icon()

/obj/item/reagent_container/hypospray/autoinjector/tramadol
	name = "曲马多自动注射器"
	chemname = "tramadol"
	desc = "一支装有3剂15单位曲马多的自动注射器，这是一种针对普通伤口的弱效但有效的止痛药。可在维兰德医疗售货机补充。"
	amount_per_transfer_from_this = REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD
	volume = (REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD) * INJECTOR_USES
	display_maptext = TRUE
	maptext_label = "Tr"

/obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless
	name = "曲马多EZ自动注射器"
	desc = "一支EZ自动注射器，装有3剂15单位曲马多，这是一种针对普通伤口的弱效但有效的止痛药。可在维兰德医疗售货机补充，且无需任何训练即可使用。"
	icon_state = "emptyskill"
	skilllock = SKILL_MEDICAL_DEFAULT
	maptext_label = "EzTr"

/obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless/one_use
	name = "一次性曲马多EZ自动注射器"
	desc = "一支EZ自动注射器，装有单剂15单位曲马多，这是一种针对普通伤口的弱效但有效的止痛药。无法补充，但无需任何训练即可使用。"
	icon_state = "empty_oneuse"
	autoinjector_type = "autoinjector_oneuse"
	volume = 15
	amount_per_transfer_from_this = 15
	uses_left = 1
	display_maptext = TRUE
	maptext_label = "OuTr"

/obj/item/reagent_container/hypospray/autoinjector/oxycodone
	name = "羟考酮自动注射器（强效止痛药）"
	chemname = "oxycodone"
	desc = "一支装有3剂10单位羟考酮的自动注射器，这是一种用于危及生命情况的强效止痛药。可在维兰德医疗售货机补充。"
	amount_per_transfer_from_this = MED_REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD
	volume = (MED_REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD) * INJECTOR_USES
	display_maptext = TRUE
	maptext_label = "Ox"

/obj/item/reagent_container/hypospray/autoinjector/kelotane
	name = "凯洛坦自动注射器"
	chemname = "kelotane"
	desc = "一支装有3剂15单位凯洛坦的自动注射器，这是一种常见的烧伤药物。可在维兰德医疗售货机补充。"
	amount_per_transfer_from_this = REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD
	volume = (REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD) * INJECTOR_USES
	display_maptext = TRUE
	maptext_label = "Kl"

/obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless
	name = "凯洛坦EZ自动注射器"
	desc = "一支EZ自动注射器，装有3剂15单位凯洛坦，这是一种常见的烧伤药物。无需任何训练即可使用。可在维兰德医疗售货机补充。"
	icon_state = "emptyskill"
	skilllock = SKILL_MEDICAL_DEFAULT
	display_maptext = TRUE
	maptext_label = "EzKl"

/obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless/one_use
	name = "一次性凯洛坦EZ自动注射器"
	desc = "一支EZ自动注射器，预装单次剂量15单位的凯洛坦，一种常见的烧伤药物。无法重新装填，但无需任何训练即可使用。"
	icon_state = "empty_oneuse"
	autoinjector_type = "autoinjector_oneuse"
	volume = 15
	amount_per_transfer_from_this = 15
	uses_left = 1
	display_maptext = TRUE
	maptext_label = "OuKl"

/obj/item/reagent_container/hypospray/autoinjector/bicaridine
	name = "碧卡利定自动注射器"
	chemname = "bicaridine"
	desc = "一支自动注射器，预装3次剂量，每次15单位的碧卡利定，一种常见的钝器伤及循环系统损伤药物。可在维兰德医疗售货机处重新装填。"
	amount_per_transfer_from_this = REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD
	volume = (REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD) * INJECTOR_USES
	display_maptext = TRUE
	maptext_label = "Bi"

/obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless
	name = "碧卡利定EZ自动注射器"
	desc = "一支EZ自动注射器，预装3次剂量，每次15单位的碧卡利定，一种常见的钝器伤及循环系统损伤药物。无需任何训练即可使用。"
	icon_state = "emptyskill"
	skilllock = SKILL_MEDICAL_DEFAULT
	display_maptext = TRUE
	maptext_label = "EzBi"

/obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless/one_use
	name = "一次性碧卡利定EZ自动注射器"
	desc = "一支EZ自动注射器，预装单次剂量15单位的碧卡利定，一种常见的钝器伤及循环系统损伤药物。无法重新装填，但无需任何训练即可使用。"
	icon_state = "empty_oneuse"
	autoinjector_type = "autoinjector_oneuse"
	volume = 15
	amount_per_transfer_from_this = 15
	uses_left = 1
	display_maptext = TRUE
	maptext_label = "OuBi"

/obj/item/reagent_container/hypospray/autoinjector/antitoxin
	name = "迪洛芬自动注射器"
	chemname = "anti_toxin"
	desc = "一支自动注射器，预装3次剂量，每次15单位的迪洛芬，一种常见的毒素损伤药物。可在维兰德医疗售货机处重新装填。"
	amount_per_transfer_from_this = REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD
	volume = (REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD) * INJECTOR_USES
	display_maptext = TRUE
	maptext_label = "Dy"

/obj/item/reagent_container/hypospray/autoinjector/antitoxin/skillless
	name = "迪洛芬EZ自动注射器"
	desc = "一支EZ自动注射器，预装3次剂量，每次15单位的迪洛芬，一种常见的毒素损伤药物。无需任何训练即可使用。可在维兰德医疗售货机处重新装填。"
	icon_state = "emptyskill"
	skilllock = SKILL_MEDICAL_DEFAULT
	display_maptext = TRUE
	maptext_label = "EzDy"

/obj/item/reagent_container/hypospray/autoinjector/antitoxin/skillless/one_use
	name = "一次性迪洛芬EZ自动注射器"
	desc = "一支EZ自动注射器，预装单次剂量15单位的迪洛芬，一种常见的毒素损伤药物。无法重新装填，但无需任何训练即可使用。"
	icon_state = "empty_oneuse"
	autoinjector_type = "autoinjector_oneuse"
	volume = 15
	amount_per_transfer_from_this = 15
	uses_left = 1
	display_maptext = TRUE
	maptext_label = "OuDy"

/obj/item/reagent_container/hypospray/autoinjector/meralyne
	name = "梅拉林自动注射器"
	desc = "一支自动注射器，预装3次剂量，每次15单位的梅拉林，一种高级的钝器伤及循环系统损伤药物。"
	chemname = "meralyne"
	amount_per_transfer_from_this = REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD
	volume = (REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD) * INJECTOR_USES
	display_maptext = TRUE
	maptext_label = "Me"

/obj/item/reagent_container/hypospray/autoinjector/dermaline
	name = "德马林自动注射器"
	desc = "一支自动注射器，预装3次剂量，每次15单位的德马林，一种高级烧伤药物。"
	chemname = "dermaline"
	amount_per_transfer_from_this = REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD
	volume = (REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD) * INJECTOR_USES
	display_maptext = TRUE
	maptext_label = "De"

/obj/item/reagent_container/hypospray/autoinjector/inaprovaline
	name = "伊纳普罗瓦林自动注射器"
	chemname = "inaprovaline"
	desc = "一支自动注射器，预装3次剂量，每次30单位的伊纳普罗瓦林，一种用于危急状态病人的紧急稳定药物。可在维兰德医疗售货机处重新装填。"
	amount_per_transfer_from_this = HIGH_REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD
	volume = (HIGH_REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD) * INJECTOR_USES
	display_maptext = TRUE
	maptext_label = "In"

/obj/item/reagent_container/hypospray/autoinjector/peridaxon
	name = "培利达松自动注射器"
	chemname = "peridaxon"
	desc = "一支自动注射器，预装3次剂量，每次7.5单位的培利达松，一种用于阻止大多数器官损伤症状的紧急药物。无法修复器官损伤。可在维兰德医疗售货机处重新装填。"
	amount_per_transfer_from_this = LOWH_REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD
	volume = (LOWH_REAGENTS_OVERDOSE * INJECTOR_PERCENTAGE_OF_OD) * INJECTOR_USES
	display_maptext = TRUE
	maptext_label = "Pr"

/obj/item/reagent_container/hypospray/autoinjector/emergency
	name = "紧急自动注射器（警告）"
	desc = "一支自动注射器，预装单次剂量77单位的特殊化学混合物，用于危及生命的紧急情况。无需任何训练即可使用。"
	icon_state = "empty_emergency"
	chemname = "emergency"
	autoinjector_type = "autoinjector_oneuse"
	amount_per_transfer_from_this = (REAGENTS_OVERDOSE-1)*2 + (MED_REAGENTS_OVERDOSE-1)
	volume = (REAGENTS_OVERDOSE-1)*2 + (MED_REAGENTS_OVERDOSE-1)
	mixed_chem = TRUE
	uses_left = 1
	injectSFX = 'sound/items/air_release.ogg'
	injectVOL = 70//limited-supply emergency injector with v.large injection of drugs. Variable sfx freq sometimes rolls too quiet.
	display_maptext = TRUE //see anaesthetic injector
	maptext_label = "!!"
	skilllock = SKILL_MEDICAL_DEFAULT

/obj/item/reagent_container/hypospray/autoinjector/emergency/Initialize()
	. = ..()
	reagents.add_reagent("bicaridine", REAGENTS_OVERDOSE-1)
	reagents.add_reagent("kelotane", REAGENTS_OVERDOSE-1)
	reagents.add_reagent("oxycodone", MED_REAGENTS_OVERDOSE-1)
	update_icon()

/obj/item/reagent_container/hypospray/autoinjector/black_goo_cure
	name = "\"Pathogen\" cure autoinjector (SINGLE-USE)"
	desc = "一支自动注射器，预装单次剂量的A0-3959X.91–15号制剂（亦称‘黑水’）解药。无需任何训练即可使用。"
	icon_state = "empty_research_oneuse"
	chemname = "antiZed"
	autoinjector_type = "autoinjector_oneuse"
	amount_per_transfer_from_this = 5
	volume = 5
	uses_left = 1
	injectSFX = 'sound/items/air_release.ogg'
	display_maptext = TRUE
	maptext_label = "!!!"
	skilllock = SKILL_MEDICAL_DEFAULT

/obj/item/reagent_container/hypospray/autoinjector/black_goo_cure/Initialize()
	. = ..()
	reagents.add_reagent("antiZed", 5)
	update_icon()

/obj/item/reagent_container/hypospray/autoinjector/ultrazine
	name = "超能素自动注射器"
	chemname = "ultrazine"
	desc = "一支自动注射器，预装5次剂量，每次5单位的超能素，一种特殊且非法的肌肉兴奋剂。切勿一次性注射超过两次。极易上瘾。"
	amount_per_transfer_from_this = 5
	volume = 25
	uses_left = 5
	autoinjector_type = "+stimpack_custom"
	icon_state = "stimpack"
	autoinjector_type = null
	skilllock = SKILL_MEDICAL_DEFAULT
	display_maptext = FALSE //corporate secret
	maptext_label = "Uz"

/obj/item/reagent_container/hypospray/autoinjector/ultrazine/update_icon()
	. = ..()
	icon_state = uses_left ? "stimpack" : "stimpack0"
	if((isstorage(loc) || ismob(loc)) && display_maptext)
		maptext = SPAN_LANGCHAT("[maptext_label]")
	else
		maptext = ""

/obj/item/reagent_container/hypospray/autoinjector/ultrazine/empty
	name = "空的超能剂自动注射器"
	volume = 0
	uses_left = 0

/obj/item/reagent_container/hypospray/autoinjector/ultrazine/liaison
	name = "白色自动注射器"
	desc = "你知道他们怎么说，别用可疑的注射器扎自己。"
	maptext_label = "??"

/obj/item/reagent_container/hypospray/autoinjector/yautja
	name = "异常晶体"
	chemname = "thwei"
	desc = "一块一端带尖刺、发出诡异光芒的晶体。"
	icon = 'icons/obj/items/hunter/pred_gear.dmi'
	icon_state = "crystal"
	injectSFX = 'sound/items/pred_crystal_inject.ogg'
	autoinjector_type = "thwei"
	injectVOL = 15
	amount_per_transfer_from_this = REAGENTS_OVERDOSE
	volume = REAGENTS_OVERDOSE
	uses_left = 1
	black_market_value = 25

/obj/item/reagent_container/hypospray/autoinjector/yautja/attack(mob/M as mob, mob/user as mob)
	if(HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		..()
	else
		to_chat(user, SPAN_DANGER("你不知道该往哪里注射[src]。"))

	if(uses_left == 0)
		addtimer(CALLBACK(src, PROC_REF(remove_crystal)), 120 SECONDS)

/obj/item/reagent_container/hypospray/autoinjector/yautja/proc/remove_crystal()
	visible_message(SPAN_DANGER("[src]坍缩消失，化为乌有。"))
	qdel(src)

/obj/item/reagent_container/hypospray/autoinjector/yautja/update_icon()
	overlays.Cut()
	if(uses_left && autoinjector_type) //does not apply a colored fill overlay like the rest of the autoinjectors
		var/image/filling = image('icons/obj/items/hunter/pred_gear.dmi', src, "[autoinjector_type]_[uses_left]")
		overlays += filling
		return

/obj/item/reagent_container/hypospray/autoinjector/skillless
	name = "急救自动注射器"
	chemname = "tricordrazine"
	desc = "一支装载了单次15单位三合剂的自动注射器，供陆战队员自行治疗。可在维兰德医疗贩卖机补充。"
	icon_state = "tricord"
	autoinjector_type = null
	amount_per_transfer_from_this = 15
	volume = 15
	skilllock = SKILL_MEDICAL_DEFAULT
	uses_left = 1
	display_maptext = TRUE
	maptext_label = "OuTc"

/obj/item/reagent_container/hypospray/autoinjector/skillless/attack(mob/M as mob, mob/user as mob)
	. = ..()
	if(.)
		if(!uses_left) //Prevents autoinjectors to be refilled.
			icon_state += "0"
			name += " expended"
			flags_atom &= ~OPENCONTAINER

/obj/item/reagent_container/hypospray/autoinjector/skillless/attackby()
	return

/obj/item/reagent_container/hypospray/autoinjector/skillless/get_examine_text(mob/user)
	. = ..()
	if(reagents && length(reagents.reagent_list))
		. += SPAN_NOTICE("It is currently loaded.")
	else if(!uses_left)
		. += SPAN_NOTICE("It is spent.")
	else
		. += SPAN_NOTICE("它是空的。")

/obj/item/reagent_container/hypospray/autoinjector/skillless/tramadol
	name = "止痛自动注射器"
	chemname = "tramadol"
	icon_state = "tramadol"
	desc = "一支装载了单次15单位曲马多的自动注射器，供陆战队员自行使用。可在维兰德医疗贩卖机补充。"
	maptext_label = "OuPs"

/obj/item/reagent_container/hypospray/autoinjector/empty
	name = "5单位定制自动注射器"
	desc = "一支定制自动注射器，可能来自研究部。可使用加压试剂罐袋补充。"
	icon_state = "empty_research"
	mixed_chem = TRUE
	amount_per_transfer_from_this = 5
	volume = 15
	uses_left = 0
	display_maptext = TRUE

/obj/item/reagent_container/hypospray/autoinjector/empty/get_examine_text(mob/user)
	. = ..()
	. += SPAN_NOTICE("It transfers [amount_per_transfer_from_this]u per injection and has a maximum of [volume/amount_per_transfer_from_this] injections.")

/obj/item/reagent_container/hypospray/autoinjector/empty/small
	name = "15单位定制自动注射器"
	amount_per_transfer_from_this = 15
	volume = 45

/obj/item/reagent_container/hypospray/autoinjector/empty/medium
	name = "30单位定制自动注射器"
	amount_per_transfer_from_this = 30
	volume = 90

/obj/item/reagent_container/hypospray/autoinjector/empty/large
	name = "60单位定制自动注射器"
	amount_per_transfer_from_this = 60
	volume = 180

/obj/item/reagent_container/hypospray/autoinjector/empty/skillless
	name = "15单位定制EZ自动注射器"
	desc = "一支定制EZ自动注射器，可能来自研究部。可使用加压试剂罐袋补充。它会立即注射全部药剂，且无需任何训练。"
	icon_state = "empty_research_oneuse"
	autoinjector_type = "autoinjector_oneuse"
	skilllock = SKILL_MEDICAL_DEFAULT
	amount_per_transfer_from_this = 15
	volume = 15
	uses_left = 0

/obj/item/reagent_container/hypospray/autoinjector/empty/skillless/unit
	name = "1单位定制EZ自动注射器"
	volume = 1
	amount_per_transfer_from_this = 1

/obj/item/reagent_container/hypospray/autoinjector/empty/skillless/verysmall
	name = "5单位定制EZ自动注射器"
	volume = 5
	amount_per_transfer_from_this = 5

/obj/item/reagent_container/hypospray/autoinjector/empty/skillless/small
	name = "10单位定制EZ自动注射器"
	volume = 10
	amount_per_transfer_from_this = 10

/obj/item/reagent_container/hypospray/autoinjector/empty/skillless/medium
	name = "30单位定制EZ自动注射器"
	volume = 30
	amount_per_transfer_from_this = 30

/obj/item/reagent_container/hypospray/autoinjector/empty/skillless/large
	name = "45单位定制EZ自动注射器"
	volume = 45
	amount_per_transfer_from_this = 45

/obj/item/reagent_container/hypospray/autoinjector/empty/skillless/extralarge
	name = "60单位定制EZ自动注射器"
	volume = 60
	amount_per_transfer_from_this = 60

/obj/item/reagent_container/hypospray/autoinjector/empty/medic
	name = "15单位试剂袋自动注射器"
	desc = "一种专门设计用于装入加压试剂罐包并从中补充的自动注射器。具有类似药瓶的锁定装置，最多可容纳6次注射。"
	skilllock = SKILL_MEDICAL_MEDIC
	volume = 90
	amount_per_transfer_from_this = 15
	autoinjector_type = "autoinjector_medic"
	icon_state = "empty_medic"
	uses_left = 0

/obj/item/reagent_container/hypospray/autoinjector/empty/medic/large
	name = "30单位试剂包自动注射器"
	volume = 180
	amount_per_transfer_from_this = 30
