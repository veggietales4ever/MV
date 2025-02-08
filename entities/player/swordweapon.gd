extends Area2D

var sword_damage := 1



func _on_area_entered(area: Area2D) -> void:
	if area.owner is Enemy:
		var enemy = area.owner as Enemy
		enemy.damage(sword_damage)

func damage():
	Enemy.Health -= sword_damage
	
