extends Node

var rng = RandomNumberGenerator.new()
var defaultMinValue:int = 99999

func _ready():
	pass # Replace with function body.
	
func percentage(part:int, whole:int) -> int:
	if part == 0 || whole == 0:
		return 0
	return (part / whole) * 100
		
func getCharacterStates() -> Array:
	return [
		{ "position":0, "health": Data.CHARACTER_1_HEALTH_CURRENT, "magic": Data.CHARACTER_1_MAGIC_CURRENT, "levelMultiplyer": 1.0 + Data.CHARACTER_1_LV * 0.1 },
		{ "position":1, "health": Data.CHARACTER_2_HEALTH_CURRENT, "magic": Data.CHARACTER_2_MAGIC_CURRENT, "levelMultiplyer": 1.0 + Data.CHARACTER_2_LV * 0.1 },
		{ "position":2, "health": Data.CHARACTER_3_HEALTH_CURRENT, "magic": Data.CHARACTER_3_MAGIC_CURRENT, "levelMultiplyer": 1.0 + Data.CHARACTER_3_LV * 0.1 },
		{ "position":3, "health": Data.CHARACTER_4_HEALTH_CURRENT, "magic": Data.CHARACTER_4_MAGIC_CURRENT, "levelMultiplyer": 1.0 + Data.CHARACTER_4_LV * 0.1 },
	]
			
func getPositionWithLowestHealthAny() -> int:
	var lowest:Dictionary = { "position":-1, "health": defaultMinValue }
	var characters = getCharacterStates()
	for x in characters:
		if x.health < lowest.health:
			lowest = x
	return lowest.position
	
func getPositionWithLowestHealthExcept(exceptPosition:int) -> int:
	var lowest:Dictionary = { "position":-1, "health": defaultMinValue }
	var characters = getCharacterStates()
	for x in characters:
		if x.position != exceptPosition && x.health < lowest.health:
			lowest = x
	return lowest.position
	
func getPositionWithLowestMagicAny() -> int:
	var lowest:Dictionary = { "position":-1, "magic": defaultMinValue }
	var characters = getCharacterStates()
	for x in characters:
		if x.magic < lowest.magic:
			lowest = x
	return lowest.position
	
func getPositionWithLowestMagicExcept(exceptPosition:int) -> int:
	var lowest:Dictionary = { "position":-1, "magic": defaultMinValue }
	var characters = getCharacterStates()
	for x in characters:
		if x.position != exceptPosition && x.magic < lowest.magic:
			lowest = x
	return lowest.position
	
##
## resolve ATTACK action
##	
func resolveAttackAction(attack:int, defence:int, attackerDexterity:int, attackerLuck:int, attackerName:String, defenderName:String) -> int:
	var checkHit = CharacterHandler.skillCheck(attackerDexterity)
	if checkHit == Enums.SYSTEM_SKILL_CHECK_RESULT.SUCCESS:
		var damage = attack + rng.randi_range(1, attackerLuck) - defence
		if damage > 0:
			Events.emit_signal("SYSTEM_WRITE_LOG", str(attackerName, " hits ", defenderName, " for ", damage, " damage."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			return damage
	elif checkHit == Enums.SYSTEM_SKILL_CHECK_RESULT.CRITICAL: 
		var damage = attack + rng.randi_range(1, attackerLuck)
		if damage > 0:
			Events.emit_signal("SYSTEM_WRITE_LOG", str(attackerName, " criticly hits ", defenderName, " for ", damage, " damage."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			return damage
	
	Events.emit_signal("SYSTEM_WRITE_LOG", str(attackerName, " attacks ", defenderName, " and misses."), Enums.SYSTEM_LOG_TYPE.BATTLE)
	return 0
	
func resolvePotionSelfAction(position:int) -> void:
	if InventoryHandler.itemExists("Potion"):
		var item = InventoryHandler.withdrawItem("Potion")
		Events.emit_signal("PARTY_ADD_HEALTH", position, item.value)
		Events.emit_signal("UPDATE_HP_BOX")
		Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position), " drinks a potion."), Enums.SYSTEM_LOG_TYPE.BATTLE)

func resolveUsePotionAllyAction() -> void:
	if InventoryHandler.itemExists(Statics.ITEMS.POTION.name):
		var targetPosition = getPositionWithLowestHealthAny()
		if targetPosition != defaultMinValue:
			var potion = InventoryHandler.withdrawItem(Statics.ITEMS.POTION.name)
			Events.emit_signal("PARTY_ADD_HEALTH", targetPosition, potion.value) # position:int, value:int
			Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(targetPosition), " drinks a potion."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			
func resolveUseElexir(position:int) -> void:
	if InventoryHandler.itemExists(Statics.ITEMS.ELEXIR.name):
		var characters:Array = []
		if Data.CHARACTER_1_HEALTH_CURRENT <= 0 && position != 0:
			characters.push_back(0)
		if Data.CHARACTER_2_HEALTH_CURRENT <= 0 && position != 1:
			characters.push_back(1)
		if Data.CHARACTER_3_HEALTH_CURRENT <= 0 && position != 2:
			characters.push_back(2)
		if Data.CHARACTER_4_HEALTH_CURRENT <= 0 && position != 3:
			characters.push_back(3)
		characters.shuffle()
		if characters.size() > 0:
			var elexir = InventoryHandler.withdrawItem(Statics.ITEMS.ELEXIR.name)
			Events.emit_signal("PARTY_REVIVE_CHARACTER", characters[0], elexir.value)
			Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position), " uses an elexir on ", CharacterHandler.getCharacterName(characters[0]), "."), Enums.SYSTEM_LOG_TYPE.BATTLE)
		
