extends Node

@onready var party = preload("res://scenes/player/party.tscn")
@onready var playerSprite = preload("res://scenes/player/playerSprites.tscn")

func getScene(type:Enums.SCENE_TYPE):
	if type == Enums.SCENE_TYPE.PARTY:
		return party.instantiate()
	elif type == Enums.SCENE_TYPE.PLAYER_SPRITE:
		return playerSprite.instantiate()

