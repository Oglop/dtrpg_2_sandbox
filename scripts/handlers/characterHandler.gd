extends Node

var REMOVE_POISON_CHANCE:int = 15
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("TURN_ENDED", _on_turnEnded)
	Events.connect("CHARACTER_ADD_STATUS_EFFECT", _on_characterAddStatusEffect)
	Events.connect("CHARACTER_REMOVE_STATUS_EFFECT", _on_characterRemoveStatusEffect)
	
func percentage(part:int, whole:int) -> int:
	if part == 0 || whole == 0:
		return 0
	return (part / whole) * 100
	
func percentageOf(percent:int, whole:int) -> int:
	if percent == 0 || whole == 0:
		return 0
	var part = whole * 0.1
	return part * percent
	
func getPartyDiscount() -> float:
	return 0.0
	
	
func _on_characterAddStatusEffect(position:int, statusEffect:Enums.STATUS_EFFECTS) -> void:
	if position == 0:
		if !Data.CHARACTER_1_STATUS_EFFECTS.has(statusEffect):
			Data.CHARACTER_1_STATUS_EFFECTS.append(statusEffect)
	elif position == 1:
		if !Data.CHARACTER_2_STATUS_EFFECTS.has(statusEffect):
			Data.CHARACTER_2_STATUS_EFFECTS.append(statusEffect)
	elif position == 2:
		if !Data.CHARACTER_3_STATUS_EFFECTS.has(statusEffect):
			Data.CHARACTER_3_STATUS_EFFECTS.append(statusEffect)
	elif position == 3:
		if !Data.CHARACTER_4_STATUS_EFFECTS.has(statusEffect):
			Data.CHARACTER_4_STATUS_EFFECTS.append(statusEffect)
			
func _on_characterRemoveStatusEffect(position:int, statusEffect:Enums.STATUS_EFFECTS) -> void:
	if position == 0:
		if Data.CHARACTER_1_STATUS_EFFECTS.has(statusEffect):
			Data.CHARACTER_1_STATUS_EFFECTS.erase(statusEffect)
	elif position == 1:
		if Data.CHARACTER_2_STATUS_EFFECTS.has(statusEffect):
			Data.CHARACTER_2_STATUS_EFFECTS.erase(statusEffect)
	elif position == 2:
		if Data.CHARACTER_3_STATUS_EFFECTS.has(statusEffect):
			Data.CHARACTER_3_STATUS_EFFECTS.erase(statusEffect)
	elif position == 3:
		if Data.CHARACTER_4_STATUS_EFFECTS.has(statusEffect):
			Data.CHARACTER_4_STATUS_EFFECTS.erase(statusEffect)
			
func removeStun() -> void:
	var index:int = Data.CHARACTER_1_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.STUN)
	if index != -1:
		Data.CHARACTER_1_STATUS_EFFECTS.remove_at(index)
		Events.emit_signal("SYSTEM_WRITE_LOG", str(getCharacterName(0), " shrugs off the stun."), Enums.SYSTEM_LOG_TYPE.BATTLE)
		index = -1
	index = Data.CHARACTER_2_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.STUN)
	if index != -1:
		Data.CHARACTER_2_STATUS_EFFECTS.remove_at(index)
		Events.emit_signal("SYSTEM_WRITE_LOG", str(getCharacterName(1), " shrugs off the stun."), Enums.SYSTEM_LOG_TYPE.BATTLE)
		index = -1
	index = Data.CHARACTER_3_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.STUN)
	if index != -1:
		Data.CHARACTER_3_STATUS_EFFECTS.remove_at(index)
		Events.emit_signal("SYSTEM_WRITE_LOG", str(getCharacterName(2), " shrugs off the stun."), Enums.SYSTEM_LOG_TYPE.BATTLE)
		index = -1
	index = Data.CHARACTER_4_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.STUN)
	if index != -1:
		Data.CHARACTER_4_STATUS_EFFECTS.remove_at(index)
		Events.emit_signal("SYSTEM_WRITE_LOG", str(getCharacterName(3), " shrugs off the stun."), Enums.SYSTEM_LOG_TYPE.BATTLE)
		index = -1
		
func handlePoisonStatus() -> void:
	var index:int = Data.CHARACTER_1_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.POISON)
	if index != -1:
		var dmg = percentageOf(10, Data.CHARACTER_1_HEALTH_MAX)
		Events.emit_signal("CHARACTER_TAKE_DAMAGE", 0, dmg)
		Events.emit_signal("SYSTEM_WRITE_LOG", str(getCharacterName(0), " is hurt by the posion."), Enums.SYSTEM_LOG_TYPE.BATTLE)
		if skillCheck(REMOVE_POISON_CHANCE) != Enums.SYSTEM_SKILL_CHECK_RESULT.FAIL:
			Data.CHARACTER_1_STATUS_EFFECTS.remove_at(index)
			index = -1
	index = Data.CHARACTER_2_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.POISON)
	if index != -1:
		var dmg = percentageOf(10, Data.CHARACTER_2_HEALTH_MAX)
		Events.emit_signal("CHARACTER_TAKE_DAMAGE", 1, dmg)
		Events.emit_signal("SYSTEM_WRITE_LOG", str(getCharacterName(1), " is hurt by the posion."), Enums.SYSTEM_LOG_TYPE.BATTLE)
		if skillCheck(REMOVE_POISON_CHANCE) != Enums.SYSTEM_SKILL_CHECK_RESULT.FAIL:
			Data.CHARACTER_2_STATUS_EFFECTS.remove_at(index)
			index = -1
	index = Data.CHARACTER_3_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.POISON)
	if index != -1:
		var dmg = percentageOf(10, Data.CHARACTER_3_HEALTH_MAX)
		Events.emit_signal("CHARACTER_TAKE_DAMAGE", 2, dmg)
		Events.emit_signal("SYSTEM_WRITE_LOG", str(getCharacterName(2), " is hurt by the posion."), Enums.SYSTEM_LOG_TYPE.BATTLE)
		if skillCheck(REMOVE_POISON_CHANCE) != Enums.SYSTEM_SKILL_CHECK_RESULT.FAIL:
			Data.CHARACTER_3_STATUS_EFFECTS.remove_at(index)
			index = -1
	index = Data.CHARACTER_4_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.POISON)
	if index != -1:
		var dmg = percentageOf(10, Data.CHARACTER_4_HEALTH_MAX)
		Events.emit_signal("CHARACTER_TAKE_DAMAGE", 3, dmg)
		Events.emit_signal("SYSTEM_WRITE_LOG", str(getCharacterName(3), " is hurt by the posion."), Enums.SYSTEM_LOG_TYPE.BATTLE)
		if skillCheck(REMOVE_POISON_CHANCE) != Enums.SYSTEM_SKILL_CHECK_RESULT.FAIL:
			Data.CHARACTER_4_STATUS_EFFECTS.remove_at(index)
			index = -1
			
