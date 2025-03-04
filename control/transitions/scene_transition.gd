extends CanvasLayer

@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer
@onready var pause_ui: Control = PauseMenu.get_node("Control")


func fade_out() -> bool:
	if PauseMenu.visible:
		pause_ui.modulate.a = 1.0
		PauseMenu.visible = true
		
	animation_player.play("fade_out")
	PlayerManager.player.can_move = false
	await animation_player.animation_finished
	
	PauseMenu.visible = false
	return true
	
	
func fade_in() -> bool:
	#PauseMenu.visible = true
	#pause_ui.modulate.a = 0.0
	
	animation_player.play("fade_in")
	await animation_player.animation_finished
	PlayerManager.player.can_move = true
	
	return true
