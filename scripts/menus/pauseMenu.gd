extends CanvasLayer

var unselectedTheme:Theme = preload("res://media/themes/textBoxTheme.tres")
var selectedTheme:Theme = preload("res://media/themes/selectedTeme.tres")

enum MENU_STATES { 
	MAIN, 
	RULES,
	INVENTORY, 
	INVENTORY_USE,
	INVENTORY_USE_CHARACTER,
	INVENTORY_EQUIP,
	INVENTORY_EQUIP_CHARACTER,
	STATUS
}
enum INPUT_BLOCKED {
	YES,NO
}
var _inputWait:float = 0.2
var _inputBlocked:INPUT_BLOCKED = INPUT_BLOCKED.NO
var _state:MENU_STATES = MENU_STATES.MAIN
var _mainIndex:int = 0
var _inventoryIndex:int = 0
var _inventoryUseIndex:int = 0
var _inventoryEquipIndex:int = 0
var _characterIndex:int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("SET_GLOBAL_STATE", _on_globalStateChange)
	Events.connect("INPUT_UP", _on_inputUp)
	Events.connect("INPUT_DOWN", _on_inputDown)
	Events.connect("INPUT_ACCEPT", _on_inputAccept)
	Events.connect("INPUT_CANCEL", _on_inputCancel)
	Events.connect("CHARACTER_SELECT_ACCEPTED", _on_characterSelectAccepted)
	Events.connect("CHARACTER_SELECT_CANCEL", _on_characterSelectCancel)
	updateUI()

func _on_globalStateChange() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_PAUSE_SCREEN:
		self.visible = true
	else:
		self.visible = false
		
	updateUI()
		
		
func setInputBlocked() -> void:
		_inputBlocked = INPUT_BLOCKED.YES
		$Timer.start(_inputWait)
		
		
		
func _on_characterSelectAccepted(position:int) -> void:
	pass
	
func _on_characterSelectCancel() -> void:
	if _state == MENU_STATES.STATUS:
		_state = MENU_STATES.MAIN
		
	setInputBlocked()
		
func setMainIndex(increase:bool) -> void:
	if increase:
		_mainIndex += 1
	else:
		_mainIndex -= 1
	if _mainIndex < 0:
		_mainIndex = 0
	if _mainIndex > 2:
		_mainIndex = 2
		

		
func _on_inputUp() -> void:
	if _inputBlocked == INPUT_BLOCKED.NO:
		setInputBlocked()
		if _state == MENU_STATES.MAIN:
			setMainIndex(false)
			
		updateUI()
		
	
func _on_inputDown() -> void:
	if _inputBlocked == INPUT_BLOCKED.NO:
		setInputBlocked()
		if _state == MENU_STATES.MAIN:
			setMainIndex(true)
			
		updateUI()
	
func _on_inputAccept() -> void:
	if _inputBlocked == INPUT_BLOCKED.NO:
		setInputBlocked()
		if _state == MENU_STATES.MAIN:
			if _mainIndex == 0:
				_state = MENU_STATES.INVENTORY
			elif _mainIndex == 1:
				_state = MENU_STATES.STATUS
			elif _mainIndex == 2:
				_state = MENU_STATES.RULES
		
		
	updateUI()
	
func _on_inputCancel() -> void:
	if _inputBlocked == INPUT_BLOCKED.NO:
		setInputBlocked()
		if _state == MENU_STATES.MAIN:
			Events.emit_signal("SET_GLOBAL_STATE", Enums.SYSTEM_GLOBAL_STATES.ON_MAP)
			
		if _state == MENU_STATES.STATUS:
			_state = MENU_STATES.MAIN
		if _state == MENU_STATES.INVENTORY:
			_state = MENU_STATES.MAIN
		if _state == MENU_STATES.RULES:
			_state = MENU_STATES.MAIN
	updateUI()

func updateUI() -> void:
	if _state == MENU_STATES.MAIN:
		setMainVisible(true)
		setCharacterSelectVisible(false)
		setMainTheme()
	else:
		setMainVisible(false)
		
	if _state == MENU_STATES.STATUS:
		setCharacterCardVisible(true)
		setCharacterSelectVisible(true)
	else:
		setCharacterCardVisible(false)
		
		
	if _state == MENU_STATES.INVENTORY || _state == MENU_STATES.INVENTORY_EQUIP || _state == MENU_STATES.INVENTORY_USE || _state == MENU_STATES.INVENTORY_EQUIP_CHARACTER || _state == MENU_STATES.INVENTORY_USE_CHARACTER:
		setInventoryMenuVisible(true)
#		setCharacterCardVisible(true)
	else:
		setInventoryMenuVisible(false)
#		setCharacterCardVisible(false)
		
	if _state == MENU_STATES.RULES:
		setRulesMenuVisible(true)
	else:
		setRulesMenuVisible(false)



func setMainTheme() -> void:
	if _mainIndex == 0:
		$itemsMarginContainer/Panel.theme = selectedTheme
		$statusMarginContainer/Panel.theme = unselectedTheme
		$rulesMarginContainer/Panel.theme = unselectedTheme
	elif _mainIndex == 1:
		$itemsMarginContainer/Panel.theme = unselectedTheme
		$statusMarginContainer/Panel.theme = selectedTheme
		$rulesMarginContainer/Panel.theme = unselectedTheme
	elif _mainIndex == 2:
		$itemsMarginContainer/Panel.theme = unselectedTheme
		$statusMarginContainer/Panel.theme = unselectedTheme
		$rulesMarginContainer/Panel.theme = selectedTheme

func setMainVisible(visible:bool) -> void:
	$itemsMarginContainer.visible = visible
	$statusMarginContainer.visible = visible
	$rulesMarginContainer.visible = visible

func setInventoryMenuVisible(visible:bool) -> void:
	$invetoryItemsAll.visible = visible
	
func setCharacterSelectVisible(visible:bool) -> void:
	$characterSelect.visible = visible
	
	
func setCharacterCardVisible(visible:bool) -> void:
	$characterCard.visible = visible

func setRulesMenuVisible(visible:bool) -> void:
	$rulesMenu.visible = visible 

func _on_timer_timeout():
	$Timer.stop()
	_inputBlocked = INPUT_BLOCKED.NO
	
