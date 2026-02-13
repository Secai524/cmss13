




/////////////////////// Hand Labeler ////////////////////////////////


/// meant for use with qdelling/newing things to transfer labels between them
/atom/proc/transfer_label_component(atom/target)
	var/datum/component/label/src_label_component = GetComponent(/datum/component/label)
	if(src_label_component)
		var/target_label_text = src_label_component.label_name
		target.AddComponent(/datum/component/label, target_label_text)

/obj/item/tool/hand_labeler
	name = "手持标签机"
	icon = 'icons/obj/items/paper.dmi'
	icon_state = "labeler0"
	item_state = "flight"
	var/label = null
	var/labels_left = 50
	/// off or on.
	var/mode = 0
	var/label_sound = 'sound/items/component_pickup.ogg'
	var/remove_label_sound = 'sound/items/paper_ripped.ogg'

	matter = list("metal" = 125)

/obj/item/tool/hand_labeler/afterattack(atom/A, mob/user as mob, proximity)
	if(!proximity)
		return

	if(!mode) //if it's off, give up.
		to_chat(user, SPAN_WARNING("\The [src] isn't on."))
		return

	if(A == loc) // if placing the labeller into something (e.g. backpack)
		return // don't set a label

	if(!labels_left)
		to_chat(user, SPAN_WARNING("没有标签了。"))
		return
	if(length(A.name) + length(label) > 64)
		to_chat(user, SPAN_WARNING("标签太大。"))
		return
	if(isliving(A) || istype(A, /obj/item/holder))
		to_chat(user, SPAN_WARNING("你不能给活物贴标签。"))
		return
	if((istype(A, /obj/item/reagent_container/glass)) && (!(istype(A, /obj/item/reagent_container/glass/minitank))))
		to_chat(user, SPAN_WARNING("标签无法粘在[A]上。请改用笔。"))
		return
	if(istype(A, /obj/item/tool/surgery) || istype(A, /obj/item/reagent_container/pill))
		to_chat(user, SPAN_WARNING("那样不卫生。"))
		return
	//disallow naming structures and vehicles, but not crates!
	if(istype(A, /obj/vehicle/multitile) || (istype(A, /obj/structure) && !istype(A, /obj/structure/closet/crate) && !istype(A, /obj/structure/closet/coffin/woodencrate)))
		to_chat(user, SPAN_WARNING("标签粘不上去。"))
		return
	if(isturf(A))
		to_chat(user, SPAN_WARNING("标签粘不上去。"))
		return
	if(istype(A, /obj/item/storage/pill_bottle))
		var/obj/item/storage/pill_bottle/target_pill_bottle = A
		target_pill_bottle.choose_color(user)

	if(!label || !length(label))
		remove_label(A, user)
		return

	var/datum/component/label/labelcomponent = A.GetComponent(/datum/component/label)
	if(labelcomponent && labelcomponent.has_label())
		if(labelcomponent.label_name == label)
			to_chat(user, SPAN_WARNING("标签上已经写着\"[label]\"."))
			return

	user.visible_message(SPAN_NOTICE("[user]将[A]标记为\"[label]\"."),
	SPAN_NOTICE("You label [A] as \"[label]\"."))

	log_admin("[user] has labeled [A.name] with label \"[label]\". (CKEY: ([user.ckey]))")

	A.AddComponent(/datum/component/label, label)

	playsound(A, label_sound, 20, TRUE)

	labels_left--

/obj/item/tool/hand_labeler/attack_self(mob/user)
	..()
	mode = !mode
	icon_state = "labeler[mode]"
	if(mode)
		to_chat(user, SPAN_NOTICE("你打开了[src]。"))
		//Now let them choose the text.
		var/str = copytext(reject_bad_text(tgui_input_text(user, "标签文本？", "Set label", "", MAX_NAME_LEN, ui_state=GLOB.not_incapacitated_state)), 1, MAX_NAME_LEN)
		if(!str || !length(str))
			to_chat(user, SPAN_NOTICE("标签文本已清除。你现在可以移除标签了。"))
			label = null
			return
		label = str
		to_chat(user, SPAN_NOTICE("你将文本设置为‘[str]’。"))
		return

	to_chat(user, SPAN_NOTICE("你关闭了[src]。"))
	return

