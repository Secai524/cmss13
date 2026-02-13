//------------CANTEEN MRE VENDOR---------------
/obj/structure/machinery/cm_vending/sorted/marine_food
	name = "\improper 殖民地海军陆战队科技食品供应商"
	desc = "USCM食品贩卖机，内含标准军用即食餐。"
	icon_state = "marine_food"
	hackable = TRUE
	unacidable = FALSE
	unslashable = FALSE
	wrenchable = TRUE

/obj/structure/machinery/cm_vending/sorted/marine_food/populate_product_list(scale)
	listed_products = list(
		list("预制餐食", -1, null, null),
		list("USCM（殖民地海军陆战队） 即食餐（鸡肉味）", 15, /obj/item/reagent_container/food/snacks/mre_pack/meal5, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 预制餐（玉米面包）", 15, /obj/item/reagent_container/food/snacks/mre_pack/meal1, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 预制餐（意面）", 15, /obj/item/reagent_container/food/snacks/mre_pack/meal3, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 预制餐（披萨）", 15, /obj/item/reagent_container/food/snacks/mre_pack/meal4, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 预制餐（猪肉）", 15, /obj/item/reagent_container/food/snacks/mre_pack/meal2, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 预制餐（豆腐）", 15, /obj/item/reagent_container/food/snacks/mre_pack/meal6, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 蛋白质棒", 50, /obj/item/reagent_container/food/snacks/protein_pack, VENDOR_ITEM_REGULAR),
		list("药剂瓶", -1, null, null),
		list("军用水壶", 10, /obj/item/reagent_container/food/drinks/flask/canteen, VENDOR_ITEM_REGULAR),
		list("金属水壶", 10, /obj/item/reagent_container/food/drinks/flask, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）水壶", 5, /obj/item/reagent_container/food/drinks/flask/marine, VENDOR_ITEM_REGULAR),
		list("W-Y 烧瓶", 5, /obj/item/reagent_container/food/drinks/flask/weylandyutani, VENDOR_ITEM_REGULAR)
	)

/obj/structure/machinery/cm_vending/sorted/marine_food/tutorial
	hackable = FALSE
	wrenchable = FALSE
	req_access = list(ACCESS_TUTORIAL_LOCKED)

/obj/structure/machinery/cm_vending/sorted/marine_food/tutorial/populate_product_list(scale)
	listed_products = list(
		list("预制餐食", -1, null, null),
		list("USCM（殖民地海军陆战队） 即食餐（鸡肉味）", 0, /obj/item/reagent_container/food/snacks/mre_pack/meal5, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 预制餐（玉米面包）", 0, /obj/item/reagent_container/food/snacks/mre_pack/meal1, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 即食餐（意面）", 0, /obj/item/reagent_container/food/snacks/mre_pack/meal3, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 预制餐（披萨）", 0, /obj/item/reagent_container/food/snacks/mre_pack/meal4, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 预制餐（猪肉）", 0, /obj/item/reagent_container/food/snacks/mre_pack/meal2, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 预制餐（豆腐）", 0, /obj/item/reagent_container/food/snacks/mre_pack/meal6, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队） 蛋白质棒", 1, /obj/item/reagent_container/food/snacks/protein_pack, VENDOR_ITEM_RECOMMENDED),
		list("药剂瓶", -1, null, null),
		list("军用水壶", 0, /obj/item/reagent_container/food/drinks/flask/canteen, VENDOR_ITEM_REGULAR),
		list("金属水壶", 0, /obj/item/reagent_container/food/drinks/flask, VENDOR_ITEM_REGULAR),
		list("USCM（殖民地海军陆战队）水壶", 0, /obj/item/reagent_container/food/drinks/flask/marine, VENDOR_ITEM_REGULAR),
		list("W-Y 烧瓶", 0, /obj/item/reagent_container/food/drinks/flask/weylandyutani, VENDOR_ITEM_REGULAR)
	)
//------------BOOZE-O-MAT VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/boozeomat
	name = "\improper 酒水自动贩卖机"
	desc = "一项技术奇迹，据称能在你点单时精确调配出你想要的混合饮品。"
	icon_state = "boozeomat"
	vendor_theme = VENDOR_THEME_COMPANY
	vend_delay = 1.5 SECONDS
	hackable = TRUE
	unacidable = FALSE
	unslashable = FALSE
	wrenchable = TRUE

/obj/structure/machinery/cm_vending/sorted/boozeomat/populate_product_list(scale)
	listed_products = list(
		list("酒精", -1, null, null),
		list("麦芽酒", 6, /obj/item/reagent_container/food/drinks/cans/ale, VENDOR_ITEM_REGULAR),
		list("啤酒", 6, /obj/item/reagent_container/food/drinks/cans/beer, VENDOR_ITEM_REGULAR),
		list("野蔷薇石榴糖浆", 5, /obj/item/reagent_container/food/drinks/bottle/grenadine, VENDOR_ITEM_REGULAR),
		list("卡卡沃保证品质龙舌兰酒", 5, /obj/item/reagent_container/food/drinks/bottle/tequila, VENDOR_ITEM_REGULAR),
		list("皮特上尉的古巴香料朗姆酒", 5, /obj/item/reagent_container/food/drinks/bottle/rum, VENDOR_ITEM_REGULAR),
		list("巴顿堡特级干邑", 5, /obj/item/reagent_container/food/drinks/bottle/cognac, VENDOR_ITEM_REGULAR),
		list("达文波特黑麦威士忌", 3, /obj/item/reagent_container/food/drinks/bottle/davenport, VENDOR_ITEM_REGULAR),
		list("双胡子特酿葡萄酒", 5, /obj/item/reagent_container/food/drinks/bottle/wine, VENDOR_ITEM_REGULAR),
		list("翠玉甜瓜利口酒", 2, /obj/item/reagent_container/food/drinks/bottle/melonliquor, VENDOR_ITEM_REGULAR),
		list("黄金眼味美思", 5, /obj/item/reagent_container/food/drinks/bottle/vermouth, VENDOR_ITEM_REGULAR),
		list("格里菲特金酒", 5, /obj/item/reagent_container/food/drinks/bottle/gin, VENDOR_ITEM_REGULAR),
		list("越狱者绿茴香酒", 2, /obj/item/reagent_container/food/drinks/bottle/absinthe, VENDOR_ITEM_REGULAR),
		list("蓝色库拉索小姐", 2, /obj/item/reagent_container/food/drinks/bottle/bluecuracao, VENDOR_ITEM_REGULAR),
		list("红星伏特加", 5, /obj/item/reagent_container/food/drinks/bottle/vodka, VENDOR_ITEM_REGULAR),
		list("罗伯特·罗巴斯特咖啡利口酒", 5, /obj/item/reagent_container/food/drinks/bottle/kahlua, VENDOR_ITEM_REGULAR),
		list("吉特叔叔的特酿", 5, /obj/item/reagent_container/food/drinks/bottle/whiskey, VENDOR_ITEM_REGULAR),
		list("维兰德-汤谷阿斯彭啤酒", 20, /obj/item/reagent_container/food/drinks/cans/aspen, VENDOR_ITEM_REGULAR),

		list("精酿啤酒", -1, null, null),
		list("彭德尔顿的三星勋章", 5, /obj/item/reagent_container/food/drinks/bottle/beer/craft, VENDOR_ITEM_REGULAR),
		list("燕尾服特酿", 5, /obj/item/reagent_container/food/drinks/bottle/beer/craft/tuxedo, VENDOR_ITEM_REGULAR),
		list("加努奇纯正淡啤", 5, /obj/item/reagent_container/food/drinks/bottle/beer/craft/ganucci, VENDOR_ITEM_REGULAR),
		list("蓝色麦芽", 5, /obj/item/reagent_container/food/drinks/bottle/beer/craft/bluemalt, VENDOR_ITEM_REGULAR),
		list("派对爆竹艾尔", 5, /obj/item/reagent_container/food/drinks/bottle/beer/craft/partypopper, VENDOR_ITEM_REGULAR),
		list("塔祖什卡绿松石啤酒", 5, /obj/item/reagent_container/food/drinks/bottle/beer/craft/tazhushka, VENDOR_ITEM_REGULAR),
		list("收割者红啤", 5, /obj/item/reagent_container/food/drinks/bottle/beer/craft/reaper, VENDOR_ITEM_REGULAR),
		list("单色拉格", 5, /obj/item/reagent_container/food/drinks/bottle/beer/craft/mono, VENDOR_ITEM_REGULAR),

		list("无酒精", -1, null, null),
		list("公爵紫茶", 10, /obj/item/reagent_container/food/drinks/tea, VENDOR_ITEM_REGULAR),
		list("果啤", 8, /obj/item/reagent_container/food/drinks/cans/cola, VENDOR_ITEM_REGULAR),
		list("青柠汁", 4, /obj/item/reagent_container/food/drinks/bottle/limejuice, VENDOR_ITEM_REGULAR),
		list("牛奶奶油", 4, /obj/item/reagent_container/food/drinks/bottle/cream, VENDOR_ITEM_REGULAR),
		list("橙汁", 4, /obj/item/reagent_container/food/drinks/bottle/orangejuice, VENDOR_ITEM_REGULAR),
		list("苏打水", 15, /obj/item/reagent_container/food/drinks/cans/sodawater, VENDOR_ITEM_REGULAR),
		list("番茄汁", 4, /obj/item/reagent_container/food/drinks/bottle/tomatojuice, VENDOR_ITEM_REGULAR),
		list("汤力水", 8, /obj/item/reagent_container/food/drinks/cans/tonic, VENDOR_ITEM_REGULAR),

		list("容器", -1, null, null),
		list("烧瓶", 5, /obj/item/reagent_container/food/drinks/flask/barflask, VENDOR_ITEM_REGULAR),
		list("玻璃", 30, /obj/item/reagent_container/food/drinks/drinkingglass, VENDOR_ITEM_REGULAR),
		list("冰杯", 30, /obj/item/reagent_container/food/drinks/ice, VENDOR_ITEM_REGULAR),
		list("保温瓶", 5, /obj/item/reagent_container/food/drinks/flask/vacuumflask, VENDOR_ITEM_REGULAR)
	)

/obj/structure/machinery/cm_vending/sorted/boozeomat/populate_product_list_and_boxes(scale)
	. = ..()

	// If this is groundside and isn't dynamically changing we will spawn with stock randomly removed from it
	if(vend_flags & VEND_STOCK_DYNAMIC)
		return
	if(Check_WO())
		return
	var/turf/location = get_turf(src)
	if(location && is_ground_level(location.z))
		random_unstock()

/// Randomly removes amounts of listed_products and reagents
/obj/structure/machinery/cm_vending/sorted/boozeomat/proc/random_unstock()
	for(var/list/vendspec as anything in listed_products)
		var/amount = vendspec[2]
		if(amount <= 0)
			continue

		// Chance to just be empty
		if(prob(25))
			vendspec[2] = 0
			continue

		// Otherwise its some amount between 1 and the original amount
		vendspec[2] = rand(1, 3)

/obj/structure/machinery/cm_vending/sorted/boozeomat/chess
	name = "\improper 国际象棋自动机"
	desc = "2143年，红星饮品公司——一家隶属于UPP-CA（殖民地管理局）的企业——为在一批限量版红星伏特加瓶盖内侧找到特殊代码的饮酒者举办了一次促销抽奖活动，奖品是一台无限续杯的象棋自动贩卖机。"
	vendor_theme = VENDOR_THEME_COMPANY
	icon_state = "chessomat"
	hackable = TRUE
	unacidable = FALSE
	unslashable = FALSE
	wrenchable = TRUE

/obj/structure/machinery/cm_vending/sorted/boozeomat/chess/populate_product_list(scale)
	listed_products = list(
		list("白棋", -1, null, null),
		list("兵卒", 2, /obj/item/reagent_container/food/drinks/bottle/vodka/chess/w_pawn, VENDOR_ITEM_REGULAR),
		list("主教", 2, /obj/item/reagent_container/food/drinks/bottle/vodka/chess/w_bishop, VENDOR_ITEM_REGULAR),
		list("骑士", 2, /obj/item/reagent_container/food/drinks/bottle/vodka/chess/w_knight, VENDOR_ITEM_REGULAR),
		list("车", 2, /obj/item/reagent_container/food/drinks/bottle/vodka/chess/w_rook, VENDOR_ITEM_REGULAR),
		list("国王", 2, /obj/item/reagent_container/food/drinks/bottle/vodka/chess/w_king, VENDOR_ITEM_REGULAR),
		list("女王", 2, /obj/item/reagent_container/food/drinks/bottle/vodka/chess/w_queen, VENDOR_ITEM_REGULAR),

		list("黑棋", -1, null, null),
		list("兵卒", 2, /obj/item/reagent_container/food/drinks/bottle/vodka/chess/b_pawn, VENDOR_ITEM_REGULAR),
		list("主教", 2, /obj/item/reagent_container/food/drinks/bottle/vodka/chess/b_bishop, VENDOR_ITEM_REGULAR),
		list("骑士", 2, /obj/item/reagent_container/food/drinks/bottle/vodka/chess/b_knight, VENDOR_ITEM_REGULAR),
		list("车", 2, /obj/item/reagent_container/food/drinks/bottle/vodka/chess/b_rook, VENDOR_ITEM_REGULAR),
		list("国王", 2, /obj/item/reagent_container/food/drinks/bottle/vodka/chess/b_king, VENDOR_ITEM_REGULAR),
		list("女王", 2, /obj/item/reagent_container/food/drinks/bottle/vodka/chess/b_queen, VENDOR_ITEM_REGULAR)
	)
