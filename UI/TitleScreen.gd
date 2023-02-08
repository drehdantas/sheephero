extends Control

onready var newGameButton = $Menu/Buttons/NewGameButton
onready var fadeInEffect = $FadeIn

var sceneToLoad
var playerStats = PlayerStats 

# Called when the node enters the scene tree for the first time.
func _ready():
	verify_sound_status()
	newGameButton.connect("pressed", self, "_on_NewGameButton_pressed")

func _on_NewGameButton_pressed():
	sceneToLoad = "res://World/Phases/Phase1.tscn"
	fadeInEffect.show()
	fadeInEffect.fadeIn()

func _on_FadeIn_fadeFinished():
	get_tree().change_scene(sceneToLoad)

func _on_LeaderBoardButton_pressed():
	sceneToLoad = "res://UI/LeaderBoardUI.tscn"
	fadeInEffect.show()
	fadeInEffect.fadeIn()

func _on_VolumeButton_pressed():
	var master_sound = AudioServer.get_bus_index("Master")
	if AudioServer.is_bus_mute(master_sound):
		AudioServer.set_bus_mute(master_sound, false)
		$VolumeButton/VolumeBorderIcon.visible = true
		PlayerStats.set_volume_status(false) 
	else:
		AudioServer.set_bus_mute(master_sound, true)
		$VolumeButton/VolumeBorderIcon.visible = false
		PlayerStats.set_volume_status(true) 
		

func verify_sound_status():
	var master_sound = AudioServer.get_bus_index("Master")
	if playerStats.get_volume_status() and AudioServer.is_bus_mute(master_sound):
		AudioServer.set_bus_mute(master_sound, true)
		$VolumeButton/VolumeBorderIcon.visible = false	
	else:
		AudioServer.set_bus_mute(master_sound, false)
		$VolumeButton/VolumeBorderIcon.visible = true

