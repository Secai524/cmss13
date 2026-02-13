// Reference: http://www.teuse.net/personal/harrington/hh_bible.htm
// http://www.trmn.org/portal/images/uniforms/rmn/rmn_officer_srv_dress_lrg.png

/obj/item/clothing/head/beret/centcom/officer
	name = "军官贝雷帽"
	desc = "一顶黑色贝雷帽，饰有维兰德-汤谷安保部队的银色鸢形盾牌和雕刻剑徽，向世界宣告佩戴者是维兰德-汤谷的捍卫者。"
	icon_state = "centcomofficerberet"

/obj/item/clothing/head/beret/centcom/captain
	name = "舰长贝雷帽"
	desc = "一顶白色贝雷帽，饰有维兰德-汤谷安保部队的钴蓝色鸢形盾牌和雕刻剑徽，仅由指挥维兰德-汤谷海军舰船的舰长佩戴。"
	icon_state = "centcomcaptain"

/obj/item/clothing/shoes/centcom
	name = "礼服鞋"
	desc = "它们看起来被擦拭得一尘不染。"
	icon_state = "laceups"

/obj/item/clothing/under/rank/centcom/representative
	desc = "太空黑色布料上点缀着金色镶边，这套制服彰显着\"Ensign\" and bears \"N.C.V. Fearless CV-286\" on the left shoulder."
	name = "\improper Wey-Yu Navy Uniform"
	icon_state = "officer"
	item_state = "g_suit"
	displays_id = 0

/obj/item/clothing/under/rank/centcom/officer
	desc = "太空黑色布料上点缀着金色镶边，这套制服彰显着\"Lieutenant Commander\" and bears \"N.C.V. Fearless CV-286\" on the left shoulder."
	name = "\improper Wey-Yu Officer Uniform"
	icon_state = "officer"
	item_state = "g_suit"
	displays_id = 0
	item_state_slots = list(WEAR_BODY = "officer")

/obj/item/clothing/under/rank/centcom/captain
	desc = "太空黑色布料上点缀着金色镶边，这套制服彰显着\"Admiral\" and bears \"N.C.V. Fearless CV-286\" on the left shoulder."
	name = "\improper Wey-Yu Admiral Uniform"
	icon_state = "officer"
	item_state = "g_suit"
	displays_id = 0
