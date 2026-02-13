///////////////////////
/////// HYBRISA ///////
///////////////////////


/////////////////////// UNDER ///////////////////////
////////////////////////////////////////////////////

// HYBRISA - GOONS

/obj/item/clothing/under/marine/veteran/pmc/corporate/hybrisa
	name = "\improper WY corporate security uniform"
	desc = "维兰德-汤谷公司安保人员穿着的装甲制服。这种款式通常被所谓的‘打手’穿着。"
	icon_state = "sec_hybrisa_uniform"
	worn_state = "sec_hybrisa_uniform"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE

/obj/item/clothing/under/marine/veteran/pmc/corporate/hybrisa/lead
	desc = "维兰德-汤谷公司安保人员穿着的装甲制服。这种款式通常由俗称‘打手小队’的队长穿着。"
	icon_state = "sec_lead_hybrisa_uniform"
	worn_state = "sec_lead_hybrisa_uniform"

// CMB Police Officer

/obj/item/clothing/under/hybrisa/cmb_officer
	name = "\improper Colonial Marshal uniform"
	desc = "一条灰色休闲裤和一件蓝色纽扣衬衫，配黑色领带；殖民地执法官的非标准制服，专为更城市化的殖民地设计，类似于地球上更传统的警察部队制服。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/CMB.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/CMB.dmi',
	)
	icon_state = "police_uniform"
	worn_state = "police_uniform"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

// WY - Pilot

/obj/item/clothing/under/hybrisa/wy_pilot
	name = "\improper Weyland-Yutani Pilot uniform"
	desc = "一条灰色休闲裤和一件白色纽扣衬衫，配深灰色领带和金色肩章以示军衔；维兰德-汤谷旗下商业级飞行员的标准制服。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/WY.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/WY.dmi',
	)
	icon_state = "civilian_pilot_uniform"
	worn_state = "civilian_pilot_uniform"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

// Paramedic

/obj/item/clothing/under/hybrisa/paramedic
	name = "\improper EMT - Paramedic uniform"
	desc = "一套急救医疗技术员 - 护理人员作训服，绿色款。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/medical.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/medical.dmi',
	)
	icon_state = "paramedic_green_uniform"
	worn_state = "paramedic_green_uniform"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/hybrisa/paramedic/red
	name = "\improper EMT - Paramedic uniform"
	desc = "一套急救医疗技术员 - 护理人员作训服，红色款。"
	icon_state = "paramedic_redblack_uniform"
	worn_state = "paramedic_redblack_uniform"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

// Sanitation Worker

/obj/item/clothing/under/hybrisa/santiation
	name = "\improper Weyland-Yutani RFF - Sanitation uniform"
	desc = "一套维兰德-汤谷快速反应部队 - 环卫作训服，包括绿色工装裤和灰色Polo衫，带有绿色反光条纹。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/service.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/service.dmi',
	)
	icon_state = "sanitation_worker_uniform"
	worn_state = "sanitation_worker_uniform"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

// Engineer Worker Uniform

/obj/item/clothing/under/hybrisa/engineering_utility
	name = "\improper Weyland-Yutani engineering utility uniform"
	desc = "一套维兰德-汤谷工程公用事业工人制服，包括橙色工装裤和灰色Polo衫，带有橙色反光条纹。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/engineering.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/engineering.dmi',
	)
	icon_state = "engineer_worker_uniform"
	worn_state = "engineer_worker_uniform"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/hybrisa/engineering_utility/alt
	name = "\improper Weyland-Yutani engineering utility uniform"
	desc = "一套维兰德-汤谷工程公用事业工人制服，包括蓝色工装裤和灰色Polo衫，带有黄色反光条纹。"
	icon_state = "engineer_worker_alt_uniform"
	worn_state = "engineer_worker_alt_uniform"

//  Kelland Mining

/obj/item/clothing/under/hybrisa/kelland_mining
	name = "\improper kelland-mining uniform"
	desc = "一套凯兰矿业作训服，包括黄色公用事业工装裤和浅灰色Polo衫，带有红色反光条纹。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/cargo.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/cargo.dmi',
	)
	icon_state = "kellandmining_uniform"
	worn_state = "kellandmining_uniform"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/hybrisa/kelland_mining/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/kelland)

// Weymart

/obj/item/clothing/under/hybrisa/weymart
	name = "\improper Weymart uniform"
	desc = "一条深灰色休闲裤和一件橙色纽扣衬衫；维兰德-汤谷旗下超市‘维玛特’的标准制服。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/WY.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/WY.dmi',
	)
	icon_state = "weymart_uniform"
	worn_state = "weymart_uniform"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

// Pizza-Galaxy

/obj/item/clothing/under/hybrisa/pizza_galaxy
	name = "\improper Pizza-Galaxy uniform"
	desc = "一条红色休闲裤和一件白色纽扣衬衫，背面印有巨大的‘披萨银河’标志；披萨银河员工的标准制服。披萨银河！飞向无限，超越极限！"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/service.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/service.dmi',
	)
	icon_state = "new_pizza_uniform"
	worn_state = "new_pizza_uniform"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

