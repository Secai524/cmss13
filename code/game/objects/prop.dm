/obj/item/prop
	name = "prop"
	desc = "某种道具。"

/// A prop that acts as a replacement for another item, mimicking their looks.
/// Mainly used in Reqs Tutorial to provide the full item selections without side effects.
/obj/item/prop/replacer
	/// The type that this object is taking the place of
	var/original_type

/obj/item/prop/replacer/Initialize(mapload, obj/original_type)
	if(!original_type)
		return INITIALIZE_HINT_QDEL
	. = ..()
	src.original_type = original_type
	var/obj/created_type = new original_type // Instancing this for the sake of assigning its appearance to the prop and nothing else
	name = initial(original_type.name)
	icon = initial(original_type.icon)
	icon_state = initial(original_type.icon_state)
	desc = initial(original_type.desc)
	if(ispath(original_type, /obj/item))
		var/obj/item/item_type = original_type
		item_state = initial(item_type.item_state)

	appearance = created_type.appearance
	qdel(created_type)

/obj/item/prop/laz_top
	name = "lazertop"
	desc = "一把压缩成笔记本电脑的雷克西姆RXF-M5 EVA手枪！也被称为“Laz-top”。这是分别为大阿根廷和美国秘密项目开发的一系列隐蔽刺杀武器中的一员。"
	icon_state = "laptop-gun"
	icon = 'icons/obj/structures/props/server_equipment.dmi'
	item_state = ""
	w_class = SIZE_SMALL
	garbage = TRUE

/obj/item/prop/geiger_counter
	name = "盖革计数器"
	desc = "盖革计数器测量其接收到的辐射。这种型号会自动记录并传输读取到的任何信息，前提是它有电池，除了开启外无需用户输入。"
	icon = 'icons/obj/items/devices.dmi'
	icon_state = "geiger"
	item_state = ""
	w_class = SIZE_SMALL
	flags_equip_slot = SLOT_WAIST
	///Whether the geiger counter is on or off
	var/toggled_on = FALSE
	///Iconstate of geiger counter when on
	var/enabled_state = "geiger_on"
	///Iconstate of geiger counter when off
	var/disabled_state = "geiger"
	///New battery it will spawn with
	var/starting_battery = /obj/item/cell/crap
	///Battery inside geiger counter
	var/obj/item/cell/battery //It doesn't drain the battery, but it has a battery for emergency use

/obj/item/prop/geiger_counter/Initialize(mapload, ...)
	. = ..()
	if(!starting_battery)
		return
	battery = new starting_battery(src)

/obj/item/prop/geiger_counter/Destroy()
	. = ..()
	if(battery)
		qdel(battery)

/obj/item/prop/geiger_counter/attack_self(mob/user)
	. = ..()
	toggled_on = !toggled_on
	if(!battery)
		to_chat(user, SPAN_NOTICE("[src]缺少电池。"))
		return
	to_chat(user, SPAN_NOTICE("你[toggled_on ? "enable" : "disable"] [src]."))
	update_icon()

/obj/item/prop/geiger_counter/attackby(obj/item/attacking_item, mob/user)
	. = ..()
	if(!HAS_TRAIT(attacking_item, TRAIT_TOOL_SCREWDRIVER) && !HAS_TRAIT(attacking_item, TRAIT_TOOL_CROWBAR))
		return

	if(!battery)
		to_chat(user, SPAN_NOTICE("没有电池可供你移除。"))
		return
	to_chat(user, SPAN_NOTICE("你用[attacking_item]将[battery]从[src]中撬出，使其不可逆地脱落。"))
	user.put_in_hands(battery)
	battery = null
	update_icon()

/obj/item/prop/geiger_counter/update_icon()
	. = ..()

	if(battery && toggled_on)
		icon_state = enabled_state
		return
	icon_state = disabled_state

