extends Node

@onready var party = preload("res://scenes/player/party.tscn")
@onready var playerSprite = preload("res://scenes/player/playerSprites.tscn")
@onready var enemy = preload("res://scenes/map/enemy.tscn")
@onready var messageSign = preload("res://scenes/map/messageSign.tscn")

func getScene(type:Enums.SCENE_TYPE):
	if type == Enums.SCENE_TYPE.PARTY:
		return party.instantiate()
	elif type == Enums.SCENE_TYPE.PLAYER_SPRITE:
		return playerSprite.instantiate()
	elif type == Enums.SCENE_TYPE.ENEMY:
		return enemy.instantiate()
	elif type == Enums.SCENE_TYPE.MESSAGE_SIGN:
		return messageSign.instantiate()

