//Base pistol for inheritance/
//--------------------------------------------------

/obj/item/weapon/gun/pistol
	icon_state = "" //should return the honk-error sprite if there's no assigned icon.
	reload_sound = 'sound/weapons/flipblade.ogg'
	cocked_sound = 'sound/weapons/gun_pistol_cocked.ogg'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/guns.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/pistols.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/pistols_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/pistols_righthand.dmi'
	)
	mouse_pointer = 'icons/effects/mouse_pointer/pistol_mouse.dmi'

	matter = list("metal" = 2000)
	flags_equip_slot = SLOT_WAIST
	w_class = SIZE_MEDIUM
	force = 6
	movement_onehanded_acc_penalty_mult = 3
	wield_delay = WIELD_DELAY_VERY_FAST //If you modify your pistol to be two-handed, it will still be fast to aim
	fire_sound = "m4a3"
	firesound_volume = 25
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/suppressor/sleek,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/burstfire_assembly,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED //For easy reference.
	gun_category = GUN_CATEGORY_HANDGUN

/obj/item/weapon/gun/pistol/Initialize(mapload, spawn_empty)
	. = ..()
	if(current_mag && current_mag.current_rounds > 0)
		load_into_chamber()

/obj/item/weapon/gun/pistol/unique_action(mob/user)
		cock(user)

/obj/item/weapon/gun/pistol/set_gun_config_values()
	..()
	movement_onehanded_acc_penalty_mult = 3

//-------------------------------------------------------
//M4A3 PISTOL

/obj/item/weapon/gun/pistol/m4a3
	name = "\improper M4A3 service pistol"
	desc = "一把M4A3制式手枪，曾是殖民地海军陆战队的标准配发副武器，但最近已被88型4号战斗手枪取代。发射9毫米手枪弹。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/pistols.dmi'
	icon_state = "m4a3"
	item_state = "m4a3"
	current_mag = /obj/item/ammo_magazine/pistol
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/suppressor/sleek,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/burstfire_assembly,
	)

/obj/item/weapon/gun/pistol/m4a3/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/weapon/gun/pistol/m4a3/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 21, "under_x" = 21, "under_y" = 17, "stock_x" = 21, "stock_y" = 17)

/obj/item/weapon/gun/pistol/m4a3/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT

/obj/item/weapon/gun/pistol/m4a3/m4a4
	name = "\improper M4A4 service pistol"
	desc = "一把M4A4制式手枪，是USCM的标准配发副武器，是先前A3型号的升级版。发射9毫米手枪弹。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/pistols.dmi'
	icon_state = "m4a4"
	item_state = "m4a4"
	current_mag = /obj/item/ammo_magazine/pistol

/obj/item/weapon/gun/pistol/m4a3/m4a4/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 21,"rail_x" = 10, "rail_y" = 23, "under_x" = 21, "under_y" = 16, "stock_x" = 21, "stock_y" = 17)

/obj/item/weapon/gun/pistol/m4a3/training
	current_mag = /obj/item/ammo_magazine/pistol/rubber

/obj/item/weapon/gun/pistol/m4a3/tactical
	starting_attachment_types = list(/obj/item/attachable/suppressor, /obj/item/attachable/reflex, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/pistol/m4a3/custom
	name = "\improper M4A3 custom pistol"
	desc = "这把M4A3采用镀镍表面和仿象牙握把。这是由盖特威空间站一位知名枪匠生产的轻度定制型号。通常由那些薪水无处可花的低级士兵和初级军官购买。口径9毫米。"
	icon_state = "m4a3c"
	item_state = "m4a3c"

/obj/item/weapon/gun/pistol/m4a3/custom/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT


//-------------------------------------------------------
//M4A3 45 //Inspired by the 1911
//deprecated

/obj/item/weapon/gun/pistol/m1911
	name = "\improper M1911 service pistol"
	desc = "自第一次世界大战以来的永恒经典，由阿玛特战场系统公司在收购柯尔特制造公司后限量生产。曾是USCM的标准配发武器，现已仅接受预订。口径.45 ACP。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/pistols.dmi'
	icon_state = "m4a345"
	item_state = "m4a3"
	current_mag = /obj/item/ammo_magazine/pistol/m1911

/obj/item/weapon/gun/pistol/m1911/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/weapon/gun/pistol/m1911/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 22, "under_x" = 21, "under_y" = 17, "stock_x" = 21, "stock_y" = 17)

/obj/item/weapon/gun/pistol/m1911/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5

