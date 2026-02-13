//---------------------------------------------------

//Generic parent object.
/obj/item/weapon/gun/revolver
	flags_equip_slot = SLOT_WAIST
	w_class = SIZE_MEDIUM
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/guns.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/revolvers.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/revolvers_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/revolvers_righthand.dmi'
	)
	mouse_pointer = 'icons/effects/mouse_pointer/pistol_mouse.dmi'

	matter = list("metal" = 2000)
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_INTERNAL_MAG|GUN_ONE_HAND_WIELDED
	gun_category = GUN_CATEGORY_HANDGUN
	wield_delay = WIELD_DELAY_VERY_FAST //If you modify your revolver to be two-handed, it will still be fast to aim
	movement_onehanded_acc_penalty_mult = 3
	has_empty_icon = FALSE
	has_open_icon = TRUE
	current_mag = /obj/item/ammo_magazine/internal/revolver

	fire_sound = 'sound/weapons/gun_44mag_v4.ogg'
	reload_sound = 'sound/weapons/gun_44mag_speed_loader.wav'
	cocked_sound = 'sound/weapons/gun_revolver_spun.ogg'
	unload_sound = 'sound/weapons/gun_44mag_open_chamber.wav'
	var/chamber_close_sound = 'sound/weapons/gun_44mag_close_chamber.wav'
	var/hand_reload_sound = 'sound/weapons/gun_revolver_load3.ogg'
	var/spin_sound = 'sound/effects/spin.ogg'
	var/thud_sound = 'sound/effects/thud.ogg'
	var/list/cylinder_click = list('sound/weapons/gun_empty.ogg')

	var/trick_delay = 4 SECONDS
	var/recent_trick //So they're not spamming tricks.
	var/russian_roulette = 0 //God help you if you do this.
	var/trickster_gun = FALSE //If true, allows gun spinning.

/obj/item/weapon/gun/revolver/Initialize(mapload, spawn_empty)
	. = ..()
	if(current_mag)
		replace_cylinder(current_mag.current_rounds)

/obj/item/weapon/gun/revolver/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_5)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_3
	scatter = SCATTER_AMOUNT_TIER_8
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_3
	movement_onehanded_acc_penalty_mult = 3

/obj/item/weapon/gun/revolver/get_examine_text(mob/user)
	. = ..()
	if(current_mag)
		var/message = "[current_mag.chamber_closed? "It's closed.": "It's open with [current_mag.current_rounds] round\s loaded."]"
		. += message

	if(trickster_gun)
		. += SPAN_NOTICE("You feel like tricks with it can be done easily.")

/obj/item/weapon/gun/revolver/display_ammo(mob/user) // revolvers don't *really* have a chamber, at least in a way that matters for ammo displaying
	if(flags_gun_features & GUN_AMMO_COUNTER && !(flags_gun_features & GUN_BURST_FIRING) && current_mag)
		to_chat(user, SPAN_DANGER("剩余 [current_mag.current_rounds] / [current_mag.max_rounds] 发子弹。"))

/obj/item/weapon/gun/revolver/proc/rotate_cylinder(mob/user) //Cylinder moves backward.
	if(current_mag)
		current_mag.chamber_position = current_mag.chamber_position == 1 ? current_mag.max_rounds : current_mag.chamber_position - 1

/obj/item/weapon/gun/revolver/proc/spin_cylinder(mob/user)
	if(current_mag && current_mag.chamber_closed) //We're not spinning while it's open. Could screw up reloading.
		current_mag.chamber_position = rand(1,current_mag.max_rounds)
		to_chat(user, SPAN_NOTICE("你旋转了弹巢。"))
		playsound(user, cocked_sound, 25, 1)
		russian_roulette = TRUE //Sets to play RR. Resets when the gun is emptied.

/obj/item/weapon/gun/revolver/proc/perform_tricks(mob/user)
	var/result = revolver_trick(user)
	if(result)
		to_chat(user, SPAN_NOTICE("你炫酷的技巧鼓舞了自己。接下来的几枪将会更加专注！"))
		accuracy_mult = BASE_ACCURACY_MULT * 2
		accuracy_mult_unwielded = BASE_ACCURACY_MULT * 2
		addtimer(CALLBACK(src, PROC_REF(recalculate_attachment_bonuses)), 3 SECONDS)

/obj/item/weapon/gun/revolver/proc/replace_cylinder(number_to_replace)
	if(current_mag)
		current_mag.chamber_contents = list()
		current_mag.chamber_contents.len = current_mag.max_rounds
		var/i
		for(i = 1 to current_mag.max_rounds) //We want to make sure to populate the cylinder.
			current_mag.chamber_contents[i] = i > number_to_replace ? "empty" : "bullet"
		current_mag.chamber_position = max(1,number_to_replace)

/obj/item/weapon/gun/revolver/proc/empty_cylinder()
	if(current_mag)
		for(var/i = 1 to current_mag.max_rounds)
			current_mag.chamber_contents[i] = "empty"

