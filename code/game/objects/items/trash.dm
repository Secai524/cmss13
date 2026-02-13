//////////////////
///Trash Parent///
//////////////////
/obj/item/trash
	icon = 'icons/obj/items/trash.dmi'
	w_class = SIZE_SMALL
	desc = "这是垃圾。"
	garbage = TRUE

//////////////
///Wrappers///
//////////////

/obj/item/trash/barcardine
	name = "碧卡利定能量棒包装纸"
	desc = "一张碧卡利定能量棒的空包装纸。你注意到内侧有几个医疗标签。你不确定自己是否在意这个。"
	icon_state = "barcardine_trash"

/obj/item/trash/boonie
	name = "丛林帽能量棒包装纸"
	desc = "一张薄荷绿色的包装纸。让你想起了另一个涉及薄荷绿色的糟糕决定，但你想不起来是什么了……"
	icon_state = "boonie_trash"

/obj/item/trash/burger
	name = "汉堡包装纸"
	icon_state = "burger"
	desc = "一张油腻的塑料薄膜，曾经包裹着一个芝士汉堡。由维兰德-汤谷公司包装。"

/obj/item/trash/burger/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/trash/buritto
	name = "墨西哥卷饼包装纸"
	icon_state = "burrito"
	desc = "一张恶臭的塑料薄膜，曾经包裹着一个微波墨西哥卷饼。由维兰德-汤谷公司包装。"

/obj/item/trash/buritto/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/trash/candy
	name = "糖果"
	icon_state= "candy"

/obj/item/trash/cheesie
	name = "芝士喇叭"
	gender = PLURAL
	icon_state = "cheesie_honkers"

/obj/item/trash/chips
	name = "薯片"
	gender = PLURAL
	icon_state = "chips"

/obj/item/trash/chunk
	name = "大块能量棒盒子"
	desc = "一个大块能量棒的空盒子。明显轻了很多。"
	icon_state = "chunk_trash"

/obj/item/trash/chunk/hunk
	name = "超大块能量棒板条箱"
	desc = "一个超大块能量棒的空板条箱。重量极大地减轻了。"
	icon_state = "hunk_trash"

/obj/item/trash/eat
	name = "EAT能量棒包装纸"
	icon_state = "eat"

/obj/item/trash/hotdog
	name = "热狗包装纸"
	icon_state = "hotdog"
	desc = "一张发霉的塑料薄膜，曾经包裹着一个热狗。由维兰德-汤谷公司包装。"

/obj/item/trash/hotdog/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/trash/kepler
	name = "开普勒包装纸"
	icon_state = "kepler"

/obj/item/trash/kepler/flamehot
	name = "开普勒火焰辣味包装纸"
	icon_state = "flamehotkepler"

/obj/item/trash/popcorn
	name = "爆米花"
	icon_state = "popcorn"

/obj/item/trash/popcorn/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/trash/raisins
	name = "无葡萄干"
	gender = PLURAL
	icon_state= "4no_raisins"

/obj/item/trash/semki
	name = "塞姆基包"
	icon_state = "semki_pack"

/obj/item/trash/sosjerky
	name = "胆小鬼私藏牛肉干"
	icon_state = "sosjerky"

/obj/item/trash/syndi_cakes
	name = "辛迪蛋糕"
	gender = PLURAL
	icon_state = "syndi_cakes"

/obj/item/trash/uscm_mre
	name = "\improper crumbled USCM MRE"
	desc = "它已为USCM尽了一份力。你呢？"
	icon = 'icons/obj/items/storage/mre.dmi'
	icon_state = "mealpackempty"

/obj/item/trash/upp_mre
	name = "\improper crumbled UPP IRP"
	desc = "饥饿的士兵就是死去的士兵。"
	icon = 'icons/obj/items/storage/mre.dmi'
	icon_state = "upp_mealpackempty"

/obj/item/trash/twe_mre
	name = "\improper crumbled TWE ORP"
	desc = "帝国永不饥饿..."
	icon = 'icons/obj/items/storage/mre.dmi'
	icon_state = "twe_mealpackempty"

/obj/item/trash/pmc_mre
	name = "\improper crumbled PMC CFR"
	desc = "对于一个皱巴巴的包装纸来说，它的市场成本可真高。"
	icon = 'icons/obj/items/storage/mre.dmi'
	icon_state = "pmc_mealpackempty"

/obj/item/trash/wy_mre
	name = "\improper crumbled W-Y ration"
	desc = "提醒：在工作场所乱扔垃圾将处以削减每日配给的惩罚。"
	icon = 'icons/obj/items/storage/mre.dmi'
	icon_state = "wy_mealpackempty"

/obj/item/trash/merc_mre
	name = "\improper crumbled FSR ration"
	desc = "谁把它留在这儿的？平民？徒步旅行者？军事收藏家？还是卧底雇佣兵？"
	icon = 'icons/obj/items/storage/mre.dmi'
	icon_state = "mealpackempty"

/obj/item/trash/waffles
	name = "华夫饼"
	gender = PLURAL
	icon_state = "waffles"

/obj/item/trash/wy_chips_pepper
	name = "维兰德-汤谷胡椒薯片"
	gender = PLURAL
	icon_state = "wy_chips_pepper"
	desc = "一个油腻的空袋子，曾经装着维兰德-汤谷胡椒薯片。"

//////////////////////
///Ciagarette Butts///
//////////////////////