// Cuppa Joe's

/obj/item/clothing/under/hybrisa/cuppa_joes
	name = "\improper Cuppa Joe's uniform"
	desc = "一条黑色休闲裤和一件白色短袖纽扣衬衫；一杯乔咖啡店员工的标准制服。你有一杯乔的微笑吗？"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/service.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/service.dmi',
	)
	icon_state = "cuppajoes_uniform"
	worn_state = "cuppajoes_uniform"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

// Science

/obj/item/clothing/under/rank/scientist/hybrisa
	name = "科学家公用连体服"
	desc = "由特殊纤维制成，提供对生物危害的轻微防护。其标记表明穿着者为科学家。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/research.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/research.dmi',
	)
	icon_state = "science_outfit"
	worn_state = "science_outfit"
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_jumpsuit = FALSE

// WY-Exec Expensive Suits

// Detective Suit

/obj/item/clothing/under/hybrisa/wy_exec_suit_uniform
	name = "\improper expensive suit"
	desc = "一套奢华的品牌西装，非普通人所能企及。是高级执行官和富裕精英的专属选择。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/WY.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/WY.dmi',
	)
	icon_state = "wy_exec_suit"
	worn_state = "wy_exec_suit"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/hybrisa/wy_exec_suit_uniform/brown

	icon_state = "wy_exec_suit_2"
	worn_state = "wy_exec_suit_2"

/obj/item/clothing/under/hybrisa/wy_exec_suit_uniform/jacket
	icon_state = "wy_exec_suit_3"
	worn_state = "wy_exec_suit_3"

/obj/item/clothing/under/hybrisa/wy_exec_suit_uniform/brown/jacket
	icon_state = "wy_exec_suit_4"
	worn_state = "wy_exec_suit_4"

/obj/item/clothing/under/hybrisa/wy_exec_suit_uniform/jacket_only
	icon_state = "wy_exec_suit_5"
	worn_state = "wy_exec_suit_5"


/////////////////////// Hats & Helmets ///////////////////////
/////////////////////////////////////////////////////////////

// HYBRISA - GOONS

/obj/item/clothing/head/helmet/marine/veteran/pmc/corporate/hybrisa
	name = "\improper WY corporate security helmet"
	desc = "一顶配有橙色安全面罩的基础骷髅头盔。由公司安保人员佩戴，评级可保护头部免受手持撬棍的失控科学家攻击。"
	icon_state = "sec_helmet_hybrisa"
	item_state = "sec_helmet_hybrisa"

/obj/item/clothing/head/helmet/marine/veteran/pmc/corporate/hybrisa/lead
	desc = "一顶配有橙色安全面罩的基础骷髅头盔。由公司安保人员佩戴。此款式由脑容量过大而无法塞进旧款头盔的低级守卫佩戴。至少他们是这么说的。"
	icon_state = "sec_lead_helmet_hybrisa"
	item_state = "sec_lead_helmet_hybrisa"

/obj/item/clothing/head/helmet/marine/veteran/pmc/corporate/hybrisa/brown
	name = "\improper WY corporate security helmet"
	desc = "一顶配有橙色安全面罩的基础骷髅头盔。由公司安保人员佩戴，评级可保护头部免受手持撬棍的失控科学家攻击。"
	icon_state = "sec_brown_helmet_hybrisa"
	item_state = "sec_brown_helmet_hybrisa"

/obj/item/clothing/head/helmet/marine/veteran/pmc/corporate/hybrisa/medic
	desc = "一顶配有橙色安全面罩的基础骷髅头盔。由公司安保人员佩戴，评级可保护头部免受手持撬棍的失控科学家攻击。正面饰有医疗十字标志。"
	icon_state = "sec_medic_helmet_hybrisa"
	item_state = "sec_medic_helmet_hybrisa"

// CMB Police Hats

/obj/item/clothing/head/hybrisa/cmb_cap_new
	name = "\improper Colonial Marshal Bureau cap"
	desc = "一项深色帽子，上面印有代表外缘星域正义、权威与保护的强大字母‘MARSHAL’。地球的法律延伸至太阳系之外。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/CMB.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/CMB.dmi',
	)
	icon_state = "cmb_cap"
	item_state = "cmb_cap"
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS

/obj/item/clothing/head/hybrisa/cmb_cap_new/riot
	name = "\improper Police cap"
	desc = "一项深色帽子，上面印有代表外缘星域正义、权威与保护的强大字母‘POLICE’。地球的法律延伸至太阳系之外。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/CMB.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/CMB.dmi',
	)
	icon_state = "pol_cap"
	item_state = "pol_cap"

/obj/item/clothing/head/hybrisa/cmb_peaked_cap
	name = "\improper Colonial Marshal Bureau cap"
	desc = "一项深色大檐帽，上面印有代表外缘星域正义、权威与保护的‘殖民地执法局’星形徽章。地球的法律延伸至太阳系之外。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/CMB.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/CMB.dmi',
	)
	icon_state = "police_cap_norim"
	item_state = "police_cap_norim"
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS

