//-------------------------------------------------------
//This gun is very powerful, but also has a kick.

/obj/item/weapon/gun/minigun
	name = "\improper Ol' Painless"
	desc = "一门巨大的多管旋转加特林机枪。这东西无疑威力巨大。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/event.dmi'
	icon_state = "painless"
	item_state = "painless"
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/guns_by_type/machineguns.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/machineguns.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/machineguns_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/machineguns_righthand.dmi'
	)
	mouse_pointer = 'icons/effects/mouse_pointer/lmg_mouse.dmi'

	fire_sound = 'sound/weapons/gun_minigun.ogg'
	cocked_sound = 'sound/weapons/gun_minigun_cocked.ogg'
	current_mag = /obj/item/ammo_magazine/minigun
	w_class = SIZE_HUGE
	force = 20
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_RECOIL_BUILDUP|GUN_CAN_POINTBLANK
	gun_category = GUN_CATEGORY_HEAVY
	start_semiauto = FALSE
	start_automatic = TRUE

/obj/item/weapon/gun/minigun/Initialize(mapload, spawn_empty)
	. = ..()
	if(current_mag && current_mag.current_rounds > 0)
		load_into_chamber()

/obj/item/weapon/gun/minigun/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)

	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3

	scatter = SCATTER_AMOUNT_TIER_9 // Most of the scatter should come from the recoil

	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_buildup_limit = RECOIL_AMOUNT_TIER_3 / RECOIL_BUILDUP_VIEWPUNCH_MULTIPLIER

/obj/item/weapon/gun/minigun/handle_starting_attachment()
	..()
	//invisible mag harness
	var/obj/item/attachable/magnetic_harness/Integrated = new(src)
	Integrated.hidden = TRUE
	Integrated.flags_attach_features &= ~ATTACH_REMOVABLE
	Integrated.Attach(src)
	update_attachable(Integrated.slot)

//Minigun UPP
/obj/item/weapon/gun/minigun/upp
	name = "\improper GSh-7.62 rotary machine gun"
	desc = "UPP重型单位使用的气动旋转机枪。其巨大的火力密度和弹药容量足以压制大规模敌军。需要重型武器训练来控制其后坐力。"
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_SPECIALIST|GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_RECOIL_BUILDUP|GUN_CAN_POINTBLANK

/obj/item/weapon/gun/minigun/upp/able_to_fire(mob/living/user)
	. = ..()
	if(!. || !istype(user)) //Let's check all that other stuff first.
		return 0
	if(!skillcheck(user, SKILL_FIREARMS, SKILL_FIREARMS_TRAINED))
		to_chat(user, SPAN_WARNING("你似乎不知道如何使用 [src]..."))
		return 0
	if(!skillcheck(user, SKILL_SPEC_WEAPONS, SKILL_SPEC_ALL) && user.skills.get_skill_level(SKILL_SPEC_WEAPONS) != SKILL_SPEC_UPP)
		to_chat(user, SPAN_WARNING("你似乎不知道如何使用 [src]..."))
		return 0


//M60
/obj/item/weapon/gun/m60
	name = "\improper M60 General Purpose Machine Gun"
	desc = "M60。猪猡。动作英雄的终极幻想。\n<b>Alt+点击以打开供弹盖进行装填。</b>"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/machineguns.dmi'
	icon_state = "m60"
	item_state = "m60"
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/guns_by_type/machineguns.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/machineguns.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/machineguns_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/machineguns_righthand.dmi'
	)
	mouse_pointer = 'icons/effects/mouse_pointer/lmg_mouse.dmi'

	fire_sound = 'sound/weapons/gun_m60.ogg'
	cocked_sound = 'sound/weapons/gun_m60_cocked.ogg'

	current_mag = /obj/item/ammo_magazine/m60
	pixel_x = -10
	hud_offset = -10
	w_class = SIZE_LARGE
	force = 25
	flags_gun_features = GUN_WIELDED_FIRING_ONLY|GUN_CAN_POINTBLANK
	gun_category = GUN_CATEGORY_HEAVY
	attachable_allowed = list(
		/obj/item/attachable/bipod/m60,
	)
	starting_attachment_types = list(
		/obj/item/attachable/bipod/m60,
	)
	start_semiauto = FALSE
	start_automatic = TRUE

	var/cover_open = FALSE //if the gun's feed-cover is open or not.

