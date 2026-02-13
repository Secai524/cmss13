//USCM

/obj/item/mre_food_packet/uscm
	icon = 'icons/obj/items/food/mre_food/uscm.dmi'

///ENTREE

/obj/item/mre_food_packet/entree/uscm
	name = "\improper MRE main dish"
	desc = "一份MRE主菜组件。包含提供营养的主餐。"
	icon = 'icons/obj/items/food/mre_food/uscm.dmi'
	icon_state = "entree"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/porkribs,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/grilledchicken,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/pizzasquare,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/chickentender,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/pepperonisquare,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/spaghettichunks,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/chiliconcarne,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/noodlesoup,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/grilledchickenbreast,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/feijoada,
	)

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/porkribs
	name = "无骨猪肋排"
	icon_state = "无骨猪肋排"
	desc = "在这么多香料下，你甚至尝不出加工肉蛋白的味道！"

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/porkribs/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 14)
	reagents.add_reagent("sodiumchloride", 2)
	reagents.add_reagent("blackpepper", 4)

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/grilledchicken
	name = "烤鸡"
	icon_state = "烤鸡"
	desc = "尝起来其实不像烤鸡，但你真的指望在这里能吃到那种美味吗？"

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/grilledchicken/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 14)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/pizzasquare
	name = "披萨方块"
	icon_state = "披萨方块"
	desc = "一道美国经典菜品，已在菜单上增减了大约27次。尽管是正品的廉价仿制品，但仍深受喜爱。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/pizzasquare/Initialize()
	. = ..()
	reagents.add_reagent("cheese", 4)
	reagents.add_reagent("meatprotein", 3)
	reagents.add_reagent("bread", 5)
	reagents.add_reagent("vegetable", 2)
	reagents.add_reagent("tomatojuice", 4)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/pepperonisquare
	name = "意式香肠披萨方块"
	icon_state = "pepperoni square"
	desc = "标准MRE的新增菜品。和普通的披萨方块一样，它的口感像一块涂了油的纸板。不过，这个上面有一些调味过度的仿制意式香肠片。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/pepperonisquare/Initialize()
	. = ..()
	reagents.add_reagent("cheese", 3)
	reagents.add_reagent("meatprotein", 5)
	reagents.add_reagent("bread", 6)
	reagents.add_reagent("tomatojuice", 4)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/chickentender
	name = "鸡柳条"
	icon_state = "鸡柳条"
	desc = "出人意料地美味，但主要是让你更想吃真货。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/chickentender/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 10)
	reagents.add_reagent("bread", 4)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/grilledchickenbreast
	name = "烤鸡胸肉"
	icon_state = "烤鸡胸肉"
	desc = "尝起来其实不像烤鸡，但如果你不介意清淡的食物和耐嚼的口感，那也不算太糟。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/grilledchickenbreast/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 14)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/spaghettichunks
	name = "肉酱意面"
	icon_state = "spaghetti chunks"
	desc = "软塌、有嚼劲的面条配上一些熟肉块，全部覆盖在番茄酱里。它冷得令人不适，还有点黏糊糊的。如果你加热一下可能会更开胃，但你没那个时间。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/spaghettichunks/Initialize()
	. = ..()
	reagents.add_reagent("noodles", 8)
	reagents.add_reagent("meatprotein", 6)
	reagents.add_reagent("tomatojuice", 4)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/chiliconcarne
	name = "墨西哥辣肉酱"
	icon_state = "墨西哥辣肉酱"
	desc = "一道极其辛辣的碎肉菜肴。里面的辣椒粉可能比肉还多。建议手边备点牛奶。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/chiliconcarne/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 10)
	reagents.add_reagent("hotsauce", 6)
	reagents.add_reagent("vegetable", 4)
	reagents.add_reagent("tomatojuice", 2)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/noodlesoup
	name = "汤面"
	icon_state = "汤面"
	desc = "一份稀薄的汤面，配有蔬菜、鸡肉风味和一些营养粉来完善这顿饭。如果加热，可以让你长时间保持温暖。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/noodlesoup/Initialize()
	. = ..()
	reagents.add_reagent("noodles", 9)
	reagents.add_reagent("vegetable", 4)
	reagents.add_reagent("water", 5)
	reagents.add_reagent("meatprotein", 1)

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/feijoada
	name = "feijoada"
	icon_state = "brazilian-style feijoada"
	desc = "一道巴西菜肴，内含黑豆、不同种类的肉、蔬菜和香料。风味浓郁，非常饱腹。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/entree/feijoada/Initialize()
	. = ..()
	reagents.add_reagent("vegetable", 7)
	reagents.add_reagent("meatprotein", 5)
	reagents.add_reagent("tomatojuice", 4)
	reagents.add_reagent("plantmatter", 2)

