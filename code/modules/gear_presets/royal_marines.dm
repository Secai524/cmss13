/datum/equipment_preset/twe
	name = "三世界帝国"
	faction = FACTION_TWE
	faction_group = list(FACTION_TWE, FACTION_MARINE)
	origin_override = ORIGIN_TWE
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_JAPANESE)
	minimap_background = "background_twe"

/datum/equipment_preset/twe/royal_marine/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(MALE, FEMALE)
	var/datum/preferences/placeholder_pref = new()
	placeholder_pref.randomize_appearance(new_human)
	var/random_name = random_name(new_human.gender)
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(20,45)

	var/static/list/colors = list("BLACK" = list(15, 15, 25), "BROWN" = list(102, 51, 0), "AUBURN" = list(139, 62, 19))
	var/static/list/hair_colors = colors.Copy() + list("BLONDE" = list(197, 164, 30), "CARROT" = list(174, 69, 42))
	var/hair_color = pick(hair_colors)
	new_human.r_hair = hair_colors[hair_color][1]
	new_human.g_hair = hair_colors[hair_color][2]
	new_human.b_hair = hair_colors[hair_color][3]
	new_human.r_facial = hair_colors[hair_color][1]
	new_human.g_facial = hair_colors[hair_color][2]
	new_human.b_facial = hair_colors[hair_color][3]
	var/eye_color = pick(colors)
	new_human.r_eyes = colors[eye_color][1]
	new_human.g_eyes = colors[eye_color][2]
	new_human.b_eyes = colors[eye_color][3]
	idtype = /obj/item/card/id/dogtag
	if(new_human.gender == MALE)
		new_human.h_style = pick("平头", "光头", "板寸", "底层剃光", "侧边削短", "列兵 Joker", "陆战队员渐变", "低渐变", "中渐变", "高渐变", "无渐变", "咖啡馆发型", "平头",)
		new_human.f_style = pick("五点钟胡茬", "剃光", "全脸胡须", "三点钟小胡子", "五点钟胡茬", "五点钟小胡子", "七点钟胡茬", "七点钟小胡子",)
	else
		new_human.h_style = pick("马尾辫 1", "马尾辫 2", "马尾辫 3", "马尾辫 4", "列兵 Redding", "列兵 Clarison", "下士 Dietrich", "列兵 Vasquez", "陆战队员发髻", "陆战队员发髻 2", "陆战队员平顶",)

/datum/equipment_preset/twe/royal_marine/load_id(mob/living/carbon/human/new_human, client/mob_client)
	if(human_versus_human)
		var/obj/item/clothing/under/uniform = new_human.w_uniform
		if(istype(uniform))
			uniform.has_sensor = UNIFORM_HAS_SENSORS
	return ..()

//*****************************************************************************************************/

/datum/equipment_preset/twe/royal_marine
	name = "皇家海军陆战队突击队"
	assignment = "Royal Marine"
	job_title = JOB_TWE_RMC_RIFLEMAN
	var/human_versus_human = FALSE
	///Gives the Royal Marines their radios
	var/headset_type = /obj/item/device/radio/headset/distress/royal_marine
	idtype = /obj/item/card/id/dogtag

//*****************************************************************************************************/

/datum/equipment_preset/twe/royal_marine/standard
	name = "TWE皇家海军陆战队突击队（步枪兵）"
	paygrades = list(PAY_SHORT_RMC1 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RMC"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Royal Marines Rifleman"
	job_title = JOB_TWE_RMC_RIFLEMAN

	minimap_icon = "rmc_rifleman"

	skills = /datum/skills/rmc


/datum/equipment_preset/twe/royal_marine/standard/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp78, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp78, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp78, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/l23, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc/rmc_l23_ammo, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23/ap, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/incin, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/he, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/twe, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/m94, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full_rmc_aid, WEAR_R_STORE)

/datum/equipment_preset/twe/royal_marine/standard/mre_pack
	name = "TWE皇家海军陆战队突击队（装备步枪兵）" //finally useful preset

/datum/equipment_preset/twe/royal_marine/standard/mre_pack/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/frame, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_box/magazine/l23, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_box/magazine/misc/flares, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_box/magazine/misc/mre/twe, WEAR_IN_BACK)
	..()