/obj/item/weapon/gun/pistol/m1911/socom
	name = "\improper M48A4 service pistol"
	desc = "自第一次世界大战以来的永恒经典，M1911A1在USCM中应用有限，因其可靠性常被非政府组织用作副武器。这是现代化版本，带有弹药计数器和聚合物握把，型号为M48A4。口径.45 ACP。"
	icon_state = "m4a345_s"
	item_state = "m4a3"
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER

/obj/item/weapon/gun/pistol/m1911/socom/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5

/obj/item/weapon/gun/pistol/m1911/socom/equipped
	starting_attachment_types = list(/obj/item/attachable/suppressor, /obj/item/attachable/lasersight, /obj/item/attachable/reflex)

/obj/item/weapon/gun/pistol/m1911/custom
	name = "\improper M1911C service pistol"
	desc = "USCM指挥单位使用的传奇M1911手枪变体。基于现代化的M48A4，其外形经过修改以更接近经典M1911，同时保留了现代技术特征，如隐蔽的弹药计数器。口径.45 ACP。"
	icon_state = "m1911c"
	item_state = "m4a3"
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER
	current_mag = /obj/item/ammo_magazine/pistol/m1911/highimpact

/obj/item/weapon/gun/pistol/m1911/custom/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5

/obj/item/weapon/gun/pistol/m1911/custom/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 20, "rail_x" = 10, "rail_y" = 22, "under_x" = 21, "under_y" = 15, "stock_x" = 21, "stock_y" = 17)

/obj/item/weapon/gun/pistol/m1911/custom/unique_action(mob/user)
	if(fire_into_air(user))
		return ..()

//-------------------------------------------------------
//Beretta 92FS, the gun McClane carries around in Die Hard. Very similar to the service pistol, all around.

/obj/item/weapon/gun/pistol/b92fs
	name = "\improper Beretta 92FS pistol"
	desc = "20世纪流行的警用枪械，常被硬汉警察用于对抗恐怖分子。时代的经典，口径9毫米。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/pistols.dmi'
	icon_state = "b92fs"
	item_state = "b92fs"
	current_mag = /obj/item/ammo_magazine/pistol/b92fs

/obj/item/weapon/gun/pistol/b92fs/Initialize(mapload, spawn_empty)
	. = ..()
	if(prob(10))
		name = "\improper Beretta 93FR burst pistol"
		desc += " This specific pistol is a burst-fire, limited availability, police-issue 93FR type Beretta. Not too accurate, aftermarket modififcations are recommended."
		var/obj/item/attachable/burstfire_assembly/BFA = new(src)
		BFA.flags_attach_features &= ~ATTACH_REMOVABLE
		BFA.Attach(src)
		update_attachable(BFA.slot)
		add_firemode(GUN_FIREMODE_BURSTFIRE)

/obj/item/weapon/gun/pistol/b92fs/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 22, "under_x" = 21, "under_y" = 17, "stock_x" = 21, "stock_y" = 17)

/obj/item/weapon/gun/pistol/b92fs/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_7
	burst_scatter_mult = SCATTER_AMOUNT_TIER_5
	scatter_unwielded = SCATTER_AMOUNT_TIER_7
	damage_mult = BASE_BULLET_DAMAGE_MULT - BULLET_DAMAGE_MULT_TIER_2


//-------------------------------------------------------
//DEAGLE //This one is obvious.

/obj/item/weapon/gun/pistol/heavy
	name = "\improper Desert Eagle"
	desc = "The handcannon that needs no introduction, the Desert Eagle is expensive, unwieldy, and extremely heavy for a pistol. However, it more than makes up for its weighty build \
	with its powerful shots, capable of stopping a human, or even a bear, dead in their tracks."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/pistols.dmi'
	icon_state = "deagle"
	item_state = "deagle"
	fire_sound = 'sound/weapons/gun_DE50.ogg'
	firesound_volume = 40
	current_mag = /obj/item/ammo_magazine/pistol/heavy
	force = 13

	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/compensator,
	)

/obj/item/weapon/gun/pistol/heavy/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 31, "muzzle_y" = 20, "rail_x" = 17, "rail_y" = 22, "under_x" = 21, "under_y" = 15, "stock_x" = 20, "stock_y" = 17)


/obj/item/weapon/gun/pistol/heavy/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_5)
	set_burst_amount(BURST_AMOUNT_TIER_2)
	set_burst_delay(FIRE_DELAY_TIER_8)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_5
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_1
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_3

/obj/item/weapon/gun/pistol/heavy/co
	name = "抛光沙漠之鹰"
	icon_state = "c_deagle"
	item_state = "c_deagle"
	current_mag = /obj/item/ammo_magazine/pistol/heavy/super/highimpact
	black_market_value = 100
	unacidable = TRUE
	explo_proof = TRUE