//The cylinder is always emptied out before a reload takes place.
/obj/item/weapon/gun/revolver/proc/add_to_cylinder(mob/user) //Bullets are added forward.
	if(current_mag)
		//First we're going to try and replace the current bullet.
		if(!current_mag.current_rounds)
			current_mag.chamber_contents[current_mag.chamber_position] = "bullet"
		else //Failing that, we'll try to replace the next bullet in line.
			if((current_mag.chamber_position + 1) > current_mag.max_rounds)
				current_mag.chamber_contents[1] = "bullet"
				current_mag.chamber_position = 1
			else
				current_mag.chamber_contents[current_mag.chamber_position + 1] = "bullet"
				current_mag.chamber_position++
		playsound(user, hand_reload_sound, 25, 1)
		return 1

/obj/item/weapon/gun/revolver/reload(mob/user, obj/item/ammo_magazine/magazine)
	if(flags_gun_features & GUN_BURST_FIRING)
		return

	if(!magazine || !istype(magazine))
		to_chat(user, SPAN_WARNING("这行不通！"))
		return

	if(magazine.current_rounds <= 0)
		to_chat(user, SPAN_WARNING("那个 [magazine.name] 是空的！"))
		return

	if(current_mag)
		if(istype(magazine, /obj/item/ammo_magazine/handful)) //Looks like we're loading via handful.
			if(current_mag.chamber_closed)
				to_chat(user, SPAN_WARNING("弹巢关闭时无法装填任何东西！"))
				return
			if(!current_mag.current_rounds && current_mag.caliber == magazine.caliber) //Make sure nothing's loaded and the calibers match.
				replace_ammo(user, magazine) //We are going to replace the ammo just in case.
				current_mag.match_ammo(magazine)
				current_mag.transfer_ammo(magazine,user,1) //Handful can get deleted, so we can't check through it.
				add_to_cylinder(user)
			//If bullets still remain in the gun, we want to check if the actual ammo matches.
			else if(magazine.default_ammo == current_mag.default_ammo) //Ammo datums match, let's see if they are compatible.
				if(current_mag.transfer_ammo(magazine,user,1))
					add_to_cylinder(user)//If the magazine is deleted, we're still fine.
			else
				to_chat(user, "[current_mag] 是 [current_mag.current_rounds ? "already loaded with some other ammo. Better not mix them up." : "not compatible with that ammo."]") //Not the right kind of ammo.
		else //So if it's not a handful, it's an actual speedloader.
			if(current_mag.gun_type == magazine.gun_type) //Has to be the same gun type.
				if(current_mag.chamber_closed) // If the chamber is closed unload it
					unload(user)
				if(current_mag.transfer_ammo(magazine,user,magazine.current_rounds))//Make sure we're successful.
					replace_ammo(user, magazine) //We want to replace the ammo ahead of time, but not necessary here.
					current_mag.match_ammo(magazine)
					replace_cylinder(current_mag.current_rounds)
					playsound(user, reload_sound, 25, 1) // Reloading via speedloader.
					if(!current_mag.chamber_closed) // If the chamber is open, we close it
						unload(user)
			else
				to_chat(user, SPAN_WARNING("\The [magazine] doesn't fit!"))

/obj/item/weapon/gun/revolver/unload(mob/user)
	if(flags_gun_features & GUN_BURST_FIRING)
		return

	if(current_mag)
		if(current_mag.chamber_closed) //If it's actually closed.
			to_chat(user, SPAN_NOTICE("你清空了 [src] 的弹巢。"))
			empty_cylinder()
			current_mag.create_handful(user)
			current_mag.chamber_closed = !current_mag.chamber_closed
			russian_roulette = FALSE //Resets the RR variable.
			playsound(src, chamber_close_sound, 25, 1)
		else
			current_mag.chamber_closed = !current_mag.chamber_closed
			playsound(src, unload_sound, 25, 1)
		update_icon()
	return

/obj/item/weapon/gun/revolver/able_to_fire(mob/user)
	. = ..()
	if(. && istype(user) && current_mag && !current_mag.chamber_closed)
		to_chat(user, SPAN_WARNING("关闭弹巢！"))
		playsound(user, pick(cylinder_click), 25, 1, 5)
		return 0

/obj/item/weapon/gun/revolver/ready_in_chamber()
	if(current_mag)
		if(current_mag.current_rounds > 0)
			if(current_mag.chamber_contents[current_mag.chamber_position] == "bullet")
				in_chamber = create_bullet(ammo, initial(name))
				apply_traits(in_chamber)
				return in_chamber
		else if(current_mag.chamber_closed)
			unload(null)

/obj/item/weapon/gun/revolver/load_into_chamber(mob/user)
	if(ready_in_chamber())
		return in_chamber
	rotate_cylinder() //If we fail to return to chamber the round, we just move the firing pin some.

/obj/item/weapon/gun/revolver/reload_into_chamber(mob/user)
	in_chamber = null
	if(current_mag)
		if(current_mag.current_rounds > 0)
			current_mag.current_rounds-- // Subtract the round from the mag only after firing is confirmed
		current_mag.chamber_contents[current_mag.chamber_position] = "blank" //We shot the bullet.
		rotate_cylinder()
		return 1

/obj/item/weapon/gun/revolver/delete_bullet(obj/projectile/projectile_to_fire, refund = 0)
	qdel(projectile_to_fire)
	if(refund && current_mag)
		current_mag.current_rounds++
	return TRUE

