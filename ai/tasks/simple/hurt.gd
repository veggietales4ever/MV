extends BTAction


func _tick(delta: float) -> Status:
	await agent.knockback()
	
	return SUCCESS
