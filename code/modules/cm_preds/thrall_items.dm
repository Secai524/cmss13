///Thrall Armor & Material Types
/obj/item/clothing/suit/armor/yautja/thrall
	name = "外星护甲"
	desc = "由奇异合金制成的护甲。触感冰冷，带着异样的重量。它经过改造，可同时携带人类和异形的近战武器。"

	icon = 'icons/obj/items/hunter/thrall_gear.dmi'
	icon_state = "thrallarmor_ebony"
	item_state = "thrallarmor_ebony"
	item_state_slots = list(WEAR_JACKET = "thrallarmor_ebony")
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/hunter/thrall_gear.dmi'
	)
	thrall = TRUE
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_MEDIUMHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH

	allowed = list(
		/obj/item/weapon/gun/launcher/spike,
		/obj/item/weapon/gun/energy/yautja,
		/obj/item/weapon,
	)

/obj/item/clothing/suit/armor/yautja/thrall/silver
	icon_state = "thrallarmor_silver"
	item_state = "thrallarmor_silver"
	item_state_slots = list(WEAR_JACKET = "thrallarmor_silver")

/obj/item/clothing/suit/armor/yautja/thrall/gold
	icon_state = "thrallarmor_gold"
	item_state = "thrallarmor_gold"
	item_state_slots = list(WEAR_JACKET = "thrallarmor_gold")

/obj/item/clothing/suit/armor/yautja/thrall/crimson
	icon_state = "thrallarmor_crimson"
	item_state = "thrallarmor_crimson"
	item_state_slots = list(WEAR_JACKET = "thrallarmor_crimson")

/obj/item/clothing/suit/armor/yautja/thrall/bone
	icon_state = "thrallarmor_bone"
	item_state = "thrallarmor_bone"
	item_state_slots = list(WEAR_JACKET = "thrallarmor_bone")

///Thrall Greaves & Material Types
/obj/item/clothing/shoes/yautja/thrall
	name = "异形胫甲"
	desc = "由碎布和奇异合金制成的胫甲。触感冰冷，带着异样的重量。它们经过改造，以兼容人类装备。"

	icon = 'icons/obj/items/hunter/thrall_gear.dmi'
	icon_state = "thrallgreaves_ebony"
	item_state = "thrallgreaves_ebony"
	item_icons = list(
		WEAR_FEET = 'icons/mob/humans/onmob/hunter/thrall_gear.dmi'
	)
	thrall = TRUE

	allowed_items_typecache = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
		/obj/item/weapon/gun/pistol/action,
		/obj/item/weapon/gun/pistol/clfpistol,
		/obj/item/weapon/straight_razor,
	)

/obj/item/clothing/shoes/yautja/thrall/silver
	icon_state = "thrallgreaves_silver"
	item_state = "thrallgreaves_silver"
	item_state_slots = list(WEAR_FEET = "thrallgreaves_silver")

/obj/item/clothing/shoes/yautja/thrall/gold
	icon_state = "thrallgreaves_gold"
	item_state = "thrallgreaves_gold"
	item_state_slots = list(WEAR_FEET = "thrallgreaves_gold")

/obj/item/clothing/shoes/yautja/thrall/crimson
	icon_state = "thrallgreaves_crimson"
	item_state = "thrallgreaves_crimson"
	item_state_slots = list(WEAR_FEET = "thrallgreaves_crimson")

/obj/item/clothing/shoes/yautja/thrall/bone
	icon_state = "thrallgreaves_bone"
	item_state = "thrallgreaves_bone"
	item_state_slots = list(WEAR_FEET = "thrallgreaves_bone")

///Thrall Mask Material Types, original mask & mask code in yaut_mask.dm
/obj/item/clothing/mask/gas/yautja/thrall/silver
	icon_state = "thrallmask_silver"
	item_state = "thrallmask_silver"
	item_state_slots = list(WEAR_FACE = "thrallmask_silver")

/obj/item/clothing/mask/gas/yautja/thrall/gold
	icon_state = "thrallmask_gold"
	item_state = "thrallmask_gold"
	item_state_slots = list(WEAR_FACE = "thrallmask_gold")

/obj/item/clothing/mask/gas/yautja/thrall/crimson
	icon_state = "thrallmask_crimson"
	item_state = "thrallmask_crimson"
	item_state_slots = list(WEAR_FACE = "thrallmask_crimson")

/obj/item/clothing/mask/gas/yautja/thrall/bone
	icon_state = "thrallmask_bone"
	item_state = "thrallmask_bone"
	item_state_slots = list(WEAR_FACE = "thrallmask_bone")

