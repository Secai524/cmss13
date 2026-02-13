/*
 * Toy gun
 * Toy crossbow
 * Toy swords
*/



/*
 * Toy gun: Why isn't this an /obj/item/weapon/gun?
 */
/obj/item/toy/gun
	name = "玩具枪"
	desc = "还剩0发玩具子弹。看起来几乎和真的一样！适合8岁及以上。子弹用完后请记得在自动制造机里回收！"
	icon_state = "capgun"
	item_state = "gun"
	flags_equip_slot = SLOT_WAIST
	w_class = SIZE_MEDIUM

	matter = list("glass" = 10,"metal" = 10)

	attack_verb = list("struck", "用枪托击打", "hit", "bashed")
	var/bullets = 7

/obj/item/toy/gun/get_examine_text(mob/user)
	desc = "There are [bullets] caps\s left. Looks almost like the real thing! Ages 8 and up."
	return ..()

/obj/item/toy/gun/attackby(obj/item/toy/gun_ammo/A as obj, mob/user as mob)
	if (istype(A, /obj/item/toy/gun_ammo))
		if (src.bullets >= 7)
			to_chat(user, SPAN_NOTICE("它已经装满了！"))
			return 1
		if (A.amount_left <= 0)
			to_chat(user, SPAN_DANGER("没有更多玩具子弹了！"))
			return 1
		if (A.amount_left < (7 - bullets))
			src.bullets += A.amount_left
			to_chat(user, SPAN_DANGER("You reload [A.amount_left] caps\s!"))
			A.amount_left = 0
		else
			to_chat(user, SPAN_DANGER("You reload [7 - bullets] caps\s!"))
			A.amount_left -= 7 - bullets
			bullets = 7
		A.update_icon()
		A.desc = "There are [A.amount_left] caps\s left! Make sure to recycle the box in an autolathe when it gets empty."
		return 1

/obj/item/toy/gun/afterattack(atom/target as mob|obj|turf|area, mob/user as mob, flag)
	if (flag)
		return
	if (!(istype(usr, /mob/living/carbon/human) || SSticker) && SSticker.mode.name != "monkey")
		to_chat(usr, SPAN_DANGER("你的手不够灵巧，无法完成此操作！"))
		return
	src.add_fingerprint(user)
	if (src.bullets < 1)
		user.show_message(SPAN_DANGER("*咔哒* *咔哒*"), SHOW_MESSAGE_AUDIBLE)
		playsound(user, 'sound/weapons/gun_empty.ogg', 15, 1)
		return
	playsound(user, 'sound/weapons/Gunshot.ogg', 15, 1)
	src.bullets--
	for(var/mob/O in viewers(user, null))
		O.show_message(SPAN_DANGER("<B>[user]用玩具枪朝[target]开了一枪！</B>"), SHOW_MESSAGE_VISIBLE, SPAN_DANGER("You hear a gunshot."), SHOW_MESSAGE_AUDIBLE)

/obj/item/toy/gun_ammo
	name = "玩具子弹"
	desc = "还剩7发玩具子弹！子弹用完后请记得在自动制造机里回收盒子。"
	icon_state = "cap_ammo"
	w_class = SIZE_TINY

	matter = list("metal" = 10,"glass" = 10)

	var/amount_left = 7

/obj/item/toy/gun_ammo/update_icon()
	if(amount_left)
		icon_state = "cap_ammo"
	else
		icon_state = "cap_ammo_e"


/*
 * Toy crossbow
 */

/obj/item/toy/crossbow
	name = "泡沫飞镖弩"
	desc = "许多精力过剩的儿童喜爱的武器。适合8岁及以上。"
	icon_state = "foamcrossbow"
	item_state = "crossbow"
	w_class = SIZE_SMALL
	attack_verb = list("attacked", "struck", "hit")
	var/bullets = 5

/obj/item/toy/crossbow/examine(mob/user)
	..()
	if (bullets)
		to_chat(user, SPAN_NOTICE("它已装填了[bullets]支泡沫飞镖！"))

/obj/item/toy/crossbow/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/toy/crossbow_ammo))
		if(bullets <= 4)
			if(user.drop_held_item())
				qdel(I)
				bullets++
				to_chat(user, SPAN_NOTICE("你将泡沫飞镖装填进弩里。"))
		else
			to_chat(usr, SPAN_DANGER("它已经装满了。"))


