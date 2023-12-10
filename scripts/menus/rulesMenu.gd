extends CanvasLayer

var PRESSABLE_WAIT:float = 0.2

enum pressable_states {
	TRUE,
	FALSE
}

enum menu_states {
	IN_ACTIVE,
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

var _characterPosition:int = 0

var state:menu_states = menu_states.MAIN_MENU
var pressabe:pressable_states = pressable_states.TRUE

var unselectedTheme:Theme = preload("res://media/themes/textBoxTheme.tres")
var selectedTheme:Theme = preload("res://media/themes/selectedTeme.tres")

var mainMenuSelected = 0
var ruleMenuSelected = 0
var actionMenuSelected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	setRulesMenuVisiblity(false)
	setActionsMenyVisibility(false)
	Events.connect("INPUT_UP", _on_pressUp)
	Events.connect("INPUT_DOWN", _on_pressDown)
	Events.connect("INPUT_ACCEPT", _on_pressAccept)
	Events.connect("INPUT_CANCEL", _on_pressCancel)
	Events.connect("ACTIVATE_RULES_MENU", _on_activateRulesMenu)
	
func _on_activateRulesMenu(position:int) -> void:
	_characterPosition = position
	state = menu_states.MAIN_MENU
	mainMenuSelected = 0
	ruleMenuSelected = 0
	actionMenuSelected = 0
	setAvailableRulesAndActions()
	updateUI()
	
func setAvailableRulesAndActions() -> void:
	var type:Enums.CLASSES
	if _characterPosition == 0:
		type = Data.CHARACTER_1_TYPE
	elif _characterPosition == 1:
		type = Data.CHARACTER_2_TYPE
	elif _characterPosition == 2:
		type = Data.CHARACTER_3_TYPE
	elif _characterPosition == 3:
		type = Data.CHARACTER_4_TYPE
		
	if type == Enums.CLASSES.WARRIOR:
		availableRules = Statics.CLASSES_ATRIBUTES.WARRIOR.AVAILABLE_RULES
		availableActions = Statics.CLASSES_ATRIBUTES.WARRIOR.AVAILABLE_ACTIONS
	elif type == Enums.CLASSES.KNIGHT:
		availableRules = Statics.CLASSES_ATRIBUTES.KNIGHT.AVAILABLE_RULES
		availableActions = Statics.CLASSES_ATRIBUTES.KNIGHT.AVAILABLE_ACTIONS
	elif type == Enums.CLASSES.WIZARD:
		availableRules = Statics.CLASSES_ATRIBUTES.WIZARD.AVAILABLE_RULES
		availableActions = Statics.CLASSES_ATRIBUTES.WIZARD.AVAILABLE_ACTIONS
	elif type == Enums.CLASSES.HUNTER:
		availableRules = Statics.CLASSES_ATRIBUTES.HUNTER.AVAILABLE_RULES
		availableActions = Statics.CLASSES_ATRIBUTES.HUNTER.AVAILABLE_ACTIONS
	elif type == Enums.CLASSES.THIEF:
		availableRules = Statics.CLASSES_ATRIBUTES.THIEF.AVAILABLE_RULES
		availableActions = Statics.CLASSES_ATRIBUTES.THIEF.AVAILABLE_ACTIONS
	elif type == Enums.CLASSES.CLERIC:
		availableRules = Statics.CLASSES_ATRIBUTES.CLERIC.AVAILABLE_RULES
		availableActions = Statics.CLASSES_ATRIBUTES.CLERIC.AVAILABLE_ACTIONS

func updateAvailableRules() -> void:
	if availableRules.size() >= 1:
		$ruleMarginContainer4/Panel/Label.text = parseTextFromRule(availableRules[0])
	if availableRules.size() >= 2:
		$ruleMarginContainer5/Panel/Label.text = parseTextFromRule(availableRules[1])
	if availableRules.size() >= 3:
		$ruleMarginContainer6/Panel/Label.text = parseTextFromRule(availableRules[2])
	if availableRules.size() >= 4:
		$ruleMarginContainer7/Panel/Label.text = parseTextFromRule(availableRules[3])
	if availableRules.size() >= 5:
		$ruleMarginContainer8/Panel/Label.text = parseTextFromRule(availableRules[4])
	if availableRules.size() >= 6:
		$ruleMarginContainer9/Panel/Label.text = parseTextFromRule(availableRules[5])
	
func updateAvailableActions() -> void:
	if availableActions.size() >= 1:
		$actionMarginContainer10/Panel/Label.text = parseTextFromAction(availableActions[0])
	if availableActions.size() >= 2:
		$actionMarginContainer11/Panel/Label.text = parseTextFromAction(availableActions[1])
	if availableActions.size() >= 3:	
		$actionMarginContainer12/Panel/Label.text = parseTextFromAction(availableActions[2])
	if availableActions.size() >= 4:	
		$actionMarginContainer13/Panel/Label.text = parseTextFromAction(availableActions[3])
	if availableActions.size() >= 5:
		$actionMarginContainer14/Panel/Label.text = parseTextFromAction(availableActions[4])
	if availableActions.size() >= 6:
		$actionMarginContainer15/Panel/Label.text = parseTextFromAction(availableActions[5])


func updateCurrentRuleActionPairs() -> void:
	if _characterPosition == 0:
		$MarginContainer1/rule1Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_1_RULES[0].rule), " - ",  parseTextFromAction(Data.CHARACTER_1_RULES[0].action))
		$MarginContainer2/rule2Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_1_RULES[1].rule), " - ",  parseTextFromAction(Data.CHARACTER_1_RULES[1].action))
		$MarginContainer3/rule3Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_1_RULES[2].rule), " - ",  parseTextFromAction(Data.CHARACTER_1_RULES[2].action))
	elif _characterPosition == 1:
		$MarginContainer1/rule1Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_2_RULES[0].rule), " - ",  parseTextFromAction(Data.CHARACTER_2_RULES[0].action))
		$MarginContainer2/rule2Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_2_RULES[1].rule), " - ",  parseTextFromAction(Data.CHARACTER_2_RULES[1].action))
		$MarginContainer3/rule3Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_2_RULES[2].rule), " - ",  parseTextFromAction(Data.CHARACTER_2_RULES[2].action))
	elif _characterPosition == 2:
		$MarginContainer1/rule1Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_3_RULES[0].rule), " - ",  parseTextFromAction(Data.CHARACTER_3_RULES[0].action))
		$MarginContainer2/rule2Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_3_RULES[1].rule), " - ",  parseTextFromAction(Data.CHARACTER_3_RULES[1].action))
		$MarginContainer3/rule3Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_3_RULES[2].rule), " - ",  parseTextFromAction(Data.CHARACTER_3_RULES[2].action))
	elif _characterPosition == 3:
		$MarginContainer1/rule1Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_4_RULES[0].rule), " - ",  parseTextFromAction(Data.CHARACTER_4_RULES[0].action))
		$MarginContainer2/rule2Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_4_RULES[1].rule), " - ",  parseTextFromAction(Data.CHARACTER_4_RULES[1].action))
		$MarginContainer3/rule3Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_4_RULES[2].rule), " - ",  parseTextFromAction(Data.CHARACTER_4_RULES[2].action))

