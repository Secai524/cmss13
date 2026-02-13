/* Cards
 * Contains:
 * DATA CARD
 * ID CARD
 * FINGERPRINT CARD HOLDER
 * FINGERPRINT CARD
 */



/*
 * DATA CARDS - Used for the teleporter
 */
/obj/item/card
	name = "card"
	desc = "处理卡片事务。"
	icon = 'icons/obj/items/card.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/items/ids_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/items/ids_righthand.dmi',
	)
	w_class = SIZE_TINY
	var/associated_account_number = 0

	var/list/files = list(  )

/obj/item/card/data
	name = "数据盘"
	desc = "一个数据盘。"
	icon_state = "data"
	var/function = "storage"
	var/data = "null"
	var/special = null
	item_state = "card-id"

/obj/item/card/data/verb/label(t as text)
	set name = "Label Disk"
	set category = "Object"
	set src in usr

	if (t)
		src.name = text("data disk- '[]'", t)
	else
		src.name = "数据盘"
	src.add_fingerprint(usr)
	return

/obj/item/card/data/clown
	name = "\proper the coordinates to clown planet"
	icon_state = "data"
	item_state = "card-id"
	layer = OBJ_LAYER
	level = 2
	desc = "此卡包含传说中的小丑行星坐标。请小心处理。"
	function = "teleporter"
	data = "Clown Land"
	black_market_value = 50

/*
 * ID CARDS
 */

/obj/item/card/id
	name = "身份全息徽章"
	desc = "一片编码压缩玻璃纤维。用于身份识别和权限控制。"
	icon_state = "id"
	item_state = "card-id"
	var/access = list()
	var/faction = FACTION_NEUTRAL
	var/id_type = "ID Card"
	var/list/faction_group
	/// For custom minimap icons
	var/minimap_icon_override = null

	/// The name registered_name on the card
	var/registered_name = "未知"
	var/datum/weakref/registered_ref = null
	var/registered_gid = 0
	flags_equip_slot = SLOT_ID

	var/blood_type = "\[UNSET\]"

	//alt titles are handled a bit weirdly in order to unobtrusively integrate into existing ID system

	/// can be alt title or the actual job
	var/assignment = null
	/// actual job
	var/rank = null
	/// Marine's paygrade
	var/paygrade = PAY_SHORT_CIV
	/// For medics and engineers to 'claim' a locker
	var/claimedgear = 1

	var/list/uniform_sets = null
	var/list/vended_items

	/// whether the id's onmob overlay only appear when wearing a uniform
	var/pinned_on_uniform = TRUE

	var/modification_log = list()


/obj/item/card/id/Destroy()
	. = ..()
	screen_loc = null

/obj/item/card/id/proc/GetJobName() //Used in secHUD icon generation

	var/job_icons = get_all_job_icons()
	var/centcom = get_all_centcom_jobs()

	if(assignment in job_icons)
		return assignment//Check if the job has a hud icon
	if(rank in job_icons)
		return rank
	if(assignment in centcom)
		return "Centcom"//Return with the NT logo if it is a Centcom job
	if(rank in centcom)
		return "Centcom"
	return "未知" //Return unknown if none of the above apply

/obj/item/card/id/attack_self(mob/user as mob)
	..()
	user.visible_message("[user]向你展示：[icon2html(src, viewers(user))] [name]：职务：[assignment]")
	src.add_fingerprint(user)

/obj/item/card/id/proc/set_user_data(mob/living/carbon/human/H)
	if(!istype(H))
		return

	registered_name = H.real_name
	registered_ref = WEAKREF(H)
	registered_gid = H.gid
	blood_type = H.blood_type

/obj/item/card/id/proc/set_assignment(new_assignment)
	assignment = new_assignment
	name = "[registered_name]的[id_type] ([assignment])"

/obj/item/card/id/GetAccess()
	return access

/obj/item/card/id/GetID()
	return src

/obj/item/card/id/verb/read()
	set name = "Read ID Card"
	set category = "Object"
	set src in usr

	to_chat(usr, "[icon2html(src, usr)] [name]：卡上当前职务为[assignment]")
	to_chat(usr, "卡上血型为[blood_type]。")

/obj/item/card/id/proc/check_biometrics(mob/living/carbon/human/target)
	if(registered_ref && (registered_ref != WEAKREF(target)))
		return FALSE
	if(target.real_name != registered_name)
		return FALSE
	return TRUE

/obj/item/card/id/data
	name = "身份全息徽章"
	desc = "一个普通的、批量生产的全息徽章。"
	icon_state = "data"
	item_state = "card-id"

/obj/item/card/id/lanyard
	name = "身份识别全息挂绳"
	desc = "一个粗糙的全息挂绳。廉价至极。"
	icon_state = "lanyard"
	item_state = "lanyard"