/obj/item/weapon/gun/pistol/heavy/co/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_5)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_5
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_4
	scatter_unwielded = SCATTER_AMOUNT_TIER_3
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_8
	recoil = RECOIL_AMOUNT_TIER_3
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/pistol/heavy/co/unique_action(mob/user)
	if(fire_into_air(user))
		return ..()

/obj/item/weapon/gun/pistol/heavy/co/gold
	name = "金色复古沙漠之鹰"
	desc = "一把镀金阳极氧化并饰有红木握把的沙漠之鹰。炫耀的代名词，它华丽、笨重、极其沉重，后坐力如骡子踢腿。但作为权力的象征，无出其右。"
	icon_state = "g_deagle"
	item_state = "g_deagle"

//-------------------------------------------------------
//NP92 pistol
//Its a makarov

/obj/item/weapon/gun/pistol/np92
	name = "\improper NP92 pistol"
	desc = "UPP的标准配发副武器。NP92是一款小巧但威力强大的副武器，深受大多数配发人员的喜爱，尽管有些人更喜欢它旨在取代的73式手枪。使用12发弹匣。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/UPP/pistols.dmi'
	icon_state = "np92"
	item_state = "np92"
	fire_sound = "88m4"
	current_mag = /obj/item/ammo_magazine/pistol/np92
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/suppressor/sleek,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
	)

/obj/item/weapon/gun/pistol/np92/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/norcomm)

/obj/item/weapon/gun/pistol/np92/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 27, "muzzle_y" = 20,"rail_x" = 13, "rail_y" = 22, "under_x" = 21, "under_y" = 18, "stock_x" = 21, "stock_y" = 18)

/obj/item/weapon/gun/pistol/np92/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_3

/obj/item/weapon/gun/pistol/np92/suppressed
	name = "\improper NPZ92 pistol"
	desc = "NPZ92是NP92的版本，包含一个集成消音器，限量配发给科曼多部队。"
	icon_state = "npz92"
	item_state = "npz92"
	inherent_traits = list(TRAIT_GUN_SILENCED)
	fire_sound = "gun_silenced"
	current_mag = /obj/item/ammo_magazine/pistol/np92/suppressed
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
	)

/obj/item/weapon/gun/pistol/np92/suppressed/tranq
	current_mag = /obj/item/ammo_magazine/pistol/np92/tranq

//-------------------------------------------------------
//Type 73 pistol
//Its a TT

/obj/item/weapon/gun/pistol/t73
	name = "\improper Type 73 pistol"
	desc = "73式曾是UPP的标准配发副武器。在UPP中被NP92取代，但由于熟悉感和额外威力，它仍然受UPP老兵欢迎。由于产量极大，它们往往最终落入那些预算有限、试图武装自己的部队手中。使用者包括进步人民联盟、殖民地解放阵线，以及几乎所有的雇佣兵或海盗团体。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/UPP/pistols.dmi'
	icon_state = "tt"
	item_state = "tt"
	fire_sound = 'sound/weapons/gun_tt.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/t73
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/suppressor/sleek,
	)

/obj/item/weapon/gun/pistol/t73/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/norcomm)

/obj/item/weapon/gun/pistol/t73/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 13, "rail_y" = 22, "under_x" = 22, "under_y" = 15, "stock_x" = 21, "stock_y" = 18)

/obj/item/weapon/gun/pistol/t73/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_6


/obj/item/weapon/gun/pistol/t73/leader
	name = "\improper Type 74 pistol"
	desc = "74式是经过特殊改装的73式型号，配有集成激光瞄准系统、多处减重闪电槽以允许使用更高膛压弹药而保持相同后坐力弹簧，以及更舒适的握把。由于NP92的采用，74式产量有限，因此通常仅应高级军官要求配发。"
	icon_state = "ttb"
	item_state = "ttb"
	current_mag = /obj/item/ammo_magazine/pistol/t73_impact
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER
	accepted_ammo = list(
		/obj/item/ammo_magazine/pistol/t73,
		/obj/item/ammo_magazine/pistol/t73_impact,
	)

	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/suppressor/sleek,
		/obj/item/attachable/heavy_barrel,
	)

/obj/item/weapon/gun/pistol/t73/leader/handle_starting_attachment()
	..()
	var/obj/item/attachable/lasersight/TT = new(src)
	TT.flags_attach_features &= ~ATTACH_REMOVABLE
	TT.hidden = TRUE
	TT.Attach(src)
	update_attachable(TT.slot)

/obj/item/weapon/gun/pistol/t73/leader/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_6
	accuracy_mult_unwielded = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_6
	scatter = SCATTER_AMOUNT_TIER_7
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_7
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_6

