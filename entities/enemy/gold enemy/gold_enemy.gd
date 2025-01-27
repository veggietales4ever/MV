extends CharacterBody2D
class_name Enemy

signal enemy_damaged()

@export var Health : Int = 3

@export var player: PackedScene

func _ready() -> void:
	$AnimationPlayer.play("walk")