///SIDE

/obj/item/mre_food_packet/uscm/side
	name = "\improper MRE side dish"
	desc = "一份MRE配菜组件。包含一道配菜，与主餐一同食用。"
	icon_state = "side"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/uscm/side/cracker,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/side/mashedpotatoes,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/side/risotto,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/side/onigiri,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/side/cornbread,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/side/kale,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/side/tortillas,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/side/cinnamonappleslices,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/side/boiledrice,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/side/biscuits,
	)

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/cracker
	name = "cracker"
	icon_state = "cracker"
	desc = "极易碎裂。你永远无法把碎屑从制服上完全弄干净。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/cracker/Initialize()
	. = ..()
	reagents.add_reagent("bread", 6)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/mashedpotatoes
	name = "土豆泥"
	icon_state = "土豆泥"
	desc = "非常适合下巴受伤的人和喜欢室温果泥的爱好者。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/mashedpotatoes/Initialize()
	. = ..()
	reagents.add_reagent("potato", 6)
	reagents.add_reagent("vegetable", 3)
	reagents.add_reagent("milk", 2)
	reagents.add_reagent("sodiumchloride", 1)

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/risotto
	name = "risotto"
	icon_state = "risotto"
	desc = "稍微有点异国风味，但意大利菜从不让人失望。然而，保质期3-5年的廉价仿制意大利菜却常常如此。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/risotto/Initialize()
	. = ..()
	reagents.add_reagent("sodiumchloride", 1)
	reagents.add_reagent("rice", 4)
	reagents.add_reagent("cornoil", 1)
	reagents.add_reagent("vegetable", 2)

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/onigiri
	name = "饭团"
	icon_state = "饭团"
	desc = "三角形的米饭，底部包着一层海苔。好吧……你觉得那可能是海苔。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/onigiri/Initialize()
	. = ..()
	reagents.add_reagent("rice", 5)
	reagents.add_reagent("plantmatter", 1)
	reagents.add_reagent("sodiumchloride", 1)

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/cornbread
	name = "cornbread"
	icon_state = "cornbread"
	desc = "因其极其干硬且尝起来像生面粉而广受厌恶。补给处后面可能堆了一大堆这玩意儿。没人吃这鬼东西。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/cornbread/Initialize()
	. = ..()
	reagents.add_reagent("bread", 4)
	reagents.add_reagent("cornoil", 2)
	reagents.add_reagent("sodiumchloride", 1)

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/kale
	name = "腌羽衣甘蓝"
	icon_state = "kale"
	desc = "裹满香料的干制植物。即使是军用级别的，羽衣甘蓝也很难推销出去。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/kale/Initialize()
	. = ..()
	reagents.add_reagent("plantmatter", 6)
	reagents.add_reagent("blackpepper", 2)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/tortillas
	name = "tortillas"
	icon_state = "tortillas"
	desc = "加入单兵口粮中，本意是用来包裹主菜。但当你拿到一块方形意面时，这个想法就彻底泡汤了。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/tortillas/Initialize()
	. = ..()
	reagents.add_reagent("bread", 6)

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/biscuits
	name = "biscuits"
	icon_state = "biscuits"
	desc = "什锦饼干。总是又硬又有点不新鲜，但和其他东西搭配还不错。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/biscuits/Initialize()
	. = ..()
	reagents.add_reagent("bread", 6)


