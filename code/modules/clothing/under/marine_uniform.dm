//=========================//MARINES\\===================================//
//=======================================================================//


/obj/item/clothing/under/marine
	name = "\improper USCM uniform"
	desc = "标准配发的陆战队员制服。内含轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	icon_state = "marine_jumpsuit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/jungle.dmi'
	worn_state = "marine_jumpsuit"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	drop_sound = "armorequip"
	siemens_coefficient = 0.9
	///Makes it so that we can see the right name in the vendor.
	var/specialty = "USCM"
	var/snow_name = " snow uniform"
	layer = UPPER_ITEM_LAYER
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/jungle.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)

	//speciality does NOTHING if you have NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/Initialize(mapload, new_protection[] = list(MAP_ICE_COLONY = ICE_PLANET_MIN_COLD_PROT), override_icon_state[] = null)
	if(!(flags_atom & NO_NAME_OVERRIDE))
		name = "[specialty]"
		if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
			name += snow_name
		else
			name += " uniform"
	if(!(flags_atom & NO_GAMEMODE_SKIN))
		select_gamemode_skin(type, override_icon_state, new_protection)
	return ..() //Done after above in case gamemode skin is missing sprites.

/obj/item/clothing/under/marine/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	if(flags_atom & MAP_COLOR_INDEX)
		return
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/jungle.dmi'
			item_icons[WEAR_BODY] = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/jungle.dmi'
		if("classic")
			icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/classic.dmi'
			item_icons[WEAR_BODY] = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/classic.dmi'
		if("desert")
			icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/desert.dmi'
			item_icons[WEAR_BODY] = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/desert.dmi'
		if("snow")
			icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/snow.dmi'
			item_icons[WEAR_BODY] = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/snow.dmi'
			flags_jumpsuit |= UNIFORM_DO_NOT_HIDE_ACCESSORIES
		if("urban")
			icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/urban.dmi'
			item_icons[WEAR_BODY] = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/urban.dmi'

/obj/item/clothing/under/marine/set_sensors(mob/user)
	if(!skillcheckexplicit(user, SKILL_ANTAG, SKILL_ANTAG_AGENT))
		to_chat(user, SPAN_WARNING("\the [src]的传感器无法被修改。"))
		return
	. = ..()

/obj/item/clothing/under/marine/jungle
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/desert
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/desert.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/under/marine/classic
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/under/marine/snow
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/under/marine/urban
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/urban.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/under/marine/medic
	name = "\improper USCM corpsman uniform"
	desc = "标准配发的陆战队医疗兵作训服。内含轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	icon_state = "marine_medic"
	worn_state = "marine_medic"
	specialty = "USCM Hospital Corpsman"

/obj/item/clothing/under/marine/medic/jungle
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/medic/desert
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/desert.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/under/marine/medic/classic
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/under/marine/medic/snow
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/under/marine/medic/urban
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/urban.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/under/marine/engineer
	name = "\improper USCM ComTech uniform"
	desc = "标准配发的陆战队战斗技术员作训服。内含轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	icon_state = "marine_engineer"
	worn_state = "marine_engineer"
	specialty = "USCM Combat Technician"

/obj/item/clothing/under/marine/engineer/jungle
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/engineer/desert
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/desert.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/under/marine/engineer/classic
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/under/marine/engineer/snow
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/under/marine/engineer/urban
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/urban.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/under/marine/rto
	name = "\improper USCM radio telephone operator uniform"
	desc = "标准配发的RTO作训服。内含轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	icon_state = "marine_rto"
	item_state = "marine_rto"
	specialty = "marine Radio Telephone Operator"

/obj/item/clothing/under/marine/rto/jungle
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/rto/desert
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/desert.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/under/marine/rto/classic
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/under/marine/rto/snow
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/under/marine/rto/urban
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/urban.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/under/marine/tanker
	name = "\improper USCM tanker uniform"
	icon_state = "marine_tanker"
	worn_state = "marine_tanker"
	flags_jumpsuit = FALSE
	specialty = "USCM tanker"

/obj/item/clothing/under/marine/tanker/jungle
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/tanker/desert
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/desert.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/under/marine/tanker/classic
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/under/marine/tanker/snow
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/under/marine/tanker/urban
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/urban.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/under/marine/tanker/New(loc,
	new_protection = list(MAP_ICE_COLONY = ICE_PLANET_MIN_COLD_PROT))

	..(loc, new_protection)

/obj/item/clothing/under/marine/chef
	name = "\improper USCM Mess Technician uniform"
	desc = "标准配发的炊事技术员制服。内含轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	icon_state = "chef_uniform"
	worn_state = "chef_uniform"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/service.dmi'
	flags_jumpsuit = FALSE
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/service.dmi',
	)

/obj/item/clothing/under/marine/mp
	name = "宪兵连体服"
	desc = "标准配发的宪兵制服。内含轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	icon_state = "MP_jumpsuit"
	worn_state = "MP_jumpsuit"
	suit_restricted = list(/obj/item/clothing/suit/storage/marine, /obj/item/clothing/suit/armor/riot/marine, /obj/item/clothing/suit/storage/jacket/marine/service/mp)
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE|UNIFORM_SLEEVE_CUTTABLE|UNIFORM_JACKET_REMOVABLE
	specialty = "military police"

/obj/item/clothing/under/marine/mp/jungle
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/mp/desert
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/desert.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/under/marine/mp/classic
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/under/marine/mp/snow
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/under/marine/mp/urban
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/urban.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/under/marine/warden
	name = "军事典狱长连体服"
	desc = "标准配发的军事典狱长制服。内含轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	icon_state = "warden_jumpsuit"
	worn_state = "warden_jumpsuit"
	suit_restricted = list(/obj/item/clothing/suit/storage/marine, /obj/item/clothing/suit/armor/riot/marine, /obj/item/clothing/suit/storage/jacket/marine/service/warden)
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE|UNIFORM_SLEEVE_CUTTABLE|UNIFORM_JACKET_REMOVABLE
	specialty = "military warden"

/obj/item/clothing/under/marine/warden/jungle
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/warden/desert
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/desert.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/under/marine/warden/classic
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/under/marine/warden/snow
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/under/marine/warden/urban
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/urban.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer
	name = "陆战队军官制服"
	desc = "比丝绸更柔软。比羽毛更轻盈。比凯夫拉更具防护性。也比普通连体服更时髦。内含轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	icon_state = ""
	item_state = ""
	worn_state = ""
	suit_restricted = null //so most officers can wear whatever suit they want
	flags_jumpsuit = FALSE
	specialty = "marine officer"
	black_market_value = 25
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

/obj/item/clothing/under/marine/officer/intel
	name = "\improper marine intelligence officer sweatsuit"
	desc = "比虎钳更紧致。比胡须油更顺滑。从头到脚覆盖着各种小包、口袋、袋子、带子和腰带。显然，你不仅是情报官中最聪明的，也是最时尚的。这套服装花了整个研发团队五天时间开发。它可能比整艘阿尔迈耶号还要贵……大概吧。"
	icon_state = "io"
	item_state = "io"
	worn_state = "io"
	specialty = "marine intelligence officer"

/obj/item/clothing/under/marine/officer/intel/jungle
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/officer/intel/desert
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/desert.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/intel/classic
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/intel/snow
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/intel/urban
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/urban.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/warrant
	name = "\improper chief MP uniform"
	desc = "USCM宪兵长通常穿着的制服。内含轻型凯夫拉碎片，有助于抵御刺击武器、子弹和爆炸破片。此制服包含一个小型电磁场分配器，以帮助抵消能量武器火力，同时材料中编织了防化过滤器，以抵御生物和辐射危害。"
	icon_state = "WO_jumpsuit"
	item_state = "WO_jumpsuit"
	worn_state = "WO_jumpsuit"
	suit_restricted = list(/obj/item/clothing/suit/storage/marine, /obj/item/clothing/suit/armor/riot/marine, /obj/item/clothing/suit/storage/jacket/marine/service/cmp)
	flags_jumpsuit = FALSE
	specialty = "chief MP"

/obj/item/clothing/under/marine/officer/warrant/jungle
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/officer/warrant/desert
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/desert.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/warrant/classic
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/warrant/snow
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/warrant/urban
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/urban.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/pilot
	name = "飞行员军官连体服"
	desc = "USCM飞行员军官穿着的连体服，旨在恶劣环境中生存。带领陆战队员飞向荣耀。内含轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	icon_state = "pilot_flightsuit"
	item_state = "pilot_flightsuit"
	worn_state = "pilot_flightsuit"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	flags_cold_protection = ICE_PLANET_MIN_COLD_PROT
	specialty = "pilot officer"
	snow_name = " snow bodysuit"
	suit_restricted = list(/obj/item/clothing/suit/storage/jacket/marine/pilot/armor, /obj/item/clothing/suit/storage/marine/light/vest/dcc, /obj/item/clothing/suit/storage/jacket/marine/pilot, /obj/item/clothing/suit/storage/marine/light/vest)
	flags_atom = FPRINT

