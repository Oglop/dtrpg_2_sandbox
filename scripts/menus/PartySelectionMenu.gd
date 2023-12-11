extends CanvasLayer
var inputWait:float = 0.2
var _state:menu_states = menu_states.MAIN
var _pressableState:pressableStates = pressableStates.BUSY
var unselectedTheme:Theme = preload("res://media/themes/textBoxTheme.tres")
var selectedTheme:Theme = preload("res://media/themes/selectedTeme.tres")
var _selectClassIndex:int = 0
var _currentCharacterIndex:int = 0
enum menu_states {
	MAIN,
	SELECT_CLASS,
	VIEW_CURRENT
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
		if _state == menu_states.SELECT_CLASS:
			_selectClassIndex -= 1
			if _selectClassIndex < 0:
				_selectClassIndex = 0
		updateUI()
	
func _on_inputDown() -> void:
	if _pressableState == pressableStates.PRESSABLE:
		setPressableBusy()
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
			_state = menu_states.SELECT_CLASS
			_selectClassIndex = 0
			
		updateUI()
		
func _on_inputCancel() -> void:
	if _pressableState == pressableStates.PRESSABLE:
		setPressableBusy()
		
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
		$addMarginContainer.visible = true
		$addMarginContainer/Panel.theme = selectedTheme
		$selectWarrior.visible = false
		$selectKnight.visible = false
		$selectWizard.visible = false
		$selectHunter.visible = false
		$selectThief.visible = false
		$selectCleric.visible = false
	else:
		$addMarginContainer/Panel.theme = unselectedTheme
		
	if _state == menu_states.SELECT_CLASS:
		$selectWarrior.visible = true
		$selectKnight.visible = true
		$selectWizard.visible = true
		$selectHunter.visible = true
		$selectThief.visible = true
		$selectCleric.visible = true
		updateSelectClassThemes()

func updateSelectClassThemes() -> void:
	if _selectClassIndex == 0:
		$selectWarrior/Panel.theme = selectedTheme
		$selectKnight/Panel.theme = unselectedTheme
		$selectWizard/Panel.theme = unselectedTheme
		$selectHunter/Panel.theme = unselectedTheme
		$selectThief/Panel.theme = unselectedTheme
		$selectCleric/Panel.theme = unselectedTheme
	elif _selectClassIndex == 1:
		$selectWarrior/Panel.theme = unselectedTheme
		$selectKnight/Panel.theme = selectedTheme
		$selectWizard/Panel.theme = unselectedTheme
		$selectHunter/Panel.theme = unselectedTheme
		$selectThief/Panel.theme = unselectedTheme
		$selectCleric/Panel.theme = unselectedTheme
	elif _selectClassIndex == 2:
		$selectWarrior/Panel.theme = unselectedTheme
		$selectKnight/Panel.theme = unselectedTheme
		$selectWizard/Panel.theme = selectedTheme
		$selectHunter/Panel.theme = unselectedTheme
		$selectThief/Panel.theme = unselectedTheme
		$selectCleric/Panel.theme = unselectedTheme
	elif _selectClassIndex == 3:
		$selectWarrior/Panel.theme = unselectedTheme
		$selectKnight/Panel.theme = unselectedTheme
		$selectWizard/Panel.theme = unselectedTheme
		$selectHunter/Panel.theme = selectedTheme
		$selectThief/Panel.theme = unselectedTheme
		$selectCleric/Panel.theme = unselectedTheme
	elif _selectClassIndex == 4:
		$selectWarrior/Panel.theme = unselectedTheme
		$selectKnight/Panel.theme = unselectedTheme
		$selectWizard/Panel.theme = unselectedTheme
		$selectHunter/Panel.theme = unselectedTheme
		$selectThief/Panel.theme = selectedTheme
		$selectCleric/Panel.theme = unselectedTheme
	elif _selectClassIndex == 5:
		$selectWarrior/Panel.theme = unselectedTheme
		$selectKnight/Panel.theme = unselectedTheme
		$selectWizard/Panel.theme = unselectedTheme
		$selectHunter/Panel.theme = unselectedTheme
		$selectThief/Panel.theme = unselectedTheme
		$selectCleric/Panel.theme = selectedTheme

