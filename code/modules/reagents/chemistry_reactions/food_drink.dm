
//*****************************************************************************************************/
//****************************************Food Mixtures************************************************/
//*****************************************************************************************************/

/datum/chemical_reaction/tofu
	name = "豆腐"
	id = "tofu"
	result = null
	required_reagents = list("soymilk" = 10)
	required_catalysts = list("enzyme" = 5)
	result_amount = 1

/datum/chemical_reaction/tofu/on_reaction(datum/reagents/holder, created_volume)
	. = ..()
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_container/food/snacks/tofu(location)

/datum/chemical_reaction/hot_coco
	name = "热可可"
	id = "hot_coco"
	result = "hot_coco"
	required_reagents = list("water" = 5, "coco" = 1)
	result_amount = 5

/datum/chemical_reaction/soysauce
	name = "酱油"
	id = "soysauce"
	result = "soysauce"
	required_reagents = list("soymilk" = 4, "sulphuric acid" = 1)
	result_amount = 5

/datum/chemical_reaction/condensedcapsaicin
	name = "浓缩辣椒素"
	id = "condensedcapsaicin"
	result = "condensedcapsaicin"
	required_reagents = list("capsaicin" = 2)
	required_catalysts = list("phoron" = 5)
	result_amount = 1

/datum/chemical_reaction/hotsauce
	name = "辣酱"
	id = "hotsauce"
	result = "hotsauce"
	required_reagents = list("capsaicin" = 2)
	required_catalysts = list("blackpepper" = 1)
	result_amount = 1

/datum/chemical_reaction/machosauce
	name = "猛男酱"
	id = "machosauce"
	result = "machosauce"
	required_reagents = list("condensedcapsaicin" = 1, "souto_classic" = 1)
	result_amount = 2

/datum/chemical_reaction/machosauce/cherry
	required_reagents = list("condensedcapsaicin" = 1, "souto_cherry" = 1)

/datum/chemical_reaction/machosauce/lime
	required_reagents = list("condensedcapsaicin" = 1, "lemon_lime" = 1)

/datum/chemical_reaction/machosauce/grape
	required_reagents = list("condensedcapsaicin" = 1, "grapejuice" = 1)

/datum/chemical_reaction/machosauce/blueraspberry
	required_reagents = list("condensedcapsaicin" = 1, "blueraspberry" = 1)

/datum/chemical_reaction/machosauce/peach
	required_reagents = list("condensedcapsaicin" = 1, "peach" = 1)

/datum/chemical_reaction/machosauce/cranberry
	required_reagents = list("condensedcapsaicin" = 1, "cranberry" = 1)

/datum/chemical_reaction/machosauce/vanilla
	required_reagents = list("condensedcapsaicin" = 1, "vanilla" = 1)

/datum/chemical_reaction/machosauce/pineapple
	required_reagents = list("condensedcapsaicin" = 1, "pineapple" = 1)

/datum/chemical_reaction/machosauce/infinite
	required_reagents = list("condensedcapsaicin" = 1, "machosauce" = 1)

/datum/chemical_reaction/machosauce/infinite/cherry
	required_reagents = list("machosauce" = 1, "souto_cherry" = 1)

/datum/chemical_reaction/machosauce/infinite/lime
	required_reagents = list("machosauce" = 1, "lemon_lime" = 1)

/datum/chemical_reaction/machosauce/infinite/grape
	required_reagents = list("machosauce" = 1, "grapejuice" = 1)

/datum/chemical_reaction/machosauce/infinite/blueraspberry
	required_reagents = list("machosauce" = 1, "blueraspberry" = 1)

/datum/chemical_reaction/machosauce/infinite/peach
	required_reagents = list("machosauce" = 1, "peach" = 1)

/datum/chemical_reaction/machosauce/infinite/cranberry
	required_reagents = list("machosauce" = 1, "cranberry" = 1)

/datum/chemical_reaction/machosauce/infinite/vanilla
	required_reagents = list("machosauce" = 1, "vanilla" = 1)

/datum/chemical_reaction/machosauce/infinite/pineapple
	required_reagents = list("machosauce" = 1, "pineapple" = 1)

