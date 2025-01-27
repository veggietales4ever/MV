extends StaticBody2D





func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "Sword":
		$AnimationPlayer.play("destroyed")
		await $AnimationPlayer.animation_finished
		queue_free()
