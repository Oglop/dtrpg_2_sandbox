extends AnimatedSprite2D

var _type:Enums.TREASURE_TYPES
var _key:String
var _tier:int = 0
var _state:Enums.TREASURE_STATE
var _lockedBy:String

func _ready():
	pass
	
func openTreasure() -> void:
	if _state == Enums.TREASURE_STATE.CLOSED:
		if tryUnlockTreasure():
			_state = Enums.TREASURE_STATE.OPENED
			if _key != "":
				Data.MAP_OPENED_TREASURES.append(_key)
			var treasure =  getTreasure()
			if treasure.size() > 0:
				Events.emit_signal("PARTY_ADD_ITEM", treasure)
				setAnimation()
		else:
			Events.emit_signal("SYSTEM_WRITE_LOG", "The chest is locked.", Enums.SYSTEM_LOG_TYPE.MAP)
		

func getTreasure() -> Dictionary:
	var possibleItems:Array = []
	if _key != "":
		var item = Statics.ITEMS[_key]
		Events.emit_signal("SYSTEM_WRITE_LOG", str("The chest contained ", Globals.getAOrAn(item.name), " ", item.name, "."), Enums.SYSTEM_LOG_TYPE.MAP)
		return item
	if _tier >= 0:
		possibleItems.append_array([ Statics.ITEMS["POTION"], Statics.ITEMS["ANTIDOTE"] ])
	if _tier >= 1:
		possibleItems.append_array(InventoryHandler.getTier1Equipment())
		possibleItems.append(Statics.ITEMS["HERB"])
	if _tier >= 2:
		possibleItems.append_array(InventoryHandler.getTier2Equipment())
		possibleItems.append(Statics.ITEMS["ELIXIR"])
	
	possibleItems.shuffle()
	Events.emit_signal("SYSTEM_WRITE_LOG", str("The chest contained ", Globals.getAOrAn(possibleItems[0].name), " ", possibleItems[0].name, "."), Enums.SYSTEM_LOG_TYPE.MAP)
	return possibleItems[0]
		
	return {}

func tryUnlockTreasure() -> bool:
	if _lockedBy == "":
		return true
	if !InventoryHandler.itemExists(_lockedBy):
		return false
		
	var key:Dictionary = InventoryHandler.withdrawItem(_lockedBy)
	Events.emit_signal("SYSTEM_WRITE_LOG", str("Unlocked the chest using ", Globals.getAOrAn(key.name), " ", key.name, "."), Enums.SYSTEM_LOG_TYPE.MAP)
	return true


func setProperties(type:Enums.TREASURE_TYPES, key:String, tier:int, lockedBy:String) -> void:
	_type = type
	_key = key
	_tier = tier
	_lockedBy = lockedBy
	setState()
	setAnimation()
	
func setState() -> void:
	if Data.MAP_OPENED_TREASURES.has(_key):
		_state = Enums.TREASURE_STATE.OPENED
	else:
		_state =  Enums.TREASURE_STATE.CLOSED
	
func setAnimation() -> void:
	if _type == Enums.TREASURE_TYPES.MINOR:
		if _state == Enums.TREASURE_STATE.OPENED:
			self.play("minor_open")
		else:
			self.play("minor_closed")
	elif _type == Enums.TREASURE_TYPES.RANDOM_CHEST:
		if _state == Enums.TREASURE_STATE.OPENED:
			self.play("random_open")
		else:
			self.play("random_closed")
	elif _type == Enums.TREASURE_TYPES.FIXED_CHEST:
		if _state == Enums.TREASURE_STATE.OPENED:
			self.play("fixed_open")
		else:
			self.play("fixed_closed")
	elif _type == Enums.TREASURE_TYPES.LOCKED_CHEST:
		if _state == Enums.TREASURE_STATE.OPENED:
			self.play("locked_open")
		else:
			self.play("locked_closed")
