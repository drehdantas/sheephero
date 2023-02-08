extends Control

var playerStats = PlayerStats
var score = SilentWolf.Scores

onready var boardlist = $ScrollContainer/LeaderBoardContainer/Control/ItemList

func _ready():
	get_high_scores()
	
func get_high_scores():	
	score =  yield(SilentWolf.Scores.get_high_scores(0), "sw_scores_received")
	var scores = SilentWolf.Scores.scores

	print(str(scores.size()))
#	var id = 0
	for score in scores:
		var name = str(score.score) + " - " + str(score.player_name)
		boardlist.add_item(name, null, true)
#		boardlist.set_item_text(id, str(score.player_name))
#		id += 1
	
func _on_BackButton_pressed():
	playerStats._ready()
	get_tree().paused = false
	get_tree().change_scene("res://UI/TitleScreen.tscn")
