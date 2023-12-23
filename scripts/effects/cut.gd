extends AnimatedSprite2D

var rng = RandomNumberGenerator.new()

func _ready():
	self.rotation += rng.randf_range(-10, 10)
	self.play("cut")


func _process(delta):
	if self.animation_finished:
		self.queue_free()
#	pass

