extends Node

var rng = RandomNumberGenerator.new()


func _ready():
	pass # Replace with function body.
	
func percentage(part:int, whole:int) -> int:
	if part == 0 || whole == 0:
		return 0
	return (part / whole) * 100
	
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
		var lowest:Dictionary = { "p":-1, "hp": -1 }
		var characters:Array = [
			{ "p":0, "hp": Data.CHARACTER_1_HEALTH_CURRENT },
			{ "p":1, "hp": Data.CHARACTER_2_HEALTH_CURRENT },
			{ "p":2, "hp": Data.CHARACTER_3_HEALTH_CURRENT },
			{ "p":3, "hp": Data.CHARACTER_4_HEALTH_CURRENT },
		]
		for x in characters:
			if x.hp > 0 && x.hp < lowest.hp:
				lowest = x
		if lowest.p != -1:
			var potion = InventoryHandler.withdrawItem(Statics.ITEMS.POTION.name)
			Events.emit_signal("PARTY_ADD_HEALTH", lowest.p, potion.value) # position:int, value:int
			Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(lowest.p), " drinks a potion."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			
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
		
			
		
	
	
	
	


