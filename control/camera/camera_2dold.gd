extends Camera2D


#@export var player = CharacterBody2D
@export var camera: camera_state
#var camera_change : CameraChange

enum camera_state {FOLLOW, PANNING}

var player = PlayerManager.player
var shake_intensity := 0.0
var shake_decay := 4
var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_current()
	
	#var camera_change_area = get_tree().get_nodes_in_group("camera_change_area")
	#if camera_change_area.size() > 0:
		#camera_change = camera_change_area[0] as CameraChange
		#camera_change.cameraswitch.connect(_on_camera_switch)


#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().process_frame
	match camera:
		camera_state.FOLLOW:
			camera_follow()
		camera_state.PANNING:
			camera_panning()

			
	if shake_intensity > 0:
		offset = Vector2(rng.randf_range(-shake_intensity, shake_intensity), rng.randf_range(-shake_intensity, shake_intensity))
		shake_intensity = max(0, shake_intensity - (shake_decay * delta)) # Gradually reduce shake


func camera_panning():
	anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	position = PlayerManager.player.position
	var x = floor(position.x / 400) * 400 
	var y = floor(position.y / 270) * 270
	
	position = Vector2(x,y)
	
	var tween := create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", Vector2(x,y), 0.14)

func camera_follow():
	anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	position = PlayerManager.player.position
	
func apply_screen_shake(intensity: float):
	shake_intensity = intensity

#func _on_camera_switch():
	#if camera == camera_state.FOLLOW:
		#camera = camera_state.PANNING
		#print(camera)
	#elif camera == camera_state.PANNING:
		#camera = camera_state.FOLLOW
		#print(camera)
		
