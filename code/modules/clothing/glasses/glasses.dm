/obj/item/clothing/glasses
	name = "glasses"
	gender = PLURAL
	icon = 'icons/obj/items/clothing/glasses/glasses.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/glasses_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/glasses_righthand.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/glasses.dmi',
	)
	w_class = SIZE_SMALL
	var/vision_flags = 0
	var/darkness_view = 0 //Base human is 2
	/// The amount of nightvision these glasses have. This should be a number between 0 and 1.
	var/lighting_alpha = LIGHTING_PLANE_ALPHA_VISIBLE
	var/invisa_view = FALSE
	var/prescription = FALSE
	var/toggleable = FALSE
	var/toggle_on_sound = 'sound/machines/click.ogg'
	var/toggle_off_sound = 'sound/machines/click.ogg'
	var/active = TRUE
	flags_inventory = COVEREYES
	flags_equip_slot = SLOT_EYES
	flags_armor_protection = BODY_FLAG_EYES
	var/deactive_state
	var/has_tint = FALSE //whether it blocks vision like a welding helmet
	var/fullscreen_vision
	var/req_skill
	var/req_skill_level
	var/req_skill_explicit = FALSE
	var/hud_type //hud type the glasses gives

/obj/item/clothing/glasses/Initialize(mapload, ...)
	. = ..()
	if(prescription)
		AddElement(/datum/element/poor_eyesight_correction)

/obj/item/clothing/glasses/update_clothing_icon()
	if(ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_glasses()

/obj/item/clothing/glasses/update_icon()
	if(!deactive_state || active)
		icon_state = initial(icon_state)
	else
		icon_state = deactive_state
	..()

/obj/item/clothing/glasses/proc/can_use_active_effect(mob/living/carbon/human/user)
	if(req_skill && req_skill_level && !(!req_skill_explicit && skillcheck(user, req_skill, req_skill_level)) && !(req_skill_explicit && skillcheckexplicit(user, req_skill, req_skill_level)))
		return FALSE
	else
		return TRUE

/obj/item/clothing/glasses/proc/toggle_glasses_effect()
	active = !active
	clothing_traits_active = !clothing_traits_active
	update_icon()
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		if(H.glasses == src)
			if(has_tint)
				H.update_tint()
			H.update_sight()
			H.update_glass_vision(src)
			update_clothing_icon()

			if(hud_type)
				var/datum/mob_hud/MH = GLOB.huds[hud_type]
				if(active)
					MH.add_hud_to(H, src)
					playsound(H, 'sound/handling/hud_on.ogg', 25, 1)
				else
					MH.remove_hud_from(H, src)
					playsound(H, 'sound/handling/hud_off.ogg', 25, 1)
			if(active) //turning it on? then add the traits
				for(var/trait in clothing_traits)
					ADD_TRAIT(H, trait, TRAIT_SOURCE_EQUIPMENT(flags_equip_slot))
			else //turning it off - take away its traits
				for(var/trait in clothing_traits)
					REMOVE_TRAIT(H, trait, TRAIT_SOURCE_EQUIPMENT(flags_equip_slot))

	for(var/X in actions)
		var/datum/action/A = X
		if(istype(A, /datum/action/item_action/toggle))
			A.update_button_icon()

/obj/item/clothing/glasses/proc/try_make_offhand_prescription(mob/user)
	if(!prescription)
		return FALSE

	var/obj/item/clothing/glasses/offhand = user.get_inactive_hand()
	if(istype(offhand) && !offhand.prescription)
		if(tgui_alert(user, "你希望取出处方镜片并放入[offhand]吗？", "Insert Prescription Lenses", list("Yes", "No")) == "Yes")
			if(QDELETED(src) || offhand != user.get_inactive_hand())
				return FALSE
			offhand.prescription = TRUE
			offhand.AddElement(/datum/element/poor_eyesight_correction)
			offhand.desc += " Fitted with prescription lenses."
			user.visible_message(SPAN_DANGER("[user]从[src]中取出镜片并放入[offhand]。"), SPAN_NOTICE("You take the lenses out of [src] and put them in [offhand]."))
			qdel(src)
			return TRUE

	return FALSE

/obj/item/clothing/glasses/sunglasses/prescription/attack_self(mob/user)
	if(try_make_offhand_prescription(user))
		return

	return ..()

/obj/item/clothing/glasses/regular/attack_self(mob/user)
	if(try_make_offhand_prescription(user))
		return

	return ..()

/obj/item/clothing/glasses/equipped(mob/user, slot)
	if(active && slot == WEAR_EYES)
		if(!can_use_active_effect(user))
			toggle_glasses_effect()
			to_chat(user, SPAN_WARNING("你完全不明白这些数据的含义，在它让你感到恶心之前将其关闭。"))

		else if(hud_type)
			var/datum/mob_hud/MH = GLOB.huds[hud_type]
			MH.add_hud_to(user, src)
	user.update_sight()
	..()

/obj/item/clothing/glasses/dropped(mob/living/carbon/human/user)
	if(istype(user) && src == user.glasses)
		if(hud_type && active)
			var/datum/mob_hud/H = GLOB.huds[hud_type]
			H.remove_hud_from(user, src)
		user.glasses = null
		user.update_inv_glasses()
		user.update_glass_vision(src)
	user.update_sight()
	return ..()

/obj/item/clothing/glasses/attack_self(mob/user)
	..()

	if(!toggleable)
		return
	if(!can_use_active_effect(user))
		to_chat(user, SPAN_WARNING("你不知道如何使用[src]。"))
		return

	if(active)
		to_chat(user, SPAN_NOTICE("你关闭了[src]上的光学矩阵。"))
		playsound_client(user.client, toggle_off_sound, null, 75)
	else
		to_chat(user, SPAN_NOTICE("你激活了[src]的光学矩阵。"))
		playsound_client(user.client, toggle_on_sound, null, 75)

	toggle_glasses_effect()

/obj/item/clothing/glasses/science
	name = "试剂扫描器HUD护目镜" //science goggles
	desc = "这护目镜可能对某个没拿着步枪、也不想主动降低自己战斗寿命的人有用。"
	icon = 'icons/obj/items/clothing/glasses/huds.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/huds.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/glasses_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/glasses_righthand.dmi',
	)
	icon_state = "purple"
	item_state = "glasses"
	deactive_state = "purple_off"
	actions_types = list(/datum/action/item_action/toggle/hudgoggles)
	toggleable = TRUE
	flags_inventory = COVEREYES
	req_skill = SKILL_RESEARCH
	req_skill_level = SKILL_RESEARCH_TRAINED
	clothing_traits = list(TRAIT_REAGENT_SCANNER)
	matter = list("glass" = 500,"plastic" = 500)