/obj/item/trash/cigbutt
	name = "烟蒂"
	desc = "一个肮脏的旧烟蒂。"
	icon = 'icons/obj/items/smoking/cigarettes.dmi'
	icon_state = "cigbutt"
	w_class = SIZE_TINY
	throwforce = 1

/obj/item/trash/cigbutt/Initialize()
	. = ..()
	pixel_x = rand(-10,10)
	pixel_y = rand(-10,10)
	apply_transform(turn(transform,rand(0,360)))

/obj/item/trash/cigbutt/ucigbutt
	desc = "一个肮脏的旧无过滤嘴烟蒂。"
	icon_state = "ucigbutt"


/obj/item/trash/cigbutt/bcigbutt
	desc = "一个装在精美黑色包装里的肮脏旧烟蒂。"
	icon_state = "bcigbutt"

/obj/item/trash/cigbutt/cigarbutt
	name = "雪茄烟蒂"
	desc = "一个肮脏的旧雪茄烟蒂。"
	icon_state = "cigarbutt"
	icon = 'icons/obj/items/smoking/cigars.dmi'

////////////
///Dishes///
////////////

/obj/item/trash/plate
	name = "盘子"
	icon_state = "plate"

/obj/item/trash/ceramic_plate
	name = "陶瓷板"
	icon_state = "ceramic_plate"
	desc = "一个陶瓷盘子，看起来它还没完成作为食物托盘的爱国使命。现在你看着它，这或许是个不错的投掷武器..."
	throw_range = 5
	throw_speed = SPEED_VERY_FAST
	throwforce = 5

/obj/item/trash/ceramic_plate/launch_impact(atom/hit_atom)
	. = ..()
	playsound(get_turf(src), "shatter", 50, TRUE)
	visible_message(SPAN_DANGER("\The [src] shatters into a thousand tiny fragments!"))
	qdel(src)

/obj/item/trash/snack_bowl
	name = "零食碗"
	icon_state = "snack_bowl"

/obj/item/trash/tray
	name = "托盘"
	icon_state = "tray"

/obj/item/trash/USCMtray
	name = "\improper USCM Tray"
	desc = "已结束服役期。"
	icon_state = "MREtray"

//////////
///Misc///
//////////

/obj/item/trash/candle
	name = "candle"
	icon = 'icons/obj/items/candle.dmi'
	icon_state = "candle4"

/obj/item/trash/c_tube
	name = "纸板管"
	desc = "一个...纸板管。"
	icon = 'icons/obj/items/tools.dmi'
	icon_state = "c_tube"
	throwforce = 1
	w_class = SIZE_SMALL
	throw_speed = SPEED_VERY_FAST
	throw_range = 5


// Hybrisa
/obj/item/trash/hybrisa
	icon = 'icons/obj/structures/props/hybrisa/misc_props.dmi'
	icon_state = ""

// Cuppa Joe's Trash
/obj/item/trash/hybrisa/cuppa_joes
	icon = 'icons/obj/items/food/drinks.dmi'

/obj/item/trash/hybrisa/cuppa_joes/lid
	name = "Cuppa Joe咖啡杯盖"
	desc = "你拥有CuppaJoe的微笑吗？保持活力！冻干CuppaJoe咖啡。"
	icon_state = "coffeecuppajoelid"
	w_class = SIZE_TINY
	throwforce = 1
/obj/item/trash/hybrisa/cuppa_joes/empty_cup
	name = "空的Cuppa Joe咖啡杯"
	desc = "你拥有CuppaJoe的微笑吗？保持活力！冻干CuppaJoe咖啡。"
	icon_state = "coffeecuppajoenolid"
	w_class = SIZE_TINY
	throwforce = 1

/obj/item/trash/hybrisa/cuppa_joes/Initialize()
	. = ..()
	pixel_x = rand(-10,10)
	pixel_y = rand(-10,10)
	apply_transform(turn(transform,rand(0,360)))

// Cuppa Joes no random axis
/obj/item/trash/hybrisa/cuppa_joes_static/lid
	name = "Cuppa Joe咖啡杯盖"
	desc = "你拥有CuppaJoe的微笑吗？保持活力！冻干CuppaJoe咖啡。"
	icon = 'icons/obj/items/food/drinks.dmi'
	icon_state = "coffeecuppajoelid"
	w_class = SIZE_TINY
	throwforce = 1
/obj/item/trash/hybrisa/cuppa_joes_static/empty_cup
	name = "空的Cuppa Joe咖啡杯"
	desc = "你拥有CuppaJoe的微笑吗？保持活力！冻干CuppaJoe咖啡。"
	icon = 'icons/obj/items/food/drinks.dmi'
	icon_state = "coffeecuppajoenolid"
	w_class = SIZE_TINY
	throwforce = 1

/obj/item/trash/hybrisa/cuppa_joes_static/empty_cup_stack
	name = "空的Cuppa Joe咖啡杯堆"
	desc = "你拥有CuppaJoe的微笑吗？保持活力！冻干CuppaJoe咖啡。"
	icon = 'icons/obj/items/food/drinks.dmi'
	icon_state = "coffeecuppajoestacknolid"
	w_class = SIZE_TINY
	throwforce = 1

/obj/item/trash/hybrisa/cuppa_joes_static/lid_stack
	name = "Cuppa Joe咖啡杯盖堆"
	desc = "你拥有CuppaJoe的微笑吗？保持活力！冻干CuppaJoe咖啡。"
	icon = 'icons/obj/items/food/drinks.dmi'
	icon_state = "coffeecuppajoelidstack"
	w_class = SIZE_TINY
	throwforce = 1
