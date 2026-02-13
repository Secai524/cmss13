/obj/item/storage/pouch
	name = "抽象收纳袋"
	desc = "一个收纳袋概念的物理实体。哇哦。"
	icon = 'icons/obj/items/clothing/pouches.dmi'
	icon_state = "small_drop"
	w_class = SIZE_LARGE //does not fit in backpack
	max_w_class = SIZE_SMALL
	flags_equip_slot = SLOT_STORE
	storage_slots = 1
	storage_flags = STORAGE_FLAGS_POUCH
	cant_hold = list(/obj/item/weapon/throwing_knife)
	///If it closes a flap over its contents, and therefore update_icon should lift that flap when opened. If it doesn't have _half and _full iconstates, this doesn't matter either way.
	var/flap = TRUE

/obj/item/storage/pouch/update_icon()
	overlays.Cut()
	if(!length(contents))
		return TRUE //For the pistol pouch to know it's empty.
	if(content_watchers && flap) //If it has a flap and someone's looking inside it, don't close the flap.
		return

	if(isnull(storage_slots))//uses weight instead of slots
		var/fullness = 0
		for(var/obj/item/C as anything in contents)
			fullness += C.w_class
		if(fullness <= max_storage_space * 0.5)
			overlays += "+[icon_state]_half"
		else
			overlays += "+[icon_state]_full"
		return

	else if(length(contents) <= storage_slots * 0.5)
		overlays += "+[icon_state]_half"
	else
		overlays += "+[icon_state]_full"


/obj/item/storage/pouch/get_examine_text(mob/user)
	. = ..()
	. += "Can be worn by attaching it to a pocket."


/obj/item/storage/pouch/equipped(mob/user, slot)
	if(slot == WEAR_L_STORE || slot == WEAR_R_STORE)
		mouse_opacity = MOUSE_OPACITY_OPAQUE //so it's easier to click when properly equipped.
	..()

/obj/item/storage/pouch/dropped(mob/user)
	mouse_opacity = initial(mouse_opacity)
	..()


/obj/item/storage/pouch/general
	name = "轻型通用收纳袋"
	desc = "一种通用收纳袋，用于携带一个小型物品，或两个微型物品。"
	icon_state = "small_drop"
	storage_flags = STORAGE_FLAGS_DEFAULT
	max_w_class = SIZE_MEDIUM
	cant_hold = list( //Prevent inventory bloat
		/obj/item/storage/firstaid,
		/obj/item/storage/toolkit,
		/obj/item/storage/bible,
		/obj/item/storage/box,
	)
	storage_slots = null
	max_storage_space = 2

/obj/item/storage/pouch/general/medium
	name = "中型通用收纳袋"
	desc = "一种通用收纳袋，用于携带各种不同尺寸的物品。"
	icon_state = "medium_drop"
	storage_slots = null
	max_storage_space = 4

/obj/item/storage/pouch/general/large
	name = "大型通用收纳袋"
	desc = "一种通用收纳袋，用于携带更多不同尺寸的物品。"
	icon_state = "large_drop"
	storage_slots = null
	max_storage_space = 6

/obj/item/storage/pouch/flamertank
	name = "燃料罐绑带收纳袋"
	desc = "两条环形带，用于固定M240型凝固汽油弹罐。小心处理。"
	storage_slots = 2
	icon_state = "fueltank_pouch"
	storage_flags = STORAGE_FLAGS_POUCH
	can_hold = list(
		/obj/item/ammo_magazine/flamer_tank,
		/obj/item/tool/extinguisher,
	)
	bypass_w_limit = list(
		/obj/item/ammo_magazine/flamer_tank,
		/obj/item/tool/extinguisher,
	)

/obj/item/storage/pouch/general/large/m39ap
	storage_slots = 1

/obj/item/storage/pouch/general/large/m39ap/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/smg/m39/ap(src)

/obj/item/storage/pouch/bayonet
	name = "刺刀鞘"
	desc = "刀锋相见！"
	can_hold = list(
		/obj/item/weapon/throwing_knife,
		/obj/item/attachable/bayonet,
	)
	cant_hold = list()
	icon_state = "bayonet"
	storage_slots = 5
	storage_flags = STORAGE_FLAGS_POUCH|STORAGE_USING_DRAWING_METHOD|STORAGE_ALLOW_QUICKDRAW
	var/default_knife_type = /obj/item/weapon/throwing_knife

	COOLDOWN_DECLARE(draw_cooldown)

/obj/item/storage/pouch/bayonet/Initialize()
	. = ..()
	for(var/total_storage_slots in 1 to storage_slots)
		new default_knife_type(src)

/obj/item/storage/pouch/bayonet/upp
	default_knife_type = /obj/item/attachable/bayonet/upp

/obj/item/storage/pouch/bayonet/_item_insertion(obj/item/W, prevent_warning = 0)
	..()
	playsound(src, 'sound/weapons/gun_shotgun_shell_insert.ogg', 15, TRUE)

/obj/item/storage/pouch/bayonet/_item_removal(obj/item/W, atom/new_location)
	..()
	playsound(src, 'sound/weapons/gun_shotgun_shell_insert.ogg', 15, TRUE)

/obj/item/storage/pouch/bayonet/attack_hand(mob/user, mods)
	if(COOLDOWN_FINISHED(src, draw_cooldown))
		..()
		COOLDOWN_START(src, draw_cooldown, BAYONET_DRAW_DELAY)
		playsound(src, 'sound/weapons/gun_shotgun_shell_insert.ogg', 15, TRUE)
	else
		to_chat(user, SPAN_WARNING("你需要等待片刻才能拔出另一把刀！"))
		return 0

/obj/item/storage/pouch/survival
	name = "生存挎包"
	desc = "在紧急情况下分发给殖民者的挎包。"
	icon_state = "tools"
	storage_slots = 7
	max_w_class = SIZE_MEDIUM
	can_hold = list(
		/obj/item/device/flashlight/lantern,
		/obj/item/tool/crowbar,
		/obj/item/storage/pill_bottle/packet,
		/obj/item/stack/medical/bruise_pack,
		/obj/item/device/radio,
		/obj/item/attachable/bayonet,
		/obj/item/stack/medical/splint,
	)

