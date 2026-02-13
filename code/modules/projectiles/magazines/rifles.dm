


//-------------------------------------------------------
//M41A (MK2) PULSE RIFLE AMMUNITION

/obj/item/ammo_magazine/rifle
	name = "\improper M41A magazine (10x24mm)"
	desc = "一个10x24mm突击步枪弹匣。"
	caliber = "10x24mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/assault_rifles.dmi'
	icon_state = "m41a"
	item_state = "generic_mag"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_righthand.dmi'
		)
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 40
	gun_type = /obj/item/weapon/gun/rifle/m41a
	ammo_band_icon = "+m41a_band"
	ammo_band_icon_empty = "+m41a_band_e"

/obj/item/ammo_magazine/rifle/extended
	name = "\improper M41A extended magazine (10x24mm)"
	desc = "一个加长型10x24mm突击步枪弹匣。"
	icon_state = "m41a_extended"
	max_rounds = 60
	bonus_overlay_icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/assault_rifles.dmi'
	bonus_overlay = "m41a_ex"

/obj/item/ammo_magazine/rifle/incendiary
	name = "\improper M41A incendiary magazine (10x24mm)"
	desc = "一个燃烧型10x24mm突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/rifle/explosive
	name = "\improper M41A explosive magazine (10x24mm)"
	desc = "一个爆炸型10x24mm突击步枪弹匣。老天……千万别用它打中友军。"
	default_ammo = /datum/ammo/bullet/rifle/explosive
	ammo_band_color = AMMO_BAND_COLOR_EXPLOSIVE

/obj/item/ammo_magazine/rifle/heap
	name = "\improper M41A HEAP magazine (10x24mm)"
	desc = "一个高爆穿甲型10x24mm突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/ap
	name = "\improper M41A AP magazine (10x24mm)"
	desc = "一个穿甲型10x24mm突击步枪弹匣。"
	desc_lore = "Unlike standard HEAP magazines, these reserve bullets do not have depleted uranium tips. Instead, these rounds trade off some of their bullet package for a lighter weight, reducing damage but increasing penetration capabilities and muzzle velocity."
	default_ammo = /datum/ammo/bullet/rifle/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/le
	name = "\improper M41A LE magazine (10x24mm)"
	desc = "一个碎甲型10x24mm突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/le
	ammo_band_color = AMMO_BAND_COLOR_LIGHT_EXPLOSIVE

/obj/item/ammo_magazine/rifle/penetrating
	name = "\improper M41A wall-penetrating magazine (10x24mm)"
	desc = "一个穿墙型10x24mm突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/rifle/toxin
	name = "\improper M41A toxin magazine (10x24mm)"
	desc = "一个毒素型10x24mm突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/ap/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN


/obj/item/ammo_magazine/rifle/rubber
	name = "M41A橡胶弹弹匣 (10x24mm)"
	desc = "一个装满橡胶子弹的10x24mm突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

//-------------------------------------------------------
//M41A (MK1) TRUE AND ORIGINAL

/obj/item/ammo_magazine/rifle/m41aMK1
	name = "\improper M41A MK1 magazine (10x24mm)"
	desc = "一个仅兼容旧式M41A MK1的长方形弹药箱。可容纳95发子弹。"
	icon_state = "m41a_mk1"
	max_rounds = 95
	gun_type = /obj/item/weapon/gun/rifle/m41aMK1
	default_ammo = /datum/ammo/bullet/rifle
	ammo_band_icon = "+m41a_mk1_band"
	ammo_band_icon_empty = "+m41a_mk1_band_e"

