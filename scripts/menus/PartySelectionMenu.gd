extends CanvasLayer
var inputWait:float = 0.2
var _state:menu_states = menu_states.MAIN
var _pressableState:pressableStates = pressableStates.BUSY
var unselectedTheme:Theme = preload("res://media/themes/textBoxTheme.tres")
var selectedTheme:Theme = preload("res://media/themes/selectedTeme.tres")

var _selectMainIndex:int = 0
var _selectClassIndex:int = 0
var _currentCharacterIndex:int = 0

var _selectedClass:Enums.CLASSES = Enums.CLASSES.NONE

enum menu_states {
	MAIN,
	SELECT_CLASS,
	VIEW_CURRENT,
	ACCEPT_CLASS_PROMPT,
}

enum pressableStates {
	PRESSABLE,
	BUSY
}

func _ready():
	Events.connect("INPUT_UP", _on_inputUp)
	Events.connect("INPUT_DOWN", _on_inputDown)
	Events.connect("INPUT_RIGHT", _on_inputRight)
	Events.connect("INPUT_LEFT", _on_inputLeft)
	Events.connect("INPUT_ACCEPT", _on_inputAccept)
	Events.connect("INPUT_CANCEL", _on_inputCancel)
	setLabels()
	updateUI()
	$Timer.start(inputWait)
	
func _on_timer_timeout():
	$Timer.stop()
	_pressableState = pressableStates.PRESSABLE
	
func setPressableBusy() -> void:
	_pressableState = pressableStates.BUSY
	$Timer.start(inputWait)
	
	
func _on_inputUp() -> void:
	if _pressableState == pressableStates.PRESSABLE:
		setPressableBusy()
		if _state == menu_states.MAIN:
			_selectMainIndex -= 1
			if _selectMainIndex < 0:
				_selectMainIndex = 0
		if _state == menu_states.SELECT_CLASS:
			_selectClassIndex -= 1
			if _selectClassIndex < 0:
				_selectClassIndex = 0
		updateUI()
	
func _on_inputDown() -> void:
	if _pressableState == pressableStates.PRESSABLE:
		setPressableBusy()
		if _state == menu_states.MAIN:
			_selectMainIndex += 1
			if _selectMainIndex > 1:
				_selectMainIndex = 1
		if _state == menu_states.SELECT_CLASS:
			_selectClassIndex += 1
			if _selectClassIndex > 5:
				_selectClassIndex = 5
		updateUI()
	
func _on_inputRight() -> void:
	if _pressableState == pressableStates.PRESSABLE:
		setPressableBusy()
	
func _on_inputLeft() -> void:
	if _pressableState == pressableStates.PRESSABLE:
		setPressableBusy()
	
func _on_inputAccept() -> void:
	if _pressableState == pressableStates.PRESSABLE:
		setPressableBusy()
		if _state == menu_states.MAIN:
			if _selectMainIndex == 0:
				_state = menu_states.SELECT_CLASS
				_selectClassIndex = 0
			elif _selectMainIndex == 1:
				_state = menu_states.VIEW_CURRENT
		elif _state == menu_states.SELECT_CLASS:
			classAccepted() 
			
		updateUI()
		
func _on_inputCancel() -> void:
	if _pressableState == pressableStates.PRESSABLE:
		setPressableBusy()
		if _state == menu_states.VIEW_CURRENT:
			_state = menu_states.MAIN
		
	updateUI()

func setLabels() -> void:
	$selectWarrior/Panel/Label.text = Text.CLASS_WARRIOR
	$selectKnight/Panel/Label.text = Text.CLASS_KNIGHT
	$selectWizard/Panel/Label.text = Text.CLASS_WIZARD
	$selectHunter/Panel/Label.text = Text.CLASS_HUNTER
	$selectThief/Panel/Label.text = Text.CLASS_THIEF
	$selectCleric/Panel/Label.text = Text.CLASS_CLERIC

func updateUI() -> void:
	if _state == menu_states.MAIN:
		setMainVisibility(true)
		updateMainThemes()
	else:
		setMainVisibility(false)
		
	if _state == menu_states.SELECT_CLASS:
		setClassSelectorsVisiblity(true)
		updateSelectClassThemes()
	else:
		setClassSelectorsVisiblity(false)
		
	if _state == menu_states.VIEW_CURRENT:
		setCurrentPartyVisibility(true)
	else:
		setCurrentPartyVisibility(false)
		
