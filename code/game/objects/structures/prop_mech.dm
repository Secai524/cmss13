/obj/structure/prop/mech
	icon = 'icons/obj/structures/props/mech.dmi'

/obj/structure/prop/mech/hydralic_clamp
	name = "液压夹具"
	icon_state = "mecha_clamp"

/obj/structure/prop/mech/drill
	name = "钻头"
	desc = "这就是能刺穿苍穹的钻头！"
	icon_state = "mecha_drill"

/obj/structure/prop/mech/armor_booster
	name = "护甲增强模块（近战武器）"
	desc = "增强外骨骼装甲对武装近战攻击的防御。需要能量运作。"
	icon_state = "mecha_abooster_ccw"

/obj/structure/prop/mech/repair_droid
	name = "维修机器人"
	desc = "自动维修机器人。扫描外骨骼损伤并进行修复。可修复几乎所有类型的外部或内部损伤。"
	icon_state = "repair_droid"

/obj/structure/prop/mech/tesla_energy_relay
	name = "能量中继器"
	desc = "从区域内任何可用电源通道无线汲取能量。性能指数相当低。"
	icon_state = "tesla"

/obj/structure/prop/mech/parts
	name = "机甲部件"
	flags_atom = FPRINT|CONDUCT

/obj/structure/prop/mech/parts/chassis
	name="机甲底盘"
	icon_state = "backbone"

// ripley to turn into P-1000 an Older version of the P-5000 to anchor it more into the lore...
/obj/structure/prop/mech/parts/chassis/ripley
	name = "P-1000底盘"
	icon_state = "ripley_chassis"
/obj/structure/prop/mech/parts/chassis/firefighter
	name = "消防员底盘"
	icon_state = "ripley_chassis"
/obj/structure/prop/mech/parts/ripley_torso
	name="P-1000躯干"
	desc="P-1000 APLU的躯干部分。包含动力单元、处理核心和生命维持系统。"
	icon_state = "ripley_harness"
/obj/structure/prop/mech/parts/ripley_left_arm
	name="P-1000左臂"
	desc="P-1000 APLU左臂。数据和电源接口与大多数外骨骼工具兼容。"
	icon_state = "ripley_l_arm"
/obj/structure/prop/mech/parts/ripley_right_arm
	name="P-1000右臂"
	desc="P-1000 APLU右臂。数据和电源接口与大多数外骨骼工具兼容。"
	icon_state = "ripley_r_arm"
/obj/structure/prop/mech/parts/ripley_left_leg
	name="P-1000左腿"
	desc="P-1000 APLU左腿。包含较为复杂的伺服驱动和平衡维持系统。"
	icon_state = "ripley_l_leg"
/obj/structure/prop/mech/parts/ripley_right_leg
	name="P-1000右腿"
	desc="P-1000 APLU右腿。包含较为复杂的伺服驱动和平衡维持系统。"
	icon_state = "ripley_r_leg"

//gygax turned into MAX (Mobile Assault Exo-Warrior)look like a gygax from afar
/obj/structure/prop/mech/parts/chassis/gygax
	name = "MAX底盘"
	icon_state = "gygax_chassis"
/obj/structure/prop/mech/parts/gygax_torso
	name="MAX躯干"
	desc="MAX的躯干部分。包含动力单元、处理核心和生命维持系统。拥有一个额外的装备插槽。"
	icon_state = "gygax_harness"
/obj/structure/prop/mech/parts/gygax_head
	name="MAX头部"
	desc="MAX头部。内置先进的监视和瞄准传感器。"
	icon_state = "gygax_head"
/obj/structure/prop/mech/parts/gygax_left_arm
	name="MAX左臂"
	desc="MAX左臂。数据和电源接口与大多数外骨骼工具和武器兼容。"
	icon_state = "gygax_l_arm"
/obj/structure/prop/mech/parts/gygax_right_arm
	name="MAX右臂"
	desc="MAX右臂。数据和电源接口与大多数外骨骼工具和武器兼容。"
	icon_state = "gygax_r_arm"
/obj/structure/prop/mech/parts/gygax_left_leg
	name="MAX左腿"
	icon_state = "gygax_l_leg"