/obj/item/clothing/glasses/science/prescription
	name = "处方试剂扫描器HUD护目镜"
	desc = "这护目镜可能对某个没拿着步枪、也不想主动降低自己战斗寿命的人有用。内含处方镜片。"
	prescription = TRUE

/obj/item/clothing/glasses/science/get_examine_text(mob/user)
	. = ..()
	. += SPAN_INFO("While wearing them, you can examine items to see their reagent contents.")

/obj/item/clothing/glasses/kutjevo
	name = "库特耶沃护目镜"
	desc = "用于保护库特耶沃工人眼睛的护目镜。N95Z级防护。"
	icon = 'icons/obj/items/clothing/glasses/goggles.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/goggles.dmi',
	)
	icon_state = "kutjevo_goggles"
	item_state = "kutjevo_goggles"

/obj/item/clothing/glasses/kutjevo/safety
	name = "安全护目镜"
	desc = "用于保护工人眼睛的护目镜。N95Z级防护。"

/obj/item/clothing/glasses/eyepatch
	name = "eyepatch"
	gender = NEUTER
	desc = "曾由旧时的冒险家佩戴，如今更常与一位传奇人物联系在一起。据说他块头大，还是个老大。厉害吧？别让宪兵看到你穿这身不合规的装束。"
	icon = 'icons/obj/items/clothing/glasses/misc.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/misc.dmi',
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/glasses/misc.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/glasses.dmi',
	)
	icon_state = "eyepatch"
	item_state = "eyepatch"
	flags_armor_protection = 0
	flags_equip_slot = SLOT_EYES|SLOT_FACE
	flags_obj = OBJ_IS_HELMET_GARB
	var/toggled = FALSE
	var/original_state = "eyepatch"
	var/toggled_state = "eyepatch_left"
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/glasses/eyepatch/ui_action_click()
	toggle_state()

/obj/item/clothing/glasses/eyepatch/verb/toggle_state()
	set name = "Toggle Eyepatch State"
	set category = "Object"
	set src in usr
	if(usr.stat == DEAD)
		return

	toggled = !toggled
	if(toggled)
		icon_state = toggled_state
		item_state = toggled_state
		to_chat(usr, SPAN_NOTICE("你将眼罩翻到左侧。"))
	else
		icon_state = original_state
		item_state = original_state
		to_chat(usr, SPAN_NOTICE("你将眼罩翻到右侧。"))

	update_clothing_icon(src) // Updates the on-mob appearance

/obj/item/clothing/glasses/eyepatch/left
	parent_type = /obj/item/clothing/glasses/eyepatch
	icon_state = "eyepatch_left"
	item_state = "eyepatch_left"
	original_state = "eyepatch"
	toggled_state = "eyepatch_left"

/obj/item/clothing/glasses/eyepatch/white
	icon_state = "eyepatch_white"
	item_state = "eyepatch_white"
	original_state = "eyepatch_white"
	toggled_state = "eyepatch_white_left"

/obj/item/clothing/glasses/eyepatch/white/left
	parent_type = /obj/item/clothing/glasses/eyepatch/white
	icon_state = "eyepatch_white_left"
	item_state = "eyepatch_white_left"

/obj/item/clothing/glasses/eyepatch/green
	icon_state = "eyepatch_green"
	item_state = "eyepatch_green"
	original_state = "eyepatch_green"
	toggled_state = "eyepatch_green_left"

/obj/item/clothing/glasses/eyepatch/green/left
	parent_type = /obj/item/clothing/glasses/eyepatch/green
	icon_state = "eyepatch_green_left"
	item_state = "eyepatch_green_left"

/obj/item/clothing/glasses/monocle
	name = "monocle"
	gender = NEUTER
	desc = "多么时髦的眼罩！"
	icon = 'icons/obj/items/clothing/glasses/misc.dmi'
	icon_state = "monocle"
	item_state = "headset" // lol
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/misc.dmi',
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/glasses/misc.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/devices_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/devices_righthand.dmi',
	)
	flags_armor_protection = 0
	flags_equip_slot = SLOT_EYES|SLOT_FACE

/obj/item/clothing/glasses/material
	name = "光学材料扫描器"
	desc = "戴上这个你就能看见物体……就像你用肉眼看到的一样。话说这玩意儿当初为啥要做出来？"
	icon = 'icons/obj/items/clothing/glasses/goggles.dmi'
	icon_state = "material"
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/goggles.dmi',
	)
	item_state = "glasses"
	actions_types = list(/datum/action/item_action/toggle)
	toggleable = TRUE

/obj/item/clothing/glasses/regular
	name = "陆战队员RPG眼镜"
	desc = "陆战队可能称它们为制式处方眼镜，但你知道它们是防无聊眼镜。"
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/glasses/glasses.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/glasses.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/glasses_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/glasses_righthand.dmi',
	)
	icon_state = "mBCG"
	item_state = "mBCG"
	prescription = TRUE
	flags_armor_protection = 0
	flags_equip_slot = SLOT_EYES|SLOT_FACE
	flags_obj = OBJ_IS_HELMET_GARB

