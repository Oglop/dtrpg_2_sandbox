extends Node

func _ready():
	pass # Replace with function body.
	
# Save map
func saveMap(map: Array, name: String) -> void:
	var path = "data://" + name + ".save"
	if !fileExists(Statics.SAVE_FILE_SLOT_1_PATH):
		var file = FileAccess.open(path, FileAccess.WRITE)

func saveSlot(saveSlot: Enums.SAVE_SLOTS) -> void:
	var path = ""
	if saveSlot == Enums.SAVE_SLOTS.SLOT1:
		path = Statics.SAVE_FILE_SLOT_1_PATH
	elif saveSlot == Enums.SAVE_SLOTS.SLOT2:
		path = Statics.SAVE_FILE_SLOT_2_PATH
	elif saveSlot == Enums.SAVE_SLOTS.SLOT3:
		path = Statics.SAVE_FILE_SLOT_3_PATH
		
	var file = FileAccess.open(path, FileAccess.WRITE)
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
	
	
func fileExists(path:String) -> bool:
	if FileAccess.file_exists(path):
		return true
	return false
	
func loadSlot() -> void:
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
