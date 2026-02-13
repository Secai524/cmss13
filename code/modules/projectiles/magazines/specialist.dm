//-------------------------------------------------------
//SNIPER RIFLES
//Keyword rifles. They are subtype of rifles, but still contained here as a specialist weapon.

/obj/item/ammo_magazine/sniper
	name = "\improper M42A marksman magazine (10x28mm Caseless)"
	desc = "一个装有10x28毫米无壳狙击步枪弹的弹匣。用它进行瞄准射击将造成显著伤害。"
	caliber = "10x28mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/marksman_rifles.dmi'
	icon_state = "m42c" //PLACEHOLDER
	w_class = SIZE_MEDIUM
	max_rounds = 15
	default_ammo = /datum/ammo/bullet/sniper
	gun_type = /obj/item/weapon/gun/rifle/sniper/M42A
	ammo_band_icon = "+m42c_band"
	ammo_band_icon_empty = "+m42c_band_e"

/obj/item/ammo_magazine/sniper/incendiary
	name = "\improper M42A incendiary magazine (10x28mm)"
	desc = "一个装有10x28毫米燃烧狙击步枪弹的弹匣。用它进行瞄准射击将暂时致盲目标并使其猛烈燃烧。"
	default_ammo = /datum/ammo/bullet/sniper/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/sniper/flak
	name = "\improper M42A flak magazine (10x28mm)"
	desc = "一个装有10x28毫米高爆狙击步枪弹的弹匣。用它进行瞄准射击将暂时减缓目标速度，并对附近任何人造成冲击伤害。"
	default_ammo = /datum/ammo/bullet/sniper/flak
	ammo_band_color = AMMO_BAND_COLOR_IMPACT

//XM43E1 Magazine
/obj/item/ammo_magazine/sniper/anti_materiel
	name = "\improper XM43E1 marksman magazine (10x99mm)"
	desc = "一个装有10x99毫米无壳反器材弹的弹匣，能够穿透大多数步兵级别的器材。根据你击中的目标，它甚至可能有足够的能量伤及目标身后的任何东西。"
	max_rounds = 8
	caliber = "10x99mm"
	default_ammo = /datum/ammo/bullet/sniper/anti_materiel
	gun_type = /obj/item/weapon/gun/rifle/sniper/XM43E1

//M42C magazine

/obj/item/ammo_magazine/sniper/elite
	name = "\improper M42C marksman magazine (10x99mm)"
	desc = "一个装有特制超音速10x99毫米反坦克弹的弹匣。"
	default_ammo = /datum/ammo/bullet/sniper/elite
	gun_type = /obj/item/weapon/gun/rifle/sniper/elite
	caliber = "10x99mm"
	icon_state = "m42c"
	max_rounds = 6


//Type 88 //Based on the actual Dragunov designated marksman rifle.

/obj/item/ammo_magazine/sniper/svd
	name = "\improper Type-88 Magazine (7.62x54mmR)"
	desc = "88式精确射手步枪的大口径7.62x54毫米R弹匣。"
	caliber = "7.62x54mmR"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/marksman_rifles.dmi'
	icon_state = "type88mag"
	default_ammo = /datum/ammo/bullet/sniper/upp
	max_rounds = 12
	gun_type = /obj/item/weapon/gun/rifle/sniper/svd

//M4RA magazines

/obj/item/ammo_magazine/rifle/m4ra/custom
	name = "\improper A19 HV magazine (10x24mm)"
	desc = "一个装有A19高速10x24毫米弹的弹匣，供M4RA定制战斗步枪使用。M4RA定制战斗步枪是唯一能装填这种子弹的枪。"
	icon_state = "a19"
	default_ammo = /datum/ammo/bullet/rifle/m4ra
	max_rounds = 18
	gun_type = /obj/item/weapon/gun/rifle/m4ra_custom
	ammo_band_icon = "+a19_band"
	ammo_band_icon_empty = "+a19_band_e"

/obj/item/ammo_magazine/rifle/m4ra/custom/incendiary
	name = "\improper A19 HV incendiary magazine (10x24mm)"
	desc = "一个装有A19高速燃烧弹的弹匣，供M4RA战斗步枪使用。M4RA定制战斗步枪是唯一能装填这种子弹的枪。"
	default_ammo = /datum/ammo/bullet/rifle/m4ra/incendiary
	max_rounds = 18
	gun_type = /obj/item/weapon/gun/rifle/m4ra_custom
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/rifle/m4ra/custom/impact
	name = "\improper A19 HV high impact magazine (10x24mm)"
	desc = "一个装有A19高冲击力弹的弹匣，供M4RA战斗步枪使用。M4RA定制战斗步枪是唯一能装填这种子弹的枪。"
	default_ammo = /datum/ammo/bullet/rifle/m4ra/impact
	max_rounds = 18
	gun_type = /obj/item/weapon/gun/rifle/m4ra_custom
	ammo_band_color = AMMO_BAND_COLOR_HIGH_IMPACT

