extends BTAction

func _tick(delta: float) -> Status:
	var pos: Vector2 = agent.global_position
	pos += Vector2(
		randi_range(-50.0, 50.0),
		0
	)
	blackboard.set_var("pos", pos)
	
	return SUCCESS
