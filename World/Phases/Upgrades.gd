extends Node2D

signal change_max_health
signal default_signal_start_wave

func _on_Option1_pressed():
	PlayerStats.health = PlayerStats.max_health
	emit_signal("default_signal_start_wave")

func _on_Option2_pressed():
	PlayerStats.set_max_health(PlayerStats.max_health + 1)
	emit_signal("change_max_health")

func _on_Option3_pressed():
	PlayerStats.set_max_speed(PlayerStats.max_speed + 4)
	emit_signal("default_signal_start_wave")
