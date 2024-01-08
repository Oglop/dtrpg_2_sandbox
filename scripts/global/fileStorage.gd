extends Node

func _ready():
	Events.connect("SYSTEM_LOAD_STATE", loadSlot)
	Events.connect("SYSTEM_SAVE_STATE", saveSlot)
	
func checkCreateDirectory(path:String) -> bool:
	
	return true
# Save map
func saveMap(map: Array, name: String) -> void:
	var path = "user://" + name + ".save"
	if !fileExists(Statics.SAVE_FILE_SLOT_1_PATH):
		var file = FileAccess.open(path, FileAccess.WRITE)

func setState(state:Dictionary) -> void:
	Data.MAP_OPENED_TREASURES = state.mapOpenedTreasures
	Data.PARTY_CURRENT_ROOM = state.partyCurrentRoom
	Data.MAP_OPENED_DOORS = state.mapOpenedDooors
	Data.PARTY_SKILLS = state.partySkills
	Data.PARTY_X = state.partyX
	Data.PARTY_Y = state.partyY
	Data.PARTY_CROWNS = state.partyCrowns
	Data.PARTY_ITEMS = state.partyItems
	Data.CHARACTER_1_TYPE = state.character_1_type
	Data.CHARACTER_1_NAME = state.character_1_name
	Data.CHARACTER_1_HEALTH_MAX = state.character_1_healthMax
	Data.CHARACTER_1_HEALTH_CURRENT = state.character_1_healthCurrent
	Data.CHARACTER_1_HEALTH_GROWTH = state.character_1_healthGrowth
	Data.CHARACTER_1_MAGIC_MAX = state.character_1_magicMax
	Data.CHARACTER_1_MAGIC_CURRENT = state.character_1_magicCurrent
	Data.CHARACTER_1_MAGIC_GROWTH = state.character_1_magicGrowth
	Data.CHARACTER_1_LV = state.character_1_lv
	Data.CHARACTER_1_XP = state.character_1_xp
	Data.CHARACTER_1_NEXT = state.character_1_next
	Data.CHARACTER_1_STRENGTH = state.character_1_strength
	Data.CHARACTER_1_AGILITY = state.character_1_agility
	Data.CHARACTER_1_INTELLIGENCE = state.character_1_intelligence
	Data.CHARACTER_1_LUCK = state.character_1_luck
	Data.CHARACTER_1_EQUIPABLE = state.character_1_equipable
	Data.CHARACTER_1_RULES = state.character_1_rules
	Data.CHARACTER_1_WEAPON = state.character_1_weapon
	Data.CHARACTER_1_ARMOR = state.character_1_armor
	Data.CHARACTER_1_ACCESSORY = state.character_1_accessory
	Data.CHARACTER_1_ACTIONS = state.character_1_actionn
	Data.CHARACTER_2_TYPE = state.character_2_type
	Data.CHARACTER_2_NAME = state.character_2_name
	Data.CHARACTER_2_HEALTH_MAX = state.character_2_healthMax
	Data.CHARACTER_2_HEALTH_CURRENT = state.character_2_healthCurrent
	Data.CHARACTER_2_HEALTH_GROWTH = state.character_2_healthGrowth
	Data.CHARACTER_2_MAGIC_MAX = state.character_2_magicMax
	Data.CHARACTER_2_MAGIC_CURRENT = state.character_2_magicCurrent
	Data.CHARACTER_2_MAGIC_GROWTH = state.character_2_magicGrowth
	Data.CHARACTER_2_LV = state.character_2_lv
	Data.CHARACTER_2_XP = state.character_2_xp
	Data.CHARACTER_2_NEXT = state.character_2_next
	Data.CHARACTER_2_STRENGTH = state.character_2_strength
	Data.CHARACTER_2_AGILITY = state.character_2_agility
	Data.CHARACTER_2_INTELLIGENCE = state.character_2_intelligence
	Data.CHARACTER_2_LUCK = state.character_2_luck
	Data.CHARACTER_2_EQUIPABLE = state.character_2_equipable
	Data.CHARACTER_2_RULES = state.character_2_rules
	Data.CHARACTER_2_WEAPON = state.character_2_weapon
	Data.CHARACTER_2_ARMOR = state.character_2_armor
	Data.CHARACTER_2_ACCESSORY = state.character_2_accessory
	Data.CHARACTER_2_ACTIONS = state.character_2_actions
	Data.CHARACTER_3_TYPE = state.character_3_type
	Data.CHARACTER_3_NAME = state.character_3_name
	Data.CHARACTER_3_HEALTH_MAX = state.character_3_healthMax
	Data.CHARACTER_3_HEALTH_CURRENT = state.character_3_healthCurrent
	Data.CHARACTER_3_HEALTH_GROWTH = state.character_3_healthGrowth
	Data.CHARACTER_3_MAGIC_MAX = state.character_3_magicMax
	Data.CHARACTER_3_MAGIC_CURRENT = state.character_3_magicCurrent
	Data.CHARACTER_3_MAGIC_GROWTH = state.character_3_magicGrowth
	Data.CHARACTER_3_LV = state.character_3_lv
	Data.CHARACTER_3_XP = state.character_3_xp
	Data.CHARACTER_3_NEXT = state.character_3_next
	Data.CHARACTER_3_STRENGTH = state.character_3_strength
	Data.CHARACTER_3_AGILITY = state.character_3_agility
	Data.CHARACTER_3_INTELLIGENCE = state.character_3_intelligence
	Data.CHARACTER_3_LUCK = state.character_3_luck
	Data.CHARACTER_3_EQUIPABLE = state.character_3_equipable
	Data.CHARACTER_3_RULES = state.character_3_rules
	Data.CHARACTER_3_WEAPON = state.character_3_weapon 
	Data.CHARACTER_3_ARMOR = state.character_3_armor
	Data.CHARACTER_3_ACCESSORY = state.character_3_accessory
	Data.CHARACTER_3_ACTIONS = state.character_3_actions
	Data.CHARACTER_4_TYPE = state.character_4_type 
	Data.CHARACTER_4_NAME = state.character_4_name 
	Data.CHARACTER_4_HEALTH_MAX = state.character_4_healthMax 
	Data.CHARACTER_4_HEALTH_CURRENT = state.character_4_healthCurrent 
	Data.CHARACTER_4_HEALTH_GROWTH = state.character_4_healthGrowth 
	Data.CHARACTER_4_MAGIC_MAX = state.character_4_magicMax 
	Data.CHARACTER_4_MAGIC_CURRENT = state.character_4_magicCurrent 
	Data.CHARACTER_4_MAGIC_GROWTH = state.character_4_magicGrowth 
	Data.CHARACTER_4_LV = state.character_4_lv
	Data.CHARACTER_4_XP = state.character_4_xp
	Data.CHARACTER_4_NEXT = state.character_4_next
	Data.CHARACTER_4_STRENGTH = state.character_4_strength
	Data.CHARACTER_4_AGILITY = state.character_4_agility
	Data.CHARACTER_4_INTELLIGENCE = state.character_4_intelligence
	Data.CHARACTER_4_LUCK = state.character_4_luck
	Data.CHARACTER_4_EQUIPABLE = state.character_4_equipable
	Data.CHARACTER_4_RULES = state.character_4_rules
	Data.CHARACTER_4_WEAPON = state.character_4_weapon 
	Data.CHARACTER_4_ARMOR = state.character_4_armor
	Data.CHARACTER_4_ACCESSORY = state.character_4_accessory
	Data.CHARACTER_4_ACTIONS = state.character_4_actions

