// SS13 DONATOR CUSTOM ITEM STORAGE ZONE OF MAGICAL HAPPINESS APOPHIS - LAST UPDATE - 14JUN2016

//#######################################################\\
//###################### TEMPLATES ######################\\
//#######################################################\\

//HEAD TEMPLATE (for Helmets/Hats/Berets)  ONLY TAKE NAME, DESC, ICON_STATE, AND ITEM_STATE.  Make a copy of those, and put the ckey of the person at the end after fluff
/obj/item/clothing/head/helmet/marine/fluff
	name = "物品名称"
	desc = "物品描述。捐赠者物品" //Add UNIQUE if Unique
	icon_state = null
	item_state = null
	//DON'T GRAB STUFF BETWEEN THIS LINE
	icon = 'icons/obj/items/clothing/hats/donator.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/donator.dmi'
	)
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS
	flags_atom = FPRINT|CONDUCT|NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	flags_marine_helmet = NO_FLAGS

/obj/item/clothing/head/helmet/marine/fluff/Initialize(mapload)
	. = ..()
	item_icons[WEAR_HEAD] = 'icons/mob/humans/onmob/clothing/head/donator.dmi'

/obj/item/clothing/head/helmet/marine/fluff/verb/toggle_squad_markings()
	set src in usr
	if(!ishuman(usr))
		return

	if(usr.is_mob_incapacitated() || !isturf(usr.loc))
		to_chat(usr, SPAN_WARNING("现在不行！"))
		return

	to_chat(usr, SPAN_NOTICE("你[flags_marine_helmet & HELMET_SQUAD_OVERLAY? "hide" : "show"] the squad markings."))
	flags_marine_helmet ^= HELMET_SQUAD_OVERLAY
	usr.update_inv_head()

/obj/item/clothing/head/helmet/marine/fluff/verb/toggle_garb_overlay()
	set src in usr
	if(!ishuman(usr))
		return

	if(usr.is_mob_incapacitated() || !isturf(usr.loc))
		to_chat(usr, SPAN_WARNING("现在不行！"))
		return

	to_chat(usr, SPAN_NOTICE("你[flags_marine_helmet & HELMET_GARB_OVERLAY? "hide" : "show"] the helmet garb."))
	flags_marine_helmet ^= HELMET_GARB_OVERLAY
	update_icon()

	//AND THIS LINE
//END HEAD TEMPLATE

//MASK TEMPLATE (for masks)  ONLY TAKE NAME, DESC, ICON_STATE, ITEM_STATE,  AND ITEM_COLOR.  Make a copy of those, and put the ckey of the person at the end after fluff
/obj/item/clothing/mask/fluff
	name = "物品名称"
	desc = "物品描述。捐赠者物品" //Add UNIQUE if Unique
	icon_state = null
	item_state = null
	icon = 'icons/obj/items/clothing/masks/donator.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/donator.dmi'
	)
	//DON'T GRAB STUFF BETWEEN THIS LINE
	flags_inventory = ALLOWREBREATH
	flags_inv_hide = HIDEEARS|HIDEEYES|HIDEFACE
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT
	//AND THIS LINE

//END MASK TEMPLATE

//SUIT TEMPLATE (for armor/exosuit)  ONLY TAKE NAME, DESC, ICON_STATE, AND ITEM_STATE.  Make a copy of those, and put the ckey of the person at the end after fluff
/obj/item/clothing/suit/storage/marine/fluff
	name = "物品名称"
	desc = "物品描述。捐赠者物品" //Add UNIQUE if Unique
	icon_state = null
	item_state = null
	flags_atom = FPRINT|CONDUCT|NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	//DON'T GRAB STUFF BETWEEN THIS LINE
	icon = 'icons/obj/items/clothing/suits/donator.dmi'
	flags_inventory = BLOCKSHARPOBJ
	flags_marine_armor = NO_FLAGS

/obj/item/clothing/suit/storage/marine/fluff/Initialize(mapload)
	. = ..()
	item_icons[WEAR_JACKET] = 'icons/mob/humans/onmob/clothing/suits/donator.dmi'

//LIGHT SUIT TEMPLATE (for armor/exosuit)  ONLY TAKE NAME, DESC, ICON_STATE, AND ITEM_STATE.  Make a copy of those, and put the ckey of the person at the end after fluff
/obj/item/clothing/suit/storage/marine/light/fluff
	name = "物品名称"
	desc = "物品描述。捐赠者物品" //Add UNIQUE if Unique
	icon_state = null
	item_state = null
	flags_atom = FPRINT|CONDUCT|NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	//DON'T GRAB STUFF BETWEEN THIS LINE
	icon = 'icons/obj/items/clothing/suits/donator.dmi'
	flags_inventory = BLOCKSHARPOBJ
	flags_marine_armor = NO_FLAGS

/obj/item/clothing/suit/storage/marine/light/fluff/Initialize(mapload)
	. = ..()
	item_icons[WEAR_JACKET] = 'icons/mob/humans/onmob/clothing/suits/donator.dmi'

/obj/item/clothing/suit/storage/marine/fluff/verb/toggle_squad_markings()
	set src in usr
	if(!ishuman(usr))
		return

	if(usr.is_mob_incapacitated() || !isturf(usr.loc))
		to_chat(usr, SPAN_WARNING("现在不行！"))
		return

	to_chat(usr, SPAN_NOTICE("你[flags_marine_armor & ARMOR_SQUAD_OVERLAY? "hide" : "show"] the squad markings."))
	flags_marine_armor ^= ARMOR_SQUAD_OVERLAY
	usr.update_inv_wear_suit()

/obj/item/clothing/suit/storage/marine/fluff/verb/toggle_shoulder_lamp()
	set src in usr
	if(!ishuman(usr))
		return

	if(usr.is_mob_incapacitated() || !isturf(usr.loc))
		to_chat(usr, SPAN_WARNING("现在不行！"))
		return

	to_chat(usr, SPAN_NOTICE("你[flags_marine_armor & ARMOR_LAMP_OVERLAY? "hide" : "show"] the shoulder lamp."))
	flags_marine_armor ^= ARMOR_LAMP_OVERLAY
	update_icon(usr)


	//AND THIS LINE
//END SUIT TEMPLATE

//FEET TEMPLATE (for shoes)  ONLY TAKE NAME, DESC, ICON_STATE, ITEM_STATE,  AND ITEM_COLOR.  Make a copy of those, and put the ckey of the person at the end after fluff
/obj/item/clothing/shoes/marine/fluff
	name = "物品名称"
	desc = "物品描述。捐赠者物品" //Add UNIQUE if Unique
	icon_state = null
	item_state = null
//END FEET TEMPLATE

//UNIFORM TEMPLATE (for uniforms/jumpsuits)  ONLY TAKE NAME, DESC, ICON_STATE, ITEM_STATE,  AND ITEM_COLOR.  Make a copy of those, and put the ckey of the person at the end after fluff
/obj/item/clothing/under/marine/fluff
	name = "物品名称"
	desc = "物品描述。捐赠者物品" //Add UNIQUE if Unique
	flags_atom = FPRINT|NO_NAME_OVERRIDE|NO_GAMEMODE_SKIN
	icon_state = null
	item_state = null
	worn_state = null
	icon = 'icons/obj/items/clothing/uniforms/donator.dmi'
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROT

	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/donator.dmi',
	)

//END UNIFORM TEMPLATE

/obj/item/storage/backpack/marine/fluff
	icon_state = null
	xeno_types = null
	icon = 'icons/obj/items/clothing/backpack/donator.dmi'
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/donator.dmi'
	)

/obj/item/storage/backpack/marine/satchel/fluff
	icon_state = null
	xeno_types = null
	icon = 'icons/obj/items/clothing/backpack/donator.dmi'
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/donator.dmi'
	)

/obj/item/clothing/gloves/marine/fluff   //MARINE GLOVES TEMPLATE
	name = "物品名称"
	desc = "物品描述。捐赠者物品" //Add UNIQUE if Unique
	icon_state = null
	item_state = null

/obj/item/clothing/glasses/fluff
	flags_inventory = COVEREYES


