extends State
class_name AirState

@export var landing_state : State
@export var ground_state : State
@export var landing_animation : String = ""
@onready var jump_buffer: Timer = $"../../Timers/JumpBuffer"

var velocity = Vector2(0, 0)



func state_process(delta):
	if character.is_on_floor():
		next_state = landing_state
	if character.is_on_floor() and velocity.y > 0:
			$Timers/JumpBuffer.start()

func on_exit():
	if next_state == landing_state:
		playback.travel(landing_animation)
		next_state = ground_state
