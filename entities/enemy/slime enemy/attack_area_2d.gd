extends Area2D
class_name AttackArea2D


@export var damage : int = 10


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	

func _on_body_entered(p_body : Node2D):
	if p_body is Character:
		var damage_dealt = p_body.hit(damage)
		print("dealt %s damage to %s" % [damage_dealt, p_body.name])
