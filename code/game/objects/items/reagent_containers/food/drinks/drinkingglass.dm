

/obj/item/reagent_container/food/drinks/drinkingglass
	name = "glass"
	desc = "标准的饮水杯。"
	icon_state = "glass_empty"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/food_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/food_righthand.dmi'
	)
	matter = list("glass" = 500)
	amount_per_transfer_from_this = 5
	volume = 50
	center_of_mass = "x=16;y=10"

/obj/item/reagent_container/food/drinks/drinkingglass/on_reagent_change()
	/*if(length(reagents.reagent_list) > 1 )
		icon_state = "glass_brown"
		name = "一杯私酿烈酒"
		desc = "两种或更多饮料混合而成。"*/
	/*else if(length(reagents.reagent_list) == 1)
		for(var/datum/reagent/R in reagents.reagent_list)
			switch(R.id)*/
	if (length(reagents.reagent_list) > 0)
		//mrid = R.get_master_reagent_id()
		var/datum/reagent/R = reagents.get_master_reagent()
		switch(R.id)
			if("beer")
				icon_state = "beerglass"
				name = "啤酒杯"
				desc = "一杯冰镇啤酒。"
				center_of_mass = "x=16;y=8"
			if("beer2")
				icon_state = "beerglass"
				name = "啤酒杯"
				desc = "一杯冰镇啤酒。"
				center_of_mass = "x=16;y=8"
			if("ale")
				icon_state = "aleglass"
				name = "麦芽酒杯"
				desc = "一杯冰镇美味的麦芽酒。"
				center_of_mass = "x=16;y=8"
			if("milk")
				icon_state = "glass_white"
				name = "一杯牛奶"
				desc = "白色又营养的美味！"
				center_of_mass = "x=16;y=10"
			if("cream")
				icon_state  = "glass_white"
				name = "一杯奶油"
				desc = "呃……"
				center_of_mass = "x=16;y=10"
			if("chocolatesyrup")
				icon_state  = "chocolateglass"
				name = "一杯巧克力糖浆"
				desc = "太放纵了！"
				center_of_mass = "x=16;y=10"
			if("chocolate_milk")
				icon_state  = "chocomilk_glass"
				name = "巧克力牛奶"
				desc = "童年的经典，能让最铁血的陆战队员也露出微笑。"
				center_of_mass = "x=16;y=10"
			if("lemonjuice")
				icon_state  = "lemonglass"
				name = "一杯柠檬汁"
				desc = "好酸……"
				center_of_mass = "x=16;y=10"
			if("cola")
				icon_state  = "glass_brown"
				name = "一杯太空可乐"
				desc = "一杯清爽的太空可乐。"
				center_of_mass = "x=16;y=10"
			if("nuka_cola")
				icon_state = "nuka_colaglass"
				name = "核子可乐"
				desc = "别哭，别抬眼，这只是核废土。"
				center_of_mass = "x=16;y=6"
			if("orangejuice")
				icon_state = "glass_orange"
				name = "一杯橙汁"
				desc = "维生素！耶！"
				center_of_mass = "x=16;y=10"
			if("tomatojuice")
				icon_state = "glass_red"
				name = "一杯番茄汁"
				desc = "你确定这是番茄汁吗？"
				center_of_mass = "x=16;y=10"
			if("blood")
				icon_state = "glass_red"
				name = "一杯番茄汁"
				desc = "你确定这是番茄汁吗？"
				center_of_mass = "x=16;y=10"
			if("limejuice")
				icon_state = "glass_green"
				name = "一杯青柠汁"
				desc = "一杯酸甜的青柠汁。"
				center_of_mass = "x=16;y=10"
			if("whiskey")
				icon_state = "whiskeyglass"
				name = "一杯威士忌"
				desc = "杯中丝滑、烟熏风味的威士忌佳酿让这杯酒看起来非常优雅。"
				center_of_mass = "x=16;y=12"
			if("gin")
				icon_state = "ginvodkaglass"
				name = "一杯金酒"
				desc = "一杯晶莹剔透的格里芬特金酒。"
				center_of_mass = "x=16;y=12"
			if("sake")
				icon_state = "ginvodkaglass"
				name = "一杯清酒"
				desc = "一杯温热的维兰德-汤谷品牌清酒。"
				center_of_mass = "x=16;y=12"
			if("vodka")
				icon_state = "ginvodkaglass"
				name = "一杯伏特加"
				desc = "杯中是伏特加。辛塔牌。"
				center_of_mass = "x=16;y=12"
			if("sake")
				icon_state = "ginvodkaglass"
				name = "一杯清酒"
				desc = "一杯清酒。"
				center_of_mass = "x=16;y=12"
			if("goldschlager")
				icon_state = "ginvodkaglass"
				name = "一杯金箔酒"
				desc = "百分百证明少女会喝任何含金箔的东西。"
				center_of_mass = "x=16;y=12"
			if("wine")
				icon_state = "wineglass"
				name = "一杯葡萄酒"
				desc = "一杯看起来非常优雅的饮品。"
				center_of_mass = "x=15;y=7"
			if("cognac")
				icon_state = "cognacglass"
				name = "一杯干邑白兰地"
				desc = "该死，光是拿着这杯酒，你就感觉自己像个法国贵族。"
				center_of_mass = "x=16;y=6"
			if ("kahlua")
				icon_state = "kahluaglass"
				name = "一杯RR咖啡利口酒"
				desc = "该死，这东西看起来劲头十足"
				center_of_mass = "x=15;y=7"
			if("vermouth")
				icon_state = "vermouthglass"
				name = "一杯苦艾酒"
				desc = "你甚至在想自己为什么要纯饮这玩意儿。"
				center_of_mass = "x=16;y=12"
			if("tequila")
				icon_state = "tequilaglass"
				name = "一杯龙舌兰酒"
				desc = "现在只差一副颜色古怪的墨镜了！"
				center_of_mass = "x=16;y=12"
			if("patron")
				icon_state = "patronglass"
				name = "一杯培恩酒"
				desc = "在酒吧里喝着培恩，周围全是些不入流的女士。"
				center_of_mass = "x=7;y=8"
			if("rum")
				icon_state = "rumglass"
				name = "一杯朗姆酒"
				desc = "现在你想要一件海盗服了，对吧？"
				center_of_mass = "x=16;y=12"
			if("gintonic")
				icon_state = "gintonicglass"
				name = "金汤力"
				desc = "一杯温和但依然出色的鸡尾酒。干了它，像个真正的英国人一样。"
				center_of_mass = "x=16;y=7"
			if("whiskeycola")
				icon_state = "whiskeycolaglass"
				name = "威士忌可乐"
				desc = "看起来人畜无害的可乐威士忌混合饮料。美味。"
				center_of_mass = "x=16;y=9"
			if("whiterussian")
				icon_state = "whiterussianglass"
				name = "白色俄罗斯"
				desc = "一杯非常好看的饮料。但这只是，呃，你的个人看法，伙计。"
				center_of_mass = "x=16;y=9"
			if("screwdrivercocktail")
				icon_state = "screwdriverglass"
				name = "螺丝起子"
				desc = "伏特加和橙汁的简单而卓越的混合。正是疲惫工程师的良药。"
				center_of_mass = "x=15;y=10"
			if("bloodymary")
				icon_state = "bloodymaryglass"
				name = "血腥玛丽"
				desc = "番茄汁，混合了伏特加和一点青柠。尝起来像液态谋杀。"
				center_of_mass = "x=16;y=10"
			if("martini")
				icon_state = "martiniglass"
				name = "经典马天尼"
				desc = "该死，酒保甚至只是搅拌了它，没有摇匀。"
				center_of_mass = "x=17;y=8"
			if("vodkamartini")
				icon_state = "martiniglass"
				name = "伏特加马提尼"
				desc ="对经典马提尼的拙劣模仿。但依然很棒。"
				center_of_mass = "x=17;y=8"
			if("gargleblaster")
				icon_state = "gargleblasterglass"
				name = "泛银河系含漱爆破液"
				desc = "这……这是否意味着亚瑟和福特在空间站上？哦，真开心。"
				center_of_mass = "x=17;y=6"
			if("bravebull")
				icon_state = "bravebullglass"
				name = "勇敢公牛"
				desc = "龙舌兰和咖啡利口酒，融合成令人垂涎的混合物。干了它。"
				center_of_mass = "x=15;y=8"
			if("tequilasunrise")
				icon_state = "tequilasunriseglass"
				name = "龙舌兰日出"
				desc = "哦，太好了，现在你开始怀念地球上的日出了……"
				center_of_mass = "x=16;y=10"
			if("phoronspecial")
				icon_state = "toxinsspecialglass"
				name = "毒素特调"
				desc = "哇哦，这玩意儿着火了"
			if("doctorsdelight")
				icon_state = "doctorsdelightglass"
				name = "医生的喜悦"
				desc = "多种果汁的健康混合物，保证让你在下一次工具箱砸头事件发生前保持健康。"
				center_of_mass = "x=16;y=8"
			if("manlydorf")
				icon_state = "manlydorfglass"
				name = "硬汉多夫"
				desc = "一种由麦芽酒和啤酒调制的男子汉饮品。仅供真男人享用。"
				center_of_mass = "x=16;y=10"
			if("irishcream")
				icon_state = "irishcreamglass"
				name = "爱尔兰奶油"
				desc = "这是奶油混合威士忌。你还能指望爱尔兰人做出什么别的？"
				center_of_mass = "x=16;y=9"
			if("cubalibre")
				icon_state = "cubalibreglass"
				name = "自由古巴"
				desc = "朗姆酒和可乐的经典混合。"
				center_of_mass = "x=16;y=8"
			if("b52")
				icon_state = "b52glass"
				name = "B-52"
				desc = "咖啡利口酒、爱尔兰奶油和白兰地。你会被炸翻的。"
				center_of_mass = "x=16;y=10"
			if("atomicbomb")
				icon_state = "atomicbombglass"
				name = "原子弹"
				desc = "维兰德-汤谷对您饮用后的行为不承担法律责任。"
				center_of_mass = "x=15;y=7"
			if("longislandicedtea")
				icon_state = "longislandicedteaglass"
				name = "长岛冰茶"
				desc = "酒柜里的佳酿，混合成美味饮品。仅供中年酗酒女性。"
				center_of_mass = "x=16;y=8"
			if("threemileisland")
				icon_state = "threemileislandglass"
				name = "三哩岛冰茶"
				desc = "来一杯这个，保证不会熔毁。"
				center_of_mass = "x=16;y=2"
			if("margarita")
				icon_state = "margaritaglass"
				name = "玛格丽塔"
				desc = "加冰，杯沿抹盐。干杯~！"
				center_of_mass = "x=16;y=8"
			if("blackrussian")
				icon_state = "blackrussianglass"
				name = "黑俄罗斯"
				desc = "专为乳糖不耐受者准备。依然像白俄一样优雅。"
				center_of_mass = "x=16;y=9"
			if("vodkatonic")
				icon_state = "vodkatonicglass"
				name = "伏特加汤力"
				desc = "当金汤力还不够“俄式”的时候。"
				center_of_mass = "x=16;y=7"
			if("manhattan")
				icon_state = "manhattanglass"
				name = "曼哈顿"
				desc = "侦探卧底时的首选饮品。他从来都受不了金酒……"
				center_of_mass = "x=17;y=8"
			if("manhattan_proj")
				icon_state = "proj_manhattanglass"
				name = "曼哈顿计划"
				desc = "科学家的首选饮品，用来思考如何炸掉空间站。"
				center_of_mass = "x=17;y=8"
			if("ginfizz")
				icon_state = "ginfizzglass"
				name = "金菲士"
				desc = "清爽柠檬味，美妙干涩口感。"
				center_of_mass = "x=16;y=7"
			if("irishcoffee")
				icon_state = "irishcoffeeglass"
				name = "爱尔兰咖啡"
				desc = "咖啡加酒精。比早上喝含羞草更有趣。"
				center_of_mass = "x=15;y=10"
			if("hooch")
				icon_state = "glass_brown2"
				name = "私酿烈酒"
				desc = "你现在真的跌到谷底了……你的肝脏昨晚已经打包走人了。"
				center_of_mass = "x=16;y=10"
			if("whiskeysoda")
				icon_state = "whiskeysodaglass2"
				name = "威士忌苏打"
				desc = "终极清爽。"
				center_of_mass = "x=16;y=9"
			if("tonic")
				icon_state = "glass_clear"
				name = "一杯汤力水"
				desc = "奎宁味道古怪，但至少能防住太空疟疾。"
				center_of_mass = "x=16;y=10"
			if("sodawater")
				icon_state = "glass_clear"
				name = "一杯苏打水"
				desc = "苏打水。何不来杯苏格兰威士忌加苏打？"
				center_of_mass = "x=16;y=10"
			if("water")
				icon_state = "glass_clear"
				name = "一杯水"
				desc = "所有清爽饮料之父。"
				center_of_mass = "x=16;y=10"
			if("spacemountainwind")
				icon_state = "Space_mountain_wind_glass"
				name = "一杯太空山风"
				desc = "太空山风。如你所知，太空中没有山，只有风。"
				center_of_mass = "x=16;y=10"
			if("thirteenloko")
				icon_state = "thirteen_loko_glass"
				name = "一杯十三乐可"
				desc = "这是一杯十三乐可，看起来品质上乘。指的是饮料，不是杯子。"
				center_of_mass = "x=16;y=10"
			if("dr_gibb")
				icon_state = "dr_gibb_glass"
				name = "一杯吉布博士"
				desc = "吉布博士。并不像名字听起来那么危险。"
				center_of_mass = "x=16;y=10"
			if("space_up")
				icon_state = "space-up_glass"
				name = "一杯太空汽水"
				desc = "太空汽水。帮你保持冷静。"
				center_of_mass = "x=16;y=10"
			if("moonshine")
				icon_state = "glass_clear"
				name = "月光酒"
				desc = "你现在真的跌到谷底了……你的肝脏昨晚已经打包走人了。"
				center_of_mass = "x=16;y=10"
			if("soymilk")
				icon_state = "glass_white"
				name = "一杯豆奶"
				desc = "白色且营养丰富的豆制品！"
				center_of_mass = "x=16;y=10"
			if("berryjuice")
				icon_state = "berryjuice"
				name = "一杯浆果汁"
				desc = "浆果汁。或者也可能是果酱。谁在乎呢？"
				center_of_mass = "x=16;y=10"
			if("poisonberryjuice")
				icon_state = "poisonberryjuice"
				name = "一杯毒浆果汁"
				desc = "一杯致命的果汁。"
				center_of_mass = "x=16;y=10"
			if("carrotjuice")
				icon_state = "carrotjuice"
				name = "一杯胡萝卜汁"
				desc = "就像胡萝卜一样，只是不用嚼。"
				center_of_mass = "x=16;y=10"
			if("banana")
				icon_state = "banana"
				name = "一杯香蕉汁"
				desc = "香蕉的原始精华。HONK"
				center_of_mass = "x=16;y=10"
			if("bahama_mama")
				icon_state = "bahama_mama"
				name = "巴哈马妈妈"
				desc = "热带鸡尾酒。"
				center_of_mass = "x=16;y=5"
			if("singulo")
				icon_state = "singulo"
				name = "奇点"
				desc = "一种蓝空间饮料。"
				center_of_mass = "x=17;y=4"
			if("alliescocktail")
				icon_state = "alliescocktail"
				name = "盟友鸡尾酒"
				desc = "一种用你的盟友调制的饮料。"
				center_of_mass = "x=17;y=8"
			if("antifreeze")
				icon_state = "antifreeze"
				name = "防冻液"
				desc = "终极提神饮品。"
				center_of_mass = "x=16;y=8"
			if("barefoot")
				icon_state = "b&p"
				name = "赤脚"
				desc = "赤脚与怀孕。"
				center_of_mass = "x=17;y=8"
			if("demonsblood")
				icon_state = "demonsblood"
				name = "恶魔之血"
				desc = "光是看着这东西就让你后颈发毛。"
				center_of_mass = "x=16;y=2"
			if("booger")
				icon_state = "booger"
				name = "鼻屎"
				desc = "呃……"
				center_of_mass = "x=16;y=10"
			if("snowwhite")
				icon_state = "snowwhite"
				name = "白雪"
				desc = "冰爽提神。"
				center_of_mass = "x=16;y=8"
			if("aloe")
				icon_state = "aloe"
				name = "芦荟汁"
				desc = "非常，非常，非常好。"
				center_of_mass = "x=17;y=8"
			if("andalusia")
				icon_state = "andalusia"
				name = "安达卢西亚"
				desc = "一杯名字古怪的好饮料。"
				center_of_mass = "x=16;y=9"
			if("sbiten")
				icon_state = "sbitenglass"
				name = "斯比特恩"
				desc = "伏特加与香料的辛辣混合。非常够劲。"
				center_of_mass = "x=17;y=8"
			if("red_mead")
				icon_state = "red_meadglass"
				name = "红蜂蜜酒"
				desc = "一款真正的维京饮品，尽管它的颜色很奇怪。"
				center_of_mass = "x=17;y=10"
			if("mead")
				icon_state = "meadglass"
				name = "蜂蜜酒"
				desc = "一款维京饮品，不过是便宜货。"
				center_of_mass = "x=17;y=10"
			if("iced_beer")
				icon_state = "iced_beerglass"
				name = "冰镇啤酒"
				desc = "冰爽至极的啤酒，连周围的空气都要冻结。"
				center_of_mass = "x=16;y=7"
			if("grog")
				icon_state = "grogglass"
				name = "格罗格"
				desc = "为太空准备的上好赛帕饮品。"
				center_of_mass = "x=16;y=10"
			if("soy_latte")
				icon_state = "soy_latte"
				name = "豆奶拿铁"
				desc = "阅读时来一杯清爽怡人的饮料。"
				center_of_mass = "x=15;y=9"
			if("cafe_latte")
				icon_state = "cafe_latte"
				name = "咖啡拿铁"
				desc = "阅读时来一杯强劲又清爽的绝佳饮品。"
				center_of_mass = "x=15;y=9"
			if("acidspit")
				icon_state = "acidspitglass"
				name = "酸液喷吐"
				desc = "来自维兰德-汤谷的饮品。用活体异形制成。"
				center_of_mass = "x=16;y=7"
			if("amasec")
				icon_state = "amasecglass"
				name = "阿玛塞克酒"
				desc = "战斗前必备良品！！！"
				center_of_mass = "x=16;y=9"
			if("neurotoxin")
				icon_state = "neurotoxinglass"
				name = "神经毒素"
				desc = "保证能把你喝得晕头转向的饮品。"
				center_of_mass = "x=16;y=8"
			if("hippiesdelight")
				icon_state = "hippiesdelightglass"
				name = "嬉皮士的喜悦"
				desc = "20世纪60年代人们喜爱的饮品。"
				center_of_mass = "x=16;y=8"
			if("bananahonk")
				icon_state = "bananahonkglass"
				name = "香蕉轰隆"
				desc = "来自香蕉天堂的饮品。"
				center_of_mass = "x=16;y=8"
			if("silencer")
				icon_state = "silencerglass"
				name = "消音器"
				desc = "来自默剧天堂的饮品。"
				center_of_mass = "x=16;y=9"
			if("nothing")
				icon_state = "nothing"
				name = "无"
				desc = "空空如也。"
				center_of_mass = "x=16;y=10"
			if("devilskiss")
				icon_state = "devilskiss"
				name = "魔鬼之吻"
				desc = "惊悚时刻！"
				center_of_mass = "x=16;y=8"
			if("changelingsting")
				icon_state = "changelingsting"
				name = "变形者蛰刺"
				desc = "一杯刺鼻的饮品。"
				center_of_mass = "x=16;y=10"
			if("irishcarbomb")
				icon_state = "irishcarbomb"
				name = "爱尔兰汽车炸弹"
				desc = "一杯爱尔兰汽车炸弹。"
				center_of_mass = "x=16;y=8"
			if("syndicatebomb")
				icon_state = "syndicatebomb"
				name = "辛迪加炸弹"
				desc = "一杯辛迪加炸弹。"
				center_of_mass = "x=16;y=4"
			if("erikasurprise")
				icon_state = "erikasurprise"
				name = "艾丽卡惊喜"
				desc = "惊喜在于，它是绿色的！"
				center_of_mass = "x=16;y=9"
			if("driestmartini")
				icon_state = "driestmartiniglass"
				name = "最干马提尼"
				desc = "仅限老手尝试。你仿佛能看到玻璃杯里漂浮的沙粒。"
				center_of_mass = "x=17;y=8"
			if("ice")
				icon_state = "iceglass"
				name = "一杯冰"
				desc = "一般来说，你总得往里面加点别的东西……"
				center_of_mass = "x=16;y=10"
			if("icecoffee")
				icon_state = "icedcoffeeglass"
				name = "冰咖啡"
				desc = "一杯让你精神焕发、恢复活力的饮品！"
				center_of_mass = "x=16;y=10"
			if("coffee")
				icon_state = "glass_brown"
				name = "一杯咖啡"
				desc = "别摔了它，否则滚烫的液体和玻璃碎片会溅得到处都是。"
				center_of_mass = "x=16;y=10"
			if("bilk")
				icon_state = "glass_brown"
				name = "一杯比尔克奶啤"
				desc = "一种牛奶和啤酒的混合饮品。专为那些害怕骨质疏松的酒鬼准备。"
				center_of_mass = "x=16;y=10"
			if("fuel")
				icon_state = "dr_gibb_glass"
				name = "一杯焊枪燃料"
				desc = "除非你是个工业工具，否则喝这个可能不安全。"
				center_of_mass = "x=16;y=10"
			if("brownstar")
				icon_state = "brownstar"
				name = "棕色之星"
				desc = "它听起来不是你想的那样……"
				center_of_mass = "x=16;y=10"
			if("grapejuice")
				icon_state = "grapejuice"
				name = "一杯葡萄汁"
				desc = "是葡~萄~汁！"
				center_of_mass = "x=16;y=10"
			if("grapesoda")
				icon_state = "grapesoda"
				name = "葡萄汽水罐"
				desc = "看起来是种美味的饮料！"
				center_of_mass = "x=16;y=10"
			if("icetea")
				icon_state = "icedteaglass"
				name = "冰茶"
				desc = "与某位说唱歌手/演员无关。"
				center_of_mass = "x=15;y=10"
			if("grenadine")
				icon_state = "grenadineglass"
				name = "一杯石榴糖浆"
				desc = "酸甜可口，一种用于为饮品增色或调味的酒吧糖浆。"
				center_of_mass = "x=17;y=6"
			if("milkshake")
				icon_state = "milkshake"
				name = "奶昔"
				desc = "令人大脑冻结的绝妙混合物。"
				center_of_mass = "x=16;y=7"
			if("chocolate_milkshake")
				icon_state = "chocolate_milkshake"
				name = "巧克力奶昔"
				desc = "经典巧克力口味的、令人大脑冻结的绝妙混合物。"
				center_of_mass = "x=16;y=7"
			if("lemonade")
				icon_state = "lemonadeglass"
				name = "柠檬水"
				desc = "哦，怀旧之情……"
				center_of_mass = "x=16;y=10"
			if("kiraspecial")
				icon_state = "kiraspecial"
				name = "基拉特调"
				desc = "那位被所有人误认为是女孩的家伙万岁。笨蛋！"
				center_of_mass = "x=16;y=12"
			if("rewriter")
				icon_state = "rewriter"
				name = "改写者"
				desc = "图书馆员圣殿的秘密……"
				center_of_mass = "x=16;y=9"
			if("suidream")
				icon_state = "sdreamglass"
				name = "穗之梦"
				desc = "一种花哨、果味、甜腻的混合饮料。理解这个名字只会带来羞耻。"
				center_of_mass = "x=16;y=5"
			if("melonliquor")
				icon_state = "emeraldglass"
				name = "一杯甜瓜利口酒"
				desc = "一种相对较甜、果味的46度利口酒。"
				center_of_mass = "x=16;y=5"
			if("bluecuracao")
				icon_state = "curacaoglass"
				name = "一杯蓝橙酒"
				desc = "充满异国情调的蓝色果味饮品，由橙子蒸馏而成。"
				center_of_mass = "x=16;y=5"
			if("absinthe")
				icon_state = "absintheglass"
				name = "一杯苦艾酒"
				desc = "苦艾，茴芹，我的天。"
				center_of_mass = "x=16;y=5"
			if("pwine")
				icon_state = "pwineglass"
				name = "一杯？？？"
				desc = "一种黑色的粘稠液体，表面泛着油性的紫色光泽。你确定要喝这个吗？"
				center_of_mass = "x=16;y=5"
			if("eggnog")
				icon_state = "glass_white"
				name = "蛋奶酒"
				desc = "一种浓郁、不含酒精的乳制品饮料，传统上在圣诞节期间饮用。"
				center_of_mass = "x=16;y=10"
			if("spikedeggnog")
				icon_state = "goldschlagerglass"
				name = "加料酒蛋奶酒"
				desc = "光是看着它，就让人回想起拥抱、家人和拆礼物的时光。"
				center_of_mass = "x=16;y=5"
			if("mojito")
				icon_state = "mojitoglass"
				name = "莫吉托"
				desc = "古巴经典饮品，绝不会让你失望。"
				center_of_mass = "x=16;y=5"
			else
				//a common drinking reagent that makes more than half of the total volume
				if(istype(R, /datum/reagent/drink) && R.volume >= 0.5*reagents.total_volume)
					icon_state ="glass_brown"
					if(R.volume >= 0.75*reagents.total_volume)
						name = "一杯[R.id]"
					else
						name = "一杯..[R.id]？"
						desc = "这看起来主要是[R.id]混合了别的东西。"
					center_of_mass = "x=16;y=10"
				else
					icon_state ="glass_brown"
					name = "一杯..什么？"
					desc = "你实在看不出这是什么。"
					center_of_mass = "x=16;y=10"
	else
		icon_state = "glass_empty"
		name = "glass"
		desc = "标准的饮水杯。"
		center_of_mass = "x=16;y=10"
		return