func classAccepted() -> void:
	_state = menu_states.ACCEPT_CLASS_PROMPT
	
	var type:Enums.CLASSES = Enums.CLASSES.NONE
	if _selectClassIndex == 0:
		type = Enums.CLASSES.WARRIOR
	elif _selectClassIndex == 1:
		type = Enums.CLASSES.KNIGHT
	elif _selectClassIndex == 2:
		type = Enums.CLASSES.WIZARD
	elif _selectClassIndex == 3:
		type = Enums.CLASSES.HUNTER
	elif _selectClassIndex == 4:
		type = Enums.CLASSES.THIEF
	elif _selectClassIndex == 5:
		type = Enums.CLASSES.CLERIC
	
	CharacterHandler.setNewCharacterOfType(type, _currentCharacterIndex)
	Events.emit_signal("LOAD_CHARACTER_CARD", _currentCharacterIndex)
		
func setCurrentPartyVisibility(visible:bool) -> void:
	$viewCharacter1.visible = visible
	$viewCharacter2.visible = visible
	$viewCharacter3.visible = visible
	$viewCharacter4.visible = visible

func setMainVisibility(visible:bool) -> void:
	$addMarginContainer.visible = visible
	$viewMarginContainer.visible = visible

func updateMainThemes() -> void:
	if _selectMainIndex == 0:
		$addMarginContainer/Panel.theme = selectedTheme
		$viewMarginContainer/Panel.theme = unselectedTheme
	elif _selectMainIndex == 1:
		$addMarginContainer/Panel.theme = unselectedTheme
		$viewMarginContainer/Panel.theme = selectedTheme
		
func setClassSelectorsVisiblity(visible:bool) -> void:
	$selectWarrior.visible = visible
	$selectKnight.visible = visible
	$selectWizard.visible = visible
	$selectHunter.visible = visible
	$selectThief.visible = visible
	$selectCleric.visible = visible
	$classDescriptionMarginContainer.visible = visible
		
func updateSelectClassThemes() -> void:
	if _selectClassIndex == 0:
		$classDescriptionMarginContainer/Panel/Label.text = Text.CLASS_DESCRIPTION_WARRIOR
		$selectWarrior/Panel.theme = selectedTheme
		$selectKnight/Panel.theme = unselectedTheme
		$selectWizard/Panel.theme = unselectedTheme
		$selectHunter/Panel.theme = unselectedTheme
		$selectThief/Panel.theme = unselectedTheme
		$selectCleric/Panel.theme = unselectedTheme
	elif _selectClassIndex == 1:
		$classDescriptionMarginContainer/Panel/Label.text = Text.CLASS_DESCRIPTION_KNIGT
		$selectWarrior/Panel.theme = unselectedTheme
		$selectKnight/Panel.theme = selectedTheme
		$selectWizard/Panel.theme = unselectedTheme
		$selectHunter/Panel.theme = unselectedTheme
		$selectThief/Panel.theme = unselectedTheme
		$selectCleric/Panel.theme = unselectedTheme
	elif _selectClassIndex == 2:
		$classDescriptionMarginContainer/Panel/Label.text = Text.CLASS_DESCRIPTION_WIZARD
		$selectWarrior/Panel.theme = unselectedTheme
		$selectKnight/Panel.theme = unselectedTheme
		$selectWizard/Panel.theme = selectedTheme
		$selectHunter/Panel.theme = unselectedTheme
		$selectThief/Panel.theme = unselectedTheme
		$selectCleric/Panel.theme = unselectedTheme
	elif _selectClassIndex == 3:
		$classDescriptionMarginContainer/Panel/Label.text = Text.CLASS_DESCRIPTION_HUNTER
		$selectWarrior/Panel.theme = unselectedTheme
		$selectKnight/Panel.theme = unselectedTheme
		$selectWizard/Panel.theme = unselectedTheme
		$selectHunter/Panel.theme = selectedTheme
		$selectThief/Panel.theme = unselectedTheme
		$selectCleric/Panel.theme = unselectedTheme
	elif _selectClassIndex == 4:
		$classDescriptionMarginContainer/Panel/Label.text = Text.CLASS_DESCRIPTION_THIEF
		$selectWarrior/Panel.theme = unselectedTheme
		$selectKnight/Panel.theme = unselectedTheme
		$selectWizard/Panel.theme = unselectedTheme
		$selectHunter/Panel.theme = unselectedTheme
		$selectThief/Panel.theme = selectedTheme
		$selectCleric/Panel.theme = unselectedTheme
	elif _selectClassIndex == 5:
		$classDescriptionMarginContainer/Panel/Label.text = Text.CLASS_DESCRIPTION_CLERIC
		$selectWarrior/Panel.theme = unselectedTheme
		$selectKnight/Panel.theme = unselectedTheme
		$selectWizard/Panel.theme = unselectedTheme
		$selectHunter/Panel.theme = unselectedTheme
		$selectThief/Panel.theme = unselectedTheme
		$selectCleric/Panel.theme = selectedTheme

