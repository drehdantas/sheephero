extends Node2D

onready var bat = preload("res://Enemies/Bat.tscn")
onready var wolf = preload("res://Enemies/Wolf.tscn")
onready var wizard = preload("res://Enemies/WolfWizard.tscn")
onready var enemySpawnTimer = $EnemySpawnTimer

var batsRemainingToSpawn
var wolvesRemainingToSpawn
var wizardRemainingToSpawn
var enemiesKilledThisWave = 0

var waves
var currentWave: Wave
var currentWaveNumer = 0

signal new_wave(value)
signal no_more_waves

func _ready():
	waves = $Waves.get_children()
	start_next_wave()

func start_next_wave():
	currentWave = waves[currentWaveNumer]
	batsRemainingToSpawn = currentWave.numBats
	wolvesRemainingToSpawn = currentWave.numWolves
	wizardRemainingToSpawn = currentWave.numWizards
	enemySpawnTimer.wait_time = currentWave.secondsBetweenSpawns
	enemySpawnTimer.start()
	currentWaveNumer += 1
	
func connect_bat_signals(bat: Bat): 
	var stats: Stats = bat.get_node("Stats")
	stats.connect("no_health", self, "_on_enemy_stats_died_signal")
	
func connect_wolf_signals(wolf: Wolf): 
	var stats: Stats = wolf.get_node("Stats")
	stats.connect("no_health", self, "_on_enemy_stats_died_signal")
	
func connect_wizards_signals(wizard: WolfWizard): 
	var stats: Stats = wizard.get_node("Stats")
	stats.connect("no_health", self, "_on_enemy_stats_died_signal")
	
func _on_enemy_stats_died_signal():
	enemiesKilledThisWave += 1

func _on_EnemySpawnTimer_timeout():
	var enemy_position
	if batsRemainingToSpawn:
		enemy_position = Vector2(rand_range(-190, 330), rand_range(-80, 190))
		while enemy_position.x < 310 and enemy_position.x > -80 and enemy_position.y < 180 and enemy_position.y > -40:
			enemy_position = Vector2(rand_range(-190, 330), rand_range(-80, 190))
			
		var batInstance = bat.instance()
		connect_bat_signals(batInstance)
		get_parent().add_child(batInstance)
		batInstance.global_position = enemy_position
		
		batsRemainingToSpawn -= 1
		
	if wolvesRemainingToSpawn:	
		enemy_position = Vector2(rand_range(-190, 330), rand_range(-80, 190))
		while enemy_position.x < 310 and enemy_position.x > -80 and enemy_position.y < 180 and enemy_position.y > -40:
			enemy_position = Vector2(rand_range(-190, 330), rand_range(-80, 190))
				
		var wolfInstance = wolf.instance()
		connect_wolf_signals(wolfInstance)
		get_parent().add_child(wolfInstance)
		wolfInstance.global_position = enemy_position
		
		wolvesRemainingToSpawn -= 1
	if wizardRemainingToSpawn:
		enemy_position = Vector2(rand_range(-190, 330), rand_range(-80, 190))
		while enemy_position.x < 310 and enemy_position.x > -80 and enemy_position.y < 180 and enemy_position.y > -40:
			enemy_position = Vector2(rand_range(-190, 330), rand_range(-80, 190))
				
		var wizardInstance = wizard.instance()
		connect_wizards_signals(wizardInstance)
		get_parent().add_child(wizardInstance)
		wizardInstance.global_position = enemy_position
		
		wizardRemainingToSpawn -= 1
		
	if enemiesKilledThisWave == currentWave.numEnemies:
		enemiesKilledThisWave = 0
		if currentWaveNumer < waves.size():
			emit_signal("new_wave", currentWaveNumer)
		else:
#			zerou o jogo
			emit_signal("no_more_waves")
			
	