/obj/item/clothing/head/hybrisa/cmb_peaked_cap_gold
	name = "\improper Colonial Marshal Bureau cap"
	desc = "一项深色大檐帽，上面印有代表外缘星域正义、权威与保护的‘殖民地执法局’星形徽章。地球的法律延伸至太阳系之外。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/CMB.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/CMB.dmi',
	)
	icon_state = "police_cap"
	item_state = "police_cap"
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS

// WY-Pilot Cap

/obj/item/clothing/head/hybrisa/wy_po_cap
	name = "\improper Weyland-Yutani Pilot cap"
	desc = "一项深色大檐帽，上面印有维兰德-汤谷的‘飞翼’标志。合格民用飞行员的正式帽子，类似于旧地球的正式飞行员装束。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/WY.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/WY.dmi',
	)
	icon_state = "civilian_pilot_cap"
	item_state = "civilian_pilot_cap"
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS

// Weymart Cap

/obj/item/clothing/head/hybrisa/weymart
	name = "橙色棒球帽"
	desc = "这是一顶'维玛特'橙色的棒球帽，正面印有'维玛特'标志。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/WY.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/WY.dmi',
	)
	icon_state = "weymart_cap"
	item_state = "weymart_cap"

// Pizza-Galaxy Cap

/obj/item/clothing/head/hybrisa/pizza_galaxy
	name = "披萨银河红色棒球帽"
	desc = "这是一顶红色的棒球帽，正面印有'披萨银河'标志。"
	icon = 'icons/obj/items/clothing/hats/soft_caps.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/soft_caps.dmi'
	)
	icon_state = "pizzagalaxy_cap"
	item_state = "pizzagalaxy_cap"

// Helmets

// Firefighter

/obj/item/clothing/head/helmet/hybrisa/medtech
	name = "MT-SHIELD-X 525头盔"
	desc = "MT-SHIELD-X 525（医疗科技 - 极端危险集成安全头盔）。一款为保护穿戴者免受危险环境伤害而设计的封闭式头盔，此特定型号旨在多种危险环境中有效运作，并保护使用者免受潜在生物危害。此头盔由海珀戴恩系统公司与医疗科技合作设计。"
	icon = 'icons/obj/items/clothing/hats/hazard.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hazard.dmi'
	)
	icon_state = "firefighter_helmet"
	item_state = "firefighter_helmet"
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	flags_inventory = COVEREYES|BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEEYES|HIDETOPHAIR

/obj/item/clothing/head/helmet/hybrisa/firefighter
	name = "HS-SHIELD-X 500头盔"
	desc = "HS-SHIELD-X 500（海珀戴恩系统 - 极端危险集成安全头盔）。一款为保护穿戴者免受危险环境伤害而设计的封闭式头盔，此特定型号旨在高温环境中有效运作，并保护使用者免受烟雾吸入伤害。它内置半封闭式呼吸系统。此头盔由海珀戴恩系统公司设计。"
	icon = 'icons/obj/items/clothing/hats/hazard.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hazard.dmi'
	)
	icon_state = "firefighter_alt_helmet"
	item_state = "firefighter_alt_helmet"
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	flags_inventory = COVEREYES|BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEEYES|HIDETOPHAIR

// Kelland Mining

/obj/item/clothing/head/helmet/hybrisa/kelland_mining_helmet
	name = "HS-KM-SHIELD-X 550头盔"
	desc = "HS-KM-SHIELD-X 550（海珀戴恩系统 - 凯兰矿业 - 极端危险集成安全头盔）。一款为保护穿戴者免受危险环境伤害而设计的封闭式头盔，此特定型号旨在多种危险环境中有效运作，并保护使用者免受有毒烟雾吸入伤害。它内置半封闭式呼吸系统。此头盔由海珀戴恩系统公司与凯兰矿业合作设计。"
	icon = 'icons/obj/items/clothing/hats/hazard.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hazard.dmi'
	)
	icon_state = "kelland_mining_helmet"
	item_state = "kelland_mining_helmet"
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	flags_inventory = COVEREYES|BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEEYES|HIDETOPHAIR

/obj/item/clothing/head/helmet/hybrisa/kelland_mining_helmet/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/kelland)

// Pizza-Galaxy (Rare Helmet)

/obj/item/clothing/head/helmet/hybrisa/pizza_galaxy
	name = "HS-PG-SHIELD-X 575头盔"
	desc = "HS-PG-SHIELD-X 575（海珀戴恩系统 - 披萨银河 - 极端危险集成安全头盔）。一款为保护穿戴者免受危险环境伤害而设计的封闭式原型头盔，此特定型号旨在低大气压环境中有效运作。它内置封闭式呼吸系统。此头盔由海珀戴恩系统公司与披萨银河合作设计。"
	icon = 'icons/obj/items/clothing/hats/hazard.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hazard.dmi'
	)
	icon_state = "pizza_galaxy_helmet"
	item_state = "pizza_galaxy_helmet"
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	flags_inventory = COVEREYES|BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEEYES|HIDETOPHAIR

