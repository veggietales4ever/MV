extends CharacterBody2D
class_name Enemy

signal direction_changed(new_direction: Vector2)
signal enemy_damaged()

@export var Health : int = 3

var invulnerable : bool = false
var direction = Vector2.ZERO
var player : Player
var is_hurt := false
var is_knocked_back := false
var knockback_force := 1000
var knockback_duration := 0.7
var invulnerability_duration := 3.0
var gravity := 600
var player_inside := false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox: Area2D = $hitbox
@onready var state_matchine: EnemyStateMachine = $EnemyStateMachine
@onready var invulnerability_timer: Timer = $Timers/InvulnerabilityTimer

func _ready() -> void:
	state_matchine.initialize(self)
	player = PlayerManager.player
	animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _process(delta: float) -> void:
	apply_gravity(delta)
	
func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func update_animation(state : String) -> void:
	animation_player.play(state)
	
	
func _on_chase_trigger_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var player = PlayerManager.player
		

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = true
		var player = PlayerManager.player
		if not player.invulnerable:
			player_data.life -= 1
			player.take_damage(global_position)
			
		
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Weapon:
		var weapon = area as Weapon
		print("Enemy hit by:", weapon.name, " | Damage:", weapon.weapon_damage)
		damage(weapon.weapon_damage)
		animation_player.play("damaged")
			
func damage(amount: int):
	print("Enemy Took damage:", amount)
	if invulnerable or is_knocked_back:
		return # Don't take damage if invulnerable
		
		
	Health -= amount # Subtract health
	emit_signal("enemy_damaged") # Emit signal if needed
	
	
	if Health <= 0:
		explode()
		queue_free()
		return
	# States
	is_knocked_back = true
	invulnerable = true
	
	take_damage_animation()
	
	# Knockback direction (opposite of player)
	var knockback_direction = sign(position.x - PlayerManager.player.position.x)
	if knockback_direction == 0:
		knockback_direction = 1 # Default to right if directly on top
		
	# Calculate knockback target position
	var knockback_distance = 50  # Adjust as needed for better effect
	var knockback_target = position + Vector2(knockback_direction * knockback_distance, 0)
	
	
	# Check for wall collision
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, knockback_target, collision_mask)
	var result = space_state.intersect_ray(query)
	
	if result:
		print("Wall Detected!")
		knockback_target = result.position
		
		
	# Use tween for smooth movement
	var tween = create_tween()
	tween.tween_property(self, "position", knockback_target, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.connect("finished", _on_knockback_finished)
	
	
	# Transition to chase state after knockback
	if state_matchine:
		for state in state_matchine.states:
			if state is EnemyStateChase:
				state_matchine.change_state(state)
				break

	# Knockback timer
	var knockback_tween = create_tween()
	knockback_tween.tween_property(self, "velocity", Vector2.ZERO, knockback_duration)
	knockback_tween.set_ease(Tween.EASE_IN_OUT)
	knockback_tween.connect("finished", _on_knockback_finished)
	
	start_invulnerability()
	
	
		
func explode():
	var explosion_scene = preload("res://particles/explosion.tscn")
	var explosion_instance = explosion_scene.instantiate()
	get_parent().add_child(explosion_instance)
	explosion_instance.global_position = global_position
	
	#Pass enemy color to the explosion effect
	explosion_instance.set_explosion_color(sprite_2d.modulate)

func take_damage_animation():
	if not is_hurt:
		is_hurt = true
		#animation_player.play("damaged")
		#print(is_hurt)
		
func _on_knockback_finished():
	is_knocked_back = false
	velocity = Vector2.ZERO # Make sure no leftover movement force

func start_invulnerability(): 
	invulnerable = true
	invulnerability_timer.start(invulnerability_duration)
	var flash_tween = create_tween()
	for i in range(7): # Flash 7 times
		flash_tween.tween_property(self, "modulate", Color(1, 1, 1, 0.3), 0.1) # 0.1 is duration of tween in seconds
		flash_tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.1)
	flash_tween.connect("finished", _on_invulnerability_timer_timeout)
	
func _on_invulnerability_timer_timeout():
	invulnerable = false
	self.modulate = Color(1, 1, 1, 1) # Reset opacity
	
	var player = PlayerManager.player
	if player == null:
		print("Error: Playermanager.player is not set")
		return
		
	for area in hitbox.get_overlapping_areas():
		if area.get_parent() == player and area is Weapon:
			print("Player attack still inside! Applying damage.")
			_on_hitbox_area_entered(area)
			break
			
	for body in hitbox.get_overlapping_bodies():
		if body == player:
			print("Player still inside")
			_on_hitbox_body_entered(body)
			break
	
func apply_gravity(delta):
	velocity.y += gravity * delta


func _on_animation_finished(anim_name):
	if anim_name in ["damaged"]:
		emit_signal("enemy_damaged")
		animation_player.play("wander")


func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = false
