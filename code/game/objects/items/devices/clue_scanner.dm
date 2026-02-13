/obj/item/device/clue_scanner
	name = "法证扫描仪"
	desc = "一种用于采集指纹的现代手持扫描仪。采集指纹后，必须在安保记录终端上进行分析。"
	icon_state = "forensic1"
	w_class = SIZE_MEDIUM
	item_state = "electronic"
	flags_atom = FPRINT|CONDUCT
	flags_item = NOBLUDGEON
	flags_equip_slot = SLOT_WAIST

	var/list/print_list
	var/scanning = FALSE
	var/newlyfound

/obj/item/device/clue_scanner/get_examine_text(mob/user)
	. = ..()
	. += SPAN_INFO("Print sets stored: [length(print_list)]")

/obj/item/device/clue_scanner/update_icon()
	overlays.Cut()

	if(scanning)
		overlays += "+scanning"

	if(print_list)
		overlays += "+prints"

/obj/item/device/clue_scanner/attack_self(mob/user)
	. = ..()

	if(!skillcheck(user, SKILL_POLICE, SKILL_POLICE_SKILLED))
		to_chat(user, SPAN_WARNING("你似乎不知道如何使用 [src]..."))
		return

	scanning = TRUE
	update_icon()
	user.visible_message(SPAN_NOTICE("[user]开始扫描周围环境以寻找指纹..."), SPAN_NOTICE("You scan the surroundings for prints..."))
	if(!do_after(user, 50, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		scanning = FALSE
		update_icon()
		return
	scanning = FALSE

	newlyfound = 0
	for(var/obj/effect/decal/prints/P in range(2))
		newlyfound++
		LAZYADD(print_list, P)
		P.moveToNullspace()

	update_icon()

	if(!newlyfound)
		to_chat(user, SPAN_INFO("未发现新的指纹组！"))
	else
		to_chat(user, SPAN_INFO("发现新打印蓝图：[newlyfound]，蓝图库总数：[length(print_list)]"))
