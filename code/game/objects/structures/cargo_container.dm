/obj/structure/cargo_container
	name = "货柜"
	desc = "一个巨大的工业运输货柜。\n你不应该看到这个。"
	icon = 'icons/obj/structures/props/containers/contain.dmi'
	bound_width = 32
	bound_height = 64
	density = TRUE
	health = 200
	opacity = TRUE
	anchored = TRUE
	///multiples any demage taken from bullets
	var/bullet_damage_multiplier = 0.2
	///multiples any demage taken from explosion
	var/explosion_damage_multiplier = 2

/obj/structure/cargo_container/bullet_act(obj/projectile/projectile)
	. = ..()
	update_health(projectile.damage * bullet_damage_multiplier)

/obj/structure/cargo_container/attack_alien(mob/living/carbon/xenomorph/xenomorph)
	. = ..()
	var/damage = ((floor((xenomorph.melee_damage_lower + xenomorph.melee_damage_upper)/2)) )

	//Frenzy bonus
	if(xenomorph.frenzy_aura > 0)
		damage += (xenomorph.frenzy_aura * FRENZY_DAMAGE_MULTIPLIER)

	xenomorph.animation_attack_on(src)

	xenomorph.visible_message(SPAN_DANGER("[xenomorph]劈砍[src]！"),
	SPAN_DANGER("You slash [src]!"))

	update_health(damage)

	return XENO_ATTACK_ACTION

