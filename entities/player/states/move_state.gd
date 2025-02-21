extends PlayerState
# Move state

func _update(delta: float) -> void:
	var velocity : Vector2 = move(delta)
	
	if Vector2.ZERO.is_equal_approx(velocity): #as long as currency velocity is not approximately 0. switch state to move state
		dispatch("stopped", velocity)
		
	if blackboard.get_var(BBNames.jump_var) && character.is_on_floor() && blackboard.get_var(BBNames.jumps_made_var) == 0: # jumps_made_var == 0 means we haven't made any jumps, we're also on the floor
		jump()

func jump():
	character.velocity.y = -character.jump_velocity
	var current_jumps : int = blackboard.get_var(BBNames.jumps_made_var)
	blackboard.set_var(BBNames.jumps_made_var, current_jumps + 1)