/obj/item/clothing/under/marine/officer/pilot/jungle
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/officer/pilot/desert
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/desert.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/pilot/classic
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/pilot/snow
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/pilot/urban
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/urban.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/pilot/flight
	name = "战术飞行员军官飞行服"
	desc = "USCM飞行员军官穿着的飞行服，配有大量皮制带子、小包和其他你永远不会用到的重要装备。看起来非常酷。"
	icon_state = "pilot_flightsuit_alt"
	worn_state = "pilot_flightsuit_alt"
	item_state = "pilot_flightsuit_alt"
	flags_jumpsuit = UNIFORM_JACKET_REMOVABLE
	flags_atom = NO_NAME_OVERRIDE
	flags_cold_protection = ICE_PLANET_MIN_COLD_PROT

/obj/item/clothing/under/marine/engineer/jungle
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/officer/pilot/flight/snow
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/pilot/flight/urban
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/urban.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/pilot/dcc
	name = "运输机机组长连体服"
	desc = "USCM运输机机组长穿着的连体服，旨在恶劣环境中生存。内含轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	icon_state = "crewchief_flightsuit"
	worn_state = "crewchief_flightsuit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)

/obj/item/clothing/under/marine/officer/tanker
	name = "载具乘员制服"
	desc = "USCM载具乘员的标准制服。为军团争光。它嵌有轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	icon_state = "marine_tanker"
	worn_state = "marine_tanker"
	suit_restricted = list(/obj/item/clothing/suit/storage/marine/tanker, /obj/item/clothing/suit/storage/jacket/marine/service/tanker)
	specialty = "vehicle crewman"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	item_state_slots = list(WEAR_BODY = "marine_tanker")

/obj/item/clothing/under/marine/officer/tanker/jungle
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/officer/tanker/desert
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/desert.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/tanker/classic
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/tanker/snow
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/tanker/urban
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/urban.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/bridge
	name = "陆战队员常服"
	desc = "USCM成员穿着的常服。为军团争光。它嵌有轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)
	icon_state = "BO_jumpsuit"
	worn_state = "BO_jumpsuit"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/officer/boiler
	name = "陆战队员作战服"
	desc = "USCM成员穿着的作战服。为军团争光。它嵌有轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	icon_state = "uscmboiler"
	worn_state = "uscmboiler"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE|UNIFORM_JACKET_REMOVABLE
	specialty = "marine operations"
	flags_atom = FPRINT

/obj/item/clothing/under/marine/officer/boiler/jungle
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

/obj/item/clothing/under/marine/officer/boiler/desert
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/desert.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/desert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/boiler/classic
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/classic.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/classic.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/boiler/snow
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/snow.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/snow.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/boiler/urban
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/urban.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/urban.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'
	)

/obj/item/clothing/under/marine/officer/command
	name = "\improper USCM officer uniform"
	desc = "USCM军官熨烫平整的勤务制服。哪怕只是多看一眼都可能被送上军事法庭。它嵌有轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	icon_state = "CO_jumpsuit"
	worn_state = "CO_jumpsuit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi'
	)
	specialty = "USCM officer"
	flags_atom = FPRINT && NO_GAMEMODE_SKIN

/obj/item/clothing/under/marine/officer/general
	name = "USCM军官C类常服"
	desc = "标准配发的USCM军官C类常服，包括一件短袖卡其色纽扣衬衫和绿色长裤。"
	icon_state = "general_jumpsuit"
	worn_state = "general_jumpsuit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN

/obj/item/clothing/under/marine/officer/ce
	name = "总工程师制服"
	desc = "军事工程师的制服。它嵌有轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	icon_state = "EC_jumpsuit"
	worn_state = "EC_jumpsuit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/engineering.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/engineering.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	item_state_slots = list(WEAR_BODY = "EC_jumpsuit")

/obj/item/clothing/under/marine/officer/engi
	name = "工程师制服"
	desc = "军事工程师的制服。它嵌有轻型凯夫拉碎片，有助于抵御刺击武器和子弹。"
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	icon_state = "mt_jumpsuit"
	worn_state = "mt_jumpsuit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/engineering.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/engineering.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)
	specialty = "engineer"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	flags_atom = NO_GAMEMODE_SKIN
	item_state_slots = list(WEAR_BODY = "mt_jumpsuit")

/obj/item/clothing/under/marine/officer/engi/OT
	name = "军械工程师制服"
	desc = "专业炸弹制造者的制服。它嵌有轻型凯夫拉碎片，有助于抵御刺击武器、子弹和爆炸破片。额外加装了护板以吸收爆炸冲击。"
	armor_bomb = CLOTHING_ARMOR_LOW
	icon_state = "ot_jumpsuit"
	worn_state = "ot_jumpsuit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/engineering.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/engineering.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)
	item_state_slots = list(WEAR_BODY = "ot_jumpsuit")

/obj/item/clothing/under/marine/officer/researcher
	name = "研究员服装"
	desc = "研究员穿着的简单民用服装。"
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	icon_state = "research_jumpsuit"
	worn_state = "research_jumpsuit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/research.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/research.dmi',
	)
	specialty = "researcher"
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/under/marine/officer/formal
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN

/obj/item/clothing/under/marine/officer/formal/servicedress
	name = "指挥官礼服衬衫"
	desc = "高级军官两件套海军礼服制服中的衬衫和领带。穿着它，彰显风范与内涵。"
	specialty = "captain's service dress"
	icon_state = "CO_service"
	worn_state = "CO_service"
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/under/marine/officer/formal/gray
	name = "指挥官灰色礼服制服"
	desc = "一件熨烫平整的USCM军官制服，适用于阅兵或炎热天气。自豪地穿上它。"
	icon_state = "co_gray"
	worn_state = "co_gray"
	specialty = "captain's gray formal"
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/under/marine/officer/formal/turtleneck
	name = "指挥官高领制服"
	desc = "一件熨烫平整的USCM军官制服，适用于更正式或庄重的场合。自豪地穿上它。"
	icon_state = "co_turtleneck"
	worn_state = "co_turtleneck"
	specialty = "captain's turtleneck"
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/under/marine/dress
	name = "陆战队员礼服常服"
	desc = "USCM陆战队员通常穿着的礼服常服。在保持比标准常服更正式的同时，仍具实用性。"
	icon_state = "formal_jumpsuit"
	worn_state = "formal_jumpsuit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	flags_jumpsuit = FALSE
	black_market_value = 15

/obj/item/clothing/under/marine/dress/command
	name = "陆战队军官礼服常服"
	desc = "USCM陆战队员通常穿着的礼服常服。在保持比标准常服更正式的同时，仍具实用性。这件属于一名军官。"
	icon_state = "formal_jumpsuit"
	worn_state = "formal_jumpsuit"
	specialty = "command formal"
	black_market_value = 20

//=========================//DRESS BLUES\\================================\\
//=======================================================================\\

/obj/item/clothing/under/marine/dress/blues
	name = "陆战队员蓝色常服（士兵）"
	desc = "传奇的陆战队员蓝色常服衬衫与长裤，自19世纪以来几乎未曾改变。这款朴素版本供E-1至E-3级士兵使用。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)
	icon_state = "enlisted"
	worn_state = "enlisted"

/obj/item/clothing/under/marine/dress/blues/senior
	name = "陆战队员蓝色常服（士官/军官）"
	desc = "传奇的陆战队员蓝色常服衬衫与长裤，自19世纪以来几乎未曾改变。此版本带有标志性的血条，由士官和军官穿着。"
	icon_state = "senior"
	worn_state = "senior"

/obj/item/clothing/under/marine/dress/blues/general
	name = "陆战队员蓝色常服（士官/军官）"
	desc = "传奇的陆战队员蓝色常服衬衫与长裤，自19世纪以来几乎未曾改变。此版本为黑色长裤配宽大血条，供将官穿着。"
	icon_state = "general"
	worn_state = "general"

//=========================//PROVOST\\================================\\
//=======================================================================\\

/obj/item/clothing/under/marine/mp/provost
	flags_jumpsuit = FALSE
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE

	name = "\improper USCM military police utility uniform"
	desc = "美国殖民地海军陆战队军事站点和基地上大多数宪兵的标准配发制服。穿着此制服的军官通常隶属于USCM宪兵办公室。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)
	icon_state = "provost"
	worn_state = "provost"

	specialty = "provost"

	suit_restricted = list(
		/obj/item/clothing/suit/storage/marine/MP,
		/obj/item/clothing/suit/armor/riot/marine,
		/obj/item/clothing/suit/storage/jacket/marine/provost,
	)

	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT

