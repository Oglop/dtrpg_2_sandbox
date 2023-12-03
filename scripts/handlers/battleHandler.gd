extends Node

# damage = (attack / defense) * (HP_CONSTANT * AVG_BATTLE_LENGTH)

var rng = RandomNumberGenerator.new()

func _ready():
	Events.connect("PARTY_COMBAT_AT", _on_combatAt)

##
##
func _on_combatAt(position:Vector2):
	resolveTurn(position)


func resolveTurn(position:Vector2) -> void:
	var health:int = 0
	var healthMax:int = 0
	var magic:int = 0
	var magicMax:int = 0
	
	for n in range(0,3):
		if n == 0:
			health = Data.CHARACTER_1_HEALTH_CURRENT
			healthMax = Data.CHARACTER_1_HEALTH_MAX
			magic = Data.CHARACTER_1_MAGIC_CURRENT
			magicMax = Data.CHARACTER_1_MAGIC_MAX
		elif n == 1:
			health = Data.CHARACTER_2_HEALTH_CURRENT
			healthMax = Data.CHARACTER_2_HEALTH_MAX
			magic = Data.CHARACTER_2_MAGIC_CURRENT
			magicMax = Data.CHARACTER_2_MAGIC_MAX
		elif n == 2:
			health = Data.CHARACTER_3_HEALTH_CURRENT
			healthMax = Data.CHARACTER_3_HEALTH_MAX
			magic = Data.CHARACTER_3_MAGIC_CURRENT
			magicMax = Data.CHARACTER_3_MAGIC_MAX
		elif n == 3:
			health = Data.CHARACTER_4_HEALTH_CURRENT
			healthMax = Data.CHARACTER_4_HEALTH_MAX
			magic = Data.CHARACTER_4_MAGIC_CURRENT
			magicMax = Data.CHARACTER_4_MAGIC_MAX	
			
		resolveRules(n)

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

## actionResolver
## resolve action for character in position
func resolveAction(position:int, action:Enums.ACTION) -> void:

	if (action == Enums.ACTION.ATTACK):
		resolveAttackAction(10, 5, 16, 7, "Hello World", "Lamas")
	
## resolveRules
## postion
func resolveRules(position:int) -> void:
	var actionExecuted = false
	var rules:Array = getCharacterRules(position)
	
	for rule in rules:
		if RuleHandler.validateRule(rule.rule, position):
			resolveAction(position, rule.action)
			actionExecuted = true
			break
			
	if !actionExecuted:	
		Events.emit_signal("SYSTEM_WRITE_LOG", str(getCharacterName(position), " is idling."), Enums.SYSTEM_LOG_TYPE.BATTLE)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
