extends PlayerState


func handle_input(_delta):
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		PlayerManager.player.velocity.x = direction * PlayerManager.player.speed
	else:
		PlayerManager.player.change_state("IdleState")
	if Input.is_action_just_pressed("jump") and PlayerManager.player.is_on_floor():
		PlayerManager.player.change_state("JumpState") 