//-------------------------------------------------------
//KT-42 //Inspired by the .44 Auto Mag pistol
// rebalanced - slightly worse stats than the 88 mod, but uses heavy pistol bullets.

/obj/item/weapon/gun/pistol/kt42
	name = "\improper KT-42 automag"
	desc = "KT-42自动马格南是一款古老但可靠的设计，可追溯至数十年前。有许多版本和变体，但42型是目前最常见的。这款手持火炮绝不会错。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/pistols.dmi'
	icon_state = "kt42"
	item_state = "kt42"
	fire_sound = 'sound/weapons/gun_kt42.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/kt42

/obj/item/weapon/gun/pistol/kt42/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 20,"rail_x" = 8, "rail_y" = 22, "under_x" = 22, "under_y" = 17, "stock_x" = 22, "stock_y" = 17)

/obj/item/weapon/gun/pistol/kt42/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_1
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_5
	damage_mult = BASE_BULLET_DAMAGE_MULT


//-------------------------------------------------------
//W62 'Whisper' //.22 plinker made by Spearhead Armory

/obj/item/weapon/gun/pistol/holdout
	name = "W62‘耳语’手枪"
	desc = "一把由矛头公司制造的.22LR口径小型靶枪。设计用于打靶或安静地处理星际害虫。集成消音器，机械瞄具标配氚光涂料。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/pistols.dmi'
	icon_state = "whisper"
	item_state = "whisper"
	fire_sound = 'sound/weapons/gun_pistol_holdout.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/holdout
	w_class = SIZE_SMALL
	force = 2
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/lasersight,
	)

/obj/item/weapon/gun/pistol/holdout/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/spearhead)

/obj/item/weapon/gun/pistol/holdout/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 25, "muzzle_y" = 20,"rail_x" = 6, "rail_y" = 20, "under_x" = 20, "under_y" = 17, "stock_x" = 22, "stock_y" = 17)

/obj/item/weapon/gun/pistol/holdout/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT

/obj/item/weapon/gun/pistol/holdout/handle_starting_attachment()
	..()
	var/obj/item/attachable/suppressor/S = new(src)
	S.hidden = TRUE
	S.flags_attach_features &= ~ATTACH_REMOVABLE
	S.Attach(src)
	update_attachable(S.slot)

/obj/item/weapon/gun/pistol/holdout/custom
	name = "W62‘耳语’定制手枪"
	desc = "一把由矛头公司制造的.22LR口径小型靶枪。设计用于打靶或安静地处理星际害虫。这把定制了象牙握把板和蓝钢表面处理。"
	icon_state = "whisperc"
	item_state = "whisperc"


//-------------------------------------------------------
//AC71 'Action' // .380 ACP pocket pistol made by Spearhead Armory

/obj/item/weapon/gun/pistol/action
	name = "AC71‘行动’隐藏手枪"
	desc = "一把由矛头军械厂制造的.380 ACP手枪。常被执法官用作备用武器。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/pistols.dmi'
	icon_state = "action"
	item_state = "action"
	fire_sound = 'sound/weapons/gun_pistol_380acp.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/action
	w_class = SIZE_TINY
	force = 4
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
	)

/obj/item/weapon/gun/pistol/action/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/spearhead)

/obj/item/weapon/gun/pistol/action/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT

/obj/item/weapon/gun/pistol/action/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 24, "muzzle_y" = 17,"rail_x" = 12, "rail_y" = 18, "under_x" = 17, "under_y" = 14, "stock_x" = 22, "stock_y" = 17)

//-------------------------------------------------------
//CLF HOLDOUT PISTOL
/obj/item/weapon/gun/pistol/clfpistol
	name = "D18蜂鸟手枪"
	desc = "D18蜂鸟手枪于2170年代中期生产，作为CLF休眠特工用于刺杀和伏击的廉价隐蔽枪械，可藏于鞋和工作靴中。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/pistols.dmi'
	icon_state = "m43"
	item_state = "m43"
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED
	fire_sound = 'sound/weapons/gun_m43.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/clfpistol
	w_class = SIZE_TINY
	force = 5
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/suppressor/sleek,
		/obj/item/attachable/flashlight/under_barrel, // not like it matters lol
		/obj/item/attachable/flashlight,
	)

/obj/item/weapon/gun/pistol/clfpistol/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 21, "under_x" = 21, "under_y" = 17, "stock_x" = 21, "stock_y" = 17)

/obj/item/weapon/gun/pistol/clfpistol/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_5
	scatter_unwielded = SCATTER_AMOUNT_TIER_8
	scatter = SCATTER_AMOUNT_TIER_9
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_4

