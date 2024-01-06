extends Node2D

var _state: Enums.PARTY_STATE = Enums.PARTY_STATE.IDLE

func _ready():
	Events.connect("INPUT_RESET", _on_input_reset)
	Events.connect("INPUT_RIGHT", _on_input_right)
	Events.connect("INPUT_UP", _on_input_up)
	Events.connect("INPUT_LEFT", _on_input_left)
	Events.connect("INPUT_DOWN", _on_input_down)
	Events.connect("PARTY_MOVED", _on_partyMoved)
	Events.connect("INPUT_ACCEPT", _on_inputAccept)
	Events.connect("PARTY_ADD_EXPERIENCE", _on_partyAddExperience)
	Events.connect("PARTY_ADD_GOLD", _on_partyAddCrowns)
	Events.connect("PARTY_SUB_CROWNS", _on_partySubCrowns)
	Events.connect("PARTY_ADD_ITEM", _on_partyAddItem)
	Events.connect("PARTY_ADD_HEALTH", _on_addHealth)
	Events.connect("PARTY_ADD_MAGIC", _on_addMagic)
	Events.connect("PARTY_REVIVE_CHARACTER", _on_partyReviveCharacter)
	Events.connect("SET_GLOBAL_STATE", _on_globalStateChange)
	Events.connect("ENEMY_IS_COLLIDING_WITH_AREA", _on_enemyCollidedWithArea)
	
	
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
	_state = Enums.PARTY_STATE.INTERACTING
	$partyMoveTimer.start(Statics.MOVE_SPEED_WAIT)
	
	#Events.emit_signal("ENEMY_IS_COLLIDING_WITH_AREA", self._id, self.global_position, self._name, self._type)
func _on_enemyCollidedWithArea(id:String, enemyPosition:Vector2, name:String, type:Enums.ENEMY_TYPES):
	fightCheck($rightCheck/partyCollisionShapeRight, id, enemyPosition, name, type)
	fightCheck($upCheck/partyCollisionShapeUp, id, enemyPosition, name, type)
	fightCheck($leftCheck/partyCollisionShapeLeft, id, enemyPosition, name, type)
	fightCheck($downCheck/partyCollisionShapeDown, id, enemyPosition, name, type)
	
func fightCheck(area:CollisionShape2D, id:String, enemyPosition:Vector2, name:String, type:Enums.ENEMY_TYPES) -> void:
	if int(area.global_position.x / 16) == int(enemyPosition.x / 16) && int(area.global_position.y / 16) == int(enemyPosition.y / 16):
		_state = Enums.PARTY_STATE.FIGHTING
		$partyFightTimer.start(Statics.FIGHT_WAIT)
		Events.emit_signal("PARTY_COMBAT_AT", id, enemyPosition, name, type)
	
func travelCheck(area:Area2D) -> bool:
	var bodies = area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemy") && _state == Enums.PARTY_STATE.IDLE:
			_state = Enums.PARTY_STATE.FIGHTING
			$partyFightTimer.start(Statics.FIGHT_WAIT)
			Events.emit_signal("PARTY_COMBAT_AT", body._id, body.global_position, body._name, body._type)
			body.setTurnEndedStatusHasFought()
		elif body.is_in_group("sign") && _state == Enums.PARTY_STATE.IDLE:
			Events.emit_signal("MESSAGE_BOX_QUEUE_MESSAGES", body.getTitle(), body.getMessages())
			Events.emit_signal("SET_GLOBAL_STATE", Enums.SYSTEM_GLOBAL_STATES.IN_MESSAGE_BOX)
		return true
	return false

func _on_input_reset() -> void:
	_state = Enums.PARTY_STATE.IDLE
	
func _on_inputAccept() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.ON_MAP:
		if _state == Enums.PARTY_STATE.IDLE:
			$partyMoveTimer.start(0.2)
			_state = Enums.PARTY_STATE.INTERACTING
			var interactWithGroup:String = checkForInteractionWithGroup()
			if interactWithGroup == "merchant":
				Events.emit_signal("SET_GLOBAL_STATE", Enums.SYSTEM_GLOBAL_STATES.IN_MERCHANT_SELECT)
			elif interactWithGroup == "sign":
				Events.emit_signal("SET_GLOBAL_STATE", Enums.SYSTEM_GLOBAL_STATES.IN_MESSAGE_BOX)
			elif interactWithGroup == "npc":
				Events.emit_signal("SET_GLOBAL_STATE", Enums.SYSTEM_GLOBAL_STATES.IN_MESSAGE_BOX)
			