/obj/item/clothing/glasses/regular/hipster
	name = "处方眼镜"
	desc = "无聊的眼镜，让你看起来聪明且可能值得信赖。"
	icon_state = "hipster_glasses"
	item_state = "hipster_glasses"
	flags_equip_slot = SLOT_EYES|SLOT_FACE

/obj/item/clothing/glasses/regular/hippie
	name = "圆形处方眼镜"
	desc = "圆框眼镜，让你看起来聪明且可能值得信赖。"
	icon_state = "hippie_glasses"
	item_state = "hippie_glasses"
	flags_equip_slot = SLOT_EYES|SLOT_FACE

/obj/item/clothing/glasses/threedglasses
	desc = "很久以前，人们用这种眼镜让屏幕图像呈现三维效果。"
	name = "3D眼镜"
	icon_state = "3d"
	item_state = "3d"
	flags_armor_protection = 0
	flags_equip_slot = SLOT_EYES|SLOT_FACE

/obj/item/clothing/glasses/gglasses
	name = "绿色眼镜"
	desc = "森林绿色的眼镜，就像你在策划一个邪恶计划时会戴的那种。"
	icon_state = "gglasses"
	item_state = "gglasses"
	flags_armor_protection = 0
	flags_equip_slot = SLOT_EYES|SLOT_FACE

/obj/item/clothing/glasses/jensen
	name = "增强型太阳镜"
	desc = "移除了HUD的增强型太阳镜。"
	icon = 'icons/obj/items/clothing/glasses/misc.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/misc.dmi',
	)
	icon_state = "jensenshades"
	item_state = "jensenshades"
	flags_equip_slot = SLOT_EYES|SLOT_FACE

/obj/item/clothing/glasses/mbcg
	name = "陆战队员处方RPG眼镜"
	desc = "陆战队可能称其为制式处方眼镜，但你更愿意叫它们防呆眼镜。这副眼镜确实配备了合适的处方镜片。"
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/glasses/glasses.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/glasses.dmi',
	)
	icon_state = "mBCG"
	item_state = "mBCG"
	prescription = TRUE
	flags_equip_slot = SLOT_EYES|SLOT_FACE
	flags_obj = OBJ_IS_HELMET_GARB

/obj/item/clothing/glasses/m42_goggles
	name = "\improper M42 scout sight"
	desc = "M42侦察步枪的耳机与护目镜系统。可高亮显示周围环境影像。点击切换。"
	icon = 'icons/obj/items/clothing/glasses/night_vision.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/night_vision.dmi',
	)
	icon_state = "m56_goggles"
	gender = NEUTER
	deactive_state = "m56_goggles_0"
	vision_flags = SEE_TURFS
	toggleable = 1
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/glasses/disco_fever
	name = "故障的增强现实护目镜"
	desc = "有人试图在这副增强现实头戴设备上观看黑市的阿克图里安成人影片，现在它已经没用了。和你不同，迪斯科永不死。\n侧面贴着某种癫痫警告标签。"
	icon_state = "discovision"
	icon = 'icons/obj/items/clothing/glasses/misc.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/misc.dmi',
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/glasses/misc.dmi',
	)
	flags_equip_slot = SLOT_EYES|SLOT_FACE
	gender = NEUTER
	black_market_value = 25

	//These three vars are so that the flashing of the obj and onmob match what the wearer is seeing. They're actually vis_contents rather than overlays,
	//strictly speaking, since overlays can't be animate()-ed.
	var/list/onmob_colors
	var/obj/obj_glass_overlay
	var/obj/mob_glass_overlay

/obj/item/clothing/glasses/disco_fever/Initialize(mapload, ...)
	. = ..()

	obj_glass_overlay = new()
	obj_glass_overlay.vis_flags = VIS_INHERIT_ID|VIS_INHERIT_ICON
	obj_glass_overlay.icon_state = "discovision_glass"
	obj_glass_overlay.layer = FLOAT_LAYER
	vis_contents += obj_glass_overlay

	mob_glass_overlay = new()
	mob_glass_overlay.icon = 'icons/mob/humans/onmob/clothing/glasses/misc.dmi'
	mob_glass_overlay.vis_flags = VIS_INHERIT_ID|VIS_INHERIT_DIR
	mob_glass_overlay.icon_state = "discovision_glass"
	mob_glass_overlay.layer = FLOAT_LAYER

	//The overlays are painted in shades of pure red. These matrices convert them to various shades of the new color.
	onmob_colors = list(
		"base" = color_matrix_recolor_red("#5D5D5D"),
		"yellow" = color_matrix_recolor_red("#D4C218"),
		"green" = color_matrix_recolor_red("#0DB347"),
		"cyan" = color_matrix_recolor_red("#2AC1DB"),
		"blue" = color_matrix_recolor_red("#005BF7"),
		"indigo" = color_matrix_recolor_red("#9608D4"),
		)

	obj_glass_overlay.color = onmob_colors["base"]
	mob_glass_overlay.color = onmob_colors["base"]

/obj/item/clothing/glasses/disco_fever/equipped(mob/living/carbon/human/user, slot)
	. = ..()

	if(!ishuman(user) || slot != WEAR_EYES && slot != WEAR_FACE)
		return

	RegisterSignal(user, COMSIG_MOB_RECALCULATE_CLIENT_COLOR, PROC_REF(apply_discovision_handler))
	apply_discovision_handler(user)

	//Add the onmob overlay. Normal onmob images are handled by static overlays.
	//It's added to the head object so that glasses/mask overlays on the mob render above it, since vis_contents and overlays appear to use different layerings.
	var/obj/limb/head/user_head = user.get_limb("head")
	user_head?.vis_contents += mob_glass_overlay

///Ends existing animations in preparation for the funny. Looping animations don't seem to properly end if a new one is started on the same tick.
/obj/item/clothing/glasses/disco_fever/proc/apply_discovision_handler(mob/user)
	SIGNAL_HANDLER

	//User client has its looping animation ended by the login matrix update when ghosting.
	//For some reason the obj overlay doesn't end the loop properly when set to 0 seconds, but as long as the previous loop is ended the new one should
	//transition smoothly from whatever color it current has.
	animate(obj_glass_overlay, color = onmob_colors["base"], time = 0.3 SECONDS)
	animate(mob_glass_overlay, color = onmob_colors["base"], time = 0.3 SECONDS)

	addtimer(CALLBACK(src, PROC_REF(apply_discovision), user), 0.1 SECONDS)