/obj/item/ammo_magazine/rifle/m41aMK1/ap
	name = "\improper M41A MK1 AP magazine (10x24mm)"
	desc = "一个仅兼容旧式M41A MK1的长方形弹药箱。可容纳95发子弹。此箱内为穿甲弹。"
	default_ammo = /datum/ammo/bullet/rifle/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/m41aMK1/heap
	name = "\improper M41A MK1 HEAP magazine (10x24mm)"
	desc = "一个仅兼容旧式M41A MK1的长方形弹药箱。可容纳95发子弹。此箱内为高爆穿甲弹。"
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/m41aMK1/incendiary
	name = "\improper M41A MK1 incendiary magazine (10x24mm)"
	desc = "一个仅兼容旧式M41A MK1的长方形弹药箱。可容纳95发子弹。此箱内为燃烧弹。"
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/rifle/m41aMK1/toxin
	name = "\improper M41A MK1 toxin magazine (10x24mm)"
	desc = "一个仅兼容旧式M41A MK1的长方形弹药箱。可容纳95发子弹。此箱内为毒气弹。"
	default_ammo = /datum/ammo/bullet/rifle/ap/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

/obj/item/ammo_magazine/rifle/m41aMK1/penetrating
	name = "\improper M41A MK1 wall-penetrating magazine (10x24mm)"
	desc = "一个仅兼容旧式M41A MK1的长方形弹药箱。可容纳95发子弹。此箱内为穿墙弹。"
	default_ammo = /datum/ammo/bullet/rifle/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

//-------------------------------------------------------
//M4RA, l42 reskin, same stats as before but different, lore friendly, shell.

/obj/item/ammo_magazine/rifle/m4ra
	name = "\improper M4RA magazine (10x24mm)"
	desc = "一个用于M4RA战斗步枪的10x24mm子弹弹匣。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/marksman_rifles.dmi'
	icon_state = "m4ra"
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 25
	gun_type = /obj/item/weapon/gun/rifle/m4ra
	bonus_overlay_icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/marksman_rifles.dmi'
	ammo_band_icon = "+m4ra_band"
	ammo_band_icon_empty = "+m4ra_band_e"

/obj/item/ammo_magazine/rifle/m4ra/ap
	name = "\improper M4RA armor-piercing magazine (10x24mm)"
	desc = "一个用于M4RA战斗步枪的10x24mm穿甲弹弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/ap
	max_rounds = 25
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/m4ra/extended
	name = "\improper M4RA extended magazine (10x24mm)"
	desc = "M4RA战斗步枪使用的10x24mm子弹扩容弹匣。额外增加10发容量，最多可容纳35发。"
	icon_state = "m4ra_extended"
	bonus_overlay = "m4ra_ex"
	max_rounds = 35

/obj/item/ammo_magazine/rifle/m4ra/rubber
	name = "M4RA橡胶弹弹匣（10x24mm）"
	desc = "M4RA战斗步枪使用的10x24mm低致命性橡胶子弹弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

/obj/item/ammo_magazine/rifle/m4ra/heap
	name = "\improper M4RA high-explosive armor-piercing magazine (10x24mm)"
	desc = "M4RA战斗步枪使用的高爆穿甲10x24mm子弹弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/m4ra/penetrating
	name = "\improper M4RA wall-penetrating magazine (10x24mm)"
	desc = "M4RA战斗步枪使用的穿墙10x24mm子弹弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/rifle/m4ra/incendiary
	name = "\improper M4RA incendiary magazine (10x24mm)"
	desc = "M4RA战斗步枪使用的燃烧10x24mm子弹弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

//-------------------------------------------------------
//XM40 AKA SOF RIFLE FROM HELL (It's an EM-2, a prototype of the real world L85A1 way back from the 1940s. We've given it a blue plastic shell and an integral suppressor)
/obj/item/ammo_magazine/rifle/xm40
	name = "\improper XM40 magazine (10x24mm)"
	desc = "XM40脉冲步枪使用的短粗宽体双排大容量弹匣。发射10x24mm穿甲弹，可容纳60发，膛内另有1发。"
	icon_state = "m40_sd"
	max_rounds = 60
	gun_type = /obj/item/weapon/gun/rifle/m41a/elite/xm40
	default_ammo = /datum/ammo/bullet/rifle/ap