//-------------------------------------------------------
//SMARTGUN
/obj/item/ammo_magazine/smartgun
	name = "M56智能枪弹鼓"
	desc = "一个10x28毫米500发弹鼓，供M56智能枪使用。"
	caliber = "10x28mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/machineguns.dmi'
	icon_state = "m56_drum"
	bonus_overlay = "drum_overlay"
	max_rounds = 500 //Should be 500 in total.
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/smartgun
	gun_type = /obj/item/weapon/gun/smartgun
	flags_magazine = AMMUNITION_REFILLABLE|AMMUNITION_SLAP_TRANSFER

/obj/item/ammo_magazine/smartgun/rusty
	name = "生锈的M56智能枪弹鼓"
	icon_state = "m56f_drum"
	bonus_overlay = "rusty_drum_overlay"
	desc = "一个略有磨损的10x28毫米500发弹鼓，适用于M56智能枪，或者更直白地说，管你手里拿的是什么，型号名称在这里基本不适用。"

/obj/item/ammo_magazine/smartgun/rusty/Initialize(mapload, spawn_empty)
	. = ..()
	current_rounds = rand(280, 500) //Scavenged surplus, so there is more suprise factors

/obj/item/ammo_magazine/smartgun/dirty
	name = "辐射M56智能枪弹鼓"
	desc = "乍一看是标准的500发M56智能枪弹鼓，实际上装填的是辐射弹，为子弹提供了额外的“冲击力”。弹匣本身经过轻微改装，只能装入M56D或M56T型智能枪，并标有一个红色X。"
	icon_state = "m56_drum_dirty"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/WY/machineguns.dmi'
	default_ammo = /datum/ammo/bullet/smartgun/dirty
	gun_type = /obj/item/weapon/gun/smartgun/l56a2
	flags_magazine = AMMUNITION_REFILLABLE|AMMUNITION_SLAP_TRANSFER

/obj/item/ammo_magazine/smartgun/holo_targetting
	name = "全息瞄准M56智能枪弹鼓"
	desc = "一个10x28毫米全息瞄准弹鼓，供皇家海军陆战队突击队L56A2智能枪使用。"
	ammo_band_icon = "+m56_drum_strip"
	ammo_band_icon_empty = "+m56_drum_strip_e"
	ammo_band_color = AMMO_BAND_COLOR_HOLOTARGETING
	default_ammo = /datum/ammo/bullet/smartgun/holo_target
	gun_type = /obj/item/weapon/gun/smartgun/rmc
	flags_magazine = AMMUNITION_REFILLABLE|AMMUNITION_SLAP_TRANSFER

/obj/item/ammo_magazine/smartgun/heap
	name = "HEAP M56智能枪弹鼓"
	desc = "一个10x28毫米HEAP弹鼓，供维兰德和UA精锐部队使用。"
	icon_state = "m56_drum"
	ammo_band_icon = "+m56_drum_strip"
	ammo_band_icon_empty = "+m56_drum_strip_e"
	bonus_overlay = "heap_drum_overlay"
	ammo_band_color = AMMO_BAND_COLOR_HEAP
	default_ammo = /datum/ammo/bullet/smartgun/heap
	gun_type = /obj/item/weapon/gun/smartgun/terminator
	flags_magazine = AMMUNITION_REFILLABLE|AMMUNITION_SLAP_TRANSFER

/obj/item/ammo_magazine/smartgun/upp
	name = "RFVS37智能枪弹鼓"
	// desc = "一个10x28毫米500发弹鼓，供M56智能枪使用。"
	// caliber = "10x28mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/machineguns.dmi'
	icon_state = "rfvs37"

//-------------------------------------------------------
//Flare gun. Close enough?
/obj/item/ammo_magazine/internal/flare
	name = "信号枪内置弹仓"
	caliber = "FL"
	max_rounds = 1
	default_ammo = /datum/ammo/flare

//-------------------------------------------------------
//M5 RPG

