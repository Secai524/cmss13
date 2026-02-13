
//external magazines

/obj/item/ammo_magazine/revolver
	name = "\improper M44 speed loader (.44)"
	desc = "一个7发.44口径左轮手枪快速装弹器。"
	default_ammo = /datum/ammo/bullet/revolver
	flags_equip_slot = NO_FLAGS
	caliber = ".44"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/revolvers.dmi'
	icon_state = "m44"
	item_state = "generic_speedloader"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_righthand.dmi'
		)
	w_class = SIZE_SMALL
	max_rounds = 7
	gun_type = /obj/item/weapon/gun/revolver/m44
	ammo_band_icon = "+m44_tip"
	ammo_band_icon_empty = "empty"

/obj/item/ammo_magazine/revolver/marksman
	name = "\improper M44 marksman speed loader (.44)"
	desc = "一个7发.44口径左轮手枪快速装弹器，装有远程穿甲射手弹。"
	default_ammo = /datum/ammo/bullet/revolver/marksman
	caliber = ".44"
	ammo_band_color = REVOLVER_TIP_COLOR_MARKSMAN

/obj/item/ammo_magazine/revolver/heavy
	name = "\improper M44 heavy speed loader (.44)"
	desc = "一个7发.44口径左轮手枪快速装弹器，装有重型子弹。虽然比传统的.44子弹伤害低，但它们具有更高的停止作用。"
	default_ammo = /datum/ammo/bullet/revolver/heavy
	caliber = ".44"
	ammo_band_color = REVOLVER_TIP_COLOR_HEAVY

/obj/item/ammo_magazine/revolver/incendiary
	name = "\improper M44 incendiary speed loader (.44)"
	desc = "一个7发.44口径左轮手枪快速装弹器，装有燃烧弹。"
	default_ammo = /datum/ammo/bullet/revolver/incendiary
	ammo_band_color = REVOLVER_TIP_COLOR_INCENDIARY

/obj/item/ammo_magazine/revolver/marksman/toxin
	name = "\improper M44 toxic speed loader (.44)"
	desc = "一个7发.44口径左轮手枪快速装弹器，装有毒素弹。"
	default_ammo = /datum/ammo/bullet/revolver/marksman/toxin
	ammo_band_color = REVOLVER_TIP_COLOR_TOXIN

/obj/item/ammo_magazine/revolver/penetrating
	name = "\improper M44 wall-penetrating speed loader (.44)"
	desc = "一个7发.44口径左轮手枪快速装弹器，装有穿墙弹。"
	default_ammo = /datum/ammo/bullet/revolver/penetrating
	ammo_band_color = REVOLVER_TIP_COLOR_PENETRATING

/**
 * COLONY REVOLVERS
 */

/obj/item/ammo_magazine/revolver/pkd
	name = "\improper Plfager Katsuma stripper clip (.44)"
	desc = "翻开两侧的卡扣（PKL型号有三个），对准爆能枪的供弹口后推入。弹夹可重复使用。"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/revolvers.dmi'
	icon_state = "pkd_44"
	caliber = ".44 sabot"

/obj/item/ammo_magazine/revolver/upp
	name = "\improper ZHNK-72 speed loader (7.62x38mmR)"
	desc = "一个7发7.62x38mmR口径左轮手枪快速装弹器。"
	default_ammo = /datum/ammo/bullet/revolver/upp
	caliber = "7.62x38mmR"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/revolvers.dmi'
	icon_state = "zhnk72loader"
	gun_type = /obj/item/weapon/gun/revolver/upp

/obj/item/ammo_magazine/revolver/upp/shrapnel
	name = "\improper ZHNK-72 shrapnel-shot speed loader (7.62x38mmR)"
	desc = "这个快速装弹器装有七发‘破片弹’，由地上回收的廉价弹壳重新填充火药和随机金属碎屑制成。作用类似于箭弹。"
	default_ammo = /datum/ammo/bullet/revolver/upp/shrapnel
	icon_state = "zhnk72loader_shrapnel"

