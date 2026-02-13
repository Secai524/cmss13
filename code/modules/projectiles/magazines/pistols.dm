
//-------------------------------------------------------
//M4A3 PISTOL

/obj/item/ammo_magazine/pistol
	name = "\improper M4A3 magazine (9mm)"
	desc = "一个用于M4A3的9mm手枪弹匣。"
	caliber = "9mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/pistols.dmi'
	icon_state = "m4a3"
	max_rounds = 12
	w_class = SIZE_SMALL
	default_ammo = /datum/ammo/bullet/pistol
	gun_type = /obj/item/weapon/gun/pistol/m4a3
	ammo_band_icon = "+m4a3_band"
	ammo_band_icon_empty = "+m4a3_band_e"

/obj/item/ammo_magazine/pistol/hp
	name = "\improper M4A3 hollowpoint magazine (9mm)"
	desc = "一个用于M4A3的空尖弹9mm手枪弹匣。这些空尖弹对无护甲目标有明显更高的停止作用，对护甲目标则明显更低。"
	default_ammo = /datum/ammo/bullet/pistol/hollow
	ammo_band_color = AMMO_BAND_COLOR_HOLLOWPOINT

/obj/item/ammo_magazine/pistol/ap
	name = "\improper M4A3 AP magazine (9mm)"
	desc = "一个用于M4A3的穿甲弹9mm手枪弹匣。这些穿甲弹对护甲目标有明显更高的停止作用，对无护甲目标则明显更低。"
	default_ammo = /datum/ammo/bullet/pistol/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/pistol/rubber
	name = "\improper M4A3 Rubber magazine (9mm)"
	desc = "一个用于M4A3的9mm手枪弹匣。这个装有橡胶子弹。"
	default_ammo = /datum/ammo/bullet/pistol/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

/obj/item/ammo_magazine/pistol/incendiary
	name = "\improper M4A3 incendiary magazine (9mm)"
	desc = "一个用于M4A3的燃烧弹9mm手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/pistol/penetrating
	name = "\improper M4A3 wall-penetrating magazine (9mm)"
	desc = "一个用于M4A3的穿墙弹9mm手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/pistol/toxin
	name = "\improper M4A3 toxin magazine (9mm)"
	desc = "一个用于M4A3的毒素弹9mm手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/ap/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

//-------------------------------------------------------
//M4A3 45 //Inspired by the 1911

/obj/item/ammo_magazine/pistol/m1911
	name = "\improper M1911 magazine (.45)"
	desc = "一个用于传奇M1911手枪的弹匣。可容纳八发标准子弹。"
	default_ammo = /datum/ammo/bullet/pistol/heavy
	caliber = ".45"
	icon_state = "m4a345"//rename later
	max_rounds = 8
	gun_type = /obj/item/weapon/gun/pistol/m1911
	ammo_band_icon = "+m4a345_band"
	ammo_band_icon_empty = "+m4a345_band_e"

/obj/item/ammo_magazine/pistol/m1911/highimpact
	name = "\improper M1911 high-impact magazine (.45)"
	desc = "一个用于传奇M1911手枪的弹匣。可容纳八发能短暂击倒目标的震荡弹。"
	default_ammo = /datum/ammo/bullet/pistol/heavy/highimpact
	ammo_band_color = AMMO_BAND_COLOR_HIGH_IMPACT

/obj/item/ammo_magazine/pistol/m1911/highimpact/ap
	name = "\improper M1911 high-impact armor-piercing magazine (.45)"
	desc = "一个用于传奇M1911手枪的弹匣。可容纳八发能短暂击倒目标的震荡穿甲弹。"
	default_ammo = /datum/ammo/bullet/pistol/heavy/highimpact/ap
	ammo_band_color = AMMO_BAND_COLOR_HIGH_IMPACT_AP
//-------------------------------------------------------
//88M4 based off VP70

