extends Area2D

#var can_move : bool

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	#body_exited.connect(_on_body_exited)
	
# When any node enters, this event triggers. check if character
func _on_body_entered(p_body : Node2D):
	if p_body is Character:
		PlayerManager.player.can_move = true
		PlayerManager.player.input_handler.can_move = true
		print(p_body)
		
