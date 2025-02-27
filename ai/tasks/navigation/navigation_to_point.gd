@tool
extends BTAction

# Max distance left or right from where the NPC currently stands
@export var max_distance : float = 200.0

var npc : NPC
var rng : RandomNumberGenerator
var desired_direction : Vector2


func _generate_name() -> String:
	return "Navigate to a new point of max distance %s to the left or right of where the character is." % max_distance

func _setup() -> void:
	npc = agent as NPC
	rng = RandomNumberGenerator.new()
	blackboard.bind_var_to_property(BBNames.direction_var, self, "desired_direction")
	
	
func _enter() -> void:
	npc.navigation.target_position = pick_destination()
	
# similar to _update on state machine, or _process on any node. only runs when behavior tree is currently acting on this script.
func _tick(delta: float) -> Status:
	if npc.navigation.is_navigation_finished():
		return SUCCESS
	
	if not npc.navigation.is_target_reachable():
		return FAILURE
		
	var next_path = npc.navigation.get_next_path_position()
	desired_direction = npc.global_position.direction_to(next_path)
	
	## for jumping
	if reached_horizontally_but_vertical_offset(desired_direction):
		return FAILURE
	
	if desired_direction.y < 0 && npc.is_on_floor() && npc.is_on_wall:
		pass
		#npc.jump()
		#print(npc.is_on_wall)
		#print(npc.is_on_floor)
		#print(desired_direction.y)
		
	npc.move(desired_direction)
	
	return RUNNING
	
# Choose a new point to navigate the NPC to
func pick_destination() -> Vector2:
	var current_position = npc.get_global_position()
	var offset = rng.randf_range(-max_distance, max_distance)
	var new_destination = Vector2(
		current_position.x + offset,
		current_position.y
	)
	return new_destination

func reached_horizontally_but_vertical_offset(p_desired_direction : Vector2) -> bool:
	if is_zero_approx(p_desired_direction.x):
		return true
		
	return false
