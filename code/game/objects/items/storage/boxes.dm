/*
 * Everything derived from the common cardboard box.
 * Basically everything except the original is a kit (starts full).
 *
 * Contains:
 * Empty box, starter boxes (survival/engineer),
 * Latex glove and sterile mask boxes,
 * Syringe, beaker, dna injector boxes,
 * Blanks, flashbangs, and EMP grenade boxes,
 * Tracking and chemical implant boxes,
 * Prescription glasses and drinking glass boxes,
 * Condiment bottle and silly cup boxes,
 * Donkpocket and monkeycube boxes,
 * ID and security PDA cart boxes,
 * Handcuff, mousetrap, and pillbottle boxes,
 * Snap-pops and matchboxes,
 * Replacement light boxes.
 *
 * For syndicate call-ins see uplink_kits.dm
 *
 *  EDITED BY APOPHIS 09OCT2015 to prevent in-game abuse of boxes.
 */



/obj/item/storage/box
	name = "box"
	desc = "这只是一个普通的盒子。"
	icon_state = "box"
	icon = 'icons/obj/items/storage/boxes.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/storage_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/storage_righthand.dmi',
	)
	item_state = "box"
	foldable = TRUE
	storage_slots = null
	max_w_class = SIZE_SMALL //Changed because of in-game abuse
	w_class = SIZE_LARGE //Changed because of in-game abuse
	storage_flags = STORAGE_FLAGS_BOX

/obj/item/storage/box/pride
	name = "骄傲蜡笔盒"
	desc = "一盒包含各种骄傲口味的蜡笔。"
	storage_slots = 8
	w_class = SIZE_SMALL
	can_hold = list(/obj/item/toy/crayon/pride)

/obj/item/storage/box/pride/fill_preset_inventory()
	new /obj/item/toy/crayon/pride/gay(src)
	new /obj/item/toy/crayon/pride/lesbian(src)
	new /obj/item/toy/crayon/pride/bi(src)
	new /obj/item/toy/crayon/pride/ace(src)
	new /obj/item/toy/crayon/pride/pan(src)
	new /obj/item/toy/crayon/pride/trans(src)
	new /obj/item/toy/crayon/pride/enby(src)
	new /obj/item/toy/crayon/pride/fluid(src)

/obj/item/storage/box/survival
	w_class = SIZE_MEDIUM

/obj/item/storage/box/survival/fill_preset_inventory()
	new /obj/item/clothing/mask/breath( src )
	new /obj/item/tank/emergency_oxygen( src )

/obj/item/storage/box/engineer

/obj/item/storage/box/engineer/fill_preset_inventory()
	new /obj/item/clothing/mask/breath( src )
	new /obj/item/tank/emergency_oxygen/engi( src )


/obj/item/storage/box/gloves
	name = "乳胶手套盒"
	desc = "内含白色手套。"
	icon_state = "latex"
	item_state = "latex"
	can_hold = list(/obj/item/clothing/gloves/latex)
	w_class = SIZE_SMALL


/obj/item/storage/box/gloves/fill_preset_inventory()
	new /obj/item/clothing/gloves/latex(src)
	new /obj/item/clothing/gloves/latex(src)
	new /obj/item/clothing/gloves/latex(src)
	new /obj/item/clothing/gloves/latex(src)
	new /obj/item/clothing/gloves/latex(src)
	new /obj/item/clothing/gloves/latex(src)
	new /obj/item/clothing/gloves/latex(src)

/obj/item/storage/box/masks
	name = "无菌口罩盒"
	desc = "此盒内含无菌口罩。"
	icon_state = "sterile"
	item_state = "sterile"
	can_hold = list(/obj/item/clothing/mask/surgical)
	w_class = SIZE_SMALL

/obj/item/storage/box/bloodbag
	name = "空血袋盒"
	desc = "这个盒子可以容纳各种血袋。"
	icon_state = "blood"
	item_state = "blood"
	can_hold = list(/obj/item/reagent_container/blood/)
	w_class = SIZE_MEDIUM

/obj/item/storage/box/masks/fill_preset_inventory()
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/clothing/mask/surgical(src)


/obj/item/storage/box/syringes
	name = "注射器盒"
	desc = "一个装满注射器的盒子。"
	desc = "盒子上印有生物危害警报警告。"
	can_hold = list(/obj/item/reagent_container/syringe)
	icon_state = "syringe"
	item_state = "syringe"
	w_class = SIZE_SMALL

/obj/item/storage/box/syringes/fill_preset_inventory()
	new /obj/item/reagent_container/syringe(src)
	new /obj/item/reagent_container/syringe(src)
	new /obj/item/reagent_container/syringe(src)
	new /obj/item/reagent_container/syringe(src)
	new /obj/item/reagent_container/syringe(src)
	new /obj/item/reagent_container/syringe(src)
	new /obj/item/reagent_container/syringe(src)


/obj/item/storage/box/beakers
	name = "烧杯盒"
	icon_state = "beaker"
	item_state = "beaker"
	can_hold = list(/obj/item/reagent_container/glass/beaker)
	w_class = SIZE_MEDIUM

