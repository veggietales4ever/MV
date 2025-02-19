extends State
class_name AttackState

@export var ground_state : State
@export var sword_attack_animation_name : String = ""

#func state_process(delta):
	#if character.is_on_floor() && attacking:
		#next_state = ground_state
#
#func on_exit():
	#if next_state == ground_state:
		#next_state = ground_state


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == sword_attack_animation_name:
		attacking = false
		next_state = ground_state
