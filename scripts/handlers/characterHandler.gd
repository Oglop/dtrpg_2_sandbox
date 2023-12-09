extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
	
func getStartingWeaponByClass(type:Enums.CLASSES) -> Dictionary:
	if type == Enums.CLASSES.WARRIOR:
		return Statics.ITEMS.SHORT_SWORD
	elif type == Enums.CLASSES.KNIGHT:
		return Statics.ITEMS.SPEAR
	elif type == Enums.CLASSES.WIZARD:
		return Statics.ITEMS.STAFF
	elif type == Enums.CLASSES.HUNTER:
		return Statics.ITEMS.SPEAR
	elif type == Enums.CLASSES.THIEF:
		return Statics.ITEMS.SHORT_SWORD
	elif type == Enums.CLASSES.CLERIC:
		return Statics.ITEMS.CLUB
	return {}
	
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
	if position == 0:
		Data.CHARACTER_1_TYPE = type
		Data.CHARACTER_1_NAME = name
		Data.CHARACTER_1_LV = 1
		Data.CHARACTER_1_XP = 0
		Data.CHARACTER_1_XP_NEXT = 0
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
		Data.CHARACTER_1_ACCESSORY = {}
	elif position == 1:
		Data.CHARACTER_2_TYPE = type
		Data.CHARACTER_2_NAME = name
		Data.CHARACTER_2_LV = 1
		Data.CHARACTER_2_XP = 0
		Data.CHARACTER_2_XP_NEXT = 0
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
		Data.CHARACTER_2_ACCESSORY = {}
	elif position == 2:
		Data.CHARACTER_3_TYPE = type
		Data.CHARACTER_3_NAME = name
		Data.CHARACTER_3_LV = 1
		Data.CHARACTER_3_XP = 0
		Data.CHARACTER_3_XP_NEXT = 0
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
		Data.CHARACTER_3_ACCESSORY = {}
	elif position == 3:
		Data.CHARACTER_4_TYPE = type
		Data.CHARACTER_4_NAME = name
		Data.CHARACTER_4_LV = 1
		Data.CHARACTER_4_XP = 0
		Data.CHARACTER_4_XP_NEXT = 0
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
		Data.CHARACTER_4_ACCESSORY = {}
	
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
	var type:Enums.CLASSES = Enums.CLASSES.NONE
	var attack:int = 0
	var defence:int = 0
	var strength:int = 0
	var luck:int = 0
	var agility:int = 0
	var intelligence:int = 0
	var rules:Array = []
	
	if position == 0:
		var levelMultiplyer = (Data.CHARACTER_1_LV / 10)
		if Data.CHARACTER_1_WEAPON != null && Data.CHARACTER_1_WEAPON.size() > 0:
			attack = (Data.CHARACTER_1_STRENGTH + Data.CHARACTER_1_WEAPON.value) * levelMultiplyer
		else:
			attack = Data.CHARACTER_1_STRENGTH * levelMultiplyer
		
		if Data.CHARACTER_1_ARMOR != null && Data.CHARACTER_1_ARMOR.size() > 0:
			defence = Data.CHARACTER_1_ARMOR.value * levelMultiplyer
		else:
			defence = 1  * levelMultiplyer
		
		health = Data.CHARACTER_1_HEALTH_CURRENT
		type = Data.CHARACTER_1_TYPE
		name = Data.CHARACTER_1_NAME
		strength = Data.CHARACTER_1_STRENGTH
		agility = Data.CHARACTER_1_AGILITY
		intelligence = Data.CHARACTER_1_INTELLIGENCE
		luck = Data.CHARACTER_1_LUCK
		rules = Data.CHARACTER_1_RULES
	elif position == 1:
		var levelMultiplyer = (Data.CHARACTER_2_LV / 10)
		if Data.CHARACTER_2_WEAPON != null && Data.CHARACTER_2_WEAPON.size() > 0:
			attack = (Data.CHARACTER_2_STRENGTH + Data.CHARACTER_2_WEAPON.value) * levelMultiplyer
		else:
			attack = Data.CHARACTER_2_STRENGTH * levelMultiplyer
		
		if Data.CHARACTER_2_ARMOR != null && Data.CHARACTER_2_ARMOR.size() > 0:
			defence = Data.CHARACTER_2_ARMOR.value * levelMultiplyer
		else:
			defence = 1 * levelMultiplyer
			
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
	elif position == 2:
		var levelMultiplyer = Data.CHARACTER_3_LV / 10
		if Data.CHARACTER_3_WEAPON != null && Data.CHARACTER_3_WEAPON.size() > 0:
			attack = Data.CHARACTER_3_STRENGTH + Data.CHARACTER_3_WEAPON.value * levelMultiplyer
		else:
			attack = Data.CHARACTER_3_STRENGTH * levelMultiplyer
		
		if Data.CHARACTER_3_ARMOR != null && Data.CHARACTER_3_ARMOR.size() > 0:
			defence = Data.CHARACTER_3_ARMOR.value * levelMultiplyer
		else:
			defence = 1 * levelMultiplyer
			
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
	else:
		var levelMultiplyer = Data.CHARACTER_4_LV / 10
		if Data.CHARACTER_4_WEAPON != null && Data.CHARACTER_4_WEAPON.size() > 0:
			attack = Data.CHARACTER_4_STRENGTH + Data.CHARACTER_4_WEAPON.value * levelMultiplyer
		else:
			attack = Data.CHARACTER_4_STRENGTH * levelMultiplyer
		
		if Data.CHARACTER_4_ARMOR != null && Data.CHARACTER_4_ARMOR.size() > 0:
			defence = Data.CHARACTER_4_ARMOR.value * levelMultiplyer
		else:
			defence = 1 * levelMultiplyer
			
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
	
