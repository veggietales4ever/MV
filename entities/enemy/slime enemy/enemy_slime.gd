extends NPC
class_name SlimeEnemy

func _physics_process(delta: float) -> void:
	#move(1, 50)
	move_and_slide()
#
#func move(dir, speed):
	#velocity = dir * speed