/obj/structure/cargo_container/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable || health <= 0)
		return TAILSTAB_COOLDOWN_NONE
	playsound(src, 'sound/effects/metalhit.ogg', 25, 1)
	update_health(xeno.melee_damage_upper)
	if(health <= 0)
		xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴摧毁了[src]！"),
		SPAN_DANGER("We destroy [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	else
		xeno.visible_message(SPAN_DANGER("[xeno] 用它的尾巴抽打 [src]！"),
		SPAN_DANGER("We strike [src] with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/cargo_container/ex_act(severity, direction)
	. = ..()
	update_health(severity * explosion_damage_multiplier)

//Note, for Watatsumi, Grant, and Arious, "left" and "leftmid" are both the left end of the container, but "left" is generic and "leftmid" has the Sat Mover mark on it
/obj/structure/cargo_container/watatsumi
	name = "Watatsumi货柜"
	desc = "一个巨大的工业运输货柜。\n这个来自Watatsumi，一家生产各种电子和机械产品的制造商。\n至少，货柜上是这么写的。你以前压根没听说过这家公司。"

/obj/structure/cargo_container/watatsumi/left
	icon_state = "watatsumi_l"

/obj/structure/cargo_container/watatsumi/leftmid
	icon_state = "watatsumi_lm"

/obj/structure/cargo_container/watatsumi/mid
	icon_state = "watatsumi_m"

/obj/structure/cargo_container/watatsumi/rightmid
	icon_state = "watatsumi_rm"

/obj/structure/cargo_container/watatsumi/right
	icon_state = "watatsumi_r"

/obj/structure/cargo_container/grant
	name = "格兰特公司货柜"
	desc = "一个巨大的工业运输货柜。\n这个来自格兰特公司，一家医疗和生物技术部件制造商。\n你记得听说过他们最新的某种药物，以及它有多危险……尽管他们声称已接近找到解决方案。"

/obj/structure/cargo_container/grant/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/grant)

/obj/structure/cargo_container/grant/left
	icon_state = "grant_l"

/obj/structure/cargo_container/grant/leftmid
	icon_state = "grant_lm"

/obj/structure/cargo_container/grant/rightmid
	icon_state = "grant_rm"

/obj/structure/cargo_container/grant/right
	icon_state = "grant_r"

/obj/structure/cargo_container/arious
	name = "Arious货柜"
	desc = "一个巨大的工业运输货柜。\n这个来自Arious，一家计算机部件和动态探测器制造商。\n你仍然在想为什么我们有一柜子旧动态探测器，以及它们是否还能用。"

/obj/structure/cargo_container/arious/left
	icon_state = "arious_l"

/obj/structure/cargo_container/arious/leftmid
	icon_state = "arious_lm"

/obj/structure/cargo_container/arious/mid
	icon_state = "arious_m"

/obj/structure/cargo_container/arious/rightmid
	icon_state = "arious_rm"

/obj/structure/cargo_container/arious/right
	icon_state = "arious_r"

/obj/structure/cargo_container/wy
	name = "维兰德-汤谷货柜"
	desc = "一个巨大的工业运输货柜。\n这个来自维兰德-汤谷公司，你之前可能听说过他们。"

/obj/structure/cargo_container/wy/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/structure/cargo_container/wy/left
	icon_state = "wy_l"

/obj/structure/cargo_container/wy/mid
	icon_state = "wy_m"

/obj/structure/cargo_container/wy/right
	icon_state = "wy_r"

/obj/structure/cargo_container/wy2
	name = "维兰德-汤谷货柜"
	desc = "一个巨大的工业运输货柜。\n这个来自维兰德-汤谷公司，你之前可能听说过他们。"

/obj/structure/cargo_container/wy2/left
	icon_state = "wy2_l"

/obj/structure/cargo_container/wy2/mid
	icon_state = "wy2_m"

/obj/structure/cargo_container/wy2/right
	icon_state = "wy2_r"

/obj/structure/cargo_container/armat
	name = "阿玛特货柜"
	desc = "一个大型工业货柜。这个来自阿玛特公司，他们是M41A和其他陆战队武器背后的国防承包商。"

/obj/structure/cargo_container/armat/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/structure/cargo_container/armat/left
	icon_state = "armat_l"

/obj/structure/cargo_container/armat/mid
	icon_state = "armat_m"

/obj/structure/cargo_container/armat/right
	icon_state = "armat_r"

/obj/structure/cargo_container/hd
	name = "海珀戴恩系统货柜"
	desc = "一个巨大的工业运输货柜。\n这个来自海珀戴恩系统公司，一家生产合成人、义肢和武器的制造商。\n我们不会谈论他们以前与UPP的关联。"

/obj/structure/cargo_container/hd/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/hyperdyne)

/obj/structure/cargo_container/hd/left
	icon_state = "hd_l"

/obj/structure/cargo_container/hd/left/alt
	icon_state = "hd_l_alt"

/obj/structure/cargo_container/hd/mid
	icon_state = "hd_m"

/obj/structure/cargo_container/hd/mid/alt
	icon_state = "hd_m_alt"

/obj/structure/cargo_container/hd/right
	icon_state = "hd_r"

/obj/structure/cargo_container/hd/right/alt
	icon_state = "hd_r_alt"

/obj/structure/cargo_container/trijent
	name = "特里金特公司货柜"
	desc = "一个巨大的工业运输货柜。\n这个来自特里金特公司的采矿作业。\n如果这个货柜破裂了，你最好别吸入里面的东西。"

/obj/structure/cargo_container/trijent/left
	icon_state = "trijent_l"

/obj/structure/cargo_container/trijent/left/alt
	icon_state = "trijent_l_alt"

/obj/structure/cargo_container/trijent/mid
	icon_state = "trijent_m"

/obj/structure/cargo_container/trijent/mid/alt
	icon_state = "trijent_m_alt"

/obj/structure/cargo_container/trijent/right
	icon_state = "trijent_r"

/obj/structure/cargo_container/trijent/right/alt
	icon_state = "trijent_r_alt"

/obj/structure/cargo_container/kelland //The container formerly known as 'gorg'
	name = "凯兰矿业公司货柜"
	desc = "一个小型工业运输货柜。\n除了LV-178采矿作业的事故外，你对凯兰矿业公司了解不多。"
	bound_height = 32 //It's smaller than the rest
	layer = ABOVE_XENO_LAYER //Due to size, needs to be above player and xenos

/obj/structure/cargo_container/kelland/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/kelland)

