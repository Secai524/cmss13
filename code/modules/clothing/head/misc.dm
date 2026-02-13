
/obj/item/clothing/head/hairflower
	name = "发饰花别针"
	icon_state = "hairflower"
	desc = "闻起来不错。"
	item_state = "hairflower"
	flags_armor_protection = 0

/obj/item/clothing/head/powdered_wig
	name = "扑粉假发"
	desc = "一顶扑粉假发。"
	icon_state = "pwig"
	item_state = "pwig"

/obj/item/clothing/head/that
	name = "高顶礼帽"
	desc = "这是一顶看起来像阿米什风格的帽子。"
	icon_state = "tophat"
	item_state = "that"
	icon = 'icons/obj/items/clothing/hats/formal_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/formal_hats.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_righthand.dmi',
	)
	siemens_coefficient = 0.9
	flags_armor_protection = 0

/obj/item/clothing/head/nursehat
	name = "护士帽"
	desc = "它能快速识别出受过训练的医务人员。"
	icon_state = "nursehat"
	siemens_coefficient = 0.9
	flags_armor_protection = 0

/obj/item/clothing/head/syndicatefake
	name = "红色太空头盔复制品"
	desc = "一个辛迪加特工太空头盔的塑料复制品，戴上它你看起来就像一个真正的、凶残的辛迪加特工！这是个玩具，不能在太空中使用！"
	icon_state = "syndicate"
	item_state = "syndicate"
	icon = 'icons/obj/items/clothing/hats/hazard.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hazard.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/hats_righthand.dmi',
	)
	flags_inventory = COVEREYES|COVERMOUTH
	flags_inv_hide = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEALLHAIR
	siemens_coefficient = 2
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE|BODY_FLAG_EYES
	anti_hug = 1

/obj/item/clothing/head/greenbandana
	name = "绿色头巾"
	desc = "这是一条带有精细纳米技术衬里的绿色头巾。"
	icon_state = "greenbandana"
	item_state = "greenbandana"
	flags_inventory = NO_FLAGS
	flags_inv_hide = NO_FLAGS
	flags_armor_protection = 0

/obj/item/clothing/head/cardborg
	name = "纸板头盔"
	desc = "一个用盒子做的头盔。"
	icon_state = "cardborg_h"
	item_state = "cardborg_h"
	flags_inventory = COVERMOUTH|COVEREYES
	flags_inv_hide = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEALLHAIR
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE|BODY_FLAG_EYES

/obj/item/clothing/head/flatcap
	name = "鸭舌帽"
	desc = "一顶工人的帽子。"
	icon_state = "flat_cap"
	item_state = "detective"
	siemens_coefficient = 0.9

/obj/item/clothing/head/pirate
	name = "海盗帽"
	desc = "哟嚯。"
	icon_state = "pirate"
	item_state = "pirate"
	flags_armor_protection = 0

/obj/item/clothing/head/bandana
	name = "海盗头巾"
	desc = "哟嚯。"
	icon_state = "bandana"
	item_state = "bandana"

/obj/item/clothing/head/bowler
	name = "圆顶礼帽"
	desc = "绅士们，精英登场！"
	icon_state = "bowler"
	item_state = "bowler"
	icon = 'icons/obj/items/clothing/hats/formal_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/formal_hats.dmi'
	)
	flags_armor_protection = 0

/obj/item/clothing/head/straw
	name = "\improper straw hat"
	desc = "一顶饱经风霜的草帽，帽冠环绕着棕色皮革带。它看起来非常适合阳光明媚的日子和田间漫长的午后。"
	icon_state = "strawhat"
	item_state = "strawhat"

/obj/item/clothing/head/cowboy

	name = "\improper cowboy hat"
	desc = "一顶标志性的美国牛仔帽。"
	icon = 'icons/obj/items/clothing/hats/hats.dmi'
	icon_state = "cowboy_dark"
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/hats.dmi'
	)
	desc = "一顶做工精良的牛仔帽。"

/obj/item/clothing/head/cowboy/light
	icon_state = "cowboy_light"

//stylish bs12 hats

/obj/item/clothing/head/bowlerhat
	name = "圆顶礼帽"
	desc = "献给杰出的绅士。"
	icon_state = "bowler_hat"
	item_state = "bowler_hat"
	icon = 'icons/obj/items/clothing/hats/formal_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/formal_hats.dmi'
	)
	flags_armor_protection = 0

/obj/item/clothing/head/director
	name = "导演帽"
	desc = "属于某个非常重要的人物。对所有伤害类型提供轻微防护。"
	icon_state = "director_hat"
	item_state = "director_hat"
	icon = 'icons/obj/items/clothing/hats/formal_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/formal_hats.dmi'
	)
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM

/obj/item/clothing/head/manager
	name = "经理帽"
	desc = "属于某个重要人物。提供对所有形式伤害的轻微防护。"
	icon_state = "manager_hat"
	item_state = "manager_hat"
	icon = 'icons/obj/items/clothing/hats/formal_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/formal_hats.dmi'
	)
	flags_armor_protection = BODY_FLAG_HEAD
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM

/obj/item/clothing/head/beaverhat
	name = "海狸皮帽"
	desc = "柔软的毛毡让这顶帽子既舒适又优雅。"
	icon_state = "beaver_hat"
	item_state = "beaver_hat"
	icon = 'icons/obj/items/clothing/hats/formal_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/formal_hats.dmi'
	)

/obj/item/clothing/head/boaterhat
	name = "平顶硬草帽"
	desc = "夏日时尚的终极之选。"
	icon_state = "boater_hat"
	item_state = "boater_hat"
	icon = 'icons/obj/items/clothing/hats/formal_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/formal_hats.dmi'
	)

/obj/item/clothing/head/feathertrilby
	name = "\improper feather trilby"
	desc = "一顶时髦别致、带有羽毛的帽子。"
	icon_state = "feather_trilby"
	item_state = "feather_trilby"
	icon = 'icons/obj/items/clothing/hats/formal_hats.dmi'
	item_icons = list(
		WEAR_HEAD = 'icons/mob/humans/onmob/clothing/head/formal_hats.dmi'
	)

/obj/item/clothing/head/fez
	name = "\improper fez"
	icon_state = "fez"
	item_state = "fez"
	desc = "你应该戴一顶土耳其毡帽。毡帽很酷。"

//end bs12 hats

/obj/item/clothing/head/chicken
	name = "小鸡套装头部"
	desc = "咯咯！"
	icon_state = "chickenhead"
	item_state = "chickensuit"
	flags_inventory = NO_FLAGS
	flags_inv_hide = HIDEALLHAIR
	siemens_coefficient = 2
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE|BODY_FLAG_EYES

/obj/item/clothing/head/xenos
	name = "外星人服装头盔"
	icon_state = "xenos"
	item_state = "xenos_helm"
	desc = "一个用廉价织物制成的头盔。"
	flags_inventory = COVERMOUTH|COVEREYES|BLOCKSHARPOBJ
	flags_inv_hide = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEALLHAIR
	siemens_coefficient = 2
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE|BODY_FLAG_EYES

/obj/item/clothing/head/foil
	name = "锡纸帽"
	desc = "防止政府、外星人和你的姻亲读取你的思想。大概吧。"
	icon_state = "foil"
	item_state = "foil"