func getState() -> Dictionary:
	return {
		"version":1.0,
		"mapOpenedTreasures": Data.MAP_OPENED_TREASURES,
		"mapOpenedDooors": Data.MAP_OPENED_DOORS,
		"partySkills": Data.PARTY_SKILLS,
		"partyCurrentRoom": Data.PARTY_CURRENT_ROOM,
		"partyX": Data.PARTY_X,
		"partyY": Data.PARTY_Y,
		"partyCrowns": Data.PARTY_CROWNS,
		"partyItems": Data.PARTY_ITEMS,
		"character_1_type": Data.CHARACTER_1_TYPE,
		"character_1_name": Data.CHARACTER_1_NAME,
		"character_1_healthMax": Data.CHARACTER_1_HEALTH_MAX,
		"character_1_healthCurrent": Data.CHARACTER_1_HEALTH_CURRENT,
		"character_1_healthGrowth": Data.CHARACTER_1_HEALTH_GROWTH,
		"character_1_magicMax": Data.CHARACTER_1_MAGIC_MAX,
		"character_1_magicCurrent": Data.CHARACTER_1_MAGIC_CURRENT,
		"character_1_magicGrowth": Data.CHARACTER_1_MAGIC_GROWTH,
		"character_1_lv":Data.CHARACTER_1_LV,
		"character_1_xp":Data.CHARACTER_1_XP,
		"character_1_next":Data.CHARACTER_1_NEXT,
		"character_1_strength":Data.CHARACTER_1_STRENGTH,
		"character_1_agility":Data.CHARACTER_1_AGILITY,
		"character_1_intelligence":Data.CHARACTER_1_INTELLIGENCE,
		"character_1_luck":Data.CHARACTER_1_LUCK,
		"character_1_equipable":Data.CHARACTER_1_EQUIPABLE,
		"character_1_rules":Data.CHARACTER_1_RULES,
		"character_1_weapon": Data.CHARACTER_1_WEAPON,
		"character_1_armor":Data.CHARACTER_1_ARMOR,
		"character_1_accessory":Data.CHARACTER_1_ACCESSORY,
		"character_1_actions":Data.CHARACTER_1_ACTIONS,
		"character_2_type": Data.CHARACTER_2_TYPE,
		"character_2_name": Data.CHARACTER_2_NAME,
		"character_2_healthMax": Data.CHARACTER_2_HEALTH_MAX,
		"character_2_healthCurrent": Data.CHARACTER_2_HEALTH_CURRENT,
		"character_2_healthGrowth": Data.CHARACTER_2_HEALTH_GROWTH,
		"character_2_magicMax": Data.CHARACTER_2_MAGIC_MAX,
		"character_2_magicCurrent": Data.CHARACTER_2_MAGIC_CURRENT,
		"character_2_magicGrowth": Data.CHARACTER_2_MAGIC_GROWTH,
		"character_2_lv":Data.CHARACTER_2_LV,
		"character_2_xp":Data.CHARACTER_2_XP,
		"character_2_next":Data.CHARACTER_2_NEXT,
		"character_2_strength":Data.CHARACTER_2_STRENGTH,
		"character_2_agility":Data.CHARACTER_2_AGILITY,
		"character_2_intelligence":Data.CHARACTER_2_INTELLIGENCE,
		"character_2_luck":Data.CHARACTER_2_LUCK,
		"character_2_equipable":Data.CHARACTER_2_EQUIPABLE,
		"character_2_rules":Data.CHARACTER_2_RULES,
		"character_2_weapon": Data.CHARACTER_2_WEAPON,
		"character_2_armor":Data.CHARACTER_2_ARMOR,
		"character_2_accessory":Data.CHARACTER_2_ACCESSORY,
		"character_2_actions":Data.CHARACTER_2_ACTIONS,
		"character_3_type": Data.CHARACTER_3_TYPE,
		"character_3_name": Data.CHARACTER_3_NAME,
		"character_3_healthMax": Data.CHARACTER_3_HEALTH_MAX,
		"character_3_healthCurrent": Data.CHARACTER_3_HEALTH_CURRENT,
		"character_3_healthGrowth": Data.CHARACTER_3_HEALTH_GROWTH,
		"character_3_magicMax": Data.CHARACTER_3_MAGIC_MAX,
		"character_3_magicCurrent": Data.CHARACTER_3_MAGIC_CURRENT,
		"character_3_magicGrowth": Data.CHARACTER_3_MAGIC_GROWTH,
		"character_3_lv":Data.CHARACTER_3_LV,
		"character_3_xp":Data.CHARACTER_3_XP,
		"character_3_next":Data.CHARACTER_3_NEXT,
		"character_3_strength":Data.CHARACTER_3_STRENGTH,
		"character_3_agility":Data.CHARACTER_3_AGILITY,
		"character_3_intelligence":Data.CHARACTER_3_INTELLIGENCE,
		"character_3_luck":Data.CHARACTER_3_LUCK,
		"character_3_equipable":Data.CHARACTER_3_EQUIPABLE,
		"character_3_rules":Data.CHARACTER_3_RULES,
		"character_3_weapon": Data.CHARACTER_3_WEAPON,
		"character_3_armor":Data.CHARACTER_3_ARMOR,
		"character_3_accessory":Data.CHARACTER_3_ACCESSORY,
		"character_3_actions":Data.CHARACTER_3_ACTIONS,
		"character_4_type": Data.CHARACTER_4_TYPE,
		"character_4_name": Data.CHARACTER_4_NAME,
		"character_4_healthMax": Data.CHARACTER_4_HEALTH_MAX,
		"character_4_healthCurrent": Data.CHARACTER_4_HEALTH_CURRENT,
		"character_4_healthGrowth": Data.CHARACTER_4_HEALTH_GROWTH,
		"character_4_magicMax": Data.CHARACTER_4_MAGIC_MAX,
		"character_4_magicCurrent": Data.CHARACTER_4_MAGIC_CURRENT,
		"character_4_magicGrowth": Data.CHARACTER_4_MAGIC_GROWTH,
		"character_4_lv":Data.CHARACTER_4_LV,
		"character_4_xp":Data.CHARACTER_4_XP,
		"character_4_next":Data.CHARACTER_4_NEXT,
		"character_4_strength":Data.CHARACTER_4_STRENGTH,
		"character_4_agility":Data.CHARACTER_4_AGILITY,
		"character_4_intelligence":Data.CHARACTER_4_INTELLIGENCE,
		"character_4_luck":Data.CHARACTER_4_LUCK,
		"character_4_equipable":Data.CHARACTER_4_EQUIPABLE,
		"character_4_rules":Data.CHARACTER_4_RULES,
		"character_4_weapon": Data.CHARACTER_4_WEAPON,
		"character_4_armor":Data.CHARACTER_4_ARMOR,
		"character_4_accessory":Data.CHARACTER_4_ACCESSORY,
		"character_4_actions":Data.CHARACTER_4_ACTIONS
	}