/obj/structure/cargo_container/kelland/left
	icon_state = "kelland_l"

/obj/structure/cargo_container/kelland/right
	icon_state = "kelland_r"

/obj/structure/cargo_container/ferret
	name = "费雷特重工业货柜"
	desc = "一个巨大的工业运输货柜。\n这个来自费雷特重工业公司，一家生产陆地爬行器和动力装载机的制造商。\n不幸的是，这家公司破产了。幸运的是，这些货柜现在非常便宜。"

/obj/structure/cargo_container/ferret/left
	icon_state = "ferret_l"

/obj/structure/cargo_container/ferret/mid
	icon_state = "ferret_m"

/obj/structure/cargo_container/ferret/right
	icon_state = "ferret_r"

/obj/structure/cargo_container/lockmart
	name = "洛克马特公司货柜"
	desc = "一个巨大的工业运输货柜。\n这个来自洛克希德·马丁公司，一家生产飞船和飞船部件的制造商。\n他们制造了USCSS诺斯特罗莫号……那艘船后来到底怎么样了？"

/obj/structure/cargo_container/lockmart/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/lockmart)

/obj/structure/cargo_container/lockmart/left
	icon_state = "lockmart_l"

/obj/structure/cargo_container/lockmart/mid
	icon_state = "lockmart_m"

/obj/structure/cargo_container/lockmart/right
	icon_state = "lockmart_r"

/obj/structure/cargo_container/seegson
	name = "西格森公司货柜"
	desc = "一个巨大的工业运输货柜。\n这个来自西格森公司，他们几乎生产所有东西。\n你注意到这个货柜上有一张剥落的便条，上面写着所有物品都是几十年前从另一个空间站转移过来的，它在这里多久了？"

/obj/structure/cargo_container/seegson/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/seegson)

/obj/structure/cargo_container/seegson/left
	icon_state = "seegson_l"

/obj/structure/cargo_container/seegson/mid
	icon_state = "seegson_m"

/obj/structure/cargo_container/seegson/right
	icon_state = "seegson_r"

/obj/structure/cargo_container/attack_hand(mob/user as mob)

	playsound(loc, 'sound/effects/clang.ogg', 25, 1)

	var/damage_dealt
	if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		if(H.species.can_shred(H))

			user.visible_message(SPAN_WARNING("[user]猛砸[src]，但毫无效果。"),
					SPAN_WARNING("You beat against [src] to no effect."),
					"You hear twisting metal.")

	if(!damage_dealt)
		user.visible_message(SPAN_WARNING("[user]猛击[src]，但毫无效果。"),
					SPAN_WARNING("[user] beats against the [src]."),
					"You hear twisting metal.")

/obj/structure/cargo_container/horizontal
	name = "货柜"
	desc = "一个巨大的工业运输货柜。"
	icon = 'icons/obj/structures/props/containers/containHorizont.dmi'
	bound_width = 64
	bound_height = 32
	density = TRUE
	health = 200
	opacity = TRUE

/obj/structure/cargo_container/horizontal/blue
	name = "通用货柜"
	desc = "一个巨大的工业运输货柜。\n尽管侧面有明显的标志，但你无法看到它，因为标志没有朝南。"

/obj/structure/cargo_container/horizontal/blue/top
	icon_state = "blue_t"

/obj/structure/cargo_container/horizontal/blue/middle
	icon_state = "blue_m"

/obj/structure/cargo_container/horizontal/blue/bottom
	icon_state = "blue_b"

/obj/structure/cargo_container/canc
	name = "中亚洲合作组织货柜"
	desc = "一个巨大的工业运输货柜。\n这个来自中亚洲合作组织，该组织已被UPP吸收。他们庞大的工业产出确保了带有其标志和名称的货柜不会很快消失。"

/obj/structure/cargo_container/canc/left
	icon_state = "canc_g_l"

/obj/structure/cargo_container/canc/mid
	icon_state = "canc_g_m"

/obj/structure/cargo_container/canc/right
	icon_state = "canc_g_r"

