extends Node
var rng = RandomNumberGenerator.new()


func _ready():
	Events.connect("ADD_ENEMY_TO_MAP", _on_addEnemyToMap)

func getEnemyName(type:Enums.ENEMY_TYPES) -> String:
	if type == Enums.ENEMY_TYPES.NONE:
		return ""
		
	return ""

func getEnemyDescription(type:Enums.ENEMY_TYPES) -> String:
	if type == Enums.ENEMY_TYPES.NONE:
		return ""
		
	return ""

func getEnemyStats(type:Enums.ENEMY_TYPES) -> Dictionary:
	var stats:Dictionary = {}
	if type == Enums.ENEMY_TYPES.GOBLIN:
		return Statics.ENEMY_STATS.GOBLIN;
	
	return stats


##
## "<monster>": {
##  "name": "<monster-name>",
##  "description": "<description.>",
##  "health": <hp>,
##  "attack": <att>,
##  "defence": <def>
## }
func getEnemyDetails(type:Enums.ENEMY_TYPES) -> Array:
	var stats = getEnemyStats(type)
	var meta = getEnemyMeta(type)
	
	var numberOfEnemies = rng.randi_range(meta.min, meta.max)
	var details:Array = []
	for n in numberOfEnemies:
		details.append({
			"name": stats.name,
			"health": stats.health,
			"healthMax": stats.health,
			"attack": stats.attack,
			"defence": stats.defence,
			"xp": stats.xp,
			"crownsMin": stats.crownsMin,
			"crownsMax": stats.crownsMax,
			"itemDrop": stats.itemDrop,
			"itemDropRate":stats.itemDropRate
		})
		
	return details
	
func getEnemyMeta(type:Enums.ENEMY_TYPES) -> Dictionary:
	var stats:Dictionary = {}
	if type == Enums.ENEMY_TYPES.GOBLIN:
		return Statics.ENEMY_SPAWNS.GOBLIN
	return stats
	
	
func removeEnemy(id:String) -> void:
	var updatedEnemyList:Array = []
	for enemy in Data.ENEMIES:
		if enemy.id != id:
			updatedEnemyList.append(enemy)
	Data.ENEMIES = updatedEnemyList
	Events.emit_signal("DELETE_ENEMY_ACTOR", id)
	
func generateId() -> String:
	var id:String = ""
	var characters:Array = [ "1","2","3","4","5","6","7","8","9","0","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","x","y","z","_" ]
	for n in range(0,10):
		id += characters[rng.randi_range(0, characters.size() - 1)]
	return id
	
func _on_addEnemyToMap(type:Enums.ENEMY_TYPES, position:Vector2) -> void:
	var id = generateId()
	var details = getEnemyDetails(type)
	
	var enemy:Dictionary = {
		"id": id,
		"type": type,
		"x":position.x,
		"y":position.y,
		"details": details
	}
	
	Data.ENEMIES.append(enemy)
	Events.emit_signal("SPAWN_ENEMY_ACTOR", id, position, type)
	