///Handles disco-vision. Normal client color matrix handling isn't set up for a continuous animation like this, so this is applied afterwards.
/obj/item/clothing/glasses/disco_fever/proc/apply_discovision(mob/user)
	//Caramelldansen HUD overlay.
	//Use of this filter in armed conflict is in direct contravention of the Geneva Suggestions (2120 revision)
	//Colors are based on a bit of the music video. Original version was a rainbow with #c20000 and #db6c03 as well.

	//Animate the obj and onmob in sync with the client.
	for(var/I in list(obj_glass_overlay, mob_glass_overlay))
		animate(I, color = onmob_colors["indigo"], time = 0.3 SECONDS, loop = -1)
		animate(color = onmob_colors["base"], time = 0.3 SECONDS)
		animate(color = onmob_colors["cyan"], time = 0.3 SECONDS)
		animate(color = onmob_colors["base"], time = 0.3 SECONDS)
		animate(color = onmob_colors["yellow"], time = 0.3 SECONDS)
		animate(color = onmob_colors["base"], time = 0.3 SECONDS)
		animate(color = onmob_colors["green"], time = 0.3 SECONDS)
		animate(color = onmob_colors["base"], time = 0.3 SECONDS)
		animate(color = onmob_colors["blue"], time = 0.3 SECONDS)
		animate(color = onmob_colors["base"], time = 0.3 SECONDS)
		animate(color = onmob_colors["yellow"], time = 0.3 SECONDS)
		animate(color = onmob_colors["base"], time = 0.3 SECONDS)

	if(!user.client) //Shouldn't happen but can't hurt to check.
		return

	if(!user.client.prefs?.allow_flashing_lights_pref)
		to_chat(user, SPAN_NOTICE("您的偏好设置不允许[src]的效果。"))
		return

	var/base_colors
	if(!user.client.color) //No set client color.
		base_colors = color_matrix_saturation(1.35) //Crank up the saturation and get ready to party.
	else if(istext(user.client.color)) //Hex color string.
		base_colors = color_matrix_multiply(color_matrix_from_string(user.client.color), color_matrix_saturation(1.35))
	else //Color matrix.
		base_colors = color_matrix_multiply(user.client.color, color_matrix_saturation(1.35))

	var/list/colours = list(
		"yellow" = color_matrix_multiply(base_colors, color_matrix_from_string("#d4c218")),
		"green" = color_matrix_multiply(base_colors, color_matrix_from_string("#2dc404")),
		"cyan" = color_matrix_multiply(base_colors, color_matrix_from_string("#2ac1db")),
		"blue" = color_matrix_multiply(base_colors, color_matrix_from_string("#005BF7")),
		"indigo" = color_matrix_multiply(base_colors, color_matrix_from_string("#b929f7"))
		)

	//Animate the victim's client.
	animate(user.client, color = colours["indigo"], time = 0.3 SECONDS, loop = -1)
	animate(color = base_colors, time = 0.3 SECONDS)
	animate(color = colours["cyan"], time = 0.3 SECONDS)
	animate(color = base_colors, time = 0.3 SECONDS)
	animate(color = colours["yellow"], time = 0.3 SECONDS)
	animate(color = base_colors, time = 0.3 SECONDS)
	animate(color = colours["green"], time = 0.3 SECONDS)
	animate(color = base_colors, time = 0.3 SECONDS)
	animate(color = colours["blue"], time = 0.3 SECONDS)
	animate(color = base_colors, time = 0.3 SECONDS)
	animate(color = colours["yellow"], time = 0.3 SECONDS)
	animate(color = base_colors, time = 0.3 SECONDS)

/obj/item/clothing/glasses/disco_fever/dropped(mob/living/carbon/human/user)
	. = ..()

	if(!ishuman(user))
		return

	UnregisterSignal(user, COMSIG_MOB_RECALCULATE_CLIENT_COLOR)

	animate(obj_glass_overlay, color = onmob_colors["base"], time = 0.3 SECONDS)
	animate(mob_glass_overlay, color = onmob_colors["base"], time = 0.3 SECONDS)

	user.update_client_color_matrices(0.3 SECONDS)
	var/obj/limb/head/user_head = user.get_limb("head")
	user_head?.vis_contents -= mob_glass_overlay

/obj/item/clothing/glasses/mgoggles
	name = "陆战队员防弹护目镜"
	desc = "USCM标准配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。"
	icon = 'icons/obj/items/clothing/glasses/goggles.dmi'
	icon_state = "mgoggles"
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/goggles.dmi',
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/glasses/goggles.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/glasses_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/glasses_righthand.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/goggles.dmi',
	)
	flags_equip_slot = SLOT_EYES|SLOT_FACE
	flags_obj = OBJ_NO_HELMET_BAND|OBJ_IS_HELMET_GARB
	eye_protection = EYE_PROTECTION_FLAVOR
	var/activated = FALSE
	var/active_icon_state = "mgoggles_down"
	var/inactive_icon_state = "mgoggles"

	var/datum/action/item_action/activation
	var/obj/item/attached_item
	var/message_up = "You push the goggles up."
	var/message_down = "You pull the goggles down."
	garbage = FALSE

/obj/item/clothing/glasses/mgoggles/prescription
	name = "陆战队员处方防弹护目镜"
	desc = "USCM标准配发护目镜。主要用于装饰头盔。内含处方镜片，以防你还不确定它们有多逊。"
	icon_state = "mgoggles"
	prescription = TRUE

/obj/item/clothing/glasses/mgoggles/black
	name = "黑色陆战队员防弹护目镜"
	desc = "USCM标准配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此款配有黑色镜片。"
	icon_state = "mgogglesblk"
	active_icon_state = "mgogglesblk_down"
	inactive_icon_state = "mgogglesblk"

