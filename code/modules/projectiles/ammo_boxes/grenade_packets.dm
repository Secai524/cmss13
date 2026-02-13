/obj/item/storage/box/packet
	icon = 'icons/obj/items/storage/packets.dmi'
	icon_state = "hedp_packet"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/storage_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/storage_righthand.dmi',
	)
	w_class = SIZE_MEDIUM//fits into bags
	storage_slots = 3
	can_hold = list(/obj/item/explosive/grenade)
	foldable = null
	var/content_type

/obj/item/storage/box/packet/update_icon()
	if(LAZYLEN(contents))
		icon_state = initial(icon_state)
	else
		icon_state = initial(icon_state) + "_e"

/obj/item/storage/box/packet/Initialize()
	if(!content_type)
		return INITIALIZE_HINT_QDEL

	. = ..()

	update_icon()

/obj/item/storage/box/packet/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new content_type(src)

GLOBAL_LIST_INIT(grenade_packets, list(
	/obj/item/storage/box/packet/high_explosive,
	/obj/item/storage/box/packet/baton_slug,
	/obj/item/storage/box/packet/flare,
	/obj/item/storage/box/packet/hornet,
	/obj/item/storage/box/packet/incendiary,
	/obj/item/storage/box/packet/smoke,
	/obj/item/storage/box/packet/foam,
	/obj/item/storage/box/packet/phosphorus,
	/obj/item/storage/box/packet/phosphorus/upp,
	/obj/item/storage/box/packet/m15,
	/obj/item/storage/box/packet/airburst_he,
	/obj/item/storage/box/packet/airburst_incen
	))

/obj/item/storage/box/packet/high_explosive
	name = "\improper HEDP grenade packet"
	desc = "它包含三枚HEDP高爆手榴弹。"
	icon_state = "hedp_packet"
	item_state = "hedp_packet"
	content_type = /obj/item/explosive/grenade/high_explosive

/obj/item/storage/box/packet/high_explosive/upp
	name = "\improper Type 6 grenade packet"
	desc = "它包含三枚6型破片手榴弹。"
	icon_state = "hefa_packet"
	item_state = "hefa_packet"
	content_type = /obj/item/explosive/grenade/high_explosive/upp

/obj/item/storage/box/packet/baton_slug
	name = "\improper HIRR baton slug packet"
	desc = "它包含三枚HIRR（高冲击橡胶弹）防暴弹头。"
	icon_state = "baton_packet"
	item_state = "baton_packet"
	content_type = /obj/item/explosive/grenade/slug/baton

/obj/item/storage/box/packet/flare
	name = "\improper M74 AGM-S star shell packet"
	desc = "它包含三枚M40-F星壳手榴弹。这种40毫米榴弹会爆燃成燃烧的灰烬，非常适合临时照亮一片区域。"
	icon_state = "starshell_packet"
	item_state = "starshell_packet"
	content_type = /obj/item/explosive/grenade/high_explosive/airburst/starshell

/obj/item/storage/box/packet/hornet
	name = "\improper M74 AGM-H hornet shell packet"
	desc = "它包含三枚M74 AGM-H黄蜂弹。这种40毫米榴弹会在射程内爆炸成一簇.22lr子弹，对路径上的任何目标造成巨大伤害。"
	icon_state = "hornet_packet"
	item_state = "hornet_packet"
	content_type = /obj/item/explosive/grenade/high_explosive/airburst/hornet_shell

/obj/item/storage/box/packet/incendiary
	name = "\improper HIDP grenade packet"
	desc = "它包含三枚HIDP燃烧手榴弹。"
	icon_state = "hidp_packet"
	item_state = "hidp_packet"
	content_type = /obj/item/explosive/grenade/incendiary

/obj/item/storage/box/packet/smoke
	name = "\improper HSDP grenade packet"
	desc = "它包含三枚HSDP烟雾弹。"
	icon_state = "hsdp_packet"
	item_state = "hsdp_packet"
	content_type = /obj/item/explosive/grenade/smokebomb

/obj/item/storage/box/packet/phosphorus
	name = "\improper WPDP grenade packet"
	desc = "它包含三枚WPDP白磷手榴弹。"
	icon_state = "wpdp_packet"
	item_state = "wpdp_packet"
	content_type = /obj/item/explosive/grenade/phosphorus/weak