func updateUI() -> void:
	updateCurrentRuleActionPairs()
	if state == menu_states.MAIN_MENU:
		setRulesMenuVisiblity(false)
		setActionsMenyVisibility(false)
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
		setActionsMenyVisibility(false)
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
	if state == menu_states.SELECT_ACTION:
		updateAvailableActions()
		setRulesMenuVisiblity(true)
		setActionsMenyVisibility(true)
		if actionMenuSelected == 0:
			$actionMarginContainer10.theme = selectedTheme
			$actionMarginContainer11.theme = unselectedTheme
			$actionMarginContainer12.theme = unselectedTheme
			$actionMarginContainer13.theme = unselectedTheme
			$actionMarginContainer14.theme = unselectedTheme
			$actionMarginContainer15.theme = unselectedTheme
		elif actionMenuSelected == 1:
			$actionMarginContainer10.theme = unselectedTheme
			$actionMarginContainer11.theme = selectedTheme
			$actionMarginContainer12.theme = unselectedTheme
			$actionMarginContainer13.theme = unselectedTheme
			$actionMarginContainer14.theme = unselectedTheme
			$actionMarginContainer15.theme = unselectedTheme
		elif actionMenuSelected == 2:
			$actionMarginContainer10.theme = unselectedTheme
			$actionMarginContainer11.theme = unselectedTheme
			$actionMarginContainer12.theme = selectedTheme
			$actionMarginContainer13.theme = unselectedTheme
			$actionMarginContainer14.theme = unselectedTheme
			$actionMarginContainer15.theme = unselectedTheme
		elif actionMenuSelected == 3:
			$actionMarginContainer10.theme = unselectedTheme
			$actionMarginContainer11.theme = unselectedTheme
			$actionMarginContainer12.theme = unselectedTheme
			$actionMarginContainer13.theme = selectedTheme
			$actionMarginContainer14.theme = unselectedTheme
			$actionMarginContainer15.theme = unselectedTheme
		elif actionMenuSelected == 4:
			$actionMarginContainer10.theme = unselectedTheme
			$actionMarginContainer11.theme = unselectedTheme
			$actionMarginContainer12.theme = unselectedTheme
			$actionMarginContainer13.theme = unselectedTheme
			$actionMarginContainer14.theme = selectedTheme
			$actionMarginContainer15.theme = unselectedTheme
		elif actionMenuSelected == 5:
			$actionMarginContainer10.theme = unselectedTheme
			$actionMarginContainer11.theme = unselectedTheme
			$actionMarginContainer12.theme = unselectedTheme
			$actionMarginContainer13.theme = unselectedTheme
			$actionMarginContainer14.theme = unselectedTheme
			$actionMarginContainer15.theme = selectedTheme

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
		if state == menu_states.SELECT_ACTION: 
			actionMenuSelected -= 1
			if actionMenuSelected < 0:
				actionMenuSelected = 0
	
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
		if state == menu_states.SELECT_ACTION: 
			actionMenuSelected += 1
			if actionMenuSelected > availableActions.size() - 1:
				actionMenuSelected = availableActions.size() - 1
			
	updateUI()
	
