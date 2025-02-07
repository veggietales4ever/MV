extends EnemyState
class_name EnemyStateChase


@export var chase_speed: float = 50.0  # Speed when chasing the player
@export var chase_duration: float = 2.0  # Duration of chase before returning to idle
@export var next_state: EnemyState  # Define the next state after chasing

var _timer : float = 0.0

func enter() -> void:
	enemy.update_animation("walk")  # Change to appropriate animation
	_timer = chase_duration

func exit() -> void:
	enemy.velocity = Vector2.ZERO  # Stop movement

func process(delta: float) -> EnemyState:
	_timer -= delta
	if _timer <= 0:
		return next_state
	return null

func physics(delta: float) -> EnemyState:
	if enemy.player:
		var direction = (enemy.player.global_position - enemy.global_position).normalized()
		enemy.velocity = direction * chase_speed
	return null
