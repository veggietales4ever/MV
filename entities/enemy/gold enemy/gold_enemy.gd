extends CharacterBody2D

signal enemy_damaged()

@export var Health = 3

@export var player: PackedScene

func _ready() -> void:
	$AnimationPlayer.play("walk")
