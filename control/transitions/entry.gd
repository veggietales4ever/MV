extends Node2D

var can_move : bool = false

func _on_exit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var player = body as CharacterBody2D
		
	await get_tree().create_timer(3.0).timeout
	print("scene transition")
