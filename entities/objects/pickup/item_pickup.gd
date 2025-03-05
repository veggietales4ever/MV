@tool
extends CharacterBody2D
class_name ItemPickup

const GRAVITY = 300  # Adjust based on your game
const BOUNCE_FACTOR = 0.9  # Controls how much items bounce when they hit the floor
const FRICTION = 0.9  # Controls how much the horizontal movement slows down

@export var item_data : ItemData : set = _set_item_data

@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	area_2d.body_entered.connect(_on_body_entered)
	

func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += GRAVITY * delta
	
	# Move and check for collisions
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var normal = collision_info.get_normal()
		
		# Check if we hit the floor
		if normal.y < 0:  
			velocity.y = -velocity.y * BOUNCE_FACTOR  # Make it bounce
			velocity.x *= FRICTION  # Apply friction when landing
			if abs(velocity.y) < 10:  # Stop bouncing if below threshold
				velocity.y = 0
		else:
			velocity = velocity.bounce(normal)
		
	# Apply friction over time
	velocity -= velocity * delta * 4
		
"""
collision_info.get_normal gives you the direction of the collision
bounce is going to set the velocity opposite of that
"""



func _on_body_entered(b) -> void:
	if b is Player:
		if item_data:
			if PlayerManager.INVENTORY_DATA.add_item(item_data) == true:
				item_picked_up()


func item_picked_up() -> void:
	area_2d.body_entered.disconnect(_on_body_entered)
	audio_stream_player_2d.play()
	visible = false
	await audio_stream_player_2d.finished
	queue_free()


func _set_item_data(value : ItemData) -> void:
	item_data = value
	_update_texture()


func _update_texture() -> void:
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture

	
	
