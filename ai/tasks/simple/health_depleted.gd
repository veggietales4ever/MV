extends BTAction

@export var stats : CharacterStats
@export var health_var : int

func _tick(delta: float) -> Status:
	agent.stats.health = health_var
	if health_var >= 0:
		agent.explode()
		agent.queue_free()
	return SUCCESS
		