/obj/item/card/id/silver
	name = "身份全息徽章"
	desc = "一个镀银的全息徽章，象征着荣誉与奉献。"
	icon_state = "silver"
	item_state = "silver_id"

/obj/item/card/id/silver/clearance_badge
	name = "公司医生徽章"
	desc = "一个公司全息徽章。采用指纹锁定，拥有3级权限。通常由公司医生持有。"
	icon_state = "clearance"
	item_state = "silver_id"

/obj/item/card/id/silver/clearance_badge/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/wy)

/obj/item/card/id/silver/clearance_badge/scientist
	name = "公司科学家徽章"
	desc = "一个公司全息徽章。采用指纹锁定，拥有4级权限。通常由公司科学家持有。"

/obj/item/card/id/silver/clearance_badge/cl
	name = "公司联络官徽章"
	desc = "一个独特的公司橙白配色全息徽章。采用指纹锁定，拥有5级权限。通常由公司联络官持有。"
	icon_state = "cl"
	item_state = "cl_id"

/obj/item/card/id/silver/clearance_badge/manager
	name = "公司经理徽章"
	desc = "一个标准的公司橙白配色全息徽章。底部设计独特，未封口。采用指纹锁定，拥有5-X级权限。通常由公司经理持有。"
	icon_state = "pmc"
	item_state = "cl_id"

/obj/item/card/id/pizza
	name = "披萨送货员徽章"
	desc = "上面写着：'披萨送货员地方工会第217号'，'使命必达！'"
	icon_state = "pizza"
	item_state = "card-id"

/obj/item/card/id/souto
	name = "索托人"
	desc = "上面写着：'独一无二！'"
	icon_state = "gold"
	item_state = "gold_id"

/obj/item/card/id/souto/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/souta)

/obj/item/card/id/gold
	name = "身份全息徽章"
	desc = "一个镀金的全息徽章，象征着权力与力量。"
	icon_state = "gold"
	item_state = "gold_id"

/obj/item/card/id/visa
	name = "破旧的维萨卡"
	desc = "一个公司全息徽章。采用独特的公司橙白配色。"
	id_type = "Document"
	icon_state = "visa"

/obj/item/card/id/silver/cl
	name = "公司全息徽章"
	desc = "一个公司全息徽章。采用独特的公司橙白配色。"
	icon_state = "cl"
	item_state = "cl_id"

/obj/item/card/id/silver/cl/Initialize()
	. = ..()
	if(istype(src, /obj/item/card/id/silver/cl/hyperdyne))
		AddElement(/datum/element/corp_label/hyperdyne)
	else
		AddElement(/datum/element/corp_label/wy)

/obj/item/card/id/silver/cl/hyperdyne
	name = "公司全息徽章"
	desc = "一个公司全息徽章。采用独特的公司橙黑配色。"
	icon_state = "hyperdyne"

/obj/item/card/id/gold/council
	name = "身份全息徽章"
	desc = "一个真正的青铜镀金上校全息徽章。象征着尊重与权威，也是个绝佳的镇纸。"
	icon_state = "commodore"
	item_state = "commodore_id"

/obj/item/card/id/pmc
	name = "\improper PMC holo-badge"
	desc = "一个公司全息徽章。底部设计独特，未封口。"
	icon_state = "pmc"
	item_state = "cl_id"
	registered_name = "The Weyland-Yutani Corporation"
	assignment = "Corporate Mercenary"

/obj/item/card/id/pmc/New()
	access = get_access(ACCESS_LIST_WY_ALL)
	AddElement(/datum/element/corp_label/wy)
	..()

/obj/item/card/id/pmc/commando
	name = "\improper W-Y Commando holo-badge"
	assignment = "公司突击队员"
	icon_state = "commando"

/obj/item/card/id/pmc/ds
	name = "\improper Corporate holo-badge"
	desc = "上面列有一个呼号和一个序列号。仅发放给“白化”协议小队。"
	icon_state = "ds"
	item_state = "ds_id"

/obj/item/card/id/marshal
	name = "\improper CMB marshal gold badge"
	desc = "一枚令人垂涎的金色徽章，标志着佩戴者是少数在外围巡逻的CMB执法官之一。它是正义、权威与保护的象征。保护那些无力自保之人。这枚徽章代表着对誓言的恪守不渝。"
	icon_state = "cmbmar"
	id_type = "Badge"
	item_state = "cmbmar"
	paygrade = PAY_SHORT_CMBM

/obj/item/card/id/deputy
	name = "\improper CMB deputy silver badge"
	desc = "这枚银色徽章代表佩戴者是CMB副执法官。它是正义、权威与保护的象征。保护那些无力自保之人。这枚徽章代表着对誓言的恪守不渝。"
	icon_state = "cmbdep"
	id_type = "Badge"
	item_state = "cmbdep"
	paygrade = PAY_SHORT_CMBD