//*****************************************************************************************************/
/datum/equipment_preset/twe/royal_marine/spec
	paygrades = list(PAY_SHORT_RMC2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RMC SPC"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/rmc/specialist

/datum/equipment_preset/twe/royal_marine/spec/marksman
	name = "TWE皇家海军陆战队突击队（精确射手）"
	assignment = "Royal Marines Marksman"
	job_title = JOB_TWE_RMC_MARKSMAN
	minimap_icon = "rmc_marksman"

/datum/equipment_preset/twe/royal_marine/spec/marksman/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/tacticalmask/tan, WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m42_night_goggles/rmc, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp78, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp78, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp78, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/l64a3/marksman, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc/l64a3/marksman, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/incin, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/he, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/twe, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l64/ap, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/m94, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full_rmc_aid, WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/twe/royal_marine/spec/breacher
	name = "TWE皇家海军陆战队突击队（破门手）"
	role_comm_title = "RMC BRC"
	assignment = "Royal Marines Breacher"
	job_title = JOB_TWE_RMC_BREACHER
	minimap_icon = "rmc_breacher"

	skills = /datum/skills/rmc/breacher

/datum/equipment_preset/twe/royal_marine/spec/breacher/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine/breacher, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/welding/superior, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/twe, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/pointman, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23/ap, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/l23/breacher, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/m94, WEAR_IN_BELT)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/shield/riot/ballistic, WEAR_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tactical/full, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full_rmc_aid, WEAR_R_STORE)

//*****************************************************************************************************/
/datum/equipment_preset/twe/royal_marine/spec/machinegun
	name = "TWE皇家海军陆战队突击队（智能枪手）"
	role_comm_title = "RMC SG"
	assignment = "Royal Marines Smartgunner"
	job_title = JOB_TWE_RMC_SMARTGUNNER

	minimap_icon = "rmc_sg"

	skills = /datum/skills/rmc/smartgun

/datum/equipment_preset/twe/royal_marine/spec/machinegun/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine/breacher, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife, WEAR_FEET)
	new_human.equip_to_slot(new /obj/item/clothing/glasses/night/m56_goggles, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/twe, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/smartgun, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smartgun/rmc, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/l905/full, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/regular, WEAR_IN_BACK)
	new_human.equip_to_slot(new /obj/item/smartgun_battery(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smartgun/holo_targetting, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smartgun/holo_targetting, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/incin, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/he, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/m94, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smartgun/holo_targetting, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smartgun/holo_targetting, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full_rmc_aid, WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/twe/royal_marine/medic
	name = "TWE皇家海军陆战队突击队（医疗技术员）"
	paygrades = list(PAY_SHORT_RMC3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RMC MED"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Royal Marines Medical Technician"
	job_title = JOB_TWE_RMC_MEDIC

	minimap_icon = "rmc_medic"

	skills = /datum/skills/rmc/medic

/datum/equipment_preset/twe/royal_marine/medic/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine/medic, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine/medical, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/surg_vest/equipped, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light, WEAR_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23/extended, WEAR_IN_JACKET) // Medic is very limited in ammo (sarcasm?)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23/extended, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23/ap, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/l23, WEAR_J_STORE) // This is until we get proper Astra SMG sprites

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/rmc/full, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/medium/medic, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/incin, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/he, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/syringe_case/rmc, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller/surgical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/twe, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full_rmc, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pressurized_reagent_canister/revival_tricord, WEAR_R_STORE)

//*****************************************************************************************************/
/datum/equipment_preset/twe/royal_marine/team_leader
	name = "TWE皇家海军陆战队突击队（组长）"
	paygrades = list(PAY_SHORT_RMC4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RMC TL"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Royal Marines Team Leader"
	job_title = JOB_TWE_RMC_TEAMLEADER

	minimap_icon = "rmc_teamleader"

	skills = /datum/skills/rmc/leader

/datum/equipment_preset/twe/royal_marine/team_leader/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine/team_leader, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/tl, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/twe, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/team_leader, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23/extended, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23/ap, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/l23/leader, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/l905/full, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator/compact, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/syringe_case/rmc, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/cautery, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/incin, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/he, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/m94, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/rmc, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full_rmc_aid, WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/twe/royal_marine/lieuteant //they better say it Lef-tenant or they should be banned for LRP. More importantly this guy doesn't spawn in the ERT
	name = "TWE皇家海军陆战队突击队（军官）"
	paygrades = list(PAY_SHORT_RNO1A = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RMC LT"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Royal Marines Team Commander"
	job_title = JOB_TWE_RMC_LIEUTENANT

	minimap_icon = "rmc_lieutenant"

	skills = /datum/skills/rmc/lieutenant

/datum/equipment_preset/twe/royal_marine/lieuteant/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine/team_leader, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lt, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/twe, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/team_leader, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23/extended, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23/ap, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/l23/leader, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/l905/full, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/syringe_case/rmc, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator/compact, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/cautery, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/incin, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/he, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/m94, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/rmc, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full_rmc_officer_aid, WEAR_R_STORE)

/datum/equipment_preset/twe/royal_marine/lieuteant/service
	name = "TWE皇家海军陆战队突击队（SO）"

/datum/equipment_preset/twe/royal_marine/lieuteant/service/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/royal_marine, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/dress/rmc, WEAR_FEET)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service, WEAR_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel, WEAR_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator, WEAR_IN_L_STORE)