/obj/item/prop/tableflag
	name = "美洲合众国桌旗"
	desc = "一面代表整个北美、南美和中美洲的美洲合众国微型桌旗。"
	icon = 'icons/obj/items/table_decorations.dmi'
	icon_state = "uaflag"
	force = 0.5
	w_class = SIZE_SMALL

/obj/item/prop/tableflag/uscm
	name = "USCM桌旗"
	desc = "一面美国殖民地海军陆战队的微型桌旗。旗帜底部写有“Semper Fi”（永远忠诚）。"
	icon_state = "uscmflag"

/obj/item/prop/tableflag/uscm2
	name = "USCM历史桌旗"
	desc = "一面美国殖民地海军陆战队的传统猩红与金色微型历史桌旗。USCM徽标位于中央；一只鹰栖息其上，后方衬有一个船锚。"
	icon_state = "uscmflag2"

/obj/item/prop/tableflag/upp
	name = "UPP桌旗"
	desc = "一面进步人民联盟的微型桌旗，猩红的背景上环绕着17颗黄色星星，中间是一颗更大的星。"
	icon_state = "uppflag"

/obj/item/prop/flower_vase
	name = "花瓶"
	desc = "一个空的玻璃花瓶。"
	icon_state = "flowervase"
	icon = 'icons/obj/items/table_decorations.dmi'
	w_class = SIZE_SMALL

/obj/item/prop/flower_vase/bluewhiteflowers
	name = "蓝白花束花瓶"
	desc = "一个插满蓝色和白色玫瑰的花瓶。"
	icon_state = "bluewhiteflowers"

/obj/item/prop/flower_vase/redwhiteflowers
	name = "红白花束花瓶"
	desc = "一个插满红色和白色玫瑰的花瓶。"
	icon_state = "redwhiteflowers"

/obj/item/prop/colony/usedbandage
	name = "脏绷带"
	desc = "一些用过的纱布。"
	icon_state = "bandages_prop"
	icon = 'icons/obj/structures/props/furniture/misc.dmi'

/obj/item/prop/colony/used_flare
	name = "flare"
	desc = "一根用过的USCM制式照明弹。侧面有使用说明，写着‘拉绳，发光’。"
	icon_state = "flare-empty"
	icon = 'icons/obj/items/lighting.dmi'

/obj/item/prop/colony/canister
	name = "燃料罐"
	desc = "一个油桶。在太空里！或者也许在某个殖民地。"
	icon_state = "canister"
	icon = 'icons/obj/items/tank.dmi'

/obj/item/prop/colony/proptag
	name = "信息身份牌"
	desc = "一名阵亡陆战队员的信息身份牌。上面写着：（空白）"
	icon_state = "dogtag_taken"
	icon = 'icons/obj/items/card.dmi'

/obj/item/prop/colony/game
	name = "便携式游戏套件"
	desc = "一台ThinkPad Systems Game-Bro掌上游戏机（简称TSGBH）。可以玩国际象棋、跳棋、三维象棋，还能运行Byond！不过这台没电了。"
	icon_state = "game_kit"
	icon = 'icons/obj/items/toy.dmi'

/obj/item/prop/gripper
	name = "磁性抓取器"
	desc = "一种供合成人资产使用的简易抓取工具。"
	icon_state = "gripper"
	icon = 'icons/obj/items/devices.dmi'

/obj/item/prop/matter_decompiler
	name = "物质解译器"
	desc = "吞食垃圾、玻璃碎片或其他碎屑将补充你的储备。"
	icon_state = "decompiler"
	icon = 'icons/obj/items/devices.dmi'

/// Xeno-specific props

/obj/item/prop/alien/hugger
	name = "????"
	desc = "它的尾巴末端有某种管状物。这到底是什么鬼东西？"
	icon = 'icons/mob/xenos/effects.dmi'
	icon_state = "facehugger_impregnated"

//-----USS Almayer Props -----//
//Put any props that don't function properly, they could function in the future but for now are for looks. This system could be expanded for other maps too. ~Art

