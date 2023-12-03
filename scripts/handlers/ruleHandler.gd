extends Node

func _ready():
	pass
	
func percentage(part:int, whole:int) -> int:
	if part == 0 || whole == 0:
		return 0
	return (part / whole) * 100

func validateRule(
	type:Enums.RULE,
	position:int) -> bool:
		
	var health:int = 0
	var healthMax:int = 0
	var magic:int = 0
	var magicMax:int = 0
	
	if position == 0:
		health = Data.CHARACTER_1_HEALTH_CURRENT
		healthMax = Data.CHARACTER_1_HEALTH_MAX
		magic = Data.CHARACTER_1_MAGIC_CURRENT
		magicMax = Data.CHARACTER_1_MAGIC_MAX
	elif position == 1:
		health = Data.CHARACTER_2_HEALTH_CURRENT
		healthMax = Data.CHARACTER_2_HEALTH_MAX
		magic = Data.CHARACTER_2_MAGIC_CURRENT
		magicMax = Data.CHARACTER_2_MAGIC_MAX
	elif position == 1:
		health = Data.CHARACTER_3_HEALTH_CURRENT
		healthMax = Data.CHARACTER_3_HEALTH_MAX
		magic = Data.CHARACTER_3_MAGIC_CURRENT
		magicMax = Data.CHARACTER_3_MAGIC_MAX
	else:
		health = Data.CHARACTER_4_HEALTH_CURRENT
		healthMax = Data.CHARACTER_4_HEALTH_MAX
		magic = Data.CHARACTER_4_MAGIC_CURRENT
		magicMax = Data.CHARACTER_4_MAGIC_MAX
		
	if type == Enums.RULE.ALWAYS:
		return true
	elif type == Enums.RULE.NEVER:
		return false
	elif type == Enums.RULE.SELF_HP_GT_50:
		return greaterThan(health, healthMax, 50)
	elif type == Enums.RULE.SELF_HP_GT_20:
		return greaterThan(health, healthMax, 20)
	elif type == Enums.RULE.SELF_HP_LT_80:
		return lessThan(health, healthMax, 80)
	elif type == Enums.RULE.SELF_HP_LT_50:
		return lessThan(health, healthMax, 50)
	elif type == Enums.RULE.SELF_HP_LT_20:
		return lessThan(health, healthMax, 20)
	elif type == Enums.RULE.SELF_HP_LT_10:
		return lessThan(health, healthMax, 10)
	elif type == Enums.RULE.SELF_MP_GT_20:
		return greaterThan(magic, magicMax, 20)
	elif type == Enums.RULE.SELF_MP_GT_50:
		return greaterThan(magic, magicMax, 50)
	elif type == Enums.RULE.SELF_MP_LT_80:
		return lessThan(magic, magicMax, 80)
	elif type == Enums.RULE.SELF_MP_LT_50:
		return lessThan(magic, magicMax, 50)
	elif type == Enums.RULE.SELF_MP_LT_20:
		return lessThan(magic, magicMax, 20)
	elif type == Enums.RULE.SELF_MP_LT_10:
		return lessThan(magic, magicMax, 10)
	elif type == Enums.RULE.ALLY_HP_GT_50:
		return allyGreaterThan(position, 50)
	elif type == Enums.RULE.ALLY_HP_GT_20:
		return allyGreaterThan(position, 20)
	elif type == Enums.RULE.ALLY_HP_LT_80:
		return allyLessThan(position, 80)
	elif type == Enums.RULE.ALLY_HP_LT_50:
		return allyLessThan(position, 50)
	elif type == Enums.RULE.ALLY_HP_LT_20:
		return allyLessThan(position, 20)
	elif type == Enums.RULE.ALLY_HP_LT_10:
		return allyLessThan(position, 10)
	elif type == Enums.RULE.ALLY_MP_GT_20:
		return allyGreaterThan(position, 20)
	elif type == Enums.RULE.ALLY_MP_GT_50:
		return allyGreaterThan(position, 50)
	elif type == Enums.RULE.ALLY_MP_LT_80:
		return allyLessThan(position, 80)
	elif type == Enums.RULE.ALLY_MP_LT_50:
		return allyLessThan(position, 50)
	elif type == Enums.RULE.ALLY_MP_LT_20:
		return allyLessThan(position, 20)
	elif type == Enums.RULE.ALLY_MP_LT_10:
		return allyLessThan(position, 10)
	elif type == Enums.RULE.ALLY_DEAD:
		return allyDead(position)
	return false


func greaterThan(part:int, whole:int, value:int) -> bool:
	if percentage(part, whole) >= value:
		return true
	else:
		return false
		