/obj/item/clothing/under/marine/mp/provost/chief
	name = "\improper service 'A' officer winter uniform"
	desc = "A类常服的冬季版本，常由宪兵办公室的军官穿着。"
	icon_state = "provost_ci"
	worn_state = "provost_ci"


//=========================//USCM Survivors\\================================\\
//=======================================================================\\

/obj/item/clothing/under/marine/reconnaissance
	name = "\improper USCM uniform"
	desc = "撕裂、烧焦、血迹斑斑。这套制服经历的远超你的想象。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)
	icon_state = "recon_marine"
	worn_state = "recon_marine"
	flags_atom = NO_GAMEMODE_SKIN

/obj/item/clothing/under/marine/reconnaissance/Initialize(mapload)
	. = ..()
	var/R = rand(1,4)
	switch(R) //this is no longer shitcode, courtesy of stan_albatross
		if(1)
			roll_suit_sleeves(FALSE)
		if(2)
			roll_suit_jacket(FALSE)
		if(3)
			cut_suit_jacket(FALSE)


//=========================//RESPONDERS\\================================\\
//=======================================================================\\

/obj/item/clothing/under/marine/veteran
	flags_jumpsuit = FALSE
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE //Let's make them keep their original name.

//=========================//Marine Raiders\\================================\\

/obj/item/clothing/under/marine/veteran/marsoc
	name = "特种作战部队制服"
	desc = "精英陆战队员的黑色制服。设计舒适，有助于融入黑暗环境。"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)
	icon_state = "marsoc"
	worn_state = "marsoc"
	specialty = "sof uniform"
	flags_item = NO_GAMEMODE_SKIN

//=========================//PMC\\================================\\

/obj/item/clothing/under/marine/veteran/pmc
	name = "\improper PMC fatigues"
	desc = "一套白色作训服，为私人安保人员设计。维兰德-汤谷公司的标志醒目地印在制服上。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/WY.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/WY.dmi',
	)
	icon_state = "pmc_jumpsuit"
	worn_state = "pmc_jumpsuit"
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	undershirt = TRUE
	suit_restricted = list(
		/obj/item/clothing/suit/storage/marine/veteran/pmc,
		/obj/item/clothing/suit/storage/marine/smartgunner/veteran/pmc,
		/obj/item/clothing/suit/armor/vest/security,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/suit/storage/labcoat,
		/obj/item/clothing/suit/storage/jacket/marine,
		/obj/item/clothing/suit/storage/CMB/trenchcoat,
		/obj/item/clothing/suit/storage/windbreaker,
		/obj/item/clothing/suit/storage/snow_suit,
	) //if you remove this, it allows you to wear the marine M3 armor over the pmc fatigues

/obj/item/clothing/under/marine/veteran/pmc/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/under/marine/veteran/pmc/leader
	name = "\improper PMC command fatigues"
	desc = "一套白色作训服，为私人安保人员设计。维兰德-汤谷公司的标志醒目地印在制服上。这套制服看起来属于高级军官。"
	icon_state = "officer_jumpsuit"
	worn_state = "officer_jumpsuit"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE

/obj/item/clothing/under/marine/veteran/pmc/leader/commando
	name = "\improper W-Y Commando fatigues"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE

/obj/item/clothing/under/marine/veteran/pmc/leader/commando/leader
	name = "\improper W-Y Commando leader fatigues"
	icon_state = "commando_leader"
	worn_state = "commando_leader"
	flags_jumpsuit = null

/obj/item/clothing/under/marine/veteran/pmc/engineer
	name = "\improper PMC engineer fatigues"
	desc = "一套黑橙色作训服，为私人安保技术人员设计。维兰德-汤谷公司的标志醒目地印在制服上。"
	icon_state = "engineer_jumpsuit"
	worn_state = "engineer_jumpsuit"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE

/obj/item/clothing/under/marine/veteran/pmc/guard
	name = "\improper PMC guard fatigues"
	desc = "一套黑橙色作训服，为私人安保执法队员设计。维兰德-汤谷公司的标志醒目地印在制服上。"
	icon_state = "guard_jumpsuit"
	worn_state = "guard_jumpsuit"

/obj/item/clothing/under/marine/veteran/pmc/apesuit
	name = "\improper W-Y commando Apesuit uniform"
	desc = "维兰德-汤谷精英突击队员穿着的装甲制服。防护良好，同时保持轻便舒适。"
	icon_state = "ape_jumpsuit"
	worn_state = "ape_jumpsuit"

/obj/item/clothing/under/marine/veteran/pmc/combat_android
	name = "\improper W-Y android combat uniform"
	desc = "维兰德-汤谷战斗合成人穿着的装甲制服。防护良好，同时保持轻便舒适。"
	icon_state = "combat_android_uniform"
	worn_state = "combat_android_uniform"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/veteran/pmc/combat_android/dark
	desc = "兼容光学迷彩的装甲制服，由维兰德-汤谷战斗合成人穿着。防护良好，同时保持轻便舒适。"
	icon_state = "invis_android_uniform"
	worn_state = "invis_android_uniform"

/obj/item/clothing/under/marine/veteran/pmc/corporate
	name = "\improper W-Y corporate security uniform"
	desc = "维兰德-汤谷公司安保人员穿着的装甲制服。这种款式通常被所谓的‘打手’穿着。"
	icon_state = "sec_uniform"
	worn_state = "sec_uniform"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE

/obj/item/clothing/under/marine/veteran/pmc/corporate/medic //TODO: make this an armband accessory instead of a jumpsuit
	name = "\improper W-Y corporate security medic uniform"
	desc = "维兰德-汤谷公司安保成员穿着的装甲制服。此版本带有红色臂章，表明穿着者的医疗职能。"
	icon_state = "med_uniform"
	item_state = "med_uniform"
	worn_state = "med_uniform"

/obj/item/clothing/under/marine/veteran/pmc/corporate/engineer //TODO: make this an armband accessory instead of a jumpsuit
	name = "\improper W-Y corporate security engineer uniform"
	desc = "维兰德-汤谷公司安保成员穿着的装甲制服。此版本带有黄色臂章，表明穿着者的技术职能。"
	icon_state = "eng_uniform"
	item_state = "eng_uniform"
	worn_state = "eng_uniform"

/obj/item/clothing/under/marine/veteran/pmc/corporate/lead
	name = "\improper W-Y corporate security leader uniform"
	desc = "维兰德-汤谷公司安保人员穿着的装甲制服。这种款式通常由俗称‘打手小队’的队长穿着。"
	icon_state = "sec_lead_uniform"
	item_state = "sec_lead_uniform"
	worn_state = "sec_lead_uniform"

/obj/item/clothing/under/marine/veteran/pmc/corporate/kutjevo
	desc = "维兰德-汤谷公司安保成员穿着的装甲制服。此版本更透气，适用于炎热干燥的环境。"
	icon_state = "sec_kutjevo_uniform"
	item_state = "sec_kutjevo_uniform"
	worn_state = "sec_kutjevo_uniform"

/obj/item/clothing/under/marine/veteran/pmc/corporate/kutjevo/lead
	desc = "维兰德-汤谷公司安保成员穿着的装甲制服。此版本更透气，适用于炎热干燥的环境，并带有金色臂章表明其为队长。"
	icon_state = "sec_lead_kutjevo_uniform"
	item_state = "sec_lead_kutjevo_uniform"
	worn_state = "sec_lead_kutjevo_uniform"

//=========================//UPP\\================================\\

/obj/item/clothing/under/marine/veteran/bear
	name = "\improper Iron Bear uniform"
	desc = "为俄罗斯母亲服务的“铁熊”雇佣兵穿着的制服。闻起来有点像真正的熊。"
	icon_state = "bear_jumpsuit"
	icon = 'icons/obj/items/clothing/uniforms/misc_ert_colony.dmi'
	worn_state = "bear_jumpsuit"
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	has_sensor = UNIFORM_NO_SENSORS
	suit_restricted = list(/obj/item/clothing/suit/storage/marine/veteran/bear)

	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/misc_ert_colony.dmi',
	)

