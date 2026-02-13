/obj/structure/closet/cabinet
	name = "cabinet"
	desc = "经典永不过时。"
	icon_state = "cabinet_closed"
	icon_closed = "cabinet_closed"
	icon_opened = "cabinet_open"

/obj/structure/closet/cabinet/update_icon()
	if(!opened)
		icon_state = icon_closed
	else
		icon_state = icon_opened

/obj/structure/closet/acloset
	name = "奇怪的柜子"
	desc = "它看起来像是外星造物！"
	icon_state = "acloset"
	icon_closed = "acloset"
	icon_opened = "aclosetopen"


/obj/structure/closet/gimmick
	name = "行政补给柜"
	desc = "这是一个存放着本不该出现在这里的物品的储物柜。"
	icon_state = "syndicate1"
	icon_closed = "syndicate1"
	icon_opened = "syndicate1_open"
	anchored = FALSE

/obj/structure/closet/gimmick/tacticool
	name = "战术装备柜"
	desc = "这是一个用于存放战术装备的储物柜。"
	icon_state = "syndicate1"
	icon_closed = "syndicate1"
	icon_opened = "syndicate1_open"

/obj/structure/closet/gimmick/tacticool/Initialize()
	. = ..()
	new /obj/item/clothing/glasses/eyepatch(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/gloves/swat(src)
	new /obj/item/clothing/gloves/swat(src)
	new /obj/item/clothing/head/helmet/swat(src)
	new /obj/item/clothing/head/helmet/swat(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/clothing/shoes/swat(src)
	new /obj/item/clothing/shoes/swat(src)
	new /obj/item/clothing/suit/armor/swat(src)
	new /obj/item/clothing/suit/armor/swat(src)


