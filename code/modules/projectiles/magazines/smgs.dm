/obj/item/ammo_magazine/smg
	name = "\improper default SMG magazine"
	desc = "一个冲锋枪弹匣。"
	item_state = "generic_mag"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_righthand.dmi'
		)
	default_ammo = /datum/ammo/bullet/smg
	max_rounds = 30

//-------------------------------------------------------
//M39 SMG ammo

/obj/item/ammo_magazine/smg/m39
	name = "\improper M39 HV magazine (10x20mm)"
	desc = "一个10x20mm无壳高速冲锋枪弹匣。强力推进剂使子弹获得更高的速度和轻微的穿透能力，显著提升了中距离效能，但与步枪子弹相比仍有明显差距。"
	caliber = "10x20mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/smgs.dmi'
	icon_state = "m39_HV"
	bonus_overlay_icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/smgs.dmi'
	max_rounds = 48
	w_class = SIZE_MEDIUM
	gun_type = /obj/item/weapon/gun/smg/m39
	default_ammo = /datum/ammo/bullet/smg/m39
	ammo_band_icon = "+m39_band"
	ammo_band_icon_empty = "+m39_band_e"

/obj/item/ammo_magazine/smg/m39/ap
	name = "\improper M39 AP magazine (10x20mm)"
	desc = "一个10x20mm无壳穿甲冲锋枪弹匣。弹头由高密度材料制成，使其能够直接穿透护甲，但也降低了弹药的原始停止力和速度。"
	default_ammo = /datum/ammo/bullet/smg/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/smg/m39/le
	name = "\improper M39 LE magazine (10x20mm)"
	desc = "一个10x20mm无壳轻型爆破冲锋枪弹匣，内含特制轻型爆破弹，旨在快速摧毁护甲，代价是伤害和穿透力大幅降低。"
	default_ammo = /datum/ammo/bullet/smg/le
	ammo_band_color = AMMO_BAND_COLOR_LIGHT_EXPLOSIVE

/obj/item/ammo_magazine/smg/m39/rubber
	name = "\improper M39 rubber magazine (10x20mm)"
	desc = "一个10x20mm无壳橡胶子弹冲锋枪弹匣，内含橡胶子弹。非致命，但对生物形态效果极差。"
	default_ammo = /datum/ammo/bullet/smg/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

/obj/item/ammo_magazine/smg/m39/heap
	name = "\improper M39 HEAP magazine (10x20mm)"
	desc = "一个10x20mm无壳穿甲高爆冲锋枪弹匣。弹头由特殊炸药制成，旨在穿透护甲后引爆，以造成最大软组织伤害。"
	default_ammo = /datum/ammo/bullet/smg/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/smg/m39/penetrating
	name = "\improper M39 wall-penetrating magazine (10x20mm)"
	desc = "一个10x20mm无壳穿墙子弹冲锋枪弹匣，内含穿墙子弹。设计用于直接穿透物体和墙壁。"
	default_ammo = /datum/ammo/bullet/smg/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/smg/m39/toxin
	name = "\improper M39 toxin magazine (10x20mm)"
	desc = "一个10x20mm无壳毒素子弹冲锋枪弹匣，内含毒素子弹。擅长剥离护甲和破坏生物结构。"
	default_ammo = /datum/ammo/bullet/smg/ap/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

/obj/item/ammo_magazine/smg/m39/incendiary
	name = "\improper M39 incendiary magazine (10x20mm)"
	desc = "一个10x20mm无壳燃烧冲锋枪弹匣。燃烧弹头使目标着火，但导致枪支停止力低且精度严重下降。"
	default_ammo = /datum/ammo/bullet/smg/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/smg/m39/extended
	name = "\improper M39 HV extended magazine (10x20mm)"
	desc = "一个10x20mm无壳高速加长冲锋枪弹匣。强力推进剂使子弹获得更高的飞行速度和轻微的穿透能力，显著提升了远距离效能，但与步枪子弹相比仍有明显差距。"
	max_rounds = 72
	icon_state = "m39_HV_extended"
	bonus_overlay = "m39_ex"

//-------------------------------------------------------
//M5, a classic SMG used in a lot of action movies.

/obj/item/ammo_magazine/smg/mp5
	name = "\improper MP5 magazine (9mm)"
	desc = "一个用于MP5的9mm弹匣。"
	default_ammo = /datum/ammo/bullet/smg
	caliber = "9mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/smgs.dmi'
	icon_state = "mp5"
	gun_type = /obj/item/weapon/gun/smg/mp5
	max_rounds = 30 //Also comes in 10 and 40.


//-------------------------------------------------------
//MP27, based on the MP27, based on the M7.