/datum/chemical_reaction/machosauce/weaksauce
	required_reagents = list("machosauce" = 1, "water" = 1)

/datum/chemical_reaction/machosauce/weaksauce/infinite
	required_reagents = list("machosauce" = 1, "weaksauce" = 1)

/datum/chemical_reaction/machosauce/weaksauce/infinite/water
	required_reagents = list("water" = 1, "weaksauce" = 1)

/datum/chemical_reaction/sodiumchloride
	name = "氯化钠"
	id = "sodiumchloride"
	result = "sodiumchloride"
	required_reagents = list("sodium" = 1, "chlorine" = 1)
	result_amount = 2

/datum/chemical_reaction/cheesewheel/immature
	name = "未成熟奶酪轮"
	id = "immaturecheesewheel"
	result = null
	required_reagents = list("milk" = 40)
	required_catalysts = list("enzyme" = 5)
	result_amount = 1

/datum/chemical_reaction/cheesewheel/immature/on_reaction(datum/reagents/holder, created_volume)
	. = ..()
	var/location = get_turf(holder.my_atom)
	new /obj/item/reagent_container/food/snacks/sliceable/cheesewheel/immature(location)


/datum/chemical_reaction/synthmeat
	name = "synthmeat"
	id = "synthmeat"
	result = null
	required_reagents = list("blood" = 5, "clonexadone" = 1)
	result_amount = 1

/datum/chemical_reaction/synthmeat/on_reaction(datum/reagents/holder, created_volume)
	. = ..()
	var/location = get_turf(holder.my_atom)
	new /obj/item/reagent_container/food/snacks/meat/synthmeat(location)


/datum/chemical_reaction/hot_ramen
	name = "辣味拉面"
	id = "hot_ramen"
	result = "hot_ramen"
	required_reagents = list("dry_ramen" = 3, "water" = 1)
	result_amount = 3

/datum/chemical_reaction/hell_ramen
	name = "地狱拉面"
	id = "hell_ramen"
	result = "hell_ramen"
	required_reagents = list("hot_ramen" = 6, "hotsauce" = 1)
	result_amount = 6

/datum/chemical_reaction/electrolyte_grape_beverage
	name = "电解质葡萄饮料"
	id = "electrolyte_grape_beverage"
	result = "grapejuice"
	required_reagents = list("dehydrated_grape_beverage" = 1, "water" = 5)
	result_amount = 5

/datum/chemical_reaction/electrolyte_orange_beverage
	name = "电解质橙味饮料"
	id = "electrolyte_orange_beverage"
	result = "orangejuice"
	required_reagents = list("electrolyte_orange_beverage" = 1, "water" = 5)
	result_amount = 5

/datum/chemical_reaction/electrolyte_lemonline_beverage
	name = "电解质青柠柠檬饮料"
	id = "electrolyte_lemonlime_beverage"
	result = "lemon_lime"
	required_reagents = list("electrolyte_lemonlime_beverage" = 1, "water" = 5)
	result_amount = 5

/datum/chemical_reaction/hazelnut_beverage
	name = "榛子饮料"
	id = "hazelnut_beverage"
	result = "coco_drink_hazelnut"
	required_reagents = list("hazelnut_beverage" = 1, "water" = 5)
	result_amount = 5

/datum/chemical_reaction/chocolate_beverage
	name = "巧克力饮料"
	id = "chocolate_beverage"
	result = "coco_drink"
	required_reagents = list("chocolate_beverage" = 1, "water" = 5)
	result_amount = 5

//*****************************************************************************************************/
//******************************************Cocktails**************************************************/
//*****************************************************************************************************/


/datum/chemical_reaction/goldschlager
	name = "金万利"
	id = "goldschlager"
	result = "goldschlager"
	required_reagents = list("vodka" = 10, "gold" = 1)
	result_amount = 10

/datum/chemical_reaction/patron
	name = "培恩"
	id = "patron"
	result = "patron"
	required_reagents = list("tequila" = 10, "silver" = 1)
	result_amount = 10

/datum/chemical_reaction/bilk
	name = "比尔克"
	id = "bilk"
	result = "bilk"
	required_reagents = list("milk" = 1, "beer" = 1)
	result_amount = 2

