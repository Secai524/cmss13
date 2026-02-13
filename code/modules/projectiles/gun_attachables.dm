//Gun attachable items code. Lets you add various effects to firearms.
//Some attachables are hardcoded in the projectile firing system, like grenade launchers, flamethrowers.
/*
When you are adding new guns into the attachment list, or even old guns, make sure that said guns
properly accept overlays. You can find the proper offsets in the individual gun dms, so make sure
you set them right. It's a pain to go back to find which guns are set incorrectly.
To summarize: rail attachments should go on top of the rail. For rifles, this usually means the middle of the gun.
For handguns, this is usually toward the back of the gun. SMGs usually follow rifles.
Muzzle attachments should connect to the barrel, not sit under or above it. The only exception is the bayonet.
Underrail attachments should just fit snugly, that's about it. Stocks are pretty obvious.

All attachment offsets are now in a list, including stocks. Guns that don't take attachments can keep the list null.
~N

Defined in conflicts.dm of the #defines folder.
#define ATTACH_REMOVABLE 1
#define ATTACH_ACTIVATION 2
#define ATTACH_PROJECTILE 4
#define ATTACH_RELOADABLE 8
#define ATTACH_WEAPON 16
*/

/obj/item/attachable
	name = "附件物品"
	desc = "这是一个非常理论化的附件概念。你本不该看到这个。"
	icon = 'icons/obj/items/weapons/guns/attachments/barrel.dmi'
	icon_state = null
	item_state = null
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/devices_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/devices_righthand.dmi'
	)
	var/attach_icon //the sprite to show when the attachment is attached when we want it different from the icon_state.
	var/pixel_shift_x = 16 //Determines the amount of pixels to move the icon state for the overlay.
	var/pixel_shift_y = 16 //Uses the bottom left corner of the item.

	flags_atom = FPRINT|CONDUCT|MAP_COLOR_INDEX
	matter = list("metal" = 100)
	w_class = SIZE_SMALL
	force = 1
	var/slot = null //"muzzle", "rail", "under", "stock", "special", "cosmetic"

	/*
	Anything that isn't used as the gun fires should be a flat number, never a percentange. It screws with the calculations,
	and can mean that the order you attach something/detach something will matter in the final number. It's also completely
	inaccurate. Don't worry if force is ever negative, it won't runtime.
	*/
	//These bonuses are applied only as the gun fires a projectile.

	//These are flat bonuses applied and are passive, though they may be applied at different points.
	var/accuracy_mod = 0 //Modifier to firing accuracy, works off a multiplier.
	var/accuracy_unwielded_mod = 0 //same as above but for onehanded.
	var/damage_mod = 0 //Modifer to the damage mult, works off a multiplier.
	var/damage_falloff_mod = 0 //Modifier to damage falloff, works off a multiplier.
	var/damage_buildup_mod = 0 //Modifier to damage buildup, works off a multiplier.
	var/range_min_mod = 0 //Modifier to minimum effective range, tile value.
	var/range_max_mod = 0 //Modifier to maximum effective range, tile value.
	var/projectile_max_range_mod = 0 //Modifier to how far the projectile can travel in tiles.
	var/melee_mod = 0 //Changing to a flat number so this actually doesn't screw up the calculations.
	var/scatter_mod = 0 //Increases or decreases scatter chance.
	var/scatter_unwielded_mod = 0 //same as above but for onehanded firing.
	var/bonus_proj_scatter_mod = 0 //Increses or decrease scatter for bonus projectiles. Mainly used for shotguns.
	var/recoil_mod = 0 //If positive, adds recoil, if negative, lowers it. Recoil can't go below 0.
	var/recoil_unwielded_mod = 0 //same as above but for onehanded firing.
	var/burst_scatter_mod = 0 //Modifier to scatter from wielded burst fire, works off a multiplier.
	var/light_mod = 0 //Adds an x-brightness flashlight to the weapon, which can be toggled on and off.
	var/delay_mod = 0 //Changes firing delay. Cannot go below 0.
	var/burst_mod = 0 //Changes burst rate. 1 == 0.
	var/size_mod = 0 //Increases the weight class.
	var/aim_speed_mod = 0 //Changes the aiming speed slowdown of the wearer by this value.
	var/wield_delay_mod = 0 //How long ADS takes (time before firing)
	var/movement_onehanded_acc_penalty_mod = 0 //Modifies accuracy/scatter penalty when firing onehanded while moving.
	var/velocity_mod = 0 // Added velocity to bullets
	var/hud_offset_mod  = 0 //How many pixels to adjust the gun's sprite coords by. Ideally, this should keep the gun approximately centered.

	var/activation_sound = 'sound/weapons/handling/gun_underbarrel_activate.ogg'
	var/deactivation_sound = 'sound/weapons/handling/gun_underbarrel_deactivate.ogg'

	var/flags_attach_features = ATTACH_REMOVABLE

	var/current_rounds = 0 //How much it has.
	var/max_rounds = 0 //How much ammo it can store

	var/attachment_action_type

	var/hidden = FALSE //Render on gun?

	/// An assoc list in the format list(/datum/element/bullet_trait_to_give = list(...args))
	/// that will be given to a projectile with the current ammo datum
	var/list/list/traits_to_give
	/// List of traits to be given to the gun itself.
	var/list/gun_traits

/obj/item/attachable/Initialize(mapload, ...)
	. = ..()
	set_bullet_traits()

/obj/item/attachable/proc/set_bullet_traits()
	return

/obj/item/attachable/attackby(obj/item/I, mob/user)
	if(flags_attach_features & ATTACH_RELOADABLE)
		if(user.get_inactive_hand() != src)
			to_chat(user, SPAN_WARNING("你必须手持[src]才能这么做！"))
		else
			reload_attachment(I, user)
		return TRUE
	else
		. = ..()

/obj/item/attachable/proc/can_be_attached_to_gun(mob/user, obj/item/weapon/gun/G)
	if(G.attachable_allowed && !(type in G.attachable_allowed) )
		to_chat(user, SPAN_WARNING("[src]无法安装在[G]上！"))
		return FALSE
	return TRUE

/obj/item/attachable/proc/Attach(obj/item/weapon/gun/G)
	if(!istype(G))
		return //Guns only

	/*
	This does not check if the attachment can be removed.
	Instead of checking individual attachments, I simply removed
	the specific guns for the specific attachments so you can't
	attempt the process in the first place if a slot can't be
	removed on a gun. can_be_removed is instead used when they
	try to strip the gun.
	*/
	if(G.attachments[slot])
		var/obj/item/attachable/A = G.attachments[slot]
		A.Detach(detaching_gun = G)

	if(ishuman(loc))
		var/mob/living/carbon/human/M = src.loc
		M.drop_held_item(src)
	forceMove(G)

	G.attachments[slot] = src
	G.recalculate_attachment_bonuses()

	G.setup_firemodes()
	G.update_force_list() //This updates the gun to use proper force verbs.

	var/mob/living/living
	if(isliving(G.loc))
		living = G.loc

	if(attachment_action_type)
		var/given_action = FALSE
		if(living && (G == living.l_hand || G == living.r_hand))
			give_action(living, attachment_action_type, src, G)
			given_action = TRUE
		if(!given_action)
			new attachment_action_type(src, G)

	// Sharp attachments (bayonet) make weapons sharp as well.
	if(sharp)
		G.sharp = sharp

	for(var/trait in gun_traits)
		ADD_TRAIT(G, trait, TRAIT_SOURCE_ATTACHMENT(slot))
	for(var/entry in traits_to_give)
		if(!G.in_chamber)
			break
		var/list/L
		// Check if this is an ID'd bullet trait
		if(istext(entry))
			L = traits_to_give[entry].Copy()
		else
			// Prepend the bullet trait to the list
			L = list(entry) + traits_to_give[entry]
		// Apply bullet traits from attachment to gun's current projectile
		G.in_chamber.apply_bullet_trait(L)

/obj/item/attachable/proc/Detach(mob/user, obj/item/weapon/gun/detaching_gun)
	if(!istype(detaching_gun))
		return //Guns only

	if(!user && ishuman(detaching_gun.loc))
		user = detaching_gun.loc //Specifically for when called by Attach which doesn't pass a user.

	if(user)
		detaching_gun.on_detach(user, src)

	if(flags_attach_features & ATTACH_ACTIVATION)
		activate_attachment(detaching_gun, user, TRUE)

	detaching_gun.attachments[slot] = null
	detaching_gun.recalculate_attachment_bonuses()

	for(var/X in detaching_gun.actions)
		var/datum/action/DA = X
		if(DA.target == src)
			qdel(X)
			break

	forceMove(get_turf(detaching_gun))
	user?.put_in_hands(src, TRUE)

	if(sharp)
		detaching_gun.sharp = 0

	for(var/trait in gun_traits)
		REMOVE_TRAIT(detaching_gun, trait, TRAIT_SOURCE_ATTACHMENT(slot))
	for(var/entry in traits_to_give)
		if(!detaching_gun.in_chamber)
			break
		var/list/L
		if(istext(entry))
			L = traits_to_give[entry].Copy()
		else
			L = list(entry) + traits_to_give[entry]
		// Remove bullet traits of attachment from gun's current projectile
		detaching_gun.in_chamber._RemoveElement(L)

	// Remove any leftover reference to the bullet trait
	if(!isnull(detaching_gun.in_chamber))
		for(var/list/trait_list in detaching_gun.in_chamber.bullet_traits)
			trait_list.Remove(traits_to_give)
			if(!length(trait_list))
				detaching_gun.in_chamber.bullet_traits.Remove(list(trait_list))

		if(!length(detaching_gun.in_chamber.bullet_traits))
			detaching_gun.in_chamber.bullet_traits = null

/obj/item/attachable/ui_action_click(mob/living/user, obj/item/weapon/gun/G)
	activate_attachment(G, user)
	return //success

/obj/item/attachable/proc/activate_attachment(atom/target, mob/user) //This is for activating stuff like flamethrowers, or switching weapon modes.
	return

/obj/item/attachable/proc/reload_attachment(obj/item/I, mob/user)
	return

///Returns TRUE if its functionality is successfully used, FALSE if gun's own unloading should proceed instead.
/obj/item/attachable/proc/unload_attachment(mob/user, reload_override = 0, drop_override = 0, loc_override = 0)
	return FALSE

/obj/item/attachable/proc/fire_attachment(atom/target, obj/item/weapon/gun/gun, mob/user) //For actually shooting those guns.
	SHOULD_CALL_PARENT(TRUE)
	SEND_SIGNAL(user, COMSIG_MOB_FIRED_GUN_ATTACHMENT, src) // Because of this, the . = ..() check should be called last, just before firing
	return TRUE

/obj/item/attachable/proc/handle_attachment_description()
	var/base_attachment_desc
	switch(slot)
		if("rail")
			base_attachment_desc = "It has a [icon2html(src)] [name] mounted on the top."
		if("muzzle")
			base_attachment_desc = "It has a [icon2html(src)] [name] mounted on the front."
		if("stock")
			base_attachment_desc = "It has a [icon2html(src)] [name] for a stock."
		if("under")
			var/output = "It has a [icon2html(src)] [name]"
			if(flags_attach_features & ATTACH_WEAPON)
				output += " ([current_rounds]/[max_rounds])"
			output += " mounted underneath."
			base_attachment_desc = output
		else
			base_attachment_desc = "It has a [icon2html(src)] [name] attached."
	return handle_pre_break_attachment_description(base_attachment_desc) + "<br>"

/obj/item/attachable/proc/handle_pre_break_attachment_description(base_description_text as text)
	return base_description_text

// ======== Muzzle Attachments ======== //

/obj/item/attachable/suppressor
	name = "suppressor"
	desc = "一个带有排气口以排出噪音和气体的小型管体。\n 不能完全消音，但能大幅降低声响，并略微提升精度和稳定性，代价是伤害略有降低。"
	icon = 'icons/obj/items/weapons/guns/attachments/barrel.dmi'
	icon_state = "suppressor"
	slot = "muzzle"
	pixel_shift_y = 15
	attach_icon = "suppressor_a"
	hud_offset_mod = -3
	gun_traits = list(TRAIT_GUN_SILENCED)

/obj/item/attachable/suppressor/New()
	..()
	damage_falloff_mod = 0.1

/obj/item/attachable/suppressor/sleek
	name = "紧凑型消音器"
	desc = "一款专为冲锋枪和手枪设计的轻量、低轮廓消音器。它能抑制声音和枪口焰，同时略微提升稳定性和精度，但会轻微降低弹丸速度和终点杀伤力。"
	icon_state = "suppressor_sleek"
	slot = "muzzle"
	pixel_shift_y = 15
	attach_icon = "suppressor_sleek_a"
	hud_offset_mod = -3
	gun_traits = list(TRAIT_GUN_SILENCED_ALT)

/obj/item/attachable/suppressor/sleek/New()
	..()
	damage_falloff_mod = 0.1

/obj/item/attachable/suppressor/nsg
	name = "\improper BL11 firearm muffler"
	desc = "螺纹钢制枪管附件；减缓推进剂气体的逸出，从而抑制武器开火声响。"
	icon_state = "bl11"
	attach_icon = "bl11_a"

/obj/item/attachable/suppressor/xm40_integral
	name = "\improper XM40 integral suppressor"
	icon_state = "m40sd_suppressor"
	attach_icon = "m40sd_suppressor_a"

/obj/item/attachable/suppressor/xm40_integral/New()
	..()
	attach_icon = "m40sd_suppressor_a"

/obj/item/attachable/bayonet
	name = "\improper M5 'Night Raider' bayonet"
	icon = 'icons/obj/items/weapons/guns/attachments/barrel.dmi'
	icon_state = "bayonet"
	item_state = "combat_bayonet"
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/objects.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/knives_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/knives_righthand.dmi'
	)
	desc = "殖民地海军陆战队的标准配发刺刀。你可以将这把刀滑入靴中，或将其安装在步枪前端。"
	sharp = IS_SHARP_ITEM_ACCURATE
	force = MELEE_FORCE_NORMAL
	throwforce = MELEE_FORCE_NORMAL
	throw_speed = SPEED_VERY_FAST
	throw_range = 6
	hitsound = 'sound/weapons/slash.ogg'
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	attack_speed = 9
	flags_equip_slot = SLOT_FACE
	flags_armor_protection = SLOT_FACE
	flags_item = CAN_DIG_SHRAPNEL


	attach_icon = "bayonet_a"
	melee_mod = 20
	slot = "muzzle"
	pixel_shift_x = 14 //Below the muzzle.
	pixel_shift_y = 18
	hud_offset_mod = -4
	var/pry_delay = 3 SECONDS

/obj/item/attachable/bayonet/Initialize(mapload, ...)
	. = ..()
	if(flags_equip_slot & SLOT_FACE)
		AddElement(/datum/element/mouth_drop_item)

/obj/item/attachable/bayonet/New()
	..()
	accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_1

/obj/item/attachable/bayonet/upp_replica
	AUTOWIKI_SKIP(TRUE)

	name = "\improper Type 80 bayonet"
	desc = "UPP的标准配发刺刀，因频繁使用而变钝。"
	icon_state = "upp_bayonet"
	item_state = "upp_bayonet"
	attach_icon = "upp_bayonet_a"

/obj/item/attachable/bayonet/wy
	AUTOWIKI_SKIP(TRUE)

	name = "\improper SA120 L7 bayonet"
	desc = "维兰德突击队和PMC的标准配发刺刀，具有更符合人体工学的碳纤维涂层握柄和防腐蚀刀刃。"
	icon_state = "wy_bayonet"
	item_state = "wy_bayonet"
	attach_icon = "wy_bayonet_a"
	unacidable = TRUE

/obj/item/attachable/bayonet/wy/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/attachable/bayonet/upp
	AUTOWIKI_SKIP(TRUE)

	name = "\improper Type 80 bayonet"
	desc = "UPP的标准配发刺刀，80式经过平衡设计，也可作为有效的投掷刀使用。"
	icon_state = "upp_bayonet"
	item_state = "upp_bayonet"
	attach_icon = "upp_bayonet_a"
	throwforce = MELEE_FORCE_TIER_10 //doubled by throwspeed to 100
	throw_speed = SPEED_REALLY_FAST
	throw_range = 7
	pry_delay = 1 SECONDS

/obj/item/attachable/bayonet/co2
	AUTOWIKI_SKIP(TRUE)

	name = "\improper M8 cartridge bayonet"
	desc = "一款过期的USCM批准、仅限《军靴》杂志订阅者的独家产品，见于第255期《夜袭者内部——与朱利安·格尔德中尉探讨瓦解士气的替代方案》。刀刃内侧有一条加压管，按下一个按钮可将压缩二氧化碳注入刺伤处。摸起来感觉廉价，甚至像是次品。"
	icon_state = "co2_knife"
	attach_icon = "co2_bayonet_a"
	var/filled = FALSE

/obj/item/attachable/bayonet/rmc
	AUTOWIKI_SKIP(TRUE)

	name = "\improper L5 bayonet"
	desc = "RMC的标准配发刺刀，L5式经过平衡设计，也可作为有效的投掷刀使用。"
	icon_state = "twe_bayonet"
	item_state = "twe_bayonet"
	attach_icon = "twe_bayonet_a"
	throwforce = MELEE_FORCE_TIER_10 //doubled by throwspeed to 100
	throw_speed = SPEED_REALLY_FAST
	throw_range = 7
	pry_delay = 1 SECONDS

/obj/item/attachable/bayonet/antique
	AUTOWIKI_SKIP(TRUE)

	name = "\improper antique bayonet"
	desc = "一款复古风格的刺刀，具有长刀刃、带黄铜配件的木柄，体现了历史工艺。"
	icon_state = "antique_bayonet"
	item_state = "antique_bayonet"
	attach_icon = "antique_bayonet_a"

/obj/item/attachable/bayonet/rmc_replica
	AUTOWIKI_SKIP(TRUE)

	name = "\improper L5 bayonet"
	desc = "RMC的标准配发刺刀，因频繁使用而变钝。"
	icon_state = "twe_bayonet"
	item_state = "twe_bayonet"
	attach_icon = "twe_bayonet_a"

/obj/item/attachable/bayonet/custom
	AUTOWIKI_SKIP(TRUE)

	name = "\improper M5 'Raven's Claw' tactical bayonet"
	desc = "一款原型刺刀-战斗刀混合体，专为近距离交战和城市作战设计。其坚固的结构、快速拆卸机制和致命的通用性使其成为一种强大的工具。"
	icon_state = "bayonet_custom"
	item_state = "bayonet_custom"
	attach_icon = "bayonet_custom_a"

/obj/item/attachable/bayonet/custom/red
	AUTOWIKI_SKIP(TRUE)

	desc = "一款原型刺刀-战斗刀混合体，专为近距离交战和城市作战设计。其坚固的结构、快速拆卸机制和致命的通用性使其成为一种强大的工具。此版本定制了红色握柄和金色细节，赋予其独特的外观。"
	icon_state = "bayonet_custom_red"
	item_state = "bayonet_custom_red"
	attach_icon = "bayonet_custom_red_a"

/obj/item/attachable/bayonet/custom/blue
	AUTOWIKI_SKIP(TRUE)

	desc = "一款原型刺刀-战斗刀混合体，专为近距离交战和城市作战设计。其坚固的结构、快速拆卸机制和致命的通用性使其成为一种强大的工具。此版本定制了蓝色握柄和金色细节，赋予其独特的外观。"
	icon_state = "bayonet_custom_blue"
	item_state = "bayonet_custom_blue"
	attach_icon = "bayonet_custom_blue_a"

/obj/item/attachable/bayonet/custom/black
	AUTOWIKI_SKIP(TRUE)

	desc = "一款原型刺刀-战斗刀混合体，专为近距离交战和城市作战设计。其坚固的结构、快速拆卸机制和致命的通用性使其成为一种强大的工具。此版本定制了黑色握柄和金色细节，赋予其独特的外观。"
	icon_state = "bayonet_custom_black"
	item_state = "bayonet_custom_black"
	attach_icon = "bayonet_custom_black_a"

/obj/item/attachable/bayonet/tanto
	AUTOWIKI_SKIP(TRUE)

	name = "\improper T9 tactical bayonet"
	desc = "T9式是内罗伊德星区TWE殖民地军队的首选，专为城市战设计，具有耐用的短刀刀刃和快速安装系统，体现了传统日本刀具的影响。偶尔可见于殖民地解放阵线（CLF）部队手中，通常是从该星区各处的TWE分遣队和前哨站偷来的。"
	icon_state = "bayonet_tanto"
	item_state = "bayonet_tanto"
	attach_icon = "bayonet_tanto_a"

/obj/item/attachable/bayonet/tanto/blue
	AUTOWIKI_SKIP(TRUE)

	icon_state = "bayonet_tanto_alt"
	item_state = "bayonet_tanto_alt"
	attach_icon = "bayonet_tanto_alt_a"

/obj/item/attachable/bayonet/van_bandolier
	AUTOWIKI_SKIP(TRUE)

	name = "\improper Fairbairn-Sykes fighting knife"
	desc = "这不是用来处理猎物或执行营地杂务的。它几乎肯定不是原品。几乎。"

/obj/item/attachable/bayonet/co2/update_icon()
	icon_state = "co2_knife[filled ? "-f" : ""]"
	attach_icon = "co2_bayonet[filled ? "-f" : ""]_a"

/obj/item/attachable/bayonet/co2/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/co2_cartridge))
		if(!filled)
			filled = TRUE
			user.visible_message(SPAN_NOTICE("[user] slots a CO2 cartridge into [src]. A second later, \he apparently looks dismayed."), SPAN_WARNING("You slot a fresh CO2 cartridge into [src] and snap the slot cover into place. Only then do you realize [W]'s valve broke inside [src]. Fuck."))
			playsound(src, 'sound/machines/click.ogg')
			qdel(W)
			update_icon()
			return
		else
			user.visible_message(SPAN_WARNING("[user] fiddles with [src]. \He looks frustrated."), SPAN_NOTICE("No way man! You can't seem to pry the existing container out of [src]... try a screwdriver?"))
			return
	if(HAS_TRAIT(W, TRAIT_TOOL_SCREWDRIVER) && do_after(user, 2 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD))
		user.visible_message(SPAN_WARNING("[user] screws with [src], using \a [W]. \He looks very frustrated."), SPAN_NOTICE("You try to pry the cartridge out of [src], but it's stuck damn deep. Piece of junk..."))
		return
	..()

/obj/item/co2_cartridge //where tf else am I gonna put this?
	name = "\improper CO2 cartridge"
	desc = "一个用于M8卡榫刺刀的压缩CO2气罐。请勿食用或刺穿。"
	icon = 'icons/obj/items/tank.dmi'
	icon_state = "co2_cartridge"
	item_state = ""
	w_class = SIZE_TINY

/obj/item/attachable/extended_barrel
	name = "加长枪管"
	desc = "加长的枪管能加速并稳定弹头，提高初速和精度。"
	slot = "muzzle"
	icon = 'icons/obj/items/weapons/guns/attachments/barrel.dmi'
	icon_state = "ebarrel"
	attach_icon = "ebarrel_a"
	hud_offset_mod = -3
	wield_delay_mod = WIELD_DELAY_FAST

/obj/item/attachable/extended_barrel/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_4
	velocity_mod = AMMO_SPEED_TIER_1

