extends Node

signal level_load_started
signal level_loaded
signal tilemap_bounds_changed(bounds : Array[Vector2])

var current_tilemap_bounds : Array[Vector2]
var target_transition : String
var position_offset : Vector2


func _ready() -> void:
	await get_tree().process_frame
	level_loaded.emit()

func change_tilemap_bounds(bounds : Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	tilemap_bounds_changed.emit(bounds)

func load_new_level(
		level_path : String,
		_target_transition : String,
		_position_offset : Vector2
) -> void:
	
	get_tree().paused = true # pause game
	target_transition = _target_transition
	position_offset = _position_offset
	
	#Level Transition
	await SceneTransition.fade_out()
	
	level_load_started.emit() # emit level load started

	await get_tree().process_frame # makes this asynchronous and stops and wait for whatever we tell it to wait for
	
	get_tree().change_scene_to_file(level_path)
	
	#Level Transition
	
	await get_tree().process_frame
	get_tree().paused = false
	
	await SceneTransition.fade_in()
	await get_tree().create_timer(0.2).timeout
	
	level_loaded.emit()
