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
	if PlayerManager.player.entry_state == "fade_left":
		sprite_2d.flip_h = true
	elif PlayerManager.player.entry_state == "fade_right":
		sprite_2d.flip_h = false
	elif direction.x:
		sprite_2d.flip_h = direction.x < 0
		
		
	PlayerManager.player.entry_state = ""
	
	# State
	var state = 'idle'
	
	#Prioritize attacking but avoid ground attack after landing
	if attacking:
		state = 'attack'
		if not on_floor:
			state = 'jump_attack'
		elif on_floor and animation_player.current_animation != 'jump_attack':
			state = 'attack'
	elif crouching:
		state = 'crouching'
	#elif not on_floor:
	elif velocity.y < 0:
		state = 'jump'
	elif velocity.y >= 0 and not on_floor:
		state = 'idle'
	elif on_floor and direction.x:
		state = 'run'

	animation_player.play(state)
	
func _on_animation_finished(anim_name):
	if anim_name == 'attack' or anim_name == 'jump_attack':
		emit_signal("attack_finished")
		animation_player.play('idle')
