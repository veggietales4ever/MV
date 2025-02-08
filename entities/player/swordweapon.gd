extends Weapon
class_name BasicSword

@export var sword_damage := 1


func _on_area_entered(area: Area2D) -> void:
	print("Sword hit:", area.owner)
	if area.owner is Enemy:
		var enemy = area.owner as Enemy
		print("Dealing", sword_damage, "damage to:", enemy.name)
		enemy.damage(sword_damage)