/obj/item/ammo_magazine/smg/mp27
	name = "\improper MP27 magazine (4.6x30mm)"
	desc = "一个用于MP27的4.6mm弹匣。发射大而重的子弹，对于冲锋枪而言有明显的冲击力，但同样有明显的散射和精度损失。"
	default_ammo = /datum/ammo/bullet/smg/mp27
	caliber = "4.6x30mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/smgs.dmi'
	icon_state = "mp7_30"
	gun_type = /obj/item/weapon/gun/smg/mp27
	max_rounds = 30 //Also comes in 20 and 40.
	bonus_overlay = "mp7_30_overlay"
	var/random_magazine = TRUE

/obj/item/ammo_magazine/smg/mp27/Initialize(mapload, spawn_empty)
	. = ..()
	if(random_magazine)
		var/capacity = pick(20, 30, 40)
		name = "\improper MP27 [capacity]-round magazine (4.6x30mm)"
		desc = "一个[capacity]发容量的4.6mm MP27弹匣。发射大而重的子弹，对于冲锋枪而言有明显的冲击力，但同样有明显的散射和精度损失。由于工厂蓝图混淆，20发、30发和40发弹匣都在同一批盒子中制造和销售，导致了一场集体诉讼，使该公司破产。"
		caliber = "4.6x30mm"
		base_mag_icon = "mp7_[capacity]"
		icon_state = "mp7_[capacity]"
		bonus_overlay = "mp7_[capacity]_overlay"
		current_rounds = capacity
		max_rounds = capacity
		random_magazine = FALSE

//-------------------------------------------------------
//PPSH //Based on the PPSh-41.

#define PPSH_STICK_MAGAZINE_JAM_CHANCE 0.1
#define PPSH_DRUM_MAGAZINE_JAM_CHANCE 1

/obj/item/ammo_magazine/smg/ppsh
	name = "\improper PPSh-17b stick magazine (7.62x25mm)"
	desc = "一个PPSh冲锋枪的弹匣。弹药量少于标志性的弹鼓，但后者会导致供弹和操作问题。哪个更好，由你决定。"
	caliber = "7.62x25mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/smgs.dmi'
	icon_state = "ppsh17b_stick"
	bonus_overlay = "ppsh17b_stick_overlay"
	max_rounds = 35
	gun_type = /obj/item/weapon/gun/smg/ppsh
	default_ammo = /datum/ammo/bullet/smg/ppsh
	var/bonus_mag_aim_slowdown = 0
	var/bonus_mag_wield_delay = 0
	var/jam_chance = PPSH_STICK_MAGAZINE_JAM_CHANCE
	var/new_item_state = "ppsh17b"


/obj/item/ammo_magazine/smg/ppsh/extended
	name = "\improper PPSh-17b drum magazine (7.62x25mm)"
	desc = "标志性的PPSh-17b弹鼓。载弹量是弹匣版的两倍，但可能导致操作和供弹问题。哪个更好，由你决定。"
	icon_state = "ppsh17b_drum"
	bonus_overlay = "ppsh17b_drum_overlay"
	max_rounds = 71
	w_class = SIZE_MEDIUM
	bonus_mag_aim_slowdown = SLOWDOWN_ADS_QUICK_MINUS
	bonus_mag_wield_delay = WIELD_DELAY_VERY_FAST
	jam_chance = PPSH_DRUM_MAGAZINE_JAM_CHANCE
	new_item_state = "ppsh17b_d"

#undef PPSH_STICK_MAGAZINE_JAM_CHANCE
#undef PPSH_DRUM_MAGAZINE_JAM_CHANCE

//-------------------------------------------------------
//Type-19, based on the PPS-43

/obj/item/ammo_magazine/smg/pps43
	name = "\improper Type-19 stick magazine (7.62x25mm)"
	desc = "19式冲锋枪的弹匣。"
	caliber = "7.62x25mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/smgs.dmi'
	icon_state = "insasu_stickmag"
	bonus_overlay = "insasu_stickmag_overlay"
	max_rounds = 35
	gun_type = /obj/item/weapon/gun/smg/pps43
	default_ammo = /datum/ammo/bullet/smg/pps43
	var/bonus_mag_aim_slowdown = 0
	var/bonus_mag_wield_delay = 0


/obj/item/ammo_magazine/smg/pps43/extended
	name = "\improper Type-19 drum magazine (7.62x25mm)"
	desc = "19式冲锋枪的7.62x25毫米弹鼓。"
	icon_state = "insasu_drum"
	bonus_overlay = "insasu_drum_overlay"
	max_rounds = 71
	w_class = SIZE_MEDIUM
	bonus_mag_aim_slowdown = SLOWDOWN_ADS_QUICK_MINUS
	bonus_mag_wield_delay = WIELD_DELAY_VERY_FAST
//-------------------------------------------------------
//Type 64 SMG, based on the PP Bizon.