// Biosuits

/obj/item/clothing/head/bio_hood/wy_bio
	name = "WY-TSS MK II - 生物防护头罩"
	desc = "'维兰德-汤谷地球科学生物防护服 MK II'。一款由维兰德-汤谷内部研发的先进轻量化生物防护服。这是一个保护头部和面部免受生物污染物侵害的头罩。"
	icon = 'icons/obj/items/clothing/hats/hazard.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hazard.dmi'
	)
	icon_state = "sci_expedition_helmet"
	item_state = "sci_expedition_helmet"

/obj/item/clothing/head/bio_hood/wy_bio/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/head/bio_hood/wy_bio/alt
	name = "WY-TSS MK I - 生物防护头罩"
	desc = "'维兰德-汤谷地球科学生物防护服 MK I'。一款由维兰德-汤谷内部研发的先进轻量化生物防护服。这是一个保护头部和面部免受生物污染物侵害的头罩。"
	icon_state = "sci_expedition_helmet_alt"
	item_state = "sci_expedition_helmet_alt"

/obj/item/clothing/suit/bio_suit/wy_bio
	name = "WY-TSS MK I - 生物防护服"
	desc = "'维兰德-汤谷地球科学生物防护服 MK I'。一款由维兰德-汤谷内部研发的先进轻量化生物防护服。这是一套提供生物污染防护的服装。"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
	)
	icon_state = "sci_expedition"
	item_state = "sci_expedition"
	slowdown = 0
	uniform_restricted = null

/obj/item/clothing/suit/bio_suit/wy_bio/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

// Synth Bio

/obj/item/clothing/head/bio_hood/synth/wy_bio
	name = "WY-TSS MK II - 生物防护头罩"
	desc = "'维兰德-汤谷地球科学生物防护服 MK II'。一款由维兰德-汤谷内部研发的先进轻量化生物防护服。这是一个保护头部和面部免受生物污染物侵害的头罩，合成人适用。不提供实质性防护。"
	icon = 'icons/obj/items/clothing/hats/hazard.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hazard.dmi'
	)
	icon_state = "sci_expedition_helmet"
	item_state = "sci_expedition_helmet"

/obj/item/clothing/head/bio_hood/synth/wy_bio/alt
	name = "WY-TSS MK I - 生物防护头罩"
	desc = "'维兰德-汤谷地球科学生物防护服 MK I'。一款由维兰德-汤谷内部研发的先进轻量化生物防护服。这是一个保护头部和面部免受生物污染物侵害的头罩，合成人适用。不提供实质性防护。"
	icon_state = "sci_expedition_helmet_synth"
	item_state = "sci_expedition_helmet_synth"

/obj/item/clothing/suit/storage/synthbio/wy_bio
	name = "WY-TSS MK I - 生物防护服"
	desc = "'维兰德-汤谷地球科学生物防护服 MK I'。一款由维兰德-汤谷内部研发的先进轻量化生物防护服。一套合成人适用的生物危害防护服。旨在让合成人能够向人类营造感染控制的假象。其内部大部分防护衬里已被移除，以便容纳装备并减轻移动负担。"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
	)
	icon_state = "sci_expedition_synth"
	item_state = "sci_expedition_synth"
	uniform_restricted = null

/////////////////////// Oversuits ///////////////////////
////////////////////////////////////////////////////////

// Fire-Fighter

/obj/item/clothing/suit/storage/marine/light/vest/fire_light

	name = "PT-LT防火服"
	desc = "'PyroTex LT'是一款由'Watatsumi'研发的先进轻量化防火服。它提供防火和防热保护，同时也能提供一定程度的钝器创伤防护。"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
	)
	icon_state = "firefighter_oversuit"
	item_state = "firefighter_oversuit"
	uniform_restricted = null
	gas_transfer_coefficient = 0.90
	fire_intensity_resistance = BURN_LEVEL_TIER_1
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	allowed = list(
		/obj/item/tool/extinguisher,
		/obj/item/device/flashlight,
		/obj/item/device/healthanalyzer,
		/obj/item/device/radio,
		/obj/item/tank/emergency_oxygen,
		/obj/item/tool/crowbar,
		/obj/item/tool/pen,
		/obj/item/weapon/gun,
		/obj/item/prop/prop_gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/storage/bible,
		/obj/item/attachable/bayonet,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/belt/gun/type47,
		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
		/obj/item/storage/belt/gun/smartpistol,
		/obj/item/storage/belt/gun/flaregun,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
		/obj/item/storage/belt/gun/m39,
		/obj/item/storage/belt/gun/xm51,
	)
	slowdown = 1
	flags_inventory = NOPRESSUREDMAGE
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROT
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS

/obj/item/clothing/suit/storage/marine/light/vest/fire_light/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/corp_label/armat)

/obj/item/clothing/suit/storage/marine/light/vest/fire_light/equipped(mob/user, slot)
	if(slot == WEAR_JACKET)
		RegisterSignal(user, COMSIG_LIVING_FLAMER_CROSSED, PROC_REF(flamer_fire_crossed_callback))
	..()

