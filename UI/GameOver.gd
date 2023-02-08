extends Control

var playerStats = PlayerStats
onready var scoreText = $VBoxContainer/VBoxContainer/Score

func _ready():
	visible = false

func game_over():
	scoreText.set_text(str(playerStats.get_player_score()))
	visible = true

func _on_RestartButton_pressed():
	playerStats._ready()
	PlayerStats.set_wavelevel(1)
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_QuitButton_pressed():
	playerStats._ready()
	get_tree().paused = false
	get_tree().change_scene("res://UI/TitleScreen.tscn")

func _on_LeaderboardButton_pressed():
	get_tree().change_scene("res://UI/SaveNameUI.tscn")
