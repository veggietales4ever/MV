extends State
class_name IdleState



	
func handle_input(_delta):
	if Input.is_action_just_pressed("jump") and PlayerManager.player.is_on_floor():
		PlayerManager.player.change_state("JumpState")
		
	elif Input.get_axis("left", "right") != 0:
		PlayerManager.player.change_state("RunState")