/obj/item/attachable/extended_barrel/vented
	name = "AB-RVX加长制退器"
	desc = "一种由各UA部队使用的精密加工开槽枪管延长件。极大提高精度、枪口控制力和弹头初速，但由于泄压会降低终点杀伤力。"
	desc_lore = "Designed by Armat Battlefield Systems under contract for the United Americas Colonial Marine Corps, the AB-RVX compensator is a general-purpose muzzle device intended primarily for rifles such as the M41A, though it has also been adapted for smaller-caliber weapons like the M39 submachine gun and the M10 auto pistol. Its extended ported design effectively reduces recoil and muzzle rise, enhancing shot stability and control during sustained fire. While the aggressive gas redirection slightly decreases impact force, the compensator improves overall accuracy. Due to its specialized application and manufacturing complexity."
	slot = "muzzle"
	icon = 'icons/obj/items/weapons/guns/attachments/barrel.dmi'
	icon_state = "ebarrel_vented"
	attach_icon = "ebarrel_vented_a"
	pixel_shift_y = 15
	hud_offset_mod = -3
	wield_delay_mod = WIELD_DELAY_FAST

/obj/item/attachable/extended_barrel/vented/Initialize(mapload, ...)
	. = ..()
	select_gamemode_skin(type)

/obj/item/attachable/extended_barrel/vented/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	var/new_attach_icon
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("snow")
			attach_icon = new_attach_icon ? new_attach_icon : "s_" + attach_icon
			. = TRUE
		if("desert")
			attach_icon = new_attach_icon ? new_attach_icon : "d_" + attach_icon
			. = TRUE
		if("classic")
			attach_icon = new_attach_icon ? new_attach_icon : "c_" + attach_icon
			. = TRUE
		if("urban")
			attach_icon = new_attach_icon ? new_attach_icon : "u_" + attach_icon
			. = TRUE
	return .

/obj/item/attachable/extended_barrel/vented/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_6
	damage_mod = -BULLET_DAMAGE_MULT_TIER_2
	recoil_mod = -RECOIL_AMOUNT_TIER_5

	damage_falloff_mod = -0.1
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_6
	recoil_unwielded_mod = -RECOIL_AMOUNT_TIER_5
	velocity_mod = AMMO_SPEED_TIER_1

/obj/item/attachable/heavy_barrel
	name = "枪管增压器"
	desc = "一种超线程枪管延长器，可适配大多数枪械的枪口。提高子弹速度和初速。\n以牺牲精度和射速为代价，极大提高弹头杀伤力。"
	slot = "muzzle"
	icon = 'icons/obj/items/weapons/guns/attachments/barrel.dmi'
	icon_state = "charger"
	attach_icon = "charger_a"
	pixel_shift_y = 18
	hud_offset_mod = -3

/obj/item/attachable/heavy_barrel/New()
	..()
	accuracy_mod = -HIT_ACCURACY_MULT_TIER_3
	damage_mod = BULLET_DAMAGE_MULT_TIER_6
	delay_mod = FIRE_DELAY_TIER_11

	accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_7

/obj/item/attachable/heavy_barrel/Attach(obj/item/weapon/gun/G)
	if(G.gun_category == GUN_CATEGORY_SHOTGUN)
		damage_mod = BULLET_DAMAGE_MULT_TIER_1
	else
		damage_mod = BULLET_DAMAGE_MULT_TIER_6
	..()

/obj/item/attachable/compensator
	name = "后坐力补偿器"
	desc = "一种通过将排出气体向上导流来减少后坐力的枪口附件。\n提高精度并减少后坐力，代价是略微降低武器杀伤力。"
	slot = "muzzle"
	icon = 'icons/obj/items/weapons/guns/attachments/barrel.dmi'
	icon_state = "comp"
	attach_icon = "comp_a"
	pixel_shift_x = 17
	hud_offset_mod = -3

/obj/item/attachable/compensator/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_4
	damage_mod = -BULLET_DAMAGE_MULT_TIER_2
	recoil_mod = -RECOIL_AMOUNT_TIER_3

	damage_falloff_mod = 0.1
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_4
	recoil_unwielded_mod = -RECOIL_AMOUNT_TIER_4

/obj/item/attachable/compensator/m10
	name = "M10加长后坐力补偿器"
	desc = "为M10自动手枪设计的重型、过度结构的补偿器兼枪管延长件。在自动射击时极大改善后坐力控制，代价是体积增大和操控性下降。肯定是在弥补什么，但效果极其残暴。"
	desc_lore = "A limited-production muzzle device developed by Armat Battlefield Systems. The compensator channels muzzle gases to counteract recoil and slightly increase bullet velocity through focused pressure, marginally improving ballistic performance."
	slot = "muzzle"
	icon = 'icons/obj/items/weapons/guns/attachments/barrel.dmi'
	icon_state = "m10_overcomp"
	attach_icon = "m10_overcomp_a"
	pixel_shift_x = 17
	hud_offset_mod = -3

/obj/item/attachable/compensator/m10/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_3
	recoil_mod = -RECOIL_AMOUNT_TIER_4
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_4
	recoil_unwielded_mod = -RECOIL_AMOUNT_TIER_4
	damage_mod = BULLET_DAMAGE_MULT_TIER_1

/obj/item/attachable/compensator/m10/Initialize(mapload, ...)
	. = ..()
	select_gamemode_skin(type)

/obj/item/attachable/compensator/m10/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	var/new_attach_icon
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("snow")
			attach_icon = new_attach_icon ? new_attach_icon : "s_" + attach_icon
			. = TRUE
		if("desert")
			attach_icon = new_attach_icon ? new_attach_icon : "d_" + attach_icon
			. = TRUE
		if("classic")
			attach_icon = new_attach_icon ? new_attach_icon : "c_" + attach_icon
			. = TRUE
		if("urban")
			attach_icon = new_attach_icon ? new_attach_icon : "u_" + attach_icon
			. = TRUE
	return .

/obj/item/attachable/compensator/m10/spiked
	name = "M10加长尖刺后坐力补偿器"
	desc = "为M10自动手枪设计的极其沉重、过度工程的补偿器兼枪管延长件，顶端配有硬化尖刺帽。在自动射击时极大改善后坐力控制——并在近距离将手枪变成一件凶残的钝器。肯定是在弥补什么，但效果极其残暴。"
	desc_lore = "A rare prototype developed by Armat Battlefield Systems for a short-lived M10 close-quarters combat program. The compensator channels muzzle gases to counteract recoil and slightly increase bullet velocity through focused pressure, marginally increasing projectile force. The hardened spike cap provides a secondary striking option in confined engagements. Only a limited run was manufactured before the project was abandoned, making surviving units a rare and sought-after upgrade."
	slot = "muzzle"
	icon = 'icons/obj/items/weapons/guns/attachments/barrel.dmi'
	icon_state = "m10_overcomp_spike"
	attach_icon = "m10_overcomp_spike_a"
	pixel_shift_x = 17
	hud_offset_mod = -3
	melee_mod = 20
	sharp = IS_SHARP_ITEM_SIMPLE
	force = MELEE_FORCE_STRONG
	throwforce = MELEE_FORCE_WEAK
	throw_speed = SPEED_VERY_FAST
	throw_range = 6
	hitsound = 'sound/weapons/spike_thunk.ogg'
	attack_verb = list("bashed", "bludgeoned", "cracked", "smashed", "crushed", "pummeled", "spiked", "rammed")
	attack_speed = 9

/obj/item/attachable/compensator/m10/spiked/Attach(obj/item/weapon/gun/attaching_gun)
	if(!istype(attaching_gun, /obj/item/weapon/gun))
		return ..()
	attaching_gun.hitsound = 'sound/weapons/spike_thunk.ogg'
	melee_mod = 20
	sharp = IS_SHARP_ITEM_SIMPLE
	force = MELEE_FORCE_STRONG
	hitsound = 'sound/weapons/spike_thunk.ogg'
	attack_verb = list("bashed", "bludgeoned", "cracked", "smashed", "crushed", "pummeled", "spiked", "rammed")
	attack_speed = 9
	return ..()

/obj/item/attachable/compensator/m10/spiked/Detach(mob/user, obj/item/weapon/gun/detaching_gun)
	if(!istype(detaching_gun, /obj/item/weapon/gun))
		return ..()
	detaching_gun.hitsound = initial(detaching_gun.hitsound)
	return ..()

/obj/item/attachable/compensator/m10/spiked/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_3
	recoil_mod = -RECOIL_AMOUNT_TIER_4
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_4
	recoil_unwielded_mod = -RECOIL_AMOUNT_TIER_4
	damage_mod = BULLET_DAMAGE_MULT_TIER_1

/obj/item/attachable/shotgun_choke
	name = "霰弹枪收束器"
	desc = "一种用于泵动式霰弹枪的改良收束器。它能收紧弹丸散布、提高精度、速度和最大射程。武器的循环射速也会增加。作为交换，弹丸杀伤力和冲击力会大幅降低，且武器后坐力更高。不建议与独头弹配合使用。"
	slot = "muzzle"
	icon = 'icons/obj/items/weapons/guns/attachments/barrel.dmi'
	icon_state = "choke"
	attach_icon = "choke_a"
	pixel_shift_x = 16
	pixel_shift_y = 17
	hud_offset_mod = -2

/obj/item/attachable/shotgun_choke/set_bullet_traits()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_knockback_disabled)
	))

/obj/item/attachable/shotgun_choke/New()
	..()
	recoil_mod = RECOIL_AMOUNT_TIER_4
	accuracy_mod = HIT_ACCURACY_MULT_TIER_5
	damage_mod = -BULLET_DAMAGE_MULT_TIER_4
	velocity_mod = AMMO_SPEED_TIER_1
	delay_mod = -FIRE_DELAY_TIER_2
	bonus_proj_scatter_mod = -SCATTER_AMOUNT_TIER_6
	projectile_max_range_mod = 1
	damage_falloff_mod = -0.3

/obj/item/attachable/shotgun_choke/Attach(obj/item/weapon/gun/shotgun/pump/attaching_gun)
	if(!istype(attaching_gun, /obj/item/weapon/gun/shotgun/pump))
		return ..()
	attaching_gun.pump_delay -= FIRE_DELAY_TIER_5
	attaching_gun.fire_sound = 'sound/weapons/gun_shotgun_choke.ogg'
	return ..()

/obj/item/attachable/shotgun_choke/Detach(mob/user, obj/item/weapon/gun/shotgun/pump/detaching_gun)
	if(!istype(detaching_gun, /obj/item/weapon/gun/shotgun/pump))
		return ..()
	detaching_gun.pump_delay += FIRE_DELAY_TIER_5
	detaching_gun.fire_sound = initial(detaching_gun.fire_sound)
	return ..()

// Mateba(Unica) barrels

/obj/item/attachable/mateba
	name = "标准独角兽枪管"
	icon = 'icons/obj/items/weapons/guns/attachments/barrel.dmi'
	icon_state = "mateba_medium"
	desc = "一根标准的独角兽枪管。在精度和射速之间取得平衡。"
	slot = "special"
	flags_attach_features = NO_FLAGS

/obj/item/attachable/mateba/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_3

/obj/item/attachable/mateba/Attach(obj/item/weapon/gun/G)
	..()
	G.attachable_offset["muzzle_x"] = 27

/obj/item/attachable/mateba/Detach(mob/user, obj/item/weapon/gun/detaching_gun)
	..()
	detaching_gun.attachable_offset["muzzle_x"] = 20

/obj/item/attachable/mateba/silver
	icon_state = "mateba_medium_s"

/obj/item/attachable/mateba/gold
	icon_state = "mateba_medium_a"

/obj/item/attachable/mateba/long
	name = "神射手独角兽枪管"
	icon_state = "mateba_long"
	desc = "一根神射手独角兽枪管。以牺牲射速为代价，提供更高的精度。"
	flags_attach_features = NO_FLAGS
	hud_offset_mod = -1

/obj/item/attachable/mateba/long/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_4
	scatter_mod = -SCATTER_AMOUNT_TIER_6
	delay_mod = FIRE_DELAY_TIER_7

/obj/item/attachable/mateba/long/Attach(obj/item/weapon/gun/G)
	..()
	G.attachable_offset["muzzle_x"] = 27

/obj/item/attachable/mateba/long/silver
	icon_state = "mateba_long_s"

/obj/item/attachable/mateba/long/gold
	icon_state = "mateba_long_a"

/obj/item/attachable/mateba/short
	name = "短管独角兽枪管"
	icon_state = "mateba_short"
	desc = "一根短管独角兽枪管。以牺牲精度为代价，提供更快的射速。"
	hud_offset_mod = 2

/obj/item/attachable/mateba/short/New()
	..()
	accuracy_mod = -HIT_ACCURACY_MULT_TIER_4
	scatter_mod = SCATTER_AMOUNT_TIER_6
	delay_mod = -FIRE_DELAY_TIER_7

/obj/item/attachable/mateba/short/Attach(obj/item/weapon/gun/G)
	..()
	G.attachable_offset["muzzle_x"] = 27

/obj/item/attachable/mateba/short/silver
	icon_state = "mateba_short_s"

/obj/item/attachable/mateba/short/gold
	icon_state = "mateba_short_a"

// ======== Rail attachments ======== //

/obj/item/attachable/reddot
	name = "S5红点瞄准镜"
	desc = "一款阿玛特S5红点瞄准镜。零倍率光学瞄具，提供更快、更精准的目标捕获能力。"
	desc_lore = "An all-weather collimator sight, designated as the AN/PVQ-64 Dot Sight. Equipped with a sunshade to increase clarity in bright conditions and resist weathering. Compact and efficient, a marvel of military design, until you realize that this is actually just an off-the-shelf design that got a military designation slapped on."
	icon = 'icons/obj/items/weapons/guns/attachments/rail.dmi'
	icon_state = "reddot"
	attach_icon = "reddot_a"
	slot = "rail"

/obj/item/attachable/reddot/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_4
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_1
	movement_onehanded_acc_penalty_mod = MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
	AddElement(/datum/element/corp_label/armat)

/obj/item/attachable/reddot/small
	name = "S5微型红点瞄准镜"
	desc = "一款轻量、低矮的红点光学瞄具，专为快速目标捕获而设计，重量惩罚极低。针对冲锋枪和手枪优化，是速度和敏捷性至关重要的近距离作战的理想选择。"
	desc_lore = "Designated AN/PVQ-64(M), the Micro variant of the S5 collimator sight strips the platform down to essentials. With reduced bulk and weight, it's favored by scouts and boarding teams. Despite the mil-spec designation, it's little more than a civilian reflex sight rebranded with a price hike."
	icon = 'icons/obj/items/weapons/guns/attachments/rail.dmi'
	icon_state = "reddot_small"
	attach_icon = "reddot_small_a"
	slot = "rail"

/obj/item/attachable/reddot/small/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_3
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_1
	movement_onehanded_acc_penalty_mod = MOVEMENT_ACCURACY_PENALTY_MULT_TIER_6

/obj/item/attachable/reflex
	name = "S6反射式瞄准镜"
	desc = "一款阿玛特S6反射式瞄准镜。与机械瞄具相比的零倍率替代品，相比S5红点镜拥有更开阔的光学窗口。有助于减少自动射击时的散射。"
	desc_lore = "A simple folding reflex sight designated as the AN/PVG-72 Reflex Sight, compatible with most rail systems. Bulky and built to last, it can link with military HUDs for limited point-of-aim calculations."
	icon = 'icons/obj/items/weapons/guns/attachments/rail.dmi'
	icon_state = "reflex"
	attach_icon = "reflex_a"
	slot = "rail"

/obj/item/attachable/reflex/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_3
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_1
	scatter_mod = -SCATTER_AMOUNT_TIER_10
	burst_scatter_mod = -1
	movement_onehanded_acc_penalty_mod = MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
	AddElement(/datum/element/corp_label/armat)


/obj/item/attachable/flashlight
	name = "导轨手电筒"
	desc = "一个装在枪械导轨上的手电筒。可以开关。比标准的M3型护甲灯提供更好的光源。此型号设置为安装在导轨上，按特殊动作键切换其安装方式。"
	icon = 'icons/obj/items/weapons/guns/attachments/rail.dmi'
	icon_state = "flashlight"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/misc.dmi',
	)
	attach_icon = "flashlight_a"
	light_mod = 6
	slot = "rail"
	matter = list("metal" = 50,"glass" = 20)
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle/rail_flashlight
	activation_sound = 'sound/handling/light_on_1.ogg'
	deactivation_sound = 'sound/handling/click_2.ogg'
	var/original_state = "flashlight"
	var/original_attach = "flashlight_a"

	var/helm_mounted_light_power = 2
	var/helm_mounted_light_range = 3

	var/datum/action/item_action/activation
	var/obj/item/attached_item

/obj/item/attachable/flashlight/unique_action(mob/user)
	to_chat(user, SPAN_NOTICE("你将[src]重新配置为下挂式安装。"))
	playsound(user, 'sound/machines/click.ogg', 25, 1)
	user.put_in_hands(new /obj/item/attachable/flashlight/under_barrel(user))
	qdel(src)

/obj/item/attachable/flashlight/on_enter_storage(obj/item/storage/internal/S)
	..()

	if(!istype(S, /obj/item/storage/internal))
		return

	if(!istype(S.master_object, /obj/item/clothing/head/helmet/marine))
		return

	remove_attached_item()

	attached_item = S.master_object
	RegisterSignal(attached_item, COMSIG_PARENT_QDELETING, PROC_REF(remove_attached_item))
	activation = new /datum/action/item_action/toggle/rail_flashlight(src, S.master_object)

	if(ismob(S.master_object.loc))
		activation.give_to(S.master_object.loc)

/obj/item/attachable/flashlight/on_exit_storage(obj/item/storage/S)
	remove_attached_item()
	return ..()

/obj/item/attachable/flashlight/proc/remove_attached_item()
	SIGNAL_HANDLER
	if(!attached_item)
		return
	if(light_on)
		icon_state = original_state
		attach_icon = original_attach
		activate_attachment(attached_item, attached_item.loc, TRUE)
	UnregisterSignal(attached_item, COMSIG_PARENT_QDELETING)
	qdel(activation)
	attached_item.update_icon()
	attached_item = null

/obj/item/attachable/flashlight/ui_action_click(mob/owner, obj/item/holder)
	if(!attached_item)
		. = ..()
	else
		activate_attachment(attached_item, owner)
		for(var/datum/action/item_action as anything in holder.actions)
			item_action.update_button_icon()

/obj/item/attachable/flashlight/activate_attachment(obj/item/weapon/gun/G, mob/living/user, turn_off)
	turn_light(user, turn_off ? !turn_off : !light_on)

/obj/item/attachable/flashlight/turn_light(mob/user, toggle_on, cooldown, sparks, forced, light_again)
	. = ..()
	if(. != CHECKS_PASSED)
		return

	if(istype(attached_item, /obj/item/clothing/head/helmet/marine))
		if(!toggle_on || light_on)
			if(light_on)
				playsound(user, deactivation_sound, 15, 1)
			icon_state = original_state
			attach_icon = original_attach
			light_on = FALSE
		else
			playsound(user, activation_sound, 15, 1)
			icon_state += "-on"
			attach_icon += "-on"
			light_on = TRUE
		attached_item.update_icon()
		attached_item.set_light_range(helm_mounted_light_range)
		attached_item.set_light_power(helm_mounted_light_power)
		attached_item.set_light_on(light_on)
		activation.update_button_icon()
		return

	if(!isgun(loc))
		return

	var/obj/item/weapon/gun/attached_gun = loc

	if(toggle_on && !light_on)
		attached_gun.set_light_range(attached_gun.light_range + light_mod)
		attached_gun.set_light_power(attached_gun.light_power + (light_mod * 0.5))
		if(!(attached_gun.flags_gun_features & GUN_FLASHLIGHT_ON))
			attached_gun.set_light_color(COLOR_WHITE)
			attached_gun.set_light_on(TRUE)
			light_on = TRUE
			attached_gun.flags_gun_features |= GUN_FLASHLIGHT_ON

	if(!toggle_on && light_on)
		attached_gun.set_light_range(attached_gun.light_range - light_mod)
		attached_gun.set_light_power(attached_gun.light_power - (light_mod * 0.5))
		if(attached_gun.flags_gun_features & GUN_FLASHLIGHT_ON)
			attached_gun.set_light_on(FALSE)
			light_on = FALSE
			attached_gun.flags_gun_features &= ~GUN_FLASHLIGHT_ON

	if(attached_gun.flags_gun_features & GUN_FLASHLIGHT_ON)
		icon_state += "-on"
		attach_icon += "-on"
		playsound(user, deactivation_sound, 15, 1)
	else
		icon_state = original_state
		attach_icon = original_attach
		playsound(user, activation_sound, 15, 1)
	attached_gun.update_attachable(slot)

	for(var/X in attached_gun.actions)
		var/datum/action/A = X
		if(A.target == src)
			A.update_button_icon()
	return TRUE

/obj/item/attachable/flashlight/attackby(obj/item/I, mob/user)
	if(HAS_TRAIT(I, TRAIT_TOOL_SCREWDRIVER))
		to_chat(user, SPAN_NOTICE("你拆除了导轨手电筒的安装座，将其转换为普通手电筒。"))
		if(isstorage(loc))
			var/obj/item/storage/S = loc
			S.remove_from_storage(src)
		if(loc == user)
			user.temp_drop_inv_item(src)
		var/obj/item/device/flashlight/F = new(user)
		user.put_in_hands(F) //This proc tries right, left, then drops it all-in-one.
		qdel(src) //Delete da old flashlight
	else
		. = ..()

/obj/item/attachable/flashlight/under_barrel
	desc = "一个装在枪械导轨上的手电筒。可以开关。比标准的M3型护甲灯提供更好的光源。此型号设置为安装在下挂位置，按特殊动作键切换其安装方式。"
	slot = "under"
	pixel_shift_x = 15
	pixel_shift_y = 18

/obj/item/attachable/flashlight/under_barrel/unique_action(mob/user)
	to_chat(user, SPAN_NOTICE("你将[src]重新配置为导轨安装。"))
	playsound(user, 'sound/machines/click.ogg', 25, 1)
	user.put_in_hands(new /obj/item/attachable/flashlight(user))
	qdel(src)

/obj/item/attachable/flashlight/grip //Grip Light is here because it is a child object. Having it further down might cause a future coder a headache.
	name = "下挂式手电握把"
	desc = "天哪，补给官，他们给手电筒装了个握把！\n微量减少后坐力和散射。微量提升精度。可作为光源使用。"
	icon = 'icons/obj/items/weapons/guns/attachments/under.dmi'
	icon_state = "flashgrip"
	attach_icon = "flashgrip_a"
	light_mod = 5
	slot = "under"
	attachment_action_type = /datum/action/item_action/toggle/flashlight_grip
	original_state = "flashgrip"
	original_attach = "flashgrip_a"

/obj/item/attachable/flashlight/grip/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_1
	recoil_mod = -RECOIL_AMOUNT_TIER_5
	scatter_mod = -SCATTER_AMOUNT_TIER_10

/obj/item/attachable/flashlight/grip/attackby(obj/item/I, mob/user)
	if(HAS_TRAIT(I, TRAIT_TOOL_SCREWDRIVER))
		to_chat(user, SPAN_NOTICE("等等，牛仔，那个握把是螺栓固定的。你无法改装它。"))
	return

/obj/item/attachable/flashlight/laser_light_combo //Unique attachment for the VP78 based on the fact it has a Laser-Light Module in AVP2010
	name = "VP78激光-照明模块"
	desc = "一款用于VP78勤务手枪的激光-照明模块，目前正作为USCM下一代手枪计划的一部分进行有限实地测试。所有VP78手枪均配备此模块。"
	icon = 'icons/obj/items/weapons/guns/attachments/under.dmi'
	icon_state = "vplaserlight"
	attach_icon = "vplaserlight_a"
	light_mod = 5
	slot = "under"
	attachment_action_type = /datum/action/item_action/toggle/flashlight_grip
	original_state = "vplaserlight"
	original_attach = "vplaserlight_a"

