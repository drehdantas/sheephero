extends Node2D

onready var gameOver = $CanvasLayer2/GameOver
onready var enemySpawnTimer = $Spawner/EnemySpawnTimer
onready var newWaveUI = $CanvasLayer/NewWave
onready var updatesUI = $CanvasLayer/UpdatesUI
onready var healthUI = $CanvasLayer/HealthUI
onready var spawner = $Spawner

var momentWave = 0

func _ready():
	newWaveUI.new_wave(momentWave + 1)
	
func _process(delta):
	if PlayerStats.health <= 0:
		PlayerStats.playerScore = 0
		gameOver.game_over()
		enemySpawnTimer.stop()

func _on_Spawner_new_wave(value):
	momentWave = value
	if updatesUI != null:
		updatesUI.show()

func _on_Spawner_no_more_waves():
	PlayerStats.health = 0
	
func _on_Upgrades_change_max_health():
	newWaveUI.new_wave(momentWave + 1)
	spawner.start_next_wave()
	healthUI.set_all_hearts()

func _on_Upgrades_default_signal_start_wave():
	newWaveUI.new_wave(momentWave + 1)
	spawner.start_next_wave()