/datum/chemical_reaction/icetea
	name = "冰茶"
	id = "icetea"
	result = "icetea"
	required_reagents = list("tea" = 3, "ice" = 1)
	result_amount = 4

/datum/chemical_reaction/tea
	name = "茶"
	id = "tea"
	result = "tea"
	required_reagents = list("tea_leaves" = 1, "water" = 1)
	result_amount = 2

/datum/chemical_reaction/icecoffee
	name = "冰咖啡"
	id = "icecoffee"
	result = "icecoffee"
	required_reagents = list("coffee" = 3, "ice" = 1)
	result_amount = 4

/datum/chemical_reaction/nuka_cola
	name = "核子可乐"
	id = "nuka_cola"
	result = "nuka_cola"
	required_reagents = list("cola" = 6, "uranium" = 1)
	result_amount = 6


/datum/chemical_reaction/moonshine
	name = "月光酒"
	id = "moonshine"
	result = "moonshine"
	required_reagents = list("nutriment" = 10)
	required_catalysts = list("enzyme" = 5)
	result_amount = 10

/datum/chemical_reaction/moonshine/plantmatter
	required_reagents = list("plantmatter" = 10)

/datum/chemical_reaction/moonshine/vegetable
	required_reagents = list("vegetable" = 10)

/datum/chemical_reaction/moonshine/fruit
	required_reagents = list("fruit" = 10)

/datum/chemical_reaction/moonshine/mushroom
	required_reagents = list("mushroom" = 10)

/datum/chemical_reaction/moonshine/bread
	required_reagents = list("bread" = 10)


/datum/chemical_reaction/grenadine
	name = "石榴糖浆"
	id = "grenadine"
	result = "grenadine"
	required_reagents = list("berryjuice" = 10)
	required_catalysts = list("enzyme" = 5)
	result_amount = 10

/datum/chemical_reaction/wine
	name = "葡萄酒"
	id = "wine"
	result = "wine"
	required_reagents = list("grapejuice" = 10)
	required_catalysts = list("enzyme" = 5)
	result_amount = 10

/datum/chemical_reaction/pwine
	name = "毒酒"
	id = "pwine"
	result = "pwine"
	required_reagents = list("poisonberryjuice" = 10)
	required_catalysts = list("enzyme" = 5)
	result_amount = 10

/datum/chemical_reaction/melonliquor
	name = "甜瓜利口酒"
	id = "melonliquor"
	result = "melonliquor"
	required_reagents = list("watermelonjuice" = 10)
	required_catalysts = list("enzyme" = 5)
	result_amount = 10

/datum/chemical_reaction/bluecuracao
	name = "蓝橙酒"
	id = "bluecuracao"
	result = "bluecuracao"
	required_reagents = list("orangejuice" = 10)
	required_catalysts = list("enzyme" = 5)
	result_amount = 10

/datum/chemical_reaction/spacebeer
	name = "太空啤酒"
	id = "spacebeer"
	result = "beer"
	required_reagents = list("cornoil" = 10)
	required_catalysts = list("enzyme" = 5)
	result_amount = 10

/datum/chemical_reaction/vodka
	name = "伏特加"
	id = "vodka"
	result = "vodka"
	required_reagents = list("potato" = 10)
	required_catalysts = list("enzyme" = 5)
	result_amount = 10

/datum/chemical_reaction/sake
	name = "清酒"
	id = "sake"
	result = "sake"
	required_reagents = list("rice" = 10)
	required_catalysts = list("enzyme" = 5)
	result_amount = 10

/datum/chemical_reaction/kahlua
	name = "甘露咖啡酒"
	id = "kahlua"
	result = "kahlua"
	required_reagents = list("coffee" = 5, "sugar" = 5)
	required_catalysts = list("enzyme" = 5)
	result_amount = 5

/datum/chemical_reaction/gin_tonic
	name = "金汤力"
	id = "gintonic"
	result = "gintonic"
	required_reagents = list("gin" = 2, "tonic" = 1)
	result_amount = 3

/datum/chemical_reaction/cuba_libre
	name = "自由古巴"
	id = "cubalibre"
	result = "cubalibre"
	required_reagents = list("rum" = 2, "cola" = 1)
	result_amount = 3

