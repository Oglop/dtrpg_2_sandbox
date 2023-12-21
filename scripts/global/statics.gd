extends Node

var GAME_VERSION:String = "1.0.0"
var SAVE_FILE_SLOT_1_PATH:String = "slot_1"
var SAVE_FILE_SLOT_2_PATH:String = "slot_2"
var SAVE_FILE_SLOT_3_PATH:String = "slot_3"
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
		"EQUIP_TYPES": [ Enums.ITEM_TYPES.WEAPON_SWORD, Enums.ITEM_TYPES.ARMOR_HEAVY ],
		"RULES": [
			{
				"rule": Enums.RULE.SELF_HP_LT_20,
				"action": Enums.ACTION.USE_POTION_SELF
			},
			{
				"rule": Enums.RULE.ALWAYS,
				"action": Enums.ACTION.ATTACK
			},
			{
				"rule": Enums.RULE.NONE,
				"action": Enums.ACTION.NONE
			}
		],
		"AVAILABLE_RULES": [
			Enums.RULE.SELF_HP_LT_20,
			Enums.RULE.SELF_HP_LT_50,
			Enums.RULE.SELF_HP_GT_50,
			Enums.RULE.ALLY_HP_LT_20,
			Enums.RULE.ALWAYS,
			Enums.RULE.ALLY_DEAD
		],
		"AVAILABLE_ACTIONS": [
			Enums.ACTION.ATTACK,
			Enums.ACTION.DEFEND,
			Enums.ACTION.USE_POTION_SELF,
			Enums.ACTION.USE_POTION_ALLY,
			Enums.ACTION.USE_ELEXIR_ALLY
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
		"EQUIP_TYPES": [ Enums.ITEM_TYPES.WEAPON_SPEAR, Enums.ITEM_TYPES.ARMOR_HEAVY ],
		"RULES": [
			{
				"rule": Enums.RULE.ALLY_HP_LT_20,
				"action": Enums.ACTION.PROTECT
			},
			{
				"rule": Enums.RULE.ALWAYS,
				"action": Enums.ACTION.ATTACK
			},
			{
				"rule": Enums.RULE.NONE,
				"action": Enums.ACTION.NONE
			}
		],
		"AVAILABLE_RULES": [
			Enums.RULE.SELF_HP_LT_20,
			Enums.RULE.SELF_HP_LT_50,
			Enums.RULE.SELF_HP_GT_50,
			Enums.RULE.ALLY_HP_LT_20,
			Enums.RULE.ALWAYS,
			Enums.RULE.ALLY_DEAD
		],
		"AVAILABLE_ACTIONS": [
			Enums.ACTION.ATTACK,
			Enums.ACTION.DEFEND,
			Enums.ACTION.PROTECT,
			Enums.ACTION.USE_POTION_SELF,
			Enums.ACTION.USE_POTION_ALLY,
			Enums.ACTION.USE_ELEXIR_ALLY
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
		"EQUIP_TYPES": [ Enums.ITEM_TYPES.WEAPON_STAFF, Enums.ITEM_TYPES.ARMOR_LIGHT ],
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
				"rule": Enums.RULE.SELF_HP_LT_20,
				"action": Enums.ACTION.ATTACK
			}
		],
		"AVAILABLE_RULES": [
			Enums.RULE.SELF_HP_LT_20,
			Enums.RULE.SELF_MP_LT_20,
			Enums.RULE.SELF_MP_LT_10,
			Enums.RULE.SELF_HP_GT_50,
			Enums.RULE.ALLY_MP_GT_20,
			Enums.RULE.ALWAYS
		],
		"AVAILABLE_ACTIONS": [
			Enums.ACTION.USE_HERB_SELF,
			Enums.ACTION.USE_HERB_ALLY,
			Enums.ACTION.CAST_FIREBALL,
			Enums.ACTION.ATTACK,
			Enums.ACTION.USE_POTION_SELF,
			Enums.ACTION.DEFEND,
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
		"EQUIP_TYPES": [ Enums.ITEM_TYPES.WEAPON_RANGED, Enums.ITEM_TYPES.ARMOR_LIGHT ],
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
		],
		"AVAILABLE_RULES": [
			Enums.RULE.ALLY_HP_LT_20,
			Enums.RULE.ALLY_MP_LT_20,
			Enums.RULE.ALLY_DEAD,
			Enums.RULE.SELF_HP_GT_50,
			Enums.RULE.SELF_MP_LT_20,
			Enums.RULE.ALWAYS
		],
		"AVAILABLE_ACTIONS": [
			Enums.ACTION.CAST_HEAL,
			Enums.ACTION.USE_ELEXIR_ALLY,
			Enums.ACTION.USE_HERB_ALLY,
			Enums.ACTION.ATTACK,
			Enums.ACTION.USE_POTION_SELF,
			Enums.ACTION.USE_POTION_ALLY
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
		"EQUIP_TYPES": [ Enums.ITEM_TYPES.WEAPON_SWORD, Enums.ITEM_TYPES.ARMOR_LIGHT ],
		"RULES": [
			{
				"rule": Enums.RULE.SELF_HP_GT_50,
				"action": Enums.ACTION.BACK_STAB
			},
			{
				"rule": Enums.RULE.ALLY_HP_GT_50,
				"action": Enums.ACTION.STEAL
			},
			{
				"rule": Enums.RULE.ALWAYS,
				"action": Enums.ACTION.ATTACK
			}
		],
		"AVAILABLE_RULES": [
			Enums.RULE.ALLY_HP_LT_10,
			Enums.RULE.SELF_HP_LT_50,
			Enums.RULE.SELF_HP_GT_50,
			Enums.RULE.SELF_HP_LT_10,
			Enums.RULE.ALLY_HP_GT_50,
			Enums.RULE.ALWAYS
		],
		"AVAILABLE_ACTIONS": [
			Enums.ACTION.ATTACK,
			Enums.ACTION.USE_POTION_SELF,
			Enums.ACTION.DEFEND,
			Enums.ACTION.USE_POTION_ALLY,
		],
		"ACTIONS_LEVEL": {
			"LV3": [ Enums.ACTION.STEAL ],
			"LV6": [ Enums.ACTION.BACK_STAB ]
		}
	},
	"CLERIC": {
		"HEALTH_BASE": 24,
		"HEALTH_GROWTH": Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"MAGIC_BASE": 12,
		"MAGIC_GROWTH": Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL,
		"STRENGTH_BASE":10,
		"STRENGTH_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.FLAT,
		"AGILITY_BASE":12,
		"AGILITY_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.SHARP,
		"INTELLIGENCE_BASE":14,
		"INTELLIGENCE_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.FLAT,
		"LUCK_BASE":4,
		"LUCK_GROWTH":Enums.CLASSES_ATTRIBUTE_GROWTH.SHARP,
		"EQUIP_TYPES": [ Enums.ITEM_TYPES.WEAPON_BLUNT, Enums.ITEM_TYPES.ARMOR_HEAVY ],
		"RULES": [
			{
				"rule": Enums.RULE.ALLY_DEAD,
				"action": Enums.ACTION.CAST_REVIVE
			},
			{
				"rule": Enums.RULE.ALLY_HP_LT_20,
				"action": Enums.ACTION.CAST_HEAL
			},
			{
				"rule": Enums.RULE.ALWAYS,
				"action": Enums.ACTION.ATTACK
			}
		],
		"AVAILABLE_RULES": [
			Enums.RULE.ALLY_DEAD,
			Enums.RULE.ALLY_HP_LT_20,
			Enums.RULE.ALLY_MP_LT_10,
			Enums.RULE.SELF_HP_LT_20,
			Enums.RULE.SELF_MP_LT_20,
			Enums.RULE.ALWAYS
		],
		"AVAILABLE_ACTIONS": [
			Enums.ACTION.USE_ELEXIR_ALLY,
			Enums.ACTION.CAST_HEAL,
			Enums.ACTION.CAST_REVIVE,
			Enums.ACTION.USE_HERB_ALLY,
			Enums.ACTION.USE_POTION_ALLY,
			Enums.ACTION.ATTACK
		]
	}
}

var SPELLS: Dictionary = {
	"HEAL": {
		"cost": 4,
		"effect": 8,
		"randomness": 5
	},
	"REVIVE": {
		"cost": 10,
		"effect": 4,
		"randomness": 3
	},
	"FIREBALL": {
		"cost": 2,
		"effect": 4,
		"randomness": 2
	},
	"LIGHTNING": {
		"cost": 4,
		"effect": 6,
		"randomness": 10
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
	"SHORT_BOW": {
		"type": Enums.ITEM_TYPES.WEAPON_RANGED,
		"name": "Short Bow",
		"value":6,
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