/obj/item/attachable/flashlight/laser_light_combo/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_1
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
	scatter_mod = -SCATTER_AMOUNT_TIER_10
	scatter_unwielded_mod = -SCATTER_AMOUNT_TIER_9
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_1

/obj/item/attachable/flashlight/laser_light_combo/attackby(obj/item/combo_light, mob/user)
	if(HAS_TRAIT(combo_light, TRAIT_TOOL_SCREWDRIVER))
		to_chat(user, SPAN_NOTICE("你无法改装它。"))
	return

/obj/item/attachable/magnetic_harness
	name = "磁性挂带"
	desc = "一个磁性连接的挂带套件，可安装在武器的导轨上。武器掉落时，会自动挂载到任何一套USCM护甲上。"
	icon = 'icons/obj/items/weapons/guns/attachments/rail.dmi'
	icon_state = "magnetic"
	attach_icon = "magnetic_a"
	slot = "rail"
	pixel_shift_x = 13
	var/retrieval_slot = WEAR_J_STORE

/obj/item/attachable/magnetic_harness/New()
	..()
	accuracy_mod = -HIT_ACCURACY_MULT_TIER_1
	accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_1

/obj/item/attachable/magnetic_harness/can_be_attached_to_gun(mob/user, obj/item/weapon/gun/G)
	if(SEND_SIGNAL(G, COMSIG_DROP_RETRIEVAL_CHECK) & COMPONENT_DROP_RETRIEVAL_PRESENT)
		to_chat(user, SPAN_WARNING("[G]已经安装了回收系统！"))
		return FALSE
	return ..()

/obj/item/attachable/magnetic_harness/Attach(obj/item/weapon/gun/G)
	. = ..()
	G.AddElement(/datum/element/drop_retrieval/gun, retrieval_slot)

/obj/item/attachable/magnetic_harness/Detach(mob/user, obj/item/weapon/gun/detaching_gun)
	. = ..()
	detaching_gun.RemoveElement(/datum/element/drop_retrieval/gun, retrieval_slot)

/obj/item/attachable/magnetic_harness/lever_sling
	name = "R4T磁性枪带" //please don't make this attachable to any other guns...
	desc = "一款为舒适地携带19世纪杠杆式步枪而设计的定制枪带，原因不明。内含专门设计的磁铁，确保杠杆式步枪永远不会从你背上掉落，但它们在一定程度上会妨碍握持。"
	icon = 'icons/obj/items/weapons/guns/attachments/under.dmi'
	icon_state = "r4t-sling"
	attach_icon = "r4t-sling_a"
	slot = "under"
	wield_delay_mod = WIELD_DELAY_VERY_FAST
	retrieval_slot = WEAR_BACK

/obj/item/attachable/magnetic_harness/lever_sling/New()
	..()
	select_gamemode_skin(type)

/obj/item/attachable/magnetic_harness/lever_sling/Attach(obj/item/weapon/gun/G) //this is so the sling lines up correctly
	. = ..()
	G.attachable_offset["under_x"] = 15
	G.attachable_offset["under_y"] = 12


/obj/item/attachable/magnetic_harness/lever_sling/Detach(mob/user, obj/item/weapon/gun/detaching_gun)
	. = ..()
	detaching_gun.attachable_offset["under_x"] = 24
	detaching_gun.attachable_offset["under_y"] = 16

/obj/item/attachable/magnetic_harness/lever_sling/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..() // We are forcing attach_icon skin
	var/new_attach_icon
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("snow")
			attach_icon = new_attach_icon ? new_attach_icon : "s_" + attach_icon
			. = TRUE
		if("desert")
			attach_icon = new_attach_icon ? new_attach_icon : "d_" + attach_icon
			. = TRUE
		if("classic")
			attach_icon = new_attach_icon ? new_attach_icon : "c_" + attach_icon
			. = TRUE
		if("urban")
			attach_icon = new_attach_icon ? new_attach_icon : "u_" + attach_icon
			. = TRUE
	return .

/obj/item/attachable/alt_iff_scope
	name = "B8智能瞄准镜"
	icon = 'icons/obj/items/weapons/guns/attachments/rail.dmi'
	icon_state = "iffbarrel"
	attach_icon = "iffbarrel_a"
	desc = "一款实验性B8智能瞄准镜。基于阿玛特智能枪所使用的技术，此瞄准镜集成了敌我识别系统。只能安装在M4RA战斗步枪、M44战斗左轮手枪和M41A MK2脉冲步枪上。"
	desc_lore = "An experimental fire-control optic capable of linking into compatible IFF systems on certain weapons, designated the XAN/PVG-110 Smart Scope. Experimental technology developed by Armat, who have assured that all previously reported issues with false-negative IFF recognitions have been solved. Make sure to check the sight after every deployment, just in case."
	slot = "rail"
	pixel_shift_y = 15

/obj/item/attachable/alt_iff_scope/New()
	..()
	damage_mod = -BULLET_DAMAGE_MULT_TIER_2
	damage_falloff_mod = 0.2

/obj/item/attachable/alt_iff_scope/set_bullet_traits()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

/obj/item/attachable/alt_iff_scope/Attach(obj/item/weapon/gun/attaching_gun)
	. = ..()
	if(!GetComponent(attaching_gun, /datum/component/iff_fire_prevention))
		attaching_gun.AddComponent(/datum/component/iff_fire_prevention, 5)
	SEND_SIGNAL(attaching_gun, COMSIG_GUN_ALT_IFF_TOGGLED, TRUE)

/obj/item/attachable/alt_iff_scope/Detach(mob/user, obj/item/weapon/gun/detaching_gun)
	. = ..()
	SEND_SIGNAL(detaching_gun, COMSIG_GUN_ALT_IFF_TOGGLED, FALSE)
	detaching_gun.GetExactComponent(/datum/component/iff_fire_prevention).RemoveComponent()

/obj/item/attachable/scope
	name = "S8 4倍望远瞄准镜"
	icon = 'icons/obj/items/weapons/guns/attachments/rail.dmi'
	icon_state = "sniperscope"
	attach_icon = "sniperscope_a"
	desc = "一款阿玛特S8望远目镜。固定4倍变焦。按下HUD上的‘使用导轨附件’图标或使用同名指令来缩放。"
	desc_lore = "An intermediate-power Armat scope designated as the AN/PVQ-31 4x Optic. Fairly basic, but both durable and functional... enough. 780 meters is about as far as one can push the 10x24mm cartridge, really."
	slot = "rail"
	aim_speed_mod = SLOWDOWN_ADS_SCOPE //Extra slowdown when wielded
	wield_delay_mod = WIELD_DELAY_FAST
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle/scope
	var/zoom_offset = 11
	var/zoom_viewsize = 12
	var/allows_movement = 0
	var/accuracy_scoped_buff
	var/delay_scoped_nerf
	var/damage_falloff_scoped_buff
	var/ignore_clash_fog = FALSE
	var/using_scope

/obj/item/attachable/scope/New()
	..()
	delay_mod = FIRE_DELAY_TIER_12
	accuracy_mod = -HIT_ACCURACY_MULT_TIER_1
	movement_onehanded_acc_penalty_mod = MOVEMENT_ACCURACY_PENALTY_MULT_TIER_4
	accuracy_unwielded_mod = 0

	accuracy_scoped_buff = HIT_ACCURACY_MULT_TIER_8 //to compensate initial debuff
	delay_scoped_nerf = FIRE_DELAY_TIER_11 //to compensate initial debuff. We want "high_fire_delay"
	damage_falloff_scoped_buff = -0.4 //has to be negative

/obj/item/attachable/scope/Attach(obj/item/weapon/gun/gun)
	. = ..()
	RegisterSignal(gun, COMSIG_GUN_RECALCULATE_ATTACHMENT_BONUSES, PROC_REF(handle_attachment_recalc))

/obj/item/attachable/scope/Detach(mob/user, obj/item/weapon/gun/detaching_gun)
	. = ..()
	UnregisterSignal(detaching_gun, COMSIG_GUN_RECALCULATE_ATTACHMENT_BONUSES)


/// Due to the bipod's interesting way of handling stat modifications, this is necessary to prevent exploits.
/obj/item/attachable/scope/proc/handle_attachment_recalc(obj/item/weapon/gun/source)
	SIGNAL_HANDLER

	if(!source.zoom)
		return

	if(using_scope)
		source.accuracy_mult += accuracy_scoped_buff
		source.modify_fire_delay(delay_scoped_nerf)
		source.damage_falloff_mult += damage_falloff_scoped_buff


/obj/item/attachable/scope/proc/apply_scoped_buff(obj/item/weapon/gun/G, mob/living/carbon/user)
	if(G.zoom)
		G.accuracy_mult += accuracy_scoped_buff
		G.modify_fire_delay(delay_scoped_nerf)
		G.damage_falloff_mult += damage_falloff_scoped_buff
		using_scope = TRUE
		RegisterSignal(user, COMSIG_LIVING_ZOOM_OUT, PROC_REF(remove_scoped_buff))

/obj/item/attachable/scope/proc/remove_scoped_buff(mob/living/carbon/user, obj/item/weapon/gun/G)
	SIGNAL_HANDLER
	UnregisterSignal(user, COMSIG_LIVING_ZOOM_OUT)
	using_scope = FALSE
	G.accuracy_mult -= accuracy_scoped_buff
	G.modify_fire_delay(-delay_scoped_nerf)
	G.damage_falloff_mult -= damage_falloff_scoped_buff
	user.update_action_buttons()

/obj/item/attachable/scope/activate_attachment(obj/item/weapon/gun/G, mob/living/carbon/user, turn_off)
	if(turn_off || G.zoom)
		if(G.zoom)
			G.zoom(user, zoom_offset, zoom_viewsize, allows_movement)
		return TRUE

	if(!G.zoom)
		if(!(G.flags_item & WIELDED))
			if(user)
				to_chat(user, SPAN_WARNING("你必须双手持握[G]才能使用[src]。"))
			return FALSE
		if(MODE_HAS_FLAG(MODE_FACTION_CLASH) && !ignore_clash_fog)
			if(user)
				to_chat(user, SPAN_DANGER("你凑近[src]观察，但它似乎起雾了。无法使用！"))
			return FALSE
		else
			G.zoom(user, zoom_offset, zoom_viewsize, allows_movement)
			apply_scoped_buff(G,user)
	return TRUE

//variable zoom scopes, they go between 2x and 4x zoom.

#define ZOOM_LEVEL_2X 0
#define ZOOM_LEVEL_4X 1

/obj/item/attachable/scope/variable_zoom
	name = "S10可变倍率望远瞄准镜"
	desc = "一款阿玛特S10望远目镜。可在2倍变焦（允许开镜移动）和4倍变焦之间切换。按下HUD上的‘使用导轨附件’图标或使用同名指令来缩放。"
	attachment_action_type = /datum/action/item_action/toggle/scope
	var/dynamic_aim_slowdown = SLOWDOWN_ADS_MINISCOPE_DYNAMIC
	var/zoom_level = ZOOM_LEVEL_4X

/obj/item/attachable/scope/variable_zoom/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/attachable/scope/variable_zoom/Attach(obj/item/weapon/gun/G)
	. = ..()
	var/mob/living/living
	var/given_zoom_action = FALSE
	if(living && (G == living.l_hand || G == living.r_hand))
		give_action(living, /datum/action/item_action/toggle_zoom_level, src, G)
		given_zoom_action = TRUE
	if(!given_zoom_action)
		new /datum/action/item_action/toggle_zoom_level(src, G)

/obj/item/attachable/scope/variable_zoom/apply_scoped_buff(obj/item/weapon/gun/G, mob/living/carbon/user)
	. = ..()
	if(G.zoom)
		G.slowdown += dynamic_aim_slowdown

/obj/item/attachable/scope/variable_zoom/remove_scoped_buff(mob/living/carbon/user, obj/item/weapon/gun/G)
	G.slowdown -= dynamic_aim_slowdown
	..()

/obj/item/attachable/scope/variable_zoom/proc/toggle_zoom_level()
	if(using_scope)
		to_chat(usr, SPAN_WARNING("你无法在通过[src]观察时改变其变焦设置！"))
		return
	if(zoom_level == ZOOM_LEVEL_2X)
		zoom_level = ZOOM_LEVEL_4X
		zoom_offset = 11
		zoom_viewsize = 12
		allows_movement = 0
		to_chat(usr, SPAN_NOTICE("变焦等级切换至4倍。"))
		return
	else
		zoom_level = ZOOM_LEVEL_2X
		zoom_offset = 6
		zoom_viewsize = 7
		allows_movement = 1
		to_chat(usr, SPAN_NOTICE("变焦等级切换至2倍。"))
		return

/datum/action/item_action/toggle_zoom_level

/datum/action/item_action/toggle_zoom_level/New()
	..()
	name = "切换变焦等级"
	action_icon_state = "zoom_in"
	button.name = name

/datum/action/item_action/toggle_zoom_level/action_activate()
	. = ..()
	var/obj/item/weapon/gun/G = holder_item
	var/obj/item/attachable/scope/variable_zoom/S = G.attachments["rail"]
	S.toggle_zoom_level()
	update_button_icon()

/datum/action/item_action/toggle_zoom_level/update_button_icon()
	var/obj/item/weapon/gun/G = holder_item
	var/obj/item/attachable/scope/variable_zoom/S = G.attachments["rail"]
	if(S.zoom_level == ZOOM_LEVEL_2X)
		action_icon_state = "zoom_in"
	else
		action_icon_state = "zoom_out"
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

//other variable zoom scopes

/obj/item/attachable/scope/variable_zoom/integrated
	name = "可变倍率瞄准镜"

/obj/item/attachable/scope/variable_zoom/slavic
	icon_state = "slavicscope"
	attach_icon = "slavicscope"
	desc = "哎呀！你怎么把这从光荣的斯大林武器上拆下来了？妈的，装回去干活，同志。扬基佬不会自己开枪吗？"

/obj/item/attachable/scope/variable_zoom/eva
	name = "RXF-M5 EVA望远可变倍率瞄准镜"
	icon_state = "rxfm5_eva_scope"
	attach_icon = "rxfm5_eva_scope_a"
	desc = "一款民用级瞄准镜，可在短距和长距放大倍率间切换，专为外星侦察设计。装在手枪上看起来很滑稽。"
	aim_speed_mod = 0

/obj/item/attachable/scope/variable_zoom/twe
	name = "S10可变倍率望远瞄准镜"
	icon_state = "3we_scope"
	attach_icon = "3we_scope_a"
	desc = "一款阿玛特S10望远目镜。可在2倍变焦（允许开镜移动）和4倍变焦之间切换。按下HUD上的‘使用导轨附件’图标或使用同名指令来缩放。"

#undef ZOOM_LEVEL_2X
#undef ZOOM_LEVEL_4X


/obj/item/attachable/scope/mini
	name = "S4 2倍望远迷你瞄准镜"
	icon_state = "miniscope"
	attach_icon = "miniscope_a"
	desc = "一款阿玛特S4伸缩目镜。固定为适中的2倍变焦。按下HUD上的‘使用导轨附件’图标或使用同名指令来缩放。"
	desc_lore = "A light-duty optic, designated as the AN/PVQ-45 2x Optic. Suited towards short to medium-range engagements. Users are advised to zero it often, as the first mass-production batch had a tendency to drift in one direction or another with sustained use."
	slot = "rail"
	zoom_offset = 6
	zoom_viewsize = 7
	allows_movement = TRUE
	aim_speed_mod = 0
	var/dynamic_aim_slowdown = SLOWDOWN_ADS_MINISCOPE_DYNAMIC

/obj/item/attachable/scope/mini/New()
	..()
	delay_mod = 0
	delay_scoped_nerf = FIRE_DELAY_TIER_SMG
	damage_falloff_scoped_buff = -0.2 //has to be negative
	AddElement(/datum/element/corp_label/armat)


/obj/item/attachable/scope/mini/apply_scoped_buff(obj/item/weapon/gun/G, mob/living/carbon/user)
	. = ..()
	if(G.zoom)
		G.slowdown += dynamic_aim_slowdown

/obj/item/attachable/scope/mini/remove_scoped_buff(mob/living/carbon/user, obj/item/weapon/gun/G)
	G.slowdown -= dynamic_aim_slowdown
	..()

/obj/item/attachable/scope/mini/flaregun
	wield_delay_mod = 0
	dynamic_aim_slowdown = SLOWDOWN_ADS_MINISCOPE_DYNAMIC

/obj/item/attachable/scope/mini/f90
	dynamic_aim_slowdown = SLOWDOWN_ADS_NONE

/obj/item/attachable/scope/mini/flaregun/New()
	..()
	delay_mod = 0
	accuracy_mod = 0
	movement_onehanded_acc_penalty_mod = 0
	accuracy_unwielded_mod = 0

	accuracy_scoped_buff = HIT_ACCURACY_MULT_TIER_8
	delay_scoped_nerf = FIRE_DELAY_TIER_9

/obj/item/attachable/scope/mini/hunting
	name = "2倍狩猎迷你瞄准镜"
	icon_state = "huntingscope"
	attach_icon = "huntingscope"
	desc = "这款民用级瞄准镜因其低廉的价格和出色的光学性能而常见于猎枪上。固定为适中的2倍变焦。按下HUD上的‘使用导轨附件’图标或使用同名指令来缩放。"

/obj/item/attachable/scope/mini/nsg23
	name = "维兰德S4 2倍先进望远迷你瞄准镜"
	desc = "一款阿玛特S4伸缩目镜，由维兰德科学家专门调校，以达到最佳人体工学效果。"
	icon_state = "miniscope_nsg23"
	attach_icon = "miniscope_nsg23_a"
	zoom_offset = 7
	dynamic_aim_slowdown = SLOWDOWN_ADS_NONE

/obj/item/attachable/scope/mini/nsg23/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/attachable/scope/mini/xm88
	name = "XS-9目标中继器"
	desc = "一款阿玛特XS-9光学接口。与传统瞄准镜不同，这款导轨安装设备没有伸缩镜片。相反，枪械自带的瞄准系统将数据直接传输到目镜，供系统操作员实时参考。"
	icon_state = "boomslang-scope"
	zoom_offset = 7
	dynamic_aim_slowdown = SLOWDOWN_ADS_NONE

/obj/item/attachable/scope/mini/xm88/New()
	..()
	select_gamemode_skin(type)
	attach_icon = icon_state

/obj/item/attachable/scope/slavic
	icon_state = "slavicscope"
	attach_icon = "slavicscope"
	desc = "哎呀！你怎么把这从光荣的斯大林武器上拆下来了？妈的，装回去干活，同志。扬基佬不会自己开枪吗？"

/obj/item/attachable/vulture_scope // not a subtype of scope because it uses basically none of the scope's features
	name = "\improper M707 \"Vulture\" scope"
	icon = 'icons/obj/items/weapons/guns/attachments/rail.dmi'
	icon_state = "vulture_scope"
	attach_icon = "vulture_scope"
	desc = "一款为M707反器材步枪设计的强大但笨重的瞄准镜。" // Can't be seen normally, anyway
	slot = "rail"
	aim_speed_mod = SLOWDOWN_ADS_SCOPE //Extra slowdown when wielded
	wield_delay_mod = WIELD_DELAY_FAST
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle/vulture_scope
	/// Weakref to the user of the scope
	var/datum/weakref/scope_user
	/// If the scope is currently in use
	var/scoping = FALSE
	/// How far out the player should see by default
	var/start_scope_range = 12
	/// The bare minimum distance the scope can be from the player
	var/min_scope_range = 12
	/// The maximum distance the scope can be from the player
	var/max_scope_range = 25
	/// How far in the perpendicular axis the scope can move in either direction
	var/perpendicular_scope_range = 7
	/// How far in each direction the scope should see. Default human view size is 7
	var/scope_viewsize = 7
	/// The current X position of the scope within the sniper's view box. 0 is center
	var/scope_offset_x = 0
	/// The current Y position of the scope within the sniper's view box. 0 is center
	var/scope_offset_y = 0
	/// How far in any given direction the scope can drift
	var/scope_drift_max = 2
	/// The current X coord position of the scope camera
	var/scope_x = 0
	/// The current Y coord position of the scope camera
	var/scope_y = 0
	/// Ref to the scope screen element
	var/atom/movable/screen/vulture_scope/scope_element
	/// If the gun should experience scope drift
	var/scope_drift = TRUE
	/// % chance for the scope to drift on process with a spotter using their scope
	var/spotted_drift_chance = 25
	/// % chance for the scope to drift on process without a spotter using their scope
	var/unspotted_drift_chance = 90
	/// If the scope should use do_afters for adjusting and moving the sight
	var/slow_use = TRUE
	/// Cooldown for interacting with the scope's adjustment or position
	COOLDOWN_DECLARE(scope_interact_cd)
	/// If the user is currently holding their breath
	var/holding_breath = FALSE
	/// Cooldown for after holding your breath
	COOLDOWN_DECLARE(hold_breath_cd)
	/// How long you can hold your breath for
	var/breath_time = 4 SECONDS
	/// How long the cooldown for holding your breath is, only starts after breath_time finishes
	var/breath_cooldown_time = 12 SECONDS
	/// The initial dir of the scope user when scoping in
	var/scope_user_initial_dir
	/// How much to increase darkness view by
	var/darkness_view = 12
	/// If there is currently a spotter using the linked spotting scope
	var/spotter_spotting = FALSE
	/// How much time it takes to adjust the position of the scope. Adjusting the offset will take half of this time
	var/adjust_delay = 1 SECONDS

/obj/item/attachable/vulture_scope/Initialize(mapload, ...)
	. = ..()
	START_PROCESSING(SSobj, src)
	select_gamemode_skin(type)

/obj/item/attachable/vulture_scope/Destroy()
	STOP_PROCESSING(SSobj, src)
	on_unscope()
	QDEL_NULL(scope_element)
	return ..()

/obj/item/attachable/vulture_scope/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..() // We are forcing attach_icon skin
	var/new_attach_icon
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("snow")
			attach_icon = new_attach_icon ? new_attach_icon : "s_" + attach_icon
			. = TRUE
		if("desert")
			attach_icon = new_attach_icon ? new_attach_icon : "d_" + attach_icon
			. = TRUE
		if("classic")
			attach_icon = new_attach_icon ? new_attach_icon : "c_" + attach_icon
			. = TRUE
		if("urban")
			attach_icon = new_attach_icon ? new_attach_icon : "u_" + attach_icon
			. = TRUE
	return .

/obj/item/attachable/vulture_scope/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "VultureScope", name)
		ui.open()

/obj/item/attachable/vulture_scope/ui_state(mob/user)
	return GLOB.not_incapacitated_state

/obj/item/attachable/vulture_scope/ui_data(mob/user)
	var/list/data = list()
	data["offset_x"] = scope_offset_x
	data["offset_y"] = scope_offset_y
	data["valid_offset_dirs"] = get_offset_dirs()
	data["scope_cooldown"] = !COOLDOWN_FINISHED(src, scope_interact_cd)
	data["valid_adjust_dirs"] = get_adjust_dirs()
	data["breath_cooldown"] = !COOLDOWN_FINISHED(src, hold_breath_cd)
	data["breath_recharge"] = get_breath_recharge()
	data["spotter_spotting"] = spotter_spotting
	data["current_scope_drift"] = get_scope_drift_chance()
	data["time_to_fire_remaining"] = 1 - (get_time_to_fire() / FIRE_DELAY_TIER_VULTURE)
	return data

