extends Node

@onready var party = preload("res://scenes/player/party.tscn")
@onready var playerSprite = preload("res://scenes/player/playerSprites.tscn")
@onready var enemy = preload("res://scenes/map/enemy.tscn")
@onready var messageSign = preload("res://scenes/map/messageSign.tscn")
@onready var damageNumbers = preload("res://scenes/effects/damageNumbers.tscn")
@onready var fireball = preload("res://scenes/effects/fireball.tscn")
@onready var cut = preload("res://scenes/effects/cut.tscn")
@onready var lavawave = preload("res://scenes/effects/lavawave.tscn")
@onready var poison = preload("res://scenes/effects/poison.tscn")

func getScene(type:Enums.SCENE_TYPE):
	if type == Enums.SCENE_TYPE.PARTY:
		return party.instantiate()
	elif type == Enums.SCENE_TYPE.PLAYER_SPRITE:
		return playerSprite.instantiate()
	elif type == Enums.SCENE_TYPE.ENEMY:
		return enemy.instantiate()
	elif type == Enums.SCENE_TYPE.MESSAGE_SIGN:
		return messageSign.instantiate()
	elif type == Enums.SCENE_TYPE.DAMAGE_NUMBERS:
		return damageNumbers.instantiate()
	elif type == Enums.SCENE_TYPE.FIREBALL:
		return fireball.instantiate()
	elif type == Enums.SCENE_TYPE.CUT:
		return cut.instantiate()
	elif type == Enums.SCENE_TYPE.LAVAWAVE:
		return lavawave.instantiate()
	elif type == Enums.SCENE_TYPE.POISON:
		return poison.instantiate()

