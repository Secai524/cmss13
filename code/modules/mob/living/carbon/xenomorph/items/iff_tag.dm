/obj/item/iff_tag
	name = "异形敌我识别标签"
	desc = "一个包含小型敌我识别计算机的标签，可植入异形的甲壳中。你可以使用权限调节器修改其敌我识别组，如果已经植入，也可以直接在异形身上操作。"
	icon = 'icons/obj/items/Marine_Research.dmi'
	icon_state = "xeno_tag"
	var/list/faction_groups = list()

/obj/item/iff_tag/attack(mob/living/carbon/xenomorph/xeno, mob/living/carbon/human/injector)
	if(isxeno(xeno))
		if(xeno.stat == DEAD)
			to_chat(injector, SPAN_WARNING("\The [xeno] is dead..."))
			return
		if(xeno.iff_tag)
			to_chat(injector, SPAN_WARNING("\The [xeno] already has a tag inside it."))
			return
		injector.visible_message(SPAN_NOTICE("[injector]开始将\the [src]强行注入[xeno]的甲壳..."), SPAN_NOTICE("You start forcing \the [src] into [xeno]'s carapace..."))
		if(!do_after(injector, 5 SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC, xeno, INTERRUPT_DIFF_LOC, BUSY_ICON_GENERIC))
			return
		injector.visible_message(SPAN_NOTICE("[injector]将\the [src]强行注入[xeno]的甲壳！"), SPAN_NOTICE("You force \the [src] into [xeno]'s carapace!"))
		xeno.iff_tag = src
		injector.drop_inv_item_to_loc(src, xeno)
		if(xeno.hive.hivenumber == XENO_HIVE_RENEGADE) //it's important to know their IFF settings for renegade
			to_chat(xeno, SPAN_NOTICE("随着设备植入你的甲壳，你的本能发生了变化，驱使你去保护[english_list(faction_groups, "no one")]."))
		return
	return ..()

/obj/item/iff_tag/attackby(obj/item/W, mob/user)
	if(HAS_TRAIT(W, TRAIT_TOOL_MULTITOOL) && ishuman(user))
		handle_reprogramming(user)
		return
	return ..()

/obj/item/iff_tag/proc/handle_reprogramming(mob/living/carbon/human/programmer, mob/living/carbon/xenomorph/xeno)
	var/list/id_faction_groups = programmer.get_id_faction_group()
	var/option = tgui_alert(programmer, "异形标签当前的敌我识别组显示为：[english_list(faction_groups, "无")]\nYour ID's IFF group reads as: [english_list(id_faction_groups, "无")]", "Xenomorph IFF Tag", list("Overwrite", "Add", "Remove"))
	if(!option)
		return FALSE
	if(xeno)
		if(!xeno.iff_tag)
			to_chat(programmer, SPAN_WARNING("\The [src]'s tag got removed while you were reprogramming it!"))
			return FALSE
		if(!programmer.Adjacent(xeno))
			to_chat(programmer, SPAN_WARNING("你需要靠近异形才能重新编程标签！"))
			return FALSE
	switch(option)
		if("Overwrite")
			faction_groups = id_faction_groups
		if("Add")
			faction_groups |= id_faction_groups
		if("Remove")
			faction_groups = list()
	to_chat(programmer, SPAN_NOTICE("你<b>[option]</b>了敌我识别组数据，标签上的敌我识别组现在显示为：[english_list(faction_groups, "无")]."))
	if(xeno?.hive.hivenumber == XENO_HIVE_RENEGADE) //it's important to know their IFF settings for renegade
		to_chat(xeno, SPAN_NOTICE("你的本能已经改变，你似乎被驱使去保护[english_list(faction_groups, "no one")]."))
	return TRUE

/obj/item/iff_tag/pmc_handler
	faction_groups = FACTION_LIST_MARINE_WY


/obj/item/storage/xeno_tag_case
	name = "异形标签储存箱"
	desc = "一个坚固的箱子，用于储存并为异形敌我识别标签充电。由维兰德-汤谷研究与数据(TM)部门提供。"
	icon = 'icons/obj/items/Marine_Research.dmi'
	icon_state = "tag_box"
	use_sound = "toolbox"
	storage_slots = 8
	can_hold = list(
		/obj/item/iff_tag,
		/obj/item/device/multitool,
	)
	black_market_value = 25

/obj/item/storage/xeno_tag_case/full/fill_preset_inventory()
	for(var/i = 1 to storage_slots - 1)
		new /obj/item/iff_tag(src)
	new /obj/item/device/multitool(src)