/obj/structure/cargo_container/canc/tan
	name = "中亚洲合作组织货柜"
	desc = "一个巨大的工业运输货柜。\n这个来自中亚洲合作组织，该组织已被UPP吸收。他们庞大的工业产出确保了带有其标志和名称的货柜不会很快消失。"

/obj/structure/cargo_container/canc/tan/left
	icon_state = "canc_t_l"

/obj/structure/cargo_container/canc/tan/mid
	icon_state = "canc_t_m"

/obj/structure/cargo_container/canc/tan/right
	icon_state = "canc_t_r"

/obj/structure/cargo_container/upp
	name = "UPP货柜"
	desc = "一个巨大的工业运输货柜。\n这个来自进步人民联盟，侧面的巨大标志表明了这一点。"

/obj/structure/cargo_container/upp/left
	icon_state = "upp_l"

/obj/structure/cargo_container/upp/mid
	icon_state = "upp_m"

/obj/structure/cargo_container/upp/right
	icon_state = "upp_r"

/obj/structure/cargo_container/upp/tan
	name = "UPP货柜"
	desc = "一个巨大的工业运输货柜。\n这个来自进步人民联盟，侧面的巨大标志表明了这一点。"

/obj/structure/cargo_container/upp/tan/left
	icon_state = "upp_t_l"

/obj/structure/cargo_container/upp/tan/mid
	icon_state = "upp_t_m"

/obj/structure/cargo_container/upp/tan/right
	icon_state = "upp_t_r"

/obj/structure/cargo_container/upp/mk6
	name = "太空安全部货柜"
	desc = "一个巨大的工业运输货柜。\n这个属于进步人民联盟的太空安全部。"

/obj/structure/cargo_container/upp/mk6/left
	icon_state = "mk6_l"

/obj/structure/cargo_container/upp/mk6/mid
	icon_state = "mk6_m"

/obj/structure/cargo_container/upp/mk6/right
	icon_state = "mk6_r"

/obj/structure/cargo_container/uscm
	name = "美国殖民地海军陆战队货柜"
	desc = "一个巨大的工业运输货柜。\n这个属于美利坚合众国的美国海军陆战队。"

/obj/structure/cargo_container/uscm/sanfran/left
	name = "美国殖民地海军陆战队货柜"

	icon_state = "uscm1_l"

/obj/structure/cargo_container/uscm/sanfran/mid
	icon_state = "uscm1_m"

/obj/structure/cargo_container/uscm/borodino/left
	name = "美国殖民地海军陆战队货柜"

	icon_state = "uscm2_l"

/obj/structure/cargo_container/uscm/borodino/mid
	icon_state = "uscm2_m"

/obj/structure/cargo_container/uscm/tartarus/left
	name = "美国殖民地海军陆战队货柜"

	icon_state = "uscm3_l"

/obj/structure/cargo_container/uscm/tartarus/mid
	icon_state = "uscm3_m"

/obj/structure/cargo_container/uscm/chinook/left
	name = "美国殖民地海军陆战队货柜"

	icon_state = "uscm4_l"

/obj/structure/cargo_container/uscm/chinook/mid
	icon_state = "uscm4_m"

/obj/structure/cargo_container/uscm/crestus/left
	name = "美国殖民地海军陆战队货柜"

	icon_state = "uscm5_l"

/obj/structure/cargo_container/uscm/crestus/mid
	icon_state = "uscm5_m"

/obj/structure/cargo_container/uscm/micor/left
	name = "美国殖民地海军陆战队货柜"

	icon_state = "uscm6_l"

/obj/structure/cargo_container/uscm/mid
	icon_state = "uscm_m"

/obj/structure/cargo_container/uscm/right
	icon_state = "uscm_r"

/obj/structure/cargo_container/upp_small
	name = "UPP货柜"
	desc = "一个小型工业运输货柜。\n这个来自进步人民联盟，侧面有红星标志。"
	bound_height = 32
	layer = ABOVE_XENO_LAYER

