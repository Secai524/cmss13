

/obj/item/clothing/shoes/marine
	name = "陆战队员作战靴"
	desc = "用于战斗场景或作战状况的标准配发作战靴。时刻准备战斗。"
	icon_state = "marine"
	item_state = "marine"
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT
	siemens_coefficient = 0.7
	allowed_items_typecache = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
		/obj/item/weapon/gun/pistol/action,
		/obj/item/weapon/gun/pistol/clfpistol,
		/obj/item/tool/screwdriver,
		/obj/item/tool/surgery/scalpel,
		/obj/item/weapon/straight_razor,
	)
	drop_sound = "armorequip"

/obj/item/clothing/shoes/marine/update_icon()
	if(stored_item)
		icon_state = "[initial(icon_state)]-1"
	else
		icon_state = initial(icon_state)

/obj/item/clothing/shoes/marine/knife
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/jungle
	icon_state = "marine_jungle"
	desc = "别走得太慢，魔鬼已经出笼。"

/obj/item/clothing/shoes/marine/jungle/knife
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/jungle/pistol
	spawn_item_type = /obj/item/weapon/gun/pistol/action

/obj/item/clothing/shoes/marine/brown
	icon_state = "marine_brown"
	desc = "用于战斗场景或作战状况的标准配发作战靴。时刻准备战斗。这双是棕色的。"

/obj/item/clothing/shoes/marine/brown/knife
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/grey
	icon_state = "marine_grey"
	desc = "用于战斗场景或作战状况的标准配发作战靴。时刻准备战斗。这双是灰色的。"

/obj/item/clothing/shoes/marine/grey/knife
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/urban
	icon_state = "marine_grey_alt"
	desc = "别走得太慢，魔鬼已经出笼。"

/obj/item/clothing/shoes/marine/urban/knife
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/monkey
	name = "猴子作战靴"
	desc = "一双结实的作战靴，抛光皮革的反光映照出你的真我。"
	icon_state = "monkey_shoes"
	item_state = "monkey_shoes"
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/upp
	name = "军用作战靴"
	icon_state = "marine_brown"
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH

/obj/item/clothing/shoes/marine/upp/knife
	spawn_item_type = /obj/item/attachable/bayonet/upp

/obj/item/clothing/shoes/marine/upp/black
	icon_state = "marine"
	item_state = "marine"

/obj/item/clothing/shoes/marine/upp/black/knife
	spawn_item_type = /obj/item/attachable/bayonet/upp

/obj/item/clothing/shoes/marine/joe
	name = "生化防护靴"
	desc = "一双做工略显廉价的生化防护靴。明日，携手共进。"
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/dress
	name = "礼服鞋"
	desc = "预先抛光的高档礼服鞋。你可以在上面看到自己的倒影。"
	icon_state = "laceups"
	flags_inventory = NOSLIPPING
	siemens_coefficient = 0.6

/obj/item/clothing/shoes/dress/commander
	name = "指挥官礼服鞋"
	desc = "鞋底经过特殊设计，能更好地践踏脚下的敌人。"
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW

/obj/item/clothing/shoes/stompers
	name = "锐步践踏者"
	desc = "一双运动鞋，旨在激发任何目睹者士气高涨的反应。"
	icon_state = "stompers"
	flags_inventory = NOSLIPPING

/obj/item/clothing/shoes/veteran/pmc
	name = "抛光皮鞋"
	desc = "时尚的巅峰，但这些看起来编织了防护纤维。"
	icon_state = "jackboots"
	item_state = "jackboots"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	flags_inventory = FPRINT|NOSLIPPING
	siemens_coefficient = 0.6
	allowed_items_typecache = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
		/obj/item/weapon/gun/pistol/action,
		/obj/item/weapon/gun/pistol/clfpistol,
		/obj/item/weapon/straight_razor,
	)

/obj/item/clothing/shoes/veteran/pmc/update_icon()
	if(stored_item)
		icon_state = "[initial(icon_state)]-1"
	else
		icon_state = initial(icon_state)

/obj/item/clothing/shoes/veteran/pmc/knife
	spawn_item_type = /obj/item/attachable/bayonet/wy

/obj/item/clothing/shoes/veteran/pmc/commando
	name = "\improper W-Y commando boots"
	desc = "一双重装甲、耐酸靴子。"

	armor_bio = CLOTHING_ARMOR_HIGH
	siemens_coefficient = 0.2
	unacidable = TRUE

/obj/item/clothing/shoes/veteran/pmc/commando/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/shoes/veteran/pmc/commando/knife
	spawn_item_type = /obj/item/attachable/bayonet/wy

/obj/item/clothing/shoes/veteran/pmc/combat_android
	name = "\improper M7X greaves"
	desc = "一双重装甲、耐酸靴子，专为搭配M7X猿人服而设计。"
	icon_state = "droid_boots"
	item_state = "droid_boots"
	armor_bio = CLOTHING_ARMOR_HIGH
	siemens_coefficient = 0.2
	unacidable = TRUE
	spawn_item_type = /obj/item/attachable/bayonet/wy

