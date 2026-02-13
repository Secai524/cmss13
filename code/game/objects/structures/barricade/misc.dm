/*----------------------*/
// SNOW
/*----------------------*/

/obj/structure/barricade/snow
	name = "雪地路障"
	desc = "一堆雪塑成的斜坡墙。作为掩体，统计上比空气强。"
	icon_state = "snow_0"
	barricade_type = "snow"
	health = 75 //Actual health depends on snow layer
	maxhealth = 75
	stack_type = /obj/item/stack/snow
	debris = list(/obj/item/stack/snow)
	stack_amount = 3
	destroyed_stack_amount = 0
	can_wire = FALSE
	metallic = FALSE

/obj/structure/barricade/snow/New(loc, mob/user, direction)
	if(direction)
		setDir(direction)
	..(loc, user)



//Item Attack
/obj/structure/barricade/snow/attackby(obj/item/W, mob/user)
	for(var/obj/effect/xenomorph/acid/A in src.loc)
		if(A.acid_t == src)
			to_chat(user, "你无法靠近，它正在融化！")
			return
	//Removing the barricades
	if(istype(W, /obj/item/tool/shovel) && user.a_intent != INTENT_HARM)
		var/obj/item/tool/shovel/ET = W
		if(ET.folded)
			return
		if(user.action_busy)
			to_chat(user, SPAN_WARNING("你已经在铲雪了！"))
			return
		user.visible_message("[user.name]开始清理\the [src]。","You start removing \the [src].")
		if(!do_after(user, ET.shovelspeed * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD, src))
			return
		if(!ET.folded)
			user.visible_message(SPAN_NOTICE("\The [user] removes \the [src]."))
			deconstruct(TRUE)
		return

	return ..()

/obj/structure/barricade/snow/hit_barricade(obj/item/I)
	switch(I.damtype)
		if("fire")
			take_damage( I.force * I.demolition_mod * 0.6 )
		if("brute")
			take_damage( I.force * I.demolition_mod * 0.3 )

	return


/*----------------------*/
// WOOD
/*----------------------*/

/obj/structure/barricade/wooden
	name = "木质路障"
	desc = "用钉在一起的木板制成的墙。不太坚固，但能提供一些隐蔽。"
	icon_state = "wooden"
	health = 100
	maxhealth = 100
	layer = OBJ_LAYER
	stack_type = /obj/item/stack/sheet/wood
	debris = list(/obj/item/stack/sheet/wood)
	stack_amount = 5
	destroyed_stack_amount = 3
	barricade_hitsound = 'sound/effects/woodhit.ogg'
	can_change_dmg_state = 0
	barricade_type = "wooden"
	can_wire = FALSE
	repair_materials = list("wood" = 1)
	metallic = FALSE

/obj/structure/barricade/wooden/attackby(obj/item/W as obj, mob/user as mob)
	for(var/obj/effect/xenomorph/acid/A in src.loc)
		if(A.acid_t == src)
			to_chat(user, "你无法靠近，它正在融化！")
			return
	if(istype(W, /obj/item/stack/sheet/wood))
		var/obj/item/stack/sheet/wood/D = W
		if(health < maxhealth)
			if(D.get_amount() < 1)
				to_chat(user, SPAN_WARNING("你需要一块木板来修复[src]。"))
				return
			visible_message(SPAN_NOTICE("[user]开始修复[src]。"))
			if(do_after(user, 2 SECONDS, INTERRUPT_ALL, BUSY_ICON_FRIENDLY, src) && health < maxhealth)
				if (D.use(1))
					update_health(-0.5*maxhealth)
					update_damage_state()
					visible_message(SPAN_NOTICE("[user]笨拙地修复了[src]。"))
		return

	if(try_nailgun_usage(W, user))
		return

	return ..()

/obj/structure/barricade/wooden/hit_barricade(obj/item/I)
	switch(I.damtype)
		if("fire")
			take_damage( I.force * I.demolition_mod * 1.5 )
		if("brute")
			take_damage( I.force * I.demolition_mod * 0.75 )