/datum/chemical_reaction/martini
	name = "经典马天尼"
	id = "martini"
	result = "martini"
	required_reagents = list("gin" = 2, "vermouth" = 1)
	result_amount = 3

/datum/chemical_reaction/vodkamartini
	name = "伏特加马天尼"
	id = "vodkamartini"
	result = "vodkamartini"
	required_reagents = list("vodka" = 2, "vermouth" = 1)
	result_amount = 3

/datum/chemical_reaction/white_russian
	name = "白色俄罗斯"
	id = "whiterussian"
	result = "whiterussian"
	required_reagents = list("blackrussian" = 3, "cream" = 2)
	result_amount = 5

/datum/chemical_reaction/whiskey_cola
	name = "威士忌可乐"
	id = "whiskeycola"
	result = "whiskeycola"
	required_reagents = list("whiskey" = 2, "cola" = 1)
	result_amount = 3

/datum/chemical_reaction/screwdriver
	name = "螺丝起子"
	id = "screwdrivercocktail"
	result = "screwdrivercocktail"
	required_reagents = list("vodka" = 2, "orangejuice" = 1)
	result_amount = 3

/datum/chemical_reaction/bloody_mary
	name = "血腥玛丽"
	id = "bloodymary"
	result = "bloodymary"
	required_reagents = list("vodka" = 1, "tomatojuice" = 2, "limejuice" = 1)
	result_amount = 4

/datum/chemical_reaction/gargle_blaster
	name = "泛银河系含漱爆破液"
	id = "gargleblaster"
	result = "gargleblaster"
	required_reagents = list("vodka" = 1, "gin" = 1, "whiskey" = 1, "cognac" = 1, "limejuice" = 1)
	result_amount = 5

/datum/chemical_reaction/brave_bull
	name = "勇敢公牛"
	id = "bravebull"
	result = "bravebull"
	required_reagents = list("tequila" = 2, "kahlua" = 1)
	result_amount = 3

/datum/chemical_reaction/tequila_sunrise
	name = "龙舌兰日出"
	id = "tequilasunrise"
	result = "tequilasunrise"
	required_reagents = list("tequila" = 2, "orangejuice" = 1)
	result_amount = 3

/datum/chemical_reaction/phoron_special
	name = "毒素特调"
	id = "phoronspecial"
	result = "phoronspecial"
	required_reagents = list("rum" = 2, "vermouth" = 1, "phoron" = 2)
	result_amount = 5

/datum/chemical_reaction/doctor_delight
	name = "医生的喜悦"
	id = "doctordelight"
	result = "doctorsdelight"
	required_reagents = list("limejuice" = 1, "tomatojuice" = 1, "orangejuice" = 1, "cream" = 1, "tricordrazine" = 1)
	result_amount = 5

/datum/chemical_reaction/irish_cream
	name = "爱尔兰奶油"
	id = "irishcream"
	result = "irishcream"
	required_reagents = list("whiskey" = 2, "cream" = 1)
	result_amount = 3

/datum/chemical_reaction/manly_dorf
	name = "硬汉多夫"
	id = "manlydorf"
	result = "manlydorf"
	required_reagents = list ("ale" = 2, "beer" = 1)
	result_amount = 3

/datum/chemical_reaction/hooch
	name = "私酿烈酒"
	id = "hooch"
	result = "hooch"
	required_reagents = list ("sugar" = 1, "ethanol" = 2, "fuel" = 1)
	result_amount = 3

/datum/chemical_reaction/irish_coffee
	name = "爱尔兰咖啡"
	id = "irishcoffee"
	result = "irishcoffee"
	required_reagents = list("irishcream" = 1, "coffee" = 1)
	result_amount = 2

/datum/chemical_reaction/b52
	name = "B-52"
	id = "b52"
	result = "b52"
	required_reagents = list("irishcream" = 1, "kahlua" = 1, "cognac" = 1)
	result_amount = 3

/datum/chemical_reaction/atomicbomb
	name = "原子弹"
	id = "atomicbomb"
	result = "atomicbomb"
	required_reagents = list("b52" = 10, "uranium" = 1)
	result_amount = 10

