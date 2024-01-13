extends Node

var SYSTEM_NEW_GAME:String = "New game"
var SCENE_WORLDS_PATH:String = "res://scenes/worlds/"
var SCENE_DEV_WORLD:String = "devWorld.tscn"


var CHARACTER_AGE_YOUNG:String = "Young"
var CHARACTER_AGE_ADULT:String = "Adult"
var CHARACTER_AGE_OLD:String = "Old"

var CLASS_WARRIOR:String = "Warrior"
var CLASS_WARRIOR_NAME_1:String = "Goor"
var CLASS_WARRIOR_NAME_2:String = "Friez"
var CLASS_WARRIOR_NAME_3:String = "Pronc"
var CLASS_WARRIOR_NAME_4:String = "Klug"

var CLASS_KNIGHT:String = "Knight"
var CLASS_KNIGHT_NAME_1:String = "Rhono"
var CLASS_KNIGHT_NAME_2:String = "Tulio"
var CLASS_KNIGHT_NAME_3:String = "Wrex"
var CLASS_KNIGHT_NAME_4:String = "Plias"

var CLASS_HUNTER:String = "Hunter"
var CLASS_HUNTER_NAME_1:String = "Rux"
var CLASS_HUNTER_NAME_2:String = "Onni"
var CLASS_HUNTER_NAME_3:String = "Mida"
var CLASS_HUNTER_NAME_4:String = "Ainro"

var CLASS_WIZARD:String = "Wizard"
var CLASS_WIZARD_NAME_1:String = "Xro"
var CLASS_WIZARD_NAME_2:String = "Rux"
var CLASS_WIZARD_NAME_3:String = "Dilio"
var CLASS_WIZARD_NAME_4:String = "Qaz"

var CLASS_THIEF:String = "Thief"
var CLASS_THIEF_NAME_1:String = "Pik"
var CLASS_THIEF_NAME_2:String = "Tyr"
var CLASS_THIEF_NAME_3:String = "Elis"
var CLASS_THIEF_NAME_4:String = "Lios"

var CLASS_CLERIC:String = "Cleric"
var CLASS_CLERIC_NAME_1:String = "Rhina"
var CLASS_CLERIC_NAME_2:String = "Olona"
var CLASS_CLERIC_NAME_3:String = "Hemic"
var CLASS_CLERIC_NAME_4:String = "Plax"

var MAP_TRAVEL_EAST:String = "Traveling east."
var MAP_TRAVEL_NORTH:String = "Traveling north."
var MAP_TRAVEL_WEST:String = "Traveling west."
var MAP_TRAVEL_SOUTH:String = "Traveling south."

var ALWAYS:String = "Any"
var NEVER:String = "Never"
var SELF_IS_POISONED:String = "Self:Poisoned"
var SELF_HP_GT_50:String = "Self:HP > 50%"
var SELF_HP_GT_20:String = "Self:HP > 20%"
var SELF_HP_LT_80:String = "Self:HP < 80%"
var SELF_HP_LT_50:String = "Self:HP < 50%"
var SELF_HP_LT_20:String = "Self:HP < 20%"
var SELF_HP_LT_10:String = "Self:HP < 10%"
var SELF_MP_GT_50:String = "Self:MP > 50%"
var SELF_MP_GT_20:String = "Self:MP > 20%"
var SELF_MP_LT_80:String = "Self:MP < 80%"
var SELF_MP_LT_50:String = "Self:MP < 50%"
var SELF_MP_LT_20:String = "Self:MP < 20%"
var SELF_MP_LT_10:String = "Self:MP < 10%"
var ALLY_IS_POISONED:String = "Ally:Poisoned"
var ALLY_HP_GT_50:String = "Ally:HP > 50%"
var ALLY_HP_GT_20:String = "Ally:HP > 20%"
var ALLY_HP_LT_80:String = "Ally:HP < 80%"
var ALLY_HP_LT_50:String = "Ally:HP < 50%"
var ALLY_HP_LT_20:String = "Ally:HP < 20%"
var ALLY_HP_LT_10:String = "Ally:HP < 10%"
var ALLY_MP_GT_50:String = "Ally:MP > 50%"
var ALLY_MP_GT_20:String = "Ally:MP > 20%"
var ALLY_MP_LT_80:String = "Ally:MP < 80%"
var ALLY_MP_LT_50:String = "Ally:MP < 50%"
var ALLY_MP_LT_20:String = "Ally:MP < 20%"
var ALLY_MP_LT_10:String = "Ally:MP < 10%"
var ALLY_DEAD:String = "Ally:Dead"

var NONE:String = ""
var ATTACK:String = "Attack"
var USE_POTION_SELF:String = "Use potion self"
var USE_POTION_ALLY:String = "Use potion ally"
var USE_HERB_SELF:String = "Use herb self"
var USE_HERB_ALLY:String = "Use herb ally"
var USE_ANTIDOTE_SELF:String = "Use antidote self"
var USE_ANTIDOTE_ALLY:String = "Use antidote ally"
var USE_ELEXIR_ALLY:String = "Use elexir"
var CAST_FIREBALL:String = "Cast fireball"
var PROTECT:String = "Protect"
var DEFEND:String = "Defend"
var CAST_HEAL:String = "Cast heal"
var CAST_REVIVE:String = "Cast revive"
var STEAL:String = "Steal"
var BACK_STAB:String = "Backstab"



var CHARACTER_CARD_LEVEL:String = "LV: "
var CHARACTER_CARD_XP:String = "XP: "
var CHARACTER_CARD_NEXT:String = "- NEXT: "
var CHARACTER_CARD_LUCK:String = "Luc: "
var CHARACTER_CARD_AGILITY:String = "Agi: "
var CHARACTER_CARD_STRENGTH:String = "Str: "
var CHARACTER_CARD_INTELLIGENCE:String = "Int: "
var CHARACTER_CARD_HP:String = "HP: "
var CHARACTER_CARD_MP:String = "MP: "
var CHARACTER_CARD_ATTACK:String = "Attack: "
var CHARACTER_CARD_DEFENCE:String = "Defence: "
var CHARACTER_CARD_ARMOR:String = "Armor: "
var CHARACTER_CARD_WEAPON:String = "Weapon: "
var CHARACTER_CARD_ACCESSORY:String = "Accessory: "


var CLASS_DESCRIPTION_WARRIOR:String = "The warrior focuses on physical attack, strong enough to break any foe."
var CLASS_DESCRIPTION_KNIGT:String = "The knight focuses on defensive and protecting the party."
var CLASS_DESCRIPTION_WIZARD:String = "The wizard uses strog magical attacks but needs magic to use his power."
var CLASS_DESCRIPTION_HUNTER:String = "The hunter is a supportive class that can still do alot of damage to the enemy."
var CLASS_DESCRIPTION_THIEF:String = "The thief can uses luck for great risk and reward."
var CLASS_DESCRIPTION_CLERIC:String = "The cleric focuses on healing the other party members."