func saveSlot(saveSlot: Enums.SAVE_SLOTS) -> void:
	var path = ""
	if saveSlot == Enums.SAVE_SLOTS.SLOT1:
		path = str("user://" + Statics.SAVE_FILE_SLOT_1_PATH + ".save")
	elif saveSlot == Enums.SAVE_SLOTS.SLOT2:
		path = str("user://" + Statics.SAVE_FILE_SLOT_2_PATH + ".save")
	elif saveSlot == Enums.SAVE_SLOTS.SLOT3:
		path = str("user://" + Statics.SAVE_FILE_SLOT_3_PATH + ".save")
		
	if checkCreateDirectory(path):
		var file = FileAccess.open(path, FileAccess.WRITE)
		var saveData:Dictionary = getState()
		var jsonString:String = JSON.stringify(saveData)
		file.store_string(jsonString)
		file.close()
#		file.store_var(Data.CHARACTER_1_TYPE)
#		file.store_string(Data.CHARACTER_1_NAME)
#		file.store_var(Data.CHARACTER_1_HEALTH_CURRENT)
#		file.store_var(Data.CHARACTER_1_HEALTH_MAX)
#		file.store_var(Data.CHARACTER_1_LV)
#		file.store_var(Data.CHARACTER_1_XP)
#		file.store_var(Data.CHARACTER_1_MAGIC_CURRENT)
#		file.store_var(Data.CHARACTER_1_MAGIC_MAX)
#		file.store_var(Data.CHARACTER_1_STRENGTH)
#		file.store_var(Data.CHARACTER_1_AGILITY)
#		file.store_var(Data.CHARACTER_1_INTELLIGENCE)
#		file.store_var(Data.CHARACTER_1_LUCK)
#		file.store_var(Data.CHARACTER_1_RULES)
#		file.store_string(JSON.stringify(Data.CHARACTER_1_WEAPON))
#		file.store_string(JSON.stringify(Data.CHARACTER_1_ARMOR))
#		file.store_string(JSON.stringify(Data.CHARACTER_1_ACCESSORY))
#		file.store_var(Data.CHARACTER_1_XP_NEXT)
#
#
#		file.store_var(Data.CHARACTER_2_TYPE)
#		file.store_string(Data.CHARACTER_2_NAME)
#		file.store_var(Data.CHARACTER_2_HEALTH_CURRENT)
#		file.store_var(Data.CHARACTER_2_HEALTH_MAX)
#		file.store_var(Data.CHARACTER_2_LV)
#		file.store_var(Data.CHARACTER_2_XP)
#		file.store_var(Data.CHARACTER_2_MAGIC_CURRENT)
#		file.store_var(Data.CHARACTER_2_MAGIC_MAX)
#		file.store_var(Data.CHARACTER_2_STRENGTH)
#		file.store_var(Data.CHARACTER_2_AGILITY)
#		file.store_var(Data.CHARACTER_2_INTELLIGENCE)
#		file.store_var(Data.CHARACTER_2_LUCK)
#		file.store_var(Data.CHARACTER_2_RULES)
#		file.store_var(Data.CHARACTER_2_WEAPON)
#		file.store_var(Data.CHARACTER_2_ARMOR)
#		file.store_var(Data.CHARACTER_2_ACCESSORY)
#		file.store_var(Data.CHARACTER_2_XP_NEXT)
#
#
#		file.store_var(Data.CHARACTER_3_TYPE)
#		file.store_string(Data.CHARACTER_3_NAME)
#		file.store_var(Data.CHARACTER_3_HEALTH_CURRENT)
#		file.store_var(Data.CHARACTER_3_HEALTH_MAX)
#		file.store_var(Data.CHARACTER_3_LV)
#		file.store_var(Data.CHARACTER_3_XP)
#		file.store_var(Data.CHARACTER_3_MAGIC_CURRENT)
#		file.store_var(Data.CHARACTER_3_MAGIC_MAX)
#		file.store_var(Data.CHARACTER_3_STRENGTH)
#		file.store_var(Data.CHARACTER_3_AGILITY)
#		file.store_var(Data.CHARACTER_3_INTELLIGENCE)
#		file.store_var(Data.CHARACTER_3_LUCK)
#		file.store_var(Data.CHARACTER_3_RULES)
#		file.store_var(Data.CHARACTER_3_WEAPON)
#		file.store_var(Data.CHARACTER_3_ARMOR)
#		file.store_var(Data.CHARACTER_3_ACCESSORY)
#		file.store_var(Data.CHARACTER_3_XP_NEXT)
#
#		file.store_var(Data.CHARACTER_4_TYPE)
#		file.store_string(Data.CHARACTER_4_NAME)
#		file.store_var(Data.CHARACTER_4_HEALTH_CURRENT)
#		file.store_var(Data.CHARACTER_4_HEALTH_MAX)
#		file.store_var(Data.CHARACTER_4_LV)
#		file.store_var(Data.CHARACTER_4_XP)
#		file.store_var(Data.CHARACTER_4_MAGIC_CURRENT)
#		file.store_var(Data.CHARACTER_4_MAGIC_MAX)
#		file.store_var(Data.CHARACTER_4_STRENGTH)
#		file.store_var(Data.CHARACTER_4_AGILITY)
#		file.store_var(Data.CHARACTER_4_INTELLIGENCE)
#		file.store_var(Data.CHARACTER_4_LUCK)
#		file.store_var(Data.CHARACTER_4_RULES)
#		file.store_var(Data.CHARACTER_4_WEAPON)
#		file.store_var(Data.CHARACTER_4_ARMOR)
#		file.store_var(Data.CHARACTER_4_ACCESSORY)
#		file.store_var(Data.CHARACTER_4_XP_NEXT)
	
