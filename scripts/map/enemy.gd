extends Node2D

var _id:String = ""
var _name:String = ""
var _description:String = ""
var _type:Enums.ENEMY_TYPES = Enums.ENEMY_TYPES.NONE

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("DELETE_ENEMY_ACTOR", _on_enemy_defeated)


func _on_enemy_defeated(id:String) -> void:
	if _id == id:
		self.queue_free()

func snapToGrid():
	var gridX:int = self.global_position.x / 16
	var gridY:int = self.global_position.y / 16
	self.global_position = Vector2(gridX * 16, gridY * 16)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## 
## 
## 
func setAnimation(type:Enums.ENEMY_TYPES) -> void:
	if type == Enums.ENEMY_TYPES.GOBLIN:
		$AnimatedSprite2D.animation = "goblin"


## 
## Set type and position
## 
func setProperties(id:String, type:Enums.ENEMY_TYPES) -> void:
	_id = id
	_type = type
	_name = EnemyHandler.getEnemyName(type)
	_description = EnemyHandler.getEnemyDescription(type)
	
	snapToGrid()
	setAnimation(type)
