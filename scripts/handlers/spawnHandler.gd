extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("PARTY_SPAWN_CHARACTER", _on_partySpawnCharacter)
	Events.connect("SPAWN_ENEMY_ACTOR", _on_spawnEnemy)
	Events.connect("SPAWN_DAMAGE_NUMBER", _on_spawnDamageNumber)
	Events.connect("SPAWN_FIREBALL", _on_spawnFireball)
	
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
	
func _on_spawnDamageNumber(position:Vector2, value:int, isHealing:bool, isCritical:bool) -> void:
	var dmg = SceneLoader.getScene(Enums.SCENE_TYPE.DAMAGE_NUMBERS)
	position.x += 8
	dmg.set_global_position(position)
	dmg.setProperties(position, value, isHealing, isCritical)
	self.add_child(dmg)
	
func _on_spawnFireball(position:Vector2) -> void:
	var  fb = SceneLoader.getScene(Enums.SCENE_TYPE.FIREBALL)
	fb.global_position = position
	self.add_child(fb)