/obj/item/clothing/under/marine/veteran/UPP
	name = "\improper UPP fatigues"
	desc = "一套UPP作训服，为进步人民联盟武装部队大规模生产。在ICC区域尤为罕见。这套特定服装采用UPP第17营“闷燃之子”的暗沉色调迷彩，该营在英日臂稀疏的UPP边境地带活动。"
	icon_state = "upp_uniform"
	worn_state = "upp_uniform"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UPP.dmi'
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	has_sensor = UNIFORM_HAS_SENSORS
	suit_restricted = list(/obj/item/clothing/suit/storage/marine/faction/UPP, /obj/item/clothing/suit/gimmick/jason, /obj/item/clothing/suit/storage/snow_suit/soviet, /obj/item/clothing/suit/storage/snow_suit/survivor, /obj/item/clothing/suit/storage/webbing, /obj/item/clothing/suit/storage/webbing/brown, /obj/item/clothing/suit/storage/webbing/black)
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	undershirt = TRUE

	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UPP.dmi'
	)

/obj/item/clothing/under/marine/veteran/UPP/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/norcomm)

/obj/item/clothing/under/marine/veteran/UPP/medic
	name = "\improper UPP medic fatigues"
	desc = "一套UPP医疗兵作训服，为进步人民联盟武装部队大规模生产。在ICC区域尤为罕见。这套特定服装采用UPP第17营“闷燃之子”的暗沉色调迷彩，该营在英日臂稀疏的UPP边境地带活动。"
	icon_state = "upp_uniform_medic"
	worn_state = "upp_uniform_medic"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE

/obj/item/clothing/under/marine/veteran/UPP/engi
	name = "\improper UPP engineer fatigues"
	desc = "一套UPP工程师作训服，为进步人民联盟武装部队大规模生产。在ICC区域尤为罕见。这套特定服装采用UPP第17营“闷燃之子”的暗沉色调迷彩，该营在英日臂稀疏的UPP边境地带活动。"
	icon_state = "upp_uniform_engi"
	worn_state = "upp_uniform_engi"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE

/obj/item/clothing/under/marine/veteran/UPP/mp
	name = "\improper UPP Military Police fatigues"
	desc = "一套进步人民联盟武装部队大规模生产的宪兵制服。在ICC区域尤为罕见。这套制服采用UPP第17营“闷燃之子”的暗沉土褐色迷彩，该营在盎格鲁-日耳曼臂稀疏的UPP边境地带活动。"
	icon_state = "upp_uniform_mp"
	worn_state = "upp_uniform_mp"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE

/obj/item/clothing/under/marine/veteran/UPP/officer
	name = "\improper UPP Officer fatigues"
	desc = "一套进步人民联盟武装部队大规模生产的军官制服。在ICC区域尤为罕见。这套制服采用UPP第17营“闷燃之子”的暗沉土褐色迷彩，该营在盎格鲁-日耳曼臂稀疏的UPP边境地带活动。"
	icon_state = "upp_uniform_officer"
	worn_state = "upp_uniform_officer"

/obj/item/clothing/under/marine/veteran/UPP/civi1
	name = "\improper UPP Civilian-style Orange overalls"
	desc = "一套平民风格的橙色工装裤，配深褐色汗衫。材质低劣，但总比没有强。这种款式的服装通常发放给从事繁重体力劳动的人。"
	icon_state = "upp_uniform_civi1"
	worn_state = "upp_uniform_civi1"
	suit_restricted = FALSE

/obj/item/clothing/under/marine/veteran/UPP/civi2
	name = "\improper UPP Civilian-style tan overalls"
	desc = "一套平民风格的土黄色工装裤，配蓝色汗衫。材质低劣，但总比没有强。这种款式的服装通常发放给从事繁重体力劳动的人。"
	icon_state = "upp_uniform_civi2"
	worn_state = "upp_uniform_civi2"
	suit_restricted = FALSE

/obj/item/clothing/under/marine/veteran/UPP/civi3
	name = "\improper UPP Civilian-style shirt and pants"
	desc = "一套平民风格的土黄色衬衫和牛仔裤。材质虽差，但足够舒适，适合全天穿着。"
	icon_state = "upp_uniform_civi3"
	worn_state = "upp_uniform_civi3"
	suit_restricted = FALSE

/obj/item/clothing/under/marine/veteran/UPP/civi4
	name = "\improper UPP Civilian-style Vest and pants"
	desc = "一套平民风格的棕色背心和橙色长裤。材质出奇地不错，UPP平民很少穿这种衣服有两个原因：他们通常负担不起，而且如果穿得起，反而会让自己成为目标。"
	icon_state = "upp_uniform_civi4"
	worn_state = "upp_uniform_civi4"
	suit_restricted = FALSE

/obj/item/clothing/under/marine/veteran/UPP/civi5
	name = "\improper Jùtóu Combine mining overalls"
	desc = "一套耐用的橄榄绿连体工作服，外穿无袖蓬松橙色工作背心——巨头联合体劳工的标准配备。背心面料褪色，内衬加固垫料，对工作场所危险提供最低限度的防护。背面印有红星徽章，标志着穿戴者属于联合体产业工人队伍。僵硬、不舒适、大规模生产，但在严酷的深空劳动环境中总比没有强。"
	icon_state = "miner_uniform"
	worn_state = "miner_uniform"
	suit_restricted = FALSE

/obj/item/clothing/under/marine/veteran/UPP/army
	name = "\improper UPP army jungle fatigues"
	desc =  "一套进步人民联盟武装集体大规模生产的UPP作战服。在3WE区域尤为罕见。这套制服采用UPP陆军第202步兵团丛林迷彩。"
	icon_state = "upp_army_green_uniform"
	worn_state = "upp_army_green_uniform"
	suit_restricted = FALSE

/obj/item/clothing/under/marine/veteran/UPP/army/alt
	name = "\improper UPP Army fatigues"
	desc = "一套进步人民联盟武装集体大规模生产的UPP作战服。在3WE区域尤为罕见。这套制服采用UPP陆军第202步兵团标准UPP迷彩。"
	icon_state = "upp_army_yellow_uniform"
	worn_state = "upp_army_yellow_uniform"

// UPP SOF

/obj/item/clothing/under/marine/veteran/UPP/SOF_uniform
	name = "\improper CCC5-L compression undersuit"
	desc = "一套温度调节压力服，构成CCC5-L系统的基层。提供压缩支撑、有限的真空防护、吸湿排汗特性以及NBC防护，以维持操作员在危险环境下的生存。"
	icon_state = "sof_uniform"
	worn_state = "sof_uniform"

/obj/item/clothing/under/marine/veteran/UPP/pap
	name = "\improper PaP service uniform"
	desc = "一条蓝灰色长裤搭配蓝色衬衫，关键部位嵌有维纳拉护甲插片，可防护刀刃及小口径弹道攻击。"
	icon_state = "upp_uniform_pap"
	worn_state = "upp_uniform_pap"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE|UNIFORM_JACKET_REMOVABLE
	suit_restricted = FALSE

//=========================//CMB\\================================\\


/obj/item/clothing/under/marine/veteran/cmb
	name = "\improper CMB Riot Control uniform"
	desc = "一套殖民地治安官使用的深色战术制服，专为在殖民地管辖下的遥远世界执行防暴任务的单位设计。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/CMB.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/CMB.dmi',
	)
	icon_state = "cmb_swat_uniform"
	worn_state = "cmb_swat_uniform"
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	has_sensor = UNIFORM_HAS_SENSORS
	suit_restricted = list(
		/obj/item/clothing/suit/storage/marine/veteran/cmb,
		/obj/item/clothing/suit/storage/marine/MP,
		/obj/item/clothing/suit/storage/CMB,
		/obj/item/clothing/suit/armor/riot/marine,
		/obj/item/clothing/suit/armor/vest/security,
		/obj/item/clothing/suit/storage/hazardvest,
	)

/obj/item/clothing/under/marine/veteran/cmb/marshal
	name = "\improper CMB Riot Control Marshal uniform"
	desc = "一套殖民地治安官使用的深色战术制服，其金色徽章表明这是防暴控制指挥人员的着装。"
	icon_state = "cmb_swatleader_uniform"
	worn_state = "cmb_swatleader_uniform"


//=========================//Freelancer\\================================\\

/obj/item/clothing/under/marine/veteran/freelancer
	name = "\improper freelancer fatigues"
	desc = "一套宽松的作战服，非常适合非正式的雇佣兵。闻起来有火药、苹果派的味道，并沾满了油脂和清酒的污渍。"
	icon_state = "freelancer_uniform"
	worn_state = "freelancer_uniform"
	icon = 'icons/obj/items/clothing/uniforms/misc_ert_colony.dmi'
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	has_sensor = UNIFORM_NO_SENSORS
	suit_restricted = list(/obj/item/clothing/suit/storage/marine/faction/freelancer, /obj/item/clothing/suit/storage/webbing, /obj/item/clothing/suit/storage/utility_vest)
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/misc_ert_colony.dmi',
	)


//=========================//Dutch Dozen\\================================\\