/obj/structure/prop/mech/parts/gygax_right_leg
	name="MAX右腿"
	icon_state = "gygax_r_leg"
/obj/structure/prop/mech/parts/gygax_armor
	name="MAX装甲板"
	icon_state = "gygax_armor"

// durand MOX (mobile offensive exo-warrior) look like a durand from afar.
/obj/structure/prop/mech/parts/chassis/durand
	name = "MOX底盘"
	icon_state = "durand_chassis"
/obj/structure/prop/mech/parts/durand_torso
	name="MOX躯干"
	icon_state = "durand_harness"
/obj/structure/prop/mech/parts/durand_head
	name="MOX头部"
	icon_state = "durand_head"
/obj/structure/prop/mech/parts/durand_left_arm
	name="MOX左臂"
	icon_state = "durand_l_arm"
/obj/structure/prop/mech/parts/durand_right_arm
	name="MOX右臂"
	icon_state = "durand_r_arm"
/obj/structure/prop/mech/parts/durand_left_leg
	name="MOX左腿"
	icon_state = "durand_l_leg"
/obj/structure/prop/mech/parts/durand_right_leg
	name="MOX右腿"
	icon_state = "durand_r_leg"
/obj/structure/prop/mech/parts/durand_armor
	name="MOX装甲板"
	icon_state = "durand_armor"

// phazon currently not in use. could  be deleted...
/obj/structure/prop/mech/parts/chassis/phazon
	name = "Phazon底盘"
	icon_state = "phazon_chassis"
/obj/structure/prop/mech/parts/phazon_torso
	name="Phazon躯干"
	icon_state = "phazon_harness"
/obj/structure/prop/mech/parts/phazon_head
	name="Phazon头部"
	icon_state = "phazon_head"
/obj/structure/prop/mech/parts/phazon_left_arm
	name="Phazon左臂"
	icon_state = "phazon_l_arm"
/obj/structure/prop/mech/parts/phazon_right_arm
	name="Phazon右臂"
	icon_state = "phazon_r_arm"
/obj/structure/prop/mech/parts/phazon_left_leg
	name="法扎左腿"
	icon_state = "phazon_l_leg"
/obj/structure/prop/mech/parts/phazon_right_leg
	name="法扎右腿"
	icon_state = "phazon_r_leg"
/obj/structure/prop/mech/parts/phazon_armor_plates
	name="法扎护甲板"
	icon_state = "phazon_armor"

// odysseus currently not in use  could  be deleted...
/obj/structure/prop/mech/parts/chassis/odysseus
	name = "奥德修斯底盘"
	icon_state = "odysseus_chassis"
/obj/structure/prop/mech/parts/odysseus_head
	name="奥德修斯头部"
	icon_state = "odysseus_head"
/obj/structure/prop/mech/parts/odysseus_torso
	name="奥德修斯躯干"
	desc="奥德修斯的躯干部分。包含动力单元、处理核心和生命维持系统。"
	icon_state = "odysseus_torso"
/obj/structure/prop/mech/parts/odysseus_left_arm
	name="奥德修斯左臂"
	desc="奥德修斯左臂。数据和电源接口与大多数外骨骼工具兼容。"
	icon_state = "odysseus_l_arm"
/obj/structure/prop/mech/parts/odysseus_right_arm
	name="奥德修斯右臂"
	desc="奥德修斯右臂。数据和电源接口与大多数外骨骼工具兼容。"
	icon_state = "odysseus_r_arm"
/obj/structure/prop/mech/parts/odysseus_left_leg
	name="奥德修斯左腿"
	desc="奥德修斯左腿。包含较为复杂的伺服驱动和平衡维持系统。"
	icon_state = "odysseus_l_leg"
/obj/structure/prop/mech/parts/odysseus_right_leg
	name="奥德修斯右腿"
	desc="奥德修斯右腿。包含较为复杂的伺服驱动和平衡维持系统。"
	icon_state = "odysseus_r_leg"
/obj/structure/prop/mech/parts/odysseus_armor_plates
	name="奥德修斯护甲板"
	icon_state = "odysseus_armor"
