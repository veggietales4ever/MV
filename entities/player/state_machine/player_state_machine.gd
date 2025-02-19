extends Node
class_name PlayerStateMachine

@export var current_state : State
@export var character: CharacterBody2D
@export var animation_tree: AnimationTree

var states : Array[State]

func _ready():
	for child in get_children(): # Grabbing all child nodes (AirState, IdleState, CrouchingState, etc). For each child, check if there's a state
		if child is State:
			states.append(child)
			
			child.character = character
			child.playback = animation_tree["parameters/playback"]
			
		else:
			push_warning("Child " + child.name + " is not a State for PlayerStateMachine")
			
func _physics_process(delta: float) -> void:
	if current_state.next_state != null:
		switch_states(current_state.next_state)
		
	current_state.state_process(delta)


func check_if_can_move():
	return current_state.can_move

func switch_states(new_state : State):
	if current_state != null:
		current_state.on_exit()
		current_state.next_state = null
		
		# make sure when we re enter an old state the next state is cleared, so it won't immediately try to switch again until we have that logic
	current_state = new_state
	
	current_state.on_enter()

func _input(event: InputEvent) -> void:
	current_state.state_input(event)
	
	"""
	when our state machine is running, and there's a current state set it's going to be calling the state_input
	but when that's not the current state that state is not going to be running its state input
	so we won't be able to jump unless the current state is the ground state
	"""
