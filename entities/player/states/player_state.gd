extends LimboState
class_name PlayerState


@export var animation_name : StringName

var character : CharacterBody2D
var character_stats : CharacterStats

func _enter() -> void:
	character = agent as CharacterBody2D
	agent.animation_player.play(animation_name)
	character_stats = agent.stats

func move(delta) -> Vector2:
	var direction : Vector2 = blackboard.get_var(BBNames.direction_var)
	
	if not is_zero_approx(direction.x): # Checks that input direction is not 0
		character.velocity.x = move_toward(character.velocity.x, direction.x * character_stats.speed, character.acceleration * delta)
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, character_stats.friction * delta)
		
	character.move_and_slide()
	return character.velocity
