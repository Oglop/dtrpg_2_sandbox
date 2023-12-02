extends Sprite2D

var _position:int = 0

func _ready():
	Events.connect("UPDATE_SPRITE_POSITIONS", _on_updateSpritePositions)
	Events.connect("UPDATE_SPRITE_ANIMATIONS", _on_updateSpriteAnimations)
	
func setProperties(position:int):
	_position = position
	setAnimation()

func _on_updateSpriteAnimations() -> void:
	setAnimation()

func _on_updateSpritePositions() -> void:
	self.global_position = Vector2(Globals.X_POSITIONS[_position], Globals.Y_POSITIONS[_position])
	
func setAnimation():
	if _position == 0:
		setCharacter1Animation()
	if _position == 1:
		setCharacter2Animation()
	if _position == 2:
		setCharacter3Animation()
	if _position == 3:
		setCharacter4Animation()

func setCharacter1Animation() -> void:
	if Data.CHARACTER_1_HEALTH_CURRENT	> 0:
		if Data.CHARACTER_1_TYPE == Enums.CLASSES.WARRIOR:
			$playerSpriteAnimations.play("warriorIdle")
		elif Data.CHARACTER_1_TYPE == Enums.CLASSES.KNIGHT:
			$playerSpriteAnimations.play("knightIdle")
		elif Data.CHARACTER_1_TYPE == Enums.CLASSES.WIZARD:
			$playerSpriteAnimations.play("wizardIdle")
		elif Data.CHARACTER_1_TYPE == Enums.CLASSES.HUNTER:
			$playerSpriteAnimations.play("hunterIdle")
	else:
		$playerSpriteAnimations.play("dead")
		
func setCharacter2Animation() -> void:
	if Data.CHARACTER_2_HEALTH_CURRENT	> 0:
		if Data.CHARACTER_2_TYPE == Enums.CLASSES.WARRIOR:
			$playerSpriteAnimations.play("warriorIdle")
		elif Data.CHARACTER_2_TYPE == Enums.CLASSES.KNIGHT:
			$playerSpriteAnimations.play("knightIdle")
		elif Data.CHARACTER_2_TYPE == Enums.CLASSES.WIZARD:
			$playerSpriteAnimations.play("wizardIdle")
		elif Data.CHARACTER_2_TYPE == Enums.CLASSES.HUNTER:
			$playerSpriteAnimations.play("hunterIdle")
	else:
		$playerSpriteAnimations.play("dead")
		
func setCharacter3Animation() -> void:
	if Data.CHARACTER_3_HEALTH_CURRENT	> 0:
		if Data.CHARACTER_3_TYPE == Enums.CLASSES.WARRIOR:
			$playerSpriteAnimations.play("warriorIdle")
		elif Data.CHARACTER_3_TYPE == Enums.CLASSES.KNIGHT:
			$playerSpriteAnimations.play("knightIdle")
		elif Data.CHARACTER_3_TYPE == Enums.CLASSES.WIZARD:
			$playerSpriteAnimations.play("wizardIdle")
		elif Data.CHARACTER_3_TYPE == Enums.CLASSES.HUNTER:
			$playerSpriteAnimations.play("hunterIdle")
	else:
		$playerSpriteAnimations.play("dead")
	
func setCharacter4Animation() -> void:
	if Data.CHARACTER_4_HEALTH_CURRENT	> 0:
		if Data.CHARACTER_4_TYPE == Enums.CLASSES.WARRIOR:
			$playerSpriteAnimations.play("warriorIdle")
		elif Data.CHARACTER_4_TYPE == Enums.CLASSES.KNIGHT:
			$playerSpriteAnimations.play("knightIdle")
		elif Data.CHARACTER_4_TYPE == Enums.CLASSES.WIZARD:
			$playerSpriteAnimations.play("wizardIdle")
		elif Data.CHARACTER_4_TYPE == Enums.CLASSES.HUNTER:
			$playerSpriteAnimations.play("hunterIdle")
	else:
		$playerSpriteAnimations.play("dead")