/datum/chemical_reaction/margarita
	name = "玛格丽塔"
	id = "margarita"
	result = "margarita"
	required_reagents = list("tequila" = 2, "limejuice" = 1)
	result_amount = 3

/datum/chemical_reaction/longislandicedtea
	name = "长岛冰茶"
	id = "longislandicedtea"
	result = "longislandicedtea"
	required_reagents = list("vodka" = 1, "gin" = 1, "tequila" = 1, "cubalibre" = 1)
	result_amount = 4

/datum/chemical_reaction/icedtea
	name = "长岛冰茶"
	id = "longislandicedtea"
	result = "longislandicedtea"
	required_reagents = list("vodka" = 1, "gin" = 1, "tequila" = 1, "cubalibre" = 1)
	result_amount = 4

/datum/chemical_reaction/threemileisland
	name = "三哩岛冰茶"
	id = "threemileisland"
	result = "threemileisland"
	required_reagents = list("longislandicedtea" = 10, "uranium" = 1)
	result_amount = 10

/datum/chemical_reaction/whiskeysoda
	name = "威士忌苏打"
	id = "whiskeysoda"
	result = "whiskeysoda"
	required_reagents = list("whiskey" = 2, "sodawater" = 1)
	result_amount = 3

/datum/chemical_reaction/black_russian
	name = "黑俄罗斯"
	id = "blackrussian"
	result = "blackrussian"
	required_reagents = list("vodka" = 3, "kahlua" = 2)
	result_amount = 5

/datum/chemical_reaction/manhattan
	name = "曼哈顿"
	id = "manhattan"
	result = "manhattan"
	required_reagents = list("whiskey" = 2, "vermouth" = 1)
	result_amount = 3

/datum/chemical_reaction/manhattan_proj
	name = "曼哈顿计划"
	id = "manhattan_proj"
	result = "manhattan_proj"
	required_reagents = list("manhattan" = 10, "uranium" = 1)
	result_amount = 10

/datum/chemical_reaction/vodka_tonic
	name = "伏特加汤力"
	id = "vodkatonic"
	result = "vodkatonic"
	required_reagents = list("vodka" = 2, "tonic" = 1)
	result_amount = 3

/datum/chemical_reaction/gin_fizz
	name = "金菲士"
	id = "ginfizz"
	result = "ginfizz"
	required_reagents = list("gin" = 2, "sodawater" = 1, "limejuice" = 1)
	result_amount = 4

/datum/chemical_reaction/bahama_mama
	name = "巴哈马妈妈"
	id = "bahama_mama"
	result = "bahama_mama"
	required_reagents = list("rum" = 2, "orangejuice" = 2, "limejuice" = 1, "ice" = 1)
	result_amount = 6

/datum/chemical_reaction/singulo
	name = "奇点"
	id = "singulo"
	result = "singulo"
	required_reagents = list("vodka" = 5, "wine" = 5, "radium" = 1)
	result_amount = 10

/datum/chemical_reaction/alliescocktail
	name = "盟友鸡尾酒"
	id = "alliescocktail"
	result = "alliescocktail"
	required_reagents = list("martini" = 1, "vodka" = 1)
	result_amount = 2

/datum/chemical_reaction/demonsblood
	name = "恶魔之血"
	id = "demonsblood"
	result = "demonsblood"
	required_reagents = list("rum" = 1, "spacemountainwind" = 1, "blood" = 1, "dr_gibb" = 1)
	result_amount = 4

/datum/chemical_reaction/booger
	name = "鼻屎"
	id = "booger"
	result = "booger"
	required_reagents = list("cream" = 1, "banana" = 1, "rum" = 1, "watermelonjuice" = 1)
	result_amount = 4

/datum/chemical_reaction/antifreeze
	name = "防冻液"
	id = "antifreeze"
	result = "antifreeze"
	required_reagents = list("vodka" = 2, "cream" = 1, "ice" = 1)
	result_amount = 4

/datum/chemical_reaction/barefoot
	name = "赤脚"
	id = "barefoot"
	result = "barefoot"
	required_reagents = list("berryjuice" = 1, "cream" = 1, "vermouth" = 1)
	result_amount = 3

