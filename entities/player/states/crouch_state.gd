extends PlayerState

@export var crouch_anim : StringName ="crouching"
@export var player_actions : PlayerActions


func _update(_delta: float) -> void:
	if character.is_on_floor():
		if blackboard.get_var(BBNames.crouch_var): #&& crouch:
			crouch()
		else:
			dispatch("to_stand")
			
func crouch():
	character.animation_player.play(crouch_anim)