/*
	Allow the user of the labeler to remove a label, if there is no text set
	@A object trying to remove the label
	@user the player using the labeler

*/

/obj/item/tool/hand_labeler/proc/remove_label(atom/target, mob/user)
	var/datum/component/label/label = target.GetComponent(/datum/component/label)
	if(label && label.has_label())
		user.visible_message(SPAN_NOTICE("[user]移除了[target]上的标签。"),
						SPAN_NOTICE("You remove the label from [target]."))
		log_admin("[key_name(usr)] has removed label from [target].")
		label.clear_label()
		playsound(target, remove_label_sound, 20, TRUE)
		return

	to_chat(user, SPAN_NOTICE("没有可移除的标签。"))
	return

/**
	Allow the user to refill the labeller
	@I what is the item trying to be used
	@user what is using paper on the handler
*/

/obj/item/tool/hand_labeler/attackby(obj/item/I, mob/user)
	. = ..()
	if(istype(I, /obj/item/paper))
		if(labels_left != initial(labels_left))
			to_chat(user, SPAN_NOTICE("你将[I]插入[src]。"))
			qdel(I) //delete the paper item
			labels_left = initial(labels_left)
		else
			to_chat(user, SPAN_NOTICE("[src]已经满了。"))

/*
	Instead of updating labels_left to user every label used,
	Have the user examine it to show them.
*/
/obj/item/tool/hand_labeler/get_examine_text(mob/user)
	. = ..()
	. += SPAN_NOTICE("It has [labels_left] out of [initial(labels_left)] labels left.")
	. += SPAN_HELPFUL("Use paper to refill it.")


/*
 * Pens
 */
/obj/item/tool/pen
	desc = "这是一支普通的黑色墨水笔。"
	name = "pen"
	icon = 'icons/obj/items/paper.dmi'
	icon_state = "pen"
	item_state = "pen"
	item_state_slots = list(WEAR_AS_GARB = "pen_black")
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/paperwork_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/paperwork_righthand.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/misc.dmi',
	)
	flags_equip_slot = SLOT_WAIST|SLOT_EAR|SLOT_SUIT_STORE
	throwforce = 0
	w_class = SIZE_TINY
	throw_speed = SPEED_VERY_FAST
	throw_range = 15
	matter = list("metal" = 10)
	inherent_traits = list(TRAIT_TOOL_PEN)
	/// what color the ink is!
	var/pen_color = "black"
	var/on = TRUE
	var/clicky = FALSE

/obj/item/tool/pen/attack_self(mob/living/carbon/human/user)
	..()
	on = !on
	to_chat(user, SPAN_WARNING("你咔哒一声[on ? "按出" : "收回"]了笔尖。"))
	if(clicky)
		playsound(user.loc, "sound/items/pen_click_[on? "on": "off"].ogg", 100, 1, 5)
	update_pen_state()

/obj/item/tool/pen/Initialize(mapload, ...)
	. = ..()
	update_pen_state()

/obj/item/tool/pen/proc/update_pen_state()
	overlays.Cut()
	if(on)
		overlays += "+[pen_color]_tip"

/obj/item/tool/pen/attack(mob/living/target, mob/living/user)
	if(!ismob(target))
		return
	to_chat(user, SPAN_WARNING("你用笔刺向[target]。"))
	target.last_damage_data = create_cause_data(initial(name), user)
	target.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been stabbed with [name] by [key_name(user)]</font>")
	user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [name] to stab [key_name(target)]</font>")
	msg_admin_attack("[key_name(user)] Used the [name] to stab [key_name(target)] in [get_area(user)] ([user.loc.x],[user.loc.y],[user.loc.z]).", user.loc.x, user.loc.y, user.loc.z)
	return

