extends CanvasLayer

var PRESSABLE_WAIT:float = 0.2

enum pressable_states {
	TRUE,
	FALSE
}

enum menu_states {
	MAIN_MENU,
	SELECT_RULE,
	SELECT_ACTION
}

var availableRules:Array = [
	Enums.RULE.ALWAYS,
	Enums.RULE.SELF_HP_LT_20,
	Enums.RULE.ALLY_HP_LT_20,
	Enums.RULE.SELF_MP_LT_20,
	Enums.RULE.ALLY_MP_LT_20,
	Enums.RULE.ALLY_DEAD
]


var availableActions:Array = [
	Enums.ACTION.ATTACK,
	Enums.ACTION.DEFEND,
	Enums.ACTION.PROTECT,
	Enums.ACTION.USE_POTION_SELF,
	Enums.ACTION.USE_POTION_ALLY,
	Enums.ACTION.USE_POTION_SELF,
]

var characterPosition:int = 0

var state:menu_states = menu_states.MAIN_MENU
var pressabe:pressable_states = pressable_states.TRUE

var unselectedTheme:Theme = preload("res://media/themes/textBoxTheme.tres")
var selectedTheme:Theme = preload("res://media/themes/selectedTeme.tres")

var menuItem1:String = ""
var menuItem2:String = ""
var menuItem3:String = ""


var mainMenuSelected = 0
var ruleMenuSelected = 0
var actionMenuSelected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	setRulesMenuVisiblity(false)
	Events.connect("INPUT_UP", _on_pressUp)
	Events.connect("INPUT_DOWN", _on_pressDown)
	Events.connect("INPUT_ACCEPT", _on_pressAccept)
	Events.connect("INPUT_CANCEL", _on_pressCancel)
	


func updateAvailableRules() -> void:
	$ruleMarginContainer4/Panel/Label.text = parseTextFromRule(availableRules[0])
	$ruleMarginContainer5/Panel/Label.text = parseTextFromRule(availableRules[1])
	$ruleMarginContainer6/Panel/Label.text = parseTextFromRule(availableRules[2])
	$ruleMarginContainer7/Panel/Label.text = parseTextFromRule(availableRules[3])
	$ruleMarginContainer8/Panel/Label.text = parseTextFromRule(availableRules[4])
	$ruleMarginContainer9/Panel/Label.text = parseTextFromRule(availableRules[5])
	