/obj/item/storage/box/beakers/fill_preset_inventory()
	new /obj/item/reagent_container/glass/beaker(src)
	new /obj/item/reagent_container/glass/beaker(src)
	new /obj/item/reagent_container/glass/beaker(src)
	new /obj/item/reagent_container/glass/beaker(src)
	new /obj/item/reagent_container/glass/beaker(src)
	new /obj/item/reagent_container/glass/beaker(src)
	new /obj/item/reagent_container/glass/beaker(src)

/obj/item/storage/box/vials
	name = "小瓶盒"
	icon_state = "vial"
	item_state = "vial"
	can_hold = list(/obj/item/reagent_container/glass/beaker)
	w_class = SIZE_SMALL

/obj/item/storage/box/vials/fill_preset_inventory()
	new /obj/item/reagent_container/glass/beaker/vial(src)
	new /obj/item/reagent_container/glass/beaker/vial(src)
	new /obj/item/reagent_container/glass/beaker/vial(src)
	new /obj/item/reagent_container/glass/beaker/vial(src)
	new /obj/item/reagent_container/glass/beaker/vial(src)
	new /obj/item/reagent_container/glass/beaker/vial(src)
	new /obj/item/reagent_container/glass/beaker/vial(src)

/obj/item/storage/box/sprays
	name = "空喷瓶盒"
	icon_state = "spray"
	item_state = "spray"
	can_hold = list(/obj/item/reagent_container/spray)
	w_class = SIZE_MEDIUM

/obj/item/storage/box/sprays/fill_preset_inventory()
	new /obj/item/reagent_container/spray(src)
	new /obj/item/reagent_container/spray(src)
	new /obj/item/reagent_container/spray(src)
	new /obj/item/reagent_container/spray(src)
	new /obj/item/reagent_container/spray(src)
	new /obj/item/reagent_container/spray(src)
	new /obj/item/reagent_container/spray(src)

/obj/item/storage/box/flashbangs
	name = "闪光弹盒（警告）"
	desc = "<B>警告：这些装置极其危险，反复使用可能导致失明或失聪。</B>"
	icon = 'icons/obj/items/storage/packets.dmi'
	icon_state = "flashbang"
	item_state = "flashbang"
	can_hold = list(/obj/item/explosive/grenade/flashbang)
	w_class = SIZE_MEDIUM

/obj/item/storage/box/flashbangs/fill_preset_inventory()
	new /obj/item/explosive/grenade/flashbang(src)
	new /obj/item/explosive/grenade/flashbang(src)
	new /obj/item/explosive/grenade/flashbang(src)
	new /obj/item/explosive/grenade/flashbang(src)
	new /obj/item/explosive/grenade/flashbang(src)
	new /obj/item/explosive/grenade/flashbang(src)
	new /obj/item/explosive/grenade/flashbang(src)
	if(SSticker.mode && MODE_HAS_FLAG(MODE_FACTION_CLASH))
		handle_delete_clash_contents()
	else if(SSticker.current_state < GAME_STATE_PLAYING)
		RegisterSignal(SSdcs, COMSIG_GLOB_MODE_PRESETUP, PROC_REF(handle_delete_clash_contents))

/obj/item/storage/box/flashbangs/proc/handle_delete_clash_contents()
	SIGNAL_HANDLER
	if(MODE_HAS_FLAG(MODE_FACTION_CLASH))
		var/grenade_count = 0
		var/grenades_desired = 4
		for(var/grenade in contents)
			if(grenade_count > grenades_desired)
				qdel(grenade)
			grenade_count++
	UnregisterSignal(SSdcs, COMSIG_GLOB_MODE_PRESETUP)

/obj/item/storage/box/emps
	name = "电磁脉冲手榴弹盒"
	desc = "装有5枚电磁脉冲手榴弹的盒子。"
	icon = 'icons/obj/items/storage/packets.dmi'
	icon_state = "emp"
	item_state = "emp"

/obj/item/storage/box/emps/fill_preset_inventory()
	new /obj/item/explosive/grenade/empgrenade(src)
	new /obj/item/explosive/grenade/empgrenade(src)
	new /obj/item/explosive/grenade/empgrenade(src)
	new /obj/item/explosive/grenade/empgrenade(src)
	new /obj/item/explosive/grenade/empgrenade(src)


/obj/item/storage/box/trackimp
	name = "盒装追踪植入套件"
	desc = "装满用于追踪人渣的器具的盒子。"
	icon_state = "implant"

/obj/item/storage/box/trackimp/fill_preset_inventory()
	new /obj/item/implantcase/tracking(src)
	new /obj/item/implantcase/tracking(src)
	new /obj/item/implantcase/tracking(src)
	new /obj/item/implantcase/tracking(src)
	new /obj/item/implanter(src)
	new /obj/item/implantpad(src)
	new /obj/item/device/locator(src)

/obj/item/storage/box/chemimp
	name = "盒装化学植入套件"
	desc = "用于植入化学品的材料盒。"
	icon_state = "implant"

/obj/item/storage/box/chemimp/fill_preset_inventory()
	new /obj/item/implantcase/chem(src)
	new /obj/item/implantcase/chem(src)
	new /obj/item/implantcase/chem(src)
	new /obj/item/implantcase/chem(src)
	new /obj/item/implantcase/chem(src)
	new /obj/item/implanter(src)
	new /obj/item/implantpad(src)



