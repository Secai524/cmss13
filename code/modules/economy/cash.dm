/obj/item/spacecash
	name = "15美元"
	desc = "你有15美元。"
	gender = PLURAL
	icon = 'icons/obj/items/economy.dmi'
	icon_state = "spacecash1"
	opacity = FALSE
	density = FALSE
	anchored = FALSE
	force = 1
	throwforce = 1
	throw_speed = SPEED_FAST
	throw_range = 2
	w_class = SIZE_TINY
	var/worth = 15
	/// 'Counterfeit' bills cannot be inserted into the black market for dosh. Their worth is also quartered when entered into an ATM.
	var/counterfeit = FALSE

/obj/item/spacecash/Initialize(mapload, ...)
	. = ..()
	update_value()

/obj/item/spacecash/proc/update_value()
	if(counterfeit)
		return
	black_market_value = worth // While money can be inserted directly into the console, this will allow CTs to detect if the money is 'counterfeit' with their scanner.

/obj/item/spacecash/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/spacecash))
		var/obj/item/spacecash/attack_cash = W
		if(istype(attack_cash, /obj/item/spacecash/ewallet))
			return FALSE
		if(attack_cash.counterfeit != src.counterfeit)
			to_chat(user, SPAN_NOTICE("这两叠钱看起来有点不一样..."))
			return

		var/obj/item/spacecash/bundle/bundle
		if(!istype(W, /obj/item/spacecash/bundle))
			var/obj/item/spacecash/cash = W
			user.temp_drop_inv_item(cash)
			bundle = new(src.loc)
			bundle.worth += cash.worth
			bundle.counterfeit = counterfeit
			bundle.update_value()
			qdel(cash)
		else //is bundle
			bundle = W
		bundle.worth += src.worth
		bundle.update_value()
		bundle.update_icon()
		if(istype(user, /mob/living/carbon/human))
			var/mob/living/carbon/human/h_user = user
			h_user.temp_drop_inv_item(src)
			h_user.temp_drop_inv_item(bundle)
			h_user.put_in_hands(bundle)
		to_chat(user, SPAN_NOTICE("你将价值[src.worth]美元的钞票加入了钱捆。<br>现在它总计[bundle.worth]美元。"))
		qdel(src)

/obj/item/spacecash/bundle
	name = "一捆美元"
	icon_state = ""
	desc = "它们价值0美元。"
	worth = 0

/obj/item/spacecash/bundle/update_icon()
	overlays.Cut()
	var/sum = worth
	var/num = 0
	for(var/i in list(1000,500,200,100,50,20,10,1))
		while(sum >= i && num < 50)
			sum -= i
			num++
			var/image/banknote = image('icons/obj/items/economy.dmi', "spacecash[i]")
			var/matrix/M = matrix()
			M.Translate(rand(-6, 6), rand(-4, 8))
			M.Turn(pick(-45, -27.5, 0, 0, 0, 0, 0, 0, 0, 27.5, 45))
			banknote.transform = M
			overlays += banknote
	if(num == 0) // Less than one thaler, let's just make it look like 1 for ease
		var/image/banknote = image('icons/obj/items/economy.dmi', "spacecash1")
		var/matrix/M = matrix()
		M.Translate(rand(-6, 6), rand(-4, 8))
		M.Turn(pick(-45, -27.5, 0, 0, 0, 0, 0, 0, 0, 27.5, 45))
		banknote.transform = M
		overlays += banknote
	desc = "它们价值[worth]美元。"

/obj/item/spacecash/bundle/attack_self(mob/user)
	..()
	var/oldloc = loc
	var/amount = tgui_input_number(user, "你想取出多少美元？(0 至 [worth])", "Take Money", 0, worth, 0)
	amount = floor(clamp(amount, 0, worth))
	if(amount == 0)
		return
	if(QDELETED(src) || loc != oldloc)
		return

	worth -= amount
	update_icon()
	if(!worth)
		usr.temp_drop_inv_item(src)

	if(amount in list(1000,500,200,100,50,20,1))
		var/cashtype = text2path("/obj/item/spacecash/c[amount]")
		var/obj/item/spacecash/cash = new cashtype(usr.loc)
		cash.counterfeit = counterfeit
		user.put_in_hands(cash)
	else
		var/obj/item/spacecash/bundle/bundle = new(usr.loc)
		bundle.worth = amount
		bundle.counterfeit = counterfeit
		bundle.update_icon()
		user.put_in_hands(bundle)

	if(!worth)
		qdel(src)

