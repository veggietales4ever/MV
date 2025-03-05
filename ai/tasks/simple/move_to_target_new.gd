extends BTAction

@export var target_var := &"target"
@export var speed_var : int
@export var tolerance = 20



"""
if target is not equal to null, meaning we have a characterbody, we have a target. everything is working
we then want to find that position of that target. get the direction to that target
then we want to move and check if we are at that target or not

var dir = where is the agent at, and where is the target position
need to get the agent's global position and we need to face in the direction that the target position is in
and move towards the target.
"""

func _tick(delta: float) -> Status:
	var target: CharacterBody2D = blackboard.get_var(target_var)
	if target != null:
		var target_position = target.global_position
		#var dir = agent.global_position.direction_to(target_position)

		# Update the agent's speed dynamically
		agent.stats.run_speed = speed_var  

		# Check if close enough to the target
		if abs(agent.global_position.x - target_position.x) < tolerance:
			agent.move(agent.global_position, delta)  # Stay in place
			return SUCCESS
		else:
			#print("Direction:", dir, " Speed:", agent.stats.run_speed)
			agent.move(target_position, delta)  # Move towards target
			return RUNNING
	return FAILURE
