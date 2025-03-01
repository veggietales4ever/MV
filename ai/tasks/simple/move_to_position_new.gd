extends BTAction

func _tick(delta: float) -> Status:
	var target_pos : Vector2 = blackboard.get_var("pos")
	var current_pos : Vector2 = agent.global_position
	
	agent.move(target_pos, delta)
	
	if Vector2(current_pos.x, 0).distance_to(Vector2(target_pos.x, 0)) <= 0.5:
		agent.velocity = Vector2.ZERO
		return SUCCESS
		
	return RUNNING
