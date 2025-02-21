extends AirState

@export var rising_animation : StringName = "rising"
@export var falling_animation : StringName = "falling"
@export var jump_animation : StringName = "jump"

	
func _update(delta: float) -> void:
	super(delta) # Runs air move
	select_animation()
	
	
		
	if blackboard.get_var(BBNames.attack_var):
		dispatch("attack")
		
func select_animation():
	if animation_lock:
		return
		
	if character.velocity.y <= 0.0:
		character.animation_player.play(rising_animation)
	else:
		character.animation_player.play(falling_animation)
		
