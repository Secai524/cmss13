////////////////////////////////////////////////////////////////////////////////
/// For dilutable items, like tea bags, coffee, etc.

/obj/item/reagent_container/pill/teabag
	name = "速溶茶包"
	icon = 'icons/obj/items/food/mre_food/twe.dmi'
	icon_state = "teabag"
	item_state = null
	volume = 15
	ground_offset_x = 0
	ground_offset_y = 0
	reagent_desc_override = FALSE
	identificable = FALSE
	pill_desc = null
	pill_initial_reagents = list("tea_leaves" = 15)
	fluff_text = "tea bag"
	var/list/tea_blends = list("Earl Grey", "English Breakfast", "Yorkshire", "Kenyan", "Ceylon")

/obj/item/reagent_container/pill/teabag/Initialize(mapload, ...)
	. = ..()
	var/tea_name = pick(tea_blends)
	name = "速溶[tea_name]茶包"
	desc = "一包速溶[tea_name]红茶。包括茶包本身均可完全溶解，茶包可能也是由茶叶制成。无需加热。"

/obj/item/reagent_container/pill/teabag/earl_grey
	tea_blends = list("Earl Grey")
