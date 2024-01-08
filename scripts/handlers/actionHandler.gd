extends Node

var rng = RandomNumberGenerator.new()
var defaultMinValue:int = 99999

func _ready():
	pass # Replace with function body.
	
func getPartyMemberGlobalPosition(position:int) -> Vector2:
	return Vector2(Globals.X_POSITIONS[position], Globals.Y_POSITIONS[position])
	
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
func resolveAttackAction(attack:int, defence:int, attackerDexterity:int, attackerLuck:int, attackerName:String, defenderName:String, enemyPosition:Vector2) -> int:
	var checkHit = CharacterHandler.skillCheck(attackerDexterity)
	if checkHit == Enums.SYSTEM_SKILL_CHECK_RESULT.SUCCESS:
		var damage = attack + rng.randi_range(1, attackerLuck) - defence
		if damage > 0:
			Events.emit_signal("QUEUE_DAMAGE_NUMBER", enemyPosition, damage, false, false)
			Events.emit_signal("QUEUE_FX", enemyPosition, Enums.BATTLE_DAMAGE_FXS.CUT)
			Events.emit_signal("SYSTEM_WRITE_LOG", str(attackerName, " hits ", defenderName, " for ", damage, " damage."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			return damage
	elif checkHit == Enums.SYSTEM_SKILL_CHECK_RESULT.CRITICAL: 
		var damage = attack + rng.randi_range(1, attackerLuck)
		if damage > 0:
			Events.emit_signal("QUEUE_DAMAGE_NUMBER", enemyPosition, damage, false, true)
			Events.emit_signal("QUEUE_FX", enemyPosition, Enums.BATTLE_DAMAGE_FXS.CUT)
			Events.emit_signal("SYSTEM_WRITE_LOG", str(attackerName, " criticly hits ", defenderName, " for ", damage, " damage."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			return damage
	
	Events.emit_signal("SYSTEM_WRITE_LOG", str(attackerName, " attacks ", defenderName, " and misses."), Enums.SYSTEM_LOG_TYPE.BATTLE)
	return 0

	
func resolvePotionSelfAction(position:int) -> void:
	if InventoryHandler.itemExists("Potion"):
		var item = InventoryHandler.withdrawItem("Potion")
		Events.emit_signal("PARTY_ADD_HEALTH", position, item.value)
		Events.emit_signal("UPDATE_HP_BOX")
		Events.emit_signal("QUEUE_DAMAGE_NUMBER", getPartyMemberGlobalPosition(position), item.value, true, false)
		Events.emit_signal("PARTY_USED_ITEM", 0)
		Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position), " drinks a potion."), Enums.SYSTEM_LOG_TYPE.BATTLE)

func resolveUsePotionAllyAction() -> void:
	if InventoryHandler.itemExists(Statics.ITEMS.POTION.name):
		var targetPosition = getPositionWithLowestHealthAny()
		if targetPosition != defaultMinValue:
			var potion = InventoryHandler.withdrawItem(Statics.ITEMS.POTION.name)
			Events.emit_signal("QUEUE_DAMAGE_NUMBER", getPartyMemberGlobalPosition(targetPosition), potion.value, true, false)
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
			Events.emit_signal("QUEUE_DAMAGE_NUMBER", getPartyMemberGlobalPosition(characters[0]), elexir.value, true, false)
			Events.emit_signal("PARTY_REVIVE_CHARACTER", characters[0], elexir.value)
			Events.emit_signal("PARTY_USED_ITEM", 0)
			Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position), " uses an elexir on ", CharacterHandler.getCharacterName(characters[0]), "."), Enums.SYSTEM_LOG_TYPE.BATTLE)
		
