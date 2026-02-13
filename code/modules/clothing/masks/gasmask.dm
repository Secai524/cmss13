
/obj/item/clothing/mask/gas
	name = "防毒面具"
	desc = "一种可连接供气系统的面部覆盖面具。能过滤空气中的有害气体。"
	icon_state = "gas_alt"
	item_state = "gas_alt"
	icon = 'icons/obj/items/clothing/masks/gasmasks.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/gasmasks.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/masks_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/masks_righthand.dmi',
	)
	flags_inventory = COVERMOUTH | COVEREYES | ALLOWINTERNALS | BLOCKGASEFFECT | ALLOWREBREATH | ALLOWCPR
	flags_inv_hide = HIDEEARS|HIDEFACE|HIDELOWHAIR
	flags_cold_protection = BODY_FLAG_HEAD
	flags_equip_slot = SLOT_FACE|SLOT_WAIST
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	w_class = SIZE_SMALL
	gas_transfer_coefficient = 0.01
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_NONE
	siemens_coefficient = 0.9
	vision_impair = VISION_IMPAIR_NONE
	var/gas_filter_strength = 1 //For gas mask filters
	var/list/filtered_gases = list("phoron", "sleeping_agent", "carbon_dioxide")

/obj/item/clothing/mask/gas/kutjevo
	name = "库特耶沃呼吸器"
	desc = "一种佩戴在面部的呼吸器，能过滤掉库特耶沃空气中常见的有害颗粒物。"
	icon_state = "kutjevo_respirator"
	item_state = "kutjevo_respirator"

/obj/item/clothing/mask/gas/pmc
	name = "\improper M8 pattern armored balaclava"
	desc = "一种旨在隐藏操作员身份并充当空气过滤器的装甲巴拉克拉法帽。"
	item_state = "helmet"
	icon_state = "pmc_mask"
	icon = 'icons/obj/items/clothing/masks/masks_by_faction/WY.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/masks_by_faction/WY.dmi'
	)
	vision_impair = VISION_IMPAIR_NONE
	armor_melee = CLOTHING_ARMOR_LOW
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_HIGH
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_NONE
	flags_inventory = COVERMOUTH|ALLOWINTERNALS|BLOCKGASEFFECT|ALLOWREBREATH
	flags_inv_hide = HIDEEARS|HIDEFACE|HIDEALLHAIR
	flags_equip_slot = SLOT_FACE

/obj/item/clothing/mask/gas/pmc/Initialize()
	. = ..()
	if(istypestrict(src, /obj/item/clothing/mask/gas/pmc) || istypestrict(src, /obj/item/clothing/mask/gas/pmc/leader))
		AddElement(/datum/element/corp_label/wy)

/obj/item/clothing/mask/gas/pmc/marsoc
	name = "\improper SOF armored balaclava"
	desc = "为最大程度的防护——以及酷炫而设计。提供面部攻击防护，过滤毒素，并隐藏佩戴者身份。"
	icon_state = "balaclava"
	icon = 'icons/obj/items/clothing/masks/balaclava.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/balaclava.dmi'
	)

/obj/item/clothing/mask/gas/pmc/upp
	name = "\improper UPP armored commando balaclava"
	icon_state = "upp_mask"
	icon = 'icons/obj/items/clothing/masks/masks_by_faction/UPP.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/masks_by_faction/UPP.dmi'
	)

/obj/item/clothing/mask/gas/pmc/leader
	name = "\improper M8 pattern armored balaclava"
	desc = "一种旨在隐藏操作员身份并充当空气过滤器的装甲巴拉克拉法帽。这套看起来属于高级军官。"
	icon_state = "officer_mask"

/obj/item/clothing/mask/gas/swat
	name = "\improper SWAT mask"
	desc = "一种可连接供气系统的紧贴合身战术面罩。"
	icon_state = "swat"
	siemens_coefficient = 0.7
	flags_armor_protection = BODY_FLAG_FACE|BODY_FLAG_EYES

/obj/item/clothing/mask/gas/clown_hat
	name = "小丑假发和面具"
	desc = "真正恶作剧者的面部装束。没有假发和面具，小丑就不完整。"
	icon_state = "clown"
	item_state = "clown_hat"
	icon = 'icons/obj/items/clothing/masks/masks.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/masks.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/masks_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/masks_righthand.dmi',
	)
	vision_impair = VISION_IMPAIR_NONE
	black_market_value = 25

/obj/item/clothing/mask/gas/fake_mustache
	name = "假胡子"
	desc = "它几乎完美无缺。"
	icon_state = "souto_man"
	icon = 'icons/obj/items/clothing/masks/masks.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/masks.dmi'
	)
	vision_impair = VISION_IMPAIR_NONE
	unacidable = TRUE
	flags_inventory = CANTSTRIP|COVEREYES|COVERMOUTH|ALLOWINTERNALS|ALLOWREBREATH|BLOCKGASEFFECT|ALLOWCPR|BLOCKSHARPOBJ

//=ROYAL MARINES=\\

/obj/item/clothing/mask/gas/pmc/royal_marine
	name = "\improper L7 gasmask"
	desc = "三大世界帝国皇家海军陆战队突击队成员使用的L7防毒面具。"
	icon_state = "rmc_mask"
	icon = 'icons/obj/items/clothing/masks/masks_by_faction/TWE.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/masks_by_faction/TWE.dmi'
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN

//= UPP =\\

/obj/item/clothing/mask/gas/upp_pfb
	name = "\improper ShMB/4 gasmask"
	desc = "UPP武装集体及众多UPP民间组织使用的标准配发防毒面具。"
	icon_state = "pfb"
	item_state = "pfb"
	icon = 'icons/obj/items/clothing/masks/masks_by_faction/UPP.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/masks_by_faction/UPP.dmi'
	)
	flags_atom = NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	flags_inv_hide = HIDEEARS|HIDEFACE|HIDEALLHAIR

//= CLF =\\

/obj/item/clothing/mask/gas/riot
	name = "防暴面具"
	desc = "殖民地防暴部门使用的面具，配有红色激光护盾镜片以保护眼睛，因为殖民地暴乱者时常使用RXF-M5 EVA。防暴装备也常见于CLF恐怖分子手中，因为在殖民地叛乱中缴获了大量此类装备。"
	icon_state = "carbon_mask"
	item_state = "balaclava"
	icon = 'icons/obj/items/clothing/masks/masks_by_faction/CLF.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/masks_by_faction/CLF.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/masks_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/masks_righthand.dmi',
	)
	vision_impair = VISION_IMPAIR_NONE
	eye_protection = EYE_PROTECTION_FLAVOR
	flags_inv_hide = HIDEEARS|HIDEFACE