/obj/structure/cargo_container/upp_small/container_1/left
	icon_state = "upp_1_l"

/obj/structure/cargo_container/upp_small/container_1/right
	icon_state = "upp_1_r"

/obj/structure/cargo_container/upp_small/container_2/left
	icon_state = "upp_2_l"

/obj/structure/cargo_container/upp_small/container_2/right
	icon_state = "upp_2_r"

/obj/structure/cargo_container/upp_small/container_3/left
	icon_state = "upp_3_l"

/obj/structure/cargo_container/upp_small/container_3/right
	icon_state = "upp_3_r"

/obj/structure/cargo_container/upp_small/container_4/left
	icon_state = "upp_4_l"

/obj/structure/cargo_container/upp_small/container_4/right
	icon_state = "upp_4_r"

/obj/structure/cargo_container/upp_small/container_5/left
	icon_state = "upp_5_l"

/obj/structure/cargo_container/upp_small/container_5/right
	icon_state = "upp_5_r"

/obj/structure/cargo_container/upp_small/container_6/left
	icon_state = "upp_6_l"

/obj/structure/cargo_container/upp_small/container_6/right
	icon_state = "upp_6_r"

/obj/structure/cargo_container/upp_small/container_7/left
	icon_state = "upp_7_l"

/obj/structure/cargo_container/upp_small/container_7/right
	icon_state = "upp_7_r"

/obj/structure/cargo_container/upp_small/container_8/left
	icon_state = "upp_8_l"

/obj/structure/cargo_container/upp_small/container_8/right
	icon_state = "upp_8_r"

/obj/structure/cargo_container/upp_small/container_9/left
	icon_state = "upp_9_l"

/obj/structure/cargo_container/upp_small/container_9/right
	icon_state = "upp_9_r"

/obj/structure/cargo_container/upp_small/container_10/left
	icon_state = "upp_10_l"

/obj/structure/cargo_container/upp_small/container_10/right
	icon_state = "upp_10_r"

/obj/structure/cargo_container/upp_small/container_11/left
	icon_state = "upp_11_l"

/obj/structure/cargo_container/upp_small/container_11/right
	icon_state = "upp_11_r"

/obj/structure/cargo_container/upp_small/container_12/left
	icon_state = "upp_12_l"

/obj/structure/cargo_container/upp_small/container_12/right
	icon_state = "upp_12_r"

/obj/structure/cargo_container/upp_small/container_13/left
	icon_state = "upp_13_l"

/obj/structure/cargo_container/upp_small/container_13/right
	icon_state = "upp_13_r"

/obj/structure/cargo_container/upp_small/container_14/left
	icon_state = "upp_14_l"

/obj/structure/cargo_container/upp_small/container_14/right
	icon_state = "upp_14_r"

/obj/structure/cargo_container/upp_small/container_15/left
	icon_state = "upp_15_l"

/obj/structure/cargo_container/upp_small/container_15/right
	icon_state = "upp_15_r"

/obj/structure/cargo_container/upp_small/container_16/left
	icon_state = "upp_16_l"

/obj/structure/cargo_container/upp_small/container_16/right
	icon_state = "upp_16_r"

/obj/structure/cargo_container/upp_small/container_17/left
	icon_state = "upp_17_l"

/obj/structure/cargo_container/upp_small/container_17/right
	icon_state = "upp_17_r"

/obj/structure/cargo_container/upp_small/container_18/left
	icon_state = "upp_18_l"

/obj/structure/cargo_container/upp_small/container_18/right
	icon_state = "upp_18_r"

/obj/structure/cargo_container/upp_small/container_19/left
	icon_state = "upp_19_l"

/obj/structure/cargo_container/upp_small/container_19/right
	icon_state = "upp_19_r"

/obj/structure/cargo_container/upp_small/container_20/left
	icon_state = "upp_20_l"

/obj/structure/cargo_container/upp_small/container_20/right
	icon_state = "upp_20_r"
