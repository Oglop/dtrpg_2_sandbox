extends Node

func _ready():
	pass # Replace with function body.
	
func checkCreateDirectory(path:String) -> bool:
	
	return true
# Save map
func saveMap(map: Array, name: String) -> void:
	var path = "user://" + name + ".save"
	if !fileExists(Statics.SAVE_FILE_SLOT_1_PATH):
		var file = FileAccess.open(path, FileAccess.WRITE)

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
		
		file.store_var(Data)
		
		
		file.store_var(Data.CHARACTER_1_TYPE)
		file.store_string(Data.CHARACTER_1_NAME)
		file.store_var(Data.CHARACTER_1_HEALTH_CURRENT)
		file.store_var(Data.CHARACTER_1_HEALTH_MAX)
		file.store_var(Data.CHARACTER_1_LV)
		file.store_var(Data.CHARACTER_1_XP)
		file.store_var(Data.CHARACTER_1_MAGIC_CURRENT)
		file.store_var(Data.CHARACTER_1_MAGIC_MAX)
		file.store_var(Data.CHARACTER_1_STRENGTH)
		file.store_var(Data.CHARACTER_1_AGILITY)
		file.store_var(Data.CHARACTER_1_INTELLIGENCE)
		file.store_var(Data.CHARACTER_1_LUCK)
		file.store_var(Data.CHARACTER_1_RULES)
		file.store_string(JSON.stringify(Data.CHARACTER_1_WEAPON))
		file.store_string(JSON.stringify(Data.CHARACTER_1_ARMOR))
		file.store_string(JSON.stringify(Data.CHARACTER_1_ACCESSORY))
		file.store_var(Data.CHARACTER_1_XP_NEXT)
		
		
		file.store_var(Data.CHARACTER_2_TYPE)
		file.store_string(Data.CHARACTER_2_NAME)
		file.store_var(Data.CHARACTER_2_HEALTH_CURRENT)
		file.store_var(Data.CHARACTER_2_HEALTH_MAX)
		file.store_var(Data.CHARACTER_2_LV)
		file.store_var(Data.CHARACTER_2_XP)
		file.store_var(Data.CHARACTER_2_MAGIC_CURRENT)
		file.store_var(Data.CHARACTER_2_MAGIC_MAX)
		file.store_var(Data.CHARACTER_2_STRENGTH)
		file.store_var(Data.CHARACTER_2_AGILITY)
		file.store_var(Data.CHARACTER_2_INTELLIGENCE)
		file.store_var(Data.CHARACTER_2_LUCK)
		file.store_var(Data.CHARACTER_2_RULES)
		file.store_var(Data.CHARACTER_2_WEAPON)
		file.store_var(Data.CHARACTER_2_ARMOR)
		file.store_var(Data.CHARACTER_2_ACCESSORY)
		file.store_var(Data.CHARACTER_2_XP_NEXT)
		
		
		file.store_var(Data.CHARACTER_3_TYPE)
		file.store_string(Data.CHARACTER_3_NAME)
		file.store_var(Data.CHARACTER_3_HEALTH_CURRENT)
		file.store_var(Data.CHARACTER_3_HEALTH_MAX)
		file.store_var(Data.CHARACTER_3_LV)
		file.store_var(Data.CHARACTER_3_XP)
		file.store_var(Data.CHARACTER_3_MAGIC_CURRENT)
		file.store_var(Data.CHARACTER_3_MAGIC_MAX)
		file.store_var(Data.CHARACTER_3_STRENGTH)
		file.store_var(Data.CHARACTER_3_AGILITY)
		file.store_var(Data.CHARACTER_3_INTELLIGENCE)
		file.store_var(Data.CHARACTER_3_LUCK)
		file.store_var(Data.CHARACTER_3_RULES)
		file.store_var(Data.CHARACTER_3_WEAPON)
		file.store_var(Data.CHARACTER_3_ARMOR)
		file.store_var(Data.CHARACTER_3_ACCESSORY)
		file.store_var(Data.CHARACTER_3_XP_NEXT)
		
		file.store_var(Data.CHARACTER_4_TYPE)
		file.store_string(Data.CHARACTER_4_NAME)
		file.store_var(Data.CHARACTER_4_HEALTH_CURRENT)
		file.store_var(Data.CHARACTER_4_HEALTH_MAX)
		file.store_var(Data.CHARACTER_4_LV)
		file.store_var(Data.CHARACTER_4_XP)
		file.store_var(Data.CHARACTER_4_MAGIC_CURRENT)
		file.store_var(Data.CHARACTER_4_MAGIC_MAX)
		file.store_var(Data.CHARACTER_4_STRENGTH)
		file.store_var(Data.CHARACTER_4_AGILITY)
		file.store_var(Data.CHARACTER_4_INTELLIGENCE)
		file.store_var(Data.CHARACTER_4_LUCK)
		file.store_var(Data.CHARACTER_4_RULES)
		file.store_var(Data.CHARACTER_4_WEAPON)
		file.store_var(Data.CHARACTER_4_ARMOR)
		file.store_var(Data.CHARACTER_4_ACCESSORY)
		file.store_var(Data.CHARACTER_4_XP_NEXT)
	
