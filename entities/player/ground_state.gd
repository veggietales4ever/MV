extends State
class_name GroundState

@export var jump_strength := -275

@export_group('state')
@export var air_state : State
@export var attack_state : State
@export var crouch_state : State

@export_group('animation')
@export var jump_animation : String = ""
@export var attack_animation : String = ""
@export var crouch_animation : String = ""


func state_process(delta):
	if not character.is_on_floor():
		next_state = air_state
		
func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()
	if event.is_action_pressed("attack"):
		attack()
	if event.is_action_pressed("down") and character.is_on_floor():
		crouch()
		
func jump():
	character.velocity.y = jump_strength
	next_state = air_state
	playback.travel(jump_animation)

func attack():
	next_state = attack_state
	attacking = true
	playback.travel(attack_animation)
	
func crouch():
	next_state = crouch_state
	crouching = true
	playback.travel(crouch_animation)