//-------------------------------------------------------
//.45 MARSHALS PISTOL //Inspired by the Browning Hipower
// rebalanced - singlefire, very strong bullets but slow to fire and heavy recoil
// redesigned - now rejected USCM sidearm model, utilized by Colonial Marshals and other stray groups.

/obj/item/weapon/gun/pistol/highpower
	name = "\improper MK-45 'High-Power' Automagnum"
	desc = "最初设计用于取代USCM的M44战斗左轮手枪，但在最后一刻被委员会否决，理由是每次装填弹匣后都需要扳动击锤，过于繁琐和过时。该设计最近被亨金-加西亚公司收购，改装为.45 ACP口径，并出售给殖民地执法官及其他各种无良武装团体。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/pistols.dmi'
	icon_state = "highpower"
	item_state = "highpower"
	fire_sound = 'sound/weapons/gun_kt42.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/highpower
	force = 15
	attachable_allowed = list(
		/obj/item/attachable/suppressor, // Barrel
		/obj/item/attachable/suppressor/sleek,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp_replica,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/bayonet/custom,
		/obj/item/attachable/bayonet/custom/red,
		/obj/item/attachable/bayonet/custom/blue,
		/obj/item/attachable/bayonet/custom/black,
		/obj/item/attachable/bayonet/tanto,
		/obj/item/attachable/bayonet/tanto/blue,
		/obj/item/attachable/bayonet/rmc_replica,
		/obj/item/attachable/bayonet/rmc,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot, // Rail
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/gyro, // Under
		/obj/item/attachable/lasersight,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/flashlight/under_barrel,
	)
	/// This weapon needs to be manually racked every time a new magazine is loaded. I tried and failed to touch gun shitcode so this will do.
	var/manually_slided = FALSE

/obj/item/weapon/gun/pistol/highpower/Initialize(mapload, spawn_empty)
	. = ..()
	manually_slided = TRUE
	AddElement(/datum/element/corp_label/henjin_garcia)

/obj/item/weapon/gun/pistol/highpower/Fire(atom/target, mob/living/user, params, reflex = 0, dual_wield)
	if(!manually_slided)
		click_empty()
		to_chat(user, SPAN_DANGER("\The [src] makes a clicking noise! You need to manually rack the slide after loading in a new magazine!"))
		return NONE
	return ..()

/obj/item/weapon/gun/pistol/highpower/unique_action(mob/user)
	if(!manually_slided)
		user.visible_message(SPAN_NOTICE("[user] 拉动了 \the [src] 的套筒。"), SPAN_NOTICE("You rack \the [src]'s slide, loading the next bullet in."))
		manually_slided = TRUE
		cock_gun(user, TRUE)
		return
	..()

/obj/item/weapon/gun/pistol/highpower/cock_gun(mob/user, manual = FALSE)
	if(manual)
		..()
	else
		return

/obj/item/weapon/gun/pistol/highpower/reload(mob/user, obj/item/ammo_magazine/magazine)
	//reset every time its reloaded
	manually_slided = FALSE
	..()

/obj/item/weapon/gun/pistol/highpower/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 20,"rail_x" = 6, "rail_y" = 22, "under_x" = 20, "under_y" = 15, "stock_x" = 0, "stock_y" = 0)

/obj/item/weapon/gun/pistol/highpower/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_5)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_3
	scatter = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_8
	recoil = RECOIL_AMOUNT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_4

//also comes in.... BLAPCK
//the parent has a blueish tint, making it look best for civilian usage (colonies, marshals). this one has a black tint on its metal, making it best for military groups like VAIPO, elite mercs, etc.
// black tinted magazines also included
/obj/item/weapon/gun/pistol/highpower/black
	current_mag = /obj/item/ammo_magazine/pistol/highpower/black
	icon_state = "highpower_b"
	item_state = "highpower_b"

//unimplemented
/obj/item/weapon/gun/pistol/highpower/tactical
	name = "\improper MK-44 SOCOM Automagnum"
	desc = "最初设计作为USCM M44战斗左轮手枪的替代品，但在最后一刻被委员会否决，理由是每次装填弹匣后都需要手动击锤待击，被认为过于繁琐和过时。该设计最近被Henjin-Garcia公司收购，并出售给殖民地执法官及其他各种无良武装团体。这把枪采用光滑的深色设计。"
	current_mag = /obj/item/ammo_magazine/pistol/highpower/black
	icon_state = "highpower_tac"
	item_state = "highpower_tac"
	starting_attachment_types = list(/obj/item/attachable/suppressor, /obj/item/attachable/lasersight, /obj/item/attachable/reflex)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER



//-------------------------------------------------------
//mod88 based off VP70 - Counterpart to M1911, offers burst and capacity ine exchange of low accuracy and damage.