func resolveHerbSelfAction(position:int) -> void:
	if InventoryHandler.itemExists(Statics.ITEMS.HERB.name):
		var item = InventoryHandler.withdrawItem(Statics.ITEMS.HERB.name)
		Events.emit_signal("PARTY_ADD_MAGIC", position, item.value)
		Events.emit_signal("QUEUE_DAMAGE_NUMBER", getPartyMemberGlobalPosition(position), item.value, true, false)
		Events.emit_signal("UPDATE_HP_BOX")
		Events.emit_signal("PARTY_USED_ITEM", 0)
		Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position), " uses a herb."), Enums.SYSTEM_LOG_TYPE.BATTLE)

func resolveUseHerbAllyAction() -> void:
	if InventoryHandler.itemExists(Statics.ITEMS.POTION.name):
		var lowest = getPositionWithLowestHealthAny()
		
		if lowest != defaultMinValue:
			var herb = InventoryHandler.withdrawItem(Statics.ITEMS.POTION.name)
			Events.emit_signal("QUEUE_DAMAGE_NUMBER", getPartyMemberGlobalPosition(lowest), herb.value, true, false)
			Events.emit_signal("PARTY_ADD_MAGIC", lowest, herb.value) # position:int, value:int
			Events.emit_signal("PARTY_USED_ITEM", 0)
			Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(lowest), " drinks a potion."), Enums.SYSTEM_LOG_TYPE.BATTLE)

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
		Events.emit_signal("QUEUE_DAMAGE_NUMBER", getPartyMemberGlobalPosition(targetPosition), effect, true, false)
		Events.emit_signal("PARTY_ADD_HEALTH", targetPosition, effect) # position:int, value:int
		Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position), " casts heal on ", str(CharacterHandler.getCharacterName(targetPosition)), Enums.SYSTEM_LOG_TYPE.BATTLE))

func resolveCastFireballAction(position:int, attackerName:String, enemyDetail:Dictionary, enemyPosition:Vector2) -> int:
	var spell = Statics.SPELLS.FIREBALL
	var effect:int = 0
	var manaIsSpent:bool = false
	if position == 0 && Data.CHARACTER_1_MAGIC_CURRENT >= spell.cost:
		Data.CHARACTER_1_MAGIC_CURRENT -= spell.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_1_LV * 0.1
		effect = (Data.CHARACTER_1_INTELLIGENCE * spell.effect) * levelMultiplyer
		manaIsSpent = true
	elif position == 1 && Data.CHARACTER_2_MAGIC_CURRENT >= spell.cost:
		Data.CHARACTER_2_MAGIC_CURRENT -= spell.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_2_LV * 0.1
		effect = (Data.CHARACTER_2_INTELLIGENCE * spell.effect) * levelMultiplyer
		manaIsSpent = true
	elif position == 2 && Data.CHARACTER_3_MAGIC_CURRENT >= spell.cost:
		Data.CHARACTER_3_MAGIC_CURRENT -= spell.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER3_LV * 0.1
		effect = (Data.CHARACTER_3_INTELLIGENCE * spell.effect) * levelMultiplyer
		manaIsSpent = true
	elif position == 3 && Data.CHARACTER_4_MAGIC_CURRENT >= spell.cost:
		Data.CHARACTER_4_MAGIC_CURRENT -= spell.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_4_LV * 0.1
		effect = (Data.CHARACTER_4_INTELLIGENCE * spell.effect) * levelMultiplyer
		manaIsSpent = true
		
	if manaIsSpent:
		var randomness = rng.randi_range(-Statics.SPELLS.FIREBALL.randomness, Statics.SPELLS.FIREBALL.randomness)
		effect = effect + randomness
		Events.emit_signal("QUEUE_DAMAGE_NUMBER", enemyPosition, effect, false, false)
		Events.emit_signal("QUEUE_FX", enemyPosition, Enums.BATTLE_DAMAGE_FXS.FIREBALL)
		Events.emit_signal("SYSTEM_WRITE_LOG", str(attackerName, " cast fireball at ", enemyDetail.name, " for ", effect, " damage."), Enums.SYSTEM_LOG_TYPE.BATTLE)
		return effect
		
	Events.emit_signal("SYSTEM_WRITE_LOG", str(attackerName, " are unable to cast spell."), Enums.SYSTEM_LOG_TYPE.BATTLE)
	return 0
	