/datum/equipment_preset/twe/royal_marine/captain //RMC Captain. Exists purely for admin spawns (you never know when you need a high ranking RMC Officer, eh?)
	name = "TWE皇家海军陆战队突击队（上尉）"
	paygrades = list(PAY_SHORT_RNO2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RMC CPT"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Royal Marines Captain"
	job_title = JOB_TWE_RMC_CAPTAIN

	minimap_icon = "rmc_commander"

	skills = /datum/skills/rmc/captain

/datum/equipment_preset/twe/royal_marine/captain/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine/team_leader, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lt, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/team_leader, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23/extended, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23/incendiary, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/l23/leader, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/l905/full, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/syringe_case/rmc, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator/compact, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/cautery, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/incin, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/he, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/m94, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/twe, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/rmc, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full_rmc_officer_aid, WEAR_R_STORE)

/datum/equipment_preset/twe/royal_marine/captain/service
	name = "TWE皇家海军陆战队突击队（副指挥官）"

/datum/equipment_preset/twe/royal_marine/captain/service/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/royal_marine, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/dress/rmc, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator, WEAR_EYES)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel, WEAR_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator, WEAR_IN_L_STORE)

/datum/equipment_preset/twe/royal_marine/major //RMC Major. The top brass of the RMC forces in Neroid. Custom pistol coming soon(tm)
	name = "TWE皇家海军陆战队突击队（少校）"
	paygrades = list(PAY_SHORT_RNO3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RMC MJR"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Royal Marines Major"
	job_title = JOB_TWE_RMC_MAJOR

	minimap_icon = "rmc_major"

	skills = /datum/skills/rmc/major

/datum/equipment_preset/twe/royal_marine/major/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine/team_leader, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lt, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine/breacher, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/team_leader, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23/extended, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23/incendiary, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23/incendiary, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/l23, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/l23/leader, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/mateba/cmateba/special, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/syringe_case/rmc, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator/compact, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/cautery, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/incin, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/he, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/m94, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/twe, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/rmc, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full_rmc_officer_aid, WEAR_R_STORE)

/datum/equipment_preset/twe/royal_marine/major/service
	name = "TWE皇家海军陆战队突击队（指挥官）"

/datum/equipment_preset/twe/royal_marine/major/service/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/royal_marine, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/dress/rmc, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/mateba/cmateba/special, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator, WEAR_EYES)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/rmc/service/co, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/lockable, WEAR_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/command, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator, WEAR_IN_L_STORE)


///Hunting Grounds Royal Marines///

/datum/equipment_preset/twe/royal_marine/standard/hunted
	name = "TWE皇家海军陆战队突击队（被猎杀）"
	faction = FACTION_HUNTED_TWE

/datum/equipment_preset/twe/royal_marine/standard/hunted/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp78, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp78, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp78, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc/rmc_f90_ammo, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/incin, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/he, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/twe, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/m94, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full_rmc_aid, WEAR_R_STORE)

/datum/equipment_preset/twe/royal_marine/team_leader/hunted
	name = "TWE皇家海军陆战队突击队队长（被猎杀）"
	faction = FACTION_HUNTED_TWE

/datum/equipment_preset/twe/royal_marine/team_leader/hunted/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp78, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp78, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp78, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90/a_grip, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc/rmc_f90_ammo, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/incin, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/he, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/twe, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/m94, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full_rmc_aid, WEAR_R_STORE)

/datum/equipment_preset/twe/royal_marine/lieuteant/hunted
	name = "TWE皇家海军陆战队突击队军官（被猎杀）"
	faction = FACTION_HUNTED_TWE

/datum/equipment_preset/twe/royal_marine/lieuteant/hunted/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine/team_leader, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lt, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/team_leader, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90/a_grip, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/l905/full, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/incin, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/he, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/m94, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/twe, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/cautery, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/syringe_case/rmc, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full_rmc_officer_aid, WEAR_R_STORE)
