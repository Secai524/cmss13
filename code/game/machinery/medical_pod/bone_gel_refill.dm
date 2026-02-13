/obj/structure/machinery/gel_refiller
	name = "骨仿生晶格制造机"
	desc = "常被那些无法念出其全名的人称为骨凝胶补充机，这台机器合成并储存骨凝胶以供后续使用。前面的插槽允许你插入骨凝胶瓶进行补充。"
	desc_lore = "In an attempt to prevent counterfeit bottles of bone gel not created by Weyland-Yutani, also known as a regular bottle, from being refilled, there is a chip reader in the fabricator and a chip in each bottle to make sure it is genuine. However, due to a combination of quality issues and being unmaintainable from proprietary parts, the machine often has problems. One such problem is in the chip reader, resulting in the fabricator being unable to detect a bottle directly on it, and such fails to activate, resulting in a person having to stand there and manually hold a bottle at the correct height to fill it."
	icon_state = "bone_gel_vendor"
	icon = 'icons/obj/structures/machinery/vending.dmi'
	density = TRUE

/obj/structure/machinery/gel_refiller/attackby(obj/item/attacking_item, mob/user)
	if(!istype(attacking_item, /obj/item/tool/surgery/bonegel))
		return ..()
	var/obj/item/tool/surgery/bonegel/gel = attacking_item
	gel.refill_gel(src, user)