/obj/item/storage/box/rxglasses
	name = "处方眼镜盒"
	desc = "这个盒子里装着书呆子眼镜。"
	icon_state = "glasses"
	can_hold = list(/obj/item/clothing/glasses/regular)
	w_class = SIZE_MEDIUM

/obj/item/storage/box/rxglasses/fill_preset_inventory()
	new /obj/item/clothing/glasses/regular(src)
	new /obj/item/clothing/glasses/regular(src)
	new /obj/item/clothing/glasses/regular(src)
	new /obj/item/clothing/glasses/regular(src)
	new /obj/item/clothing/glasses/regular(src)
	new /obj/item/clothing/glasses/regular(src)
	new /obj/item/clothing/glasses/regular(src)

/obj/item/storage/box/wycaps
	name = "公司棒球帽盒"
	desc = "这个盒子里有七顶维兰德-汤谷品牌的棒球帽。请随意分发。"
	icon_state = "mre1"

/obj/item/storage/box/wycaps/fill_preset_inventory()
	new /obj/item/clothing/head/cmcap/wy_cap(src)
	new /obj/item/clothing/head/cmcap/wy_cap(src)
	new /obj/item/clothing/head/cmcap/wy_cap(src)
	new /obj/item/clothing/head/cmcap/wy_cap(src)
	new /obj/item/clothing/head/cmcap/wy_cap(src)
	new /obj/item/clothing/head/cmcap/wy_cap(src)
	new /obj/item/clothing/head/cmcap/wy_cap(src)

/obj/item/storage/box/drinkingglasses
	name = "玻璃杯盒"
	desc = "盒子上印有玻璃杯的图片。"

/obj/item/storage/box/drinkingglasses/fill_preset_inventory()
	new /obj/item/reagent_container/food/drinks/drinkingglass(src)
	new /obj/item/reagent_container/food/drinks/drinkingglass(src)
	new /obj/item/reagent_container/food/drinks/drinkingglass(src)
	new /obj/item/reagent_container/food/drinks/drinkingglass(src)
	new /obj/item/reagent_container/food/drinks/drinkingglass(src)
	new /obj/item/reagent_container/food/drinks/drinkingglass(src)

/obj/item/storage/box/cdeathalarm_kit
	name = "死亡警报套件"
	desc = "用于植入死亡警报的器具盒。"
	icon_state = "implant"
	item_state = "box"

/obj/item/storage/box/cdeathalarm_kit/fill_preset_inventory()
	new /obj/item/implanter(src)
	new /obj/item/implantcase/death_alarm(src)
	new /obj/item/implantcase/death_alarm(src)
	new /obj/item/implantcase/death_alarm(src)
	new /obj/item/implantcase/death_alarm(src)
	new /obj/item/implantcase/death_alarm(src)
	new /obj/item/implantcase/death_alarm(src)

/obj/item/storage/box/condimentbottles
	name = "调味瓶盒"
	desc = "盒子上有一大块番茄酱污渍。"

/obj/item/storage/box/condimentbottles/fill_preset_inventory()
	new /obj/item/reagent_container/food/condiment(src)
	new /obj/item/reagent_container/food/condiment(src)
	new /obj/item/reagent_container/food/condiment(src)
	new /obj/item/reagent_container/food/condiment(src)
	new /obj/item/reagent_container/food/condiment(src)
	new /obj/item/reagent_container/food/condiment(src)



/obj/item/storage/box/cups
	name = "纸杯盒"
	desc = "盒子正面印有纸杯的图片。"

/obj/item/storage/box/cups/fill_preset_inventory()
	new /obj/item/reagent_container/food/drinks/sillycup( src )
	new /obj/item/reagent_container/food/drinks/sillycup( src )
	new /obj/item/reagent_container/food/drinks/sillycup( src )
	new /obj/item/reagent_container/food/drinks/sillycup( src )
	new /obj/item/reagent_container/food/drinks/sillycup( src )
	new /obj/item/reagent_container/food/drinks/sillycup( src )
	new /obj/item/reagent_container/food/drinks/sillycup( src )

/obj/item/storage/box/donkpockets
	name = "唐克口袋饼盒"
	desc = "<B>使用说明：</B> <I>微波加热。产品若在七分钟内未食用将会冷却。</I>"
	icon_state = "donk_kit"
	item_state = "donk_kit"
	can_hold = list(/obj/item/reagent_container/food/snacks)
	w_class = SIZE_MEDIUM

/obj/item/storage/box/donkpockets/fill_preset_inventory()
	new /obj/item/reagent_container/food/snacks/donkpocket(src)
	new /obj/item/reagent_container/food/snacks/donkpocket(src)
	new /obj/item/reagent_container/food/snacks/donkpocket(src)
	new /obj/item/reagent_container/food/snacks/donkpocket(src)
	new /obj/item/reagent_container/food/snacks/donkpocket(src)
	new /obj/item/reagent_container/food/snacks/donkpocket(src)

/obj/item/storage/box/teabags
	name = "伯爵红茶茶包盒"
	desc = "一盒速溶茶包。"
	icon_state = "teabag_box"
	item_state = "teabag_box"
	can_hold = list(/obj/item/reagent_container/pill/teabag)
	w_class = SIZE_SMALL
	storage_slots = 8