// FLUFF kinda
/obj/item/weapon/gun/revolver/proc/close_chamber(mob/user)
	if(current_mag && !current_mag.chamber_closed)
		current_mag.chamber_closed = TRUE
		to_chat(user, SPAN_NOTICE("你关闭了 [src] 的弹巢。"))
		playsound(user, chamber_close_sound, 25, 1)
		update_icon()

/obj/item/weapon/gun/revolver/unique_action(mob/user)
	if(current_mag && !current_mag.chamber_closed)
		close_chamber(user)
		return
	if(trickster_gun && user.a_intent == INTENT_DISARM)
		perform_tricks(user)
		return
	else
		spin_cylinder(user)

/obj/item/weapon/gun/revolver/proc/revolver_basic_spin(mob/living/carbon/human/user, direction = 1, obj/item/weapon/gun/revolver/double)
	set waitfor = 0
	playsound(user, spin_sound, 25, 1)
	if(double)
		user.visible_message("[user] 灵巧地甩动并旋转了 [src] 和 [double]！", SPAN_NOTICE("You flick and spin [src] and [double]!"),  null, 3)
		animation_wrist_flick(double, 1)
	else
		user.visible_message("[user] 灵巧地甩动并旋转了 [src]！",SPAN_NOTICE("You flick and spin [src]!"),  null, 3)

	animation_wrist_flick(src, direction)
	sleep(3)
	if(loc && user)
		playsound(user, thud_sound, 25, 1)

/obj/item/weapon/gun/revolver/proc/revolver_throw_catch(mob/living/carbon/human/user)
	set waitfor = 0
	user.visible_message("[user]灵巧地拨动[src]并将其抛向空中！", SPAN_NOTICE("You flick and toss [src] into the air!"), null, 3)
	var/img_layer = MOB_LAYER+0.1
	var/image/trick = image(icon,user,icon_state,img_layer)
	switch(pick(1,2))
		if(1)
			animation_toss_snatch(trick)
		if(2)
			animation_toss_flick(trick, pick(1,-1))

	invisibility = 100
	var/list/client/displayed_for = list()
	for(var/mob/M as anything in viewers(user))
		var/client/C = M.client
		if(C)
			C.images += trick
			displayed_for += C

	sleep(6) // BOO

	for(var/client/C in displayed_for)
		C.images -= trick
	trick = null
	invisibility = 0

	if(loc && user)
		playsound(user, thud_sound, 25, 1)
		if(user.get_inactive_hand())
			user.visible_message("[user]用同一只手接住了[src]！", SPAN_NOTICE("You catch [src] as it spins in to your hand!"), null, 3)
		else
			user.visible_message("[user] catches [src] with \his other hand!", SPAN_NOTICE("You snatch [src] with your other hand! Awesome!"), null, 3)
			user.temp_drop_inv_item(src)
			user.put_in_inactive_hand(src)
			user.swap_hand()
			user.update_inv_l_hand(0)
			user.update_inv_r_hand()

/obj/item/weapon/gun/revolver/proc/revolver_trick(mob/living/carbon/human/user)
	if(world.time < (recent_trick + trick_delay) )
		return //Don't spam it.
	if(!istype(user))
		return //Not human.
	var/chance = -5
	chance = user.health < 6 ? 0 : user.health - 5

	//Pain is largely ignored, since it deals its own effects on the mob. We're just concerned with health.
	//And this proc will only deal with humans for now.

	recent_trick = world.time //Turn on the delay for the next trick.
	var/obj/item/weapon/gun/revolver/double = user.get_inactive_hand()
	if(prob(chance))
		switch(rand(1,8))
			if(1)
				revolver_basic_spin(user, -1)
			if(2)
				revolver_basic_spin(user, 1)
			if(3)
				revolver_throw_catch(user)
			if(4)
				revolver_basic_spin(user, 1)
			if(5)
				revolver_basic_spin(user, 1)
			if(6)
				var/arguments[] = istype(double) ? list(user, 1, double) : list(user, -1)
				revolver_basic_spin(arglist(arguments))
			if(7)
				var/arguments[] = istype(double) ? list(user, -1, double) : list(user, 1)
				revolver_basic_spin(arglist(arguments))
			if(8)
				if(istype(double))
					spawn(0)
						double.revolver_throw_catch(user)
					revolver_throw_catch(user)
				else
					revolver_throw_catch(user)
		return TRUE
	else
		user.visible_message(SPAN_INFO("<b>[user]</b>像个大蠢货一样笨手笨脚地摆弄着[src]！"), null, null, 3)
		to_chat(user, SPAN_WARNING("你像个蠢货一样笨手笨脚地摆弄着[src]...真逊。"))
		return FALSE


//-------------------------------------------------------
//M44 Revolver

/obj/item/weapon/gun/revolver/m44
	name = "\improper M44 combat revolver"
	desc = "一把笨重的左轮手枪，殖民地海军陆战队的突击部队和军官以及民间执法部门偶尔会携带。发射.44马格南子弹。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/revolvers.dmi'
	icon_state = "m44r"
	item_state = "m44r"
	current_mag = /obj/item/ammo_magazine/internal/revolver/m44
	force = 8
	flags_gun_features = GUN_INTERNAL_MAG|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
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
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/compensator,
		/obj/item/attachable/stock/revolver,
		/obj/item/attachable/scope,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/alt_iff_scope,
	)
	var/folded = FALSE // Used for the stock attachment, to check if we can shoot or not

