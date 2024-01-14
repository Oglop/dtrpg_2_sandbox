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

]

var availableActions:Array = [
	
]

var _characterPosition:int = 0

var state:menu_states = menu_states.MAIN_MENU
var pressabe:pressable_states = pressable_states.TRUE

var unselectedTheme:Theme = preload("res://media/themes/textBoxTheme.tres")
var selectedTheme:Theme = preload("res://media/themes/selectedTeme.tres")

var mainMenuSelected = 0
var ruleMenuSelected = 0
var actionMenuSelected = 0

var _indexWasMinusOne:bool = false

var _viewableRulesList:Array = []
var _viewableRulesFirst:int = 0
var _viewableRulesLast:int = 5

var _viewableActionsList:Array = []
var _viewableActionsFirst:int = 0
var _viewableActionsLast:int = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	setMainMenuVisibility(false)
	setRulesMenuVisiblity(false)
	setActionsMenyVisibility(false)
	Events.connect("INPUT_UP", _on_pressUp)
	Events.connect("INPUT_DOWN", _on_pressDown)
	Events.connect("INPUT_ACCEPT", _on_pressAccept)
	Events.connect("INPUT_CANCEL", _on_pressCancel)
	Events.connect("ACTIVATE_RULES_MENU", _on_activateRulesMenu)
	Events.connect("SET_GLOBAL_STATE", _on_globalStateChange)
	
	
func _on_globalStateChange(globalState:Enums.SYSTEM_GLOBAL_STATES) -> void:
	await self.get_tree().create_timer(0.4).timeout
	if globalState == Enums.SYSTEM_GLOBAL_STATES.IN_RULES_MENU:
		state = menu_states.MAIN_MENU
		updateCurrentRuleActionPairs()
		updateUI()
		
	
func _on_activateRulesMenu(position:int) -> void:
	_characterPosition = position
	state = menu_states.MAIN_MENU
	mainMenuSelected = 0
	ruleMenuSelected = 0
	actionMenuSelected = 0
	setAvailableRulesAndActions()
	updateUI()
	
func scrollViewableRulesUp() -> void:
	_viewableRulesFirst -= 1
	_viewableRulesLast -= 1
	if _viewableRulesFirst < 0:
		_viewableRulesFirst = 0
		_viewableRulesLast = 5
	
func scrollViewableRulesDown() -> void:
	_viewableRulesFirst += 1
	_viewableRulesLast += 1
	if _viewableRulesLast > availableRules.size() - 1:
		_viewableRulesFirst = availableRules.size() - 5
		_viewableRulesLast = availableRules.size() - 1

func scrollViewActionsUp() -> void:
	_viewableActionsFirst -= 1
	_viewableActionsLast -= 1
	if _viewableActionsFirst < 0:
		_viewableActionsFirst = 0
		_viewableActionsLast = 5
	
func scrollViewActionsDown() -> void:
	_viewableActionsFirst += 1
	_viewableActionsLast += 1
	if _viewableActionsLast > availableActions.size() - 1:
		_viewableActionsFirst = availableActions.size() - 5
		_viewableActionsLast = availableActions.size() - 1
		
func updateRulesArrowPosition(arrowIndex:int) -> void:
	var x = 33
	var y = 132 + 12 * arrowIndex
	$rulesArrow.position = Vector2i(x, y)
	print(str("ruleMenuSelected: ", ruleMenuSelected, ", _viewableRulesFirst: ", _viewableRulesFirst, ", _viewableRulesLast: ", _viewableRulesLast))#, ", arrowIndex: ", index))
	
func updateActionsArrowPosition(arrowIndex:int) -> void:
	var x = 164
	var y = 132 + 12 * arrowIndex
	$actionsArrow.position = Vector2i(x, y)
	
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
	elif type == Enums.CLASSES.KNIGHT:
		availableRules = Statics.CLASSES_ATRIBUTES.KNIGHT.AVAILABLE_RULES
	elif type == Enums.CLASSES.WIZARD:
		availableRules = Statics.CLASSES_ATRIBUTES.WIZARD.AVAILABLE_RULES
	elif type == Enums.CLASSES.HUNTER:
		availableRules = Statics.CLASSES_ATRIBUTES.HUNTER.AVAILABLE_RULES
	elif type == Enums.CLASSES.THIEF:
		availableRules = Statics.CLASSES_ATRIBUTES.THIEF.AVAILABLE_RULES
	elif type == Enums.CLASSES.CLERIC:
		availableRules = Statics.CLASSES_ATRIBUTES.CLERIC.AVAILABLE_RULES
		
	availableRules.push_front(Enums.RULE.NONE)
	setAvailableActions()
	updateCurrentRuleActionPairs()
	