func updateUI() -> void:
	if state == menu_states.MAIN_MENU:
		setRulesMenuVisiblity(false)
		if mainMenuSelected == 0:
			$MarginContainer1.theme = selectedTheme
			$MarginContainer2.theme = unselectedTheme
			$MarginContainer3.theme = unselectedTheme
		elif mainMenuSelected == 1:
			$MarginContainer1.theme = unselectedTheme
			$MarginContainer2.theme = selectedTheme
			$MarginContainer3.theme = unselectedTheme
		elif mainMenuSelected == 2:
			$MarginContainer1.theme = unselectedTheme
			$MarginContainer2.theme = unselectedTheme
			$MarginContainer3.theme = selectedTheme
	if state == menu_states.SELECT_RULE:
		updateAvailableRules()
		setRulesMenuVisiblity(true)
		if ruleMenuSelected == 0:
			$ruleMarginContainer4.theme = selectedTheme
			$ruleMarginContainer5.theme = unselectedTheme
			$ruleMarginContainer6.theme = unselectedTheme
			$ruleMarginContainer7.theme = unselectedTheme
			$ruleMarginContainer8.theme = unselectedTheme
			$ruleMarginContainer9.theme = unselectedTheme
		elif ruleMenuSelected == 1:
			$ruleMarginContainer4.theme = unselectedTheme
			$ruleMarginContainer5.theme = selectedTheme
			$ruleMarginContainer6.theme = unselectedTheme
			$ruleMarginContainer7.theme = unselectedTheme
			$ruleMarginContainer8.theme = unselectedTheme
			$ruleMarginContainer9.theme = unselectedTheme
		elif ruleMenuSelected == 2:
			$ruleMarginContainer4.theme = unselectedTheme
			$ruleMarginContainer5.theme = unselectedTheme
			$ruleMarginContainer6.theme = selectedTheme
			$ruleMarginContainer7.theme = unselectedTheme
			$ruleMarginContainer8.theme = unselectedTheme
			$ruleMarginContainer9.theme = unselectedTheme
		elif ruleMenuSelected == 3:
			$ruleMarginContainer4.theme = unselectedTheme
			$ruleMarginContainer5.theme = unselectedTheme
			$ruleMarginContainer6.theme = unselectedTheme
			$ruleMarginContainer7.theme = selectedTheme
			$ruleMarginContainer8.theme = unselectedTheme
			$ruleMarginContainer9.theme = unselectedTheme
		elif ruleMenuSelected == 4:
			$ruleMarginContainer4.theme = unselectedTheme
			$ruleMarginContainer5.theme = unselectedTheme
			$ruleMarginContainer6.theme = unselectedTheme
			$ruleMarginContainer7.theme = unselectedTheme
			$ruleMarginContainer8.theme = selectedTheme
			$ruleMarginContainer9.theme = unselectedTheme
		elif ruleMenuSelected == 5:
			$ruleMarginContainer4.theme = unselectedTheme
			$ruleMarginContainer5.theme = unselectedTheme
			$ruleMarginContainer6.theme = unselectedTheme
			$ruleMarginContainer7.theme = unselectedTheme
			$ruleMarginContainer8.theme = unselectedTheme
			$ruleMarginContainer9.theme = selectedTheme
		

func _on_pressUp() -> void:
	if pressabe == pressable_states.TRUE:
		setNotPressable()
		if state == menu_states.MAIN_MENU:
			mainMenuSelected -= 1
			if mainMenuSelected < 0:
				mainMenuSelected = 0
		if state == menu_states.SELECT_RULE: 
			ruleMenuSelected -= 1
			if ruleMenuSelected < 0:
				ruleMenuSelected = 0
	
	updateUI()
	
func _on_pressDown() -> void:
	if pressabe == pressable_states.TRUE:
		setNotPressable()
		if state == menu_states.MAIN_MENU:
			mainMenuSelected += 1
			if mainMenuSelected > 2:
				mainMenuSelected = 2
		if state == menu_states.SELECT_RULE: 
			ruleMenuSelected += 1
			if ruleMenuSelected > 5:
				ruleMenuSelected = 5
			
	updateUI()
	
func setRulesMenuVisiblity(visible:bool) -> void:
	$ruleMarginContainer4.visible = visible
	$ruleMarginContainer5.visible = visible
	$ruleMarginContainer6.visible = visible
	$ruleMarginContainer7.visible = visible
	$ruleMarginContainer8.visible = visible
	$ruleMarginContainer9.visible = visible
	
func setActionsMenyVisibility(visible:bool) -> void:
	pass
	
func _on_pressAccept() -> void:
	if pressabe == pressable_states.TRUE:
		setNotPressable()
		if state == menu_states.MAIN_MENU:
			state = menu_states.SELECT_RULE
			
	updateUI()
			
func _on_pressCancel() -> void:
	if pressabe == pressable_states.TRUE:
		setNotPressable()
		if state == menu_states.SELECT_RULE:
			state = menu_states.MAIN_MENU
			setRulesMenuVisiblity(false)
	updateUI()
	
