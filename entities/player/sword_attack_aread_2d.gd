extends Area2D
class_name SwordAttackArea2D


@export var character : Character

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	

func _on_body_entered(p_body : Node2D):
	if p_body is Character:
		p_body.hit()