/obj/item/spacecash/c1
	name = "1美元钞票"
	icon_state = "spacecash1"
	desc = "一张美国政府印制的一美元钞票。上面印有乔治·华盛顿的头像。这会让大多数英裔人士落泪，但本身价值不高。在某些星系，大概能给你换来半根热狗。"
	worth = 1

/obj/item/spacecash/c10
	name = "10美元钞票"
	icon_state = "spacecash10"
	desc = "一张美国政府印制的十美元钞票。上面印有亚历山大·汉密尔顿的头像，这位联邦银行的热衷者，也是一次恶劣骚扰事件的受害者。在付税和小费之前，大概够在一家廉价餐馆吃顿饭。"
	worth = 10

/obj/item/spacecash/c20
	name = "20美元钞票"
	icon_state = "spacecash20"
	desc = "一张美国政府印制的二十美元钞票。上面印有安德鲁·杰克逊的头像，这位1812年战争的著名英雄，也是各地原住民的屠杀者。大概够你在当地殖民地牛排馆享用一顿不错的两道菜大餐。"
	worth = 20

/obj/item/spacecash/c50
	name = "50美元钞票"
	icon_state = "spacecash50"
	desc = "一张美国政府印制的五十美元钞票。上面印有尤利西斯·S·格兰特的头像，这位以内战中消耗性部队战术而闻名的人物。用这张钞票，你大概可以请整个酒吧的人喝一杯啤酒——假设酒吧里只有另外4个人。"
	worth = 50

/obj/item/spacecash/c100
	name = "100美元钞票"
	icon_state = "spacecash100"
	desc = "一张美国政府印制的一百美元钞票。上面印有本·富兰克林的头像，这位杰出的风筝引雷者。用这张钞票，你大概可以支付一整天的上岸休假活动开销，前提是你不粗心大意。（而你正是如此）"
	worth = 100

/obj/item/spacecash/c200
	name = "200美元"
	icon_state = "spacecash200"
	desc = "两张美国政府印制的一百美元钞票。上面都印有本·富兰克林的头像。两个本从不同角度充满期待且热情地看着你。"
	worth = 200

/obj/item/spacecash/c500
	name = "500美元"
	icon_state = "spacecash500"
	desc = "五张美国政府印制的一百美元钞票。上面全都印有本·富兰克林的头像。它们都热切地瞪着你，让你感觉好像欠了他们什么。"
	worth = 500

/obj/item/spacecash/c500/counterfeit
	// If you're going to slap down huge sums of cash in easily reachable spots for RP or flavor reasons, make them counterfeit, so they don't break the black market - they will be rejected.
	counterfeit = TRUE

/obj/item/spacecash/c1000
	name = "1000美元"
	icon_state = "spacecash1000"
	desc = "十张美国政府印制的一百美元钞票。每一张该死的钞票上都印着他妈的本·富兰克林。本们的法庭不耐烦地坐着，仿佛每一个都认为只有自己才属于你。这群愤怒的本们都已经得知了你与其他本们的关系，他们想要一个解释。"
	worth = 1000

/obj/item/spacecash/c1000/counterfeit
	// If you're going to slap down huge sums of cash in easily reachable spots for RP or flavor reasons, make them counterfeit, so they don't break the black market - they will be rejected.
	counterfeit = TRUE

/proc/spawn_money(sum, spawnloc, mob/living/carbon/human/human_user as mob)
	if(sum in list(1000,500,200,100,50,20,10,1))
		var/cash_type = text2path("/obj/item/spacecash/c[sum]")
		var/obj/cash = new cash_type (usr.loc)
		if(ishuman(human_user) && !human_user.get_active_hand())
			human_user.put_in_hands(cash)
	else
		var/obj/item/spacecash/bundle/bundle = new (spawnloc)
		bundle.worth = sum
		bundle.update_icon()
		if (ishuman(human_user) && !human_user.get_active_hand())
			human_user.put_in_hands(bundle)
	return

/obj/item/spacecash/ewallet
	name = "\improper Weyland-Yutani cash card"
	icon_state = "efundcard"
	desc = "一张维兰德-汤谷支持的现金卡，存储有一定金额的货币。"
	var/owner_name = "" //So the ATM can set it so the EFTPOS can put a valid name on transactions.

/obj/item/spacecash/ewallet/get_examine_text(mob/user)
	. = ..()
	if(user == loc)
		. += SPAN_NOTICE("Charge card's owner: [owner_name]. Dollars remaining: [worth].")
