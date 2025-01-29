extends Node

var fade_duration = 0.5 # Set fade duration to 2.5 seconds
var fade_speed = 0.5# / fade_duration
var right_distance = 65
var right_duration = 2.5
var state = "idle"
var can_move := false


@export var exit_right: PackedScene

@onready var player: Player = $"../Entities/Player"
@onready var fade_rect: ColorRect = $FadeRect

func _ready() -> void:
	if fade_rect:
		fade_rect.visible = true
		fade_rect.color = Color(0, 0, 0, 0)
	else:
		push_error("FadeRect node is not found!")
		
		
func _process(delta: float) -> void:
	if state == "fade" and fade_rect:
		fade_rect.color.a = min(1, fade_rect.color.a + fade_speed * delta)
		player.cant_move()
		#fade_out()
		transition_right()
		
		
func fade_out():
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1, fade_duration)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(on_entry_finished_left)
	
func on_entry_finished_left():
	player.can_move = true
	state = "idle"



func transition_right():
	var tween = create_tween()
	tween.tween_property(player, "position:x", player.position.x + right_distance, right_duration)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.finished.connect(on_transition_finished)
	
func on_transition_finished():
	get_tree().change_scene_to_packed(exit_right)


func _on_right_transition_area_body_entered(body: Node2D) -> void:
	if player:
		state = "fade"
		print(state)