func resolveStealAction(position:int, attackerDexterity:int, attackerLuck:int) -> void:
	pass
	
func resolveBackstabAction(position:int, attack:int, defence:int, attackerDexterity:int, attackerLuck:int, attackerName:String, defenderName:String, enemyPosition:Vector2) -> int:
	return 0
	

func resolveDoubleStrikeAction(attack:int, defence:int, attackerDexterity:int, attackerLuck:int, attackerName:String, defenderName:String, enemyPosition:Vector2) -> int:
	var dmg = resolveAttackAction(attack, defence, attackerDexterity, attackerLuck, attackerName, defenderName, enemyPosition)
	dmg = resolveAttackAction(attack, defence, attackerDexterity, attackerLuck, attackerName, defenderName, enemyPosition)	
	return dmg
	
func resolveLavawaveAction(position:int, enemy:Dictionary, enemyPosition:Vector2) -> void:
	var spell = Statics.SPELLS.LAVA_WAVE
	var effect:int = 0
	var manaIsSpent:bool = false
	if position == 0 && Data.CHARACTER_1_MAGIC_CURRENT >= spell.cost:
		Data.CHARACTER_1_MAGIC_CURRENT -= spell.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_1_LV * 0.1
		effect = (Data.CHARACTER_1_INTELLIGENCE * spell.effect) * levelMultiplyer
		manaIsSpent = true
	elif position == 1 && Data.CHARACTER_2_MAGIC_CURRENT >= spell.cost:
		Data.CHARACTER_2_MAGIC_CURRENT -= spell.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_2_LV * 0.1
		effect = (Data.CHARACTER_2_INTELLIGENCE * spell.effect) * levelMultiplyer
		manaIsSpent = true
	elif position == 2 && Data.CHARACTER_3_MAGIC_CURRENT >= spell.cost:
		Data.CHARACTER_3_MAGIC_CURRENT -= spell.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER3_LV * 0.1
		effect = (Data.CHARACTER_3_INTELLIGENCE * spell.effect) * levelMultiplyer
		manaIsSpent = true
	elif position == 3 && Data.CHARACTER_4_MAGIC_CURRENT >= spell.cost:
		Data.CHARACTER_4_MAGIC_CURRENT -= spell.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_4_LV * 0.1
		effect = (Data.CHARACTER_4_INTELLIGENCE * spell.effect) * levelMultiplyer
		manaIsSpent = true
		
	if manaIsSpent:
		for e in enemy.enemyDetails:
			var randomness = rng.randi_range(-spell.randomness, spell.randomness)
			effect = effect + randomness
			e.health -= effect
			Events.emit_signal("QUEUE_DAMAGE_NUMBER", enemyPosition, effect, false, false)
			Events.emit_signal("QUEUE_FX", enemyPosition, Enums.BATTLE_DAMAGE_FXS.LAVA_WAVE)
			Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position), " cast lava wave at ", e.name, " for ", effect, " damage."), Enums.SYSTEM_LOG_TYPE.BATTLE)
	else:
		Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position), " are unable to cast spell."), Enums.SYSTEM_LOG_TYPE.BATTLE)
	
	