/obj/item/attachable/vulture_scope/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("adjust_dir")
			var/direction = params["offset_dir"]
			if(!(direction in GLOB.alldirs) || !scoping || !scope_user)
				return

			var/mob/scoper = scope_user.resolve()
			if(slow_use)
				if(!COOLDOWN_FINISHED(src, scope_interact_cd))
					return
				to_chat(scoper, SPAN_NOTICE("你开始调整[src]..."))
				COOLDOWN_START(src, scope_interact_cd, adjust_delay / 2)
				if(!do_after(scoper, 0.4 SECONDS))
					return

			adjust_offset(direction)
			. = TRUE

		if("adjust_position")
			var/direction = params["position_dir"]
			if(!(direction in GLOB.alldirs) || !scoping || !scope_user)
				return

			var/mob/scoper = scope_user.resolve()
			if(slow_use)
				if(!COOLDOWN_FINISHED(src, scope_interact_cd))
					return

				to_chat(scoper, SPAN_NOTICE("你开始移动[src]..."))
				COOLDOWN_START(src, scope_interact_cd, adjust_delay)
				if(!do_after(scoper, 0.8 SECONDS))
					return

			adjust_position(direction)
			. = TRUE

		if("hold_breath")
			if(!COOLDOWN_FINISHED(src, hold_breath_cd) || holding_breath)
				return

			hold_breath()
			. = TRUE

/obj/item/attachable/vulture_scope/process()
	if(scope_element && prob(get_scope_drift_chance())) //every 6 seconds when unspotted, on average
		scope_drift()

/// Returns a number between 0 and 100 for the chance of the scope drifting on process()
/obj/item/attachable/vulture_scope/proc/get_scope_drift_chance()
	if(!scope_drift || holding_breath)
		return 0

	if(spotter_spotting)
		return spotted_drift_chance

	else
		return unspotted_drift_chance

/// Returns how many deciseconds until the gun is able to fire again
/obj/item/attachable/vulture_scope/proc/get_time_to_fire()
	if(!istype(loc, /obj/item/weapon/gun/boltaction/vulture))
		return 0

	var/obj/item/weapon/gun/boltaction/vulture/rifle = loc
	if(!rifle.last_fired)
		return 0

	return (rifle.last_fired + rifle.get_fire_delay()) - world.time

/obj/item/attachable/vulture_scope/activate_attachment(obj/item/weapon/gun/gun, mob/living/carbon/user, turn_off)
	if(turn_off || scoping)
		on_unscope()
		return TRUE

	if(!scoping)
		if(!(gun.flags_item & WIELDED))
			to_chat(user, SPAN_WARNING("你必须双手持握[gun]才能使用[src]。"))
			return FALSE

		if(!HAS_TRAIT(gun, TRAIT_GUN_BIPODDED))
			to_chat(user, SPAN_WARNING("你必须部署两脚架才能使用[src]。"))
			return FALSE

		on_scope()
	return TRUE

/obj/item/attachable/vulture_scope/proc/get_offset_dirs()
	var/list/possible_dirs = GLOB.alldirs.Copy()
	if(scope_offset_x >= scope_drift_max)
		possible_dirs -= list(NORTHEAST, EAST, SOUTHEAST)
	else if(scope_offset_x <= -scope_drift_max)
		possible_dirs -= list(NORTHWEST, WEST, SOUTHWEST)

	if(scope_offset_y >= scope_drift_max)
		possible_dirs -= list(NORTHWEST, NORTH, NORTHEAST)
	else if(scope_offset_y <= -scope_drift_max)
		possible_dirs -= list(SOUTHWEST, SOUTH, SOUTHEAST)

	return possible_dirs

/// Gets a list of valid directions to be able to adjust the reticle in
/obj/item/attachable/vulture_scope/proc/get_adjust_dirs()
	if(!scoping)
		return list()
	var/list/possible_dirs = GLOB.alldirs.Copy()
	var/turf/current_turf = get_turf(src)
	var/turf/scope_tile = locate(scope_x, scope_y, current_turf.z)
	var/mob/scoper = scope_user.resolve()
	if(!scoper)
		return list()

	var/user_dir = scoper.dir
	var/distance = get_dist(current_turf, scope_tile)
	if(distance >= max_scope_range)
		possible_dirs -= get_related_directions(user_dir)

	else if(distance <= min_scope_range)
		possible_dirs -= get_related_directions(REVERSE_DIR(user_dir))

	if((user_dir == EAST) || (user_dir == WEST))
		if(scope_y - current_turf.y >= perpendicular_scope_range)
			possible_dirs -= get_related_directions(NORTH)

		else if(current_turf.y - scope_y >= perpendicular_scope_range)
			possible_dirs -= get_related_directions(SOUTH)

	else
		if(scope_x - current_turf.x >= perpendicular_scope_range)
			possible_dirs -= get_related_directions(EAST)

		else if(current_turf.x - scope_x >= perpendicular_scope_range)
			possible_dirs -= get_related_directions(WEST)

	return possible_dirs

/// Adjusts the position of the reticle by a tile in a given direction
/obj/item/attachable/vulture_scope/proc/adjust_offset(direction = NORTH)
	var/old_x = scope_offset_x
	var/old_y = scope_offset_y
	if((direction == NORTHEAST) || (direction == EAST) || (direction == SOUTHEAST))
		scope_offset_x = min(scope_offset_x + 1, scope_drift_max)
	else if((direction == NORTHWEST) || (direction == WEST) || (direction == SOUTHWEST))
		scope_offset_x = max(scope_offset_x - 1, -scope_drift_max)

	if((direction == NORTHWEST) || (direction == NORTH) || (direction == NORTHEAST))
		scope_offset_y = min(scope_offset_y + 1, scope_drift_max)
	else if((direction == SOUTHWEST) || (direction == SOUTH) || (direction == SOUTHEAST))
		scope_offset_y = max(scope_offset_y - 1, -scope_drift_max)

	recalculate_scope_offset(old_x, old_y)

/// Adjusts the position of the scope by a tile in a given direction
/obj/item/attachable/vulture_scope/proc/adjust_position(direction = NORTH)
	var/perpendicular_axis = "x"
	var/mob/user = scope_user.resolve()
	var/turf/user_turf = get_turf(user)
	if((user.dir == EAST) || (user.dir == WEST))
		perpendicular_axis = "y"

	if((direction == NORTHEAST) || (direction == EAST) || (direction == SOUTHEAST))
		scope_x++
		scope_x = user_turf.x + axis_math(user, perpendicular_axis, "x", direction)
	else if((direction == NORTHWEST) || (direction == WEST) || (direction == SOUTHWEST))
		scope_x--
		scope_x = user_turf.x + axis_math(user, perpendicular_axis, "x", direction)
	if((direction == NORTHWEST) || (direction == NORTH) || (direction == NORTHEAST))
		scope_y++
		scope_y = user_turf.y + axis_math(user, perpendicular_axis, "y", direction)
	else if((direction == SOUTHWEST) || (direction == SOUTH) || (direction == SOUTHEAST))
		scope_y--
		scope_y = user_turf.y + axis_math(user, perpendicular_axis, "y", direction)

	SEND_SIGNAL(src, COMSIG_VULTURE_SCOPE_MOVED)

	recalculate_scope_pos()

/// Figures out which direction the scope should move based on user direction and their input
/obj/item/attachable/vulture_scope/proc/axis_math(mob/user, perpendicular_axis = "x", modifying_axis = "x", direction = NORTH)
	var/turf/user_turf = get_turf(user)
	var/inverse = FALSE
	if((user.dir == SOUTH) || (user.dir == WEST))
		inverse = TRUE
	var/user_offset
	if(modifying_axis == "x")
		user_offset = scope_x - user_turf.x

	else
		user_offset = scope_y - user_turf.y

	if(perpendicular_axis == modifying_axis)
		return clamp(user_offset, -perpendicular_scope_range, perpendicular_scope_range)

	else
		return clamp(abs(user_offset), min_scope_range, max_scope_range) * (inverse ? -1 : 1)

/// Recalculates where the reticle should be inside the scope
/obj/item/attachable/vulture_scope/proc/recalculate_scope_offset(old_x = 0, old_y = 0)
	var/mob/scoper = scope_user.resolve()
	if(!scoper.client)
		return

	var/x_to_set = (scope_offset_x >= 0 ? "+" : "") + "[scope_offset_x]"
	var/y_to_set = (scope_offset_y >= 0 ? "+" : "") + "[scope_offset_y]"
	scope_element.screen_loc = "CENTER[x_to_set],CENTER[y_to_set]"

/// Recalculates where the scope should be in relation to the user
/obj/item/attachable/vulture_scope/proc/recalculate_scope_pos()
	if(!scope_user)
		return
	var/turf/current_turf = get_turf(src)
	var/x_off = scope_x - current_turf.x
	var/y_off = scope_y - current_turf.y
	var/pixels_per_tile = 32
	var/mob/scoper = scope_user.resolve()
	if(!scoper.client)
		return

	if(scoping)
		scoper.client.set_pixel_x(x_off * pixels_per_tile)
		scoper.client.set_pixel_y(y_off * pixels_per_tile)
	else
		scoper.client.set_pixel_x(0)
		scoper.client.set_pixel_y(0)

/// Handler for when the user begins scoping
/obj/item/attachable/vulture_scope/proc/on_scope()
	var/turf/gun_turf = get_turf(src)
	scope_x = gun_turf.x
	scope_y = gun_turf.y
	scope_offset_x = 0
	scope_offset_y = 0
	holding_breath = FALSE

	if(!isgun(loc))
		return

	var/obj/item/weapon/gun/gun = loc
	var/mob/living/gun_user = gun.get_gun_user()
	if(!gun_user)
		return

	switch(gun_user.dir)
		if(NORTH)
			scope_y += start_scope_range
		if(EAST)
			scope_x += start_scope_range
		if(SOUTH)
			scope_y -= start_scope_range
		if(WEST)
			scope_x -= start_scope_range

	scope_user = WEAKREF(gun_user)
	scope_user_initial_dir = gun_user.dir
	scoping = TRUE
	recalculate_scope_pos()
	gun_user.overlay_fullscreen("vulture", /atom/movable/screen/fullscreen/vulture)
	scope_element = new(src)
	gun_user.client.add_to_screen(scope_element)
	gun_user.see_in_dark += darkness_view
	gun_user.lighting_alpha = 127
	gun_user.sync_lighting_plane_alpha()
	RegisterSignal(gun, list(
		COMSIG_ITEM_DROPPED,
		COMSIG_ITEM_UNWIELD,
	), PROC_REF(on_unscope))
	RegisterSignal(gun_user, COMSIG_MOB_UNDEPLOYED_BIPOD, PROC_REF(on_unscope))
	RegisterSignal(gun_user, COMSIG_MOB_MOVE_OR_LOOK, PROC_REF(on_mob_move_look))
	RegisterSignal(gun_user.client, COMSIG_PARENT_QDELETING, PROC_REF(on_unscope))

/// Handler for when the scope is deleted, dropped, etc.
/obj/item/attachable/vulture_scope/proc/on_unscope()
	SIGNAL_HANDLER
	if(!scope_user)
		return

	var/mob/scoper = scope_user.resolve()
	if(isgun(loc))
		UnregisterSignal(loc, list(
			COMSIG_ITEM_DROPPED,
			COMSIG_ITEM_UNWIELD,
		))
	UnregisterSignal(scoper, list(COMSIG_MOB_UNDEPLOYED_BIPOD, COMSIG_MOB_MOVE_OR_LOOK))
	UnregisterSignal(scoper.client, COMSIG_PARENT_QDELETING)
	stop_holding_breath()
	scope_user_initial_dir = null
	scoper.clear_fullscreen("vulture")
	scoper.client.remove_from_screen(scope_element)
	scoper.see_in_dark -= darkness_view
	scoper.lighting_alpha = LIGHTING_PLANE_ALPHA_VISIBLE
	scoper.sync_lighting_plane_alpha()
	QDEL_NULL(scope_element)
	recalculate_scope_pos()
	scope_user = null
	scoping = FALSE
	if(scoper.client)
		scoper.client.set_pixel_x(0)
		scoper.client.set_pixel_y(0)

/// Handler for if the mob moves or changes look direction
/obj/item/attachable/vulture_scope/proc/on_mob_move_look(mob/living/mover, actually_moving, direction, specific_direction)
	SIGNAL_HANDLER

	if(actually_moving || (mover.dir != scope_user_initial_dir))
		on_unscope()

/// Causes the scope to drift in a random direction by 1 tile
/obj/item/attachable/vulture_scope/proc/scope_drift(forced_dir)
	var/dir_picked
	if(!forced_dir)
		dir_picked = pick(get_offset_dirs())
	else
		dir_picked = forced_dir

	adjust_offset(dir_picked)

/// Returns the turf that the sniper scope + reticle is currently focused on
/obj/item/attachable/vulture_scope/proc/get_viewed_turf()
	RETURN_TYPE(/turf)
	if(!scoping)
		return null
	var/turf/gun_turf = get_turf(src)
	return locate(scope_x + scope_offset_x, scope_y + scope_offset_y, gun_turf.z)

/// Lets the user start holding their breath, stopping gun sway for a short time
/obj/item/attachable/vulture_scope/proc/hold_breath()
	if(!scope_user)
		return

	var/mob/scoper = scope_user.resolve()
	to_chat(scoper, SPAN_NOTICE("你屏住呼吸，稳定瞄准镜..."))
	holding_breath = TRUE
	INVOKE_ASYNC(src, PROC_REF(tick_down_breath_scope))
	addtimer(CALLBACK(src, PROC_REF(stop_holding_breath)), breath_time)

/// Slowly empties out the crosshair as the user's breath runs out
/obj/item/attachable/vulture_scope/proc/tick_down_breath_scope()
	scope_element.icon_state = "vulture_steady_4"
	sleep(breath_time * 0.25)
	scope_element.icon_state = "vulture_steady_3"
	sleep(breath_time * 0.25)
	scope_element.icon_state = "vulture_steady_2"
	sleep(breath_time * 0.25)
	scope_element.icon_state = "vulture_steady_1"

/// Stops the user from holding their breath, starting the cooldown
/obj/item/attachable/vulture_scope/proc/stop_holding_breath()
	if(!scope_user || !holding_breath)
		return

	var/mob/scoper = scope_user.resolve()
	to_chat(scoper, SPAN_NOTICE("你呼出一口气，任由瞄准镜晃动。"))
	holding_breath = FALSE
	scope_element.icon_state = "vulture_unsteady"
	COOLDOWN_START(src, hold_breath_cd, breath_cooldown_time)

/// Returns a % of how much time until the user can still their breath again
/obj/item/attachable/vulture_scope/proc/get_breath_recharge()
	return 1 - (COOLDOWN_TIMELEFT(src, hold_breath_cd) / breath_cooldown_time)

/datum/action/item_action/vulture

/datum/action/item_action/vulture/action_activate()
	. = ..()
	var/obj/item/weapon/gun/gun_holder = holder_item
	var/obj/item/attachable/vulture_scope/scope = gun_holder.attachments["rail"]
	if(!istype(scope))
		return
	scope.tgui_interact(owner)

// ======== Stock attachments ======== //


/obj/item/attachable/stock //Generic stock parent and related things.
	name = "标准枪托"
	desc = "如果你能看到这个，说明有人搞砸了。去GitHub上报告，然后找个程序员修。"
	icon_state = "stock"
	slot = "stock"
	wield_delay_mod = WIELD_DELAY_VERY_FAST
	melee_mod = 5
	size_mod = 2
	pixel_shift_x = 30
	pixel_shift_y = 14

	var/collapsible = FALSE
	var/stock_activated = TRUE
	var/collapse_delay  = 0
	var/list/deploy_message = list("collapse", "extend")

/obj/item/attachable/stock/proc/apply_on_weapon(obj/item/weapon/gun/gun)
	return TRUE

/obj/item/attachable/stock/activate_attachment(obj/item/weapon/gun/gun, mob/living/carbon/user, turn_off)
	. = ..()

	if(!collapsible)
		return .

	if(turn_off && stock_activated)
		stock_activated = FALSE
		apply_on_weapon(gun)
		return TRUE

	if(!user)
		return TRUE

	if(gun.flags_item & WIELDED)
		to_chat(user, SPAN_NOTICE("你需要空出一只手来调整[src]。"))
		return TRUE

	if(!do_after(user, collapse_delay, INTERRUPT_INCAPACITATED|INTERRUPT_NEEDHAND, BUSY_ICON_GENERIC, gun, INTERRUPT_DIFF_LOC))
		return FALSE

	stock_activated = !stock_activated
	apply_on_weapon(gun)
	playsound(user, activation_sound, 15, 1)
	var/message = deploy_message[1 + stock_activated]
	to_chat(user, SPAN_NOTICE("你[message]了[src]。"))

	for(var/X in gun.actions)
		var/datum/action/A = X
		if(istype(A, /datum/action/item_action/toggle))
			A.update_button_icon()

/obj/item/attachable/stock
	icon = 'icons/obj/items/weapons/guns/attachments/stock.dmi'

/obj/item/attachable/stock/shotgun
	name = "\improper M37 wooden stock"
	desc = "M37霰弹枪的非标准重型木质枪托。比标准执勤型更笨重，但能减少后坐力并提高精度。据说在近战中也能当不错的棍棒用。"
	slot = "stock"
	icon_state = "stock"
	wield_delay_mod = WIELD_DELAY_FAST
	pixel_shift_x = 32
	pixel_shift_y = 15
	hud_offset_mod = 6 //*Very* long sprite.

/obj/item/attachable/stock/shotgun/New()
	..()
	//it makes stuff much better when two-handed
	accuracy_mod = HIT_ACCURACY_MULT_TIER_4
	recoil_mod = -RECOIL_AMOUNT_TIER_4
	scatter_mod = -SCATTER_AMOUNT_TIER_8
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
	//it makes stuff much worse when one handed
	accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_3
	recoil_unwielded_mod = RECOIL_AMOUNT_TIER_4
	scatter_unwielded_mod = SCATTER_AMOUNT_TIER_8
	//but at the same time you are slow when 2 handed
	aim_speed_mod = CONFIG_GET(number/slowdown_med)

	select_gamemode_skin(type)


/obj/item/attachable/stock/synth/collapsible
	name = "\improper M37A2 Collapsible Stock"
	desc = "M37A2的线框枪托，用于辅助控制后坐力。"
	slot = "stock"
	melee_mod = 5
	size_mod = 1
	icon_state = "37stock"
	attach_icon = "37stock"
	pixel_shift_x = 40
	pixel_shift_y = 14
	hud_offset_mod = 3
	collapsible = TRUE
	stock_activated = FALSE
	wield_delay_mod = WIELD_DELAY_NONE //starts collapsed so no delay mod
	collapse_delay = 0.5 SECONDS
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle/stock

/obj/item/attachable/stock/synth/collapsible/New()
	..()

	//rifle stock starts collapsed so we zero out everything
	accuracy_mod = 0
	recoil_mod = 0
	scatter_mod = 0
	movement_onehanded_acc_penalty_mod = 0
	accuracy_unwielded_mod = 0
	recoil_unwielded_mod = 0
	scatter_unwielded_mod = 0
	aim_speed_mod = 0
	wield_delay_mod = WIELD_DELAY_NONE
	select_gamemode_skin(type)


/obj/item/attachable/stock/synth/collapsible/apply_on_weapon(obj/item/weapon/gun/gun)
	if(stock_activated)
		accuracy_mod = HIT_ACCURACY_MULT_TIER_4
		recoil_mod = -RECOIL_AMOUNT_TIER_4
		scatter_mod = -SCATTER_AMOUNT_TIER_8
		//it makes stuff worse when one handed
		movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
		accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_3
		recoil_unwielded_mod = RECOIL_AMOUNT_TIER_4
		scatter_unwielded_mod =  SCATTER_AMOUNT_TIER_8
		aim_speed_mod = CONFIG_GET(number/slowdown_med)
		hud_offset_mod = 5
		select_gamemode_skin(type)
		wield_delay_mod = WIELD_DELAY_VERY_FAST //added 0.2 seconds for wield, basic solid stock adds 0.4

	else
		accuracy_mod = 0
		recoil_mod = 0
		scatter_mod = 0
		movement_onehanded_acc_penalty_mod = 0
		accuracy_unwielded_mod = 0
		recoil_unwielded_mod = 0
		scatter_unwielded_mod = 0
		aim_speed_mod = 0
		hud_offset_mod = 5
		select_gamemode_skin(type)
		wield_delay_mod = WIELD_DELAY_NONE //stock is folded so no wield delay

	gun.recalculate_attachment_bonuses()
	gun.update_overlays(src, "stock")

/obj/item/attachable/stock/synth/collapsible/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..() // We are forcing attach_icon skin
	var/new_attach_icon
	var/new_icon_state
	if(stock_activated)
		switch(SSmapping.configs[GROUND_MAP].camouflage_type)
			if("jungle")
				attach_icon = new_attach_icon ? new_attach_icon : initial(attach_icon) + "_on"
				icon_state = new_icon_state ? new_icon_state : initial(icon_state) + "_on"
				. = TRUE
			if("snow")
				attach_icon = new_attach_icon ? new_attach_icon : "s_" + initial(attach_icon) + "_on"
				icon_state = new_icon_state ? new_icon_state : "s_" + initial(icon_state) + "_on"
				. = TRUE
			if("desert")
				attach_icon = new_attach_icon ? new_attach_icon : "d_" + initial(attach_icon) + "_on"
				icon_state = new_icon_state ? new_icon_state : "d_" + initial(icon_state) + "_on"
				. = TRUE
			if("classic")
				attach_icon = new_attach_icon ? new_attach_icon : "c_" + initial(attach_icon) + "_on"
				icon_state = new_icon_state ? new_icon_state : "c_" + initial(icon_state) + "_on"
				. = TRUE
			if("urban")
				attach_icon = new_attach_icon ? new_attach_icon : "u_" + initial(attach_icon) + "_on"
				icon_state = new_icon_state ? new_icon_state : "u_" + initial(icon_state) + "_on"
				. = TRUE
	else
		switch(SSmapping.configs[GROUND_MAP].camouflage_type)
			if("jungle")
				attach_icon = new_attach_icon ? new_attach_icon : initial(attach_icon)
				icon_state = new_icon_state ? new_icon_state : initial(icon_state)
				. = TRUE
			if("snow")
				attach_icon = new_attach_icon ? new_attach_icon : "s_" + initial(attach_icon)
				icon_state = new_icon_state ? new_icon_state : "s_" + initial(icon_state)
				. = TRUE
			if("desert")
				attach_icon = new_attach_icon ? new_attach_icon : "d_" + initial(attach_icon)
				icon_state = new_icon_state ? new_icon_state : "d_" + initial(icon_state)
				. = TRUE
			if("classic")
				attach_icon = new_attach_icon ? new_attach_icon : "c_" + initial(attach_icon)
				icon_state = new_icon_state ? new_icon_state : "c_" + initial(icon_state)
				. = TRUE
			if("urban")
				attach_icon = new_attach_icon ? new_attach_icon : "u_" + initial(attach_icon)
				icon_state = new_icon_state ? new_icon_state : "u_" + initial(icon_state)
				. = TRUE
	return .

/obj/item/attachable/stock/double
	name = "\improper double barrel shotgun stock"
	desc = "一块涂有清漆、饱经风霜的厚实木头。"
	slot = "stock"
	icon_state = "db_stock"
	wield_delay_mod = WIELD_DELAY_NONE//part of the gun's base stats
	flags_attach_features = NO_FLAGS
	pixel_shift_x = 32
	pixel_shift_y = 15
	hud_offset_mod = 2