/obj/item/clothing/under/marine/veteran/dutch
	name = "\improper Dutch's Dozen uniform"
	desc = "荷兰十二人雇佣兵穿着的舒适制服。有明显的磨损痕迹，但状态依然良好。"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS
	icon = 'icons/obj/items/clothing/uniforms/misc_ert_colony.dmi'
	icon_state = "dutch_jumpsuit"
	worn_state = "dutch_jumpsuit"
	has_sensor = UNIFORM_NO_SENSORS
	suit_restricted = list(/obj/item/clothing/suit/storage/marine/veteran/dutch, /obj/item/clothing/suit/armor/vest/dutch)
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/misc_ert_colony.dmi',
	)

/obj/item/clothing/under/marine/veteran/dutch/ranger
	icon_state = "dutch_jumpsuit2"

/obj/item/clothing/under/marine/veteran/dutch/vietnam
	name = "\improper US Army uniform"
	desc = "标准制式陆军制服。越战期间使用。"

/obj/item/clothing/under/marine/veteran/van_bandolier
	name = "狩猎服"
	desc = "一套剪裁得体的服装，由优质但坚固的强化织物制成。可防护荆棘、恶劣天气，以及永远困扰户外活动者的割伤和擦伤。"
	icon = 'icons/obj/items/clothing/uniforms/misc_ert_colony.dmi'
	icon_state = "van_bandolier"
	worn_state = "van_bandolier"
	item_state = "van_bandolier_clothes"
	flags_cold_protection = ICE_PLANET_MIN_COLD_PROT
	has_sensor = UNIFORM_NO_SENSORS
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/misc_ert_colony.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/uniforms_righthand.dmi',
	)

//=========================//OWLF\\================================\\

/obj/item/clothing/under/marine/veteran/owlf
	name = "\improper OWLF thermal field uniform"
	desc = "一套内置热光学隐形技术的高科技制服。看起来比你的命还值钱。"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS //This is all a copy and paste of the Dutch's stuff for now.
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS
	icon = 'icons/obj/items/clothing/uniforms/misc_ert_colony.dmi'
	icon_state = "owlf_uniform"
	worn_state = "owlf_uniform"
	has_sensor = UNIFORM_NO_SENSORS
	hood_state = /obj/item/clothing/head/owlf_hood
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/misc_ert_colony.dmi',
	)

//===========================//HELGHAST - MERCENARY\\================================\\
//=====================================================================\\

/obj/item/clothing/under/marine/veteran/mercenary
	name = "\improper Mercenary fatigues"
	desc = "一套厚实的米色套装，配有红色臂章。套装上印有一个未知符号。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/CLF.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/CLF.dmi',
	)
	icon_state = "mercenary_heavy_uniform"
	worn_state = "mercenary_heavy_uniform"
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT

/obj/item/clothing/under/marine/veteran/mercenary/miner
	name = "\improper Mercenary miner fatigues"
	desc = "一套米色套装，配有红色臂章。看起来有点薄，似乎并非为防护设计。套装上印有一个未知符号。"
	icon_state = "mercenary_miner_uniform"
	worn_state = "mercenary_miner_uniform"

/obj/item/clothing/under/marine/veteran/mercenary/support
	name = "\improper Mercenary engineer fatigues"
	desc = "一套带黄色点缀的蓝色套装，供工程师使用。套装上印有一个未知符号。"
	icon_state = "mercenary_engineer_uniform"
	worn_state = "mercenary_engineer_uniform"


////// Civilians /////////

/obj/item/clothing/under/marine/ua_riot
	name = "\improper United American security uniform"
	desc = "凯夫纶制成的工装裤罩着一件时髦的蓝色正装衬衫。UA品牌的安保制服因其与反工会防暴队的关联而声名狼藉。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)
	icon_state = "ua_riot"
	worn_state = "ua_riot"
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE //Let's make them keep their original name.
	flags_jumpsuit = FALSE
	suit_restricted = null

/obj/item/clothing/under/marine/ua_riot/police
	name = "\improper United American police uniform"
	desc = "美国海军陆战队和陆军人员标准制服的变体，染成海军蓝色，通常由警察在高强度局势下穿着。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/CMB.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/CMB.dmi',
	)
	icon_state = "police_riot"
	worn_state = "police_riot"

/obj/item/clothing/under/pizza
	name = "披萨配送制服"
	desc = "一件不合身、略有污渍的披萨配送飞行员制服。闻起来有奶酪味。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/security.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/security.dmi',
	)
	icon_state = "redshirt2"
	worn_state = "redshirt2"
	has_sensor = UNIFORM_NO_SENSORS

/obj/item/clothing/under/souto
	name = "\improper Souto Man's cargo pants"
	desc = "独一无二的Souto员工所穿的白色工装裤。像一罐冰镇的Souto葡萄汽水一样酷！"
	icon_state = "souto_man"
	worn_state = "souto_man"
	has_sensor = UNIFORM_NO_SENSORS

/obj/item/clothing/under/colonist
	name = "殖民者连体服"
	desc = "一件时髦的灰绿色连体服。维兰德-汤谷非专业殖民者的标准配发品。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/WY.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/WY.dmi',
	)
	icon_state = "colonist"
	worn_state = "colonist"
	has_sensor = UNIFORM_HAS_SENSORS

/obj/item/clothing/under/colonist/Initialize()
	. = ..()
	if(istypestrict(src, /obj/item/clothing/under/colonist))
		AddElement(/datum/element/corp_label/wy)
	if(istypestrict(src, /obj/item/clothing/under/colonist/administrator))
		AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/under/colonist/administrator
	name = "管理员制服"
	desc = "一件办公室灰色Polo衫，胸前有维兰德-汤谷徽章。由公司所属殖民地的管理员穿着。"
	icon_state = "colony_admin"
	worn_state = "colony_admin"

/obj/item/clothing/under/colonist/workwear
	name = "灰色工作服"
	desc = "一条黑色休闲裤和一件灰色短袖工作衫。维兰德-汤谷在殖民地运营和行政部门工作的员工的标准制服。"
	icon = 'icons/obj/items/clothing/uniforms/workwear.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/workwear.dmi',
	)
	flags_bodypart_hidden = BODY_FLAG_CHEST|BODY_FLAG_LEGS
	icon_state = "workwear_grey"
	worn_state = "workwear_grey"

/obj/item/clothing/under/colonist/workwear/khaki
	name = "卡其色工作服"
	desc = "一条牛仔裤搭配一件卡其色工作衫。因其单调的外观而在蓝领工人中常见。"
	icon_state = "workwear_khaki"
	worn_state = "workwear_khaki"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE|UNIFORM_JACKET_REMOVABLE

/obj/item/clothing/under/colonist/workwear/pink
	name = "粉色工作服"
	desc = "一条牛仔裤搭配一件粉色工作衫。粉色？你妻子可能不这么认为，但这种奇装异服值得公司安保部门盘问。你是什么，某种自由思想的无政府主义者？"
	icon_state = "workwear_pink"
	worn_state = "workwear_pink"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE|UNIFORM_JACKET_REMOVABLE

/obj/item/clothing/under/colonist/workwear/blue
	name = "蓝色工作服"
	desc = "一条棕色帆布工装裤搭配一件深蓝色工作衫。蓝领工人中的常见搭配。"
	icon_state = "workwear_blue"
	worn_state = "workwear_blue"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE|UNIFORM_JACKET_REMOVABLE

/obj/item/clothing/under/colonist/workwear/green
	name = "绿色工作服"
	desc = "一条棕色帆布工装裤搭配一件绿色工作衫。蓝领工人中的常见搭配。"
	icon_state = "workwear_green"
	worn_state = "workwear_green"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE|UNIFORM_JACKET_REMOVABLE

/obj/item/clothing/under/colonist/clf
	name = "\improper Colonial Liberation Front uniform"
	desc = "一件时髦的灰绿色连体服——殖民者的标准配发品。这个版本似乎在某些区域印有殖民地解放阵线的标志。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/CLF.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/CLF.dmi',
	)
	icon_state = "clf_uniform"
	worn_state = "clf_uniform"

/obj/item/clothing/under/colonist/white_service
	name = "白色公务制服"
	desc = "一件白色正装衬衫、领带和修身长裤。任何从事专业商务人士的标准服装。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)
	icon_state = "CO_service"
	worn_state = "CO_service"
	has_sensor = UNIFORM_HAS_SENSORS

/obj/item/clothing/under/colonist/steward
	name = "乘务员便服"
	desc = "一件时髦的棕色背心和短裤——店员和工会代表常穿这类制服。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)
	icon_state = "steward"
	worn_state = "steward"
	has_sensor = UNIFORM_HAS_SENSORS

/obj/item/clothing/under/tshirt
	name = "T恤父对象"
	icon = 'icons/obj/items/clothing/uniforms/workwear.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/workwear.dmi',
	)
	has_sensor = UNIFORM_NO_SENSORS

