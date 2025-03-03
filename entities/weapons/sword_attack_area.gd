extends Area2D
class_name SwordAttackArea2D

@export var damage : int = 10

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(p_body : Node2D):
	if p_body is Enemy:
		#p_body.hit(damage)
		var damage_dealth = p_body.hit(damage)
		print("dealt %s damage to %s" % [damage_dealth, p_body.name])
