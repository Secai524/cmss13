// Surgery Tools
/obj/item/tool/surgery
	icon = 'icons/obj/items/surgery_tools.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
	)
	attack_speed = 4

/*
 * Retractor
 * Usual substitutes: crowbar for heavy prying, wirecutter for fine adjustment. Fork for extremely fine work.
 */
/obj/item/tool/surgery/retractor
	name = "retractor"
	desc = "一种外科手术工具，用于撑开皮肤、组织或器官，以暴露和进入手术部位。"
	icon_state = "retractor"
	hitsound = 'sound/weapons/genhit3.ogg'
	force = 10
	throwforce = 1
	matter = list("metal" = 10000, "glass" = 5000)
	flags_atom = FPRINT|CONDUCT
	w_class = SIZE_SMALL
	attack_verb = list("attacked", "hit", "bludgeoned", "pummeled", "beat")

/obj/item/tool/surgery/retractor/predatorretractor
	name = "opener"
	icon_state = "predator_retractor"

/*
 * Hemostat
 * Usual substitutes: wirecutter for clamping bleeds or pulling things out, fork for extremely fine work, surgical line/fixovein/cable coil for tying up blood vessels.
 */
/obj/item/tool/surgery/hemostat
	name = "hemostat"
	desc = "一种外科手术工具，通过夹闭血管来控制出血。也可用于取出异物，以及操作和提起小型器官和组织。"
	icon_state = "hemostat"
	hitsound = 'sound/weapons/pierce.ogg'
	matter = list("metal" = 5000, "glass" = 2500)
	force = 10
	sharp = IS_SHARP_ITEM_SIMPLE
	flags_atom = FPRINT|CONDUCT
	w_class = SIZE_SMALL
	attack_verb = list("attacked", "pinched", "pierced", "punctured")

/obj/item/tool/surgery/hemostat/predatorhemostat
	name = "pincher"
	icon_state = "predator_hemostat"

/*
 * Cautery
 * Usual substitutes: cigarettes, lighters, welding tools.
 */
/obj/item/tool/surgery/cautery
	name = "cautery"
	desc = "一种外科手术工具，利用高温止血、封闭血管并去除不需要的组织。通过灼烧来闭合切口。"
	icon_state = "cautery"
	matter = list("metal" = 5000, "glass" = 2500)
	force = 10
	throwforce = 1
	damtype = "fire"
	hitsound = 'sound/surgery/cautery2.ogg'
	flags_atom = FPRINT|CONDUCT
	w_class = SIZE_TINY
	flags_item = ANIMATED_SURGICAL_TOOL
	attack_verb = list("burned", "seared", "scorched", "singed")

/obj/item/tool/surgery/cautery/predatorcautery
	name = "cauterizer"
	icon_state = "predator_cautery"
	flags_item = NO_FLAGS

/*
 * Surgical Drill
 * Usual substitutes: pen, metal rods.
 */
/obj/item/tool/surgery/surgicaldrill
	name = "手术钻"
	desc = "一种外科手术工具，用于钻穿骨骼，为植入目的制造空腔。"
	icon_state = "drill"
	hitsound = 'sound/weapons/circsawhit.ogg'
	matter = list("metal" = 15000, "glass" = 10000)
	flags_atom = FPRINT|CONDUCT
	force = 25
	attack_speed = 9
	throwforce = 9
	sharp = IS_SHARP_ITEM_ACCURATE //it makes holes in skin and bone... Yes, sharp.
	w_class = SIZE_SMALL
	attack_verb = list("drilled", "bored", "gored", "perforated")

/obj/item/tool/surgery/surgicaldrill/predatorsurgicaldrill
	name = "骨钻"
	icon_state = "predator_drill"

/*
 * Scalpel
 * Usual substitutes: bayonets, kitchen knives, glass shards.
 */
/obj/item/tool/surgery/scalpel
	name = "scalpel"
	desc = "一种外科手术工具，用于切开切口、清创病变组织，并通过切割动作分离肌肉和器官。也可用于取出异物。是大多数手术的开端。"
	icon_state = "scalpel"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/equipment/medical_righthand.dmi',
		WEAR_AS_GARB = 'icons/mob/humans/onmob/clothing/helmet_garb/medical.dmi',
	)
	flags_atom = FPRINT|CONDUCT
	force = 10
	sharp = IS_SHARP_ITEM_ACCURATE
	edge = 1
	demolition_mod = 0.1
	w_class = SIZE_TINY
	throwforce = 5
	flags_item = CAN_DIG_SHRAPNEL
	throw_speed = SPEED_VERY_FAST
	throw_range = 5
	matter = list("metal" = 10000, "glass" = 5000)
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/tool/surgery/scalpel/predatorscalpel
	name = "cutter"
	icon_state = "predator_scalpel"