/obj/item/clothing/suit/storage/marine/light/vest/fire_light/dropped(mob/user)
	UnregisterSignal(user, COMSIG_LIVING_FLAMER_CROSSED)
	..()

/obj/item/clothing/suit/storage/marine/light/vest/fire_light/proc/flamer_fire_crossed_callback(mob/living/L, datum/reagent/R)
	SIGNAL_HANDLER

	if(R.fire_penetrating)
		return

	return COMPONENT_NO_IGNITE

// UPP firefighter

/obj/item/clothing/suit/storage/marine/light/vest/fire_light/upp
	name = "T-20消防响应外套"
	desc = "一款配发给UPP工业和应急人员的坚固、无装饰的防火大衣。基于PyroTex LT设计，但使用更廉价的国产材料，它以重量和舒适度为代价，提供对高温和碎片的基本防护。"
	icon_state = "upp_firefighter_alt"
	item_state = "upp_firefighter_alt"
	uniform_restricted = FALSE

/obj/item/clothing/suit/storage/marine/light/vest/fire_light/upp/alt
	icon_state = "upp_firefighter"
	item_state = "upp_firefighter"

/obj/item/clothing/suit/storage/marine/light/vest/fire_light/upp/synth
	name = "T-20合成人防火响应外套"
	desc = "一款配发给UPP工业和应急人员的坚固、无装饰的防火大衣。基于PyroTex LT设计，但使用更廉价的国产材料，它以重量和舒适度为代价，提供对高温和碎片的基本防护。"

	time_to_unequip = 0.5 SECONDS
	time_to_equip = 1 SECONDS
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_NONE
	storage_slots = 4
	slowdown = SLOWDOWN_ARMOR_SUPER_LIGHT

/obj/item/clothing/suit/storage/marine/light/vest/fire_light/upp/synth/Initialize()
	flags_atom |= NO_NAME_OVERRIDE
	flags_marine_armor |= SYNTH_ALLOWED
	return ..()

/obj/item/clothing/suit/storage/marine/light/vest/fire_light/upp/synth/alt
	name = "T-20合成人防火响应外套"
	desc = "一款配发给UPP工业和应急人员的坚固、无装饰的防火大衣。基于PyroTex LT设计，但使用更廉价的国产材料，它以重量和舒适度为代价，提供对高温和碎片的基本防护。"
	icon_state = "upp_firefighter"
	item_state = "upp_firefighter"

	time_to_unequip = 0.5 SECONDS
	time_to_equip = 1 SECONDS
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_NONE
	storage_slots = 4
	slowdown = SLOWDOWN_ARMOR_SUPER_LIGHT

/obj/item/clothing/suit/storage/marine/light/vest/fire_light/upp/synth/alt/Initialize()
	flags_atom |= NO_NAME_OVERRIDE
	flags_marine_armor |= SYNTH_ALLOWED
	return ..()

// Kelland Mining

/obj/item/clothing/suit/storage/marine/light/vest/hybrisa_kelland
	name = "\improper Kelland-Mining utility uniform"
	desc = "一套标准配发的凯兰矿业工装服，包括一条黄色工装裤和一件黑色立领重型填充夹克，可抵御多种环境危害。"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
	)
	icon_state = "kellandmining_oversuit"
	item_state = "kellandmining_oversuit"
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/prop/prop_gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/storage/bible,
		/obj/item/attachable/bayonet,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/belt/gun/type47,
		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
		/obj/item/storage/belt/gun/smartpistol,
		/obj/item/storage/belt/gun/flaregun,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
		/obj/item/storage/belt/gun/m39,
		/obj/item/storage/belt/gun/xm51,
	)

/obj/item/clothing/suit/storage/marine/light/vest/hybrisa_kelland/Initialize()
	. = ..()
	RemoveElement(/datum/element/corp_label/armat)
	AddElement(/datum/element/corp_label/kelland)

/obj/item/clothing/suit/storage/marine/light/vest/hybrisa_kelland_alt
	name = "\improper Kelland-Mining utility uniform"
	desc = "一套标准配发的凯兰矿业工装服，包括一条黄色工装裤和一件黑色立领重型填充夹克，可抵御多种环境危害。"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
	)
	icon_state = "kellandmining_alt_oversuit"
	item_state = "kellandmining_alt_oversuit"
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/prop/prop_gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/storage/bible,
		/obj/item/attachable/bayonet,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/belt/gun/type47,
		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
		/obj/item/storage/belt/gun/smartpistol,
		/obj/item/storage/belt/gun/flaregun,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
		/obj/item/storage/belt/gun/m39,
		/obj/item/storage/belt/gun/xm51,
	)

/obj/item/clothing/suit/storage/marine/light/vest/hybrisa_kelland_alt/Initialize()
	. = ..()
	RemoveElement(/datum/element/corp_label/armat)
	AddElement(/datum/element/corp_label/kelland)

// EMT - Paramedic