/obj/item/storage/box/packet/phosphorus/strong
	name = "\improper CCDP grenade packet"
	desc = "它包含三枚CCDP化合物手榴弹。"
	icon_state = "ccdp_packet"
	item_state = "ccdp_packet"
	content_type = /obj/item/explosive/grenade/phosphorus

/obj/item/storage/box/packet/phosphorus/upp
	name = "\improper Type 8 WP grenade packet"
	desc = "它包含三枚8型白磷手榴弹。"
	content_type = /obj/item/explosive/grenade/phosphorus/upp

/obj/item/storage/box/packet/hefa
	name = "\improper HEFA grenade packet"
	desc = "它包含三枚HEFA手榴弹。别告诉HEFA命令。"
	icon_state = "hefa_packet"
	item_state = "hefa_packet"
	content_type = /obj/item/explosive/grenade/high_explosive/frag

/obj/item/storage/box/packet/hefa/toy
	name = "玩具HEFA手榴弹包"
	desc = "这些小小的欢乐包曾作为纪念品奖励，随《军靴！》杂志第100期（第二季）分发给订阅者。没人知道在这个过程中，为什么没有任何人在任何时刻问一句‘等等，这主意是不是糟透了？’。"
	content_type = /obj/item/explosive/grenade/high_explosive/frag/toy

/obj/item/storage/box/packet/foam
	name = "\improper MFHS foam grenade packet"
	desc = "它包含三枚MFHS金属泡沫手榴弹。"
	icon_state = "mfhs_packet"
	item_state = "mfhs_packet"
	content_type = /obj/item/explosive/grenade/metal_foam

/obj/item/storage/box/packet/m15
	name = "\improper M15 fragmentation grenade packet"
	desc = "它包含三枚M15破片手榴弹。小心轻放。"
	icon_state = "general_packet"
	item_state = "m15_packet"
	content_type = /obj/item/explosive/grenade/high_explosive/m15

/obj/item/storage/box/packet/m15/rubber
	name = "M15橡胶弹手榴弹包"
	desc = "它包含三枚M15橡胶弹手榴弹，用于防暴或战斗演习。"
	icon_state = "general_packet"
	content_type = /obj/item/explosive/grenade/high_explosive/m15/rubber

/obj/item/storage/box/packet/sebb
	name = "\improper G2 Electroshock grenade packet"
	desc = "它包含三枚G2电击手榴弹。小心轻放。"
	icon_state = "sebb_packet"
	item_state = "sebb_packet"
	content_type = /obj/item/explosive/grenade/sebb

/obj/item/storage/box/packet/airburst_he
	name = "\improper M74 airburst grenade packet"
	desc = "它包含三枚M74空爆破片手榴弹。此端朝向敌人。"
	icon_state = "agmf_packet"
	content_type = /obj/item/explosive/grenade/high_explosive/airburst

/obj/item/storage/box/packet/airburst_incen
	name = "\improper M74 airburst incendiary grenade packet"
	desc = "它包含三枚M74空爆燃烧手榴弹。此端朝向敌人。"
	icon_state = "agmi_packet"
	item_state = "agmi_packet"
	content_type = /obj/item/explosive/grenade/incendiary/airburst

/obj/item/storage/box/packet/airburst_smoke
	name = "\improper M74 airburst smoke grenade packet"
	desc = "内装三枚M74空爆烟雾弹。此端朝向敌人。"
	icon_state = "agms_packet"
	item_state = "agms_packet"
	content_type = /obj/item/explosive/grenade/smokebomb/airburst

/obj/item/storage/box/packet/rmc/he
	name = "\improper R2175/A HEDP grenade packet"
	desc = "内装三枚R2175/A HEDP手榴弹。小心轻放。"
	icon_state = "hedp_packet"
	item_state = "hedp_packet"
	content_type = /obj/item/explosive/grenade/high_explosive/rmc

/obj/item/storage/box/packet/rmc/incin
	name = "\improper R2175/B HIDP grenade packet"
	desc = "内装三枚R2175/B HIDP手榴弹。小心轻放。"
	icon_state = "hidp_packet"
	item_state = "hidp_packet"
	content_type = /obj/item/explosive/grenade/incendiary/rmc