/obj/item/storage/pouch/survival/full/fill_preset_inventory()
	new /obj/item/device/flashlight/lantern(src)
	new /obj/item/tool/crowbar/red(src)
	new /obj/item/storage/pill_bottle/packet/tricordrazine(src)
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/device/radio(src)
	new /obj/item/attachable/bayonet(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/pouch/survival/black
	icon_state = "soctools"

/obj/item/storage/pouch/survival/full/black
	icon_state = "soctools"

/obj/item/storage/pouch/survival/full/wy
	icon_state = "soctools"

/obj/item/storage/pouch/survival/full/wy/fill_preset_inventory()
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/tool/crowbar/tactical(src)
	new /obj/item/storage/pill_bottle/packet/tricordrazine(src)
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/device/radio(src)
	new /obj/item/attachable/bayonet/wy(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/pouch/survival/synth
	name = "合成人生存挎包"
	desc = "在紧急情况下分发给合成人的应急挎包。"
	icon_state = "tools"
	storage_slots = 6
	max_w_class = SIZE_MEDIUM
	can_hold = list(
		/obj/item/device/flashlight,
		/obj/item/tool/crowbar,
		/obj/item/tool/weldingtool,
		/obj/item/stack/cable_coil,
		/obj/item/stack/sheet/metal,
		/obj/item/device/radio,
		/obj/item/attachable/bayonet,
	)

/obj/item/storage/pouch/survival/synth/full/fill_preset_inventory()
	new /obj/item/tool/crowbar/red(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/stack/sheet/metal/large_stack(src)
	new /obj/item/device/radio(src)
	new /obj/item/attachable/bayonet(src)

/obj/item/storage/pouch/survival/synth/black
	icon_state = "soctools"

/obj/item/storage/pouch/survival/synth/black/full/fill_preset_inventory()
	new /obj/item/tool/crowbar/red(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/stack/sheet/metal/large_stack(src)
	new /obj/item/device/radio(src)
	new /obj/item/attachable/bayonet(src)

/obj/item/storage/pouch/firstaid
	name = "急救挎包"
	desc = "一个小挎包，可容纳基本医疗设备，如自动注射器和绷带。"
	icon_state = "firstaid"
	storage_slots = 4
	can_hold = list(
		/obj/item/stack/medical/ointment,
		/obj/item/reagent_container/hypospray/autoinjector,
		/obj/item/storage/pill_bottle/packet,
		/obj/item/stack/medical/bruise_pack,
		/obj/item/stack/medical/splint,
	)

/obj/item/storage/pouch/firstaid/wy
	icon_state = "wy_firstaid"

/obj/item/storage/pouch/firstaid/full
	desc = "包含多种自动注射器，用于快速处理伤势。"

/obj/item/storage/pouch/firstaid/full/fill_preset_inventory()
	new /obj/item/reagent_container/hypospray/autoinjector/bicaridine(src)
	new /obj/item/reagent_container/hypospray/autoinjector/kelotane(src)
	new /obj/item/reagent_container/hypospray/autoinjector/tramadol(src)
	new /obj/item/reagent_container/hypospray/autoinjector/emergency(src)

/obj/item/storage/pouch/firstaid/full/black
	icon_state = "wy_firstaid"

/obj/item/storage/pouch/firstaid/full/alternate
	desc = "包含急救自动注射器、绷带、药膏和夹板。"

/obj/item/storage/pouch/firstaid/full/alternate/wy
	name = "维兰德急救挎包"
	icon_state = "wy_firstaid"

/obj/item/storage/pouch/firstaid/full/alternate/fill_preset_inventory()
	new /obj/item/reagent_container/hypospray/autoinjector/tricord(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/stack/medical/bruise_pack(src)

/obj/item/storage/pouch/firstaid/full/alternate/wy
	icon_state = "wy_firstaid"

/obj/item/storage/pouch/firstaid/full/pills
	desc = "包含多种药片包，用于治疗多种伤势。"

/obj/item/storage/pouch/firstaid/full/pills/wy
	name = "维兰德急救挎包"
	icon_state = "wy_firstaid"

/obj/item/storage/pouch/firstaid/full/pills/fill_preset_inventory()
	new /obj/item/storage/pill_bottle/packet/bicaridine(src)
	new /obj/item/storage/pill_bottle/packet/kelotane(src)
	new /obj/item/storage/pill_bottle/packet/tramadol(src)
	new /obj/item/storage/pill_bottle/packet/tramadol(src)

/obj/item/storage/pouch/firstaid/full/pills/wy
	icon_state = "wy_firstaid"

/obj/item/storage/pouch/firstaid/hunted
	name = "旧挎包"
	desc = "一种通用挎包，用于携带必要的生存物品。"
	icon_state = "survival"
	storage_slots = 5
	can_hold = list(
		/obj/item/reagent_container/pill,
		/obj/item/stack/medical/advanced/bruise_pack/predator,
		/obj/item/stack/medical/advanced/ointment/predator,
		/obj/item/stack/medical/splint,
	)

/obj/item/storage/pouch/firstaid/hunted/fill_preset_inventory()
	new /obj/item/stack/medical/advanced/bruise_pack/predator(src)
	new /obj/item/stack/medical/advanced/ointment/predator(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/reagent_container/pill/oxycodone/natural(src)
	new /obj/item/reagent_container/pill/bicaridine/natural(src)

/obj/item/storage/pouch/firstaid/ert
	desc = "可容纳自动注射器、药膏和绷带。这个里面还有些额外的东西。"
	icon_state = "firstaid"
	storage_slots = 5

/obj/item/storage/pouch/firstaid/ert/fill_preset_inventory()
	new /obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless(src)
	new /obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless(src)
	new /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless(src)
	new /obj/item/reagent_container/hypospray/autoinjector/emergency(src)
	new /obj/item/stack/medical/bruise_pack(src)

/obj/item/storage/pouch/firstaid/ert/wy
	icon_state = "wy_firstaid"

///Pistol pouch.
/obj/item/storage/pouch/pistol
	name = "副武器挎包"
	desc = "你可以用这个装手枪；更重要的是，你可以快速拔枪。适用于紧急情况。"
	icon_state = "pistol"
	use_sound = null
	max_w_class = SIZE_MEDIUM
	can_hold = list(/obj/item/weapon/gun/pistol, /obj/item/weapon/gun/revolver,/obj/item/weapon/gun/flare)
	storage_flags = STORAGE_FLAGS_POUCH|STORAGE_USING_DRAWING_METHOD|STORAGE_ALLOW_QUICKDRAW
	flap = FALSE

	///Display code pulled from belt.dm gun belt. Can shave quite a lot off because this pouch can only hold one item at a time.
	var/obj/item/weapon/gun/current_gun //The gun it holds, used for referencing later so we can update the icon.
	var/image/gun_underlay //The underlay we will use.
	var/sheatheSound = 'sound/weapons/gun_pistol_sheathe.ogg'
	var/drawSound = 'sound/weapons/gun_pistol_draw.ogg'
	var/icon_x = 0
	var/icon_y = -3

/obj/item/storage/pouch/pistol/Destroy()
	gun_underlay = null
	current_gun = null
	. = ..()

/obj/item/storage/pouch/pistol/on_stored_atom_del(atom/movable/AM)
	if(AM == current_gun)
		current_gun = null
		update_gun_icon()

/obj/item/storage/pouch/pistol/can_be_inserted(obj/item/W, mob/user, stop_messages = FALSE) //A little more detailed than just 'the pouch is full'.
	. = ..()
	if(!.)
		return
	if(current_gun && isgun(W))
		if(!stop_messages)
			to_chat(usr, SPAN_WARNING("[src]已经持有一把枪。"))
		return FALSE

/obj/item/storage/pouch/pistol/_item_insertion(obj/item/I, prevent_warning = 0, mob/user)
	if(isgun(I))
		current_gun = I
		update_gun_icon()
	..()

/obj/item/storage/pouch/pistol/_item_removal(obj/item/I, atom/new_location)
	if(I == current_gun)
		current_gun = null
		update_gun_icon()
	..()

/obj/item/storage/pouch/pistol/proc/update_gun_icon()
	if(current_gun)
		playsound(src, drawSound, 15, TRUE)
		gun_underlay = image('icons/obj/items/clothing/belts/holstered_guns.dmi', current_gun.base_gun_icon)
		gun_underlay.pixel_x = icon_x
		gun_underlay.pixel_y = icon_y
		gun_underlay.color = current_gun.color
		underlays += gun_underlay
	else
		playsound(src, sheatheSound, 15, TRUE)
		underlays -= gun_underlay
		gun_underlay = null

///CO pouch. This pouch can hold only 1 of each type of item: 1 sidearm, 1 pair of binoculars, 1 CO tablet
/obj/item/storage/pouch/pistol/command
	name = "指挥挎包"
	desc = "一种专门、坚固的挎包，配发给指挥官。可容纳其副武器、指挥平板电脑和一副望远镜。"
	storage_slots = 3
	icon_state = "command_pouch"
	can_hold = list(
		/obj/item/weapon/gun/revolver,
		/obj/item/weapon/gun/pistol,
		/obj/item/device/binoculars,
		/obj/item/device/cotablet,
	)

	var/obj/item/device/binoculars/binos
	var/obj/item/device/cotablet/tablet
	icon_x = -6
	icon_y = 0

/obj/item/storage/pouch/pistol/command/Destroy()
	binos = null
	tablet = null
	. = ..()

/obj/item/storage/pouch/pistol/command/on_stored_atom_del(atom/movable/AM)
	..()
	if(AM == binos)
		binos = null
	else if(AM == tablet)
		tablet = null

/obj/item/storage/pouch/pistol/command/can_be_inserted(obj/item/I, mob/user, stop_messages = FALSE)
	. = ..()
	if(!.)
		return
	if(binos && istype(I, /obj/item/device/binoculars))
		if(!stop_messages)
			to_chat(usr, SPAN_WARNING("[src]已经装有一副望远镜。"))
		return FALSE
	else if(tablet && istype(I, /obj/item/device/cotablet))
		if(!stop_messages)
			to_chat(usr, SPAN_WARNING("[src]已经装有一台平板电脑。"))
		return FALSE

/obj/item/storage/pouch/pistol/command/_item_insertion(obj/item/I, prevent_warning = 0, mob/user)
	if(istype(I, /obj/item/device/binoculars))
		binos = I
	else if(istype(I, /obj/item/device/cotablet))
		tablet = I
	..()

/obj/item/storage/pouch/pistol/command/_item_removal(obj/item/I, atom/new_location)
	if(I == binos)
		binos = null
	else if(I == tablet)
		tablet = null
	..()

/obj/item/storage/pouch/pistol/command/update_icon()
	overlays.Cut()
	if(!length(contents))
		return
	if(content_watchers) //Opened flaps.
		if(binos)
			overlays += "+command_pouch_binos"
		if(tablet)
			overlays += "+command_pouch_tablet"
	else
		if(binos)
			overlays += "+command_pouch_binos_flap"
		if(tablet)
			overlays += "+command_pouch_tablet_flap"

/obj/item/storage/pouch/pistol/command/attack_hand(mob/user, mods) //Mostly copied from gunbelt.
	if(current_gun && ishuman(user) && loc == user)
		if(mods && mods[ALT_CLICK] && length(contents) > 1) //Withdraw the most recently inserted nongun item if possible.
			var/obj/item/I = contents[length(contents)]
			if(isgun(I))
				I = contents[length(contents) - 1]
			I.attack_hand(user)
		else
			current_gun.attack_hand(user)
		return
	..()

//// MAGAZINE POUCHES /////

/obj/item/storage/pouch/magazine
	name = "弹匣包"
	desc = "可携带弹匣。"
	icon_state = "medium_ammo_mag"
	max_w_class = SIZE_MEDIUM
	storage_slots = 3
	bypass_w_limit = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg/m39,
	)
	can_hold = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/m60,
		/obj/item/ammo_magazine/handful,
	)

/obj/item/storage/pouch/magazine/wy
	icon_state = "wy_ammo_mag_small"

/obj/item/storage/pouch/magazine/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/ammo_magazine/shotgun))
		var/obj/item/ammo_magazine/shotgun/M = W
		if(istype(src, /obj/item/storage/pouch/magazine/pistol))
			return..()
		else
			dump_ammo_to(M,user, M.transfer_handful_amount)
	else
		return ..()

/obj/item/storage/pouch/magazine/large
	name = "大型弹匣包"
	desc = "可容纳多个弹匣。"
	icon_state = "large_ammo_mag"
	storage_slots = 4

/obj/item/storage/pouch/magazine/large/black //evil dark pouch for evil corporation
	icon_state = "wy_ammo_mag"

/obj/item/storage/pouch/magazine/pistol
	name = "手枪弹匣包"
	desc = "可容纳手枪弹匣和左轮手枪快速装弹器。"
	max_w_class = SIZE_SMALL
	icon_state = "pistol_mag"
	storage_slots = 4

	can_hold = list(
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/pistol/heavy,
		/obj/item/ammo_magazine/revolver,
	)

/obj/item/storage/pouch/magazine/pistol/large
	name = "大型手枪弹匣包"
	desc = "可容纳多个手枪弹匣或左轮手枪快速装弹器。"
	storage_slots = 6
	icon_state = "large_pistol_mag"

/obj/item/storage/pouch/magazine/pistol/large/mateba/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/revolver/mateba(src)

/obj/item/storage/pouch/magazine/pistol/large/mateba/impact/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/revolver/mateba/highimpact(src)

/obj/item/storage/pouch/magazine/pistol/large/vp78/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/pistol/vp78(src)

/obj/item/storage/pouch/magazine/pulse_rifle/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle(src)

/obj/item/storage/pouch/magazine/pistol/pmc_mateba/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/revolver/mateba/highimpact/ap(src)

/obj/item/storage/pouch/magazine/pistol/pmc_mod88/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/pistol/mod88(src)

/obj/item/storage/pouch/magazine/pistol/pmc_vp78/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/pistol/vp78(src)

/obj/item/storage/pouch/magazine/pistol/m1911/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/pistol/m1911(src)

/obj/item/storage/pouch/magazine/upp/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/type71(src)

/obj/item/storage/pouch/magazine/large/upp/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/type71(src)

/obj/item/storage/pouch/magazine/large/wy
	icon_state = "wy_ammo_mag"

/obj/item/storage/pouch/magazine/large/wy/pmc_m39/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/smg/m39/ap(src)

/obj/item/storage/pouch/magazine/large/wy/nsg_ap/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/nsg23/ap(src)

/obj/item/storage/pouch/magazine/large/wy/nsg_ext/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/nsg23/extended(src)

/obj/item/storage/pouch/magazine/large/wy/nsg_heap/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/nsg23/heap(src)

/obj/item/storage/pouch/magazine/large/wy/pmc_p90/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/smg/fp9000(src)

/obj/item/storage/pouch/magazine/large/wy/pmc_lmg/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/lmg(src)

/obj/item/storage/pouch/magazine/large/wy/pmc_sniper/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/sniper/elite(src)

/obj/item/storage/pouch/magazine/large/wy/pmc_rifle/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/ap(src)

/obj/item/storage/pouch/magazine/large/wy/smg_heap/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/smg/m39/heap(src)

/obj/item/storage/pouch/magazine/large/pmc_sg
	name = "智能枪弹鼓包"
	desc = "一个重型弹包，用于携带大量智能枪弹鼓。"
	icon_state = "wy_sgdrums_ammo"
	storage_slots = 3
	can_hold = list(
		/obj/item/ammo_magazine/smartgun,
	)

/obj/item/storage/pouch/magazine/large/pmc_sg/full/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/smartgun(src)

/obj/item/storage/pouch/magazine/large/pmc_sg/commando/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/smartgun/dirty(src)

/obj/item/storage/pouch/magazine/large/pmc_sg/marsoc
	icon_state = "socdrums"

/obj/item/storage/pouch/magazine/large/pmc_sg/marsoc/full/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/smartgun/heap(src)

/obj/item/storage/pouch/magazine/large/pmc_sg/marsoc/full_low_threat/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/smartgun(src)

/obj/item/storage/pouch/magazine/large/m16/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/m16(src)

/obj/item/storage/pouch/magazine/large/m16/ap/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/m16/ap(src)

/obj/item/storage/pouch/magazine/large/m16/ap/black
	icon_state = "wy_ammo_mag"

/obj/item/storage/pouch/magazine/large/rifle_heap
	icon_state = "wy_ammo_mag"

/obj/item/storage/pouch/magazine/large/rifle_heap/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/rifle/heap(src)

/obj/item/storage/pouch/magazine/large/m60/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/m60(src)

/obj/item/storage/pouch/shotgun
	name = "霰弹枪弹壳包"
	desc = "可容纳数把弹壳，或者如果你出于某种原因选择的话，也可以装子弹。"
	icon_state = "medium_shotshells"
	max_w_class = SIZE_SMALL
	storage_slots = 5
	bypass_w_limit = list()
	can_hold = list(
		/obj/item/ammo_magazine/handful,
	)
	flap = FALSE

/obj/item/storage/pouch/shotgun/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/ammo_magazine/shotgun))
		var/obj/item/ammo_magazine/shotgun/M = W
		dump_ammo_to(M, user, M.transfer_handful_amount)
	else
		return ..()

