/obj/item/reagent_container/food/snacks/fishable
	name = "\improper fishable snack"
	desc = "它来自深渊。你也将归于深渊。海洋之母吞噬一切。"
	icon = 'icons/obj/items/fishing_atoms.dmi'
	icon_state = null
	bitesize = 4
	trash = null
	var/min_length = 1
	var/max_length = 5
	var/total_length = ""
	var/guttable = TRUE
	var/gutted = FALSE
	var/gut_icon_state = null
	var/initial_desc = ""
	var/list/guttable_atoms = list(/obj/item/reagent_container/food/snacks/meat, /obj/item/reagent_container/food/snacks/meat/synthmeat)//placeholders, for now
	var/base_gut_meat = /obj/item/reagent_container/food/snacks/meat
	//slice_path = null//
	//slices_num
	//package = 0//did someone say shell critters?

/obj/item/reagent_container/food/snacks/fishable/Initialize()
	. = ..()
	total_length = rand(min_length, max_length)//used for fish fact at the round end
	initial_desc = initial(desc)
	gut_icon_state = icon_state + "_gutted"
	update_desc()


/obj/item/reagent_container/food/snacks/fishable/proc/update_desc()
	var/gut_desc
	if(guttable)
		desc = initial_desc + "\n\nIt can still be gutted and cleaned."
	if(gutted)
		desc = initial_desc + "\n\nIt has already been gutted!"
	if(!guttable)
		desc = initial_desc + "\n\nIt cannot be gutted."
	gut_desc = desc

	desc = gut_desc + "\n\nIt is [total_length]in."
	return

/obj/item/reagent_container/food/snacks/fishable/update_icon()
	if(gutted && (gut_icon_state != null))
		icon_state = gut_icon_state
		return
	return

/obj/item/reagent_container/food/snacks/fishable/attackby(obj/item/W, mob/user)
	if(gutted)
		to_chat(user, SPAN_WARNING("[src]已经被开膛破肚了！"))
		return
	if(!guttable)
		to_chat(user, SPAN_WARNING("[src]无法被开膛破肚。"))
		return
	if(W.sharp == IS_SHARP_ITEM_ACCURATE || W.sharp == IS_SHARP_ITEM_BIG)
		user.visible_message("[user]切开并清理了[src]。", "You gut [src].")
		playsound(loc, 'sound/effects/blobattack.ogg', 25, 1)
		var/gut_loot = roll(total_length / 2 - min_length)
		if(gut_loot <= 0)
			gut_loot = 1

		gibs(user.loc)
		new base_gut_meat(get_turf(user)) //always spawn at least one meat per gut
		playsound(loc, 'sound/effects/splat.ogg', 25, 1)//replace
		gutted = TRUE
		update_desc()
		update_icon()
		for(var/i in 1 to gut_loot)
			var/atom_type = pick(guttable_atoms)
			new atom_type(get_turf(user))

/obj/item/reagent_container/food/snacks/fishable/crab
	name = "\improper spindle crab"
	desc = "看起来像只小螃蟹。"
	icon_state = "crab"
	gut_icon_state = "crab_gutted"
	guttable = TRUE
	min_length = 4
	max_length = 8
	base_gut_meat = /obj/item/reagent_container/food/snacks/meat/fish/crab
	guttable_atoms = list(/obj/item/reagent_container/food/snacks/meat/fish/crab)
	bitesize = 6
	trash = null//todo, crab shell

/obj/item/reagent_container/food/snacks/fishable/crab/Initialize()
	. = ..()
	reagents.add_reagent("fish", 5)
	bitesize = 3

//----------------//
//SQUIDS
/obj/item/reagent_container/food/snacks/fishable/squid
	name = "普通鱿鱼"
	desc = "它们有喙。"
	icon_state = "squid"
	bitesize = 8

/obj/item/reagent_container/food/snacks/fishable/squid/whorl
	name = "涡旋鱿鱼"
	desc = "一个矮胖的小家伙，外壳呈涡旋状，因此得名。"
	icon_state = "squid_whorl"
	gut_icon_state = "squid_whorl_gutted"
	guttable = TRUE
	min_length = 4
	max_length = 14
	base_gut_meat = /obj/item/reagent_container/food/snacks/meat/fish/squid
	guttable_atoms = list(/obj/item/reagent_container/food/snacks/meat/fish/squid)
	bitesize = 1

/obj/item/reagent_container/food/snacks/fishable/squid/whorl/Initialize()
	. = ..()
	reagents.add_reagent("fish", 1)

/obj/item/reagent_container/food/snacks/fishable/squid/sock
	name = "短袜鱿鱼"
	desc = "带壳的小鱿鱼在新瓦拉德罗很常见。虽然用‘鱿鱼’这个词来描述这种生物会让生物学家暴跳如雷，但鉴于它们的外形相似，这个名字已经流传开来。短袜鱿鱼以其浓郁的口感而闻名。"
	icon_state = "squid_sock"
	gut_icon_state = "squid_sock_gutted"
	guttable = TRUE
	min_length = 1
	max_length = 5
	base_gut_meat = /obj/item/reagent_container/food/snacks/meat/fish/squid/alt
	guttable_atoms = list(/obj/item/reagent_container/food/snacks/meat/fish/squid/alt)
	bitesize = 1

/obj/item/reagent_container/food/snacks/fishable/squid/sock/Initialize()
	. = ..()
	reagents.add_reagent("fish", 1)


