extends Node2D

#@onready var player: Player = $Entities/Player
@onready var fade_rect: ColorRect = $Fade/FadeRect

@export var player: CharacterBody2D
#@export var starting_map: PackedScene

var state = "fade"
var right_distance = 45
var left_distance = -45
var duration = 0.5
var fade_duration = 0.5 # Set fade duration to 2.5 seconds
var fade_speed = 0.5# / fade_duration


func _ready() -> void:
	print(state)
		# Initialize fade_rect as transparent
	if state == "fade" and fade_rect:
		fade_rect.visible = true
		fade_rect.color = Color(0, 0, 0, 1)
		fade_out()
		entry_left()
	else:
		push_error("FadeRect node is not found!")

func _process(delta: float) -> void:
	if not player:
		print("Player reference is null!")
		return
	#if state == "fade" and fade_rect:
		#fade_rect.color.a = min(1, fade_rect.color.a + fade_speed * delta)
		#entry_left()
		
		#if fade_rect.color.a == 1:
			#on_transition_finished()

func fade_out():
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0, fade_duration)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(on_entry_finished_left)

func _on_transition_area_body_entered(body: Node2D) -> void:
	if player:
		state = "fade_left"
		print(state)
		
# Scene Entry
func entry_left():
	if state == "fade":
		var tween = create_tween()
		tween.tween_property(player, "position:x", player.position.x + right_distance, duration)
		tween.set_ease(Tween.EASE_OUT)
		
		tween.finished.connect(on_entry_finished_left)



# Scene Exits
func transition_right():
	var tween = create_tween()
	tween.tween_property(player, "position:x", player.position.x + right_distance, duration)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.finished.connect(on_transition_finished_right)
	
func transition_left():
	var tween = create_tween()
	tween.tween_property(player, "position:x", player.position.x + left_distance, duration)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.finished.connect(on_transition_finished_left)
	
	

# Scene Transitions
func on_transition_finished_left():
	get_tree().change_scene_to_file("res://world/world 1/forest area/test_world.tscn")
	
func on_transition_finished_right():
	get_tree().change_scene_to_file("res://world/world 1/forest area/test_world.tscn")
	
func on_entry_finished_left():
	player.can_move = true
	state = "idle"
	print(state)