/*
 * Researchable Scalpels
 */
/obj/item/tool/surgery/scalpel/laser
	name = "原型激光手术刀"
	desc = "一种配备了定向激光的手术刀，可在切开时控制出血并起到烧灼作用。可惜这只是原型机，看起来像是将过热的激光粗糙地安装在改装过的手术刀上，所以别指望有什么奇迹。"
	desc_lore = "The prototype laser scalpel was developed during the mid-1900s, a time where scientists had yet to solve their quandary of developing a laser that could cut through flesh and and burn the blood vessels closed simultaneously; they settled on a compromise: slapping a superheated directed laser beneath the blade of the scalpel and hoping the laser burns the incision the blade makes. While the prototype ironically functioned perfectly as a cautery, it left something to be desired where bloodless incisions were a concern. Somehow, the big heads in research forgot to calibrate the width of the laser to be equivalent to the precise width of the incision made by the blade, leaving some blood vessels untouched in the process."
	icon_state = "scalpel_laser"
	damtype = "fire"
	flags_item = ANIMATED_SURGICAL_TOOL
	///The likelihood an incision made with this will be bloodless.
	var/bloodlessprob = 60
	black_market_value = 15

/obj/item/tool/surgery/scalpel/laser/improved
	name = "激光手术刀"
	desc = "一种配备定向激光的手术刀，可在切开时控制出血并起到烧灼作用。此标准型号使用二氧化碳激光汽化组织并封闭血管，但切口并非总是无血的。"
	desc_lore = "After figuring out how to make a laser that incises flesh, the prototype and its blade became nothing more than a distant memory and a reminder to not haphazardly slap two independently-functioning tools together and praying to Spess Jesus they will in tandem with one another. This design, hailing from the early 2000s, uses a CO2 laser to create an incision by using an invisible infrared beam that vaporizes tissue while sealing blood vessels. While pinpoint bleeding occurs on occasion, the laser scalpel is a perfect, if not expensive alternative to replacing a standard scalpel and cautery."
	icon_state = "scalpel_laser_2"
	damtype = "fire"
	bloodlessprob = 80
	black_market_value = 20

/obj/item/tool/surgery/scalpel/laser/advanced
	name = "高级激光手术刀"
	desc = "一种配备定向激光的手术刀，用于在切开时控制出血并起到烧灼作用。其激光具备智能探测技术，可瞄准并烧灼附近所有血管，代表了精密能量切割器具的巅峰！"
	desc_lore = "Scientists perfected the standard model by using a much stronger type of laser that creates explosions on the microscopic scale to vaporize any tissue and blood vessels in its way as it makes an incision. With a 100% success rate in creating bloodless incision, these scalpels have no issue taking the place of scalpels and cauteries, despite their exorbitant price tags."
	icon_state = "scalpel_laser_3"
	damtype = "fire"
	bloodlessprob = 100
	black_market_value = 25

/*
 * Special Variants
 */

/obj/item/tool/surgery/scalpel/pict_system
	name = "\improper PICT system"
	desc = "血管周切开烧灼工具采用高频振动刀片和抽吸液体控制系统，可精确瞄准并摧毁为肿瘤供血的淋巴和血管系统，同时抽吸可能含有游离癌细胞的液体。由于其专用于切割特定组织，在开始手术时比手术刀慢得多，且无法进行全程无血切开。"
	desc_lore = "The PICT system has humble origins as yet another tool developed for cancer research. Designed to identify, sever and cauterize the lymphatic and vascular systems feeding tumors, it accomplishes goals with aplomb and is the standard tool for cutting and burning off nutrient supplies to tumors before extraction. Due to its mechanisms of targeting specific types of cells while incising and suctioning, it struggles to create a full-length incision bloodlessly."
	icon_state = "pict_system"
	force = 15
	attack_speed = 6
	w_class = SIZE_SMALL
	black_market_value = 25

