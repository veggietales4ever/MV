extends BTAction

#@export var stats : CharacterStats
var health_var : int

func _tick(delta: float) -> Status:
	agent.stats.health = health_var
	if health_var >= 0:
		agent.animation_player.play()
		agent.explode()
		agent.queue_free()
	return SUCCESS
		
