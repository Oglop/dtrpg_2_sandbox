extends Node

# damage = (attack / defense) * (HP_CONSTANT * AVG_BATTLE_LENGTH)

var rng = RandomNumberGenerator.new()

func skillCheck(skill:int) -> Enums.SYSTEM_SKILL_CHECK_RESULT:
	var n = rng.randi_range(1, 20)
	if n == 1:
		return Enums.SYSTEM_SKILL_CHECK_RESULT.FAIL
	elif n == 20:
		return Enums.SYSTEM_SKILL_CHECK_RESULT.CRITICAL
	elif n <= skill:
		return Enums.SYSTEM_SKILL_CHECK_RESULT.SUCCESS
	return Enums.SYSTEM_SKILL_CHECK_RESULT.FAIL
	
func resolveCombat(attack:int, defence:int, attackerDexterity:int, attackerLuck:int, attackerName:String, defenderName:String, attackName:String) -> int:
	var checkHit = skillCheck(attackerDexterity)
	if checkHit == Enums.SYSTEM_SKILL_CHECK_RESULT.SUCCESS:
		var damage = attack + rng.randi_range(1, attackerLuck) - defence
		if damage > 0:
			Events.emit_signal("SYSTEM_WRITE_LOG", str(attackName, " hits ", defenderName, " for ", damage, " damage."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			return damage
	elif checkHit == Enums.SYSTEM_SKILL_CHECK_RESULT.CRITICAL: 
		var damage = attack + rng.randi_range(1, attackerLuck)
		if damage > 0:
			Events.emit_signal("SYSTEM_WRITE_LOG", str(attackName, " criticly hits ", defenderName, " for ", damage, " damage."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			return damage
	
	Events.emit_signal("SYSTEM_WRITE_LOG", str(attackName, " attacks ", defenderName, " and misses."), Enums.SYSTEM_LOG_TYPE.BATTLE)
	return 0
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
