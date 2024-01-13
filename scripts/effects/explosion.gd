extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.play("explosion")
	await self.get_tree().create_timer(0.5).timeout
	self.queue_free()