func removeProtecting() -> void:
	var index:int = Data.CHARACTER_1_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.PROTECTED)
	if index != -1:
		Data.CHARACTER_1_STATUS_EFFECTS.remove_at(index)
		index = -1
	index = Data.CHARACTER_1_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.PROTECTING)
	if index != -1:
		Data.CHARACTER_1_STATUS_EFFECTS.remove_at(index)
		index = -1
		
	index = Data.CHARACTER_2_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.PROTECTED)
	if index != -1:
		Data.CHARACTER_2_STATUS_EFFECTS.remove_at(index)
		index = -1
	index = Data.CHARACTER_2_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.PROTECTING)
	if index != -1:
		Data.CHARACTER_2_STATUS_EFFECTS.remove_at(index)
		index = -1
		
	index = Data.CHARACTER_3_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.PROTECTED)
	if index != -1:
		Data.CHARACTER_3_STATUS_EFFECTS.remove_at(index)
		index = -1
	index = Data.CHARACTER_3_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.PROTECTING)
	if index != -1:
		Data.CHARACTER_3_STATUS_EFFECTS.remove_at(index)
		index = -1
	
	index = Data.CHARACTER_4_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.PROTECTED)
	if index != -1:
		Data.CHARACTER_4_STATUS_EFFECTS.remove_at(index)
		index = -1
	index = Data.CHARACTER_4_STATUS_EFFECTS.find(Enums.STATUS_EFFECTS.PROTECTING)
	if index != -1:
		Data.CHARACTER_4_STATUS_EFFECTS.remove_at(index)
		index = -1
	
func _on_turnEnded() -> void:
	removeStun()
	handlePoisonStatus()
	removeProtecting()

	
func skillCheck(skill:int) -> Enums.SYSTEM_SKILL_CHECK_RESULT:
	var check = rng.randi_range(1, 20)
	if check == 1:
		return Enums.SYSTEM_SKILL_CHECK_RESULT.FAIL
	elif check == 20:
		return Enums.SYSTEM_SKILL_CHECK_RESULT.CRITICAL
	elif check <= skill:
		return Enums.SYSTEM_SKILL_CHECK_RESULT.SUCCESS
	return Enums.SYSTEM_SKILL_CHECK_RESULT.FAIL
	
## Get name of character
func getCharacterName(position:int) -> String:
	if position == 0:
		return Data.CHARACTER_1_NAME
	elif position == 1:
		return Data.CHARACTER_2_NAME
	elif position == 2:
		return Data.CHARACTER_3_NAME
	else:
		return Data.CHARACTER_4_NAME
		
func getClassName(type:Enums.CLASSES) -> String:
	if type == Enums.CLASSES.WARRIOR:
		return "Warrior"
	elif type == Enums.CLASSES.KNIGHT:
		return "Knight"
	elif type == Enums.CLASSES.WIZARD:
		return "Wizard"
	elif type == Enums.CLASSES.HUNTER:
		return "Hunter"
	elif type == Enums.CLASSES.THIEF:
		return "Thief"
	elif type == Enums.CLASSES.CLERIC:
		return "Cleric"
	return ""

func getEquipableByTypeAndPosition(position:int, itemType:Enums.ITEM_TYPES) -> bool:
	if position == 0:
		return Data.CHARACTER_1_EQUIPABLE.find(itemType) >= 0
	elif position == 1:
		return Data.CHARACTER_2_EQUIPABLE.find(itemType) >= 0
	elif position == 2:
		return Data.CHARACTER_3_EQUIPABLE.find(itemType) >= 0
	elif position == 3:
		return Data.CHARACTER_4_EQUIPABLE.find(itemType) >= 0
	return false
		
func getLevelNext(xpBase:int, level:int) -> int:
	return floor(level * 40 * xpBase) 
	
# return xp base
func getXPBase(currentLV:int) -> int:
	if currentLV >= 1 && currentLV <= 6:
		return Statics.LEVEL_1_6_XP_BASE
	elif currentLV >= 7 && currentLV <= 12:
		return Statics.LEVEL_7_12_XP_BASE
	elif currentLV >= 13 && currentLV <= 18:
		return Statics.LEVEL_13_18_XP_BASE
	elif currentLV >= 19 && currentLV <= 26:
		return Statics.LEVEL_19_26_XP_BASE
	else:
		return Statics.LEVEL_27_99_XP_BASE
		