//#######################################################\\
//#################### GENERIC SET(S) ###################\\
//#######################################################\\

/obj/item/clothing/head/helmet/marine/fluff/standard_helmet //GENERIC DONOR
	name = "欧米茄小队头盔"
	desc = "欧米茄小队佩戴的头盔。捐赠者物品"
	icon_state = "standard_helmet"
	item_state = "standard_helmet"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/suit/storage/marine/fluff/standard_armor //GENERIC DONOR
	name = "欧米茄小队护甲"
	desc = "欧米茄小队穿戴的护甲。捐赠者物品"
	icon_state = "standard_armor"
	item_state = "standard_armor"

/obj/item/clothing/under/marine/fluff/standard_jumpsuit //GENERIC DONOR
	name = "欧米茄小队制服"
	desc = "欧米茄小队穿着的制服。捐赠者物品"
	icon_state = "standard_jumpsuit"
	worn_state = "standard_jumpsuit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/turtleneck //GENERIC DONOR
	name = "黑色行动高领衫"
	desc = "一件价值900美元的黑色高领衫，由最纯净的阿塞拜疆羊绒编织而成。捐赠者物品"
	icon_state = "syndicate"
	item_state = "bl_suit"
	worn_state = "syndicate"
	flags_jumpsuit = FALSE


/obj/item/clothing/mask/fluff/balaclava //GENERIC DONOR
	name = "巴拉克拉法帽"
	desc = "用于隐藏面部的黑色巴拉克拉法帽。免责声明：可能无法真正隐藏你的脸...捐赠者物品"
	item_state = "balaclava"
	icon_state = "balaclava"
	icon = 'icons/obj/items/clothing/masks/balaclava.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/balaclava.dmi'
	)
	flags_inventory = COVERMOUTH|ALLOWREBREATH
	flags_inv_hide = HIDEEARS|HIDEFACE|HIDEALLHAIR

/obj/item/clothing/glasses/fluff/eyepatch //GENERIC DONOR
	name = "眼罩"
	desc = "硬汉度+10。捐赠者物品。"
	icon = 'icons/obj/items/clothing/glasses/misc.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/misc.dmi',
	)
	icon_state = "eyepatch"
	item_state = "eyepatch"

//  EXO-SUITS/ARMORS COSMETICS  ////////////////////////////////////////////////

/obj/item/clothing/suit/storage/marine/fluff/santa //CKEY=tophatpenguin
	name = "圣诞老人套装"
	desc = "节日气氛！捐赠者物品"
	icon_state = "santa"
	item_state = "santa"
	icon = 'icons/obj/items/clothing/suits/misc_ert.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/misc_ert.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)

/obj/item/clothing/suit/storage/marine/fluff/commandercookies //CKEY=commandercookies
	name = "陆战队护甲（带弹药）"
	desc = "一件带有弹药的陆战队战斗背心。捐赠者物品"
	icon_state = "bulletproofammo"
	item_state = "bulletproofammo"

/obj/item/clothing/suit/storage/marine/fluff/cia
	name = "CIA夹克"
	desc = "一件背后印有CIA的装甲夹克。捐赠者物品"
	icon_state = "cia"
	item_state = "cia"

/obj/item/clothing/suit/storage/marine/fluff/obey //CKEY=obeystylez (UNIQUE)
	name = "黑色行动烧蚀护甲背心"
	desc = "一套外观花哨的护甲。赞助者物品"
	icon_state = "armor_reflec"
	item_state = "armor_reflec"
	icon = 'icons/obj/items/clothing/suits/armor.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/armor.dmi'
	)

/obj/item/clothing/suit/storage/marine/fluff/sas_juggernaut //CKEY=sasoperative (UNIQUE)
	name = "游骑兵夹克"
	desc = "一件老旧的凯夫拉夹克。赞助者物品"
	icon_state = "hunkjacket"
	item_state = "hunkjacket"

/obj/item/clothing/suit/storage/marine/fluff/penguin //CKEY=tophatpenguin
	name = "风衣"
	desc = "一件18世纪风格的风衣。穿着它的人意味着要动真格了。赞助者物品"
	icon_state = "detective"
	item_state = "det_suit"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/suits_righthand.dmi',
	)
	blood_overlay_type = "coat"

/obj/item/clothing/suit/storage/marine/fluff/wright //CKEY=wrightthewrong
	name = "特警护甲"
	desc = "一套外观花哨的护甲。赞助者物品"
	icon_state = "deathsquad"
	item_state = "swat_suit"

/obj/item/clothing/suit/storage/marine/fluff/tyran //CKEY=tyran68
	name = "特警护甲"
	desc = "一套外观花哨的护甲。赞助者物品"
	icon_state = "deathsquad"
	item_state = "swat_suit"

/obj/item/clothing/suit/storage/marine/fluff/tristan //CKEY=tristan63
	name = "M3X型护甲"
	desc = "一套实验性的M3型护甲，经过现代化改造，加入了贴合身体的陶瓷板以提供更好的弹道防护。不幸的是，这些陶瓷板似乎已经损坏到无法修复，只剩下基础的M3防护。赞助者物品"
	icon_state = "tristan_armor"
	item_state = "tristan_armor"

/obj/item/clothing/suit/storage/marine/light/fluff/sas_legion //CKEY=sasoperative (UNIQUE)
	name = "M3游骑兵护甲"
	desc = "一套M3型游骑兵护甲，这玩意儿恐怕没多少存货了。赞助者物品。"
	flags_atom = FPRINT|CONDUCT|NO_NAME_OVERRIDE|MAP_COLOR_INDEX
	icon_state = "rangerarmor"
	item_state = "rangerarmor"
	item_state_slots = list(
		WEAR_L_HAND = "marine_armor",
		WEAR_R_HAND = "marine_armor"
	)

/obj/item/clothing/suit/storage/marine/light/fluff/sas_legion/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
		if("snow")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
		if("desert")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
		if("classic")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
		if("urban")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'

/obj/item/clothing/suit/storage/marine/fluff/feodrich //CKEY=feodrich (UNIQUE)
	name = "毁灭战士护甲"
	desc = "一位著名地球战士的制服……赞助者物品。"
	item_state = "doom_armor"
	icon_state = "doom_armor"

/obj/item/clothing/suit/storage/marine/fluff/totalanarchy //CKEY=totalanarchy
	name = "里奥的护甲"
	desc = "用过的雇佣兵护甲。赞助者物品。"
	item_state = "merc_armor"
	icon_state = "merc_armor"

/obj/item/clothing/suit/storage/marine/fluff/sadokist2 //CKEY=sadokist
	name = "重型安保硬质护甲"
	desc = "重装甲安保硬质护甲。赞助者物品"
	icon_state = "rig-secTG"
	item_state = "rig-secTG"

/obj/item/clothing/suit/storage/marine/fluff/vintage //CKEY=vintagepalmer
	name = "带波纹的复古护甲"
	desc = "一件复古的赞助者物品"
	icon_state = "bulletproof"
	item_state = "bulletproof"
	icon = 'icons/obj/items/clothing/suits/armor.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/armor.dmi',
	)

/obj/item/clothing/suit/storage/marine/fluff/john56 //CKEY=johnkilla56
	name = "红色风衣"
	desc = "一件特殊的风衣，因能让各地的灰潮感到恐惧而闻名。赞助者物品"
	icon_state = "hos"
	item_state = "hos"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)
	blood_overlay_type = "coat"

/obj/item/clothing/suit/storage/marine/light/fluff/biolock //CKEY=biolock
	name = "M3-L定制型"
	desc = "标准M3型护甲的轻量化、精简版本。这套护甲看起来经过了大量改装和定制涂装。赞助者物品。"
	item_state = "bio_armor"
	icon_state = "bio_armor"

/obj/item/clothing/suit/storage/marine/fluff/sas_elite //CKEY=sasoperative (UNIQUE)
	name = "M3夜袭护甲"
	desc = "一套为夜间行动定制的全黑护甲。独特赞助者物品"
	icon_state = "hunkarmor"
	item_state = "hunkarmor"

