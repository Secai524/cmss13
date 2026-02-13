/obj/item/storage/pill_bottle/dice
	name = "一包骰子"
	desc = "这是一个装有骰子的小容器。"

/obj/item/storage/pill_bottle/dice/fill_preset_inventory()
		new /obj/item/toy/dice( src )
		new /obj/item/toy/dice/d20( src )

/*
 * Donut Box
 */

/obj/item/storage/donut_box
	icon = 'icons/obj/items/food/donuts.dmi'
	icon_state = "donutbox"
	name = "\improper Yum! donuts"
	desc = "一盒令人垂涎的\"<i>Yum!</i>\" brand donuts."
	storage_slots = 6
	var/startswith = 6
	var/open = 0
	can_hold = list(/obj/item/reagent_container/food/snacks/donut)
	foldable = /obj/item/stack/sheet/cardboard

/obj/item/storage/donut_box/fill_preset_inventory()
	for(var/i=1; i <= startswith; i++)
		new /obj/item/reagent_container/food/snacks/donut/normal(src)

/obj/item/storage/donut_box/attack_self(mob/user as mob)
	var/message = "You [open ? "close [src]. Another time, then." : "open [src]. Mmmmm... donuts."]"
	to_chat(user, message)
	open = !open
	update_icon()
	if(!length(contents))
		..()
	return

/obj/item/storage/donut_box/update_icon()
	overlays.Cut()
	if(!open)
		icon_state = "donutbox"
		return
	icon_state = "donutbox_o"
	var/i = 0
	for(var/obj/item/reagent_container/food/snacks/donut/D in contents)
		i++
		var/image/img = image('icons/obj/items/food/donuts.dmi', "[D.overlay_state]-[i]")
		overlays += img

/obj/item/storage/donut_box/empty
	icon_state = "donutbox_o"
	startswith = 0

/*
 * Mateba(Unica) Case
 */

/obj/item/storage/mateba_case
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "matebacase"
	name = "独角兽备用枪管箱"
	desc = "一个用于存放定制独角兽自动左轮所需工具和零件的木箱。包含三种枪管长度、用于更换的必要工具，并有空间存放枪械本身。"
	storage_slots = 5
	can_hold = list(/obj/item/attachable/mateba, /obj/item/weapon/gun/revolver/mateba, /obj/item/weapon/mateba_key)

/obj/item/storage/mateba_case/captain/fill_preset_inventory()
	new /obj/item/attachable/mateba/short(src)
	new /obj/item/attachable/mateba(src)
	new /obj/item/attachable/mateba/long(src)
	new /obj/item/weapon/mateba_key(src)

/obj/item/storage/mateba_case/captain/council
	icon_state = "c_matebacase"
	name = "高级军官独角兽备用枪管箱"
	desc = "一个用于存放定制独角兽自动左轮所需工具和零件的乌木黑箱，并有空间存放枪械本身。此型号为高级军官定制，配有银色枪管附件。"

/obj/item/storage/mateba_case/captain/council/fill_preset_inventory()
	new /obj/item/attachable/mateba/short/silver(src)
	new /obj/item/attachable/mateba/silver(src)
	new /obj/item/attachable/mateba/long/silver(src)
	new /obj/item/weapon/mateba_key(src)

/obj/item/storage/mateba_case/captain/council_gold
	icon_state = "c_matebacase"
	name = "高级军官独角兽备用枪管箱"
	desc = "一个用于存放定制独角兽自动左轮所需工具和零件的乌木黑箱，并有空间存放枪械本身。此型号为高级军官定制，配有金色枪管附件。"

/obj/item/storage/mateba_case/captain/council_gold/fill_preset_inventory()
	new /obj/item/attachable/mateba/short/gold(src)
	new /obj/item/attachable/mateba/gold(src)
	new /obj/item/attachable/mateba/long/gold(src)
	new /obj/item/weapon/mateba_key(src)

/obj/item/storage/mateba_case/general
	icon_state = "c_matebacase"
	name = "豪华独角兽定制套件箱"
	desc = "一个用于存放定制独角兽自动左轮所需工具和零件的乌木黑箱。此型号为将官级金色独角兽定制，配有金色枪管附件。"

/obj/item/storage/mateba_case/general/fill_preset_inventory()
	new /obj/item/attachable/mateba/short/gold(src)
	new /obj/item/attachable/mateba/gold(src)
	new /obj/item/attachable/mateba/long/gold(src)
	new /obj/item/weapon/mateba_key(src)

//6 pack

