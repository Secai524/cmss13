
//marine gloves

/obj/item/clothing/gloves/marine
	name = "陆战队战斗手套"
	desc = "陆战队标准制式战术手套。上面写着：‘由陆战队遗孀协会编织’。"
	icon_state = "black"
	item_state = "black"
	siemens_coefficient = 0.6

	flags_cold_protection = BODY_FLAG_HANDS
	flags_heat_protection = BODY_FLAG_HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROT
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROT
	flags_armor_protection = BODY_FLAG_HANDS
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_LOW
	var/adopts_squad_color = TRUE
	/// The dmi where the grayscale squad overlays are contained
	var/squad_overlay_icon = 'icons/mob/humans/onmob/clothing/hands_garb.dmi'

/obj/item/clothing/gloves/marine/get_mob_overlay(mob/living/carbon/human/current_human, slot, default_bodytype = "默认")
	var/image/ret = ..()
	if(!adopts_squad_color || !(current_human?.assigned_squad?.equipment_color))
		return ret
	var/image/glove_overlay = image(squad_overlay_icon, icon_state = "std-gloves")
	glove_overlay.alpha = current_human.assigned_squad.armor_alpha
	glove_overlay.color = current_human.assigned_squad.equipment_color
	ret.overlays += glove_overlay
	return ret

/obj/item/clothing/gloves/marine/insulated
	name = "陆战队绝缘手套"
	desc = "这副手套能保护佩戴者免受电击。"
	icon_state = "insulated"
	item_state = "insulated"
	siemens_coefficient = 0

/obj/item/clothing/gloves/marine/insulated/black
	name = "陆战队黑色绝缘手套"
	desc = "这些陆战队手套能保护穿戴者免受电击和弹片伤害。是装备齐全的陆战队员的标准配发品。"
	icon_state = "yellow"
	item_state = "black"
	item_state_slots = list(WEAR_HANDS = "black")
	adopts_squad_color = FALSE

/obj/item/clothing/gloves/marine/black
	name = "陆战队黑色战斗手套"
	adopts_squad_color = FALSE

/obj/item/clothing/gloves/marine/brown
	name = "陆战队棕色战斗手套"
	desc = "陆战队标准制式战术手套。上面写着：‘由陆战队遗孀协会编织’。这是棕色款，而非经典的黑色。"
	icon_state = "brown"
	item_state = "brown"
	adopts_squad_color = FALSE

/obj/item/clothing/gloves/marine/grey
	name = "陆战队灰色战斗手套"
	desc = "陆战队标准制式战术手套。上面写着：‘由陆战队遗孀协会编织’。这是灰色款，而非经典的黑色。"
	icon_state = "marine_grey"
	item_state = "marine_grey"
	adopts_squad_color = FALSE

/obj/item/clothing/gloves/marine/fingerless
	name = "陆战队无指战斗手套"
	desc = "陆战队标准制式战术手套。上面写着：‘由陆战队遗孀协会编织’。这副手套经过改装，指尖部分已被移除。"
	icon_state = "marine_fingerless"
	item_state = "marine_fingerless"
	adopts_squad_color = FALSE

/obj/item/clothing/gloves/marine/medical
	name = "陆战队医疗战斗手套"
	desc = "陆战队标准制式无菌手套，提供常规防护，同时让使用者在执行医疗工作时获得更好的抓握力。"
	icon_state = "latex"
	item_state = "latex"
	adopts_squad_color = FALSE


/obj/item/clothing/gloves/marine/officer
	name = "军官手套"
	desc = "闪亮而引人注目。看起来价格不菲。"
	icon_state = "black"
	item_state = "bgloves"
	adopts_squad_color = FALSE

/obj/item/clothing/gloves/marine/officer/chief
	name = "高级军官手套"
	desc = "血痂附着在其略有凹陷的金属铆钉上。"

/obj/item/clothing/gloves/marine/techofficer
	name = "技术军官手套"
	desc = "无菌且绝缘！为什么不是每个人都配发这个？"
	icon_state = "yellow"
	item_state = "ygloves"
	siemens_coefficient = 0

	adopts_squad_color = FALSE

