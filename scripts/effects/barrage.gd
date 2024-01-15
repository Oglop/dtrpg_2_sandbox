extends AnimatedSprite2D


func _ready():
	self.play("chainLightning")
	await self.get_tree().create_timer(0.3).timeout
	self.queue_free()