func getCharacterEquipableByClass(type:Enums.CLASSES) -> Array:
	if type == Enums.CLASSES.WARRIOR:
		return Statics.CLASSES_ATRIBUTES.WARRIOR.EQUIP_TYPES
	elif type == Enums.CLASSES.KNIGHT:
		return Statics.CLASSES_ATRIBUTES.KNIGHT.EQUIP_TYPES
	elif type == Enums.CLASSES.WIZARD:
		return Statics.CLASSES_ATRIBUTES.WIZARD.EQUIP_TYPES
	elif type == Enums.CLASSES.HUNTER:
		return Statics.CLASSES_ATRIBUTES.HUNTER.EQUIP_TYPES
	elif type == Enums.CLASSES.THIEF:
		return Statics.CLASSES_ATRIBUTES.THIEF.EQUIP_TYPES
	elif type == Enums.CLASSES.CLERIC:
		return Statics.CLASSES_ATRIBUTES.CLERIC.EQUIP_TYPES
	return []

## Return Array of rules for character
## [{ 
##   rule: Enums.RULE
##   action: Enums.ACTION
## }]
func getCharacterRules(position:int) -> Array:
	if position == 0:
		return Data.CHARACTER_1_RULES
	elif position == 1:
		return Data.CHARACTER_2_RULES
	elif position == 2:
		return Data.CHARACTER_3_RULES
	else:
		return Data.CHARACTER_4_RULES

func getHealthBaseByClass(type:Enums.CLASSES) -> int:
	if type == Enums.CLASSES.WARRIOR:
		return Statics.CLASSES_ATRIBUTES.WARRIOR.HEALTH_BASE
	elif type == Enums.CLASSES.KNIGHT:
		return Statics.CLASSES_ATRIBUTES.KNIGHT.HEALTH_BASE
	elif type == Enums.CLASSES.WIZARD:
		return Statics.CLASSES_ATRIBUTES.WIZARD.HEALTH_BASE
	elif type == Enums.CLASSES.HUNTER:
		return Statics.CLASSES_ATRIBUTES.HUNTER.HEALTH_BASE
	elif type == Enums.CLASSES.THIEF:
		return Statics.CLASSES_ATRIBUTES.THIEF.HEALTH_BASE
	elif type == Enums.CLASSES.CLERIC:
		return Statics.CLASSES_ATRIBUTES.CLERIC.HEALTH_BASE
	return 0
	
func getMagicBaseByClass(type:Enums.CLASSES) -> int:
	if type == Enums.CLASSES.WARRIOR:
		return Statics.CLASSES_ATRIBUTES.WARRIOR.MAGIC_BASE
	elif type == Enums.CLASSES.KNIGHT:
		return Statics.CLASSES_ATRIBUTES.KNIGHT.MAGIC_BASE
	elif type == Enums.CLASSES.WIZARD:
		return Statics.CLASSES_ATRIBUTES.WIZARD.MAGIC_BASE
	elif type == Enums.CLASSES.HUNTER:
		return Statics.CLASSES_ATRIBUTES.HUNTER.MAGIC_BASE
	elif type == Enums.CLASSES.THIEF:
		return Statics.CLASSES_ATRIBUTES.THIEF.MAGIC_BASE
	elif type == Enums.CLASSES.CLERIC:
		return Statics.CLASSES_ATRIBUTES.CLERIC.MAGIC_BASE
	return 0
	
func getStrengthBaseByClass(type:Enums.CLASSES) -> int:
	if type == Enums.CLASSES.WARRIOR:
		return Statics.CLASSES_ATRIBUTES.WARRIOR.STRENGTH_BASE
	elif type == Enums.CLASSES.KNIGHT:
		return Statics.CLASSES_ATRIBUTES.KNIGHT.STRENGTH_BASE
	elif type == Enums.CLASSES.WIZARD:
		return Statics.CLASSES_ATRIBUTES.WIZARD.STRENGTH_BASE
	elif type == Enums.CLASSES.HUNTER:
		return Statics.CLASSES_ATRIBUTES.HUNTER.STRENGTH_BASE
	elif type == Enums.CLASSES.THIEF:
		return Statics.CLASSES_ATRIBUTES.THIEF.STRENGTH_BASE
	elif type == Enums.CLASSES.CLERIC:
		return Statics.CLASSES_ATRIBUTES.CLERIC.STRENGTH_BASE
	return 0
	
func getAgileBaseByClass(type:Enums.CLASSES) -> int:
	if type == Enums.CLASSES.WARRIOR:
		return Statics.CLASSES_ATRIBUTES.WARRIOR.AGILITY_BASE
	elif type == Enums.CLASSES.KNIGHT:
		return Statics.CLASSES_ATRIBUTES.KNIGHT.AGILITY_BASE
	elif type == Enums.CLASSES.WIZARD:
		return Statics.CLASSES_ATRIBUTES.WIZARD.AGILITY_BASE
	elif type == Enums.CLASSES.HUNTER:
		return Statics.CLASSES_ATRIBUTES.HUNTER.AGILITY_BASE
	elif type == Enums.CLASSES.THIEF:
		return Statics.CLASSES_ATRIBUTES.THIEF.AGILITY_BASE
	elif type == Enums.CLASSES.CLERIC:
		return Statics.CLASSES_ATRIBUTES.CLERIC.AGILITY_BASE
	return 0
	
