// Holds props for helmet garb

/obj/item/prop/helmetgarb
	icon = 'icons/obj/items/clothing/helmet_garb.dmi'
	icon_state = null
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/misc.dmi',
		)
	w_class = SIZE_TINY
	garbage = TRUE

/obj/item/prop/helmetgarb/Initialize(mapload, ...)
	. = ..()
	if(garbage)
		flags_obj |= OBJ_IS_HELMET_GARB

/obj/item/prop/helmetgarb/gunoil
	name = "枪油"
	desc = "这是一瓶枪油。别信谣言，M41A可不是一把会自我清洁的枪。"
	icon_state = "gunoil"

/obj/item/prop/helmetgarb/spent_buckshot
	name = "用过的霰弹"
	desc = "三发用过的老式霰弹。你知道它们以前被漆成绿色吗？真是个奇怪的时代。"
	icon_state = "spent_buckshot"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/ammo.dmi',
		)

/obj/item/prop/helmetgarb/spent_slug
	name = "用过的独头弹"
	gender = PLURAL
	desc = "当你需要以更强的停止作用力击倒目标时使用。这三发已经打过了。"
	icon_state = "spent_slug"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/ammo.dmi',
		)

/obj/item/prop/helmetgarb/spent_flech
	name = "用过的箭弹"
	desc = "这玩意儿打得越多，你就越觉得破片手榴弹可能更能胜任这活儿。话说，这玩意儿不是应该从枪里弹出来吗？"
	icon_state = "spent_flech"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/ammo.dmi',
		)

/obj/item/prop/helmetgarb/cartridge
	name = "cartridge"
	desc = "这是一枚71式脉冲步枪的子弹。它因撞击装甲表面而变形。现在它已经沦为一件幸运的纪念品了。"
	icon_state = "cartridge"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/ammo.dmi',
	)
	item_state_slots = list(WEAR_AS_GARB = "bullet")

/obj/item/prop/helmetgarb/prescription_bottle
	name = "处方药"
	desc = "抗焦虑药？安非他命？治疗突发性睡眠障碍的药？标签已无法辨认，里面曾经装过什么将永远是个谜。瓶盖拧得比任何身份锁都紧。"
	icon_state = "prescription_bottle"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/medical.dmi',
	)

/obj/item/prop/helmetgarb/rabbitsfoot
	name = "兔脚"
	desc = "对你来说是幸运的，但对兔子可不是，这玩意儿对它没什么好处。"
	icon_state = "rabbitsfoot"

/obj/item/prop/helmetgarb/rosary
	name = "rosary"
	desc = "耶稣拯救生命！"
	icon_state = "rosary"
	item_state_slots = list(WEAR_AS_GARB = "rosary")

/obj/item/prop/helmetgarb/lucky_feather
	name = "\improper Red Lucky Feather"
	desc = "这是一种刺眼的红色，由非常劣质的塑料和合成线制成，你知道的，就是每个公司联络官的脊梁骨用的那种材料。"
	icon_state = "lucky_feather"
	item_state_slots = list(WEAR_AS_GARB = "lucky_feather")
	color = "red"

/obj/item/prop/helmetgarb/lucky_feather/blue
	name = "\improper Blue Lucky Feather"
	desc = "这是一种亮蓝色。你记得好像在全息剧院里见过一只冠蓝鸦。"
	item_state_slots = list(WEAR_AS_GARB = "lucky_feather_blue")
	color = "blue"

/obj/item/prop/helmetgarb/lucky_feather/purple
	name = "\improper Purple Lucky Feather"
	desc = "这是一种大胆的紫色。传说有个叫莎士比亚的空间站AI模拟了1000只猴子乱打字，试图重现莎士比亚的真实作品。艺术评论家们仍在争论这是否是真正的人工抽象艺术的第一个实例。"
	item_state_slots = list(WEAR_AS_GARB = "lucky_feather_purple")
	color = "purple"

