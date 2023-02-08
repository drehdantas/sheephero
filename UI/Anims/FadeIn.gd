extends ColorRect

signal fadeFinished

onready var fadeInAnimation = $AnimationPlayer

func fadeIn():
	fadeInAnimation.play("FadeIn")

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("fadeFinished")
