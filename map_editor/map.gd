extends Node2D

var _map: Array = []
var mapName: String = "test"


func generateMap() -> void : 
	for y in range(Statics.MAP_SIZE):
		_map.append([])
		for x in range(Statics.MAP_SIZE):
			_map[y].append(-1)
			
func draw():
	pass
	
func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)

# Called when the node enters the scene tree for the first time.
func _ready():
	generateMap()
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
