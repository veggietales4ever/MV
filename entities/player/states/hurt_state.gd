extends PlayerState
class_name HurtState


@onready var invulnerability_timer: Timer = $"../../Timers/InvulnerabilityTimer"
@onready var sprite_2d: Sprite2D = $"../../Facing/Sprite2D"

@export_group('damage')
@export var knockback_force : float = 1000.0
@export var knockback_duration : float = 0.3
@export var invulnerability_duration : float = 1.0
@export var invulnerable : bool = false
@export var is_knocked_back : bool = false

@export var can_move : bool = true



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
	
	
	# Knockback direction (opposite of enemy)
	var knockback_direction = sign(character.position.x - enemy_position.x)
	if knockback_direction == 0:
		knockback_direction = 1 # Default to right if directly on top
	
	# Apply knockback
	#velocity.x = knockback_direction * knockback_force
	#velocity.y = -jump_strength * 1.3 # Slight upward
	
	# Knockback movement
	character.move_and_slide()
	
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
