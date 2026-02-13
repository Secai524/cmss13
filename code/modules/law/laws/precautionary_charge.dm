/datum/law/precautionary_charge
	brig_time = PERMABRIG_SENTENCE
	conditions = "Not inclusive for execution criteria."

/datum/law/precautionary_charge/discretionary_arrest
	name = "酌情拘留"
	desc = "指挥官为行动或安全利益，可酌情使用此指控以任何理由拘留人员。此指控的持续时间可变，指挥官可随时赦免/撤销。"
	conditions = "Not inclusive for execution criteria. May only be appealed to the Acting Commander or Provost/USCM HC."

/datum/law/precautionary_charge/insanity
	name = "精神失常"
	desc = "行为方式表明肇事者神志不清。一旦确认其神志清醒，可解除此特定指控。除自杀/自杀未遂情况外，只有首席医疗官/合成人可宣布某人精神失常。"

/datum/law/precautionary_charge/prisoner_of_war
	name = "战俘"
	desc = "身为当前与美国殖民地海军陆战队敌对且被承认的合法派系成员。"
	conditions = "Execution is forbidden barring exceptional circumstances."