/obj/item/weapon/gun/m60/Initialize(mapload, spawn_empty)
	. = ..()
	if(current_mag && current_mag.current_rounds > 0)
		load_into_chamber()

/obj/item/weapon/gun/m60/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 37, "muzzle_y" = 16, "rail_x" = 0, "rail_y" = 0, "under_x" = 38, "under_y" = 12, "stock_x" = 10, "stock_y" = 14)

/obj/item/weapon/gun/m60/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	set_burst_amount(BURST_AMOUNT_TIER_5)
	set_burst_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_NONE - SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_8
	scatter_unwielded = SCATTER_AMOUNT_TIER_10
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	empty_sound = 'sound/weapons/gun_empty.ogg'

/obj/item/weapon/gun/m60/clicked(mob/user, list/mods)
	if(!mods[ALT_CLICK] || !CAN_PICKUP(user, src))
		return ..()
	else
		if(!locate(src) in list(user.get_active_hand(), user.get_inactive_hand()))
			return TRUE
		if(user.get_active_hand() && user.get_inactive_hand())
			to_chat(user, SPAN_WARNING("你双手没空，做不到！"))
			return TRUE
		if(!cover_open)
			playsound(src.loc, 'sound/handling/smartgun_open.ogg', 50, TRUE, 3)
			to_chat(user, SPAN_NOTICE("你打开[src]的供弹盖，可以取出弹链了。"))
			cover_open = TRUE
		else
			playsound(src.loc, 'sound/handling/smartgun_close.ogg', 50, TRUE, 3)
			to_chat(user, SPAN_NOTICE("你关上[src]的供弹盖。"))
			cover_open = FALSE
		update_icon()
		return TRUE

/obj/item/weapon/gun/m60/replace_magazine(mob/user, obj/item/ammo_magazine/magazine)
	if(!cover_open)
		to_chat(user, SPAN_WARNING("[src]的供弹盖关着！你无法放入新弹链！<b>(alt+点击打开)</b>"))
		return
	return ..()

/obj/item/weapon/gun/m60/unload(mob/user, reload_override, drop_override, loc_override)
	if(!cover_open)
		to_chat(user, SPAN_WARNING("[src]的供弹盖关着！你无法取出弹链！<b>(alt+点击打开)</b>"))
		return
	return ..()

/obj/item/weapon/gun/m60/update_icon()
	. = ..()
	if(cover_open)
		overlays += image(icon, src, "+[base_gun_icon]_cover_open", pixel_x = -2, pixel_y = 8)
	else
		overlays += image(icon, src, "+[base_gun_icon]_cover_closed", pixel_x = -10, pixel_y = 0)

/obj/item/weapon/gun/m60/able_to_fire(mob/living/user)
	. = ..()
	if(.)
		if(cover_open)
			to_chat(user, SPAN_WARNING("供弹盖开着时无法射击[src]！<b>(alt+点击关闭)</b>"))
			return FALSE


/obj/item/weapon/gun/pkp
	name = "\improper QYJ-72 General Purpose Machine Gun"
	desc = "QYJ-72是进步人民联盟的标准通用机枪，使用7.62x54mmR口径弹药，发射威力强大、射速高的子弹。配备250发超大弹箱，QJY-72的设计核心是压制火力和以火力密度保证的精度。\n<b>Alt+点击以打开供弹盖进行装填。</b>"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/UPP/machineguns.dmi'
	icon_state = "qjy72"
	item_state = "qjy72"
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/guns_by_type/machineguns.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/machineguns.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/machineguns_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/machineguns_righthand.dmi'
	)
	fire_sound = 'sound/weapons/gun_mg.ogg'
	cocked_sound = 'sound/weapons/gun_m60_cocked.ogg'
	current_mag = /obj/item/ammo_magazine/pkp

	pixel_x = -10
	hud_offset = -10

	w_class = SIZE_LARGE
	force = 40 //the image of a upp machinegunner beating someone to death with a gpmg makes me laugh
	start_semiauto = FALSE
	start_automatic = TRUE
	flags_gun_features = GUN_WIELDED_FIRING_ONLY|GUN_CAN_POINTBLANK|GUN_AUTO_EJECTOR|GUN_SPECIALIST|GUN_AMMO_COUNTER
	gun_category = GUN_CATEGORY_HEAVY
	attachable_allowed = list(
		/obj/item/attachable/bipod/pkp,
	)
	var/cover_open = FALSE //if the gun's feed-cover is open or not.