func getIntelligenceBaseByClass(type:Enums.CLASSES) -> int:
	if type == Enums.CLASSES.WARRIOR:
		return Statics.CLASSES_ATRIBUTES.WARRIOR.INTELLIGENCE_BASE
	elif type == Enums.CLASSES.KNIGHT:
		return Statics.CLASSES_ATRIBUTES.KNIGHT.INTELLIGENCE_BASE
	elif type == Enums.CLASSES.WIZARD:
		return Statics.CLASSES_ATRIBUTES.WIZARD.INTELLIGENCE_BASE
	elif type == Enums.CLASSES.HUNTER:
		return Statics.CLASSES_ATRIBUTES.HUNTER.INTELLIGENCE_BASE
	elif type == Enums.CLASSES.THIEF:
		return Statics.CLASSES_ATRIBUTES.THIEF.INTELLIGENCE_BASE
	elif type == Enums.CLASSES.CLERIC:
		return Statics.CLASSES_ATRIBUTES.CLERIC.INTELLIGENCE_BASE
	return 0
	
func getLuckBaseByClass(type:Enums.CLASSES) -> int:
	if type == Enums.CLASSES.WARRIOR:
		return Statics.CLASSES_ATRIBUTES.WARRIOR.LUCK_BASE
	elif type == Enums.CLASSES.KNIGHT:
		return Statics.CLASSES_ATRIBUTES.KNIGHT.LUCK_BASE
	elif type == Enums.CLASSES.WIZARD:
		return Statics.CLASSES_ATRIBUTES.WIZARD.LUCK_BASE
	elif type == Enums.CLASSES.HUNTER:
		return Statics.CLASSES_ATRIBUTES.HUNTER.LUCK_BASE
	elif type == Enums.CLASSES.THIEF:
		return Statics.CLASSES_ATRIBUTES.THIEF.LUCK_BASE
	elif type == Enums.CLASSES.CLERIC:
		return Statics.CLASSES_ATRIBUTES.CLERIC.LUCK_BASE
	return 0
	
func getRulesByClass(type:Enums.CLASSES) -> Array:
	if type == Enums.CLASSES.WARRIOR:
		return Statics.CLASSES_ATRIBUTES.WARRIOR.RULES
	elif type == Enums.CLASSES.KNIGHT:
		return Statics.CLASSES_ATRIBUTES.KNIGHT.RULES
	elif type == Enums.CLASSES.WIZARD:
		return Statics.CLASSES_ATRIBUTES.WIZARD.RULES
	elif type == Enums.CLASSES.HUNTER:
		return Statics.CLASSES_ATRIBUTES.HUNTER.RULES
	elif type == Enums.CLASSES.THIEF:
		return Statics.CLASSES_ATRIBUTES.THIEF.RULES
	elif type == Enums.CLASSES.CLERIC:
		return Statics.CLASSES_ATRIBUTES.CLERIC.RULES
	return []

func getActionsByLevelAndClass(type:Enums.CLASSES, lv:int) -> Array:
	var actions:Array
	var lvIndex:String = ""
	lvIndex = str("LV", lv)
	if type == Enums.CLASSES.WARRIOR:
		if Statics.CLASSES_ATRIBUTES.WARRIOR.ACTIONS_LEVEL.has(lvIndex):
			actions.append_array(Statics.CLASSES_ATRIBUTES.WARRIOR.ACTIONS_LEVEL[lvIndex])
	elif type == Enums.CLASSES.KNIGHT:
		if Statics.CLASSES_ATRIBUTES.KNIGHT.ACTIONS_LEVEL.has(lvIndex):
			actions.append_array(Statics.CLASSES_ATRIBUTES.KNIGHT.ACTIONS_LEVEL[lvIndex])
	elif type == Enums.CLASSES.WIZARD:
		if Statics.CLASSES_ATRIBUTES.WIZARD.ACTIONS_LEVEL.has(lvIndex):
			actions.append_array(Statics.CLASSES_ATRIBUTES.WIZARD.ACTIONS_LEVEL[lvIndex])
	elif type == Enums.CLASSES.HUNTER:
		if Statics.CLASSES_ATRIBUTES.HUNTER.ACTIONS_LEVEL.has(lvIndex):
			actions.append_array(Statics.CLASSES_ATRIBUTES.HUNTER.ACTIONS_LEVEL[lvIndex])
	elif type == Enums.CLASSES.THIEF:
		if Statics.CLASSES_ATRIBUTES.THIEF.ACTIONS_LEVEL.has(lvIndex):
			actions.append_array(Statics.CLASSES_ATRIBUTES.THIEF.ACTIONS_LEVEL[lvIndex])
	elif type == Enums.CLASSES.CLERIC:
		if Statics.CLASSES_ATRIBUTES.CLERIC.ACTIONS_LEVEL.has(lvIndex):
			actions.append_array(Statics.CLASSES_ATRIBUTES.CLERIC.ACTIONS_LEVEL[lvIndex])
		
	return actions
	
func getStartingWeaponByClass(type:Enums.CLASSES) -> Dictionary:
	if type == Enums.CLASSES.WARRIOR:
		return Statics.ITEMS.SHORT_SWORD
	elif type == Enums.CLASSES.KNIGHT:
		return Statics.ITEMS.SPEAR
	elif type == Enums.CLASSES.WIZARD:
		return Statics.ITEMS.STAFF
	elif type == Enums.CLASSES.HUNTER:
		return Statics.ITEMS.SHORT_BOW
	elif type == Enums.CLASSES.THIEF:
		return Statics.ITEMS.SHORT_SWORD
	elif type == Enums.CLASSES.CLERIC:
		return Statics.ITEMS.CLUB
	return {}

