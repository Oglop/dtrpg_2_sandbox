extends CanvasLayer

var rng:RandomNumberGenerator = RandomNumberGenerator.new()
enum PRESSABLE {
	YES,
	NO
}

enum MERCHANT_STATES {
	ITEMS_SELECT,
	ITEMS_ACCEPT
}

var _index:int = 0
var _active:bool = false
var _isPressable:PRESSABLE = PRESSABLE.NO
var _purchaseableItems:Array = []
var _merchantState:MERCHANT_STATES = MERCHANT_STATES.ITEMS_SELECT

var _viewableList:Array = []
var _viewableFirst:int = 0
var _viewableLast:int = 9
var _indexWasMinusOne:bool = false

func _ready():
	Events.connect("MERCHANT_MENU_SET_ACTIVE", _on_merchantMenuSetActive)
	Events.connect("INPUT_UP", _on_inputUp)
	Events.connect("INPUT_DOWN", _on_inputDown)
	Events.connect("INPUT_ACCEPT", _on_inputAccept)
	Events.connect("INPUT_CANCEL", _on_inputCancel)
	Events.connect("SET_GLOBAL_STATE", _on_globalStateChanged)
	_on_merchantMenuSetActive(false)
	
#DEBUG
#	_on_merchantMenuSetActive(true)
#	Data.SYSTEM_STATE = Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_MENU_BUY
#	Data.PARTY_CROWNS = 100
	
	
func _on_globalStateChanged(globalState:Enums.SYSTEM_GLOBAL_STATES) -> void:
	if globalState == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_MENU_BUY:
		_on_merchantMenuSetActive(true)
	else:
		_on_merchantMenuSetActive(false)
	
func _on_merchantMenuSetActive(active:bool, items:Array = []) -> void:
	setUnpressable()
	_index = 0
	_active = active
	self.visible = active
	if _active:
		
		_merchantState = MERCHANT_STATES.ITEMS_SELECT
		if items.size() > 0:
			populatePurchaseableItemsSet(items)
		else:
			populatePurchaseableItemsRandom()
		populateViewableList()
		updateLabels()
	updateUI()
		
	
func _on_inputUp() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_MENU_BUY:
		if _isPressable == PRESSABLE.YES:
			setUnpressable()
			if _merchantState == MERCHANT_STATES.ITEMS_SELECT:
				_index -= 1
				if _index < 0:
					_index = 0
				updateUI()
	
func _on_inputDown() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_MENU_BUY:
		if _isPressable == PRESSABLE.YES:
			setUnpressable()
			if _merchantState == MERCHANT_STATES.ITEMS_SELECT:
				_index += 1
				if _index >= _purchaseableItems.size() - 1:
					_index = _purchaseableItems.size() - 1
				updateUI()
	
func _on_inputAccept() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_MENU_BUY:
		if _isPressable == PRESSABLE.YES:
			setUnpressable(0.5)
			if _merchantState == MERCHANT_STATES.ITEMS_SELECT:
				_merchantState = MERCHANT_STATES.ITEMS_ACCEPT
			elif _merchantState == MERCHANT_STATES.ITEMS_ACCEPT:
				if validatePurchase():
					purchaseItem()
				else:
					# TODO can´t buy
					pass
			updateUI()
	
func _on_inputCancel() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_MENU_BUY:
		if _isPressable == PRESSABLE.YES:
			setUnpressable()
			if _merchantState == MERCHANT_STATES.ITEMS_SELECT:
				Events.emit_signal("SET_GLOBAL_STATE", Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_SELECT)
			if _merchantState == MERCHANT_STATES.ITEMS_ACCEPT:
				_merchantState = MERCHANT_STATES.ITEMS_SELECT
			updateUI()
	
func setViewableScrollIndex(increment:bool) -> void:
	if increment:
		_index += 1
	else:
		_index -= 1

	if _index > _purchaseableItems.size() - 1:
		_index = _purchaseableItems.size() - 1
	if _index < 0:
		_indexWasMinusOne = true
		_index = 0
	
func populateViewableList() -> void:
	_viewableList = []
	for n in range(_viewableFirst, _viewableLast + 1):
		if _purchaseableItems.size() > n:
			_viewableList.append(_purchaseableItems[n])
		else:
			_viewableList.append({ "name": "", "quantity": -1, "cost": 0 })
	
func scrollUpViewable() -> void:
	_viewableFirst -= 1
	_viewableLast -= 1
	if _viewableFirst < 0:
		_viewableFirst = 0
		_viewableLast = 9