/obj/item/reagent_container/food/snacks/mre_food/uscm/side/cinnamonappleslices
	name = "肉桂苹果片"
	icon_state = "肉桂苹果片"
	desc = "裹着肉桂酱的黏糊苹果块。以甜味甚至有点美味著称，但也黏得要命。吃完记得洗手，否则你的枪会黏糊一整年。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/cinnamonappleslices/Initialize()
	. = ..()
	reagents.add_reagent("fruit", 3)
	reagents.add_reagent("sugar", 3)

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/boiledrice
	name = "白米饭"
	icon_state = "rice"
	desc = "一包平淡无味的白米饭。单调乏味，但配上其他东西会好一些。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/side/boiledrice/Initialize()
	. = ..()
	reagents.add_reagent("rice", 6)

///SNACK

/obj/item/mre_food_packet/uscm/snack
	name = "\improper MRE snack"
	desc = "单兵口粮的零食部分。内含一份轻食，以防你不太饿。"
	icon_state = "snack"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/biscuit,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/meatballs,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/pretzels,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/sushi,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/peanuts,
	)

/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/biscuit
	name = "biscuit"
	icon_state = "biscuit"
	desc = "让你想起饼干，但这是全麦的。据称是USCM健康计划的一部分，具有独特的口感和风味。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/biscuit/Initialize()
	. = ..()
	reagents.add_reagent("bread", 4)
	reagents.add_reagent("sodiumchloride", 1)

/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/meatballs
	name = "meatballs"
	icon_state = "meatballs"
	desc = "尽管是煮熟的肉末球，你依然能尝到软骨的碎渣。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/meatballs/Initialize()
	. = ..()
	reagents.add_reagent("meatprotein", 4)
	reagents.add_reagent("sodiumchloride", 2)
	reagents.add_reagent("blackpepper", 1)

/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/pretzels
	name = "pretzels"
	icon_state = "pretzels"
	desc = "咸脆的椒盐卷饼，会让你很快感到口干舌燥。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/pretzels/Initialize()
	. = ..()
	reagents.add_reagent("bread", 4)
	reagents.add_reagent("sodiumchloride", 4)

/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/sushi
	name = "sushi"
	icon_state = "sushi"
	desc = "你高度怀疑生鱼在这里不会变质。它几乎闻不到鱼腥味……这真的是鱼吗？"

/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/sushi/Initialize()
	. = ..()
	reagents.add_reagent("fish", 2)
	reagents.add_reagent("plantmatter", 2)
	reagents.add_reagent("soysauce", 2)
	reagents.add_reagent("soymilk", 2)

/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/peanuts
	name = "peanuts"
	icon_state = "peanuts"
	desc = "一些咸脆花生。出人意料地，是个不错的零食。你甚至可能会想再来点。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/snack/peanuts/Initialize()
	. = ..()
	reagents.add_reagent("nuts", 4)
	reagents.add_reagent("sodiumchloride", 1)

///DESSERT