/obj/item/storage/pouch/shotgun/heavybuck/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/heavy/buckshot(src)

/obj/item/storage/pouch/shotgun/heavyslug/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/heavy/slug(src)

/obj/item/storage/pouch/shotgun/heavyflechette/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/heavy/flechette(src)

/obj/item/storage/pouch/shotgun/large
	name = "大型霰弹枪弹壳包"
	desc = "可容纳更多把弹壳，或者如果你出于某种原因选择的话，也可以装子弹。"
	icon_state = "large_shotshells"
	storage_slots = 7

/obj/item/storage/pouch/shotgun/large/beanbag/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/beanbag(src)

/obj/item/storage/pouch/shotgun/large/beanbag/riot/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/beanbag/riot(src)

/obj/item/storage/pouch/shotgun/large/slug/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/slug(src)

/obj/item/storage/pouch/shotgun/large/buckshot/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/buckshot(src)

/obj/item/storage/pouch/explosive
	name = "爆炸物包"
	desc = "可携带手榴弹、塑胶炸药、地雷箱及其他爆炸物。"
	icon_state = "large_explosive"
	storage_slots = 6
	max_w_class = SIZE_MEDIUM
	can_hold = list(
		/obj/item/explosive/plastic,
		/obj/item/explosive/mine,
		/obj/item/explosive/grenade,
	)

/obj/item/storage/pouch/explosive/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/storage/box/nade_box))
		var/obj/item/storage/box/nade_box/M = W
		dump_into(M,user)
	else
		return ..()

/obj/item/storage/pouch/explosive/full/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/explosive/grenade/high_explosive(src)

/obj/item/storage/pouch/explosive/upp/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/explosive/grenade/high_explosive/upp(src)

/obj/item/storage/pouch/explosive/C4/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/explosive/plastic(src)

/obj/item/storage/pouch/explosive/emp_dutch/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/explosive/grenade/empgrenade/dutch(src)

