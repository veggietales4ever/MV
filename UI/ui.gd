extends CanvasLayer

const HEART_ROW_SIZE = 8
const HEART_OFFSET = 16

@onready var player_health: Sprite2D = $PlayerHealth

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#for i in player_data.life:
		#var new_heart = Sprite2D.new()
		#new_heart.texture = player_health.texture
		#new_heart.hframes = player_health.hframes
		#player_health.add_child(new_heart)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	#display_heart()
	
