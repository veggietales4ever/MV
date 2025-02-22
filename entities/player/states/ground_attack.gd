extends GroundState
class_name AttackState


func _enter() -> void:
	super()
	character.animation_player.animation_finished.connect(_on_animation_finished)
	blackboard.set_var(BBNames.attack_var, false)
	
func _exit() -> void:
	character.animation_player.animation_finished.disconnect(_on_animation_finished)
	
func _on_animation_finished(p_animation : StringName):
	if not blackboard.get_var(BBNames.attack_var):
		dispatch("finished")
		return
		
	#if i want to add a second animation after the current one finishes
	#match p_animation:
		#animation_name:
			#character.animation_player.play(attack2)
			#
			#dispatch("finished")
	