func resetCharacterData() -> void:
	Data.CHARACTER_1_TYPE = Enums.CLASSES.NONE
	Data.CHARACTER_1_NAME = ""
	Data.CHARACTER_1_LV = 1
	Data.CHARACTER_1_XP = 0
	Data.CHARACTER_1_XP_NEXT = 0
	Data.CHARACTER_1_HEALTH_MAX = 0
	Data.CHARACTER_1_HEALTH_CURRENT = 0
	Data.CHARACTER_1_MAGIC_MAX = 0
	Data.CHARACTER_1_MAGIC_CURRENT = 0
	Data.CHARACTER_1_STRENGTH = 0
	Data.CHARACTER_1_AGILITY = 0
	Data.CHARACTER_1_INTELLIGENCE = 0
	Data.CHARACTER_1_LUCK = 0
	Data.CHARACTER_1_RULES = []
	Data.CHARACTER_1_WEAPON = {}
	Data.CHARACTER_1_ARMOR = {}
	Data.CHARACTER_1_EQUIPABLE = []
	Data.CHARACTER_1_ACCESSORY = {}
	Data.CHARACTER_1_ACTIONS = []
	
	Data.CHARACTER_2_TYPE = Enums.CLASSES.NONE
	Data.CHARACTER_2_NAME = ""
	Data.CHARACTER_2_LV = 1
	Data.CHARACTER_2_XP = 0
	Data.CHARACTER_2_XP_NEXT = 0
	Data.CHARACTER_2_HEALTH_MAX = 0
	Data.CHARACTER_2_HEALTH_CURRENT = 0
	Data.CHARACTER_2_MAGIC_MAX = 0
	Data.CHARACTER_2_MAGIC_CURRENT = 0
	Data.CHARACTER_2_STRENGTH = 0
	Data.CHARACTER_2_AGILITY = 0
	Data.CHARACTER_2_INTELLIGENCE = 0
	Data.CHARACTER_2_LUCK = 0
	Data.CHARACTER_2_RULES = []
	Data.CHARACTER_2_WEAPON = {}
	Data.CHARACTER_2_ARMOR = {}
	Data.CHARACTER_2_EQUIPABLE = []
	Data.CHARACTER_2_ACCESSORY = {}
	Data.CHARACTER_2_ACTIONS = []
	
	Data.CHARACTER_3_TYPE = Enums.CLASSES.NONE
	Data.CHARACTER_3_NAME = ""
	Data.CHARACTER_3_LV = 1
	Data.CHARACTER_3_XP = 0
	Data.CHARACTER_3_XP_NEXT = 0
	Data.CHARACTER_3_HEALTH_MAX = 0
	Data.CHARACTER_3_HEALTH_CURRENT = 0
	Data.CHARACTER_3_MAGIC_MAX = 0
	Data.CHARACTER_3_MAGIC_CURRENT = 0
	Data.CHARACTER_3_STRENGTH = 0
	Data.CHARACTER_3_AGILITY = 0
	Data.CHARACTER_3_INTELLIGENCE = 0
	Data.CHARACTER_3_LUCK = 0
	Data.CHARACTER_3_RULES = []
	Data.CHARACTER_3_WEAPON = {}
	Data.CHARACTER_3_ARMOR = {}
	Data.CHARACTER_3_EQUIPABLE = []
	Data.CHARACTER_3_ACCESSORY = {}
	Data.CHARACTER_3_ACTIONS = []
	
	Data.CHARACTER_4_TYPE = Enums.CLASSES.NONE
	Data.CHARACTER_4_NAME = ""
	Data.CHARACTER_4_LV = 1
	Data.CHARACTER_4_XP = 0
	Data.CHARACTER_4_XP_NEXT = 0
	Data.CHARACTER_4_HEALTH_MAX = 0
	Data.CHARACTER_4_HEALTH_CURRENT = 0
	Data.CHARACTER_4_MAGIC_MAX = 0
	Data.CHARACTER_4_MAGIC_CURRENT = 0
	Data.CHARACTER_4_STRENGTH = 0
	Data.CHARACTER_4_AGILITY = 0
	Data.CHARACTER_4_INTELLIGENCE = 0
	Data.CHARACTER_4_LUCK = 0
	Data.CHARACTER_4_RULES = []
	Data.CHARACTER_4_WEAPON = {}
	Data.CHARACTER_4_ARMOR = {}
	Data.CHARACTER_4_EQUIPABLE = []
	Data.CHARACTER_4_ACCESSORY = {}
	Data.CHARACTER_4_ACTIONS = []
	
func getStartingArmorByClass(type:Enums.CLASSES) -> Dictionary:
	if type == Enums.CLASSES.WARRIOR:
		return Statics.ITEMS.LEATHER_ARMOR
	elif type == Enums.CLASSES.KNIGHT:
		return Statics.ITEMS.LEATHER_ARMOR
	elif type == Enums.CLASSES.WIZARD:
		return Statics.ITEMS.ROBE_ARMOR
	elif type == Enums.CLASSES.HUNTER:
		return Statics.ITEMS.LEATHER_ARMOR
	elif type == Enums.CLASSES.THIEF:
		return Statics.ITEMS.LEATHER_ARMOR
	elif type == Enums.CLASSES.CLERIC:
		return Statics.ITEMS.ROBE_ARMOR
	return {}

