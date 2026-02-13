
/obj/item/storage/pouch/stimulant_injector
	name = "兴奋剂包"
	desc = "一个装有兴奋剂注射器的包。"
	icon = 'icons/obj/items/clothing/pouches.dmi'
	icon_state = "stimulant"
	w_class = SIZE_LARGE //does not fit in backpack
	max_w_class = SIZE_SMALL
	flags_equip_slot = SLOT_STORE
	storage_slots = 3
	storage_flags = STORAGE_FLAGS_POUCH
	can_hold = list(/obj/item/reagent_container/hypospray/autoinjector/stimulant)
	var/stimulant_type

/obj/item/storage/pouch/stimulant_injector/fill_preset_inventory()
	if(!stimulant_type)
		return

	for(var/i in 1 to storage_slots)
		new stimulant_type(src)

/obj/item/storage/pouch/stimulant_injector/speed
	desc = "一个装有速度兴奋剂注射器的包。"
	stimulant_type = /obj/item/reagent_container/hypospray/autoinjector/stimulant/speed_stimulant

/obj/item/storage/pouch/stimulant_injector/brain
	stimulant_type = /obj/item/reagent_container/hypospray/autoinjector/stimulant/brain_stimulant
	desc = "一个装有脑部兴奋剂注射器的包。"

/obj/item/storage/pouch/stimulant_injector/redemption
	desc = "一个装有救赎兴奋剂注射器的包。"
	storage_slots = 1
	stimulant_type = /obj/item/reagent_container/hypospray/autoinjector/stimulant/redemption_stimulant

/obj/item/reagent_container/hypospray/autoinjector/stimulant
	icon_state = "stimpack"
	// 5 minutes per injection
	amount_per_transfer_from_this = 5
	// maximum of 15 minutes per injector, has an OD of 15
	volume = 5
	uses_left = 1
	display_maptext = TRUE

/obj/item/reagent_container/hypospray/autoinjector/stimulant/update_icon()
	overlays.Cut()
	if(!uses_left)
		icon_state = "stimpack0"
		return

	icon_state = "stimpack"
	var/datum/reagent/R = GLOB.chemical_reagents_list[chemname]

	if(!R)
		return
	var/image/I = image(icon, src, icon_state="+stimpack_custom")
	I.color = R.color
	overlays += I

/obj/item/reagent_container/hypospray/autoinjector/stimulant/speed_stimulant
	name = "速度兴奋剂自动注射器"
	chemname = "speed_stimulant"
	desc = "一支装有实验性性能增强兴奋剂的兴奋剂。对肌肉有极强的刺激作用。持续5分钟。"
	maptext_label = "StSp"

/obj/item/reagent_container/hypospray/autoinjector/stimulant/brain_stimulant
	name = "脑部兴奋剂注射器"
	chemname = "brain_stimulant"
	desc = "一支装有实验性中枢神经系统兴奋剂的兴奋剂。对神经有极强的刺激作用。持续5分钟。"
	maptext_label = "StBr"

/obj/item/reagent_container/hypospray/autoinjector/stimulant/redemption_stimulant
	amount_per_transfer_from_this = 5
	volume = 5
	name = "救赎兴奋剂自动注射器"
	chemname = "redemption_stimulant"
	desc = "一支装有实验性骨骼、器官和肌肉兴奋剂的兴奋剂。显著提高人类在倒下前所能承受的伤害。持续5分钟。"
	maptext_label = "StRe"
