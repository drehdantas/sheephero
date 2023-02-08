extends Control

var stamina = 100 setget set_stamina
var max_stamina = 100 setget set_max_stamina

onready var staminaBar = $StaminaBar
	
func set_stamina(value):
	staminaBar.value = value
	
func set_max_stamina(value):
	max_stamina = max(value, 20)
	self.stamina = min(stamina, max_stamina)
	if staminaBar != null:
		staminaBar.rect_size.x = max_stamina * 20
	
func _ready():
	self.max_stamina = PlayerStats.max_stamina
	self.stamina = PlayerStats.stamina
	PlayerStats.connect("stamina_changed", self, "set_stamina")
	PlayerStats.connect("max_stamina_changed", self, "set_max_stamina")
