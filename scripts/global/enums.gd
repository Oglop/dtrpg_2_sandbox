extends Node

enum SYSTEM_GLOBAL_STATES { ON_MAP, IN_RULES_MENU, IN_BATTLE, IN_MESSAGE_BOX, IN_PAUSE_SCREEN }
enum STORY_KEY_ITEMS {  }
enum STARTUP_MODE { MAP_EDITOR, GAME, DEVELOPMENT }
enum PARTY_STATE { IDLE, MOVED, FIGHTING }
enum CLASSES { NONE, WARRIOR, KNIGHT, WIZARD, HUNTER, THIEF, CLERIC }
enum CLASSES_ATTRIBUTE_GROWTH { NONE, FLAT, NORMAL, SHARP }
enum SYSTEM_SKILL_CHECK_RESULT { FAIL, SUCCESS, CRITICAL }
enum SYSTEM_LOG_TYPE { BATTLE, MAP, NPC }
enum AGES { YOUNG, ADULT, OLD }
enum SAVE_SLOTS { SLOT1, SLOT2, SLOT3 }
enum MAPS { NONE, DEV_MAP }
enum MAP_MESSAGE_SIGN_TYPES { NONE, SIGN_DEV_WORLD }
enum ENTER_FROM { START_SCREEN }
enum SCENE_TYPE {
	PARTY,
	PLAYER_SPRITE,
	ENEMY,
	MESSAGE_SIGN,
	DAMAGE_NUMBERS,
	FIREBALL,
	CUT
}
enum RULE {
	NONE,
	ALWAYS,
	NEVER,
	SELF_HP_GT_50,
	SELF_HP_GT_20,
	SELF_HP_LT_80,
	SELF_HP_LT_50,
	SELF_HP_LT_20,
	SELF_HP_LT_10,
	SELF_MP_GT_50,
	SELF_MP_GT_20,
	SELF_MP_LT_80,
	SELF_MP_LT_50,
	SELF_MP_LT_20,
	SELF_MP_LT_10,
	ALLY_HP_GT_50,
	ALLY_HP_GT_20,
	ALLY_HP_LT_80,
	ALLY_HP_LT_50,
	ALLY_HP_LT_20,
	ALLY_HP_LT_10,
	ALLY_MP_GT_50,
	ALLY_MP_GT_20,
	ALLY_MP_LT_80,
	ALLY_MP_LT_50,
	ALLY_MP_LT_10,
	ALLY_MP_LT_20,
	ALLY_DEAD,
}
enum ACTION {
	NONE,
	ATTACK,
	USE_POTION_SELF,
	USE_POTION_ALLY,
	USE_HERB_SELF,
	USE_HERB_ALLY,
	USE_ELEXIR_ALLY,
	CAST_FIREBALL,
	CAST_HEAL,
	CAST_REVIVE,
	PROTECT,
	DEFEND,
	STEAL,
	BACK_STAB,
}

enum ENEMY_TYPES {
	NONE,
	GOBLIN
}

enum ENEMY_STATES {
	INACTIVE,
	CHASING,
	IN_FIGHT
}

enum ITEM_TYPES {
	NONE,
	CONSUMABLE,
	WEAPON_SWORD,
	WEAPON_STAFF,
	WEAPON_BLUNT,
	WEAPON_AXE,
	WEAPON_SPEAR,
	WEAPON_RANGED,
	ARMOR_LIGHT,
	ARMOR_HEAVY,
	ASSESSORY_RING,
	ASSESSORY_HELMET,
}

enum ITEM_NAMES {
	NONE,
	POTION,
	HERB,
	ELEXIR
}

enum BATTLE_DAMAGE_FXS {
	FIREBALL,
	CUT
}