/obj/item/tool/pen/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!isobj(target))
		return
	var/obj/obj_target = target
	//Changing name/description of items. Only works if they have the OBJ_UNIQUE_RENAME object flag set
	if(proximity_flag && (obj_target.flags_obj & OBJ_UNIQUE_RENAME))
		var/penchoice = tgui_input_list(user, "你想编辑什么？", "Pen Setting", list("Rename", "Description", "Reset"))
		if(QDELETED(target) || !CAN_PICKUP(user, obj_target))
			return
		if(penchoice == "Rename")
			var/input = tgui_input_text(user, "你想将[target]命名为什么？", "Object Name", "[target.name]", MAX_NAME_LEN)
			var/oldname = target.name
			if(QDELETED(target) || !CAN_PICKUP(user, obj_target))
				return
			if(input == oldname || !input)
				to_chat(user, SPAN_NOTICE("你将[target]改成了……呃……[target]。"))
			else
				msg_admin_niche("[key_name(usr)] changed [src]'s name to [input] [ADMIN_JMP(src)]")
				target.AddComponent(/datum/component/rename, input, target.desc)
				var/datum/component/label/label = target.GetComponent(/datum/component/label)
				if(label)
					label.clear_label()
					label.apply_label()
				to_chat(user, SPAN_NOTICE("你已成功将[oldname]重命名为[target]。"))
				obj_target.renamedByPlayer = TRUE
				playsound(target, "paper_writing", 15, TRUE)

		if(penchoice == "Description")
			var/input = tgui_input_text(user, "描述[target]", "Description", "[target.desc]", 140)
			var/olddesc = target.desc
			if(QDELETED(target) || !CAN_PICKUP(user, obj_target))
				return
			if(input == olddesc || !input)
				to_chat(user, SPAN_NOTICE("你决定不更改[target]的描述。"))
			else
				msg_admin_niche("[key_name(usr)] changed \the [src]'s description to [input] [ADMIN_JMP(src)]")
				target.AddComponent(/datum/component/rename, target.name, input)
				to_chat(user, SPAN_NOTICE("你已成功更改[target]的描述。"))
				obj_target.renamedByPlayer = TRUE
				playsound(target, "paper_writing", 15, TRUE)

		if(penchoice == "Reset")
			if(QDELETED(target) || !CAN_PICKUP(user, obj_target))
				return

			qdel(target.GetComponent(/datum/component/rename))

			//reapply any label to name
			var/datum/component/label/label = target.GetComponent(/datum/component/label)
			if(label)
				label.clear_label()
				label.apply_label()

			to_chat(user, SPAN_NOTICE("你已成功重置[target]的名称和描述。"))
			obj_target.renamedByPlayer = FALSE

/obj/item/tool/pen/clicky
	desc = "这是一支维兰德品牌、按动感十足的黑色墨水笔。"
	name = "维兰德笔"
	clicky = TRUE

/obj/item/tool/pen/clicky/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/tool/pen/blue
	desc = "这是一支普通的蓝色墨水笔。"
	item_state_slots = list(WEAR_AS_GARB = "pen_blue")
	pen_color = "blue"

/obj/item/tool/pen/blue/clicky
	desc = "这是一支维兰德品牌、按动感十足的蓝色墨水笔。"
	name = "维兰德蓝色笔"
	clicky = TRUE

/obj/item/tool/pen/red
	desc = "这是一支普通的红色墨水笔。"
	item_state_slots = list(WEAR_AS_GARB = "pen_red")
	pen_color = "red"

/obj/item/tool/pen/red/clicky
	desc = "这是一支维兰德品牌、按动感十足的红色墨水笔。"
	name = "维兰德红色笔"
	clicky = TRUE

/obj/item/tool/pen/green
	desc = "这是一支普通的绿色墨水笔。"
	pen_color = "green"

/obj/item/tool/pen/green/clicky
	desc = "这是一支维兰德品牌、按动感十足的绿色墨水笔。"
	name = "维兰德绿色笔"
	clicky = TRUE

/obj/item/tool/pen/white
	desc = "这是一支稀有的白色墨水笔。"
	pen_color = "white"

/obj/item/tool/pen/white/clicky
	desc = "这是一支维兰德品牌、按压感极强的白色墨水笔。"
	name = "维兰德白色笔"
	clicky = TRUE

/obj/item/tool/pen/multicolor
	name = "多色笔"
	desc = "一支可以切换颜色的笔！"
	var/list/colour_list = list("red", "blue", "black")
	var/current_colour_index = 1

