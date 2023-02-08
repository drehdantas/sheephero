extends Node2D

onready var gameOver = $CanvasLayer/GameOver

func _process(delta):
	if PlayerStats.health <= 0:
		gameOver.game_over()
