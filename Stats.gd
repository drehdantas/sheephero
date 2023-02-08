extends Node

class_name Stats

export var originalHealth = 3
var originalSpeed = 80

var max_health = 1 setget set_max_health
var max_stamina = 100 setget set_max_stamina
var max_speed = 80 setget set_max_speed

var health = max_health setget set_health
var stamina = max_stamina setget set_stamina
var speed = max_speed setget set_speed

var waveLevel = 1 setget set_wavelevel
var playerScore = 0 setget set_player_score, get_player_score
var playerRecord = 0 setget set_player_record

var player = null
var statusVolume = true setget set_volume_status, get_volume_status

onready var songBackground = $AudioStreamPlayer2D

signal no_health
signal health_changed(value)
signal max_health_changed(value)

signal stamina_changed(value)
signal max_stamina_changed(value)

func _ready():
	set_initial_values()
	
#	ENQUANTO DESENVOLVE A MUSICA FICA STOPPED
#	var master_sound = AudioServer.get_bus_index("Master")
#	AudioServer.set_bus_mute(master_sound, true)
	
func set_initial_values():
	max_health = originalHealth
	max_speed = originalSpeed
	playerScore = 0
	
	self.health = max_health
	self.stamina = max_stamina
	self.speed = max_speed

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed")

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")
		
func set_max_stamina(value):
	max_stamina = value
	self.stamina = min(stamina, max_stamina)
	emit_signal("max_stamina_changed")
	
func set_stamina(value):
	stamina = value
	emit_signal("stamina_changed", stamina)
	
func set_max_speed(value):
	max_speed = value
	self.speed = min(speed, max_speed)
	emit_signal("max_speed_changed")
	
func set_speed(value):
	speed = value
	emit_signal("speed_changed", speed)
	
func set_wavelevel(value):
	waveLevel = value
	
func set_player_score(value):
	playerScore += value
	
func get_player_score():
	return playerScore * waveLevel
	
func set_player_record(value):
	if playerRecord < playerScore:
		playerRecord = value
	
func set_volume_status(value):
	statusVolume = value
	
func get_volume_status():
	return statusVolume

	