/obj/item/ammo_magazine/revolver/small
	name = "\improper S&W speed loader (.38)"
	desc = "一个6发.38口径左轮手枪快速装弹器。"
	default_ammo = /datum/ammo/bullet/revolver/small
	caliber = ".38"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/revolvers.dmi'
	icon_state = "38"
	max_rounds = 6
	gun_type = /obj/item/weapon/gun/revolver/small

/obj/item/ammo_magazine/revolver/cmb
	name = "\improper Spearhead hollowpoint speed loader (.357)"
	desc = "这个6发快速装弹器是为殖民地治安官最常配发的手枪而制，装有空尖弹，用于有野生动物问题的殖民地或轨道空间站。它们更倾向于较低的穿透力以减少船体破损的风险。作为交换，它们对有护甲的目标几乎无效，但在空间站上这又有多大可能成为问题呢？"
	default_ammo = /datum/ammo/bullet/revolver/small/hollowpoint
	caliber = ".357"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/revolvers.dmi'
	icon_state = "cmb_hp"
	max_rounds = 6
	gun_type = /obj/item/weapon/gun/revolver/cmb

/obj/item/ammo_magazine/revolver/cmb/normalpoint //put these in the marshal ert - ok sure :)
	name = "\improper Spearhead speed loader (.357)"
	desc = "这个6发快速装弹器装有标准的.357左轮手枪子弹。令人惊讶的稀有品，因为大多数CMB左轮手枪配发给殖民地治安官时都使用空尖弹，以应对有敌意野生动物的殖民地或船体薄弱的空间站。"
	default_ammo = /datum/ammo/bullet/revolver/small/cmb
	icon_state = "cmb"

/**
 * MATEBA REVOLVER
 */

/obj/item/ammo_magazine/revolver/mateba
	name = "\improper Unica 6 speed loader (.454)"
	desc = "为矛头独角兽6型自动左轮手枪特制的强力6发.454快速装弹器。威力惊人。此标准型号专为反护甲优化。"
	default_ammo = /datum/ammo/bullet/revolver/mateba
	caliber = ".454"
	icon_state = "mateba"
	max_rounds = 6
	gun_type = /obj/item/weapon/gun/revolver/mateba

/obj/item/ammo_magazine/revolver/mateba/highimpact
	name = "\improper High Impact Unica 6 speed loader (.454)"
	desc = "为矛头独角兽6型自动左轮手枪特制的强力6发.454快速装弹器。威力惊人。此高爆型号专为反人员优化。不要指向任何你不想摧毁的东西。"
	default_ammo = /datum/ammo/bullet/revolver/mateba/highimpact
	ammo_band_color = REVOLVER_TIP_COLOR_HIGH_IMPACT

/obj/item/ammo_magazine/revolver/mateba/highimpact/ap
	name = "\improper High Impact Armor-Piercing Unica 6 speed loader (.454)"
	desc = "为矛头独角兽6型自动左轮手枪特制的强力6发.454快速装弹器。威力惊人。此穿甲型号专为对抗装甲目标优化，但整体伤害较低。不要指向任何你不想摧毁的东西。"
	default_ammo = /datum/ammo/bullet/revolver/mateba/highimpact/ap
	ammo_band_color = REVOLVER_TIP_COLOR_HIAP

/obj/item/ammo_magazine/revolver/mateba/highimpact/explosive
	name = "\improper Unica 6 explosive speed loader (.454)"
	desc = "为矛头独角兽6型自动左轮手枪特制的强力6发.454快速装弹器。弹头内置冲击引信。向任何目标射击都会引发剧烈爆炸。请极度谨慎使用。"
	default_ammo = /datum/ammo/bullet/revolver/mateba/highimpact/explosive
	ammo_band_color = REVOLVER_TIP_COLOR_EXPLOSIVE

/**
 * WEBLEY REVOLVER
*/

