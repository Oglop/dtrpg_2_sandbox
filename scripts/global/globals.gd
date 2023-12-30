extends Node

var rng = RandomNumberGenerator.new()
var PARTY_SIZE:int = 6
var X_POSITIONS:Array = [0,0,0,0,0,0,0,0]
var Y_POSITIONS:Array = [0,0,0,0,0,0,0,0]


func chance(test:int) -> bool:
	var i:int = rng.randi_range(1, 100)
	if i <= test:
		return true
	return false
	
func isVowel(value:String) -> bool:
	#A, E, I, O, U, and sometimes W and Y
	var capitalized = value.capitalize()
	if capitalized.begins_with("A") || capitalized.begins_with("E") || capitalized.begins_with("I") || capitalized.begins_with("O") || capitalized.begins_with("U") || capitalized.begins_with("Y"):
		return true
	return false
