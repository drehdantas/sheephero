extends Control

var playerStats = PlayerStats 

func _ready():
	verify_sound_status()
	visible = false

func _input(event):
	if event.is_action_pressed("pause") && playerStats.health > 0:
		var newPauseState = not get_tree().paused
		get_tree().paused = newPauseState
		visible = newPauseState

func _on_ResumeButton_pressed():
	visible = false
	get_tree().paused = false

func _on_RestartButton_pressed():
	playerStats._ready()
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_QuitButton_pressed():
	playerStats._ready()
	get_tree().paused = false
	get_tree().change_scene("res://UI/TitleScreen.tscn")

func _on_SongButton_pressed():
	var master_sound = AudioServer.get_bus_index("Master")
	if AudioServer.is_bus_mute(master_sound):
		AudioServer.set_bus_mute(master_sound, false)
		$VBoxContainer/SongButton/VolumeBorderIcon.visible = true
		PlayerStats.set_volume_status(false) 
	else:
		AudioServer.set_bus_mute(master_sound, true)
		$VBoxContainer/SongButton/VolumeBorderIcon.visible = false	
		PlayerStats.set_volume_status(true) 
		
func verify_sound_status():
	var master_sound = AudioServer.get_bus_index("Master")
	if playerStats.get_volume_status() and AudioServer.is_bus_mute(master_sound):
		AudioServer.set_bus_mute(master_sound, true)
		$VBoxContainer/SongButton/VolumeBorderIcon.visible = false	
	else:
		AudioServer.set_bus_mute(master_sound, false)
		$VBoxContainer/SongButton/VolumeBorderIcon.visible = true

