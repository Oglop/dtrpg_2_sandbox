extends Node2D

var _deathTimer:float = 0.6
var _value:int = 0
var _isHealing:bool = false
var _isCritical:bool = false
var _verticalVelocity:float = 0.2

func setProperties(position:Vector2, value:int, isHealing:bool, isCritical:bool) -> void:
	_value = value
	_isCritical = isCritical
	_isHealing = isHealing
	setStyle()

func setStyle() -> void:
	if _isHealing:
		$Control/Label.text = str(_value)
		$Control/Label.add_theme_color_override("font_color", Color("58d025"))
	else:
		$Control/Label.text = str(_value * -1)
		$Control/Label.add_theme_color_override("font_color", Color("ff0000"))
		
	if _isCritical:
		$Control/Label.add_theme_font_size_override("font_size", 24)

func _ready():
	$Timer.start(_deathTimer)

func _physics_process(delta):
	$Control/Label.global_position.y -= _verticalVelocity

func _on_timer_timeout():
	self.queue_free()