/obj/item/ammo_magazine/revolver/webley
	name = "\improper Webley speed loader (.455)"
	desc = ".455韦伯利，最后一种像样的手枪口径。装填Mk III达姆弹，因为陆战队员不是人类，海牙公约不适用于他们。"
	default_ammo = /datum/ammo/bullet/revolver/webley
	caliber = ".455"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony/revolvers.dmi'
	icon_state = "357"
	max_rounds = 6
	gun_type = /obj/item/weapon/gun/revolver/m44/custom/webley

//INTERNAL MAGAZINES

//---------------------------------------------------

/obj/item/ammo_magazine/internal/revolver
	name = "左轮手枪弹巢"
	default_ammo = /datum/ammo/bullet/revolver
	max_rounds = 6
	gun_type = /obj/item/weapon/gun/revolver

//-------------------------------------------------------
//M44 MAGNUM REVOLVER //Not actually cannon, but close enough.

/obj/item/ammo_magazine/internal/revolver/m44
	caliber = ".44"
	max_rounds = 7
	gun_type = /obj/item/weapon/gun/revolver/m44

/obj/item/ammo_magazine/internal/revolver/m44/pkd
	max_rounds = 8
	caliber = ".44 sabot"

/obj/item/ammo_magazine/internal/revolver/m44/marksman
	default_ammo = /datum/ammo/bullet/revolver/marksman //because the starting m44 custom revolver belt is full of marksman ammo, but your gun would have normal ammo loaded

//-------------------------------------------------------
//RUSSIAN REVOLVER //Based on the 7.62mm Russian revolvers.

/obj/item/ammo_magazine/internal/revolver/upp
	default_ammo = /datum/ammo/bullet/revolver/upp
	caliber = "7.62x38mmR"
	max_rounds = 7
	gun_type = /obj/item/weapon/gun/revolver/upp

/obj/item/ammo_magazine/internal/revolver/upp/shrapnel
	default_ammo = /datum/ammo/bullet/revolver/upp/shrapnel


//-------------------------------------------------------
//357 REVOLVER //Based on the generic S&W 357.

/obj/item/ammo_magazine/internal/revolver/small
	default_ammo = /datum/ammo/bullet/revolver/small
	caliber = ".38"
	gun_type = /obj/item/weapon/gun/revolver/small

//-------------------------------------------------------
//BURST REVOLVER //Mateba(Unica) is pretty well known. The cylinder folds up instead of to the side.

/obj/item/ammo_magazine/internal/revolver/mateba
	default_ammo = /datum/ammo/bullet/revolver
	caliber = ".454"
	gun_type = /obj/item/weapon/gun/revolver/mateba

/obj/item/ammo_magazine/internal/revolver/mateba/impact
	default_ammo = /datum/ammo/bullet/revolver/mateba/highimpact

/obj/item/ammo_magazine/internal/revolver/mateba/ap
	default_ammo = /datum/ammo/bullet/revolver/mateba/highimpact/ap

/obj/item/ammo_magazine/internal/revolver/mateba/explosive
	default_ammo = /datum/ammo/bullet/revolver/mateba/highimpact/explosive

//-------------------------------------------------------
//MARSHALS REVOLVER //Spearhead exists in Alien cannon.

/obj/item/ammo_magazine/internal/revolver/cmb
	default_ammo = /datum/ammo/bullet/revolver/small/cmb
	caliber = ".357"
	gun_type = /obj/item/weapon/gun/revolver/cmb

/obj/item/ammo_magazine/internal/revolver/cmb/hollowpoint
	default_ammo = /datum/ammo/bullet/revolver/small/hollowpoint
	caliber = ".357"
	gun_type = /obj/item/weapon/gun/revolver/cmb

//-------------------------------------------------------
//BIG GAME HUNTER'S REVOLVER
/obj/item/ammo_magazine/internal/revolver/webley
	caliber = ".455"
	default_ammo = /datum/ammo/bullet/revolver/webley
	gun_type = /obj/item/weapon/gun/revolver/m44/custom/webley
