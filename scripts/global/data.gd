extends Node

func getCharacterByPosition(position:int) -> Dictionary:
	var name:String = ""
	var health:int = 0
	var type:Enums.CLASSES = Enums.CLASSES.NONE
	var attack:int = 0
	var defence:int = 0
	var strength:int = 0
	var luck:int = 0
	var agility:int = 0
	var intelligence:int = 0
	var rules:Array = []
	
	if position == 0:
		health = CHARACTER_1_HEALTH_CURRENT
		type = CHARACTER_1_TYPE
		name = CHARACTER_1_NAME
		attack = CHARACTER_1_STRENGTH
		defence = 1
		strength = CHARACTER_1_STRENGTH
		agility = CHARACTER_1_AGILITY
		intelligence = CHARACTER_1_INTELLIGENCE
		luck = CHARACTER_1_LUCK
		rules = CHARACTER_1_RULES
	elif position == 1:
		health = CHARACTER_2_HEALTH_CURRENT
		type = CHARACTER_2_TYPE
		name = CHARACTER_2_NAME
		attack = CHARACTER_2_STRENGTH
		defence = 1
		strength = CHARACTER_2_STRENGTH
		agility = CHARACTER_2_AGILITY
		intelligence = CHARACTER_2_INTELLIGENCE
		luck = CHARACTER_2_LUCK
		rules = CHARACTER_2_RULES
	elif position == 2:
		health = CHARACTER_3_HEALTH_CURRENT
		type = CHARACTER_3_TYPE
		name = CHARACTER_3_NAME
		attack = CHARACTER_3_STRENGTH
		defence = 1
		strength = CHARACTER_3_STRENGTH
		agility = CHARACTER_3_AGILITY
		intelligence = CHARACTER_3_INTELLIGENCE
		luck = CHARACTER_3_LUCK
		rules = CHARACTER_3_RULES
	else:
		health = CHARACTER_4_HEALTH_CURRENT
		type = CHARACTER_4_TYPE
		name = CHARACTER_4_NAME
		attack = CHARACTER_4_STRENGTH
		defence = 1
		strength = CHARACTER_4_STRENGTH
		agility = CHARACTER_4_AGILITY
		intelligence = CHARACTER_4_INTELLIGENCE
		luck = CHARACTER_4_LUCK
		rules = CHARACTER_4_RULES
	
	return {
		"name": name,
		"health": health,
		"type": type,
		"attack": attack,
		"defence": defence,
		"strength": strength,
		"agility": agility,
		"intelligence": intelligence,
		"luck": luck,
		"rules": rules
	}
		
		

var PARTY_CURRENT_ROOM:Enums.MAPS = Enums.MAPS.NONE
var PARTY_X:int = 0
var PARTY_Y:int = 0
var SYSTEM_LOG_BATTLE:bool = true
var SYSTEM_LOG_MAP:bool = true
var SYSTEM_LOG_NPC:bool = true

var CHARACTER_1_TYPE:Enums.CLASSES = Enums.CLASSES.NONE
var CHARACTER_1_NAME:String = ""
var CHARACTER_1_LV:int = 1
var CHARACTER_1_XP:int = 0
var CHARACTER_1_XP_NEXT:int = 0
var CHARACTER_1_HEALTH_CURRENT:int = 0
var CHARACTER_1_HEALTH_MAX:int = 0
var CHARACTER_1_MAGIC_CURRENT:int = 0
var CHARACTER_1_MAGIC_MAX:int = 0
var CHARACTER_1_STRENGTH:int = 0
var CHARACTER_1_AGILITY:int = 0
var CHARACTER_1_INTELLIGENCE:int = 0
var CHARACTER_1_LUCK:int = 0
var CHARACTER_1_RULES:Array = [
	{
		"rule": Enums.RULE.SELF_HP_LT_10,
		"action": Enums.ACTION.USE_POTION
	},{
		"rule": Enums.RULE.ALWAYS,
		"action": Enums.ACTION.ATTACK
	}
]

var CHARACTER_2_TYPE:Enums.CLASSES = Enums.CLASSES.NONE
var CHARACTER_2_NAME:String = ""
var CHARACTER_2_LV:int = 1
var CHARACTER_2_XP:int = 0
var CHARACTER_2_XP_NEXT:int = 0
var CHARACTER_2_HEALTH_CURRENT:int = 0
var CHARACTER_2_HEALTH_MAX:int = 0
var CHARACTER_2_MAGIC_CURRENT:int = 0
var CHARACTER_2_MAGIC_MAX:int = 0
var CHARACTER_2_STRENGTH:int = 0
var CHARACTER_2_AGILITY:int = 0
var CHARACTER_2_INTELLIGENCE:int = 0
var CHARACTER_2_LUCK:int = 0
var CHARACTER_2_RULES:Array = [
	{
		"rule": Enums.RULE.SELF_HP_LT_10,
		"action": Enums.ACTION.USE_POTION
	},{
		"rule": Enums.RULE.ALWAYS,
		"action": Enums.ACTION.ATTACK
	}
]

var CHARACTER_3_TYPE:Enums.CLASSES = Enums.CLASSES.NONE
var CHARACTER_3_NAME:String = ""
var CHARACTER_3_LV:int = 1
var CHARACTER_3_XP:int = 0
var CHARACTER_3_XP_NEXT:int = 0
var CHARACTER_3_HEALTH_CURRENT:int = 0
var CHARACTER_3_HEALTH_MAX:int = 0
var CHARACTER_3_MAGIC_CURRENT:int = 0
var CHARACTER_3_MAGIC_MAX:int = 0
var CHARACTER_3_STRENGTH:int = 0
var CHARACTER_3_AGILITY:int = 0
var CHARACTER_3_INTELLIGENCE:int = 0
var CHARACTER_3_LUCK:int = 0
var CHARACTER_3_RULES:Array = [
	{
		"rule": Enums.RULE.SELF_HP_LT_10,
		"action": Enums.ACTION.USE_POTION
	},{
		"rule": Enums.RULE.ALWAYS,
		"action": Enums.ACTION.ATTACK
	}
]

var CHARACTER_4_TYPE:Enums.CLASSES = Enums.CLASSES.NONE
var CHARACTER_4_NAME:String = ""
var CHARACTER_4_LV:int = 1
var CHARACTER_4_XP:int = 0
var CHARACTER_4_XP_NEXT:int = 0
var CHARACTER_4_HEALTH_CURRENT:int = 0
var CHARACTER_4_HEALTH_MAX:int = 0
var CHARACTER_4_MAGIC_CURRENT:int = 0
var CHARACTER_4_MAGIC_MAX:int = 0
var CHARACTER_4_STRENGTH:int = 0
var CHARACTER_4_AGILITY:int = 0
var CHARACTER_4_INTELLIGENCE:int = 0
var CHARACTER_4_LUCK:int = 0
var CHARACTER_4_RULES:Array = [
	{
		"rule": Enums.RULE.SELF_HP_LT_10,
		"action": Enums.ACTION.USE_POTION
	},{
		"rule": Enums.RULE.ALWAYS,
		"action": Enums.ACTION.ATTACK
	}
]

var ENEMIES:Array = [

]