/obj/item/weapon/gun/pistol/mod88
	name = "\improper 88 Mod 4 combat pistol"
	desc = "USCM标准配发枪械。也常见于维兰德-汤谷PMC小队手中。发射9毫米穿甲弹，并具备三连发功能。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/WY/pistols.dmi'
	icon_state = "_88m4" // to comply with css standards
	item_state = "_88m4"
	fire_sound = "88m4"
	firesound_volume = 20
	reload_sound = 'sound/weapons/gun_88m4_reload.ogg'
	unload_sound = 'sound/weapons/gun_88m4_unload.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/mod88
	force = 8
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/suppressor/sleek,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/reflex,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/stock/mod88,
	)

/obj/item/weapon/gun/pistol/mod88/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/weapon/gun/pistol/mod88/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 27, "muzzle_y" = 21,"rail_x" = 8, "rail_y" = 22, "under_x" = 21, "under_y" = 18, "stock_x" = 18, "stock_y" = 15)

/obj/item/weapon/gun/pistol/mod88/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_7
	burst_scatter_mult = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_7
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_4


/obj/item/weapon/gun/pistol/mod88/training
	current_mag = /obj/item/ammo_magazine/pistol/mod88/rubber


/obj/item/weapon/gun/pistol/mod88/flashlight/handle_starting_attachment()
	..()
	var/obj/item/attachable/flashlight/flashlight = new(src)
	flashlight.Attach(src)
	update_attachable(flashlight.slot)

//-------------------------------------------------------
// ES-4 - Basically a CL-exclusive reskin of the 88 mod 4 that only uses less-lethal ammo.

/obj/item/weapon/gun/pistol/es4
	name = "\improper ES-4 electrostatic pistol"
	desc = "一款维兰德公司制造的非致命手枪。最初于2080年代生产，ES-4静电手枪能高精度地发射带电子弹，但其高昂的成本和持续的清洁需求使其十分罕见。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/WY/pistols.dmi'
	icon_state = "es4"
	item_state = "es4"
	fire_sound = 'sound/weapons/gun_es4.ogg'
	firesound_volume = 20
	reload_sound = 'sound/weapons/gun_88m4_reload.ogg'
	unload_sound = 'sound/weapons/gun_88m4_unload.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/es4
	force = 8
	muzzle_flash = "muzzle_energy"
	muzzle_flash_color = COLOR_MUZZLE_BLUE
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER
	attachable_allowed = list(
		/obj/item/attachable/flashlight,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/lasersight,
	)

/obj/item/weapon/gun/pistol/es4/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/weapon/gun/pistol/es4/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 27, "muzzle_y" = 21, "rail_x" = 10, "rail_y" = 22, "under_x" = 25, "under_y" = 18, "stock_x" = 18, "stock_y" = 15)

/obj/item/weapon/gun/pistol/es4/set_gun_config_values()
	..()
	fire_delay = FIRE_DELAY_TIER_11
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_7
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_4

//-------------------------------------------------------
//VP78 - the only pistol viable as a primary.

/obj/item/weapon/gun/pistol/vp78
	name = "\improper VP78 pistol"
	desc = "一款庞大、令人生畏的半自动手枪，使用9毫米碎甲弹。在UA和3WE星域都很常见，通常由维兰德-汤谷PMC部队和公司高管持有。该武器也正作为USCM下一代手枪计划的一部分进行有限的实地测试。套筒上刻有维兰德-汤谷的标志，提醒你谁才是真正的主宰。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/WY/pistols.dmi'
	icon_state = "vp78"
	item_state = "vp78"

	fire_sound = 'sound/weapons/gun_vp78_v2.ogg'
	reload_sound = 'sound/weapons/gun_vp78_reload.ogg'
	unload_sound = 'sound/weapons/gun_vp78_unload.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/vp78
	force = 8
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/suppressor/sleek,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight, // look its kinda strange why you would list these as allowed when the vp-78 has an integrated flashlight, but flashlight attachment code does have a warning for this so yknow whatever really
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/flashlight/laser_light_combo,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
	)

/obj/item/weapon/gun/pistol/vp78/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/weapon/gun/pistol/vp78/handle_starting_attachment()
	..()
	var/obj/item/attachable/flashlight/laser_light_combo/VP = new(src)
	VP.flags_attach_features &= ~ATTACH_REMOVABLE
	VP.hidden = FALSE
	VP.Attach(src)
	update_attachable(VP.slot)

/obj/item/weapon/gun/pistol/vp78/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 22,"rail_x" = 10, "rail_y" = 23, "under_x" = 20, "under_y" = 17, "stock_x" = 18, "stock_y" = 14)