/obj/item/prop/helmetgarb/lucky_feather/yellow
	name = "\improper Yellow Lucky Feather"
	desc = "这是一种坚毅的黄色。据说新堪萨斯殖民地人均产出的木匠比UA控制区内任何其他殖民地都多。"
	item_state_slots = list(WEAR_AS_GARB = "lucky_feather_yellow")
	color = "yellow"

#define NVG_SHAPE_COSMETIC 1
#define NVG_SHAPE_BROKEN 2
#define NVG_SHAPE_PATCHED 3
#define NVG_SHAPE_FINE 4

/obj/item/prop/helmetgarb/helmet_nvg
	name = "\improper M2 night vision goggles"
	desc = "USCM标准的M2军用夜视镜。需要电池才能工作。"
	icon_state = "nvg"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/goggles.dmi',
	)
	gender = PLURAL
	garbage = FALSE
	w_class = SIZE_MEDIUM

	var/nvg_maxhealth = 125
	var/nvg_health = 125

	/// How much charge the cell should have at most. -1 is infinite
	var/cell_max_charge = 2500

	var/activated = FALSE
	var/nightvision = FALSE
	var/shape = NVG_SHAPE_FINE

	var/active_powered_icon_state = "nvg_down_powered"
	var/active_icon_state = "nvg_down"
	var/inactive_icon_state = "nvg"

	var/datum/action/item_action/toggle/helmet_nvg/activation
	var/obj/item/clothing/head/attached_item
	var/mob/living/attached_mob
	var/lighting_alpha = 100
	var/matrix_color = NV_COLOR_GREEN

/obj/item/prop/helmetgarb/helmet_nvg/Initialize(mapload, ...)
	. = ..()
	if(shape != NVG_SHAPE_COSMETIC)
		AddComponent(/datum/component/cell, cell_max_charge, TRUE, charge_drain = 8)
		RegisterSignal(src, COMSIG_CELL_TRY_RECHARGING, PROC_REF(cell_try_recharge))
		RegisterSignal(src, COMSIG_CELL_OUT_OF_CHARGE, PROC_REF(on_power_out))

/obj/item/prop/helmetgarb/helmet_nvg/on_enter_storage(obj/item/storage/internal/S)
	..()

	if(!istype(S))
		return

	remove_attached_item()

	var/obj/item/MO = S.master_object
	if(!istype(MO, /obj/item/clothing/head/helmet/marine) && !istype(MO, /obj/item/clothing/head/cmcap)) // Do not bother if it's not a helmet or at least a hat
		return

	attached_item = MO

	RegisterSignal(attached_item, COMSIG_PARENT_QDELETING, PROC_REF(remove_attached_item))
	RegisterSignal(attached_item, COMSIG_ITEM_EQUIPPED, PROC_REF(toggle_check))

	if(ismob(attached_item.loc))
		set_attached_mob(attached_item.loc)


/obj/item/prop/helmetgarb/helmet_nvg/attackby(obj/item/A as obj, mob/user as mob)
	if(HAS_TRAIT(A, TRAIT_TOOL_SCREWDRIVER))
		repair(user)

	else
		..()

/obj/item/prop/helmetgarb/helmet_nvg/proc/cell_try_recharge(datum/source, mob/living/user)
	SIGNAL_HANDLER

	if(user.action_busy)
		return COMPONENT_CELL_NO_RECHARGE

	if(src != user.get_inactive_hand())
		to_chat(user, SPAN_WARNING("你需要将[src]拿在手中才能为其充电。"))
		return COMPONENT_CELL_NO_RECHARGE

	if(shape == NVG_SHAPE_COSMETIC)
		to_chat(user, SPAN_WARNING("[src]内部没有电池的连接器。"))
		return COMPONENT_CELL_NO_RECHARGE

	if(shape == NVG_SHAPE_BROKEN)
		to_chat(user, SPAN_WARNING("你需要先修理[src]。"))
		return COMPONENT_CELL_NO_RECHARGE


