/mob/living/simple_animal/small/mouse/rat
	name = "rat"
	real_name = "rat"
	desc = "这是一只体型庞大、携带疾病的啮齿动物。"
	icon_state = "rat_gray"
	icon_living = "rat_gray"
	icon_dead = "rat_gray_dead"
	maxHealth = 10
	health = 10
	holder_type = /obj/item/holder/rat
	icon_base = "rat"

/*
 * Rat types
 */

/mob/living/simple_animal/small/mouse/rat/gray
	body_color = "gray"
	icon_state = "rat_gray"
	holder_type = /obj/item/holder/rat/gray

/mob/living/simple_animal/small/mouse/rat/brown
	body_color = "brown"
	icon_state = "rat_brown"
	holder_type = /obj/item/holder/rat/brown

/mob/living/simple_animal/small/mouse/rat/brown/Old_Timmy
	name = "老提米"
	desc = "一只从殖民地旧时代遗留下来的、看起来年迈的老鼠。"
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "splats"
	holder_type = /obj/item/holder/rat/brown/Old_Timmy

/mob/living/simple_animal/small/mouse/rat/black
	body_color = "black"
	icon_state = "rat_black"
	holder_type = /obj/item/holder/rat/black

/mob/living/simple_animal/small/mouse/rat/white
	body_color = "white"
	icon_state = "rat_white"
	desc = "这是一只实验室大鼠。"
	holder_type = /obj/item/holder/rat/white

/mob/living/simple_animal/small/mouse/rat/white/Milky
	name = "米尔基"
	desc = "一只从维兰德-汤谷研究设施逃出的实验鼠。希望它没有携带什么基因工程疾病之类的……"
	gender = MALE
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "stamps on"
	holder_type = /obj/item/holder/rat/white/Milky


//Specific Pets for Frozen's Rat Collecting Competition

/mob/living/simple_animal/small/mouse/rat/pet
	name = "宠物鼠"
	desc = "这是某人的宠物鼠。我想知道它为什么会在这里。"
	holder_type = /obj/item/holder/rat/pet

/mob/living/simple_animal/small/mouse/rat/pet/marvin
	name = "马文"
	desc = "一只毛发光亮、保养良好的老鼠，脖子上戴着一个小项圈，它一定有主人。作为啮齿动物，它看起来异常干净卫生。"
	body_color = "black"
	icon_state = "rat_black"
	holder_type = /obj/item/holder/rat/pet/marvin

/mob/living/simple_animal/small/mouse/rat/pet/ikit
	name = "伊基特"
	desc = "一只白化病大鼠，脖子上戴着一个小项圈，它一定有主人。希望它没有什么基因工程疾病之类的……"
	body_color = "white"
	icon_state = "rat_white"
	holder_type = /obj/item/holder/rat/pet/ikit


//Spawning those rats from cheese.

/obj/item/reagent_container/food/snacks/cheesewedge/attack_self(mob/user)
	if(user.mob_flags & HAS_SPAWNED_PET)
		return ..()
	if(GLOB.community_awards[user.ckey])
		for(var/award in GLOB.community_awards[user.ckey])
			if(award == "RatKing")
				return spawn_pet_rat(user)
	..()

/obj/item/reagent_container/food/snacks/cheesewedge/proc/spawn_pet_rat(mob/user)
	if(user.mob_flags & HAS_SPAWNED_PET)
		return FALSE
	if(tgui_alert(user, "是否要生成你的宠物鼠？", "Spawn Pet", list("Yes", "No")) != "Yes")
		return FALSE

	var/list/pet_rats = file2list("config/pet_rats.txt")
	var/rat_path
	for(var/rat_owner in pet_rats)
		if(!length(rat_owner))
			return FALSE
		if(copytext(rat_owner,1,2) == "#")
			continue

		//Split the line at every "-"
		var/list/split_rat_owner = splittext(rat_owner, " - ")
		if(!length(split_rat_owner))
			return FALSE

		//ckey is before the first "-"
		var/ckey = ckey(split_rat_owner[1])
		if(!ckey || (ckey != user.ckey))
			continue

		if(length(split_rat_owner) >= 2)
			rat_path = split_rat_owner[2]
			break

	if(!rat_path)
		return FALSE

	new rat_path(user.loc)
	user.mob_flags |= HAS_SPAWNED_PET
