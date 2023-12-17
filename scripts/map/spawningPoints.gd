extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	spawnAndSnap()
	
func snapToGrid(position:Vector2) -> Vector2:
	var gridX:int = position.x / Statics.ROOM_SIZE
	var gridY:int = position.y / Statics.ROOM_SIZE
	return Vector2(gridX * Statics.ROOM_SIZE, gridY * Statics.ROOM_SIZE)
	
	
func spawnAndSnap() -> void:
	var spawningPoints:Array = self.get_children()
	for spawningPoint in spawningPoints:
		var position = snapToGrid(spawningPoint.global_position)
		Events.emit_signal("ADD_ENEMY_TO_MAP", Enums.ENEMY_TYPES.GOBLIN, position) 
	
