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
	Events.connect("PARTY_ADD_GOLD", _on_partyAddCrowns)
	Events.connect("PARTY_ADD_ITEM", _on_partyAddItem)
	Events.connect("PARTY_ADD_HEALTH", _on_addHealth)
	Events.connect("PARTY_ADD_MAGIC", _on_addMagic)
	Events.connect("PARTY_REVIVE_CHARACTER", _on_partyReviveCharacter)
	Events.connect("SET_GLOBAL_STATE", _on_globalStateChange)
	
	
	self.global_position = Vector2(Data.PARTY_X, Data.PARTY_Y)
	
func _on_partyReviveCharacter(position:int, value:int) -> void:
	if position == 0:
		Data.CHARACTER_1_HEALTH_CURRENT = 0 + value
	if position == 1:
		Data.CHARACTER_2_HEALTH_CURRENT = 0 + value
	if position == 2:
		Data.CHARACTER_3_HEALTH_CURRENT = 0 + value
	if position == 3:
		Data.CHARACTER_4_HEALTH_CURRENT = 0 + value
	
func _on_globalStateChange(globalState:Enums.SYSTEM_GLOBAL_STATES) -> void:
	pass
	
func travelCheck(area:Area2D) -> bool:
	var bodies = area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemy") && _state == Enums.PARTY_STATE.IDLE:
			_state = Enums.PARTY_STATE.FIGHTING
			$partyFightTimer.start(Statics.FIGHT_WAIT)
			Events.emit_signal("PARTY_COMBAT_AT", body._id, body.global_position, body._name, body._type)
		elif body.is_in_group("sign") && _state == Enums.PARTY_STATE.IDLE:
			Events.emit_signal("MESSAGE_BOX_QUEUE_MESSAGES", body.getTitle(), body.getMessages())
			Events.emit_signal("SET_GLOBAL_STATE", Enums.SYSTEM_GLOBAL_STATES.IN_MESSAGE_BOX)
		return true
	return false

func _on_input_reset() -> void:
	_state = Enums.PARTY_STATE.IDLE

func _on_input_right() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.ON_MAP:
		if _state == Enums.PARTY_STATE.IDLE:
			if !travelCheck($rightCheck):
				_state = Enums.PARTY_STATE.MOVED
				Data.PARTY_X += 16
				Events.emit_signal("PARTY_MOVED")
				Events.emit_signal("SYSTEM_WRITE_LOG", Text.MAP_TRAVEL_EAST, Enums.SYSTEM_LOG_TYPE.MAP, true)
		
func _on_input_up() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.ON_MAP:
		if _state == Enums.PARTY_STATE.IDLE:
			if !travelCheck($upCheck):
				_state = Enums.PARTY_STATE.MOVED
				Data.PARTY_Y -= 16
				Events.emit_signal("PARTY_MOVED")
				Events.emit_signal("SYSTEM_WRITE_LOG", Text.MAP_TRAVEL_NORTH, Enums.SYSTEM_LOG_TYPE.MAP, true)
	
func _on_input_left() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.ON_MAP:
		if _state == Enums.PARTY_STATE.IDLE:
			if !travelCheck($leftCheck):
				_state = Enums.PARTY_STATE.MOVED
				Data.PARTY_X -= 16
				Events.emit_signal("PARTY_MOVED")
				Events.emit_signal("SYSTEM_WRITE_LOG", Text.MAP_TRAVEL_WEST, Enums.SYSTEM_LOG_TYPE.MAP, true)
	
func _on_input_down() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.ON_MAP:
		if _state == Enums.PARTY_STATE.IDLE:
			if !travelCheck($downCheck):
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
	self.global_position = Vector2(Data.PARTY_X, Data.PARTY_Y)
	Events.emit_signal("UPDATE_SPRITE_POSITIONS")
	$partyMoveTimer.start(Statics.MOVE_SPEED_WAIT)


func _on_partyAddCrowns(crowns:int) -> void:
	Data.PARTY_CROWNS += crowns
	
	
func _on_partyAddItem(item:Dictionary) -> void:
	var itemInserted:bool = false
	for x in Data.PARTY_ITEMS:
		if x.name == item.name:
			x.quantity += 1
			itemInserted = true
	if !itemInserted:
		Data.PARTY_ITEMS.append(item)
		
