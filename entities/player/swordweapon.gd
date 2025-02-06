extends Area2D

var sword_damage := 2



func _on_area_entered(area: Area2D) -> void:
	if area.owner is Enemy:
		var enemy = area.owner as Enemy
		enemy.take_damage(sword_damage)