/datum/chemical_reaction/grapesoda
	name = "葡萄汽水"
	id = "grapesoda"
	result = "grapesoda"
	required_reagents = list("grapejuice" = 2, "cola" = 1)
	result_amount = 3

/datum/chemical_reaction/mojito
	name = "莫吉托"
	id = "mojito"
	result = "mojito"
	required_reagents = list("rum" = 1, "sugar" = 1, "limejuice" = 1, "sodawater" = 1)
	result_amount = 4



////DRINKS THAT REQUIRED IMPROVED SPRITES BELOW:: -Agouri/////

/datum/chemical_reaction/sbiten
	name = "斯比特恩"
	id = "sbiten"
	result = "sbiten"
	required_reagents = list("vodka" = 10, "hotsauce" = 1)
	result_amount = 10

/datum/chemical_reaction/red_mead
	name = "红蜂蜜酒"
	id = "red_mead"
	result = "red_mead"
	required_reagents = list("blood" = 1, "mead" = 1)
	result_amount = 2

/datum/chemical_reaction/mead
	name = "蜂蜜酒"
	id = "mead"
	result = "mead"
	required_reagents = list("sugar" = 1, "water" = 1)
	required_catalysts = list("enzyme" = 5)
	result_amount = 2

/datum/chemical_reaction/iced_beer
	name = "冰镇啤酒"
	id = "iced_beer"
	result = "iced_beer"
	required_reagents = list("beer" = 10, "frostoil" = 1)
	result_amount = 10

/datum/chemical_reaction/iced_beer2
	name = "冰镇啤酒"
	id = "iced_beer"
	result = "iced_beer"
	required_reagents = list("beer" = 5, "ice" = 1)
	result_amount = 6

/datum/chemical_reaction/grog
	name = "格罗格"
	id = "grog"
	result = "grog"
	required_reagents = list("rum" = 1, "water" = 1)
	result_amount = 2

/datum/chemical_reaction/soy_latte
	name = "豆奶拿铁"
	id = "soy_latte"
	result = "soy_latte"
	required_reagents = list("coffee" = 1, "soymilk" = 1)
	result_amount = 2

/datum/chemical_reaction/cafe_latte
	name = "咖啡拿铁"
	id = "cafe_latte"
	result = "cafe_latte"
	required_reagents = list("coffee" = 1, "milk" = 1)
	result_amount = 2

/datum/chemical_reaction/acidspit
	name = "酸液喷吐"
	id = "acidspit"
	result = "acidspit"
	required_reagents = list("wine" = 5, "sulphuric acid" = 1)
	result_amount = 6

/datum/chemical_reaction/amasec
	name = "阿玛塞克酒"
	id = "amasec"
	result = "amasec"
	required_reagents = list("iron" = 1, "wine" = 5, "vodka" = 5)
	result_amount = 10

/datum/chemical_reaction/changelingsting
	name = "变形者蛰刺"
	id = "changelingsting"
	result = "changelingsting"
	required_reagents = list("screwdrivercocktail" = 1, "limejuice" = 1, "lemonjuice" = 1)
	result_amount = 5

/datum/chemical_reaction/aloe
	name = "芦荟汁"
	id = "aloe"
	result = "aloe"
	required_reagents = list("cream" = 1, "whiskey" = 1, "watermelonjuice" = 1)
	result_amount = 2

/datum/chemical_reaction/andalusia
	name = "安达卢西亚"
	id = "andalusia"
	result = "andalusia"
	required_reagents = list("rum" = 1, "whiskey" = 1, "lemonjuice" = 1)
	result_amount = 3

/datum/chemical_reaction/neurotoxin
	name = "神经毒素"
	id = "neurotoxin"
	result = "neurotoxin"
	required_reagents = list("gargleblaster" = 1, "stoxin" = 1)
	result_amount = 2

/datum/chemical_reaction/snowwhite
	name = "白雪"
	id = "snowwhite"
	result = "snowwhite"
	required_reagents = list("beer" = 1, "lemon_lime" = 1)
	result_amount = 2

/datum/chemical_reaction/irishcarbomb
	name = "爱尔兰汽车炸弹"
	id = "irishcarbomb"
	result = "irishcarbomb"
	required_reagents = list("ale" = 1, "irishcream" = 1)
	result_amount = 2

