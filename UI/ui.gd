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
	
func display_heart():
	for heart in player_health.get_children():
		var index = heart.get_index()
		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET
		heart.position = Vector2(x, y)
		
		var last_heart = floor(player_data.life)
		if index > last_heart:
			heart.frame = 0
		if index == last_heart:
			heart.frame = (player_data.life - last_heart) * 4
		if index < last_heart:
			heart.frame = 4
