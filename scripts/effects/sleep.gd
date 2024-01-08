extends AnimatedSprite2D

func _ready():
	self.play("protect")
	await self.get_tree().create_timer(0.4).timeout
	self.queue_free()