/obj/item/weapon/gun/pistol/vp78/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_7)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_4

/obj/item/weapon/gun/pistol/vp78/whiteout
	starting_attachment_types = list(/obj/item/attachable/heavy_barrel, /obj/item/attachable/reflex)


//-------------------------------------------------------
/*
Auto 9 The gun RoboCop uses. A better version of the VP78, with more rounds per magazine. Probably the best pistol around, but takes no attachments.
It is a modified Beretta 93R, and can fire three-round burst or single fire. Whether or not anyone else aside RoboCop can use it is not established.
*/

/obj/item/weapon/gun/pistol/auto9
	name = "\improper Auto-9 pistol"
	desc = "一款先进、可选射击模式的冲锋手枪，具备三连发功能。上次出现是在清理底特律的险恶街头。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/event.dmi'
	icon_state = "auto9"
	item_state = "auto9"

	fire_sound = 'sound/weapons/gun_pistol_large.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/auto9
	force = 15

/obj/item/weapon/gun/pistol/auto9/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_7)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_3



//-------------------------------------------------------
//The first rule of monkey pistol is we don't talk about monkey pistol.

/obj/item/weapon/gun/pistol/chimp
	name = "\improper CHIMP70 pistol"
	desc = "一款威力强大的手枪，主要配发给训练有素的精英刺客-赛博特工。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/event.dmi'
	icon_state = "c70"
	item_state = "c70"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/misc_weapons_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/misc_weapons_righthand.dmi',
		)
	current_mag = /obj/item/ammo_magazine/pistol/chimp
	fire_sound = 'sound/weapons/gun_chimp70.ogg'
	w_class = SIZE_MEDIUM
	force = 8
	flags_gun_features = GUN_AUTO_EJECTOR

/obj/item/weapon/gun/pistol/chimp/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_9)
	set_burst_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_2)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT


//-------------------------------------------------------
//Smartpistol. An IFF pistol, pretty much.

/obj/item/weapon/gun/pistol/smart
	name = "\improper SU-6 Smartpistol"
	desc = "SU-6智能手枪是一款基于敌我识别（IFF）的手枪，目前正在殖民地海军陆战队进行实地测试。使用改进的.45 ACP IFF子弹。能够进行连发射击。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/pistols.dmi'
	icon_state = "smartpistol"
	item_state = "smartpistol"
	force = 8
	current_mag = /obj/item/ammo_magazine/pistol/smart
	fire_sound = 'sound/weapons/gun_su6.ogg'
	reload_sound = 'sound/weapons/handling/gun_su6_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_su6_unload.ogg'
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER

/obj/item/weapon/gun/pistol/smart/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 13, "rail_y" = 22, "under_x" = 24, "under_y" = 17, "stock_x" = 24, "stock_y" = 17)

/obj/item/weapon/gun/pistol/smart/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_4

/obj/item/weapon/gun/pistol/smart/set_bullet_traits()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

//-------------------------------------------------------
//SKORPION //Based on the same thing.

/obj/item/weapon/gun/pistol/skorpion
	name = "\improper CZ-81 machine pistol"
	desc = "一款坚固耐用的20世纪枪械，结合了手枪和冲锋枪的特点。使用.32ACP口径子弹，弹匣容量20发。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/smgs.dmi'
	icon_state = "skorpion"
	item_state = "skorpion"
	item_icons = list(
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/smgs.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/smgs_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/smgs_righthand.dmi'
	)
	fire_sound = 'sound/weapons/gun_skorpion.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/skorpion
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED
	attachable_allowed = list(
		/obj/item/attachable/reddot, //Rail
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/suppressor, //Muzzle
		/obj/item/attachable/suppressor/sleek,
		/obj/item/attachable/compensator,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/lasersight, //Underbarrel
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/flashlight/under_barrel,
	)
	start_semiauto = FALSE
	start_automatic = TRUE

/obj/item/weapon/gun/pistol/skorpion/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 18,"rail_x" = 16, "rail_y" = 21, "under_x" = 23, "under_y" = 15, "stock_x" = 23, "stock_y" = 15)

/obj/item/weapon/gun/pistol/skorpion/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	fa_scatter_peak = 15 //shots
	fa_max_scatter = SCATTER_AMOUNT_TIER_5

	accuracy_mult = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_7
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2

//-------------------------------------------------------
/*
M10 Auto Pistol: A compact machine pistol that sacrifices accuracy for an impressive fire rate, shredding close-range targets with ease.
With a 40-round magazine, it can keep up sustained fire in tense situations, though its high recoil and low stability make it tricky to control.
Unlike other pistols, it can be equipped with limited mods (small muzzle, underbarrel laser, magazine, and optics) but has no burst-fire option.
*/

