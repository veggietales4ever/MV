extends PlayerState
class_name GroundState

@export var jump_anim : StringName = "jump"
#@export var can_jump : bool = true
@export var can_move : bool = true

var _on_first_frame = true


func _update(delta: float) -> void:
	if can_move:
		move(delta)
		
	if character.is_on_floor():
		can_jump = true
		if can_jump && blackboard.get_var(BBNames.jump_var) && blackboard.get_var(BBNames.jumps_made_var) == 0: # jumps_made_var == 0 means we haven't made any jumps, we're also on the floor
			jump()
	elif not _on_first_frame:
		dispatch("in_air")
	
	if blackboard.get_var(BBNames.crouch_var):
		dispatch("crouching")
		
	_on_first_frame = false

# Movement for when running on the ground
func move(delta) -> Vector2:
	var direction: Vector2 = blackboard.get_var(BBNames.direction_var, Vector2.ZERO)
	var velocity : Vector2
	
	if not is_zero_approx(direction.x):
		#character.velocity.x = direction.x * character.speed
		velocity.x = move_toward(velocity.x, direction.x * character_stats.run_speed, character.stats.acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, character.stats.friction * delta)
	
	
	#if direction.x:
		#velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)
	#else:
		#velocity.x = move_toward(velocity.x, 0, friction * delta)
	
	character.move_and_slide()
	return velocity
	
	# Jump
func jump():
	if can_jump:
		can_jump = false
		character.velocity.y = -character.jump_velocity
		var current_jumps : int = blackboard.get_var(BBNames.jumps_made_var)
		blackboard.set_var(BBNames.jumps_made_var, current_jumps + 1)
		character.animation_player.play(jump_anim)
		dispatch("jump")
