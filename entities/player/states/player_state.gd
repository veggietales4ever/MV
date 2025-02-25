extends LimboState
class_name PlayerState

@export var animation_name : StringName
@export var acceleration := 1200
@export var friction := 2000
@export var speed := 110

var character : Character
var character_stats : CharacterStats
var animation_lock : bool = false
var can_jump : bool = true
var direction := Vector2.ZERO

	
	
func _enter() -> void:
	character = agent as Character
	agent.animation_player.play(animation_name)
	character_stats = character.stats

#func apply_gravity(delta):
	#character.velocity.y += character.gravity * delta
	#character.velocity.y = character.velocity.y / 2 if character.faster_fall and character.velocity.y < 0 else character.velocity.y
	#character.velocity.y = character.velocity.y * character.gravity_multiplier
	#character.velocity.y = min(character.velocity.y, character.terminal_velocity)
	#

func lock_animation():
	animation_lock = true
	
func unlock_animation():
	animation_lock = false
	
func _apply_gravity(p_delta : float):
	if not character.is_on_floor():
		character.velocity += character.get_gravity() * p_delta
