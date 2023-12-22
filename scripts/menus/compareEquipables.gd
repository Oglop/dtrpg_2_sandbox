extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("HIDE_COMPARE_EQUIPABLES", _on_hideCompareEquipables)
	Events.connect("COMPARE_EQUIPABLES", _on_compareEquipables)

func _on_hideCompareEquipables() -> void:
	self.visible = false
	
func _on_compareEquipables(equipedItem:Dictionary, unequipedItem:Dictionary, canEquip:bool) -> void:
	self.visible = true
	var comparer:String = "="
	var value:int = 0
	var equipedValue:int = 0 
	var equipedName:String = ""
	
	if canEquip:
		$MarginContainer/Panel/LabelUnequiped.text = unequipedItem.name
	else:
		$MarginContainer/Panel/LabelUnequiped.text = "-"
	
	if equipedItem != null && equipedItem.size() > 0:
		equipedValue = equipedItem.value
		value = unequipedItem.value - equipedValue
		equipedName = equipedItem.name
		if value > 0:
			comparer = "+"
		elif value < 0:
			comparer = "-"
	else: 
		equipedName = "-"
		value = unequipedItem.value
			
	if canEquip:
		$MarginContainer/Panel/LabelEquiped.text = equipedName
		$MarginContainer/Panel/LabelCompare.text = str(comparer, value)
	else:
		$MarginContainer/Panel/LabelEquiped.text = equipedName
		$MarginContainer/Panel/LabelCompare.text = "-"
		
		
		
		
