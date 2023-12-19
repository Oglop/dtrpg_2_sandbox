extends CanvasLayer

var _active:bool = false
var _wait:float = 0.2
var _state:MENU_STATE = MENU_STATE.MAIN
var _pressableState:PRESSABLE = PRESSABLE.NO
enum MENU_STATE {
	MAIN,
	EQUIP,
	USE
}
enum PRESSABLE {
	YES,
	NO
}

var _viewableScrollIndex:int = 0
var _actualIndex:int = 0
var _viewableSize:int = 12
var _viewableList:Array = []

func _ready():
	Events.connect("INPUT_UP", _on_inputUp)
	Events.connect("INPUT_DOWN", _on_inputDown)
	Events.connect("INPUT_ACCEPT", _on_inputAccept)
	Events.connect("INPUT_CANCEL", _on_inputCancel)
	Events.connect("SET_INVENTORY_ITEMS_ALL_ACTIVE", _on_setActive)
	Events.connect("CHARACTER_SELECT_ACCEPTED",_on_characterSelectAccepted )
	Events.connect("CHARACTER_SELECT_CANCEL", _on_characterSelectCancel)
	
	
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.POTION)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.POTION)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.POTION)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.POTION)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.HERB)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.SHORT_SWORD)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.ELIXIR)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.ELIXIR)
	
	updateViewableList(_viewableScrollIndex)
	updateLabels()
	setIndexArrowPosition(_viewableScrollIndex)
	
	_on_setActive(false)

func setUnpressable(delay = 0.2) -> void:
	$Timer.start(delay)
	_pressableState = PRESSABLE.NO

func _on_setActive(active:bool) -> void:
	_active = active
	self.visible = active
	if active:
		_viewableScrollIndex = 0
		_actualIndex = 0
		setUnpressable(0.4)
		
func _on_characterSelectAccepted(position:int) -> void:
	Events.emit_signal("CHARACTER_SELECT_ACTIVE", false)
	if _state == MENU_STATE.USE:
		var item = InventoryHandler.withdrawItem(Data.PARTY_ITEMS[_actualIndex].name)
		InventoryHandler.useConsumable(item, position)
		_state = MENU_STATE.MAIN
	updateViewableList(_viewableScrollIndex)
	updateLabels()
	
func _on_characterSelectCancel() -> void:
	Events.emit_signal("CHARACTER_SELECT_ACTIVE", false)
	if _state == MENU_STATE.USE:
		_state = MENU_STATE.MAIN

func _on_inputDown() -> void:
	if _active:
		if _pressableState == PRESSABLE.YES:
			setUnpressable()
			if _state == MENU_STATE.MAIN:
				setViewableScrollIndex(true)
				setIndexArrowPosition(_viewableScrollIndex)
	
func _on_inputUp() -> void:
	if _active:
		if _pressableState == PRESSABLE.YES:
			setUnpressable()
			if _state == MENU_STATE.MAIN:
				setViewableScrollIndex(false)
				setIndexArrowPosition(_viewableScrollIndex)
			
func _on_inputAccept() -> void:
	if _active:
		if _pressableState == PRESSABLE.YES:
			var type = Data.PARTY_ITEMS[_actualIndex].type
			if type == Enums.ITEM_TYPES.CONSUMABLE:
				_state = MENU_STATE.USE
				Events.emit_signal("CHARACTER_SELECT_ACTIVE", true)
			setUnpressable()
		
func _on_inputCancel() -> void:
	if _active:
		if _pressableState == PRESSABLE.YES:
			if _state == MENU_STATE.USE:
				_state = MENU_STATE.MAIN
		setUnpressable()
				
func setViewableScrollIndex(increment:bool) -> void:
	if increment:
		_viewableScrollIndex += 1
		_actualIndex += 1
	else:
		_viewableScrollIndex -= 1
		_actualIndex -= 1
		
	if _actualIndex > Data.PARTY_ITEMS.size() - 1:
		_actualIndex = Data.PARTY_ITEMS.size() - 1
	if _actualIndex < 0:
			_actualIndex = 0
		
	if _viewableScrollIndex > Data.PARTY_ITEMS.size() - 1:
		_viewableScrollIndex = Data.PARTY_ITEMS.size() - 1
	if _viewableScrollIndex < 0:
			_viewableScrollIndex = 0
		
func updateViewableList(viewableScrollIndex:int) -> void:
	_viewableList = []
	for n in range(_viewableScrollIndex, _viewableScrollIndex + _viewableSize):
		if Data.PARTY_ITEMS.size() > n:
			_viewableList.append(Data.PARTY_ITEMS[n])
		else:
			_viewableList.append({ "name": "", "quantity": -1 })
		
func updateLabels() -> void:
	for n in range(0, _viewableList.size()):
		if _viewableList[n] != null:
			setLabel(n, _viewableList[n].name, _viewableList[n].quantity)
		else:
			setLabel(n, "", 0)

func getItemLabel(item:String, quantity:int) -> String:
	if item == "":
		return ""
	#var itemString = "%-12s" % item
	#var quantityString = "%03d" % quantity
	
	# return "{item} {quantity}".format({"item": "%-12s" % item, "quantity": "%03d" % quantity})
	return "{quantity} {item}".format({"item": item, "quantity": quantity})

func setLabel(index:int, item:String, quantity:int) -> void:
	var label = getLabel(index)
	label.text = getItemLabel(item, quantity)
	
func setIndexArrowPosition(index:int) -> void:
	var x = 15
	var y = 20 + 12 * index
	$menuArrow.position = Vector2(x, y)
	
func getLabel(index:int) -> Label:
	if index == 0:
		return $MarginContainer/Panel/LabelItem1
	elif index == 1:
		return $MarginContainer/Panel/LabelItem2
	elif index == 2:
		return $MarginContainer/Panel/LabelItem3
	elif index == 3:
		return $MarginContainer/Panel/LabelItem4
	elif index == 4:
		return $MarginContainer/Panel/LabelItem5
	elif index == 5:
		return $MarginContainer/Panel/LabelItem6
	elif index == 6:
		return $MarginContainer/Panel/LabelItem7
	elif index == 7:
		return $MarginContainer/Panel/LabelItem8
	elif index == 8:
		return $MarginContainer/Panel/LabelItem9
	elif index == 9:
		return $MarginContainer/Panel/LabelItem10
	elif index == 10:
		return $MarginContainer/Panel/LabelItem11
	else:
		return $MarginContainer/Panel/LabelItem12



func _on_timer_timeout():
	$Timer.stop()
	_pressableState = PRESSABLE.YES
