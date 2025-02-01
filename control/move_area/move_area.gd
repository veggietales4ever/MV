extends Area2D

@export var activation_delay: float = 1.5
var can_move := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_deferred("monitoring", false)
	await get_tree().create_timer(activation_delay).timeout
	monitoring = true
