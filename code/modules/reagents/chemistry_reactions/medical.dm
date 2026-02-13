
/datum/chemical_reaction/tricordrazine
	name = "三合剂"
	id = "tricordrazine"
	result = "tricordrazine"
	required_reagents = list("inaprovaline" = 1, "anti_toxin" = 1)
	result_amount = 2
	mob_react = FALSE

/datum/chemical_reaction/adrenaline
	name = "肾上腺素"
	id = "adrenaline"
	result = "adrenaline"
	required_reagents = list("carbon" = 1, "nitrogen" = 1, "oxygen" = 1)
	result_amount = 2

/datum/chemical_reaction/alkysine
	name = "阿尔基辛"
	id = "alkysine"
	result = "alkysine"
	required_reagents = list("chlorine" = 1, "nitrogen" = 1, "anti_toxin" = 1)
	result_amount = 2

/datum/chemical_reaction/dexalin
	name = "地塞林"
	id = "dexalin"
	result = "dexalin"
	required_reagents = list("oxygen" = 2, "phoron" = 0.1)
	required_catalysts = list("phoron" = 5)
	result_amount = 1

/datum/chemical_reaction/dermaline
	name = "德玛林"
	id = "dermaline"
	result = "dermaline"
	required_reagents = list("oxygen" = 1, "phosphorus" = 1, "kelotane" = 1)
	result_amount = 3

/datum/chemical_reaction/meralyne
	name = "梅拉林"
	id = "meralyne"
	result = "meralyne"
	required_reagents = list("carbon" = 1, "water" = 1, "bicaridine" = 1)
	result_amount = 3

/datum/chemical_reaction/dexalinp
	name = "地塞林增效剂"
	id = "dexalinp"
	result = "dexalinp"
	required_reagents = list("dexalin" = 1, "carbon" = 1, "iron" = 1)
	result_amount = 3

/datum/chemical_reaction/bicaridine
	name = "碧卡利定"
	id = "bicaridine"
	result = "bicaridine"
	required_reagents = list("inaprovaline" = 1, "carbon" = 1)
	result_amount = 2

/datum/chemical_reaction/ryetalyn
	name = "莱特林"
	id = "ryetalyn"
	result = "ryetalyn"
	required_reagents = list("arithrazine" = 1, "carbon" = 1)
	result_amount = 2

/datum/chemical_reaction/cryoxadone
	name = "低温克赛酮"
	id = "cryoxadone"
	result = "cryoxadone"
	required_reagents = list("dexalin" = 1, "water" = 1, "oxygen" = 1)
	result_amount = 3

/datum/chemical_reaction/clonexadone
	name = "克隆克赛酮"
	id = "clonexadone"
	result = "clonexadone"
	required_reagents = list("cryoxadone" = 1, "sodium" = 1, "phoron" = 0.1)
	required_catalysts = list("phoron" = 5)
	result_amount = 2

/datum/chemical_reaction/spaceacillin
	name = "太空青霉素"
	id = "spaceacillin"
	result = "spaceacillin"
	required_reagents = list("cryptobiolin" = 1, "inaprovaline" = 1)
	result_amount = 2

/datum/chemical_reaction/imidazoline
	name = "imidazoline"
	id = "imidazoline"
	result = "imidazoline"
	required_reagents = list("carbon" = 1, "hydrogen" = 1, "anti_toxin" = 1)
	result_amount = 2

/datum/chemical_reaction/ethylredoxrazine
	name = "乙基红氧嗪"
	id = "ethylredoxrazine"
	result = "ethylredoxrazine"
	required_reagents = list("oxygen" = 1, "anti_toxin" = 1, "carbon" = 1)
	result_amount = 3

/datum/chemical_reaction/ethanoloxidation
	name = "ethanoloxidation" //Kind of a placeholder in case someone ever changes it so that chemicals
	id = "ethanoloxidation" // react in the body. Also it would be silly if it didn't exist.
	result = "water"
	required_reagents = list("ethylredoxrazine" = 1, "ethanol" = 1)
	result_amount = 2

/datum/chemical_reaction/sterilizine
	name = "灭菌灵"
	id = "sterilizine"
	result = "sterilizine"
	required_reagents = list("ethanol" = 1, "anti_toxin" = 1, "chlorine" = 1)
	result_amount = 3

/datum/chemical_reaction/inaprovaline
	name = "伊纳普罗瓦林"
	id = "inaprovaline"
	result = "inaprovaline"
	required_reagents = list("oxygen" = 1, "carbon" = 1, "sugar" = 1)
	result_amount = 3

/datum/chemical_reaction/anti_toxin
	name = "迪洛芬"
	id = "anti_toxin"
	result = "anti_toxin"
	required_reagents = list("silicon" = 1, "potassium" = 1, "nitrogen" = 1)
	result_amount = 3


/datum/chemical_reaction/tramadol
	name = "曲马多"
	id = "tramadol"
	result = "tramadol"
	required_reagents = list("inaprovaline" = 1, "ethanol" = 1, "oxygen" = 1)
	result_amount = 3

/datum/chemical_reaction/paracetamol
	name = "扑热息痛"
	id = "paracetamol"
	result = "paracetamol"
	required_reagents = list("tramadol" = 1, "nitrogen" = 1, "water" = 1)
	result_amount = 3

/datum/chemical_reaction/oxycodone
	name = "羟考酮"
	id = "oxycodone"
	result = "oxycodone"
	required_reagents = list("ethanol" = 1, "tramadol" = 1)
	required_catalysts = list("phoron" = 1)
	result_amount = 1

/datum/chemical_reaction/leporazine
	name = "莱波拉嗪"
	id = "leporazine"
	result = "leporazine"
	required_reagents = list("silicon" = 1, "copper" = 1)
	required_catalysts = list("phoron" = 5)
	result_amount = 2

/datum/chemical_reaction/arithrazine
	name = "阿瑞斯嗪"
	id = "arithrazine"
	result = "arithrazine"
	required_reagents = list("anti_toxin" = 1, "phosphorus" = 1)
	result_amount = 2

/datum/chemical_reaction/kelotane
	name = "凯洛坦"
	id = "kelotane"
	result = "kelotane"
	required_reagents = list("silicon" = 1, "carbon" = 1)
	result_amount = 2

/datum/chemical_reaction/peridaxon
	name = "培利达松"
	id = "peridaxon"
	result = "peridaxon"
	required_reagents = list("bicaridine" = 2, "clonexadone" = 2)
	required_catalysts = list("phoron" = 5)
	result_amount = 2

/datum/chemical_reaction/methylphenidate
	name = "哌甲酯"
	id = "methylphenidate"
	result = "methylphenidate"
	required_reagents = list("mindbreaker" = 1, "hydrogen" = 1)
	result_amount = 3

/datum/chemical_reaction/citalopram
	name = "西酞普兰"
	id = "citalopram"
	result = "citalopram"
	required_reagents = list("mindbreaker" = 1, "carbon" = 1)
	result_amount = 3

/datum/chemical_reaction/paroxetine
	name = "帕罗西汀"
	id = "paroxetine"
	result = "paroxetine"
	required_reagents = list("mindbreaker" = 1, "oxygen" = 1, "inaprovaline" = 1)
	result_amount = 3
