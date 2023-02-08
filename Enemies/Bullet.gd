extends KinematicBody2D

var direction : Vector2 = Vector2.LEFT # default direction
var speed : float = 100 #put your rocket speed

const MagicHitEffect = preload("res://Effects/EnemyDeathEffect.tscn")
	
func _physics_process(delta):
	translate(direction*speed*delta)

func _on_Hitbox_area_entered(area):
	queue_free()
	var magicHitEffect = MagicHitEffect.instance()
	get_parent().add_child(magicHitEffect)
	magicHitEffect.global_position = global_position
