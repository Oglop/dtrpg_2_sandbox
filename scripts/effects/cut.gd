extends AnimatedSprite2D

var rng = RandomNumberGenerator.new()

func _ready():
	self.rotation += rng.randf_range(-0.5, 0.5)
	self.play("cut")
	await self.get_tree().create_timer(0.2).timeout
	self.queue_free()
