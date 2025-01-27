extends CharacterBody2D
class_name Enemy

signal enemy_damaged()

@export var Health : int = 3
@export var player: PackedScene

var invulnerable : bool = false
var direction = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox: Area2D = $hitbox
#@onready var state_matchine: EnemyStateMachine = $EnemyStateMachine

func _ready() -> void:
	pass
	#$AnimationPlayer.play("walk")
	
func _physics_process(_delta: float) -> void:
	move_and_slide()
	
	
func update_animation(state : String) -> void:
	animation_player.play(state)