/obj/item/mre_food_packet/uscm/dessert
	name = "\improper MRE dessert"
	desc = "单兵口粮的配餐部分。内含一份甜点，应在主餐后食用（或者，如果你够叛逆，也可以在主餐前吃）。"
	icon_state = "dessert"
	food_list = list(
		/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/spicedapples,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/chocolatebrownie,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/sugarcookie,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/cocobar,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/flan,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/honeyflan,
		/obj/item/reagent_container/food/snacks/cookie,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/lemonpie,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/limepie,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/brigadeiro,
		/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/strawberrytoaster,
	)

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/spicedapples
	name = "五香苹果"
	icon_state = "五香苹果"
	desc = "用肉桂调味的干苹果片。会让你口干舌燥，但这就是为什么单兵口粮里配了水。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/spicedapples/Initialize()
	. = ..()
	reagents.add_reagent("fruit", 2)
	reagents.add_reagent("sugar", 2)

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/chocolatebrownie
	name = "巧克力布朗尼"
	icon_state = "巧克力布朗尼"
	desc = "一块巧克力味的方形蛋糕。自制的布朗尼口感扎实有嚼劲，是好的那种。这块布朗尼不是自制的。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/chocolatebrownie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("coco", 2)
	reagents.add_reagent("sprinkles", 1)

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/sugarcookie
	name = "糖霜曲奇"
	icon_state = "糖霜曲奇"
	desc = "一块甜曲奇。有点硬，但仍然比大多数主菜要好。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/sugarcookie/Initialize()
	. = ..()
	reagents.add_reagent("sugar", 2)
	reagents.add_reagent("bread", 2)

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/cocobar
	name = "可可棒"
	icon_state = "可可棒"
	desc = "经典牛奶巧克力棒，搭配热饮很不错。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/cocobar/Initialize()
	. = ..()
	reagents.add_reagent("coco", 5)
	reagents.add_reagent("milk", 2)
	reagents.add_reagent("sugar", 2)

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/flan
	name = "flan"
	icon_state = "flan"
	desc = "一种柔软、奶白色的饼干派。触感有些酥脆易碎。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/flan/Initialize()
	. = ..()
	reagents.add_reagent("milk", 1)
	reagents.add_reagent("cream", 2)
	reagents.add_reagent("sugar", 2)
	reagents.add_reagent("egg", 3)

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/honeyflan
	name = "蜂蜜布丁派"
	icon_state = "蜂蜜布丁派"
	desc = "一种柔软、奶白色的饼干派，覆盖着蜂蜜浇头。浇头本身更像是浓稠的凝胶，而非糖浆状酱汁。也许制造商从肉桂苹果片的经验中学到了什么。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/honeyflan/Initialize()
	. = ..()
	reagents.add_reagent("honey", 3)
	reagents.add_reagent("milk", 2)
	reagents.add_reagent("sugar", 2)
	reagents.add_reagent("egg", 3)

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/lemonpie
	name = "柠檬派"
	icon_state = "柠檬派"
	desc = "一种馅料浓稠、柠檬味极其浓郁的派，配以干燥、块状的酥皮。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/lemonpie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("lemonjuice", 5)
	reagents.add_reagent("cream", 2)
	reagents.add_reagent("sugar", 1)
	reagents.add_reagent("egg", 1)

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/limepie
	name = "青柠派"
	icon_state = "青柠派"
	desc = "一种馅料酸味极其浓郁、带有青柠风味的派，配以干燥、块状的酥皮。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/limepie/Initialize()
	. = ..()
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("limejuice", 5)
	reagents.add_reagent("cream", 2)
	reagents.add_reagent("sugar", 1)
	reagents.add_reagent("egg", 1)

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/brigadeiro
	name = "布里加代罗球"
	icon_state = "布里加代罗球"
	desc = "一种传统的巴西甜点，据称由炼乳、可可和黄油制成。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/brigadeiro/Initialize()
	. = ..()
	reagents.add_reagent("cream", 2)
	reagents.add_reagent("sugar", 3)
	reagents.add_reagent("coco", 4)
	reagents.add_reagent("egg", 1)

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/strawberrytoaster
	name = "草莓烤面包糕点"
	icon_state = "草莓烤面包糕点"
	desc = "一种酥脆的饼干，内含人工草莓酱。顶部的干糖霜使其看起来像一款流行的早餐产品。尽管看起来像，但这实际上是一种烤面包糕点：制造商想避免版权侵权。"

/obj/item/reagent_container/food/snacks/mre_food/uscm/dessert/strawberrytoaster/Initialize()
	. = ..()
	reagents.add_reagent("bread", 2)
	reagents.add_reagent("berryjuice", 3)
	reagents.add_reagent("cream", 2)
	reagents.add_reagent("sprinkles", 2)
	reagents.add_reagent("egg", 1)

///SPREAD

/obj/item/reagent_container/food/drinks/cans/spread
	name = "涂抹酱包（奶酪）"
	icon = 'icons/obj/items/food/mre_food/uscm.dmi'
	icon_state = "spread"
	desc = "一种奶油状、奶酪味的涂抹酱，由加工奶酪制成。与玉米饼和其他零食搭配良好。"
	open_sound = "rip"
	open_message = "You pull open the package of the spread!"
	volume = 6
	var/flavor = "cheese spread"
	food_interactable = TRUE
	possible_transfer_amounts = list(1, 2, 3, 5)
	crushable = FALSE
	gulp_size = 5
	object_fluff = "packet"

