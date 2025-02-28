extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Active")


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$AnimationPlayer.play("Destroyed")
		$AudioStreamPlayer.play()
		await $AnimationPlayer.animation_finished
		queue_free()