/obj/item/ammo_magazine/pistol/mod88
	name = "\improper 88M4 AP magazine (9mm)"
	desc = "一个用于Mod88的9mm手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/ap
	caliber = "9mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/WY/pistols.dmi'
	icon_state = "88m4"
	max_rounds = 19
	gun_type = /obj/item/weapon/gun/pistol/mod88
	ammo_band_icon = "+88m4_band"
	ammo_band_icon_empty = "+88m4_band_e"
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/pistol/mod88/normalpoint // Unused
	name = "\improper 88M4 FMJ magazine (9mm)"
	default_ammo = /datum/ammo/bullet/pistol
	caliber = "9mm"
	ammo_band_color = null

/obj/item/ammo_magazine/pistol/mod88/normalpoint/extended // Unused
	name = "\improper 88M4 FMJ extended magazine (9mm)"
	icon_state = "88m4_mag_ex"
	default_ammo = /datum/ammo/bullet/pistol
	caliber = "9mm"

/obj/item/ammo_magazine/pistol/mod88/toxin
	name = "\improper 88M4 toxic magazine (9mm)"
	desc = "一个用于Mod88的毒素弹9mm手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/ap/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

/obj/item/ammo_magazine/pistol/mod88/penetrating
	name = "\improper 88M4 wall-penetrating magazine (9mm)"
	desc = "一个用于Mod88的穿墙弹9mm手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/pistol/mod88/incendiary
	name = "\improper 88M4 incendiary magazine (9mm)"
	desc = "一个用于Mod88的燃烧弹9mm手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/pistol/mod88/rubber
	name = "\improper 88M4 rubber magazine (9mm)"
	desc = "一个用于Mod88的9mm手枪弹匣。这个装有橡胶子弹。"
	default_ammo = /datum/ammo/bullet/pistol/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

//-------------------------------------------------------
//ES-4

/obj/item/ammo_magazine/pistol/es4
	name = "\improper ES-4 stun magazine (9mm)"
	default_ammo = /datum/ammo/bullet/pistol/rubber/es4
	caliber = "9mm"
	desc = "可容纳19发特制导电9mm子弹。ES-4中的静电推进功能通过发射cV9mm子弹实现，其速度按比例降低以保持更高的动能传递率。所有这些将一枚穿透性子弹变成了非致命子弹。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/WY/pistols.dmi'
	icon_state = "es4"
	max_rounds = 19
	gun_type = /obj/item/weapon/gun/pistol/es4

//-------------------------------------------------------
//VP78

/obj/item/ammo_magazine/pistol/vp78
	name = "\improper VP78 magazine (9mm)"
	desc = "一个用于VP78的9mm手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/squash
	caliber = "9mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/WY/pistols.dmi'
	icon_state = "vp78"
	max_rounds = 18
	gun_type = /obj/item/weapon/gun/pistol/vp78
	ammo_band_icon = "+vp78_band"
	ammo_band_icon_empty = "+vp78_band_e"

/obj/item/ammo_magazine/pistol/vp78/toxin
	name = "\improper VP78 toxic magazine (9mm)"
	desc = "一个用于VP78的9毫米毒素手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/squash/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

/obj/item/ammo_magazine/pistol/vp78/penetrating
	name = "\improper VP78 wall-penetrating magazine (9mm)"
	desc = "一个用于VP78的9毫米穿甲手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/squash/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/pistol/vp78/incendiary
	name = "\improper VP78 incendiary magazine (9mm)"
	desc = "一个用于VP78的9毫米燃烧手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/squash/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/pistol/vp78/rubber
	name = "\improper VP78 rubber magazine (9mm)"
	desc = "一个用于VP78的9毫米手枪弹匣。此弹匣装填的是橡胶子弹。"
	default_ammo = /datum/ammo/bullet/pistol/squash/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

//-------------------------------------------------------
//Beretta 92FS, the gun McClane carries around in Die Hard. Very similar to the service pistol, all around.

/obj/item/ammo_magazine/pistol/b92fs
	name = "\improper Beretta 92FS magazine (9mm)"
	desc = "一个用于贝雷塔92FS的9毫米手枪弹匣。"
	caliber = "9mm"
	icon_state = "m4a3" //PLACEHOLDER
	max_rounds = 15
	default_ammo = /datum/ammo/bullet/pistol
	gun_type = /obj/item/weapon/gun/pistol/b92fs


