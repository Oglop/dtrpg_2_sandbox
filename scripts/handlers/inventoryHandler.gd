extends Node

func _ready():
	Events.connect("INVENTORY_ADD", addItem)
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
	var itemInserted:bool = false
	for x in Data.PARTY_ITEMS:
		if x.name == item.name:
			x.quantity += 1
			itemInserted = true
			break
	if !itemInserted:
		Data.PARTY_ITEMS.append(item)