/obj/item/card/id/deputy/riot
	name = "\improper CMB riot officer silver badge"
	desc = "这枚银色徽章代表佩戴者是CMB防暴控制官。它是正义、权威与保护的象征。保护那些无力自保之人。这枚徽章代表着对誓言的恪守不渝。"
	paygrade = PAY_SHORT_CMBR

/obj/item/card/id/nspa_silver
	name = "\improper NSPA silver badge"
	desc = "这枚银色徽章代表佩戴者是NSPA警员。它是正义、权威与保护的象征。保护那些无力自保之人。这枚徽章代表着对誓言的恪守不渝。"
	icon_state = "nspa_silver"
	id_type = "Badge"
	item_state = "silver_id"
	paygrade = PAY_SHORT_CST

/obj/item/card/id/nspa_silver_gold
	name = "\improper NSPA silver & gold badge"
	desc = "这枚镶有金边的银色徽章代表佩戴者是NSPA高级警员至中士。它是正义、权威与保护的象征。保护那些无力自保之人。这枚徽章代表着对誓言的恪守不渝。"
	icon_state = "nspa_silverandgold"
	id_type = "Badge"
	item_state = "silver_id"
	paygrade = PAY_SHORT_SGT

/obj/item/card/id/nspa_gold
	name = "\improper NSPA gold badge"
	desc = "一枚金色徽章，标志着佩戴者是NSPA的高级官员，通常是督察及以上级别。它是正义、权威与保护的象征。保护那些无力自保之人。这枚徽章代表着对誓言的恪守不渝。"
	icon_state = "nspa_gold"
	id_type = "Badge"
	item_state = "gold_id"
	paygrade = PAY_SHORT_CINSP

/obj/item/card/id/PaP
	name = "PaP身份全息徽章"
	desc = "UPP人民武装警察内部人员的标准制式全息徽章。显示官员的军衔和所属单位。"
	icon_state = "data"
	paygrade = PAY_SHORT_PAP_MLTS

/obj/item/card/id/PaP/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/norcomm)

/obj/item/card/id/general
	name = "将官全息徽章"
	desc = "精英中的精英。仅授予最忠诚奉献之人。"
	icon_state = "general"
	item_state = "general_id"
	registered_name = "The United States Colonial Marines"
	assignment = "High Command Officer"

/obj/item/card/id/general/New()
	access = get_access(ACCESS_LIST_MARINE_ALL)

/obj/item/card/id/provost
	name = "宪兵长全息徽章"
	desc = "发放给宪兵长办公室成员。"
	icon_state = "provost"
	item_state = "provost_id"
	registered_name = "United States Colonial Marines Provost Office"
	assignment = "Provost Staff"

/obj/item/card/id/provost/New()
	access = get_access(ACCESS_LIST_MARINE_ALL)

/obj/item/card/id/adaptive
	name = "特工卡"
	access = list(ACCESS_ILLEGAL_PIRATE)

/obj/item/card/id/adaptive/silver
	icon_state = "silver"
	item_state = "silver_id"

/obj/item/card/id/adaptive/gold
	icon_state = "gold"
	item_state = "gold_id"

/obj/item/card/id/adaptive/New(mob/user as mob)
	..()
	if(!QDELETED(user)) // Runtime prevention on laggy starts or where users log out because of lag at round start.
		registered_name = ishuman(user) ? user.real_name : "未知"
	assignment = "Agent"
	name = "[registered_name]的[id_type] ([assignment])"

/obj/item/card/id/adaptive/afterattack(obj/item/O as obj, mob/user as mob, proximity)
	if(!proximity)
		return
	if(istype(O, /obj/item/card/id))
		var/obj/item/card/id/target_id = O
		access |= target_id.access
		if(ishuman(user))
			to_chat(user, SPAN_NOTICE("当你将卡片划过身份卡时，其微型扫描器激活，复制了后者的权限。"))

/obj/item/card/id/adaptive/attack_self(mob/user as mob)
	switch(alert("你想要显示这张身份卡，还是重命名它？","Choose.","Rename","显示"))
		if("Rename")
			var/new_name = strip_html(input(user, "你想在这张卡上填写什么名字？", "Agent card name", ishuman(user) ? user.real_name : user.name),26)
			if(!new_name || new_name == "未知" || new_name == "floor" || new_name == "wall" || new_name == "r-wall") //Same as mob/new_player/prefrences.dm
				to_chat(user, SPAN_WARNING("无效姓名。"))
				return

			var/new_job = strip_html(input(user, "你想在这张卡上填写什么职务？\n注意：这不会授予除维护权限外的任何访问级别。", "Agent card job assignment", "Assistant"))
			if(!new_job)
				to_chat(user, SPAN_WARNING("无效职务。"))
				return

			var/new_rank = strip_html(input(user, "你想在这张卡上填写什么薪级？\n注意：必须是薪级的缩写形式，例如CIV代表平民，ME1代表陆战队列兵。", "Agent card paygrade assignment", PAY_SHORT_CIV))
			if(!new_rank || !(new_rank in GLOB.paygrades))
				to_chat(user, SPAN_WARNING("无效薪级。"))
				return

			registered_name = new_name
			assignment = new_job
			name = "[registered_name]的[id_type] ([assignment])"
			paygrade = new_rank
			to_chat(user, SPAN_NOTICE("你成功伪造了身份卡。"))
			return
	..()

