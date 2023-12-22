extends CanvasLayer

var unselectedTheme:Theme = preload("res://media/themes/textBoxTheme.tres")
var selectedTheme:Theme = preload("res://media/themes/selectedTeme.tres")

var _timerWait:float = 0.2
var _active:bool = false
var _inputBlocked:bool = true
var _index:int = 0
var _equipType:Enums.ITEM_TYPES = Enums.ITEM_TYPES.NONE
var _character1CanEquip:bool = false
var _character2CanEquip:bool = false
var _character3CanEquip:bool = false
var _character4CanEquip:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("INPUT_UP", _on_inputUp)
	Events.connect("INPUT_DOWN", _on_inputDown)
	Events.connect("INPUT_ACCEPT", _on_inputAccept)
	Events.connect("INPUT_CANCEL", _on_inputCancel)
	Events.connect("CHARACTER_SELECT_ACTIVE", _on_characterSelectActive)
	Events.connect("CHARACTER_SELECT_ACTIVE_TYPE", _on_characterSelectActiveType)
	updateUI()

func _on_characterSelectActiveType(type:Enums.ITEM_TYPES) -> void:
	
	_index = 0
	_equipType = type
	_character1CanEquip = CharacterHandler.getEquipableByTypeAndPosition(0, type)
	_character2CanEquip = CharacterHandler.getEquipableByTypeAndPosition(1, type)
	_character3CanEquip = CharacterHandler.getEquipableByTypeAndPosition(2, type)
	_character4CanEquip = CharacterHandler.getEquipableByTypeAndPosition(3, type)
	Events.emit_signal("CHARACTER_SELECT_CHANGED", _index)
	inputBlock()
	_active = true
	updateUI()
	

func inputBlock(delay:float = 0.4) -> void:
	$Timer.start(delay)
	_inputBlocked = true
	
func _on_characterSelectActive(active:bool) -> void:
	_index = 0
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
	var canEquip:bool = true
	if _equipType != Enums.ITEM_TYPES.NONE:
		canEquip = false
		if _index == 0 && _character1CanEquip == true:
			canEquip = true
		elif _index == 1 && _character2CanEquip == true:
			canEquip = true
		elif _index == 2 && _character3CanEquip == true:
			canEquip = true
		elif _index == 3 && _character4CanEquip == true:
			canEquip = true
	
	if canEquip && _active && !_inputBlocked:
		inputBlock(_timerWait)
		_equipType = Enums.ITEM_TYPES.NONE
		Events.emit_signal("VISIBLE_CHARACTER_CARD", false)
		Events.emit_signal("CHARACTER_SELECT_ACCEPTED", _index)
		
	
func _on_inputCancel() -> void:
	if _active && !_inputBlocked:
		inputBlock(_timerWait)
		_equipType = Enums.ITEM_TYPES.NONE
		Events.emit_signal("VISIBLE_CHARACTER_CARD", false)
		Events.emit_signal("CHARACTER_SELECT_CANCEL")
		Events.emit_signal("HIDE_COMPARE_EQUIPABLES")

func updateUI() -> void:
	if _active:
		self.visible = true
	else:
		self.visible = false
		
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
