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

var LEVEL_1_6_XP_BASE:float = 1.2
var LEVEL_7_12_XP_BASE:float = 2.2
var LEVEL_13_18_XP_BASE:float = 2.8
var LEVEL_19_26_XP_BASE:float = 3.4
var LEVEL_27_99_XP_BASE:float = 5.6


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
		"EQUIP_TYPES": [ Enums.ITEM_TYPES.WEAPON_DAGGER, Enums.ITEM_TYPES.WEAPON_SWORD, Enums.ITEM_TYPES.ARMOR_HEAVY ],
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
		],
		"ACTIONS_LEVEL": {
			"LV1": [ Enums.ACTION.ATTACK, Enums.ACTION.DEFEND, Enums.ACTION.USE_POTION_SELF ],
			"LV2": [ Enums.ACTION.DOUBLE_STRIKE ]
		}
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
		"EQUIP_TYPES": [ Enums.ITEM_TYPES.WEAPON_DAGGER, Enums.ITEM_TYPES.WEAPON_SPEAR, Enums.ITEM_TYPES.ARMOR_HEAVY ],
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
		],
		"ACTIONS_LEVEL": {
			"LV1": [ Enums.ACTION.ATTACK, Enums.ACTION.USE_POTION_ALLY, Enums.ACTION.USE_POTION_SELF ],
			"LV2": [ Enums.ACTION.PROTECT ],
			"LV5": [ Enums.ACTION.PIERCE ]
		}
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
		"EQUIP_TYPES": [ Enums.ITEM_TYPES.WEAPON_DAGGER, Enums.ITEM_TYPES.WEAPON_STAFF, Enums.ITEM_TYPES.ARMOR_LIGHT ],
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
			},
			{
				"rule": Enums.RULE.NONE,
				"action": Enums.ACTION.NONE
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
		],
		"ACTIONS_LEVEL": {
			"LV1": [ Enums.ACTION.ATTACK, Enums.ACTION.CAST_FIREBALL, Enums.ACTION.USE_HERB_SELF ],
			"LV5": [ Enums.ACTION.LAVA_WAVE ]
		}
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
		"EQUIP_TYPES": [ Enums.ITEM_TYPES.WEAPON_DAGGER, Enums.ITEM_TYPES.WEAPON_RANGED, Enums.ITEM_TYPES.ARMOR_LIGHT ],
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
			},
			{
				"rule": Enums.RULE.NONE,
				"action": Enums.ACTION.NONE
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
		],
		"ACTIONS_LEVEL": {
			"LV1": [ Enums.ACTION.ATTACK, Enums.ACTION.USE_POTION_ALLY, Enums.ACTION.USE_ELEXIR_ALLY ],
			"LV3": [ Enums.ACTION.STUN ],
			"LV6": [ Enums.ACTION.POISON ],
			"LV12": [ Enums.ACTION.BARRAGE ]
		}
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
		"EQUIP_TYPES": [ Enums.ITEM_TYPES.WEAPON_DAGGER, Enums.ITEM_TYPES.WEAPON_SWORD, Enums.ITEM_TYPES.ARMOR_LIGHT ],
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
			},
			{
				"rule": Enums.RULE.NONE,
				"action": Enums.ACTION.NONE
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
			"LV1": [ Enums.ACTION.ATTACK, Enums.ACTION.DEFEND, Enums.ACTION.USE_POTION_SELF ],
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
		"EQUIP_TYPES": [ Enums.ITEM_TYPES.WEAPON_DAGGER, Enums.ITEM_TYPES.WEAPON_BLUNT, Enums.ITEM_TYPES.ARMOR_HEAVY ],
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
			},
			{
				"rule": Enums.RULE.NONE,
				"action": Enums.ACTION.NONE
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
		],
		"ACTIONS_LEVEL": {
			"LV1": [ Enums.ACTION.ATTACK, Enums.ACTION.USE_HERB_ALLY, Enums.ACTION.USE_ELEXIR_ALLY ],
			"LV4": [ Enums.ACTION.BLESS ],
			"LV6": [ Enums.ACTION.CAST_REVIVE ],
			"LV8": [ Enums.ACTION.HEAL_ALL ],
		}
	}
}

var SPELLS: Dictionary = {
	"HEAL": {
		"cost": 4,
		"effect": 8,
		"randomness": 5
	},
	"HEAL_MANY": {
		"cost": 8,
		"effect": 6,
		"randomness": 4
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
	},
	"LAVA_WAVE": {
		"cost": 9,
		"effect": 4,
		"randomness": 3
	}
}