/obj/item/ammo_magazine/rocket
	name = "\improper 84mm high explosive rocket"
	desc = "一个装有高爆弹头的火箭发射管。直接命中时对软目标造成高伤害，并在5米宽区域内使大多数目标短暂眩晕。对重装甲目标效果减弱。"
	caliber = "rocket"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/rocket_launchers.dmi'
	icon_state = "rocket"

	reload_delay = 60
	matter = list("metal" = 10000)
	w_class = SIZE_MEDIUM
	max_rounds = 1
	default_ammo = /datum/ammo/rocket
	gun_type = /obj/item/weapon/gun/launcher/rocket/m5
	flags_magazine = NO_FLAGS

/obj/item/ammo_magazine/rocket/attack_self(mob/user)
	. = ..()
	if(current_rounds <= 0)
		to_chat(user, SPAN_NOTICE("你开始拆解空的发射管框架..."))
		if(do_after(user,10, INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
			user.visible_message("[user]拆解了火箭发射管框架。",SPAN_NOTICE("You take apart the empty frame."))
			var/obj/item/stack/sheet/metal/M = new(get_turf(user))
			M.amount = 2
			user.drop_held_item()
			qdel(src)
	else
		to_chat(user, "里面有导弹可不行！")

/obj/item/ammo_magazine/rocket/attack(mob/living/carbon/human/demoman, mob/living/carbon/human/user)
	if(!istype(demoman) || !istype(user) || get_dist(user, demoman) > 1)
		return
	var/obj/item/weapon/gun/launcher/in_hand = demoman.get_active_hand()
	if(!in_hand || !istype(in_hand))
		to_chat(user, SPAN_WARNING("[demoman]的主手里没有拿着火箭发射器！"))
		return
	if(!in_hand.can_be_reloaded)
		to_chat(user, SPAN_WARNING("[demoman]的[in_hand]无法重新装填！"))
		return
	if(!in_hand.current_mag)
		to_chat(user, SPAN_WARNING("[demoman]的[in_hand]已经装填好了！"))
		return
	if(!istype(in_hand, gun_type))
		to_chat(user, SPAN_WARNING("[src]装不进[demoman]的[in_hand.name]！")) // using name here because otherwise it puts an odd 'the' in front
		return
	var/obj/item/weapon/twohanded/offhand/off_hand = demoman.get_inactive_hand()
	if(!off_hand || !istype(off_hand))
		to_chat(user, SPAN_WARNING("\the [demoman] needs to be wielding \the [in_hand] in order to reload!"))
		return
	if(!skillcheck(demoman, SKILL_FIREARMS, SKILL_FIREARMS_TRAINED))
		to_chat(user, SPAN_WARNING("你不知道如何给\the [in_hand]重新装填！"))
		return
	if(demoman.dir != user.dir || demoman.loc != get_step(user, user.dir))
		to_chat(user, SPAN_WARNING("你必须站在\the [demoman]身后才能为其装填！"))
		return
	if(in_hand.current_mag.current_rounds > 0)
		to_chat(user, SPAN_WARNING("\the [in_hand] is already loaded!"))
		return
	if(user.action_busy)
		return
	to_chat(user, SPAN_NOTICE("你开始为\the [demoman]的[in_hand]重新装填！保持不动..."))
	if(!do_after(user,(in_hand.current_mag.reload_delay / 2), INTERRUPT_ALL, BUSY_ICON_FRIENDLY, demoman, INTERRUPT_ALL, BUSY_ICON_GENERIC))
		to_chat(user, SPAN_WARNING("你的装填被打断了！"))
		return
	if(off_hand != demoman.get_inactive_hand())
		to_chat(user, SPAN_WARNING("\the [demoman] needs to be wielding \the [in_hand] in order to reload!"))
		return
	if(demoman.dir != user.dir)
		to_chat(user, SPAN_WARNING("你必须站在\the [demoman]身后才能为其装填！"))
		return
	user.drop_inv_item_on_ground(src)
	qdel(in_hand.current_mag)
	in_hand.replace_ammo(user,src)
	in_hand.current_mag = src
	in_hand.update_icon()
	forceMove(in_hand)
	to_chat(user, SPAN_NOTICE("你将\the [src]装入了\the [demoman]的[in_hand]。"))
	if(in_hand.reload_sound)
		playsound(demoman, in_hand.reload_sound, 25, 1)
	else
		playsound(demoman,'sound/machines/click.ogg', 25, 1)

	return 1

/obj/item/ammo_magazine/rocket/update_icon()
	if(current_rounds <= 0)
		name = "\improper 84mm spent rocket tube"
		icon_state = "rocket_e"
		desc = "一个M5火箭筒用过的火箭发射管。在手中激活可拆解为金属。"
		add_to_garbage(src)
	else
		icon_state = initial(icon_state)

/obj/item/ammo_magazine/rocket/custom/update_icon()
	if(current_rounds <= 0)
		return ..()
	if(warhead)
		if(locked)
			if(fuel && fuel.reagents.get_reagent_amount(fuel_type) >= fuel_requirement)
				icon_state = initial(icon_state) +"_locked"
			else
				icon_state = initial(icon_state) +"_no_fuel"
		else if(!locked)
			icon_state = initial(icon_state) +"_unlocked"
	else
		icon_state = initial(icon_state)

/obj/item/ammo_magazine/rocket/ap
	name = "\improper 84mm anti-armor rocket"
	icon_state = "ap_rocket"
	default_ammo = /datum/ammo/rocket/ap
	desc = "一个装有穿甲弹头的火箭发射管。能够穿透重装甲目标。造成极低或无溅射伤害。对大多数目标造成必定眩晕效果。在7米内具有高精度。"

/obj/item/ammo_magazine/rocket/wp
	name = "\improper 84mm white-phosphorus rocket"
	icon_state = "wp_rocket"
	default_ammo = /datum/ammo/rocket/wp
	desc = "一个装有白磷燃烧弹头的火箭发射管。具有两种伤害因素。命中时在4米半径圆形区域内散布X型萘（蓝色火焰），无视掩体，同时爆裂成高温破片，点燃稍大区域内的目标。"

/obj/item/ammo_magazine/rocket/brute
	name = "\improper M5510 Laser-Guided Rocket"
	icon_state = "brute_rocket"
	default_ammo = /datum/ammo/rocket/brute
	gun_type = /obj/item/weapon/gun/launcher/rocket/brute
	desc = "M5510火箭是高效能反结构弹药，设计用于在任何大气条件下迅速加速至近每小时1000英里。其弹头采用偏转稳定聚能装药，可产生低频压力波，足以在数米椭圆形半径内夷平几乎所有防御工事。已知此类火箭对人员杀伤力有限，但足以将任何偏远地区的泥屋送上轨道。"

/obj/item/ammo_magazine/rocket/custom
	name = "\improper 84mm custom rocket"
	desc = "一个装有定制弹头的火箭发射管。"
	icon_state = "custom_rocket"
	default_ammo = /datum/ammo/rocket/custom
	matter = list("metal" = 7500) //2 sheets
	var/obj/item/explosive/warhead/rocket/warhead
	var/obj/item/reagent_container/glass/fuel
	var/fuel_requirement = 60
	var/fuel_type = "methane"
	var/locked = FALSE

/obj/item/ammo_magazine/rocket/custom/attack_self(mob/user as mob)
	if(!locked && current_rounds)
		if(warhead)
			user.put_in_hands(warhead)
			warhead = null
		else if(fuel)
			user.put_in_hands(fuel)
			fuel = null
		update_icon()
		return
	. = ..()

/obj/item/ammo_magazine/rocket/custom/get_examine_text(mob/user)
	. = ..()
	if(fuel)
		. += SPAN_NOTICE("Contains fuel.")
	if(warhead)
		. += SPAN_NOTICE("Contains a warhead.")

/obj/item/ammo_magazine/rocket/custom/attackby(obj/item/W as obj, mob/user as mob)
	if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
		to_chat(user, SPAN_WARNING("你不知道如何摆弄[name]。"))
		return
	if(current_rounds <= 0)
		to_chat(user, SPAN_WARNING("火箭发射管已经使用过了。"))
		return
	if(HAS_TRAIT(W, TRAIT_TOOL_SCREWDRIVER))
		if(!warhead)
			to_chat(user, SPAN_NOTICE("[name]必须装有弹头才能这么做！"))
			return
		if(locked)
			to_chat(user, SPAN_NOTICE("你解锁了[name]。"))
		else
			to_chat(user, SPAN_NOTICE("你锁上了[name]。"))
		locked = !locked
		playsound(loc, 'sound/items/Screwdriver.ogg', 25, 0, 6)
	else if(istype(W,/obj/item/reagent_container/glass) && !locked)
		if(fuel)
			to_chat(user, SPAN_DANGER("[name]已经装有燃料容器了！"))
			return
		else
			user.temp_drop_inv_item(W)
			W.forceMove(src)
			fuel = W
			to_chat(user, SPAN_DANGER("你将[W]装入[name]。"))
			playsound(loc, 'sound/items/Screwdriver2.ogg', 25, 0, 6)
	else if(istype(W,/obj/item/explosive/warhead/rocket) && !locked)
		if(warhead)
			to_chat(user, SPAN_DANGER("[name]已经装有弹头了！"))
			return
		var/obj/item/explosive/warhead/rocket/det = W
		if(det.assembly_stage < ASSEMBLY_LOCKED)
			to_chat(user, SPAN_DANGER("[W]未固定！"))
			return
		user.temp_drop_inv_item(W)
		W.forceMove(src)
		warhead = W
		to_chat(user, SPAN_DANGER("你将[W]装入[name]。"))
		playsound(loc, 'sound/items/Screwdriver2.ogg', 25, 0, 6)
	update_icon()

//-------------------------------------------------------
//M5 RPG'S MEAN FUCKING COUSIN

/obj/item/ammo_magazine/rocket/m57a4
	name = "\improper 84mm thermobaric rocket array"
	desc = "一个为M57-A4四联装发射器配备的温压火箭发射管，装有4枚弹头。"
	caliber = "rocket array"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/event.dmi'
	icon_state = "quad_rocket"

	max_rounds = 4
	default_ammo = /datum/ammo/rocket/wp/quad
	gun_type = /obj/item/weapon/gun/launcher/rocket/m57a4
	reload_delay = 200

/obj/item/ammo_magazine/rocket/m57a4/update_icon()
	..()
	if(current_rounds <= 0)
		name = "\improper 84mm spent rocket array"
		desc = "一个M57-A4四联装发射器用过的火箭发射管组件。在手中激活可拆解为金属。"
		icon_state = "quad_rocket_e"

//-------------------------------------------------------
//Anti-tank rocket

/obj/item/ammo_magazine/rocket/anti_tank
	name = "\improper 84mm Anti-Tank Rocket"
	desc = "一种专为穿透装甲车辆外壳设计的反装甲火箭。"
	caliber = "rocket"
	icon_state = "at_rocket"

	max_rounds = 1
	default_ammo = /datum/ammo/rocket/ap/anti_tank
	gun_type = /obj/item/weapon/gun/launcher/rocket/anti_tank
	reload_delay = 100


//-------------------------------------------------------
//UPP Rockets

/obj/item/ammo_magazine/rocket/upp
	name = "\improper HJRA-12 High-Explosive Rocket"
	desc = "UPP标准配发HJRA-12手持反坦克火箭发射器用火箭。此为标准高爆火箭，用于攻击轻型车辆或作为杀伤人员手榴弹。"

	caliber = "88mm"
	icon_state = "hjra_explosive"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/rocket_launchers.dmi'

	max_rounds = 1
	default_ammo = /datum/ammo/rocket
	gun_type = /obj/item/weapon/gun/launcher/rocket/upp
	reload_delay = 85

/obj/item/ammo_magazine/rocket/upp/update_icon()
	if(current_rounds <= 0)
		qdel(src)
	else
		icon_state = initial(icon_state)

/obj/item/ammo_magazine/rocket/upp/at
	name = "\improper HJRA-12 Anti-Tank Rocket"
	desc = "UPP标准配发HJRA-12手持反坦克火箭发射器用火箭。此为标准反坦克火箭，设计用于瘫痪或摧毁敌方装甲车辆。"

	caliber = "88mm"
	icon_state = "hjra_tank"

	max_rounds = 1
	default_ammo = /datum/ammo/rocket/ap/anti_tank
	gun_type = /obj/item/weapon/gun/launcher/rocket/upp
	reload_delay = 85

/obj/item/ammo_magazine/rocket/upp/incen
	name = "\improper HJRA-12 Extreme-Intensity Incendiary Rocket"
	desc = "UPP标准配发HJRA-12手持反坦克火箭发射器用火箭。此为极高强度燃烧火箭。"
	desc_lore = "This incendiary rocket uses an experimental chemical designated 'R-189' by the UPP. It is designed to melt through fortifications and bunkers but is most commonly used in an anti-personnel role due to over-issuing and the tempeartures after use in its intended role leaving behind a cloud of super-heated air, preventing troops' advance."
	caliber = "88mm"
	icon_state = "hjra_incen"

	max_rounds = 1
	default_ammo = /datum/ammo/rocket/wp/upp
	gun_type = /obj/item/weapon/gun/launcher/rocket/upp
	reload_delay = 85