/obj/item/ammo_magazine/rifle/xm40/heap
	name = "\improper XM40 HEAP magazine (10x24mm)"
	desc = "XM40脉冲步枪使用的短粗宽体双排大容量弹匣。发射10x24mm高爆穿甲弹，可容纳60发，膛内另有1发。"
	icon_state = "m40_sd_heap"
	max_rounds = 60
	gun_type = /obj/item/weapon/gun/rifle/m41a/elite/xm40
	default_ammo = /datum/ammo/bullet/rifle/heap

//-------------------------------------------------------
//MAR-40 AK CLONE //AK47 and FN FAL together as one.

/obj/item/ammo_magazine/rifle/mar40
	name = "\improper MAR magazine (7.62x39mm)"
	desc = "MAR系列枪械使用的7.62x39mm弹匣。"
	caliber = "7.62x39mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/assault_rifles.dmi'
	icon_state = "mar40"
	default_ammo = /datum/ammo/bullet/rifle/mar40
	max_rounds = 40
	gun_type = /obj/item/weapon/gun/rifle/mar40
	w_class = SIZE_MEDIUM

/obj/item/ammo_magazine/rifle/mar40/extended
	name = "\improper MAR extended magazine (7.62x39mm)"
	desc = "7.62x39mm MAR弹匣，此型号比标准弹匣容量更大。"
	max_rounds = 60
	bonus_overlay = "mar40_ex"
	icon_state = "mar40_extended"

/obj/item/ammo_magazine/rifle/mar40/lmg
	name = "\improper MAR drum magazine (7.62x39mm)"
	desc = "MAR-50轻机枪使用的7.62x39mm弹鼓。"
	caliber = "7.62x39mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/machineguns.dmi'
	icon_state = "mar50"
	max_rounds = 100
	gun_type = /obj/item/weapon/gun/rifle/mar40/lmg

//-------------------------------------------------------
//M16 RIFLE

/obj/item/ammo_magazine/rifle/m16
	name = "\improper M16 magazine (5.56x45mm)"
	desc = "M16突击步枪使用的5.56x45mm弹匣。"
	caliber = "5.56x45mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/assault_rifles.dmi'
	icon_state = "m16"
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 20
	gun_type = /obj/item/weapon/gun/rifle/m16
	w_class = SIZE_MEDIUM
	ammo_band_icon = "+m16_band"
	ammo_band_icon_empty = "+m16_band_e"

/obj/item/ammo_magazine/rifle/m16/ap
	name = "\improper M16 AP magazine (5.56x45mm)"
	desc = "M16突击步枪使用的5.56x45mm穿甲弹弹匣。"
	caliber = "5.56x45mm"
	default_ammo = /datum/ammo/bullet/rifle/ap
	max_rounds = 20
	gun_type = /obj/item/weapon/gun/rifle/m16
	w_class = SIZE_MEDIUM
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/m16/ext
	name = "\improper M16 extended magazine (5.56x45mm)"
	desc = "M16突击步枪使用的5.56x45mm扩容弹匣。此型号包含30发子弹。"
	icon_state = "m16_ext"
	item_state = "m16_ext"
	bonus_overlay = "m16_ext_overlay"
	max_rounds = 30

//-------------------------------------------------------
//AR10 RIFLE

/obj/item/ammo_magazine/rifle/ar10
	name = "\improper AR10 magazine (7.62x51mm)"
	desc = "AR10突击步枪使用的7.62x51mm弹匣。"
	caliber = "7.62x51mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/assault_rifles.dmi'
	icon_state = "ar10"
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 20
	gun_type = /obj/item/weapon/gun/rifle/ar10
	w_class = SIZE_MEDIUM

//-------------------------------------------------------
//M41AE2 HEAVY PULSE RIFLE

