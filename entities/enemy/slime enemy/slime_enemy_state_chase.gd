extends EnemyState
class_name EnemyStateChase

@export var anim_name : String = "wander"

@export var chase_speed: float = 50.0  # Speed when chasing the player
@export var chase_duration: float = 10.0  # Duration of chase before returning to idle
@export var next_state: EnemyState  # Define the next state after chasing

var _timer : float = 0.0

func enter() -> void:
	enemy.update_animation("wander")  # Change to appropriate animation
	_timer = chase_duration


func exit() -> void:
	enemy.velocity = Vector2.ZERO  # Stop movement


func process(delta: float) -> EnemyState:
	_timer -= delta
	if _timer <= 0:
		return next_state
	return null

func physics(_delta: float) -> EnemyState:
	if enemy.player:
		var direction = (enemy.player.global_position - enemy.global_position).normalized()
		
		enemy.velocity.x = direction.x * chase_speed
		enemy.velocity.y = enemy.velocity.y # preserve gravity
		
		#flip sprite
		if direction.x < 0:
			enemy.sprite_2d.scale.x = 0.3
		elif direction.x > 0:
			enemy.sprite_2d.scale.x = -0.3

	return null