func resoleStunAction(position:int, enemyDetail:Dictionary, enemyPosition:Vector2) -> void:
	if !enemyDetail.statusEffects.has(Enums.STATUS_EFFECTS.STUN):
		var stunChance:int = 0
		var attackerName:String = ""
		if position == 0:
			stunChance = Data.CHARACTER_1_STRENGTH
			attackerName = Data.CHARACTER_1_NAME
		elif position == 1:
			stunChance = Data.CHARACTER_2_STRENGTH
			attackerName = Data.CHARACTER_2_NAME
		elif position == 2:
			stunChance = Data.CHARACTER_3_STRENGTH
			attackerName = Data.CHARACTER_3_NAME
		elif position == 3:
			stunChance = Data.CHARACTER_4_STRENGTH
			attackerName = Data.CHARACTER_4_NAME
			
		var skillCheckResult = CharacterHandler.skillCheck(stunChance)
		
		if skillCheckResult == Enums.SYSTEM_SKILL_CHECK_RESULT.SUCCESS:
			enemyDetail.statusEffects.append(Enums.STATUS_EFFECTS.STUN)
			Events.emit_signal("SYSTEM_WRITE_LOG", str(attackerName, " stuns ", enemyDetail.name, " with a heavy blow."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			Events.emit_signal("QUEUE_FX", enemyPosition, Enums.BATTLE_DAMAGE_FXS.STUN)
		elif skillCheckResult == Enums.SYSTEM_SKILL_CHECK_RESULT.CRITICAL:
			enemyDetail.statusEffects.append(Enums.STATUS_EFFECTS.STUN)
			enemyDetail.statusEffects.append(Enums.STATUS_EFFECTS.STUN)
			Events.emit_signal("SYSTEM_WRITE_LOG", str(attackerName, " stuns ", enemyDetail.name, " with a heavy blow."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			Events.emit_signal("QUEUE_FX", enemyPosition, Enums.BATTLE_DAMAGE_FXS.STUN)
			
func resolvePoisonAction(position:int, enemy:Dictionary, enemyPosition:Vector2) -> void:
	var intelligence:int = 0
	if position == 0:
		intelligence = Data.CHARACTER_1_INTELLIGENCE
	elif position == 1:
		intelligence = Data.CHARACTER_2_INTELLIGENCE
	elif position == 2:
		intelligence = Data.CHARACTER_3_INTELLIGENCE
	elif position == 3:
		intelligence = Data.CHARACTER_4_INTELLIGENCE
	for detail in enemy.enemyDetails.shuffle():
		if !detail.statusEffects.has(Enums.STATUS_EFFECTS.POISON):
			var skillCheckResult = CharacterHandler.skillCheck(intelligence)
			if skillCheckResult != Enums.SYSTEM_SKILL_CHECK_RESULT.FAIL:
				detail.statusEffects.append(Enums.STATUS_EFFECTS.POISON)
				Events.emit_signal("SYSTEM_WRITE_LOG", str(detail.name, " is hit by the poison."), Enums.SYSTEM_LOG_TYPE.BATTLE)
				Events.emit_signal("QUEUE_FX", enemyPosition, Enums.BATTLE_DAMAGE_FXS.POSION)
			if skillCheckResult != Enums.SYSTEM_SKILL_CHECK_RESULT.CRITICAL:
				break
	
func resolveBarrageAction(position:int, attack:int, agility:int, enemy:Dictionary, enemyPosition:Vector2) -> void:
	Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position)," fires multiple arrows."), Enums.SYSTEM_LOG_TYPE.BATTLE)
	for detail in enemy.enemyDetails:
		if detail.health > 0:
			var skillCheckResult = CharacterHandler.skillCheck(agility)
			var dmg:int = 0
			if skillCheckResult == Enums.SYSTEM_SKILL_CHECK_RESULT.SUCCESS:
				dmg = (attack * 0.5) + rng.randi_range(1, agility) - detail.defence
				detail.health -= dmg
	#				
			if skillCheckResult == Enums.SYSTEM_SKILL_CHECK_RESULT.CRITICAL:
				dmg = attack + rng.randi_range(1, agility) - detail.defence
				detail.health -= dmg
			Events.emit_signal("SYSTEM_WRITE_LOG", str(detail.name, " is hit by the barrage."), Enums.SYSTEM_LOG_TYPE.BATTLE)
		
func resolveMeditateAction(position:int) -> void:
	var intelligence:int = 0
	var levelMultiplyer:float = 0.0
	if position == 0:
		intelligence = Data.CHARACTER_1_INTELLIGENCE
		levelMultiplyer = 1.0 + Data.CHARACTER_1_LV * 0.1
	elif position == 1:
		intelligence = Data.CHARACTER_2_INTELLIGENCE
		levelMultiplyer = 1.0 + Data.CHARACTER_2_LV * 0.1
	elif position == 2:
		intelligence = Data.CHARACTER_3_INTELLIGENCE
		levelMultiplyer = 1.0 + Data.CHARACTER_3_LV * 0.1
	elif position == 3:
		intelligence = Data.CHARACTER_4_INTELLIGENCE
		levelMultiplyer = 1.0 + Data.CHARACTER_4_LV * 0.1
	Events.emit_signal("PARTY_ADD_MAGIC", position, intelligence * levelMultiplyer)
	Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position), " is meditating."), Enums.SYSTEM_LOG_TYPE.BATTLE)
	
