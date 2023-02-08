extends Node

class_name GlobalSingleton

var player_name = "zebunda" setget set_player_name, get_player_name
var total_score = 200 setget set_total_score, get_total_score

func _ready():
	SilentWolf.configure({
		"api_key": "LgnriQUfK97OQWRGyx8P5wzhppLzYRi8lS63M3ne",
		"game_id": "TheSheepHeroSurvives",
		"game_version": "1.0.2",
		"log_level": 0
	})

	SilentWolf.configure_scores({
		"open_scene_on_close": "res://World/Phases/Phase1.tscn"
	})
	pass # Replace with function body.
	
func set_player_name(value):
	player_name = value
	
func set_total_score(value):
	total_score = value
	
func get_player_name():
	return player_name
	
func get_total_score():
	return total_score
	