func setNewCharacterOfType(type:Enums.CLASSES, position:int) -> void:
	var healthBase:int = getHealthBaseByClass(type)
	var magicBase:int = getMagicBaseByClass(type)
	var strengthBase:int = getStrengthBaseByClass(type)
	var agilityBase:int = getAgileBaseByClass(type)
	var intelligenceBase:int = getIntelligenceBaseByClass(type)
	var luckBase:int = getLuckBaseByClass(type)
	var rules:Array = getRulesByClass(type)
	var weapon:Dictionary = getStartingWeaponByClass(type)
	var armor:Dictionary = getStartingArmorByClass(type)
	var name:String = getCharacterNameByPositionAndClass(type, position)
	var equiplables:Array = getCharacterEquipableByClass(type)
	var availableActions:Array = getActionsByLevelAndClass(type, 1)
	var next:int = getLevelNext(getXPBase(1), 1)
	if position == 0:
		Data.CHARACTER_1_TYPE = type
		Data.CHARACTER_1_NAME = name
		Data.CHARACTER_1_LV = 1
		Data.CHARACTER_1_XP = 0
		Data.CHARACTER_1_XP_NEXT = next
		Data.CHARACTER_1_HEALTH_MAX = healthBase
		Data.CHARACTER_1_HEALTH_CURRENT = healthBase
		Data.CHARACTER_1_MAGIC_MAX = magicBase
		Data.CHARACTER_1_MAGIC_CURRENT = magicBase
		Data.CHARACTER_1_STRENGTH = strengthBase
		Data.CHARACTER_1_AGILITY = agilityBase
		Data.CHARACTER_1_INTELLIGENCE = intelligenceBase
		Data.CHARACTER_1_LUCK = luckBase
		Data.CHARACTER_1_RULES = rules
		Data.CHARACTER_1_WEAPON = weapon
		Data.CHARACTER_1_ARMOR = armor
		Data.CHARACTER_1_EQUIPABLE = equiplables
		Data.CHARACTER_1_ACCESSORY = {}
		Data.CHARACTER_1_ACTIONS = availableActions
	elif position == 1:
		Data.CHARACTER_2_TYPE = type
		Data.CHARACTER_2_NAME = name
		Data.CHARACTER_2_LV = 1
		Data.CHARACTER_2_XP = 0
		Data.CHARACTER_2_XP_NEXT = next
		Data.CHARACTER_2_HEALTH_MAX = healthBase
		Data.CHARACTER_2_HEALTH_CURRENT = healthBase
		Data.CHARACTER_2_MAGIC_MAX = magicBase
		Data.CHARACTER_2_MAGIC_CURRENT = magicBase
		Data.CHARACTER_2_STRENGTH = strengthBase
		Data.CHARACTER_2_AGILITY = agilityBase
		Data.CHARACTER_2_INTELLIGENCE = intelligenceBase
		Data.CHARACTER_2_LUCK = luckBase
		Data.CHARACTER_2_RULES = rules
		Data.CHARACTER_2_WEAPON = weapon
		Data.CHARACTER_2_ARMOR = armor
		Data.CHARACTER_2_EQUIPABLE = equiplables
		Data.CHARACTER_2_ACCESSORY = {}
		Data.CHARACTER_2_ACTIONS = availableActions
	elif position == 2:
		Data.CHARACTER_3_TYPE = type
		Data.CHARACTER_3_NAME = name
		Data.CHARACTER_3_LV = 1
		Data.CHARACTER_3_XP = 0
		Data.CHARACTER_3_XP_NEXT = next
		Data.CHARACTER_3_HEALTH_MAX = healthBase
		Data.CHARACTER_3_HEALTH_CURRENT = healthBase
		Data.CHARACTER_3_MAGIC_MAX = magicBase
		Data.CHARACTER_3_MAGIC_CURRENT = magicBase
		Data.CHARACTER_3_STRENGTH = strengthBase
		Data.CHARACTER_3_AGILITY = agilityBase
		Data.CHARACTER_3_INTELLIGENCE = intelligenceBase
		Data.CHARACTER_3_LUCK = luckBase
		Data.CHARACTER_3_RULES = rules
		Data.CHARACTER_3_WEAPON = weapon
		Data.CHARACTER_3_ARMOR = armor
		Data.CHARACTER_3_EQUIPABLE = equiplables
		Data.CHARACTER_3_ACCESSORY = {}
		Data.CHARACTER_3_ACTIONS = availableActions
	elif position == 3:
		Data.CHARACTER_4_TYPE = type
		Data.CHARACTER_4_NAME = name
		Data.CHARACTER_4_LV = 1
		Data.CHARACTER_4_XP = 0
		Data.CHARACTER_4_XP_NEXT = next
		Data.CHARACTER_4_HEALTH_MAX = healthBase
		Data.CHARACTER_4_HEALTH_CURRENT = healthBase
		Data.CHARACTER_4_MAGIC_MAX = magicBase
		Data.CHARACTER_4_MAGIC_CURRENT = magicBase
		Data.CHARACTER_4_STRENGTH = strengthBase
		Data.CHARACTER_4_AGILITY = agilityBase
		Data.CHARACTER_4_INTELLIGENCE = intelligenceBase
		Data.CHARACTER_4_LUCK = luckBase
		Data.CHARACTER_4_RULES = rules
		Data.CHARACTER_4_WEAPON = weapon
		Data.CHARACTER_4_ARMOR = armor
		Data.CHARACTER_4_EQUIPABLE = equiplables
		Data.CHARACTER_4_ACCESSORY = {}
		Data.CHARACTER_4_ACTIONS = availableActions
	
func isCharacterAlive(position:int) -> bool:
	if position == 0:
		return Data.CHARACTER_1_HEALTH_CURRENT > 0
	elif position == 1:
		return Data.CHARACTER_2_HEALTH_CURRENT > 0
	elif position == 2:
		return Data.CHARACTER_3_HEALTH_CURRENT > 0
	else:
		return Data.CHARACTER_4_HEALTH_CURRENT > 0
	
