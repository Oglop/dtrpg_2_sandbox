extends MarginContainer

func _ready():
	Events.connect("LOAD_CHARACTER_CARD", _on_loadCharacterCardByPosition)
	Events.connect("VISIBLE_CHARACTER_CARD", _on_setVisisble)
	Events.connect("CHARACTER_SELECT_CHANGED",  _on_loadCharacterCardByPosition)

func _on_setVisisble(visible:bool) -> void:
	self.visible = visible

func _on_loadCharacterCardByPosition(position:int) -> void:
#	_on_setVisisble(true)
	var character = CharacterHandler.getCharacterByPosition(position)
	$Panel/LabelName.text = character.name
	$Panel/LabelLevel.text = str(Text.CHARACTER_CARD_LEVEL, character.lv)
	$Panel/LabelClass.text = str(character.class)
	$Panel/LabelXP.text = str(Text.CHARACTER_CARD_XP, character.xp)
	$Panel/LabelNext.text = str(Text.CHARACTER_CARD_NEXT, character.next)
	$Panel/LabelLuc.text = str(Text.CHARACTER_CARD_LUCK, character.luck)
	$Panel/LabelInt.text = str(Text.CHARACTER_CARD_INTELLIGENCE, character.intelligence)
	$Panel/LabelAgi.text = str(Text.CHARACTER_CARD_AGILITY, character.agility)
	$Panel/LabelStr.text = str(Text.CHARACTER_CARD_STRENGTH, character.strength)
	$Panel/LabelHP.text = str(Text.CHARACTER_CARD_HP, character.health, "/", character.healthMax)
	$Panel/LabelMP.text = str(Text.CHARACTER_CARD_MP, character.magic, "/", character.magicMax)
	$Panel/LabelAttack.text = str(Text.CHARACTER_CARD_ATTACK, character.attack)
	$Panel/LabelDefence.text = str(Text.CHARACTER_CARD_DEFENCE, character.defence)
	$Panel/LabelArmor.text = str(Text.CHARACTER_CARD_ARMOR, character.armor)
	$Panel/LabelWeapon.text = str(Text.CHARACTER_CARD_WEAPON, character.weapon)
	$Panel/LabelAccessory.text = str(Text.CHARACTER_CARD_ACCESSORY, character.accessory)
