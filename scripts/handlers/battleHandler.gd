extends Node

# damage = (attack / defense) * (HP_CONSTANT * AVG_BATTLE_LENGTH)

var rng = RandomNumberGenerator.new()
var _damageFXQueue:Array = []
var _damageFXTimerWait:float = 0.3
var _damageNumbersQueue:Array = []
var _damageNumbersTimerWait:float = 0.3
enum DAMAGE_QUEUE_STATES {
	READY,
	BUSY
}
enum DAMAGE_FX_STATES {
	READY,
	BUSY
}

var _damageNumbersQueueState:DAMAGE_QUEUE_STATES = DAMAGE_QUEUE_STATES.READY
var _damageFXQueueState:DAMAGE_FX_STATES = DAMAGE_FX_STATES.READY

func _ready():
	Events.connect("PARTY_COMBAT_AT", _on_combatAt)
	Events.connect("QUEUE_DAMAGE_NUMBER", _on_queueDamageNumber)
	Events.connect("QUEUE_FX", _on_queueFX)

func _process(_delta):
	if _damageNumbersQueueState == DAMAGE_QUEUE_STATES.READY &&  _damageNumbersQueue.size() > 0:
		_damageNumbersQueueState = DAMAGE_QUEUE_STATES.BUSY
		unqueueDamageNumber()
	if _damageFXQueueState == DAMAGE_FX_STATES.READY &&  _damageFXQueue.size() > 0:
		_damageFXQueueState = DAMAGE_FX_STATES.BUSY
		unqueueDamageFX()
	

func _on_queueFX(position:Vector2, type:Enums.BATTLE_DAMAGE_FXS) -> void:
	_damageFXQueue.append({ "position": position, "type": type })
		
func _on_queueDamageNumber(position:Vector2, value:int, isCritical:bool, isHeal:bool) -> void:
	_damageNumbersQueue.append({ "position": position, "value": value, "isCritical": isCritical, "isHeal": isHeal  })

func unqueueDamageFX() -> void:
	if _damageFXQueue.size() > 0:
		var fx = _damageFXQueue.pop_front()
		if fx.type == Enums.BATTLE_DAMAGE_FXS.FIREBALL:
			Events.emit_signal("SPAWN_DAMAGE_FX_FIREBALL", fx.position)
		elif fx.type == Enums.BATTLE_DAMAGE_FXS.CUT:
			Events.emit_signal("SPAWN_DAMAGE_FX_CUT", fx.position)
		elif fx.type == Enums.BATTLE_DAMAGE_FXS.POSION:
			Events.emit_signal("SPAWN_DAMAGE_FX_POISON", fx.position)
		elif fx.type == Enums.BATTLE_DAMAGE_FXS.LAVA_WAVE:
			Events.emit_signal("SPAWN_DAMAGE_FX_LAVAWAVE", fx.position)
		await get_tree().create_timer(_damageFXTimerWait).timeout
		_damageFXQueueState = DAMAGE_FX_STATES.READY

func unqueueDamageNumber() -> void:
	if _damageNumbersQueue.size() > 0:
		var dmg = _damageNumbersQueue.pop_front()
		#position:Vector2, value:int, isHealing:bool, isCritical:bool
		Events.emit_signal("SPAWN_DAMAGE_NUMBER", dmg.position, dmg.value, dmg.isCritical, dmg.isHeal )
		await get_tree().create_timer(_damageNumbersTimerWait).timeout
		_damageNumbersQueueState = DAMAGE_QUEUE_STATES.READY

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
	if aliveCharacters.size() > 0:
		aliveCharacters.shuffle()
		return aliveCharacters[0]
	resolvePartyFell()
	return -1
	
func resolveEnemyAttack(enemyDetail:Dictionary) -> void:
	var characterPosition:int = getRandomCharacterIndex()
	var character:Dictionary = CharacterHandler.getCharacterByPosition(characterPosition)
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
			
	var postion:Vector2 = ActionHandler.getPartyMemberGlobalPosition(characterPosition)
	Events.emit_signal("QUEUE_DAMAGE_NUMBER", postion, dmg, false, false)
	Events.emit_signal("SYSTEM_WRITE_LOG", str(enemyDetail.name, " hit ", character.name, " for ", dmg, " damage." ), Enums.SYSTEM_LOG_TYPE.BATTLE)
	Events.emit_signal("QUEUE_FX", postion, Enums.BATTLE_DAMAGE_FXS.CUT)
	Events.emit_signal("UPDATE_HP_BOX")
	
	checkForEnemyAttackStatusEffect(characterPosition, postion, enemyDetail)

#signal SPAWN_DAMAGE_FX_POISON
#signal SPAWN_DAMAGE_FX_LAVAWAVE
#signal SPAWN_DAMAGE_FX_STUN
#signal SPAWN_DAMAGE_FX_CHAIN_LIGHTNING
#signal SPAWN_DAMAGE_FX_SLEEP
#signal SPAWN_DAMAGE_FX_PROTECT
#signal SPAWN_DAMAGE_FX_MISS
	
