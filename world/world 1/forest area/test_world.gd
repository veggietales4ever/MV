extends Node2D

#const SaveManager = preload("res://addons/MetroidvaniaSystem/Template/Scripts/SaveManager.gd")
#const SAVE_PATH = "user://example_save_data.sav"

#@onready var player: Player = $Entities/Player
#@onready var transitions: Node = $Transitions
#@onready var fade_rect: ColorRect = $Transitions/FadeRect

#const EXIT_RIGHT = preload("res://world/world 1/forest area/test_world2.tscn")
#const EXIT_LEFT = null


func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.set_as_parent(self)
	LevelManager.level_load_started.connect(_free_level)
	
	#fade_rect.modulate.a = 1  # Ensure the screen is black before the fade-in
	#TransitionManager.fade_in()  # Start fading out when entering a new scene
	#
	#if Global.previous_scene == "test_world2" and Global.last_exit == "left":
		#PlayerManager.player.position = Vector2(1378, 133)
		#TransitionManager.entry_right()
		#
	#print(state)

func _free_level() -> void:
	PlayerManager.unparent_player(self)
	queue_free()

#func _process(_delta: float) -> void:
	#if state == "fade_right": #and fade_rect:
		#on_transition_finished_right()
	#if state == "fade_left": #and fade_rect:
		#on_transition_finished_left()
	

## Transitions
## Left
#func on_transition_finished_left():
	#if EXIT_LEFT:
		#await TransitionManager.fade_out()
		#Global.previous_scene = "test_world"
		#Global.last_exit = "left"
		##TransitionManager.change_scene(EXIT_LEFT)
	#else:
		#push_error("Exit left is null")
	#
## Right
#func on_transition_finished_right():
	#if EXIT_RIGHT:
		#await TransitionManager.fade_out()
		#Global.previous_scene = "test_world"
		#Global.last_exit = "right"
		#TransitionManager.change_scene("res://world/world 1/forest area/test_world2.tscn")
	#else:
		#push_error("Exit right is null")