/obj/item/weapon/gun/revolver/m44/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/weapon/gun/revolver/m44/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 21, "rail_x" = 12, "rail_y" = 23, "under_x" = 21, "under_y" = 16, "stock_x" = 16, "stock_y" = 20)

/obj/item/weapon/gun/revolver/m44/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_7)
	accuracy_mult = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_8
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_3

/obj/item/weapon/gun/revolver/m44/able_to_fire(mob/user)
	if (folded)
		to_chat(user, SPAN_NOTICE("你需要展开枪托才能开火！"))//this is stupid
		return 0
	else
		return ..()

/obj/item/weapon/gun/revolver/m44/mp //No differences (yet) beside spawning with marksman ammo loaded
	current_mag = /obj/item/ammo_magazine/internal/revolver/m44/marksman

/obj/item/weapon/gun/revolver/m44/custom //loadout
	name = "\improper M44 custom combat revolver"
	desc = "一把笨重的战斗左轮手枪。握把被抛光至珍珠般完美，枪身镀银。发射.44马格南子弹。"
	current_mag = /obj/item/ammo_magazine/internal/revolver/m44
	icon_state = "m44rc"
	item_state = "m44rc"

//----------------------------------------------
// Blade Runner Blasters.
/obj/item/weapon/gun/revolver/m44/custom/pkd_special
	name = "\improper M2019 Blaster"
	desc = "正式名称为Pflager Katsumata D系列爆能手枪，M2019是侦探和银翼杀手使用的手枪遗物，于2019年取代了.38短管侦探特制手枪。发射.44定制包装脱壳马格南子弹。法律上属于左轮手枪，其非传统但坚固的内部设计使该型号在收藏家和爱好者中极受欢迎。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/revolvers.dmi'
	icon_state = "lapd_2019"
	item_state = "highpower" //placeholder

	fire_sound = "gun_pkd"
	fire_rattle = 'sound/weapons/gun_pkd_fire01_rattle.ogg'
	reload_sound = 'sound/weapons/handling/pkd_speed_load.ogg'
	cocked_sound = 'sound/weapons/handling/pkd_cock.wav'
	unload_sound = 'sound/weapons/handling/pkd_open_chamber.ogg'
	chamber_close_sound = 'sound/weapons/handling/pkd_close_chamber.ogg'
	hand_reload_sound = 'sound/weapons/gun_revolver_load3.ogg'
	current_mag = /obj/item/ammo_magazine/internal/revolver/m44/pkd
	accepted_ammo = list(
		/obj/item/ammo_magazine/internal/revolver/m44/pkd,
	)

	attachable_allowed = list(
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under_barrel,
	)

	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/guns.dmi',
		WEAR_J_STORE = 'icons/mob/humans/onmob/clothing/suit_storage/guns_by_type/pistols.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/pistols_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/guns/pistols_righthand.dmi'
	)

/obj/item/weapon/gun/revolver/m44/custom/pkd_special/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 22, "rail_x" = 11, "rail_y" = 25, "under_x" = 20, "under_y" = 18, "stock_x" = 20, "stock_y" = 18)

/obj/item/weapon/gun/revolver/m44/custom/pkd_special/set_gun_config_values()
	..()
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	set_fire_delay(FIRE_DELAY_TIER_11)

/obj/item/weapon/gun/revolver/m44/custom/pkd_special/k2049
	name = "\improper M2049 Blaster"
	desc = "自2049年服役以来，LAPD 2049 .44特制手枪“退役”的复制人比美国走廊的殖民者还多。顶部安装的附件导轨使这个修订版能为有抱负的侦探安装多种光学瞄具。虽然复制人不被允许进入外核心星系之外，但这把枪偶尔会通过缺陷品、收藏家和窃贼之手流落到边缘地带。"
	icon_state = "lapd_2049"
	item_state = "m4a3c" //placeholder

	attachable_allowed = list(
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/alt_iff_scope,
	)

/obj/item/weapon/gun/revolver/m44/custom/pkd_special/k2049/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 22, "rail_x" = 11, "rail_y" = 25, "under_x" = 20, "under_y" = 18, "stock_x" = 20, "stock_y" = 18)

/obj/item/weapon/gun/revolver/m44/custom/pkd_special/l_series
	name = "\improper PKL 'Double' Blaster"
	desc = "出售给平民和私营公司的Pflager Katsumata L系列爆能手枪是一款优质双管手枪，可以同时发射两发子弹。通常见于战斗合成人和复制人手中，这把“手炮”的价值超过三台发射器的总价。最初由华莱士公司委托制造，后来作为奢侈枪械在公开市场发售。"
	icon_state = "pkd_double"
	item_state = "_88m4" //placeholder

	attachable_allowed = list(
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under_barrel,
	)

/obj/item/weapon/gun/revolver/m44/custom/pkd_special/l_series/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 22, "rail_x" = 11, "rail_y" = 25, "under_x" = 20, "under_y" = 18, "stock_x" = 20, "stock_y" = 18)

/obj/item/weapon/gun/revolver/m44/custom/pkd_special/l_series/set_gun_config_values()
	..()
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_2)
	set_burst_delay(FIRE_DELAY_TIER_12)


