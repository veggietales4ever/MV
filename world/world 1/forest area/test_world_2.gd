extends Node2D

@onready var player: Player = $Entities/Player
@onready var fade_rect: ColorRect = $Fade/FadeRect


#@export var starting_map: PackedScene

var state = "idle"
var right_distance = 85
var left_distance = -85
var duration = 2.5
var fade_duration = 1.5 # Set fade duration to 2.5 seconds
var fade_speed = 1.5# / fade_duration


func _ready() -> void:
	print(state)
		# Initialize fade_rect as transparent
	if fade_rect:
		fade_rect.visible = true
		fade_rect.color = Color(0, 0, 0, 255)
	else:
		push_error("FadeRect node is not found!")

func _process(delta: float) -> void:
	pass
	if state == "fade" and fade_rect:
		fade_rect.color.a = min(0, fade_rect.color.a + fade_speed * delta)
		player.can_move = false
		entry_left()
		#if fade_rect.color.a == 1:
			#on_transition_finished()


func _on_transition_area_body_entered(body: Node2D) -> void:
	if player:
		state = "fade_left"
		print(state)
		
# Scene Entry
func entry_left():
	var tween = create_tween()
	tween.tween_property(player, "position:x", player.position.x + right_distance, duration)
	tween.set_ease(Tween.EASE_OUT)



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
