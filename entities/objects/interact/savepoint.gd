extends Area2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("idle")
	body_entered.connect(_on_body_entered)

func _on_body_entered(player : Character) -> void:
	if player:
		anim_player.play("touch")
		await anim_player.animation_finished
		#get_tree().create_timer(2.0).timeout
		SaveManager.save_game()
		print("Game Saved")
