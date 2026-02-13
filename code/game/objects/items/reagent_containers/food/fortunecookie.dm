//The fortune

/obj/item/paper/fortune
	name = "fortune"
	icon_state = "fortune"

/obj/item/paper/fortune/premade

/obj/item/paper/fortune/premade/proc/assign_fortunes()
	var/list/fortunelist = file2list("strings/fortunes.txt")
	return(pick(fortunelist))

/obj/item/paper/fortune/premade/proc/get_lucky_numbers()
	var/num1 = rand(1,99)
	var/num2 = rand(1,99)
	var/num3 = rand(1,99)
	var/num4 = rand(1,99)
	var/num5 = rand(1,99)
	var/luckynumbers = "[num1], [num2], [num3], [num4], and [num5]"
	return luckynumbers

/obj/item/paper/fortune/premade/Initialize(mapload, message = "Random", numbers = "Random")
	. = ..()
	switch(message)
		if("无")
			message = null
		if("Random")
			message = assign_fortunes()
	if(numbers == "无")
		numbers = null
	else
		numbers = "Your lucky numbers are [numbers == "Random" ? get_lucky_numbers() : numbers]."
	if(message || numbers)
		info = "<p style=\"text-align: center;\"><span style=\"text-align: center; color: #0000ff;\"><b>[message]</b><br/>[numbers]</p></span>"
	else
		error("Fortune cookie code broke! Fortune does not smile upon you today.")

//The cookie

/obj/item/reagent_container/food/snacks/fortunecookie
	name = "幸运饼干"
	desc = "一个金棕色的幸运饼干。有人说里面的纸条甚至有预测未来的能力，管它是什么意思。"
	icon_state = "fortune_cookie"
	icon = 'icons/obj/items/food/mre_food/USCM.dmi'
	filling_color = "#E8E79E"
	//If the cookie has been broken open
	var/cookie_broken = FALSE
	//The fortune inside the cookie
	var/cookiefortune

/obj/item/reagent_container/food/snacks/fortunecookie/update_icon()
	. = ..()
	if(cookie_broken)
		icon_state = "fortune_cookie_open"
	else
		icon_state = "fortune_cookie"

/obj/item/reagent_container/food/snacks/fortunecookie/get_examine_text(mob/user)
	. = ..()
	if(cookie_broken)
		. += SPAN_WARNING("It's cracked open!")
	else
		if(cookiefortune)
			. += SPAN_NOTICE("It has a fortune inside it already.")
		else
			. += SPAN_NOTICE("它是空的。")

/obj/item/reagent_container/food/snacks/fortunecookie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 3)
	bitesize = 2

/obj/item/reagent_container/food/snacks/fortunecookie/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/paper))
		if(cookie_broken)
			to_chat(user,SPAN_WARNING("[src]被掰开了！你怎么把东西塞进去？"))
		else
			if(!cookiefortune)
				to_chat(user, SPAN_NOTICE("你将纸条塞进了[src]。"))
				cookiefortune = W
				user.drop_inv_item_to_loc(W, src)
			else
				to_chat(user,SPAN_WARNING("[src]里面已经有一张幸运签了！"))

//Break open the cookie first before eating it (with use)
/obj/item/reagent_container/food/snacks/fortunecookie/attack_self(mob/user)
	if(!cookie_broken)
		cookie_broken = TRUE
		playsound(user,'sound/effects/pillbottle.ogg',10,TRUE)
		name = "掰开的幸运饼干"
		update_icon()
		if(cookiefortune)
			to_chat(user,SPAN_NOTICE("你掰开幸运饼干，里面露出一张幸运签！"))
			user.put_in_hands(cookiefortune)
			cookiefortune = null
		else
			to_chat(user, SPAN_WARNING("你掰开幸运饼干，但里面没有幸运签！糟了！"))
	else
		. = ..()

//Override for clicking on yourself too
/obj/item/reagent_container/food/snacks/fortunecookie/attack(mob/M, mob/user)
	if(!cookie_broken)
		cookie_broken = TRUE
		playsound(user,'sound/effects/pillbottle.ogg',10,TRUE)
		name = "掰开的幸运饼干"
		update_icon()
		if(cookiefortune)
			to_chat(user,SPAN_NOTICE("你掰开幸运饼干，里面露出一张幸运签！"))
			user.put_in_hands(cookiefortune)
			cookiefortune = null
		else
			to_chat(user, SPAN_WARNING("你掰开幸运饼干，但里面没有幸运签！糟了！"))
	else
		. = ..()

/obj/item/reagent_container/food/snacks/fortunecookie/on_stored_atom_del(atom/movable/AM)
	if(AM == cookiefortune)
		cookiefortune = null

/obj/item/reagent_container/food/snacks/fortunecookie/prefilled/Initialize(mapload, fortune, numbers)
	. = ..()
	cookiefortune = new /obj/item/paper/fortune/premade(src, fortune, numbers)
