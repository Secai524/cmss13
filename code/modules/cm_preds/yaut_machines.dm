/obj/structure/machinery/prop/almayer/CICmap/yautja
	name = "猎手球体"
	desc = "由猎手设计的球体，用于显示猎物在整个猎场中的位置。"
	icon = 'icons/obj/structures/machinery/yautja_machines.dmi'
	icon_state = "globe"
	breakable = FALSE
	minimap_flag = MINIMAP_FLAG_ALL
	drawing = FALSE

/obj/structure/machinery/autolathe/yautja
	name = "铁血战士自动制造机"
	desc = "它使用金属和玻璃生产物品。"
	icon = 'icons/obj/structures/machinery/yautja_machines.dmi'
	stored_material =  list("metal" = 40000, "glass" = 20000)
	breakable = FALSE

/obj/structure/machinery/prop/yautja/bubbler
	name = "铁血战士熔炉"
	desc = "一台发出不祥嗡鸣的大型黑色机器，附有一个沸腾液体的锅。可以看到里面漂浮着似乎是残留的油脂和毛发团。"
	icon = 'icons/obj/structures/machinery/yautja_machines.dmi'
	icon_state = "vat"
	density = TRUE
	breakable = FALSE

/obj/structure/machinery/prop/yautja/bubbler/get_examine_text(mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		. += SPAN_NOTICE("You can use this machine to clean the skin off limbs, and turn them into bones for your armor.")
		. += SPAN_NOTICE("You first need to find a limb. Then you use a ceremonial dagger to prepare it.")
		. += SPAN_NOTICE("After preparing the limb, you put it into the cauldron, removing the flesh, leaving you with a bone.")
		. += SPAN_NOTICE("You will then clean and polish the resulting bones with a polishing rag, making it ready to be attached to your armor.")

/obj/structure/machinery/prop/yautja/bubbler/attackby(obj/potential_limb, mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		to_chat(user, SPAN_NOTICE("你完全不知道这东西是干什么用的，而且你觉得现在不是弄清楚的时候。"))
		return

	if(user.action_busy)
		return

	if(!istype(potential_limb, /obj/item/limb))
		to_chat(user, SPAN_NOTICE("你无法将此物放入[src]。"))
		return
	var/obj/item/limb/current_limb = potential_limb

	if(!current_limb.flayed)
		to_chat(user, SPAN_NOTICE("此肢体尚未就绪。"))
		return
	icon_state = "vat_boiling"
	to_chat(user, SPAN_WARNING("你将[current_limb]放入并启动了熔炉。"))
	if(!do_after(user, 15 SECONDS, INTERRUPT_NONE, BUSY_ICON_HOSTILE, current_limb))
		to_chat(user, SPAN_NOTICE("你将[current_limb]从熔炉中拉了出来。"))
		icon_state = initial(icon_state)
		return
	icon_state = initial(icon_state)

	var/obj/item/clothing/accessory/limb/skeleton/new_bone = new current_limb.bone_type(get_turf(src))
	if(istype(new_bone, /obj/item/clothing/accessory/limb/skeleton/head))
		new_bone.desc = SPAN_NOTICE("This skull used to be [current_limb.name].")
	qdel(current_limb)