/obj/item/attachable/stock/double/New()
	..()

/obj/item/attachable/stock/mou53
	name = "\improper MOU53 tactical stock"
	desc = "专为MOU53撅把式霰弹枪设计的金属枪托。"
	icon_state = "ou_stock"
	hud_offset_mod = 5

/obj/item/attachable/stock/mou53/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_1
	recoil_mod = -RECOIL_AMOUNT_TIER_5
	scatter_mod = -SCATTER_AMOUNT_TIER_10
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_1
	recoil_unwielded_mod = -RECOIL_AMOUNT_TIER_5
	scatter_unwielded_mod = -SCATTER_AMOUNT_TIER_10

/obj/item/attachable/stock/r4t
	name = "\improper R4T scouting stock"
	desc = "专为R4T杠杆式步枪设计的木质枪托，旨在承受恶劣环境。它能提升武器稳定性，但确实很碍事。"
	icon_state = "r4t-stock"
	wield_delay_mod = WIELD_DELAY_SLOW
	hud_offset_mod = 6

/obj/item/attachable/stock/r4t/New()
	..()
	select_gamemode_skin(type)
	recoil_mod = -RECOIL_AMOUNT_TIER_5
	scatter_mod = -SCATTER_AMOUNT_TIER_8
	recoil_unwielded_mod = RECOIL_AMOUNT_TIER_5
	scatter_unwielded_mod = SCATTER_AMOUNT_TIER_4

/obj/item/attachable/stock/pistol/collapsible
	name = "\improper M10 folding stock"
	desc = "专为M10自动手枪定制的折叠枪托。展开时增强后坐力控制，同时保持紧凑性以用于近距离作战。"
	slot = "stock"
	icon_state = "m10_folding"
	attach_icon = "m10_folding_a"
	pixel_shift_x = 40
	pixel_shift_y = 14
	hud_offset_mod = 3
	collapsible = TRUE
	stock_activated = FALSE
	collapse_delay = 0.5 SECONDS
	wield_delay_mod = WIELD_DELAY_NONE
	flags_attach_features = ATTACH_REMOVABLE | ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle

	var/base_icon = "m10_folding"

/obj/item/attachable/stock/pistol/collapsible/New()
	..()
	select_gamemode_skin(type)
	//it makes stuff much better when two-handed
	accuracy_mod = HIT_ACCURACY_MULT_TIER_3
	recoil_mod = -RECOIL_AMOUNT_TIER_4
	scatter_mod = -SCATTER_AMOUNT_TIER_8
	wield_delay_mod = WIELD_DELAY_FAST
	delay_mod = 0
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_6
	//it makes stuff much worse when one handed
	accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_3
	recoil_unwielded_mod = RECOIL_AMOUNT_TIER_4
	scatter_unwielded_mod = SCATTER_AMOUNT_TIER_10
	//but at the same time you are slowish when 2 handed
	aim_speed_mod = CONFIG_GET(number/slowdown_low)

/obj/item/attachable/stock/pistol/collapsible/apply_on_weapon(obj/item/weapon/gun/gun)
	if (stock_activated)
		accuracy_mod = HIT_ACCURACY_MULT_TIER_3
		recoil_mod = -RECOIL_AMOUNT_TIER_4
		scatter_mod = -SCATTER_AMOUNT_TIER_8
		scatter_unwielded_mod = SCATTER_AMOUNT_TIER_10
		size_mod = 1
		aim_speed_mod = CONFIG_GET(number/slowdown_low)
		wield_delay_mod = WIELD_DELAY_FAST
		movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_6
		accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_3
		recoil_unwielded_mod = RECOIL_AMOUNT_TIER_4
	else
		accuracy_mod = 0
		recoil_mod = 0
		scatter_mod = 0
		movement_onehanded_acc_penalty_mod = 0
		accuracy_unwielded_mod = 0
		recoil_unwielded_mod = 0
		scatter_unwielded_mod = 0
		aim_speed_mod = 0
		hud_offset_mod = 3
		wield_delay_mod = WIELD_DELAY_NONE

	select_gamemode_skin(type)
	gun.recalculate_attachment_bonuses()
	gun.update_overlays(src, "stock")

/obj/item/attachable/stock/pistol/collapsible/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	var/prefix = ""
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("classic") prefix = "c_"
		if("desert") prefix = "d_"
		if("snow") prefix = "s_"
		if("urban") prefix = "u_"

	var/suffix = stock_activated ? "_on" : ""
	icon_state = "[prefix][base_icon][suffix]"
	attach_icon = "[prefix][base_icon]_a[suffix]"

/obj/item/attachable/stock/m10_solid
	name = "\improper M10 solid stock"
	desc = "专为M10自动手枪设计的固定聚合物枪托，提高持续射击时的稳定性。"
	icon_state = "m10_stock"
	attach_icon = "m10_stock_a"
	wield_delay_mod = WIELD_DELAY_FAST
	pixel_shift_x = 40
	pixel_shift_y = 14
	hud_offset_mod = 3
	melee_mod = 10

/obj/item/attachable/stock/m10_solid/Initialize(mapload, ...)
	. = ..()
	select_gamemode_skin(type)
	accuracy_mod = HIT_ACCURACY_MULT_TIER_7
	recoil_mod = -RECOIL_AMOUNT_TIER_3
	scatter_mod = -SCATTER_AMOUNT_TIER_6
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
	accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_5
	recoil_unwielded_mod = RECOIL_AMOUNT_TIER_5
	scatter_unwielded_mod = SCATTER_AMOUNT_TIER_6
	aim_speed_mod = CONFIG_GET(number/slowdown_low)
	delay_mod = 0

/obj/item/attachable/stock/m10_solid/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..() // We are forcing attach_icon skin
	var/new_attach_icon
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("snow")
			attach_icon = new_attach_icon ? new_attach_icon : "s_" + attach_icon
			. = TRUE
		if("desert")
			attach_icon = new_attach_icon ? new_attach_icon : "d_" + attach_icon
			. = TRUE
		if("classic")
			attach_icon = new_attach_icon ? new_attach_icon : "c_" + attach_icon
			. = TRUE
		if("urban")
			attach_icon = new_attach_icon ? new_attach_icon : "u_" + attach_icon
			. = TRUE
	return .

/obj/item/attachable/stock/xm88
	name = "\improper XM88 padded stock"
	desc = "特制复合聚合物枪托，内嵌铝制加强杆和厚橡胶垫以缓冲后坐力。专为XM88重型步枪设计。"
	icon_state = "boomslang-stock"
	wield_delay_mod = WIELD_DELAY_NORMAL
	hud_offset_mod = 6

/obj/item/attachable/stock/xm88/New()
	..()
	select_gamemode_skin(type)
	recoil_mod = -RECOIL_AMOUNT_TIER_5
	scatter_mod = -SCATTER_AMOUNT_TIER_8
	recoil_unwielded_mod = RECOIL_AMOUNT_TIER_5
	scatter_unwielded_mod = SCATTER_AMOUNT_TIER_4

/obj/item/attachable/stock/tactical
	name = "\improper MK221 tactical stock"
	desc = "为MK221战术霰弹枪制造的金属枪托。"
	icon_state = "tactical_stock"
	hud_offset_mod = 6

/obj/item/attachable/stock/tactical/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_1
	recoil_mod = -RECOIL_AMOUNT_TIER_5
	scatter_mod = -SCATTER_AMOUNT_TIER_10
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_1
	recoil_unwielded_mod = -RECOIL_AMOUNT_TIER_5
	scatter_unwielded_mod = -SCATTER_AMOUNT_TIER_10

/obj/item/attachable/stock/type23
	name = "\improper Type 23 standard stock"
	desc = "冲压金属枪托，内置后坐力弹簧，用于吸收8号口径霰弹枪开火时的巨大后坐力。不建议拆卸。"
	icon_state = "type23_stock"
	pixel_shift_x = 15
	pixel_shift_y = 15
	hud_offset_mod = 2

/obj/item/attachable/stock/type23/New()
	..()
	//2h
	accuracy_mod = HIT_ACCURACY_MULT_TIER_4
	recoil_mod = -RECOIL_AMOUNT_TIER_4
	scatter_mod = -SCATTER_AMOUNT_TIER_8
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
	//1h
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_1
	recoil_unwielded_mod = -RECOIL_AMOUNT_TIER_5
	scatter_unwielded_mod = -SCATTER_AMOUNT_TIER_10

/obj/item/attachable/stock/rifle
	name = "\improper M41A solid stock"
	desc = "少量配发给USCM部队的稀有枪托。兼容M41A，可减少后坐力并提高精度，但会降低操控性和灵活性。同时也能增强用枪托末端敲击物体的威力。"
	slot = "stock"
	melee_mod = 10
	size_mod = 1
	icon_state = "riflestock"
	attach_icon = "riflestock_a"
	pixel_shift_x = 40
	pixel_shift_y = 10
	wield_delay_mod = WIELD_DELAY_FAST
	hud_offset_mod = 3

/obj/item/attachable/stock/rifle/New()
	..()
	//it makes stuff much better when two-handed
	accuracy_mod = HIT_ACCURACY_MULT_TIER_5
	recoil_mod = -RECOIL_AMOUNT_TIER_3
	scatter_mod = -SCATTER_AMOUNT_TIER_7
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_4
	//it makes stuff much worse when one handed
	accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_3
	recoil_unwielded_mod = RECOIL_AMOUNT_TIER_4
	scatter_unwielded_mod = SCATTER_AMOUNT_TIER_8
	//but at the same time you are slow when 2 handed
	aim_speed_mod = CONFIG_GET(number/slowdown_med)

/obj/item/attachable/stock/rifle/collapsible
	name = "\improper M41A folding stock"
	desc = "任何以开头的枪支的标准后端。\"M41\". Compatible with the M41A series, this stock reduces recoil and improves accuracy, but at a reduction to handling and agility. Also enhances the thwacking of things with the stock-end of the rifle."
	slot = "stock"
	melee_mod = 5
	size_mod = 1
	icon_state = "m41_folding"
	attach_icon = "m41_folding_a"
	pixel_shift_x = 40
	pixel_shift_y = 14
	hud_offset_mod = 3
	collapsible = TRUE
	stock_activated = FALSE
	wield_delay_mod = WIELD_DELAY_NONE //starts collapsed so no delay mod
	collapse_delay = 0.5 SECONDS
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle/stock

/obj/item/attachable/stock/rifle/collapsible/New()
	..()

	//rifle stock starts collapsed so we zero out everything
	accuracy_mod = 0
	recoil_mod = 0
	scatter_mod = 0
	movement_onehanded_acc_penalty_mod = 0
	accuracy_unwielded_mod = 0
	recoil_unwielded_mod = 0
	scatter_unwielded_mod = 0
	aim_speed_mod = 0
	wield_delay_mod = WIELD_DELAY_NONE

/obj/item/attachable/stock/rifle/collapsible/apply_on_weapon(obj/item/weapon/gun/gun)
	if(stock_activated)
		accuracy_mod = HIT_ACCURACY_MULT_TIER_2
		recoil_mod = -RECOIL_AMOUNT_TIER_5
		scatter_mod = -SCATTER_AMOUNT_TIER_9
		//it makes stuff worse when one handed
		movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
		accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_3
		recoil_unwielded_mod = RECOIL_AMOUNT_TIER_4
		scatter_unwielded_mod = SCATTER_AMOUNT_TIER_8
		aim_speed_mod = CONFIG_GET(number/slowdown_med)
		hud_offset_mod = 5
		icon_state = "m41_folding_on"
		attach_icon = "m41_folding_a_on"
		wield_delay_mod = WIELD_DELAY_VERY_FAST //added 0.2 seconds for wield, basic solid stock adds 0.4

	else
		accuracy_mod = 0
		recoil_mod = 0
		scatter_mod = 0
		movement_onehanded_acc_penalty_mod = 0
		accuracy_unwielded_mod = 0
		recoil_unwielded_mod = 0
		scatter_unwielded_mod = 0
		aim_speed_mod = 0
		hud_offset_mod = 3
		icon_state = "m41_folding"
		attach_icon = "m41_folding_a"
		wield_delay_mod = WIELD_DELAY_NONE //stock is folded so no wield delay

	gun.recalculate_attachment_bonuses()
	gun.update_overlays(src, "stock")

/obj/item/attachable/stock/rifle/collapsible/ak4047
	name = "\improper AK-4047 folding stock"
	desc =  "任何以'AK'开头的枪支的标准后端。兼容AK-4047系列，此枪托可减少后坐力并提高精度，但会降低操控性和灵活性。和它的前辈一样，也能增强用枪托末端敲击物体的威力。"
	slot = "stock"
	melee_mod = 5
	size_mod = 1
	icon_state = "ak4047_folding"
	attach_icon = "ak4047_folding_a"
	pixel_shift_x = 29
	hud_offset_mod = 3
	collapsible = TRUE
	stock_activated = FALSE
	wield_delay_mod = WIELD_DELAY_NONE //starts collapsed so no delay mod
	collapse_delay = 0.5 SECONDS
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle/stock

/obj/item/attachable/stock/rifle/collapsible/ak4047/New()
	..()

	//rifle stock starts collapsed so we zero out everything
	accuracy_mod = 0
	recoil_mod = 0
	scatter_mod = 0
	movement_onehanded_acc_penalty_mod = 0
	accuracy_unwielded_mod = 0
	recoil_unwielded_mod = 0
	scatter_unwielded_mod = 0
	aim_speed_mod = 0
	wield_delay_mod = WIELD_DELAY_NONE

/obj/item/attachable/stock/rifle/collapsible/ak4047/apply_on_weapon(obj/item/weapon/gun/gun)
	if(stock_activated)
		accuracy_mod = HIT_ACCURACY_MULT_TIER_2
		recoil_mod = -RECOIL_AMOUNT_TIER_5
		scatter_mod = -SCATTER_AMOUNT_TIER_9
		//it makes stuff worse when one handed
		movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
		accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_3
		recoil_unwielded_mod = RECOIL_AMOUNT_TIER_4
		scatter_unwielded_mod = SCATTER_AMOUNT_TIER_8
		aim_speed_mod = CONFIG_GET(number/slowdown_med)
		hud_offset_mod = 5
		icon_state = "ak4047_folding_on"
		attach_icon = "ak4047_folding_a_on"
		wield_delay_mod = WIELD_DELAY_VERY_FAST //added 0.2 seconds for wield, basic solid stock adds 0.4

	else
		accuracy_mod = 0
		recoil_mod = 0
		scatter_mod = 0
		movement_onehanded_acc_penalty_mod = 0
		accuracy_unwielded_mod = 0
		recoil_unwielded_mod = 0
		scatter_unwielded_mod = 0
		aim_speed_mod = 0
		hud_offset_mod = 3
		icon_state = "ak4047_folding"
		attach_icon = "ak4047_folding_a"
		wield_delay_mod = WIELD_DELAY_NONE //stock is folded so no wield delay

	gun.recalculate_attachment_bonuses()
	gun.update_overlays(src, "stock")

/obj/item/attachable/stock/rifle/collapsible/m41ae2
	name = "\improper M41AE2 folding stock"
	desc = "标准M41AE2集成折叠枪托。"
	slot = "stock"
	melee_mod = 5
	size_mod = 1
	icon_state = "m41ae2_folding"
	attach_icon = "m41ae2_folding_a"
	pixel_shift_x = 29
	hud_offset_mod = -2
	collapsible = TRUE
	stock_activated = FALSE
	wield_delay_mod = WIELD_DELAY_NONE //starts collapsed so no delay mod
	collapse_delay = 0.5 SECONDS
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle/stock

/obj/item/attachable/stock/rifle/collapsible/m41ae2/New()
	..()

	//rifle stock starts collapsed so we zero out everything
	accuracy_mod = 0
	recoil_mod = 0
	scatter_mod = 0
	aim_speed_mod = 0
	wield_delay_mod = WIELD_DELAY_NONE

/obj/item/attachable/stock/rifle/collapsible/m41ae2/apply_on_weapon(obj/item/weapon/gun/gun)
	if(stock_activated)
		accuracy_mod = HIT_ACCURACY_MULT_TIER_1
		recoil_mod = -RECOIL_AMOUNT_TIER_5
		scatter_mod = -SCATTER_AMOUNT_TIER_10
		//it makes stuff worse when one handed
		aim_speed_mod = CONFIG_GET(number/slowdown_med)
		hud_offset_mod = -1
		icon_state = "m41ae2_folding_on"
		attach_icon = "m41ae2_folding_a_on"
		wield_delay_mod = WIELD_DELAY_SLOW
	else
		accuracy_mod = 0
		recoil_mod = 0
		scatter_mod = 0
		aim_speed_mod = 0
		hud_offset_mod = -3
		icon_state = "m41ae2_folding"
		attach_icon = "m41ae2_folding_a"
		wield_delay_mod = WIELD_DELAY_NONE //stock is folded so no wield delay

	gun.recalculate_attachment_bonuses()
	gun.update_overlays(src, "stock")

/obj/item/attachable/stock/xm177
	name = "\improper collapsible M16 stock"
	desc = "在加利福尼亚州非常非法。"
	icon_state = "m16_folding"
	attach_icon = "m16_folding"
	collapsible = TRUE
	stock_activated = FALSE
	wield_delay_mod = WIELD_DELAY_NONE //starts collapsed so no delay mod
	collapse_delay = 0.5 SECONDS
	flags_attach_features = ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle/stock
	var/base_icon = "m16_folding"

/obj/item/attachable/stock/xm177/Initialize()
	.=..()
	accuracy_mod = 0
	recoil_mod = 0
	scatter_mod = 0
	movement_onehanded_acc_penalty_mod = 0
	accuracy_unwielded_mod = 0
	recoil_unwielded_mod = 0
	scatter_unwielded_mod = 0
	aim_speed_mod = 0
	wield_delay_mod = WIELD_DELAY_NONE

/obj/item/attachable/stock/xm177/apply_on_weapon(obj/item/weapon/gun/gun)
	if(stock_activated)
		accuracy_mod = HIT_ACCURACY_MULT_TIER_2
		recoil_mod = -RECOIL_AMOUNT_TIER_5
		scatter_mod = -SCATTER_AMOUNT_TIER_9
		aim_speed_mod = CONFIG_GET(number/slowdown_med)
		hud_offset_mod = 5
		icon_state = base_icon
		attach_icon = "[base_icon]_on"
		wield_delay_mod = WIELD_DELAY_VERY_FAST

	else
		accuracy_mod = 0
		recoil_mod = 0
		scatter_mod = 0
		movement_onehanded_acc_penalty_mod = 0
		accuracy_unwielded_mod = 0
		recoil_unwielded_mod = 0
		scatter_unwielded_mod = 0
		aim_speed_mod = 0
		hud_offset_mod = 3
		icon_state = base_icon
		attach_icon = base_icon
		wield_delay_mod = WIELD_DELAY_NONE //stock is folded so no wield delay
	gun.recalculate_attachment_bonuses()
	gun.update_overlays(src, "stock")


/obj/item/attachable/stock/xm177/car15a3
	name = "\improper collapsible CAR-15A3 stock"
	icon_state = "car_folding"
	attach_icon = "car_folding"
	base_icon = "car_folding"

/obj/item/attachable/stock/xm51
	name = "\improper XM51 stock"
	desc = "专为XM51破门霰弹枪设计的特种枪托。帮助使用者吸收武器后坐力，同时减少散射。枪托内部集成机构允许使用毁灭性的两连发点射。代价是枪支变得过于笨重无法入套，且操控性和机动性更差。"
	icon_state = "xm51_stock"
	attach_icon = "xm51_stock_a"
	wield_delay_mod = WIELD_DELAY_FAST
	hud_offset_mod = 3
	melee_mod = 10

/obj/item/attachable/stock/xm51/Initialize(mapload, ...)
	. = ..()
	select_gamemode_skin(type)
	//it makes stuff much better when two-handed
	accuracy_mod = HIT_ACCURACY_MULT_TIER_3
	recoil_mod = -RECOIL_AMOUNT_TIER_4
	scatter_mod = -SCATTER_AMOUNT_TIER_8
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_4
	//and allows for burst-fire
	burst_mod = BURST_AMOUNT_TIER_2
	//but it makes stuff much worse when one handed
	accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_5
	recoil_unwielded_mod = RECOIL_AMOUNT_TIER_5
	scatter_unwielded_mod = SCATTER_AMOUNT_TIER_6
	//and makes you slower
	aim_speed_mod = CONFIG_GET(number/slowdown_med)

/obj/item/attachable/stock/xm51/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..() // We are forcing attach_icon skin
	var/new_attach_icon
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("snow")
			attach_icon = new_attach_icon ? new_attach_icon : "s_" + attach_icon
			. = TRUE
		if("desert")
			attach_icon = new_attach_icon ? new_attach_icon : "d_" + attach_icon
			. = TRUE
		if("classic")
			attach_icon = new_attach_icon ? new_attach_icon : "c_" + attach_icon
			. = TRUE
		if("urban")
			attach_icon = new_attach_icon ? new_attach_icon : "u_" + attach_icon
			. = TRUE
	return .

/obj/item/attachable/stock/mod88
	AUTOWIKI_SKIP(TRUE)

	name = "\improper Mod 88 burst stock"
	desc = "提升Mod 88的射速和连发数量。某些版本在未安装时可作为该武器的枪套。此为测试物品，不应在常规游戏中使用（目前）。"
	icon_state = "mod88_stock"
	attach_icon = "mod88_stock_a"
	wield_delay_mod = WIELD_DELAY_FAST
	flags_attach_features = NO_FLAGS
	hud_offset_mod = 4
	size_mod = 2
	melee_mod = 5

/obj/item/attachable/stock/mod88/New()
	..()
	//2h
	accuracy_mod = HIT_ACCURACY_MULT_TIER_3
	recoil_mod = -RECOIL_AMOUNT_TIER_2
	scatter_mod = -SCATTER_AMOUNT_TIER_7
	burst_scatter_mod = -1
	burst_mod = BURST_AMOUNT_TIER_2
	delay_mod = -FIRE_DELAY_TIER_11
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_4
	//1h
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_1
	recoil_unwielded_mod = -RECOIL_AMOUNT_TIER_5
	scatter_unwielded_mod = -SCATTER_AMOUNT_TIER_10

/obj/item/attachable/stock/carbine
	name = "\improper L42 synthetic stock"
	desc = "一种由坚固而轻质材料制成的特制枪托。可安装于L42A战斗步枪上。作为钝器使用效果不佳。"
	slot = "stock"
	size_mod = 1
	icon_state = "l42stock"
	attach_icon = "l42stock_a"
	pixel_shift_x = 37
	pixel_shift_y = 8
	wield_delay_mod = WIELD_DELAY_NORMAL
	hud_offset_mod = 2

/obj/item/attachable/stock/carbine/New()
	..()
	//it makes stuff much better when two-handed
	accuracy_mod = HIT_ACCURACY_MULT_TIER_6
	recoil_mod = -RECOIL_AMOUNT_TIER_4
	scatter_mod = -SCATTER_AMOUNT_TIER_8
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
	//it makes stuff much worse when one handed
	accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_3
	recoil_unwielded_mod = RECOIL_AMOUNT_TIER_4
	scatter_unwielded_mod = SCATTER_AMOUNT_TIER_8

