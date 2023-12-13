extends Node2D

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
		self.queue_free()
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
		if direction.x == 1 && direction.y == 0:
			self.global_position = Vector2(self.global_position.x + Statics.ROOM_SIZE, self.global_position.y)
		elif direction.x == 0 && direction.y == -1:
			self.global_position = Vector2(self.global_position.x, self.global_position.y - Statics.ROOM_SIZE)
		elif direction.x == -1 && direction.y == 0:
			self.global_position = Vector2(self.global_position.x - Statics.ROOM_SIZE, self.global_position.y)
		elif direction.x == 0 && direction.y == 1:
			self.global_position = Vector2(self.global_position.x, self.global_position.y + Statics.ROOM_SIZE)
		

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
	
static func get_direction(from, to):
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
