extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("SET_GLOBAL_STATE", _on_globalStateChange)
	Events.connect("SPAWN_NPCS_TO_MAP", _on_spawnNPCsToMap)
	Events.connect("SPAWN_TREASURE_TO_MAP", _on_spawnTreasureToMap)
	_on_spawnNPCsToMap()
	_on_spawnTreasureToMap()

func _on_globalStateChange(globalState:Enums.SYSTEM_GLOBAL_STATES) -> void:
	pass

func _on_spawnNPCsToMap() -> void:
	if Data.PARTY_CURRENT_ROOM == Enums.MAPS.DEV_MAP:
		Events.emit_signal("SPAWN_NPC", "DEV_WORLD_WOMAN_1")
		
func _on_spawnTreasureToMap() -> void:
	if Data.PARTY_CURRENT_ROOM == Enums.MAPS.DEV_MAP:
		Events.emit_signal("SPAWN_TREASURE", "DEV_WORLD_LONGSWORD_01")
		Events.emit_signal("SPAWN_TREASURE", "DEV_WORLD_CHEST_01")
		Events.emit_signal("SPAWN_TREASURE", "DEV_WORLD_CHEST_02")
		

