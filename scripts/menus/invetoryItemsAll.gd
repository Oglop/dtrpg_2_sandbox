extends CanvasLayer

var _active:bool = false
#var _wait:float = 0.2
var _state:MENU_STATE = MENU_STATE.MAIN
var _isPressable:PRESSABLE = PRESSABLE.NO
enum MENU_STATE {
	MAIN,
	EQUIP_WEAPON,
	EQUIP_ARMOR,
	EQUIP_ACCESSORY,
	USE
}
enum PRESSABLE {
	YES,
	NO
}

var _index:int = 0
#var _actualIndex:int = 0
#var _viewableSize:int = 12
var _viewableFirst:int = 0
var _viewableLast:int = 11
var _viewableList:Array = []
var _indexWasMinusOne:bool = false

func _ready():
	Events.connect("INPUT_UP", _on_inputUp)
	Events.connect("INPUT_DOWN", _on_inputDown)
	Events.connect("INPUT_ACCEPT", _on_inputAccept)
	Events.connect("INPUT_CANCEL", _on_inputCancel)
	Events.connect("SET_INVENTORY_ITEMS_ALL_ACTIVE", _on_setActive)
	Events.connect("CHARACTER_SELECT_ACCEPTED",_on_characterSelectAccepted )
	Events.connect("CHARACTER_SELECT_CANCEL", _on_characterSelectCancel)
	Events.connect("CHARACTER_SELECT_CHANGED", _on_characterSelectChanged)
	Events.connect("PARTY_USED_ITEM", refreshViewableList)
	
	
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.POTION)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.POTION)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.POTION)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.POTION)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.HERB)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.SHORT_SWORD)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.ELIXIR)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.ELIXIR)
	
	## DEBUG
	Data.PARTY_ITEMS.append({"purchaseble": true,"cost": 10,"type": Enums.ITEM_TYPES.WEAPON_BLUNT,"name": "Club1","value": 6,"magicValue": 0,"quantity": 1})
	Data.PARTY_ITEMS.append({"purchaseble": true,"cost": 10,"type": Enums.ITEM_TYPES.WEAPON_BLUNT,"name": "Club2","value": 6,"magicValue": 0,"quantity": 1})
	Data.PARTY_ITEMS.append({"purchaseble": true,"cost": 10,"type": Enums.ITEM_TYPES.WEAPON_BLUNT,"name": "Club3","value": 6,"magicValue": 0,"quantity": 1})
	Data.PARTY_ITEMS.append({"purchaseble": true,"cost": 10,"type": Enums.ITEM_TYPES.WEAPON_BLUNT,"name": "Club4","value": 6,"magicValue": 0,"quantity": 1})
	Data.PARTY_ITEMS.append({"purchaseble": true,"cost": 10,"type": Enums.ITEM_TYPES.WEAPON_BLUNT,"name": "Club5","value": 6,"magicValue": 0,"quantity": 1})
	Data.PARTY_ITEMS.append({"purchaseble": true,"cost": 10,"type": Enums.ITEM_TYPES.WEAPON_BLUNT,"name": "Club6","value": 6,"magicValue": 0,"quantity": 1})
	Data.PARTY_ITEMS.append({"purchaseble": true,"cost": 10,"type": Enums.ITEM_TYPES.WEAPON_BLUNT,"name": "Club7","value": 6,"magicValue": 0,"quantity": 1})
	Data.PARTY_ITEMS.append({"purchaseble": true,"cost": 10,"type": Enums.ITEM_TYPES.WEAPON_BLUNT,"name": "Club8","value": 6,"magicValue": 0,"quantity": 1})
	Data.PARTY_ITEMS.append({"purchaseble": true,"cost": 10,"type": Enums.ITEM_TYPES.WEAPON_BLUNT,"name": "Club9","value": 6,"magicValue": 0,"quantity": 1})
	Data.PARTY_ITEMS.append({"purchaseble": true,"cost": 10,"type": Enums.ITEM_TYPES.WEAPON_BLUNT,"name": "Club10","value": 6,"magicValue": 0,"quantity": 1})
	Data.PARTY_ITEMS.append({"purchaseble": true,"cost": 10,"type": Enums.ITEM_TYPES.WEAPON_BLUNT,"name": "Club12","value": 6,"magicValue": 0,"quantity": 1})
	Data.PARTY_ITEMS.append({"purchaseble": true,"cost": 10,"type": Enums.ITEM_TYPES.WEAPON_BLUNT,"name": "Club11","value": 6,"magicValue": 0,"quantity": 1})
	Data.PARTY_ITEMS.append({"purchaseble": true,"cost": 10,"type": Enums.ITEM_TYPES.WEAPON_BLUNT,"name": "Club13","value": 6,"magicValue": 0,"quantity": 1})
	
	
	
	updateUI()
	
#	updateViewableList(_index)
#	updateLabels()
#	setIndexArrowPosition(_index)
	
	_on_setActive(false)