/obj/item/toy/crossbow/afterattack(atom/target as mob|obj|turf|area, mob/user as mob, flag)
	if(!isturf(target.loc) || target == user)
		return
	if(flag)
		return

	if (locate (/obj/structure/surface/table, src.loc))
		return
	else if (bullets)
		var/turf/trg = get_turf(target)
		var/obj/effect/foam_dart_dummy/D = new/obj/effect/foam_dart_dummy(get_turf(src))
		bullets--
		D.icon_state = "foamdart"
		D.name = "泡沫飞镖"
		playsound(user.loc, 'sound/items/syringeproj.ogg', 15, 1)

		for(var/i=0, i<6, i++)
			if (D)
				if(D.loc == trg)
					break
				step_towards(D,trg)

				for(var/mob/living/M in D.loc)
					if(!istype(M,/mob/living))
						continue
					if(M == user)
						continue
					for(var/mob/O in viewers(GLOB.world_view_size, D))
						O.show_message(SPAN_DANGER("[M]被泡沫飞镖击中了！"), SHOW_MESSAGE_VISIBLE)
					new /obj/item/toy/crossbow_ammo(M.loc)
					qdel(D)
					return

				for(var/atom/A in D.loc)
					if(A == user)
						continue
					if(A.density)
						new /obj/item/toy/crossbow_ammo(A.loc)
						qdel(D)

			sleep(1)

		spawn(10)
			if(D)
				new /obj/item/toy/crossbow_ammo(D.loc)
				qdel(D)

		return
	else if (bullets == 0)
		user.apply_effect(5, WEAKEN)
		for(var/mob/O in viewers(GLOB.world_view_size, user))
			O.show_message(SPAN_DANGER("[user]意识到弹药耗尽，开始四处搜寻！"), SHOW_MESSAGE_VISIBLE)


/obj/item/toy/crossbow/attack(mob/living/M as mob, mob/user as mob)
	src.add_fingerprint(user)

	if (src.bullets > 0 && M.body_position == LYING_DOWN)

		for(var/mob/O in viewers(M, null))
			if(O.client)
				O.show_message(SPAN_DANGER("<B>[user]漫不经心地瞄准[M]的头部，扣动了扳机！</B>"), SHOW_MESSAGE_VISIBLE, SPAN_DANGER("You hear the sound of foam against skull!"), SHOW_MESSAGE_AUDIBLE)
				O.show_message(SPAN_DANGER("[M]的头部被泡沫飞镖击中了！"), SHOW_MESSAGE_VISIBLE)

		playsound(user.loc, 'sound/items/syringeproj.ogg', 15, 1)
		new /obj/item/toy/crossbow_ammo(M.loc)
		src.bullets--
	else if (M.body_position == LYING_DOWN && src.bullets == 0)
		for(var/mob/O in viewers(M, null))
			if (O.client)
				O.show_message(SPAN_DANGER("<B>[user]漫不经心地瞄准[M]的头部，扣动扳机，然后发现弹药耗尽，立刻趴到地上寻找弹药！</B>"), SHOW_MESSAGE_VISIBLE, SPAN_DANGER("You hear someone fall."), SHOW_MESSAGE_AUDIBLE)
		user.apply_effect(5, WEAKEN)
	return

/obj/item/toy/crossbow_ammo
	name = "泡沫飞镖"
	desc = "要么是软弹枪，要么什么都不是！适合8岁及以上。"
	icon = 'icons/obj/items/toy.dmi'
	icon_state = "foamdart"
	w_class = SIZE_TINY

/obj/effect/foam_dart_dummy
	name = ""
	desc = ""
	icon = 'icons/obj/items/toy.dmi'
	icon_state = null
	anchored = TRUE
	density = FALSE


/*
 * Toy swords
 */
/obj/item/toy/sword
	name = "蓝色玩具光剑"
	desc = "一把廉价的光剑塑料复制品，在那些新《星球冲突》电影的粉丝中非常流行。逼真的音效！适合8岁及以上。"
	icon = 'icons/obj/items/weapons/melee/energy.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/energy_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/melee/energy_righthand.dmi',
	)
	icon_state = "sword0"
	item_state = "sword0"
	var/active = 0
	var/sword_type = "blue"
	w_class = SIZE_SMALL
	attack_verb = list("attacked", "struck", "hit")

/obj/item/toy/sword/red
	name = "红色玩具光剑"
	sword_type = "red"

/obj/item/toy/sword/green
	name = "绿色玩具光剑"
	sword_type = "green"

/obj/item/toy/sword/purple
	name = "绿色玩具光剑"
	sword_type = "purple"

/obj/item/toy/sword/attack_self(mob/user)
	..()

	active = !active
	if (active)
		to_chat(user, SPAN_NOTICE("你手腕一抖，弹出了塑料剑刃。"))
		playsound(user, 'sound/weapons/saberon.ogg', 15, 1)
		icon_state = "sword[sword_type]"
		item_state = "sword[sword_type]"
		w_class = SIZE_LARGE
	else
		to_chat(user, SPAN_NOTICE("你将塑料剑刃按回剑柄。"))
		playsound(user, 'sound/weapons/saberoff.ogg', 15, 1)
		icon_state = "sword0"
		item_state = "sword0"
		w_class = SIZE_SMALL

	if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		H.update_inv_l_hand(0)
		H.update_inv_r_hand()

	add_fingerprint(user)

/obj/item/toy/katana
	name = "仿制武士刀"
	desc = "在D20规则中弱得可怜。"
	icon = 'icons/obj/items/weapons/melee/swords.dmi'
	icon_state = "katana"
	flags_atom = FPRINT|CONDUCT
	flags_equip_slot = SLOT_WAIST|SLOT_BACK
	force = 5
	throwforce = 5
	w_class = SIZE_MEDIUM
	attack_verb = list("attacked", "slashed", "stabbed", "sliced")