/obj/item/prop/helmetgarb/helmet_nvg/proc/repair(mob/user as mob)
	if(user.action_busy)

		return
	if(src != user.get_inactive_hand())
		to_chat(user, SPAN_WARNING("你需要将\the [src]拿在手中才能修理它们。"))
		return
	if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_NOVICE)) // level 2 is enough to repair damaged NVG
		to_chat(user, SPAN_WARNING("你没有接受过修理电子设备的训练..."))
		return

	if(shape == NVG_SHAPE_BROKEN)
		if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED)) // level 3 is needed to repair broken NVG
			to_chat(user, SPAN_WARNING("这种复杂程度的修理对你来说太难了，去找个更专业的人吧。"))
			return

		to_chat(user, "你开始修理\the [src]。")
		if(!do_after(user, 5 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD, src))
			to_chat(user, SPAN_WARNING("你被打断了。"))
			return
		playsound(src.loc, 'sound/items/Screwdriver.ogg', 25, 1)
		color = "#bebebe"
		shape = NVG_SHAPE_PATCHED
		to_chat(user, "你成功修补了\the [src]。")
		nvg_maxhealth = 65
		nvg_health = 65
		return

	else if(nvg_health == nvg_maxhealth)
		if(shape == NVG_SHAPE_PATCHED)
			to_chat(user, SPAN_WARNING("已修复完毕，无事可做。"))
		else if(shape == NVG_SHAPE_FINE)
			to_chat(user, SPAN_WARNING("无需修理。"))
		else if(shape == NVG_SHAPE_COSMETIC)

			to_chat(user, SPAN_WARNING("它只剩下一个空壳了。"))

	else
		to_chat(user, "你开始修理\the [src]。")
		if(do_after(user, 2 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD, src))
			to_chat(user, "你成功修复了\the [src]。")
			playsound(src.loc, 'sound/items/Screwdriver.ogg', 25, 1)
			nvg_health = nvg_maxhealth
		else
			to_chat(user, SPAN_WARNING("你被打断了。"))


/obj/item/prop/helmetgarb/helmet_nvg/get_examine_text(mob/user)
	. = ..()

	if(shape == NVG_SHAPE_BROKEN)
		. += "They appear to be broken. Maybe someone competent can fix them."
	else

		if(shape == NVG_SHAPE_PATCHED)
			. += "They are covered in scratches and have traces of a recent repair."

		var/nvg_health_procent = nvg_health / nvg_maxhealth * 100
		if(nvg_health_procent > 70)
			. += "They appear to be in good shape."
		else if(nvg_health_procent > 50)
			. += "They are visibly damaged."
		else if(nvg_health_procent > 30)
			. += "It's unlikely they can sustain more damage."
		else if(nvg_health_procent >= 0)
			. += "They are falling apart."

/obj/item/prop/helmetgarb/helmet_nvg/on_exit_storage(obj/item/storage/S)
	remove_attached_item()
	return ..()


/obj/item/prop/helmetgarb/helmet_nvg/proc/set_attached_mob(mob/User)
	attached_mob = User
	activation = new /datum/action/item_action/toggle/helmet_nvg(src, attached_item)
	activation.give_to(attached_mob)
	activation.action_icon_state = "nvg"
	add_verb(attached_mob, /obj/item/prop/helmetgarb/helmet_nvg/proc/toggle)
	RegisterSignal(attached_mob, COMSIG_HUMAN_XENO_ATTACK, PROC_REF(break_nvg))
	RegisterSignal(attached_item, COMSIG_ITEM_DROPPED, PROC_REF(remove_attached_mob))

/obj/item/prop/helmetgarb/helmet_nvg/proc/remove_attached_item()
	SIGNAL_HANDLER

	if(!attached_item)
		return
	UnregisterSignal(attached_item, list(
		COMSIG_PARENT_QDELETING,
		COMSIG_ITEM_EQUIPPED
	))

	if(activated)
		activated = FALSE
		icon_state = inactive_icon_state

	remove_attached_mob()
	attached_item = null

/obj/item/prop/helmetgarb/helmet_nvg/proc/remove_attached_mob()
	UnregisterSignal(attached_item, COMSIG_ITEM_DROPPED)
	qdel(activation)
	if(!attached_mob)
		return
	UnregisterSignal(attached_mob, list(
		COMSIG_HUMAN_XENO_ATTACK,
		COMSIG_MOB_CHANGE_VIEW
	))
	remove_verb(attached_mob, /obj/item/prop/helmetgarb/helmet_nvg/proc/toggle)
	remove_nvg()
	attached_mob = null