/obj/item/weapon/gun/pistol/m10
	name = "\improper M10 auto pistol"
	desc = "阿玛特战场系统M10自动手枪，一款紧凑、射速快的随身武器，专为近距离防御设计。配备40发弹匣，强调射速而非精度，能在短距离交火中提供有效的压制火力。"
	icon = 'icons/obj/items/weapons/guns/guns_by_map/classic/guns_obj.dmi'
	icon_state = "m10"
	item_state = "m10"
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small, //Rail
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/suppressor, //Muzzle
		/obj/item/attachable/suppressor/sleek,
		/obj/item/attachable/compensator/m10, // Special M10 compensator
		/obj/item/attachable/compensator/m10/spiked, // Special M10 compensator - Melee version
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/stock/pistol/collapsible, //Stock
		/obj/item/attachable/stock/m10_solid,
		/obj/item/attachable/lasersight/micro, //Underbarrel
		/obj/item/attachable/flashlight/under_barrel,
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER
	start_automatic = TRUE
	map_specific_decoration = TRUE
	fire_sound = null
	fire_sounds = list('sound/weapons/gun_m10_auto_pistol.ogg', 'sound/weapons/gun_m10_auto_pistol2.ogg')
	reload_sound = 'sound/weapons/handling/gun_m10_auto_pistol_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_m10_auto_pistol_unload.ogg'

	current_mag = /obj/item/ammo_magazine/pistol/m10

/obj/item/weapon/gun/pistol/m10/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/weapon/gun/pistol/m10/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 25, "muzzle_y" = 19,"rail_x" = 11, "rail_y" = 21, "under_x" = 18, "under_y" = 15, "stock_x" = 25, "stock_y" = 17)

/obj/item/weapon/gun/pistol/m10/set_gun_config_values()
	..()
	set_burst_amount(0)
	set_fire_delay(FIRE_DELAY_TIER_12)
	fa_scatter_peak = FULL_AUTO_SCATTER_PEAK_TIER_4
	fa_max_scatter = SCATTER_AMOUNT_TIER_7
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	scatter = SCATTER_AMOUNT_TIER_5
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_5
	damage_mult = BASE_BULLET_DAMAGE_MULT - BULLET_DAMAGE_MULT_TIER_5

//-------------------------------------------------------
/*

L54 service pistol

*/

/obj/item/weapon/gun/pistol/l54
	name = "\improper L54 service pistol"
	desc = "NSPA标准配发的半自动制式手枪。使用9毫米口径，可与USCM广泛使用的M4A3手枪相媲美。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/TWE/pistols.dmi'
	icon_state = "l54"
	item_state = "l54"
	fire_sound = 'sound/weapons/gun_vp78_v2.ogg'
	reload_sound = 'sound/weapons/gun_vp78_reload.ogg'
	unload_sound = 'sound/weapons/gun_vp78_unload.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/l54
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/suppressor/sleek,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/burstfire_assembly,
	)

/obj/item/weapon/gun/pistol/l54/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 21, "under_x" = 21, "under_y" = 17, "stock_x" = 21, "stock_y" = 17)

/obj/item/weapon/gun/pistol/l54/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT

/obj/item/weapon/gun/pistol/l54_custom
	name = "\improper L54 custom service pistol"
	desc = "NSPA及三世界帝国内各军事力量的标准配发半自动手枪，使用9毫米口径。功能上可与USCM的M4A3制式手枪相媲美，但这把样品经过了深度定制——采用金合金涂层、带一体式制退器的加长枪管、精密调校的内部结构以及自动退壳功能。这些改装使其性能远超标准制式规格。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/TWE/pistols.dmi'
	icon_state = "l54_custom"
	item_state = "l54_custom"
	current_mag = /obj/item/ammo_magazine/pistol/l54_custom
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/burstfire_assembly,
	)

/obj/item/weapon/gun/pistol/l54_custom/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 21, "under_x" = 21, "under_y" = 17, "stock_x" = 21, "stock_y" = 17)

/obj/item/weapon/gun/pistol/l54_custom/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AUTO_EJECTOR

/obj/item/weapon/gun/pistol/l54_custom/alt
	desc = "NSPA及三世界帝国内各军事力量的标准配发半自动手枪，使用9毫米口径。功能上可与USCM的M4A3制式手枪相媲美，但这把样品经过了深度定制——采用深色特种合金涂层、带一体式制退器的加长枪管、精密调校的内部结构以及自动退壳功能。这些改装使其性能远超标准制式规格。"
	icon_state = "l54_custom_alt"
	item_state = "l54_custom_alt"