//-------------------------------------------------------
//DEAGLE //This one is obvious.

/obj/item/ammo_magazine/pistol/heavy
	name = "\improper Desert Eagle magazine (.50)"
	desc = "七发威力强大的.50口径毁灭性弹药。"
	default_ammo = /datum/ammo/bullet/pistol/deagle
	caliber = ".50"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/pistols.dmi'
	icon_state = "deagle"
	max_rounds = 7
	gun_type = /obj/item/weapon/gun/pistol/heavy
	default_ammo = /datum/ammo/bullet/pistol/heavy
	ammo_band_icon = "+deagle_band"
	ammo_band_icon_empty = "+deagle_band_e"

/obj/item/ammo_magazine/pistol/heavy/super //Commander's variant
	name = "重型沙漠之鹰弹匣 (.50)"
	desc = "七发毁灭性威力的.50口径弹药。"
	gun_type = /obj/item/weapon/gun/pistol/heavy/co
	default_ammo = /datum/ammo/bullet/pistol/deagle
	ammo_band_color = AMMO_BAND_COLOR_SUPER

/obj/item/ammo_magazine/pistol/heavy/super/highimpact
	name = "高冲击重型沙漠之鹰弹匣 (.50)"
	desc = "七发毁灭性威力的.50口径弹药。弹头采用合成锇铅合金，足以击退任何被命中的目标。请勿对准任何你珍视之物。"
	default_ammo = /datum/ammo/bullet/pistol/deagle/highimpact
	ammo_band_color = AMMO_BAND_COLOR_HIGH_IMPACT

/obj/item/ammo_magazine/pistol/heavy/super/highimpact/ap
	name = "\improper High Impact Armor-Piercing Desert Eagle magazine (.50)"
	desc = "七发毁灭性威力的.50口径弹药。威力惊人。弹头采用锇-碳化钨合金，不仅能击退目标，还能撕裂任何目标的护甲。由于生产成本高昂且担心船体破损，配发数量极少。请勿对准任何你珍视之物。"
	default_ammo = /datum/ammo/bullet/pistol/deagle/highimpact/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

//-------------------------------------------------------
//Type 31 pistol. //A makarov

/obj/item/ammo_magazine/pistol/np92
	name = "\improper NP92 magazine (9x18mm Makarov)"
	desc = "一个9x18毫米马卡洛夫手枪弹匣，用于NP92手枪。"
	default_ammo = /datum/ammo/bullet/pistol
	caliber = "9x18mm Makarov"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/pistols.dmi'
	icon_state = "np92mag"
	max_rounds = 12
	gun_type = /obj/item/weapon/gun/pistol/np92

/obj/item/ammo_magazine/pistol/np92/suppressed
	name = "\improper NPZ92 magazine (9x18mm Makarov)"
	desc = "一个9x18毫米马卡洛夫手枪弹匣，用于NPZ92手枪。"
	default_ammo = /datum/ammo/bullet/pistol
	caliber = "9x18mm Makarov"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/pistols.dmi'
	icon_state = "npz92mag"
	max_rounds = 12

/obj/item/ammo_magazine/pistol/np92/tranq
	name = "\improper NPZ92 tranq magazine (9x18mm Makarov)"
	desc = "一个9x18毫米马卡洛夫镇静剂手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/tranq
	caliber = "9x18mm Makarov"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/pistols.dmi'
	icon_state = "npz92tranqmag"
	max_rounds = 12

//-------------------------------------------------------
//Type 73 pistol. //A TT

/obj/item/ammo_magazine/pistol/t73
	name = "\improper Type 73 magazine (7.62x25mm Tokarev)"
	desc = "一个7.62x25毫米手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/heavy
	caliber = "7.62x25mm Tokarev"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/pistols.dmi'
	icon_state = "ttmag"
	max_rounds = 9
	gun_type = /obj/item/weapon/gun/pistol/t73