/obj/item/weapon/gun/revolver/m44/custom/webley
	name = "\improper Webley SRV-80"
	desc = "帝国武装太空军第24伞兵团使用的顶开式左轮手枪，有时也见于其他TWE军事部队手中。发射.455马格南子弹。古老，是的，但极其有效。真空密封的内部结构、胶木风格握把，以及如同被骡子踢了一脚的后坐力。依然能放倒目标。狠狠地放倒。"
	current_mag = /obj/item/ammo_magazine/internal/revolver/webley
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/TWE/revolvers.dmi'
	icon_state = "webley"
	item_state = "m44r"
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/antique,
		/obj/item/attachable/bayonet/custom,
		/obj/item/attachable/bayonet/custom/red,
		/obj/item/attachable/bayonet/custom/blue,
		/obj/item/attachable/bayonet/custom/black,
		/obj/item/attachable/bayonet/tanto,
		/obj/item/attachable/bayonet/tanto/blue,
		/obj/item/attachable/bayonet/rmc_replica,
		/obj/item/attachable/bayonet/rmc,
	)

/obj/item/weapon/gun/revolver/m44/custom/webley/set_gun_config_values()
	..()
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2

/obj/item/weapon/gun/revolver/m44/custom/webley/IASF_webley
	icon_state = "webley_black"
	item_state = "m44r"

//-------------------------------------------------------
//RUSSIAN REVOLVER //Based on the 7.62mm Russian revolvers.

/obj/item/weapon/gun/revolver/upp
	name = "\improper ZHNK-72 revolver"
	desc = "ZHNK-72是一款UPP设计的左轮手枪。ZHNK-72被UPP武装部队用于警务角色，也有少量配发给士官长。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/UPP/revolvers.dmi'
	icon_state = "zhnk72"
	item_state = "zhnk72"

	fire_sound = "gun_pkd" //sounds stolen from bladerunner revolvers bc they aren't used and sound awesome
	fire_rattle = 'sound/weapons/gun_pkd_fire01_rattle.ogg'
	reload_sound = 'sound/weapons/handling/pkd_speed_load.ogg'
	cocked_sound = 'sound/weapons/handling/pkd_cock.wav'
	unload_sound = 'sound/weapons/handling/pkd_open_chamber.ogg'
	chamber_close_sound = 'sound/weapons/handling/pkd_close_chamber.ogg'
	hand_reload_sound = 'sound/weapons/gun_revolver_load3.ogg'
	current_mag = /obj/item/ammo_magazine/internal/revolver/upp
	force = 8
	attachable_allowed = list(
		/obj/item/attachable/reddot, // Rail
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/bayonet, // Muzzle
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/lasersight, // Underbarrel
		/obj/item/attachable/flashlight/under_barrel,
		)

/obj/item/weapon/gun/revolver/upp/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/norcomm)

/obj/item/weapon/gun/revolver/upp/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 21, "rail_x" = 14, "rail_y" = 23, "under_x" = 19, "under_y" = 17, "stock_x" = 24, "stock_y" = 19)

/obj/item/weapon/gun/revolver/upp/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_9)
	accuracy_mult = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_4
	recoil = 0
	recoil_unwielded = 0

/obj/item/weapon/gun/revolver/upp/shrapnel
	current_mag = /obj/item/ammo_magazine/internal/revolver/upp/shrapnel
	random_spawn_chance = 100
	random_under_chance = 100
	random_spawn_under = list(
		/obj/item/attachable/lasersight,
	)

//-------------------------------------------------------
//357 REVOLVER //Based on the generic S&W 357.
//a lean mean machine, pretty inaccurate unless you play its dance.

/obj/item/weapon/gun/revolver/small
	name = "\improper S&W .38 model 37 revolver"
	desc = "一把由史密斯&韦森制造的纤薄.38手枪。永恒的经典，从古代到未来。这款特定型号以极度不准但极其致命而闻名。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/revolvers.dmi'
	icon_state = "sw357"
	item_state = "sw357"
	fire_sound = 'sound/weapons/gun_44mag2.ogg'
	current_mag = /obj/item/ammo_magazine/internal/revolver/small
	force = 6
	flags_gun_features = GUN_ANTIQUE|GUN_ONE_HAND_WIELDED|GUN_CAN_POINTBLANK|GUN_INTERNAL_MAG
	trickster_gun = TRUE

/obj/item/weapon/gun/revolver/small/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 19, "rail_x" = 12, "rail_y" = 21, "under_x" = 20, "under_y" = 15, "stock_x" = 20, "stock_y" = 15)

/obj/item/weapon/gun/revolver/small/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_6)
	accuracy_mult = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_5
	damage_mult = BASE_BULLET_DAMAGE_MULT * 2
	recoil = 0
	recoil_unwielded = 0

/obj/item/weapon/gun/revolver/small/black
	name = "\improper S&W .38 model 37 Custom revolver"
	desc = "一把由史密斯&韦森制造的定制纤薄.38手枪。永恒的经典，从古代到未来。这款特定型号，拥有光滑的黑色枪身和定制的象牙握把，以极度不准但极其致命而闻名。"
	icon_state = "black_sw357"
	item_state = "black_sw357"