/obj/item/clothing/glasses/mgoggles/black/prescription
	name = "黑色陆战队员处方防弹护目镜"
	desc = "USCM标准配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此款配有黑色镜片。此外，还包含处方镜片。"
	icon_state = "mgogglesblk"
	active_icon_state = "mgogglesblk_down"
	inactive_icon_state = "mgogglesblk"
	prescription = TRUE

/obj/item/clothing/glasses/mgoggles/orange
	name = "橙色陆战队员防弹护目镜"
	desc = "USCM标准配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此款配有琥珀色日间镜片。"
	icon_state = "mgogglesorg"
	active_icon_state = "mgogglesorg_down"
	inactive_icon_state = "mgogglesorg"

/obj/item/clothing/glasses/mgoggles/orange/prescription
	name = "橙色陆战队员处方防弹护目镜"
	desc = "USCM标准配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此款配有琥珀色日间镜片。"
	icon_state = "mgogglesorg"
	active_icon_state = "mgogglesorg_down"
	inactive_icon_state = "mgogglesorg"
	prescription = TRUE

/obj/item/clothing/glasses/mgoggles/v2
	name = "M1A1陆战队员防弹护目镜"
	desc = "USCM新式配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此版本镜片更大。"
	icon_state = "mgoggles2"
	active_icon_state = "mgoggles2_down"
	inactive_icon_state = "mgoggles2"

/obj/item/clothing/glasses/mgoggles/v2/prescription
	name = "M1A1陆战队员处方防弹护目镜"
	desc = "USCM新式配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此版本镜片更大。"
	icon_state = "mgoggles2"
	active_icon_state = "mgoggles2_down"
	inactive_icon_state = "mgoggles2"
	prescription = TRUE

/obj/item/clothing/glasses/mgoggles/red
	name = "红色陆战队员防弹护目镜"
	desc = "USCM标准配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此款配有猩红色日间镜片。"
	icon_state = "mgogglesred"
	active_icon_state = "mgogglesred_down"
	inactive_icon_state = "mgogglesred"

/obj/item/clothing/glasses/mgoggles/red/prescription
	name = "红色陆战队员处方防弹护目镜"
	desc = "USCM标准配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此款配有猩红色日间镜片。"
	icon_state = "mgogglesred"
	active_icon_state = "mgogglesred_down"
	inactive_icon_state = "mgogglesred"
	prescription = TRUE

/obj/item/clothing/glasses/mgoggles/blue
	name = "蓝色陆战队员防弹护目镜"
	desc = "USCM标准配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此款配有蓝色日间镜片。"
	icon_state = "mgogglesblue"
	active_icon_state = "mgogglesblue_down"
	inactive_icon_state = "mgogglesblue"

/obj/item/clothing/glasses/mgoggles/blue/prescription
	name = "处方蓝色陆战队防弹护目镜"
	desc = "USCM标准配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此款配有蓝色日间镜片。"
	icon_state = "mgogglesblue"
	active_icon_state = "mgogglesblue_down"
	inactive_icon_state = "mgogglesblue"
	prescription = TRUE

/obj/item/clothing/glasses/mgoggles/purple
	name = "紫色陆战队防弹护目镜"
	desc = "USCM标准配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。这款配有紫色日间镜片。"
	icon_state = "mgogglespurple"
	active_icon_state = "mgogglespurple_down"
	inactive_icon_state = "mgogglespurple"

/obj/item/clothing/glasses/mgoggles/purple/prescription
	name = "处方紫色陆战队防弹护目镜"
	desc = "USCM标准配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。这款配有紫色日间镜片。"
	icon_state = "mgogglespurple"
	active_icon_state = "mgogglespurple_down"
	inactive_icon_state = "mgogglespurple"
	prescription = TRUE

/obj/item/clothing/glasses/mgoggles/yellow
	name = "黄色陆战队防弹护目镜"
	desc = "USCM标准配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。这款配有黄色日间镜片。"
	icon_state = "mgogglesyellow"
	active_icon_state = "mgogglesyellow_down"
	inactive_icon_state = "mgogglesyellow"

/obj/item/clothing/glasses/mgoggles/yellow/prescription
	name = "处方黄色陆战队防弹护目镜"
	desc = "USCM标准配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。这款配有黄色日间镜片。"
	icon_state = "mgogglesyellow"
	active_icon_state = "mgogglesyellow_down"
	inactive_icon_state = "mgogglesyellow"
	prescription = TRUE

/obj/item/clothing/glasses/mgoggles/v2/blue
	name = "M1A1陆战队员防弹护目镜"
	desc = "USCM新式配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此版本镜片更大。"
	icon_state = "m2gogglesblue"
	active_icon_state = "m2gogglesblue_down"
	inactive_icon_state = "m2gogglesblue"

/obj/item/clothing/glasses/mgoggles/v2/blue/prescription
	name = "M1A1陆战队员处方防弹护目镜"
	desc = "USCM新式配发护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此版本镜片更大。"
	icon_state = "m2gogglesblue"
	active_icon_state = "m2gogglesblue_down"
	inactive_icon_state = "m2gogglesblue"
	prescription = TRUE

/obj/item/clothing/glasses/mgoggles/v2/polarized_blue
	name = "M1A1陆战队偏光防弹护目镜"
	desc = "USCM较新型号护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此版本配有更大的偏光镜片。"
	icon_state = "polarizedblue"
	active_icon_state = "polarizedblue_down"
	inactive_icon_state = "polarizedblue"

/obj/item/clothing/glasses/mgoggles/v2/polarized_blue/prescription
	name = "处方M1A1陆战队偏光防弹护目镜"
	desc = "USCM较新型号护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此版本配有更大的偏光镜片。"
	icon_state = "polarizedblue"
	active_icon_state = "polarizedblue_down"
	inactive_icon_state = "polarizedblue"
	prescription = TRUE

