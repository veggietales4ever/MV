extends Node2D

const SaveManager = preload("res://addons/MetroidvaniaSystem/Template/Scripts/SaveManager.gd")
const SAVE_PATH = "user://example_save_data.sav"

@onready var player: Player = $Entities/Player
@onready var fade_rect: ColorRect = $Fade/FadeRect


#@export var starting_map: PackedScene

var state = "idle"
var right_distance = 30
var right_duration = 0.5
var fade_duration = 1.5 # Set fade duration to 2.5 seconds
var fade_speed = 1.0 / fade_duration


func _ready() -> void:
	MetSys.room_changed.connect(goto_map, CONNECT_DEFERRED)
	print(state)
	# Initialize fade_rect as transparent
	if fade_rect:
		fade_rect.visible = true
		fade_rect.color = Color(0, 0, 0, 0)
	else:
		push_error("FadeRect node is not found!")
	
func _process(delta: float) -> void:
	if state == "fade" and fade_rect:
		fade_rect.color.a = min(1, fade_rect.color.a + fade_speed * delta)
		player.can_move = false
		transition_right()
		#transition_animation()
		if fade_rect.color.a == 1:
			on_transition_finished()
		
func goto_map(target_map: String):
	pass

func _on_transition_area_body_entered(body: Node2D) -> void:
	if player:
		state = "fade"
		print(state)

func transition_right():
	var tween = create_tween()
	tween.tween_property(player, "position:x", player.position.x + right_distance, right_duration)
	tween.set_ease(Tween.EASE_OUT)
	
	#tween.finished.connect(on_transition_finished)
	
#func transition_animation():
	#AnimationPlayer.play('run')

func on_transition_finished():
	get_tree().change_scene_to_file("res://world/world 1/forest area/test_world2.tscn")