func getCharacterNameByPositionAndClass(type:Enums.CLASSES, position:int) -> String:
	if position == 0:
		if type == Enums.CLASSES.WARRIOR:
			return Text.CLASS_WARRIOR_NAME_1
		elif type == Enums.CLASSES.KNIGHT:
			return Text.CLASS_KNIGHT_NAME_1
		elif type == Enums.CLASSES.HUNTER:
			return Text.CLASS_HUNTER_NAME_1
		elif type == Enums.CLASSES.WIZARD:
			return Text.CLASS_WIZARD_NAME_1
		elif type == Enums.CLASSES.THIEF:
			return Text.CLASS_THIEF_NAME_1
		elif type == Enums.CLASSES.CLERIC:
			return Text.CLASS_CLERIC_NAME_1
	elif position == 1:
		if type == Enums.CLASSES.WARRIOR:
			return Text.CLASS_WARRIOR_NAME_2
		elif type == Enums.CLASSES.KNIGHT:
			return Text.CLASS_KNIGHT_NAME_2
		elif type == Enums.CLASSES.HUNTER:
			return Text.CLASS_HUNTER_NAME_2
		elif type == Enums.CLASSES.WIZARD:
			return Text.CLASS_WIZARD_NAME_2
		elif type == Enums.CLASSES.THIEF:
			return Text.CLASS_THIEF_NAME_2
		elif type == Enums.CLASSES.CLERIC:
			return Text.CLASS_CLERIC_NAME_2
	elif position == 2:
		if type == Enums.CLASSES.WARRIOR:
			return Text.CLASS_WARRIOR_NAME_3
		elif type == Enums.CLASSES.KNIGHT:
			return Text.CLASS_KNIGHT_NAME_3
		elif type == Enums.CLASSES.HUNTER:
			return Text.CLASS_HUNTER_NAME_3
		elif type == Enums.CLASSES.WIZARD:
			return Text.CLASS_WIZARD_NAME_3
		elif type == Enums.CLASSES.THIEF:
			return Text.CLASS_THIEF_NAME_3
		elif type == Enums.CLASSES.CLERIC:
			return Text.CLASS_CLERIC_NAME_3
	elif position == 3:
		if type == Enums.CLASSES.WARRIOR:
			return Text.CLASS_WARRIOR_NAME_4
		elif type == Enums.CLASSES.KNIGHT:
			return Text.CLASS_KNIGHT_NAME_4
		elif type == Enums.CLASSES.HUNTER:
			return Text.CLASS_HUNTER_NAME_4
		elif type == Enums.CLASSES.WIZARD:
			return Text.CLASS_WIZARD_NAME_4
		elif type == Enums.CLASSES.THIEF:
			return Text.CLASS_THIEF_NAME_4
		elif type == Enums.CLASSES.CLERIC:
			return Text.CLASS_CLERIC_NAME_4
			
	return ""
	
	