/obj/item/tool/surgery/scalpel/manager
	name = "切口管理系统"
	desc = "这是外科医生身体的真正延伸，这个奇迹能瞬间、完全地同时准备并扩大切口，且无出血，从而立即开始治疗步骤。它只能用于开始手术。"
	desc_lore = "Thousands of surgeons across the galaxy can only dream of holding one of these in their hands. With the technology of an advanced laser scalpel and a mechanical retractor all in one tool, a surgeon can incise, seal blood vessels, and widen incisions all in one step. Sadly, the tool is overhyped, aiding in its unconscionable price tag; it cannot function as a retractor, hemostat, cautery in any circumstances other than making an incision."
	force = 15
	attack_speed = 6
	icon_state = "scalpel_manager"
	flags_item = ANIMATED_SURGICAL_TOOL
	black_market_value = 25

/*
 * Circular Saw
 * Usual substitutes: fire axes, machetes, hatchets, butcher's knife, bayonet. Bayonet is better than axes etc. for sawing ribs/skull, worse for amputation.
 */

/obj/item/tool/surgery/circular_saw
	name = "圆锯"
	desc = "一种外科工具，用于在撬开颅骨和胸腔的厚骨之前将其锯开，或用于截除病变肢体。"
	icon_state = "saw"
	hitsound = 'sound/weapons/circsawhit.ogg'
	flags_atom = FPRINT|CONDUCT
	force = 25
	attack_speed = 9
	sharp = IS_SHARP_ITEM_BIG
	w_class = SIZE_SMALL
	throwforce = 9
	throw_speed = SPEED_VERY_FAST
	throw_range = 5
	matter = list("metal" = 20000,"glass" = 10000)
	flags_item = ANIMATED_SURGICAL_TOOL
	attack_verb = list("attacked", "slashed", "sawed", "cut", "maimed", "gored")
	edge = 1

/obj/item/tool/surgery/circular_saw/predatorbonesaw
	name = "骨锯"
	icon_state = "predator_bonesaw"
	flags_item = NO_FLAGS

/*
 * Bone Gel
 * Usual substitutes: screwdriver.
 */

/obj/item/tool/surgery/bonegel
	name = "骨凝胶瓶"
	desc = "一个装有骨凝胶的容器，骨凝胶是一种能够使用模拟骨骼的类似物来固定骨折的物质。需要从专用机器重新填充。"
	desc_lore = "Bone gel is a biological synthetic bone-analogue with the consistency of clay. It is capable of fixing hairline fractures and complex fractures alike by sealing cracks through adhesion to compact bone and solidifying; the gel then naturally erodes away as the bone remodels itself. Bone gel should not be used to fix missing bone, as it does not replace the body's bone marrow. Overuse in a short period may cause acute immunodeficiency or anemia."
	icon_state = "bone-gel"
	w_class = SIZE_SMALL
	matter = list("plastic" = 7500)
	///base icon state for update_icon() to reference, fixes bonegel/empty
	var/base_icon_state = "bone-gel"
	///percent of gel remaining in container
	var/remaining_gel = 100
	///If gel is used when doing bone surgery
	var/unlimited_gel = FALSE
	///Time it takes per 10% of gel refilled
	var/time_per_refill = 1 SECONDS
	///if the bone gel is actively being refilled
	var/refilling = FALSE

	///How much bone gel is needed to fix a fracture
	var/fracture_fix_cost = 5
	///How much bone gel is needed to mend bones
	var/mend_bones_fix_cost = 5

/obj/item/tool/surgery/bonegel/update_icon(mob/user)
	. = ..()
	switch(remaining_gel)
		if(76 to INFINITY)
			icon_state = base_icon_state
		if(51 to 75)
			icon_state = "[base_icon_state]_75"
		if(26 to 50)
			icon_state = "[base_icon_state]_50"
		if(5 to 25)
			icon_state = "[base_icon_state]_25"
		if(0 to 4)
			icon_state = "[base_icon_state]_0"

	if(user)
		user.update_inv_l_hand()
		user.update_inv_r_hand()

/obj/item/tool/surgery/bonegel/get_examine_text(mob/user)
	. = ..()
	if(unlimited_gel) //Only show how much gel is left if it actually uses bone gel
		return
	. += "A volume reader on the side tells you there is still [remaining_gel]% of [src] is remaining."
	. += "[src] can be refilled from a osteomimetic lattice fabricator."

	if(!skillcheck(user, SKILL_MEDICAL, SKILL_MEDICAL_DOCTOR)) //Know how much you will be using if you can use it
		return
	. += SPAN_NOTICE("You will need to use [fracture_fix_cost]% of the bone gel to repair a fracture.")
	. += SPAN_NOTICE("You will need to use [mend_bones_fix_cost]% of the bone gel to mend bones.")

