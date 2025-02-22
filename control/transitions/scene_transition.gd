extends CanvasLayer

@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer


func fade_out() -> bool:
	animation_player.play("fade_out")
	PlayerManager.player.can_move = false
	await animation_player.animation_finished
	return true
	
	
func fade_in() -> bool:
	animation_player.play("fade_in")
	await animation_player.animation_finished
	PlayerManager.player.can_move = true
	return true
