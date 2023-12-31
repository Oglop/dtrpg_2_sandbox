extends CanvasLayer

enum PRESSABLE {
	YES,
	NO
}
enum MERCHANT_STATES {
	SELECT_ITEM,
	ACCEPT_ITEM
}

var _index:int = 0
var _state:MERCHANT_STATES = MERCHANT_STATES.SELECT_ITEM
var _isPressable:PRESSABLE = PRESSABLE.YES
var _sellableList:Array = []
var _viewableList:Array = []
var _viewableFirst:int = 0
var _viewableLast:int = 4
var _discount:float = 0
var _indexWasMinusOne:bool = false

func _ready():
	Events.connect("INPUT_UP", _on_inputUp)
	Events.connect("INPUT_DOWN", _on_inputDown)
	Events.connect("INPUT_ACCEPT", _on_inputAccept)
	Events.connect("INPUT_CANCEL", _on_inputCancel)
	Events.connect("SET_GLOBAL_STATE", _on_globalStateChanged)
	Events.connect("INPUT_UP", _on_inputUp)
	
	# DEBUG
	Data.SYSTEM_STATE = Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_MENU_SELL
	Data.PARTY_CROWNS = 123
	Data.PARTY_ITEMS.append({
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.CONSUMABLE,
		"name": "Potion",
		"value": 100,
		"magicValue": 0,
		"quantity":3
	})
	Data.PARTY_ITEMS.append({
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.CONSUMABLE,
		"name": "Herb",
		"value": 100,
		"magicValue": 0,
		"quantity":2
	})
	Data.PARTY_ITEMS.append({
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.CONSUMABLE,
		"name": "Elixir",
		"value": 1,
		"magicValue": 0,
		"quantity": 1
	})
	Data.PARTY_ITEMS.append({
		"purchaseble": true,
		"cost": 8,
		"type": Enums.ITEM_TYPES.WEAPON_DAGGER,
		"name": "Club",
		"value": 3,
		"magicValue": 0,
		"quantity": 1
	})
	Data.PARTY_ITEMS.append({
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.WEAPON_RANGED,
		"name": "Short Bow",
		"value":6,
		"magicValue": 0,
		"quantity": 1
	})
	Data.PARTY_ITEMS.append({
		"purchaseble": true,
		"cost": 2,
		"type": Enums.ITEM_TYPES.ASSESSORY_RING,
		"name": "Iron ring",
		"value": 2,
		"magicValue": 4,
		"quantity": 1
	})
	Data.PARTY_ITEMS.append({
		"purchaseble": true,
		"cost": 10,
		"type": Enums.ITEM_TYPES.ARMOR_LIGHT,
		"name": "Robe",
		"value": 2,
		"magicValue": 4,
		"quantity": 1
	})
	
	populateSellabeleList()
	poulateViewableList()
	updateUI()

func _on_activateMerchantSellMenu(active:bool) -> void:
	setUnpressable()
	_index = 0
	_discount = CharacterHandler.getPartyDiscount()
	updateUI()
	
func _on_globalStateChanged(globalState:Enums.SYSTEM_GLOBAL_STATES) -> void:
	if globalState == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_MENU_SELL:
		_on_activateMerchantSellMenu(true)
	else:
		_on_activateMerchantSellMenu(false)

func _on_inputUp() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_MENU_SELL:
		if _isPressable == PRESSABLE.YES:
			setUnpressable()
			if _state == MERCHANT_STATES.SELECT_ITEM:
				if _index > _viewableLast:
					_index = _viewableLast - 1
				_index -= 1
				if _index < 0:
					_indexWasMinusOne = true
					_index = 0
			updateUI()
	
func _on_inputDown() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_MENU_SELL:
		if _isPressable == PRESSABLE.YES:
			setUnpressable()
			if _state == MERCHANT_STATES.SELECT_ITEM:
				_index += 1
				if _index > _sellableList.size() - 1:
					_index = _sellableList.size() - 1
			updateUI()
	
func _on_inputAccept() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_MENU_SELL:
		if _isPressable == PRESSABLE.YES:
			setUnpressable()
			if _state == MERCHANT_STATES.SELECT_ITEM:
				_state = MERCHANT_STATES.ACCEPT_ITEM
			elif _state == MERCHANT_STATES.ACCEPT_ITEM:
				_state = MERCHANT_STATES.SELECT_ITEM
				sellItem()
			updateUI()
	
func _on_inputCancel() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_MENU_SELL:
		if _isPressable == PRESSABLE.YES:
			setUnpressable()
			if _state == MERCHANT_STATES.ACCEPT_ITEM:
				_state = MERCHANT_STATES.SELECT_ITEM
			updateUI()

func _on_timer_timeout():
	_isPressable = PRESSABLE.YES
	$Timer.stop()
	
func sellItem() -> void:
	var rate:float = 0.5 - _discount
	var quantity:int = _sellableList[_index].quantity
	Events.emit_signal("PARTY_ADD_GOLD", _viewableList[_index].cost * rate)
	Events.emit_signal("INVENTORY_DELETE", _sellableList[_index].name)
	populateSellabeleList()
	poulateViewableList()
	if quantity <= 1:
		_index -= 1
		if _index < 0:
			_index = 0
	
		
func setUnpressable(wait:float = 0.2) -> void:
	_isPressable = PRESSABLE.NO
	$Timer.start(wait)
	
