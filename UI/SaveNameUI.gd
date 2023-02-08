extends Control

onready var lineEdit = $VBoxContainer/LineEdit

export(int) var LIMIT = 15
var current_text = ''
var cursor_line = 0
var cursor_column = 0

func _on_SaveButton_pressed():
	SilentWolf.Scores.persist_score(lineEdit.text, PlayerStats.get_player_score())
	var score =  yield(SilentWolf.Scores.get_high_scores(0), "sw_scores_received")
	get_tree().change_scene("res://UI/LeaderBoardUI.tscn")

func _ready():
	lineEdit.grab_focus()
	lineEdit.set_cursor_position(len(lineEdit.text))


func _on_LineEdit_text_changed(new_text):
	if new_text.length() > LIMIT:
		lineEdit.text = current_text
		lineEdit.set_cursor_position(len(lineEdit.text))

	current_text = lineEdit.text
