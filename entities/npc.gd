extends Character
class_name NPC

#@export var navigation : NavigationAgent2D
#@export var idle_anim : StringName = "idle"
#@export var bt_player : BTPlayer
#
#var blackboard : Blackboard
#var locked_animation = false
#
#func _ready() -> void:
	#blackboard = bt_player.blackboard
	#blackboard.bind_var_to_property(BBNames.health_var, stats, "health")
	#
#func _physics_process(delta: float) -> void:
	#apply_gravity(delta)
	#select_movement_animation()
	#move_and_slide()
#
## Horizontal walk / move action
#func move(p_desired_direction : Vector2, speed):
	#var move_direction = Vector2(
		#p_desired_direction.x,
		#0
	#)
	##
	###var move_direction = npc.global_position.direction_to(next_path) for flying enemies
	#var move_velocity = Vector2(
		#move_direction.x * stats.run_speed,
		#velocity.y)
##
	#velocity = move_velocity
	##move_and_slide()
#
#
#
#func select_movement_animation():
	#if locked_animation:
		#return
	#
	#if velocity.is_zero_approx():
		#animation_player.play(idle_anim)
	#else:
		#animation_player.play(idle_anim)
#
#func jump():
	#velocity.y -= stats.jump_velocity
#
## Underscore before means private. probably to that script
#func apply_gravity(p_delta : float):
	#if not is_on_floor():
		#velocity += get_gravity() * p_delta
		#
		#
#func lock_animation():
	#locked_animation = true
	#
	#
#func unlock_animation():
	#locked_animation = false
#
#func check_for_self(node):
	#if node == self:
		#return true
	#else:
		#return false
