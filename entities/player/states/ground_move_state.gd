extends GroundState

@export var idle_anim : StringName = "idle"
@export var move_anim : StringName = "move"

func _enter() -> void:
	super()
	blackboard.set_var(BBNames.jumps_made_var, 0)


func _update(delta: float) -> void:
	super(delta)
	
	if Vector2.ZERO.is_equal_approx(character.velocity): #as long as currency velocity is not approximately 0. switch state to move state
		character.animation_player.play(idle_anim)
	else:
		character.animation_player.play(move_anim)
	
		
	if blackboard.get_var(BBNames.attack_var):
		dispatch("attack")