/obj/item/reagent_container/food/drinks/drinkingglass/attack(mob/living/target as mob, mob/living/user as mob)
	if(!target)
		return

	if(user.a_intent != INTENT_HARM)
		return ..()

	force = 15

	var/obj/limb/affecting = user.zone_selected
	var/drowsy_threshold = 0

	drowsy_threshold = CLOTHING_ARMOR_MEDIUM - target.getarmor(affecting, ARMOR_MELEE)

	target.apply_damage(force, BRUTE, affecting, sharp=0)

	if(affecting == "head" && iscarbon(target) && !isxeno(target))
		for(var/mob/O in viewers(user, null))
			if(target != user)
				O.show_message(text(SPAN_DANGER("<B>[target] has been hit over the head with a glass of [name], by [user]!</B>")), SHOW_MESSAGE_VISIBLE)
			else
				O.show_message(text(SPAN_DANGER("<B>[target] hit \himself with a glass of [name] on the head!</B>")), SHOW_MESSAGE_VISIBLE)
		if(drowsy_threshold > 0)
			target.apply_effect(min(drowsy_threshold, 10) , DROWSY)

	else //Regular attack text
		for(var/mob/O in viewers(user, null))
			if(target != user)
				O.show_message(text(SPAN_DANGER("<B>[target] has been attacked with a glass of [name], by [user]!</B>")), SHOW_MESSAGE_VISIBLE)
			else
				O.show_message(text(SPAN_DANGER("<B>[target] has attacked \himself with a glass of [name]!</B>")), SHOW_MESSAGE_VISIBLE)

	user.attack_log += text("\[[time_stamp()]\] <font color='red'>Has attacked [target.name] ([target.ckey]) with a glass!</font>")
	target.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been smashed with a glass by [user.name] ([user.ckey])</font>")
	msg_admin_attack("[user.name] ([user.ckey]) attacked [target.name] ([target.ckey]) with a glass (INTENT: [uppertext(intent_text(user.a_intent))]) in [get_area(user)] ([user.loc.x],[user.loc.y],[user.loc.z]).", user.loc.x, user.loc.y, user.loc.z)

	if(reagents)
		for(var/mob/O in viewers(user, null))
			O.show_message(text(SPAN_NOTICE("<B>The contents of \the [src] splashes all over [target]!</B>")), SHOW_MESSAGE_VISIBLE)
		reagents.reaction(target, TOUCH)

	smash(target, user)

	return