func fileExists(path:String) -> bool:
	if FileAccess.file_exists(path):
		return true
	return false
	
func loadSlot() -> void:
	var json = JSON.new()
	
	if fileExists(Statics.SAVE_FILE_SLOT_1_PATH):
		var file = FileAccess.open(Statics.SAVE_FILE_SLOT_1_PATH, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		var data:Dictionary = JSON.parse_string(content) #.result
		setState(data)
		
#		Data.CHARACTER_1_TYPE = file.get_var(Data.CHARACTER_1_TYPE)
#		Data.CHARACTER_1_NAME = file.get_string(Data.CHARACTER_1_NAME)
#		Data.CHARACTER_1_HEALTH_CURRENT = file.get_var(Data.CHARACTER_1_HEALTH_CURRENT)
#		Data.CHARACTER_1_HEALTH_MAX = file.get_var(Data.CHARACTER_1_HEALTH_MAX)
#		Data.CHARACTER_1_MAGIC_CURRENT = file.get_var(Data.CHARACTER_1_MAGIC_CURRENT)
#		Data.CHARACTER_1_MAGIC_MAX = file.get_var(Data.CHARACTER_1_MAGIC_MAX)
#		Data.CHARACTER_1_LV = file.get_var(Data.CHARACTER_1_LV)
#		Data.CHARACTER_1_XP = file.get_var(Data.CHARACTER_1_XP)
#		Data.CHARACTER_1_STRENGTH = file.get_var(Data.CHARACTER_1_STRENGTH)
#		Data.CHARACTER_1_AGILITY = file.get_var(Data.CHARACTER_1_AGILITY)
#		Data.CHARACTER_1_INTELLIGENCE = file.get_var(Data.CHARACTER_1_INTELLIGENCE)
#		Data.CHARACTER_1_LUCK = file.get_var(Data.CHARACTER_1_LUCK)
#		##Data.CHARACTER_1_RULES = file.get_var(Data.CHARACTER_1_RULES)
##		Data.CHARACTER_1_WEAPON = file.get_var(json.parse(Data.CHARACTER_1_WEAPON))
#		#Data.CHARACTER_1_ARMOR = file.get_var(json.parse(Data.CHARACTER_1_ARMOR))
#		#Data.CHARACTER_1_ACCESSORY = file.get_var(json.parse(Data.CHARACTER_1_ACCESSORY))
#
#		Data.CHARACTER_1_XP_NEXT = file.get_var(Data.CHARACTER_1_XP_NEXT)
#		Data.CHARACTER_2_TYPE = file.get_var(Data.CHARACTER_2_TYPE)
#		Data.CHARACTER_2_NAME = file.get_string(Data.CHARACTER_2_NAME)
#		Data.CHARACTER_2_HEALTH_CURRENT = file.get_var(Data.CHARACTER_2_HEALTH_CURRENT)
#		Data.CHARACTER_2_HEALTH_MAX = file.get_var(Data.CHARACTER_2_HEALTH_MAX)
#		Data.CHARACTER_2_LV = file.get_var(Data.CHARACTER_2_LV)
#		Data.CHARACTER_2_XP = file.get_var(Data.CHARACTER_2_XP)
#		Data.CHARACTER_2_MAGIC_CURRENT = file.get_var(Data.CHARACTER_2_MAGIC_CURRENT)
#		Data.CHARACTER_2_MAGIC_MAX = file.get_var(Data.CHARACTER_2_MAGIC_MAX)
#		Data.CHARACTER_2_STRENGTH = file.get_var(Data.CHARACTER_2_STRENGTH)
#		Data.CHARACTER_2_AGILITY = file.get_var(Data.CHARACTER_2_AGILITY)
#		Data.CHARACTER_2_INTELLIGENCE = file.get_var(Data.CHARACTER_2_INTELLIGENCE)
#		Data.CHARACTER_2_LUCK = file.get_var(Data.CHARACTER_2_LUCK)
#		Data.CHARACTER_3_TYPE = file.get_var(Data.CHARACTER_3_TYPE)
#		Data.CHARACTER_3_NAME = file.get_string(Data.CHARACTER_3_NAME)
#		Data.CHARACTER_3_HEALTH_CURRENT = file.get_var(Data.CHARACTER_3_HEALTH_CURRENT)
#		Data.CHARACTER_3_HEALTH_MAX = file.get_var(Data.CHARACTER_3_HEALTH_MAX)
#		Data.CHARACTER_3_MAGIC_CURRENT = file.get_var(Data.CHARACTER_3_MAGIC_CURRENT)
#		Data.CHARACTER_3_MAGIC_MAX = file.get_var(Data.CHARACTER_3_MAGIC_MAX)
#		Data.CHARACTER_3_LV = file.get_var(Data.CHARACTER_3_LV)
#		Data.CHARACTER_3_XP = file.get_var(Data.CHARACTER_3_XP)
#		Data.CHARACTER_3_STRENGTH = file.get_var(Data.CHARACTER_3_STRENGTH)
#		Data.CHARACTER_3_AGILITY = file.get_var(Data.CHARACTER_3_AGILITY)
#		Data.CHARACTER_3_INTELLIGENCE = file.get_var(Data.CHARACTER_3_INTELLIGENCE)
#		Data.CHARACTER_3_LUCK = file.get_var(Data.CHARACTER_3_LUCK)
#		Data.CHARACTER_4_TYPE = file.get_var(Data.CHARACTER_4_TYPE)
#		Data.CHARACTER_4_NAME = file.get_string(Data.CHARACTER_4_NAME)
#		Data.CHARACTER_4_HEALTH_CURRENT = file.get_var(Data.CHARACTER_4_HEALTH_CURRENT)
#		Data.CHARACTER_4_HEALTH_MAX = file.get_var(Data.CHARACTER_4_HEALTH_MAX)
#		Data.CHARACTER_4_MAGIC_CURRENT = file.get_var(Data.CHARACTER_4_MAGIC_CURRENT)
#		Data.CHARACTER_4_MAGIC_MAX = file.get_var(Data.CHARACTER_4_MAGIC_MAX)
#		Data.CHARACTER_4_LV = file.get_var(Data.CHARACTER_4_LV)
#		Data.CHARACTER_4_XP = file.get_var(Data.CHARACTER_4_XP)
#		Data.CHARACTER_4_STRENGTH = file.get_var(Data.CHARACTER_4_STRENGTH)
#		Data.CHARACTER_4_AGILITY = file.get_var(Data.CHARACTER_4_AGILITY)
#		Data.CHARACTER_4_INTELLIGENCE = file.get_var(Data.CHARACTER_4_INTELLIGENCE)
#		Data.CHARACTER_4_LUCK = file.get_var(Data.CHARACTER_4_LUCK)
