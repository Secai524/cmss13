//Look Sir, free crabs!
/mob/living/simple_animal/small/crab
	name = "crab"
	desc = "一种硬壳甲壳类动物。似乎很满足于整天闲躺着。"
	icon_state = "crab"
	icon_living = "crab"
	icon_dead = "crab_dead"
	mob_size = MOB_SIZE_SMALL
	speak_emote = list("clicks")
	emote_hear = list("clicks.")
	emote_see = list("发出咔哒声。")
	speak_chance = 1
	turns_per_move = 5
	meat_type = /obj/item/reagent_container/food/snacks/meat
	response_help  = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm   = "stomps the"
	stop_automated_movement = 1
	friendly = "pinches"
	black_market_value = 50
	dead_black_market_value = 0
	var/obj/item/inventory_head
	var/obj/item/inventory_mask

/mob/living/simple_animal/small/crab/Life(delta_time)
	..()
	//CRAB movement
	if(!ckey && !stat)
		if(isturf(src.loc) && !resting && !buckled) //This is so it only moves if it's not inside a closet, gentics machine, etc.
			turns_since_move++
			if(turns_since_move >= turns_per_move)
				Move(get_step(src,pick(4,8)))
				turns_since_move = 0
	regenerate_icons()

//COFFEE! SQUEEEEEEEEE!
/mob/living/simple_animal/small/crab/Coffee
	name = "咖啡"
	real_name = "咖啡"
	desc = "这是咖啡，另一只宠物！"
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "stomps"