///Subtype for name & desc
/obj/item/clothing/under/chainshirt/thrall
	name = "异形网眼护服"
	desc = "一件由奇异合金编织而成的背心。触感冰冷，带着异样的重量。它已为人类生理结构进行了适应性改造。"

///Subtype of base bracers, not hunter ones. Different name, desc, & color.
/obj/item/clothing/gloves/yautja/thrall
	name = "仆从护腕"
	desc = "一对奇异的异形护腕，已为人类生物学进行了适应性改造。"

	color = "#b85440"
	minimap_icon = "thrall"

/obj/item/storage/box/bracer
	name = "异形盒子"
	desc = "一个刻有符文的奇异盒子。"
	color = "#68423b"
	icon = 'icons/obj/structures/closet.dmi'
	icon_state = "pred_coffin"
	foldable = FALSE

/obj/item/storage/box/bracer/fill_preset_inventory()
	new /obj/item/clothing/gloves/yautja/thrall(src)

///Relay beacon for blooded thralls, only capable of teleporting back to the Yautja Ship
/obj/item/device/thrall_teleporter
	name = "简易中继信标"
	desc = "一个覆盖着神圣文字的装置。每隔几秒就会发出嗡嗡声和哔哔声。"

	icon = 'icons/obj/items/hunter/thrall_gear.dmi'
	icon_state = "thrall_teleporter"

	flags_item = ITEM_PREDATOR
	w_class = SIZE_TINY
	force = 1
	throwforce = 1
	unacidable = TRUE
	black_market_value = 100
	var/teleporting = FALSE

/obj/item/device/thrall_teleporter/attack_self(mob/user)
	..()

	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user
	var/ship_to_tele = -1

	if(!HAS_TRAIT(H, TRAIT_YAUTJA_TECH) || should_block_game_interaction(H))
		to_chat(user, SPAN_WARNING("你摆弄着它，但什么都没发生！"))
		return

	if(H.faction == FACTION_YAUTJA_YOUNG)
		to_chat(user, SPAN_WARNING("你尚未学会如何使用中继信标，最好别乱动它。"))
		return

	if(isthrall(user))
		var/datum/entity/clan_player/clan_info = H.client.clan_info
		if(clan_info.permissions & CLAN_PERMISSION_ADMIN_VIEW)
			var/list/datum/view_record/clan_view/clan_perm_view = DB_VIEW(/datum/view_record/clan_view/)
			for(var/datum/view_record/clan_view/clan_view in clan_perm_view)
				if(!SSpredships.is_clanship_loaded(clan_view?.clan_id))
					continue
				ship_to_tele += list("[clan_view.name]" = "[clan_view.clan_id]: [clan_view.name]")
		if(SSpredships.is_clanship_loaded(clan_info?.clan_id))
			ship_to_tele += list("Your clan" = "[clan_info.clan_id]")

	var/clan = ship_to_tele
	if(clan != "人类" && !SSpredships.is_clanship_loaded(clan))
		return // Checking ship is valid

	// Getting an arrival point
	var/turf/target_turf
	target_turf = SAFEPICK(SSpredships.get_clan_spawnpoints(clan))
	if(!istype(target_turf))
		return

	// Let's go
	playsound(src,'sound/ambience/signal.ogg', 25, 1, sound_range = 6)
	teleporting = TRUE
	user.visible_message(SPAN_INFO("[user]开始变得闪烁模糊……"))

	if(!do_after(user, 10 SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC))
		to_chat(user, "你被打断了！")
		teleporting = FALSE
		return
	// Display fancy animation for you and the person you might be pulling (Legacy)
	SEND_SIGNAL(user, COMSIG_MOB_EFFECT_CLOAK_CANCEL)
	user.visible_message(SPAN_WARNING("[icon2html(user, viewers(src))][user]消失了！"))
	var/tele_time = animation_teleport_quick_out(user)
	var/mob/living/passenger = user.pulling
	if(istype(passenger)) // Pulled person
		SEND_SIGNAL(passenger, COMSIG_MOB_EFFECT_CLOAK_CANCEL)
		passenger.visible_message(SPAN_WARNING("[icon2html(passenger, viewers(src))][passenger]消失了！"))
		animation_teleport_quick_out(passenger)

		sleep(tele_time) // Animation delay
		user.trainteleport(target_turf) // Actually teleports everyone, not just you + pulled

		// Undo animations
		animation_teleport_quick_in(user)
		if(istype(passenger) && !QDELETED(passenger))
			animation_teleport_quick_in(passenger)
		teleporting = FALSE
	else
		VARSET_CALLBACK(src, teleporting, FALSE)