/obj/item/ammo_magazine/pistol/t73_impact
	name = "\improper High Impact Type 74 magazine (7.62x25mm Tokarev)"
	desc = "一个高冲击7.62x25毫米托卡列夫手枪弹匣。弹头采用钨铅合金，足以击退任何被命中的目标。对准异议分子。"
	default_ammo = /datum/ammo/bullet/pistol/deagle/highimpact/upp
	caliber = "7.62x25mm Tokarev"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/pistols.dmi'
	icon_state = "ttmag_impact"
	max_rounds = 9
	gun_type = /obj/item/weapon/gun/pistol/t73/leader

//-------------------------------------------------------
//KT-42 //Inspired by the .44 Auto Mag pistol

/obj/item/ammo_magazine/pistol/kt42
	name = "\improper KT-42 magazine (.44)"
	desc = "一个.44手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/heavy
	caliber = ".44"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/pistols.dmi'
	icon_state = "kt42"
	max_rounds = 16
	gun_type = /obj/item/weapon/gun/pistol/kt42

//-------------------------------------------------------
//W62 'Whisper' (.22 LR)

/obj/item/ammo_magazine/pistol/holdout
	name = "W62弹匣 (.22)"
	desc = "一个出奇小的弹匣，装填.22子弹。虽不是蜂鸟手枪，但也差不多了。"
	default_ammo = /datum/ammo/bullet/pistol/tiny
	caliber = ".22"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/pistols.dmi'
	icon_state = "holdout"
	max_rounds = 10
	w_class = SIZE_TINY
	gun_type = /obj/item/weapon/gun/pistol/holdout

//-------------------------------------------------------
//AC71 (.380 ACP)

/obj/item/ammo_magazine/pistol/action
	name = "AC71弹匣 (.380 ACP)"
	desc = "一个小型弹匣，装填8发.380 ACP子弹。"
	default_ammo = /datum/ammo/bullet/pistol/tiny
	caliber = ".380 ACP"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/pistols.dmi'
	icon_state = "action"
	max_rounds = 8
	w_class = SIZE_TINY
	gun_type = /obj/item/weapon/gun/pistol/action

//-------------------------------------------------------
//CLF HOLDOUT PISTOL
/obj/item/ammo_magazine/pistol/clfpistol
	name = "D18弹匣 (9毫米)"
	desc = "一个小型D18弹匣，存储7发9毫米子弹。它怎么会这么小？"
	default_ammo = /datum/ammo/bullet/pistol
	caliber = "9mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/pistols.dmi'
	icon_state = "m4a3" // placeholder
	max_rounds = 7
	w_class = SIZE_TINY
	gun_type = /obj/item/weapon/gun/pistol/clfpistol


//-------------------------------------------------------
//.45 MARSHALS PISTOL //Inspired by the Browning Hipower
// rebalanced - singlefire, very strong bullets but slow to fire and heavy recoil
// redesigned - now rejected USCM sidearm model, utilized by Colonial Marshals and other stray groups.

/obj/item/ammo_magazine/pistol/highpower
	name = "\improper MK-45 Automagnum magazine (.45)"
	desc = "一个.45手枪弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/highpower
	caliber = ".45"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/pistols.dmi'
	icon_state = "highpower"
	max_rounds = 13
	gun_type = /obj/item/weapon/gun/pistol/highpower

//comes in black, for the black variant of the highpower, better for military usage

/obj/item/ammo_magazine/pistol/highpower/black
	icon_state = "highpower_b"

//-------------------------------------------------------
/*
Auto 9 The gun RoboCop uses. A better version of the VP78, with more rounds per magazine. Probably the best pistol around, but takes no attachments.
It is a modified Beretta 93R, and can fire three-round burst or single fire. Whether or not anyone else aside RoboCop can use it is not established.
*/

/obj/item/ammo_magazine/pistol/auto9
	name = "\improper Auto-9 magazine (9mm)"
	desc = "一个用于Auto-9手枪的9毫米手枪弹匣。平头弹，专为击碎罪犯头颅而设计。"
	default_ammo = /datum/ammo/bullet/pistol/squash
	caliber = "9mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/WY/pistols.dmi'
	icon_state = "88m4" //PLACEHOLDER
	max_rounds = 50
	gun_type = /obj/item/weapon/gun/pistol/auto9