/obj/item/tool/pen/multicolor/attack_self(mob/living/carbon/human/user)
	if(!on)
		return ..()

	current_colour_index = (current_colour_index % length(colour_list)) + 1
	pen_color = colour_list[current_colour_index]
	balloon_alert(user, "已切换为[pen_color]")
	to_chat(user, SPAN_NOTICE("你转动笔身，将墨水颜色切换为[pen_color]。"))
	if(clicky)
		playsound(user.loc, 'sound/items/pen_click_on.ogg', 100, 1, 5)
	update_pen_state()

/obj/item/tool/pen/multicolor/fountain
	desc = "这支钢笔是阿玛特精湛工艺的奢华证明，堪称设计与功能的典范。饰以金色点缀和精密的机械结构，只需轻轻一扭，即可在众多墨水颜色间快速切换。作为精密工程的产物，笔内的每个机械装置都旨在提供无缝、毫不费力的颜色转换，造就了一件兼具奢华与多功能的工具。"
	desc_lore = "More than just a tool for writing, Armat's fountain pen is a symbol of distinction and authority within the ranks of the United States Colonial Marine Corps (USCM). It is a legacy item, exclusively handed out to the top-tier command personnel, each pen a tribute to the recipient's leadership and dedication.\n \nArmat, renowned for their weapons technology, took a different approach in crafting this piece. The fountain pen, though seemingly a departure from their usual field, is deeply ingrained with the company's engineering philosophy, embodying precision, functionality, and robustness.\n \nThe golden accents are not mere embellishments; they're an identifier, setting apart these pens and their owners from the rest. The gold is meticulously alloyed with a durable metallic substance, granting it resilience to daily wear and tear. Such resilience is symbolic of the tenacity and perseverance required of USCM command personnel.\n \nEach pen is equipped with an intricate color changing mechanism, allowing the user to switch between various ink colors. This feature, inspired by the advanced targeting systems of Armat's weaponry, uses miniaturized actuators and precision-ground components to smoothly transition the ink flow. A simple twist of the pen's body activates the change, rotating the internal ink cartridges into place with mechanical grace, ready for the user's command.\n \nThe ink colors are not chosen arbitrarily. Each represents a different echelon within the USCM, allowing the pen's owner to write in the hue that corresponds with their rank or the rank of the recipient of their written orders. This acts as a silent testament to the authority of their words, as if each stroke of the pen echoes through the halls of USCM authority.\n \nDespite its ornate appearance, the pen is as robust as any Armat weapon, reflecting the company's commitment to reliability and durability. The metal components are corrosion-resistant, ensuring the pen's longevity, even under the challenging conditions often faced by USCM high command.\n \nThe fusion of luxury and utility, the blend of gold and metal, is an embodiment of the hard-won elegance of command, of the fusion between power and grace. It's more than a writing instrument - it's an emblem of leadership, an accolade to the dedication and strength of those who bear it. Armat's fountain pen stands as a monument to the precision, integrity, and courage embodied by the USCM's highest-ranking officers."
	name = "钢笔"
	icon_state = "fountain_pen"
	item_state = "fountain_pen"
	item_state_slots = list(WEAR_AS_GARB = "fountain_pen")
	matter = list("metal" = 20, "gold" = 10)
	colour_list = list("red", "blue", "green", "yellow", "purple", "pink", "brown", "black", "orange") // Can add more colors as required
	var/owner_name

/obj/item/tool/pen/multicolor/fountain/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/tool/pen/multicolor/fountain/pickup(mob/user, silent)
	. = ..()
	if(!owner_name)
		RegisterSignal(user, COMSIG_POST_SPAWN_UPDATE, PROC_REF(set_owner), override = TRUE)

///Sets the owner of the pen to who it spawns with, requires var/source for signals
/obj/item/tool/pen/multicolor/fountain/proc/set_owner(datum/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, COMSIG_POST_SPAWN_UPDATE)
	var/mob/living/carbon/human/user = source
	owner_name = user.name

/obj/item/tool/pen/multicolor/fountain/get_examine_text(mob/user)
	. = ..()
	if(owner_name)
		. += "There's a laser engraving of [owner_name] on it."

