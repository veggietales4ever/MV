extends PlayerState
class_name AirState

@export var can_move : bool = true

func _update(delta: float) -> void:
	if can_move:
		air_move(delta)
		
	if character.is_on_floor():
		dispatch("on_ground")

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
