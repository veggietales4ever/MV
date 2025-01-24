extends Camera2D

@export var player = CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_follow()


func camera_panning():
	position = player.global_position
	#var x = floor(position.x / 576) 
	#var y = floor(position.y / 324)
	
	#position = Vector2(x,y)

func camera_follow():
	anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	position = player.global_position
