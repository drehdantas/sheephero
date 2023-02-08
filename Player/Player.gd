extends KinematicBody2D

const PlayerHurtSound = preload("res://Music and Sounds/PlayerHurtSound.tscn")

export var ACCELERATION = 500
export var FRICTION = 500
export var ROLL_SPEED = 110
export var ROLL_STAMINA = 30
export var ATTACK_STAMINA = 10

enum {
	MOVE,
	ROLL,
	ATTACK
}

#codigo para resolver um bug que chama o roll_animation_finished duas vezes, nao me orgulho
var alreadyRolled = false
var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var speed

var stats = PlayerStats 

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")
	stats.player = self
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector
	speed = stats.max_speed
	
#	se eu tiver dado restart e animacao de hit nao tiver acabado - bug loco
	blinkAnimationPlayer.play("Stop")
	
func _exit_tree():
	stats.player = null
	
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state()
		ATTACK:
			attack_state()
	
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector) # só para comecar virado pro ladinho certo
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * stats.max_speed, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move()
	
	if Input.is_action_just_pressed("roll"):
		state = ROLL
		
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	

func attack_state():
	if stats.stamina > ATTACK_STAMINA:
		animationState.travel("Attack")
	else:
		state = MOVE

func roll_state():
	if stats.stamina > ROLL_STAMINA:
		velocity = roll_vector * ROLL_SPEED
		animationState.travel("Roll")
		move()
	else:
		state = MOVE
	
func move():
	velocity = move_and_slide(velocity)

func roll_animation_finished():
	velocity = velocity * 0.8
	state = MOVE
	
	if alreadyRolled == false:
		stats.stamina -= ROLL_STAMINA
		alreadyRolled = true
	else:
		alreadyRolled = false
	
	
func attack_state_finished():
	state = MOVE
	if alreadyRolled == false:
		stats.stamina -= ATTACK_STAMINA
		alreadyRolled = true
	else:
		alreadyRolled = false

func _on_Hurtbox_area_entered(area):
	if hurtbox.invincible == false:
		stats.health -= area.damage
		hurtbox.start_invincibility(0.6)
		hurtbox.create_hit_effect()
		var playerHurtSound = PlayerHurtSound.instance()
		get_tree().current_scene.add_child(playerHurtSound)

func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")

func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")

func _on_StaminaRecovery_timeout():
	if stats.stamina < stats.max_stamina:
		stats.stamina += 1