//-------------------------------------------------------
//BURST REVOLVER //Mateba(Unica) is pretty well known. The cylinder folds up instead of to the side.

/obj/item/weapon/mateba_key
	name = "独角兽枪管钥匙"
	desc = "用于更换独角兽左轮手枪的枪管。"
	icon = 'icons/obj/items/tools.dmi'
	icon_state = "matebakey"
	flags_atom = FPRINT|QUICK_DRAWABLE|CONDUCT
	force = 5
	w_class = SIZE_TINY
	throwforce = 5
	throw_speed = SPEED_VERY_FAST
	throw_range = 5
	attack_verb = list("stabbed")

/obj/item/weapon/gun/revolver/mateba
	name = "\improper Spearhead Unica 6 autorevolver"
	desc = "矛头独角兽是一款威力强大、射速快的左轮手枪，利用自身后坐力旋转弹巢。发射重型.454子弹。"
	desc_lore = "Originally an Italian design, during the middle 21st century, Mateba company had many severe financial issues as well as violation of local firearm laws. \
	After numerous court cases, they went bankrupt and few years later, Spearhead Armaments acquired the rights to the Mateba designs, and re-introduced the Unica 6 as the 'Spearhead Unica', \
	as well as many other Mateba revolvers. The new design featured a few changes, like rechambered variation for .454 rounds, attachment rail and other attachments support, but overall, design intentionally remained the same, \
	due to the iconic status in pop culture and high demand for the authentic piece. The gun is produced in limited numbers and is considered a luxury firearm, often seen in the hands of high-ranking officers, mercenaries and wealthy collectors, \
	usually comes with authentic wooden grips, engravings, or gold plating finish."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/USCM/revolvers.dmi'
	icon_state = "mateba"
	item_state = "mateba"

	fire_sound = 'sound/weapons/gun_mateba.ogg'
	current_mag = /obj/item/ammo_magazine/internal/revolver/mateba
	force = 15
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/mateba,
		/obj/item/attachable/mateba/long,
		/obj/item/attachable/mateba/short,
	)
	starting_attachment_types = list(/obj/item/attachable/mateba)
	unacidable = TRUE
	explo_proof = TRUE
	black_market_value = 100
	var/is_locked = TRUE
	var/can_change_barrel = TRUE

/obj/item/weapon/gun/revolver/mateba/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/spearhead)

/obj/item/weapon/gun/revolver/mateba/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/mateba_key) && can_change_barrel)
		if(attachments["special"])
			var/obj/item/attachable/R = attachments["special"]
			visible_message(SPAN_NOTICE("[user]开始从[src]上拆卸[R]。"),
			SPAN_NOTICE("You begin stripping [R] from [src]."), null, 4)

			if(!do_after(usr, 35, INTERRUPT_ALL, BUSY_ICON_FRIENDLY))
				return

			if(!(R == attachments[R.slot]))
				return

			visible_message(SPAN_NOTICE("[user]解锁并从[src]上取下[R]。"),
			SPAN_NOTICE("You unlocks removes [R] from [src]."), null, 4)
			R.Detach(user, src)
			if(attachments["muzzle"])
				var/obj/item/attachable/M = attachments["muzzle"]
				M.Detach(user, src)
			playsound(src, 'sound/handling/attachment_remove.ogg', 15, 1, 4)
			update_icon()
	else if(istype(I, /obj/item/attachable))
		var/obj/item/attachable/A = I
		if(A.slot == "muzzle" && !attachments["special"] && can_change_barrel)
			to_chat(user, SPAN_WARNING("你需要先安装枪管！"))
			return
	. = ..()

/obj/item/weapon/gun/revolver/mateba/unique_action(mob/user)
	if(fire_into_air(user))
		return ..()

/obj/item/weapon/gun/revolver/mateba/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 21, "rail_x" = 9, "rail_y" = 25, "under_x" = 19, "under_y" = 17, "stock_x" = 19, "stock_y" = 17, "special_x" = 23, "special_y" = 22)

/obj/item/weapon/gun/revolver/mateba/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_3)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_8)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_2
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_5
	scatter = SCATTER_AMOUNT_TIER_7
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_10
	recoil = RECOIL_AMOUNT_TIER_2
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/revolver/mateba/pmc
	current_mag = /obj/item/ammo_magazine/internal/revolver/mateba/ap

/obj/item/weapon/gun/revolver/mateba/impact
	current_mag = /obj/item/ammo_magazine/internal/revolver/mateba/impact

/obj/item/weapon/gun/revolver/mateba/general
	name = "\improper golden Spearhead Unica-6 autorevolver custom"
	desc = "这款深度定制的独角兽6型自动左轮手枪拥有镀金枪身和由极度濒危红木制成的握把，其矫饰的设计只有其使用者的权力可以匹敌。适合国王。或将军。"
	icon_state = "amateba"
	item_state = "amateba"
	current_mag = /obj/item/ammo_magazine/internal/revolver/mateba/impact
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/mateba/gold,
		/obj/item/attachable/mateba/long/gold,
		/obj/item/attachable/mateba/short/gold,
	)
	starting_attachment_types = null

/obj/item/weapon/gun/revolver/mateba/general/handle_starting_attachment()
	..()
	var/obj/item/attachable/mateba/long/gold/barrel = new(src)
	barrel.flags_attach_features &= ~ATTACH_REMOVABLE
	barrel.Attach(src)
	update_attachables()

