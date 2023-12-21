extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("HIDE_COMPARE_EQUIPABLES", _on_hideCompareEquipables)
	Events.connect("COMPARE_EQUIPABLES", _on_compareEquipables)

func _on_hideCompareEquipables() -> void:
	self.visible = false
	
func _on_compareEquipables(equipedItem:Dictionary, unequipedItem:Dictionary, canEquip:bool) -> void:
	self.visible = true
	if !canEquip:
		$MarginContainer/Panel/LabelUnequiped.text = "-"
	if canEquip:
		var equipedValue:int = 0 
		var comparer:String = "="
		var value:int = 0
		if equipedItem != null && equipedItem.size() > 0:
			equipedValue = equipedItem.value
			value = unequipedItem.value - equipedValue
			if value > 0:
				comparer = "+"
			elif value < 0:
				comparer = "-"
		$MarginContainer/Panel/LabelCompare.text = str(comparer, value)
