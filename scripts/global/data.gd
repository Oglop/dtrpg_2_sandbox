extends Node

func _ready():
	Events.connect("SET_GLOBAL_STATE", _on_setGlobalState)

func _on_setGlobalState(systemState:Enums.SYSTEM_GLOBAL_STATES) -> void:
	SYSTEM_STATE = systemState

var PARTY_CURRENT_ROOM:Enums.MAPS = Enums.MAPS.NONE
var PARTY_X:int = 0
var PARTY_Y:int = 0
var PARTY_CROWNS:int = 0
var PARTY_ITEMS:Array = []
var PARTY_KEY_ITEMS:Array = []

var SYSTEM_SELECTED_SAVE_SLOT:Enums.SAVE_SLOTS = Enums.SAVE_SLOTS.SLOT1
var SYSTEM_STATE:Enums.SYSTEM_GLOBAL_STATES = Enums.SYSTEM_GLOBAL_STATES.ON_MAP
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
var CHARACTER_1_EQUIPABLE:Array = []
var CHARACTER_1_RULES:Array = [
	{
		"rule": Enums.RULE.SELF_HP_LT_10,
		"action": Enums.ACTION.USE_POTION_SELF
	},{
		"rule": Enums.RULE.ALWAYS,
		"action": Enums.ACTION.ATTACK
	},{
		"rule": Enums.RULE.NONE,
		"action": Enums.ACTION.NONE
	}
]
var CHARACTER_1_WEAPON:Dictionary = {}
var CHARACTER_1_ARMOR:Dictionary = {}
var CHARACTER_1_ACCESSORY:Dictionary = {}

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
var CHARACTER_2_EQUIPABLE:Array = []
var CHARACTER_2_RULES:Array = [
	{
		"rule": Enums.RULE.SELF_HP_LT_10,
		"action": Enums.ACTION.USE_POTION_SELF
	},{
		"rule": Enums.RULE.ALWAYS,
		"action": Enums.ACTION.USE_POTION_SELF
	},{
		"rule": Enums.RULE.NONE,
		"action": Enums.ACTION.NONE
	}
]
var CHARACTER_2_WEAPON:Dictionary = {}
var CHARACTER_2_ARMOR:Dictionary = {}
var CHARACTER_2_ACCESSORY:Dictionary = {}

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
var CHARACTER_3_EQUIPABLE:Array = []
var CHARACTER_3_RULES:Array = [
	{
		"rule": Enums.RULE.SELF_HP_LT_10,
		"action": Enums.ACTION.USE_POTION_SELF
	},{
		"rule": Enums.RULE.ALWAYS,
		"action": Enums.ACTION.ATTACK
	},{
		"rule": Enums.RULE.NONE,
		"action": Enums.ACTION.NONE
	}
]
var CHARACTER_3_WEAPON:Dictionary = {}
var CHARACTER_3_ARMOR:Dictionary = {}
var CHARACTER_3_ACCESSORY:Dictionary = {}

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
var CHARACTER_4_EQUIPABLE:Array = []
var CHARACTER_4_RULES:Array = [
	{
		"rule": Enums.RULE.SELF_HP_LT_10,
		"action": Enums.ACTION.USE_POTION_SELF
	},{
		"rule": Enums.RULE.ALWAYS,
		"action": Enums.ACTION.ATTACK
	},{
		"rule": Enums.RULE.NONE,
		"action": Enums.ACTION.NONE
	}
]
var CHARACTER_4_WEAPON:Dictionary = {}
var CHARACTER_4_ARMOR:Dictionary = {}
var CHARACTER_4_ACCESSORY:Dictionary = {}

var ENEMIES:Array = [

]
