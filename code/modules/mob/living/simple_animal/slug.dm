/mob/living/simple_animal/small/alien_slug
	name = "奇怪的蛞蝓"
	desc = "一种长相怪异、长着小肢体的蛞蝓状生物。"
	icon = 'icons/mob/animal.dmi'
	icon_state = "slug_movement"
	icon_living = "slug_movement"
	icon_dead = "slug_dead"
	speak = list("Blurb.","Blub.","BLURP!")
	speak_emote = list("blurps")
	emote_hear = list("blurps.")
	emote_see = list("扭动。")
	attacktext = "bites"
	response_help  = "pets"
	response_disarm = "shoos"
	response_harm   = "stomps on"
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	maxHealth = 5
	health = 5
	universal_speak = 0
	universal_understand = 1

/mob/living/simple_animal/small/alien_slug/Life(delta_time)
	. = ..()
	if(!ckey && stat == CONSCIOUS && prob(0.5))
		set_stat(UNCONSCIOUS)
		icon_state = "slug_resting"
		wander = 0
		speak_chance = 0
	else if(ckey || (stat == UNCONSCIOUS && prob(1)))
		set_stat(CONSCIOUS)
		icon_state = "slug_movement"
		wander = 1

/mob/living/simple_animal/small/alien_slug/Initialize()
	. = ..()
	add_verb(src, list(
		/mob/living/proc/ventcrawl,
		/mob/living/proc/hide,
	))

/mob/living/simple_animal/small/alien_slug/start_pulling(atom/movable/AM)//Prevents it from pulling things
	to_chat(src, SPAN_WARNING("你太小了，拉不动任何东西。"))
	return
