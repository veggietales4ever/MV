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
	MetSys.room_changed.connect(goto_map, CONNECT_DEFERRED)
	print(state)


func _process(delta: float) -> void:
	if state == "fade_right" and fade_rect:
		on_transition_finished_right()
		
func goto_map(target_map: String):
	pass
	

# Transitions
# Left
func on_transition_finished_left():
	get_tree().change_scene_to_packed(exit_left)
	
# Right
func on_transition_finished_right():
	await transitions.on_fade_out_finished
	Global.previous_scene = "test_world"
	TransitionManager.change_scene(exit_right)
