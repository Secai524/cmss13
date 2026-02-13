/obj/structure/closet/coffin
	name = "coffin"
	desc = "这是为逝者准备的安葬容器。"
	icon_state = "coffin"
	icon_closed = "coffin"
	icon_opened = "coffin_open"
	material = MATERIAL_WOOD
	anchored = FALSE
	layer = BETWEEN_OBJECT_ITEM_LAYER

/obj/structure/closet/coffin/update_icon()
	if(!opened)
		icon_state = icon_closed
	else
		icon_state = icon_opened

/obj/structure/closet/coffin/uscm
	name = "\improper USCM coffin"
	desc = "为逝去的陆战队员准备的安葬容器，饰以红色，内部印有陆战队的徽章。永远忠诚。"
	icon_state = "uscm_coffin"
	icon_closed = "uscm_coffin"
	icon_opened = "uscm_coffin_open"

/obj/structure/closet/coffin/predator
	name = "奇怪的棺材"
	desc = "这是为逝者准备的安葬容器。侧面似乎有奇怪的标记..？"
	icon_state = "pred_coffin"
	icon_closed = "pred_coffin"
	icon_opened = "pred_coffin_open"

	open_sound = 'sound/effects/stonedoor_openclose.ogg'
	close_sound = 'sound/effects/stonedoor_openclose.ogg'


/obj/structure/closet/coffin/woodencrate //Subtyped here so Req doesn't sell them
	name = "木制板条箱"
	desc = "一个木箱。粗制滥造，空间宽敞，在ASRS上毫无价值。"
	icon_state = "closed_woodcrate"
	icon_opened = "open_woodcrate"
	icon_closed = "closed_woodcrate"
	material = MATERIAL_WOOD
	store_mobs = FALSE
	climbable = TRUE
	throwpass = 1
