

///jar

/obj/item/reagent_container/food/drinks/jar
	name = "空罐子"
	desc = "一个罐子。你不确定它原本是装什么的。"
	icon_state = "jar"
	item_state = "beaker"
	center_of_mass = "x=15;y=8"

/obj/item/reagent_container/food/drinks/jar/on_reagent_change()
	if(length(reagents.reagent_list) > 0)
		icon_state ="jar_what"
		name = "装着东西的罐子"
		desc = "你实在看不出这是什么。"
	else
		icon_state = "jar"
		name = "空罐子"
		desc = "一个罐子。你不确定它原本是装什么的。"
