//Let's get some REAL contraband stuff in here. Because come on, getting brigged for LIPSTICK is no fun.

//Illicit drugs~
/obj/item/storage/pill_bottle/happy
	name = "快乐丸"
	gender = PLURAL
	desc = "高度违禁药物。当你想看见彩虹的时候。"
	skilllock = SKILL_MEDICAL_DEFAULT

/obj/item/storage/pill_bottle/happy/Initialize()
	. = ..()
	new /obj/item/reagent_container/pill/happy( src )
	new /obj/item/reagent_container/pill/happy( src )
	new /obj/item/reagent_container/pill/happy( src )
	new /obj/item/reagent_container/pill/happy( src )
	new /obj/item/reagent_container/pill/happy( src )
	new /obj/item/reagent_container/pill/happy( src )
	new /obj/item/reagent_container/pill/happy( src )

/obj/item/storage/pill_bottle/zombie_powder
	name = "可疑药瓶"
	icon_state = "pill_canister10"
	pill_type_to_fill = /obj/item/reagent_container/pill/zombie_powder
	skilllock = SKILL_MEDICAL_DEFAULT
	maptext_label = "??"

/obj/item/reagent_container/food/drinks/flask/weylandyutani/poison
	desc = "一个压印有维兰德-汤谷标志性徽标的金属瓶，大概是某个公司马屁精下令配给到USS军用舰船自动贩卖机里的。这个闻起来不对劲……"

/obj/item/reagent_container/food/drinks/flask/weylandyutani/poison/Initialize()
	. = ..()
	reagents.remove_any(60)
	reagents.add_reagent("souto_classic", 30)
	reagents.add_reagent("neurotoxin", 30)

/obj/item/reagent_container/food/drinks/bottle/holywater/bong
	name = "嬉皮水瓶"
	desc = "原本是随军牧师圣水瓶，这个已经被重新灌装成了……某种看起来相似的东西。"

/obj/item/reagent_container/food/drinks/bottle/holywater/bong/Initialize()
	. = ..()
	reagents.remove_any(100)
	reagents.add_reagent("hippiesdelight", 100)

/obj/item/weapon/baton/damaged
	name = "损坏的电击警棍"
	desc = "用于使人丧失行动能力的电击警棍。这根看起来相当破烂，尤其是开关周围。"
	force = 12
	has_user_lock = FALSE