/obj/item/clothing/under/tshirt/w_br
	name = "白色T恤和棕色长裤"
	desc = "一件舒适的白色T恤和棕色牛仔裤。"
	icon_state = "tshirt_w_br"
	worn_state = "tshirt_w_br"
	displays_id = FALSE
	has_sensor = UNIFORM_HAS_SENSORS

/obj/item/clothing/under/tshirt/gray_blu
	name = "灰色T恤和牛仔裤"
	desc = "一件舒适的灰色T恤和蓝色牛仔裤。"
	icon_state = "tshirt_gray_blu"
	worn_state = "tshirt_gray_blu"
	displays_id = FALSE
	has_sensor = UNIFORM_HAS_SENSORS

/obj/item/clothing/under/tshirt/r_bla
	name = "红色T恤和黑色长裤"
	desc = "一件舒适的红色T恤和黑色牛仔裤。"
	icon_state = "tshirt_r_bla"
	worn_state = "tshirt_r_bla"
	displays_id = FALSE
	has_sensor = UNIFORM_HAS_SENSORS

/obj/item/clothing/under/CM_uniform
	name = "\improper Colonial Marshal uniform"
	desc = "一条米白色长裤和一件蓝色纽扣衬衫，配深棕色领带；这是殖民地执法官的标准制服。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/CMB.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/CMB.dmi',
	)
	icon_state = "marshal"
	worn_state = "marshal"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE|UNIFORM_JACKET_REMOVABLE

/obj/item/clothing/under/liaison_suit
	name = "联络员的棕褐色西装"
	desc = "一套挺括、时髦的棕褐色西装，常见于维兰德-汤谷公司的商人。精工细作，让你看起来像个混蛋。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/WY.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/WY.dmi',
	)
	icon_state = "liaison_regular"
	worn_state = "liaison_regular"

/obj/item/clothing/under/liaison_suit/charcoal
	name = "联络员的炭灰色西装"
	desc = "一套挺括、时髦的炭灰色西装，常见于维兰德-汤谷公司的商人。精工细作，让你看起来像个混蛋。"
	icon_state = "liaison_charcoal"
	worn_state = "liaison_charcoal"

/obj/item/clothing/under/liaison_suit/charcoal/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/under/liaison_suit/charcoal/skirt
	name = "联络员的炭灰色西装套裙"
	desc = "一套挺括、时髦的炭灰色西装，常见于维兰德-汤谷公司的女商人。精工细作，让你看起来像个混蛋。"
	icon_state = "liaison_charcoal_skirt"
	worn_state = "liaison_charcoal_skirt"

/obj/item/clothing/under/liaison_suit/outing
	name = "联络员的便装"
	desc = "一套休闲装，包括一件有领衬衫和一件背心。看起来像是你周末或访问废弃殖民地时会穿的衣服。"
	icon_state = "liaison_outing"
	worn_state = "liaison_outing"

/obj/item/clothing/under/liaison_suit/outing/red
	icon_state = "liaison_outing_red"
	worn_state = "liaison_outing_red"

/obj/item/clothing/under/liaison_suit/formal
	name = "联络员的白色西装"
	desc = "一套正式的白色西装。看起来像是参加葬礼、维兰德-汤谷公司晚宴或两者兼有时会穿的衣服。硬得像块板，但让你感觉像是从劳斯莱斯里走出来一样。"
	icon_state = "liaison_formal"
	worn_state = "liaison_formal"

/obj/item/clothing/under/liaison_suit/formal/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/under/liaison_suit/suspenders
	name = "联络员的背带装"
	desc = "一件有领衬衫，配以一副背带。由那些提出尖锐问题的维兰德-汤谷员工穿着。隐约散发着雪茄和蹩脚演技的气味。"
	icon_state = "liaison_suspenders"
	worn_state = "liaison_suspenders"

/obj/item/clothing/under/liaison_suit/suspenders/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/under/liaison_suit/blazer
	name = "联络员的蓝色西装外套"
	desc = "一件挺括但休闲的蓝色西装外套。类似的款式在任何维兰德-汤谷办公室都能找到。只为银河系最狡猾的人提供最优质的穿着。"
	icon_state = "liaison_blue_blazer"
	worn_state = "liaison_blue_blazer"

/obj/item/clothing/under/liaison_suit/blazer/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/under/liaison_suit/field
	name = "商务休闲装"
	desc = "一条深棕色长裤搭配一件深蓝色纽扣衬衫。这是企业界人士中流行的造型，他们的大部分业务都在夜总会进行。"
	icon_state = "corporate_field"
	worn_state = "corporate_field"

/obj/item/clothing/under/liaison_suit/field/skirt
	name = "商务休闲裙装"
	desc = "一条黑色铅笔裙搭配一件深蓝色纽扣衬衫。这是企业界人士中流行的造型，他们的大部分业务都在夜总会进行。"
	icon_state = "corporate_field_skirt"
	worn_state = "corporate_field_skirt"

/obj/item/clothing/under/liaison_suit/ivy
	name = "乡村俱乐部装束"
	desc = "一条卡其色长裤搭配一件浅蓝色纽扣衬衫。这是企业界人士中流行的造型，他们的大部分业务都在乡村俱乐部进行。"
	icon_state = "corporate_ivy"
	worn_state = "corporate_ivy"

/obj/item/clothing/under/liaison_suit/orange
	name = "橙色装束"
	desc = "一条黑色长裤搭配一件极具维兰德-汤谷风格的橙色衬衫。这是那些主要在维兰德-汤谷办公室处理业务的商界人士的流行装扮。"
	icon_state = "corporate_orange"
	worn_state = "corporate_orange"

/obj/item/clothing/under/liaison_suit/corporate_formal
	name = "白色西裤"
	desc = "一条象牙色休闲裤搭配一件白衬衫。这是正式公司活动的流行搭配。"
	icon_state = "corporate_formal"
	worn_state = "corporate_formal"

/obj/item/clothing/under/liaison_suit/black
	name = "黑色西裤"
	desc = "一条黑色休闲裤搭配一件白衬衫。这是公司职员中最常见的搭配。"
	icon_state = "corporate_black"
	worn_state = "corporate_black"

/obj/item/clothing/under/liaison_suit/black/skirt
	name = "黑色西装裙"
	desc = "一条黑色铅笔裙搭配一件白衬衫。这是公司职员中常见的搭配。"
	icon_state = "corporate_black_skirt"
	worn_state = "corporate_black_skirt"

/obj/item/clothing/under/liaison_suit/brown
	name = "棕色西裤"
	desc = "一条棕色休闲裤搭配一件白衬衫。这是公司职员中常见的搭配。"
	icon_state = "corporate_brown"
	worn_state = "corporate_brown"

/obj/item/clothing/under/liaison_suit/blue
	name = "蓝色西裤"
	desc = "一条蓝色休闲裤搭配一件白衬衫。这是公司职员中常见的搭配。"
	icon_state = "corporate_blue"
	worn_state = "corporate_blue"

/obj/item/clothing/under/marine/reporter
	name = "战地记者制服"
	desc = "一套宽松而结实的制服，适合任何潜在的报道需求。"
	icon_state = "cc_white"
	worn_state = "cc_white"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	flags_atom = NO_GAMEMODE_SKIN|NO_NAME_OVERRIDE
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)

/obj/item/clothing/under/marine/reporter/black
	icon_state = "cc_black"
	worn_state = "cc_black"

/obj/item/clothing/under/marine/reporter/orange
	icon_state = "cc_orange"
	worn_state = "cc_orange"

/obj/item/clothing/under/marine/reporter/red
	icon_state = "cc_red"
	worn_state = "cc_red"

/obj/item/clothing/under/twe_suit
	name = "代表精制西装"
	desc = "一套挺括、时尚的蓝色西装，通常由三世界帝国的绅士穿着。精湛的工艺旨在让你看起来尽可能重要。"
	icon_state = "twe_suit"
	worn_state = "twe_suit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/TWE.dmi',
	)

/obj/item/clothing/under/stowaway
	name = "脏污西装"
	desc = "一套挺括、时髦的棕褐色西装，常见于维兰德-汤谷公司的商人。精工细作，让你看起来像个混蛋。"
	icon_state = "stowaway_uniform"
	worn_state = "stowaway_uniform"
	icon = 'icons/obj/items/clothing/uniforms/formal_uniforms.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/formal_uniforms.dmi',
	)