/obj/item/clothing/suit/hybrisa/EMT_green_utility
	name = "\improper EMT - Paramedic utility fatigues"
	desc = "一套紧急医疗技术员-护理员工装服，这是绿色的。"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
	)
	icon_state = "paramedic_green_oversuit"
	item_state = "paramedic_green_oversuit"
	uniform_restricted = null

/obj/item/clothing/suit/hybrisa/EMT_red_utility
	name = "\improper EMT - Paramedic utility fatigues"
	desc = "一套紧急医疗技术员-护理员工装服，这是红色的。"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
	)
	icon_state = "paramedic_redblack_oversuit"
	item_state = "paramedic_redblack_oversuit"
	uniform_restricted = null

// Sanitation

/obj/item/clothing/suit/hybrisa/sanitation_utility
	name = "\improper Sanitation utility uniform"
	desc = "一套清洁工装服，供较富裕殖民地的清理人员使用。"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
	)
	icon_state = "sanitation_worker_oversuit"
	item_state = "sanitation_worker_oversuit"
	uniform_restricted = null

// Engineer Utility Oversuit

/obj/item/clothing/suit/hybrisa/engineering_utility_oversuit
	name = "\improper Weyland-Yutani engineer utility uniform"
	desc = "一套维兰德-汤谷工程师工装服。被维兰德-汤谷殖民地工程师用作通用工装外套。"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
	)
	icon_state = "engineer_worker_oversuit"
	item_state = "engineer_worker_oversuit"
	uniform_restricted = null

/obj/item/clothing/suit/hybrisa/engineering_utility_oversuit/alt
	icon_state = "engineer_worker_alt_oversuit"
	item_state = "engineer_worker_alt_oversuit"

// WY Pilot

/obj/item/clothing/suit/storage/hybrisa/wy_Pilot
	name = "\improper Weyland-Yutani Pilot formal-jacket"
	desc = "一件西装式夹克，配有毛皮衬里衣领和象征军衔的金色肩章。由维兰德-汤谷认证的民用飞行员穿着，类似于旧地球的正式飞行员服装。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/WY.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/WY.dmi'
	)
	icon_state = "civilian_pilot_jacket"
	item_state = "civilian_pilot_jacket"
	uniform_restricted = null

// Executive Trench-coat

/obj/item/clothing/suit/storage/CMB/hybrisa/fur_lined_trench_coat
	name = "\improper expensive fur-lined trench-coat"
	desc = "一件奢华的毛皮衬里、复古风格风衣，散发着经典黑色电影的优雅气息。这件精美的服装远非普通人所能负担，仅供高级管理人员和精英军事人员使用。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/WY.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/WY.dmi'
	)
	icon_state = "wy_expensive_fur_trenchcoat"
	item_state = "wy_expensive_fur_trenchcoat"
	uniform_restricted = null

/obj/item/clothing/suit/storage/CMB/hybrisa/fur_lined_trench_coat/alt
	icon_state = "wy_expensive_fur_trenchcoat_alt"
	item_state = "wy_expensive_fur_trenchcoat_alt"


// CMB Police Jackets & Armor

// CMB Jacket

/obj/item/clothing/suit/storage/CMB/hybrisa
	name = "\improper CMB Marshal jacket"
	desc = "一件黑色聚酯夹克，上面别着执法官的徽章。代表着外缘星系的正义、权威与保护。地球的法律延伸至太阳系之外。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/CMB.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/CMB.dmi'
	)
	icon_state = "police_jacket"
	item_state = "police_jacket"
	uniform_restricted = null

// CMB Vest

/obj/item/clothing/suit/armor/vest/hybrisa/cmb_vest
	name = "CMB防弹背心"
	desc = "一件CMB防弹背心，可提供一定程度的伤害防护。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/CMB.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/CMB.dmi'
	)
	icon_state = "police_ballistic_armor"
	item_state = "police_ballistic_armor"
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/armor/vest/hybrisa/civilian_vest
	name = "防弹背心"
	desc = "一件通用、无标识的防弹背心，可提供一定程度的伤害防护。"
	icon_state = "generic_ballistic_armor"
	item_state = "generic_ballistic_armor"
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW

// Hazard Vests

/obj/item/clothing/suit/storage/hazardvest/medical_green
	name = "紧急医疗技术员-绿色危险警示背心"
	desc = "一件用于工作区域的绿白相间紧急医疗技术员高能见度危险警示背心。"
	icon = 'icons/obj/items/clothing/suits/vests_aprons.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/vests_aprons.dmi',
	)
	icon_state = "medicalhazard_green"
	item_state = "medicalhazard_green"

/obj/item/clothing/suit/storage/hazardvest/medical_red
	name = "紧急医疗技术员-红色危险警示背心"
	desc = "一件用于工作区域的红白相间紧急医疗技术员高能见度危险警示背心。"
	icon = 'icons/obj/items/clothing/suits/vests_aprons.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/vests_aprons.dmi',
	)
	icon_state = "medicalhazard_white"
	item_state = "medicalhazard_white"

