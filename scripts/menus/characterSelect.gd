extends CanvasLayer

var unselectedTheme:Theme = preload("res://media/themes/textBoxTheme.tres")
var selectedTheme:Theme = preload("res://media/themes/selectedTeme.tres")

var _timerWait:float = 0.2
var _active:bool = false
var _inputBlocked:bool = true
var _index:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("INPUT_UP", _on_inputUp)
	Events.connect("INPUT_DOWN", _on_inputDown)
	Events.connect("INPUT_ACCEPT", _on_inputAccept)
	Events.connect("INPUT_CANCEL", _on_inputCancel)
	Events.connect("CHARACTER_SELECT_ACTIVE", _on_characterSelectActive)
	updateUI()

func inputBlock(delay:float = 0.4) -> void:
	$Timer.start(delay)
	_inputBlocked = true
	
func _on_characterSelectActive(active:bool) -> void:
	inputBlock()
	_active = active
	updateUI()
	
func _on_inputUp() -> void:
	if _active && !_inputBlocked:
		inputBlock(_timerWait)
		_index -= 1
		if _index < 0:
			_index = 0
		Events.emit_signal("CHARACTER_SELECT_CHANGED", _index)
		updateUI()
	
func _on_inputDown() -> void:
	if _active && !_inputBlocked:
		inputBlock(_timerWait)
		_index += 1
		if _index > 3:
			_index = 3
		Events.emit_signal("CHARACTER_SELECT_CHANGED", _index)
		updateUI()
		
func _on_inputAccept() -> void:
	if _active && !_inputBlocked:
		Events.emit_signal("CHARACTER_SELECT_ACCEPTED", _index)
	
func _on_inputCancel() -> void:
	if _active && !_inputBlocked:
		Events.emit_signal("CHARACTER_SELECT_CANCEL")

		
func updateUI() -> void:
	$MarginContainer1/Panel/Label.text = Data.CHARACTER_1_NAME
	$MarginContainer2/Panel/Label.text = Data.CHARACTER_2_NAME
	$MarginContainer3/Panel/Label.text = Data.CHARACTER_3_NAME
	$MarginContainer4/Panel/Label.text = Data.CHARACTER_4_NAME
	if _index == 0:
		$MarginContainer1/Panel.theme = selectedTheme
		$MarginContainer2/Panel.theme = unselectedTheme
		$MarginContainer3/Panel.theme = unselectedTheme
		$MarginContainer4/Panel.theme = unselectedTheme
	elif _index == 1:
		$MarginContainer1/Panel.theme = unselectedTheme
		$MarginContainer2/Panel.theme = selectedTheme
		$MarginContainer3/Panel.theme = unselectedTheme
		$MarginContainer4/Panel.theme = unselectedTheme
	elif _index == 2:
		$MarginContainer1/Panel.theme = unselectedTheme
		$MarginContainer2/Panel.theme = unselectedTheme
		$MarginContainer3/Panel.theme = selectedTheme
		$MarginContainer4/Panel.theme = unselectedTheme
	elif _index == 3:
		$MarginContainer1/Panel.theme = unselectedTheme
		$MarginContainer2/Panel.theme = unselectedTheme
		$MarginContainer3/Panel.theme = unselectedTheme
		$MarginContainer4/Panel.theme = selectedTheme


func _on_timer_timeout():
	_inputBlocked = false
	$Timer.stop()