/obj/item/reagent_container/food/drinks/drinkingglass/bullet_act(obj/projectile/P)
	. = ..()
	smash()

/obj/item/reagent_container/food/drinks/drinkingglass/proc/smash(mob/living/target, mob/living/user)
	var/obj/item/weapon/broken_glass/B
	if(user)
		user.temp_drop_inv_item(src)
		B = new /obj/item/weapon/broken_glass(user.loc)
		user.put_in_active_hand(B)
	else
		B = new /obj/item/weapon/broken_glass(src.loc)
	if(prob(33))
		if(target)
			new/obj/item/shard(target.loc) // Create a glass shard at the target's location!
		else
			new/obj/item/shard(src.loc)

	playsound(src, "shatter", 25, 1)
	transfer_fingerprints_to(B)

	qdel(src)

// for /obj/structure/machinery/vending/sovietsoda
/obj/item/reagent_container/food/drinks/drinkingglass/soda
	name = "汽水杯"
	desc = "喝汽水用的玻璃杯。"

/obj/item/reagent_container/food/drinks/drinkingglass/soda/Initialize()
	. = ..()
	reagents.add_reagent("sodawater", 50)
	on_reagent_change()

/obj/item/reagent_container/food/drinks/drinkingglass/cola
	name = "可乐杯"
	desc = "喝可乐用的玻璃杯。"

/obj/item/reagent_container/food/drinks/drinkingglass/cola/Initialize()
	. = ..()
	reagents.add_reagent("cola", 50)
	on_reagent_change()