/obj/item/ammo_magazine/rifle/lmg
	name = "\improper M41AE2 ammo box (10x24mm)"
	desc = "M41AE2重型脉冲步枪使用的半矩形10x24mm弹匣。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/machineguns.dmi'
	icon_state = "m41ae2"
	max_rounds = 300
	gun_type = /obj/item/weapon/gun/rifle/lmg
	flags_magazine = AMMUNITION_CANNOT_REMOVE_BULLETS|AMMUNITION_REFILLABLE|AMMUNITION_SLAP_TRANSFER
	flags_atom = FPRINT|CONDUCT|MAP_COLOR_INDEX
	ammo_band_icon = "+m41ae2_band"
	ammo_band_icon_empty = "+m41ae2_band_e"

/obj/item/ammo_magazine/rifle/lmg/Initialize(...)
	. = ..()
	select_gamemode_skin(type)

/obj/item/ammo_magazine/rifle/lmg/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	var/new_base_icon_state
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("snow")
			base_mag_icon = new_base_icon_state ? new_base_icon_state : "s_" + initial(icon_state)
			. = TRUE
		if("desert")
			base_mag_icon = new_base_icon_state ? new_base_icon_state : "d_" + initial(icon_state)
			. = TRUE
		if("classic")
			base_mag_icon = new_base_icon_state ? new_base_icon_state : "c_" + initial(icon_state)
			. = TRUE
		if("urban")
			base_mag_icon = new_base_icon_state ? new_base_icon_state : "u_" + initial(icon_state)
			. = TRUE
	return .

/obj/item/ammo_magazine/rifle/lmg/holo_target
	name = "\improper M41AE2 ammo box (10x24mm holo-target)"
	desc = "M41AE2重型脉冲步枪使用的半矩形全息瞄准弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/holo_target
	max_rounds = 200
	ammo_band_color = AMMO_BAND_COLOR_HOLOTARGETING

/obj/item/ammo_magazine/rifle/lmg/ap
	name = "\improper M41AE2 ammo box (10x24mm armor-piercing)"
	desc = "M41AE2重型脉冲步枪使用的半矩形穿甲弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/ap
	max_rounds = 300
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/lmg/heap
	name = "\improper M41AE2 ammo box (10x24mm high-explosive armor-piercing)"
	desc = "M41AE2重型脉冲步枪使用的半矩形弹匣。内装USCM标准的穿甲爆弹头子弹。"
	default_ammo = /datum/ammo/bullet/rifle/heap
	max_rounds = 300
	gun_type = /obj/item/weapon/gun/rifle/lmg
	ammo_band_color = AMMO_BAND_COLOR_HEAP

//-------------------------------------------------------
//UPP TYPE 71 RIFLE

/obj/item/ammo_magazine/rifle/type71
	name = "\improper Type 71 magazine (5.45x39mm)"
	desc = "71式步枪使用的5.45x39mm大容量盒式弹匣。"
	caliber = "5.45x39mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/assault_rifles.dmi'
	icon_state = "type71"
	ammo_band_icon = "+type71_band"
	ammo_band_icon_empty = "+type71_band_e"
	default_ammo = /datum/ammo/bullet/rifle/type71
	max_rounds = 60
	gun_type = /obj/item/weapon/gun/rifle/type71

/obj/item/ammo_magazine/rifle/type71/ap
	name = "\improper Type 71 AP magazine (5.45x39mm)"
	desc = "71式步枪使用的5.45x39mm穿甲大容量盒式弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/type71/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/type71/heap
	name = "\improper Type 71 HEAP magazine (5.45x39mm)"
	desc = "71式步枪使用的标准高爆穿甲5.45x39mm大容量盒式弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/type71/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

//-------------------------------------------------------
//UPP - Norcomm AK-4047 RIFLE

/obj/item/ammo_magazine/rifle/ak4047
	name = "\improper AK-4047 magazine (10x24mm)"
	desc = "专为AK-4047系列突击步枪设计的坚固可靠40发弹匣。为耐用性打造，可承受恶劣条件，即使在最差环境中也能持续射击。"
	caliber = "10x24mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/assault_rifles.dmi'
	icon_state = "ak4047"
	item_state = "generic_mag"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_righthand.dmi'
		)
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 40
	gun_type = /obj/item/weapon/gun/rifle/ak4047
	ammo_band_icon = "+ak4047_band"
	ammo_band_icon_empty = "+ak4047_band_e"