func checkForEnemyAttackStatusEffect(position:int, targetPostion:Vector2, enemyDetail:Dictionary) -> void:
	var addEffects:Array = []
	for effect in enemyDetail.attackEffects:
		if effect == Enums.STATUS_EFFECTS.POISON:
			if Globals.chance(20):
				addEffects.append(Enums.STATUS_EFFECTS.POISON)
				Events.emit_signal("SPAWN_DAMAGE_FX_POISON", targetPostion)
		elif effect == Enums.STATUS_EFFECTS.BURNING:
			if Globals.chance(10):
				addEffects.append(Enums.STATUS_EFFECTS.BURNING)
		elif effect == Enums.STATUS_EFFECTS.STUN:
			if Globals.chance(40):
				addEffects.append(Enums.STATUS_EFFECTS.STUN)
				Events.emit_signal("SPAWN_DAMAGE_FX_STUN", targetPostion)
	for effect in addEffects:
		Events.emit_signal("CHARACTER_ADD_STATUS_EFFECT", position, effect)
			
		
func removeDeadEnemies(enemy:Dictionary) -> Array:
	var newDetails = []
	for detail in enemy.details:
		if detail.health > 0:
			newDetails.push_back(detail)
		else:
			var dropsItem:bool = Globals.chance(detail.itemDropRate)
			var crowns:int = rng.randi_range(detail.crownsMin, detail.crownsMax)
			Events.emit_signal("SYSTEM_WRITE_LOG", str(detail.name, " is slain, party gains ", detail.xp ," xp and ", crowns, " crowns."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			Events.emit_signal("PARTY_ADD_EXPERIENCE", detail.xp)
			Events.emit_signal("PARTY_ADD_GOLD", rng.randi_range(detail.crownsMin, detail.crownsMax))
			Events.emit_signal("ENEMY_CHECK_FOR_DROPS", detail.type)
			
	return newDetails	
	
func resolvePartyFell() -> void:
	get_tree().change_scene_to_file("res://scenes/rooms/gameOver.tscn")
	
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

func resolveTurn(enemyPosition:Vector2, enemy:Dictionary) -> void:
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
			detail = enemy.details[actionTaker - 100]
			health = detail.health
			healthMax = detail.healthMax
			magic = 0
			magicMax = 0
		
		# get attacker - attacker is
		
		# get defender

		if enemyAttacking:
			if detail.health > 0:
				resolveEnemyAttack(detail)
		else:
			var action = resolveRules(actionTaker)
			if action == Enums.ACTION.NONE:
				Events.emit_signal("SYSTEM_WRITE_LOG", str(CharacterHandler.getCharacterName(actionTaker), " is idling."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			else:
				var enemeyDetail = getRandomEnemy(enemy)
				if enemeyDetail.size() == 0:
					# no alive enemies, break
					break
				resolveAction(actionTaker, enemeyDetail, action, enemyPosition, enemy)
		
		# if no characters loose
		if !isPartyAlive():
			resolvePartyFell() 
		
	# remove dead enemies, if no enemies win
	enemy.details = removeDeadEnemies(enemy)
	if enemy.details.size() == 0:
		EnemyHandler.removeEnemy(enemy.id)
			


## actionResolve
## resolve action for character in position
func resolveAction(position:int, enemeyDetail:Dictionary, action:Enums.ACTION, enemyPosition:Vector2, enemy:Dictionary) -> void:
	var attacker = CharacterHandler.getCharacterByPosition(position)
	if action == Enums.ACTION.ATTACK:
		var damage = ActionHandler.resolveAttackAction(attacker.attack, enemeyDetail.defence, attacker.agility, attacker.luck, attacker.name, enemeyDetail.name, enemyPosition)
		enemeyDetail.health -= damage
	elif action == Enums.ACTION.USE_POTION_SELF:
		ActionHandler.resolvePotionSelfAction(position)
	elif action == Enums.ACTION.USE_POTION_ALLY:
		ActionHandler.resolveUsePotionAllyAction()
	elif action == Enums.ACTION.USE_ELEXIR_ALLY:
		ActionHandler.resolveUseElexir(position)
	elif action == Enums.ACTION.USE_HERB_SELF:
		ActionHandler.resolveHerbSelfAction(position)
	elif action == Enums.ACTION.USE_HERB_ALLY:
		ActionHandler.resolveUseHerbAllyAction()
	elif action == Enums.ACTION.CAST_HEAL:
		ActionHandler.resolveCastHealAction(position)
	elif action == Enums.ACTION.CAST_FIREBALL:
		var damage = ActionHandler.resolveCastFireballAction(position, attacker.name, enemeyDetail, enemyPosition)
		enemeyDetail.health -= damage
	elif action == Enums.ACTION.LAVA_WAVE:
		ActionHandler.resolveLavawaveAction(position, enemy, enemyPosition)
	elif action == Enums.ACTION.PROTECT:
		ActionHandler.resolveProtectAction(position)
	elif action == Enums.ACTION.DEFEND:
		ActionHandler.resolveDefendAction(position)
	elif action == Enums.ACTION.BARRAGE:
		ActionHandler.resolveBarrageAction(position, attacker.attack, attacker.agility, enemy, enemyPosition)
	
## resolveRules
## postion
func resolveRules(position:int) -> Enums.ACTION:
	var rules:Array = CharacterHandler.getCharacterRules(position)
	
	for rule in rules:
		if RuleHandler.validateRule(rule.rule, position):
			return rule.action
			# resolveAction(position, rule.action)
			
	return Enums.ACTION.NONE

