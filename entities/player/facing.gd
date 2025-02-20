extends Node2D
class_name Facing

@export var character : CharacterBody2D

#Updates the nodes scale to face left (-1 scale.x) or right (+1 scale.x)
func _physics_process(_delta: float) -> void:
	if character.velocity.x > 0:
		scale.x = 1.0
	elif character.velocity.x < 0:
		scale.x = -1.0