func populateViewableRules() -> void:
	_viewableRulesList = []
	for n in range(_viewableRulesFirst, _viewableRulesLast + 1):
		if availableRules.size() > n:
			_viewableRulesList.append(availableRules[n])
		else:
			_viewableRulesList.append(Enums.RULE.NONE)
	
func populateViewableActions() -> void:
	_viewableActionsList = []
	for n in range(_viewableActionsFirst, _viewableActionsLast + 1):
		if availableActions.size() > n:
			_viewableActionsList.append(availableActions[n])
		else:
			_viewableActionsList.append(Enums.ACTION.NONE)

func updateRulesLabels() -> void:
	if _viewableRulesList.size() >= 1:
		$rulesMarginContainer/Panel/Label1.text = parseTextFromRule(_viewableRulesList[0])
	else:
		$rulesMarginContainer/Panel/Label1.text = ""
	if _viewableRulesList.size() >= 2:
		$rulesMarginContainer/Panel/Label2.text = parseTextFromRule(_viewableRulesList[1])
	else:
		$rulesMarginContainer/Panel/Label2.text = ""
	if _viewableRulesList.size() >= 3:
		$rulesMarginContainer/Panel/Label3.text = parseTextFromRule(_viewableRulesList[2])
	else:
		$rulesMarginContainer/Panel/Label3.text = ""
	if _viewableRulesList.size() >= 4:
		$rulesMarginContainer/Panel/Label4.text = parseTextFromRule(_viewableRulesList[3])
	else:
		$rulesMarginContainer/Panel/Label4.text = ""
	if _viewableRulesList.size() >= 5:
		$rulesMarginContainer/Panel/Label5.text = parseTextFromRule(_viewableRulesList[4])
	else:
		$rulesMarginContainer/Panel/Label5.text = ""
	if _viewableRulesList.size() >= 6:
		$rulesMarginContainer/Panel/Label6.text = parseTextFromRule(_viewableRulesList[5])
	else:
		$rulesMarginContainer/Panel/Label6.text = ""
		
	
func setAvailableActions() -> void:
	availableActions
	if _characterPosition == 0:
		availableActions = Data.CHARACTER_1_ACTIONS
	elif _characterPosition == 1:
		availableActions = Data.CHARACTER_2_ACTIONS
	elif _characterPosition == 1:
		availableActions = Data.CHARACTER_3_ACTIONS
	elif _characterPosition == 1:
		availableActions = Data.CHARACTER_4_ACTIONS

func updateActionLabels() -> void:
	if _viewableActionsList.size() >= 1:
		$actionMarginContainer/Panel/Label1.text = parseTextFromAction(_viewableActionsList[0])
	else:
		$actionMarginContainer/Panel/Label1.text = ""

	if _viewableActionsList.size() >= 2:
		$actionMarginContainer/Panel/Label2.text = parseTextFromAction(_viewableActionsList[1])
	else:
		$actionMarginContainer/Panel/Label2.text = ""
		
	if _viewableActionsList.size() >= 3:
		$actionMarginContainer/Panel/Label3.text = parseTextFromAction(_viewableActionsList[2])
	else:
		$actionMarginContainer/Panel/Label3.text = ""
		
	if _viewableActionsList.size() >= 4:
		$actionMarginContainer/Panel/Label4.text = parseTextFromAction(_viewableActionsList[3])
	else:
		$actionMarginContainer/Panel/Label4.text = ""
		
	if _viewableActionsList.size() >= 5:
		$actionMarginContainer/Panel/Label5.text = parseTextFromAction(_viewableActionsList[4])
	else:
		$actionMarginContainer/Panel/Label5.text = ""
		
	if _viewableActionsList.size() >= 6:
		$actionMarginContainer/Panel/Label6.text = parseTextFromAction(_viewableActionsList[5])
	else:
		$actionMarginContainer/Panel/Label6.text = ""
		
func refreshRulesViewableList() -> void:
	if ruleMenuSelected > _viewableRulesLast:
		scrollViewableRulesDown()
		populateViewableRules() 
	elif ruleMenuSelected < _viewableRulesFirst:
		scrollViewableRulesUp()
		populateViewableRules()
	elif _indexWasMinusOne:
		_indexWasMinusOne = false
		_viewableRulesFirst = 0
		_viewableRulesLast = 5
		populateViewableRules()
	