var ITEMS:Dictionary = {
	"POTION": {
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.CONSUMABLE,
		"name": "Potion",
		"value": 100,
		"magicValue": 0,
		"quantity":1
	},
	"ELIXIR": {
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.CONSUMABLE,
		"name": "Elixir",
		"value": 1,
		"magicValue": 0,
		"quantity": 1
	},
	"HERB": {
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.CONSUMABLE,
		"name": "Herb",
		"value": 80,
		"magicValue": 0,
		"quantity": 1
	},
	"ANTIDOTE": {
		"purchaseble": true,
		"cost": 16,
		"type": Enums.ITEM_TYPES.CONSUMABLE,
		"name": "Antidote",
		"value": 1,
		"magicValue": 0,
		"quantity": 1
	},
	"SHORT_SWORD": {
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.WEAPON_SWORD,
		"name": "Short Sword",
		"value": 8,
		"magicValue": 0,
		"quantity": 1
	},
	"LONG_SWORD": {
		"purchaseble": true,
		"cost": 45,
		"type": Enums.ITEM_TYPES.WEAPON_SWORD,
		"name": "Long Sword",
		"value": 16,
		"magicValue": 0,
		"quantity": 1
	},
	"DAGGER": {
		"purchaseble": true,
		"cost": 8,
		"type": Enums.ITEM_TYPES.WEAPON_DAGGER,
		"name": "Club",
		"value": 3,
		"magicValue": 0,
		"quantity": 1
	},
	"CLUB": {
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.WEAPON_BLUNT,
		"name": "Club",
		"value": 6,
		"magicValue": 0,
		"quantity": 1
	},
	"MACE": {
		"purchaseble": true,
		"cost": 38,
		"type": Enums.ITEM_TYPES.WEAPON_BLUNT,
		"name": "MAce",
		"value": 14,
		"magicValue": 0,
		"quantity": 1
	},
	"SPEAR": {
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.WEAPON_SPEAR,
		"name": "Spear",
		"value": 8,
		"magicValue": 0,
		"quantity": 1
	},
	"LANCE": {
		"purchaseble": true,
		"cost": 40,
		"type": Enums.ITEM_TYPES.WEAPON_SPEAR,
		"name": "Lance",
		"value": 16,
		"magicValue": 0,
		"quantity": 1
	},
	"SHORT_BOW": {
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.WEAPON_RANGED,
		"name": "Short Bow",
		"value":6,
		"magicValue": 0,
		"quantity": 1
	},
	"HUNTING_BOW": {
		"purchaseble": true,
		"cost": 40,
		"type": Enums.ITEM_TYPES.WEAPON_RANGED,
		"name": "Hunting Bow",
		"value":16,
		"magicValue": 0,
		"quantity": 1
	},
	"HAND_AXE": {
		"purchaseble": true,
		"cost": 12,
		"type": Enums.ITEM_TYPES.WEAPON_AXE,
		"name": "Hand axe",
		"value":9,
		"magicValue": 0,
		"quantity": 1
	},
	"CURVED_AXE": {
		"purchaseble": true,
		"cost": 52,
		"type": Enums.ITEM_TYPES.WEAPON_AXE,
		"name": "Curved axe",
		"value":21,
		"magicValue": 0,
		"quantity": 1
	},
	"STAFF": {
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.WEAPON_STAFF,
		"name": "Staff",
		"value": 2,
		"magicValue": 5,
		"quantity": 1
	},
	"OAK_STAFF": {
		"purchaseble": true,
		"cost": 40,
		"type": Enums.ITEM_TYPES.WEAPON_STAFF,
		"name": "Oak Staff",
		"value": 4,
		"magicValue": 10,
		"quantity": 1
	},
	"LEATHER_ARMOR": {
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.ARMOR_HEAVY,
		"name": "Leather armor",
		"value": 4,
		"magicValue": 2,
		"quantity": 1
	},
	"ROBE_ARMOR": {
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.ARMOR_LIGHT,
		"name": "Robe",
		"value": 2,
		"magicValue": 4,
		"quantity": 1
	},
	"IRON_RING": {
		"purchaseble": true,
		"cost": 2,
		"type": Enums.ITEM_TYPES.ASSESSORY_RING,
		"name": "Iron ring",
		"value": 2,
		"magicValue": 4,
		"quantity": 1
	},
	"LEATHER_HELM": {
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.ASSESSORY_HELMET,
		"name": "Leather helm",
		"value": 2,
		"magicValue": 0,
		"quantity": 1
	},
	
	"SMALL_KEY": {
		"purchaseble": true,
		"cost": 20,
		"type": Enums.ITEM_TYPES.KEY,
		"name": "Small key",
		"value": 0,
		"magicValue": 0,
		"quantity": 1
	},
	
	"SILVER_RING": {
		"purchaseble": false,
		"cost": 8,
		"type": Enums.ITEM_TYPES.TREASURE,
		"name": "Silver ring",
		"value": 0,
		"magicValue": 0,
		"quantity": 1
	},
	"GOLD_RING": {
		"purchaseble": false,
		"cost": 24,
		"type": Enums.ITEM_TYPES.TREASURE,
		"name": "Gold ring",
		"value": 0,
		"magicValue": 0,
		"quantity": 1
	},
	"GOLD_NECKLACE": {
		"purchaseble": false,
		"cost": 32,
		"type": Enums.ITEM_TYPES.TREASURE,
		"name": "Gold necklace",
		"value": 0,
		"magicValue": 0,
		"quantity": 1
	}
}

