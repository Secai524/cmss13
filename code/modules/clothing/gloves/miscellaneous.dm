/obj/item/clothing/gloves/captain
	desc = "华贵的蓝色手套，配有漂亮的金边。真够气派的。"
	name = "上尉手套"
	icon_state = "captain"
	item_state = "egloves"
	flags_cold_protection = BODY_FLAG_HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROT
	flags_heat_protection = BODY_FLAG_HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROT

/obj/item/clothing/gloves/cyborg
	desc = "哔啵啵啵。"
	name = "合成人手套"
	icon_state = "black"
	item_state = "r_hands"
	siemens_coefficient = 1

/obj/item/clothing/gloves/swat
	desc = "这些战术手套具有一定的防火和抗冲击能力。"
	name = "\improper SWAT Gloves"
	icon_state = "veteran"
	item_state = "black"
	siemens_coefficient = 0.6


	flags_cold_protection = BODY_FLAG_HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROT
	flags_heat_protection = BODY_FLAG_HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROT

/obj/item/clothing/gloves/combat //Combined effect of SWAT gloves and insulated gloves
	desc = "这些战术手套具有一定的防火和抗冲击能力。"
	name = "战斗手套"
	icon_state = "black"
	item_state = "black"
	siemens_coefficient = 0

	flags_cold_protection = BODY_FLAG_HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROT
	flags_heat_protection = BODY_FLAG_HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROT

/obj/item/clothing/gloves/latex
	name = "乳胶手套"
	desc = "无菌乳胶手套。"
	icon_state = "latex"
	item_state = "latex"
	siemens_coefficient = 0.30
	armor_bio = CLOTHING_ARMOR_LOW

/obj/item/clothing/gloves/botanic_leather
	desc = "这些皮手套能防护荆棘、倒刺、尖刺以及其他植物来源的有害物体。"
	name = "植物学家皮手套"
	icon_state = "leather"
	item_state = "ggloves"
	siemens_coefficient = 0.9

/obj/item/clothing/gloves/black_leather
	name = "时尚皮手套"
	desc = "由最优质皮革制成的柔软黑色皮手套。时尚、耐用，适合工作或娱乐。"
	icon_state = "black_leather"
	item_state = "black"

/obj/item/clothing/gloves/boxing
	name = "拳击手套"
	desc = "因为你确实需要另一个借口来揍你的船员。"
	icon_state = "boxing"
	item_state = "boxing"
	force = 0//don't actually deal damage
	attack_verb = list("boxes","punches","jabs","strikes","uppercuts", "fisticuffs", "bashes")
	var/pain_dam = 20
	var/box_sound = list('sound/weapons/punch1.ogg')//placeholder
	var/knockout_sound = 'sound/effects/knockout.ogg'


/obj/item/clothing/gloves/boxing/Touch(atom/A, proximity)
	var/mob/living/M = loc
	var/painforce = pain_dam
	var/boxing_verb = pick(attack_verb)
	if (A in range(1, M))
		if(isliving(A) && M.a_intent == INTENT_HARM)
			if(isyautja(A) || isxeno(A))
				return 0
			if (ishuman(A))
				var/mob/living/carbon/human/L = A
				var/boxing_icon = pick("boxing_up","boxing_down","boxing_left","boxing_right")
				if (!istype(L.gloves, /obj/item/clothing/gloves/boxing))
					to_chat(M, SPAN_WARNING("你不能和[A]拳击，他们没戴拳击手套！"))
					return 1
				if (L.halloss > 100)
					playsound(loc, knockout_sound, 50, FALSE)
					M.show_message(FONT_SIZE_LARGE(SPAN_WARNING("KNOCKOUT!")), SHOW_MESSAGE_VISIBLE)
					return 1
				if (L.body_position == LYING_DOWN || L.stat == UNCONSCIOUS)//Can't beat 'em while they're down.
					to_chat(M, SPAN_WARNING("你不能和[A]拳击，他们已经倒下了！"))
					return 1
				M.visible_message(SPAN_DANGER("[M] [boxing_verb] [A]!"))
				L.apply_effect(painforce, AGONY)
				M.animation_attack_on(L)
				M.flick_attack_overlay(L, boxing_icon)
				playsound(loc, pick(box_sound), 25, 1)
				return 1

/obj/item/clothing/gloves/boxing/attackby(obj/item/W, mob/user)
	if(HAS_TRAIT(W, TRAIT_TOOL_WIRECUTTERS) || W.sharp == IS_SHARP_ITEM_ACCURATE || W.sharp == IS_SHARP_ITEM_BIG)
		to_chat(user, SPAN_NOTICE("割开这副上好的拳击手套将是极大的耻辱。")) //Nope
		return
	..()

/obj/item/clothing/gloves/boxing/green
	icon_state = "boxinggreen"
	item_state = "boxinggreen"

/obj/item/clothing/gloves/boxing/blue
	icon_state = "boxingblue"
	item_state = "boxingblue"

/obj/item/clothing/gloves/boxing/yellow
	icon_state = "boxingyellow"
	item_state = "boxingyellow"

/obj/item/clothing/gloves/white
	name = "白手套"
	desc = "这些看起来相当精致。"
	icon_state = "white"
	item_state = "white"
