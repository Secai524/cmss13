

//*****************************Pickaxe********************************/

/obj/item/tool/pickaxe
	name = "pickaxe"
	icon = 'icons/obj/items/tools.dmi'
	item_icons = list(
		WEAR_WAIST = 'icons/mob/humans/onmob/clothing/belts/tools.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/tools_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/tools_righthand.dmi'
	)
	icon_state = "pickaxe"
	flags_atom = FPRINT|CONDUCT
	flags_equip_slot = SLOT_WAIST
	force = MELEE_FORCE_STRONG
	throwforce = 4
	item_state = "pickaxe"
	w_class = SIZE_LARGE
	hitsound = 'sound/weapons/bladeslice.ogg'
	matter = list("metal" = 3750)
	/// moving the delay to an item var so R&D can make improved picks. --NEO
	var/digspeed = 40

	attack_verb = list("hit", "pierced", "sliced", "attacked")
	var/drill_sound = 'sound/weapons/Genhit.ogg'
	var/drill_verb = "picking"
	sharp = IS_SHARP_ITEM_SIMPLE
	var/excavation_amount = 100

/obj/item/tool/pickaxe/hammer
	name = "矿用大锤"
	icon_state = "minesledge"
	item_state = "minesledge"
	desc = "一把由强化金属制成的矿用锤。功能和鹤嘴锄一样好。"

/obj/item/tool/pickaxe/silver
	name = "银制鹤嘴锄"
	icon_state = "spickaxe"
	item_state = "spickaxe"
	digspeed = 30

	desc = "这在冶金学上毫无道理。"
	black_market_value = 25

/obj/item/tool/pickaxe/drill
	/// Can dig sand as well!
	name = "矿用钻机"
	icon_state = "handdrill"
	item_state = "jackhammer"
	digspeed = 30

	desc = "你的钻头将穿透岩壁。"
	drill_verb = "drilling"

/obj/item/tool/pickaxe/jackhammer
	name = "声波破碎镐"
	icon_state = "jackhammer"
	item_state = "jackhammer"
	/// faster than drill, but cannot dig
	digspeed = 20

	desc = "利用声波冲击破碎岩石，是消灭洞穴蜥蜴的完美工具。"
	drill_verb = "hammering"

/obj/item/tool/pickaxe/gold
	name = "金制鹤嘴锄"
	icon_state = "gpickaxe"
	item_state = "gpickaxe"
	digspeed = 20

	desc = "这在冶金学上毫无道理。"
	black_market_value = 30

/obj/item/tool/pickaxe/plasmacutter
	name = "等离子切割器"
	icon_state = "plasmacutter"
	item_state = "gun"
	/// it is smaller than the pickaxe
	w_class = SIZE_MEDIUM
	damtype = "fire"
	/// Can slice though normal walls, all girders, or be used in reinforced wall deconstruction/ light thermite on fire
	digspeed = 20
	desc = "一种利用高温等离子体脉冲切割岩石的工具。你可以用它来切断异形的肢体！或者，你知道的，采矿。"
	drill_verb = "cutting"
	heat_source = 3800
	flags_item = IGNITING_ITEM

/obj/item/tool/pickaxe/diamond
	name = "钻石鹤嘴锄"
	icon_state = "dpickaxe"
	item_state = "dpickaxe"
	digspeed = 10

	desc = "一把带有钻石镐头的鹤嘴锄，这简直就像《我的世界》。"
	black_market_value = 5 //fuck you!

/obj/item/tool/pickaxe/diamonddrill //When people ask about the badass leader of the mining tools, they are talking about ME!
	name = "钻石矿用钻机"
	icon_state = "diamonddrill"
	item_state = "jackhammer"
	/// Digs through walls, girders, and can dig up sand
	digspeed = 5

	desc = "你的钻头将贯穿天际！"
	drill_verb = "drilling"
	black_market_value = 35

/obj/item/tool/pickaxe/borgdrill
	name = "赛博格矿用钻机"
	icon_state = "diamonddrill"
	item_state = "jackhammer"
	digspeed = 15
	desc = ""
	drill_verb = "drilling"





