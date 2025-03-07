extends PlayerState

func _update(delta: float) -> void:
	var velocity : Vector2 = move(delta)
	
	if not Vector2.ZERO.is_equal_approx(velocity): #as long as currency velocity is not approximately 0. switch state to move state
		dispatch("moving", velocity) # pass any data you want receiving data to know about (velocity)
