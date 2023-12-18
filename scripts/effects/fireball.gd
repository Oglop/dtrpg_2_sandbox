extends AnimatedSprite2D

func _ready():
	self.animation = "fireball"
	self.play("fireball")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.animation_finished:
		self.queue_free()