/obj/item/prop/helmetgarb/helmet_nvg/proc/toggle_check(obj/item/I, mob/living/carbon/human/user, slot)
	SIGNAL_HANDLER

	if(attached_mob != user && slot == WEAR_HEAD)
		set_attached_mob(user)

	if(slot == WEAR_HEAD && !nightvision && activated && !SEND_SIGNAL(src, COMSIG_CELL_CHECK_CHARGE) && shape > NVG_SHAPE_BROKEN)
		enable_nvg(user)
	else
		remove_nvg()


/obj/item/prop/helmetgarb/helmet_nvg/proc/enable_nvg(mob/living/carbon/human/user)
	if(nightvision)
		remove_nvg()

	RegisterSignal(user, COMSIG_HUMAN_POST_UPDATE_SIGHT, PROC_REF(update_sight))

	if(user.client?.prefs?.night_vision_preference)
		matrix_color = user.client.prefs.nv_color_list[user.client.prefs.night_vision_preference]
	user.add_client_color_matrix("nvg", 99, color_matrix_multiply(color_matrix_saturation(0), color_matrix_from_string(matrix_color)))
	user.overlay_fullscreen("nvg", /atom/movable/screen/fullscreen/flash/noise/nvg)
	user.overlay_fullscreen("nvg_blur", /atom/movable/screen/fullscreen/brute/nvg, 3)
	playsound(user, 'sound/handling/toggle_nv1.ogg', 25)
	nightvision = TRUE
	user.update_sight()

	icon_state = active_powered_icon_state
	attached_item.update_icon()
	activation.update_button_icon()

	SEND_SIGNAL(src, COMSIG_CELL_START_TICK_DRAIN)


/obj/item/prop/helmetgarb/helmet_nvg/proc/update_sight(mob/M)
	SIGNAL_HANDLER

	if(lighting_alpha < 255)
		M.see_in_dark = 12
	M.lighting_alpha = lighting_alpha
	M.sync_lighting_plane_alpha()


/obj/item/prop/helmetgarb/helmet_nvg/proc/remove_nvg()
	SIGNAL_HANDLER

	if(!attached_mob)
		return

	if(nightvision)
		attached_mob.remove_client_color_matrix("nvg", 1 SECONDS)
		attached_mob.clear_fullscreen("nvg", 0.5 SECONDS)
		attached_mob.clear_fullscreen("nvg_blur", 0.5 SECONDS)
		playsound(attached_mob, 'sound/handling/toggle_nv2.ogg', 25)
		nightvision = FALSE

		UnregisterSignal(attached_mob, COMSIG_HUMAN_POST_UPDATE_SIGHT)

		if(activated)
			icon_state = active_icon_state
			attached_item.update_icon()
			activation.update_button_icon()

		attached_mob.update_sight()

		SEND_SIGNAL(src, COMSIG_CELL_STOP_TICK_DRAIN)


/obj/item/prop/helmetgarb/helmet_nvg/process(delta_time)
	if(!attached_mob)
		return PROCESS_KILL

	if(!activated || !attached_item || attached_mob.is_dead())
		on_power_out()
		return

	if(!attached_item.has_garb_overlay())
		to_chat(attached_mob, SPAN_WARNING("当\the [src]处于隐藏状态时无法使用。"))
		remove_nvg()
		return


/obj/item/prop/helmetgarb/helmet_nvg/proc/on_power_out(datum/source)
	SIGNAL_HANDLER

	if(activated && !attached_mob.is_dead())
		to_chat(attached_mob, SPAN_WARNING("[src]发出低电量警告并立即关机！"))
	remove_nvg()

/obj/item/prop/helmetgarb/helmet_nvg/ui_action_click(mob/owner, obj/item/holder)
	toggle_nods(owner)


