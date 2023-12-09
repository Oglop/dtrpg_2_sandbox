extends Node

var SAVE_FILE_SLOT_1_PATH:String = "data://slot1.save"
var WINDOW_SIZE_X:int = 320
var WINDOW_SIZE_Y:int = 280
var MAP_SIZE:int = 256
var ROOM_SIZE:int = 16
var MOVE_SPEED_WAIT:float = 0.2
var FIGHT_WAIT:float = 1.0

var CLASSES_ATTRIBUTE_GROWTH_NONE:float = 0.0
var CLASSES_ATTRIBUTE_GROWTH_FLAT:float = 1.2
var CLASSES_ATTRIBUTE_GROWTH_NORMAL:float = 1.5
var CLASSES_ATTRIBUTE_GROWTH_SHARP:float = 1.8

var ROOM_STARTING_POSITIONS:Dictionary = {
	"devMap": {
		"x": 128,
		"y": 64
	}
}

var LEVEL_1_6_XP_BASE:int = 1.2
var LEVEL_7_12_XP_BASE:int = 2.2
var LEVEL_13_18_XP_BASE:int = 2.8
var LEVEL_19_26_XP_BASE:int = 3.4
var LEVEL_27_99_XP_BASE:int = 5.6

var CLASSES_ATRIBUTES:Dictionary = {
	"WARRIOR": {
		"HEALTH_BASE": 30,
		"HEALTH_GROWTH": Enums.CLASSES_ATTRIBUTE_GROWTH.SHARP,
		"MAGIC_BASE": 0,
		"MAGIC_GROWTH": Enums.CLASSES_ATTRIBUTE_GROWTH.NONE,
		"STRENGTH_BASE":16,
		"STRENGTH_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.SHARP,
		"AGILITY_BASE":12,
		"AGILITY_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"INTELLIGENCE_BASE":5,
		"INTELLIGENCE_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.FLAT,
		"LUCK_BASE":7,
		"LUCK_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"RULES": [
			{
				"rule": Enums.RULE.SELF_HP_LT_20,
				"action": Enums.ACTION.USE_POTION_SELF
			},
			{
				"rule": Enums.RULE.ALWAYS,
				"action": Enums.ACTION.ATTACK
			}
		]
	},
	"KNIGHT": {
		"HEALTH_BASE": 40,
		"HEALTH_GROWTH": Enums.CLASSES_ATTRIBUTE_GROWTH.SHARP,
		"MAGIC_BASE": 0,
		"MAGIC_GROWTH": Enums.CLASSES_ATTRIBUTE_GROWTH.NONE,
		"STRENGTH_BASE":12,
		"STRENGTH_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"AGILITY_BASE":12,
		"AGILITY_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"INTELLIGENCE_BASE":8,
		"INTELLIGENCE_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.FLAT,
		"LUCK_BASE":3,
		"LUCK_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.FLAT,
		"RULES": [
			{
				"rule": Enums.RULE.ALLY_HP_LT_20,
				"action": Enums.ACTION.PROTECT
			},
			{
				"rule": Enums.RULE.ALWAYS,
				"action": Enums.ACTION.ATTACK
			}
		]
	},
	"WIZARD": {
		"HEALTH_BASE": 16,
		"HEALTH_GROWTH": Enums.CLASSES_ATTRIBUTE_GROWTH.FLAT,
		"MAGIC_BASE": 42,
		"MAGIC_GROWTH": Enums.CLASSES_ATTRIBUTE_GROWTH.SHARP,
		"STRENGTH_BASE":4,
		"STRENGTH_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.FLAT,
		"AGILITY_BASE":8,
		"AGILITY_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"INTELLIGENCE_BASE":18,
		"INTELLIGENCE_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.SHARP,
		"LUCK_BASE":6,
		"LUCK_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.FLAT,
		"RULES": [
			{
				"rule": Enums.RULE.SELF_MP_LT_10,
				"action": Enums.ACTION.USE_HERB_SELF
			},
			{
				"rule": Enums.RULE.ALLY_MP_GT_20,
				"action": Enums.ACTION.CAST_FIREBALL
			},
			{
				"rule": Enums.RULE.ALWAYS,
				"action": Enums.ACTION.ATTACK
			}
		]
	},
	"HUNTER": {
		"HEALTH_BASE": 26,
		"HEALTH_GROWTH": Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"MAGIC_BASE": 14,
		"MAGIC_GROWTH": Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"STRENGTH_BASE":8,
		"STRENGTH_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"AGILITY_BASE":16,
		"AGILITY_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"INTELLIGENCE_BASE":12,
		"INTELLIGENCE_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.FLAT,
		"LUCK_BASE":8,
		"LUCK_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"RULES": [
			{
				"rule": Enums.RULE.SELF_HP_LT_20,
				"action": Enums.ACTION.USE_HERB_SELF
			},
			{
				"rule": Enums.RULE.ALLY_MP_LT_10,
				"action": Enums.ACTION.USE_HERB_ALLY
			},
			{
				"rule": Enums.RULE.ALWAYS,
				"action": Enums.ACTION.ATTACK
			}
		]
	},
	"THIEF": {
		"HEALTH_BASE": 18,
		"HEALTH_GROWTH": Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"MAGIC_BASE": 0,
		"MAGIC_GROWTH": Enums.CLASSES_ATTRIBUTE_GROWTH.NONE,
		"STRENGTH_BASE":13,
		"STRENGTH_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.FLAT,
		"AGILITY_BASE":15,
		"AGILITY_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.SHARP,
		"INTELLIGENCE_BASE":8,
		"INTELLIGENCE_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.FLAT,
		"LUCK_BASE":16,
		"LUCK_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.SHARP,
		"RULES": [
			{
				"rule": Enums.RULE.SELF_HP_LT_20,
				"action": Enums.ACTION.USE_HERB_SELF
			},
			{
				"rule": Enums.RULE.ALWAYS,
				"action": Enums.ACTION.ATTACK
			}
		]
	},
	"CLERIC": {
		"HEALTH_BASE": 24,
		"HEALTH_GROWTH": Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"MAGIC_BASE": 12,
		"MAGIC_GROWTH": Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"STRENGTH_BASE":10,
		"STRENGTH_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.FLAT,
		"AGILITY_BASE":112,
		"AGILITY_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.SHARP,
		"INTELLIGENCE_BASE":14,
		"INTELLIGENCE_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.FLAT,
		"LUCK_BASE":4,
		"LUCK_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.SHARP,
		"RULES": [
			{
				"rule": Enums.RULE.ALLY_DEAD,
				"action": Enums.ACTION.USE_ELEXIR_ALLY
			},
			{
				"rule": Enums.RULE.ALLY_HP_LT_20,
				"action": Enums.ACTION.USE_HERB_ALLY
			},
			{
				"rule": Enums.RULE.ALWAYS,
				"action": Enums.ACTION.ATTACK
			}
		]
	}
	
}

