extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var anim_idle : StringName = "idle"

func _ready() -> void:
	animation_player.play(anim_idle)
