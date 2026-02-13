/obj/item/stack/rods
	name = "金属杆"
	desc = "一些金属杆。可用于建造或其他用途。"
	singular_name = "金属杆"
	icon_state = "rods"
	icon = 'icons/obj/items/stacks.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/material_stacks_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/material_stacks_righthand.dmi',
	)
	flags_atom = FPRINT|CONDUCT
	w_class = SIZE_SMALL
	force = 9
	throwforce = 15
	throw_speed = SPEED_VERY_FAST
	throw_range = 20
	matter = list("metal" = 1875)
	max_amount = 60
	attack_verb = list("hit", "bludgeoned", "whacked")
	stack_id = "金属杆"
	garbage = TRUE
	var/sheet_path = /obj/item/stack/sheet/metal
	var/used_per_sheet = 4

/obj/item/stack/rods/Initialize(mapload, ...)
	. = ..()
	recipes = GLOB.rod_recipes

/obj/item/stack/rods/attackby(obj/item/W as obj, mob/user as mob)
	if (!iswelder(W))
		return ..()

	if(!HAS_TRAIT(W, TRAIT_TOOL_BLOWTORCH))
		to_chat(user, SPAN_WARNING("你需要一把更强的喷枪！"))
		return

	var/obj/item/tool/weldingtool/WT = W

	if(amount < used_per_sheet)
		to_chat(user, SPAN_DANGER("你至少需要[used_per_sheet]根金属杆才能这么做。"))
		return

	if(WT.remove_fuel(0,user))
		var/obj/item/stack/sheet/new_item = new sheet_path(user.loc)
		new_item.add_to_stacks(user)
		for (var/mob/M as anything in viewers(src))
			M.show_message(SPAN_DANGER("[user.name]用焊枪将[src]塑造成金属。"), SHOW_MESSAGE_VISIBLE, SPAN_DANGER("You hear welding."), SHOW_MESSAGE_AUDIBLE)
		use(used_per_sheet)

GLOBAL_LIST_INIT(rod_recipes, list (
	new /datum/stack_recipe("grille", /obj/structure/grille, 4, time = 20, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_TRAINED),
	new /datum/stack_recipe("fence", /obj/structure/fence, 10, time = 20, one_per_turf = ONE_TYPE_PER_TURF, on_floor = 1, skill_req = SKILL_CONSTRUCTION, skill_lvl = SKILL_CONSTRUCTION_TRAINED)
	))


/obj/item/stack/rods/plasteel
	name = "塑钢杆"
	desc = "一些塑钢杆。可用于建造更坚固的结构和物体。"
	singular_name = "塑钢杆"
	icon_state = "rods_plasteel"
	flags_atom = FPRINT
	matter = list("plasteel" = 3750)
	attack_verb = list("hit", "bludgeoned", "whacked")
	stack_id = "塑钢杆"
	sheet_path = /obj/item/stack/sheet/plasteel
	used_per_sheet = 2

/obj/item/stack/rods/plasteel/Initialize()
	. = ..()
	recipes = null

/obj/item/stack/rods/plasteel/attackby(obj/item/W as obj, mob/user as mob)
	if(!istype(W, /obj/item/stack/sheet/metal))
		return ..()

	var/obj/item/stack/sheet/metal/M = W

	if(amount < 5) // Placeholder until we get an elaborate crafting system created
		to_chat(user, SPAN_DANGER("你至少需要五根塑钢杆才能这么做。"))
		return

	if(M.amount >= 10 && do_after(user, 1 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD))
		if(!M.use(10))
			return
		var/obj/item/device/m56d_post_frame/PF = new(get_turf(user))
		to_chat(user, SPAN_NOTICE("你制造了\a [PF]。"))
		var/replace = (user.get_inactive_hand()==src)
		use(5)
		if(QDELETED(src) && replace)
			user.put_in_hands(PF)
	else
		to_chat(user, SPAN_WARNING("你至少需要十张金属板才能这么做。"))
