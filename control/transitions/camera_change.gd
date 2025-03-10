extends Area2D
class_name CameraChange

signal cameraswitch

func _ready() -> void:
	add_to_group("camera_change_area")
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if body is CharacterBody2D:
		cameraswitch.emit()
