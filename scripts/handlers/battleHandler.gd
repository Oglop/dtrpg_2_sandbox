extends Node

# damage = (attack / defense) * (HP_CONSTANT * AVG_BATTLE_LENGTH)

var rng = RandomNumberGenerator.new()

func _ready():
	Events.connect("PARTY_COMBAT_AT", _on_combatAt)


func getEnemyById(id:String) -> Dictionary:
	for enemy in Data.ENEMIES:
		if enemy.id == id:
			return enemy
	return {
		"id": "",
		"type": Enums.ENEMY_TYPES.NONE,
		"details":[]
	}
##
##
func _on_combatAt(id:String, position:Vector2, enemyName:String, type:Enums.ENEMY_TYPES):
	var enemy = getEnemyById(id)
	resolveTurn(position, enemy)


func getShuffeledOrderList(enemy:Dictionary) -> Array:
	var order:Array = []
	if Data.CHARACTER_1_HEALTH_CURRENT > 0:
		order.push_back(0)
	if Data.CHARACTER_2_HEALTH_CURRENT > 0:
		order.push_back(1)
	if Data.CHARACTER_3_HEALTH_CURRENT > 0:
		order.push_back(2)
	if Data.CHARACTER_4_HEALTH_CURRENT > 0:
		order.push_back(3)
		
	for n in range(0 , enemy.details.size() - 1):
		order.push_back(100 + n)
		
	order.shuffle()
	return order
	
func isPartyAlive() -> bool:
	return Data.CHARACTER_1_HEALTH_CURRENT > 0 || Data.CHARACTER_2_HEALTH_CURRENT > 0 || Data.CHARACTER_3_HEALTH_CURRENT > 0 || Data.CHARACTER_4_HEALTH_CURRENT > 0
	
func getRandomCharacterIndex() -> int:
	var aliveCharacters = []
	if Data.CHARACTER_1_HEALTH_CURRENT > 0:
		aliveCharacters.push_back(0)
	if Data.CHARACTER_2_HEALTH_CURRENT > 0:
		aliveCharacters.push_back(1)
	if Data.CHARACTER_3_HEALTH_CURRENT > 0:
		aliveCharacters.push_back(2)
	if Data.CHARACTER_4_HEALTH_CURRENT > 0:
		aliveCharacters.push_back(3)
	aliveCharacters.shuffle()
	return aliveCharacters[0]
	
func resolveEnemyAttack(enemyDetail:Dictionary) -> void:
	var characterPosition:int = getRandomCharacterIndex()
	var character:Dictionary = Data.getCharacterByPosition(characterPosition)
	var dmg:int = enemyDetail.attack / character.defence
	
	if characterPosition == 0:
		Data.CHARACTER_1_HEALTH_CURRENT -= dmg
		if Data.CHARACTER_1_HEALTH_CURRENT < 0:
			Data.CHARACTER_1_HEALTH_CURRENT = 0
	elif characterPosition == 1:
		Data.CHARACTER_2_HEALTH_CURRENT -= dmg
		if Data.CHARACTER_2_HEALTH_CURRENT < 0:
			Data.CHARACTER_2_HEALTH_CURRENT = 0
	elif characterPosition == 2:
		Data.CHARACTER_3_HEALTH_CURRENT -= dmg
		if Data.CHARACTER_3_HEALTH_CURRENT < 0:
			Data.CHARACTER_3_HEALTH_CURRENT = 0
	elif characterPosition == 3:
		Data.CHARACTER_4_HEALTH_CURRENT -= dmg
		if Data.CHARACTER_4_HEALTH_CURRENT < 0:
			Data.CHARACTER_4_HEALTH_CURRENT = 0
	Events.emit_signal("SYSTEM_WRITE_LOG", str(enemyDetail.name, " hit ", character.name, " for ", dmg, " damage." ), Enums.SYSTEM_LOG_TYPE.BATTLE)
	Events.emit_signal("UPDATE_HP_BOX")
	
	
func chance(test:int) -> bool:
	var i:int = rng.randi_range(1, 100)
	if i <= test:
		return true
	return false
	
		