/obj/item/weapon/gun/revolver/mateba/general/santa
	name = "\improper Festeba"
	desc = "SANTA本人使用的独角兽手枪。据传装有爆炸性弹药。"
	icon_state = "amateba"
	item_state = "amateba"
	current_mag = /obj/item/ammo_magazine/internal/revolver/mateba/explosive
	color = "#FF0000"
	fire_sound = null
	fire_sounds = list('sound/voice/alien_queen_xmas.ogg', 'sound/voice/alien_queen_xmas_2.ogg')
	starting_attachment_types = list(/obj/item/attachable/heavy_barrel)

/obj/item/weapon/gun/revolver/mateba/engraved
	name = "\improper engraved Spearhead Unica 6 autorevolver"
	desc = "哑光黑色枪身、乌木握把、金边弹巢，这把独角兽手枪既是一件艺术品，也是死亡的使者。"
	icon_state = "aamateba"
	item_state = "aamateba"
	current_mag = /obj/item/ammo_magazine/internal/revolver/mateba/impact

/obj/item/weapon/gun/revolver/mateba/silver
	name = "\improper silver Spearhead Unica 6 autorevolver"
	desc = ".454矛头独角兽6型自动左轮手枪是一款半自动手炮，利用自身后坐力旋转弹巢。极其稀有、价格高昂、威力无匹，仅见于少数USCM高级官员之手。时尚、精致，最重要的是，极其致命。这把采用漂亮的抛光银色涂装。"
	icon_state = "smateba"
	item_state = "smateba"
	current_mag = /obj/item/ammo_magazine/internal/revolver/mateba/impact
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/mateba/silver,
		/obj/item/attachable/mateba/long/silver,
		/obj/item/attachable/mateba/short/silver,
	)

	starting_attachment_types = list(/obj/item/attachable/mateba/silver)

/obj/item/weapon/gun/revolver/mateba/golden
	name = "\improper golden Spearhead Unica 6 autorevolver"
	desc = ".454矛头独角兽6型自动左轮手枪是一款半自动手炮，利用自身后坐力旋转弹巢。极其稀有、价格高昂、威力无匹，仅见于少数USCM高级官员之手。时尚、精致，最重要的是，极其致命。这把采用漂亮的抛光银色涂装。"
	icon_state = "amateba"
	item_state = "amateba"
	current_mag = /obj/item/ammo_magazine/internal/revolver/mateba/impact
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/mateba/gold,
		/obj/item/attachable/mateba/long/gold,
		/obj/item/attachable/mateba/short/gold,
	)

	starting_attachment_types = list(/obj/item/attachable/mateba/gold)

/obj/item/weapon/gun/revolver/mateba/engraved/tactical
	current_mag = /obj/item/ammo_magazine/internal/revolver/mateba
	starting_attachment_types = list(/obj/item/attachable/mateba, /obj/item/attachable/compensator, /obj/item/attachable/reflex)

/obj/item/weapon/gun/revolver/mateba/cmateba
	name = "定制型矛头独角兽6型自动左轮"
	desc = ".454口径矛头独角兽6型自动左轮是一款利用自身后坐力旋转弹巢的半自动手炮。极其稀有、价格高昂且威力惊人，仅见于少数高级USCM官员之手。时尚、精密，最重要的是，极度致命。"
	icon_state = "cmateba"
	item_state = "cmateba"
	current_mag = /obj/item/ammo_magazine/internal/revolver/mateba/impact
	map_specific_decoration = TRUE

/obj/item/weapon/gun/revolver/mateba/special
	name = "特制矛头独角兽6型自动左轮"
	desc = "一支老旧且经过大量改装的矛头独角兽6型自动左轮。它配有光滑的木制握把，枪管也比未改装型号大得多。显然，这把武器得到了长期的精心保养。"
	icon_state = "cmateba_special"
	item_state = "cmateba_special"
	current_mag = /obj/item/ammo_magazine/internal/revolver/mateba/impact
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
	)
	starting_attachment_types = list()
	can_change_barrel = FALSE

/obj/item/weapon/gun/revolver/mateba/special/set_gun_config_values()
	..()
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4

/obj/item/weapon/gun/revolver/mateba/special/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 23, "rail_x" = 9, "rail_y" = 25, "under_x" = 19, "under_y" = 17, "stock_x" = 19, "stock_y" = 17, "special_x" = 23, "special_y" = 22)

