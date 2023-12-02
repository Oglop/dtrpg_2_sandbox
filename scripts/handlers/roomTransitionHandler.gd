extends Node

func _ready():
	Events.connect("PARTY_SET_POSITION", _on_setPartyPosition)

func _on_setPartyPosition(map:Enums.MAPS, enterFrom:Enums.ENTER_FROM) -> void:
	print("_on_setPartyPosition(map:Enums.MAPS, enterFrom:Enums.ENTER_FROM) -> void:")
	
	Data.PARTY_CURRENT_ROOM = map
	if map == Enums.MAPS.DEV_MAP && enterFrom == Enums.ENTER_FROM.START_SCREEN:
		Data.PARTY_X = Statics.ROOM_STARTING_POSITIONS.devMap.x
		Data.PARTY_Y = Statics.ROOM_STARTING_POSITIONS.devMap.y
	
	for n in range(Globals.PARTY_SIZE,-1,-1):
		Globals.X_POSITIONS[n] = Data.PARTY_X
		Globals.Y_POSITIONS[n] = Data.PARTY_Y
		# Globals.TAIL_DIRECTION[n] = $PlayerSprite.flip_h
		# Globals.TAIL_ANIMATION[n] = Global.playerState