/obj/item/clothing/suit/storage/marine/fluff/limo //CKEY=limodish (UNIQUE)
	name = "血红色硬质护甲"
	desc = "看起来像一套硬质护甲。独特的捐助者物品"
	icon_state = "syndicate"
	item_state = "syndicate"
	icon = 'icons/obj/items/clothing/suits/hazard.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/hazard.dmi',
	)

/obj/item/clothing/suit/storage/marine/fluff/Zynax //CKEY=zynax
	name = "戈尔卡战术背心"
	desc = "俄罗斯迷彩背心。独特的捐助者物品"
	icon_state = "gorkavest_u"
	item_state = "gorkavest_u"

/obj/item/clothing/suit/storage/marine/fluff/bwoincognito //CKEY=bwoincognito
	name = "废土夹克"
	desc = "一件古老废土客的夹克……独特的捐助者物品"
	icon_state = "riotjacket_u"
	item_state = "riotjacket_u"

/obj/item/clothing/suit/storage/marine/fluff/adjective
	name = "宪兵长大衣"
	desc = "一件彰显权威的大衣。捐助者物品"
	icon_state = "jensencoat"
	item_state = "jensencoat"

/obj/item/clothing/suit/storage/marine/fluff/fickmacher //CKEY=fickmacher (UNIQUE)
	name = "塞莱娜的大衣"
	desc = "一件彰显权威的大衣。捐助者物品"
	icon_state = "jensencoat"
	item_state = "jensencoat"

/obj/item/clothing/suit/storage/marine/fluff/juninho
	name = "烧蚀护甲"
	desc = "一套相当先进的护甲。捐助者物品"
	icon_state = "armor_reflec"
	item_state = "armor_reflec"
	icon = 'icons/obj/items/clothing/suits/armor.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/armor.dmi',
	)

/obj/item/clothing/suit/storage/marine/fluff/mitii
	name = "米娅的大衣"
	desc = "一件彰显权威的大衣。捐助者物品"
	icon_state = "hos"
	item_state = "hos"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)

/obj/item/clothing/suit/storage/marine/fluff/gromi
	name = "鹰眼的夹克"
	desc = "一件由著名战场医生穿过的夹克。独特的捐助者物品"
	icon_state = "hawkeye_jacket_u"
	item_state = "hawkeye_jacket_u"

/obj/item/clothing/suit/storage/marine/fluff/chimera //CKEY=theultimatechimera
	name = "布雷特的大衣"
	desc = "一件彰显权威的大衣。捐助者物品"
	icon_state = "hos"
	item_state = "hos"
	icon = 'icons/obj/items/clothing/suits/coats_robes.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/coats_robes.dmi',
	)

/obj/item/clothing/suit/storage/marine/fluff/devilzhand
	name = "坦克的大衣"
	desc = "一件彰显权威的大衣。捐助者物品"
	icon_state = "jensencoat"
	item_state = "jensencoat"

/obj/item/clothing/suit/storage/marine/fluff/feweh //CKEY=feweh
	name = "粉色的烧蚀护甲背心"
	desc = "你见过的最花哨的防弹背心。捐助者物品"
	icon_state = "armor_reflec"
	item_state = "armor_reflec"
	icon = 'icons/obj/items/clothing/suits/armor.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/armor.dmi',
	)

/obj/item/clothing/suit/storage/marine/fluff/crazyh206
	name = "圣殿骑士护甲"
	desc = "某种你不认识的奇怪神圣护甲……捐助者物品" //Add UNIQUE if Unique
	icon_state = "templar"
	item_state = "templar"

/obj/item/clothing/suit/storage/marine/fluff/tranquill
	name = "杰西·平克曼的汉·索罗套装"
	desc = "一位著名走私犯穿过的旧衣服。独特的捐助者物品"
	item_state = "solo_jumpsuit_u"
	icon_state = "solo_jumpsuit_u"

/obj/item/clothing/suit/storage/marine/fluff/oneonethreeeight //CKEY=oneonethreeeight
	name = "迷彩护甲"
	desc = "林地迷彩护甲。捐助者物品" //Add UNIQUE if Unique
	icon_state = "camo_armor"
	item_state = "camo_armor"

/obj/item/clothing/suit/storage/marine/fluff/dino //CKEY=dinobubba7
	name = "潜行服"
	desc = "一件旧制服，曾由一位著名间谍使用。闻起来有股烟味…… 捐赠者物品"
	icon_state = "snakesuit"
	item_state = "snakesuit"

/obj/item/clothing/suit/storage/marine/fluff/fickmacher2 //CKEY=fickmacher (UNIQUE)
	name = "哈特下士的护甲"
	desc = "看起来左臂是机械臂，等等，什么？ 捐赠者物品"
	icon_state = "hartarmor"
	item_state = "hartarmor"

/obj/item/clothing/suit/storage/marine/fluff/paradox //CKEY=paradox1i7
	name = "圣殿骑士护甲"
	desc = "古老英雄们的神圣护甲，早已逝去…… 捐赠者物品"
	icon_state = "templar2"
	item_state = "templar2"

/obj/item/clothing/suit/storage/marine/fluff/chris1464 //CKEY=chris1464
	name = "雇佣兵护甲"
	desc = "来自一个老牌雇佣兵公司的护甲，你希望它还能撑得住…… 捐赠者物品"
	icon_state = "merc_vest"
	item_state = "merc_vest"

/obj/item/clothing/suit/storage/marine/fluff/radical
	name = "赏金猎人护甲"
	desc = "来自一位远古赏金猎人的护甲。 捐赠者物品" //Add UNIQUE if Unique
	icon_state = "boba_armor"
	item_state = "boba_armor"

/obj/item/clothing/suit/storage/marine/fluff/stobarico //CKEY=stobarico (UNIQUE)
	name = "英国海军上将制服"
	desc = "一位海军上将的古老制服。 捐赠者物品"
	icon_state = "lordadmiral"
	item_state = "lordadmiral"

/obj/item/clothing/suit/storage/marine/fluff/starscream //CKEY=starscream123 (NOT UNIQUE)
	name = "卡达尔·侯赛因的护甲"
	desc = "略有磨损和撕裂。 捐赠者物品"
	icon_state = "merc_armor"
	item_state = "merc_armor"

/obj/item/clothing/suit/storage/marine/fluff/steelpoint //CKEY=steelpoint (UNIQUE)
	name = "M4-X护甲"
	desc = "一套为对抗异形的陆战队员设计的下一代单兵护甲系统，表面涂有独特的耐酸聚合物涂层，并增强了防弹性能。这个原型版本缺少这两项功能。捐赠者物品"
	flags_atom = FPRINT|CONDUCT|NO_NAME_OVERRIDE|MAP_COLOR_INDEX
	icon_state = "steelpoint_armor"
	item_state = "steelpoint_armor"
	item_state_slots = list(
		WEAR_L_HAND = "marine_armor",
		WEAR_R_HAND = "marine_armor"
	)

/obj/item/clothing/suit/storage/marine/fluff/steelpoint/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
		if("snow")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
		if("desert")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
		if("classic")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
		if("urban")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'

/obj/item/clothing/suit/storage/marine/fluff/valentine //CKEY=markvalentine
	name = "肖基的护甲"
	desc = "好得惊人的护甲。 捐赠者物品"
	icon_state = "ertarmor_sec"
	item_state = "ertarmor_sec"


/obj/item/clothing/suit/storage/marine/fluff/nickiskool //CKEY=nickiskool
	name = "星爵夹克"
	desc = "谁？ 捐赠者物品"
	icon_state = "star_jacket"
	item_state = "star_jacker"

/obj/item/clothing/suit/storage/marine/fluff/sadokist //CKEY=sadokist
	name = "T15特种作战护甲"
	desc = "一套为特种部队操作员精心编织的护甲，旨在灵活且能防护轻武器火力。似乎是为特定用户量身定制的，因为衣领上印有“塔尼娅”的名字。 捐赠者物品"
	icon_state = "sadokist_armor"
	item_state = "sadokist_armor"

/obj/item/clothing/suit/storage/marine/fluff/fairedan //CKEY=fairedan (UNIQUE)
	name = "货船船员飞行夹克"
	desc = "洛克马丁CM-88B野牛星际货船船员的标准配发夹克。内标签上有数字1809246…… 捐赠者物品"
	icon_state = "Fairedan_vest"
	item_state = "Fairedan_vest"