/obj/item/storage/box/teabags/fill_preset_inventory()
	new /obj/item/reagent_container/pill/teabag/earl_grey(src)
	new /obj/item/reagent_container/pill/teabag/earl_grey(src)
	new /obj/item/reagent_container/pill/teabag/earl_grey(src)
	new /obj/item/reagent_container/pill/teabag/earl_grey(src)
	new /obj/item/reagent_container/pill/teabag/earl_grey(src)
	new /obj/item/reagent_container/pill/teabag/earl_grey(src)
	new /obj/item/reagent_container/pill/teabag/earl_grey(src)
	new /obj/item/reagent_container/pill/teabag/earl_grey(src)

/obj/item/storage/box/lemondrop
	name = "柠檬糖盒"
	desc = "一盒柠檬味硬糖。"
	icon_state = "lemon_drop_box"
	item_state = "lemon_drop_box"
	can_hold = list(/obj/item/reagent_container/food/snacks/lemondrop)
	w_class = SIZE_SMALL
	storage_slots = 8

/obj/item/storage/box/lemondrop/fill_preset_inventory()
	new /obj/item/reagent_container/food/snacks/lemondrop(src)
	new /obj/item/reagent_container/food/snacks/lemondrop(src)
	new /obj/item/reagent_container/food/snacks/lemondrop(src)
	new /obj/item/reagent_container/food/snacks/lemondrop(src)
	new /obj/item/reagent_container/food/snacks/lemondrop(src)
	new /obj/item/reagent_container/food/snacks/lemondrop(src)
	new /obj/item/reagent_container/food/snacks/lemondrop(src)
	new /obj/item/reagent_container/food/snacks/lemondrop(src)

/obj/item/storage/box/monkeycubes
	name = "猴子方块盒"
	desc = "Drymate牌猴子方块。加水即可！"
	icon = 'icons/obj/items/storage/boxes.dmi'
	icon_state = "monkeycubebox"
	item_state = "monkeycubebox"

/obj/item/storage/box/monkeycubes/fill_preset_inventory()
	for(var/i = 1; i <= 5; i++)
		new /obj/item/reagent_container/food/snacks/monkeycube/wrapped(src)

/obj/item/storage/box/monkeycubes/farwacubes
	name = "法瓦方块盒"
	desc = "Drymate牌法瓦方块，从阿多米运来。加水即可！"

/obj/item/storage/box/monkeycubes/farwacubes/fill_preset_inventory()
	for(var/i = 1; i <= 5; i++)
		new /obj/item/reagent_container/food/snacks/monkeycube/wrapped/farwacube(src)

/obj/item/storage/box/monkeycubes/stokcubes
	name = "斯托克方块盒"
	desc = "Drymate牌斯托克方块，从莫赫斯运来。加水即可！"

/obj/item/storage/box/monkeycubes/stokcubes/fill_preset_inventory()
	for(var/i = 1; i <= 5; i++)
		new /obj/item/reagent_container/food/snacks/monkeycube/wrapped/stokcube(src)

/obj/item/storage/box/monkeycubes/neaeracubes
	name = "尼埃拉方块盒"
	desc = "Drymate牌尼埃拉方块，从贾贡4号运来。加水即可！"

/obj/item/storage/box/monkeycubes/neaeracubes/fill_preset_inventory()
	for(var/i = 1; i <= 5; i++)
		new /obj/item/reagent_container/food/snacks/monkeycube/wrapped/neaeracube(src)

/obj/item/storage/box/monkeycubes/yautja
	name = "奇怪方块盒"
	desc = "一个标签印有未知语言的盒子。"
	icon_state = "box_of_doom"

/obj/item/storage/box/ids
	name = "备用身份卡盒"
	desc = "有好多空白身份卡。"
	icon_state = "id"
	item_state = "id"

/obj/item/storage/box/ids/fill_preset_inventory()
	new /obj/item/card/id(src)
	new /obj/item/card/id(src)
	new /obj/item/card/id(src)
	new /obj/item/card/id(src)
	new /obj/item/card/id(src)
	new /obj/item/card/id(src)
	new /obj/item/card/id(src)


/obj/item/storage/box/handcuffs
	name = "手铐盒"
	desc = "一盒手铐。"
	icon_state = "handcuff"
	item_state = "handcuff"

/obj/item/storage/box/handcuffs/fill_preset_inventory()
	new /obj/item/restraint/handcuffs(src)
	new /obj/item/restraint/handcuffs(src)
	new /obj/item/restraint/handcuffs(src)
	new /obj/item/restraint/handcuffs(src)
	new /obj/item/restraint/handcuffs(src)
	new /obj/item/restraint/handcuffs(src)
	new /obj/item/restraint/handcuffs(src)


/obj/item/storage/box/legcuffs
	name = "脚镣盒"
	desc = "一盒脚镣。"
	icon_state = "handcuff"
	item_state = "handcuff"

/obj/item/storage/box/legcuffs/fill_preset_inventory()
	new /obj/item/restraint/legcuffs(src)
	new /obj/item/restraint/legcuffs(src)
	new /obj/item/restraint/legcuffs(src)
	new /obj/item/restraint/legcuffs(src)
	new /obj/item/restraint/legcuffs(src)
	new /obj/item/restraint/legcuffs(src)
	new /obj/item/restraint/legcuffs(src)