//----------------//
//WORMS
/obj/item/reagent_container/food/snacks/fishable/worm
	name = "海虫"
	desc = "也许能当鱼饵用？"
	icon_state = "worm_redring"
	guttable = TRUE
	gut_icon_state = "worm_redring_gutted"
	base_gut_meat = /obj/item/fish_bait
	bitesize = 1

/obj/item/reagent_container/food/snacks/fishable/worm/Initialize()
	. = ..()
	reagents.add_reagent("enzyme", 1)

	//todo, attackby with a knife so you can make bait objects for fishing with
/obj/item/reagent_container/food/snacks/fishable/quadtopus
	name = "quadtopus"
	desc = "像章鱼，但更凶、更笨、更小。基本上就是个海军陆战队员。"
	icon_state = "quadtopus"
	bitesize = 2
//--------------------//
// SHELLED CRITTERS, you have to pry them open with a SHARP object to get the guts out. Maybe should be bool hasshell = TRUE and overrite gutting proc?
/obj/item/reagent_container/food/snacks/fishable/shell/clam
	name = "clam"
	desc = "一个藏在壳里的海洋生物。"
	icon_state = "shell_clam"
	guttable = TRUE
	base_gut_meat = /obj/item/ore/pearl
	bitesize = 1

/obj/item/reagent_container/food/snacks/fishable/shell/clam/Initialize()
	. = ..()
	reagents.add_reagent("fish", 1)


//--------------------//
// Pan Fish, Regular fish you can gut and clean (additional fish past this point)
/obj/item/reagent_container/food/snacks/fishable/fish/bluegill
	name = "bluegill"
	desc = "一条带刺的小鱼，哎哟！"
	gut_icon_state = "bluegill_gutted"
	guttable = TRUE
	min_length = 5
	max_length = 16
	base_gut_meat = /obj/item/reagent_container/food/snacks/meat/fish/bluegill
	guttable_atoms = list(/obj/item/reagent_container/food/snacks/meat/fish/bluegill)
	icon_state = "bluegill"
	bitesize = 3

/obj/item/reagent_container/food/snacks/fishable/fish/bluegill/Initialize()
	. = ..()
	reagents.add_reagent("fish", 4)


/obj/item/reagent_container/food/snacks/fishable/fish/bass
	name = "bass"
	desc = "鱼类菜肴中的经典主食！"
	guttable = TRUE
	base_gut_meat = /obj/item/reagent_container/food/snacks/meat/fish/bass
	guttable_atoms = list(/obj/item/reagent_container/food/snacks/meat/fish/bass)
	icon_state = "bass"
	gut_icon_state = "bass_gutted"
	min_length = 8
	max_length = 32
	bitesize = 6

/obj/item/reagent_container/food/snacks/fishable/fish/bass/Initialize()
	. = ..()
	reagents.add_reagent("fish", 4)


/obj/item/reagent_container/food/snacks/fishable/fish/catfish
	name = "catfish"
	desc = "体型相当大，但由于是底栖食腐鱼，不适合食用。"
	guttable = FALSE
	icon_state = "catfish"
	min_length = 10
	max_length = 108
	bitesize = 6

/obj/item/reagent_container/food/snacks/fishable/fish/catfish/Initialize()
	. = ..()
	reagents.add_reagent("fish", 4)


/obj/item/reagent_container/food/snacks/fishable/fish/salmon

	name = "salmon"
	desc = "一种红色带鳞的河鱼！"
	guttable = TRUE
	icon_state = "salmon"
	min_length = 12
	max_length = 44
	gut_icon_state = "salmon_gutted"
	bitesize = 5
	base_gut_meat = /obj/item/reagent_container/food/snacks/meat/fish/salmon
	guttable_atoms = list(/obj/item/reagent_container/food/snacks/meat/fish/salmon)

/obj/item/reagent_container/food/snacks/fishable/fish/salmon/Initialize()
	. = ..()
	reagents.add_reagent("fish", 4)

/obj/item/reagent_container/food/snacks/fishable/fish/white_perch

	name = "白鲈"
	desc = "一种带刺的小型入侵鱼类，干掉它！"
	guttable = TRUE
	icon_state = "white_perch"
	min_length = 6
	max_length = 22
	gut_icon_state = "white_perch_gutted"
	bitesize = 5
	base_gut_meat = /obj/item/reagent_container/food/snacks/meat/fish/white_perch
	guttable_atoms = list(/obj/item/reagent_container/food/snacks/meat/fish/white_perch)

/obj/item/reagent_container/food/snacks/fishable/fish/white_perch/Initialize()
	. = ..()
	reagents.add_reagent("fish", 4)

//--------------------//
//Urchins, spikey bottom-feeding creatures
/obj/item/reagent_container/food/snacks/fishable/urchin/purple
	name = "紫海胆"
	desc = "幸好我没踩到它！"
	icon_state = "urchin_purple"
	guttable = FALSE
	min_length = 2
	max_length = 9
	bitesize = 1

/obj/item/reagent_container/food/snacks/fishable/urchin/purple/Initialize()
	. = ..()
	reagents.add_reagent("fish", 1)

/obj/item/reagent_container/food/snacks/fishable/urchin/red
	name = "红海胆"
	desc = "幸好我没踩到它，它看起来怒气冲冲！"
	guttable = FALSE
	icon_state = "urchin_red"
	min_length = 2
	max_length = 9
	bitesize = 1

/obj/item/reagent_container/food/snacks/fishable/urchin/red/Initialize()
	. = ..()
	reagents.add_reagent("fish", 1)

//finished code on worm and clam fish and items, added 3 new fish types (catfish being non-guttable is on purpose), worm now drops bait when gutted
