extends Area2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

var movement : PlayerInput

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("idle")
	body_entered.connect(_on_body_entered)

func _on_body_entered(player : Character) -> void:
	if player:
		player_stop()
		anim_player.play("touch")
		await anim_player.animation_finished
		SaveManager.save_game()
		queue_free()
		get_tree().create_timer(2.0).timeout
		print("Game Saved")
		player_start()

func player_stop() -> void:
	PlayerManager.player.can_move = false
	PlayerManager.player.input_handler.can_move = false
	PlayerManager.player.input_handler.reset_input_states()
	
func player_start() -> void:
	PlayerManager.player.can_move = true
	PlayerManager.player.input_handler.can_move = true
	#PlayerManager.player.input_handler.reset_input_states()
