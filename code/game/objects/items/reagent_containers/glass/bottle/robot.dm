
/obj/item/reagent_container/glass/bottle/robot
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,40,50,60)
	volume = 60
	var/reagent = ""


/obj/item/reagent_container/glass/bottle/robot/inaprovaline
	name = "内置伊纳普罗瓦林瓶"
	desc = "一个小瓶子。内含伊纳普罗瓦林——用于稳定病人状况。"
	icon = 'icons/obj/items/chemistry.dmi'
	reagent = "inaprovaline"

/obj/item/reagent_container/glass/bottle/robot/inaprovaline/Initialize()
	. = ..()
	reagents.add_reagent("inaprovaline", 60)
	return


/obj/item/reagent_container/glass/bottle/robot/antitoxin
	name = "内置抗毒素瓶"
	desc = "一小瓶抗毒素。可解毒并修复损伤，一种特效药。"
	icon = 'icons/obj/items/chemistry.dmi'
	reagent = "anti_toxin"

/obj/item/reagent_container/glass/bottle/robot/antitoxin/Initialize()
	. = ..()
	reagents.add_reagent("anti_toxin", 60)
	return
