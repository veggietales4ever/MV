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


func _ready() -> void:
	fade_rect.modulate.a = 1  # Ensure the screen is black before the fade-in
	TransitionManager.fade_in()  # Start fading out when entering a new scene
	
	if Global.previous_scene == "test_world2":
		if Global.last_exit == "left":
			PlayerManager.player.position = Vector2(950, PlayerManager.player.position.y)
		else:
			PlayerManager.player.position = Vector2(100, PlayerManager.player.position.y)
	print("Previous Scene:", Global.previous_scene, "Last exit:", Global.last_exit)
		#TransitionManager.entry_right()
	print(state)


func _process(_delta: float) -> void:
	if state == "fade_right" and fade_rect:
		on_transition_finished_right()
		
	

# Transitions
# Left
func on_transition_finished_left():
<<<<<<< HEAD:world/world_1/forest_area/test_world.gd
	if exit_left:
		await TransitionManager.on_fade_out_finished
		Global.previous_scene = "test_world2"
		TransitionManager.change_scene(exit_left)
	else:
		push_error("Error: exit_left is null")
	
# Right
func on_transition_finished_right():
	if exit_right:
		await TransitionManager.fade_out()
		Global.previous_scene = "test_world"
		Global.last_exit = "right"
		TransitionManager.change_scene(exit_right)
	else:
		push_error("Error: exit_right is null")
	
	#if exit_right:
		#await TransitionManager.on_fade_out_finished
		#Global.previous_scene = "test_world"
		#TransitionManager.change_scene(exit_right)
	#else:
		#push_error("Error: exit_right is null")

# Entry Transitions
func on_entry_transition_finished_right():
	await TransitionManager.on_fade_out_finished
	Global.previous_scene = "test_world2"
	TransitionManager.change_scene(entry_right)
=======
	get_tree().change_scene_to_packed(exit_left)
	
# Right
func on_transition_finished_right():
	await TransitionManager.on_fade_out_finished
	Global.previous_scene = "test_world"
	TransitionManager.change_scene(exit_right)
>>>>>>> parent of afc2cf6 (errors on errors. trying to fix change scene (transitions global)):world/world 1/forest area/test_world.gd
