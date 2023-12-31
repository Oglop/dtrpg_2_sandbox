extends CanvasLayer

var unselectedTheme:Theme = preload("res://media/themes/textBoxTheme.tres")
var selectedTheme:Theme = preload("res://media/themes/selectedTeme.tres")

enum PRESSABLE {
	YES, NO
}
var _index:int = 0
var _isPressable:PRESSABLE = PRESSABLE.NO
func _ready():
	Events.connect("INPUT_UP", _on_inputUp)
	Events.connect("INPUT_DOWN", _on_inputDown)
	Events.connect("INPUT_ACCEPT", _on_inputAccept)
	Events.connect("INPUT_CANCEL", _on_inputCancel)
	Events.connect("SET_GLOBAL_STATE", _on_globalStateChanged)
	activateBuyOrSellMenu(false)
	# DEBUG
#	Events.emit_signal("SET_GLOBAL_STATE", Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_SELECT)

func _on_timer_timeout():
	_isPressable = PRESSABLE.YES
	$Timer.stop()

func _on_globalStateChanged(globalState:Enums.SYSTEM_GLOBAL_STATES) -> void:
	if globalState == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_SELECT:
		activateBuyOrSellMenu(true)
	else:
		activateBuyOrSellMenu(false)
		
func _on_inputUp() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_SELECT:
		if _isPressable == PRESSABLE.YES:
			if _index == 1:
				_index = 0
			setUnpressable()
			updateUI()

func _on_inputDown() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_SELECT:
		if _isPressable == PRESSABLE.YES:
			if _index == 0:
				_index = 1
			setUnpressable()
			updateUI()
	
func _on_inputAccept() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_SELECT:
		if _isPressable == PRESSABLE.YES:
			if _index == 0:
				Events.emit_signal("SET_GLOBAL_STATE", Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_MENU_BUY)
			elif _index == 1:
				Events.emit_signal("SET_GLOBAL_STATE", Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_MENU_SELL)
			setUnpressable()
	
func _on_inputCancel() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_SELECT:
		if _isPressable == PRESSABLE.YES:
			Events.emit_signal("SET_GLOBAL_STATE", Enums.SYSTEM_GLOBAL_STATES.ON_MAP)
			setUnpressable()

func setUnpressable(wait:float = 0.2) -> void:
	$Timer.start(wait)
	_isPressable = PRESSABLE.NO

func activateBuyOrSellMenu(active:bool) -> void:
	self.visible = active
	if active:
		_index = 0
		_isPressable = PRESSABLE.YES
		setUnpressable()
		updateUI()

func updateUI() -> void:
	if _index == 0:
		$buyMarginContainer/Panel.theme = selectedTheme
		$sellMarginContainer/Panel.theme = unselectedTheme
	elif _index == 1:
		$buyMarginContainer/Panel.theme = unselectedTheme
		$sellMarginContainer/Panel.theme = selectedTheme
	
