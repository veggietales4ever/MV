#player_graphics.gd
extends Node2D

signal attack_finished

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready():
	# Connect the signal (if not already connected via the editor)
	animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))

func update_sprite(direction, velocity, on_floor, crouching, attacking):
	# Flip
	if direction.x:
		sprite_2d.flip_h = direction.x < 0
		

	
	# State
	var state = 'idle'
	
	#Prioritize attacking but avoid ground attack after landing
	if attacking:
		state = 'attack'
		if not on_floor:
			state = 'jump_attack'
		elif on_floor and animation_player.current_animation != 'jump_attack':
			state = 'attack'
		if on_floor and crouching:
			state = 'crouchingsword'
	elif crouching:
		state = 'crouching'
	#elif not on_floor:
	elif velocity.y < 0:
		state = 'jump'
	elif velocity.y >= 0 and not on_floor:
		state = 'idle'
	elif on_floor and direction.x:
		state = 'run'
		
	# Change animation if different from current
	#if animation_player.current_animation != state:
	animation_player.play(state)
		
		
	
func _on_animation_finished(anim_name):
	if anim_name == 'attack' or anim_name == 'jump_attack' or anim_name == 'crouchingsword':
		emit_signal("attack_finished")
		animation_player.play('idle')
		
func damage_animation():
	animation_player.play('hurt')
	
	PlayerManager.player.cant_move()
	#var tween = create_tween()
	#tween.tween_property(player, "position:x", player.position.x, 100)
	#tween.set_ease(Tween.EASE_OUT)
