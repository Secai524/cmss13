/datum/equipment_preset/survivor/security/nv
	name = "幸存者 - 新瓦拉德罗保安"
	assignment = "United Americas Peacekeeper"

/datum/equipment_preset/survivor/security/nv/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/ua_riot(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/sec(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/ua_riot(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	..()

/datum/equipment_preset/survivor/doctor/nv
	name = "幸存者 - 新瓦拉德罗医疗技术员"
	assignment = "New Varadero Medical Technician"

/datum/equipment_preset/survivor/doctor/nv/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/utility(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
	..()

/datum/equipment_preset/survivor/scientist/nv
	name = "幸存者 - 新瓦拉德罗研究员"
	assignment = "New Varadero Researcher"

/datum/equipment_preset/survivor/scientist/nv/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/researcher(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat/researcher(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/cm/tan(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/science(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/chem(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
	..()

/datum/equipment_preset/survivor/interstellar_commerce_commission_liaison/nv
	name = "幸存者 - 星际商业委员会联络官 新瓦拉德罗"
	assignment = "星际商业委员会公司联络官"

/datum/equipment_preset/survivor/interstellar_commerce_commission_liaison/nv/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/corporate_formal(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat/white(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/black(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clipboard, WEAR_L_HAND)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses, WEAR_EYES)
	..()

/datum/equipment_preset/survivor/trucker/nv
	name = "幸存者 - 新瓦拉德罗货物技术员"
	assignment = "New Varadero Cargo Technician"

/datum/equipment_preset/survivor/trucker/nv/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/utility/brown(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/meson(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beanie/tan(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/tech(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown(new_human), WEAR_HANDS)
	..()

/datum/equipment_preset/survivor/engineer/nv
	name = "幸存者 - 新瓦拉德罗技术员"
	assignment = "New Varadero Engineer"

/datum/equipment_preset/survivor/engineer/nv/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/utility/gray(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/blue(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/eng(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat/dblue(new_human), WEAR_HEAD)
	..()

/datum/equipment_preset/survivor/chaplain/nv
	name = "幸存者 - 新瓦拉德罗牧师"
	assignment = "New Varadero Priest"

/datum/equipment_preset/survivor/chaplain/nv/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/norm(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/priest_robe(new_human), WEAR_JACKET)
	add_survivor_rare_item(new_human)
	..()