/obj/item/prop/almayer
	name = "通用阿尔迈耶号道具"
	desc = "此内容不应可见，如果你看到这个，说明PROP.DM文件存在问题，请提交错误报告"
	icon = 'icons/obj/structures/props/almayer/almayer_props.dmi'
	icon_state = "hangarbox"

/obj/item/prop/almayer/box
	name = "金属板条箱"
	desc = "一种常用于存放运输机小型电子设备的金属板条箱。"
	icon_state = "hangarbox"
	w_class = SIZE_LARGE

/obj/item/prop/almayer/flight_recorder
	name = "\improper FR-112 flight recorder"
	desc = "一个小红盒子，内含运输机执行任务期间的飞行数据。通常被称为黑匣子，尽管这个是血红色的。"
	icon_state = "flight_recorder"
	w_class = SIZE_LARGE

/obj/item/prop/almayer/flight_recorder/colony
	name = "\improper CIR-60 colony information recorder"
	desc = "一个小红盒子，记录殖民地公告、殖民者生命体征消失及其他关键读数。通常被称为黑匣子，尽管这个是血红色的。"
	icon_state = "flight_recorder"
	w_class = SIZE_LARGE

/obj/item/prop/almayer/flare_launcher
	name = "\improper MJU-77/C case"
	desc = "一种通常安装在运输机上的照明弹发射器，用于提高对抗红外制导导弹的生存能力。"
	icon_state = "flare_launcher"
	w_class = SIZE_SMALL

/obj/item/prop/almayer/chaff_launcher
	name = "\improper RR-247 Chaff case"
	desc = "一种通常安装在运输机上的箔条发射器，用于提高对抗雷达制导导弹的生存能力。"
	icon_state = "chaff_launcher"
	w_class = SIZE_MEDIUM

/obj/item/prop/almayer/handheld1
	name = "小型手持设备"
	desc = "一小块电子小玩意儿。"
	icon_state = "handheld1"
	w_class = SIZE_SMALL

/obj/item/prop/almayer/comp_closed
	name = "运输机维护电脑"
	desc = "一台关闭的运输机维护电脑，技术员和飞行员用它来排查运输机故障。它有为不同系统准备的各种接口。"
	icon_state = "hangar_comp"
	w_class = SIZE_LARGE

/obj/item/prop/almayer/comp_open
	name = "运输机维护电脑"
	desc = "一台打开的运输机维护电脑，但似乎处于关闭状态。技术员和飞行员用它来定位运输机上的受损或故障系统。它有为不同系统准备的各种接口。"
	icon_state = "hangar_comp_open"
	w_class = SIZE_LARGE

//lore fluff books and magazines

/obj/item/prop/magazine
	name = "普通道具杂志"
	desc = "一本封面上印着漂亮女孩的杂志……等等，那不是我老妈吗？"
	icon = 'icons/obj/structures/props/wall_decorations/posters.dmi'
	icon_state = "poster15"
	throw_speed = SPEED_FAST
	throw_range = 5
	w_class = SIZE_MEDIUM
	attack_verb = list("bashed", "whacked", "educated")
	pickup_sound = "sound/handling/book_pickup.ogg"
	drop_sound = "sound/handling/book_pickup.ogg"
	black_market_value = 15

//random magazines
/obj/item/prop/magazine/dirty
	name = "色情杂志"
	desc = "哇哇哇哇。"
	icon_state = "poster17"

/obj/item/prop/magazine/dirty/torn
	name = "\improper torn magazine page"
	desc = "哇哦哇哦。"

/obj/item/prop/magazine/dirty/torn/alt
	icon_state = "poster3"


//books
/obj/item/prop/magazine/book
	name = "普通道具书籍"
	desc = "一本普通的精装书，里面的字母组合起来，形成了我们通常所说的‘单词’。它的书页由纸张制成，这是一种用纤维素（通常存在于树木中）创造的材料。"
	icon = 'icons/obj/items/books.dmi'
	icon_state = "book_white"
	item_state = "book_white"

