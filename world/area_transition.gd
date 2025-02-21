@tool
extends Area2D
class_name AreaTransition

enum SIDE {LEFT, RIGHT, TOP, BOTTOM}

@export_file( "*.tscn") var level
@export var target_transition_area : StringName = "AreaTransition"

@export_category("Collision Area Settings")
@export_range(1,12,1, "or_greater") var size : int = 2 :
	set(_v):
		size = _v
		_update_area()
		
"""
anytime value is set on the size, set size our value to _v, call update area
"""

@export var side: SIDE = SIDE.LEFT :
	set(_v):
		side = _v
		_update_area()
		
@export var snap_to_grid : bool = false
	#set(_v):
		#_snap_to_grid()

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	_update_area()
	if Engine.is_editor_hint():
		return
		
	#monitoring = false   # Don't want to monitor until the level is loaded.
	
	body_entered.connect(_player_entered)


func _player_entered(_p : Node2D) -> void:
	# Do something with Level Manager
	pass
	
	
func _update_area() -> void:
	var new_rect : Vector2 = Vector2(64, 64)
	var new_position : Vector2 = Vector2.ZERO
	
	if side == SIDE.TOP:
		new_rect.x *= size
		new_position.y -= 16
	elif side == SIDE.BOTTOM:
		new_rect.x *= size
		new_position.y += 16
	elif side == SIDE.LEFT:
		new_rect.y *= size
		new_position.x -= 16
	elif side == SIDE.RIGHT:
		new_rect.y *= size
		new_position.x += 16
		
	if collision_shape == null:
		collision_shape = get_node("CollisionShape2D")
		
	collision_shape.shape.size = new_rect
	collision_shape.position = new_position
	
#func _snap_to_grid() -> void:
	#position.x = round(position.x / 16) * 16
	#position.y = round(position.x / 16) * 16
	