func removeDeadEnemies(enemy:Dictionary) -> Array:
	var newDetails = []
	for detail in enemy.details:
		if detail.health > 0:
			newDetails.push_back(detail)
		else:
			var dropsItem:bool = chance(detail.itemDropRate)
			var crowns:int = rng.randi_range(detail.crownsMin, detail.crownsMax)
			Events.emit_signal("SYSTEM_WRITE_LOG", str(detail.name, " is slain, party gains ", detail.xp ," xp and ", crowns, " crowns."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			Events.emit_signal("PARTY_ADD_EXPERIENCE", detail.xp)
			Events.emit_signal("PARTY_ADD_GOLD", rng.randi_range(detail.crownsMin, detail.crownsMax))
	return newDetails
	
##
## return random enenmy detail with hp > 0
##
func getRandomEnemy(enemy:Dictionary) -> Dictionary:
	var alive:Array = []
	for detail in enemy.details:
		if detail.health > 0:
			alive.push_back(detail)
	if alive.size() >= 1:
		alive.shuffle()
		return alive[0]
	return {}

func resolveTurn(position:Vector2, enemy:Dictionary) -> void:
	var enemyAttacking:bool = false
	var detail:Dictionary = {}
	var health:int = 0
	var healthMax:int = 0
	var magic:int = 0
	var magicMax:int = 0
	
	var turnOrder:Array = getShuffeledOrderList(enemy)
	
	for actionTaker in turnOrder:
		if actionTaker < 100:
			enemyAttacking = false
		else:
			enemyAttacking = true
			
		if actionTaker == 0:
			health = Data.CHARACTER_1_HEALTH_CURRENT
			healthMax = Data.CHARACTER_1_HEALTH_MAX
			magic = Data.CHARACTER_1_MAGIC_CURRENT
			magicMax = Data.CHARACTER_1_MAGIC_MAX
		elif actionTaker == 1:
			health = Data.CHARACTER_2_HEALTH_CURRENT
			healthMax = Data.CHARACTER_2_HEALTH_MAX
			magic = Data.CHARACTER_2_MAGIC_CURRENT
			magicMax = Data.CHARACTER_2_MAGIC_MAX
		elif actionTaker == 2:
			health = Data.CHARACTER_3_HEALTH_CURRENT
			healthMax = Data.CHARACTER_3_HEALTH_MAX
			magic = Data.CHARACTER_3_MAGIC_CURRENT
			magicMax = Data.CHARACTER_3_MAGIC_MAX
		elif actionTaker == 3:
			health = Data.CHARACTER_4_HEALTH_CURRENT
			healthMax = Data.CHARACTER_4_HEALTH_MAX
			magic = Data.CHARACTER_4_MAGIC_CURRENT
			magicMax = Data.CHARACTER_4_MAGIC_MAX
		else:
			detail = enemy.details[100 - actionTaker]
			health = detail.health
			healthMax = detail.healthMax
			magic = 0
			magicMax = 0
		
		# get attacker - attacker is
		
		# get defender

		if enemyAttacking:
			resolveEnemyAttack(detail)
		else:
			var action = resolveRules(actionTaker)
			if action == Enums.ACTION.NONE:
				Events.emit_signal("SYSTEM_WRITE_LOG", str(getCharacterName(actionTaker), " is idling."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			else:
				var enemeyDetail = getRandomEnemy(enemy)
				resolveAction(actionTaker, enemeyDetail, action)
		
		# if no characters loose
		
		# remove dead enemies, if no enemies win
		enemy.details = removeDeadEnemies(enemy)
		if enemy.details.size() == 0:
			EnemyHandler.removeEnemy(enemy.id)
			break
		


##
## check skill by testing skille value 1-20 against random number
##
func skillCheck(skill:int) -> Enums.SYSTEM_SKILL_CHECK_RESULT:
	var n = rng.randi_range(1, 20)
	if n == 1:
		return Enums.SYSTEM_SKILL_CHECK_RESULT.FAIL
	elif n == 20:
		return Enums.SYSTEM_SKILL_CHECK_RESULT.CRITICAL
	elif n <= skill:
		return Enums.SYSTEM_SKILL_CHECK_RESULT.SUCCESS
	return Enums.SYSTEM_SKILL_CHECK_RESULT.FAIL

##
## resolve ATTACK action
##	
func resolveAttackAction(attack:int, defence:int, attackerDexterity:int, attackerLuck:int, attackerName:String, defenderName:String) -> int:
	var checkHit = skillCheck(attackerDexterity)
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
		Events.emit_signal("SYSTEM_WRITE_LOG", str(getCharacterName(position), " drinks a potion."), Enums.SYSTEM_LOG_TYPE.BATTLE)

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

## actionResolve
## resolve action for character in position
func resolveAction(position:int, enemeyDetail:Dictionary, action:Enums.ACTION) -> void:
	var attacker = Data.getCharacterByPosition(position)
	if action == Enums.ACTION.ATTACK:
		var damage = resolveAttackAction(attacker.attack, enemeyDetail.defence, attacker.agility, attacker.luck, attacker.name, enemeyDetail.name)
		enemeyDetail.health -= damage
	elif action == Enums.ACTION.USE_POTION_SELF:
		resolvePotionSelfAction(position)
	
## resolveRules
## postion
func resolveRules(position:int) -> Enums.ACTION:
	var rules:Array = getCharacterRules(position)
	
	for rule in rules:
		if RuleHandler.validateRule(rule.rule, position):
			return rule.action
			# resolveAction(position, rule.action)
			
	return Enums.ACTION.NONE
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
