extends PlayerState


func enter_state(player_node):
	super(player_node)
	player.velocity.x = 0
	
func handle_input(_delta):
	if Input.is_action_just_pressed("down") and PlayerManager.player.is_on_floor():
		PlayerManager.player.change_state("CrouchingState")
		
	elif Input.get_axis("left", "right") != 0:
		PlayerManager.player.change_state("RunState")
