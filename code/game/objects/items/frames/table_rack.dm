


/*
 * Table Parts
 */

/obj/item/frame/table
	name = "土黄色桌子部件"
	desc = "一套桌子组件，包括一块大型平坦金属面板和四条桌腿。需要自行组装。"
	gender = PLURAL
	icon = 'icons/obj/items/table_parts.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/construction_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/construction_righthand.dmi',
	)
	icon_state = "tan_table_parts"
	item_state = "tan_table_parts"
	matter = list("metal" = 7500) //A table, takes two sheets to build
	flags_atom = FPRINT|CONDUCT
	attack_verb = list("slammed", "bashed", "battered", "bludgeoned", "thrashed", "whacked")
	var/table_type = /obj/structure/surface/table //what type of table it creates when assembled

/obj/item/frame/table/attackby(obj/item/W, mob/user)

	..()
	if(HAS_TRAIT(W, TRAIT_TOOL_WRENCH))
		new /obj/item/stack/sheet/metal(user.loc)
		qdel(src)

	if(istype(W, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = W
		if(R.use(4))
			new /obj/item/frame/table/reinforced(get_turf(src))
			to_chat(user, SPAN_NOTICE("你加固了[src]。"))
			user.temp_drop_inv_item(src)
			qdel(src)
		else
			to_chat(user, SPAN_WARNING("你至少需要四根金属棒来加固[src]。"))

	if(istype(W, /obj/item/stack/sheet/wood))
		var/obj/item/stack/sheet/wood/S = W
		if(S.use(2))
			new /obj/item/frame/table/wood(get_turf(src))
			new /obj/item/stack/sheet/metal(get_turf(src))
			to_chat(user, SPAN_NOTICE("你更换了[src]的金属部件。"))
			user.temp_drop_inv_item(src)
			qdel(src)
		else
			to_chat(user, SPAN_WARNING("你至少需要两块木板来更换[src]的金属部件。"))

/obj/item/frame/table/attack_self(mob/user)
	..()

	var/obj/structure/blocker/anti_cade/AC = locate(/obj/structure/blocker/anti_cade) in usr.loc  // for M2C HMG, look at smartgun_mount.dm
	if(AC)
		to_chat(user, SPAN_WARNING("你无法在此处建造桌子！"))
		return
	var/area/area = get_area(user)
	if(!area.allow_construction)
		to_chat(user, SPAN_WARNING("[src]必须在合适的表面上组装！"))
		return
	var/turf/open/OT = user.loc
	if(!(istype(OT) && OT.allow_construction))
		to_chat(user, SPAN_WARNING("[src]必须在合适的表面上组装！"))
		return
	if(istype(get_area(loc), /area/shuttle))  //HANGAR/SHUTTLE BUILDING
		to_chat(user, SPAN_WARNING("不行。此区域是运输机所需空间。"))
		return
	for(var/obj/object in OT)
		if(object.density)
			to_chat(user, SPAN_WARNING("[object]阻挡了你建造[src]！"))
			return
	if(!do_after(user, 3 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD))
		to_chat(user, SPAN_WARNING("建造桌子时请保持静止！"))
		return

	var/obj/structure/surface/table/T = new table_type(user.loc)
	T.add_fingerprint(user)
	user.drop_held_item()
	qdel(src)

/*
 * Reinforced Table Parts
 */

/obj/item/frame/table/reinforced
	name = "加固桌部件"
	desc = "一套桌子组件，包括一块大型平坦金属面板、四条桌腿以及侧板。需要自行组装。"
	icon = 'icons/obj/items/table_parts.dmi'
	icon_state = "reinf_tableparts"
	item_state = "reinf_tableparts"
	matter = list("metal" = 15000) //A reinforced table. Two sheets of metal and four rods
	table_type = /obj/structure/surface/table/reinforced

/obj/item/frame/table/reinforced/attackby(obj/item/W, mob/user)
	if(HAS_TRAIT(W, TRAIT_TOOL_WRENCH))
		deconstruct()

/obj/item/frame/table/reinforced/deconstruct(disassembled = TRUE)
	if(disassembled)
		new /obj/item/stack/sheet/metal(get_turf(src))
		new /obj/item/stack/rods(get_turf(src))
	return ..()

/*
 * Wooden Table Parts
 */

/obj/item/frame/table/wood
	name = "木制桌子部件"
	desc = "一套桌子组件，包括一块大型平坦木质面板和四条桌腿。需要自行组装。"
	icon_state = "wood_tableparts"
	item_state = "wood_tableparts"
	flags_atom = FPRINT
	matter = null
	table_type = /obj/structure/surface/table/woodentable

/obj/item/frame/table/wood/attackby(obj/item/W, mob/user)

	if(HAS_TRAIT(W, TRAIT_TOOL_WRENCH))
		deconstruct()

	if(istype(W, /obj/item/stack/tile/carpet) && table_type == /obj/structure/surface/table/woodentable)
		var/obj/item/stack/tile/carpet/C = W
		if(C.use(1))
			to_chat(user, SPAN_NOTICE("你在[src]上铺了一层地毯。"))
			new /obj/item/frame/table/gambling(get_turf(src))
			qdel(src)

/obj/item/frame/table/wood/deconstruct(disassembled = TRUE)
	if(disassembled)
		new /obj/item/stack/sheet/wood(get_turf(src))
	return ..()

/obj/item/frame/table/wood/poor
	name = "劣质木制桌子部件"
	desc = "一套工艺粗糙的桌子组件，包括一块大型平坦木质面板和四条桌腿。需要自行组装。"
	icon_state = "pwood_tableparts"
	item_state = "pwood_tableparts"
	table_type = /obj/structure/surface/table/woodentable/poor

/obj/item/frame/table/wood/fancy
	name = "精美木制桌子部件"
	desc = "一套精制红木桌的组件，包含一块大型平整木质桌面和四条桌腿。需要自行组装。"
	icon_state = "fwood_tableparts"
	item_state = "fwood_tableparts"
	table_type = /obj/structure/surface/table/woodentable/fancy

/*
 * Gambling Table Parts
 */

/obj/item/frame/table/gambling
	name = "赌桌组件"
	desc = "一套桌子的组件，包含一块大型平整的木质与地毯表面以及四条桌腿。需要自行组装。"
	icon_state = "gamble_tableparts"
	item_state = "gamble_tableparts"
	flags_atom = null
	matter = null
	table_type = /obj/structure/surface/table/gamblingtable

/obj/item/frame/table/gambling/attackby(obj/item/W as obj, mob/user as mob)

	if(HAS_TRAIT(W, TRAIT_TOOL_WRENCH))
		deconstruct()
	if(HAS_TRAIT(W, TRAIT_TOOL_CROWBAR))
		to_chat(user, SPAN_NOTICE("你从[src]中撬出了地毯。"))
		new /obj/item/stack/tile/carpet(get_turf(src))
		new /obj/item/frame/table/wood(get_turf(src))
		qdel(src)

/obj/item/frame/table/gambling/deconstruct(disassembled = TRUE)
	if(disassembled)
		new /obj/item/stack/sheet/wood(get_turf(src))
		new /obj/item/stack/tile/carpet(get_turf(src))
	return ..()

/*
 * Almayer Tables
 */
/obj/item/frame/table/almayer
	name = "灰色桌子组件"
	icon_state = "table_parts"
	item_state = "table_parts"
	table_type = /obj/structure/surface/table/almayer

/*
 * Rack Parts
 */

/obj/item/frame/rack
	name = "机架部件"
	gender = PLURAL
	desc = "一套带有多层金属搁板的储物架组件。相对廉价，适合大规模存储。需要自行组装。"
	icon = 'icons/obj/items/table_parts.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/construction_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/construction_righthand.dmi',
	)
	icon_state = "rack_parts"
	flags_atom = FPRINT|CONDUCT
	matter = list("metal" = 3750) //A big storage shelf, takes five sheets to build

/obj/item/frame/rack/attackby(obj/item/W, mob/user)
	..()
	if(HAS_TRAIT(W, TRAIT_TOOL_WRENCH))
		new /obj/item/stack/sheet/metal(get_turf(src))
		qdel(src)

/obj/item/frame/rack/attack_self(mob/user)
	..()
	var/area/area = get_area(user)
	if(!area.allow_construction)
		to_chat(user, SPAN_WARNING("[src]必须在合适的表面上组装！"))
		return
	var/turf/open/OT = user.loc
	if(!(istype(OT) && OT.allow_construction))
		to_chat(user, SPAN_WARNING("[src]必须在合适的表面上组装！"))
		return

	if(istype(get_area(loc), /area/shuttle))  //HANGAR/SHUTTLE BUILDING
		to_chat(user, SPAN_WARNING("不行。此区域是运输机所需空间。"))
		return

	if(locate(/obj/structure/surface/table) in user.loc || locate(/obj/structure/barricade) in user.loc)
		to_chat(user, SPAN_WARNING("此处已有结构。"))
		return

	if(locate(/obj/structure/surface/rack) in user.loc)
		to_chat(user, SPAN_WARNING("此处已有一个架子。"))
		return

	var/obj/structure/surface/rack/R = new /obj/structure/surface/rack(user.loc)
	R.add_fingerprint(user)
	user.drop_held_item()
	qdel(src)