/obj/item/reagent_container/food/drinks/cans/spread/update_icon()
	overlays.Cut()
	if(open)
		icon_state = "spread_open"
		if(reagents.total_volume)
			overlays += mutable_appearance(icon, flavor)

/obj/item/reagent_container/food/drinks/cans/spread/on_reagent_change()
	. = ..()
	update_icon()

/obj/item/reagent_container/food/drinks/cans/spread/cheese/Initialize()
	. = ..()
	reagents.add_reagent("cheese", 4)
	reagents.add_reagent("sodiumchloride", 2)

/obj/item/reagent_container/food/drinks/cans/spread/jalapeno
	name = "涂抹酱包（墨西哥辣椒奶酪）"
	desc = "一种奶油状、奶酪味的涂抹酱，由加工奶酪制成。与玉米饼和其他零食搭配良好；这款带有辛辣的墨西哥辣椒风味。"
	flavor = "jalapeno cheese spread"

/obj/item/reagent_container/food/drinks/cans/spread/jalapeno/Initialize()
	. = ..()
	reagents.add_reagent("cheese", 4)
	reagents.add_reagent("capsaicin", 2)

/obj/item/reagent_container/food/drinks/cans/spread/peanut_butter
	name = "涂抹酱包（花生酱）"
	desc = "一种奶油状、坚果味的涂抹酱，由加工花生制成。与玉米饼和其他零食搭配良好。"
	flavor = "peanut butter"

/obj/item/reagent_container/food/drinks/cans/spread/peanut_butter/Initialize()
	. = ..()
	reagents.add_reagent("nuts", 4)
	reagents.add_reagent("sodiumchloride", 2)

///BEVERAGE DRINKS

/obj/item/reagent_container/food/drinks/beverage_drink
	name = "饮料粉包"
	desc = "粉末状调味剂，可混入水中制成即饮型战地饮料。"
	icon = 'icons/obj/items/food/mre_food/uscm.dmi'
	icon_state = "beverage"
	volume = 20

/obj/item/reagent_container/food/drinks/beverage_drink/grape
	name = "电解质饮料粉包（葡萄味）"
	desc = "一包电解质饮料粉，与水混合后可制成即饮型战地饮料。带有葡萄风味。"

/obj/item/reagent_container/food/drinks/beverage_drink/grape/Initialize()
	. = ..()
	reagents.add_reagent("dehydrated_grape_beverage", 4)

/obj/item/reagent_container/food/drinks/beverage_drink/orange
	name = "电解质饮料粉包（橙子味）"
	desc = "粉末状橙子调味剂，可混入水中制成即饮型战地饮料。含有据说有助于补水的电解质。"

/obj/item/reagent_container/food/drinks/beverage_drink/orange/Initialize()
	. = ..()
	reagents.add_reagent("electrolyte_orange_beverage", 4)

/obj/item/reagent_container/food/drinks/beverage_drink/lemonlime
	name = "电解质饮料粉包（柠檬青柠味）"
	desc = "粉末状柠檬青柠调味剂，可混入水中制成即饮型战地饮料。含有据说有助于补水的电解质。"

/obj/item/reagent_container/food/drinks/beverage_drink/lemonlime/Initialize()
	. = ..()
	reagents.add_reagent("electrolyte_lemonlime_beverage", 4)

/obj/item/reagent_container/food/drinks/beverage_drink/chocolate
	name = "蛋白饮料冲剂包（牛奶巧克力味）"
	desc = "一包蛋白质混合粉末，可加入水中制成即饮型野战饮料。具有巧克力风味。"

/obj/item/reagent_container/food/drinks/beverage_drink/chocolate/Initialize()
	. = ..()
	reagents.add_reagent("chocolate_beverage", 4)

/obj/item/reagent_container/food/drinks/beverage_drink/chocolate_hazelnut
	name = "蛋白饮料冲剂包（巧克力榛子味）"
	desc = "一包蛋白质混合粉末，可加入水中制成即饮型野战饮料。具有巧克力榛子风味。"

/obj/item/reagent_container/food/drinks/beverage_drink/chocolate_hazelnut/Initialize()
	. = ..()
	reagents.add_reagent("hazelnut_beverage", 4)