/obj/item/prop/helmetgarb/helmet_nvg/proc/toggle()
	set category = "Object"
	set name = "Toggle M2 night vision goggles"

	var/obj/item/clothing/head/helmet/marine/H = usr.get_item_by_slot(WEAR_HEAD)
	if(istype(H))
		for(var/obj/item/prop/helmetgarb/helmet_nvg/G in H.pockets.contents)
			G.toggle_nods(usr)
			break


/obj/item/prop/helmetgarb/helmet_nvg/proc/toggle_nods(mob/living/carbon/human/user)
	if(user.is_mob_incapacitated())
		return

	if(!attached_item)
		return

	if(!attached_item.has_garb_overlay())
		to_chat(user, SPAN_WARNING("当\the [src]处于隐藏状态时无法使用。"))
		return

	if(user.client.view > 7 && shape != NVG_SHAPE_COSMETIC)
		to_chat(user, SPAN_WARNING("使用光学设备时无法使用\the [src]。"))
		return

	activated = !activated

	if(activated)
		to_chat(user, SPAN_NOTICE("你拉下护目镜。"))
		icon_state = active_icon_state
		if(!SEND_SIGNAL(src, COMSIG_CELL_CHECK_CHARGE) && user.head == attached_item && shape > NVG_SHAPE_BROKEN)
			enable_nvg(user)
		else
			icon_state = active_icon_state
			attached_item.update_icon()
			activation.update_button_icon()

		if(shape != NVG_SHAPE_COSMETIC)
			RegisterSignal(user, COMSIG_MOB_CHANGE_VIEW, PROC_REF(change_view)) // will flip non-cosmetic nvgs back up when zoomed

	else
		to_chat(user, SPAN_NOTICE("你将\the [src]推回头盔上。"))

		icon_state = inactive_icon_state
		attached_item.update_icon()
		activation.update_button_icon()

		remove_nvg()
		UnregisterSignal(user, COMSIG_MOB_CHANGE_VIEW)

/obj/item/prop/helmetgarb/helmet_nvg/proc/change_view(mob/M, new_size)
	SIGNAL_HANDLER

	if(new_size > 7) // cannot use binos with NVG
		toggle_nods(M)

/obj/item/prop/helmetgarb/helmet_nvg/proc/break_nvg(mob/living/carbon/human/user, list/slashdata, mob/living/carbon/xenomorph/Xeno) //xenos can break NVG if aim head
	SIGNAL_HANDLER

	if(check_zone(Xeno.zone_selected) == "head" && user == attached_mob)
		nvg_health -= slashdata["n_damage"] // damage can be adjusted here
	if(nvg_health <= 0)
		nvg_health = 0
		user.visible_message(SPAN_WARNING("\The [src] on [user]'s head break with a crinkling noise."),
			SPAN_WARNING("Your [src.name] break with a crinkling noise."),
			SPAN_WARNING("You hear a crinkling noise, as if something was broken in your helmet."))
		playsound(user, "bone_break", 30, TRUE)
		src.color = "#4e4e4e"
		if(shape != NVG_SHAPE_COSMETIC)
			shape = NVG_SHAPE_BROKEN
		var/obj/item/clothing/head/helmet/marine/H = attached_item
		H.pockets.remove_from_storage(src, get_turf(H))

/obj/item/prop/helmetgarb/helmet_nvg/cosmetic //for "custom loadout", purely cosmetic
	name = "老式M2夜视镜"
	desc = "这副眼镜的所有电子元件已被拆除，因此无法工作。不过，它们让你感觉很战术，这才是最重要的，对吧？"
	shape = NVG_SHAPE_COSMETIC
	garbage = TRUE

/obj/item/prop/helmetgarb/helmet_nvg/cosmetic/break_nvg(mob/living/carbon/human/user, list/slashdata, mob/living/carbon/xenomorph/Xeno)
	return

/obj/item/prop/helmetgarb/helmet_nvg/marsoc //for Marine Raiders
	name = "\improper Tactical M3 night vision goggles"
	desc = "配备集成自充电电池，无所阻挡。将其戴在头盔上，按下按钮，即刻行动。"
	cell_max_charge = -1

