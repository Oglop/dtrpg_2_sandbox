extends StaticBody2D

var _state:Enums.DOOR_STATES = Enums.DOOR_STATES.CLOSED
var _style:Enums.DOOR_STYLES = Enums.DOOR_STYLES.WOOD
var _isLocked:bool = false
var _lockedBy:String = ""

func _ready():
	pass # Replace with function body.
	
func setProperties(state:Enums.DOOR_STATES, style:Enums.DOOR_STYLES, isLocked:bool, lockedBy:String) -> void:
	_state = state
	_style = style
	_isLocked = isLocked
	_lockedBy = lockedBy
	setAnimation()
	
func setAnimation() -> void:
	if _style == Enums.DOOR_STYLES.BARS:
		if _state == Enums.DOOR_STATES.CLOSED:
			$AnimatedSprite2D.play("default")

func openDoor() -> void:
	pass
