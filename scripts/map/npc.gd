extends AnimatedSprite2D

var _messages:Array = []

func _ready():
	pass # Replace with function body.

func setProperties(key:String) -> void:
	var properties:Dictionary = Statics.NPCS[key]
	self.global_position = Globals.snapToGrid(properties.x, properties.y)
	_messages = properties.messages
	setAnimation(properties.style)
	
func setAnimation(style:Enums.MAP_NPC_STYLES) -> void:
	if style == Enums.MAP_NPC_STYLES.WOMAN_BLUE:
		self.play("blueWomanNPC")
	elif style == Enums.MAP_NPC_STYLES.MAN_BLUE:
		self.play("blueManNPC")
	