/obj/item/storage/box/zipcuffs
	name = "塑料束带盒"
	desc = "一盒塑料束带。"
	w_class = SIZE_MEDIUM
	icon_state = "handcuff"
	item_state = "handcuff"

/obj/item/storage/box/zipcuffs/fill_preset_inventory()
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)

/obj/item/storage/box/zipcuffs/small
	name = "小盒塑料束带"
	desc = "一小盒塑料束带。"
	w_class = SIZE_MEDIUM
	max_storage_space = 7

/obj/item/storage/box/zipcuffs/small/fill_preset_inventory()
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)
	new /obj/item/restraint/handcuffs/zip(src)

/obj/item/storage/box/tapes
	name = "规章胶带盒"
	desc = "一个装满录音磁带的盒子。包含10小时40分钟的录音空间！"

/obj/item/storage/box/tapes/fill_preset_inventory()
	new /obj/item/tape/regulation(src)
	new /obj/item/tape/regulation(src)
	new /obj/item/tape/regulation(src)
	new /obj/item/tape/regulation(src)
	new /obj/item/tape/regulation(src)
	new /obj/item/tape/regulation(src)
	new /obj/item/tape/regulation(src)
	new /obj/item/tape/regulation(src)
	new /obj/item/tape/regulation(src)
	new /obj/item/tape/regulation(src)
	new /obj/item/tape/regulation(src)
	new /obj/item/tape/regulation(src)
	new /obj/item/tape/regulation(src)
	new /obj/item/tape/regulation(src)

/obj/item/storage/box/mousetraps
	name = "一盒害虫必除捕鼠器"
	desc = "<B><FONT color='red'>警告：</FONT></B> <I>请置于儿童接触不到的地方</I>。"
	icon_state = "mousetraps"
	item_state = "mousetraps"

/obj/item/storage/box/mousetraps/fill_preset_inventory()
	new /obj/item/device/assembly/mousetrap( src )
	new /obj/item/device/assembly/mousetrap( src )
	new /obj/item/device/assembly/mousetrap( src )
	new /obj/item/device/assembly/mousetrap( src )
	new /obj/item/device/assembly/mousetrap( src )
	new /obj/item/device/assembly/mousetrap( src )

/obj/item/storage/box/pillbottles
	name = "一盒药瓶"
	desc = "它的正面印有药瓶的图案。"
	icon_state = "pillbox"
	item_state = "pillbox"

	storage_flags = STORAGE_FLAGS_BOX|STORAGE_CLICK_GATHER|STORAGE_GATHER_SIMULTANEOUSLY
	can_hold = list(
		/obj/item/storage/pill_bottle,
	)

	//multiplier to time required to empty the box into chem master
	var/time_to_empty = 0.3 SECONDS


/obj/item/storage/box/pillbottles/fill_preset_inventory()
	new /obj/item/storage/pill_bottle( src )
	new /obj/item/storage/pill_bottle( src )
	new /obj/item/storage/pill_bottle( src )
	new /obj/item/storage/pill_bottle( src )
	new /obj/item/storage/pill_bottle( src )
	new /obj/item/storage/pill_bottle( src )
	new /obj/item/storage/pill_bottle( src )


/obj/item/storage/box/snappops
	name = "摔炮盒"
	desc = "八份包装的乐趣！适合8岁及以上。不适合儿童。"
	icon = 'icons/obj/items/toy.dmi'
	icon_state = "spbox"
	max_storage_space = 8

/obj/item/storage/box/snappops/fill_preset_inventory()
	for(var/i=1; i <= 8; i++)
		new /obj/item/toy/snappop(src)

/obj/item/storage/box/matches
	name = "matchbox"
	desc = "一小盒‘太空级’高级火柴。"
	icon = 'icons/obj/items/smoking/matches.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/smoking_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/smoking_righthand.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/smoking.dmi'
		)
	icon_state = "matchbox"
	item_state = "matchbox"
	item_state_slots = list(WEAR_AS_GARB = "matches")
	w_class = SIZE_TINY
	flags_equip_slot = SLOT_WAIST
	flags_obj = parent_type::flags_obj|OBJ_IS_HELMET_GARB
	can_hold = list(/obj/item/tool/match)

/obj/item/storage/box/matches/fill_preset_inventory()
	for(var/i=1; i <= 14; i++)
		new /obj/item/tool/match(src)

/obj/item/storage/box/matches/attackby(obj/item/tool/match/W as obj, mob/user as mob)
	if(istype(W) && !W.heat_source && !W.burnt)
		W.light_match(user)

/obj/item/storage/box/lights
	name = "一盒替换灯泡"
	icon = 'icons/obj/items/storage/boxes.dmi'
	icon_state = "light"
	desc = "这个盒子的内部形状只能容纳灯管和灯泡。"
	item_state = "light"
	foldable = /obj/item/stack/sheet/cardboard //BubbleWrap
	can_hold = list(
		/obj/item/light_bulb/tube,
		/obj/item/light_bulb/bulb,
	)
	max_storage_space = 42 //holds 21 items of w_class 2
	storage_flags = STORAGE_FLAGS_BOX|STORAGE_CLICK_GATHER

/obj/item/storage/box/lights/bulbs/fill_preset_inventory()
	for(var/i = 0; i < 21; i++)
		new /obj/item/light_bulb/bulb(src)