func setUnpressable(delay = 0.2) -> void:
	$Timer.start(delay)
	_isPressable = PRESSABLE.NO

func _on_setActive(active:bool) -> void:
	_active = active
	self.visible = active
	if active:
		setIndexArrowPosition(_index)
		_index = 0
#		_actualIndex = 0
		setUnpressable(0.4)
		populateViewableList()
		updateLabels()
		setIndexArrowPosition(_index)
		
func _on_characterSelectChanged(position:int) -> void:
	if _state == MENU_STATE.EQUIP_WEAPON:
		var canEquip = CharacterHandler.getEquipableByTypeAndPosition(position, Data.PARTY_ITEMS[_index].type)
		if position == 0:
			Events.emit_signal("COMPARE_EQUIPABLES", Data.CHARACTER_1_WEAPON, Data.PARTY_ITEMS[_index], canEquip)
		elif position == 1:
			Events.emit_signal("COMPARE_EQUIPABLES", Data.CHARACTER_2_WEAPON, Data.PARTY_ITEMS[_index], canEquip)
		elif position == 2:
			Events.emit_signal("COMPARE_EQUIPABLES", Data.CHARACTER_3_WEAPON, Data.PARTY_ITEMS[_index], canEquip)
		elif position == 3:
			Events.emit_signal("COMPARE_EQUIPABLES", Data.CHARACTER_4_WEAPON, Data.PARTY_ITEMS[_index], canEquip)
	elif _state == MENU_STATE.EQUIP_ARMOR:
		var canEquip = CharacterHandler.getEquipableByTypeAndPosition(position, Data.PARTY_ITEMS[_index].type)
		if position == 0:
			Events.emit_signal("COMPARE_EQUIPABLES", Data.CHARACTER_1_ARMOR, Data.PARTY_ITEMS[_index], canEquip)
		elif position == 1:
			Events.emit_signal("COMPARE_EQUIPABLES", Data.CHARACTER_1_ARMOR, Data.PARTY_ITEMS[_index], canEquip)
		elif position == 2:
			Events.emit_signal("COMPARE_EQUIPABLES", Data.CHARACTER_1_ARMOR, Data.PARTY_ITEMS[_index], canEquip)
		elif position == 3:
			Events.emit_signal("COMPARE_EQUIPABLES", Data.CHARACTER_1_ARMOR, Data.PARTY_ITEMS[_index], canEquip)
	elif _state == MENU_STATE.EQUIP_ACCESSORY:
		var canEquip = CharacterHandler.getEquipableByTypeAndPosition(position, Data.PARTY_ITEMS[_index].type)
		if position == 0:
			Events.emit_signal("COMPARE_EQUIPABLES", Data.CHARACTER_1_ACCESSORY, Data.PARTY_ITEMS[_index], canEquip)
		elif position == 1:
			Events.emit_signal("COMPARE_EQUIPABLES", Data.CHARACTER_2_ACCESSORY, Data.PARTY_ITEMS[_index], canEquip)
		elif position == 2:
			Events.emit_signal("COMPARE_EQUIPABLES", Data.CHARACTER_3_ACCESSORY, Data.PARTY_ITEMS[_index], canEquip)
		elif position == 3:
			Events.emit_signal("COMPARE_EQUIPABLES", Data.CHARACTER_4_ACCESSORY, Data.PARTY_ITEMS[_index], canEquip)
		
func _on_characterSelectAccepted(position:int) -> void:
	setUnpressable()
	Events.emit_signal("CHARACTER_SELECT_ACTIVE", false)
	Events.emit_signal("HIDE_COMPARE_EQUIPABLES")
	if _state == MENU_STATE.USE:
		var item = InventoryHandler.withdrawItem(Data.PARTY_ITEMS[_index].name)
		InventoryHandler.useConsumable(item, position)
		_state = MENU_STATE.MAIN
	if _state == MENU_STATE.EQUIP_WEAPON:
		var weapon = InventoryHandler.withdrawItem(Data.PARTY_ITEMS[_index].name)
		InventoryHandler.equipWeaponCharacter(position, weapon)
		_state = MENU_STATE.MAIN
		_index = 0
	populateViewableList()
	updateLabels()
	setIndexArrowPosition(_index)
	
func _on_characterSelectCancel() -> void:
	Events.emit_signal("CHARACTER_SELECT_ACTIVE", false)
	Events.emit_signal("HIDE_COMPARE_EQUIPABLES")
	if _state == MENU_STATE.USE:
		_state = MENU_STATE.MAIN

func _on_inputDown() -> void:
	if _active:
		if _isPressable == PRESSABLE.YES:
			setUnpressable()
			if _state == MENU_STATE.MAIN:
				setViewableScrollIndex(true)
			updateUI()
		