func checkForInteractionWithGroup() -> String:
	var interactionAreas:Array = [ $rightCheck, $upCheck, $leftCheck, $downCheck ]
	for area in interactionAreas:
		var bodies = area.get_overlapping_areas()
		for body in bodies:
			if body.is_in_group("merchant"):
				return "merchant"
			elif body.is_in_group("sign"):
				Events.emit_signal("MESSAGE_BOX_QUEUE_MESSAGES", body.getTitle(), body.getMessages())
				return "sign"
			elif body.is_in_group("npc"):
				Events.emit_signal("MESSAGE_BOX_QUEUE_MESSAGES", body.get_parent().getTitle(), body.get_parent().getMessages())
				return "npc"
	return ""
			
func _on_input_right() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.ON_MAP:
		if _state == Enums.PARTY_STATE.IDLE:
			if !travelCheck($rightCheck):
				_state = Enums.PARTY_STATE.MOVED
				Data.PARTY_X += 16
				Events.emit_signal("PARTY_MOVED")
				Events.emit_signal("PARTY_MOVED_TO", Vector2(Data.PARTY_X, Data.PARTY_Y))
				Events.emit_signal("SYSTEM_WRITE_LOG", Text.MAP_TRAVEL_EAST, Enums.SYSTEM_LOG_TYPE.MAP, true)
		
func _on_input_up() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.ON_MAP:
		if _state == Enums.PARTY_STATE.IDLE:
			if !travelCheck($upCheck):
				_state = Enums.PARTY_STATE.MOVED
				Data.PARTY_Y -= 16
				Events.emit_signal("PARTY_MOVED")
				Events.emit_signal("PARTY_MOVED_TO", Vector2(Data.PARTY_X, Data.PARTY_Y))
				Events.emit_signal("SYSTEM_WRITE_LOG", Text.MAP_TRAVEL_NORTH, Enums.SYSTEM_LOG_TYPE.MAP, true)
	
func _on_input_left() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.ON_MAP:
		if _state == Enums.PARTY_STATE.IDLE:
			if !travelCheck($leftCheck):
				_state = Enums.PARTY_STATE.MOVED
				Data.PARTY_X -= 16
				Events.emit_signal("PARTY_MOVED")
				Events.emit_signal("PARTY_MOVED_TO", Vector2(Data.PARTY_X, Data.PARTY_Y))
				Events.emit_signal("SYSTEM_WRITE_LOG", Text.MAP_TRAVEL_WEST, Enums.SYSTEM_LOG_TYPE.MAP, true)
	
func _on_input_down() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.ON_MAP:
		if _state == Enums.PARTY_STATE.IDLE:
			if !travelCheck($downCheck):
				_state = Enums.PARTY_STATE.MOVED
				Data.PARTY_Y += 16
				Events.emit_signal("PARTY_MOVED")
				Events.emit_signal("PARTY_MOVED_TO", Vector2(Data.PARTY_X, Data.PARTY_Y))
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
	Events.emit_signal("TURN_ENDED")


func _on_partyAddCrowns(crowns:int) -> void:
	Data.PARTY_CROWNS += crowns
	
func _on_partySubCrowns(crowns:int) -> void:
	Data.PARTY_CROWNS -= crowns
	
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


