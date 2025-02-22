extends Area2D


func _ready() -> void:
	body_entered.connect(_player_entered)
	
func _player_entered(_p : Node2D) -> void:
	pass

func _process(_delta: float) -> void:
	pass
