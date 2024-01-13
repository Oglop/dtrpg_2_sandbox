extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("PARTY_SPAWN_CHARACTER", _on_partySpawnCharacter)
	Events.connect("SPAWN_ENEMY_ACTOR", _on_spawnEnemy)
	Events.connect("SPAWN_DAMAGE_NUMBER", _on_spawnDamageNumber)
	Events.connect("SPAWN_DAMAGE_FX_FIREBALL", _on_spawnFireball)
	Events.connect("SPAWN_DAMAGE_FX_CUT", _on_spawnFXCut)
	Events.connect("SPAWN_DAMAGE_FX_POISON", _on_spawnPoison)
	Events.connect("SPAWN_DAMAGE_FX_LAVAWAVE", _on_spawnLavawave)
	Events.connect("SPAWN_DAMAGE_FX_STUN", _on_spawnStun)
	Events.connect("SPAWN_DAMAGE_FX_CHAIN_LIGHTNING", _on_spawnChainLightning)
	Events.connect("SPAWN_DAMAGE_FX_PROTECT", _on_spawnProtect)
	Events.connect("SPAWN_DAMAGE_FX_SLEEP", _on_spawnSleep)
	Events.connect("SPAWN_DAMAGE_FX_MISS", _on_spawn_miss)
	Events.connect("SPAWN_DAMAGE_FX_EXPLOSION", _on_spawn_explosion)
	Events.connect("SPAWN_NPC", _on_spawnNPC)
	Events.connect("SPAWN_TREASURE", _on_spawnTreasure)
	Events.connect("SPAWN_DOOR", _on_spawnDoor)
	
	
	
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
	position.x += 8
	position.y += 4
	fb.global_position = position
	self.add_child(fb)
	
func _on_spawnFXCut(position:Vector2) -> void:
	var fx = SceneLoader.getScene(Enums.SCENE_TYPE.CUT)
	position.x += 8
	position.y += 4
	fx.set_global_position(position)
	self.add_child(fx)
	
func _on_spawnLavawave(position:Vector2) -> void:
	var fx = SceneLoader.getScene(Enums.SCENE_TYPE.LAVAWAVE)
	position.x += 8
	position.y += 4
	fx.set_global_position(position)
	self.add_child(fx)
	
func _on_spawnPoison(position:Vector2) -> void:
	var fx = SceneLoader.getScene(Enums.SCENE_TYPE.POISON)
	position.x += 8
	position.y += 4
	fx.set_global_position(position)
	self.add_child(fx)
	
func _on_spawnNPC(key:String) -> void:
	var npc = SceneLoader.getScene(Enums.SCENE_TYPE.NPC)
	npc.setProperties(key)
	self.add_child(npc)
	
func _on_spawnStun(position:Vector2i) -> void:
	var stun = SceneLoader.getScene(Enums.SCENE_TYPE.STUN)
	stun.global_position = position
	self.add_child(stun)
	
func _on_spawnTreasure(treasureKey:String) -> void:
	if Statics.TREASURES.has(treasureKey):
		var settings = Statics.TREASURES[treasureKey]
		var treasure = SceneLoader.getScene(Enums.SCENE_TYPE.TREASURE)
		treasure.global_position = Globals.snapToGrid(settings.x, settings.y)
		treasure.setProperties(settings.type, settings.key, settings.tier, settings.lockedBy)
		self.add_child(treasure)
		

func _on_spawnDoor(doorKey:String) -> void:
	if Statics.DOORS.has(doorKey):
		var settings = Statics.DOORS[doorKey]
		var door = SceneLoader.getScene(Enums.SCENE_TYPE.DOOR)
		door.global_position = Globals.snapToGrid(settings.x, settings.y)
		# doorKey:String, style:Enums.DOOR_STYLES, lockedBy:String
		door.setProperties(doorKey, settings.style, settings.lockedBy)
		self.add_child(door)
		
func _on_spawnChainLightning(position:Vector2i) -> void:
	var lightning = SceneLoader.getScene(Enums.SCENE_TYPE.CHAIN_LIGHTNING)
	position.x += 8
	position.y += 4
	lightning.global_position = position
	self.add_child(lightning)
	
func _on_spawnProtect(position:Vector2i) -> void:
	var protect = SceneLoader.getScene(Enums.SCENE_TYPE.PROTECT)
	position.y -= 4
	protect.global_position = position
	self.add_child(protect)
	
func _on_spawnSleep(position:Vector2i) -> void:
	var sleep = SceneLoader.getScene(Enums.SCENE_TYPE.SLEEP)
	sleep.global_position = position
	self.add_child(sleep)
	
func _on_spawn_miss(position:Vector2i) -> void:
	var miss = SceneLoader.getScene(Enums.SCENE_TYPE.MISS)
	miss.global_position = position
	self.add_child(miss)
	
func _on_spawn_explosion(position:Vector2i) -> void:
	var exp = SceneLoader.getScene(Enums.SCENE_TYPE.EXPLOSION)
	exp.global_position = position
	self.add_child(exp)
	
	
	
	
