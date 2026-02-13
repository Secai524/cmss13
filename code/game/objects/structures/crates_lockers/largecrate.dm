/obj/structure/largecrate
	name = "大型板条箱"
	desc = "一个沉重的木箱。"
	icon = 'icons/obj/structures/crates.dmi'
	icon_state = "densecrate"
	density = TRUE
	anchored = FALSE
	var/parts_type = /obj/item/stack/sheet/wood
	var/unpacking_sound = 'sound/effects/woodhit.ogg'

/obj/structure/largecrate/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_OVER|PASS_AROUND

/obj/structure/largecrate/attack_hand(mob/user as mob)
	to_chat(user, SPAN_NOTICE("你需要撬棍才能撬开它！"))
	return

/obj/structure/largecrate/proc/unpack()
	var/turf/current_turf = get_turf(src) // Get the turf the crate is on

	playsound(src, unpacking_sound, 35)

	// Move the contents back to the turf
	for(var/atom/movable/moving_atom as anything in contents)
		moving_atom.forceMove(current_turf)

	if(parts_type) // Create the crate material
		new parts_type(current_turf, 2)

	deconstruct(TRUE)

/obj/structure/largecrate/deconstruct(disassembled = TRUE)
	if(!disassembled)
		new parts_type(loc)
	return ..()


/obj/structure/largecrate/attackby(obj/item/W as obj, mob/user as mob)
	if(HAS_TRAIT(W, TRAIT_TOOL_CROWBAR))
		unpack()
		user.visible_message(SPAN_NOTICE("[user]撬开了[src]。"),
							SPAN_NOTICE("You pry open [src]."))
	else
		return attack_hand(user)

