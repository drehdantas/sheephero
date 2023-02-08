extends AnimatedSprite

onready var sfx_player: = $RandomSFXPlayer

func _ready():
	connect("animation_finished", self, "_on_animation_finished")
	play("Animate")
	if is_instance_valid(sfx_player):
		sfx_player.play_random()

func _on_animation_finished():
	queue_free()

