extends State
class_name AttackState

@export var ground_state : State

func state_process(delta):
	if character.is_on_floor() && attacking:
		next_state = ground_state

func on_exit():
	if next_state == ground_state:
		next_state = ground_state