/obj/item/tool/surgery/bonegel/proc/refill_gel(obj/refilling_obj, mob/user)
	if(unlimited_gel)
		to_chat(user, SPAN_NOTICE("[refilling_obj]拒绝填充[src]。"))
		return
	if(remaining_gel >= 100)
		to_chat(user, SPAN_NOTICE("[src]无法再装入更多骨凝胶。"))
		return

	if(refilling)
		to_chat(user, SPAN_NOTICE("你已经在从[refilling_obj]重新填充[src]了。"))
		return
	refilling = TRUE

	while(remaining_gel < 100)
		if(!do_after(user, time_per_refill, INTERRUPT_ALL, BUSY_ICON_FRIENDLY, refilling_obj))
			break
		remaining_gel = clamp(remaining_gel + 10, 0, 100)
		update_icon()
		to_chat(user, SPAN_NOTICE("[refilling_obj]发出提示音，并显示\"[remaining_gel]% filled\"."))

	refilling = FALSE
	playsound(refilling_obj, "sound/machines/ping.ogg", 10)
	to_chat(user, SPAN_NOTICE("你从[refilling_obj]取出了[src]。"))

/obj/item/tool/surgery/bonegel/proc/use_gel(gel_cost)
	if(unlimited_gel)
		return TRUE

	if(remaining_gel < gel_cost)
		return FALSE
	remaining_gel -= gel_cost
	update_icon()
	return TRUE

/obj/item/tool/surgery/bonegel/empty
	remaining_gel = 0
	icon_state = "bone-gel_0"

/obj/item/tool/surgery/bonegel/predatorbonegel
	name = "凝胶枪"
	desc = "内部是一种效果与骨凝胶相似的液体，但所需用量小得多，单个胶囊几乎可以无限次使用。"
	base_icon_state = "predator_bone-gel"
	icon_state = "predator_bone-gel"
	unlimited_gel = TRUE

/*
 * Fix-o-Vein
 * Usual substitutes: surgical line, cable coil, headbands.
 */

/obj/item/tool/surgery/FixOVein
	name = "\improper FixOVein"
	icon_state = "fixovein"
	desc = "一种外科工具，使用合成膜修复破损的血管。紧急情况下也可用于重新连接其他韧带和组织。"
	desc_lore = "Hemophilics everywhere can thank a likewise hemophilic surgeon and their love for birds for the development of this tool. Inspired by the protective keratin sheath surrounding blood feathers as they grow and the crumbling of pin feather sheaths after the feather finishes growing, they worked with scientists to develop a tool that secretes a membrane of synthetic connective tissue to provide a framework and protective casing for the healing blood vessel until it naturally repairs itself, after which is sloughs off and dissolves. Since the membrane operates on a cellular level, it is practically infinite. With patients having been operated on experiencing a 100% recovery rate, the FixOVein has earned it a spot on every surgeon's surgical tray."
	force = 0
	throwforce = 1
	matter = list("plastic" = 5000)
	w_class = SIZE_SMALL
	var/usage_amount = 10

/obj/item/tool/surgery/FixOVein/predatorFixOVein
	name = "血管修复器"
	icon_state = "predator_fixovein"

/*
 * Surgical line. Used for suturing wounds, and for some surgeries.
 * Surgical substitutes: fixovein, cable coil.
 */

/obj/item/tool/surgery/surgical_line
	name = "手术缝合线"
	desc = "一卷军用级手术缝合线，能无缝缝合任何伤口。在海上部署时也可用作坚固的钓鱼线。"
	icon_state = "line_brute"
	item_state = "line_brute"
	force = 0
	throwforce = 1
	w_class = SIZE_SMALL

/obj/item/tool/surgery/surgical_line/Initialize(mapload, ...)
	. = ..()
	AddElement(/datum/element/suturing, TRUE, FALSE, 2.5, "suture", "suturing", "being stabbed with needles", "wounds")

/*
 * Synth-graft.
 * No substitutes. Not, strictly speaking, a surgical tool at all, but here for consistency with surgical line.
 */

/obj/item/tool/surgery/synthgraft
	name = "合成移植物"
	desc = "An applicator for synthetic skin field grafts. The stuff reeks like processed space carp skin, itches like the dickens, stings like hell when applied, and the color is \
		a perfectly averaged multi-ethnic tone that doesn't blend with <i>anyone's</i> complexion. But at least you don't have to stay in sickbay for skin graft surgery."
	icon_state = "line_burn"
	item_state = "line_burn"
	force = 0
	throwforce = 1
	w_class = SIZE_SMALL

