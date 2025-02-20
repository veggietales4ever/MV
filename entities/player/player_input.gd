extends Node
class_name PlayerInput

# Handles player input

@export var limbo_hsm : LimboHSM
@export var player_actions : PlayerActions


var blackboard : Blackboard
var input_direction : Vector2

func _ready() -> void:
	blackboard = limbo_hsm.blackboard
	blackboard.bind_var_to_property(BBNames.direction_var, self, "input_direction", true)

func _process(delta: float) -> void:
	input_direction = Input.get_vector(player_actions.left, player_actions.right, player_actions.up, player_actions.down)
	
