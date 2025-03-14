extends Node2D
class_name Facing

#@export var character : CharacterBody2D
@export var limbo_hsm : LimboHSM
@export var bt_player : BTPlayer

var blackboard : Blackboard

func _ready():
	if limbo_hsm != null:
		blackboard = limbo_hsm.blackboard
	if bt_player != null:
		blackboard = bt_player.blackboard

#Updates the nodes scale to face left (-1 scale.x) or right (+1 scale.x)
func _physics_process(_delta: float) -> void:
	var current_input_direction : Vector2 = blackboard.get_var(BBNames.direction_var)
	
	if current_input_direction.x > 0:
		scale.x = 1.0
	elif current_input_direction.x < 0:
		scale.x = -1.0
