//Dutch's Dozens, pred hunter ERT, moved from fun file as they don't fit there to be honest.

/datum/equipment_preset/dutch
	name = JOB_DUTCH_RIFLEMAN
	paygrades = list(PAY_SHORT_DTC = JOB_PLAYTIME_TIER_0)
	assignment = JOB_DUTCH_RIFLEMAN
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_DUTCH

	skills = /datum/skills/dutchmerc

/datum/equipment_preset/dutch/New()
	..()
	job_title = assignment

/datum/equipment_preset/dutch/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(MALE, FEMALE)

	var/datum/preferences/human = new()
	human.randomize_appearance(new_human)

	var/first_name
	var/last_name = capitalize(pick(GLOB.last_names))
	switch(new_human.gender)
		if(FEMALE)
			first_name = capitalize(pick(GLOB.first_names_female_dutch))
		if(PLURAL, NEUTER) // Not currently possible
			first_name = capitalize(pick(MALE, FEMALE) == MALE ? pick(GLOB.first_names_male_dutch) : pick(GLOB.first_names_female_dutch))
		else // MALE
			first_name = capitalize(pick(GLOB.first_names_male_dutch))
			new_human.f_style = "五点钟胡茬"

	new_human.change_real_name(new_human, "[first_name] [last_name]")
	new_human.age = rand(25,35)
	new_human.r_hair = rand(10,30)
	new_human.g_hair = rand(10,30)
	new_human.b_hair = rand(20,50)
	new_human.r_eyes = rand(129,149)
	new_human.g_eyes = rand(52,72)
	new_human.b_eyes = rand(9,29)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/dutch/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/dutch(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/storage/fancy/cigarettes/lucky_strikes(new_human), WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/lighter/zippo(new_human), WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/dutch(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/dutch(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/dutch(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/empgrenade/dutch(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/empgrenade/dutch(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/empgrenade/dutch(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/regular/response(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector/hacked/dutch(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m1911(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/ert(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)

	switch(rand(1, 10))
		if(1 to 6) // 60% for standard m16
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m16/dutch(new_human), WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16/ap(new_human), WEAR_IN_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16/ap(new_human), WEAR_IN_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/dutch/m16/ap(new_human), WEAR_WAIST)
			new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/m16/ap(new_human), WEAR_L_STORE)

		if(7 to 9) // 30% for m16 with m203
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m16/grenadier/dutch(new_human), WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16/ap(new_human), WEAR_IN_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16/ap(new_human), WEAR_IN_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/grenade/large/dutch/full(new_human), WEAR_WAIST)
			new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/m16/ap(new_human), WEAR_L_STORE)

		if(10) // 10% for M60
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/m60(new_human), WEAR_J_STORE)//these preds gonna GET SOME!!!!!!!!!!!
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/m60(new_human), WEAR_IN_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/m60(new_human), WEAR_IN_JACKET)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/dutch/m60(new_human), WEAR_WAIST)
			new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/m60(new_human), WEAR_L_STORE)

	to_chat(new_human, SPAN_WARNING("你是荷兰佬十二人队的一员！你对铁血战士的一切了如指掌，包括最微小的细节。你们队长脸上的铁血战士面具能让铁血战士追踪你们，或者让你用来设置陷阱。铁血战士能侦测到他们装备的信号，你们一抵达就会被这个面具吸引。你背包里的EMP手榴弹作用范围极广。它们能打断铁血战士的光学迷彩并消耗其腕部能量。记住：你的目标是猎杀、消灭并掠夺地面上的铁血战士，而不是猎杀异形。你拥有多种多样的技能，好好利用它们！"))

/datum/equipment_preset/dutch/minigun
	name = JOB_DUTCH_MINIGUNNER
	paygrades = list(PAY_SHORT_DTCMG = JOB_PLAYTIME_TIER_0)
	assignment = JOB_DUTCH_MINIGUNNER
	flags = EQUIPMENT_PRESET_EXTRA

	skills = /datum/skills/dutchmerc

/datum/equipment_preset/dutch/minigun/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/dutch(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/storage/fancy/cigarettes/lucky_strikes(new_human), WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/lighter/zippo(new_human), WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/dutch(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/dutch(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/dutch(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/minigun(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/empgrenade/dutch(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/empgrenade/dutch(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/minigun(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/minigun(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/minigun(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/minigun(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/minigun(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/minigun(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/m1911(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/ert(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/explosive/emp_dutch(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)

	to_chat(new_human, SPAN_WARNING("你是荷兰佬十二人队的一员！你对铁血战士的一切了如指掌，包括最微小的细节。你们队长脸上的铁血战士面具能让铁血战士追踪你们，或者让你用来设置陷阱。铁血战士能侦测到他们装备的信号，你们一抵达就会被这个面具吸引。你背包里的EMP手榴弹作用范围极广。它们能打断铁血战士的光学迷彩并消耗其腕部能量。记住：你的目标是猎杀、消灭并掠夺地面上的铁血战士，而不是猎杀异形。"))

/datum/equipment_preset/dutch/flamer
	name = JOB_DUTCH_FLAMETHROWER
	paygrades = list(PAY_SHORT_DTCF = JOB_PLAYTIME_TIER_0)
	assignment = JOB_DUTCH_FLAMETHROWER
	flags = EQUIPMENT_PRESET_EXTRA

	skills = /datum/skills/dutchmerc

/datum/equipment_preset/dutch/flamer/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/dutch(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/dutch(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/storage/fancy/cigarettes/lucky_strikes(new_human), WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/lighter/zippo(new_human), WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/dutch(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/dutch(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/xm177/dutch, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/empgrenade/dutch(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/empgrenade/dutch(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m1911(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/large_holster/fuelpack(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/flamer/m240/spec(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/dutch/m16/ap(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flamertank(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/large/X(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/large/B(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/ert(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)

	to_chat(new_human, SPAN_WARNING("你是荷兰佬十二人队的一员！你对铁血战士的一切了如指掌，包括最微小的细节。你们队长脸上的铁血战士面具能让铁血战士追踪你们，或者让你用来设置陷阱。铁血战士能侦测到他们装备的信号，你们一抵达就会被这个面具吸引。你背包里的EMP手榴弹作用范围极广。它们能打断铁血战士的光学迷彩并消耗其腕部能量。记住：你的目标是猎杀、消灭并掠夺地面上的铁血战士，而不是猎杀异形。"))

/datum/equipment_preset/dutch/medic
	name = JOB_DUTCH_MEDIC
	paygrades = list(PAY_SHORT_DTCM = JOB_PLAYTIME_TIER_0)
	assignment = JOB_DUTCH_MEDIC
	flags = EQUIPMENT_PRESET_EXTRA

	skills = /datum/skills/dutchmedic

/datum/equipment_preset/dutch/medic/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/dutch(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/storage/fancy/cigarettes/lucky_strikes(new_human), WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/lighter/zippo(new_human), WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/dutch(new_human), WEAR_L_EAR)
	if(new_human.disabilities & NEARSIGHTED)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/prescription(new_human), WEAR_EYES)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/dutch(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/dutch(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/xm177/dutch(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/empgrenade/dutch(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/empgrenade/dutch(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/empgrenade/dutch(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator/compact_adv(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector/hacked/dutch(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/surgical_line(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/smoke(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16/ap, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16/ap, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16/ap, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/full/dutch(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/m16/ap(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full_advanced(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)

	to_chat(new_human, SPAN_WARNING("你是荷兰佬十二人队的医疗兵！你对铁血战士的一切了如指掌，包括最微小的细节。你们队长脸上的铁血战士面具能让铁血战士追踪你们，或者让你用来设置陷阱。铁血战士能侦测到他们装备的信号，你们一抵达就会被这个面具吸引。你背包里的EMP手榴弹作用范围极广。它们能打断铁血战士的光学迷彩并消耗其腕部能量。记住：你的目标是协助你的队员猎杀、消灭并掠夺地面上的铁血战士，而不是猎杀异形。"))

/datum/equipment_preset/dutch/arnie
	name = "荷兰佬十二人队 - 阿诺德"
	paygrades = list(PAY_SHORT_DTCA = JOB_PLAYTIME_TIER_0)
	assignment = JOB_DUTCH_ARNOLD
	flags = EQUIPMENT_PRESET_EXTRA

	skills = /datum/skills/dutch
	idtype = /obj/item/card/id/gold

/datum/equipment_preset/dutch/arnie/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = MALE
	new_human.change_real_name(new_human, "Arnold '达奇' Schäfer")
	new_human.f_style = "五点钟胡茬"
	new_human.h_style = "穆德发型"

	new_human.age = 38
	new_human.r_hair = 15
	new_human.g_hair = 15
	new_human.b_hair = 25
	new_human.r_eyes = 139
	new_human.g_eyes = 62
	new_human.b_eyes = 19
	idtype = /obj/item/card/id/gold

/datum/equipment_preset/dutch/arnie/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/dutch/cap(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/dutch(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/thermal/empproof(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/yautja/hunter(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/dutch(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/dutch(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/xm177/dutch(new_human), WEAR_J_STORE) //he uses a grenadier m16 in the movie but too gear limited to add it so he gets the cool gun
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16/ap(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16/ap(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/large_holster/machete/arnold/full(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16/ap, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16/ap, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16/ap, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/dutch/m16/ap(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/explosive/emp_dutch(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medical/socmed/dutch(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)

	new_human.set_species("人类英雄") //Arnold is STRONG.

	to_chat(new_human, SPAN_WARNING("你是荷兰佬，荷兰佬十二人队的队长！你对铁血战士的一切了如指掌，包括最微小的细节。你脸上的铁血战士面具能让铁血战士追踪你，或者让你用来设置陷阱。铁血战士能侦测到他们装备的信号，你们一抵达就会被这个面具吸引。你腰包里的EMP手榴弹作用范围极广。它们能打断铁血战士的光学迷彩并消耗其腕部能量。记住：你的目标是猎杀、消灭并掠夺地面上的铁血战士，而不是猎杀异形。"))