func resolveProtectAction(position:int) -> void:
	if position == 0:
		if !Data.CHARACTER_1_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_1_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
			
		if !Data.CHARACTER_2_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_2_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
		if !Data.CHARACTER_3_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_3_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
		if !Data.CHARACTER_4_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_4_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
	elif position == 1:
		if !Data.CHARACTER_2_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_2_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
			
		if !Data.CHARACTER_1_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_1_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
		if !Data.CHARACTER_3_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_3_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
		if !Data.CHARACTER_4_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_4_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
	elif position == 2:
		if !Data.CHARACTER_3_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_3_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
			
		if !Data.CHARACTER_1_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_1_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
		if !Data.CHARACTER_2_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_2_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
		if !Data.CHARACTER_4_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_4_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
	elif position == 3:
		if !Data.CHARACTER_4_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_4_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
			
		if !Data.CHARACTER_1_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_1_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
		if !Data.CHARACTER_2_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_2_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
		if !Data.CHARACTER_3_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.PROTECTING):
			Data.CHARACTER_3_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.PROTECTING)
	Events.emit_signal("SPAWN_DAMAGE_FX_PROTECT", Vector2i(Globals.X_POSITIONS[position], Globals.Y_POSITIONS[position]))
	Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position), " is protecting the party."), Enums.SYSTEM_LOG_TYPE.BATTLE)
		
func resolveDefendAction(position:int) -> void:
	if position == 0:
		if !Data.CHARACTER_1_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.DEFENDING):
			Data.CHARACTER_1_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.DEFENDING)
	elif position == 1:
		if !Data.CHARACTER_2_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.DEFENDING):
			Data.CHARACTER_2_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.DEFENDING)
	elif position == 2:
		if !Data.CHARACTER_3_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.DEFENDING):
			Data.CHARACTER_3_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.DEFENDING)
	elif position == 3:
		if !Data.CHARACTER_4_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.DEFENDING):
			Data.CHARACTER_4_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.DEFENDING)
	Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position), " is defending."), Enums.SYSTEM_LOG_TYPE.BATTLE)
	
func resolveDodgeAction(position:int) -> void:
	if position == 0:
		if !Data.CHARACTER_1_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.DODGE):
			Data.CHARACTER_1_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.DODGE)
	elif position == 1:
		if !Data.CHARACTER_2_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.DODGE):
			Data.CHARACTER_2_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.DODGE)
	elif position == 2:
		if !Data.CHARACTER_3_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.DODGE):
			Data.CHARACTER_3_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.DODGE)
	elif position == 3:
		if !Data.CHARACTER_4_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.DODGE):
			Data.CHARACTER_4_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.DODGE)
	
## bless heal
func resolveBlessAction(position:int) -> void:
	var positions:Array = []
	if position == 0:
		if !Data.CHARACTER_1_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.BLESSED):
			Data.CHARACTER_1_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.BLESSED)
	elif position == 1:
		if !Data.CHARACTER_2_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.BLESSED):
			Data.CHARACTER_2_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.BLESSED)
	elif position == 2:
		if !Data.CHARACTER_3_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.BLESSED):
			Data.CHARACTER_3_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.BLESSED)
	elif position == 3:
		if !Data.CHARACTER_4_STATUS_EFFECTS.has(Enums.STATUS_EFFECTS.BLESSED):
			Data.CHARACTER_4_STATUS_EFFECTS.append(Enums.STATUS_EFFECTS.BLESSED)
			
