extends AnimatedSprite2D

func _ready():
	self.play("wave")
	await self.get_tree().create_timer(0.5).timeout
	self.queue_free()