func _on_inputUp() -> void:
	if _active:
		if _isPressable == PRESSABLE.YES:
			setUnpressable()
			if _state == MENU_STATE.MAIN:
				setViewableScrollIndex(false)
			updateUI()
			
func _on_inputAccept() -> void:
	if _active:
		if _isPressable == PRESSABLE.YES:
			if _state == MENU_STATE.MAIN:
				#print(Data.PARTY_ITEMS[_index].name)
				var type = Data.PARTY_ITEMS[_index].type
				if type == Enums.ITEM_TYPES.CONSUMABLE:
					_state = MENU_STATE.USE
					Events.emit_signal("CHARACTER_SELECT_ACTIVE", true)

				elif (type == Enums.ITEM_TYPES.ARMOR_HEAVY || 
						type == Enums.ITEM_TYPES.ARMOR_LIGHT):
					_state = MENU_STATE.EQUIP_ARMOR
					Events.emit_signal("VISIBLE_CHARACTER_CARD", true)
					Events.emit_signal("CHARACTER_SELECT_ACTIVE_TYPE", type)
				elif (type == Enums.ITEM_TYPES.WEAPON_BLUNT || 
						type == Enums.ITEM_TYPES.WEAPON_RANGED || 
						type == Enums.ITEM_TYPES.WEAPON_SPEAR || 
						type == Enums.ITEM_TYPES.WEAPON_STAFF || 
						type == Enums.ITEM_TYPES.WEAPON_SWORD):
					_state = MENU_STATE.EQUIP_WEAPON
					Events.emit_signal("VISIBLE_CHARACTER_CARD", true)
					Events.emit_signal("CHARACTER_SELECT_ACTIVE_TYPE", type)
				elif (type == Enums.ITEM_TYPES.ASSESSORY_RING || 
						type == Enums.ITEM_TYPES.ASSESSORY_HELMET):
					_state = MENU_STATE.EQUIP_ACCESSORY
					Events.emit_signal("VISIBLE_CHARACTER_CARD", true)
					Events.emit_signal("CHARACTER_SELECT_ACTIVE_TYPE", type)
				
			setUnpressable()
		
func _on_inputCancel() -> void:
	if _active:
		if _isPressable == PRESSABLE.YES:
			if _state == MENU_STATE.USE:
				_state = MENU_STATE.MAIN
			elif _state == MENU_STATE.EQUIP_WEAPON:
				_state = MENU_STATE.MAIN
			elif _state == MENU_STATE.EQUIP_ARMOR:
				_state = MENU_STATE.MAIN
			elif _state == MENU_STATE.EQUIP_ACCESSORY:
				_state = MENU_STATE.MAIN
		setUnpressable()
				
func setViewableScrollIndex(increment:bool) -> void:
	if increment:
		_index += 1
	else:
		_index -= 1

	if _index > Data.PARTY_ITEMS.size() - 1:
		_index = Data.PARTY_ITEMS.size() - 1
	if _index < 0:
		_indexWasMinusOne = true
		_index = 0
		
func populateViewableList() -> void:
	_viewableList = []
	for n in range(_viewableFirst, _viewableLast + 1):
		if Data.PARTY_ITEMS.size() > n:
			_viewableList.append(Data.PARTY_ITEMS[n])
		else:
			_viewableList.append({ "name": "", "quantity": -1 })
			
func scrollUpViewable() -> void:
	_viewableFirst -= 1
	_viewableLast -= 1
	if _viewableFirst < 0:
		_viewableFirst = 0
		_viewableLast = 4

func scrollDownViewable() -> void:
	_viewableFirst += 1
	_viewableLast += 1
	if _viewableLast > Data.PARTY_ITEMS.size() - 1:
		_viewableFirst = Data.PARTY_ITEMS.size() - 4
		_viewableLast = Data.PARTY_ITEMS.size() - 1
		
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
	$menuArrow.position = Vector2i(x, y)
	#print(str("_index: ", _index, ", _viewableFirst: ", _viewableFirst, ", _viewableLast: ", _viewableLast, ", arrowIndex: ", index))
 
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

func refreshViewableList() -> void:
	if _index > _viewableLast:
		scrollDownViewable()
		populateViewableList() 
	elif _index < _viewableFirst:
		scrollUpViewable()
		populateViewableList()
	elif _indexWasMinusOne:
		_indexWasMinusOne = false
		_viewableFirst = 0
		_viewableLast = 11
		populateViewableList()

func updateUI() -> void:
	if _state == MENU_STATE.MAIN:
		var arrowIndex:int = _index - _viewableFirst
		var _viewableExcepts:int = _index - _viewableFirst
		if _index >= 12 && _viewableExcepts > 10:
			arrowIndex = 11
		if arrowIndex < 0:
			arrowIndex = 0
		setIndexArrowPosition(arrowIndex)
		refreshViewableList()
		updateLabels()

func _on_timer_timeout():
	$Timer.stop()
	_isPressable = PRESSABLE.YES