func fileExists(path:String) -> bool:
	if FileAccess.file_exists(path):
		return true
	return false
	
func loadSlot() -> void:
	var json = JSON.new()
	
	if fileExists(Statics.SAVE_FILE_SLOT_1_PATH):
		var file = FileAccess.open(Statics.SAVE_FILE_SLOT_1_PATH, FileAccess.READ)
		Data.CHARACTER_1_TYPE = file.get_var(Data.CHARACTER_1_TYPE)
		Data.CHARACTER_1_NAME = file.get_string(Data.CHARACTER_1_NAME)
		Data.CHARACTER_1_HEALTH_CURRENT = file.get_var(Data.CHARACTER_1_HEALTH_CURRENT)
		Data.CHARACTER_1_HEALTH_MAX = file.get_var(Data.CHARACTER_1_HEALTH_MAX)
		Data.CHARACTER_1_MAGIC_CURRENT = file.get_var(Data.CHARACTER_1_MAGIC_CURRENT)
		Data.CHARACTER_1_MAGIC_MAX = file.get_var(Data.CHARACTER_1_MAGIC_MAX)
		Data.CHARACTER_1_LV = file.get_var(Data.CHARACTER_1_LV)
		Data.CHARACTER_1_XP = file.get_var(Data.CHARACTER_1_XP)
		Data.CHARACTER_1_STRENGTH = file.get_var(Data.CHARACTER_1_STRENGTH)
		Data.CHARACTER_1_AGILITY = file.get_var(Data.CHARACTER_1_AGILITY)
		Data.CHARACTER_1_INTELLIGENCE = file.get_var(Data.CHARACTER_1_INTELLIGENCE)
		Data.CHARACTER_1_LUCK = file.get_var(Data.CHARACTER_1_LUCK)
		##Data.CHARACTER_1_RULES = file.get_var(Data.CHARACTER_1_RULES)
		#Data.CHARACTER_1_WEAPON = file.get_var(json.parse(Data.CHARACTER_1_WEAPON))
		#Data.CHARACTER_1_ARMOR = file.get_var(json.parse(Data.CHARACTER_1_ARMOR))
		#Data.CHARACTER_1_ACCESSORY = file.get_var(json.parse(Data.CHARACTER_1_ACCESSORY))
		
		Data.CHARACTER_1_XP_NEXT = file.get_var(Data.CHARACTER_1_XP_NEXT)
		Data.CHARACTER_2_TYPE = file.get_var(Data.CHARACTER_2_TYPE)
		Data.CHARACTER_2_NAME = file.get_string(Data.CHARACTER_2_NAME)
		Data.CHARACTER_2_HEALTH_CURRENT = file.get_var(Data.CHARACTER_2_HEALTH_CURRENT)
		Data.CHARACTER_2_HEALTH_MAX = file.get_var(Data.CHARACTER_2_HEALTH_MAX)
		Data.CHARACTER_2_LV = file.get_var(Data.CHARACTER_2_LV)
		Data.CHARACTER_2_XP = file.get_var(Data.CHARACTER_2_XP)
		Data.CHARACTER_2_MAGIC_CURRENT = file.get_var(Data.CHARACTER_2_MAGIC_CURRENT)
		Data.CHARACTER_2_MAGIC_MAX = file.get_var(Data.CHARACTER_2_MAGIC_MAX)
		Data.CHARACTER_2_STRENGTH = file.get_var(Data.CHARACTER_2_STRENGTH)
		Data.CHARACTER_2_AGILITY = file.get_var(Data.CHARACTER_2_AGILITY)
		Data.CHARACTER_2_INTELLIGENCE = file.get_var(Data.CHARACTER_2_INTELLIGENCE)
		Data.CHARACTER_2_LUCK = file.get_var(Data.CHARACTER_2_LUCK)
		Data.CHARACTER_3_TYPE = file.get_var(Data.CHARACTER_3_TYPE)
		Data.CHARACTER_3_NAME = file.get_string(Data.CHARACTER_3_NAME)
		Data.CHARACTER_3_HEALTH_CURRENT = file.get_var(Data.CHARACTER_3_HEALTH_CURRENT)
		Data.CHARACTER_3_HEALTH_MAX = file.get_var(Data.CHARACTER_3_HEALTH_MAX)
		Data.CHARACTER_3_MAGIC_CURRENT = file.get_var(Data.CHARACTER_3_MAGIC_CURRENT)
		Data.CHARACTER_3_MAGIC_MAX = file.get_var(Data.CHARACTER_3_MAGIC_MAX)
		Data.CHARACTER_3_LV = file.get_var(Data.CHARACTER_3_LV)
		Data.CHARACTER_3_XP = file.get_var(Data.CHARACTER_3_XP)
		Data.CHARACTER_3_STRENGTH = file.get_var(Data.CHARACTER_3_STRENGTH)
		Data.CHARACTER_3_AGILITY = file.get_var(Data.CHARACTER_3_AGILITY)
		Data.CHARACTER_3_INTELLIGENCE = file.get_var(Data.CHARACTER_3_INTELLIGENCE)
		Data.CHARACTER_3_LUCK = file.get_var(Data.CHARACTER_3_LUCK)
		Data.CHARACTER_4_TYPE = file.get_var(Data.CHARACTER_4_TYPE)
		Data.CHARACTER_4_NAME = file.get_string(Data.CHARACTER_4_NAME)
		Data.CHARACTER_4_HEALTH_CURRENT = file.get_var(Data.CHARACTER_4_HEALTH_CURRENT)
		Data.CHARACTER_4_HEALTH_MAX = file.get_var(Data.CHARACTER_4_HEALTH_MAX)
		Data.CHARACTER_4_MAGIC_CURRENT = file.get_var(Data.CHARACTER_4_MAGIC_CURRENT)
		Data.CHARACTER_4_MAGIC_MAX = file.get_var(Data.CHARACTER_4_MAGIC_MAX)
		Data.CHARACTER_4_LV = file.get_var(Data.CHARACTER_4_LV)
		Data.CHARACTER_4_XP = file.get_var(Data.CHARACTER_4_XP)
		Data.CHARACTER_4_STRENGTH = file.get_var(Data.CHARACTER_4_STRENGTH)
		Data.CHARACTER_4_AGILITY = file.get_var(Data.CHARACTER_4_AGILITY)
		Data.CHARACTER_4_INTELLIGENCE = file.get_var(Data.CHARACTER_4_INTELLIGENCE)
		Data.CHARACTER_4_LUCK = file.get_var(Data.CHARACTER_4_LUCK)