/obj/item/prop/magazine/book/spacebeast //The presence of this book is actually anachronistic, given that it was only published in 2183
	name = "\improper Space Beast, by Robert Morse"
	desc = "一本聚焦于2179年8月‘Fury 161’事件的自传，讲述了‘艾伦·雷普利’和一种被称为‘巨龙’的未知外星生物抵达后的故事。该书文笔极其粗劣，出版后不久即被禁。"
	icon_state = "book_dark"
	item_state = "book_dark"

/obj/item/prop/magazine/book/borntokill
	name = "\improper Born to Kill"
	desc = "德里克·A·W·战斧撰写的自传，记述了他在美国殖民地海军陆战队（USCM），更具体地说是第三舰队服役的经历。该书因其平淡、重复且毫无生气的文笔而受到公众甚至一些联合美洲（UA）军方成员的严厉批评，因此反响相当糟糕。然而，合成人士兵通常喜欢并重视其中包含的信息。"
	icon_state = "book_green"
	item_state = "book_green"

/obj/item/prop/magazine/book/bladerunner
	name = "\improper Bladerunner: A True Detectives Story"
	desc = "在2119年月球黑暗的地下城中，银翼杀手理查德·福特被召出退休，奉命处决一群逃离地球、寻求存在意义的复制人教派。"
	icon_state = "book_tan"
	item_state = "book_tan"

/obj/item/prop/magazine/book/starshiptroopers
	name = "星河战队"
	desc = "罗伯特·A·海因莱因所著，这本书在描绘我们‘士兵’拥有的个人装备方面确实偏离了现实，但它仍然被发放给每个基础训练中的陆战队员，所以肯定有其价值。"
	icon_state = "book_blue"
	item_state = "book_blue"

/obj/item/prop/magazine/book/theartofwar
	name = "孙子兵法"
	desc = "由古代地球的伟大将军、战略家和哲学家——传奇人物孙武所著的战争论著。这本书在美国殖民地海军陆战队司令的推荐阅读书目上，大多数军官都有一本。读过此书的军官大多声称比没读过的人更懂战斗，但实际效果可能因人而异。"
	icon_state = "book_red"
	item_state = "book_red"

//boots magazine
/obj/item/prop/magazine/boots
	name = "普通《军靴！》杂志"
	desc = "唯一官方的USCM杂志！"
	icon = 'icons/obj/items/paper.dmi'
	icon_state = "boots!"

/obj/item/prop/magazine/boots/n07
	name = "《军靴！》：第7期"
	desc = "唯一官方的USCM杂志，头条标题是‘未来士兵！’。随后的短段落描述了B18防御护甲，旨在使现代陆战队员刀枪不入，并称其最近已完成测试，提升了高层对这种新装备的期望。"

/obj/item/prop/magazine/boots/n45
	name = "《军靴！》：第45期"
	desc = "唯一官方的USCM杂志，头条标题是‘你的配枪与你！’，副标题‘你最好的睡眠伴侣’紧随其后。文章第一部分解释了基本的配枪维护，并附有一则位于门户空间站的知名枪匠的小广告。第二部分描述了在发生意外叛乱活动时，将配枪放在枕头下睡觉的最佳姿势。"

/obj/item/prop/magazine/boots/n054
	name = "《军靴！》第54期"
	desc = "这是USCM唯一的官方杂志，头条标题是‘阿玛特公司在M41A-MK2自清洁案中对诉讼人发起反击’。"

/obj/item/prop/magazine/boots/n055
	name = "《军靴！》第55期"
	desc = "这是USCM唯一的官方杂志，头条标题是‘保持你的UD4驾驶舱更安全、更舒适的十大技巧’。"

/obj/item/prop/magazine/boots/n058
	name = "《军靴！》第58期"
	desc = "这是USCM唯一的官方杂志，头条标题是‘迅捷、无声、致命：天津行动’。文章随后描述了第一侦察营老兵在天津战役中的经历，以及他们在对付UPP和当地游击队时不得不面对的严酷丛林环境。"

