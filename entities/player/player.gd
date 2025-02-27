
#player.gd
extends Character
class_name Player


signal health_depleted
#@export var sprite_2d: Sprite2D
#@export var animation_player: AnimationPlayer
#@export var stats : PlayerStats

@onready var invulnerability_timer: Timer = $Timers/InvulnerabilityTimer


@export var player_actions: PlayerActions

@onready var sword_collision: CollisionShape2D = $Facing/Sword/CollisionShape2D
@onready var input_handler: PlayerInput = $PlayerInput


@export_group('move')
@export var speed := 110 # := is the data type of first value is the only data type this var can accept.
@export var acceleration := 1200
@export var friction := 2000
var direction := Vector2.ZERO
var can_move := false
var dash := false
var crouching := false
@export_range(0.1,2) var dash_cooldown := 0.5

@export_group('jump')
@export var gravity := 600
@export var terminal_velocity := 500
@export var jump_velocity : float = 275
@export var max_air_speed : float = 90.0
@export var air_acceleration : float = 85.0
var jump := false
var faster_fall := false
var gravity_multiplier := 1

@export_group('damage')
var attacking := false
@export_range(0.1,2) var attack_cooldown := 0.5

#@export var health : int = 20.0 :
	#set(value):
		#var old_value = health
		#health = value
		#
		#if health <= 0 && old_value > 0:
			#health_depleted.emit()
@export var damage : int = 10
@export var invulnerability_duration : float = 2.0


var reset_position: Vector2
var event: bool
var abilities: Array[StringName]
var double_jump: bool
var entry_state: String = ""
var invulnerable : bool

func _ready() -> void:
	sword_collision.disabled = true
	on_enter()
	$Timers/DashCooldown.wait_time = dash_cooldown
	$Timers/AttackCooldown.wait_time = attack_cooldown
	input_handler.can_move = can_move

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	direction = input_handler.input_direction

	#
	## Jump
	#if Input.is_action_just_pressed("jump"):
		#if is_on_floor():
			#pass
		#if velocity.y > 0 and not is_on_floor():
			#$Timers/JumpBuffer.start()
	if Input.is_action_just_released("jump") and not is_on_floor() and velocity.y < 0:
		faster_fall = true

#func get_input():
	## horizontal movement
	#direction.x = Input.get_axis("left", "right")
	#
	## Jump
	#if Input.is_action_just_pressed("jump"):
		#if is_on_floor():
			#jump = true
		#if velocity.y > 0 and not is_on_floor():
			#$Timers/JumpBuffer.start()
	#
	#if Input.is_action_just_released("jump") and not is_on_floor() and velocity.y < 0:
		#faster_fall = true
		#
	## Dash
	#if Input.is_action_just_pressed("dash") and velocity.x and not $Timers/DashCooldown.time_left: #Can only dash if moving in a direction
		#dash = true
		#$Timers/DashCooldown.start()
		#
	## Crouching
	#crouching = Input.is_action_pressed("down") and is_on_floor()
	#
	## Attacking
	#if Input.is_action_just_pressed("attack"):
		#attacking = true
		#
	## Sword
	#if direction.x > 0:
		#$PlayerGraphics/Sword.position.x = 1
	#if direction.x < 0:
		#$PlayerGraphics/Sword.position.x = -50
		
func apply_movement(delta):
	# Left / Right movement
	if direction.x:
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		
	if crouching:
		velocity.x = 0
		jump = false
		

		
	## Attacking
	#if is_on_floor() and $PlayerGraphics/AnimationPlayer.current_animation == 'jump_attack':
		#attacking = false
	
	if faster_fall and attacking:
		$Timers/AttackCooldown.start()
	
	#if is_knocked_back:
		#return # Stop movement while in knockback
		#
	if invulnerable:
		invulnerability_timer.start(invulnerability_duration)
	
	move_and_slide()

func apply_gravity(delta):
	velocity.y += gravity * delta
	velocity.y = velocity.y / 2 if faster_fall and velocity.y < 0 else velocity.y
	velocity.y = velocity.y * gravity_multiplier
	velocity.y = min(velocity.y, terminal_velocity)
	
	if is_on_floor():
		faster_fall = false


func _on_can_move_area_intro_body_entered(_body: Node2D) -> void:
	can_move = true

func on_enter():
	# Position for kill system. Assigned when entereing new room
	reset_position = position

func cant_move():
	can_move = false
	input_handler.can_move = false
	
func can_now_move():
	can_move = true
	input_handler.can_move = true


func disable_control(duration: float) -> void:
	cant_move()
	await get_tree().create_timer(duration).timeout
	can_now_move()
