extends StaticBody2D

var _state:Enums.DOOR_STATES = Enums.DOOR_STATES.CLOSED
var _style:Enums.DOOR_STYLES = Enums.DOOR_STYLES.WOOD
var _lockedBy:String = ""
var _doorKey:String = ""

func _ready():
	pass # Replace with function body.
	
func setProperties(doorKey:String, style:Enums.DOOR_STYLES, lockedBy:String) -> void:
	_style = style
	_lockedBy = lockedBy
	_doorKey = doorKey
	_state = getDoorState()
	setAnimation()
	
func setAnimation() -> void:
	if _style == Enums.DOOR_STYLES.BARS:
		if _state == Enums.DOOR_STATES.CLOSED:
			$AnimatedSprite2D.play("bars_closed")
		else:
			$AnimatedSprite2D.play("bars_open")
	elif _style == Enums.DOOR_STYLES.STONE:
		if _state == Enums.DOOR_STATES.CLOSED:
			$AnimatedSprite2D.play("stone_closed")
		else:
			$AnimatedSprite2D.play("stone_open")
	elif _style == Enums.DOOR_STYLES.WOOD:
		if _state == Enums.DOOR_STATES.CLOSED:
			$AnimatedSprite2D.play("wood_closed")
		else:
			$AnimatedSprite2D.play("wood_open")
	if _state == Enums.DOOR_STATES.OPEN:
		$CollisionShape2D.disabled = true
			
func getDoorState() -> Enums.DOOR_STATES:
	if Data.MAP_OPENED_DOORS.has(_doorKey):
		return Enums.DOOR_STATES.OPEN
	return Enums.DOOR_STATES.CLOSED
		

func openDoor() -> void:
	if _state == Enums.DOOR_STATES.CLOSED:
		if _lockedBy != "":
			if InventoryHandler.itemExists(_doorKey):
				var key = InventoryHandler.withdrawItem(_doorKey)
				Data.MAP_OPENED_DOORS.append(_doorKey)
				_state = Enums.DOOR_STATES.OPEN
		else:
			Data.MAP_OPENED_DOORS.append(_doorKey)
			_state = Enums.DOOR_STATES.OPEN
	setAnimation()