/obj/item/clothing/gloves/marine/techofficer/fancy
	name = "豪华战斗手套"
	desc = "采用近乎金色外观面料制成的战斗手套。绝缘、时尚，并能保护其包裹着的柔软双手。"
	icon_state = "captain"
	item_state = "captain"

/obj/item/clothing/gloves/marine/specialist
	name = "\improper B18 defensive gauntlets"
	desc = "一副重装甲手套。"
	icon_state = "black"
	item_state = "bgloves"
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bullet = CLOTHING_ARMOR_ULTRAHIGH
	armor_laser = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_ULTRAHIGH
	armor_rad = CLOTHING_ARMOR_ULTRAHIGH
	armor_internaldamage = CLOTHING_ARMOR_ULTRAHIGH
	unacidable = TRUE

/obj/item/clothing/gloves/marine/M3G
	name = "\improper M3-G4 Grenadier gloves"
	desc = "一副覆甲但灵巧的手套。"
	icon_state = "grenadier"
	item_state = "grenadier"
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_laser = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_ULTRAHIGH
	armor_rad = CLOTHING_ARMOR_VERYHIGH
	armor_internaldamage = CLOTHING_ARMOR_VERYHIGH
	unacidable = TRUE
	flags_item = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE
	adopts_squad_color = FALSE

/obj/item/clothing/gloves/marine/veteran
	name = "装甲手套"
	desc = "非标准凯夫隆纤维手套。它们绝缘且重装甲。"
	icon_state = "veteran"
	item_state = "veteran"
	siemens_coefficient = 0
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_laser = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_HIGH
	adopts_squad_color = FALSE

/obj/item/clothing/gloves/marine/veteran/upp
	icon_state = "brown"
	item_state = "brown"

/obj/item/clothing/gloves/marine/veteran/insulated
	name = "绝缘装甲手套"
	desc = "非标准凯夫隆纤维手套。这些显然特别绝缘。"
	icon_state = "insulated"
	item_state = "insulated"

/obj/item/clothing/gloves/marine/veteran/ppo
	name = "\improper WY PPO gloves"
	desc = "由维兰德-汤谷个人防护部门制造的标准配发凯夫隆纤维手套。它们绝缘，可防电击。"
	icon_state = "ppo"
	item_state = "ppo"

/obj/item/clothing/gloves/marine/veteran/pmc
	name = "\improper WY PMC gloves"
	desc = "由维兰德-汤谷PMC派遣部门制造的标准配发凯夫隆纤维手套。它们绝缘，可防电击。"
	icon_state = "pmc"
	item_state = "pmc"

/obj/item/clothing/gloves/marine/veteran/pmc/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/gloves/marine/veteran/pmc/commando
	name = "\improper W-Y Commando gloves"
	desc = "由维兰德-汤谷突击队制造的标准配发凯夫隆纤维手套。它们绝缘，可防电击。"
	icon_state = "pmc_elite"
	item_state = "pmc_elite"
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_HIGH

/obj/item/clothing/gloves/marine/veteran/pmc/commando/leader
	icon_state = "pmc_elite_leader"
	item_state = "pmc_elite_leader"

/obj/item/clothing/gloves/marine/veteran/pmc/apesuit
	name = "\improper M5X gauntlets"
	desc = "一副为重装甲M5X Apesuit系统配套制造的重装甲手套。"
	icon_state = "gauntlets"
	item_state = "bgloves"
	siemens_coefficient = 0
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_VERYHIGH
	unacidable = TRUE

/obj/item/clothing/gloves/marine/veteran/pmc/combat_droid
	name = "\improper M7X gauntlets"
	desc = "一副为重装甲M7X Apesuit系统配套制造的重装甲手套。"
	icon_state = "combat_android_gloves"
	item_state = "bgloves"
	item_state_slots = list(WEAR_HANDS = "marine_grey")
	siemens_coefficient = 0
	armor_melee = CLOTHING_ARMOR_VERYHIGH
	armor_bullet = CLOTHING_ARMOR_ULTRAHIGH
	armor_laser = CLOTHING_ARMOR_MEDIUMHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_ULTRAHIGH
	armor_rad = CLOTHING_ARMOR_ULTRAHIGH
	armor_internaldamage = CLOTHING_ARMOR_ULTRAHIGH
	unacidable = TRUE

