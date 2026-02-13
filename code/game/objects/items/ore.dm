/obj/item/ore
	name = "rock"
	icon = 'icons/obj/structures/props/mining.dmi'
	icon_state = "ore2"
	black_market_value = 5
	var/oretag

/obj/item/ore/uranium
	name = "pitchblende"
	desc = "一种含有铀的矿石。光是看着它就让你的脑袋感觉晕乎乎的……它微微发光。"
	desc_lore = "Colonies all over the Neroid Sector mine extensively for pitchblende - uranium ore. It finds use in outdated fission reactors, nuclear weapons, and more commonly armor-piercing munitions. A W-Y funded research team determined that radiation poisoning from using these munitions is 'negligible'."
	icon_state = "Uranium ore"

	oretag = "uranium"
	black_market_value = 35

/obj/item/ore/iron
	name = "hematite"
	icon_state = "Iron ore"

	oretag = "hematite"
	black_market_value = 25

/obj/item/ore/coal
	name = "碳质岩"
	icon_state = "Coal ore"

	oretag = "coal"
	black_market_value = 15

/obj/item/ore/glass
	name = "不纯硅酸盐"
	icon_state = "Glass ore"
	gender = PLURAL
	oretag = "sand"
	black_market_value = 15

/obj/item/ore/phoron
	name = "福罗恩晶体"
	icon_state = "Phoron ore"
	gender = PLURAL
	oretag = "phoron"
	black_market_value = 25

/obj/item/ore/silver
	name = "天然银矿石"
	icon_state = "Silver ore"

	oretag = "silver"
	black_market_value = 25

/obj/item/ore/gold
	name = "天然金矿石"
	icon_state = "Gold ore"

	oretag = "gold"
	black_market_value = 30

/obj/item/ore/diamond
	name = "diamonds"
	icon_state = "Diamond ore"
	gender = PLURAL
	oretag = "diamond"
	black_market_value = 30

/obj/item/ore/osmium
	name = "粗铂"
	icon_state = "Platinum ore"
	oretag = "platinum"
	black_market_value = 30

/obj/item/ore/slag
	name = "矿渣"
	desc = "完全没用。"
	icon_state = "slag"
	oretag = "slag"
	black_market_value = 0

/obj/item/ore/Initialize()
	. = ..()
	pixel_x = rand(0,16)-8
	pixel_y = rand(0,8)-8

/obj/item/ore/pearl
	name = "pearl"
	desc = "收集五十个就能做条项链！"
	icon = 'icons/obj/items/fishing_atoms.dmi'
	icon_state = "pearl"
	oretag = "pearl"
	black_market_value = 60