/obj/item/clothing/suit/storage/hazardvest/kelland_mining
	name = "凯兰矿业危险警示背心"
	desc = "一件用于工作区域的黑色高能见度背心。"
	icon = 'icons/obj/items/clothing/suits/vests_aprons.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/vests_aprons.dmi',
	)
	icon_state = "kellandmining_hazard"
	item_state = "kellandmining_hazard"

/obj/item/clothing/suit/storage/hazardvest/sanitation
	name = "绿色危险警示背心"
	desc = "一件用于工作区域的绿白相间高能见度背心。"
	icon = 'icons/obj/items/clothing/suits/vests_aprons.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/vests_aprons.dmi',
	)
	icon_state = "sanitation_hazard"
	item_state = "sanitation_hazard"

/obj/item/clothing/suit/storage/hazardvest/weymart
	name = "维市背心"
	desc = "一件蓝色的‘维市’员工背心，配有姓名牌等。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/WY.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/WY.dmi'
	)
	icon_state = "weymart_vest"
	item_state = "weymart_vest"

// Civilian Coats

/obj/item/clothing/suit/storage/snow_suit/hybrisa/parka_blue
	name = "深蓝色旧派克大衣"
	desc = "一件破旧的蓝色派克大衣，曾经风光过……"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)
	icon_state = "hobocoat_blue"
	item_state = "hobocoat_blue"

/obj/item/clothing/suit/storage/snow_suit/hybrisa/parka_brown
	name = "深棕色磨损派克大衣"
	desc = "一件老旧磨损的棕色派克大衣，经历过更好的日子..."
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)
	icon_state = "hobocoat_brown"
	item_state = "hobocoat_brown"

/obj/item/clothing/suit/storage/snow_suit/hybrisa/parka_green
	name = "深绿色磨损派克大衣"
	desc = "一件老旧磨损的绿色派克大衣，经历过更好的日子..."
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)
	icon_state = "hobocoat_green"
	item_state = "hobocoat_green"

/obj/item/clothing/suit/storage/snow_suit/hybrisa/polyester_jacket_brown
	name = "深棕色磨损涤纶夹克"
	desc = "一件老旧磨损的棕色涤纶夹克，经历过更好的日子..."
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)
	icon_state = "hobocoat_dark"
	item_state = "hobocoat_dark"

/obj/item/clothing/suit/storage/snow_suit/hybrisa/polyester_jacket_blue
	name = "深蓝色磨损涤纶夹克"
	desc = "一件老旧磨损的蓝色涤纶夹克，经历过更好的日子..."
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)
	icon_state = "hobocoat_darkblue"
	item_state = "hobocoat_darkblue"

/obj/item/clothing/suit/storage/snow_suit/hybrisa/polyester_jacket_red
	name = "深红色磨损涤纶夹克"
	desc = "一件老旧磨损的红色涤纶夹克，经历过更好的日子..."
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)
	icon_state = "hobocoat_darkred"
	item_state = "hobocoat_darkred"

// Cuppa Joe's Apron

/obj/item/clothing/suit/apron/cuppa_joes
	name = "红色围裙"
	desc = "一条普通的红色围裙。"
	icon_state = "cuppajoes_apron"
	item_state = "cuppajoes_apron"

/////////////////////// MISC ///////////////////////////
////////////////////////////////////////////////////////

// Closets

/obj/structure/closet/hybrisa/wy_bio
	icon_state = "bio_general"
	icon_closed = "bio_general"
	icon_opened = "bio_generalopen"

/obj/structure/closet/hybrisa/wy_bio/Initialize()
	. = ..()
	contents = list()
	new /obj/item/clothing/suit/bio_suit/wy_bio( src )
	new /obj/item/clothing/head/bio_hood/wy_bio/alt( src )

/obj/structure/closet/secure_closet/hybrisa/nspa
	name = "NSPA装备柜"
	req_one_access = list(ACCESS_MARINE_BRIG, ACCESS_CIVILIAN_BRIG)
	icon_state = "secure_locked_warrant"
	icon_closed = "secure_unlocked_warrant"
	icon_locked = "secure_locked_warrant"
	icon_opened = "secure_open_warrant"
	icon_broken = "secure_locked_warrant"
	icon_off = "secure_closed_warrant"