/obj/item/clothing/glasses/mgoggles/v2/polarized_orange
	name = "M1A1陆战队偏光防弹护目镜"
	desc = "USCM较新型号护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此版本配有更大的偏光镜片。"
	icon_state = "polarizedorange"
	active_icon_state = "polarizedorange_down"
	inactive_icon_state = "polarizedorange"

/obj/item/clothing/glasses/mgoggles/v2/polarized_orange/prescription
	name = "处方M1A1陆战队偏光防弹护目镜"
	desc = "USCM较新型号护目镜。通常安装在M10型头盔顶部，也能防止昆虫、灰尘等异物进入眼睛。此版本配有更大的偏光镜片。"
	icon_state = "polarizedorange"
	active_icon_state = "polarizedorange_down"
	inactive_icon_state = "polarizedorange"
	prescription = TRUE

/obj/item/clothing/glasses/mgoggles/on_enter_storage(obj/item/storage/internal/S)
	..()

	if(!istype(S))
		return

	remove_attached_item()

	attached_item = S.master_object
	RegisterSignal(attached_item, COMSIG_PARENT_QDELETING, PROC_REF(remove_attached_item))
	RegisterSignal(attached_item, COMSIG_ITEM_EQUIPPED, PROC_REF(wear_check))
	activation = new /datum/action/item_action/toggle(src, S.master_object)

	if(ismob(S.master_object.loc))
		activation.give_to(S.master_object.loc)

/obj/item/clothing/glasses/mgoggles/on_exit_storage(obj/item/storage/S)
	remove_attached_item()
	return ..()

/obj/item/clothing/glasses/mgoggles/proc/remove_attached_item()
	SIGNAL_HANDLER
	if(!attached_item)
		return

	UnregisterSignal(attached_item, COMSIG_PARENT_QDELETING)
	UnregisterSignal(attached_item, COMSIG_ITEM_EQUIPPED)
	qdel(activation)
	attached_item = null

/obj/item/clothing/glasses/mgoggles/ui_action_click(mob/owner, obj/item/holder)
	toggle_goggles(owner)
	activation.update_button_icon()

/obj/item/clothing/glasses/mgoggles/proc/wear_check(obj/item/I, mob/living/carbon/human/user, slot)
	SIGNAL_HANDLER

	if(slot == WEAR_HEAD && prescription == TRUE && activated)
		ADD_TRAIT(user, TRAIT_NEARSIGHTED_EQUIPMENT, TRAIT_SOURCE_EQUIPMENT(/obj/item/clothing/glasses/mgoggles/prescription)) //Checks if dropped/unequipped for prescription.
	else
		REMOVE_TRAIT(user, TRAIT_NEARSIGHTED_EQUIPMENT, TRAIT_SOURCE_EQUIPMENT(/obj/item/clothing/glasses/mgoggles/prescription)) //Looks messy but potential for adding other cases for goggle types other than prescription in the future such as welding or helmet HUD attachments.

/obj/item/clothing/glasses/mgoggles/proc/toggle_goggles(mob/living/carbon/human/user)
	if(user.is_mob_incapacitated())
		return

	if(!attached_item)
		return

	activated = !activated
	if(activated)
		to_chat(user, SPAN_NOTICE(message_down))
		icon_state = active_icon_state
		if(prescription == TRUE && user.head == attached_item)
			ADD_TRAIT(user, TRAIT_NEARSIGHTED_EQUIPMENT, TRAIT_SOURCE_EQUIPMENT(/obj/item/clothing/glasses/mgoggles/prescription))
	else
		to_chat(user, SPAN_NOTICE(message_up))
		icon_state = inactive_icon_state
		if(prescription == TRUE)
			REMOVE_TRAIT(user, TRAIT_NEARSIGHTED_EQUIPMENT, TRAIT_SOURCE_EQUIPMENT(/obj/item/clothing/glasses/mgoggles/prescription))

	attached_item.update_icon()

/obj/item/clothing/glasses/mgoggles/cmb_riot_shield
	name = "\improper TC2 CMB riot shield"
	desc = "淡黄色防护镜片，需要时可向上掀起，使视野呈黄色。"
	icon_state = "swat_shield"
	icon = 'icons/obj/items/clothing/helmet_garb.dmi'
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/visors.dmi',
	)
	active_icon_state = "swat_shield"
	inactive_icon_state = "swat_shield_up"
	activated = TRUE
	message_up = "You lift the visor up."
	message_down = "You lower the visor down."
	flags_equip_slot = null

/obj/item/clothing/glasses/mgoggles/mp_riot_shield
	name = "\improper Z9 integrated riotplate"
	desc = "M7集成面罩的改进型号，"
	desc_lore = "These were originally produced by a group of marines stationed on LV-920, a snow planet. Conditions were terrible, so to raise morale, the marines hatched a prank. They would spray-paint a faceplate black and meticulously repaint the logos and warning text around the inner seams, not that anyone reads those anyway. Any MP brave or foolish enough to don the brand new faceplate would have the entirety of their cheeks and chin painted black because of residual paint, much to the delight of the bored marines. Unfortunately, due to the prank's roaring success and its spread across the Marine Corps, production of genuine models began, diluting the pool of fake plates with real ones. You're pretty sure this is a real one. Pretty sure."
	icon_state = "mp_shield"
	icon = 'icons/obj/items/clothing/helmet_garb.dmi'
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/visors.dmi',
	)
	active_icon_state = "mp_shield"
	inactive_icon_state = "mp_shield_up"
	activated = TRUE
	message_up = "You lift the visor up."
	message_down = "You lower the visor down."
	flags_equip_slot = null

//welding goggles