/obj/item/weapon/gun/pkp/handle_starting_attachment()
	..()

	//invisible mag harness
	var/obj/item/attachable/magnetic_harness/harness = new(src)
	harness.hidden = TRUE
	harness.flags_attach_features &= ~ATTACH_REMOVABLE
	harness.Attach(src)
	update_attachable(harness.slot)

	var/obj/item/attachable/bipod/pkp/bipod = new /obj/item/attachable/bipod/pkp(src)
	bipod.flags_attach_features &= ~ATTACH_REMOVABLE
	bipod.Attach(src)
	update_attachable(bipod.slot)


/obj/item/weapon/gun/pkp/Initialize(mapload, spawn_empty)
	. = ..()
	AddElement(/datum/element/corp_label/norcomm)
	if(current_mag && current_mag.current_rounds > 0)
		load_into_chamber()

/obj/item/weapon/gun/pkp/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 45, "muzzle_y" = 18, "rail_x" = 16, "rail_y" = 5, "under_x" = 37, "under_y" = 15, "stock_x" = 10, "stock_y" = 13)


/obj/item/weapon/gun/pkp/set_gun_config_values()
	..()
	fire_delay = FIRE_DELAY_TIER_10
	burst_amount = BURST_AMOUNT_TIER_6
	burst_delay = FIRE_DELAY_TIER_9
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	fa_max_scatter = SCATTER_AMOUNT_TIER_8
	scatter = SCATTER_AMOUNT_TIER_10
	burst_scatter_mult = SCATTER_AMOUNT_TIER_8
	scatter_unwielded = SCATTER_AMOUNT_TIER_10
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	empty_sound = 'sound/weapons/gun_empty.ogg'

/obj/item/weapon/gun/pkp/clicked(mob/user, list/mods)
	if(!mods[ALT_CLICK] || !CAN_PICKUP(user, src))
		return ..()
	else
		if(!locate(src) in list(user.get_active_hand(), user.get_inactive_hand()))
			return TRUE
		if(user.get_active_hand() && user.get_inactive_hand())
			to_chat(user, SPAN_WARNING("你双手没空，做不到！"))
			return TRUE
		if(!cover_open)
			playsound(src.loc, 'sound/handling/smartgun_open.ogg', 50, TRUE, 3)
			to_chat(user, SPAN_NOTICE("你打开[src]的供弹盖，可以取出弹链了。"))
			cover_open = TRUE
		else
			playsound(src.loc, 'sound/handling/smartgun_close.ogg', 50, TRUE, 3)
			to_chat(user, SPAN_NOTICE("你关上[src]的供弹盖。"))
			cover_open = FALSE
		update_icon()
		return TRUE

/obj/item/weapon/gun/pkp/replace_magazine(mob/user, obj/item/ammo_magazine/magazine)
	if(!cover_open)
		to_chat(user, SPAN_WARNING("[src]的供弹盖关着！你无法放入新弹链！<b>(alt+点击打开)</b>"))
		return
	return ..()

/obj/item/weapon/gun/pkp/unload(mob/user, reload_override, drop_override, loc_override)
	if(!cover_open)
		to_chat(user, SPAN_WARNING("[src]的供弹盖关着！你无法取出弹链！<b>(alt+点击打开)</b>"))
		return
	return ..()

