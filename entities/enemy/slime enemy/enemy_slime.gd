extends Enemy
class_name SlimeEnemy

#signal enemy_damaged()

const gravity = 30 


@onready var hitbox: Area2D = $hitbox
@onready var invulnerability_timer: Timer = $Timers/InvulnerabilityTimer
@onready var detection_zone: DetectionZone = $DetectionZone
@onready var hit_flash_anim_player: AnimationPlayer = $HitFlashAnimationPlayer

var invulnerable : bool = false
var is_hurt := false
var is_knocked_back := false
var knockback_force := 1000
var knockback_duration := 0.7
var invulnerability_duration := 3.0
var player = Player


		
func _physics_process(_delta: float) -> void:
	if is_on_wall() and is_on_floor():
		velocity.y = -stats.jump_velocity
	else:
		velocity.y += gravity
		
	move_and_slide()
	


func move(target_pos : Vector2, _delta : float):
	var direction = Vector2(
		target_pos.x - global_position.x,
		0
	).normalized()
	
	velocity.x = direction.x * stats.run_speed
	
	update_flip(direction.x)
	

func check_for_self(node):
	if node == self:
		return true
	else:
		return false

func update_flip(dir : float):
	sprite_2d.flip_h = dir < 0
	detection_zone.scale.x = -1 if dir < 0 else 1
	

func explode():
	var explosion_scene = preload("res://particles/explosion.tscn")
	var explosion_instance = explosion_scene.instantiate()
	get_parent().add_child(explosion_instance)
	explosion_instance.global_position = global_position
	
	#Pass enemy color to the explosion effect
	explosion_instance.set_explosion_color(sprite_2d.modulate)
	
func knockback():
	is_knocked_back = true
	invulnerable = true

	
	# Knockback direction (opposite of player)
	var knockback_direction = sign(position.x - PlayerManager.player.position.x)
	if knockback_direction == 0:
		knockback_direction = 1 # Default to right if directly on top
		
	# Calculate knockback target position
	var knockback_distance = 30  # Adjust as needed for better effect
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
	
	
	# Knockback timer
	var knockback_tween = create_tween()
	knockback_tween.tween_property(self, "velocity", Vector2.ZERO, knockback_duration)
	knockback_tween.set_ease(Tween.EASE_IN_OUT)
	knockback_tween.connect("finished", _on_knockback_finished)

	
	start_invulnerability()

func _on_knockback_finished():
	is_knocked_back = false
	velocity = Vector2.ZERO # Make sure no leftover movement force
	
func start_invulnerability(): 
	invulnerable = true
	invulnerability_timer.start(invulnerability_duration)
	var flash_tween = create_tween()
	for i in range(3): # Flash 7 times
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
		#
	#for area in hitbox.get_overlapping_areas():
		#if area.get_parent() == player and area is Weapon:
			#print("Player attack still inside! Applying damage.")
			#_on_hitbox_area_entered(area)
			#break
			#
	#for body in hitbox.get_overlapping_bodies():
		#if body == player:
			#print("Player still inside")
			#_on_hitbox_body_entered(body)
			#break
