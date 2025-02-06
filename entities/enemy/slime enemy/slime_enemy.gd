extends CharacterBody2D
class_name Enemy

signal direction_changed(new_direction: Vector2)
signal enemy_damaged()

@export var Health : int = 3

var invulnerable : bool = false
var direction = Vector2.ZERO
var player : Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox: Area2D = $hitbox
@onready var state_matchine: EnemyStateMachine = $EnemyStateMachine

func _ready() -> void:
	state_matchine.initialize(self)
	player = PlayerManager.player
	#$AnimationPlayer.play("walk")
	
func _physics_process(_delta: float) -> void:
	move_and_slide()
	
	
func update_animation(state : String) -> void:
	animation_player.play(state)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var player = PlayerManager.player
		if not player.invulnerable:
			player_data.life -= 1
			player.take_damage(global_position)