/obj/item/ammo_magazine/rifle/ak4047/ap
	name = "\improper AK-4047 AP magazine (10x24mm)"
	desc = "AK-4047步枪使用的10mm穿甲弹弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/ak4047/heap
	name = "\improper AK-4047 HEAP magazine (10x24mm)"
	desc = "AK-4047步枪使用的标准高爆穿甲10mm子弹弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/ak4047/incendiary
	name = "\improper AK-4047 incendiary magazine (10x24mm)"
	desc = "一个10毫米突击步枪弹匣，内装AK-4047步枪的燃烧弹。"
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

//-------------------------------------------------------
//L42A Battle Rifle

/obj/item/ammo_magazine/rifle/l42a
	name = "\improper L42A magazine (10x24mm)"
	desc = "一个10x24毫米战斗步枪弹匣。"
	caliber = "10x24mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/marksman_rifles.dmi'
	icon_state = "l42mk1"
	bonus_overlay = "l42_mag_overlay"
	bonus_overlay_icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/marksman_rifles.dmi'
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 25
	gun_type = /obj/item/weapon/gun/rifle/l42a
	w_class = SIZE_MEDIUM
	ammo_band_icon = "+l42mk1_band"
	ammo_band_icon_empty = "+l42mk1_band_e"

/obj/item/ammo_magazine/rifle/l42a/ap
	name = "\improper L42A AP magazine (10x24mm)"
	desc = "一个穿甲10x24毫米战斗步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/l42a/le
	name = "\improper L42A LE magazine (10x24mm)"
	desc = "一个破甲10x24毫米战斗步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/le
	ammo_band_color = AMMO_BAND_COLOR_LIGHT_EXPLOSIVE

/obj/item/ammo_magazine/rifle/l42a/rubber
	name = "L42A橡胶弹弹匣（10x24毫米）"
	desc = "一个装满橡胶子弹的10x24毫米战斗步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

/obj/item/ammo_magazine/rifle/l42a/heap
	name = "\improper L42A HEAP (10x24mm)"
	desc = "一个高爆穿甲10x24毫米战斗步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/l42a/penetrating
	name = "\improper L42A wall-penetrating magazine (10x24mm)"
	desc = "一个穿墙10x24毫米战斗步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/rifle/l42a/toxin
	name = "\improper L42A toxin magazine (10x24mm)"
	desc = "一个毒素10x244毫米战斗步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/ap/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

/obj/item/ammo_magazine/rifle/l42a/extended
	name = "\improper L42A extended magazine (10x24mm)"
	desc = "一个加长型10x24毫米战斗步枪弹匣。"
	caliber = "10x24mm"
	icon_state = "l42mk1_extended"
	bonus_overlay = "l42_ex_overlay"
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 35
	gun_type = /obj/item/weapon/gun/rifle/l42a
	w_class = SIZE_MEDIUM

/obj/item/ammo_magazine/rifle/l42a/incendiary
	name = "\improper L42A incendiary magazine (10x24mm)"
	desc = "一个燃烧型10毫米战斗步枪弹匣。"
	caliber = "10x24mm"
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	max_rounds = 20
	gun_type = /obj/item/weapon/gun/rifle/l42a
	w_class = SIZE_MEDIUM
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/rifle/l42a/abr40
	name = "\improper ABR-40 magazine (10x24mm)"
	desc = "一个ABR-40弹匣，装有全金属被甲弹，用于靶场射击或狩猎。理论上与L42A战斗步枪通用。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/marksman_rifles.dmi'
	icon_state = "abr40"
	bonus_overlay = "abr40_mag_overlay"
	bonus_overlay_icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/marksman_rifles.dmi'
	max_rounds = 12
	w_class = SIZE_SMALL
	ammo_band_icon = "+abr40_band"
	ammo_band_icon_empty = "+abr40_band_e"

