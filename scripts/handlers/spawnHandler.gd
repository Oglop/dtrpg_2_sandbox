extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("PARTY_SPAWN_CHARACTER", _on_partySpawnCharacter)
	Events.connect("SPAWN_ENEMY_ACTOR", _on_spawnEnemy)
	
func _on_partySpawnCharacter(position:int, type:Enums.CLASSES) -> void:
	var playerSpriteScene = SceneLoader.getScene(Enums.SCENE_TYPE.PLAYER_SPRITE)
	playerSpriteScene.setProperties(position)
	playerSpriteScene.set_global_position(Vector2(Data.PARTY_X,Data.PARTY_Y))
	self.add_child(playerSpriteScene)
	
func _on_spawnEnemy(id:String, position:Vector2, type:Enums.ENEMY_TYPES) -> void:
	var enemy = SceneLoader.getScene(Enums.SCENE_TYPE.ENEMY)
	enemy.set_global_position(Vector2(position.x,position.y))
	enemy.setProperties(id, type)
	self.add_child(enemy)
	