/obj/item/clothing/suit/storage/marine/fluff/jackmcintyre //CKEY=jackmcintyre (UNIQUE)
	name = "外骨骼夹克"
	desc = "某种奇怪的外骨骼夹克。上面印有USCM字样，覆盖着一个褪色的词，似乎是ATLAS…… 独特捐赠者物品"
	icon_state = "Adam_jacket_u"
	item_state = "Adam_jacket_u"

/obj/item/clothing/suit/storage/marine/fluff/commissar //used by both ckeys 'hycinth' and 'technokat' (UNIQUE)
	name = "欧米伽政委护甲"
	desc = "由令人畏惧且备受尊敬的欧米茄小队政委所穿戴的护甲。独特捐赠者物品"
	icon_state = "commisar_armor_u"
	item_state = "commisar_armor_u"

/obj/item/clothing/suit/storage/marine/fluff/medicae_armor //CKEY=graciegrace0 (UNIQUE)
	name = "欧米茄医疗兵护甲"
	desc = "欧米茄小队医疗部队所穿戴的护甲。独特捐赠者物品"
	icon_state = "medicae_armor_u"
	item_state = "medicae_armor_u"

/obj/item/clothing/suit/storage/marine/fluff/dudewithatude
	name = "彩虹大衣"
	desc = "由友谊的魔法驱动。（可切换打开或关闭）独特捐赠者物品"
	icon_state = "AlexLermire_u"
	item_state = "AlexLermire_u"
	var/open = FALSE

/obj/item/clothing/suit/storage/marine/fluff/dudewithatude/verb/verb_toggleopen()
	set src in usr
	set category = "Object"
	set name = "Toggle Open"
	if(!open)
		icon_state = "AlexLermire_on_u"
		item_state = "AlexLermire_on_u"
		open = TRUE
	else
		open = FALSE
		icon_state = "AlexLermire_u"
		item_state = "AlexLermire_u"
	update_icon()
	usr.update_inv_wear_suit()

/obj/item/clothing/suit/storage/marine/fluff/titus
	name = "ODST护甲"
	desc = "外观奇特的护甲，带有褪色的ODST字样... 独特捐赠者物品"
	icon_state = "leviathan13_u"
	item_state = "leviathan13_u"

/obj/item/clothing/suit/storage/marine/fluff/trblackdragon //CKEY=trblackdragon
	name = "外观奇特的护甲"
	desc = "看起来像是来自另一个时空... 独特捐赠者物品"
	icon_state = "TR-Donor_u"
	item_state = "TR-Donor_u"

/obj/item/clothing/suit/storage/marine/fluff/zegara //CKEY=zegara
	name = "黑粉护甲"
	desc = "闪亮的黑色护甲，带有粉色点缀... 独特捐赠者物品"
	icon_state = "zegara_armor_u"
	item_state = "zegara_armor_u"

/obj/item/clothing/suit/storage/marine/fluff/eonoc
	name = "棕衣"
	desc = "你无法夺走我的天空... 捐赠者物品"
	icon_state = "Eonoc_coat"
	item_state = "Eonoc_coat"
	var/open = FALSE

/obj/item/clothing/suit/storage/marine/fluff/eonoc/verb/verb_toggleopen()
	set src in usr
	set category = "Object"
	set name = "Toggle Open"
	if(!open)
		icon_state = "Eonoc_coat_o"
		item_state = "Eonoc_coat_o"
		open = TRUE
	else
		open = FALSE
		icon_state = "Eonoc_coat"
		item_state = "Eonoc_coat"
	update_icon()
	usr.update_inv_wear_suit()

/obj/item/clothing/suit/storage/marine/fluff/kaila
	name = "定制工程护甲"
	desc = "一套工程护甲上的定制涂装。捐赠者物品"
	icon_state = "kailas_armor"
	item_state = "kailas_armor"

/obj/item/clothing/suit/storage/marine/fluff/fridrich
	name = "纯黑实验服"
	desc = "非常时尚。捐赠者物品"
	icon_state = "Reznoriam"
	item_state = "Reznoriam"

/obj/item/clothing/suit/storage/marine/fluff/lostmixup
	name = "和平行者战服"
	desc = "来自一位远古英雄的制服。背后标签上写着斯内克的名字... 独特捐赠者物品。"
	icon_state = "lostmixup_u"
	item_state = "lostmixup_u"

/obj/item/clothing/suit/storage/marine/fluff/laser243
	name = "褪色游骑兵护甲"
	desc = "看起来是由多种护甲和布料拼凑而成，可能来自某个后末日世界... 捐赠者物品。"
	icon_state = "laser243"
	item_state = "laser243"

/obj/item/clothing/suit/storage/marine/fluff/killaninja12
	name = "太空牛仔护甲"
	desc = "有人称你为太空牛仔，有人称你为爱情匪徒... 独特捐赠者物品。"
	icon_state = "killaninja12_u"
	item_state = "killaninja12_u"

/obj/item/clothing/suit/storage/marine/fluff/forwardslashn
	name = "原型防弹护甲"
	desc = "一款花哨防弹护甲的原型版本。独特捐赠者物品。"
	icon_state = "forwardslashn_u"
	item_state = "forwardslashn_u"




// HELMETS/HATS/BERETS COSMETICS  ////////////////////////////////////////////////
/obj/item/clothing/head/helmet/marine/fluff/santahat //CKEY=tophatpenguin
	name = "圣诞帽"
	desc = "呵呵呵。圣诞快乐！"
	icon_state = "santa_hat_red"
	item_state = "santa_hat_red"
	icon = 'icons/obj/items/clothing/hats/hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_righthand.dmi',
	)
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/sas_juggernaut //CKEY=sasoperative (UNIQUE)
	name = "游骑兵贝雷帽"
	icon_state = "hunkberet"
	item_state = "hunkberet"
	desc = "一顶布满灰尘、内衬凯夫拉的老旧贝雷帽。捐赠者物品"

/obj/item/clothing/head/helmet/marine/fluff/tristan //CKEY=tristan63
	name = "华丽头盔"
	desc = "那不是红漆。那是真血。捐赠者物品"
	icon_state = "syndicate"
	icon = 'icons/obj/items/clothing/hats/hazard.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hazard.dmi',
	)
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/penguin //CKEY=tophatpenguin
	name = "顶级企鹅帽"
	icon_state = "petehat"
	desc = "一顶给企鹅的帽子，也许还是给顶级企鹅的……捐赠者物品"
	icon = 'icons/obj/items/clothing/hats/hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats.dmi',
	)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/feodrich //CKEY=feodrich (UNIQUE)
	name = "毁灭战士头盔"
	icon_state = "doom_helmet"
	desc = "一位著名地球战士的头盔……捐赠者物品。"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/sadokist //CKEY=sadokist
	name = "塔尼娅的贝雷帽"
	desc = "一顶亮红色的贝雷帽，为塔尼娅·伊甸尼亚所有。"
	icon_state = "beret_badge"
	icon = 'icons/obj/items/clothing/hats/berets.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/berets.dmi'
	)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/robin //CKEY=robin63
	name = "罗宾·洛的贝雷帽"
	desc = "一顶亮红色的贝雷帽，为罗宾·洛所有。"
	icon_state = "beret_badge"
	icon = 'icons/obj/items/clothing/hats/berets.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/berets.dmi'
	)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/vintage //CKEY=vintagepalmer
	name = "复古皮条客帽"
	desc = "一顶皮条客帽，专为经典皮条客准备。捐赠者物品"
	icon_state = "petehat"
	icon = 'icons/obj/items/clothing/hats/hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats.dmi',
	)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/john56 //CKEY=johnkilla56
	name = "牧师兜帽"
	desc = "我虽行过死荫的幽谷……捐赠者物品。"
	icon_state = "chaplain_hood"
	icon = 'icons/obj/items/clothing/hats/hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats.dmi',
	)