func resolveBlessedTrigger() -> void:
	pass
			
func resolveHealManyAction(position:int) -> void:
	var effect:int = 0
	
	if position == 0 && Data.CHARACTER_1_MAGIC_CURRENT >= Statics.SPELLS.HEAL_MANY.cost:
		Data.CHARACTER_1_MAGIC_CURRENT -= Statics.SPELLS.HEAL_MANY.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_1_LV * 0.1
		effect = (Data.CHARACTER_1_INTELLIGENCE * Statics.SPELLS.HEAL_MANY.effect) * levelMultiplyer
	
	if position == 1 && Data.CHARACTER_2_MAGIC_CURRENT >= Statics.SPELLS.HEAL_MANY.cost:
		Data.CHARACTER_2_MAGIC_CURRENT -= Statics.SPELLS.HEAL_MANY.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_2_LV * 0.1
		effect = (Data.CHARACTER_2_INTELLIGENCE * Statics.SPELLS.HEAL_MANY.effect) * levelMultiplyer
		
	if position == 2 && Data.CHARACTER_3_MAGIC_CURRENT >= Statics.SPELLS.HEAL_MANY.cost:
		Data.CHARACTER_3_MAGIC_CURRENT -= Statics.SPELLS.HEAL_MANY.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_3_LV * 0.1
		effect = (Data.CHARACTER_3_INTELLIGENCE * Statics.SPELLS.HEAL_MANY.effect) * levelMultiplyer
		
	if position == 3 && Data.CHARACTER_4_MAGIC_CURRENT >= Statics.SPELLS.HEAL_MANY.cost:
		Data.CHARACTER_4_MAGIC_CURRENT -= Statics.SPELLS.HEAL_MANY.cost
		var levelMultiplyer:float = 1.0 + Data.CHARACTER_4_LV * 0.1
		effect = (Data.CHARACTER_4_INTELLIGENCE * Statics.SPELLS.HEAL_MANY.effect) * levelMultiplyer
	
	if effect > 0:
		var randomness = rng.randi_range(-Statics.SPELLS.HEAL_MANY.randomnessHEAL_MANY, Statics.SPELLS.HEAL.randomness)
		effect = effect + randomness
		var targetPosition = getPositionWithLowestHealthAny()
		if Data.CHARACTER_1_HEALTH_CURRENT > 0:
			Events.emit_signal("QUEUE_DAMAGE_NUMBER", getPartyMemberGlobalPosition(0), effect, true, false)
			Events.emit_signal("PARTY_ADD_HEALTH", 0, effect)
			
		if Data.CHARACTER_2_HEALTH_CURRENT > 0:
			Events.emit_signal("QUEUE_DAMAGE_NUMBER", getPartyMemberGlobalPosition(1), effect, true, false)
			Events.emit_signal("PARTY_ADD_HEALTH", 1, effect)
			
		if Data.CHARACTER_3_HEALTH_CURRENT > 0:
			Events.emit_signal("QUEUE_DAMAGE_NUMBER", getPartyMemberGlobalPosition(2), effect, true, false)
			Events.emit_signal("PARTY_ADD_HEALTH", 2, effect)
			
		if Data.CHARACTER_4_HEALTH_CURRENT > 0:
			Events.emit_signal("QUEUE_DAMAGE_NUMBER", getPartyMemberGlobalPosition(3), effect, true, false)
			Events.emit_signal("PARTY_ADD_HEALTH", 3, effect)
		
		Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(position), " casts heal on the party."), Enums.SYSTEM_LOG_TYPE.BATTLE)

	
func resolvePierceAction(position:int, attackerName:String, enemy:Dictionary, enemyPosition:Vector2) -> void:
	pass