/obj/item/prop/magazine/boots/n070
	name = "《军靴！》第70期"
	desc = "这是USCM唯一的官方杂志，头条标题是‘陆战队员70，战争的未来’。文章随后详细介绍了‘陆战队员70’计划的规划和实施，该计划旨在帮助USCM在2170年实现现代化。"

/obj/item/prop/magazine/boots/n113
	name = "《军靴！》第113期"
	desc = "这是USCM唯一的官方杂志，头条标题是‘堪培拉，战斗的前沿’。文章随后详细描述了陆战队员不得不面对的激烈城市战斗，一些坦克兵关于新型M40里奇威坦克效能的记述，以及最近在行动区域内目击到陆战队特种部队（突袭者）的情况。"

/obj/item/prop/magazine/boots/n117
	name = "《军靴！》第117期"
	desc = "这是USCM唯一的官方杂志，头条标题是‘停止投毒’。短文进一步解释了陆战队员将CN-20神经毒气扔进卫生间作为恶作剧的危险性。"

/obj/item/prop/magazine/boots/n120
	name = "《军靴！》特别纪念刊第120期"
	desc = "这是USCM唯一的官方杂志，头条标题是‘华莱士·凯利·哈尔，2136-2181’。"

/obj/item/prop/magazine/boots/n125
	name = "《军靴！》第125期"
	desc = "这是USCM唯一的官方杂志，头条标题是‘布拉沃班……不只是负责前哨基地勤务！’。尽管标题如此，文章主要由路障照片和弹药箱摆放示意图组成。"

/obj/item/prop/magazine/boots/n131
	name = "《军靴！》第131期"
	desc =  "这是USCM唯一的官方杂志，头条标题是‘禁止闷烧’。接下来的段落详细说明了HSDP烟雾弹不适合长时间吸入暴露，以及缺氧是一种糟糕的致幻方式。"

/obj/item/prop/magazine/boots/n150
	name = "《军靴！》第150期"
	desc = "这是USCM唯一的官方杂志，头条标题是‘UPP口粮，真相’。短文进一步解释说，UPP野战口粮并未标准化，而是在地方层面生产。因此，缴获和没收的UPP口粮中包含了一些奇怪的选择，例如鸭肝、皮蛋、碱渍鳕鱼、腌猪鼻、罐头牛肚和脱水糖渍萝卜零食。"

/obj/item/prop/magazine/boots/n160
	name = "《军靴！》第160期"
	desc = "这是USCM唯一的官方杂志，头条标题是‘公司联络官因坑害太多人而‘情感枯竭’’。"

/obj/item/prop/magazine/boots/n189
	name = "《军靴！》第189期"
	desc = "这是USCM唯一的官方杂志，头条标题是‘宪兵特辑，那些帮助陆战队员自助的人！’。就像你见过的每一本第189期杂志一样，有人花时间用粗俗的语言和不雅的图画对它进行了涂鸦。"

// Massive Digger by dimdimich1996

/obj/structure/prop/invuln/dense/excavator
	name = "30型轻型挖掘机"
	desc = "维兰德-汤谷公司30型轻型挖掘机。尽管看起来像一头巨兽，但与其他W-Y地形改造挖掘机相比，30型相当轻便。其设计可拆卸运输并在现场重新组装。这台是漂亮的橙色。"
	icon = 'icons/obj/structures/props/digger.dmi'
	icon_state = "digger_orange"
	layer = BIG_XENO_LAYER

/obj/structure/prop/invuln/dense/excavator/gray
	desc = "维兰德-汤谷公司30型轻型挖掘机。尽管看起来像一头巨兽，但与其他W-Y地形改造挖掘机相比，30型相当轻便。其设计可拆卸运输并在现场重新组装。这台是漂亮的灰色。"
	icon_state = "digger_gray"

/obj/structure/prop/invuln/dense/excavator/Initialize()
	. = ..()
	if(dir & (SOUTH|NORTH))
		bound_height = 192
		bound_width = 96
	else
		bound_height = 96
		bound_width = 192
