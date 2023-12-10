extends Area2D



var _type:Enums.MAP_MESSAGE_SIGN_TYPES = Enums.MAP_MESSAGE_SIGN_TYPES.NONE


func getMessages() -> Array:
	return []
	
func getTitle() -> String:
	return ""

func _ready():
	pass

func setProperties(type:Enums.MAP_MESSAGE_SIGN_TYPES) -> void:
	_type = type

func setAnimation(type:Enums.MAP_MESSAGE_SIGN_TYPES) -> void:
	pass
