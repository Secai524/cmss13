/datum/law/civilian_law/terror_association
	name = "恐怖组织关联"
	desc = "身为恐怖组织成员，或向恐怖组织成员提供援助。"
	brig_time = PERMABRIG_SENTENCE
	conditions = "Not applicable if the defendant has engaged in terror attacks. Not applicable for execution on its own."

/datum/law/civilian_law/terrorism
	name = "恐怖主义"
	desc = "对美国或其盟国实施恐怖袭击。"
	brig_time = PERMABRIG_SENTENCE
	conditions = "Not applicable if the defendant has not engaged in terror attacks."

/datum/law/civilian_law/minor_civil_insubordination
	name = "轻微民事抗命"
	desc = "未能服从所属部门（如有）成员发出的合法命令。亦适用于对指挥官或值班军官不敬。"
	brig_time = 5
	conditions = "Only Applicable to Non-USCM personnel."

/datum/law/civilian_law/major_civil_insubordination
	name = "严重民事抗命"
	desc = "在军事行动期间，未能服从指挥官、值班军官（或所属部门主管，如有）的合法命令。"
	brig_time = 10
	conditions = "Only Applicable to Non-USCM personnel."

/datum/law/civilian_law/black_marketeering
	name = "黑市交易"
	desc = "非法获取或销售受管制产品，不包括枪支或爆炸物。"
	brig_time = 7.5
	conditions = "Enforced by Civil Authorities such as the CMB."
	special_punishment = "Confiscation of Contraband"

/datum/law/civilian_law/arms_dealing
	name = "军火交易"
	desc = "非法获取或出售枪支或爆炸物。"
	brig_time = 15
	conditions = "Enforced by Civil Authorities such as the CMB."
	special_punishment = "Confiscation of Contraband"