/obj/item/weapon/gun/pkp/update_icon()
	. = ..()
	if(cover_open)
		overlays += "+[base_gun_icon]_cover_open"
	else
		overlays += "+[base_gun_icon]_cover_closed"

/obj/item/weapon/gun/pkp/able_to_fire(mob/living/user)
	. = ..()
	if(.)
		if(cover_open)
			to_chat(user, SPAN_WARNING("供弹盖开着时无法射击[src]！<b>(alt+点击关闭)</b>"))
			return FALSE
	if(!skillcheck(user, SKILL_FIREARMS, SKILL_FIREARMS_TRAINED))
		to_chat(user, SPAN_WARNING("你似乎不知道如何使用 [src]..."))
		return 0
	if(!skillcheck(user, SKILL_SPEC_WEAPONS, SKILL_SPEC_ALL) && user.skills.get_skill_level(SKILL_SPEC_WEAPONS) != SKILL_SPEC_UPP)
		to_chat(user, SPAN_WARNING("你似乎不知道如何使用 [src]..."))
		return 0

//PILLGUN
/obj/item/weapon/gun/pill
	name = "药丸枪"
	desc = "一种装有弹簧的步枪，设计用于容纳药丸，旨在从远处为病人注射。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/event.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
	)
	icon_state = "syringegun"
	item_state = "syringegun"
	w_class = SIZE_MEDIUM
	throw_speed = SPEED_SLOW
	throw_range = 10
	force = 4

	current_mag = /obj/item/ammo_magazine/internal/pillgun

	flags_gun_features = GUN_INTERNAL_MAG

	matter = list("metal" = 2000)

/obj/item/weapon/gun/pill/attackby(obj/item/I as obj, mob/user as mob)
	if(I.loc == current_mag)
		return

	if(!istype(I, /obj/item/reagent_container/pill))
		return

	if(current_mag.current_rounds >= current_mag.max_rounds)
		to_chat(user, SPAN_WARNING("[src]的弹药已达最大容量！"))
		return

	user.drop_inv_item_on_ground(I)
	I.forceMove(current_mag)

/obj/item/weapon/gun/pill/update_icon()
	. = ..()
	if(!current_mag || !current_mag.current_rounds)
		icon_state = base_gun_icon
	else
		icon_state = base_gun_icon + "_e"

/obj/item/weapon/gun/pill/unload(mob/user, reload_override, drop_override, loc_override)
	var/obj/item/ammo_magazine/internal/pillgun/internal_mag = current_mag

	if(!istype(internal_mag))
		return

	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user

	var/obj/item/reagent_container/pill/pill_to_use = LAZYACCESS(internal_mag.pills, 1)

	if(!pill_to_use)
		return

	pill_to_use.forceMove(get_turf(H.loc))
	H.put_in_active_hand(pill_to_use)

/obj/item/weapon/gun/pill/Fire(atom/target, mob/living/user, params, reflex, dual_wield)
	if(!able_to_fire(user))
		return NONE

	if(!current_mag.current_rounds)
		click_empty(user)
		return NONE

	if(!istype(current_mag, /obj/item/ammo_magazine/internal/pillgun))
		return NONE

	var/obj/item/ammo_magazine/internal/pillgun/internal_mag = current_mag
	var/obj/item/reagent_container/pill/pill_to_use = LAZYACCESS(internal_mag.pills, 1)

	if(QDELETED(pill_to_use))
		click_empty(user)
		return NONE

	var/obj/projectile/pill/P = new /obj/projectile/pill(src, user, src)
	P.generate_bullet(GLOB.ammo_list[/datum/ammo/pill], 0, 0)

	pill_to_use.forceMove(P)
	P.source_pill = pill_to_use

	playsound(user.loc, 'sound/items/syringeproj.ogg', 50, 1)

	P.fire_at(target, user, src)
	return AUTOFIRE_CONTINUE

// upgraded version, currently no way of getting it
/obj/item/weapon/gun/pill/super
	name = "大型药丸枪"
	current_mag = /obj/item/ammo_magazine/internal/pillgun/super