/obj/item/weapon/gun/revolver/mateba/mtr6m
	name = "\improper Spearhead 2006M autorevolver"
	desc = "矛头2006M是一款威力强大、射速快的左轮手枪，利用自身后坐力旋转弹巢。发射重型.454子弹。兼容更常见的独角兽6型快速装弹器。"
	desc_lore = "Originally an Italian design, during the middle 21st century, Mateba company had many severe financial issues as well as violation of local firearm laws. \
	After numerous court cases, they went bankrupt and few years later, Spearhead Armaments acquired the rights to the Mateba designs, and re-introduced the 2006M as the 'Spearhead 2006M', \
	as well as many other Mateba revolvers. The new design featured a few changes, like rechambered variation for .454 rounds, attachment rail and other attachments support, but overall, design intentionally remained the same, \
	due to the iconic status in pop culture and high demand for the authentic piece. The gun is produced in limited numbers and is considered a luxury firearm, often seen in the hands of high-ranking officers, mercenaries and wealthy collectors, \
	usually comes with authentic wooden grips, engravings, or gold plating finish."
	icon_state = "mateba_2006m"
	item_state = "mateba_2006m"
	current_mag = /obj/item/ammo_magazine/internal/revolver/mateba/impact
	fire_sound = 'sound/weapons/gun_mateba_2006m.ogg'
	chamber_close_sound = 'sound/weapons/gun_mateba_2006m_close_chamber.ogg'
	unload_sound = 'sound/weapons/gun_mateba_2006m_open_chamber.ogg'
	reload_sound = 'sound/weapons/gun_mateba_2006m_load.ogg'
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
	)
	starting_attachment_types = list()
	can_change_barrel = FALSE
	trickster_gun = TRUE

/obj/item/weapon/gun/revolver/mateba/mtr6m/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 23, "rail_x" = 19, "rail_y" = 23, "under_x" = 19, "under_y" = 17, "stock_x" = 19, "stock_y" = 17, "special_x" = 23, "special_y" = 22)

/obj/item/weapon/gun/revolver/mateba/mtr6m/golden
	name = "\improper golden Spearhead 2006M autorevolver"
	icon_state = "gmateba_2006m"
	item_state = "gmateba_2006m"

/obj/item/weapon/gun/revolver/mateba/mtr6m/golden/black_handle
	icon_state = "bgmateba_2006m"
	item_state = "bgmateba_2006m"

/obj/item/weapon/gun/revolver/mateba/mtr6m/silver
	name = "\improper silver Spearhead 2006M autorevolver"
	icon_state = "smateba_2006m"
	item_state = "smateba_2006m"


//-------------------------------------------------------
//MARSHALS REVOLVER //Spearhead exists in Alien cannon.

/obj/item/weapon/gun/revolver/cmb
	name = "\improper Spearhead Autorevolver"
	desc = "一款发射.357子弹的自动左轮手枪，在飞船上通常装填空尖弹以防止船体损坏。通常配发给殖民地执法官。"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony/revolvers.dmi'
	icon_state = "spearhead"
	item_state = "spearhead"
	fire_sound = null
	fire_sounds = list('sound/weapons/gun_cmb_1.ogg', 'sound/weapons/gun_cmb_2.ogg')
	fire_rattle = 'sound/weapons/gun_cmb_rattle.ogg'
	cylinder_click = list('sound/weapons/handling/gun_cmb_click1.ogg', 'sound/weapons/handling/gun_cmb_click2.ogg')
	current_mag = /obj/item/ammo_magazine/internal/revolver/cmb/hollowpoint
	force = 12
	attachable_allowed = list(
		/obj/item/attachable/suppressor, // Muzzle
		/obj/item/attachable/suppressor/sleek,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/extended_barrel/vented,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot, // Rail
		/obj/item/attachable/reddot/small,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/gyro, // Under
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under_barrel,
	)

/obj/item/weapon/gun/revolver/cmb/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/corp_label/spearhead)

/obj/item/weapon/gun/revolver/cmb/click_empty(mob/user)
	if(user)
		to_chat(user, SPAN_WARNING("<b>*咔哒*</b>"))
		playsound(user, pick('sound/weapons/handling/gun_cmb_click1.ogg', 'sound/weapons/handling/gun_cmb_click2.ogg'), 25, 1, 5) //5 tile range
	else
		playsound(src, pick('sound/weapons/handling/gun_cmb_click1.ogg', 'sound/weapons/handling/gun_cmb_click2.ogg'), 25, 1, 5)

/obj/item/weapon/gun/revolver/cmb/Fire(atom/target, mob/living/user, params, reflex = 0, dual_wield)
	playsound('sound/weapons/gun_cmb_bass.ogg') // badass shooting bass
	return ..()

/obj/item/weapon/gun/revolver/cmb/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 19, "rail_x" = 11, "rail_y" = 23, "under_x" = 22, "under_y" = 16, "stock_x" = 20, "stock_y" = 18)

/obj/item/weapon/gun/revolver/cmb/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_6)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	scatter = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_5
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_3
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_3

/obj/item/weapon/gun/revolver/cmb/tactical
	starting_attachment_types = list(/obj/item/attachable/extended_barrel, /obj/item/attachable/lasersight, /obj/item/attachable/reflex)

/obj/item/weapon/gun/revolver/cmb/normalpoint
	current_mag = /obj/item/ammo_magazine/internal/revolver/cmb

/obj/item/weapon/gun/revolver/cmb/custom
	name = "\improper Spearhead custom autorevolver"
	desc = "一款发射.357子弹的自动左轮手枪，由深色金属定制而成，配有木制握把，显然是专为有品位的人士打造。"
	icon_state = "black_spearhead"
	item_state = "black_spearhead"
	current_mag = /obj/item/ammo_magazine/internal/revolver/cmb
	trickster_gun = TRUE

/obj/item/weapon/gun/revolver/cmb/custom/tactical
	starting_attachment_types = list(/obj/item/attachable/extended_barrel, /obj/item/attachable/lasersight, /obj/item/attachable/reflex)
