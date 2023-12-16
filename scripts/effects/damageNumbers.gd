extends Node2D

var _y:float = self.global_position.y
var _deathTimer:float = 1.2
var _value:int = 0
var _isHealing:bool = false
var _isCritical:bool = false
var _verticalVelocity:float = 0.2

func setProperties(position:Vector2, value:int, isHealing:bool, isCritical:bool) -> void:
	self.global_position = position
	_value = value
	_isCritical = isCritical
	_isHealing = isHealing
	$CanvasLayer/Label.text = str(_value)
	$Timer.start(_deathTimer)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	_y -= _verticalVelocity
	self.global_position = Vector2(self.global_position.x, _y)
	$CanvasLayer/MarginContainer/Label.global_position = Vector2(self.global_position.x, _y)


func _on_timer_timeout():
	self.queue_free()
