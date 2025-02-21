extends PlayerState

@export var idle_anim : StringName = "idle"
@export var move_anim : StringName = "move"
@export var jump_anim : StringName = "jump"

func _enter() -> void:
	super()
	blackboard.set_var(BBNames.jumps_made_var, 0)


func _update(delta: float) -> void:
	var velocity : Vector2 = move(delta)
	
	if Vector2.ZERO.is_equal_approx(velocity): #as long as currency velocity is not approximately 0. switch state to move state
		character.animation_player.play(idle_anim)
	else:
		character.animation_player.play(move_anim)
	
	if character.is_on_floor():
		if blackboard.get_var(BBNames.jump_var) && blackboard.get_var(BBNames.jumps_made_var) == 0: # jumps_made_var == 0 means we haven't made any jumps, we're also on the floor
			jump()
	else: #elif not _on_first_frame:
		dispatch("in_air")
	
	if blackboard.get_var(BBNames.crouch_var):
		dispatch("crouching")
		
	#_on_first_frame = false

# Movement for when running on the ground
func move(delta) -> Vector2:
	var direction: Vector2 = blackboard.get_var(BBNames.direction_var, Vector2.ZERO)
	
	if not is_zero_approx(direction.x):
		#character.velocity.x = direction.x * character.speed
		character.velocity.x = move_toward(character.velocity.x, direction.x * character.speed, character.acceleration * delta)
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, character.friction * delta)
	
	character.move_and_slide()
	return character.velocity
	
	# Jump
func jump():
	character.velocity.y = -character.jump_velocity
	var current_jumps : int = blackboard.get_var(BBNames.jumps_made_var)
	blackboard.set_var(BBNames.jumps_made_var, current_jumps + 1)
	character.animation_player.play(jump_anim)
	dispatch("jump")