/datum/chemical_reaction/syndicatebomb
	name = "辛迪加炸弹"
	id = "syndicatebomb"
	result = "syndicatebomb"
	required_reagents = list("beer" = 1, "whiskeycola" = 1)
	result_amount = 2

/datum/chemical_reaction/erikasurprise
	name = "艾丽卡惊喜"
	id = "erikasurprise"
	result = "erikasurprise"
	required_reagents = list("ale" = 1, "limejuice" = 1, "whiskey" = 1, "banana" = 1, "ice" = 1)
	result_amount = 5

/datum/chemical_reaction/devilskiss
	name = "魔鬼之吻"
	id = "devilskiss"
	result = "devilskiss"
	required_reagents = list("blood" = 1, "kahlua" = 1, "rum" = 1)
	result_amount = 3

/datum/chemical_reaction/hippiesdelight
	name = "嬉皮士的喜悦"
	id = "hippiesdelight"
	result = "hippiesdelight"
	required_reagents = list("psilocybin" = 1, "gargleblaster" = 1)
	result_amount = 2

/datum/chemical_reaction/bananahonk
	name = "香蕉轰隆"
	id = "bananahonk"
	result = "bananahonk"
	required_reagents = list("banana" = 1, "cream" = 1, "sugar" = 1)
	result_amount = 3

/datum/chemical_reaction/silencer
	name = "消音器"
	id = "silencer"
	result = "silencer"
	required_reagents = list("nothing" = 1, "cream" = 1, "sugar" = 1)
	result_amount = 3

/datum/chemical_reaction/driestmartini
	name = "最干马提尼"
	id = "driestmartini"
	result = "driestmartini"
	required_reagents = list("nothing" = 1, "gin" = 1)
	result_amount = 2

/datum/chemical_reaction/lemonade
	name = "柠檬水"
	id = "lemonade"
	result = "lemonade"
	required_reagents = list("lemonjuice" = 1, "sugar" = 1, "water" = 1)
	result_amount = 3

/datum/chemical_reaction/kiraspecial
	name = "基拉特调"
	id = "kiraspecial"
	result = "kiraspecial"
	required_reagents = list("orangejuice" = 1, "limejuice" = 1, "sodawater" = 1)
	result_amount = 2

/datum/chemical_reaction/brownstar
	name = "棕色之星"
	id = "brownstar"
	result = "brownstar"
	required_reagents = list("orangejuice" = 2, "cola" = 1)
	result_amount = 2

/datum/chemical_reaction/chocolate_milk
	name = "巧克力牛奶"
	id = "chocolate_milk"
	result = "chocolate_milk"
	required_reagents = list("chocolatesyrup" = 1, "milk" = 4)
	result_amount = 5

/datum/chemical_reaction/milkshake
	name = "奶昔"
	id = "milkshake"
	result = "milkshake"
	required_reagents = list("cream" = 1, "ice" = 2, "milk" = 2)
	result_amount = 5

/datum/chemical_reaction/milkshake/chocolate
	name = "巧克力奶昔"
	id = "chocolate_milkshake"
	result = "chocolate_milkshake"
	required_reagents = list("cream" = 1, "ice" = 2, "chocolate_milk" = 2)
	result_amount = 5

/datum/chemical_reaction/rewriter
	name = "改写者"
	id = "rewriter"
	result = "rewriter"
	required_reagents = list("spacemountainwind" = 1, "coffee" = 1)
	result_amount = 2

/datum/chemical_reaction/suidream
	name = "穗之梦"
	id = "suidream"
	result = "suidream"
	required_reagents = list("space_up" = 2, "bluecuracao" = 1, "melonliquor" = 1)
	result_amount = 4

/datum/chemical_reaction/eggnog
	name = "蛋奶酒"
	id = "eggnog"
	result = "eggnog"
	required_reagents = list("sugar" = 1, "cream" = 1, "milk" = 2)
	result_amount = 3

/datum/chemical_reaction/spikedeggnog
	name = "加料蛋奶酒"
	id = "spikedeggnog"
	result = "spikedeggnog"
	required_reagents = list("eggnog" = 2, "rum" = 1)
	result_amount = 3
