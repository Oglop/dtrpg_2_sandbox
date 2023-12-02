extends Node2D


func _ready():
	addParty()
	

func addParty() -> void:
	if Data.CHARACTER_1_TYPE != Enums.CLASSES.NONE:
		Events.emit_signal("PARTY_SPAWN_CHARACTER", 0, Data.CHARACTER_1_TYPE)
	if Data.CHARACTER_2_TYPE != Enums.CLASSES.NONE:
		Events.emit_signal("PARTY_SPAWN_CHARACTER", 1, Data.CHARACTER_2_TYPE)
	if Data.CHARACTER_3_TYPE != Enums.CLASSES.NONE:
		Events.emit_signal("PARTY_SPAWN_CHARACTER", 2, Data.CHARACTER_3_TYPE)
	if Data.CHARACTER_4_TYPE != Enums.CLASSES.NONE:
		Events.emit_signal("PARTY_SPAWN_CHARACTER", 3, Data.CHARACTER_4_TYPE)
		