func refreshActionsViewableList() -> void:
	if actionMenuSelected > _viewableActionsLast:
		scrollViewableRulesDown()
		populateViewableRules() 
	elif actionMenuSelected < _viewableActionsFirst:
		scrollViewableRulesUp()
		populateViewableRules()
	elif _indexWasMinusOne:
		_indexWasMinusOne = false
		_viewableActionsFirst = 0
		_viewableActionsLast = 5
		populateViewableRules()

func updateCurrentRuleActionPairs() -> void:
	print(str("_characterPosition: ", _characterPosition))
	if _characterPosition == 0:
		$MarginContainer1/rule1Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_1_RULES[0].rule), " - ", parseTextFromAction(Data.CHARACTER_1_RULES[0].action))
		$MarginContainer2/rule2Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_1_RULES[1].rule), " - ", parseTextFromAction(Data.CHARACTER_1_RULES[1].action))
		$MarginContainer3/rule3Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_1_RULES[2].rule), " - ", parseTextFromAction(Data.CHARACTER_1_RULES[2].action))
		$MarginContainer4/rule4Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_1_RULES[3].rule), " - ", parseTextFromAction(Data.CHARACTER_1_RULES[3].action))
	elif _characterPosition == 1:
		$MarginContainer1/rule1Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_2_RULES[0].rule), " - ", parseTextFromAction(Data.CHARACTER_2_RULES[0].action))
		$MarginContainer2/rule2Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_2_RULES[1].rule), " - ", parseTextFromAction(Data.CHARACTER_2_RULES[1].action))
		$MarginContainer3/rule3Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_2_RULES[2].rule), " - ", parseTextFromAction(Data.CHARACTER_2_RULES[2].action))
		$MarginContainer4/rule4Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_2_RULES[3].rule), " - ", parseTextFromAction(Data.CHARACTER_2_RULES[3].action))
	elif _characterPosition == 2:
		$MarginContainer1/rule1Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_3_RULES[0].rule), " - ", parseTextFromAction(Data.CHARACTER_3_RULES[0].action))
		$MarginContainer2/rule2Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_3_RULES[1].rule), " - ", parseTextFromAction(Data.CHARACTER_3_RULES[1].action))
		$MarginContainer3/rule3Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_3_RULES[2].rule), " - ", parseTextFromAction(Data.CHARACTER_3_RULES[2].action))
		$MarginContainer4/rule4Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_3_RULES[3].rule), " - ", parseTextFromAction(Data.CHARACTER_3_RULES[3].action))
	elif _characterPosition == 3:
		$MarginContainer1/rule1Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_4_RULES[0].rule), " - ", parseTextFromAction(Data.CHARACTER_4_RULES[0].action))
		$MarginContainer2/rule2Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_4_RULES[1].rule), " - ", parseTextFromAction(Data.CHARACTER_4_RULES[1].action))
		$MarginContainer3/rule3Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_4_RULES[2].rule), " - ", parseTextFromAction(Data.CHARACTER_4_RULES[2].action))
		$MarginContainer4/rule4Panel/Label.text = str(parseTextFromRule(Data.CHARACTER_4_RULES[3].rule), " - ", parseTextFromAction(Data.CHARACTER_4_RULES[3].action))