/obj/item/clothing/head/helmet/marine/fluff/biolock //CKEY=biolock
	name = "M10定制型"
	desc = "一顶定制的M10型头盔。头盔内部有更小、更光滑的衬垫。右侧有一个内置摄像头。捐赠者物品"
	icon_state = "bio_helmet"
	item_state = "bio_helmet"

/obj/item/clothing/head/helmet/marine/fluff/haveatya //CKEY=haveatya
	name = "伞降救援队贝雷帽"
	desc = "一顶伞降救援队贝雷帽，仅授予最优秀的成员。捐赠者物品"
	icon_state = "beret_badge"
	icon = 'icons/obj/items/clothing/hats/berets.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/berets.dmi'
	)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/sas_elite //CKEY=sasoperative (UNIQUE)
	name = "M3夜袭头盔"
	icon_state = "hunkhelmet"
	desc = "一款全黑定制的M3头盔，专为夜间行动设计。独特捐赠者物品"

/obj/item/clothing/head/helmet/marine/fluff/sas_legion //CKEY=sasoperative (UNIQUE)
	name = "M3游骑兵头盔"
	desc = "一顶M3游骑兵头盔，这玩意儿可不多见。赞助者物品"
	icon_state = "rangerhelmet"
	item_state = "rangerhelmet"
	flags_atom = FPRINT|CONDUCT|NO_NAME_OVERRIDE|MAP_COLOR_INDEX
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)

/obj/item/clothing/head/helmet/marine/fluff/sas_legion/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
		if("snow")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
		if("desert")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
		if("classic")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
		if("urban")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'

/obj/item/clothing/head/helmet/marine/fluff/officialjake
	name = "蒂莫西的贝雷帽"
	desc = "蒂莫西·塞德纳所有的一顶精致的红色贝雷帽。赞助者物品"
	icon_state = "beret_badge"
	icon = 'icons/obj/items/clothing/hats/berets.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/berets.dmi'
	)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/ningajai
	name = "安东尼的头盔"
	desc = "安东尼·卡迈恩所有的COG头盔。"
	icon_state = "anthonycarmine"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/goldshieldberet
	name = "beret"
	desc = "一顶带有金色盾徽的军用黑色贝雷帽。"
	icon_state = "gberet"
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/goldtrimberet
	name = "beret"
	desc = "一顶镶有金边的栗色贝雷帽。"
	icon_state = "gtberet"
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/commandercookies //CKEY=commandercookies
	name = "埃利奥特的贝雷帽"
	desc = "一顶深栗色贝雷帽。"
	icon_state = "eberet"
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/juniho
	name = "希特的帽子"
	desc = "一顶帽子，与指责某人安保工作不力密切相关……赞助者物品" //Add UNIQUE if Unique
	icon_state = "detective"
	item_state = "detective"
	icon = 'icons/obj/items/clothing/hats/formal_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/formal_hats.dmi',
	)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/limo //CKEY=limodish (UNIQUE)
	name = "血红色硬质防护服"
	desc = "这看起来像一顶戏服用的硬质防护服头盔。赞助者物品"
	icon_state = "syndicate"
	item_state = "syndicate"
	icon = 'icons/obj/items/clothing/hats/hazard.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hazard.dmi',
	)
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/devilzhand
	name = "MICH头盔"
	desc = "一顶精致的战斗头盔。赞助者物品"
	icon_state = "mich"
	item_state = "mich"

/obj/item/clothing/head/helmet/marine/fluff/bark
	name = "法官头盔"
	desc = "我即是法律。独特赞助者物品"
	icon_state = "judgehelm_u"
	item_state = "judgehelm_u"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEEYES

/obj/item/clothing/head/helmet/marine/fluff/bwoincognito //CKEY=bwoincognito
	name = "辐射头盔"
	desc = "来自古老废土客的头盔……独特赞助者物品"
	icon_state = "riothelm_u"
	item_state = "riothelm_u"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/mitii
	name = "米娅的贝雷帽"
	desc = "一顶带有闪亮安保徽章的红色贝雷帽。赞助者物品"
	icon_state = "beret_badge"
	item_state = "beret_badge"
	icon = 'icons/obj/items/clothing/hats/berets.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/berets.dmi'
	)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/fickmacher //CKEY=fickmacher (UNIQUE)
	name = "塞莱娜的帽子"
	desc = "一顶精致的贝雷帽。赞助者物品"
	icon_state = "hosberet"
	item_state = "hosberet"
	icon = 'icons/obj/items/clothing/hats/berets.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/berets.dmi'
	)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/eastgerman
	name = "梅尔文的帽子"
	desc = "一顶精致的贝雷帽。赞助者物品"
	icon_state = "hosberet"
	item_state = "hosberet"
	icon = 'icons/obj/items/clothing/hats/berets.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/berets.dmi'
	)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/chimera //CKEY=theultimatechimera
	name = "布雷特的帽子"
	desc = "一顶精致的贝雷帽。赞助者物品"
	icon_state = "hosberet"
	item_state = "hosberet"
	icon = 'icons/obj/items/clothing/hats/berets.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/berets.dmi'
	)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/lostmixup
	name = "无限弹药头巾"
	desc = "免责声明：可能不提供无限弹药。 独家赞助者物品"
	icon_state = "headband_u"
	item_state = "headband_u"
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/totalanarchy //CKEY=totalanarchy
	name = "利奥的头盔"
	desc = "一项旧的雇佣兵头盔。 赞助者物品"
	icon_state = "merc_helm"
	item_state = "merc_helm"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDELOWHAIR

/obj/item/clothing/head/helmet/marine/fluff/oneonethreeeight //CKEY=oneonethreeeight
	name = "迷彩头盔"
	desc = "林地迷彩头盔。 赞助者物品"
	icon_state = "camo_helm"
	item_state = "camo_helm"

/obj/item/clothing/head/helmet/marine/fluff/dino //CKEY=dinobubba7
	name = "斯内克头巾"
	desc = "头目所有物。 赞助者物品"
	icon_state = "snakeheadband"
	item_state = "snakeheadband"
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/paradox //CKEY=paradox1i7
	name = "圣殿骑士头盔"
	desc = "一个曾经强大骑士团的头盔。 赞助者物品"
	icon_state = "templar_helm"
	item_state = "templar_helm"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/deejay
	name = "鲁克斯的贝雷帽"
	desc = "胡安·'鲁克'·加西亚拥有的精美红色贝雷帽。 赞助者物品"
	icon_state = "beret_badge"
	item_state = "beret_badge"
	icon = 'icons/obj/items/clothing/hats/berets.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/berets.dmi'
	)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/chris1464 //CKEY=chris1464
	name = "雇佣兵贝雷帽"
	desc = "来自某雇佣兵公司的贝雷帽。 赞助者物品"
	icon_state = "cargosoft"
	item_state = "cargosoft"
	icon = 'icons/obj/items/clothing/hats/soft_caps.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/soft_caps.dmi'
	)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/radical
	name = "赏金猎人头盔"
	desc = "来自一位古代赏金猎人的头盔。 赞助者物品"
	icon_state = "boba_helmet"
	item_state = "boba_helmet"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/whiteblood17 //CKEY=whiteblood17
	name = "黑色行动头盔"
	desc = "你无权查看它。 赞助者物品"
	icon_state = "syndicate-helm-black"
	item_state = "syndicate-helm-black"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/leondark //CKEY=leondark16
	name = "亨特的USCM军帽"
	desc = "一项磨损严重的军帽，内侧写有'巴里恩托斯'的名字。 赞助者物品"
	icon_state = "USCM_cap"
	item_state = "USCM_cap"
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/starscream //CKEY=starscream123 (UNIQUE)
	name = "卡达尔·侯赛因的头盔"
	desc = "略有磨损和撕裂。 捐赠者物品"
	icon_state = "asset_protect"
	item_state = "asset_protect"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/trblackdragon //CKEY=trblackdragon
	name = "斯巴达头盔"
	desc = "斯巴达人，你们的职业是什么？ 赞助者物品"
	icon_state = "blackdragon_helmet_u" //UNIQUE
	item_state = "blackdragon_helmet_u"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/steelpoint //CKEY=steelpoint (UNIQUE)
	name = "M4-X头盔"
	desc = "一款旨在与M4-X护甲搭配的次世代作战头盔。这款全覆盖式头盔提供全面的轻型防弹保护以及增强的耐酸性。此原型版本不具备这些功能。赞助者物品"
	icon_state = "steelpoint_helmet"
	item_state = "steelpoint_helmet"
	flags_atom = FPRINT|CONDUCT|NO_NAME_OVERRIDE|MAP_COLOR_INDEX
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR
	item_state_slots = list(
		WEAR_L_HAND = "helmet",
		WEAR_R_HAND = "helmet"
	)

