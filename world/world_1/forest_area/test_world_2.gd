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
var can_move := false

func _ready() -> void:
	fade_rect.modulate.a = 1  # Ensure the screen is black before the fade-in
	TransitionManager.fade_in()  # Start fading out when entering a new scene
	if Global.previous_scene == "test_world":
		if Global.last_exit == "right":
			PlayerManager.player.position = Vector2(50, PlayerManager.player.position.y)
			TransitionManager.entry_left()
	print("Previous Scene:", Global.previous_scene, "Last exit:", Global.last_exit)
		# Move player to the appropriate side of the screen
		#PlayerManager.player.position = Vector2(10, 129) # Example: Enter from left
	#else:
		## Default spawn position
		#PlayerManager.player.position = Vector2(500, player.position.y)  # Example: Default position

func _process(_delta: float) -> void:
	if state == "fade_left" and fade_rect:
		on_transition_finished_left()

		
# Transitions
# Left
func on_transition_finished_left():
	if exit_left:
		await TransitionManager.fade_out()
		Global.previous_scene = "test_world2"
		Global.last_exit = "left"
		TransitionManager.change_scene(exit_left)
	else:
		push_error("exit left is null!")
	#await transitions.on_fade_out_finished
	#Global.previous_scene = "test_world2"
	#TransitionManager.change_scene(exit_left)
	
# Right
func on_transition_finished_right():
	get_tree().change_scene_to_packed(exit_right)
