extends Node

var fade_duration = 0.5 # Set fade duration to 2.5 seconds
var fade_speed = 1.5# / fade_duration
var right_distance = 45
var left_distance = 45
var walk_duration = 2.5
var state = "idle"
#var can_move := false


#@export var exit_right: PackedScene
#@export var exit_left: PackedScene
#@export var exit_up: PackedScene
#@export var exit_down: PackedScene
@export var level: Node2D

@onready var player: Player = $"../Entities/Player"
@onready var fade_rect: ColorRect = $FadeRect
@onready var test_world: Node2D = $".."



func _ready() -> void:
	if fade_rect:
		fade_rect.visible = true
		fade_rect.modulate = Color(0, 0, 0, 0)
	else:
		push_error("FadeRect node is not found!")

		
		
func _process(delta: float) -> void:
	if state == "fade_left" and fade_rect:
		player.cant_move()
		fade_out()
		transition_left()
	if state == "fade_right" and fade_rect:
		player.cant_move()
		fade_out()
		transition_right()
		#fade_rect.color.a = min(1, fade_rect.color.a + fade_speed * delta)
		
	
	#if state == "fade_left" or "fade_right" or "fade_up" or "fade_down" and fade_rect:
		##fade_rect.color.a = min(1, fade_rect.color.a + fade_speed * delta)
		#player.cant_move()
		#fade_in()
	
		
		
func fade_in():
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0, fade_duration)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(on_fade_in_finished)
	
	
func fade_out():
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1, fade_duration)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(on_fade_out_finished)
	

func on_fade_in_finished():
	player.can_now_move()
	state = "idle"
	
func on_fade_out_finished():
	state = "idle"
	
	
# Scene Entry
# Entry - LEFT
func entry_left():
	if state == "fade":
		var tween = create_tween()
		tween.tween_property(player, "position:x", player.position.x + right_distance, walk_duration)
		tween.set_ease(Tween.EASE_OUT)
		
		tween.finished.connect(on_entry_finished_left)
	
func on_entry_finished_left():
	player.can_move = true
	state = "idle"


# Entry - RIGHT
func entry_right():
	pass
	
func on_entry_finished_right():
	pass
	
	
	
	
	
	
	
# Scene Exit
	
# Exit LEFT
func transition_left():
	var tween = create_tween()
	tween.tween_property(player, "position:x", player.position.x + left_distance, walk_duration)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.finished.connect(level.on_transition_finished_left)
	
func _on_left_area_body_entered(body: Node2D) -> void:
	if player:
		state = "fade_left"
		print(state)
	
	
# Exit RIGHT
func transition_right():
	var tween = create_tween()
	tween.tween_property(player, "position:x", player.position.x + right_distance, walk_duration)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.finished.connect(level.on_transition_finished_right)
	
		
func _on_right_area_body_entered(body: Node2D) -> void:
	if player:
		state = "fade_right"
		print(state)
		
		





#
## Transitions
## Left
#func on_transition_finished_left():
	#get_tree().change_scene_to_packed(exit_left)
	#
## Right
#func on_transition_finished_right():
	#get_tree().change_scene_to_packed(exit_right)