/obj/item/attachable/stock/carbine/wood
	name = "\improper ABR-40 \"wooden\" stock"
	desc = "默认\"wooden\" stock for the ABR-40 hunting rifle, the civilian version of the military L42A battle rifle. Theoretically compatible with an L42. Wait, did you just take the stock out of a weapon with no grip...? Great job, genius."
	icon_state = "abr40stock"
	attach_icon = "abr40stock_a"
	melee_mod = 6
	wield_delay_mod = WIELD_DELAY_FAST

/obj/item/attachable/stock/carbine/wood/Initialize() // The gun is meant to be effectively unusable without the attachment.
	. = ..()
	accuracy_mod = (HIT_ACCURACY_MULT_TIER_6) + HIT_ACCURACY_MULT_TIER_10
	recoil_mod = -RECOIL_AMOUNT_TIER_4
	scatter_mod = (-SCATTER_AMOUNT_TIER_8) - SCATTER_AMOUNT_TIER_5

/obj/item/attachable/stock/carbine/wood/tactical
	name = "\improper ABR-40 tactical stock"
	desc = "一款带有光滑涂装的ABR-40枪托。等等，你刚从一个没有握把的武器上拆下了枪托...？干得漂亮，天才。"
	icon_state = "abr40stock_tac"
	attach_icon = "abr40stock_tac_a"

/obj/item/attachable/stock/carbine/l42a3
	name = "\improper L42A3 synthetic stock"
	desc = "一种由坚固而轻质材料制成的标准枪托。可安装于L42A3战斗步枪上。作为钝器使用效果不佳。"
	icon_state = "l42a3stock"
	attach_icon = "l42a3stock_a"

/obj/item/attachable/stock/carbine/l42a3/marksman
	name = "\improper L42A3 marksman stock"
	desc = "一种由坚固而轻质材料制成的特制枪托。可安装于L42A3战斗步枪上。作为钝器使用效果不佳。"

	wield_delay_mod = WIELD_DELAY_FAST

/obj/item/attachable/stock/smg
	name = "冲锋枪枪托"
	desc = "一种少量配发给USCM部队的稀有阿玛特枪托。与M39兼容，此枪托可减少后坐力并提高精度，但会降低操控性和敏捷性。在近身格斗中似乎也稍有效果。"
	slot = "stock"
	melee_mod = 15
	size_mod = 1
	icon_state = "smgstock"
	attach_icon = "smgstock_a"
	pixel_shift_x = 42
	pixel_shift_y = 11
	wield_delay_mod = WIELD_DELAY_FAST
	hud_offset_mod = 5

/obj/item/attachable/stock/smg/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_7
	recoil_mod = -RECOIL_AMOUNT_TIER_3
	scatter_mod = -SCATTER_AMOUNT_TIER_6
	delay_mod = 0
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
	aim_speed_mod = CONFIG_GET(number/slowdown_low)
	AddElement(/datum/element/corp_label/armat)


/obj/item/attachable/stock/smg/collapsible
	name = "冲锋枪折叠枪托"
	desc = "一款Kirchner品牌的K2 M39折叠枪托，USCM标准配发。枪托展开时可减少后坐力并提高精度，但会降低操控性和敏捷性。在近身格斗中似乎也稍有效果。此枪托可折叠收起，移除所有正面和负面效果。"
	slot = "stock"
	melee_mod = 10
	size_mod = 1
	icon_state = "smgstockc"
	attach_icon = "smgstockc_a"
	pixel_shift_x = 43
	pixel_shift_y = 11
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle/stock
	hud_offset_mod = 5
	collapsible = TRUE
	var/base_icon = "smgstockc"

/obj/item/attachable/stock/smg/collapsible/New()
	..()
	//it makes stuff much better when two-handed
	accuracy_mod = HIT_ACCURACY_MULT_TIER_3
	recoil_mod = -RECOIL_AMOUNT_TIER_4
	scatter_mod = -SCATTER_AMOUNT_TIER_8
	wield_delay_mod = WIELD_DELAY_FAST
	delay_mod = 0
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
	//it makes stuff much worse when one handed
	accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_3
	recoil_unwielded_mod = RECOIL_AMOUNT_TIER_4
	scatter_unwielded_mod = SCATTER_AMOUNT_TIER_10
	//but at the same time you are slowish when 2 handed
	aim_speed_mod = CONFIG_GET(number/slowdown_low)


/obj/item/attachable/stock/smg/collapsible/apply_on_weapon(obj/item/weapon/gun/gun)
	if(stock_activated)
		accuracy_mod = HIT_ACCURACY_MULT_TIER_3
		recoil_mod = -RECOIL_AMOUNT_TIER_4
		scatter_mod = -SCATTER_AMOUNT_TIER_8
		scatter_unwielded_mod = SCATTER_AMOUNT_TIER_10
		size_mod = 1
		aim_speed_mod = CONFIG_GET(number/slowdown_low)
		wield_delay_mod = WIELD_DELAY_FAST
		movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
		accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_3
		recoil_unwielded_mod = RECOIL_AMOUNT_TIER_4
		hud_offset_mod = 5
		icon_state = base_icon
		attach_icon = "[base_icon]_a"

	else
		accuracy_mod = 0
		recoil_mod = 0
		scatter_mod = 0
		scatter_unwielded_mod = 0
		size_mod = 0
		aim_speed_mod = 0
		wield_delay_mod = 0
		movement_onehanded_acc_penalty_mod = 0
		accuracy_unwielded_mod = 0
		recoil_unwielded_mod = 0
		hud_offset_mod = 3
		icon_state = "[base_icon]c"
		attach_icon = "[base_icon]c_a"

	gun.recalculate_attachment_bonuses()
	gun.update_overlays(src, "stock")

/obj/item/attachable/stock/smg/collapsible/mp5a5
	name = "MP5A5折叠枪托"
	icon_state = "mp5_stockc"
	base_icon = "mp5_stockc"
	attach_icon = "mp5_stockc_a"
	flags_attach_features = ATTACH_ACTIVATION
	stock_activated = FALSE

/obj/item/attachable/stock/smg/collapsible/brace
	name = "\improper submachinegun arm brace"
	desc = "专为M39冲锋枪设计的特殊枪托。它提高了单手持枪的精度，但牺牲了连发数量。安装此枪托后单手持用武器会带来严重的精度下降和后坐力惩罚。"
	size_mod = 1
	icon_state = "smg_brace"
	base_icon = "smg_brace"
	attach_icon = "smg_brace_a"
	pixel_shift_x = 43
	pixel_shift_y = 11
	collapse_delay = 2.5 SECONDS
	stock_activated = FALSE
	deploy_message = list("unlock","lock")
	hud_offset_mod = 4

/obj/item/attachable/stock/smg/collapsible/brace/New()
	..()
	//Emulates two-handing an SMG.
	burst_mod = -BURST_AMOUNT_TIER_3 //2 shots instead of 5.

	accuracy_mod = -HIT_ACCURACY_MULT_TIER_3
	scatter_mod = SCATTER_AMOUNT_TIER_8
	recoil_mod = RECOIL_AMOUNT_TIER_2
	aim_speed_mod = 0
	wield_delay_mod = WIELD_DELAY_NORMAL//you shouldn't be wielding it anyways

/obj/item/attachable/stock/smg/collapsible/brace/apply_on_weapon(obj/item/weapon/gun/G)
	if(stock_activated)
		G.flags_item |= NODROP|FORCEDROP_CONDITIONAL
		accuracy_mod = -HIT_ACCURACY_MULT_TIER_3
		scatter_mod = SCATTER_AMOUNT_TIER_8
		recoil_mod = RECOIL_AMOUNT_TIER_2 //Hurts pretty bad if it's wielded.
		accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_4
		recoil_unwielded_mod = -RECOIL_AMOUNT_TIER_4
		movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_4 //Does well if it isn't.
		hud_offset_mod = 5
		icon_state = "smg_brace_on"
		attach_icon = "smg_brace_a_on"
	else
		G.flags_item &= ~(NODROP|FORCEDROP_CONDITIONAL)
		accuracy_mod = 0
		scatter_mod = 0
		recoil_mod = 0
		accuracy_unwielded_mod = 0
		recoil_unwielded_mod = 0
		movement_onehanded_acc_penalty_mod = 0 //Does pretty much nothing if it's not activated.
		hud_offset_mod = 4
		icon_state = "smg_brace"
		attach_icon = "smg_brace_a"

	G.recalculate_attachment_bonuses()
	G.update_overlays(src, "stock")

/obj/item/attachable/stock/revolver
	name = "\improper M44 magnum sharpshooter stock"
	desc = "一款为.44马格南手枪改装的木质枪托。以提高精度和减少后坐力为代价，牺牲了操控性和敏捷性。近战效果也较差。"
	slot = "stock"
	melee_mod = -5
	size_mod = 1
	icon_state = "44stock"
	pixel_shift_x = 35
	pixel_shift_y = 19
	wield_delay_mod = WIELD_DELAY_FAST
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle/stock
	hud_offset_mod = 7 //Extremely long.
	var/folded = FALSE
	var/list/allowed_hat_items = list(
					/obj/item/ammo_magazine/revolver,
					/obj/item/ammo_magazine/revolver/marksman,
					/obj/item/ammo_magazine/revolver/heavy)

/obj/item/attachable/stock/revolver/New()
	..()
	//it makes stuff much better when two-handed
	accuracy_mod = HIT_ACCURACY_MULT_TIER_7
	recoil_mod = -RECOIL_AMOUNT_TIER_4
	scatter_mod = -SCATTER_AMOUNT_TIER_8
	//it makes stuff much worse when one handed
	accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_3
	recoil_unwielded_mod = RECOIL_AMOUNT_TIER_4
	scatter_unwielded_mod = SCATTER_AMOUNT_TIER_8
	//but at the same time you are slow when 2 handed
	aim_speed_mod = CONFIG_GET(number/slowdown_med)


/obj/item/attachable/stock/revolver/activate_attachment(obj/item/weapon/gun/G, mob/living/carbon/user, turn_off)
	var/obj/item/weapon/gun/revolver/m44/R = G
	if(!istype(R))
		return 0

	if(!user)
		return 1

	if(user.action_busy)
		return

	if(R.flags_item & WIELDED)
		if(folded)
			to_chat(user, SPAN_NOTICE("你需要一只空手来展开[src]。"))
		else
			to_chat(user, SPAN_NOTICE("你需要一只空手来折叠[src]。"))
		return 0

	if(!do_after(user, 15, INTERRUPT_INCAPACITATED|INTERRUPT_NEEDHAND, BUSY_ICON_GENERIC, G, INTERRUPT_DIFF_LOC))
		return

	playsound(user, activation_sound, 15, 1)

	if(folded)
		to_chat(user, SPAN_NOTICE("你展开了[src]。"))
		R.flags_equip_slot &= ~SLOT_WAIST
		R.folded = FALSE
		icon_state = "44stock"
		size_mod = 1
		hud_offset_mod = 7
		G.recalculate_attachment_bonuses()
	else
		to_chat(user, SPAN_NOTICE("你折叠了[src]。"))
		R.flags_equip_slot |= SLOT_WAIST // Allow to be worn on the belt when folded
		R.folded = TRUE // We can't shoot anymore, its folded
		icon_state = "44stock_folded"
		size_mod = 0
		hud_offset_mod = 4
		G.recalculate_attachment_bonuses()
	folded = !folded
	G.update_overlays(src, "stock")

// If it is activated/folded when we attach it, re-apply the things
/obj/item/attachable/stock/revolver/Attach(obj/item/weapon/gun/G)
	..()
	var/obj/item/weapon/gun/revolver/m44/R = G
	if(!istype(R))
		return 0

	if(folded)
		R.flags_equip_slot |= SLOT_WAIST
		R.folded = TRUE
	else
		R.flags_equip_slot &= ~SLOT_WAIST //Can't wear it on the belt slot with stock on when we attach it first time.

// When taking it off we want to undo everything not statwise
/obj/item/attachable/stock/revolver/Detach(mob/user, obj/item/weapon/gun/detaching_gun)
	..()
	var/obj/item/weapon/gun/revolver/m44/R = detaching_gun
	if(!istype(R))
		return 0

	if(folded)
		R.folded = FALSE
	else
		R.flags_equip_slot |= SLOT_WAIST

// ======== Underbarrel Attachments ======== //


/obj/item/attachable/attached_gun
	icon = 'icons/obj/items/weapons/guns/attachments/under.dmi'
	attachment_action_type = /datum/action/item_action/toggle
	// Some attachments may be fired. So here are the variables related to that.
	/// Ammo to fire the attachment with
	var/datum/ammo/ammo = null
	var/max_range = 0 //Determines # of tiles distance the attachable can fire, if it's not a projectile.
	var/last_fired //When the attachment was last fired.
	var/attachment_firing_delay = 0 //the delay between shots, for attachments that fires stuff
	var/fire_sound = null //Sound to play when firing it alternately
	var/gun_deactivate_sound = 'sound/weapons/handling/gun_underbarrel_deactivate.ogg'//allows us to give the attached gun unique activate and de-activate sounds. Not used yet.
	var/gun_activate_sound  = 'sound/weapons/handling/gun_underbarrel_activate.ogg'
	var/unload_sound = 'sound/weapons/gun_shotgun_shell_insert.ogg'

	/// An assoc list in the format list(/datum/element/bullet_trait_to_give = list(...args))
	/// that will be given to the projectiles of the attached gun
	var/list/list/traits_to_give_attached
	/// Current target we're firing at
	var/mob/target

/obj/item/attachable/attached_gun/Initialize(mapload, ...) //Let's make sure if something needs an ammo type, it spawns with one.
	. = ..()
	if(ammo)
		ammo = GLOB.ammo_list[ammo]


/obj/item/attachable/attached_gun/Destroy()
	ammo = null
	target = null
	return ..()

/// setter for target
/obj/item/attachable/attached_gun/proc/set_target(atom/object)
	if(object == target)
		return
	if(target)
		UnregisterSignal(target, COMSIG_PARENT_QDELETING)
	target = object
	if(target)
		RegisterSignal(target, COMSIG_PARENT_QDELETING, PROC_REF(clean_target))

///Set the target to its turf, so we keep shooting even when it was qdeled
/obj/item/attachable/attached_gun/proc/clean_target()
	SIGNAL_HANDLER
	target = get_turf(target)

/obj/item/attachable/attached_gun/proc/reset_damage_mult(obj/item/weapon/gun/gun)
	SIGNAL_HANDLER
	gun.damage_mult = 1

/obj/item/attachable/attached_gun/activate_attachment(obj/item/weapon/gun/G, mob/living/user, turn_off)
	if(G.active_attachable == src)
		if(user)
			to_chat(user, SPAN_NOTICE("你不再使用[src]。"))
			playsound(user, gun_deactivate_sound, 30, 1)
		G.active_attachable = null
		icon_state = initial(icon_state)
		UnregisterSignal(G, COMSIG_GUN_RECALCULATE_ATTACHMENT_BONUSES)
		G.recalculate_attachment_bonuses()
	else if(!turn_off)
		if(user)
			to_chat(user, SPAN_NOTICE("你现在正在使用[src]。"))
			playsound(user, gun_activate_sound, 60, 1)
		G.active_attachable = src
		G.damage_mult = 1
		RegisterSignal(G, COMSIG_GUN_RECALCULATE_ATTACHMENT_BONUSES, PROC_REF(reset_damage_mult))
		icon_state += "-on"

	SEND_SIGNAL(G, COMSIG_GUN_INTERRUPT_FIRE)

	for(var/X in G.actions)
		var/datum/action/A = X
		A.update_button_icon()
	return 1

/obj/item/attachable/attached_gun/flare_launcher
	name = "U2照明弹发射器"
	desc = "一种可重复装填的武器挂载式照明弹发射器。"
	icon_state = "flare"
	attach_icon = "flare_a"
	w_class = SIZE_MEDIUM
	current_rounds = 3
	max_rounds = 3
	max_range = 21
	attachment_action_type = /datum/action/item_action/toggle/flare_launcher
	slot = "under"
	fire_sound = 'sound/weapons/gun_flare.ogg'
	ammo = /datum/ammo/flare/no_ignite
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_PROJECTILE|ATTACH_RELOADABLE|ATTACH_WEAPON

/obj/item/attachable/attached_gun/flare_launcher/New()
	..()
	attachment_firing_delay = FIRE_DELAY_TIER_4 * 3

/obj/item/attachable/attached_gun/flare_launcher/reload_attachment(obj/item/attacking_item, mob/user)
	if(istype(attacking_item, /obj/item/device/flashlight/flare))
		var/obj/item/device/flashlight/flare/attacking_flare = attacking_item
		if(attacking_flare.on)
			to_chat(user, SPAN_WARNING("你不能把点燃的照明弹放入[src]！"))
			return
		if(!attacking_flare.fuel)
			to_chat(user, SPAN_WARNING("你不能把燃尽的照明弹放入[src]！"))
			return
		if(istype(attacking_flare,/obj/item/device/flashlight/flare/signal))
			to_chat(user, SPAN_WARNING("你无法将信号照明弹装入发射器。"))
			return
		if(current_rounds < max_rounds)
			playsound(user, 'sound/weapons/gun_shotgun_shell_insert.ogg', 25, 1)
			to_chat(user, SPAN_NOTICE("你将[attacking_flare]装入了[src]。"))
			current_rounds++
			qdel(attacking_flare)
			update_icon()
		else
			to_chat(user, SPAN_WARNING("你无法装入更多照明弹。"))
	else
		to_chat(user, SPAN_WARNING("那不是照明弹！"))

//The requirement for an attachable being alt fire is AMMO CAPACITY > 0.
/obj/item/attachable/attached_gun/grenade
	name = "U1榴弹发射器"
	desc = "一种可装填的武器挂载式榴弹发射器。"
	icon_state = "grenade"
	attach_icon = "grenade_a"
	w_class = SIZE_MEDIUM
	current_rounds = 0
	max_rounds = 3
	max_range = 7
	attachment_action_type = /datum/action/item_action/toggle/ugl
	slot = "under"
	fire_sound = 'sound/weapons/gun_m92_attachable.ogg'
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_RELOADABLE|ATTACH_WEAPON
	var/grenade_pass_flags
	var/list/loaded_grenades //list of grenade types loaded in the UGL
	var/breech_open = FALSE // is the UGL open for loading?
	var/cocked = TRUE // has the UGL been cocked via opening and closing the breech?
	var/open_sound = 'sound/weapons/handling/ugl_open.ogg'
	var/close_sound = 'sound/weapons/handling/ugl_close.ogg'

/obj/item/attachable/attached_gun/grenade/Initialize()
	. = ..()
	grenade_pass_flags = PASS_HIGH_OVER|PASS_MOB_THRU|PASS_OVER

/obj/item/attachable/attached_gun/grenade/New()
	..()
	attachment_firing_delay = FIRE_DELAY_TIER_4 * 3
	loaded_grenades = list()

/obj/item/attachable/attached_gun/grenade/get_examine_text(mob/user)
	. = ..()
	if(current_rounds) . += "It has [current_rounds] grenade\s left."
	else . += "它是空的。"

/obj/item/attachable/attached_gun/grenade/unique_action(mob/user)
	if(!ishuman(usr))
		return
	if(user.is_mob_incapacitated() || !isturf(usr.loc))
		to_chat(user, SPAN_WARNING("现在不行。"))
		return

	var/obj/item/weapon/gun/G = user.get_held_item()
	if(!istype(G))
		G = user.get_inactive_hand()
	if(!istype(G) && G != null)
		G = user.get_active_hand()
	if(!G)
		to_chat(user, SPAN_WARNING("你需要拿着\the [src]才能那么做。"))
		return

	pump(user)

/obj/item/attachable/attached_gun/grenade/update_icon()
	. = ..()
	attach_icon = initial(attach_icon)
	icon_state = initial(icon_state)
	if(breech_open)
		attach_icon += "-open"
		icon_state += "-open"
	if(istype(loc, /obj/item/weapon/gun))
		var/obj/item/weapon/gun/gun = loc
		gun.update_attachable(slot)
		for(var/datum/action/item_action as anything in gun.actions)
			item_action.update_button_icon()

/obj/item/attachable/attached_gun/grenade/proc/pump(mob/user) //for want of a better proc name
	if(breech_open) // if it was ALREADY open
		breech_open = FALSE
		cocked = TRUE // by closing the gun we have cocked it and readied it to fire
		to_chat(user, SPAN_NOTICE("你合上\the [src]的枪膛，完成待击！"))
		playsound(src, close_sound, 15, 1)
	else
		breech_open = TRUE
		cocked = FALSE
		to_chat(user, SPAN_NOTICE("你打开\the [src]的枪膛！"))
		playsound(src, open_sound, 15, 1)
	update_icon()

/obj/item/attachable/attached_gun/grenade/reload_attachment(obj/item/explosive/grenade/G, mob/user)
	if(!breech_open)
		to_chat(user, SPAN_WARNING("\The [src]'s breech must be open to load grenades! (use unique-action)"))
		return
	if(!istype(G) || istype(G, /obj/item/explosive/grenade/spawnergrenade/))
		to_chat(user, SPAN_WARNING("[src]不接受那种类型的榴弹。"))
		return
	if(!G.active) //can't load live grenades
		if(!G.underslug_launchable)
			to_chat(user, SPAN_WARNING("[src]不接受那种类型的榴弹。"))
			return
		if(current_rounds >= max_rounds)
			to_chat(user, SPAN_WARNING("[src]已满。"))
		else
			playsound(user, 'sound/weapons/grenade_insert.wav', 25, 1)
			current_rounds++
			loaded_grenades += G
			to_chat(user, SPAN_NOTICE("你将\the [G]装入\the [src]。"))
			user.drop_inv_item_to_loc(G, src)

/obj/item/attachable/attached_gun/grenade/unload_attachment(mob/user, reload_override = FALSE, drop_override = FALSE, loc_override = FALSE)
	. = TRUE //Always uses special unloading.
	if(!breech_open)
		to_chat(user, SPAN_WARNING("\The [src] is closed! You must open it to take out grenades!"))
		return
	if(!current_rounds)
		to_chat(user, SPAN_WARNING("它是空的！"))
		return

	var/obj/item/explosive/grenade/nade = loaded_grenades[length(loaded_grenades)] //Grab the last-inserted one. Or the only one, as the case may be.
	loaded_grenades.Remove(nade)
	current_rounds--

	if(drop_override || !user)
		nade.forceMove(get_turf(src))
	else
		user.put_in_hands(nade)

	user.visible_message(SPAN_NOTICE("[user]从\the [src]中卸出\a [nade]。"),
	SPAN_NOTICE("You unload \a [nade] from \the [src]."), null, 4, CHAT_TYPE_COMBAT_ACTION)
	playsound(user, unload_sound, 30, 1)

/obj/item/attachable/attached_gun/grenade/fire_attachment(atom/target,obj/item/weapon/gun/gun,mob/living/user)
	if(!(gun.flags_item & WIELDED))
		if(user)
			to_chat(user, SPAN_WARNING("你必须双手持握[gun]才能使用\the [src]。"))
		return
	if(breech_open)
		if(user)
			to_chat(user, SPAN_WARNING("你必须合上枪膛才能发射\the [src]！"))
			playsound(user, 'sound/weapons/gun_empty.ogg', 50, TRUE, 5)
		return
	if(!cocked)
		if(user)
			to_chat(user, SPAN_WARNING("你必须为\the [src]待击才能发射！（打开并合上枪膛）"))
			playsound(user, 'sound/weapons/gun_empty.ogg', 50, TRUE, 5)
		return
	if(get_dist(user,target) > max_range)
		to_chat(user, SPAN_WARNING("距离太远，无法发射挂件！"))
		playsound(user, 'sound/weapons/gun_empty.ogg', 50, TRUE, 5)
		return

	if(current_rounds > 0 && ..())
		prime_grenade(target,gun,user)