var ENEMY_SPAWNS:Dictionary = {
	"GOBLIN": {
		"description": "A vile band of goblins.",
		"min":2,
		"max":5
	},
	"BLOB": {
		"description": "Some slimy mucus.",
		"min":5,
		"max":8
	},
	"SKELETON": {
		"description": "Some ancient walking bones.",
		"min":1,
		"max":3
	},
	"MIMIC": {
		"description": "A crazed demon posing as treasure.",
		"min":1,
		"max":1
	}
}

var ENEMY_STATS:Dictionary = {
	"GOBLIN": {
		"name": "Goblin",
		"type":Enums.ENEMY_TYPES.GOBLIN,
		"crownsMin": 3,
		"crownsMax": 6,
		"xp":6,
		"health": 10,
		"attack": 6,
		"defence": 3,
		"itemDrop": ["POTION", "HERB"],
		"itemDropRate":20,
		"resistances": [],
		"statusEffects": [],
		"attackEffects": [],
		"morale": 100,
		"canFlee": true
	},
	"BLOB": {
		"name": "Blob",
		"type":Enums.ENEMY_TYPES.BLOB,
		"crownsMin": 2,
		"crownsMax": 8,
		"xp":8,
		"health": 14,
		"attack": 10,
		"defence": 5,
		"itemDrop": [],
		"itemDropRate":15,
		"resistances": [ Enums.STATUS_EFFECTS.STUN, Enums.STATUS_EFFECTS.BURNING ],
		"statusEffects": [],
		"attackEffects": [ Enums.STATUS_EFFECTS.POISON ],
		"morale": 100,
		"canFlee": true
	},
	"SKELETON": {
		"name": "Skeleton",
		"type":Enums.ENEMY_TYPES.SKELETON,
		"crownsMin": 3,
		"crownsMax": 5,
		"xp":12,
		"health": 14,
		"attack": 10,
		"defence": 5,
		"itemDrop": ["ELIXIR"],
		"itemDropRate":10,
		"resistances": [ Enums.STATUS_EFFECTS.BURNING ],
		"statusEffects": [],
		"attackEffects": [],
		"morale": 100,
		"canFlee": true
	}
	,
	"MIMIC": {
		"name": "Mimic",
		"type":Enums.ENEMY_TYPES.MIMIC,
		"crownsMin": 14,
		"crownsMax": 26,
		"xp":46,
		"health": 60,
		"attack": 24,
		"defence": 8,
		"itemDrop": [],
		"itemDropRate":10,
		"resistances": [ ],
		"statusEffects": [],
		"attackEffects": [ Enums.STATUS_EFFECTS.STUN ],
		"morale": 100,
		"canFlee": true
	}
}

#enum TREASURE_TYPES {
#	MINOR,
#	RANDOM_CHEST,
#	FIXED_CHEST
#}
## <WORLD>_<KEY>_<NO>
var TREASURES:Dictionary = {
	"DEV_WORLD_LONGSWORD_01": {
		"type": Enums.TREASURE_TYPES.FIXED_CHEST,
		"x": 16,
		"y": 16,
		"key": "POTION",
		"tier": 1,
		"lockedBy": ""
	},
	"DEV_WORLD_CHEST_01": {
		"type": Enums.TREASURE_TYPES.RANDOM_CHEST,
		"x": 32,
		"y": 16,
		"key": "",
		"tier": 1,
		"lockedBy": ""
	}
	,
	"DEV_WORLD_CHEST_02": {
		"type": Enums.TREASURE_TYPES.LOCKED_CHEST,
		"x": 64,
		"y": 16,
		"key": "POTION",
		"tier": 1,
		"lockedBy": "SMALL_KEY"
	}
}

## <WORLD>_<KEY>_<NO>
var DOORS:Dictionary = {
	"DEVWORLD_DOOR_01": {
		"x": 150,
		"y": 13,
		"style": Enums.DOOR_STYLES.WOOD,
		"lockedBy": ""
	}
}

## <WORLD>_<KEY>_<NO>
var NPCS:Dictionary = {
	"DEV_WORLD_WOMAN_1": {
		"name": "Old woman",
		"messages": [ "Hello world" ],
		"style": Enums.MAP_NPC_STYLES.WOMAN_BLUE,
		"x": 80,
		"y":28,
		"questLine": Enums.QUEST_LINES.NONE,
		"questPoints" : Enums.QUEST_POINTS.NONE
	}
}
