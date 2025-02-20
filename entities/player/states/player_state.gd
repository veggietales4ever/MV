extends LimboState
class_name PlayerState


@export var animation_name : StringName

var character : CharacterBody2D
var character_stats : CharacterStats

func _enter() -> void:
	character = agent as CharacterBody2D
	agent.animation_player.play(animation_name)
	character_stats = character.stats

#func _apply_gravity(delta : float):
	#if not character.is_on_floor():
		#character.velocity.y += character.gravity * delta
		#character.velocity.y = character.velocity.y / 2 if character.faster_fall and character.velocity.y < 0 else character.velocity.y
		#character.velocity.y = character.velocity.y * character.gravity_multiplier
		#character.velocity.y = min(character.velocity.y, character.terminal_velocity)