/obj/item/storage/pouch/medical
	name = "医疗包"
	desc = "可携带小型医疗用品。"
	icon_state = "medical"
	storage_slots = 4

	can_hold = list(
		/obj/item/device/healthanalyzer,
		/obj/item/reagent_container/dropper,
		/obj/item/reagent_container/pill,
		/obj/item/reagent_container/glass/bottle,
		/obj/item/reagent_container/syringe,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/device/flashlight/pen,
		/obj/item/reagent_container/hypospray,
		/obj/item/tool/extinguisher/mini,
		/obj/item/storage/syringe_case,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/tool/surgery/synthgraft,
	)
	instant_pill_grabbable = TRUE // If TRUE, pills can be taken directly from bottles while in hand/equipped.

/obj/item/storage/pouch/medical/full/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)

/obj/item/storage/pouch/medical/full/pills/fill_preset_inventory()
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/dexalin(src)

/obj/item/storage/pouch/medical/socmed
	name = "战术医疗包"
	desc = "一个重型医疗包，内含让伤员重新站起来所需的一切物品。种类相当齐全。"
	icon_state = "socmed"
	storage_slots = 13
	can_hold = list(
		/obj/item/stack/medical,
		/obj/item/storage/pill_bottle,
		/obj/item/device/healthanalyzer,
		/obj/item/reagent_container/hypospray,
		/obj/item/tool/extinguisher/mini,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/tool/surgery/synthgraft,
	)