/obj/item/clothing/glasses/welding
	name = "焊接护目镜"
	desc = "保护眼睛免受焊接伤害，经疯狂科学家协会认证。"
	icon = 'icons/obj/items/clothing/glasses/goggles.dmi'
	icon_state = "welding-g"
	item_state = "welding-g"
	deactive_state = "welding-gup"
	item_state_slots = list(WEAR_AS_GARB = "welding-h")
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/goggles.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/glasses_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/glasses_righthand.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/goggles.dmi',
	)
	actions_types = list(/datum/action/item_action/toggle)
	flags_inventory = COVEREYES
	flags_inv_hide = HIDEEYES
	eye_protection = EYE_PROTECTION_WELDING
	has_tint = TRUE
	vision_impair = VISION_IMPAIR_ULTRA
	var/vision_impair_on = VISION_IMPAIR_ULTRA
	var/vision_impair_off = VISION_IMPAIR_NONE

/obj/item/clothing/glasses/welding/attack_self()
	..()
	toggle()

/obj/item/clothing/glasses/welding/verb/toggle()
	set category = "Object"
	set name = "Adjust welding goggles"
	set src in usr

	if(usr.is_mob_incapacitated())
		return

	if(active)
		active = 0
		vision_impair = vision_impair_off
		flags_inventory &= ~COVEREYES
		flags_inv_hide &= ~HIDEEYES
		flags_armor_protection &= ~BODY_FLAG_EYES
		update_icon()
		eye_protection = EYE_PROTECTION_NONE
		to_chat(usr, "你将[src]推离面部。")
	else
		active = 1
		vision_impair = vision_impair_on
		flags_inventory |= COVEREYES
		flags_inv_hide |= HIDEEYES
		flags_armor_protection |= BODY_FLAG_EYES
		update_icon()
		eye_protection = initial(eye_protection)
		to_chat(usr, "你拉下[src]以保护眼睛。")


	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		if(H.glasses == src)
			H.update_tint()

	update_clothing_icon()

	for(var/X in actions)
		var/datum/action/A = X
		if(istype(A, /datum/action/item_action/toggle))
			A.update_button_icon()

/obj/item/clothing/glasses/welding/superior
	name = "高级焊接护目镜"
	desc = "由更昂贵材料制成的焊接护目镜，奇怪地散发着土豆味。"
	icon_state = "rwelding-g"
	item_state = "rwelding-g"
	vision_impair = VISION_IMPAIR_WEAK
	vision_impair_on = VISION_IMPAIR_WEAK
	vision_impair_off = VISION_IMPAIR_NONE

/obj/item/clothing/glasses/welding/superior/prescription
	desc = "由更昂贵材料制成的焊接护目镜。镜架上连接着几乎看不见的处方镜片，即使护目镜掀起时也能提供视力。"
	prescription = TRUE

//sunglasses

/obj/item/clothing/glasses/sunglasses
	desc = "通用杂牌护目镜，用于提供基础眼部防护。增强屏蔽层可阻挡多种闪光。"
	name = "sunglasses"
	icon_state = "sun"
	item_state = "sun"
	item_icons = list(
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/glasses/glasses.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/glasses_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/glasses_righthand.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/glasses.dmi',
	)
	darkness_view = -1
	flags_equip_slot = SLOT_EYES|SLOT_FACE
	flags_obj = OBJ_IS_HELMET_GARB
	flags_inv_hide = HIDEEYES
	eye_protection = EYE_PROTECTION_FLAVOR

/obj/item/clothing/glasses/sunglasses/blindfold
	name = "blindfold"
	gender = NEUTER
	desc = "遮盖眼睛，阻挡视线。"
	icon = 'icons/obj/items/clothing/glasses/misc.dmi'
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/misc.dmi',
		WEAR_FACE = 'icons/mob/humans/onmob/clothing/glasses/glasses.dmi',
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/clothing/glasses_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/clothing/glasses_righthand.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/glasses.dmi',
	)
	icon_state = "blindfold"
	item_state = "blindfold"
	vision_impair = VISION_IMPAIR_MAX

/obj/item/clothing/glasses/sunglasses/prescription
	desc = "兼具酷炫感与处方镜固有的书呆子气。竟能同时隐藏两者。"
	name = "处方太阳镜"
	prescription = TRUE
	flags_equip_slot = SLOT_EYES|SLOT_FACE
	flags_obj = OBJ_IS_HELMET_GARB

/obj/item/clothing/glasses/sunglasses/big
	name = "\improper BiMex personal shades"
	desc = "这是一副昂贵的BiMex太阳镜。该品牌在USCM步兵中颇受欢迎，因其专利镜面折射技术据称能防护原子闪光、太阳辐射和瞄准激光。最重要的是，似乎人人都认识某个家伙的某个朋友的朋友，曾用这副眼镜反射过激光手枪。BiMex在陆战队员中流行起来，源于其‘拯救殖民地，酷炫行动’广告宣传活动。"
	icon_state = "bigsunglasses"
	item_state = "sunglasses"
	eye_protection = EYE_PROTECTION_FLASH
	clothing_traits = list(TRAIT_BIMEX)
	flags_equip_slot = SLOT_EYES|SLOT_FACE
	flags_obj = OBJ_IS_HELMET_GARB

/obj/item/clothing/glasses/sunglasses/big/fake
	name = "\improper BiMax personal shades"
	desc = "这是一副廉价仿BiMex风格的太阳镜——重点在于‘风格’。"
	desc_lore = "Marketed as 'BiMax,' with an 'A' to sidestep copyright, these knockoffs are popular with penny-pinching spacers and wannabe badasses. While the real deal boasts patented mirror refraction for atomic flash, solar radiation, and targeting laser protection, these cut-rate imitations barely keep UV rays at bay. As for that famous story of a laser pistol reflecting off the originals? Good luck finding anyone who believes these could pull it off. But hey, they’re cheap, and their 'Save the Budget and Look Cool Doing It' slogan really sells it."
	icon_state = "bigsunglasses"
	item_state = "bigsunglasses"
	eye_protection = FALSE
	clothing_traits = FALSE

/obj/item/clothing/glasses/sunglasses/big/fake/red
	icon_state = "bigsunglasses_red"
	item_state = "bigsunglasses_red"