func getCharacterByPosition(position:int) -> Dictionary:
	var name:String = ""
	var health:int = 0
	var healthMax:int = 0
	var magic:int = 0
	var magicMax:int = 0
	var type:Enums.CLASSES = Enums.CLASSES.NONE
	var attack:int = 0
	var defence:int = 0
	var strength:int = 0
	var luck:int = 0
	var agility:int = 0
	var intelligence:int = 0
	var rules:Array = []
	
	var _lv:int = 1
	var _xp:int = 0
	var _next:int = 0
	var _class:String = ""
	var weapon:String = ""
	var armor:String = ""
	var accessory:String = ""
	var actions:Array = []
	
	if position == 0:
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_1_LV * 0.1
		
		magic = Data.CHARACTER_1_MAGIC_CURRENT
		magicMax = Data.CHARACTER_1_MAGIC_MAX
		healthMax = Data.CHARACTER_1_HEALTH_MAX
		_lv = Data.CHARACTER_1_LV
		_xp =  Data.CHARACTER_1_XP
		_next = Data.CHARACTER_1_XP_NEXT
		_class = getClassName(Data.CHARACTER_1_TYPE)
		
		if Data.CHARACTER_1_WEAPON != null && Data.CHARACTER_1_WEAPON.size() > 0:
			weapon = Data.CHARACTER_1_WEAPON.name
			attack = (Data.CHARACTER_1_STRENGTH + Data.CHARACTER_1_WEAPON.value) * levelMultiplyer
		else:
			attack = Data.CHARACTER_1_STRENGTH * levelMultiplyer
		
		if Data.CHARACTER_1_ARMOR != null && Data.CHARACTER_1_ARMOR.size() > 0:
			armor = Data.CHARACTER_1_ARMOR.name
			defence = Data.CHARACTER_1_ARMOR.value * levelMultiplyer
		else:
			defence = 1  * levelMultiplyer
		
		if Data.CHARACTER_1_ACCESSORY != null && Data.CHARACTER_1_ACCESSORY.size() > 0:
			accessory = Data.CHARACTER_1_ACCESSORY.name
		
		health = Data.CHARACTER_1_HEALTH_CURRENT
		type = Data.CHARACTER_1_TYPE
		name = Data.CHARACTER_1_NAME
		strength = Data.CHARACTER_1_STRENGTH
		agility = Data.CHARACTER_1_AGILITY
		intelligence = Data.CHARACTER_1_INTELLIGENCE
		luck = Data.CHARACTER_1_LUCK
		rules = Data.CHARACTER_1_RULES
		actions = Data.CHARACTER_1_ACTIONS
	elif position == 1:
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_2_LV * 0.1
		
		magic = Data.CHARACTER_2_MAGIC_CURRENT
		magicMax = Data.CHARACTER_2_MAGIC_MAX
		healthMax = Data.CHARACTER_2_HEALTH_MAX
		_lv = Data.CHARACTER_2_LV
		_xp =  Data.CHARACTER_2_XP
		_next = Data.CHARACTER_2_XP_NEXT
		_class = getClassName(Data.CHARACTER_2_TYPE)
		
		if Data.CHARACTER_2_WEAPON != null && Data.CHARACTER_2_WEAPON.size() > 0:
			weapon = Data.CHARACTER_2_WEAPON.name
			attack = (Data.CHARACTER_2_STRENGTH + Data.CHARACTER_2_WEAPON.value) * levelMultiplyer
		else:
			attack = Data.CHARACTER_2_STRENGTH * levelMultiplyer
		
		if Data.CHARACTER_2_ARMOR != null && Data.CHARACTER_2_ARMOR.size() > 0:
			armor = Data.CHARACTER_2_ARMOR.name
			defence = Data.CHARACTER_2_ARMOR.value * levelMultiplyer
		else:
			defence = 1 * levelMultiplyer
			
		if Data.CHARACTER_2_ACCESSORY != null && Data.CHARACTER_2_ACCESSORY.size() > 0:
			accessory = Data.CHARACTER_2_ACCESSORY.name
			
		health = Data.CHARACTER_2_HEALTH_CURRENT
		type = Data.CHARACTER_2_TYPE
		name = Data.CHARACTER_2_NAME
		attack = Data.CHARACTER_2_STRENGTH
		defence = 1
		strength = Data.CHARACTER_2_STRENGTH
		agility = Data.CHARACTER_2_AGILITY
		intelligence = Data.CHARACTER_2_INTELLIGENCE
		luck = Data.CHARACTER_2_LUCK
		rules = Data.CHARACTER_2_RULES
		actions = Data.CHARACTER_2_ACTIONS
	elif position == 2:
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_3_LV * 0.1
		
		magic = Data.CHARACTER_3_MAGIC_CURRENT
		magicMax = Data.CHARACTER_3_MAGIC_MAX
		healthMax = Data.CHARACTER_3_HEALTH_MAX
		_lv = Data.CHARACTER_3_LV
		_xp =  Data.CHARACTER_3_XP
		_next = Data.CHARACTER_3_XP_NEXT
		_class = getClassName(Data.CHARACTER_3_TYPE)
		
		if Data.CHARACTER_3_WEAPON != null && Data.CHARACTER_3_WEAPON.size() > 0:
			weapon = Data.CHARACTER_3_WEAPON.name
			attack = Data.CHARACTER_3_STRENGTH + Data.CHARACTER_3_WEAPON.value * levelMultiplyer
		else:
			attack = Data.CHARACTER_3_STRENGTH * levelMultiplyer
		
		if Data.CHARACTER_3_ARMOR != null && Data.CHARACTER_3_ARMOR.size() > 0:
			armor = Data.CHARACTER_3_ARMOR.name
			defence = Data.CHARACTER_3_ARMOR.value * levelMultiplyer
		else:
			defence = 1 * levelMultiplyer
			
		if Data.CHARACTER_3_ACCESSORY != null && Data.CHARACTER_3_ACCESSORY.size() > 0:
			accessory = Data.CHARACTER_3_ACCESSORY.name
			
		health = Data.CHARACTER_3_HEALTH_CURRENT
		type = Data.CHARACTER_3_TYPE
		name = Data.CHARACTER_3_NAME
		attack = Data.CHARACTER_3_STRENGTH
		defence = 1
		strength = Data.CHARACTER_3_STRENGTH
		agility = Data.CHARACTER_3_AGILITY
		intelligence = Data.CHARACTER_3_INTELLIGENCE
		luck = Data.CHARACTER_3_LUCK
		rules = Data.CHARACTER_3_RULES
		actions = Data.CHARACTER_3_ACTIONS
	else:
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_4_LV * 0.1
		
		magic = Data.CHARACTER_4_MAGIC_CURRENT
		magicMax = Data.CHARACTER_4_MAGIC_MAX
		healthMax = Data.CHARACTER_4_HEALTH_MAX
		_lv = Data.CHARACTER_4_LV
		_xp =  Data.CHARACTER_4_XP
		_next = Data.CHARACTER_4_XP_NEXT
		_class = getClassName(Data.CHARACTER_4_TYPE)
		
		if Data.CHARACTER_4_WEAPON != null && Data.CHARACTER_4_WEAPON.size() > 0:
			weapon = Data.CHARACTER_4_WEAPON.name
			attack = Data.CHARACTER_4_STRENGTH + Data.CHARACTER_4_WEAPON.value * levelMultiplyer
		else:
			attack = Data.CHARACTER_4_STRENGTH * levelMultiplyer
		
		if Data.CHARACTER_4_ARMOR != null && Data.CHARACTER_4_ARMOR.size() > 0:
			armor = Data.CHARACTER_4_ARMOR.name
			defence = Data.CHARACTER_4_ARMOR.value * levelMultiplyer
		else:
			defence = 1 * levelMultiplyer
			
		if Data.CHARACTER_4_ACCESSORY != null && Data.CHARACTER_4_ACCESSORY.size() > 0:
			accessory = Data.CHARACTER_4_ACCESSORY.name
			
		health = Data.CHARACTER_4_HEALTH_CURRENT
		type = Data.CHARACTER_4_TYPE
		name = Data.CHARACTER_4_NAME
		attack = Data.CHARACTER_4_STRENGTH
		defence = 1
		strength = Data.CHARACTER_4_STRENGTH
		agility = Data.CHARACTER_4_AGILITY
		intelligence = Data.CHARACTER_4_INTELLIGENCE
		luck = Data.CHARACTER_4_LUCK
		rules = Data.CHARACTER_4_RULES
		actions = Data.CHARACTER_4_ACTIONS
	return {
		"lv": _lv,
		"xp": _xp,
		"next": _next,
		"class": _class,
		"name": name,
		"health": health,
		"healthMax" : healthMax,
		"magic": magic,
		"magicMax": magicMax,
		"type": type,
		"attack": attack,
		"defence": defence,
		"strength": strength,
		"agility": agility,
		"intelligence": intelligence,
		"luck": luck,
		"rules": rules,
		"actions": actions,
		"weapon": weapon,
		"armor": armor,
		"accessory": accessory
	}
	
