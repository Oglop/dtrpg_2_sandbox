extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("RIGHT"):
		Events.emit_signal("INPUT_RIGHT")
	elif Input.is_action_pressed("UP"):
		Events.emit_signal("INPUT_UP")
	elif Input.is_action_pressed("LEFT"):
		Events.emit_signal("INPUT_LEFT")
	elif Input.is_action_pressed("DOWN"):
		Events.emit_signal("INPUT_DOWN")
	elif Input.is_action_pressed("ACCEPT"):
		# Events.emit_signal("INPUT_DOWN")
		pass
	elif Input.is_action_pressed("CANCEL"):
		#Events.emit_signal("INPUT_DOWN")
		pass
	