/obj/item/clothing/head/helmet/marine/fluff/steelpoint/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
		if("snow")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
		if("desert")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
		if("classic")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
		if("urban")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'

/obj/item/clothing/head/helmet/marine/fluff/valentine //CKEY=markvalentine
	name = "肖基的头盔"
	desc = "好得惊人的头盔。 捐助者物品"
	icon_state = "syndicate-helm-black"
	item_state = "syndicate-helm-black"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/jdobbin49 //CKEY=jdobbin49
	name = "菲利普的贝雷帽"
	desc = "菲利普·格林沃尔拥有的贝雷帽。 捐助者物品"
	icon_state = "berettan"
	item_state = "berettan"
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/nickiskool //CKEY=nickiskool
	name = "星爵面具"
	desc = "以防有人认出你... 捐助者物品"
	icon_state = "star_mask"
	item_state = "star_mask"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/bibblesless
	name = "黄色应急反应队头盔"
	desc = "标准应急头盔，黄色款... 捐助者物品"
	icon_state = "rig0-ert_engineer"
	item_state = "rig0-ert_engineer"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/fernkiller
	name = "白色应急反应队头盔"
	desc = "标准应急头盔，白色款... 捐助者物品"
	icon_state = "rig0-ert_medical"
	item_state = "rig0-ert_medical"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/jackmcintyre //CKEY=jackmcintyre (UNIQUE)
	name = "USCM棒球帽"
	desc = "USCM寒区棒球帽... 捐助者物品"
	icon_state = "Adam_hat"
	item_state = "Adam_hat"
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/commissar //used by both ckeys 'hycinth' and 'technokat' (UNIQUE)
	name = "欧米伽政委头盔"
	desc = "欧米伽小队政委佩戴的头盔。 独特捐助者物品"
	icon_state = "commissar_helmet_u"
	item_state = "commissar_helmet_u"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/medicae_helmet //CKEY=graciegrace0 (UNIQUE)
	name = "欧米伽医疗兵头盔"
	desc = "欧米伽小队医疗部队佩戴的头盔。 独特捐助者物品"
	icon_state = "medicae_helmet_u"
	item_state = "medicae_helmett_u"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/dingledangle
	name = "拉斯的帽子"
	desc = "有点老旧和破旧。颜色随时间略有褪色。 捐助者物品"
	icon_state = "bluesoft"
	item_state = "bluesoft"
	icon = 'icons/obj/items/clothing/hats/soft_caps.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/soft_caps.dmi'
	)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/helmet/marine/fluff/titus
	name = "ODST头盔"
	desc = "一顶旧头盔，带有褪色的ODST字样。 独特捐助者物品"
	icon_state = "leviathan13_helm_u"
	item_state = "leviathan13_helm_u"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/kaila
	name = "定制工程雪地头盔"
	desc = "在工程头盔上进行的定制涂装。 捐助者物品"
	icon_state = "kailas_helmet"
	item_state = "kailas_helmet"

/obj/item/clothing/head/helmet/marine/fluff/edgelord
	name = "操作员帽"
	desc = "一顶坚固的棕色USCM帽子，附带无线电耳机。这顶帽子背面印有‘曼恩’的名字。 捐助者物品"
	icon_state = "edgelord_cap"
	item_state = "edgelord_cap"

/obj/item/clothing/head/helmet/marine/fluff/laser243
	name = "褪色的游骑兵头盔"
	desc = "背面刻有年份2033。捐赠者物品"
	icon_state = "laser243"
	item_state = "laser243"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDEMASK|HIDEEYES|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/fluff/killaninja12
	name = "太空牛仔帽"
	desc = "帽子内侧写着名字‘莫里斯’……独特捐赠者物品"
	icon_state = "killaninja12_u"
	item_state = "killaninja12_u"

// UNIFORM/JUMPSUIT COSMETICS  ////////////////////////////////////////////////

/obj/item/clothing/under/marine/fluff/tristan //CKEY=tristan63
	desc = "这是一件蓝色连体服，带有金色标记，表示的军衔。\"舰长\"."
	name = "上尉连体服"
	icon_state = "camojump"
	worn_state = "camojump"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/feodrich //CKEY=feodrich (UNIQUE)
	name = "毁灭者制服"
	desc = "一位著名地球战士的制服……赞助者物品。"
	icon_state = "doom_suit"
	worn_state = "doom_suit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/totalanarchy //CKEY=totalanarchy
	name = "雇佣兵连体服"
	desc = "来自一支雇佣兵队伍的制服……捐赠者物品。"
	icon_state = "merc_jumpsuit"
	worn_state = "merc_jumpsuit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/john56 //CKEY=johnkilla56
	name = "粉色荣耀连体服"
	desc = "一件用于展示你粉色荣耀的连体服……捐赠者物品。"
	icon_state = "pink"
	icon = 'icons/obj/items/clothing/uniforms/jumpsuits.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/jumpsuits.dmi',
	)
	worn_state = "pink"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/sas_elite //CKEY=sasoperative (UNIQUE)
	name = "游骑兵作战服"
	desc = "黑色迷彩作战服，通常用于夜间行动。独特捐赠者物品。"
	icon_state = "hunkuni"
	worn_state = "hunkuni"
	icon = 'icons/obj/items/clothing/uniforms/donator.dmi'
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	flags_atom = FPRINT|CONDUCT|NO_NAME_OVERRIDE|MAP_COLOR_INDEX
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/donator.dmi',
	)
	item_state_slots = list(
		WEAR_L_HAND = "marine_jumpsuit",
		WEAR_R_HAND = "marine_jumpsuit"
	)

/obj/item/clothing/under/marine/fluff/sas_elite/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
		if("snow")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
		if("desert")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
		if("classic")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
		if("urban")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'

/obj/item/clothing/under/marine/fluff/leeeverett //CKEY=theflagbearer (UNIQUE)
	name = "粗犷套装"
	desc = "它沾满血迹，气味难闻。谁死在了这里面？"
	icon_state = "rugged"
	worn_state = "rugged"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/vintage //CKEY=vintagepalmer
	name = "复古粉色连体服"
	desc = "一件要么曾经是红色，要么曾经是白色但和一缸颜色一起洗过的连体服……捐赠者物品。"
	icon_state = "pink"
	worn_state = "pink"
	icon = 'icons/obj/items/clothing/uniforms/jumpsuits.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/jumpsuits.dmi',
	)
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/wooki //CKEY=tophatpenguin (UNIQUE)
	name = "华丽制服"
	desc = "伍基的华丽蓝色西装。独特捐赠者物品"
	icon_state = "wooki_u"
	worn_state = "wooki_u"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/Zynax //CKEY=zynax
	name = "戈尔卡套装"
	desc = "俄罗斯迷彩。捐赠者物品"
	icon_state = "gorkasuit"
	worn_state = "gorkasuit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/bwoincognito //CKEY=bwoincognito
	name = "辐射服"
	desc = "来自一个古老废土客群体的服装……独特捐赠者物品"
	icon_state = "riot_u"
	worn_state = "riot_u"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/juninho
	name = "企业安保制服"
	desc = "一件安保连体服，配得上企业安保主管。捐赠者物品" //Add UNIQUE if Unique
	icon_state = "hos_corporate"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/security.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/security.dmi',
	)
	worn_state = "hos_corporate"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/fickmacher //CKEY=fickmacher (UNIQUE)
	name = "塞莱娜的战术套装"
	desc = "一件外观奇特的黑色连体服。 捐赠者物品"
	icon_state = "robotics"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_department/research.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_department/research.dmi',
	)
	worn_state = "robotics"

