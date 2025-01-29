extends Node2D

const SaveManager = preload("res://addons/MetroidvaniaSystem/Template/Scripts/SaveManager.gd")
const SAVE_PATH = "user://example_save_data.sav"

@onready var player: Player = $Entities/Player
@onready var transitions: Node = $Transitions
@onready var fade_rect: ColorRect = $Transitions/FadeRect

@export_group("Exits")
@export var exit_left: PackedScene
@export var exit_right: PackedScene
@export var exit_up: PackedScene
@export var exit_down: PackedScene

var state = "idle"
var can_move = true

func _ready() -> void:
	fade_rect.modulate.a = 1  # Ensure the screen is black before the fade-in
	transitions.fade_in()  # Start fading out when entering a new scene
	print(Global.previous_scene)
	if Global.previous_scene == "test_world":
		# Move player to the appropriate side of the screen
		player.position = Vector2(10, 129) # Example: Enter from left
	else:
		# Default spawn position
		player.position = Vector2(500, player.position.y)  # Example: Default position

func _process(delta: float) -> void:
	pass
	#if state == "fade_right" and fade_rect:
		#transitions.fade_in()

		
# Transitions
# Left
func on_transition_finished_left():
	get_tree().change_scene_to_packed(exit_left)
	
# Right
func on_transition_finished_right():
	get_tree().change_scene_to_packed(exit_right)