func updateUI() -> void:
	if _viewableRulesList.size() == 0:
		populateViewableRules()
	if 	_viewableActionsList.size() == 0:
		populateViewableActions()
	
	if Data.SYSTEM_STATE != Enums.SYSTEM_GLOBAL_STATES.IN_RULES_MENU:
		setMainMenuVisibility(false)
		setRulesMenuVisiblity(false)
		setActionsMenyVisibility(false)
	else:
		setMainMenuVisibility(true)
		updateCurrentRuleActionPairs()
		if state == menu_states.MAIN_MENU:
			setRulesMenuVisiblity(false)
			setActionsMenyVisibility(false)
			if mainMenuSelected == 0:
				$MarginContainer1.theme = selectedTheme
				$MarginContainer2.theme = unselectedTheme
				$MarginContainer3.theme = unselectedTheme
				$MarginContainer4.theme = unselectedTheme
			elif mainMenuSelected == 1:
				$MarginContainer1.theme = unselectedTheme
				$MarginContainer2.theme = selectedTheme
				$MarginContainer3.theme = unselectedTheme
				$MarginContainer4.theme = unselectedTheme
			elif mainMenuSelected == 2:
				$MarginContainer1.theme = unselectedTheme
				$MarginContainer2.theme = unselectedTheme
				$MarginContainer3.theme = selectedTheme
				$MarginContainer4.theme = unselectedTheme
			elif mainMenuSelected == 3:
				$MarginContainer1.theme = unselectedTheme
				$MarginContainer2.theme = unselectedTheme
				$MarginContainer3.theme = unselectedTheme
				$MarginContainer4.theme = selectedTheme
				
		if state == menu_states.SELECT_RULE:
			var arrowIndex:int = ruleMenuSelected - _viewableRulesFirst
			var _viewableExcepts:int = ruleMenuSelected - _viewableRulesFirst
			if ruleMenuSelected >= 5 && _viewableExcepts > 4:
				arrowIndex = 5
			if arrowIndex < 0:
				arrowIndex = 0
			updateRulesArrowPosition(arrowIndex)
			updateRulesLabels()
			refreshRulesViewableList()
			setRulesMenuVisiblity(true)
			setActionsMenyVisibility(false)
#	
		if state == menu_states.SELECT_ACTION:
			var arrowIndex:int = actionMenuSelected - _viewableActionsFirst
			var _viewableExcepts:int = actionMenuSelected - _viewableActionsFirst
			if actionMenuSelected >= 5 && _viewableExcepts > 4:
				arrowIndex = 5
			if arrowIndex < 0:
				arrowIndex = 0
			updateActionsArrowPosition(arrowIndex)
			updateActionLabels()
			refreshActionsViewableList()
			setRulesMenuVisiblity(true)
			setActionsMenyVisibility(true)
#			

func _on_pressUp() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_RULES_MENU:
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
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_RULES_MENU:
		if pressabe == pressable_states.TRUE:
			setNotPressable()
			if state == menu_states.MAIN_MENU:
				mainMenuSelected += 1
				if mainMenuSelected > 3:
					mainMenuSelected = 3
			if state == menu_states.SELECT_RULE: 
				ruleMenuSelected += 1
				if ruleMenuSelected > availableRules.size() - 1:
					ruleMenuSelected = availableRules.size() - 1
			if state == menu_states.SELECT_ACTION: 
				actionMenuSelected += 1
				if actionMenuSelected > availableActions.size() - 1:
					actionMenuSelected = availableActions.size() - 1
				
		updateUI()
	
func setRulesMenuVisiblity(visible:bool) -> void:
	$rulesMarginContainer.visible = visible
	$rulesArrow.visible = visible

func setActionsMenyVisibility(visible:bool) -> void:
	$actionMarginContainer.visible = visible
	$actionsArrow.visible = visible
	
func setMainMenuVisibility(visible:bool) -> void:
	$MarginContainer1.visible = visible
	$MarginContainer2.visible = visible
	$MarginContainer3.visible = visible
	$MarginContainer4.visible = visible
	
func checkForNoneRule() -> bool:
	if availableRules[ruleMenuSelected] != Enums.RULE.NONE:
		return false
	setRuleAndActionForCharacter(Enums.RULE.NONE, Enums.ACTION.NONE)
	return true
	
func _on_pressAccept() -> void:
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_RULES_MENU:
		if pressabe == pressable_states.TRUE:
			setNotPressable()
			if state == menu_states.MAIN_MENU:
				state = menu_states.SELECT_RULE
			elif state == menu_states.SELECT_RULE:
				if !checkForNoneRule():
					actionMenuSelected = 0
					state = menu_states.SELECT_ACTION
				else:
					state = menu_states.MAIN_MENU
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
	if Data.SYSTEM_STATE == Enums.SYSTEM_GLOBAL_STATES.IN_RULES_MENU:
		if pressabe == pressable_states.TRUE:
			setNotPressable()
			if state == menu_states.SELECT_RULE:
				state = menu_states.MAIN_MENU
			elif state == menu_states.SELECT_ACTION:
				state = menu_states.SELECT_RULE
			elif state == menu_states.MAIN_MENU:
				Events.emit_signal("SET_GLOBAL_STATE", Enums.SYSTEM_GLOBAL_STATES.IN_PAUSE_SCREEN)
		updateUI()
	
func parseTextFromRule(rule:Enums.RULE) -> String:
	if rule == Enums.RULE.NONE:
		return Text.NO_RULE
	elif rule == Enums.RULE.ALWAYS:
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