func setRulesMenuVisiblity(visible:bool) -> void:
	$ruleMarginContainer4.visible = visible
	$ruleMarginContainer5.visible = visible
	$ruleMarginContainer6.visible = visible
	$ruleMarginContainer7.visible = visible
	$ruleMarginContainer8.visible = visible
	$ruleMarginContainer9.visible = visible
	
func setActionsMenyVisibility(visible:bool) -> void:
	$actionMarginContainer10.visible = visible
	$actionMarginContainer11.visible = visible
	$actionMarginContainer12.visible = visible
	$actionMarginContainer13.visible = visible
	$actionMarginContainer14.visible = visible
	$actionMarginContainer15.visible = visible
	
func _on_pressAccept() -> void:
	if pressabe == pressable_states.TRUE:
		setNotPressable()
		if state == menu_states.MAIN_MENU:
			state = menu_states.SELECT_RULE
		elif state == menu_states.SELECT_RULE:
			state = menu_states.SELECT_ACTION
		elif state == menu_states.SELECT_ACTION:
			setRuleAndActionForCharacter(availableRules[ruleMenuSelected], availableActions[actionMenuSelected])
			state = menu_states.MAIN_MENU
	updateUI()
	
func setRuleAndActionForCharacter(rule:Enums.RULE, action:Enums.ACTION) -> void:
	var newRule:Dictionary = {
		"rule": rule,
		"action": action
	}
	if _characterPosition == 0:
		Data.CHARACTER_1_RULES[mainMenuSelected] = newRule
	elif _characterPosition == 1:
		Data.CHARACTER_2_RULES[mainMenuSelected] = newRule
	elif _characterPosition == 2:
		Data.CHARACTER_3_RULES[mainMenuSelected] = newRule
	elif _characterPosition == 3:
		Data.CHARACTER_4_RULES[mainMenuSelected] = newRule
	
func _on_pressCancel() -> void:
	if pressabe == pressable_states.TRUE:
		setNotPressable()
		if state == menu_states.SELECT_RULE:
			state = menu_states.MAIN_MENU
		elif state == menu_states.SELECT_ACTION:
			state = menu_states.SELECT_RULE
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
	if action == Enums.ACTION.NONE:
		return ""
	elif action == Enums.ACTION.ATTACK:
		return Text.ATTACK
	elif action == Enums.ACTION.USE_POTION_SELF:
		return Text.USE_POTION_SELF
	elif action == Enums.ACTION.USE_POTION_ALLY:
		return Text.USE_POTION_ALLY
	elif action == Enums.ACTION.USE_HERB_SELF:
		return Text.USE_HERB_SELF
	elif action == Enums.ACTION.USE_HERB_ALLY:
		return Text.USE_HERB_ALLY
	elif action == Enums.ACTION.USE_ELEXIR_ALLY:
		return Text.USE_ELEXIR_ALLY
	elif action == Enums.ACTION.CAST_FIREBALL:
		return Text.CAST_FIREBALL
	elif action == Enums.ACTION.PROTECT:
		return Text.PROTECT
	elif action == Enums.ACTION.DEFEND:
		return Text.DEFEND
	elif action == Enums.ACTION.CAST_HEAL:
		return Text.CAST_HEAL
	elif action == Enums.ACTION.CAST_REVIVE:
		return Text.CAST_REVIVE
	elif action == Enums.ACTION.STEAL:
		return Text.STEAL
	elif action == Enums.ACTION.BACK_STAB:
		return Text.BACK_STAB
	return ""


func setNotPressable() -> void:
	pressabe = pressable_states.FALSE
	$Timer.start(PRESSABLE_WAIT)
	
func _on_timer_timeout():
	$Timer.stop()
	pressabe = pressable_states.TRUE