/obj/item/storage/box/lights/tubes
	name = "一盒替换灯管"
	icon_state = "lighttube"
	item_state = "lighttube"
	w_class = SIZE_MEDIUM

/obj/item/storage/box/lights/tubes/fill_preset_inventory()
	for(var/i = 0; i < 21; i++)
		new /obj/item/light_bulb/tube/large(src)

/obj/item/storage/box/lights/mixed
	name = "一盒替换灯具"
	icon_state = "lightmixed"
	item_state = "lightmixed"

/obj/item/storage/box/lights/mixed/fill_preset_inventory()
	for(var/i = 0; i < 14; i++)
		new /obj/item/light_bulb/tube/large(src)
	for(var/i = 0; i < 7; i++)
		new /obj/item/light_bulb/bulb(src)


/obj/item/storage/box/autoinjectors
	name = "一盒自动注射器"
	icon_state = "syringe"
	item_state = "syringe"

/obj/item/storage/box/autoinjectors/fill_preset_inventory()
	for(var/i = 0; i < 7; i++)
		new /obj/item/reagent_container/hypospray/autoinjector/empty(src)


/obj/item/storage/box/twobore
	name = "一盒2号口径霰弹"
	icon_state = "twobore"
	icon = 'icons/obj/items/storage/kits.dmi'
	desc = "一个装满巨大独头弹的盒子，仅用于狩猎最危险的猎物。2号口径。"
	storage_slots = 5
	can_hold = list(/obj/item/ammo_magazine/handful/shotgun/twobore)

/obj/item/storage/box/twobore/fill_preset_inventory()
	for(var/i in 1 to storage_slots)
		new /obj/item/ammo_magazine/handful/shotgun/twobore(src)

/obj/item/storage/box/stompers
	name = "\improper Reebok shoe box"
	desc = "一个花哨的鞋盒，表面反光，顶部有维兰德-汤谷标志，背面写着‘锐步践踏者’。"
	icon_state = "stomper_box"
	item_state = "stomper_box"
	w_class = SIZE_MEDIUM
	bypass_w_limit = /obj/item/clothing/shoes
	max_storage_space = 3
	can_hold = list(/obj/item/clothing/shoes)

/obj/item/storage/box/stompers/fill_preset_inventory()
	new /obj/item/clothing/shoes/stompers(src)

/obj/item/storage/box/stompers/update_icon()
	if(!length(contents))
		icon_state = "stomper_box_e"
	else
		icon_state = "stomper_box"

////////// MARINES BOXES //////////////////////////


/obj/item/storage/box/explosive_mines
	name = "\improper M20 mine box"
	desc = "一个安全箱，内装五枚M20反步兵近程地雷。"
	icon = 'icons/obj/items/storage/packets.dmi'
	icon_state = "minebox"
	item_state = "minebox"
	w_class = SIZE_MEDIUM
	max_storage_space = 10
	can_hold = list(/obj/item/explosive/mine)

/obj/item/storage/box/explosive_mines/fill_preset_inventory()
	for(var/i in 1 to 5)
		new /obj/item/explosive/mine(src)

/obj/item/storage/box/explosive_mines/pmc
	name = "\improper M20P mine box"

/obj/item/storage/box/explosive_mines/pmc/fill_preset_inventory()
	for(var/i in 1 to 5)
		new /obj/item/explosive/mine/pmc(src)

/obj/item/storage/box/m94
	name = "\improper M94 marking flare pack"
	desc = "一包八枚M94标记照明弹。由USCM士兵携带，用于照亮普通TNR肩灯无法触及的黑暗区域。"
	icon_state = "m94"
	icon = 'icons/obj/items/storage/packets.dmi'
	w_class = SIZE_MEDIUM
	storage_slots = 8
	max_storage_space = 8
	can_hold = list(/obj/item/device/flashlight/flare,/obj/item/device/flashlight/flare/signal)

/obj/item/storage/box/m94/fill_preset_inventory()
	for(var/i = 1 to max_storage_space)
		new /obj/item/device/flashlight/flare(src)

/obj/item/storage/box/m94/update_icon()
	if(!length(contents))
		icon_state = "m94_e"
	else
		icon_state = "m94"


/obj/item/storage/box/m94/signal
	name = "\improper M89-S signal flare pack"
	desc = "一包八枚M89-S信号标记照明弹。"
	icon_state = "m89"

/obj/item/storage/box/m94/signal/fill_preset_inventory()
	for(var/i = 1 to max_storage_space)
		new /obj/item/device/flashlight/flare/signal(src)

/obj/item/storage/box/m94/signal/update_icon()
	if(!length(contents))
		icon_state = "m89_e"
	else
		icon_state = "m89"


/obj/item/storage/box/nade_box
	name = "\improper M40 HEDP grenade box"
	desc = "一个安全箱，内装25枚M40高爆双用途手榴弹。高爆炸性，请勿存放在火焰喷射器燃料附近。"
	icon_state = "nade_placeholder"
	item_state = "nade_placeholder"
	icon = 'icons/obj/items/storage/packets.dmi'
	w_class = SIZE_LARGE
	storage_slots = 25
	max_storage_space = 50
	can_hold = list(/obj/item/explosive/grenade/high_explosive)
	var/base_icon
	var/model_icon = "model_m40"
	var/type_icon = "hedp"
	var/grenade_type = /obj/item/explosive/grenade/high_explosive
	flags_atom = FPRINT|CONDUCT|MAP_COLOR_INDEX
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items_by_map/jungle_righthand.dmi'
	)

