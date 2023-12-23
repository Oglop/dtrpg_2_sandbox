extends CanvasLayer

var BUTTON_WAIT:float = 0.2
var _readIndex = 0
var _state:states = states.BUSY
var _title:String = ""
var _messages:Array = []
enum states {
	AWAITING_INPUT,
	BUSY
}

func _ready():
	Events.connect("MESSAGE_BOX_QUEUE_MESSAGES", _on_queueMessages)
	Events.connect("INPUT_ACCEPT", _on_pressAccept)
	Events.connect("INPUT_CANCEL", _on_pressCancel)
	Events.connect("SET_GLOBAL_STATE", _on_globalStateChange)

	updateLabels()
	$Timer.start(BUTTON_WAIT)
	
func _on_globalStateChange(globalState:Enums.SYSTEM_GLOBAL_STATES) -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MESSAGE_BOX:
		self.visible = true
		updateLabels()
	else:
		self.visible = false
	
func _on_pressAccept() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MESSAGE_BOX:
		if _state == states.AWAITING_INPUT:
			if _readIndex < _messages.size() - 1:
				_readIndex += 1
				updateLabels()
				handleButtonPressed()
			else:
				Events.emit_signal("SET_GLOBAL_STATE", Enums.SYSTEM_GLOBAL_STATES.ON_MAP)
				handleButtonPressed()
	
func _on_pressCancel() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MESSAGE_BOX:
		if _state == states.AWAITING_INPUT:
			if _readIndex == 0 && _messages.size() == 1:
				Events.emit_signal("SET_GLOBAL_STATE", Enums.SYSTEM_GLOBAL_STATES.ON_MAP)
				handleButtonPressed()
			if _readIndex > 0:
				_readIndex -= 1
				updateLabels()
				handleButtonPressed()
	
func _on_queueMessages(title:String, messages:Array) -> void:
	_title = title
	_messages = messages
	updateLabels()

func clearQueue() -> void:
	_title = ""
	_messages = []
	$MarginContainer/Panel/LabelTitle.text = _title
	$MarginContainer/Panel/LabelMessage.text = ""
	
func updateLabels() -> void:
	$MarginContainer/Panel/LabelTitle.text = _title
	if _messages.size() > 0:
		$MarginContainer/Panel/LabelMessage.text = _messages[_readIndex]

func handleButtonPressed() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.ON_MAP:
		$Timer.start(BUTTON_WAIT)
		_state = states.BUSY

func _on_timer_timeout():
	$Timer.stop()
	_state = states.AWAITING_INPUT