/obj/item/clothing/shoes/veteran/pmc/combat_android/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/shoes/veteran/pmc/combat_android/dark
	name = "\improper M7X Mark II greaves"
	desc = "一双重装甲、光学迷彩、耐酸靴子，专为搭配M7X Mark II猿人服而设计。"
	icon_state = "invis_droid_boots"
	item_state = "invis_droid_boots"

/obj/item/clothing/shoes/veteran/pmc/van_bandolier
	name = "徒步靴"
	desc = "踏过岩石，踏过冰面，穿越烈日与沙地，泥泞与雪原，进入汹涌的水流和贪婪的沼泽，它们永远不会让你失望。"
	spawn_item_type = /obj/item/attachable/bayonet/van_bandolier

/obj/item/clothing/shoes/veteran/pmc/commando/cbrn
	name = "\improper M3 MOPP boots"
	desc = "M3 MOPP靴旨在保护穿戴者，避免其接触作战区域内可能存在的任何感染媒介或有害物质。这包括在标准M3靴耐久性的基础上进一步增强，降低了被刺穿或割伤的概率，并减轻了辐射影响。"
	icon_state = "cbrn"
	item_state = "cbrn"
	armor_rad = CLOTHING_ARMOR_GIGAHIGHPLUS
	armor_bio = CLOTHING_ARMOR_GIGAHIGHPLUS
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/cbrn_non_armored
	name = "\improper M2 MOPP boots"
	desc = "M2 MOPP靴旨在保护穿戴者，避免其在受污染环境中接触有害物质和潜在感染媒介。这些旧款靴子提供基本的防刺穿和环境威胁抵抗能力，但缺乏后续型号的高级耐久性和辐射屏蔽。使用者应定期检查这些靴子是否有磨损或损坏迹象。"
	icon_state = "cbrn"
	item_state = "cbrn"
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/corporate
	name = "坚固靴子"
	desc = "这双合成革靴子初穿时似乎质量上乘，但很快就会劣化，尤其是在配发使用它们的公司安保人员所执行任务的环境中。尽管如此，总比没有好。"

/obj/item/clothing/shoes/marine/corporate/knife
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/cmb
	name = "坚固靴子"
	desc = "边境执法者通常使用的通用靴子。功能性与时尚感兼备。"

/obj/item/clothing/shoes/marine/cmb/knife
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/ress
	name = "装甲凉鞋"
	icon_state = "sandals"
	item_state = "sandals"
	allowed_items_typecache = null

/obj/item/clothing/shoes/hiking
	name = "徒步鞋"
	desc = "这双坚固的鞋子沾满了泥土和污垢。专为高海拔徒步探险设计，在任何气候或环境中都肯定能派上用场。"
	icon_state = "jackboots"
	item_state = "jackboots"
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	flags_inventory = FPRINT|NOSLIPPING
	siemens_coefficient = 0.6
	allowed_items_typecache = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
		/obj/item/weapon/gun/pistol/action,
		/obj/item/weapon/gun/pistol/clfpistol,
		/obj/item/weapon/straight_razor,
	)
	var/weed_slowdown_mult = 0.5

/obj/item/clothing/shoes/hiking/equipped(mob/user, slot, silent)
	. = ..()
	var/mob/living/carbon/human/human_user = user
	if(src != human_user.shoes)
		return
	RegisterSignal(user, COMSIG_MOB_WEED_SLOWDOWN, PROC_REF(handle_weed_slowdown))

/obj/item/clothing/shoes/hiking/unequipped(mob/user, slot, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_WEED_SLOWDOWN, PROC_REF(handle_weed_slowdown))

/obj/item/clothing/shoes/hiking/proc/handle_weed_slowdown(mob/user, list/slowdata)
	SIGNAL_HANDLER
	slowdata["movement_slowdown"] *= weed_slowdown_mult

//=ROYAL MARINES=\\

/obj/item/clothing/shoes/marine/royal_marine
	name = "\improper L10 pattern combat boots"
	desc = "用于战斗场景或战斗状况的标准配发作战靴。由三大世界帝国皇家海军陆战队突击队单位使用。"
	icon_state = "rmc_boots"
	item_state = "rmc_boots"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	flags_inventory = FPRINT|NOSLIPPING
	siemens_coefficient = 0.6
	allowed_items_typecache = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
		/obj/item/weapon/gun/pistol/action,
		/obj/item/weapon/gun/pistol/clfpistol,
	)
	flags_atom = NO_NAME_OVERRIDE

/obj/item/clothing/shoes/marine/royal_marine/knife
	spawn_item_type = /obj/item/attachable/bayonet/rmc

/obj/item/clothing/shoes/dress/rmc
	name = "\improper RMC dress shoes"
	desc = "抛光的礼服鞋。你可以在上面看到自己的倒影。"
	icon_state = "rmc_laceups"