/obj/item/storage/box/nade_box/Initialize()
	. = ..()
	if(!(flags_atom & NO_GAMEMODE_SKIN))
		select_gamemode_skin()
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(try_forced_folding))

/obj/item/storage/box/nade_box/proc/try_forced_folding(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!isturf(loc))
		return

	if(length(contents))
		return

	UnregisterSignal(src, COMSIG_ITEM_DROPPED)
	storage_close(user)
	to_chat(user, SPAN_NOTICE("你扔掉了[src]。"))
	qdel(src)

/obj/item/storage/box/nade_box/post_skin_selection()
	base_icon = icon_state

/obj/item/storage/box/nade_box/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new grenade_type(src)

/obj/item/storage/box/nade_box/update_icon()
	overlays.Cut()
	if(!length(contents))
		icon_state = "[base_icon]_e"
	else
		icon_state = base_icon
		if(type_icon)
			overlays += image(icon, type_icon)
		if(model_icon)
			overlays += image(icon, model_icon)


/obj/item/storage/box/nade_box/frag
	name = "\improper M40 HEFA grenade box"
	desc = "一个安全箱，内装25枚M40高爆破片反步兵手榴弹。高爆炸性，请勿存放在火焰喷射器燃料附近。"
	type_icon = "hefa"
	can_hold = list(/obj/item/explosive/grenade/high_explosive/frag)
	grenade_type = /obj/item/explosive/grenade/high_explosive/frag

/obj/item/storage/box/nade_box/phophorus
	name = "\improper M40 CCDP grenade box"
	desc = "一个安全箱，内装25枚M40 CCDP化合物手榴弹。高爆炸性，请勿存放在火焰喷射器燃料附近。"
	type_icon = "ccdp"
	can_hold = list(/obj/item/explosive/grenade/phosphorus)
	grenade_type = /obj/item/explosive/grenade/phosphorus

/obj/item/storage/box/nade_box/incen
	name = "\improper M40 HIDP grenade box"
	desc = "一个安全箱，内装25枚M40 HIDP白色燃烧手榴弹。高度易燃，请勿存放在火焰喷射器燃料附近。"
	type_icon = "hidp"
	can_hold = list(/obj/item/explosive/grenade/incendiary)
	grenade_type = /obj/item/explosive/grenade/incendiary

/obj/item/storage/box/nade_box/airburst
	name = "\improper M74 AGM-F grenade box"
	desc = "一个安全箱，内装25枚M74 AGM破片手榴弹。爆炸物，请勿存放在火焰喷射器燃料附近。"
	model_icon = "model_m74"
	type_icon = "agmf"
	can_hold = list(/obj/item/explosive/grenade/high_explosive/airburst)
	grenade_type = /obj/item/explosive/grenade/high_explosive/airburst

/obj/item/storage/box/nade_box/airburstincen
	name = "\improper M74 AGM-I grenade box"
	desc = "一个装有25枚M74 AGM燃烧手榴弹的安全箱。高度易燃，请勿靠近喷火器燃料存放。"
	model_icon = "model_m74"
	type_icon = "agmi"
	can_hold = list(/obj/item/explosive/grenade/incendiary/airburst)
	grenade_type = /obj/item/explosive/grenade/incendiary/airburst


/obj/item/storage/box/nade_box/training
	name = "\improper M07 training grenade box"
	desc = "一个装有25枚M07训练手榴弹的安全箱。无害且可重复使用。"
	icon_state = "train_nade_placeholder"
	item_state = "train_nade_placeholder"
	model_icon = "model_mo7"
	type_icon = null
	grenade_type = /obj/item/explosive/grenade/high_explosive/training
	can_hold = list(/obj/item/explosive/grenade/high_explosive/training)
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

/obj/item/storage/box/nade_box/tear_gas
	name = "\improper M66 tear gas grenade box"
	desc = "一个装有25枚M66催泪瓦斯手榴弹的安全箱。用于防暴控制。"
	icon_state = "teargas_nade_placeholder"
	item_state = "teargas_nade_placeholder"
	model_icon = "model_m66"
	type_icon = null
	can_hold = list(/obj/item/explosive/grenade/custom/teargas)
	grenade_type = /obj/item/explosive/grenade/custom/teargas
	flags_atom = FPRINT|NO_GAMEMODE_SKIN // same sprite for all gamemodes

/obj/item/storage/box/nade_box/tear_gas/fill_preset_inventory()
	..()
	if(SSticker.mode && MODE_HAS_FLAG(MODE_FACTION_CLASH))
		handle_delete_clash_contents()
	else if(SSticker.current_state < GAME_STATE_PLAYING)
		RegisterSignal(SSdcs, COMSIG_GLOB_MODE_PRESETUP, PROC_REF(handle_delete_clash_contents))

