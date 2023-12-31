extends Node

func _ready():
	Events.connect("INVENTORY_ADD", addItem)
	Events.connect("INVENTORY_DELETE", removeItem)
	Events.connect("INVENTORY_REMOVE", withdrawItem)
	Events.connect("INVENTORY_REBUILD", rebuildInventory)
	
func withdrawItem(name:String) -> Dictionary:
	var deleteItem:Dictionary = {}
	var _item:Dictionary = {
		"type": Enums.ITEM_TYPES.NONE,
		"name": "",
		"value": -1,
		"quantity":0	
		}
	
	for item in Data.PARTY_ITEMS:
		if item.name == name && item.quantity:
			_item = {
				"name": item.name,
				"type": item.type,
				"value": item.value,
				"quantity": item.quantity
			}
			item.quantity -= 1
			deleteItem = item
			break
				
	rebuildInventory()
	return _item
	
func removeItem(name:String) -> void:
	for item in Data.PARTY_ITEMS:
		if item.name == name && item.quantity:
			item.quantity -= 1
			break	
	rebuildInventory()
	
func equipWeaponCharacter(position:int, weapon:Dictionary) -> bool:
	if position == 0:
		if !Data.CHARACTER_1_WEAPON.is_empty():
			var equipedWeapon:Dictionary = Data.CHARACTER_1_WEAPON
			addItem(equipedWeapon)
		Data.CHARACTER_1_WEAPON = weapon
	elif position == 1:
		if !Data.CHARACTER_2_WEAPON.is_empty():
			var equipedWeapon:Dictionary = Data.CHARACTER_2_WEAPON
			addItem(equipedWeapon)
		Data.CHARACTER_2_WEAPON = weapon
	elif position == 2:
		if !Data.CHARACTER_3_WEAPON.is_empty():
			var equipedWeapon:Dictionary = Data.CHARACTER_3_WEAPON
			addItem(equipedWeapon)
		Data.CHARACTER_3_WEAPON = weapon	
	elif position == 3:
		if !Data.CHARACTER_4_WEAPON.is_empty():
			var equipedWeapon:Dictionary = Data.CHARACTER_4_WEAPON
			addItem(equipedWeapon)
		Data.CHARACTER_4_WEAPON = weapon
	return true
	
func equipArmorCharacter(position:int, armor:Dictionary) -> bool:
	if position == 0:
		if Data.CHARACTER_1_ARMOR != null:
			var equipedArmor:Dictionary = Data.CHARACTER_1_ARMOR
			addItem(equipedArmor)
		Data.CHARACTER_1_ARMOR = armor
	elif position == 1:
		if Data.CHARACTER_2_ARMOR != null:
			var equipedArmor:Dictionary = Data.CHARACTER_2_ARMOR
			addItem(equipedArmor)
		Data.CHARACTER_2_ARMOR = armor
	elif position == 2:
		if Data.CHARACTER_3_ARMOR != null:
			var equipedArmor:Dictionary = Data.CHARACTER_3_ARMOR
			addItem(equipedArmor)
		Data.CHARACTER_3_ARMOR = armor	
	elif position == 3:
		if Data.CHARACTER_4_ARMOR != null:
			var equipedArmor:Dictionary = Data.CHARACTER_4_ARMOR
			addItem(equipedArmor)
		Data.CHARACTER_4_ARMOR = armor
	return true
	
func equipAccessoryCharacter(position:int, accessory:Dictionary) -> bool:
	if position == 0:
		if Data.CHARACTER_1_ACCESSORY != null:
			var equipedAccessory:Dictionary = Data.CHARACTER_1_ACCESSORY
			addItem(equipedAccessory)
		Data.CHARACTER_1_ACCESSORY = accessory
	elif position == 1:
		if Data.CHARACTER_2_ACCESSORY != null:
			var equipedAccessory:Dictionary = Data.CHARACTER_2_ACCESSORY
			addItem(equipedAccessory)
		Data.CHARACTER_2_ACCESSORY = accessory
	elif position == 2:
		if Data.CHARACTER_3_ACCESSORY != null:
			var equipedAccessory:Dictionary = Data.CHARACTER_3_ACCESSORY
			addItem(equipedAccessory)
		Data.CHARACTER_3_ACCESSORY = accessory	
	elif position == 3:
		if Data.CHARACTER_4_ACCESSORY != null:
			var equipedAccessory:Dictionary = Data.CHARACTER_4_ACCESSORY
			addItem(equipedAccessory)
		Data.CHARACTER_4_ACCESSORY = accessory
	return true


func useConsumable(item:Dictionary, position:int) -> void:
	if item.name == Statics.ITEMS.POTION.name:
		if CharacterHandler.isCharacterAlive(position):
			Events.emit_signal("PARTY_ADD_HEALTH", position, item.value)
	if item.name == Statics.ITEMS.ELIXIR.name:
		if !CharacterHandler.isCharacterAlive(position):
			Events.emit_signal("PARTY_REVIVE_CHARACTER", position, item.value)
	if item.name == Statics.ITEMS.HERB.name:
		if CharacterHandler.isCharacterAlive(position):
			Events.emit_signal("PARTY_ADD_MAGIC", position, item.value)
			
			
	
	
func rebuildInventory() -> void:
	var items:Array = []
	for item in Data.PARTY_ITEMS:
		if item.quantity > 0:
			items.push_back(item)
	Data.PARTY_ITEMS = items

func itemExists(name:String) -> bool:
	for item in Data.PARTY_ITEMS:
		if item.name == name && item.quantity > 0:
			return true
	return false
	
func addItem(item:Dictionary) -> void:
	if item.quantity == 0:
		item.quantity = 1
	var itemInserted:bool = false
	for x in Data.PARTY_ITEMS:
		if x.name == item.name:
			x.quantity += 1
			itemInserted = true
			break
	if !itemInserted:
		Data.PARTY_ITEMS.append(item)
