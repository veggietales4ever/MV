extends PlayerState


func enter_state(player_node):
	super(player_node)
	player.velocity.y = player.JUMP_STRENGTH
	
func handle_input(_delta):
	if PlayerManager.player.is_on_floor():
		PlayerManager.player.change_state("IdleState")