/obj/item/storage/beer_pack
	name = "啤酒包"
	desc = "一包阿斯彭啤酒罐。"
	icon = 'icons/obj/items/food/drinkcans.dmi'
	icon_state = "6_pack_6"
	item_state = "souto_classic"
	storage_slots = 6
	can_hold = list(/obj/item/reagent_container/food/drinks/cans/aspen)

/obj/item/storage/beer_pack/fill_preset_inventory()
	for(var/i in 1 to 6)
		new /obj/item/reagent_container/food/drinks/cans/aspen(src)

/obj/item/storage/beer_pack/update_icon()
	if(length(contents) == 1)
		var/turf/T = get_turf(src)
		var/obj/item/reagent_container/food/drinks/cans/aspen/B = new(T)
		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			H.temp_drop_inv_item(src)
			H.put_in_inactive_hand(B)
		qdel(src)
	else
		icon_state = "6_pack_[length(contents)]"

/obj/item/storage/box/clf
	name = "D18收纳盒"
	desc = "一个装饰相当精美、颇具仪式感的盒子，内含一把CLF D18手枪和一个额外弹匣。我猜那些CLF的家伙更在意他们的工艺和腔调，而不是实用性，对吧？"
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "m43case"
	w_class = SIZE_SMALL
	max_w_class = SIZE_TINY
	storage_slots = 2
	can_hold = list(/obj/item/weapon/gun/pistol/clfpistol, /obj/item/ammo_magazine/pistol/clfpistol)

/obj/item/storage/box/clf/fill_preset_inventory()
	new /obj/item/weapon/gun/pistol/clfpistol(src)
	new /obj/item/ammo_magazine/pistol/clfpistol(src)

/obj/item/storage/box/upp //war trophy luger
	name = "73式收纳盒"
	desc = "一个小盒子，装着UPP曾经的标准配枪——73式手枪，以及两个额外弹匣。里面的手枪很可能是从阵亡军官身上搜刮来的，或是从缴获的库存中拿的，不管怎样，这东西都值不少钱。"
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "matebacase"
	w_class = SIZE_MEDIUM
	max_w_class = SIZE_MEDIUM
	storage_slots = 3
	can_hold = list(/obj/item/weapon/gun/pistol/t73, /obj/item/ammo_magazine/pistol/t73)

/obj/item/storage/box/upp/fill_preset_inventory()
	new /obj/item/weapon/gun/pistol/t73(src)
	new /obj/item/ammo_magazine/pistol/t73(src)
	new /obj/item/ammo_magazine/pistol/t73(src)

/obj/item/storage/box/action
	name = "AC71‘行动’收纳盒"
	desc = "一个小盒子，内含一把矛头军械厂制造的AC71‘行动’型隐藏手枪。这很可能是陆战队员从家里带来的，或是未经许可从殖民地拿走的。"
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "m43case"
	w_class = SIZE_SMALL
	max_w_class = SIZE_TINY
	storage_slots = 3
	can_hold = list(/obj/item/weapon/gun/pistol/action, /obj/item/ammo_magazine/pistol/action)

/obj/item/storage/box/action/fill_preset_inventory()
	new /obj/item/weapon/gun/pistol/action(src)
	new /obj/item/ammo_magazine/pistol/action(src)
	new /obj/item/ammo_magazine/pistol/action(src)

/obj/item/storage/box/plinker
	name = "W62‘耳语’收纳盒"
	desc = "一个小盒子，内含一把矛头军械厂制造的.22口径W62‘耳语’型灭鼠手枪。这很可能是陆战队员从家里带来的，或是未经许可从殖民地拿走的。"
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "m43case"
	w_class = SIZE_MEDIUM
	max_w_class = SIZE_SMALL
	storage_slots = 3
	can_hold = list(/obj/item/weapon/gun/pistol/holdout, /obj/item/ammo_magazine/pistol/holdout)

/obj/item/storage/box/plinker/fill_preset_inventory()
	new /obj/item/weapon/gun/pistol/holdout(src)
	new /obj/item/ammo_magazine/pistol/holdout(src)
	new /obj/item/ammo_magazine/pistol/holdout(src)

/obj/item/storage/box/co2_knife
	name = "M8弹匣刺刀包装"
	desc = "内含一把M8弹匣刺刀和两枚配套的CO2气瓶。感谢您成为《靴子》杂志的忠实订阅者！"
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "co2_box"
	foldable = TRUE
	storage_slots = 3
	w_class = SIZE_SMALL
	max_w_class = SIZE_SMALL
	can_hold = list(/obj/item/attachable/bayonet/co2, /obj/item/co2_cartridge)

/obj/item/storage/box/co2_knife/fill_preset_inventory()
	new /obj/item/attachable/bayonet/co2(src)
	new /obj/item/co2_cartridge(src)
	new /obj/item/co2_cartridge(src)