func scrollDownViewable() -> void:
	_viewableFirst += 1
	_viewableLast += 1
	if _viewableLast > _purchaseableItems.size() - 1:
		_viewableFirst = _purchaseableItems.size() - 9
		_viewableLast = _purchaseableItems.size() - 1
		
			
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
		_viewableLast = 9
		populateViewableList()

func validatePurchase() -> bool:
	return Data.PARTY_CROWNS >= _purchaseableItems[_index].cost
				
func updateUI() -> void:
	if _merchantState == MERCHANT_STATES.ITEMS_SELECT:
		var arrowIndex:int = _index - _viewableFirst
		var _viewableExcepts:int = _index - _viewableFirst
		if _index >= 10 && _viewableExcepts > 8:
			arrowIndex = 9
		if arrowIndex < 0:
			arrowIndex = 0
		#print(str("_index: ", _index, ", _viewableFirst: ", _viewableFirst, ", _viewableLast: ", _viewableLast, ", arrowIndex: ", arrowIndex))
		$confirmMarginContainer.visible = false
		$arrowSprite.position = Vector2i(15, 16 + (arrowIndex * 12))
		refreshViewableList()
		updateLabels()
	if _merchantState == MERCHANT_STATES.ITEMS_ACCEPT:
		$arrowSprite.position = Vector2i(299, 69)
		$confirmMarginContainer/Panel/costLabel.text = str("-", _purchaseableItems[_index].cost)
		$confirmMarginContainer/Panel/itemNameLabel.text = _purchaseableItems[_index].name
		$confirmMarginContainer.visible = true
			
func populatePurchaseableItemsSet(items:Array) -> void:
	_purchaseableItems.append_array(items)
	
func populatePurchaseableItemsRandom() -> void:
	_purchaseableItems = []
	var totalItems:int = 0
	var noOfPotions:int = rng.randi_range(10, 18)
	totalItems += noOfPotions
	for n in noOfPotions:
		_purchaseableItems.append(Statics.ITEMS["POTION"])
		
	var noOfHerbs:int = rng.randi_range(1, 5)
	totalItems += noOfHerbs
	for n in noOfHerbs:
		_purchaseableItems.append(Statics.ITEMS["HERB"])
		
	var noOfElixirs:int = rng.randi_range(0, 2)
	totalItems += noOfElixirs
	for n in noOfElixirs:
		_purchaseableItems.append(Statics.ITEMS["ELIXIR"])
		
	var noOfAntidotes:int = rng.randi_range(1, 3)
	totalItems += noOfAntidotes
	for n in noOfAntidotes:
		_purchaseableItems.append(Statics.ITEMS["ANTIDOTE"])
		
	var noOfEquipables:int = rng.randi_range(1, 3)
	totalItems += noOfEquipables
	for n in noOfEquipables:
		_purchaseableItems.append(getRandomItemOfType(getRandomEquipableType()))
		
	var noOfLegendary = 0
	if totalItems < 20:
		totalItems += 1
		noOfLegendary = 1

#	"purchaseble": true,
#	"cost": 10,
#	"type": Enums.ITEM_TYPES.CONSUMABLE,
#	"name": "Elixir",
#	"value": 1,
#	"magicValue": 0,
#	"quantity": 1
func getRandomItemOfType(itemType:Enums.ITEM_TYPES) -> Dictionary:
	var items:Array = []
	for key in Statics.ITEMS:
		if Statics.ITEMS[key].purchaseble == true && Statics.ITEMS[key].type == itemType:
			items.append(Statics.ITEMS[key])
	items.shuffle()
	return items[0]
			
func purchaseItem() -> void:
	var boughtItem = _purchaseableItems[_index]
	Events.emit_signal("PARTY_SUB_CROWNS", boughtItem.cost)
	Events.emit_signal("PARTY_ADD_ITEM", boughtItem)
	_purchaseableItems.remove_at(_index)
	postPurchaseRefresh()
			
			
func getRandomEquipableType() -> Enums.ITEM_TYPES:
	var i:int = rng.randi_range(0, 4)
	if i == 0:
		return  Enums.ITEM_TYPES.ARMOR_HEAVY
	elif i == 1:
		return  Enums.ITEM_TYPES.ARMOR_LIGHT
	elif i == 2:
		return  Enums.ITEM_TYPES.ASSESSORY_HELMET
	elif i == 3:
		return  Enums.ITEM_TYPES.ASSESSORY_RING
	elif i == 4:
		return  Enums.ITEM_TYPES.WEAPON_AXE
	elif i == 5:
		return  Enums.ITEM_TYPES.WEAPON_BLUNT
	elif i == 6:
		return  Enums.ITEM_TYPES.WEAPON_DAGGER
	elif i == 7:
		return  Enums.ITEM_TYPES.WEAPON_RANGED
	elif i == 8:
		return  Enums.ITEM_TYPES.WEAPON_SPEAR
	elif i == 0:
		return  Enums.ITEM_TYPES.WEAPON_STAFF
	else:
		return  Enums.ITEM_TYPES.WEAPON_SWORD
	
