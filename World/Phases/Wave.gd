extends Node2D

class_name Wave

var numEnemies

export var numBats = 3
export var numWolves = 0
export var numWizards = 0

export var phases = 1
export var secondsBetweenSpawns = 2

func _ready():
	numEnemies = numBats + numWolves + numWizards

#func return_type_enemie():
#	return arrayEnemies.sort()