/obj/item/clothing/gloves/marine/dress
	name = "礼服手套"
	desc = "一副时尚的白色手套，供陆战队员穿着礼服时佩戴。"
	icon_state = "marine_white"
	item_state = "marine_white"
	adopts_squad_color = FALSE

/obj/item/clothing/gloves/marine/veteran/souto
	name = "\improper Souto Man gloves"
	desc = "Souto Man佩戴的手套。抓握力比Souto樱桃口味更强劲！"
	icon_state = "souto_man"
	item_state = "souto_man"
	flags_inventory = CANTSTRIP
	armor_melee = CLOTHING_ARMOR_HARDCORE
	armor_bullet = CLOTHING_ARMOR_HARDCORE
	armor_laser = CLOTHING_ARMOR_HARDCORE
	armor_energy = CLOTHING_ARMOR_HARDCORE
	armor_bomb = CLOTHING_ARMOR_HARDCORE
	armor_bio = CLOTHING_ARMOR_HARDCORE
	armor_rad = CLOTHING_ARMOR_HARDCORE
	armor_internaldamage = CLOTHING_ARMOR_HARDCORE
	unacidable = TRUE
	adopts_squad_color = FALSE

/obj/item/clothing/gloves/marine/veteran/souto/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/souta)

/obj/item/clothing/gloves/marine/veteran/insulated/van_bandolier
	name = "定制射击手套"
	desc = "对伤害、温度和电击具有高度防护性。冬暖夏凉，在任何表面都能提供稳固抓握。你可以用这个价格买很多东西，但它们物有所值。"

/obj/item/clothing/gloves/marine/joe
	name = "希格森危险品手套"
	desc = "专为接触和处理极端危险材料而制造的特殊合成手套。抗生物危害液体、腐蚀性材料等。背面自豪地印有SEEGSON标志和生物危害符号。明天，携手共进。"
	icon_state = "working_joe"
	item_state = "working_joe"
	siemens_coefficient = 0
	armor_melee = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_VERYHIGH
	armor_rad = CLOTHING_ARMOR_VERYHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	unacidable = TRUE
	adopts_squad_color = FALSE

/obj/item/clothing/gloves/marine/joe/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/seegson)

//=ROYAL MARINES=\\

/obj/item/clothing/gloves/marine/veteran/royal_marine
	name = "\improper L6 pattern combat gloves"
	desc = "皇家海军陆战队使用的标准配发战术手套。"
	icon_state = "rmc_gloves"
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN

/obj/item/clothing/gloves/marine/veteran/royal_marine/medical
	name = "\improper L6 pattern combat medic gloves"
	desc = "皇家海军陆战队战斗医疗兵使用的标准配发战术手套。无菌且仍适用于战斗。"
	icon_state = "latex"
	item_state = "latex"
	adopts_squad_color = FALSE
	armor_bio = CLOTHING_ARMOR_MEDIUM

/obj/item/clothing/gloves/marine/veteran/cbrn
	name = "\improper M3 MOPP gloves"
	desc = "M3 MOPP手套由经过处理的文拉尔制成，旨在保护使用者在CBRN环境中工作时双手免受污染。特别设计确保使用者双手有足够的灵活性来完全维护步枪或使用大多数手持工具，同时手指上的圆形粘性图案提供了增强的抓握力。标准CBRN协议规定，一旦暴露于中等污染水平，手套的最大有效寿命约为二十四小时，建议使用者在之后丢弃并更换。"
	icon_state = "cbrn"
	item_state = "cbrn"
	armor_bio = CLOTHING_ARMOR_GIGAHIGHPLUS
	armor_rad = CLOTHING_ARMOR_GIGAHIGHPLUS

/obj/item/clothing/gloves/marine/cbrn_non_armored
	name = "\improper M2 MOPP gloves"
	desc = "这些旧型号M2 MOPP手套由经过处理的文拉尔制成，在CBRN环境中提供基本的防污染保护。虽然它们为操作小型工具和武器提供了良好的灵活性，但缺乏新型号的高级抓握增强和耐用性。通常，这些手套在中等暴露下最多可保持12小时有效，之后必须更换。"
	icon_state = "cbrn"
	item_state = "cbrn"
