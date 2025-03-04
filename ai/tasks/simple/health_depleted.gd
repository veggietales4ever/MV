extends BTAction

#@export var stats : CharacterStats
var health_var : int

func _tick(_delta: float) -> Status:
	agent.stats.health = health_var
	if health_var >= 0:
		agent.animation_player.play("damaged")
		#await agent.get_tree().create_timer(1.0).timeout
		#agent.explode()
		#agent.queue_free()
	return SUCCESS
		