func _on_addHealth(position:int, value:int) -> void:
	if position == 0:
		Data.CHARACTER_1_HEALTH_CURRENT += value
		if Data.CHARACTER_1_HEALTH_CURRENT > Data.CHARACTER_1_HEALTH_MAX:
			Data.CHARACTER_1_HEALTH_CURRENT = Data.CHARACTER_1_HEALTH_MAX
	elif position == 1:
		Data.CHARACTER_2_HEALTH_CURRENT += value
		if Data.CHARACTER_2_HEALTH_CURRENT > Data.CHARACTER_2_HEALTH_MAX:
			Data.CHARACTER_2_HEALTH_CURRENT = Data.CHARACTER_2_HEALTH_MAX
	elif position == 2:
		Data.CHARACTER_3_HEALTH_CURRENT += value
		if Data.CHARACTER_3_HEALTH_CURRENT > Data.CHARACTER_3_HEALTH_MAX:
			Data.CHARACTER_3_HEALTH_CURRENT = Data.CHARACTER_3_HEALTH_MAX
	elif position == 3:
		Data.CHARACTER_4_HEALTH_CURRENT += value
		if Data.CHARACTER_4_HEALTH_CURRENT > Data.CHARACTER_4_HEALTH_MAX:
			Data.CHARACTER_4_HEALTH_CURRENT = Data.CHARACTER_4_HEALTH_MAX
			
func _on_addMagic(position:int, value:int) -> void:
	if position == 0:
			Data.CHARACTER_1_MAGIC_CURRENT += value
			if Data.CHARACTER_1_MAGIC_CURRENT > Data.CHARACTER_1_MAGIC_MAX:
				Data.CHARACTER_1_MAGIC_CURRENT = Data.CHARACTER_1_MAGIC_MAX
	elif position == 1:
		Data.CHARACTER_2_MAGIC_CURRENT += value
		if Data.CHARACTER_2_MAGIC_CURRENT > Data.CHARACTER_2_MAGIC_MAX:
			Data.CHARACTER_2_MAGIC_CURRENT = Data.CHARACTER_2_MAGIC_MAX
	elif position == 2:
		Data.CHARACTER_3_MAGIC_CURRENT += value
		if Data.CHARACTER_3_MAGIC_CURRENT > Data.CHARACTER_3_MAGIC_MAX:
			Data.CHARACTER_3_MAGIC_CURRENT = Data.CHARACTER_3_MAGIC_MAX
	elif position == 3:
		Data.CHARACTER_4_MAGIC_CURRENT += value
		if Data.CHARACTER_4_MAGIC_CURRENT > Data.CHARACTER_4_MAGIC_MAX:
			Data.CHARACTER_4_MAGIC_CURRENT = Data.CHARACTER_4_MAGIC_MAX

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
			Events.emit_signal("SYSTEM_WRITE_LOG", str(Data.CHARACTER_1_NAME, " reached level ", Data.CHARACTER_1_LV, "."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			Data.CHARACTER_1_XP_NEXT = getLevelNext(getXPBase(Data.CHARACTER_1_LV), Data.CHARACTER_1_LV)
			
		Data.CHARACTER_2_XP += xp
		if Data.CHARACTER_2_XP >= Data.CHARACTER_2_XP_NEXT:
			Data.CHARACTER_2_LV += 1
			Events.emit_signal("SYSTEM_WRITE_LOG", str(Data.CHARACTER_2_NAME, " reached level ", Data.CHARACTER_2_LV, "."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			Data.CHARACTER_2_XP_NEXT = getLevelNext(getXPBase(Data.CHARACTER_2_LV), Data.CHARACTER_2_LV)
			
		Data.CHARACTER_3_XP += xp
		if Data.CHARACTER_3_XP >= Data.CHARACTER_3_XP_NEXT:
			Data.CHARACTER_3_LV += 1
			Events.emit_signal("SYSTEM_WRITE_LOG", str(Data.CHARACTER_3_NAME, " reached level ", Data.CHARACTER_3_LV, "."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			Data.CHARACTER_3_XP_NEXT = getLevelNext(getXPBase(Data.CHARACTER_3_LV), Data.CHARACTER_3_LV)
			
		Data.CHARACTER_4_XP += xp
		if Data.CHARACTER_4_XP >= Data.CHARACTER_4_XP_NEXT:
			Data.CHARACTER_4_LV += 1
			Events.emit_signal("SYSTEM_WRITE_LOG", str(Data.CHARACTER_4_NAME, " reached level ", Data.CHARACTER_4_LV, "."), Enums.SYSTEM_LOG_TYPE.BATTLE)
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
	if _state == Enums.PARTY_STATE.MOVED:
		Events.emit_signal("INPUT_RESET")
	$partyMoveTimer.stop()


func _on_party_fight_timer_timeout():
	Events.emit_signal("INPUT_RESET")
	$partyFightTimer.stop()
