extends Node2D
##
## ENEMY
##


var _id:String = ""
var _name:String = ""
var _description:String = ""
var _type:Enums.ENEMY_TYPES = Enums.ENEMY_TYPES.NONE
var _state:Enums.ENEMY_STATES = Enums.ENEMY_STATES.INACTIVE

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("DELETE_ENEMY_ACTOR", _on_enemy_defeated)
	Events.connect("PARTY_MOVED_TO", _on_partyMovedTo)
	
#var distance = abs($KinematicBody.global_position - $SoftBody.global_position)

func _on_enemy_defeated(id:String) -> void:
	if _id == id:
		self.queue_free()

func _on_partyMovedTo(partyGlobalPosition:Vector2) -> void:
	
	var distance:int = self.global_position.distance_to(partyGlobalPosition)
	#var distance = abs(partyGlobalPosition.direction_to() - self.global_position)
	if distance > Statics.ROOM_SIZE * 20:
		_state = Enums.ENEMY_STATES.INACTIVE
	if distance < Statics.ROOM_SIZE * 8:
		if _state == Enums.ENEMY_STATES.INACTIVE:
			_state = Enums.ENEMY_STATES.CHASING
	if _state == Enums.ENEMY_STATES.CHASING && distance <= Statics.ROOM_SIZE:
		_state = Enums.ENEMY_STATES.IN_FIGHT
	
	if _state == Enums.ENEMY_STATES.IN_FIGHT && distance >= Statics.ROOM_SIZE * 3:
		_state = Enums.ENEMY_STATES.CHASING
			
	if _state == Enums.ENEMY_STATES.CHASING:
		tryMove(partyGlobalPosition)
		

func tryMove(partyGlobalPosition:Vector2) -> void:
	if partyGlobalPosition.x == self.global_position.x && partyGlobalPosition.y == self.global_position.y:
		_state = Enums.ENEMY_STATES.IN_FIGHT
	else:
		var direction = getDirectionToParty(partyGlobalPosition)
		rotateRaycaster(direction)
		var isColliding = isRaycasterColliding()
		if isColliding == false:
			moveFromDirection(direction)
		else:
			var available = getAvailableDirections()
			if available.size() > 0:
				moveFromDirection(available[0])
				
func moveFromDirection(direction:Vector2) -> void:
	if direction.x == 1 && direction.y == 0:
		self.global_position = Vector2(self.global_position.x + Statics.ROOM_SIZE, self.global_position.y)
	elif direction.x == 0 && direction.y == -1:
		self.global_position = Vector2(self.global_position.x, self.global_position.y - Statics.ROOM_SIZE)
	elif direction.x == -1 && direction.y == 0:
		self.global_position = Vector2(self.global_position.x - Statics.ROOM_SIZE, self.global_position.y)
	elif direction.x == 0 && direction.y == 1:
		self.global_position = Vector2(self.global_position.x, self.global_position.y + Statics.ROOM_SIZE)
			
func rotateRaycaster(direction:Vector2) -> void:
	if direction.x == 1 && direction.y == 0:
		$RayCast2D.rotation = deg_to_rad(270)
	elif direction.x == 0 && direction.y == -1:
		$RayCast2D.rotation = deg_to_rad(180)
	elif direction.x == -1 && direction.y == 0:
		$RayCast2D.rotation = deg_to_rad(90)
	elif direction.x == 0 && direction.y == 1:
		$RayCast2D.rotation = deg_to_rad(0)
		
func getAvailableDirections() -> Array:
	var availableDirections:Array = []
	var directions:Array = [ Vector2(1,0), Vector2(0,-1), Vector2(-1,0), Vector2(0,1) ]
	directions.shuffle()
	for d in directions:
		rotateRaycaster(d)
		if !isRaycasterColliding():
			availableDirections.append(d)
	return availableDirections
			
func isRaycasterColliding() -> bool:
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		return true
	return false

func getDirectionToParty(partyGlobalPosition:Vector2) -> Vector2:
	var direction = get_direction(self.global_position, partyGlobalPosition)
	var diff = partyGlobalPosition - self.global_position
	diff = Vector2(floor(diff.x), floor(diff.y))
	var is_vertical = direction.x == 0
	if is_vertical:
		if sign(diff.y) != direction.y or diff.y == 0:
			direction = get_direction(self.global_position, partyGlobalPosition)
	else:
		if sign(diff.x) != direction.x or diff.x == 0:
			direction = get_direction(self.global_position, partyGlobalPosition)
	return direction
			
func snapToGrid():
	var gridX:int = self.global_position.x / Statics.ROOM_SIZE
	var gridY:int = self.global_position.y / Statics.ROOM_SIZE
	self.global_position = Vector2(gridX * Statics.ROOM_SIZE, gridY * Statics.ROOM_SIZE)
	
func get_direction(from, to):
	var diff = to - from
	if abs(diff.x) > abs(diff.y):
		return Vector2(sign(diff.x), 0)
	else:
		return Vector2(0, sign(diff.y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## 
## 
## 
func setAnimation(type:Enums.ENEMY_TYPES) -> void:
	if type == Enums.ENEMY_TYPES.GOBLIN:
		$AnimatedSprite2D.animation = "goblin"
	elif type == Enums.ENEMY_TYPES.BLOB:
		$AnimatedSprite2D.animation = "blob"
	elif type == Enums.ENEMY_TYPES.SKELETON:
		$AnimatedSprite2D.animation = "skeleton"


## 
## Set type and position
## 
func setProperties(id:String, type:Enums.ENEMY_TYPES) -> void:
	_id = id
	_type = type
	_name = EnemyHandler.getEnemyName(type)
	_description = EnemyHandler.getEnemyDescription(type)
	
	snapToGrid()
	setAnimation(type)