/obj/item/tool/surgery/synthgraft/Initialize(mapload, ...)
	. = ..()
	AddElement(/datum/element/suturing, FALSE, TRUE, 2.5, "graft", "grafting", "being burnt away all over again", "burns")

/*
 * Bonesetter.
 * Usual substitutes: wrench.
 */

/obj/item/tool/surgery/bonesetter
	name = "骨骼复位器"
	desc = "正式名称为'骨折复位钳'，是一种用于'骨折复位'手术的外科工具，在此过程中将骨折的骨骼重新定位到正确位置以便正常愈合。"
	icon_state = "bonesetter"
	hitsound = 'sound/weapons/genhit3.ogg'
	force = 15
	attack_speed = 6
	throwforce = 5
	throw_speed = SPEED_VERY_FAST
	throw_range = 5
	w_class = SIZE_SMALL
	attack_verb = list("grasped", "pinched", "pulled", "yanked")
	matter = list("plastic" = 7500)

/obj/item/tool/surgery/bonesetter/predatorbonesetter
	name = "骨骼定位器"
	icon_state = "predator_bonesetter"

/*
WILL BE USED AT A LATER TIME

t. optimisticdude

/obj/item/tool/surgery/handheld_pump
	name = "手持手术泵"
	desc = "这玩意儿真能吸。字面意思。"
	icon_state = "pump"
	force = 0
	throwforce = 9
	throw_speed = SPEED_VERY_FAST
	throw_range = 5
	w_class = SIZE_SMALL
	attack_verb = list("attacked", "hit", "bludgeoned", "pummeled", "beat")
	matter = list("plastic" = 7500)
*/

/obj/item/tool/surgery/drapes //Does nothing at present. Might be useful for increasing odds of success.
	name = "手术铺单"
	desc = "用于在手术开始前覆盖肢体。"
	icon_state = "drapes"
	gender = PLURAL
	w_class = SIZE_SMALL
	flags_item = NOBLUDGEON

/*
 * MEDICOMP TOOLS
 */

/obj/item/tool/surgery/stabilizer_gel
	name = "稳定凝胶瓶"
	desc = "用于稳定伤口以便治疗。"
	icon_state = "stabilizer_gel"
	force = 0
	throwforce = 1
	w_class = SIZE_SMALL
	flags_item = ITEM_PREDATOR
	black_market_value = 50

/obj/item/tool/surgery/healing_gun
	name = "治疗枪"
	desc = "用于修复已稳定的伤口。"
	icon_state = "healing_gun"
	force = 0
	throwforce = 1
	w_class = SIZE_SMALL
	flags_item = ITEM_PREDATOR|ANIMATED_SURGICAL_TOOL
	var/loaded  = TRUE
	black_market_value = 50

/obj/item/tool/surgery/healing_gun/update_icon()
	if(loaded)
		icon_state = "healing_gun"
	else
		icon_state = "healing_gun_empty"

