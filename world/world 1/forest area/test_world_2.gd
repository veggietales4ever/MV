extends Node2D

const SaveManager = preload("res://addons/MetroidvaniaSystem/Template/Scripts/SaveManager.gd")
const SAVE_PATH = "user://example_save_data.sav"

@onready var player: Player = $Entities/Player
@onready var transitions: Node = $Transitions
@onready var fade_rect: ColorRect = $Transitions/FadeRect

const EXIT_LEFT = preload("res://world/world 1/forest area/test_worldstart.tscn")
const EXIT_RIGHT = null

var state = "idle"
var can_move := false

func _ready() -> void:
	fade_rect.modulate.a = 1  # Ensure the screen is black before the fade-in
	TransitionManager.fade_in()  # Start fading out when entering a new scene
	
	if Global.previous_scene == "test_world" and Global.last_exit == "right":
		PlayerManager.player.position = Vector2(15, PlayerManager.player.position.y)
		TransitionManager.entry_left()
	#else:
		#PlayerManager.player.position = Vector2(900, PlayerManager.player.position.y)
		

func _process(_delta: float) -> void:
	if state == "fade_left": #and fade_rect:
		on_transition_finished_left()

		
# Transitions
# Left
func on_transition_finished_left():
	if EXIT_LEFT:
		await TransitionManager.fade_out()
		Global.previous_scene = "test_world2"
		Global.last_exit = "left"
		TransitionManager.change_scene("res://world/world 1/forest area/test_world.tscn")
	else:
		push_error("Error: exit_left is null")
	
# Right
func on_transition_finished_right():
	if EXIT_RIGHT:
		await TransitionManager.fade_out()
		Global.previous_scene = "test_world2"
		Global.last_exit = "right"
		#TransitionManager.change_scene(EXIT_RIGHT)
	else:
		push_error("Error: exit_right is null")