/obj/item/attachable/attached_gun/grenade/proc/prime_grenade(atom/target,obj/item/weapon/gun/gun,mob/living/user)
	set waitfor = 0
	var/obj/item/explosive/grenade/G = loaded_grenades[1]

	if(G.antigrief_protection && user.faction == FACTION_MARINE && explosive_antigrief_check(G, user))
		to_chat(user, SPAN_WARNING("\The [name]'s safe-area accident inhibitor prevents you from firing!"))
		msg_admin_niche("[key_name(user)] attempted to prime \a [G.name] in [get_area(src)] [ADMIN_JMP(src.loc)]")
		return

	playsound(user.loc, fire_sound, 50, 1)
	msg_admin_attack("[key_name_admin(user)] fired an underslung grenade launcher [ADMIN_JMP_USER(user)]")
	log_game("[key_name_admin(user)] used an underslung grenade launcher.")

	var/pass_flags = NO_FLAGS
	pass_flags |= grenade_pass_flags
	G.det_time = min(15, G.det_time)
	G.throw_range = max_range
	G.activate(user, FALSE)
	G.forceMove(get_turf(gun))
	G.throw_atom(target, max_range, SPEED_VERY_FAST, user, null, NORMAL_LAUNCH, pass_flags)
	current_rounds--
	cocked = FALSE // we have fired so uncock the gun
	loaded_grenades.Cut(1,2)

//For the Mk1
/obj/item/attachable/attached_gun/grenade/mk1
	name = "\improper MK1 underslung grenade launcher"
	desc = "经典下挂式榴弹发射器的旧型号。可储存五发榴弹，射程更远，但射速较慢。"
	icon_state = "grenade-mk1"
	attach_icon = "grenade-mk1_a"
	current_rounds = 0
	max_rounds = 5
	max_range = 10
	attachment_firing_delay = 30

/obj/item/attachable/attached_gun/grenade/m203 //M16 GL, only DD have it.
	name = "\improper M203 Grenade Launcher"
	desc = "一款老式的下挂榴弹发射器。1969年为M16步枪采用，早在几个世纪前就已过时；它怎么会出现在这里对你来说是个谜。仅能容纳一发专用的40毫米榴弹，没有现代敌我识别系统，不会误伤友军。"
	icon_state = "grenade-m203"
	attach_icon = "grenade-m203_a"
	current_rounds = 0
	max_rounds = 1
	max_range = 14
	attachment_firing_delay = 5 //one shot, so if you can reload fast you can shoot fast

/obj/item/attachable/attached_gun/grenade/m203/Initialize()
	. = ..()
	grenade_pass_flags = NO_FLAGS


/obj/item/attachable/attached_gun/grenade/u1rmc
	name = "\improper H34 underslung grenade launcher"
	desc = "维兰德-汤谷对下挂榴弹发射器系统的设计，专为NSG23系列武器打造。最多可储存五发榴弹，射程与M41A Mk2的U1 UGL大致相当。"
	icon_state = "u1rmc"
	attach_icon = "u1rmc_a"
	current_rounds = 0
	max_rounds = 5
	max_range = 10
	attachment_firing_delay = 24

//"ammo/flamethrower" is a bullet, but the actual process is handled through fire_attachment, linked through Fire().
/obj/item/attachable/attached_gun/flamer
	name = "迷你火焰喷射器"
	icon_state = "flamethrower"
	attach_icon = "flamethrower_a"
	desc = "一种武器挂载的可补充燃料的火焰喷射器附件。它有一个次要模式，能产生更剧烈的火焰，但推进能力极差且燃料消耗巨大。"
	w_class = SIZE_MEDIUM
	current_rounds = 40
	max_rounds = 40
	max_range = 5
	slot = "under"
	fire_sound = 'sound/weapons/gun_flamethrower3.ogg'
	gun_activate_sound = 'sound/weapons/handling/gun_underbarrel_flamer_activate.ogg'
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_RELOADABLE|ATTACH_WEAPON
	attachment_action_type = /datum/action/item_action/toggle/flamer
	var/burn_level = BURN_LEVEL_TIER_1
	var/burn_duration = BURN_TIME_TIER_1
	var/round_usage_per_tile = 1
	var/intense_mode = FALSE

/obj/item/attachable/attached_gun/flamer/New()
	..()
	attachment_firing_delay = FIRE_DELAY_TIER_4 * 5

/obj/item/attachable/attached_gun/flamer/get_examine_text(mob/user)
	. = ..()
	if(intense_mode)
		. += "It is currently using a more intense and volatile flame."
	else
		. += "It is using a normal and stable flame."
	if(current_rounds > 0)
		. += "It has [current_rounds] unit\s of fuel left."
	else
		. += "它是空的。"

/obj/item/attachable/attached_gun/flamer/update_icon()
	. = ..()
	attach_icon = initial(attach_icon)
	if(intense_mode)
		attach_icon += "-intense"
	if(isgun(loc))
		var/obj/item/weapon/gun/gun = loc
		gun.update_attachable(slot)
		for(var/datum/action/item_action as anything in gun.actions)
			item_action.update_button_icon()

/obj/item/attachable/attached_gun/flamer/unique_action(mob/user)
	..()
	playsound(user,'sound/weapons/handling/flamer_ignition.ogg', 25, 1)
	if(intense_mode)
		to_chat(user, SPAN_WARNING("你将\the [src]切换回使用正常且更稳定的火焰。"))
		round_usage_per_tile = 1
		burn_level = BURN_LEVEL_TIER_1
		burn_duration = BURN_TIME_TIER_1
		max_range = 5
		intense_mode = FALSE
	else
		to_chat(user, SPAN_WARNING("你将\the [src]切换为使用更剧烈且不稳定的火焰。"))
		round_usage_per_tile = 5
		burn_level = BURN_LEVEL_TIER_5
		burn_duration = BURN_TIME_TIER_2
		max_range = 2
		intense_mode = TRUE
	update_icon()

/obj/item/attachable/attached_gun/flamer/handle_pre_break_attachment_description(base_description_text as text)
	return base_description_text + " It is on [intense_mode ? "intense" : "normal"] mode."

/obj/item/attachable/attached_gun/flamer/reload_attachment(obj/item/ammo_magazine/flamer_tank/fuel_holder, mob/user)
	if(istype(fuel_holder))
		var/amt_to_refill = max_rounds - current_rounds
		if(!amt_to_refill)
			to_chat(user, SPAN_WARNING("[src]已满。"))
			return

		if(!fuel_holder.reagents || length(fuel_holder.reagents.reagent_list) < 1)
			to_chat(user, SPAN_WARNING("[fuel_holder]是空的！"))
			return

		var/datum/reagent/to_remove = fuel_holder.reagents.reagent_list[1]

		var/list/flamer_chem = list("utnapthal","fuel")
		if(!istype(to_remove) ||  !(to_remove.id in flamer_chem) || length(fuel_holder.reagents.reagent_list) > 1)
			to_chat(user, SPAN_WARNING("你不能混合燃料！"))
			return

		var/fuel_amt
		if(to_remove)
			fuel_amt = to_remove.volume < amt_to_refill ? to_remove.volume : amt_to_refill

		if(!fuel_amt)
			to_chat(user, SPAN_WARNING("[fuel_holder]是空的！"))
			return

		playsound(user, 'sound/effects/refill.ogg', 25, 1, 3)
		to_chat(user, SPAN_NOTICE("你用[fuel_holder]给[src]补充了燃料。"))
		current_rounds += fuel_amt
		fuel_holder.reagents.remove_reagent(to_remove.id, fuel_amt)
		fuel_holder.update_icon()
	else
		to_chat(user, SPAN_WARNING("[src]只能用焚烧器燃料罐补充燃料。"))

/obj/item/attachable/attached_gun/flamer/fire_attachment(atom/target, obj/item/weapon/gun/gun, mob/living/user)
	if(!istype(loc, /obj/item/weapon/gun))
		to_chat(user, SPAN_WARNING("\The [src] must be attached to a gun!"))
		return

	var/obj/item/weapon/gun/attached_gun = loc

	if(!(attached_gun.flags_item & WIELDED))
		to_chat(user, SPAN_WARNING("你必须装备[attached_gun]才能开火[src]！"))
		return

	if(current_rounds > round_usage_per_tile && ..())
		unleash_flame(target, user)
		if(attached_gun.last_fired < world.time)
			attached_gun.last_fired = world.time

/obj/item/attachable/attached_gun/flamer/proc/unleash_flame(atom/target, mob/living/user)
	set waitfor = 0
	var/list/turf/turfs = get_line(user,target)
	var/distance = 0
	var/turf/prev_turf
	var/stop_at_turf = FALSE
	playsound(user, 'sound/weapons/gun_flamethrower2.ogg', 50, 1)
	process_flame_turf(turfs, target, user, distance, prev_turf, stop_at_turf)

/obj/item/attachable/attached_gun/flamer/proc/process_flame_turf(list/turfs, atom/target, mob/living/user, distance, turf/prev_turf, stop_at_turf)
	if(!length(turfs))
		return
	var/turf/current_turf = turfs[1]
	turfs.Cut(1,2)
	if(current_turf == user.loc)
		prev_turf = current_turf
		addtimer(CALLBACK(src, PROC_REF(process_flame_turf), turfs, target, user, distance, prev_turf, stop_at_turf), 1, TIMER_UNIQUE)
		return
	if(!current_rounds)
		return
	if(distance >= max_range)
		to_chat(user, SPAN_WARNING("仪表显示：剩余燃料块：<b>[floor(current_rounds)]</b>！"))
		return

	current_rounds -= min(round_usage_per_tile, current_rounds)
	var/datum/cause_data/cause_data = create_cause_data(initial(name), user)
	if(current_turf.density)
		current_turf.flamer_fire_act(0, cause_data)
		stop_at_turf = TRUE
	else if(prev_turf)
		var/atom/movable/temp = new/obj/flamer_fire()
		var/atom/movable/blocked = LinkBlocked(temp, prev_turf, current_turf)
		qdel(temp)

		if(blocked)
			blocked.flamer_fire_act(0, cause_data)
			if(blocked.flags_atom & ON_BORDER)
				return
			stop_at_turf = TRUE

	flame_turf(current_turf, user)
	if(stop_at_turf)
		to_chat(user, SPAN_WARNING("仪表显示：剩余燃料块：<b>[floor(current_rounds)]</b>！"))
		return

	distance++
	prev_turf = current_turf

	if(!length(turfs))
		to_chat(user, SPAN_WARNING("仪表显示：剩余燃料块：<b>[floor(current_rounds)]</b>！"))
	addtimer(CALLBACK(src, PROC_REF(process_flame_turf), turfs, target, user, distance, prev_turf, stop_at_turf), 1, TIMER_UNIQUE)


/obj/item/attachable/attached_gun/flamer/proc/flame_turf(turf/T, mob/living/user)
	if(!istype(T))
		return

	if(!locate(/obj/flamer_fire) in T) // No stacking flames!
		var/datum/reagent/napalm/ut/R = new()

		R.intensityfire = burn_level
		R.durationfire = burn_duration

		new/obj/flamer_fire(T, create_cause_data(initial(name), user), R)

/obj/item/attachable/attached_gun/flamer/advanced
	name = "高级微型火焰喷射器"
	current_rounds = 50
	max_rounds = 50
	max_range = 6
	burn_level = BURN_LEVEL_TIER_5
	burn_duration = BURN_TIME_TIER_2

/obj/item/attachable/attached_gun/flamer/advanced/unique_action(mob/user)
	return	//No need for volatile mode, it already does high damage by default

/obj/item/attachable/attached_gun/flamer/advanced/integrated
	name = "集成式火焰喷射器"

/obj/item/attachable/attached_gun/shotgun //basically, a masterkey
	name = "\improper U7 underbarrel shotgun"
	icon_state = "masterkey"
	attach_icon = "masterkey_a"
	desc = "一把阿玛特U7战术霰弹枪。可挂载于大多数武器的下挂式枪管。最多只能装填五发鹿弹。专为突入建筑物设计。"
	w_class = SIZE_MEDIUM
	max_rounds = 5
	current_rounds = 5
	ammo = /datum/ammo/bullet/shotgun/buckshot/masterkey
	attachment_action_type = /datum/action/item_action/toggle/ubs
	slot = "under"
	fire_sound = 'sound/weapons/gun_shotgun_u7.ogg'
	gun_activate_sound = 'sound/weapons/handling/gun_u7_activate.ogg'
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_PROJECTILE|ATTACH_RELOADABLE|ATTACH_WEAPON

/obj/item/attachable/attached_gun/shotgun/New()
	..()
	attachment_firing_delay = FIRE_DELAY_TIER_5*3
	AddElement(/datum/element/corp_label/armat)

/obj/item/attachable/attached_gun/shotgun/get_examine_text(mob/user)
	. = ..()
	if(current_rounds > 0) . += "It has [current_rounds] shell\s left."
	else . += "它是空的。"

/obj/item/attachable/attached_gun/shotgun/set_bullet_traits()
	LAZYADD(traits_to_give_attached, list(
		BULLET_TRAIT_ENTRY_ID("turfs", /datum/element/bullet_trait_damage_boost, 5, GLOB.damage_boost_turfs),
		BULLET_TRAIT_ENTRY_ID("breaching", /datum/element/bullet_trait_damage_boost, 10.8, GLOB.damage_boost_breaching),
		BULLET_TRAIT_ENTRY_ID("pylons", /datum/element/bullet_trait_damage_boost, 5, GLOB.damage_boost_pylons)
	))

/obj/item/attachable/attached_gun/shotgun/reload_attachment(obj/item/ammo_magazine/handful/mag, mob/user)
	if(istype(mag) && mag.flags_magazine & AMMUNITION_HANDFUL)
		if(mag.default_ammo == /datum/ammo/bullet/shotgun/buckshot)
			if(current_rounds >= max_rounds)
				to_chat(user, SPAN_WARNING("[src]已满。"))
			else
				current_rounds++
				mag.current_rounds--
				mag.update_icon()
				to_chat(user, SPAN_NOTICE("你往[src]里装填了一发霰弹。"))
				playsound(user, 'sound/weapons/gun_shotgun_shell_insert.ogg', 25, 1)
				if(mag.current_rounds <= 0)
					user.temp_drop_inv_item(mag)
					qdel(mag)
			return
	to_chat(user, SPAN_WARNING("[src]只接受霰弹枪鹿弹。"))

/obj/item/attachable/attached_gun/shotgun/af13 //NSG underslung shottie
	name = "\improper AF13 underbarrel shotgun"
	icon_state = "masterkey_af13"
	attach_icon = "masterkey_af13_a"
	desc = "一把维兰德-汤谷AF13下挂式霰弹枪。可挂载于NSG23系列武器的下挂式枪管。最多只能装填六发鹿弹。专为突入建筑物设计。"
	w_class = SIZE_MEDIUM
	max_rounds = 6
	current_rounds = 6
	slot = "under"
	fire_sound = 'sound/weapons/gun_shotgun_u7.ogg'
	gun_activate_sound = 'sound/weapons/handling/gun_u7_activate.ogg'
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_PROJECTILE|ATTACH_RELOADABLE|ATTACH_WEAPON

/obj/item/attachable/attached_gun/shotgun/af13/New()
	..()
	attachment_firing_delay = FIRE_DELAY_TIER_5*3

/obj/item/attachable/attached_gun/shotgun/af13/get_examine_text(mob/user)
	. = ..()
	if(current_rounds > 0) . += "It has [current_rounds] shell\s left."
	else . += "它是空的。"

/obj/item/attachable/attached_gun/shotgun/af13/set_bullet_traits()
	LAZYADD(traits_to_give_attached, list(
		BULLET_TRAIT_ENTRY_ID("turfs", /datum/element/bullet_trait_damage_boost, 5, GLOB.damage_boost_turfs),
		BULLET_TRAIT_ENTRY_ID("breaching", /datum/element/bullet_trait_damage_boost, 10.8, GLOB.damage_boost_breaching),
		BULLET_TRAIT_ENTRY_ID("pylons", /datum/element/bullet_trait_damage_boost, 5, GLOB.damage_boost_pylons)
	))

/obj/item/attachable/attached_gun/shotgun/af13/reload_attachment(obj/item/ammo_magazine/handful/mag, mob/user)
	if(istype(mag) && mag.flags_magazine & AMMUNITION_HANDFUL)
		if(mag.default_ammo == /datum/ammo/bullet/shotgun/buckshot)
			if(current_rounds >= max_rounds)
				to_chat(user, SPAN_WARNING("[src]已满。"))
			else
				current_rounds++
				mag.current_rounds--
				mag.update_icon()
				to_chat(user, SPAN_NOTICE("你往[src]里装填了一发霰弹。"))
				playsound(user, 'sound/weapons/gun_shotgun_shell_insert.ogg', 25, 1)
				if(mag.current_rounds <= 0)
					user.temp_drop_inv_item(mag)
					qdel(mag)
			return
	to_chat(user, SPAN_WARNING("[src]只接受霰弹枪鹿弹。"))

/obj/item/attachable/attached_gun/shotgun/af13b //NSG underslung shottie for Breacher gun
	name = "\improper AF13-B underbarrel shotgun"
	icon_state = "masterkey_af13"
	attach_icon = "masterkey_af13_a"
	desc = "一把维兰德-汤谷AF13-B下挂式霰弹枪，经过RMC军械师大幅改装。可挂载于NSG23系列武器的下挂式枪管。最多只能装填六发鹿弹。专为突入建筑物设计。"
	w_class = SIZE_MEDIUM
	max_rounds = 6
	current_rounds = 6
	ammo = /datum/ammo/bullet/shotgun/buckshot/masterkey
	slot = "under"
	fire_sound = 'sound/weapons/gun_shotgun_u7.ogg'
	gun_activate_sound = 'sound/weapons/handling/gun_u7_activate.ogg'
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_PROJECTILE|ATTACH_RELOADABLE|ATTACH_WEAPON|ATTACH_WIELD_OVERRIDE

/obj/item/attachable/attached_gun/shotgun/af13b/New()
	..()
	attachment_firing_delay = FIRE_DELAY_TIER_5*3

/obj/item/attachable/attached_gun/shotgun/af13b/get_examine_text(mob/user)
	. = ..()
	if(current_rounds > 0) . += "It has [current_rounds] shell\s left."
	else . += "它是空的。"

/obj/item/attachable/attached_gun/shotgun/af13b/set_bullet_traits()
	LAZYADD(traits_to_give_attached, list(
		BULLET_TRAIT_ENTRY_ID("turfs", /datum/element/bullet_trait_damage_boost, 2*5, GLOB.damage_boost_turfs), // 3 hits to break down regular walls, about 6 to break down r-walls
		BULLET_TRAIT_ENTRY_ID("breaching", /datum/element/bullet_trait_damage_boost, 3*10.8, GLOB.damage_boost_breaching), // 2-taps the R doors
		BULLET_TRAIT_ENTRY_ID("pylons", /datum/element/bullet_trait_damage_boost, 2*5, GLOB.damage_boost_pylons)
	))

/obj/item/attachable/attached_gun/shotgun/af13b/reload_attachment(obj/item/ammo_magazine/handful/mag, mob/user)
	if(istype(mag) && mag.flags_magazine & AMMUNITION_HANDFUL)
		if(mag.default_ammo == /datum/ammo/bullet/shotgun/buckshot)
			if(current_rounds >= max_rounds)
				to_chat(user, SPAN_WARNING("[src]已满。"))
			else
				current_rounds++
				mag.current_rounds--
				mag.update_icon()
				to_chat(user, SPAN_NOTICE("你往[src]里装填了一发霰弹。"))
				playsound(user, 'sound/weapons/gun_shotgun_shell_insert.ogg', 25, 1)
				if(mag.current_rounds <= 0)
					user.temp_drop_inv_item(mag)
					qdel(mag)
			return
	to_chat(user, SPAN_WARNING("[src]只接受霰弹枪鹿弹。"))


/obj/item/attachable/attached_gun/extinguisher
	name = "HME-12下挂式灭火器"
	icon_state = "extinguisher"
	attach_icon = "extinguisher_a"
	desc = "一台泰豪科技HME-12下挂式灭火器。可挂载于大多数武器的下挂式枪管。对准火焰后再施压。"
	w_class = SIZE_MEDIUM
	attachment_action_type = /datum/action/item_action/toggle/ext
	slot = "under"
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_WEAPON|ATTACH_MELEE
	var/obj/item/tool/extinguisher/internal_extinguisher
	current_rounds = 1 //This has to be done to pass the fire_attachment check.

/obj/item/attachable/attached_gun/extinguisher/get_examine_text(mob/user)
	. = ..()
	if(internal_extinguisher)
		. += SPAN_NOTICE("It has [floor(internal_extinguisher.reagents.total_volume)] unit\s of water left!")
		return
	. += SPAN_WARNING("它是空的。")

/obj/item/attachable/attached_gun/extinguisher/handle_attachment_description(slot)
	return "It has a [icon2html(src)] [name] ([floor(internal_extinguisher.reagents.total_volume)]/[internal_extinguisher.max_water]) mounted underneath.<br>"

/obj/item/attachable/attached_gun/extinguisher/New()
	..()
	initialize_internal_extinguisher()

/obj/item/attachable/attached_gun/extinguisher/fire_attachment(atom/target, obj/item/weapon/gun/gun, mob/living/user)
	if(!internal_extinguisher)
		return
	if(..())
		return internal_extinguisher.afterattack(target, user)

/obj/item/attachable/attached_gun/extinguisher/proc/initialize_internal_extinguisher()
	internal_extinguisher = new /obj/item/tool/extinguisher/mini/integrated_flamer()
	internal_extinguisher.safety = FALSE
	internal_extinguisher.create_reagents(internal_extinguisher.max_water)
	internal_extinguisher.reagents.add_reagent("water", internal_extinguisher.max_water)

/obj/item/attachable/attached_gun/extinguisher/pyro
	name = "HME-88B下挂式灭火器"
	desc = "一台实验性的泰豪科技HME-88B下挂式灭火器，与少数特定枪型集成。能够扑灭最猛烈的火焰。对准火焰后再施压。"
	flags_attach_features = ATTACH_ACTIVATION|ATTACH_WEAPON|ATTACH_MELEE //not removable

/obj/item/attachable/attached_gun/extinguisher/pyro/initialize_internal_extinguisher()
	internal_extinguisher = new /obj/item/tool/extinguisher/pyro()
	internal_extinguisher.safety = FALSE
	internal_extinguisher.create_reagents(internal_extinguisher.max_water)
	internal_extinguisher.reagents.add_reagent("water", internal_extinguisher.max_water)