/obj/item/clothing/glasses/sunglasses/big/fake/orange
	icon_state = "bigsunglasses_orange"
	item_state = "bigsunglasses_orange"

/obj/item/clothing/glasses/sunglasses/big/fake/yellow
	icon_state = "bigsunglasses_yellow"
	item_state = "bigsunglasses_yellow"

/obj/item/clothing/glasses/sunglasses/big/fake/green
	icon_state = "bigsunglasses_green"
	item_state = "bigsunglasses_green"

/obj/item/clothing/glasses/sunglasses/big/fake/blue
	icon_state = "bigsunglasses_blue"
	item_state = "bigsunglasses_blue"

// Hippie

/obj/item/clothing/glasses/sunglasses/hippie
	name = "\improper Suntex-Sightware rounded shades"
	desc = "来自Suntex-Sightware的彩色圆形墨镜，深受自由灵魂和特立独行者喜爱。这些充满活力的复古风格墨镜能提供足够的闪光防护，同时为任何造型增添一抹随性的波西米亚风格。"
	icon_state = "hippie_glasses_pink"
	item_state = "hippie_glasses_pink"

/obj/item/clothing/glasses/sunglasses/hippie/green
	icon_state = "hippie_glasses_green"
	item_state = "hippie_glasses_green"

/obj/item/clothing/glasses/sunglasses/hippie/sunrise
	icon_state = "hippie_glasses_sunrise"
	item_state = "hippie_glasses_sunrise"

/obj/item/clothing/glasses/sunglasses/hippie/sunset
	icon_state = "hippie_glasses_sunset"
	item_state = "hippie_glasses_sunset"

/obj/item/clothing/glasses/sunglasses/hippie/nightblue
	icon_state = "hippie_glasses_nightblue"
	item_state = "hippie_glasses_nightblue"

/obj/item/clothing/glasses/sunglasses/hippie/midnight
	icon_state = "hippie_glasses_midnight"
	item_state = "hippie_glasses_midnight"

/obj/item/clothing/glasses/sunglasses/hippie/bloodred
	icon_state = "hippie_glasses_bloodred"
	item_state = "hippie_glasses_bloodred"

/obj/item/clothing/glasses/sunglasses/big/new_bimex
	name = "\improper BiMex Polarized Shades"
	desc = "专为现代作战人员设计的流线型棱角墨镜。"
	desc_lore = "BiMex's latest 'TactOptix' line comes with advanced polarization and lightweight ballistic lenses capable of shrugging off small shrapnel impacts. A favorite among frontline operators and deep-space scouts, these shades are marketed as 'combat-tested and action-approved.' Rumors abound of lucky users surviving close-range laser shots thanks to the multi-reflective lens coating, though BiMex's official stance is to 'Stop standing in front of lasers.'"
	icon_state = "bimex_polarized_yellow"
	item_state = "bimex_polarized_yellow"
	eye_protection = EYE_PROTECTION_FLASH
	clothing_traits = list(TRAIT_BIMEX)
	flags_equip_slot = SLOT_EYES|SLOT_FACE
	flags_obj = OBJ_IS_HELMET_GARB

/obj/item/clothing/glasses/sunglasses/big/new_bimex/black
	name = "\improper BiMex Tactical Shades"
	icon_state = "bimex_black"
	item_state = "bimex_black"

/obj/item/clothing/glasses/sunglasses/big/new_bimex/bronze
	icon_state = "bimex_polarized_bronze"
	item_state = "bimex_polarized_bronze"

/obj/item/clothing/glasses/sunglasses/aviator
	name = "飞行员墨镜"
	desc = "一副棕褐色调的太阳镜。戴上它，你能隐约听到80年代的音乐在耳边回响。"
	icon_state = "aviator"
	item_state = "aviator"
	flags_equip_slot = SLOT_EYES|SLOT_FACE
	flags_obj = OBJ_IS_HELMET_GARB

/obj/item/clothing/glasses/sunglasses/aviator/silver
	name = "飞行员墨镜"
	desc = "一副银色调的太阳镜。戴上它，你能隐约听到80年代的音乐在耳边回响。"
	icon_state = "aviator_silver"
	item_state = "aviator_silver"

/obj/item/clothing/glasses/sunglasses/sechud
	name = "安保平视显示眼镜"
	desc = "这副太阳镜集成了USCM在边疆所能调集的最顶尖纳米技术。它能显示任何你认为值得关注之人的信息。"
	icon_state = "sunhud"
	eye_protection = EYE_PROTECTION_FLASH
	hud_type = MOB_HUD_SECURITY_ADVANCED
	flags_obj = OBJ_IS_HELMET_GARB

/obj/item/clothing/glasses/sunglasses/sechud/blue
	name = "安保平视显示眼镜"
	desc = "这副太阳镜集成了USCM在边疆所能调集的最顶尖纳米技术。它能显示任何你认为值得关注之人的信息。"
	icon_state = "sunhud_blue"

/obj/item/clothing/glasses/sunglasses/sechud/blue/prescription
	name = "处方安保平视显示眼镜"
	desc = "这副太阳镜集成了USCM在边疆所能调集的最顶尖纳米技术。它能显示任何你认为值得关注之人的信息。包含处方镜片。"
	prescription = TRUE

/obj/item/clothing/glasses/sunglasses/sechud/prescription
	name = "处方安保平视显示眼镜"
	desc = "这副太阳镜集成了USCM在边疆所能调集的最顶尖纳米技术。它能显示任何你认为值得关注之人的信息。包含处方镜片。"
	prescription = TRUE

/obj/item/clothing/glasses/sunglasses/sechud/tactical
	name = "战术特警平视显示器"
	desc = "具备防闪光功能并内置战斗与安保信息的护目镜。"
	icon = 'icons/obj/items/clothing/glasses/goggles.dmi'
	icon_state = "swatgoggles"
	gender = NEUTER
	item_icons = list(
		WEAR_EYES = 'icons/mob/humans/onmob/clothing/glasses/goggles.dmi',
	)