func populateSellabeleList() -> void:
	_sellableList = []
	for item in Data.PARTY_ITEMS:
		if item.type != Enums.ITEM_TYPES.KEY && item.quantity > 0:
			_sellableList.append(item)
	
func refreshViewableList() -> void:
	
	if _index > _viewableLast:
		scrollDownViewable()
		poulateViewableList() 
	elif _index < _viewableFirst:
		scrollUpViewable()
		poulateViewableList()
	elif _indexWasMinusOne:
		_indexWasMinusOne = false
		_viewableFirst = 0
		_viewableLast = 4
		poulateViewableList()
		
func scrollUpViewable() -> void:
	_viewableFirst -= 1
	_viewableLast -= 1
	if _viewableFirst < 0:
		_viewableFirst = 0
		_viewableLast = 4

func scrollDownViewable() -> void:
	_viewableFirst += 1
	_viewableLast += 1
	if _viewableLast > _sellableList.size() - 1:
		_viewableFirst = _sellableList.size() - 4
		_viewableLast = _sellableList.size() - 1
	
func poulateViewableList() -> void:
	_viewableList = []
	for n in range(_viewableFirst, _viewableLast + 1):
		if _sellableList.size() > n:
			_viewableList.append(_sellableList[n])
	
func updateItemLabels() ->  void:
	var rate:float = 0.5 - _discount
	if _viewableList.size() > 0:
		$itemsMarginContainer/Panel/itemNameLabel1.text = _viewableList[0].name
		$itemsMarginContainer/Panel/itemQuantityLabel1.text = str(_viewableList[0].quantity)
		$itemsMarginContainer/Panel/itemPriceLabel1.text = str(_viewableList[0].cost * rate)
	else:
		$itemsMarginContainer/Panel/itemNameLabel1.text = ""
		$itemsMarginContainer/Panel/itemQuantityLabel1.text = ""
		$itemsMarginContainer/Panel/itemPriceLabel1.text = ""
	if _viewableList.size() > 1:
		$itemsMarginContainer/Panel/itemNameLabel2.text = _viewableList[1].name
		$itemsMarginContainer/Panel/itemQuantityLabel2.text = str(_viewableList[1].quantity)
		$itemsMarginContainer/Panel/itemPriceLabel2.text = str(_viewableList[1].cost * rate)
	else:
		$itemsMarginContainer/Panel/itemNameLabel2.text = ""
		$itemsMarginContainer/Panel/itemQuantityLabel2.text = ""
		$itemsMarginContainer/Panel/itemPriceLabel2.text = ""
	if _viewableList.size() > 2:
		$itemsMarginContainer/Panel/itemNameLabel3.text = _viewableList[2].name
		$itemsMarginContainer/Panel/itemQuantityLabel3.text = str(_viewableList[2].quantity)
		$itemsMarginContainer/Panel/itemPriceLabel3.text = str(_viewableList[2].cost * rate)
	else:
		$itemsMarginContainer/Panel/itemNameLabel3.text = ""
		$itemsMarginContainer/Panel/itemQuantityLabel3.text = ""
		$itemsMarginContainer/Panel/itemPriceLabel3.text = ""
	if _viewableList.size() > 3:
		$itemsMarginContainer/Panel/itemNameLabel4.text = _viewableList[3].name
		$itemsMarginContainer/Panel/itemQuantityLabel4.text = str(_viewableList[3].quantity)
		$itemsMarginContainer/Panel/itemPriceLabel4.text = str(_viewableList[3].cost * rate)
	else:
		$itemsMarginContainer/Panel/itemNameLabel4.text = ""
		$itemsMarginContainer/Panel/itemQuantityLabel4.text = ""
		$itemsMarginContainer/Panel/itemPriceLabel4.text = ""
	if _viewableList.size() > 4:
		$itemsMarginContainer/Panel/itemNameLabel5.text = _viewableList[4].name
		$itemsMarginContainer/Panel/itemQuantityLabel5.text = str(_viewableList[4].quantity)
		$itemsMarginContainer/Panel/itemPriceLabel5.text = str(_viewableList[4].cost * rate)
	else:
		$itemsMarginContainer/Panel/itemNameLabel5.text = ""
		$itemsMarginContainer/Panel/itemQuantityLabel5.text = ""
		$itemsMarginContainer/Panel/itemPriceLabel5.text = ""
	
func updateUI() -> void:
	$crownsMarginContainer/Panel/crownsMoneyLabel.text = str(Data.PARTY_CROWNS)
	if _state == MERCHANT_STATES.SELECT_ITEM:
		$confirmMarginContainer.visible = false
		var arrowIndex:int = _index - _viewableFirst
		if _index >= 5 && _index - _viewableFirst != 3:
			arrowIndex = 4
		elif arrowIndex < 0:
			arrowIndex = 0
		print(str("index: ", _index, ", first: ", _viewableFirst, ", last: ", _viewableLast, ", arrowIndex: ", arrowIndex))
		$arrowSprite.position = Vector2i(15, 15 + (arrowIndex * 12))
		refreshViewableList()
		updateItemLabels()
	if _state == MERCHANT_STATES.ACCEPT_ITEM:
		var rate:float = 0.5 - _discount
		$confirmMarginContainer.visible = true
		$arrowSprite.position = Vector2i(299, 69)
		$confirmMarginContainer/Panel/itemNameLabel.text = _viewableList[_index].name
		$confirmMarginContainer/Panel/costLabel.text = str(_viewableList[_index].cost * rate)
