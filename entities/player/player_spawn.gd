extends Node2D

func _ready() -> void:
	visible = false
	if PlayerManager.player_spawned == false:
		PlayerManager.set_player_position(global_position) #global position of this node
		PlayerManager.player_spawned = true
	