/obj/item/card/id/captains_spare
	name = "上尉的备用身份卡"
	desc = "至高领主本人的备用身份卡。"
	icon_state = "gold"
	item_state = "gold_id"
	registered_name = "上尉"
	assignment = "上尉"

/obj/item/card/id/captains_spare/New()
	access = get_access(ACCESS_LIST_MARINE_ALL)
	..()

/obj/item/card/id/centcom
	name = "\improper CentCom. ID"
	desc = "一份直接来自中央司令部的身份卡。"
	icon_state = "centcom"
	registered_name = "Central Command"
	assignment = "将军"

/obj/item/card/id/centcom/New()
	access = get_access(ACCESS_LIST_WY_ALL)
	..()


/obj/item/card/id/equipped(mob/living/carbon/human/H, slot)
	if(istype(H))
		H.update_inv_head() //updating marine helmet squad coloring
		H.update_inv_wear_suit()
	..()

/obj/item/card/id/dropped(mob/user)
	if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		H.update_inv_head() //Don't do a full update yet
		H.update_inv_wear_suit()
	..()



/obj/item/card/id/dogtag
	name = "狗牌"
	desc = "一名陆战队员的狗牌。"
	icon_state = "dogtag"
	item_state = "dogtag"
	id_type = "Dogtags"
	pinned_on_uniform = FALSE
	var/tags_taken_icon = "dogtag_taken"
	var/infotag_type = /obj/item/dogtag
	var/dogtag_taken = FALSE


/obj/item/card/id/dogtag/get_examine_text(mob/user)
	. = ..()
	if(ishuman(user))
		. += SPAN_NOTICE("It reads \"[registered_name] - [assignment] - [blood_type]\"")

/obj/item/card/id/dogtag/upp
	name = "UPP狗牌"
	desc = "一名士兵的狗牌。"
	icon_state = "dogtag_upp"
	tags_taken_icon = "dogtag_upp_taken"

/obj/item/dogtag
	name = "信息身份牌"
	desc = "一名阵亡陆战队员的信息狗牌。"
	icon_state = "dogtag_taken"
	icon = 'icons/obj/items/card.dmi'
	w_class = SIZE_TINY
	var/list/fallen_references
	var/list/fallen_names
	var/list/fallen_blood_types
	var/list/fallen_assgns

/obj/item/dogtag/Initialize()
	. = ..()

	fallen_references = list()
	fallen_names = list()
	fallen_blood_types = list()
	fallen_assgns = list()

/obj/item/dogtag/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/dogtag))
		var/obj/item/dogtag/D = I
		to_chat(user, SPAN_NOTICE("你加入了[length(fallen_names)>1 ? "tags":"two tags"] together."))
		name = "信息狗牌"
		if(D.fallen_names)
			fallen_references += D.fallen_references
			fallen_names += D.fallen_names
			fallen_blood_types += D.fallen_blood_types
			fallen_assgns += D.fallen_assgns
		qdel(D)
		return TRUE
	else
		. = ..()

/obj/item/dogtag/get_examine_text(mob/user)
	. = ..()
	if(ishuman(user) && LAZYLEN(fallen_names))
		var/msg = "There [length(fallen_names)>1 ? \
			"are [length(fallen_names)] tags.<br>They read":\
			"is one ID tag.<br>It reads"]:"
		for (var/i=1 to length(fallen_names))
			msg += "<br>[i]. \"[fallen_names[i]] - [fallen_assgns[i]] - [fallen_blood_types[i]]\""
		. += SPAN_NOTICE("[msg]")

// Used to authenticate to CORSAT machines. Doesn't do anything except have its type variable
/obj/item/card/data/corsat
	name = "CORSAT管理代码"
	desc = "一张数据盘，内含解除生物危害封锁所需的CORSAT管理认证代码之一。"
	icon_state = "data"
	item_state = "card-id"
	unacidable = 1

/obj/item/card/data/prison
	name = "监狱封锁管理代码"
	desc = "一张数据盘，内含解除空间站安全封锁所需的监狱管理认证代码之一。"
	icon_state = "data"
	item_state = "card-id"
	unacidable = 1
