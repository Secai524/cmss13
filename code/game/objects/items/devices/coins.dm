//*****************************Coin********************************/

/obj/item/coin
	icon = 'icons/obj/items/economy.dmi'
	name = "硬币"
	icon_state = "coin"
	flags_atom = FPRINT|CONDUCT
	force = 0
	throwforce = 0
	w_class = SIZE_TINY
	black_market_value = 10
	var/string_attached
	var/sides = 2
	ground_offset_x = 8
	ground_offset_y = 4

/obj/item/coin/gold
	name = "金币"
	desc = "一枚纯金硬币。"
	icon_state = "coin_gold"
	black_market_value = 30

/obj/item/coin/silver
	name = "银币"
	desc = "一枚纯银硬币。"
	icon_state = "coin_silver"
	black_market_value = 25

//CO coin
/obj/item/coin/silver/falcon
	name = "坠鹰挑战币"
	desc = "一枚小硬币，刻有坠鹰徽章。"

/obj/item/coin/silver/cia
	name = "银币"
	desc = "一枚银币。正面刻有鹰徽。"

/obj/item/coin/copper
	name = "铜币"
	desc = "一种熟悉但廉价的货币形式。"
	icon_state = "coin_copper"
	black_market_value = 30

/obj/item/coin/diamond
	name = "钻石币"
	desc = "一枚完美无瑕的钻石硬币。"
	icon_state = "coin_diamond"
	black_market_value = 35

/obj/item/coin/iron
	name = "铁币"
	desc = "一枚坚固的铁制硬币。你担心它会生锈。"
	icon_state = "coin_iron"
	black_market_value = 15

/obj/item/coin/phoron
	name = "固态福罗币"
	desc = "福罗有更好的用途。"
	icon_state = "coin_phoron"
	black_market_value = 35

/obj/item/coin/uranium
	name = "铀币"
	desc = "一枚放射性硬币。别碰它！"
	icon_state = "coin_uranium"
	black_market_value = 35

/obj/item/coin/platinum
	name = "铂金币"
	desc = "一枚闪亮的铂金硬币。相当贵重。"
	icon_state = "coin_platinum"
	black_market_value = 35

/obj/item/coin/chitin
	name = "几丁质币"
	desc = "耐用的外星几丁质压制成硬币。几丁质有更好的用途……"
	icon_state = "coin_chitin"
	black_market_value = 35

/obj/item/coin/clown
	name = "小丑币"
	desc = "闻起来像香蕉。一个小丑把他的脸深情地印在每一枚硬币上。HONK！"
	icon_state = "coin_clown"
	black_market_value = 35

/obj/item/coin/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/CC = W
		if(string_attached)
			to_chat(user, SPAN_NOTICE("这枚硬币已经系上线了。"))
			return
		if (CC.use(1))
			overlays += image('icons/obj/items/economy.dmi',"coin_string_overlay")
			string_attached = 1
			to_chat(user, SPAN_NOTICE("你将一根线系在硬币上。"))
		else
			to_chat(user, SPAN_NOTICE("这卷电缆似乎是空的。"))
		return
	else if(HAS_TRAIT(W, TRAIT_TOOL_WIRECUTTERS))
		if(!string_attached)
			..()
			return

		var/obj/item/stack/cable_coil/CC = new/obj/item/stack/cable_coil(user.loc)
		CC.amount = 1
		CC.updateicon()
		overlays = list()
		string_attached = null
		to_chat(user, SPAN_NOTICE("你将线从硬币上解下。"))
	else ..()

/obj/item/coin/attack_self(mob/user)
	..()
	var/result = rand(1, sides)
	var/comment = ""
	if(result == 1)
		comment = "tails"
	else if(result == 2)
		comment = "heads"
	user.visible_message(SPAN_NOTICE("[user]扔出了\the [src]。它落在了[comment]上！"),
						SPAN_NOTICE("You throw \the [src]. It lands on [comment]!"))


/obj/item/coin/marine
	name = "陆战队员装备代币"
	desc = "我想知道它是干什么用的？"
	icon_state = "coin_copper"
	black_market_value = 0
	/// What is the token for?
	var/token_type = VEND_TOKEN_VOID

/obj/item/coin/marine/attackby(obj/item/W as obj, mob/user as mob) //To remove attaching a string functionality
	return

/obj/item/coin/marine/engineer
	name = "陆战队员工程支援代币"
	desc = "将此代币插入工程师贩卖机以获取支援武器。"
	icon_state = "coin_gold"
	token_type = VEND_TOKEN_ENGINEER

/obj/item/coin/marine/specialist
	name = "陆战队员专家武器代币"
	desc = "将此代币插入USCM装备贩卖机以获取一件高度危险的武器。"
	icon_state = "coin_diamond"
	token_type = VEND_TOKEN_SPEC

/obj/item/coin/marine/synth
	name = "合成人实验工具兑换代币"
	desc = "将此代币插入合成人实验工具贩卖机以获取多种实验性支援工具。"
	icon_state = "coin_synth"
	token_type = VEND_TOKEN_SYNTH
