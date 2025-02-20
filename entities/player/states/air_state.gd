extends PlayerState

@export var rising_animation : StringName = "rising"
@export var falling_animation : StringName = "falling"
@export var jump_animation : StringName = "jump"

	
func _update(delta: float) -> void:
	air_move(delta)
	select_animation()
	
	if character.is_on_floor():
		dispatch("on_ground")
		
func select_animation():
	if animation_lock:
		return
		
	if character.velocity.y <= 0.0:
		character.animation_player.play(rising_animation)
	else:
		character.animation_player.play(falling_animation)
		

func air_move(_delta) -> Vector2:
	var direction : Vector2 = blackboard.get_var(BBNames.direction_var)
	
	# Acceleration / Deceleration capped by max_air_speed
	if direction.x > 0:
		# Add acceleration to current velocity value capped by max_air_speed
		var attempted_velocity_x = min(character.max_air_speed, character.velocity.x + character.air_acceleration) 
		
		# Take the higher of the current velocity x or attempted_velocity.x
		character.velocity.x = max(character.velocity.x, attempted_velocity_x)
	elif direction.x < 0:
		var attempted_velocity_x = max(-1 * character.max_air_speed, character.velocity.x - character.air_acceleration) 
		
		# Take the higher of the current velocity x or attempted_velocity.x
		character.velocity.x = min(character.velocity.x, attempted_velocity_x)
		
		
	character.move_and_slide()
	return character.velocity
	
