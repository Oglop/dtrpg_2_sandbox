extends Node2D

var _state: Enums.PARTY_STATE = Enums.PARTY_STATE.IDLE

func _ready():
	Events.connect("INPUT_RESET", _on_input_reset)
	Events.connect("INPUT_RIGHT", _on_input_right)
	Events.connect("INPUT_UP", _on_input_up)
	Events.connect("INPUT_LEFT", _on_input_left)
	Events.connect("INPUT_DOWN", _on_input_down)
	Events.connect("PARTY_MOVED", _on_partyMoved)
	Events.connect("PARTY_ADD_EXPERIENCE", _on_partyAddExperience)
	$partyStaticBody.position = Vector2(Data.PARTY_X, Data.PARTY_Y)
	

func _on_input_reset() -> void:
	_state = Enums.PARTY_STATE.IDLE

func _on_input_right() -> void:
	if _state == Enums.PARTY_STATE.IDLE:
		_state = Enums.PARTY_STATE.MOVED
		Data.PARTY_X += 16
		Events.emit_signal("PARTY_MOVED")
		Events.emit_signal("SYSTEM_WRITE_LOG", Text.MAP_TRAVEL_EAST, Enums.SYSTEM_LOG_TYPE.MAP, true)
		
func _on_input_up() -> void:
	if _state == Enums.PARTY_STATE.IDLE:
		_state = Enums.PARTY_STATE.MOVED
		Data.PARTY_Y -= 16
		Events.emit_signal("PARTY_MOVED")
		Events.emit_signal("SYSTEM_WRITE_LOG", Text.MAP_TRAVEL_NORTH, Enums.SYSTEM_LOG_TYPE.MAP, true)
	
func _on_input_left() -> void:
	if _state == Enums.PARTY_STATE.IDLE:
		_state = Enums.PARTY_STATE.MOVED
		Data.PARTY_X -= 16
		Events.emit_signal("PARTY_MOVED")
		Events.emit_signal("SYSTEM_WRITE_LOG", Text.MAP_TRAVEL_WEST, Enums.SYSTEM_LOG_TYPE.MAP, true)
	
func _on_input_down() -> void:
	if _state == Enums.PARTY_STATE.IDLE:
		_state = Enums.PARTY_STATE.MOVED
		Data.PARTY_Y += 16
		Events.emit_signal("PARTY_MOVED")
		Events.emit_signal("SYSTEM_WRITE_LOG", Text.MAP_TRAVEL_SOUTH, Enums.SYSTEM_LOG_TYPE.MAP, true)
		
func _on_partyMoved() -> void:
	for n in range(Globals.PARTY_SIZE, 0, -1):
		Globals.X_POSITIONS[n] = Globals.X_POSITIONS[n - 1]
		Globals.Y_POSITIONS[n] = Globals.Y_POSITIONS[n - 1]
	Globals.X_POSITIONS[0] = Data.PARTY_X
	Globals.Y_POSITIONS[0] = Data.PARTY_Y
	$partyStaticBody.position = Vector2(Data.PARTY_X, Data.PARTY_Y)
	Events.emit_signal("UPDATE_SPRITE_POSITIONS")
	$partyMoveTimer.start(Statics.MOVE_SPEED_WAIT)

func _on_partyAddExperience(xp:int) -> void:
	var currentXP:int = 0
	var currentLV:int = 0
	var xpBase:float = 1.0
	
	if Data.CHARACTER_1_HEALTH_CURRENT > 0:
		currentXP = Data.CHARACTER_1_XP
		currentLV = Data.CHARACTER_1_LV
		
		Data.CHARACTER_1_XP += xp
		if Data.CHARACTER_1_XP >= Data.CHARACTER_1_XP_NEXT:
			Data.CHARACTER_1_LV += 1
			Data.CHARACTER_1_XP_NEXT = getLevelNext(getXPBase(Data.CHARACTER_1_LV), Data.CHARACTER_1_LV)
			
		Data.CHARACTER_2_XP += xp
		if Data.CHARACTER_2_XP >= Data.CHARACTER_2_XP_NEXT:
			Data.CHARACTER_2_LV += 1
			Data.CHARACTER_2_XP_NEXT = getLevelNext(getXPBase(Data.CHARACTER_2_LV), Data.CHARACTER_2_LV)
			
		Data.CHARACTER_3_XP += xp
		if Data.CHARACTER_3_XP >= Data.CHARACTER_3_XP_NEXT:
			Data.CHARACTER_3_LV += 1
			Data.CHARACTER_3_XP_NEXT = getLevelNext(getXPBase(Data.CHARACTER_3_LV), Data.CHARACTER_3_LV)
			
		Data.CHARACTER_4_XP += xp
		if Data.CHARACTER_4_XP >= Data.CHARACTER_4_XP_NEXT:
			Data.CHARACTER_4_LV += 1
			Data.CHARACTER_4_XP_NEXT = getLevelNext(getXPBase(Data.CHARACTER_4_LV), Data.CHARACTER_4_LV)

# returns next level
func getLevelNext(xpBase:int, level:int) -> int:
	return floor(level * 40 * xpBase) 
	
# return xp base
func getXPBase(currentLV:int) -> int:
	if currentLV >= 1 && currentLV <= 6:
		return Statics.LEVEL_1_6_XP_BASE
	elif currentLV >= 7 && currentLV <= 12:
		return Statics.LEVEL_7_12_XP_BASE
	elif currentLV >= 13 && currentLV <= 18:
		return Statics.LEVEL_13_18_XP_BASE
	elif currentLV >= 19 && currentLV <= 26:
		return Statics.LEVEL_19_26_XP_BASE
	else:
		return Statics.LEVEL_27_99_XP_BASE
	
	
func _on_party_move_timer_timeout() -> void:
	Events.emit_signal("INPUT_RESET")
	$partyMoveTimer.stop()