/obj/item/clothing/under/marine/fluff/gromi
	name = "鹰眼之服"
	desc = "一位传奇战场外科医生穿过的制服。 独特捐赠者物品"
	icon_state = "hawkeye_jumpsuit_u"
	worn_state = "hawkeye_jumpsuit_u"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/feweh //CKEY=feweh
	name = "粉色作战服"
	desc = "用子弹对抗乳腺癌。 捐赠者物品。"
	icon_state = "pink2"
	worn_state = "pink2"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/oneonethreeeight //CKEY=oneonethreeeight
	name = "迷彩连体服"
	desc = "林地迷彩连体服。 捐赠者物品"
	icon_state = "camo_jumpsuit"
	worn_state = "camo_jumpsuit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/fickmacher2 //CKEY=fickmacher (UNIQUE)
	name = "哈特之服"
	desc = "看起来右臂是机械的。 捐赠者物品"
	icon_state = "hart_jumpsuit"
	worn_state = "hart_jumpsuit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/paradox //CKEY=paradox1i7
	name = "圣殿骑士连体服"
	desc = "圣殿骑士护甲的接口组件。 捐赠者物品"
	icon_state = "templar_jumpsuit"
	worn_state = "templar_jumpsuit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/chris1464 //CKEY=chris1464
	name = "佣兵连体服"
	desc = "来自一家极其可疑的佣兵公司的连体服。 捐赠者物品"
	icon_state = "merc_jumpsuit"
	worn_state = "merc_jumpsuit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/radical
	name = "赏金猎人连体服"
	desc = "一位古老赏金猎人的内衣。 捐赠者物品"
	icon_state = "boba_jumpsuit"
	worn_state = "boba_jumpsuit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/jackmcintyre_alt //CKEY=jackmcintyre
	name = "礼服"
	desc = "标准陆战队员穿着的礼服。 捐赠者物品"
	icon_state = "BO_jumpsuit"
	icon = 'icons/obj/items/clothing/uniforms/uniforms_by_faction/UA.dmi'
	item_icons = list(
		WEAR_BODY = 'icons/mob/humans/onmob/clothing/uniforms/uniforms_by_faction/UA.dmi',
	)
	worn_state = "BO_jumpsuit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/starscream //CKEY=starscream123 (UNIQUE)
	name = "卡达尔·侯赛因的连体服"
	desc = "略有磨损和撕裂。 捐赠者物品"
	icon_state = "merc_jumpsuit2"
	worn_state = "merc_jumpsuit2"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/allan1234
	name = "指挥官连体服"
	desc = "太空指挥官穿着的连体服... 捐赠者物品"
	icon_state = "henrick_jumpsuit"
	worn_state = "henrick_jumpsuit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/steelpoint //CKEY=steelpoint (UNIQUE)
	name = "M4-X连体服"
	desc = "与M4-X护甲一同配发的连体服。与更现代的护甲系统相比已过时。 捐赠者物品"
	icon_state = "steelpoint_jumpsuit"
	worn_state = "steelpoint_jumpsuit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/valentine //CKEY=markvalentine
	name = "肖基之服"
	desc = "好得惊人的连体服。 捐赠者物品"
	icon_state = "jensen"
	worn_state = "jensen"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/arach
	name = "零式作战服"
	desc = "一种穿在未来风格护甲下的连体服。赞助者物品"
	icon_state = "samus_jumpsuit"
	worn_state = "samus_jumpsuit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/nickiskool //CKEY=nickiskool
	name = "星际货船连体服"
	desc = "专为向所有女士展示你的男性肌肉而设计。赞助者物品"
	icon_state = "star_jumpsuit"
	worn_state = "star_jumpsuit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/jackmcintyre //CKEY=jackmcintyre (UNIQUE)
	name = "白衬衫与黑裤子"
	desc = "完美适用于正式着装，或是有型地前往战区。独特赞助者物品"
	icon_state = "Adam_jumpsuit_u"
	worn_state = "Adam_jumpsuit_u"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/fairedan //CKEY=fairedan (UNIQUE)
	name = "星际货船连体服"
	desc = "洛克马丁CM-88B野牛级星际货船船员的标准配发连体服。其内侧标签上有编号1809246.... 赞助者物品"
	icon_state = "Fairedan_jumpsuit"
	worn_state = "Fairedan_jumpsuit"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/commissar //used by both ckeys 'hycinth' and 'technokat' (UNIQUE)
	name = "欧米伽政委制服"
	desc = "欧米伽小队政委穿着的制服。独特赞助者物品"
	icon_state = "commisar_jumpsuit_u"
	worn_state = "commisar_jumpsuit_u"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/medicae_jumpsuit //CKEY=graciegrace0 (UNIQUE)
	name = "欧米伽医疗兵制服"
	desc = "欧米伽小队医疗部队穿着的制服。独特赞助者物品"
	icon_state = "medicae_jumpsuit_u"
	worn_state = "medicae_jumpsuit_u"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/sailordave //CKEY=sailordave
	name = "伊甸园USCM制服"
	desc = "一款旧型号的USCM制服。独特赞助者物品"
	icon_state = "syndicate"
	worn_state = "syndicate"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/whiteblood17 //CKEY=whiteblood17
	name = "黑色行动制服"
	desc = "远超出你的薪资等级... 赞助者物品"
	icon_state = "jensen"
	worn_state = "jensen"
	flags_jumpsuit = FALSE

/obj/item/clothing/under/marine/fluff/mileswolfe //CKEY=mileswolfe
	name = "虎纹迷彩作战服"
	desc = "带有虎纹图案的作战服。独特赞助者物品"
	icon_state = "mileswolfe_u"
	worn_state = "mileswolfe_u"
	flags_jumpsuit = FALSE


// MASK COSMETICS  ////////////////////////////////////////////////

/obj/item/clothing/mask/fluff/john56 //CKEY=johnkilla56
	name = "瑞文面具"
	desc = "来自一位著名西斯的面具...等等，什么？赞助者物品。"
	item_state = "revanmask"
	icon_state = "revanmask"

/obj/item/clothing/mask/fluff/totalanarchy //CKEY=totalanarchy
	name = "PMC面具"
	desc = "一款白色的PMC面具。赞助者物品。"
	item_state = "pmc_mask"
	icon_state = "pmc_mask"
	icon = 'icons/obj/items/clothing/masks/masks_by_faction/WY.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/masks_by_faction/WY.dmi'
	)
	flags_inventory = COVERMOUTH|ALLOWREBREATH
	flags_inv_hide = HIDEEARS|HIDEFACE|HIDEALLHAIR

/obj/item/clothing/mask/fluff/sas_elite //CKEY=sasoperative (UNIQUE)
	name = "紧凑型防毒面具"
	desc = "一款带有纯红色调的紧凑型防毒面具。独特赞助者物品。"
	item_state = "hunkmask"
	icon_state = "hunkmask"

/obj/item/clothing/mask/fluff/limo //CKEY=limodish
	name = "特警面具"
	desc = "特警防毒面具。赞助者物品"
	icon_state = "swat"
	item_state = "swat"
	icon = 'icons/obj/items/clothing/masks/gasmasks.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/gasmasks.dmi'
	)
	flags_inventory = ALLOWREBREATH
	flags_inv_hide = HIDEEYES|HIDEFACE

/obj/item/clothing/mask/fluff/feweh //CKEY=feweh
	name = "平克的防毒面具"
	desc = "一款标准制式防毒面具。赞助者物品"
	icon_state = "swat"
	item_state = "swat"
	icon = 'icons/obj/items/clothing/masks/gasmasks.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/gasmasks.dmi'
	)
	flags_inventory = ALLOWREBREATH
	flags_inv_hide = HIDEEYES|HIDEFACE

/obj/item/clothing/mask/fluff/fickmacher2 //CKEY=fickmacher (UNIQUE)
	name = "哈特下士的面具"
	desc = "一副看起来像机器人的装甲面具。赞助者物品"
	icon_state = "hartmask"
	item_state = "hartmask"
	flags_inventory = ALLOWREBREATH
	flags_inv_hide = HIDEFACE

