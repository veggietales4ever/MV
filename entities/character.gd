extends CharacterBody2D
class_name Character

@export var animation_player : AnimationPlayer
@export var sprite_2d : Sprite2D
@export var stats : CharacterStats

func hit(p_damage : int):
	stats.health -= p_damage
	