/obj/item/clothing/under/stowaway/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/under/rank/chef/exec
	name = "\improper Weyland-Yutani suit"
	desc = "一件正式的白色内衬服。"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/chef/exec/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/under/rank/qm_suit
	name = "军需官制服"
	desc = "一套合身的军需官军服。它含有轻型凯夫拉碎片，有助于防御刺击武器和子弹。"
	icon_state = "RO_jumpsuit"
	worn_state = "RO_jumpsuit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/cargo.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/cargo.dmi',
	)
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE

/obj/item/clothing/under/rank/synthetic
	name = "\improper USCM Support Uniform"
	desc = "为合成人船员制作的简单制服。"
	icon_state = "rdalt"
	worn_state = "rdalt"
	icon = 'icons/obj/items/clothing/uniforms/synthetic_uniforms.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/synthetic_uniforms.dmi',
	)
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/synthetic/synth_k9
	name = "\improper W-Y K9 serial identification collar"
	desc = "包含一个与本机生产日期和时间相关的序列化制造编号。"
	icon = 'icons/mob/humans/species/synth_k9/onmob/synth_k9_overlays.dmi'
	flags_item = NODROP
	icon_state = "k9_dogtags"
	worn_state = "k9_dogtags"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/rank/frontier
	name = "\improper frontier jumpsuit"
	desc = "一件为全方位活动范围和前沿温度控制而设计的工装连体服。这是工程师在外层星域能穿的最佳装备。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)
	icon_state = "cargo_light"
	worn_state = "cargo_light"
	displays_id = FALSE

/obj/item/clothing/under/rank/utility
	name = "\improper green utility uniform"
	desc = "一套绿底绿纹的实用制服，通常配发给边疆地区的UA合同工。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)
	icon_state = "green_utility"
	worn_state = "green_utility"
	displays_id = FALSE

/obj/item/clothing/under/rank/utility/upp
	name = "\improper green utility uniform"
	desc = "一套绿底绿纹的实用制服，通常配发给边疆地区的UPP工人。"
	has_sensor = UNIFORM_HAS_SENSORS
	suit_restricted = FALSE
	armor_energy = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/rank/utility/yellow
	name = "\improper yellow utility uniform"
	desc = "一套灰色实用制服，配有黄色背带，专为舰上船员制作。"
	icon_state = "yellow_utility"
	worn_state = "yellow_utility"

/obj/item/clothing/under/rank/utility/red
	name = "\improper red utility uniform"
	desc = "一套灰色工装，配有红色背带和蓝色牛仔裤，这是资深劳工或非时薪雇员的标志。"
	icon_state = "red_utility"
	worn_state = "red_utility"

/obj/item/clothing/under/rank/utility/blue
	name = "\improper blue utility uniform"
	desc = "一套蓝色工装，配有青色背带和耐磨长裤。"
	icon_state = "blue_utility"
	worn_state = "blue_utility"

/obj/item/clothing/under/rank/utility/gray
	name = "\improper gray utility uniform"
	desc = "一套时髦的灰色连体服，通常配发给UA在边疆的合同工。"
	icon_state = "grey_utility"
	worn_state = "grey_utility"

/obj/item/clothing/under/rank/utility/brown
	name = "\improper brown utility uniform"
	desc = "一套时髦的棕色连体服，通常配发给UA在边疆的合同工。"
	icon_state = "brown_utility"
	worn_state = "brown_utility"
	has_sensor = UNIFORM_HAS_SENSORS

/obj/item/clothing/under/rank/utility/brown/upp
	name = "棕色工装"
	desc = "UPP工人和应急人员穿着的耐磨工装连体服。由热处理合成纤维制成，关键部位得到加固，能提供基本的防热和防物理伤害保护。虽然实用，但其厚重的面料和过时的设计反映了联盟对耐用性而非舒适性的重视。"
	icon_state = "brown_utility"
	worn_state = "brown_utility"
	has_sensor = UNIFORM_HAS_SENSORS
	suit_restricted = FALSE
	armor_energy = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/rank/utility/gray/upp
	name = "\improper gray utility uniform"
	desc = "UPP工人和应急人员穿着的耐磨工装连体服。由热处理合成纤维制成，关键部位得到加固，能提供基本的防热和防物理伤害保护。虽然实用，但其厚重的面料和过时的设计反映了联盟对耐用性而非舒适性的重视。"
	icon_state = "grey_utility"
	worn_state = "grey_utility"
	has_sensor = UNIFORM_HAS_SENSORS
	suit_restricted = FALSE
	armor_energy = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/rank/synthetic/councillor
	name = "\improper USCM Pristine Support Uniform"
	desc = "为合成人船员精心手工制作的制服。"
	icon_state = "synth_councillor"
	worn_state = "synth_councillor"
	displays_id = FALSE

/obj/item/clothing/under/rank/synthetic/flight
	name = "战术飞行服"
	desc = "一件带有许多皮革带、小袋和其他必备装备的飞行服。"
	icon_state = "pilot_flightsuit_alt"
	worn_state = "pilot_flightsuit_alt"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_map/jungle.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_map/jungle.dmi',
	)
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	flags_atom = NO_NAME_OVERRIDE
	flags_cold_protection = ICE_PLANET_MIN_COLD_PROT

/obj/item/clothing/under/rank/synthetic/old
	icon_state = "rdalt_s"
	worn_state = "rdalt_s"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/research.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/research.dmi',
	)

/obj/item/clothing/under/rank/synthetic/upp_joe
	name = "合成人制服"
	desc = "为UPP安保合成人设计的制服。"
	icon_state = "upp_joe"
	worn_state = "upp_joe"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UPP.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UPP.dmi',
	)
	flags_item = NO_CRYO_STORE

/obj/item/clothing/under/rank/synthetic/joe
	name = "\improper Working Joe Uniform"
	desc = "为合成人劳工制作的廉价制服。明天，携手共进。"
	icon_state = "working_joe"
	worn_state = "working_joe"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/SEEGSON.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/SEEGSON.dmi',
	)
	flags_item = NO_CRYO_STORE
	var/obj/structure/machinery/camera/camera

/obj/item/clothing/under/rank/synthetic/joe/Initialize()
	. = ..()
	camera = new /obj/structure/machinery/camera/autoname/almayer/containment/ares(src)
	AddElement(/datum/element/corp_label/seegson)

/obj/item/clothing/under/rank/synthetic/joe/Destroy()
	QDEL_NULL(camera)
	return ..()

/obj/item/clothing/under/rank/synthetic/joe/equipped(mob/living/carbon/human/mob, slot)
	if(camera)
		camera.c_tag = mob.name
	..()

/obj/item/clothing/under/rank/synthetic/joe/dropped(mob/living/carbon/human/mob)
	if(camera)
		camera.c_tag = "3RR0R"
	..()

/obj/item/clothing/under/rank/synthetic/joe/get_examine_text(mob/user)
	. = ..()
	if(camera)
		. += SPAN_ORANGE("There is a small camera mounted to the front.")

/obj/item/clothing/under/rank/synthetic/joe/engi
	name = "\improper Working Joe Hazardous Uniform"
	desc = "用于危险区域合成人劳作的加固制服。明天，携手共进。"
	icon_state = "working_joe_engi"
	worn_state = "working_joe_engi"
	flags_inventory = CANTSTRIP
	armor_melee = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE

/obj/item/clothing/under/rank/synthetic/joe/engi/overalls
	name = "\improper Working Joe Hazardous Uniform"
	desc = "用于危险区域合成人劳作的加固制服。额外增加了一层以应对液体危害。明天，携手共进。"
	icon_state = "working_joe_overalls"
	worn_state = "working_joe_overalls"
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	unacidable = TRUE

//=ROYAL MARINES=\\

/obj/item/clothing/under/marine/veteran/royal_marine
	name = "皇家海军陆战队突击队制服"
	desc = "皇家海军陆战队突击队的野战制服。内含轻型凯夫拉碎片，有助于防御刺击武器和子弹。防护水平与类似的USCM装备相当。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/TWE.dmi',
	)
	icon_state = "rmc_uniform"
	worn_state = "rmc_uniform"
	flags_atom = FPRINT|NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN

/obj/item/clothing/under/marine/veteran/royal_marine/tl
	icon_state = "rmc_uniform_teaml"
	worn_state = "rmc_uniform_teaml"

/obj/item/clothing/under/marine/veteran/royal_marine/lt
	name = "皇家海军陆战队突击队军官制服"
	desc = "皇家海军陆战队突击队的军官制服。内含轻型凯夫拉碎片，有助于防御刺击武器和子弹。防护水平与类似的USCM装备相当。"
	icon_state = "rmc_uniform_lt"
	worn_state = "rmc_uniform_lt"

