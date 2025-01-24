extends Camera2D

@export var player = CharacterBody2D
@export var camera: camera_state
enum camera_state {FOLLOW, PANNING}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match camera:
		camera_state.FOLLOW:
			camera_follow()
		camera_state.PANNING:
			camera_panning()


func camera_panning():
	anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	position = player.global_position
	var x = floor(position.x / 320) * 320 
	var y = floor(position.y / 180) * 180
	
	position = Vector2(x,y)

func camera_follow():
	anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	position = player.global_position