/obj/structure/largecrate/attack_alien(mob/living/carbon/xenomorph/user)
	user.animation_attack_on(src)
	unpack()
	user.visible_message(SPAN_DANGER("[user]砸碎了[src]！"),
					  SPAN_DANGER("We smash [src] apart!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	return XENO_ATTACK_ACTION

/obj/structure/largecrate/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(unslashable)
		return TAILSTAB_COOLDOWN_NONE
	unpack()
	xeno.visible_message(SPAN_DANGER("[xeno]用它的尾巴砸碎了[src]！"),
	SPAN_DANGER("We smash [src] apart with our tail!"), null, 5, CHAT_TYPE_XENO_COMBAT)
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/largecrate/ex_act(power)
	if(power >= EXPLOSION_THRESHOLD_VLOW)
		unpack()

/obj/structure/largecrate/proc/take_damage(damage)
	health -= damage
	if(health <= 0)
		unpack()

/obj/structure/largecrate/bullet_act(obj/projectile/P)
	take_damage(P.calculate_damage(P.damage))
	return TRUE

/obj/structure/largecrate/mule
	icon_state = "mulecrate"

/obj/structure/largecrate/lisa
	icon_state = "lisacrate"

/obj/structure/largecrate/lisa/attackby(obj/item/W as obj, mob/user as mob) //ugly but oh well
	if(HAS_TRAIT(W, TRAIT_TOOL_CROWBAR))
		new /mob/living/simple_animal/big/corgi/Lisa(loc)
	. = ..()

/obj/structure/largecrate/cow
	name = "牛箱"
	icon_state = "lisacrate"

/obj/structure/largecrate/cow/attackby(obj/item/W as obj, mob/user as mob)
	if(HAS_TRAIT(W, TRAIT_TOOL_CROWBAR))
		new /mob/living/simple_animal/big/cow(loc)
	. = ..()

/obj/structure/largecrate/goat
	name = "山羊箱"
	icon_state = "lisacrate"

/obj/structure/largecrate/goat/attackby(obj/item/W as obj, mob/user as mob)
	if(HAS_TRAIT(W, TRAIT_TOOL_CROWBAR))
		new /mob/living/simple_animal/hostile/retaliate/goat(loc)
	. = ..()

/obj/structure/largecrate/chick
	name = "鸡笼板条箱"
	icon_state = "lisacrate"

/obj/structure/largecrate/chick/attackby(obj/item/W as obj, mob/user as mob)
	if(HAS_TRAIT(W, TRAIT_TOOL_CROWBAR))
		var/num = rand(4, 6)
		for(var/i = 0, i < num, i++)
			new /mob/living/simple_animal/small/chick(loc)
	. = ..()


// CM largecrates
/obj/structure/largecrate/random
	name = "补给箱"
	var/num_things = 0
	var/list/stuff = list(/obj/item/cell/high,
						/obj/item/storage/belt/utility/full,
						/obj/item/device/multitool,
						/obj/item/tool/crowbar,
						/obj/item/device/flashlight,
						/obj/item/reagent_container/food/snacks/donkpocket,
						/obj/item/explosive/grenade/smokebomb,
						/obj/item/circuitboard/airlock,
						/obj/item/device/assembly/igniter,
						/obj/item/tool/weldingtool,
						/obj/item/tool/wirecutters,
						/obj/item/device/analyzer,
						/obj/item/clothing/under/marine,
						/obj/item/clothing/shoes/marine)

/obj/structure/largecrate/random/Initialize()
	. = ..()
	if(!num_things)
		num_things = rand(0,3)

	for(var/i in 1 to num_things)
		var/obj/item/thing = pick(stuff)
		new thing(src)
	num_things = 0

/obj/structure/largecrate/random/mini
	name = "小型板条箱"
	desc = "大型补给箱的远亲，隔了一代。"
	icon_state = "mini_crate"
	density = FALSE

/obj/structure/largecrate/random/mini/chest
	desc = "一个用安全弹性绑带包裹的小型塑料箱。"
	icon_state = "mini_chest"
	name = "小型储物箱"

/obj/structure/largecrate/random/mini/chest/b
	icon_state = "mini_chest_b"
	name = "小型储物箱"

/obj/structure/largecrate/random/mini/chest/c
	icon_state = "mini_chest_c"
	name = "小型储物箱"

/obj/structure/largecrate/random/mini/wooden
	desc = "一个小型木箱。两条支撑肋条横跨其框架。"
	icon_state = "mini_wooden"
	name = "木制板条箱"

/obj/structure/largecrate/random/mini/small_case
	desc = "一个硬壳小箱。里面会是什么？"
	icon_state = "mini_case"
	name = "小型手提箱"

/obj/structure/largecrate/random/mini/small_case/b
	icon_state = "mini_case_b"
	name = "小型手提箱"

/obj/structure/largecrate/random/mini/small_case/c
	icon_state = "mini_case_c"
	name = "小型手提箱"

/obj/structure/largecrate/random/mini/ammo
	desc = "一个小型金属弹药箱。给，弗里曼，弹药！"
	name = "小型弹药箱"
	icon_state = "mini_ammo"
	stuff = list(
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/rifle/extended,
		/obj/item/ammo_magazine/shotgun,
		/obj/item/ammo_magazine/shotgun/buckshot,
		/obj/item/ammo_magazine/shotgun/flechette,
		/obj/item/ammo_magazine/smg/m39,
		/obj/item/ammo_magazine/smg/m39/extended,
	)

/obj/structure/largecrate/random/mini/med
	desc = "一个小型金属医疗箱。给，弗里曼，拿上这个医疗包！" //https://www.youtube.com/watch?v=OMXan7GS8-Q
	icon_state = "mini_medcase"
	name = "小型医疗箱"
	num_things = 1 //funny lootbox tho.
	stuff = list(
		/obj/item/stack/medical/bruise_pack,
		/obj/item/storage/pill_bottle/packet/tricordrazine,
		/obj/item/tool/crowbar/red,
		/obj/item/device/flashlight,
		/obj/item/reagent_container/hypospray/autoinjector/skillless,
		/obj/item/storage/pill_bottle/packet/tramadol,
		/obj/item/stack/medical/ointment,
		/obj/item/stack/medical/splint,
		/obj/item/device/healthanalyzer,
		/obj/item/stack/medical/advanced/ointment,
		/obj/item/stack/medical/advanced/bruise_pack,
		/obj/item/tool/extinguisher/mini,
		/obj/item/tool/shovel/etool,
		/obj/item/tool/screwdriver,
	)

/obj/structure/largecrate/random/case
	name = "存储箱"
	desc = "一个黑色存储箱。"
	icon_state = "case"

/obj/structure/largecrate/random/case/double
	name = "cases"
	desc = "一摞黑色存储箱。"
	icon_state = "case_double"

/obj/structure/largecrate/random/case/double/unpack()
	if(parts_type)
		new parts_type(loc, 2)
	for(var/obj/O in contents)
		O.forceMove(loc)
	new /obj/structure/largecrate/random/case(loc)
	playsound(src, unpacking_sound, 35)
	qdel(src)

/obj/structure/largecrate/random/case/small
	name = "小型存储箱组"
	desc = "两个小型黑色存储箱。"
	icon_state = "case_small"

/obj/structure/largecrate/random/barrel
	name = "蓝色存储桶"
	desc = "一个蓝色存储桶。"
	icon = 'icons/obj/structures/barrels.dmi'
	icon_state = "barrel_blue"
	var/strap_overlay = "+straps"
	parts_type = /obj/item/stack/sheet/metal
	unpacking_sound = 'sound/effects/metalhit.ogg'
	var/straps = FALSE

/obj/structure/largecrate/random/barrel/true_random
	name = "barrel"
	desc = "一个桶。"
	icon_state = "barrel_recolorable"
	desc_lore = "From the future."
	var/cap_doodad_state = ""
	var/center_doodad_state = ""
	var/color_override = null


GLOBAL_LIST_EMPTY(rbarrel_cap_states) // Will be set up in generate_barrel_states
GLOBAL_LIST_INIT(rbarrel_center_states, generate_barrel_states())
GLOBAL_LIST_INIT(rbarrel_color_list, list(COLOR_SILVER,
	COLOR_FLOORTILE_GRAY,
	COLOR_MAROON,
	COLOR_SOFT_RED,
	COLOR_LIGHT_GRAYISH_RED,
	COLOR_VERY_SOFT_YELLOW,
	COLOR_OLIVE,
	COLOR_DARK_MODERATE_LIME_GREEN,
	COLOR_TEAL,
	COLOR_MODERATE_BLUE,
	COLOR_PURPLE,
	COLOR_STRONG_VIOLET,
	LIGHT_BEIGE,
	COLOR_DARK_MODERATE_ORANGE,
	COLOR_BROWN,
	COLOR_DARK_BROWN))

/proc/generate_barrel_states()
	var/list/rbarrel_center_states = list()
	var/icon/icon = new('icons/obj/structures/barrels.dmi')
	var/list/icon_list = icon_states(icon)
	for(var/state in icon_list)
		if(findtext(state,"+cap"))
			GLOB.rbarrel_cap_states.Add(state)
		if(findtext(state,"+center"))
			rbarrel_center_states.Add(state)
	// We are returning rbarrel_center_states (rather than setting GLOB) because we are called by the global initializer to set it
	return rbarrel_center_states

/obj/structure/largecrate/random/barrel/true_random/Initialize()
	. = ..()

	var/image/center_coloring = image(icon, src,"+_center")

	if(!color_override)
		center_coloring.color = pick(GLOB.rbarrel_color_list)

	center_coloring.appearance_flags = RESET_COLOR|KEEP_APART
	overlays += center_coloring
	if(prob(25))
		cap_doodad_state = pick(GLOB.rbarrel_cap_states)
		overlays += image(icon,src,cap_doodad_state)
	if(prob(50))
		center_doodad_state = pick(GLOB.rbarrel_center_states)
		overlays += image(icon,src,center_doodad_state)

/obj/structure/largecrate/random/barrel/Initialize()
	. = ..()
	if(overlays)
		overlays.Cut()
	if(straps)
		overlays += image(icon,icon_state = "+straps")

/obj/structure/largecrate/random/barrel/unpack()
	if(overlays)
		overlays.Cut()
	. = ..()

/obj/structure/largecrate/random/barrel/blue
	name = "蓝色存储桶"
	desc = "一个蓝色存储桶。"
	icon_state = "barrel_blue"

/obj/structure/largecrate/random/barrel/red
	name = "红色存储桶"
	desc = "一个红色存储桶。"
	icon_state = "barrel_red"
	straps = TRUE//the original sprite had straps, anyway, this is a harmless instance

/obj/structure/largecrate/random/barrel/green
	name = "绿色存储桶"
	desc = "一个绿色存储桶。"
	icon_state = "barrel_green"

/obj/structure/largecrate/random/barrel/yellow
	name = "黄色储存桶"
	desc = "一个黄色的储存桶。"
	icon_state = "barrel_yellow"

/obj/structure/largecrate/random/barrel/white
	name = "白色储存桶"
	desc = "一个白色的储存桶。"
	icon_state = "barrel_white"

/obj/structure/largecrate/random/barrel/medical
	name = "白色储存桶"
	desc = "一个白色的储存桶。"
	icon_state = "barrel_medical"

/obj/structure/largecrate/random/barrel/black
	name = "黑色储存桶"
	desc = "一个黑色的储存桶。"
	icon_state = "barrel_wy"

/obj/structure/largecrate/random/barrel/brown
	name = "棕色储存桶"
	desc = "一个棕色的储存桶。"
	icon_state = "barrel_tan"

/obj/structure/largecrate/random/barrel/purewhite
	name = "白色储存桶"
	desc = "一个白色的储存桶。"
	icon_state = "barrel_purewhite"

/obj/structure/largecrate/random/secure
	name = "安全补给箱"
	desc = "一个安全的板条箱。"
	icon_state = "secure_crate_strapped"
	var/strapped = 1

/obj/structure/largecrate/random/secure/attackby(obj/item/W as obj, mob/user as mob)
	if (!strapped)
		. = ..()
		return

	if (!W.sharp)
		to_chat(user, SPAN_NOTICE("你需要锋利的东西来割断绑带。"))
		return

	to_chat(user, SPAN_NOTICE("你开始割断\the [src]上的绑带..."))

	if (do_after(user, 15, INTERRUPT_ALL, BUSY_ICON_GENERIC))
		playsound(loc, 'sound/items/Wirecutter.ogg', 25, 1)
		to_chat(user, SPAN_NOTICE("你割断了绑带。"))
		icon_state = "secure_crate"
		strapped = 0


/obj/structure/largecrate/guns
	name = "\improper USCM firearms crate (x3)"
	var/num_guns = 3
	var/num_mags = 3
	var/list/stuff = list(
					/obj/item/weapon/gun/pistol/m4a3 = /obj/item/ammo_magazine/pistol,
					/obj/item/weapon/gun/pistol/m4a3 = /obj/item/ammo_magazine/pistol,
					/obj/item/weapon/gun/revolver/m44 = /obj/item/ammo_magazine/revolver,
					/obj/item/weapon/gun/rifle/m41a = /obj/item/ammo_magazine/rifle,
					/obj/item/weapon/gun/rifle/m41a = /obj/item/ammo_magazine/rifle,
					/obj/item/weapon/gun/shotgun/pump = /obj/item/ammo_magazine/shotgun,
					/obj/item/weapon/gun/smg/m39 = /obj/item/ammo_magazine/smg/m39,
					/obj/item/weapon/gun/smg/m39 = /obj/item/ammo_magazine/smg/m39
				)

/obj/structure/largecrate/guns/Initialize()
	. = ..()
	var/gun_type
	var/i = 0
	while(++i <= num_guns)
		gun_type = pick(stuff)
		new gun_type(src)
		var/obj/item/ammo_magazine/new_mag = stuff[gun_type]
		var/m = 0
		while(++m <= num_mags)
			new new_mag(src)

/obj/structure/largecrate/guns/russian
	num_guns = 3
	num_mags = 3
	name = "\improper Hyperdyne firearm crate"
	stuff = list( /obj/item/weapon/gun/revolver/upp = /obj/item/ammo_magazine/revolver/upp,
					/obj/item/weapon/gun/pistol/np92 = /obj/item/ammo_magazine/pistol/np92,
					/obj/item/weapon/gun/pistol/kt42 = /obj/item/ammo_magazine/pistol/kt42,
					/obj/item/weapon/gun/rifle/mar40 = /obj/item/ammo_magazine/rifle/mar40,
					/obj/item/weapon/gun/rifle/mar40/carbine = /obj/item/ammo_magazine/rifle/mar40/extended,
					/obj/item/weapon/gun/rifle/sniper/svd = /obj/item/ammo_magazine/sniper/svd,
					/obj/item/weapon/gun/smg/pps43 = /obj/item/ammo_magazine/smg/pps43
				)

/obj/structure/largecrate/guns/merc
	num_guns = 1
	num_mags = 5
	name = "\improper Black market firearm crate"
	stuff = list( /obj/item/weapon/gun/pistol/holdout = /obj/item/ammo_magazine/pistol/holdout,
					/obj/item/weapon/gun/pistol/action = /obj/item/ammo_magazine/pistol/action,
					/obj/item/weapon/gun/pistol/highpower = /obj/item/ammo_magazine/pistol/highpower,
					/obj/item/weapon/gun/pistol/m1911 = /obj/item/ammo_magazine/pistol/m1911,
					/obj/item/weapon/gun/pistol/heavy = /obj/item/ammo_magazine/pistol/heavy,
					/obj/item/weapon/gun/pistol/l54 = /obj/item/ammo_magazine/pistol/l54,
					/obj/item/weapon/gun/pistol/np92 = /obj/item/ammo_magazine/pistol/np92,
					/obj/item/weapon/gun/revolver/small = /obj/item/ammo_magazine/revolver/small,
					/obj/item/weapon/gun/revolver/cmb = /obj/item/ammo_magazine/revolver/cmb,
					/obj/item/weapon/gun/shotgun/merc = /obj/item/ammo_magazine/handful/shotgun/buckshot,
					/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb = /obj/item/ammo_magazine/handful/shotgun/buckshot,
					/obj/item/weapon/gun/shotgun/double/with_stock = /obj/item/ammo_magazine/handful/shotgun/buckshot,
					/obj/item/weapon/gun/lever_action/r4t = /obj/item/ammo_magazine/handful/lever_action,
					/obj/item/weapon/gun/smg/mp27 = /obj/item/ammo_magazine/smg/mp27,
					/obj/item/weapon/gun/smg/bizon = /obj/item/ammo_magazine/smg/bizon,
					/obj/item/weapon/gun/smg/mac15 = /obj/item/ammo_magazine/smg/mac15,
					/obj/item/weapon/gun/smg/uzi = /obj/item/ammo_magazine/smg/uzi,
					/obj/item/weapon/gun/rifle/mar40/carbine = /obj/item/ammo_magazine/rifle/mar40,
					/obj/item/weapon/gun/smg/pps43 = /obj/item/ammo_magazine/smg/pps43,
					/obj/item/weapon/gun/rifle/l42a/abr40 = /obj/item/ammo_magazine/rifle/l42a/abr40,
					/obj/item/weapon/gun/smg/mp5 = /obj/item/ammo_magazine/smg/mp5,
					/obj/item/weapon/gun/rifle/m16 = /obj/item/ammo_magazine/rifle/m16,
					/obj/item/weapon/gun/rifle/ar10 = /obj/item/ammo_magazine/rifle/ar10,
					/obj/item/weapon/gun/rifle/type71 = /obj/item/ammo_magazine/rifle/type71,
					/obj/item/weapon/gun/smg/fp9000 = /obj/item/ammo_magazine/smg/fp9000
				)

/obj/structure/largecrate/hunter_games_construction
	name = "工程建材箱"

/obj/structure/largecrate/hunter_games_construction/Initialize()
	. = ..()
	new /obj/item/stack/sheet/metal(src, 50)
	new /obj/item/stack/sheet/glass(src, 50)
	new /obj/item/stack/sheet/plasteel(src, 50)
	new /obj/item/stack/sheet/wood(src, 50)
	new /obj/item/stack/sandbags_empty(src, 50)
	new /obj/item/storage/toolbox/mechanical(src)
	new /obj/item/storage/toolbox/mechanical(src)
	new /obj/item/storage/toolbox/electrical(src)
	new /obj/item/storage/belt/utility/full(src)
	new /obj/item/storage/belt/utility/full(src)
	new /obj/item/clothing/gloves/yellow(src)
	new /obj/item/clothing/gloves/yellow(src)
	new /obj/item/clothing/head/welding(src)
	new /obj/item/clothing/head/welding(src)
	new /obj/item/circuitboard/airlock(src)
	new /obj/item/cell/high(src)
	new /obj/item/cell/high(src)
	new /obj/item/storage/pouch/tools(src)


/obj/structure/largecrate/hunter_games_medical
	name = "医疗箱"

/obj/structure/largecrate/hunter_games_medical/Initialize()
	. = ..()
	new /obj/item/clothing/glasses/hud/health(src)
	new /obj/item/clothing/glasses/hud/health(src)
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/storage/belt/medical/full(src)
	new /obj/item/storage/belt/medical/lifesaver/full(src)
	new /obj/item/storage/firstaid/regular(src)
	new /obj/item/storage/firstaid/adv(src)
	new /obj/item/storage/firstaid/o2(src)
	new /obj/item/storage/firstaid/toxin(src)
	new /obj/item/storage/firstaid/fire(src)
	new /obj/item/storage/firstaid/rad(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pouch/medical(src)
	new /obj/item/storage/pouch/firstaid/full(src)

/obj/structure/largecrate/hunter_games_surgery
	name = "手术箱"

/obj/structure/largecrate/hunter_games_surgery/Initialize()
	. = ..()
	new /obj/item/tool/surgery/cautery(src)
	new /obj/item/tool/surgery/surgicaldrill(src)
	new /obj/item/clothing/mask/breath/medical(src)
	new /obj/item/tank/anesthetic(src)
	new /obj/item/tool/surgery/FixOVein(src)
	new /obj/item/tool/surgery/hemostat(src)
	new /obj/item/tool/surgery/scalpel(src)
	new /obj/item/tool/surgery/bonegel(src)
	new /obj/item/tool/surgery/retractor(src)
	new /obj/item/tool/surgery/bonesetter(src)
	new /obj/item/tool/surgery/circular_saw(src)
	new /obj/item/tool/surgery/surgical_line(src)
	new /obj/item/tool/surgery/scalpel/manager(src)


/obj/structure/largecrate/hunter_games_supplies
	name = "补给箱"

/obj/structure/largecrate/hunter_games_supplies/Initialize()
	. = ..()
	new /obj/item/storage/box/m94(src)
	new /obj/item/storage/box/m94(src)
	new /obj/item/storage/pouch/general/medium(src)
	new /obj/item/storage/pouch/survival(src)
	new /obj/item/device/flashlight (src)
	new /obj/item/device/flashlight (src)
	new /obj/item/tool/crowbar/red (src)
	new /obj/item/tool/crowbar/red (src)
	new /obj/item/storage/pouch/pistol(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/pouch/flare(src)
	new /obj/item/storage/backpack(src)
	new /obj/item/storage/backpack/satchel(src)
	new /obj/item/storage/backpack(src)
	new /obj/item/device/radio(src)
	new /obj/item/device/radio(src)
	new /obj/item/attachable/bayonet(src)
	new /obj/item/attachable/bayonet(src)
	new /obj/item/weapon/throwing_knife(src)
	new /obj/item/weapon/throwing_knife(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/storage/box/donkpockets(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/storage/box/pizza(src)


/obj/structure/largecrate/hunter_games_guns
	name = "武器箱"

/obj/structure/largecrate/hunter_games_guns/mediocre/Initialize()
	. = ..()
	new /obj/item/weapon/gun/pistol/holdout(src)
	new /obj/item/ammo_magazine/pistol/holdout(src)
	new /obj/item/ammo_magazine/pistol/holdout(src)
	new /obj/item/weapon/gun/pistol/m4a3(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/weapon/gun/shotgun/double/with_stock(src)
	new /obj/item/ammo_magazine/shotgun(src)
	new /obj/item/weapon/gun/revolver/small(src)
	new /obj/item/ammo_magazine/revolver/small(src)
	new /obj/item/ammo_magazine/revolver/small(src)


/obj/structure/largecrate/hunter_games_guns/decent/Initialize()
	. = ..()
	new /obj/item/weapon/gun/pistol/m4a3(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)
	if(prob(50))
		new /obj/item/weapon/gun/smg/m39(src)
		new /obj/item/ammo_magazine/smg/m39(src)
		new /obj/item/ammo_magazine/smg/m39(src)
	else
		new /obj/item/weapon/gun/smg/mac15(src)
		new /obj/item/ammo_magazine/smg/mac15(src)
		new /obj/item/ammo_magazine/smg/mac15(src)
	new /obj/item/weapon/gun/shotgun/pump/dual_tube/cmb(src)
	new /obj/item/ammo_magazine/shotgun(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)
	new /obj/item/weapon/gun/revolver/m44(src)
	new /obj/item/ammo_magazine/revolver(src)
	new /obj/item/ammo_magazine/revolver(src)
	new /obj/item/weapon/gun/rifle/m16(src)
	new /obj/item/ammo_magazine/rifle/m16(src)
	new /obj/item/ammo_magazine/rifle/m16(src)


/obj/structure/largecrate/hunter_games_guns/good/Initialize()
	. = ..()
	new /obj/item/weapon/gun/pistol/highpower(src)
	new /obj/item/ammo_magazine/pistol/highpower(src)
	new /obj/item/ammo_magazine/pistol/highpower(src)
	if(prob(50))
		new /obj/item/weapon/gun/rifle/m41a(src)
		new /obj/item/ammo_magazine/rifle(src)
		new /obj/item/ammo_magazine/rifle(src)
	else
		new /obj/item/weapon/gun/rifle/mar40(src)
		new /obj/item/ammo_magazine/rifle/mar40(src)
		new /obj/item/ammo_magazine/rifle/mar40(src)
	new /obj/item/weapon/gun/smg/bizon(src)
	new /obj/item/ammo_magazine/smg/bizon(src)
	new /obj/item/ammo_magazine/smg/bizon(src)
	new /obj/item/weapon/gun/shotgun/combat(src)
	new /obj/item/ammo_magazine/shotgun(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)


/obj/structure/largecrate/hunter_games_ammo
	name = "弹药箱"

/obj/structure/largecrate/hunter_games_ammo/mediocre/Initialize()
	. = ..()
	new /obj/item/ammo_magazine/pistol/holdout(src)
	new /obj/item/ammo_magazine/pistol/holdout(src)
	new /obj/item/ammo_magazine/pistol/holdout(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/shotgun(src)
	new /obj/item/ammo_magazine/revolver/small(src)
	new /obj/item/ammo_magazine/revolver/small(src)

/obj/structure/largecrate/hunter_games_ammo/decent/Initialize()
	. = ..()
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/pistol(src)
	new /obj/item/ammo_magazine/smg/m39(src)
	new /obj/item/ammo_magazine/smg/m39(src)
	new /obj/item/ammo_magazine/smg/mac15(src)
	new /obj/item/ammo_magazine/smg/mac15(src)
	new /obj/item/ammo_magazine/shotgun(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)
	new /obj/item/ammo_magazine/revolver(src)
	new /obj/item/ammo_magazine/revolver(src)
	new /obj/item/ammo_magazine/rifle/m16(src)
	new /obj/item/ammo_magazine/rifle/m16(src)

/obj/structure/largecrate/hunter_games_ammo/good/Initialize()
	. = ..()
	new /obj/item/ammo_magazine/pistol/highpower(src)
	new /obj/item/ammo_magazine/pistol/highpower(src)
	new /obj/item/ammo_magazine/rifle(src)
	new /obj/item/ammo_magazine/rifle(src)
	new /obj/item/ammo_magazine/rifle/mar40(src)
	new /obj/item/ammo_magazine/rifle/mar40(src)
	new /obj/item/ammo_magazine/smg/bizon(src)
	new /obj/item/ammo_magazine/smg/bizon(src)
	new /obj/item/ammo_magazine/shotgun(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)





/obj/structure/largecrate/hunter_games_armors
	name = "护甲箱"

/obj/structure/largecrate/hunter_games_armors/Initialize()
	. = ..()
	new /obj/item/clothing/gloves/marine(src)
	new /obj/item/clothing/gloves/marine(src)
	new /obj/item/clothing/gloves/marine(src)
	new /obj/item/clothing/head/helmet(src)
	new /obj/item/clothing/head/helmet(src)
	new /obj/item/clothing/head/helmet/riot(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/clothing/suit/armor/bulletproof(src)
	new /obj/item/weapon/shield/riot(src)
