extends CanvasLayer

var TIME_OUT:float = 1.6
var HP_BOX_TEXT = "HP %3d / %3d"
# Called when the node enters the scene tree for the first time.
func _ready():
	updateHealthBox()
	self.visible = false
	Events.connect("PARTY_MOVED", _on_playerMoved)
	Events.connect("UPDATE_HP_BOX", _on_updateHealth)
	Events.connect("HP_BOX_VISIBLE", _on_setHpBoxVisiblility)

func _on_setHpBoxVisiblility(visible:bool) -> void:
	self.visible = false

func _on_playerMoved():
	self.visible = false
	$Timer.start(TIME_OUT)
	
func _on_timer_timeout():
	if Data.SYSTEM_STATE != Enums.SYSTEM_GLOBAL_STATES.IN_PAUSE_SCREEN:
		self.visible = true
		$Timer.stop()
	
func _on_updateHealth():
	if Data.SYSTEM_STATE != Enums.SYSTEM_GLOBAL_STATES.IN_PAUSE_SCREEN:
		self.visible = true
		$Timer.stop()
		updateHealthBox()
	
func updateHealthBox():
	$MarginContainer/Panel/LabelCharacter1.text = Data.CHARACTER_1_NAME
	$MarginContainer/Panel/LabelCharacter2.text = Data.CHARACTER_2_NAME
	$MarginContainer/Panel/LabelCharacter3.text = Data.CHARACTER_3_NAME
	$MarginContainer/Panel/LabelCharacter4.text = Data.CHARACTER_4_NAME
	$MarginContainer/Panel/LabelCharacterHP1.text = HP_BOX_TEXT % [Data.CHARACTER_1_HEALTH_CURRENT, Data.CHARACTER_1_HEALTH_MAX]
	$MarginContainer/Panel/LabelCharacterHP2.text = HP_BOX_TEXT % [Data.CHARACTER_2_HEALTH_CURRENT, Data.CHARACTER_2_HEALTH_MAX]
	$MarginContainer/Panel/LabelCharacterHP3.text = HP_BOX_TEXT % [Data.CHARACTER_3_HEALTH_CURRENT, Data.CHARACTER_3_HEALTH_MAX]
	$MarginContainer/Panel/LabelCharacterHP4.text = HP_BOX_TEXT % [Data.CHARACTER_4_HEALTH_CURRENT, Data.CHARACTER_4_HEALTH_MAX]
	
	