/obj/item/ammo_magazine/rifle/l42a/abr40/holo_target
	name = "\improper ABR-40 holotargeting magazine (10x24mm)"
	desc = "一个ABR-40弹匣，装有全息瞄准弹药，主要用于高亮狩猎目标以便捕获。理论上与L42A战斗步枪通用。"
	default_ammo = /datum/ammo/bullet/rifle/holo_target/hunting
	ammo_band_color = AMMO_BAND_COLOR_HOLOTARGETING

//-------------------------------------------------------
// NSG 23 ASSAULT RIFLE - PMC PRIMARY RIFLE

/obj/item/ammo_magazine/rifle/nsg23
	name = "\improper NSG 23 magazine (10x24mm)"
	desc = "一个NSG 23突击步枪弹匣。"
	caliber = "10x24mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/WY/assault_rifles.dmi'
	icon_state = "nsg23"
	item_state = "nsg23"
	bonus_overlay = "nsg23_mag_overlay" //needs to be an overlay, as the mag has a hole that would be filled over by the ext overlay
	max_rounds = 30
	gun_type = /obj/item/weapon/gun/rifle/nsg23
	ammo_band_icon = "+nsg23_band"
	ammo_band_icon_empty = "+nsg23_band_e"

/obj/item/ammo_magazine/rifle/nsg23/extended
	name = "\improper NSG 23 high-capacity drum magazine (10x24mm)"
	desc = "一个NSG 23突击步枪弹匣。此弹匣装有45发子弹。"
	icon_state = "nsg23_ext"
	item_state = "nsg23_ext"
	bonus_overlay = "nsg23_ext_overlay"
	max_rounds = 45

/obj/item/ammo_magazine/rifle/nsg23/ap
	name = "\improper NSG 23 armor-piercing magazine (10x24mm)"
	desc = "一个穿甲NSG 23突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/nsg23/heap
	name = "\improper NSG 23 HEAP magazine (10x24mm)"
	desc = "一个高爆穿甲NSG 23突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/nsg23/incendiary
	name = "\improper NSG 23 incendiary magazine (10x24mm)"
	desc = "一个白磷弹头燃烧型NSG 23突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/rifle/nsg23/rubber
	name = "\improper NSG 23 training magazine (10x24mm)"
	desc = "一个NSG 23突击步枪弹匣。此弹匣装有橡胶子弹。"
	default_ammo = /datum/ammo/bullet/rifle/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

//--------------------------------------------------------
//Bolt action rifle ammo
/obj/item/ammo_magazine/rifle/boltaction
	name = "\improper Basira-Armstrong magazine (6.5mm)"
	desc = "一个用于Basira-Armstrong猎枪的弹匣。符合民用猎枪15发子弹的限制。"
	caliber = "6.5mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/marksman_rifles.dmi'
	icon_state = "hunting"
	default_ammo = /datum/ammo/bullet/sniper/crude
	max_rounds = 10
	gun_type = /obj/item/weapon/gun/boltaction
	w_class = SIZE_SMALL

/obj/item/ammo_magazine/rifle/boltaction/vulture
	name = "\improper M707 \"Vulture\" magazine (20x102mm)"
	desc = "一个用于M707 \"Vulture\" anti-materiel rifle. Contains up to 4 massively oversized rounds."
	caliber = "20x102mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/marksman_rifles.dmi'
	icon_state = "vulture"
	handful_state = "vulture_bullet"
	default_ammo = /datum/ammo/bullet/sniper/anti_materiel/vulture
	max_rounds = 4
	gun_type = /obj/item/weapon/gun/boltaction/vulture
	w_class = SIZE_MEDIUM // maybe small? This shit's >4 inches long mind you
	ammo_band_icon = "+vulture_band"
	ammo_band_icon_empty = "+vulture_band_e"