#undef NVG_SHAPE_COSMETIC
#undef NVG_SHAPE_BROKEN
#undef NVG_SHAPE_PATCHED
#undef NVG_SHAPE_FINE

/obj/item/prop/helmetgarb/flair_initech
	name = "\improper Initech flair"
	desc = "地球某个古怪科技公司的宣传品。他们的宣传材料怎么会出现在这么偏远的星域？"
	icon_state = "flair_initech"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/patches_flairs.dmi',
	)

/obj/item/prop/helmetgarb/flair_io
	name = "\improper Io flair"
	desc = "阿克图里安人现在或许是我们的盟友，但木卫一事件永远是跨物种关系上的污点。永远不要忘记那些在多拉明号上牺牲的人们。"
	icon_state = "flair_io"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/patches_flairs.dmi',
	)

/obj/item/prop/helmetgarb/flair_peace
	name = "\improper Peace flair"
	desc = "只要是阿克图里安产的，管它呢，宝贝。"
	icon_state = "flair_peace_smiley"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/patches_flairs.dmi',
	)

/obj/item/prop/helmetgarb/flair_uscm
	name = "\improper USCM flair"
	desc = "这些徽章在征兵办公室像糖果一样分发。陆战队员，骄傲地戴上它。"
	icon_state = "flair_uscm"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/patches_flairs.dmi',
	)

/obj/item/prop/helmetgarb/spacejam_tickets
	name = "\improper Tickets to Space Jam"
	desc = "两张2181年独一无二的太空扣篮大赛原版、崭新、橙色的门票。那可真是一场盛宴。"
	icon_state = "tickets_to_space_jam"

/obj/item/prop/helmetgarb/riot_shield
	name = "\improper RC6 riot shield"
	desc = "RC6防暴头盔的配套面罩，需单独购买。"
	icon_state = "riot_shield"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/visors.dmi',
	)

/obj/item/prop/helmetgarb/helmet_gasmask
	name = "\improper M5 integrated gasmask"
	desc = "当UA最高指挥部发现并非所有部署的士兵都24/7佩戴头盔时，感到十分困惑，USCM为此项目的拨款也被取消了。"
	icon_state = "gasmask"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/visors.dmi',
	)

/obj/item/prop/helmetgarb/helmet_gasmask/on_enter_storage(obj/item/storage/internal/helmet_internal_inventory)
	..()
	if(!istype(helmet_internal_inventory))
		return
	var/obj/item/clothing/head/helmet/helmet_item = helmet_internal_inventory.master_object

	if(!istype(helmet_item))
		return

	helmet_item.flags_inventory |= BLOCKGASEFFECT
	helmet_item.flags_inv_hide |= HIDEFACE

/obj/item/prop/helmetgarb/helmet_gasmask/on_exit_storage(obj/item/storage/internal/helmet_internal_inventory)
	..()
	if(!istype(helmet_internal_inventory))
		return
	var/obj/item/clothing/head/helmet/helmet_item = helmet_internal_inventory.master_object

	if(!istype(helmet_item))
		return

	helmet_item.flags_inventory &= ~(BLOCKGASEFFECT)
	helmet_item.flags_inv_hide &= ~(HIDEFACE)

/obj/item/prop/helmetgarb/trimmed_wire
	name = "修剪过的铁丝网"
	desc = "这是一段铁丝网，大部分尖锐部分已被锉平，可以安全手持。"
	icon_state = "trimmed_wire"

/obj/item/prop/helmetgarb/bullet_pipe
	name = "10x99mm XM43E1弹壳管"
	desc = "XM43E1曾是USCM和维兰德-汤谷PMC小队短暂部署的实验性武器平台，由阿玛特系统公司在阿特拉斯武器工厂制造。不幸的是，该项目与M5集成防毒面具项目一同被取消了拨款。这个用过的弹壳被改造成了烟斗，但烟嘴处焦油过多，已无法使用。"
	icon_state = "bullet_pipe"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/ammo.dmi',
	)

