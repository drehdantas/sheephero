extends KinematicBody2D

class_name WolfWizard

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 5
export var FRICTION = 200
export var WANDER_TARGET_RANGED = 4
export var SCORE_POINTS = 10

enum{
	IDLE,
	WANDER,
	CHASE,
	FOLLOWING
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var target
var state = CHASE

onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
onready var wanderController = $WonderController
onready var blinkAnimationEnemy = $BlinkAnimationPlayer
onready var bulletTime = $BulletTime

onready var bulletInstance = preload("res://Enemies/Bullet.tscn")

func _ready():
	state = FOLLOWING
#	state = pick_random_state([IDLE, WANDER])       CASO QUEIRA INIMIGOS PARADOS E TE CAÇANDO EM VOLTA

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
				
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGED:
				update_wander()
			 
		CHASE:	
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE

		FOLLOWING:
			if PlayerStats.player != null:
				target = PlayerStats.player
				accelerate_towards_point(PlayerStats.player.global_position, delta)
			else:
				state = IDLE
	
#	codigo para fazer os morcegos não se agruparem, terem um espaço entre si
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
		
	velocity = move_and_slide(velocity)
	
func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3)) 

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	
#	codigo para fazer ele olhar pro rumo onde ta indo
	sprite.flip_h = velocity.x < 0
			
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
		
func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_Hurtbox_area_entered(area):
	knockback = area.knockback_vector * 120
	stats.health -= area.damage
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.4)

func _on_Stats_no_health():
	queue_free()
	bulletTime.stop()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	PlayerStats.set_player_score(SCORE_POINTS)

func _on_Hurtbox_invincibility_ended():
	blinkAnimationEnemy.play("Stop")

func _on_Hurtbox_invincibility_started():
	blinkAnimationEnemy.play("Start")

func fire():
	var roc = bulletInstance.instance()
	get_tree().get_current_scene().add_child(roc)
	roc.global_position = global_position
	var dir = (PlayerStats.player.global_position - global_position).normalized()
	roc.global_rotation = dir.angle() + PI / 2.0
	roc.direction = dir

func _on_BulletTime_timeout():
	if PlayerStats.player != null:
		fire()