/obj/item/ammo_magazine/rifle/boltaction/vulture/holo_target
	name = "\improper M707 \"Vulture\" holo-target magazine (20x102mm)"
	desc = "一个用于M707 \"Vulture\" anti-materiel rifle. Contains up to 4 massively oversized <b>IFF-CAPABLE</b> holo-targeting rounds, which excel at marking heavy targets to be attacked by allied ground forces. The logistical requirements for such capabilities heavily hinder the performance and stopping power of this round."
	default_ammo =  /datum/ammo/bullet/sniper/anti_materiel/vulture/holo_target
	ammo_band_color = AMMO_BAND_COLOR_HOLOTARGETING

//=ROYAL MARINES=\\

/obj/item/ammo_magazine/rifle/rmc_f90
	name = "\improper F903 magazine (10x24mm)"
	desc = "一个10x24毫米F903突击步枪弹匣。"
	caliber = "10x24mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/TWE/assault_rifles.dmi'
	icon_state = "aug"
	item_state = "aug"
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 30
	gun_type = /obj/item/weapon/gun/rifle/rmc_f90
	ammo_band_icon = "+aug_band"
	ammo_band_icon_empty = "+aug_band_e"

/obj/item/ammo_magazine/rifle/rmc_f90/marksman
	name = "\improper F903A1 Marksman magazine (10x24mm)"
	desc = "一个穿甲10x24毫米穿甲F903突击步枪弹匣。"
	icon_state = "aug_dmr"
	item_state = "aug_dmr"
	default_ammo = /datum/ammo/bullet/rifle/ap
	gun_type = /obj/item/weapon/gun/rifle/rmc_f90/scope
	max_rounds = 20
	ammo_band_color = AMMO_BAND_COLOR_AP
	ammo_band_icon = "+aug_dmr_band"
	ammo_band_icon_empty = "+aug_dmr_band_e"

/obj/item/ammo_magazine/rifle/rmc_f90/heap
	name = "\improper F903 HEAP magazine (10x24mm)"
	desc = "一个高爆穿甲10x24毫米穿甲高爆突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/rmc_f90/marksman/heap
	name = "\improper F903A1 Marksman magazine (10x24mm)"
	desc = "一个高爆穿甲10x24毫米F903突击步枪弹匣。"
	icon_state = "aug_dmr"
	item_state = "aug_dmr"
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/l23
	name = "\improper L23 magazine (8.88x51mm)"
	desc = "一个8.88x51mm L23突击步枪弹匣。"
	caliber = "8.88x51mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/TWE/assault_rifles.dmi'
	icon_state = "l23"
	item_state = "l23"
	default_ammo = /datum/ammo/bullet/rifle/l23
	max_rounds = 30
	gun_type = /obj/item/weapon/gun/rifle/l23
	ammo_band_icon = "+l23_band"
	ammo_band_icon_empty = "+l23_band_e"

/obj/item/ammo_magazine/rifle/l23/extended
	name = "\improper L23 high-capacity drum magazine (8.88x51mm)"
	desc = "一个8.88x51mm L23突击步枪弹匣。此弹匣装有45发子弹。"
	icon_state = "l23_ext"
	item_state = "l23_ext"
	bonus_overlay = "l23_ext_overlay"
	max_rounds = 45

/obj/item/ammo_magazine/rifle/l23/ap
	name = "\improper L23 armor-piercing magazine (8.88x51mm)"
	desc = "一个穿甲型8.88x51mm L23突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/l23/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/l23/heap
	name = "\improper L23 HEAP magazine (8.88x51mm)"
	desc = "一个高爆穿甲型8.88x51mm L23突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/l23/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/l23/incendiary
	name = "\improper L23 incendiary magazine (8.88x51mm)"
	desc = "一个白磷燃烧型8.88x51mm L23突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/l23/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/rifle/l23/rubber
	name = "\improper L23 practice magazine (8.88x51mm)"
	desc = "一个L23突击步枪弹匣。此弹匣装填的是橡胶子弹。"
	default_ammo = /datum/ammo/bullet/rifle/l23/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