/obj/item/tool/pen/multicolor/provost
	name = "宪兵长钢笔"
	desc = "一支流线型的黑色外壳钢笔，侧面刻有宪兵长办公室徽记。它可以根据宪兵长和宪兵部门的各种职能需要变换颜色。"
	icon_state = "provost_pen"
	colour_list = list("blue", "green", "black", "orange", "red", "white")

/*
 * Antag pens
 */
/obj/item/tool/pen/sleepypen
	desc = "这是一支笔尖锋利、带有精心雕刻的黑色墨水笔。\"Waffle Co.\""
	flags_atom = FPRINT|OPENCONTAINER
	flags_equip_slot = SLOT_WAIST

/obj/item/tool/pen/sleepypen/Initialize()
	. = ..()
	create_reagents(30)
	reagents.add_reagent("chloralhydrate", 15)

/obj/item/tool/pen/sleepypen/attack(mob/M as mob, mob/user as mob)
	if(!(istype(M,/mob)))
		return
	..()
	if(reagents.total_volume)
		if(M.reagents)
			reagents.trans_to(M, 50)
	return

/obj/item/tool/pen/paralysis
	flags_atom = FPRINT|OPENCONTAINER
	flags_equip_slot = SLOT_WAIST

/obj/item/tool/pen/paralysis/attack(mob/living/M as mob, mob/user as mob)
	if(!(istype(M)))
		return
	..()
	if(M.can_inject(user, TRUE))
		if(reagents.total_volume)
			if(M.reagents)
				reagents.trans_to(M, 50)

/obj/item/tool/pen/paralysis/Initialize()
	. = ..()
	create_reagents(50)
	reagents.add_reagent("zombiepowder", 10)
	reagents.add_reagent("cryptobiolin", 15)

/*
 * Stamps
 */
/obj/item/tool/stamp
	name = "橡皮图章"
	desc = "一个用于在重要文件上盖章的橡皮图章。"
	icon = 'icons/obj/items/paper.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/paperwork_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/paperwork_righthand.dmi'
	)
	icon_state = "stamp-def"
	item_state = "stamp"
	throwforce = 0
	w_class = SIZE_TINY
	throw_speed = SPEED_VERY_FAST
	throw_range = 15
	matter = list("metal" = 60)
	attack_verb = list("stamped")

/obj/item/tool/stamp/captain
	name = "上尉的橡皮图章"
	icon_state = "stamp-cap"

/obj/item/tool/stamp/hop
	name = "人事主管的橡皮图章"
	icon_state = "stamp-hop"

/obj/item/tool/stamp/hos
	name = "安保主管的橡皮图章"
	icon_state = "stamp-hos"

/obj/item/tool/stamp/ce
	name = "总工程师的橡皮图章"
	icon_state = "stamp-ce"

/obj/item/tool/stamp/rd
	name = "研究主管的橡皮图章"
	icon_state = "stamp-rd"

/obj/item/tool/stamp/cmo
	name = "首席医疗官的橡皮图章"
	icon_state = "stamp-cmo"

/obj/item/tool/stamp/denied
	name = "\improper DENIED rubber stamp"
	icon_state = "stamp-deny"

/obj/item/tool/stamp/approved
	name = "\improper APPROVED rubber stamp"
	icon_state = "stamp-approve"

/obj/item/tool/stamp/clown
	name = "小丑的橡皮图章"
	icon_state = "stamp-clown"

/obj/item/tool/stamp/internalaffairs
	name = "内部事务橡皮图章"
	icon_state = "stamp-intaff"

/obj/item/tool/stamp/weyyu
	name = "维兰德橡皮图章"
	icon_state = "stamp-weyyu"

/obj/item/tool/stamp/uscm
	name = "USCM橡皮图章"
	icon_state = "stamp-uscm"

/obj/item/tool/stamp/cmb
	name = "CMB橡皮图章"
	icon_state = "stamp-cmb"

/obj/item/tool/stamp/ro
	name = "军需官的橡皮图章"
	icon_state = "stamp-ro"

/obj/item/tool/carpenters_hammer //doesn't do anything, yet
	name = "木工锤"
	icon_state = "carpenters_hammer" //yay, it now has a sprite.
	item_state = "carpenters_hammer"
	desc = "可用于将钉子敲入木制物体以进行修复。"