/obj/item/storage/box/nade_box/tear_gas/proc/handle_delete_clash_contents()
	if(MODE_HAS_FLAG(MODE_FACTION_CLASH))
		var/grenade_count = 0
		var/grenades_desired = 6
		for(var/grenade in contents)
			if(grenade_count > grenades_desired)
				qdel(grenade)
			grenade_count++
	UnregisterSignal(SSdcs, COMSIG_GLOB_MODE_PRESETUP)


//ITEMS-----------------------------------//
/obj/item/storage/box/lightstick
	name = "一箱荧光棒"
	desc = "内含蓝色荧光棒。"
	icon_state = "lightstick"
	item_state = "lightstick"
	can_hold = list(/obj/item/lightstick)

/obj/item/storage/box/lightstick/fill_preset_inventory()
	new /obj/item/lightstick(src)
	new /obj/item/lightstick(src)
	new /obj/item/lightstick(src)
	new /obj/item/lightstick(src)
	new /obj/item/lightstick(src)
	new /obj/item/lightstick(src)
	new /obj/item/lightstick(src)

/obj/item/storage/box/lightstick/red
	desc = "内含红色荧光棒。"
	icon_state = "lightstick2"
	item_state = "lightstick2"

/obj/item/storage/box/lightstick/red/fill_preset_inventory()
	new /obj/item/lightstick/red(src)
	new /obj/item/lightstick/red(src)
	new /obj/item/lightstick/red(src)
	new /obj/item/lightstick/red(src)
	new /obj/item/lightstick/red(src)
	new /obj/item/lightstick/red(src)
	new /obj/item/lightstick/red(src)

//food boxes for storage in bulk

//meat
/obj/item/storage/box/meat
	name = "一箱肉"

/obj/item/storage/box/meat/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/meat/monkey(src)

//fish
/obj/item/storage/box/fish
	name = "一箱鱼"

/obj/item/storage/box/fish/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/carpmeat(src)

//grocery

//milk
/obj/item/storage/box/milk
	name = "一箱牛奶"

/obj/item/storage/box/milk/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/drinks/milk(src)

//soymilk
/obj/item/storage/box/soymilk
	name = "一箱豆奶"

/obj/item/storage/box/soymilk/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/drinks/soymilk(src)

//enzyme
/obj/item/storage/box/enzyme
	name = "一箱酶"

/obj/item/storage/box/enzyme/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/condiment/enzyme(src)

//dry storage

//flour
/obj/item/storage/box/flour
	name = "一箱面粉"

/obj/item/storage/box/flour/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/flour(src)

//sugar
/obj/item/storage/box/sugar
	name = "一箱糖"

/obj/item/storage/box/sugar/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/condiment/sugar(src)

//saltshaker
/obj/item/storage/box/saltshaker
	name = "一箱盐瓶"

/obj/item/storage/box/saltshaker/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/condiment/saltshaker(src)

//peppermill
/obj/item/storage/box/peppermill
	name = "一箱胡椒研磨器"

/obj/item/storage/box/peppermill/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/condiment/peppermill(src)

//mint
/obj/item/storage/box/mint
	name = "一箱薄荷糖"

/obj/item/storage/box/mint/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/mint(src)

// ORGANICS

//apple
/obj/item/storage/box/apple
	name = "一箱苹果"

/obj/item/storage/box/apple/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/apple(src)

//banana
/obj/item/storage/box/banana
	name = "一箱香蕉"

/obj/item/storage/box/banana/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/banana(src)

//chanterelle
/obj/item/storage/box/chanterelle
	name = "一箱鸡油菌"

/obj/item/storage/box/chanterelle/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/mushroom/chanterelle(src)

//cherries
/obj/item/storage/box/cherries
	name = "一箱樱桃"

/obj/item/storage/box/cherries/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/cherries(src)

//chili
/obj/item/storage/box/chili
	name = "一箱辣椒"

/obj/item/storage/box/chili/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/chili(src)

//cabbage
/obj/item/storage/box/cabbage
	name = "一箱卷心菜"

/obj/item/storage/box/cabbage/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/cabbage(src)

//carrot
/obj/item/storage/box/carrot
	name = "一箱胡萝卜"

/obj/item/storage/box/carrot/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/carrot(src)

//corn
/obj/item/storage/box/corn
	name = "一箱玉米"

/obj/item/storage/box/corn/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/corn(src)

//eggplant
/obj/item/storage/box/eggplant
	name = "一箱茄子"

/obj/item/storage/box/eggplant/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/eggplant(src)

//lemon
/obj/item/storage/box/lemon
	name = "一箱柠檬"

/obj/item/storage/box/lemon/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/lemon(src)

//lime
/obj/item/storage/box/lime
	name = "一箱青柠"

/obj/item/storage/box/lime/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/lime(src)

//orange
/obj/item/storage/box/orange
	name = "一箱橙子"

/obj/item/storage/box/orange/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/orange(src)

//potato
/obj/item/storage/box/potato
	name = "一箱土豆"

/obj/item/storage/box/potato/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/potato(src)

//tomato
/obj/item/storage/box/tomato
	name = "一箱番茄"

/obj/item/storage/box/tomato/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/tomato(src)

//whitebeet
/obj/item/storage/box/whitebeet
	name = "一箱白甜菜"

/obj/item/storage/box/whitebeet/fill_preset_inventory()
	for(var/i in 1 to 7)
		new /obj/item/reagent_container/food/snacks/grown/whitebeet(src)