//-------------------------------------------------------
//The first rule of monkey pistol is we don't talk about monkey pistol.
/obj/item/ammo_magazine/pistol/chimp
	name = "\improper CHIMP70 magazine (.70M)"
	desc = "一个.70M口径的香蕉形弹匣。"
	default_ammo = /datum/ammo/bullet/pistol/mankey
	caliber = ".70M"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/event.dmi'
	icon_state = "c70" //PLACEHOLDER

	matter = list("metal" = 3000)
	max_rounds = 300
	gun_type = /obj/item/weapon/gun/pistol/chimp

//-------------------------------------------------------
//Smartpistol IFF magazine.

/obj/item/ammo_magazine/pistol/smart
	name = "\improper SU-6 Smartpistol magazine (.45)"
	desc = "一个IFF兼容的.45口径手枪弹匣，用于SU-6手枪。"
	default_ammo = /datum/ammo/bullet/pistol/smart
	caliber = ".45"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/pistols.dmi'
	icon_state = "smartpistol"
	max_rounds = 15
	gun_type = /obj/item/weapon/gun/pistol/smart

//-------------------------------------------------------
//SKORPION //Based on the same thing.

/obj/item/ammo_magazine/pistol/skorpion
	name = "\improper CZ-81 20-round magazine (.32ACP)"
	desc = "一个用于CZ-81手枪的.32ACP口径弹匣。"
	caliber = ".32ACP"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/smgs.dmi'
	icon_state = "skorpion" //PLACEHOLDER
	gun_type = /obj/item/weapon/gun/pistol/skorpion
	max_rounds = 20

//-------------------------------------------------------
/*
M10 Auto Pistol: A compact machine pistol that sacrifices accuracy for an impressive fire rate, shredding close-range targets with ease.
With a 40-round magazine, it can keep up sustained fire in tense situations, though its high recoil and low stability make it tricky to control.
Unlike other pistols, it can be equipped with limited mods (small muzzle, magazine, and optics) but has no burst-fire option.
*/

/obj/item/ammo_magazine/pistol/m10
	name = "\improper M10 HV magazine (10x20mm-APC)"
	desc = "一个紧凑的40发高速弹匣，专为近距离战斗中的快速装填和可靠性能而设计。"
	default_ammo = /datum/ammo/bullet/pistol/m10
	caliber = "10x20mm-APC"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/pistols.dmi'
	icon_state = "m10"
	bonus_overlay = "m10_overlay"
	bonus_overlay_icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/pistols.dmi'
	max_rounds = 40
	gun_type = /obj/item/weapon/gun/pistol/m10

/obj/item/ammo_magazine/pistol/m10/extended
	name = "\improper M10 HV extended magazine (10x20mm-APC)"
	desc = "一个加长的62发高速弹匣，为持续交火提供额外火力，且不会显著增加装填时间。"
	default_ammo = /datum/ammo/bullet/pistol/m10
	caliber = "10x20mm-APC"
	icon_state = "m10_ext"
	bonus_overlay = "m10_ex_overlay"
	max_rounds = 62
	gun_type = /obj/item/weapon/gun/pistol/m10

/obj/item/ammo_magazine/pistol/m10/drum
	name = "\improper M10 HV drum magazine (10x20mm-APC)"
	desc = "一个超长的84发弹鼓，专为持久交火设计，以更长的装填时间为代价，提供最大的弹药容量。"
	default_ammo = /datum/ammo/bullet/pistol/m10
	caliber = "10x20mm-APC"
	icon_state = "m10_drum"
	bonus_overlay = "m10_drum_overlay"
	max_rounds = 84
	gun_type = /obj/item/weapon/gun/pistol/m10

/obj/item/ammo_magazine/pistol/m10/ap
	name = "\improper M10 AP magazine (10x20mm-APC)"
	desc = "一个装有穿甲弹的40发弹匣。设计用于击穿护甲和轻型掩体，但枪口初速比标准高速弹低。"
	default_ammo = /datum/ammo/bullet/pistol/m10/ap
	caliber = "10x20mm-APC"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/pistols.dmi'
	icon_state = "m10_ap"
	bonus_overlay = "m10_ap_overlay"
	bonus_overlay_icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/pistols.dmi'
	max_rounds = 40
	gun_type = /obj/item/weapon/gun/pistol/m10

