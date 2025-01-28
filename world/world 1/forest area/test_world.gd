extends Node2D

func _ready() -> void:
	MetSys.room_changed.connect(goto_map, CONNECT_DEFERRED)
	
func goto_map(target_map: String):
	pass


func _on_move_area_body_entered(body: Node2D) -> void:
	goto_map("test_world2")