/obj/item/tool/surgery/healing_gun/attackby(obj/item/O, mob/user)
	if(!HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		to_chat(user, SPAN_WARNING("你完全不知道如何把[O]装进[src]！"))
		return
	if(istype(O, /obj/item/tool/surgery/healing_gel))
		if(loaded)
			to_chat(user, SPAN_WARNING("治疗枪里已经有一个胶囊了！"))
			return
		user.visible_message(SPAN_NOTICE("[user]将\a [O]装入了[src]。") ,SPAN_NOTICE("You load [src] with \a [O]."))
		playsound(loc, 'sound/items/air_release.ogg',25)
		loaded = TRUE
		update_icon()
		qdel(O)
		return
	return ..()

/obj/item/tool/surgery/healing_gel
	name = "治疗凝胶胶囊"
	desc = "用于给治疗枪重新装填。"
	icon_state = "healing_gel"
	force = 0
	throwforce = 1
	w_class = SIZE_SMALL
	flags_item = ITEM_PREDATOR
	black_market_value = 15

/obj/item/tool/surgery/wound_clamp
	name = "伤口夹"
	desc = "用于在治疗后夹住伤口。"
	icon_state = "wound_clamp"
	force = 10
	throwforce = 1
	w_class = SIZE_SMALL
	flags_item = ITEM_PREDATOR|ANIMATED_SURGICAL_TOOL
	black_market_value = 15


//XENO AUTOPSY TOOL

/obj/item/tool/surgery/WYautopsy
	name = "\improper Weyland Brand Automatic Autopsy System(TM)"
	desc = "让尸检重新变得有趣。这个小装置能在约30秒内对你发现的任何奇怪生命形式完成一次完整的尸检。"
	icon_state = "scalpel_laser_2"
	damtype = "fire"
	force = 10
	throwforce = 1
	flags_item = ANIMATED_SURGICAL_TOOL
	var/active = 0
	var/resetting = 0//For the reset, to prevent macro-spam abuse

/obj/item/tool/surgery/WYautopsy/verb/reset()
	set category = "IC"
	set name = "Reset WY Autopsy tool"
	set desc = "Reset the WY Tool in case it breaks."
	set src in usr

	if(!active)
		to_chat(usr, "系统似乎运行正常...")
		return
	if(active)
		resetting = 1
		to_chat(usr, "正在重置工具。这需要几秒钟... 重置期间请勿尝试使用该工具，否则可能导致故障。")
		while(active) //While keep running until it's reset (in case of lag-spam)
			active = 0 //Sets it to not active
			to_chat(usr, "处理中...")
			spawn(60) // runs a timer before the final check.  timer is longer than autopsy timers.
				if(!active)
					to_chat(usr, "系统重置完成！")
					resetting = 0

/obj/item/tool/surgery/WYautopsy/attack(mob/living/carbon/xenomorph/T as mob, mob/living/user as mob)
/* set category = "Autopsy"
	set name = "Perform Alien Autopsy"
	set src in usr*/
	if(resetting)
		to_chat(usr, "此工具正在恢复出厂默认设置。如果你一直在等待，请尝试再次运行重置。")
	if(!isxeno(T))
		to_chat(usr, "你他妈是什么东西，某种怪物吗？")
		return
	if(T.health > 0)
		to_chat(usr, "你他妈在干什么！？干掉它！")
		return
	if(active)
		to_chat(usr, "你已经在进行尸检了。")
		return
	if(istype(T, /mob/living/carbon/xenomorph/larva))
		to_chat(usr, "这只幼虫尚未发育出任何可供你提取的有用生物质。") //It will in a future update, I guess.
		return
	active = 1
	var CHECK = user.loc
	playsound(loc, 'sound/weapons/pierce.ogg', 25)
	to_chat(usr, "你开始切割异形...这可能需要一些时间...")
	if(T.health >-100)
		to_chat(usr, "我操！它还活着！它突然暴起，用身体重量将你撞倒！")
		usr.apply_effect(20, WEAKEN)
		to_chat(T, "尽管你感到剧痛难忍，但你仍挣扎起身，用尽最后一丝力气，在生命的最后一刻杀死了[usr]。") ///~10 seconds
		T.health = T.maxHealth*2 //It's hulk levels of angry.
		active = 0
		spawn (1000) //Around 10 seconds
			T.apply_damage(5000, BRUTE) //to make sure it's DEAD after it's hyper-boost
		return

	switch(T.butchery_progress)
		if(0)
			spawn(50)
				if(CHECK != user.loc)
					to_chat(usr, "此操作需要全神贯注；你必须保持静止。")
					return
				to_chat(usr, "你已经切开了外层的几丁质甲壳。")
				new /obj/item/oldresearch/Chitin(T.loc) //This will be 1-3 Chitin eventually (depending on tier)
				new /obj/item/oldresearch/Chitin(T.loc) //This will be 1-3 Chitin eventually (depending on tier)
				T.butchery_progress++
				active = 0
		if(1)
			spawn(50)
				if(CHECK != user.loc)
					to_chat(usr, "此操作需要全神贯注；你必须保持静止。")
					return
				to_chat(usr, "你切入了胸腔并采集了一份血液样本。")
				new /obj/item/oldresearch/Blood(T.loc)//This will be a sample of blood eventually
				T.butchery_progress++
				active = 0
		if(2)
			spawn(50)
				if(CHECK != user.loc)
					to_chat(usr, "此操作需要全神贯注；你必须保持静止。")
					return
				//to_chat(usr, "You've cut out an intact organ.")
				to_chat(usr, "你切下了一些生物质...")
				new /obj/item/oldresearch/Resin(T.loc)//This will be an organ eventually, based on the caste.
				T.butchery_progress++
				active = 0
		if(3)
			spawn(50)
				if(CHECK != user.loc)
					to_chat(usr, "此操作需要全神贯注；你必须保持静止。")
					return
				to_chat(usr, "你刮出了剩余的生物质。")
				active = 0
				new /obj/item/oldresearch/Resin(T.loc)
				new /obj/effect/decal/remains/xeno(T.loc)
				qdel(T)