func parseTextFromRule(rule:Enums.RULE) -> String:
	if rule == Enums.RULE.ALWAYS:
		return Text.ALWAYS
	elif rule == Enums.RULE.NEVER:
		return Text.NEVER
	elif rule == Enums.RULE.SELF_HP_GT_50:
		return Text.SELF_HP_GT_50
	elif rule == Enums.RULE.SELF_HP_GT_20:
		return Text.SELF_HP_GT_20
	elif rule == Enums.RULE.SELF_HP_LT_80:
		return Text.SELF_HP_LT_80
	elif rule == Enums.RULE.SELF_HP_LT_50:
		return Text.SELF_HP_LT_50
	elif rule == Enums.RULE.SELF_HP_LT_20:
		return Text.SELF_HP_LT_20
	elif rule == Enums.RULE.SELF_HP_LT_10:
		return Text.SELF_HP_LT_10
	elif rule == Enums.RULE.SELF_MP_GT_50:
		return Text.SELF_MP_GT_50
	elif rule == Enums.RULE.SELF_MP_GT_20:
		return Text.SELF_MP_GT_20
	elif rule == Enums.RULE.SELF_MP_LT_80:
		return Text.SELF_MP_LT_80
	elif rule == Enums.RULE.SELF_MP_LT_50:
		return Text.SELF_MP_LT_50
	elif rule == Enums.RULE.SELF_MP_LT_20:
		return Text.SELF_MP_LT_20
	elif rule == Enums.RULE.SELF_MP_LT_10:
		return Text.SELF_MP_LT_10
	elif rule == Enums.RULE.ALLY_HP_GT_50:
		return Text.ALLY_HP_GT_50
	elif rule == Enums.RULE.ALLY_HP_GT_20:
		return Text.ALLY_HP_GT_20
	elif rule == Enums.RULE.ALLY_HP_LT_80:
		return Text.ALLY_HP_LT_80
	elif rule == Enums.RULE.ALLY_HP_LT_50:
		return Text.ALLY_HP_LT_50
	elif rule == Enums.RULE.ALLY_HP_LT_20:
		return Text.ALLY_HP_LT_20
	elif rule == Enums.RULE.ALLY_HP_LT_10:
		return Text.ALLY_HP_LT_10
	elif rule == Enums.RULE.ALLY_MP_GT_50:
		return Text.ALLY_MP_GT_50
	elif rule == Enums.RULE.ALLY_MP_GT_20:
		return Text.ALLY_MP_GT_20
	elif rule == Enums.RULE.ALLY_MP_LT_80:
		return Text.ALLY_MP_LT_80
	elif rule == Enums.RULE.ALLY_MP_LT_50:
		return Text.ALLY_MP_LT_50
	elif rule == Enums.RULE.ALLY_MP_LT_10:
		return Text.ALLY_MP_LT_10
	elif rule == Enums.RULE.ALLY_MP_LT_20:
		return Text.ALLY_MP_LT_20
	elif rule == Enums.RULE.ALLY_DEAD:
		return Text.ALLY_DEAD
	return ""
	
func parseTextFromAction(action:Enums.ACTION) -> String:
	if action == Enums.NONE:
		return ""
	elif action == Enums.ATTACK:
		return Text.ATTACK
	elif action == Enums.USE_POTION_SELF:
		return Text.USE_POTION_SELF
	elif action == Enums.USE_POTION_ALLY:
		return Text.USE_POTION_ALLY
	elif action == Enums.USE_HERB_SELF:
		return Text.USE_HERB_SELF
	elif action == Enums.USE_HERB_ALLY:
		return Text.USE_HERB_ALLY
	elif action == Enums.USE_ELEXIR_ALLY:
		return Text.USE_ELEXIR_ALLY
	elif action == Enums.CAST_FIREBALL:
		return Text.CAST_FIREBALL
	elif action == Enums.PROTECT:
		return Text.PROTECT
	elif action == Enums.DEFEND:
		return Text.DEFEND
	return ""
	
func createRuleFromSelected() -> void:
	pass
	
func createActionFromSelected() -> void:
	pass

func setNotPressable() -> void:
	pressabe = pressable_states.FALSE
	$Timer.start(PRESSABLE_WAIT)
	
func _on_timer_timeout():
	$Timer.stop()
	pressabe = pressable_states.TRUE
