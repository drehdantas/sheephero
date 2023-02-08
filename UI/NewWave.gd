extends Control

onready var timer = $Timer
onready var title = $VBoxContainer/Title
onready var counter = $VBoxContainer/Time

var timeCounter = 3.0

func _ready():
	visible = false

func new_wave(value):
	timer.start()
	visible = true
	PlayerStats.set_wavelevel(value)
	title.text = "Wave " + str(value)
	counter.text = str(get_phrase(value))

func _on_Timer_timeout():
	timer.stop()
	visible = false
	
func get_phrase(value):
	if value == 1:
		return "Can you hold up to wave 10?"
	elif value == 2:
		return "Only bats for now..."
	elif value == 3:
		return "Lets go farm health"
	elif value == 4:
		return "Here comes the wolves"
	elif value == 5:
		return "MORE WOLVES"
	elif value == 6:
		return "not died yet?"
	elif value == 7:
		return "more mages maybe"
	elif value == 8:
		return "MORE MAGES!"
	elif value == 9:
		return "thanks for playing so far"
	elif value == 10:
		return "I really appreciate your dedication"
	elif value == 11:
		return "Bonus level: Welcome to hell"
	
		
#	var phrases = [
#		"Prepare for battle!",
#		"Its easy...",
#		"it's already the final boss",
#		"The dark souls of indie games",
#		"Easier than last time"
#	]
#	return phrases[randi() % phrases.size()]