func resolveHerbSelfAction(position:int) -> void:
	if InventoryHandler.itemExists(Statics.ITEMS.HERB.name):
		var item = InventoryHandler.withdrawItem(Statics.ITEMS.HERB.name)
		Events.emit_signal("PARTY_ADD_MAGIC", position, item.value)
		Events.emit_signal("UPDATE_HP_BOX")
		Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position), " uses a herb."), Enums.SYSTEM_LOG_TYPE.BATTLE)

func resolveUseHerbAllyAction() -> void:
	if InventoryHandler.itemExists(Statics.ITEMS.POTION.name):

		var lowest = getPositionWithLowestHealthAny()
		

		if lowest.position != -1:
			var herb = InventoryHandler.withdrawItem(Statics.ITEMS.POTION.name)
			Events.emit_signal("PARTY_ADD_MAGIC", lowest.p, herb.value) # position:int, value:int
			Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(lowest.p), " drinks a potion."), Enums.SYSTEM_LOG_TYPE.BATTLE)

func resolveCastHealAction(position:int) -> void:
	var effect:int = 0
	
	if position == 0 && Data.CHARACTER_1_MAGIC_CURRENT >= Statics.SPELLS.HEAL.cost:
		Data.CHARACTER_1_MAGIC_CURRENT -= Statics.SPELLS.HEAL.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_1_LV * 0.1
		effect = (Data.CHARACTER_1_INTELLIGENCE * Statics.SPELLS.HEAL.effect) * levelMultiplyer
	
	if position == 1 && Data.CHARACTER_2_MAGIC_CURRENT >= Statics.SPELLS.HEAL.cost:
		Data.CHARACTER_2_MAGIC_CURRENT -= Statics.SPELLS.HEAL.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_2_LV * 0.1
		effect = (Data.CHARACTER_2_INTELLIGENCE * Statics.SPELLS.HEAL.effect) * levelMultiplyer
		
	if position == 2 && Data.CHARACTER_3_MAGIC_CURRENT >= Statics.SPELLS.HEAL.cost:
		Data.CHARACTER_3_MAGIC_CURRENT -= Statics.SPELLS.HEAL.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_3_LV * 0.1
		effect = (Data.CHARACTER_3_INTELLIGENCE * Statics.SPELLS.HEAL.effect) * levelMultiplyer
		
	if position == 3 && Data.CHARACTER_4_MAGIC_CURRENT >= Statics.SPELLS.HEAL.cost:
		Data.CHARACTER_4_MAGIC_CURRENT -= Statics.SPELLS.HEAL.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_4_LV * 0.1
		effect = (Data.CHARACTER_4_INTELLIGENCE * Statics.SPELLS.HEAL.effect) * levelMultiplyer
	
	if effect > 0:
		var randomness = rng.randi_range(-Statics.SPELLS.HEAL.randomness, Statics.SPELLS.HEAL.randomness)
		effect = effect + randomness
		var targetPosition = getPositionWithLowestHealthAny()
		Events.emit_signal("PARTY_ADD_HEALTH", targetPosition, effect) # position:int, value:int
		Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position), " casts heal on ", str(CharacterHandler.getCharacterName(targetPosition)), Enums.SYSTEM_LOG_TYPE.BATTLE))

	
	#CAST_FIREBALL,

	#CAST_REVIVE,
	#PROTECT,
	#DEFEND,
	#STEAL,
	#BACK_STAB,
	
	
	
	