/obj/item/attachable/attached_gun/flamer_nozzle
	name = "XM-VESG-1火焰喷射器喷嘴"
	desc = "一种特殊喷嘴，旨在改造火焰喷射器，使其更适合进攻用途。喷嘴内部涂有一种特殊的凝胶和树脂物质，能使流经的燃料硬化。从枪管射出时，喷出的是一团燃烧的凝胶，而非燃烧的石脑油流。"
	desc_lore = "The Experimental Volatile-Exothermic-Sphere-Generator clip-on nozzle attachment for the M240A1 incinerator unit was specifically designed to allow marines to launch fireballs into enemy foxholes and bunkers. Despite the gel and resin coating, the flaming ball of naptha tears apart due the drag caused by launching it through the air, leading marines to use the attachment as a makeshift firework launcher during shore leave."
	icon_state = "flamer_nozzle"
	attach_icon = "flamer_nozzle_a_1"
	w_class = SIZE_MEDIUM
	slot = "under"
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_WEAPON|ATTACH_MELEE|ATTACH_IGNORE_EMPTY
	pixel_shift_x = 4
	pixel_shift_y = 14
	attachment_action_type = /datum/action/item_action/toggle/nozzle
	max_range = 6
	last_fired = 0
	attachment_firing_delay = 2 SECONDS

	var/projectile_type = /datum/ammo/flamethrower
	var/fuel_per_projectile = 3

	var/static/list/fire_sounds = list(
		'sound/weapons/gun_flamethrower1.ogg',
		'sound/weapons/gun_flamethrower2.ogg',
		'sound/weapons/gun_flamethrower3.ogg'
	)

/obj/item/attachable/attached_gun/flamer_nozzle/handle_attachment_description(slot)
	return "It has a [icon2html(src)] [name] mounted beneath the barrel.<br>"

/obj/item/attachable/attached_gun/flamer_nozzle/activate_attachment(obj/item/weapon/gun/firearm, mob/living/user, turn_off)
	. = ..()
	attach_icon = "flamer_nozzle_a_[firearm.active_attachable == src ? 0 : 1]"
	firearm.update_icon()
	for(var/datum/action/item_action as anything in firearm.actions)
		item_action.update_button_icon()

/obj/item/attachable/attached_gun/flamer_nozzle/fire_attachment(atom/target, obj/item/weapon/gun/gun, mob/living/user)
	. = ..()

	if(world.time < gun.last_fired + gun.get_fire_delay())
		return

	if((gun.flags_gun_features & GUN_WIELDED_FIRING_ONLY) && !(gun.flags_item & WIELDED))
		to_chat(user, SPAN_WARNING("你必须装备[gun]才能开火[src]！"))
		return

	if(gun.flags_gun_features & GUN_TRIGGER_SAFETY)
		to_chat(user, SPAN_WARNING("\The [gun] isn't lit!"))
		return

	if(!istype(gun.current_mag, /obj/item/ammo_magazine/flamer_tank))
		to_chat(user, SPAN_WARNING("\The [gun] needs a flamer tank installed!"))
		return

	if(!length(gun.current_mag.reagents.reagent_list))
		to_chat(user, SPAN_WARNING("\The [gun] doesn't have enough fuel to launch a projectile!"))
		return

	var/datum/reagent/flamer_reagent = gun.current_mag.reagents.reagent_list[1]
	if(flamer_reagent.volume < FLAME_REAGENT_USE_AMOUNT * fuel_per_projectile)
		to_chat(user, SPAN_WARNING("\The [gun] doesn't have enough fuel to launch a projectile!"))
		return

	if(istype(flamer_reagent, /datum/reagent/foaming_agent/stabilized))
		to_chat(user, SPAN_WARNING("这种化学物质会堵塞喷嘴！"))
		return

	if(istype(gun.current_mag, /obj/item/ammo_magazine/flamer_tank/smoke)) // you can't fire smoke like a projectile!
		to_chat(user, SPAN_WARNING("[src]无法与此燃料罐一同使用！"))
		return

	gun.last_fired = world.time
	gun.current_mag.reagents.remove_reagent(flamer_reagent.id, FLAME_REAGENT_USE_AMOUNT * fuel_per_projectile)

	var/obj/projectile/P = new(src, create_cause_data(initial(name), user, src))
	var/datum/ammo/flamethrower/ammo_datum = new projectile_type
	ammo_datum.flamer_reagent_id = flamer_reagent.id
	P.generate_bullet(ammo_datum)
	P.icon_state = "naptha_ball"
	P.color = flamer_reagent.burncolor
	P.hit_effect_color = flamer_reagent.burncolor
	P.fire_at(target, user, user, max_range, AMMO_SPEED_TIER_2, null)
	var/turf/user_turf = get_turf(user)
	playsound(user_turf, pick(fire_sounds), 50, TRUE)

	to_chat(user, SPAN_WARNING("量表显示：剩余燃料：<b>[floor(gun.current_mag.get_ammo_percent())]</b>%！"))

/obj/item/attachable/verticalgrip
	name = "垂直握把"
	desc = "一个垂直前握把，能提供更好的精度、更小的后坐力和散射，尤其是在点射时。\n然而，它也会增加武器尺寸。"
	icon = 'icons/obj/items/weapons/guns/attachments/under.dmi'
	icon_state = "verticalgrip"
	attach_icon = "verticalgrip_a"
	size_mod = 1
	slot = "under"
	pixel_shift_x = 20

/obj/item/attachable/verticalgrip/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_3
	recoil_mod = -RECOIL_AMOUNT_TIER_5
	scatter_mod = -SCATTER_AMOUNT_TIER_10
	burst_scatter_mod = -2
	movement_onehanded_acc_penalty_mod = MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
	accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_3
	scatter_unwielded_mod = SCATTER_AMOUNT_TIER_10

/obj/item/attachable/angledgrip
	name = "倾斜握把"
	desc = "一个倾斜前握把，能改善武器人体工学，从而加快装备速度。\n然而，它也会增加武器尺寸。"
	icon = 'icons/obj/items/weapons/guns/attachments/under.dmi'
	icon_state = "angledgrip"
	attach_icon = "angledgrip_a"
	wield_delay_mod = -WIELD_DELAY_FAST
	size_mod = 1
	slot = "under"
	pixel_shift_x = 20

/obj/item/attachable/gyro
	name = "陀螺稳定器"
	desc = "一套用于单手持枪射击时稳定武器的配重平衡系统。略微降低射速。"
	icon = 'icons/obj/items/weapons/guns/attachments/under.dmi'
	icon_state = "gyro"
	attach_icon = "gyro_a"
	slot = "under"

/obj/item/attachable/gyro/New()
	..()
	delay_mod = FIRE_DELAY_TIER_11
	scatter_mod = -SCATTER_AMOUNT_TIER_10
	burst_scatter_mod = -2
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_3
	scatter_unwielded_mod = -SCATTER_AMOUNT_TIER_6
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_3

/obj/item/attachable/gyro/Attach(obj/item/weapon/gun/G)
	if(istype(G, /obj/item/weapon/gun/shotgun))
		accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_10 + HIT_ACCURACY_MULT_TIER_1
	else
		accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_3
	..()


/obj/item/attachable/lasersight
	name = "激光瞄准器"
	desc = "可安装在大多数武器下方的激光瞄准器。提高精度并减少散射，尤其是在单手持枪时。"
	desc_lore = "A standard visible-band laser module designated as the AN/PEQ-42 Laser Sight. Can be mounted onto any firearm that has a lower rail large enough to accommodate it."
	icon = 'icons/obj/items/weapons/guns/attachments/under.dmi'
	icon_state = "lasersight"
	attach_icon = "lasersight_a"
	slot = "under"
	pixel_shift_x = 17
	pixel_shift_y = 17

/obj/item/attachable/lasersight/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_1
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
	scatter_mod = -SCATTER_AMOUNT_TIER_10
	scatter_unwielded_mod = -SCATTER_AMOUNT_TIER_9
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_1

/obj/item/attachable/lasersight/micro
	name = "微型激光模块"
	desc = "一款专为M10自动手枪设计的紧凑型高精度激光瞄准器。通过与武器内部瞄准系统直接交互，提供卓越的精度增益。"
	desc_lore = "An advanced derivative of the AN/PEQ-42 line, the '42M' variant was precision-tuned by Kessler Optics for use with the M10 Auto Pistol. Its microcontroller syncs with the pistol's fire-control unit for superior point-of-aim fidelity and scatter compensation. Rare, expensive, and typically reserved for elite units or covert applications."
	icon = 'icons/obj/items/weapons/guns/attachments/under.dmi'
	icon_state = "lasersight_micro"
	attach_icon = "lasersight_micro_a"
	slot = "under"
	pixel_shift_x = 17
	pixel_shift_y = 17

/obj/item/attachable/lasersight/micro/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_1
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
	scatter_mod = -SCATTER_AMOUNT_TIER_10
	scatter_unwielded_mod = -SCATTER_AMOUNT_TIER_9
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_1

/obj/item/attachable/bipod
	name = "bipod"
	desc = "一套简单的伸缩杆，用于在射击时稳定武器。\n正确放置时可大幅提高精度并减少后坐力，但也会增加武器尺寸并降低射速。"
	icon = 'icons/obj/items/weapons/guns/attachments/under.dmi'
	icon_state = "bipod"
	attach_icon = "bipod_a"
	slot = "under"
	size_mod = 2
	melee_mod = -10
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle/bipod
	var/initial_mob_dir = NORTH // the dir the mob faces the moment it deploys the bipod
	var/bipod_deployed = FALSE
	/// If this should anchor the user while in use
	var/heavy_bipod = FALSE
	// Are switching to full auto when deploying the bipod
	var/full_auto_switch = FALSE
	// Store our old firemode so we can switch to it when undeploying the bipod
	var/old_firemode = null
	// if this bipod has a camo skin
	var/camo_bipod = FALSE

/obj/item/attachable/bipod/New()
	..()

	delay_mod = FIRE_DELAY_TIER_11
	wield_delay_mod = WIELD_DELAY_FAST
	accuracy_mod = -HIT_ACCURACY_MULT_TIER_5
	scatter_mod = SCATTER_AMOUNT_TIER_9
	recoil_mod = RECOIL_AMOUNT_TIER_5

/obj/item/attachable/bipod/Attach(obj/item/weapon/gun/gun, mob/user)
	..()

	if((GUN_FIREMODE_AUTOMATIC in gun.gun_firemode_list) || (gun.flags_gun_features & GUN_SUPPORT_PLATFORM))
		var/given_action = FALSE
		if(user && (gun == user.l_hand || gun == user.r_hand))
			give_action(user, /datum/action/item_action/bipod/toggle_full_auto_switch, src, gun)
			given_action = TRUE
		if(!given_action)
			new /datum/action/item_action/bipod/toggle_full_auto_switch(src, gun)

	RegisterSignal(gun, COMSIG_ITEM_DROPPED, PROC_REF(handle_drop))

/obj/item/attachable/bipod/Detach(mob/user, obj/item/weapon/gun/detaching_gun)
	..()
	UnregisterSignal(detaching_gun, COMSIG_ITEM_DROPPED)

	//clear out anything related to full auto switching
	full_auto_switch = FALSE
	old_firemode = null
	for(var/item_action in detaching_gun.actions)
		var/datum/action/item_action/bipod/toggle_full_auto_switch/target_action = item_action
		if(target_action.target == src)
			qdel(item_action)
			break

	if(bipod_deployed)
		undeploy_bipod(detaching_gun, user)

/obj/item/attachable/bipod/update_icon()
	if(bipod_deployed)
		icon_state = "[icon_state]-on"
		attach_icon = "[attach_icon]-on"
	else
		icon_state = initial(icon_state)
		attach_icon = initial(attach_icon)
		if(camo_bipod)
			select_gamemode_skin()

	if(istype(loc, /obj/item/weapon/gun))
		var/obj/item/weapon/gun/gun = loc
		gun.update_attachable(slot)
		for(var/datum/action/item_action as anything in gun.actions)
			if(!istype(item_action, /datum/action/item_action/bipod/toggle_full_auto_switch))
				item_action.update_button_icon()

/obj/item/attachable/bipod/proc/handle_drop(obj/item/weapon/gun/gun, mob/living/carbon/human/user)
	SIGNAL_HANDLER

	UnregisterSignal(user, COMSIG_MOB_MOVE_OR_LOOK)

	if(bipod_deployed)
		undeploy_bipod(gun, user)
		user.apply_effect(1, SUPERSLOW)
		user.apply_effect(2, SLOW)

/obj/item/attachable/bipod/proc/undeploy_bipod(obj/item/weapon/gun/gun, mob/user)
	REMOVE_TRAIT(gun, TRAIT_GUN_BIPODDED, "attached_bipod")
	bipod_deployed = FALSE
	accuracy_mod = -HIT_ACCURACY_MULT_TIER_5
	scatter_mod = SCATTER_AMOUNT_TIER_9
	recoil_mod = RECOIL_AMOUNT_TIER_5
	burst_scatter_mod = 0
	delay_mod = FIRE_DELAY_TIER_11
	//if we are no longer on full auto, don't bother switching back to the old firemode
	if(full_auto_switch && gun.gun_firemode == GUN_FIREMODE_AUTOMATIC && gun.gun_firemode != old_firemode)
		gun.do_toggle_firemode(user, null, old_firemode)

	gun.recalculate_attachment_bonuses()
	gun.stop_fire()
	SEND_SIGNAL(user, COMSIG_MOB_UNDEPLOYED_BIPOD)
	UnregisterSignal(user, COMSIG_MOB_MOVE_OR_LOOK)

	if(gun.flags_gun_features & GUN_SUPPORT_PLATFORM)
		gun.remove_firemode(GUN_FIREMODE_AUTOMATIC)

	if(heavy_bipod)
		user.anchored = FALSE

	if(!QDELETED(gun))
		playsound(user,'sound/items/m56dauto_rotate.ogg', 55, 1)
		update_icon()

/obj/item/attachable/bipod/activate_attachment(obj/item/weapon/gun/gun, mob/living/user, turn_off)
	if(turn_off)
		if(bipod_deployed)
			undeploy_bipod(gun, user)
	else
		var/obj/support = check_bipod_support(gun, user)
		if(!support&&!bipod_deployed)
			to_chat(user, SPAN_NOTICE("你开始在地面部署[src]。"))
			if(!do_after(user, 15, INTERRUPT_ALL, BUSY_ICON_HOSTILE, gun, INTERRUPT_DIFF_LOC))
				return FALSE

		bipod_deployed = !bipod_deployed
		if(user)
			if(bipod_deployed)
				ADD_TRAIT(gun, TRAIT_GUN_BIPODDED, "attached_bipod")
				to_chat(user, SPAN_NOTICE("You deploy [src] [support ? "on [support]" : "on the ground"]."))
				SEND_SIGNAL(user, COMSIG_MOB_DEPLOYED_BIPOD)
				playsound(user,'sound/items/m56dauto_rotate.ogg', 55, 1)
				accuracy_mod = HIT_ACCURACY_MULT_TIER_5
				scatter_mod = -SCATTER_AMOUNT_TIER_10
				recoil_mod = -RECOIL_AMOUNT_TIER_4
				burst_scatter_mod = -SCATTER_AMOUNT_TIER_8
				if(istype(gun, /obj/item/weapon/gun/rifle/sniper/M42A))
					delay_mod = -FIRE_DELAY_TIER_7
				else
					delay_mod = -FIRE_DELAY_TIER_12
				gun.recalculate_attachment_bonuses()
				gun.stop_fire()

				initial_mob_dir = user.dir
				RegisterSignal(user, COMSIG_MOB_MOVE_OR_LOOK, PROC_REF(handle_mob_move_or_look))

				if(gun.flags_gun_features & GUN_SUPPORT_PLATFORM)
					gun.add_firemode(GUN_FIREMODE_AUTOMATIC)

				if(heavy_bipod)
					user.anchored = TRUE

				old_firemode = gun.gun_firemode
				if(full_auto_switch && gun.gun_firemode != GUN_FIREMODE_AUTOMATIC)
					gun.do_toggle_firemode(user, null, GUN_FIREMODE_AUTOMATIC)

			else
				to_chat(user, SPAN_NOTICE("你收回了[src]。"))
				undeploy_bipod(gun, user)

	update_icon()

	return 1

/obj/item/attachable/bipod/proc/handle_mob_move_or_look(mob/living/mover, actually_moving, direction, specific_direction)
	SIGNAL_HANDLER

	if(!actually_moving && (specific_direction & initial_mob_dir)) // if you're facing north, but you're shooting north-east and end up facing east, you won't lose your bipod
		return
	undeploy_bipod(loc, mover)
	mover.apply_effect(1, SUPERSLOW)
	mover.apply_effect(2, SLOW)


//when user fires the gun, we check if they have something to support the gun's bipod.
/obj/item/attachable/proc/check_bipod_support(obj/item/weapon/gun/gun, mob/living/user)
	return 0

/obj/item/attachable/bipod/check_bipod_support(obj/item/weapon/gun/gun, mob/living/user)
	var/turf/T = get_turf(user)
	for(var/obj/O in T)
		if(O.throwpass && O.density && O.dir == user.dir && O.flags_atom & ON_BORDER)
			return O
	var/turf/T2 = get_step(T, user.dir)

	for(var/obj/O2 in T2)
		if(O2.throwpass && O2.density)
			return O2
	return 0

//item actions for handling deployment to full auto.
/datum/action/item_action/bipod/toggle_full_auto_switch/New(Target, obj/item/holder)
	. = ..()
	name = "切换全自动模式"
	action_icon_state = "full_auto_switch"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/bipod/toggle_full_auto_switch/action_activate()
	. = ..()
	var/obj/item/weapon/gun/holder_gun = holder_item
	var/obj/item/attachable/bipod/attached_bipod = holder_gun.attachments["under"]

	attached_bipod.full_auto_switch = !attached_bipod.full_auto_switch
	to_chat(owner, SPAN_NOTICE("[icon2html(holder_gun, owner)] You will [attached_bipod.full_auto_switch? "<B>start</b>" : "<B>stop</b>"] switching to full auto when deploying the bipod."))
	playsound(owner, 'sound/weapons/handling/gun_burst_toggle.ogg', 15, 1)

	if(attached_bipod.full_auto_switch)
		action_icon_state = "full_auto_switch_off"
	else
		action_icon_state = "full_auto_switch"

	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)


/obj/item/attachable/bipod/m60
	name = "bipod"
	desc = "一套简单的伸缩杆，用于在射击时稳定武器。这个看起来相当老旧。\n正确放置时可大幅提高精度并减少后坐力，但也会增加武器尺寸并降低射速。"
	icon_state = "bipod_m60"
	attach_icon = "bipod_m60_a"

	flags_attach_features = ATTACH_ACTIVATION

/obj/item/attachable/bipod/pkp
	name = "PKP两脚架"
	desc = "一套简单的伸缩杆，用于在射击时稳定武器。"
	icon_state = "qjy72_bipod"
	attach_icon = "qjy72_bipod"

/obj/item/attachable/bipod/vulture
	name = "重型两脚架"
	desc = "一套坚固的伸缩杆，用于在射击时稳定武器。"
	icon_state = "bipod_m60"
	attach_icon = "vulture_bipod"
	heavy_bipod = TRUE
	// Disable gamemode skin for item state, but we explicitly force attach_icon gamemode skins
	flags_atom = FPRINT|CONDUCT|NO_GAMEMODE_SKIN
	camo_bipod = TRUE // this bipod has a camo skin

/obj/item/attachable/bipod/vulture/Initialize(mapload, ...)
	. = ..()
	select_gamemode_skin(type)

/obj/item/attachable/bipod/vulture/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..() // We are forcing attach_icon skin
	var/new_attach_icon
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("snow")
			attach_icon = new_attach_icon ? new_attach_icon : "s_" + attach_icon
			. = TRUE
		if("desert")
			attach_icon = new_attach_icon ? new_attach_icon : "d_" + attach_icon
			. = TRUE
		if("classic")
			attach_icon = new_attach_icon ? new_attach_icon : "c_" + attach_icon
			. = TRUE
		if("urban")
			attach_icon = new_attach_icon ? new_attach_icon : "u_" + attach_icon
			. = TRUE
	return .

/obj/item/attachable/bipod/vulture/bipod/New()
	..()

	delay_mod = FIRE_DELAY_TIER_11
	wield_delay_mod = WIELD_DELAY_FAST
	accuracy_mod = -HIT_ACCURACY_MULT_TIER_5
	scatter_mod = SCATTER_AMOUNT_NONE
	recoil_mod = RECOIL_AMOUNT_TIER_5

/obj/item/attachable/bipod/m41ae2
	name = "机枪两脚架"
	desc = "一套坚固的伸缩杆，用于在射击时稳定武器。"
	icon_state = "bipod_m41ae2"
	attach_icon = "bipod_m41ae2_a"
	heavy_bipod = FALSE
	camo_bipod = TRUE // this bipod has a camo skin

/obj/item/attachable/bipod/m41ae2/Initialize(mapload, ...)
	. = ..()
	update_icon()

/obj/item/attachable/bipod/m41ae2/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..() // We are forcing attach_icon skin
	var/new_attach_icon
	var/new_icon_state
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("snow")
			attach_icon = new_attach_icon ? new_attach_icon : "s_" + attach_icon
			icon_state = new_icon_state ? new_icon_state : "s_" + icon_state
			. = TRUE
		if("desert")
			attach_icon = new_attach_icon ? new_attach_icon : "d_" + attach_icon
			icon_state = new_icon_state ? new_icon_state : "d_" + icon_state
			. = TRUE
		if("classic")
			attach_icon = new_attach_icon ? new_attach_icon : "c_" + attach_icon
			icon_state = new_icon_state ? new_icon_state : "c_" + icon_state
			. = TRUE
		if("urban")
			attach_icon = new_attach_icon ? new_attach_icon : "u_" + attach_icon
			icon_state = new_icon_state ? new_icon_state : "u_" + icon_state
			. = TRUE
	return .

/obj/item/attachable/burstfire_assembly
	name = "点射组件"
	desc = "一个精巧的小型机械斜面部件，可增加某些武器的点射次数，并为其他武器提供此能力。\n增加武器散射。"
	icon = 'icons/obj/items/weapons/guns/attachments/under.dmi'
	icon_state = "rapidfire"
	attach_icon = "rapidfire_a"
	slot = "under"

/obj/item/attachable/burstfire_assembly/New()
	..()
	accuracy_mod = -HIT_ACCURACY_MULT_TIER_3
	burst_mod = BURST_AMOUNT_TIER_2

	accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_4

/obj/item/attachable/eva_doodad
	name = "RXF-M5 EVA光束投射器"
	desc = "一个奇怪的小装置，能投射出EVA手枪实际激光穿行的不可见光束，用作聚焦器，会略微减弱激光强度。至少说明书上是这么说的。"
	icon = 'icons/obj/items/weapons/guns/attachments/under.dmi'
	icon_state = "rxfm5_eva_doodad"
	attach_icon = "rxfm5_eva_doodad_a"
	slot = "under"

/obj/item/attachable/eva_doodad/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_5
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_5
	damage_mod -= BULLET_DAMAGE_MULT_TIER_4


///Purely cosmetic attachments, used to change the appearance of a gun without changing its stats.
/obj/item/attachable/cosmetic
	slot = "cosmetic"

/obj/item/attachable/cosmetic/clf_flag
	name = "磨损的CLF旗帜"
	desc = "一面磨损的旗帜。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/machineguns.dmi'
	icon_state = null
	attach_icon = "m56f_flag"
	flags_attach_features = NO_FLAGS

/obj/item/attachable/cosmetic/clf_rags
	name = "脏布条"
	desc = "一些布条。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/machineguns.dmi'
	icon_state = null
	attach_icon = "m56f_rags"
	flags_attach_features = NO_FLAGS

/obj/item/attachable/cosmetic/clf_sling
	name = "临时吊索"
	desc = "一个皮革吊索。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/machineguns.dmi'
	icon_state = null
	attach_icon = "m56f_sling"
	flags_attach_features = NO_FLAGS

/obj/item/attachable/cosmetic/uscm_flag
	name = "USCM旗帜"
	desc = "一面布制旗帜。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/machineguns.dmi'
	icon_state = null
	attach_icon = "m56c_flag"
	flags_attach_features = NO_FLAGS
