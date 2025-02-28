extends BTAction

#@export var target_var := &"target"

@export var speed_var = 40
@export var tolerance = 20
var npc : NPC

"""
if target is not equal to null, meaning we have a characterbody, we have a target. everything is working
we then want to find that position of that target. get the direction to that target
then we want to move and check if we are at that target or not

var dir = where is the agent at, and where is the target position
need to get the agent's global position and we need to face in the direction that the target position is in
and move towards the target.
"""
func _tick(delta: float) -> Status:
	var target: CharacterBody2D = blackboard.get_var(BBNames.target_var)
	if target != null:
		var target_position = target.global_position
		var dir = agent.global_position.direction_to(target_position)
		
		if 1 == 1:
			pass
		else:
			print(dir.x, "   ", dir)
			agent.move(dir.x, speed_var)
			return RUNNING
	return FAILURE
