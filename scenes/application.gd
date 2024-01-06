extends Node2D

var gameMode: Enums.STARTUP_MODE = Enums.STARTUP_MODE.DEVELOPMENT
# Called when the node enters the scene tree for the first time.
func _ready():
	if gameMode == Enums.STARTUP_MODE.MAP_EDITOR:
		get_tree().change_scene_to_file("res://map_editor/map.tscn")
	elif gameMode == Enums.STARTUP_MODE.DEVELOPMENT:
		setDevelopmentData()
		Data.PARTY_CURRENT_ROOM = Enums.MAPS.DEV_MAP
		Events.emit_signal("PARTY_SET_POSITION", Enums.MAPS.DEV_MAP, Enums.ENTER_FROM.START_SCREEN)
		get_tree().change_scene_to_file("res://scenes/worlds/devWorld.tscn")
		
	elif gameMode == Enums.STARTUP_MODE.GAME:
		get_tree().change_scene_to_file(str(Text.SCENE_WORLDS_PATH, Text.SCENE_DEV_WORLD))
		
		
func setDevelopmentData() -> void:
	
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.POTION)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.HERB)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.POTION)
	Events.emit_signal("INVENTORY_ADD", Statics.ITEMS.POTION)
	CharacterHandler.setNewCharacterOfType(Enums.CLASSES.WARRIOR, 0)
	CharacterHandler.setNewCharacterOfType(Enums.CLASSES.KNIGHT, 1)
	CharacterHandler.setNewCharacterOfType(Enums.CLASSES.HUNTER, 2)
	CharacterHandler.setNewCharacterOfType(Enums.CLASSES.WIZARD, 3)
	
