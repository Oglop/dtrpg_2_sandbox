extends Node

enum SYSTEM_GLOBAL_STATES { 
	ON_MAP, 
	IN_RULES_MENU, 
	IN_BATTLE, 
	IN_MESSAGE_BOX, 
	IN_PAUSE_SCREEN,
	IN_MERCHANT_SELECT,
	IN_MERCHANT_MENU_BUY, 
	IN_MERCHANT_MENU_SELL
}
enum STORY_KEY_ITEMS {  }
enum STARTUP_MODE { MAP_EDITOR, GAME, DEVELOPMENT }
enum PARTY_STATE { IDLE, MOVED, FIGHTING, INTERACTING }
enum CLASSES { NONE, WARRIOR, KNIGHT, WIZARD, HUNTER, THIEF, CLERIC }
enum CLASSES_ATTRIBUTE_GROWTH { NONE, FLAT, NORMAL, SHARP }
enum SYSTEM_SKILL_CHECK_RESULT { FAIL, SUCCESS, CRITICAL }
enum SYSTEM_LOG_TYPE { BATTLE, MAP, NPC }
enum AGES { YOUNG, ADULT, OLD }
enum SAVE_SLOTS { SLOT1, SLOT2, SLOT3 }
enum PARTY_SKILLS {
	FIND_TRAPS
}
enum MAPS { NONE, DEV_MAP }
enum MAP_MESSAGE_SIGN_TYPES { NONE, SIGN_DEV_WORLD }
enum MAP_NPC_STYLES {
	WOMAN_BLUE,
	MAN_BLUE,
	WOMAN_GREEN,
	MAN_GREEN
}
enum ENTER_FROM { START_SCREEN }
enum SCENE_TYPE {
	CHAIN_LIGHTNING,
	DOOR,
	TREASURE,
	PARTY,
	PLAYER_SPRITE,
	ENEMY,
	MESSAGE_SIGN,
	DAMAGE_NUMBERS,
	FIREBALL,
	LAVAWAVE,
	POISON,
	CUT,
	NPC,
	STUN,
	SLEEP,
	PROTECT,
	MISS,
	EXPLOSION
}

enum STATUS_EFFECTS {
	STUN,
	BURNING,
	POISON,
	PROTECTING,
	PROTECTED,
	DEFENDING,
	DODGE,
	BLESSED
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
	SELF_POISONED,
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
	ALLY_POISONED
}
enum ACTION {
	NONE,
	ATTACK,
	USE_POTION_SELF,
	USE_POTION_ALLY,
	USE_HERB_SELF,
	USE_HERB_ALLY,
	USE_ELEXIR_ALLY,
	USE_ANTIDOTE_SELF,
	USE_ANTIDOTE_ALLY,
	CAST_FIREBALL,
	CAST_HEAL,
	CAST_REVIVE,
	PROTECT,
	DEFEND,
	STEAL,
	BACK_STAB,
	LAVA_WAVE,
	POISON,
	LIGHTNING_CHAIN,
	BARRAGE,
	DOUBLE_STRIKE,
	STUN,
	PIERCE,
	HEAL_ALL,
	BLESS,
}

enum ENEMY_TYPES {
	NONE,
	GOBLIN,
	BLOB,
	SKELETON,
	PRINCE,
	MIMIC,
	BITER,
	CENTIPEDE
}

enum ENEMY_STATES {
	INACTIVE,
	CHASING,
	IN_FIGHT
}

enum ITEM_TYPES {
	NONE,
	CONSUMABLE,
	WEAPON_DAGGER,
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
	TREASURE,
	KEY
}

enum ITEM_NAMES {
	NONE,
	POTION,
	HERB,
	ELEXIR
}

enum BATTLE_DAMAGE_FXS {
	FIREBALL,
	CUT,
	LAVA_WAVE,
	POSION,
	STUN,
	SLEEP
}

enum TREASURE_TYPES {
	MINOR,
	RANDOM_CHEST,
	FIXED_CHEST,
	LOCKED_CHEST
}

enum TREASURE_STATE {
	CLOSED,
	OPENED
}

enum DOOR_STYLES {
	STONE,
	WOOD,
	BARS
}

enum DOOR_STATES {
	OPEN,
	CLOSED,
	LOCKED
}

enum QUEST_LINES {
	NONE,
	MAIN
}

enum QUEST_POINTS {
	NONE,
	MAIN_TALK_TO_KING
}