func allyGreaterThan(position:int, value:int) -> bool:
	if position == 0:
		return percentage(Data.CHARACTER_2_HEALTH_CURRENT, Data.CHARACTER_2_HEALTH_MAX) >= value || percentage(Data.CHARACTER_3_HEALTH_CURRENT, Data.CHARACTER_3_HEALTH_MAX) >= value || percentage(Data.CHARACTER_4_HEALTH_CURRENT, Data.CHARACTER_4_HEALTH_MAX) >= value
	elif position == 1:
		return percentage(Data.CHARACTER_1_HEALTH_CURRENT, Data.CHARACTER_1_HEALTH_MAX) >= value || percentage(Data.CHARACTER_3_HEALTH_CURRENT, Data.CHARACTER_3_HEALTH_MAX) >= value || percentage(Data.CHARACTER_4_HEALTH_CURRENT, Data.CHARACTER_4_HEALTH_MAX) >= value
	elif position == 2:
		return percentage(Data.CHARACTER_1_HEALTH_CURRENT, Data.CHARACTER_1_HEALTH_MAX) >= value || percentage(Data.CHARACTER_2_HEALTH_CURRENT, Data.CHARACTER_2_HEALTH_MAX) >= value || percentage(Data.CHARACTER_4_HEALTH_CURRENT, Data.CHARACTER_4_HEALTH_MAX) >= value
	else:
		return percentage(Data.CHARACTER_1_HEALTH_CURRENT, Data.CHARACTER_1_HEALTH_MAX) >= value || percentage(Data.CHARACTER_2_HEALTH_CURRENT, Data.CHARACTER_2_HEALTH_MAX) >= value || percentage(Data.CHARACTER_3_HEALTH_CURRENT, Data.CHARACTER_3_HEALTH_MAX) >= value
		
		
func allyLessThan(position:int, value:int) -> bool:
	if position == 0:
		return percentage(Data.CHARACTER_2_HEALTH_CURRENT, Data.CHARACTER_2_HEALTH_MAX) <= value || percentage(Data.CHARACTER_3_HEALTH_CURRENT, Data.CHARACTER_3_HEALTH_MAX) <= value || percentage(Data.CHARACTER_4_HEALTH_CURRENT, Data.CHARACTER_4_HEALTH_MAX) <= value
	elif position == 1:
		return percentage(Data.CHARACTER_1_HEALTH_CURRENT, Data.CHARACTER_1_HEALTH_MAX) <= value || percentage(Data.CHARACTER_3_HEALTH_CURRENT, Data.CHARACTER_3_HEALTH_MAX) <= value || percentage(Data.CHARACTER_4_HEALTH_CURRENT, Data.CHARACTER_4_HEALTH_MAX) <= value
	elif position == 2:
		return percentage(Data.CHARACTER_1_HEALTH_CURRENT, Data.CHARACTER_1_HEALTH_MAX) <= value || percentage(Data.CHARACTER_2_HEALTH_CURRENT, Data.CHARACTER_2_HEALTH_MAX) <= value || percentage(Data.CHARACTER_4_HEALTH_CURRENT, Data.CHARACTER_4_HEALTH_MAX) <= value
	else:
		return percentage(Data.CHARACTER_1_HEALTH_CURRENT, Data.CHARACTER_1_HEALTH_MAX) <= value || percentage(Data.CHARACTER_2_HEALTH_CURRENT, Data.CHARACTER_2_HEALTH_MAX) <= value || percentage(Data.CHARACTER_3_HEALTH_CURRENT, Data.CHARACTER_3_HEALTH_MAX) <= value
		
		
func lessThan(part:int, whole:int, value:int) -> bool:
	if percentage(part, whole) <= value:
		return true
	else:
		return false
		
func allyDead(position:int) -> bool:
	if position == 0:
		return Data.CHARACTER_2_HEALTH_CURRENT <= 0 || Data.CHARACTER_3_HEALTH_CURRENT <= 0 || Data.CHARACTER_4_HEALTH_CURRENT <= 0
	elif position == 1:
		return Data.CHARACTER_1_HEALTH_CURRENT <= 0 || Data.CHARACTER_3_HEALTH_CURRENT <= 0 || Data.CHARACTER_4_HEALTH_CURRENT <= 0
	elif position == 2:
		return Data.CHARACTER_1_HEALTH_CURRENT <= 0 || Data.CHARACTER_2_HEALTH_CURRENT <= 0 || Data.CHARACTER_4_HEALTH_CURRENT <= 0
	else:
		return Data.CHARACTER_1_HEALTH_CURRENT <= 0 || Data.CHARACTER_2_HEALTH_CURRENT <= 0 || Data.CHARACTER_3_HEALTH_CURRENT <= 0