func getAttributeGrowth(currentMax:int, attributeGrowth:Enums.CLASSES_ATTRIBUTE_GROWTH) -> int:
	if attributeGrowth == Enums.CLASSES_ATTRIBUTE_GROWTH.NONE:
		return currentMax
	elif attributeGrowth == Enums.CLASSES_ATTRIBUTE_GROWTH.FLAT:
		return currentMax + Globals.percentageOf(currentMax, 10)
	elif attributeGrowth == Enums.CLASSES_ATTRIBUTE_GROWTH.NORMAL:
		return currentMax + Globals.percentageOf(currentMax, 20)
	elif attributeGrowth == Enums.CLASSES_ATTRIBUTE_GROWTH.SHARP:
		return currentMax + Globals.percentageOf(currentMax, 30)
		
	return currentMax

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
			Data.CHARACTER_1_XP_NEXT = CharacterHandler.getLevelNext(CharacterHandler.getXPBase(Data.CHARACTER_1_LV), Data.CHARACTER_1_LV)
			Data.CHARACTER_1_HEALTH_MAX = getAttributeGrowth(Data.CHARACTER_1_HEALTH_MAX, Data.CHARACTER_1_HEALTH_GROWTH)
			Data.CHARACTER_1_MAGIC_MAX = getAttributeGrowth(Data.CHARACTER_1_MAGIC_MAX, Data.CHARACTER_1_MAGIC_GROWTH)
			var actions:Array = CharacterHandler.getActionsByLevelAndClass(Data.CHARACTER_1_TYPE, Data.CHARACTER_1_LV)
			if actions.size() > 0:
				Data.CHARACTER_1_ACTIONS.append_array(actions)
			
	if Data.CHARACTER_2_HEALTH_CURRENT > 0:
		currentXP = Data.CHARACTER_2_XP
		currentLV = Data.CHARACTER_2_LV
		Data.CHARACTER_2_XP += xp
		if Data.CHARACTER_2_XP >= Data.CHARACTER_2_XP_NEXT:
			Data.CHARACTER_2_LV += 1
			Events.emit_signal("SYSTEM_WRITE_LOG", str(Data.CHARACTER_2_NAME, " reached level ", Data.CHARACTER_2_LV, "."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			Data.CHARACTER_2_XP_NEXT = CharacterHandler.getLevelNext(CharacterHandler.getXPBase(Data.CHARACTER_2_LV), Data.CHARACTER_2_LV)
			Data.CHARACTER_2_HEALTH_MAX = getAttributeGrowth(Data.CHARACTER_2_HEALTH_MAX, Data.CHARACTER_2_HEALTH_GROWTH)
			Data.CHARACTER_2_MAGIC_MAX = getAttributeGrowth(Data.CHARACTER_2_MAGIC_MAX, Data.CHARACTER_2_MAGIC_GROWTH)
			var actions:Array = CharacterHandler.getActionsByLevelAndClass(Data.CHARACTER_2_TYPE, Data.CHARACTER_2_LV)
			if actions.size() > 0:
				Data.CHARACTER_2_ACTIONS.append_array(actions)
			
	if Data.CHARACTER_3_HEALTH_CURRENT > 0:
		currentXP = Data.CHARACTER_3_XP
		currentLV = Data.CHARACTER_3_LV
		Data.CHARACTER_3_XP += xp
		if Data.CHARACTER_3_XP >= Data.CHARACTER_3_XP_NEXT:
			Data.CHARACTER_3_LV += 1
			Events.emit_signal("SYSTEM_WRITE_LOG", str(Data.CHARACTER_3_NAME, " reached level ", Data.CHARACTER_3_LV, "."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			Data.CHARACTER_3_XP_NEXT = CharacterHandler.getLevelNext(CharacterHandler.getXPBase(Data.CHARACTER_3_LV), Data.CHARACTER_3_LV)
			Data.CHARACTER_3_HEALTH_MAX = getAttributeGrowth(Data.CHARACTER_3_HEALTH_MAX, Data.CHARACTER_3_HEALTH_GROWTH)
			Data.CHARACTER_3_MAGIC_MAX = getAttributeGrowth(Data.CHARACTER_3_MAGIC_MAX, Data.CHARACTER_3_MAGIC_GROWTH)
			var actions:Array = CharacterHandler.getActionsByLevelAndClass(Data.CHARACTER_3_TYPE, Data.CHARACTER_3_LV)
			if actions.size() > 0:
				Data.CHARACTER_3_ACTIONS.append_array(actions)
			
	if Data.CHARACTER_4_HEALTH_CURRENT > 0:
		currentXP = Data.CHARACTER_4_XP
		currentLV = Data.CHARACTER_4_LV
		Data.CHARACTER_4_XP += xp
		if Data.CHARACTER_4_XP >= Data.CHARACTER_4_XP_NEXT:
			Data.CHARACTER_4_LV += 1
			Events.emit_signal("SYSTEM_WRITE_LOG", str(Data.CHARACTER_4_NAME, " reached level ", Data.CHARACTER_4_LV, "."), Enums.SYSTEM_LOG_TYPE.BATTLE)
			Data.CHARACTER_4_XP_NEXT = CharacterHandler.getLevelNext(CharacterHandler.getXPBase(Data.CHARACTER_4_LV), Data.CHARACTER_4_LV)
			Data.CHARACTER_4_HEALTH_MAX = getAttributeGrowth(Data.CHARACTER_4_HEALTH_MAX, Data.CHARACTER_4_HEALTH_GROWTH)
			Data.CHARACTER_4_MAGIC_MAX = getAttributeGrowth(Data.CHARACTER_4_MAGIC_MAX, Data.CHARACTER_4_MAGIC_GROWTH)
			var actions:Array = CharacterHandler.getActionsByLevelAndClass(Data.CHARACTER_4_TYPE, Data.CHARACTER_4_LV)
			if actions.size() > 0:
				Data.CHARACTER_4_ACTIONS.append_array(actions)

func _on_party_move_timer_timeout() -> void:
	if _state == Enums.PARTY_STATE.MOVED:
		Events.emit_signal("INPUT_RESET")
	elif _state == Enums.PARTY_STATE.INTERACTING:
		Events.emit_signal("INPUT_RESET")
	$partyMoveTimer.stop()


func _on_party_fight_timer_timeout() -> void:
	Events.emit_signal("INPUT_RESET")
	$partyFightTimer.stop()