/obj/item/ammo_magazine/rifle/l23/toxin
	name = "\improper L23 toxin magazine (8.88x51mm)"
	desc = "一个毒素型8.88x51mm L23突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/l23/ap/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

/obj/item/ammo_magazine/rifle/l64
	name = "\improper L64A3 squash-head magazine (8.88x51mm Caseless)"
	desc = "一个装有L10A7碎甲比赛级8.88x51mm弹药的弹匣。"
	caliber = "8.88x51mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/TWE/marksman_rifles.dmi'
	icon_state = "l64"
	w_class = SIZE_MEDIUM
	max_rounds = 25
	default_ammo = /datum/ammo/bullet/rifle/l64
	gun_type = /obj/item/weapon/gun/rifle/l64a3


/obj/item/ammo_magazine/rifle/l64/ap
	name = "\improper L64 armor-piercing magazine (8.88x51mm)"
	desc = "一个穿甲型8.88x51mm L23突击步枪弹匣。"
	default_ammo = /datum/ammo/bullet/rifle/l64/ap
	ammo_band_icon = "+l64_band"
	ammo_band_icon_empty = "+l64_band_e"

//--------------------------------------------------------
//XM51 BREACHING SHOTGUN

/obj/item/ammo_magazine/rifle/xm51
	name = "\improper XM51 magazine (16g)"
	desc = "一个16号口径霰弹枪弹匣。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/shotguns.dmi'
	icon_state = "xm51"
	caliber = "16g"
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/shotgun/light/breaching
	max_rounds = 12
	gun_type = /obj/item/weapon/gun/rifle/xm51
	transfer_handful_amount = 6

/obj/item/ammo_magazine/rifle/xm51/cmb
	name = "\improper Model 1771 magazine (16g breaching)"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/shotguns.dmi'
	icon_state = "m51b"

/obj/item/ammo_magazine/rifle/xm51/cmb/rubber
	name = "\improper Model 1771 magazine (16g rubber buckshot)"
	desc = "一个16号口径橡胶鹿弹霰弹枪弹匣。"
	icon_state = "m51b_rubber"
	gun_type = /obj/item/weapon/gun/rifle/xm51/cmb
	default_ammo = /datum/ammo/bullet/shotgun/light/rubber

//-------------------------------------------------------
//P9 SHARP Rifle

/obj/item/ammo_magazine/rifle/sharp
	name = "SHARP步枪弹匣"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/grenade_launchers.dmi'
	icon_state = "sharp_explosive_mag"
	item_state = "sharprifle"
	caliber = "Dart"
	w_class = SIZE_MEDIUM
	max_rounds = 10
	default_ammo = /datum/ammo/rifle/sharp/explosive
	gun_type = /obj/item/weapon/gun/rifle/sharp
	transfer_handful_amount = 5
	description_ammo = "darts"

/obj/item/ammo_magazine/rifle/sharp/explosive
	name = "\improper 9X-E sticky explosive dart magazine"
	desc = "一个为SHARP步枪设计的专用爆炸粘性飞镖弹匣。"

/obj/item/ammo_magazine/rifle/sharp/incendiary
	name = "\improper 9X-T sticky incendiary dart magazine"
	desc = "一个为SHARP步枪设计的专用燃烧飞镖弹匣。"
	icon_state = "sharp_incendiary_mag"
	default_ammo = /datum/ammo/rifle/sharp/incendiary

/obj/item/ammo_magazine/rifle/sharp/flechette
	name = "\improper 9X-F flechette dart magazine"
	desc = "一个为SHARP步枪设计的专用箭形飞镖弹匣。"
	icon_state = "sharp_flechette_mag"
	default_ammo = /datum/ammo/rifle/sharp/flechette

