extends Camera2D
class_name camera

@onready var player: Player = $"../Entities/Player"
#@export var player = CharacterBody2D
@export var camera: camera_state
enum camera_state {FOLLOW, PANNING}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	camera_follow()
	#match camera:
		#camera_state.FOLLOW:
			#camera_follow()
		#camera_state.PANNING:
			#camera_panning()


func camera_panning():
	anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	position = player.position
	var x = floor(position.x / 400) * 400 
	var y = floor(position.y / 270) * 270
	
	position = Vector2(x,y)
	
	var tween := create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", Vector2(x,y), 0.14)

func camera_follow():
	anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	position = player.position