/obj/item/ammo_magazine/smg/bizon
	name = "\improper Type 64 Helical Magazine (7.62x19mm)"
	desc = "64式冲锋枪的7.62x19毫米64发螺旋弹匣，是UPP武装部队的标准冲锋枪弹匣。"
	caliber = "7.62x19mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/smgs.dmi'
	icon_state = "type64mag"
	max_rounds = 64
	gun_type = /obj/item/weapon/gun/smg/bizon

//-------------------------------------------------------
//GENERIC UZI //Based on the uzi submachinegun, of course.

/obj/item/ammo_magazine/smg/mac15 //Based on the Uzi.
	name = "\improper MAC-15 magazine (9mm)"
	desc = "MAC-15的9毫米弹匣。"
	caliber = "9mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/smgs.dmi'
	icon_state = "mac15"
	max_rounds = 25 //Can also be 20, 25, 40, and 50.
	gun_type = /obj/item/weapon/gun/smg/mac15

/obj/item/ammo_magazine/smg/mac15/extended
	name = "\improper MAC-15 extended magazine (9mm)"
	desc = "MAC-15的加长型9毫米弹匣。"
	icon_state = "mac15_extended"
	bonus_overlay = "mac15_ext"
	max_rounds = 50

//-------------------------------------------------------
// the real UZI

#define UZI_NORMAL_MAGAZINE_JAM_CHANCE 0
#define UZI_EXTENDED_MAGAZINE_JAM_CHANCE 1

/obj/item/ammo_magazine/smg/uzi
	name = "\improper UZI magazine (9x21mm)"
	desc = "乌兹冲锋枪的9x21毫米弹匣。看起来很小，对吧？更大的弹匣可能导致供弹故障。"
	caliber = "9x12mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/smgs.dmi'
	icon_state = "uzi"
	max_rounds = 25
	gun_type = /obj/item/weapon/gun/smg/uzi
	var/jam_chance = UZI_NORMAL_MAGAZINE_JAM_CHANCE

/obj/item/ammo_magazine/smg/uzi/extended
	name = "\improper UZI extended magazine (9x21mm)"
	desc = "乌兹冲锋枪的稍加长型9x21毫米弹匣。由于其尺寸，可能会也可能不会导致供弹故障。"
	icon_state = "uzi_extended"
	bonus_overlay = "uzi_ext"
	max_rounds = 32
	jam_chance = UZI_EXTENDED_MAGAZINE_JAM_CHANCE

#undef UZI_NORMAL_MAGAZINE_JAM_CHANCE
#undef UZI_EXTENDED_MAGAZINE_JAM_CHANCE

//-------------------------------------------------------
//FP9000 //Based on the FN P90

/obj/item/ammo_magazine/smg/fp9000
	name = "FN FP9000弹匣（5.7x28毫米）"
	desc = "FN FP9000冲锋枪的5.7x28毫米弹匣。"
	default_ammo = /datum/ammo/bullet/smg/ap
	caliber = "5.7x28mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/smgs.dmi'
	icon_state = "fp9000"
	w_class = SIZE_MEDIUM
	max_rounds = 50
	gun_type = /obj/item/weapon/gun/smg/fp9000

//-------------------------------------------------------
//Nailgun!
/obj/item/ammo_magazine/smg/nailgun
	name = "射钉枪弹匣（7x45毫米）"
	desc = "一个装填了超大号塑钢钉的大型弹匣。不幸的是，这些钉子的生产成本使其难以负担大多数军事项目，只有某些特定的建筑工程才需要它们。"
	default_ammo = /datum/ammo/bullet/smg/nail
	flags_magazine = NO_FLAGS // Let's not start messing with nails...
	caliber = "7x45mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/nailguns.dmi'
	icon_state = "nailgun"
	w_class = SIZE_SMALL
	max_rounds = 48
	gun_type = /obj/item/weapon/gun/smg/nailgun

//-------------------------------------------------------
//P90, a classic SMG.

/obj/item/ammo_magazine/smg/p90
	name = "\improper FN P90 magazine (5.7x28mm)"
	desc = "FN P90的5.7x28毫米弹匣。"
	default_ammo = /datum/ammo/bullet/smg/p90
	caliber = "5.7x28mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/smgs.dmi'
	icon_state = "p90"
	bonus_overlay_icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/smgs.dmi'
	bonus_overlay = "p90_mag_overlay"
	w_class = SIZE_MEDIUM
	gun_type = /obj/item/weapon/gun/smg/p90
	max_rounds = 50

/obj/item/ammo_magazine/smg/p90/ap
	name = "\improper FN P90 AP magazine (5.7x28mm)"
	desc = "FN P90的穿甲型5.7x28毫米弹匣。"
	default_ammo = /datum/ammo/bullet/smg/p90/ap
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/TWE/smgs.dmi'
	icon_state = "p90_ap"
	bonus_overlay_icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/smgs.dmi'
	bonus_overlay = "p90_ap_overlay"
