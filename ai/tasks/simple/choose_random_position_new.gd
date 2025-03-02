extends BTAction

func _tick(_delta: float) -> Status:
	var pos: Vector2 = agent.global_position
	pos += Vector2(
		randi_range(-25.0, 25.0),
		0
	)
	blackboard.set_var("pos", pos)
	
	return SUCCESS
