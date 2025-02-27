extends CharacterBody2D
class_name Character

@export var animation_player : AnimationPlayer
@export var sprite_2d : Sprite2D
@export var stats : CharacterStats :
	set(value):
		stats = value.duplicate() # for each active character, it's gonna have it's own stats. they're not going to share resource directly or else they all die at same time


func hit(p_damage : int):
	stats.health -= p_damage
