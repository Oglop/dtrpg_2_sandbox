extends CanvasLayer

var messageQueue:Array = []
var WAIT_NOT_PRESSING:float = 2.0
var WAIT_PRESSING_CANCEL:float = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	Events.connect("SYSTEM_WRITE_LOG", _on_message_write_log)

func _on_message_write_log(message:String, type:Enums.SYSTEM_LOG_TYPE, interupt:bool = false) -> void:
	if interupt:
		writeMessageInterupt(message)
	else:
		if type == Enums.SYSTEM_LOG_TYPE.BATTLE && Data.SYSTEM_LOG_BATTLE == true:
			messageQueue.push_back(message)
		if type == Enums.SYSTEM_LOG_TYPE.MAP && Data.SYSTEM_LOG_MAP == true:
			messageQueue.push_back(message)
		if type == Enums.SYSTEM_LOG_TYPE.NPC && Data.SYSTEM_LOG_NPC == true:
			messageQueue.push_back(message)
		writeNextMessage()

func writeMessageInterupt(message:String):
	messageQueue.clear()
	self.visible = true
	$Timer.start(WAIT_NOT_PRESSING)
	$MarginContainer/Panel/Label.text = message

func writeNextMessage():
	if $Timer.is_stopped():
		self.visible = true
		if Input.is_action_pressed("CANCEL"):
			$Timer.start(WAIT_PRESSING_CANCEL)
		else: 
			$Timer.start(WAIT_NOT_PRESSING)
		if !messageQueue.is_empty():
			$MarginContainer/Panel/Label.text = messageQueue[0]
		else: 
			self.visible = false
	

func _on_timer_timeout():
	$Timer.stop()
	messageQueue.pop_front()
	writeNextMessage()
	
