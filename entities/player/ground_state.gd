extends State
class_name GroundState

@export var jump_strength := -275
@export var air_state : State
@export var attack_state : State
@export var jump_animation : String = ""
@export var attack_animation : String = ""


func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()
	if event.is_action_pressed("attack"):
		attack()
		
func jump():
	character.velocity.y = jump_strength
	next_state = air_state
	playback.travel(jump_animation)

func attack():
	next_state = attack_state
	attacking = true
	playback.travel(attack_animation)