/obj/structure/closet/secure_closet/hybrisa/nspa/Initialize()
	. = ..()
	new /obj/item/clothing/suit/armor/vest/hybrisa/nspa_vest(src)
	new /obj/item/clothing/under/hybrisa/nspa_officer(src)
	new /obj/item/storage/backpack/security(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/storage/belt/gun/l54(src)

// Miner Closet

/obj/structure/closet/secure_closet/hybrisa/miner
	name = "矿工装备"
	icon_state = "miningsec1"
	icon_closed = "miningsec"
	icon_locked = "miningsec1"
	icon_opened = "miningsecopen"
	icon_broken = "miningsecbroken"
	icon_off = "miningsecoff"
	req_access = list(ACCESS_CIVILIAN_PUBLIC)

/obj/structure/closet/secure_closet/hybrisa/miner/Initialize()
	. = ..()
	if(prob(50))
		new /obj/item/clothing/suit/storage/marine/light/vest/hybrisa_kelland(src)
	else
		new /obj/item/clothing/suit/storage/marine/light/vest/hybrisa_kelland_alt(src)
// new /obj/item/device/radio/headset/almayer/ct(src)
	new /obj/item/clothing/under/hybrisa/kelland_mining(src)
	new /obj/item/clothing/gloves/black(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/device/analyzer(src)
	new /obj/item/storage/bag/ore(src)
	new /obj/item/device/flashlight/lantern(src)
	new /obj/item/tool/shovel(src)
	new /obj/item/tool/pickaxe(src)
	new /obj/item/storage/backpack/satchel/eng(src)

// NSPA Clothing

// Uniform

/obj/item/clothing/under/hybrisa/nspa_officer
	name = "\improper NSPA - police uniform"
	desc = "一条黑色西裤和一件白色纽扣衬衫，配黑色领带；NSPA部队的标准制服，适用于更城市化的殖民地，类似于地球上更传统的警察部队所穿的制服。"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/TWE.dmi',
	)
	icon_state = "nspa_police"
	worn_state = "nspa_police"
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW

/obj/item/clothing/under/hybrisa/nspa_officer/warm_weather
	desc = "一件短袖橄榄绿纽扣衬衫，配同色长裤和黑色战术背心带；标准的NSPA暖天巡逻制服，为内罗伊德星区较热气候地区配发，灵感来自历史上的殖民地警察服装，兼具实用性与干练外观。"
	icon_state = "nspa_police_warm"
	worn_state = "nspa_police_warm"

// Suits & Armor

/obj/item/clothing/suit/armor/vest/hybrisa/nspa_vest
	name = "NSPA防弹背心"
	desc = "一件NSPA防弹背心，可提供一定程度的防护。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/TWE.dmi'
	)
	icon_state = "nspa_police_ballistic_armor"
	item_state = "nspa_police_ballistic_armor"
	uniform_restricted = null
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW

/obj/item/clothing/suit/storage/CMB/hybrisa/nspa_jacket
	name = "\improper NSPA police jacket"
	desc = "一件黑色涤纶夹克，上面别着NSPA的银色樱花徽章。帝国与荣耀，职责所系。职责无界，正义遍及寰宇。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/TWE.dmi'
	)
	icon_state = "nspa_police_jacket"
	item_state = "nspa_police_jacket"
	uniform_restricted = null

/obj/item/clothing/suit/storage/CMB/hybrisa/nspa_formal_jacket
	name = "\improper NSPA police formal jacket"
	desc = "NSPA警员常用的厚重羊毛正装大衣。帝国与荣耀，职责所系。职责无界，正义遍及寰宇。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/TWE.dmi'
	)
	icon_state = "nspa_police_formal_jacket"
	item_state = "nspa_police_formal_jacket"
	uniform_restricted = null

/obj/item/clothing/suit/storage/CMB/hybrisa/nspa_hazard_jacket
	name = "\improper NSPA high-vis jacket"
	desc = "NSPA人员常用的绿白条纹（高可见度）涤纶夹克。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/TWE.dmi'
	)
	icon_state = "nspa_hazard_jacket"
	item_state = "nspa_hazard_jacket"
	uniform_restricted = null

/obj/item/clothing/suit/storage/hazardvest/nspa_hazard
	name = "NSPA危险作业背心"
	desc = "NSPA人员常用的绿白高可见度背心。"
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_faction/TWE.dmi'
	)
	icon_state = "nspa_hazard_vest"
	item_state = "nspa_hazard_vest"

// NSPA - Hats

/obj/item/clothing/head/hybrisa/nspa_peaked_cap
	name = "\improper NSPA peaked cap"
	desc = "一顶深色大檐帽，上面饰有NSPA强大的银红樱花形徽章。帝国与荣耀，职责所系。职责无界，正义遍及寰宇。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/TWE.dmi',
	)
	icon_state = "nspa_police_cap_rank1"
	item_state = "nspa_police_cap_rank1"
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS

/obj/item/clothing/head/hybrisa/nspa_peaked_cap_goldandsilver
	name = "\improper NSPA peaked cap"
	desc = "一顶深色大檐帽，上面饰有NSPA强大的金银樱花形徽章。帝国与荣耀，职责所系。职责无界，正义遍及寰宇。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/TWE.dmi',
	)
	icon_state = "nspa_police_cap_rank2"
	item_state = "nspa_police_cap_rank2"
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS

/obj/item/clothing/head/hybrisa/nspa_peaked_cap_gold
	name = "\improper NSPA peaked cap"
	desc = "一顶深色大檐帽，上面印有NSPA强大而醒目的红金色樱花形徽章，通常由高级警官和NSPA人员佩戴。帝国与荣耀，职责所系。职责无界，正义遍及寰宇。"
	icon = 'icons/obj/items/clothing/hats/hats_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats_by_faction/TWE.dmi',
	)
	icon_state = "nspa_police_cap_rank3"
	item_state = "nspa_police_cap_rank3"
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = NO_FLAGS