/obj/item/prop/helmetgarb/chaplain_patch
	name = "\improper USCM chaplain helmet patch"
	desc = "这枚臂章，连同随军牧师本人，是阿尔迈耶号上随军牧师团仅存的遗物。两者都因在\"提丰擒抱\"行动中遭受的损失而不复存在。"
	icon_state = "chaplain_patch"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/patches_flairs.dmi',
		)
	flags_obj = OBJ_NO_HELMET_BAND

/obj/item/prop/helmetgarb/family_photo
	name = "家庭照片"
	desc = ""
	icon = 'icons/obj/items/paper.dmi'
	icon_state = "photo_item"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/misc.dmi',
	)
	item_state_slots = list(WEAR_AS_GARB = "paper") //PLACEHOLDER
	///The human who spawns with the photo
	var/datum/weakref/owner
	///The belonging human name
	var/owner_name
	///The belonging human faction
	var/owner_faction
	///Text written on the back
	var/scribble

/obj/item/prop/helmetgarb/family_photo/pickup(mob/user, silent)
	. = ..()
	if(!owner)
		RegisterSignal(user, COMSIG_POST_SPAWN_UPDATE, PROC_REF(set_owner), override = TRUE)


///Sets the owner of the family photo to the human it spawns with, needs var/source for signals
/obj/item/prop/helmetgarb/family_photo/proc/set_owner(datum/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, COMSIG_POST_SPAWN_UPDATE)
	var/mob/living/carbon/human/user = source
	owner = WEAKREF(user)
	owner_name = user.name
	owner_faction = user.faction

/obj/item/prop/helmetgarb/family_photo/get_examine_text(mob/user)
	. = ..()
	if(scribble)
		. += "\"[scribble]\" is written on the back of the photo."
	if(user.weak_reference == owner)
		. += "A photo of you and your family."
		return
	if(user.faction == owner_faction)
		. += "A photo of [owner_name] and their family."
		return
	. += "A photo of a family you do not know."

/obj/item/prop/helmetgarb/family_photo/attackby(obj/item/attacking_item, mob/user)
	. = ..()
	if(HAS_TRAIT(attacking_item, TRAIT_TOOL_PEN) || istype(attacking_item, /obj/item/toy/crayon))
		if(scribble)
			to_chat(user, SPAN_NOTICE("[src]上已经有字了。"))
			return
		var/new_text = copytext(strip_html(tgui_input_text(user, "你想在[src]背面写什么？", "Photo Writing")), 1, 128)

		if(!loc == user)
			to_chat(user, SPAN_NOTICE("你需要手持[src]才能在上面写字。"))
			return
		if(!user.stat == CONSCIOUS)
			to_chat(user, SPAN_NOTICE("你无法在此状态下在[src]上写字。"))
			return
		scribble = new_text
		playsound(src, "paper_writing", 15, TRUE)
	return TRUE

/obj/item/prop/helmetgarb/compass
	name = "compass"
	desc = "它总是指向北方。你确定它没坏吗？"
	icon = 'icons/obj/items/tools.dmi'
	icon_state = "compass"
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/misc.dmi',
	)
	item_state_slots = list(WEAR_AS_GARB = "paper") //PLACEHOLDER
	w_class = SIZE_SMALL

/obj/item/prop/helmetgarb/compass/get_examine_text(mob/user)
	. = ..()
	if(is_ground_level(user.z) && !SSmapping.configs[GROUND_MAP].environment_traits[ZTRAIT_IN_SPACE])
		. += SPAN_NOTICE("It seems you are facing [dir2text(user.dir)].")
		return
	. += SPAN_NOTICE("The needle is not moving.")

/obj/item/prop/helmetgarb/bug_spray
	name = "驱虫剂"
	desc = "一款商店品牌的驱虫剂，能让你远离各种害虫或蚊子。"
	icon = 'icons/obj/items/spray.dmi'
	item_icons = list(
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/misc.dmi',
	)
	icon_state = "pestspray"
	item_state_slots = list(WEAR_AS_GARB = "canteen") //PLACEHOLDER
	w_class = SIZE_SMALL