/obj/item/clothing/under/marine/officer/royal_marine
	name = "皇家海军陆战队突击队常服"
	desc = "皇家海军陆战队突击队的常服。内含轻型凯夫拉碎片，有助于防御刺击武器和子弹。防护水平与类似的USCM装备相当。光荣地穿着你的制服，突击队员。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/TWE.dmi',
	)
	icon_state = "rmc_uniform_service"
	worn_state = "rmc_uniform_service"
	flags_atom = FPRINT|NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN

/obj/item/clothing/under/marine/officer/royal_marine/black
	icon_state = "rmc_uniform_service_alt"
	worn_state = "rmc_uniform_service_alt"

// IASF

/obj/item/clothing/under/marine/veteran/royal_marine/iasf
	name = "IASF 8号作战服"
	desc = "帝国武装太空部队使用的标准8号型作战服。剪裁和防护与皇家海军陆战队突击队变体相同，但采用林地迷彩。轻型凯夫拉网层提供有限的防破片和近战威胁保护。"
	icon_state = "iasf_uniform"
	worn_state = "iasf_uniform"

/obj/item/clothing/under/marine/officer/royal_marine/iasf
	name = "IASF 2号常服"
	desc = "IASF军官穿着的正式2号常服。上身剪裁与8号作战服相同，但搭配熨烫平整的卡其色长裤。用于检阅、礼仪职责或担任顾问角色时穿着。"
	icon_state = "iasf_uniform_service"
	worn_state = "iasf_uniform_service"

// CBRN

/obj/item/clothing/under/marine/cbrn //CBRN MOPP suit
	name = "\improper M3 MOPP suit"
	desc = "M3 MOPP防护服经过专门设计和制造，旨在保护穿着者在野外免受任何未屏蔽的化学、生物、放射或核威胁。该防护服在接触有毒环境后建议使用寿命为二十四小时，但根据严重程度，可能缩短至八小时或更短。"
	desc_lore = "Since the outbreak of the New Earth Plague in 2157 and the subsequent Interstellar Commerce Commission (ICC) sanctioned decontamination of the colony and its 40 million inhabitants, the abandoned colony has been left under a strict quarantine blockade to prevent any potential scavengers from spreading what’s left of the highly-durable airborne flesh-eating bacteria. Following those events, the three major superpowers have been investing heavily in the development and procurement of CBRN equipment, in no small part due to the extensive damage that the plague and other similar bioweapons could do. The \"Marine 70\" upgrade package and the launch of the M3 pattern armor series saw the first M3-M prototypes approved for CBRN usage."
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	icon_state = "cbrn"
	worn_state = "cbrn"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	flags_jumpsuit = NO_FLAGS
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_VERYLOW
	armor_bio = CLOTHING_ARMOR_HARDCORE
	armor_rad = CLOTHING_ARMOR_ULTRAHIGHPLUS
	fire_intensity_resistance = BURN_LEVEL_TIER_1
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROT
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	actions_types = list(/datum/action/item_action/specialist/toggle_cbrn_hood)

	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)

	///Whether the hood and gas mask were worn through the hood toggle verb
	var/hood_enabled = FALSE
	///Whether enabling the hood protects you from fire
	var/supports_fire_protection = TRUE
	///Typepath of the attached hood
	var/hood_type = /obj/item/clothing/head/helmet/marine/cbrn_hood
	///The head clothing that the suit uses as a hood
	var/obj/item/clothing/head/linked_hood

/obj/item/clothing/under/marine/cbrn/Initialize()
	linked_hood = new hood_type(src)
	. = ..()

/obj/item/clothing/under/marine/cbrn/Destroy()
	. = ..()
	if(linked_hood)
		qdel(linked_hood)

/obj/item/clothing/under/marine/cbrn/verb/hood_toggle()
	set name = "切换兜帽"
	set desc = "Pull your hood and gasmask up over your face and head."
	set src in usr
	if(!usr || usr.is_mob_incapacitated(TRUE))
		return
	if(!ishuman(usr))
		return
	var/mob/living/carbon/human/user = usr

	if(user.w_uniform != src)
		to_chat(user, SPAN_WARNING("你必须穿着[src]才能戴上与之相连的[linked_hood]！"))
		return

	if(!linked_hood)
		to_chat(user, SPAN_BOLDWARNING("缺少相连的兜帽！这不应该发生。"))
		CRASH("[user] attempted to toggle hood on [src] that was missing a linked_hood.")

	playsound(user.loc, "armorequip", 25, 1)
	if(hood_enabled)
		disable_hood(user, FALSE)
		return
	enable_hood(user)

/obj/item/clothing/under/marine/cbrn/proc/enable_hood(mob/living/carbon/human/user)
	if(!istype(user))
		user = usr

	if(!linked_hood.mob_can_equip(user, WEAR_HEAD))
		to_chat(user, SPAN_WARNING("你无法装备[linked_hood]。"))
		return

	user.equip_to_slot(linked_hood, WEAR_HEAD)

	hood_enabled = TRUE
	RegisterSignal(src, COMSIG_ITEM_UNEQUIPPED, PROC_REF(disable_hood))
	RegisterSignal(linked_hood, COMSIG_ITEM_UNEQUIPPED, PROC_REF(disable_hood))

	if(!supports_fire_protection)
		return
	to_chat(user, SPAN_NOTICE("你将[linked_hood]拉过头顶。你将不再会着火。"))
	toggle_fire_protection(user, TRUE)

/obj/item/clothing/under/marine/cbrn/proc/disable_hood(mob/living/carbon/human/user, forced = TRUE)
	if(!istype(user))
		user = usr

	UnregisterSignal(src, COMSIG_ITEM_UNEQUIPPED)
	UnregisterSignal(linked_hood, COMSIG_ITEM_UNEQUIPPED)
	addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/living/carbon/human, drop_inv_item_to_loc), linked_hood, src), 1) //0.1s delay cause you can grab the hood
	addtimer(CALLBACK(src, PROC_REF(check_remove_headgear)), 2) //Checks if it is still not in contents, incase it was dropped

	hood_enabled = FALSE
	if(!forced)
		to_chat(user, SPAN_NOTICE("你脱下了[linked_hood]。"))

	if(supports_fire_protection)
		toggle_fire_protection(user, FALSE)

/obj/item/clothing/under/marine/cbrn/proc/check_remove_headgear(obj/item/clothing/under/marine/cbrn/uniform = src)
	for(var/current_atom in contents)
		if(current_atom == linked_hood)
			return
	linked_hood.forceMove(uniform)

/obj/item/clothing/under/marine/cbrn/proc/toggle_fire_protection(mob/living/carbon/user, enable_fire_protection)
	if(enable_fire_protection)
		RegisterSignal(user, COMSIG_LIVING_PREIGNITION, PROC_REF(fire_shield_is_on))
		RegisterSignal(user, list(COMSIG_LIVING_FLAMER_CROSSED, COMSIG_LIVING_FLAMER_FLAMED), PROC_REF(flamer_fire_callback))
		return
	UnregisterSignal(user, list(COMSIG_LIVING_PREIGNITION, COMSIG_LIVING_FLAMER_CROSSED, COMSIG_LIVING_FLAMER_FLAMED))

/obj/item/clothing/under/marine/cbrn/proc/fire_shield_is_on(mob/living/burning_mob) //Stealing it from the pyro spec armor
	SIGNAL_HANDLER

	if(burning_mob.fire_reagent?.fire_penetrating)
		return

	return COMPONENT_CANCEL_IGNITION

/obj/item/clothing/under/marine/cbrn/proc/flamer_fire_callback(mob/living/burning_mob, datum/reagent/fire_reagent)
	SIGNAL_HANDLER

	if(fire_reagent.fire_penetrating)
		return

	. = COMPONENT_NO_IGNITE|COMPONENT_NO_BURN

/datum/action/item_action/specialist/toggle_cbrn_hood
	ability_primacy = SPEC_PRIMARY_ACTION_2

/datum/action/item_action/specialist/toggle_cbrn_hood/New(obj/item/clothing/under/marine/cbrn/armor, obj/item/holder)
	..()
	name = "切换兜帽"
	button.name = name
	button.overlays.Cut()
	var/image/button_overlay = image(armor.linked_hood.icon, armor, armor.linked_hood.icon_state)
	button.overlays += button_overlay

/datum/action/item_action/specialist/toggle_cbrn_hood/action_activate()
	. = ..()
	var/obj/item/clothing/under/marine/cbrn/armor = holder_item
	if(!istype(armor))
		return
	armor.hood_toggle()

/obj/item/clothing/under/marine/cbrn/advanced
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_HIGHPLUS
	armor_bio = CLOTHING_ARMOR_HARDCORE
	armor_rad = CLOTHING_ARMOR_GIGAHIGHPLUS
	armor_internaldamage = CLOTHING_ARMOR_HIGHPLUS
	hood_type = /obj/item/clothing/head/helmet/marine/cbrn_hood/advanced