var ITEMS:Dictionary = {
	"POTION": {
		"type": Enums.ITEM_TYPES.CONSUMABLE,
		"name": "Potion",
		"value": 100,
		"magicValue": 0,
		"quantity":1
	},
	"ELIXIR": {
		"type": Enums.ITEM_TYPES.CONSUMABLE,
		"name": "Elixir",
		"value": 1,
		"magicValue": 0,
		"quantity": 1
	},
	"HERB": {
		"type": Enums.ITEM_TYPES.CONSUMABLE,
		"name": "Herb",
		"value": 80,
		"magicValue": 0,
		"quantity": 1
	},
	"SHORT_SWORD": {
		"type": Enums.ITEM_TYPES.WEAPON_SWORD,
		"name": "Short Sword",
		"value": 8,
		"magicValue": 0,
		"quantity": 1
	},
	"CLUB": {
		"type": Enums.ITEM_TYPES.WEAPON_BLUNT,
		"name": "Club",
		"value": 6,
		"magicValue": 0,
		"quantity": 1
	},
	"SPEAR": {
		"type": Enums.ITEM_TYPES.WEAPON_SPEAR,
		"name": "Spear",
		"value": 8,
		"magicValue": 0,
		"quantity": 1
	},
	"STAFF": {
		"type": Enums.ITEM_TYPES.WEAPON_STAFF,
		"name": "Staff",
		"value": 2,
		"magicValue": 5,
		"quantity": 1
	},
	"LEATHER_ARMOR": {
		"type": Enums.ITEM_TYPES.ARMOR_HEAVY,
		"name": "Leather armor",
		"value": 4,
		"magicValue": 2,
		"quantity": 1
	},
	"ROBE_ARMOR": {
		"type": Enums.ITEM_TYPES.ARMOR_LIGHT,
		"name": "Robe",
		"value": 2,
		"magicValue": 4,
		"quantity": 1
	}
}

var ENEMY_SPAWNS:Dictionary = {
	"GOBLIN": {
		"description": "A vile band of goblins.",
		"min":2,
		"max":5
	}
}

var ENEMY_STATS:Dictionary = {
	"GOBLIN": {
		"name": "Goblin",
		"crownsMin": 3,
		"crownsMax": 6,
		"xp":10,
		"health": 30,
		"attack": 10,
		"defence": 5,
		"itemDrop": "POTION",
		"itemDropRate":15
	}
}