func postPurchaseRefresh() -> void:
	_index -= 1
	if _index < 0:
		_index = 0
	updateLabels()
	_merchantState = MERCHANT_STATES.ITEMS_SELECT
	
func updateLabels() -> void:
	$crownsMarginContainer/Panel/crownsMoneyLabel.text = str(Data.PARTY_CROWNS)
	if _viewableList.size() >= 1:
		$itemsMarginContainer/Panel/itemName1.text = _viewableList[0].name
		$itemsMarginContainer/Panel/itemPrice1.text = str(_viewableList[0].cost)
	else:
		$itemsMarginContainer/Panel/itemName1.text = ""
		$itemsMarginContainer/Panel/itemPrice1.text = ""
		
	if _viewableList.size() >= 2:
		$itemsMarginContainer/Panel/itemName2.text = _viewableList[1].name
		$itemsMarginContainer/Panel/itemPrice2.text = str(_viewableList[1].cost)
	else:
		$itemsMarginContainer/Panel/itemName2.text = ""
		$itemsMarginContainer/Panel/itemPrice2.text = ""
		
	if _viewableList.size() >= 3:
		$itemsMarginContainer/Panel/itemName3.text = _viewableList[2].name
		$itemsMarginContainer/Panel/itemPrice3.text = str(_viewableList[2].cost)
	else:
		$itemsMarginContainer/Panel/itemName3.text = ""
		$itemsMarginContainer/Panel/itemPrice3.text = ""
		
	if _viewableList.size() >= 4:
		$itemsMarginContainer/Panel/itemName4.text = _viewableList[3].name
		$itemsMarginContainer/Panel/itemPrice4.text = str(_viewableList[3].cost)
	else:
		$itemsMarginContainer/Panel/itemName4.text = ""
		$itemsMarginContainer/Panel/itemPrice4.text = ""
		
	if _viewableList.size() >= 5:
		$itemsMarginContainer/Panel/itemName5.text = _viewableList[4].name
		$itemsMarginContainer/Panel/itemPrice5.text = str(_viewableList[4].cost)
	else:
		$itemsMarginContainer/Panel/itemName5.text = ""
		$itemsMarginContainer/Panel/itemPrice5.text = ""
		
	if _viewableList.size() >= 6:
		$itemsMarginContainer/Panel/itemName6.text = _viewableList[5].name
		$itemsMarginContainer/Panel/itemPrice6.text = str(_viewableList[5].cost)
	else:
		$itemsMarginContainer/Panel/itemName6.text = ""
		$itemsMarginContainer/Panel/itemPrice6.text = ""
		
	if _viewableList.size() >= 7:
		$itemsMarginContainer/Panel/itemName7.text = _viewableList[6].name
		$itemsMarginContainer/Panel/itemPrice7.text = str(_viewableList[6].cost)
	else:
		$itemsMarginContainer/Panel/itemName7.text = ""
		$itemsMarginContainer/Panel/itemPrice7.text = ""
		
	if _viewableList.size() >= 8:
		$itemsMarginContainer/Panel/itemName8.text = _viewableList[7].name
		$itemsMarginContainer/Panel/itemPrice8.text = str(_viewableList[7].cost)
	else:
		$itemsMarginContainer/Panel/itemName8.text = ""
		$itemsMarginContainer/Panel/itemPrice8.text = ""
		
	if _viewableList.size() >= 9:
		$itemsMarginContainer/Panel/itemName9.text = _viewableList[8].name
		$itemsMarginContainer/Panel/itemPrice9.text = str(_viewableList[8].cost)
	else:
		$itemsMarginContainer/Panel/itemName9.text = ""
		$itemsMarginContainer/Panel/itemPrice9.text = ""
		
	if _viewableList.size() >= 10:
		$itemsMarginContainer/Panel/itemName10.text = _viewableList[9].name
		$itemsMarginContainer/Panel/itemPrice10.text = str(_viewableList[9].cost)
	else:
		$itemsMarginContainer/Panel/itemName10.text = ""
		$itemsMarginContainer/Panel/itemPrice10.text = ""
	
func setUnpressable(wait:float = 0.2) -> void:
	_isPressable = PRESSABLE.NO
	$Timer.start(wait)

func _on_timer_timeout():
	$Timer.stop()
	_isPressable = PRESSABLE.YES

