extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.play("miss")
	await self.get_tree().create_timer(0.4).timeout
	self.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var y = self.global_position.y + 0.2
	self.global_position = Vector2(global_position.x, y)