/obj/item/clothing/mask/fluff/starscream //CKEY=starscream123 (UNIQUE)
	name = "卡达尔·侯赛因的面具"
	desc = "略有磨损和撕裂。 捐赠者物品"
	icon_state = "merc_mask"
	item_state = "merc_mask"
	flags_inventory = ALLOWREBREATH
	flags_inv_hide = HIDEFACE

/obj/item/clothing/mask/fluff/lostmixup
	name = "幻影雪茄"
	desc = "这是一支鬼-鬼-鬼-鬼-鬼-鬼雪茄。赞助者物品" //Add UNIQUE if Unique
	icon_state = "cigar_on"
	item_state = "cigar_on"
	icon = 'icons/obj/items/smoking/cigars.dmi'
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/masks/smoking.dmi'
	)
	flags_inventory = ALLOWREBREATH
	flags_inv_hide = HIDEFACE

// BOOTS/SHOES COSMETICS  ////////////////////////////////////////////////
/obj/item/clothing/shoes/marine/fluff/vintage //CKEY=vintagepalmer
	name = "复古凉鞋"
	desc = "复古凉鞋，只适合最高阶层的潮人。赞助者物品"
	icon_state = "sandals"
	item_state = "sandals"

/obj/item/clothing/shoes/marine/fluff/feodrich //CKEY=feodrich (UNIQUE)
	name = "毁灭战靴"
	desc = "一位著名地球战士的制服……赞助者物品。"
	icon_state = "doom_boots"
	item_state = "doom_boots"

/obj/item/clothing/shoes/marine/fluff/steelpoint //CKEY=steelpoint (UNIQUE)
	name = "M4-X军靴"
	desc = "与M4-X护甲一同配发的标准制式军靴，具有特殊的抗酸涂层，能让穿戴者在充满酸液的环境中安全行动。此原型版本不具备该功能。赞助者物品"
	icon_state = "marine"
	item_state = "marine"

//GENERIC GLASSES, GLOVES, AND MISC ////////////////////

/obj/item/clothing/glasses/fluff/wright //CKEY=wrightthewrong
	name = "eyepatch"
	desc = "哟，这可是赞助者物品，哟！"
	icon = 'icons/obj/items/clothing/glasses/misc.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/misc.dmi',
	)
	icon_state = "eyepatch"
	item_state = "eyepatch"

/obj/item/clothing/glasses/fluff/sadokist //CKEY=sadokist
	name = "塔尼娅的光学镜"
	desc = "定制光学镜，为塔尼娅·伊甸尼亚所有。"
	icon = 'icons/obj/items/clothing/glasses/goggles.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/goggles.dmi',
	)
	icon_state = "thermal"
	item_state = "glasses"

/obj/item/clothing/glasses/fluff/haveatya //CKEY=haveatya
	name = "特种夜视镜"
	desc = "免责声明：可能不提供夜视功能。赞助者物品"
	icon = 'icons/obj/items/clothing/glasses/night_vision.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/night_vision.dmi',
	)
	icon_state = "night"
	item_state = "glasses"

/obj/item/clothing/gloves/black/obey //CKEY=obeystylez (UNIQUE)
	desc = "黑色手套，深受特种作战部队青睐。赞助者物品"
	name = "黑色行动黑色手套"

//BACKPACKS

/obj/item/storage/backpack/marine/fluff/sadokist //CKEY=sadokist
	name = "塔尼娅的背包"
	desc = "一个大型背包，塔尼娅·伊甸尼亚使用。赞助者物品"
	icon_state = "securitypack"
	item_state = "securitypack"
	flags_atom = parent_type::flags_atom | NO_GAMEMODE_SKIN // same sprite for all gamemodes
	icon = 'icons/obj/items/clothing/backpack/backpacks.dmi'
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/backpacks.dmi'
	)

/obj/item/storage/backpack/marine/fluff/mitii
	name = "米娅的背包"
	desc = "一个大型安保背包，带有无线电信号增强器。赞助者物品。"
	icon_state = "securitypack"
	item_state = "securitypack"
	flags_atom = parent_type::flags_atom | NO_GAMEMODE_SKIN // same sprite for all gamemodes
	icon = 'icons/obj/items/clothing/backpack/backpacks.dmi'
	item_icons = list(
		WEAR_BACK = 'icons/mob/humans/onmob/clothing/back/backpacks.dmi'
	)

/obj/item/storage/backpack/marine/satchel/fluff/sas_juggernaut //CKEY=sasoperative (UNIQUE)
	name = "游骑兵背包"
	desc = "一个旧式驼峰包，带有额外口袋以增加空间。赞助者物品"
	icon_state = "hunkpack"
	item_state = "hunkpack"
	flags_atom = FPRINT|CONDUCT|NO_NAME_OVERRIDE|MAP_COLOR_INDEX
	item_state_slots = list(
		WEAR_L_HAND = "marinepack",
		WEAR_R_HAND = "marinepack"
	)

/obj/item/storage/backpack/marine/satchel/fluff/sas_juggernaut/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
		if("snow")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/snow_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/snow_righthand.dmi'
		if("desert")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/desert_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/desert_righthand.dmi'
		if("classic")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/classic_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/classic_righthand.dmi'
		if("urban")
			item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/urban_lefthand.dmi'
			item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/urban_righthand.dmi'

/obj/item/storage/backpack/marine/satchel/fluff/sas_legion //CKEY=sasoperative (UNIQUE)
	name = "M3装甲背包"
	desc = "大量口袋和挂包。赞助者物品"
	flags_atom = FPRINT|CONDUCT|NO_NAME_OVERRIDE|MAP_COLOR_INDEX
	icon_state = "skinnerrangerpack"
	item_state = "skinnerrangerpack"

/obj/item/clothing/glasses/fluff/alexwarhammer
	name = "黑杰克的炫酷墨镜"
	desc = "+20 硬汉点数。赞助者物品。"
	icon_state = "sun"
	item_state = "sun"

/obj/item/clothing/gloves/marine/fluff/jedijas //CKEY=jedijasun (UNIQUE)
	name = "曼达洛之拳"
	desc = "如果曼达洛是一个人，这将是它的拳头…… 赞助者物品"
	icon_state = "marine_white"
	item_state = "marine_wgloves"

/obj/item/storage/belt/marine/fluff/commissar //used by both ckeys 'hycinth' and 'technokat' (UNIQUE)
	name = "欧米茄剑带"
	desc = "由令人畏惧的欧米茄小队政委佩戴的腰带。独特赞助者物品"
	icon_state = "swordbelt_u"
	item_state = "swordbelt_u"
	icon = 'icons/obj/items/clothing/belts/donator.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/donator.dmi',
	)
	flags_atom = parent_type::flags_atom | NO_GAMEMODE_SKIN // same sprite for all gamemodes
	skip_fullness_overlays = TRUE

//CUSTOM ITEMS - NO TEMPLATES - ALL UNIQUE ////////////////////////
/obj/item/tool/lighter/zippo/fluff/ghostdex //CKEY=ghostdex
	name = "紫色之宝打火机"
	desc = "一个紫色之宝打火机，刻有约翰·多纳布尔的名字……独特赞助者物品。"
	icon = 'icons/obj/items/smoking/lighters.dmi'
	icon_state = "bluezippo"

/obj/item/clothing/mask/cigarette/fluff/ghostdex //CKEY=ghostdex
	name = "XXX定制雪茄"
	desc = "一支定制卷制的巨型雪茄，专为约翰·多纳布尔在最好、最热、最压榨的古巴血汗工厂制作。独特赞助者物品。"
	icon = 'icons/obj/items/smoking/cigars.dmi'
	icon_state = "cigar2_off"
	icon_on = "cigar2_on"
	icon_off = "cigar_2off"
	smoketime = 7200
	chem_volume = 30
	flags_inventory = COVERMOUTH|ALLOWREBREATH


//GHOST CIGAR CODE
/obj/item/clothing/mask/cigarette/cigar/fluff/ghostdex/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/tool/lighter/zippo/fluff/ghostdex))
		..()
	else
		to_chat(user, SPAN_NOTICE("\The [src] straight out REFUSES to be lit by anything other than a purple zippo."))
