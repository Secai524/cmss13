/*
Lever-action bullet handfuls!
Similar to shotguns.dm but not exactly.
*/

/obj/item/ammo_magazine/lever_action
	name = "一盒.45-70子弹"
	desc = "一个装满多把.45-70 Govt.子弹的盒子，专为老式步枪准备。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/marksman_rifles.dmi'
	icon_state = "45-70-box"
	item_state = "45-70-box"
	default_ammo = /datum/ammo/bullet/lever_action
	caliber = "45-70"
	gun_type = /obj/item/weapon/gun/lever_action
	max_rounds = 90
	w_class = SIZE_LARGE
	flags_magazine = AMMUNITION_REFILLABLE|AMMUNITION_HANDFUL_BOX
	handful_state = "lever_action_bullet"
	transfer_handful_amount = 9


/obj/item/ammo_magazine/lever_action/training
	name = "一盒.45-70空包弹"
	desc = "一个装满多把.45-70 Govt.空包弹的盒子。除非你抵近射击，否则它们造成不了什么伤害。"
	icon_state = "45-70-training-box"
	item_state = "45-70-training-box"
	default_ammo = /datum/ammo/bullet/lever_action/training
	handful_state = "training_lever_action_bullet"

//unused
/obj/item/ammo_magazine/lever_action/marksman
	name = "一盒.45-70神射手子弹"
	desc = "一个装满多把.45-70 Govt.神射手子弹的盒子，其弹头密度更低，精度更高。"
	icon_state = "45-70-marksman-box"
	item_state = "45-70-marksman-box"
	default_ammo = /datum/ammo/bullet/lever_action/marksman
	handful_state = "marksman_lever_action_bullet"

//unused
/obj/item/ammo_magazine/lever_action/tracker
	name = "一盒.45-70追踪弹"
	desc = "一个装满多把.45-70 Govt.追踪弹的盒子，部分弹头被替换为电子追踪芯片。"
	icon_state = "45-70-tracker-box"
	item_state = "45-70-tracker-box"
	default_ammo = /datum/ammo/bullet/lever_action/tracker
	handful_state = "tracking_lever_action_bullet"

/obj/item/ammo_magazine/lever_action/xm88
	name = "一盒.458 SOCOM子弹"
	desc = "一个装满多把.458 SOCOM子弹的盒子，专为XM88重型步枪设计。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/marksman_rifles.dmi'
	icon_state = "458-box"
	item_state = "458-box"
	default_ammo = /datum/ammo/bullet/lever_action/xm88
	max_rounds = 100
	caliber = ".458"
	gun_type = /obj/item/weapon/gun/lever_action/xm88
	handful_state = "boomslang_bullet"

//-------------------------------------------------------

/obj/item/ammo_magazine/internal/lever_action
	name = "杠杆式枪机管状弹仓"
	desc = "一个内置弹仓。它本不应被看到或移除。"
	default_ammo = /datum/ammo/bullet/lever_action
	caliber = "45-70"
	max_rounds = 9
	chamber_closed = 0

/obj/item/ammo_magazine/internal/lever_action/xm88
	name = "\improper XM88 heavy rifle tube"
	desc = "一个内置弹仓。它本不应被看到或移除。"
	default_ammo = /datum/ammo/bullet/lever_action/xm88
	caliber = ".458"
	max_rounds = 9
	chamber_closed = 0

//-------------------------------------------------------

/*
Handfuls of lever_action rounds. For spawning directly on mobs in roundstart, ERTs, etc
*/

/obj/item/ammo_magazine/handful/lever_action
	name = "一把.45-70子弹"
	desc = "一把标准的.45-70 Govt.子弹。"
	icon_state = "lever_action_bullet_9"
	default_ammo = /datum/ammo/bullet/lever_action
	caliber = "45-70"
	max_rounds = 9
	current_rounds = 9
	gun_type = /obj/item/weapon/gun/lever_action
	handful_state = "lever_action_bullet"
	transfer_handful_amount = 9

/obj/item/ammo_magazine/handful/lever_action/training
	name = "一把.45-70空包弹"
	desc = "一把.45-70 Govt.空包弹。这些是空包弹，基本无害……只是别在近距离射击。"
	icon_state = "training_lever_action_bullet_9"
	default_ammo = /datum/ammo/bullet/lever_action/training
	handful_state = "training_lever_action_bullet"

//unused
/obj/item/ammo_magazine/handful/lever_action/tracker
	name = "一把.45-70追踪弹"
	desc = "一把.45-70 Govt.追踪弹。部分弹头被替换为芯片，发射后可被动态探测器捕捉到信号。"
	icon_state = "tracking_lever_action_bullet_9"
	default_ammo = /datum/ammo/bullet/lever_action/tracker
	handful_state = "tracking_lever_action_bullet"

//unused
/obj/item/ammo_magazine/handful/lever_action/marksman
	name = "一把.45-70神射手子弹"
	desc = "一把.45-70 Govt.神射手子弹。其较小的弹头降低了伤害，但提高了穿透力和子弹速度。"
	icon_state = "marksman_lever_action_bullet_9"
	default_ammo = /datum/ammo/bullet/lever_action/marksman
	handful_state = "marksman_lever_action_bullet"

/obj/item/ammo_magazine/handful/lever_action/xm88
	name = "一把.458 SOCOM子弹"
	desc = "一把.458 SOCOM子弹，专为XM88重型步枪设计。"
	caliber = ".458"
	icon_state = "marksman_lever_action_bullet_9"
	default_ammo = /datum/ammo/bullet/lever_action/xm88
	handful_state = "boomslang_bullet"
