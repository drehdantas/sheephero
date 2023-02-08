extends Control

onready var healingSound = $VBoxContainer/HBoxContainer/Option1/AudioStreamPlayer2D
onready var powerUpSound = $VBoxContainer/HBoxContainer/Option2/AudioStreamPlayer2D

func _on_Option1_pressed():
	healingSound.play()
	visible = false

func _on_Option2_pressed():
	powerUpSound.play()
	visible = false

func _on_Option3_pressed():
	powerUpSound.play()
	visible = false