/obj/item/storage/pouch/medical/socmed/full/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/stack/medical/splint/nano(src)
	new /obj/item/stack/medical/advanced/bruise_pack/upgraded(src)
	new /obj/item/stack/medical/advanced/ointment/upgraded(src)
	new /obj/item/reagent_container/hypospray/autoinjector/bicaridine(src)
	new /obj/item/reagent_container/hypospray/autoinjector/kelotane(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/reagent_container/hypospray/autoinjector/emergency(src)
	new /obj/item/reagent_container/hypospray/autoinjector/emergency(src)
	new /obj/item/tool/extinguisher/mini(src)
	new /obj/item/reagent_container/hypospray/autoinjector/stimulant/brain_stimulant(src)
	new /obj/item/reagent_container/hypospray/autoinjector/stimulant/redemption_stimulant(src)
	new /obj/item/reagent_container/hypospray/autoinjector/stimulant/speed_stimulant(src)

/obj/item/storage/pouch/medical/socmed/commando/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/stack/medical/splint/nano(src)
	new /obj/item/stack/medical/advanced/bruise_pack/upgraded(src)
	new /obj/item/stack/medical/advanced/bruise_pack/upgraded(src)
	new /obj/item/stack/medical/advanced/ointment/upgraded(src)
	new /obj/item/stack/medical/advanced/ointment/upgraded(src)
	new /obj/item/reagent_container/hypospray/autoinjector/bicaridine(src)
	new /obj/item/reagent_container/hypospray/autoinjector/meralyne(src)
	new /obj/item/reagent_container/hypospray/autoinjector/kelotane(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dermaline(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/reagent_container/hypospray/autoinjector/tricord(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dexalinp(src)

/obj/item/storage/pouch/medical/socmed/commando/deathsquad/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/stack/medical/splint/nano(src)
	new /obj/item/stack/medical/advanced/bruise_pack/upgraded(src)
	new /obj/item/stack/medical/advanced/bruise_pack/upgraded(src)
	new /obj/item/stack/medical/advanced/ointment/upgraded(src)
	new /obj/item/stack/medical/advanced/ointment/upgraded(src)
	new /obj/item/reagent_container/hypospray/autoinjector/meralyne(src)
	new /obj/item/reagent_container/hypospray/autoinjector/dermaline(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/reagent_container/hypospray/autoinjector/tricord(src)
	new /obj/item/reagent_container/hypospray/autoinjector/stimulant/speed_stimulant(src)
	new /obj/item/reagent_container/hypospray/autoinjector/stimulant/brain_stimulant(src)
	new /obj/item/reagent_container/hypospray/autoinjector/stimulant/redemption_stimulant(src)

/obj/item/storage/pouch/medical/socmed/not_op/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/reagent_container/hypospray/autoinjector/bicaridine(src)
	new /obj/item/reagent_container/hypospray/autoinjector/kelotane(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/reagent_container/hypospray/autoinjector/emergency(src)
	new /obj/item/reagent_container/hypospray/autoinjector/emergency(src)
	new /obj/item/tool/extinguisher/mini(src)

/obj/item/storage/pouch/medical/socmed/dutch
	name = "\improper Dutch's Medical Pouch"
	desc = "这是荷兰人几年前从黑市商人那里买来的一个包。据传是从USCM的秘密资产中偷来的。多年来，其中的物品已被慢慢用掉并替换。"

/obj/item/storage/pouch/medical/socmed/dutch/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/reagent_container/hypospray/autoinjector/emergency(src)
	new /obj/item/tool/extinguisher/mini(src)

/obj/item/storage/pouch/medical/socmed/dutch/unmarked
	name = "战术医疗包"
	desc = "一个重型医疗包，内含让伤员重新站起来所需的一切物品。种类相当齐全。不知何故，整个包看起来都像是机密物品，你感觉光是看着它都可能被送上军事法庭。"

/obj/item/storage/pouch/first_responder
	name = "急救员包"
	desc = "专为携带补给品而设计的包，用于协助医疗人员并快速应对战场上的伤情，而非立即治疗。可容纳诸如担架床、静滞袋和健康分析仪等物资。"
	icon_state = "frt_med"
	storage_slots = 4

	can_hold = list(
		/obj/item/device/healthanalyzer,
		/obj/item/reagent_container/pill,
		/obj/item/reagent_container/syringe,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/reagent_container/hypospray,
		/obj/item/tool/extinguisher/mini,
		/obj/item/roller,
		/obj/item/bodybag,
	)
	instant_pill_grabbable = TRUE // If TRUE, pills can be taken directly from bottles while in hand/equipped.

/obj/item/storage/pouch/first_responder/full/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/roller(src)
	new /obj/item/tool/extinguisher/mini(src)
	new /obj/item/bodybag/cryobag(src)


/obj/item/storage/pouch/vials
	name = "小瓶包"
	desc = "用于携带玻璃小瓶的包。"
	icon_state = "vial"
	storage_slots = 6
	can_hold = list(/obj/item/reagent_container/glass/beaker/vial)

/obj/item/storage/pouch/vials/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/storage/fancy/vials))
		var/obj/item/storage/fancy/vials/M = W
		dump_into(M,user)
	else
		return ..()

/obj/item/storage/pouch/vials/full/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/reagent_container/glass/beaker/vial(src)

/obj/item/storage/pouch/chem
	name = "化学包"
	desc = "用于携带玻璃烧杯的包。"
	icon_state = "chemist"
	storage_slots = 2
	can_hold = list(
		/obj/item/reagent_container/glass/beaker,
		/obj/item/reagent_container/glass/bottle,
	)

/obj/item/storage/pouch/chem/fill_preset_inventory()
	new /obj/item/reagent_container/glass/beaker/large(src)
	new /obj/item/reagent_container/glass/beaker(src)

/obj/item/storage/pouch/autoinjector
	name = "自动注射器包"
	desc = "专为存放自动注射器设计的包。"
	icon_state = "injectors"
	storage_slots = 7
	can_hold = list(/obj/item/reagent_container/hypospray/autoinjector)

/obj/item/storage/pouch/autoinjector/full/fill_preset_inventory()
	new /obj/item/reagent_container/hypospray/autoinjector/bicaridine(src)
	new /obj/item/reagent_container/hypospray/autoinjector/bicaridine(src)
	new /obj/item/reagent_container/hypospray/autoinjector/kelotane(src)
	new /obj/item/reagent_container/hypospray/autoinjector/kelotane(src)
	new /obj/item/reagent_container/hypospray/autoinjector/tramadol(src)
	new /obj/item/reagent_container/hypospray/autoinjector/tramadol(src)
	new /obj/item/reagent_container/hypospray/autoinjector/emergency(src)

/obj/item/storage/pouch/autoinjector/full/wy
	icon_state = "wy_medicpack"

/obj/item/storage/pouch/syringe
	name = "注射器包"
	desc = "可携带注射器。"
	icon_state = "syringe"
	storage_slots = 6
	can_hold = list(/obj/item/reagent_container/syringe)

/obj/item/storage/pouch/syringe/full/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/reagent_container/syringe(src)

/obj/item/storage/pouch/engikit
	name = "工程师工具包"
	storage_flags = STORAGE_FLAGS_POUCH
	icon_state = "construction"
	desc = "专为存放工程部物品设计。需要工程技能才能有效使用。"
	storage_slots = 6
	can_hold_skill = list(
		/obj/item/circuitboard = list(SKILL_ENGINEER, SKILL_ENGINEER_TRAINED),
		/obj/item/device/flashlight = list(SKILL_ENGINEER, SKILL_ENGINEER_TRAINED),
		/obj/item/clothing/glasses/welding = list(SKILL_ENGINEER, SKILL_ENGINEER_TRAINED),
		/obj/item/device/analyzer = list(SKILL_ENGINEER, SKILL_ENGINEER_TRAINED),
		/obj/item/device/demo_scanner = list(SKILL_ENGINEER, SKILL_ENGINEER_TRAINED),
		/obj/item/device/reagent_scanner = list(SKILL_ENGINEER, SKILL_ENGINEER_TRAINED),
		/obj/item/device/t_scanner = list(SKILL_ENGINEER, SKILL_ENGINEER_TRAINED),
		/obj/item/stack/cable_coil = list(SKILL_ENGINEER, SKILL_ENGINEER_TRAINED),
		/obj/item/cell = list(SKILL_ENGINEER, SKILL_ENGINEER_TRAINED),
		/obj/item/device/assembly = list(SKILL_ENGINEER, SKILL_ENGINEER_TRAINED),
		/obj/item/stock_parts = list(SKILL_ENGINEER, SKILL_ENGINEER_TRAINED),
		/obj/item/explosive/plastic = list(SKILL_ENGINEER, SKILL_ENGINEER_TRAINED),
		/obj/item/device/defibrillator/synthetic = list(SKILL_ENGINEER, SKILL_ENGINEER_TRAINED),
	)
	can_hold_skill_only = TRUE

/obj/item/storage/pouch/medkit
	name = "医疗包"
	storage_flags = STORAGE_FLAGS_POUCH
	icon_state = "medkit"
	desc = "专为存放医疗物品设计。需要医疗技能才能有效使用。"
	storage_slots = 7
	can_hold_skill = list(
		/obj/item/device/healthanalyzer = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/reagent_container/dropper = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/reagent_container/pill = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/reagent_container/glass/bottle = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/reagent_container/syringe = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/storage/pill_bottle = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/stack/medical = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/reagent_container/hypospray = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/storage/syringe_case = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/storage/surgical_case = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/tool/surgery/surgical_line = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/tool/surgery/synthgraft = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/roller = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/bodybag = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/reagent_container/blood = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/tool/surgery/FixOVein = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/tool/surgery/scalpel = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/tool/surgery/hemostat = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
		/obj/item/tool/surgery/retractor = list(SKILL_MEDICAL, SKILL_MEDICAL_MEDIC),
	)
	can_hold_skill_only = TRUE
	instant_pill_grabbable = TRUE // If TRUE, pills can be taken directly from bottles while in hand/equipped.

/obj/item/storage/pouch/medkit/full/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/reagent_container/hypospray/autoinjector/skillless(src)
	new /obj/item/reagent_container/hypospray/autoinjector/skillless/tramadol(src)
	new /obj/item/reagent_container/hypospray/autoinjector/inaprovaline(src)
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/pouch/medkit/full_advanced/fill_preset_inventory()
	new /obj/item/reagent_container/hypospray/autoinjector/tricord(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/pouch/medkit/full_rmc/fill_preset_inventory()
	new /obj/item/reagent_container/blood/OMinus(src)
	new /obj/item/reagent_container/blood/OMinus(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/pouch/medkit/full_rmc_aid/fill_preset_inventory()
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/reagent_container/hypospray/autoinjector/bicaridine(src)
	new /obj/item/reagent_container/hypospray/autoinjector/kelotane(src)
	new /obj/item/device/healthanalyzer(src)

/obj/item/storage/pouch/medkit/full_rmc_officer_aid/fill_preset_inventory()
	new /obj/item/storage/surgical_case/rmc_surgical_case/full(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/reagent_container/hypospray/autoinjector/oxycodone(src)
	new /obj/item/reagent_container/hypospray/autoinjector/bicaridine(src)
	new /obj/item/reagent_container/hypospray/autoinjector/kelotane(src)
	new /obj/item/device/healthanalyzer(src)

/obj/item/storage/pouch/medkit/full/toxin/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/storage/pill_bottle/antitox(src)
	new /obj/item/storage/pill_bottle/antitox(src)
	new /obj/item/roller(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)

/obj/item/storage/pouch/medkit/full/toxin/cbrn
	can_hold_skill_only = FALSE // Given to non-medically trained personnel.

/obj/item/storage/pouch/medkit/full/toxin/cbrn/fill_preset_inventory()
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/storage/pill_bottle/antitox/skillless(src)
	new /obj/item/storage/pill_bottle/antitox/skillless(src)
	new /obj/item/roller(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
/obj/item/storage/pouch/medkit/wy
	icon_state = "wy_medkit"

/obj/item/storage/pouch/medkit/wy/full_advanced/fill_preset_inventory()
	new /obj/item/reagent_container/hypospray/autoinjector/tricord(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/advanced/ointment(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/pouch/pressurized_reagent_canister
	name = "加压试剂罐包"
	max_w_class = SIZE_SMALL
	storage_flags = STORAGE_FLAGS_POUCH|STORAGE_USING_DRAWING_METHOD
	icon_state = "pressurized_reagent_canister"
	desc = "一个加压试剂罐包。用于补充定制注射器，也可存放一个。可用试剂罐或化学分配器补充。"
	can_hold = list(/obj/item/reagent_container/hypospray/autoinjector/empty)
	var/obj/item/reagent_container/glass/pressurized_canister/inner
	matter = list("plastic" = 2000, "glass" = 2000)
	flags_item = NOBLUDGEON


/obj/item/storage/pouch/pressurized_reagent_canister/bicaridine
	name = "加压试剂罐包（碧卡利定）"
	desc = "一个加压试剂罐包。用于补充定制注射器，也可存放一个。可用试剂罐或化学分配器补充。此包预装了可靠的钝伤治疗剂碧卡利定。"

/obj/item/storage/pouch/pressurized_reagent_canister/kelotane
	name = "加压试剂罐包（凯洛坦）"
	desc = "一个加压试剂罐包。用于补充定制注射器，也可存放一个。可用试剂罐或化学分配器补充。此包预装了可靠的烧伤治疗剂凯洛坦。"

/obj/item/storage/pouch/pressurized_reagent_canister/tricordrazine
	name = "加压试剂罐包（三合剂）"
	desc = "一个加压试剂罐包。用于补充定制注射器，也可存放一个。可用试剂罐或化学分配器补充。此包预装了能缓慢治疗钝伤、烧伤、毒素和缺氧损伤的可靠药物——三合剂。"

/obj/item/storage/pouch/pressurized_reagent_canister/oxycodone
	name = "加压试剂罐包（野战麻醉剂）"
	desc = "一个加压试剂罐包。用于补充定制注射器，也可存放一个。可用试剂罐或化学分配器补充。此包预装了从本地化学分配器可获得的最强效止痛药——羟考酮。"

/obj/item/storage/pouch/pressurized_reagent_canister/revival_tricord
	name = "加压试剂罐包（三合剂复苏混合剂）"
	desc = "一个加压试剂罐包。用于补充定制注射器，也可存放一个。可用试剂罐或化学分配器补充。此包预装了等量的肾上腺素、伊纳普罗瓦林和三合剂，用于稳定除颤后患者并最小化其损伤。"

/obj/item/storage/pouch/pressurized_reagent_canister/revival_peri
	name = "加压试剂罐包（培利达松复苏混合剂）"
	desc = "一个加压试剂罐包。用于补充定制注射器，也可存放一个。可用试剂罐或化学分配器补充。此包预装了等量的肾上腺素、伊纳普罗瓦林和培利达松，用于稳定患者并抵御除颤后心脏损伤的症状。"

/obj/item/storage/pouch/pressurized_reagent_canister/Initialize()
	. = ..()
	inner = new /obj/item/reagent_container/glass/pressurized_canister()
	//Only add an autoinjector if the canister is empty
	//Important for the snowflake /obj/item/storage/pouch/pressurized_reagent_canister/oxycodone
	if(length(contents) == 0)
		new /obj/item/reagent_container/hypospray/autoinjector/empty/medic(src)
	update_icon()

/obj/item/storage/pouch/pressurized_reagent_canister/proc/fill_with(ragent)
	inner.reagents.add_reagent(ragent, inner.volume)
	if(length(contents) > 0)
		var/obj/item/reagent_container/hypospray/autoinjector/empty/A = contents[1]
		A.reagents.add_reagent(ragent, A.volume)
		A.update_uses_left()
		A.update_icon()
	update_icon()

/obj/item/storage/pouch/pressurized_reagent_canister/bicaridine/Initialize()
	. = ..()
	fill_with("bicaridine")

/obj/item/storage/pouch/pressurized_reagent_canister/kelotane/Initialize()
	. = ..()
	fill_with("kelotane")

/obj/item/storage/pouch/pressurized_reagent_canister/oxycodone/Initialize()
	. = ..()
	fill_with("oxycodone")

/obj/item/storage/pouch/pressurized_reagent_canister/tricordrazine/Initialize()
	. = ..()
	fill_with("tricordrazine")

/obj/item/storage/pouch/pressurized_reagent_canister/revival_tricord/Initialize()
	. = ..()
	//we don't call fill_with because of the complex mix of chemicals we have
	inner.reagents.add_reagent("adrenaline", inner.volume/3)
	inner.reagents.add_reagent("inaprovaline", inner.volume/3)
	inner.reagents.add_reagent("tricordrazine", inner.volume/3)
	if(length(contents) > 0)
		var/obj/item/reagent_container/hypospray/autoinjector/empty/medic/A = contents[1]
		A.reagents.add_reagent("adrenaline", A.volume/3)
		A.reagents.add_reagent("inaprovaline", A.volume/3)
		A.reagents.add_reagent("tricordrazine", A.volume/3)
		A.update_uses_left()
		A.update_icon()
	update_icon()

/obj/item/storage/pouch/pressurized_reagent_canister/revival_peri/Initialize()
	. = ..()
	//we don't call fill_with because of the complex mix of chemicals we have
	inner.reagents.add_reagent("adrenaline", inner.volume/3)
	inner.reagents.add_reagent("inaprovaline", inner.volume/3)
	inner.reagents.add_reagent("peridaxon", inner.volume/3)
	if(length(contents) > 0)
		var/obj/item/reagent_container/hypospray/autoinjector/empty/medic/A = contents[1]
		A.reagents.add_reagent("adrenaline", A.volume/3)
		A.reagents.add_reagent("inaprovaline", A.volume/3)
		A.reagents.add_reagent("peridaxon", A.volume/3)
		A.update_uses_left()
		A.update_icon()
	update_icon()

/obj/item/storage/pouch/pressurized_reagent_canister/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/reagent_container/glass/pressurized_canister))
		if(inner)
			to_chat(user, SPAN_WARNING("[src]里已经有一个容器了！"))
		else
			user.drop_inv_item_to_loc(W, src)
			inner = W
			contents -= W
			to_chat(user, SPAN_NOTICE("你将[W]插入[src]！"))
			update_icon()
		return

	if(istype(W, /obj/item/reagent_container/hypospray/autoinjector/empty))
		var/obj/item/reagent_container/hypospray/autoinjector/A = W
		fill_autoinjector(A)
		return ..()
	else if(istype(W, /obj/item/reagent_container/hypospray/autoinjector))
		to_chat(user, SPAN_WARNING("[W]与此系统不兼容！"))
	return ..()

/obj/item/storage/pouch/pressurized_reagent_canister/proc/fill_autoinjector(obj/item/reagent_container/hypospray/autoinjector/autoinjector)
	var/max_uses = autoinjector.volume / autoinjector.amount_per_transfer_from_this
	max_uses = floor(max_uses) == max_uses ? max_uses : floor(max_uses) + 1
	if(inner && inner.reagents.total_volume > 0 && (autoinjector.uses_left < max_uses))
		inner.reagents.trans_to(autoinjector, autoinjector.volume)
		autoinjector.update_uses_left()
		autoinjector.update_icon()
		playsound(loc, 'sound/effects/refill.ogg', 25, TRUE, 3)
		autoinjector.update_icon()
		update_icon()

/obj/item/storage/pouch/pressurized_reagent_canister/afterattack(obj/target, mob/user, flag) //refuel at fueltanks & chem dispensers.
	if(get_dist(user,target) > 1)
		return ..()

	if(!inner)
		to_chat(user, SPAN_WARNING("[src]没有内部容器！"))
		return ..()

	if(istype(target, /obj/structure/machinery/chem_dispenser))
		var/obj/structure/machinery/chem_dispenser/cd = target
		if(!cd.beaker)
			to_chat(user, SPAN_NOTICE("你取下内部容器并将其连接到[target]。"))
			inner.forceMove(cd)
			cd.beaker = inner
			inner = null
			update_icon()
		else
			to_chat(user, SPAN_WARNING("[cd]已经有一个容器了！"))
		return

	if(!istype(target, /obj/structure/reagent_dispensers/tank/fuel))
		return ..()



	var/obj/O = target
	if(!O.reagents || length(O.reagents.reagent_list) < 1)
		to_chat(user, SPAN_WARNING("[O]是空的！"))
		return

	var/amt_to_remove = clamp(O.reagents.total_volume, 0, inner.volume)
	if(!amt_to_remove)
		to_chat(user, SPAN_WARNING("[O]是空的！"))
		return

	//Fill our inner reagent canister
	O.reagents.trans_to(inner, amt_to_remove)

	//Refill our autoinjector
	if(length(contents) > 0)
		fill_autoinjector(contents[1])

	//Top up our inner reagent canister after filling up the injector
	amt_to_remove = clamp(O.reagents.total_volume, 0, inner.volume)
	if(amt_to_remove)
		O.reagents.trans_to(inner, amt_to_remove)

	playsound(loc, 'sound/effects/refill.ogg', 25, TRUE, 3)

	to_chat(user, SPAN_NOTICE("你重新填满了[src]。"))
	update_icon()

/obj/item/storage/pouch/pressurized_reagent_canister/get_examine_text(mob/user)
	. = ..()
	var/display_info = display_contents(user)
	if(display_info)
		. += display_info

/obj/item/storage/pouch/pressurized_reagent_canister/update_icon()
	overlays.Cut()

	if(length(contents))
		overlays += "+[icon_state]_full"
	if(inner)
		overlays += "+[icon_state]_loaded"
		if(inner.reagents?.total_volume)
			var/image/filling
			var/percent = floor((inner.reagents.total_volume / inner.reagents.maximum_volume) * 100)
			switch(percent)
				if(1 to 25)
					filling = image('icons/obj/items/reagentfillings.dmi', src, "+[icon_state]-25")
				if(26 to 50)
					filling = image('icons/obj/items/reagentfillings.dmi', src, "+[icon_state]-50")
				if(51 to 75)
					filling = image('icons/obj/items/reagentfillings.dmi', src, "+[icon_state]-75")
				if(76 to INFINITY)
					filling = image('icons/obj/items/reagentfillings.dmi', src, "+[icon_state]-100")
				else
					return

			filling.color = mix_color_from_reagents(inner.reagents.reagent_list)
			overlays += filling


/obj/item/storage/pouch/pressurized_reagent_canister/empty(mob/user)
	return //Useless, it's a one slot.

/obj/item/storage/pouch/pressurized_reagent_canister/proc/display_contents(mob/user) // Used on examine for properly skilled people to see contents.
	if(isxeno(user))
		return
	if(!inner)
		return "This [src] has no container inside!"
	if(skillcheck(user, SKILL_MEDICAL, SKILL_MEDICAL_TRAINED))
		return "This [src] contains: [get_reagent_list_text()]"
	else
		return "You don't know what's in it."

//returns a text listing the reagents (and their volume) in the atom. Used by Attack logs for reagents in pills
/obj/item/storage/pouch/pressurized_reagent_canister/proc/get_reagent_list_text()
	if(inner && inner.reagents && LAZYLEN(inner.reagents.reagent_list))
		var/datum/reagent/R = inner.reagents.reagent_list[1]
		. = "[R.name]([R.volume]u)"

		if(length(inner.reagents.reagent_list) < 2)
			return

		for(var/i in 2 to length(inner.reagents.reagent_list))
			R = inner.reagents.reagent_list[i]

			if(!R)
				continue

			. += "; [R.name]([R.volume]u)"
	else
		. = "No reagents"

/obj/item/storage/pouch/pressurized_reagent_canister/verb/flush_container()
	set category = "Weapons"
	set name = "Flush Container"
	set desc = "Forces the container to empty its reagents."
	set src in usr
	if(!inner)
		to_chat(usr, SPAN_WARNING("这个袋子里没有容器！"))
		return

	to_chat(usr, SPAN_NOTICE("你按下了紧急冲洗按钮。等待3秒..."))
	if(do_after(usr, 3 SECONDS, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		if(inner)
			to_chat(usr, SPAN_NOTICE("你冲洗了[src]。"))
			inner.reagents.clear_reagents()
			update_icon()

/obj/item/storage/pouch/pressurized_reagent_canister/verb/remove_canister()
	set category = "Weapons"
	set name = "Remove Canister"
	set desc = "Removes the Pressurized Canister from the pouch."
	set src in usr
	if(!inner)
		to_chat(usr, SPAN_WARNING("这个袋子里没有容器！"))
		return

	var/had_empty_hand = usr.put_in_any_hand_if_possible(inner, disable_warning = TRUE)
	if(!had_empty_hand)
		usr.drop_inv_item_on_ground(inner)

	inner = null
	update_icon()

/obj/item/storage/pouch/document
	name = "大型文件袋"
	desc = "可容纳纸张、文件夹、磁盘、技术手册和写字板。"
	icon_state = "document"
	storage_slots = 21
	max_w_class = SIZE_MEDIUM
	max_storage_space = 21
	storage_flags = STORAGE_FLAGS_POUCH|STORAGE_CLICK_GATHER
	can_hold = list(
		/obj/item/paper,
		/obj/item/clipboard,
		/obj/item/document_objective/paper,
		/obj/item/document_objective/report,
		/obj/item/document_objective/folder,
		/obj/item/disk/objective,
		/obj/item/document_objective/technical_manual,
	)

/obj/item/storage/pouch/document/small
	name = "小型文件袋"
	desc = "文件袋的缩小版。可容纳纸张、文件夹、磁盘、技术手册和写字板。"
	storage_slots = 7

/obj/item/storage/pouch/flare
	name = "照明弹袋"
	desc = "专为存放照明弹设计的袋子。可使用M94照明弹包补充。"
	max_w_class = SIZE_SMALL
	storage_slots = 16
	max_storage_space = 16
	storage_flags = STORAGE_FLAGS_POUCH|STORAGE_USING_DRAWING_METHOD
	icon_state = "flare"
	can_hold = list(/obj/item/device/flashlight/flare,/obj/item/device/flashlight/flare/signal)

/obj/item/storage/pouch/flare/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/storage/box/m94))
		var/obj/item/storage/box/m94/M = W
		dump_into(M,user)
	else
		return ..()

/obj/item/storage/pouch/flare/full/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/device/flashlight/flare(src)

/obj/item/storage/pouch/radio
	name = "无线电袋"
	storage_slots = 2
	icon_state = "radio"
	storage_flags = STORAGE_FLAGS_POUCH|STORAGE_USING_DRAWING_METHOD
	desc = "可容纳两部手持无线电。"
	can_hold = list(/obj/item/device/radio)


/obj/item/storage/pouch/electronics
	name = "电子设备袋"
	desc = "专为存放大多数电子设备、电池和电路板设计。"
	icon_state = "electronics"
	storage_slots = 6
	can_hold = list(
		/obj/item/circuitboard,
		/obj/item/cell,
		/obj/item/stock_parts/matter_bin,
		/obj/item/stock_parts/console_screen,
		/obj/item/stock_parts/manipulator,
		/obj/item/stock_parts/micro_laser,
		/obj/item/stock_parts/scanning_module,
		/obj/item/stock_parts/capacitor,
		/obj/item/smartgun_battery,
	)

/obj/item/storage/pouch/electronics/full/fill_preset_inventory()
	new /obj/item/circuitboard/apc(src)
	new /obj/item/cell/high(src)
	new /obj/item/circuitboard/apc(src)
	new /obj/item/cell/high(src)
	new /obj/item/circuitboard/apc(src)
	new /obj/item/cell/high(src)

/obj/item/storage/pouch/construction
	name = "工程材料袋"
	desc = "专为存放工程材料设计——玻璃/金属板、金属棒、铁丝网、电缆卷和空沙袋。还有两个挂钩，用于放置工兵铲和灯具更换器。"
	storage_slots = 3
	max_w_class = SIZE_MEDIUM
	icon_state = "construction"
	can_hold = list(
		/obj/item/stack/barbed_wire,
		/obj/item/stack/sheet,
		/obj/item/stack/rods,
		/obj/item/stack/cable_coil,
		/obj/item/stack/tile,
		/obj/item/tool/shovel/etool,
		/obj/item/stack/sandbags_empty,
		/obj/item/device/lightreplacer,
		/obj/item/weapon/gun/smg/nailgun/compact,
	)

/obj/item/storage/pouch/construction/full/fill_preset_inventory()
	new /obj/item/stack/sheet/plasteel(src, 50)
	new /obj/item/stack/sheet/metal(src, 50)
	new /obj/item/stack/sandbags_empty(src, 50)

/obj/item/storage/pouch/construction/full/wy
	icon_state = "wy_construction"

/obj/item/storage/pouch/construction/full_barbed_wire/fill_preset_inventory()
	new /obj/item/stack/sheet/plasteel(src, 50)
	new /obj/item/stack/sheet/metal(src, 50)
	new /obj/item/stack/barbed_wire(src, 20)

/obj/item/storage/pouch/construction/full_barbed_wire/wy
	icon_state = "wy_construction"

/obj/item/storage/pouch/construction/low_grade_full/fill_preset_inventory()
	new /obj/item/stack/sheet/plasteel(src, 30)
	new /obj/item/stack/sheet/metal(src, 50)
	new /obj/item/stack/barbed_wire(src, 15)

/obj/item/storage/pouch/tools
	name = "工具袋"
	desc = "专为存放维修工具设计——螺丝刀、扳手、电缆卷等。还有一个挂钩，用于放置工兵铲或灯具更换器。"
	storage_slots = 4
	max_w_class = SIZE_MEDIUM
	icon_state = "tools"
	can_hold = list(
		/obj/item/tool/crowbar,
		/obj/item/tool/screwdriver,
		/obj/item/tool/weldingtool,
		/obj/item/tool/wirecutters,
		/obj/item/tool/wrench,
		/obj/item/tool/extinguisher/mini,
		/obj/item/tool/shovel/etool,
		/obj/item/stack/cable_coil,
		/obj/item/weapon/gun/smg/nailgun/compact,
		/obj/item/cell,
		/obj/item/circuitboard,
		/obj/item/stock_parts,
		/obj/item/device/demo_scanner,
		/obj/item/device/reagent_scanner,
		/obj/item/device/assembly,
		/obj/item/device/multitool,
		/obj/item/device/flashlight,
		/obj/item/device/t_scanner,
		/obj/item/device/analyzer,
		/obj/item/explosive/plastic,
		/obj/item/device/lightreplacer,
		/obj/item/device/defibrillator/synthetic,
	)
	bypass_w_limit = list(
		/obj/item/tool/shovel/etool,
		/obj/item/device/lightreplacer,
	)

/obj/item/storage/pouch/tools/tactical
	name = "战术工具袋"
	desc = "这个装满尖锐沉重物体的特殊工具包是为破坏而非修理设计的。不过，后者也干得不错。"
	icon_state = "soctools"
	storage_slots = 8

/obj/item/storage/pouch/tools/full/fill_preset_inventory()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/device/multitool(src)
	new /obj/item/tool/wrench(src)

/obj/item/storage/pouch/tools/pfc/fill_preset_inventory()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/wrench(src)

/obj/item/storage/pouch/tools/synth/fill_preset_inventory()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/device/multitool(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/pouch/tools/tank/fill_preset_inventory()
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool/hugetank(src)
	new /obj/item/tool/extinguisher/mini(src)

/obj/item/storage/pouch/tools/mortar/fill_preset_inventory()
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/tool/shovel/etool(src)

/obj/item/storage/pouch/tools/rmc/fill_preset_inventory()
	new /obj/item/device/multitool(src)
	new /obj/item/tool/wirecutters/tactical(src)
	new /obj/item/tool/screwdriver/tactical(src)
	new /obj/item/tool/extinguisher/mini(src)

/obj/item/storage/pouch/tools/tactical/full/fill_preset_inventory()
	new /obj/item/tool/screwdriver/tactical(src)
	new /obj/item/tool/wirecutters/tactical(src)
	new /obj/item/tool/crowbar/tactical(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/device/multitool(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/explosive/plastic(src)
	new /obj/item/explosive/plastic(src)

/obj/item/storage/pouch/tools/tactical/sof/full/fill_preset_inventory()
	new /obj/item/tool/screwdriver/tactical(src)
	new /obj/item/tool/wirecutters/tactical(src)
	new /obj/item/tool/crowbar/tactical(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/device/multitool(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)

/obj/item/storage/pouch/tools/tactical/upp
	name = "合成人工具袋"
	desc = "UPP合成人专用工具袋。由于合成人力量增强且无不适感，此袋设计旨在最大化内部空间，无需考虑使用者的舒适度。"
	icon_state = "tools"
	storage_slots = 7

/obj/item/storage/pouch/tools/tactical/upp/fill_preset_inventory()
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/device/multitool(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/pouch/tools/tactical/upp/resetkey/fill_preset_inventory()
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/device/multitool(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/device/defibrillator/synthetic(src)

/obj/item/storage/pouch/tools/tactical/upp/dzho/fill_preset_inventory()
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/device/multitool(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/screwdriver(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/pouch/tools/uppsynth/fill_preset_inventory()
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/wrench(src)

/obj/item/storage/pouch/tools/uppsynth/black
	icon_state = "soctools"

/obj/item/storage/pouch/tools/uppsynth/black/full/fill_preset_inventory()
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/wrench(src)

/obj/item/storage/pouch/tools/tactical/sec
	name = "战术安保挎包"
	desc = "一款定制安保挎包，不同隔层可容纳多种安保工具。"
	storage_slots = 5
	can_hold = list(
		/obj/item/explosive/grenade/flashbang,
		/obj/item/explosive/grenade/custom/teargas,
		/obj/item/reagent_container/spray/pepper,
		/obj/item/restraint/handcuffs,
		/obj/item/device/flash,
		/obj/item/clothing/glasses,
		/obj/item/reagent_container/food/snacks/donut/normal,
		/obj/item/reagent_container/food/snacks/donut/jelly,
		/obj/item/weapon/baton,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/tool/lighter/zippo,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/clothing/glasses/hud/security,
		/obj/item/device/flashlight,
		/obj/item/device/radio/headset,
	)
	bypass_w_limit = list(
		/obj/item/weapon/gun/energy/taser,
		/obj/item/weapon/baton,
	)

/obj/item/storage/pouch/tools/tactical/sec/full/fill_preset_inventory()
	new /obj/item/weapon/baton(src)
	new /obj/item/weapon/gun/energy/taser(src)
	new /obj/item/device/flash(src)
	new /obj/item/restraint/handcuffs(src)
	new /obj/item/reagent_container/spray/pepper(src)

/obj/item/storage/pouch/sling
	name = "枪背带"
	desc = "将单个物品固定在背带上。"
	storage_slots = 1
	max_w_class = SIZE_MEDIUM
	icon_state = "sling"
	can_hold = list(/obj/item/device, /obj/item/tool)
	bypass_w_limit = list(/obj/item/tool/shovel/etool)
	storage_flags = STORAGE_FLAGS_POUCH|STORAGE_USING_DRAWING_METHOD
	var/sling_range = 2
	var/obj/item/slung

/obj/item/storage/pouch/sling/get_examine_text(mob/user)
	. = ..()
	if(slung && slung.loc != src)
		. += "\The [slung] is attached to the sling."

/obj/item/storage/pouch/sling/can_be_inserted(obj/item/I, mob/user, stop_messages = FALSE)
	if(slung)
		if(slung != I)
			if(!stop_messages)
				to_chat(usr, SPAN_WARNING("\the [slung] is already attached to the sling."))
			return FALSE
	else if(SEND_SIGNAL(I, COMSIG_DROP_RETRIEVAL_CHECK) & COMPONENT_DROP_RETRIEVAL_PRESENT)
		if(!stop_messages)
			to_chat(usr, SPAN_WARNING("[I]已经连接到另一条枪背带上了。"))
		return FALSE
	return ..()

/obj/item/storage/pouch/sling/_item_insertion(obj/item/I, prevent_warning = FALSE, mob/user)
	if(!slung)
		slung = I
		slung.AddElement(/datum/element/drop_retrieval/pouch_sling, src)
		if(!prevent_warning)
			to_chat(user, SPAN_NOTICE("你将枪背带连接到[I]上。"))
	..()

/obj/item/storage/pouch/sling/attack_self(mob/user)
	if(slung)
		to_chat(user, SPAN_NOTICE("你从[slung]上收回枪背带。"))
		unsling()
		return
	return ..()

/obj/item/storage/pouch/sling/proc/unsling()
	if(!slung)
		return
	slung.RemoveElement(/datum/element/drop_retrieval/pouch_sling, src)
	slung = null

/obj/item/storage/pouch/sling/proc/sling_return(mob/living/carbon/human/user)
	if(!slung || !slung.loc)
		return FALSE
	if(slung.loc == user)
		return TRUE
	if(!isturf(slung.loc))
		return FALSE
	if(get_dist(slung, src) > sling_range)
		return FALSE
	if(handle_item_insertion(slung))
		if(user)
			to_chat(user, SPAN_NOTICE("[slung]弹回[src]中。"))
		return TRUE

/obj/item/storage/pouch/sling/proc/attempt_retrieval(mob/living/carbon/human/user)
	if(sling_return(user))
		return
	unsling()
	if(user && src.loc == user)
		to_chat(user, SPAN_WARNING("你的[src]的枪背带空弹而回！"))

/obj/item/storage/pouch/sling/proc/handle_retrieval(mob/living/carbon/human/user)
	if(slung && slung.loc == src)
		return
	addtimer(CALLBACK(src, PROC_REF(attempt_retrieval), user), 0.3 SECONDS, TIMER_UNIQUE|TIMER_NO_HASH_WAIT)

/obj/item/storage/pouch/cassette
	name = "磁带包"
	desc = "一个制作精良的包，专为在战时安全存放磁带而设计。"
	icon_state = "cassette_pouch_closed"
	item_state_slots = list(WEAR_AS_GARB = "cassette_pouch")
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/walkman.dmi',
		)
	w_class = SIZE_SMALL
	flags_obj = OBJ_IS_HELMET_GARB
	can_hold = list(/obj/item/device/cassette_tape, /obj/item/tape/regulation)
	storage_slots = 3
	var/base_icon_state = "cassette_pouch"

/obj/item/storage/pouch/cassette/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/synsound)

/obj/item/storage/pouch/cassette/update_icon()
	underlays.Cut()
	if(!content_watchers)
		icon_state = "[base_icon_state]_closed"
	else
		switch(min(length(contents), 2))
			if(2)
				icon_state = "[base_icon_state]_2"
				var/obj/item/device/cassette_tape/first_tape = contents[1]
				underlays += image(first_tape.icon, null, first_tape.icon_state, pixel_y = -4)
				var/obj/item/device/cassette_tape/second_tape = contents[2]
				var/image/I = image(second_tape.icon, null, second_tape.icon_state, pixel_y = 5)
				var/matrix/M = matrix()
				M.Turn(180)
				I.transform = M
				underlays += I
			if(1)
				icon_state = "[base_icon_state]_1"
				var/obj/item/device/cassette_tape/first_tape = contents[1]
				underlays += image(first_tape.icon, null, first_tape.icon_state, pixel_y = -4)
			if(0)
				icon_state = base_icon_state

/obj/item/storage/pouch/machete
	name = "\improper H6B pattern M2132 machete scabbard"
	desc = "一个用于携带M2132砍刀的大型皮质刀鞘。可固定在挎包槽位。"
	icon = 'icons/obj/items/storage/holsters.dmi'
	icon_state = "macheteB_holster"
	item_state = "machete_holster"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/belts_righthand.dmi'
	)
	max_w_class = SIZE_LARGE
	storage_flags = STORAGE_FLAGS_POUCH|STORAGE_USING_DRAWING_METHOD|STORAGE_ALLOW_QUICKDRAW|STORAGE_ALLOW_WHILE_HAULED
	can_hold = list(/obj/item/weapon/sword/machete)

	var/sheathe_sound = 'sound/weapons/gun_rifle_draw.ogg'
	var/draw_sound = 'sound/weapons/gun_rifle_draw.ogg'

/obj/item/storage/pouch/machete/update_icon()
	if(length(contents))
		icon_state = "[initial(icon_state)]_full"
	else
		icon_state = initial(icon_state)

/obj/item/storage/pouch/machete/_item_insertion(obj/item/W, prevent_warning = 0)
	..()
	playsound(src, sheathe_sound, vol = 15, vary = TRUE)

/obj/item/storage/pouch/machete/_item_removal(obj/item/W, atom/new_location)
	..()
	playsound(src, draw_sound, vol = 15, vary = TRUE)

/obj/item/storage/pouch/machete/full/fill_preset_inventory()
	new /obj/item/weapon/sword/machete(src)
