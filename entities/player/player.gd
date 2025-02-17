
#player.gd
extends Entity
class_name Player

@onready var invulnerability_timer: Timer = $Timers/InvulnerabilityTimer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer


@export_group('damage')
@export var knockback_force := 1000
@export var knockback_duration := 0.3
@export var invulnerability_duration := 1.0
var is_knocked_back := false
var invulnerable := false

@export_group('move')
@export var speed := 100 # := is the data type of first value is the only data type this var can accept.
@export var acceleration := 1200
@export var friction := 1800
var direction := Vector2.ZERO
var can_move := false
var dash := false
@export_range(0.1,2) var dash_cooldown := 0.5
var crouching := false

@export_group('jump')
@export var jump_strength := 275
@export var gravity := 600
@export var terminal_velocity := 500
var jump := false
var faster_fall := false
var gravity_multiplier := 1
var was_in_air : bool = false

@export_group('weapon')
var attacking := false
@export_range(0.1,2) var attack_cooldown := 0.5

var reset_position: Vector2
var event: bool
var abilities: Array[StringName]
var double_jump: bool
var entry_state: String = ""
var animation_locked : bool = false

func _ready() -> void:
	animation_tree.active = true
	on_enter()
	PlayerManager.register_player(self)
	$Timers/DashCooldown.wait_time = dash_cooldown
	$Timers/AttackCooldown.wait_time = attack_cooldown
	#PlayerManager.player =  self


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	#apply_movement(delta)
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x:
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	
	# Jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump = true
			jump_func()
		if velocity.y > 0 and not is_on_floor():
			$Timers/JumpBuffer.start()
			
	if not is_on_floor():
		was_in_air = true
	else:
		if was_in_air:
			land()
			
		was_in_air = false
			
	#if jump:# or $Timers/JumpBuffer.time_left and is_on_floor():
		#velocity.y = -jump_strength
		#jump = false
		#faster_fall = false
			#
	if Input.is_action_just_released("jump") and not is_on_floor() and velocity.y < 0:
		faster_fall = true
			
	move_and_slide()
	update_animation()
	update_facing_direction()

func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)
	
	if not animation_locked:
		if direction != Vector2.ZERO:
			animation_player.play("run")
		else:
			animation_player.play("idle")
			
func update_facing_direction():
	if direction.x > 0:
		sprite_2d.flip_h = false
	elif direction.x < 0:
		sprite_2d.flip_h = true
		
func jump_func():
	if jump:
		velocity.y = -jump_strength
		jump = false
		faster_fall = false
		animation_player.play("jump")
		animation_locked = true
		
func land():
	animation_player.play("jumpfall")
	animation_locked = true
		
#if can_move:
	#get_input()
		
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
		
	# Jump
	if jump:# or $Timers/JumpBuffer.time_left and is_on_floor():
		velocity.y = -jump_strength
		jump = false
		faster_fall = false
	
	# Dash
	if dash:
		dash = false
		var dash_tween = create_tween()
		dash_tween.tween_property(self, 'velocity:x', velocity.x + direction.x * 300, 0.3)
		dash_tween.connect("finished", on_dash_finish)
		gravity_multiplier = 0
		
	# Attacking
	if is_on_floor() and $PlayerGraphics/AnimationPlayer.current_animation == 'jump_attack':
		attacking = false
	
	if faster_fall and attacking:
		$Timers/AttackCooldown.start()
	
	if is_knocked_back:
		return # Stop movement while in knockback
		
	if invulnerable:
		invulnerability_timer.start(invulnerability_duration)
		
	#var on_floor = is_on_floor()
	move_and_slide()

func apply_gravity(delta):
	velocity.y += gravity * delta
	velocity.y = velocity.y / 2 if faster_fall and velocity.y < 0 else velocity.y
	velocity.y = velocity.y * gravity_multiplier
	velocity.y = min(velocity.y, terminal_velocity)
	
	if is_on_floor():
		faster_fall = false

func on_dash_finish():
	velocity.x = move_toward(velocity.x, 0, 900)
	gravity_multiplier = 1

func _on_attack_finished():
	attacking = false

func _on_can_move_area_intro_body_entered(_body: Node2D) -> void:
	can_move = true

func on_enter():
	# Position for kill system. Assigned when entereing new room
	reset_position = position

func cant_move():
	can_move = false
	
func can_now_move():
	can_move = true


func _on_cannot_move_area_intro_body_entered(_body: Node2D) -> void:
	can_move = false
	
func set_entry_state(state: String):
	entry_state = state

func take_damage(enemy_position: Vector2):
	if invulnerable or is_knocked_back:
		return # Ignore damage if already in knockback or invulnerable
		
	
	var camera = get_viewport().get_camera_2d()
	if camera:
		camera.apply_screen_shake(2)
	else:
		print("No camera found")
		
		
	# States
	is_knocked_back = true
	invulnerable = true
	can_move = false
	
	#player_graphics.take_damage_animation()
	
	# Knockback direction (opposite of enemy)
	var knockback_direction = sign(position.x - enemy_position.x)
	if knockback_direction == 0:
		knockback_direction = 1 # Default to right if directly on top
	
	# Apply knockback
	velocity.x = knockback_direction * knockback_force
	velocity.y = -jump_strength * 1.3 # Slight upward
	
	# Knockback movement
	move_and_slide()
	
	# Knockback timer
	var knockback_tween = create_tween()
	knockback_tween.tween_property(self, "velocity", Vector2.ZERO, knockback_duration)
	knockback_tween.set_ease(Tween.EASE_IN_OUT)
	knockback_tween.connect("finished", _on_knockback_finished)
	
	start_invulnerability()
	
func _on_knockback_finished():
	is_knocked_back = false
	can_move = true
	
	#animate()
	
func _on_invulnerability_timeout():
	invulnerable = false
	sprite_2d.modulate = Color(1, 1, 1, 1) # Reset opacity
	
	
func start_invulnerability():
	invulnerable = true
	var flash_tween = create_tween()
	for i in range(7): # Flash 7 times
		flash_tween.tween_property(sprite_2d, "modulate", Color(1, 1, 1, 0.3), 0.1) # 0.1 is duration of tween in seconds
		flash_tween.tween_property(sprite_2d, "modulate", Color(1, 1, 1, 1), 0.1)
		
		
	flash_tween.connect("finished", _on_invulnerability_timeout)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if animation_player.current_animation == "jumpfall":
		animation_locked = false
