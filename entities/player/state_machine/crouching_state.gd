extends State
class_name CrouchingState

@export var ground_state : State
@export var landing_animation : String = ""


var velocity := Vector2(0, 0)
var jump := false

func state_process(delta):
	if crouching:
		velocity.x = 0
		jump = false
		
	if Input.is_action_just_released("down"):
		crouching = false
		next_state = ground_state
		#playback.travel(landing_animation)