/obj/item/ammo_magazine/pistol/m10/ap/extended
	name = "\improper M10 AP extended magazine (10x20mm-APC)"
	desc = "一个装有穿甲弹的62发加长弹匣。设计用于击穿护甲和轻型掩体，但枪口初速比标准高速弹低。"
	default_ammo = /datum/ammo/bullet/pistol/m10/ap
	caliber = "10x20mm-APC"
	icon_state = "m10_ap_ext"
	bonus_overlay = "m10_ap_ex_overlay"
	max_rounds = 62
	gun_type = /obj/item/weapon/gun/pistol/m10

/obj/item/ammo_magazine/pistol/m10/ap/drum
	name = "\improper M10 AP drum magazine (10x20mm-APC)"
	desc = "一个装有穿甲弹的超长84发弹鼓。设计用于击穿护甲和轻型掩体，但枪口初速比标准高速弹低。"
	default_ammo = /datum/ammo/bullet/pistol/m10/ap
	caliber = "10x20mm-APC"
	icon_state = "m10_ap_drum"
	bonus_overlay = "m10_ap_drum_overlay"
	max_rounds = 84
	gun_type = /obj/item/weapon/gun/pistol/m10

//-------------------------------------------------------
/*

L54 service pistol

*/

/obj/item/ammo_magazine/pistol/l54
	name = "\improper L54 magazine (9mm)"
	desc = "一个适用于L54手枪的弹匣。"
	caliber = "9mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/TWE/pistols.dmi'
	icon_state = "l54"
	max_rounds = 12
	w_class = SIZE_SMALL
	default_ammo = /datum/ammo/bullet/pistol
	gun_type = /obj/item/weapon/gun/pistol/l54
	ammo_band_icon = "+l54_band"
	ammo_band_icon_empty = "+l54_band_e"

/obj/item/ammo_magazine/pistol/l54_custom
	name = "\improper L54-S magazine (.9x20mm)"
	desc = "一个改装过的L54手枪弹匣，装有专用的.9x20mm弹药。与标准的9mm武器或弹匣不兼容。"
	caliber = "9mm (special)"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/TWE/pistols.dmi'
	icon_state = "l54"
	max_rounds = 12
	w_class = SIZE_SMALL
	default_ammo = /datum/ammo/bullet/pistol/l54_custom
	gun_type = /obj/item/weapon/gun/pistol/l54_custom
	ammo_band_icon = "+l54_band"
	ammo_band_icon_empty = "+l54_band_e"
	ammo_band_color = AMMO_BAND_COLOR_HIGH_VELOCITY

/obj/item/ammo_magazine/pistol/l54/hp
	name = "\improper L54 hollowpoint magazine (9mm)"
	desc = "一个用于L54手枪的弹匣。此弹匣装有空尖弹，对无护甲目标有显著更高的停止作用，但对有护甲目标效果明显较差。"
	default_ammo = /datum/ammo/bullet/pistol/hollow
	ammo_band_color = AMMO_BAND_COLOR_HOLLOWPOINT

/obj/item/ammo_magazine/pistol/l54/ap
	name = "\improper L54 AP magazine (9mm)"
	desc = "一个用于L54手枪的弹匣。此弹匣装有穿甲弹，对有良好护甲的目标有显著更高的停止作用，但对无护甲或轻护甲目标效果明显较差。"
	default_ammo = /datum/ammo/bullet/pistol/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/pistol/l54/rubber
	name = "\improper L54 Rubber magazine (9mm)"
	default_ammo = /datum/ammo/bullet/pistol/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

/obj/item/ammo_magazine/pistol/l54/incendiary
	name = "\improper L54 incendiary magazine (9mm)"
	default_ammo = /datum/ammo/bullet/pistol/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/pistol/l54/penetrating
	name = "\improper L54 wall-penetrating magazine (9mm)"
	default_ammo = /datum/ammo/bullet/pistol/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/pistol/l54/toxin
	name = "\improper L54 toxin magazine (9mm)"
	default_ammo = /datum/ammo/bullet/pistol/ap/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN
